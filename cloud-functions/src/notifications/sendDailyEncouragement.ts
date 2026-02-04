import * as admin from "firebase-admin";
import { onRequest } from "firebase-functions/v2/https";
import { ENCOURAGEMENT_MESSAGES } from "./encouragementMessages";

interface FcmTokenDoc {
  token: string;
  platform: string;
}

interface NotificationSettingsDoc {
  dailyEncouragement?: {
    enabled: boolean;
  };
}

// Re-export for tests
export { ENCOURAGEMENT_MESSAGES };

/**
 * 毎日の励まし通知を送信する Cloud Function
 * Cloud Scheduler -> HTTP -> この関数 の流れで実行
 * 毎日 20:00 JST に実行
 */
export const sendDailyEncouragement = onRequest(
  {
    region: "asia-northeast1",
    timeoutSeconds: 300,
    memory: "512MiB",
  },
  async (req, res) => {
    try {
      const result = await sendDailyEncouragementHandler(admin.firestore(), admin.messaging());
      res.status(200).json({
        success: true,
        ...result,
      });
    } catch (error) {
      console.error("sendDailyEncouragement failed:", error);
      res.status(500).json({
        success: false,
        error: error instanceof Error ? error.message : "Unknown error",
      });
    }
  }
);

/**
 * テスト可能なハンドラー関数
 */
export async function sendDailyEncouragementHandler(
  db: admin.firestore.Firestore,
  messaging: admin.messaging.Messaging
): Promise<{ totalSent: number; totalFailed: number }> {
  console.log("Starting daily encouragement notification");

  // 1. 通知設定が有効なユーザーのFCMトークンを取得
  const userTokensMap = await getEnabledUserTokens(db);
  const totalUsers = userTokensMap.size;

  console.log(`Found ${totalUsers} users with daily encouragement enabled`);

  if (totalUsers === 0) {
    console.log("No users to notify");
    return { totalSent: 0, totalFailed: 0 };
  }

  // 2. 全トークンを集約
  const allTokens: string[] = [];
  for (const tokens of userTokensMap.values()) {
    allTokens.push(...tokens);
  }

  console.log(`Total FCM tokens: ${allTokens.length}`);

  if (allTokens.length === 0) {
    console.log("No FCM tokens found");
    return { totalSent: 0, totalFailed: 0 };
  }

  // 3. 励ましメッセージを構築
  const message = buildEncouragementMessage();

  // 4. マルチキャスト送信
  const result = await sendMulticastNotification(messaging, allTokens, message, db);

  console.log(`Notification summary: sent=${result.sent}, failed=${result.failed}`);
  return { totalSent: result.sent, totalFailed: result.failed };
}

/**
 * dailyEncouragement.enabled = true のユーザーのFCMトークンを取得
 */
async function getEnabledUserTokens(db: admin.firestore.Firestore): Promise<Map<string, string[]>> {
  const userTokensMap = new Map<string, string[]>();

  // Collection Group Queryでfcm_tokensを持つユーザーを取得
  const tokensSnapshot = await db.collectionGroup("fcm_tokens").get();

  // ユーザーごとにトークンをグループ化
  const userTokensTemp = new Map<string, string[]>();
  for (const doc of tokensSnapshot.docs) {
    // パスからuserIdを抽出: users/{userId}/fcm_tokens/{tokenId}
    const pathParts = doc.ref.path.split("/");
    const usersIndex = pathParts.indexOf("users");

    if (usersIndex < 0 || usersIndex + 1 >= pathParts.length) {
      continue;
    }

    const userId = pathParts[usersIndex + 1];
    const tokenData = doc.data() as FcmTokenDoc;

    if (!tokenData.token) {
      continue;
    }

    const existing = userTokensTemp.get(userId) || [];
    existing.push(tokenData.token);
    userTokensTemp.set(userId, existing);
  }

  // 各ユーザーの通知設定を確認
  for (const [userId, tokens] of userTokensTemp) {
    const settingsRef = db.doc(`users/${userId}/notification_settings/settings`);
    const settingsSnapshot = await settingsRef.get();

    // デフォルトは有効
    let isEnabled = true;

    if (settingsSnapshot.exists) {
      const settings = settingsSnapshot.data() as NotificationSettingsDoc;
      if (settings.dailyEncouragement?.enabled === false) {
        isEnabled = false;
      }
    }

    if (isEnabled) {
      userTokensMap.set(userId, tokens);
    }
  }

  return userTokensMap;
}

/**
 * ランダムな励ましメッセージを取得
 */
export function getRandomMessage(): string {
  const index = Math.floor(Math.random() * ENCOURAGEMENT_MESSAGES.length);
  return ENCOURAGEMENT_MESSAGES[index];
}

/**
 * 励まし通知メッセージを構築
 */
export function buildEncouragementMessage(): { title: string; body: string } {
  return {
    title: "今日のひとこと",
    body: getRandomMessage(),
  };
}

/**
 * マルチキャスト通知を送信
 */
async function sendMulticastNotification(
  messaging: admin.messaging.Messaging,
  tokens: string[],
  message: { title: string; body: string },
  db: admin.firestore.Firestore
): Promise<{ sent: number; failed: number }> {
  // FCMは1回のリクエストで最大500トークンまで
  const batchSize = 500;
  let totalSent = 0;
  let totalFailed = 0;

  for (let i = 0; i < tokens.length; i += batchSize) {
    const batch = tokens.slice(i, i + batchSize);

    const response = await messaging.sendEachForMulticast({
      tokens: batch,
      notification: {
        title: message.title,
        body: message.body,
      },
      android: {
        priority: "high",
        notification: {
          channelId: "milu_notifications",
        },
      },
      apns: {
        payload: {
          aps: {
            alert: {
              title: message.title,
              body: message.body,
            },
            sound: "default",
          },
        },
      },
    });

    totalSent += response.successCount;
    totalFailed += response.failureCount;

    // 無効なトークンを削除
    await cleanupInvalidTokens(db, batch, response.responses);
  }

  return { sent: totalSent, failed: totalFailed };
}

/**
 * 送信失敗したトークンを削除（無効なトークンの場合）
 */
async function cleanupInvalidTokens(
  db: admin.firestore.Firestore,
  tokens: string[],
  responses: admin.messaging.SendResponse[]
): Promise<void> {
  const invalidTokenErrors = [
    "messaging/invalid-registration-token",
    "messaging/registration-token-not-registered",
  ];

  for (let i = 0; i < responses.length; i++) {
    const response = responses[i];
    if (!response.success && response.error) {
      const errorCode = response.error.code;
      if (invalidTokenErrors.includes(errorCode)) {
        // 無効なトークンを持つドキュメントを検索して削除
        const token = tokens[i];
        const snapshot = await db.collectionGroup("fcm_tokens").where("token", "==", token).get();

        for (const doc of snapshot.docs) {
          await doc.ref.delete();
          console.log("Deleted invalid FCM token");
        }
      }
    }
  }
}

import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

interface RegisterFcmTokenData {
  token: string;
  deviceId: string;
  platform: "ios" | "android";
}

interface RegisterFcmTokenResult {
  success: boolean;
  message: string;
}

export const registerFcmToken = functions
  .region("asia-northeast1")
  .https.onCall(async (data: RegisterFcmTokenData, context): Promise<RegisterFcmTokenResult> => {
    // 1. Authentication check
    if (!context.auth) {
      throw new functions.https.HttpsError("unauthenticated", "認証が必要です");
    }

    const userId = context.auth.uid;
    const token = data.token?.trim();
    const deviceId = data.deviceId?.trim();
    const platform = data.platform;

    // 2. Input validation
    if (!token) {
      throw new functions.https.HttpsError("invalid-argument", "FCMトークンが必要です");
    }

    if (!deviceId) {
      throw new functions.https.HttpsError("invalid-argument", "デバイスIDが必要です");
    }

    if (platform !== "ios" && platform !== "android") {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "プラットフォームはiosまたはandroidである必要があります"
      );
    }

    const db = admin.firestore();
    const now = admin.firestore.FieldValue.serverTimestamp();

    try {
      // Read lifecycle and write tokens in one transaction so withdrawal conflicts and retries safely.
      await db.runTransaction(async (transaction) => {
        const account = await transaction.get(db.doc(`user_authorizations/${userId}`));
        if (account.exists && account.data()?.state !== "active") {
          throw new functions.https.HttpsError(
            "failed-precondition",
            "退会処理中は通知を登録できません"
          );
        }
        const tokenRef = db.doc(`users/${userId}/fcm_tokens/${deviceId}`);
        const settingsRef = db.doc(`users/${userId}/notification_settings/settings`);
        const settings = await transaction.get(settingsRef);
        transaction.set(
          tokenRef,
          { token, platform, createdAt: now, updatedAt: now },
          { merge: true }
        );
        if (!settings.exists) {
          transaction.set(settingsRef, {
            vaccineReminder: { enabled: true, daysBefore: [0, 1] },
            dailyEncouragement: { enabled: true },
            createdAt: now,
            updatedAt: now,
          });
        }
      });

      return {
        success: true,
        message: "FCMトークンを登録しました",
      };
    } catch (error) {
      if (error instanceof functions.https.HttpsError) {
        throw error;
      }
      console.error("FCM token registration failed.");
      throw new functions.https.HttpsError("internal", "FCMトークンの登録中にエラーが発生しました");
    }
  });

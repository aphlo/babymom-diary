import * as admin from "firebase-admin";
import { onRequest } from "firebase-functions/v2/https";

interface ReservationGroupDoc {
  childId: string;
  scheduledDate: admin.firestore.Timestamp;
  status: string;
  members: { vaccineId: string; doseId: string }[];
}

interface FcmTokenDoc {
  token: string;
  platform: string;
}

interface NotificationSettingsDoc {
  vaccineReminder?: {
    enabled: boolean;
    daysBefore: number[];
  };
}

interface HouseholdReservation {
  householdId: string;
  childId: string;
  isToday: boolean;
  isTomorrow: boolean;
}

interface UserTokensWithPreference {
  tokens: string[];
  notifyToday: boolean;
  notifyTomorrow: boolean;
}

/**
 * 予防接種リマインダー通知を送信する Cloud Function
 * Cloud Scheduler -> HTTP -> この関数 の流れで実行
 * 毎日 10:00 JST に実行
 */
export const sendVaccineReminder = onRequest(
  {
    region: "asia-northeast1",
    timeoutSeconds: 300,
    memory: "512MiB",
  },
  async (req, res) => {
    try {
      const result = await sendVaccineReminderHandler(admin.firestore(), admin.messaging());
      res.status(200).json({
        success: true,
        ...result,
      });
    } catch (error) {
      console.error("sendVaccineReminder failed:", error);
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
export async function sendVaccineReminderHandler(
  db: admin.firestore.Firestore,
  messaging: admin.messaging.Messaging
): Promise<{ totalSent: number; totalFailed: number }> {
  // 1. JST基準で当日・翌日の日付を計算
  const { today, tomorrow } = getJSTDates();
  console.log(
    `Checking reservations for today: ${today.toISOString()}, tomorrow: ${tomorrow.toISOString()}`
  );

  // 2. 当日・翌日の予約を持つreservation_groupsを取得
  const reservations = await getUpcomingReservations(db, today, tomorrow);
  console.log(`Found ${reservations.length} upcoming reservations`);

  if (reservations.length === 0) {
    console.log("No upcoming reservations found");
    return { totalSent: 0, totalFailed: 0 };
  }

  // 3. 世帯ごとにグループ化
  const householdReservations = groupByHousehold(reservations);
  console.log(`Grouped into ${householdReservations.size} households`);

  // 4. 各世帯のメンバーに通知送信
  let totalSent = 0;
  let totalFailed = 0;

  for (const [householdId, reservationInfo] of householdReservations) {
    try {
      const result = await sendNotificationToHousehold(db, messaging, householdId, reservationInfo);
      totalSent += result.sent;
      totalFailed += result.failed;
    } catch (error) {
      console.error("Error sending notification to household:", error);
      totalFailed++;
    }
  }

  console.log(`Notification summary: sent=${totalSent}, failed=${totalFailed}`);
  return { totalSent, totalFailed };
}

/**
 * JST基準で当日と翌日の日付を取得（時刻は0:00:00にリセット）
 */
export function getJSTDates(): { today: Date; tomorrow: Date } {
  // JST = UTC + 9時間
  const now = new Date();
  const jstOffset = 9 * 60 * 60 * 1000;
  const jstNow = new Date(now.getTime() + jstOffset);

  // JSTでの日付（年月日のみ）を取得
  const jstYear = jstNow.getUTCFullYear();
  const jstMonth = jstNow.getUTCMonth();
  const jstDay = jstNow.getUTCDate();

  // JSTの0:00:00をUTCに変換
  const today = new Date(Date.UTC(jstYear, jstMonth, jstDay) - jstOffset);
  const tomorrow = new Date(today.getTime() + 24 * 60 * 60 * 1000);

  return { today, tomorrow };
}

/**
 * 当日または翌日の予約をCollection Group Queryで取得
 */
async function getUpcomingReservations(
  db: admin.firestore.Firestore,
  today: Date,
  tomorrow: Date
): Promise<HouseholdReservation[]> {
  const reservations: HouseholdReservation[] = [];

  // todayの開始から tomorrow+1日の開始までの範囲を取得
  const dayAfterTomorrow = new Date(tomorrow.getTime() + 24 * 60 * 60 * 1000);

  // Collection Group Queryで全householdsのreservation_groupsを検索
  const snapshot = await db
    .collectionGroup("reservation_groups")
    .where("status", "==", "scheduled")
    .where("scheduledDate", ">=", admin.firestore.Timestamp.fromDate(today))
    .where("scheduledDate", "<", admin.firestore.Timestamp.fromDate(dayAfterTomorrow))
    .get();

  for (const doc of snapshot.docs) {
    const data = doc.data() as ReservationGroupDoc;

    // パスからhouseholdIdを抽出: households/{householdId}/children/{childId}/reservation_groups/{groupId}
    const pathParts = doc.ref.path.split("/");
    const householdIdIndex = pathParts.indexOf("households") + 1;

    if (householdIdIndex <= 0 || householdIdIndex >= pathParts.length) {
      console.warn("Invalid reservation group path structure");
      continue;
    }

    const householdId = pathParts[householdIdIndex];
    const scheduledDate = data.scheduledDate.toDate();

    // 当日か翌日かを判定
    const isToday = isSameDay(scheduledDate, today);
    const isTomorrow = isSameDay(scheduledDate, tomorrow);

    reservations.push({
      householdId,
      childId: data.childId,
      isToday,
      isTomorrow,
    });
  }

  return reservations;
}

/**
 * 2つの日付が同じ日かどうかを判定（JST基準）
 */
export function isSameDay(date1: Date, date2: Date): boolean {
  // JST = UTC + 9時間
  const jstOffset = 9 * 60 * 60 * 1000;
  const jst1 = new Date(date1.getTime() + jstOffset);
  const jst2 = new Date(date2.getTime() + jstOffset);

  return (
    jst1.getUTCFullYear() === jst2.getUTCFullYear() &&
    jst1.getUTCMonth() === jst2.getUTCMonth() &&
    jst1.getUTCDate() === jst2.getUTCDate()
  );
}

/**
 * 予約を世帯IDでグループ化
 */
export function groupByHousehold(
  reservations: HouseholdReservation[]
): Map<string, { isToday: boolean; isTomorrow: boolean }> {
  const grouped = new Map<string, { isToday: boolean; isTomorrow: boolean }>();

  for (const reservation of reservations) {
    const existing = grouped.get(reservation.householdId);
    if (existing) {
      // 既存のエントリがある場合は、当日・翌日のフラグをマージ
      grouped.set(reservation.householdId, {
        isToday: existing.isToday || reservation.isToday,
        isTomorrow: existing.isTomorrow || reservation.isTomorrow,
      });
    } else {
      grouped.set(reservation.householdId, {
        isToday: reservation.isToday,
        isTomorrow: reservation.isTomorrow,
      });
    }
  }

  return grouped;
}

/**
 * 指定した世帯のメンバーに通知を送信
 */
async function sendNotificationToHousehold(
  db: admin.firestore.Firestore,
  messaging: admin.messaging.Messaging,
  householdId: string,
  reservationInfo: { isToday: boolean; isTomorrow: boolean }
): Promise<{ sent: number; failed: number }> {
  // 1. 世帯のメンバーUID一覧を取得
  const memberUids = await getHouseholdMemberUids(db, householdId);
  if (memberUids.length === 0) {
    return { sent: 0, failed: 0 };
  }

  // 2. 各メンバーのFCMトークンと通知設定を取得
  // ユーザーごとにdaysBefore設定が異なる可能性があるため、個別に処理
  let totalSent = 0;
  let totalFailed = 0;

  for (const uid of memberUids) {
    const userResult = await getUserTokensWithPreference(db, uid, reservationInfo);

    if (userResult.tokens.length === 0) {
      continue;
    }

    // ユーザーの設定に基づいて通知対象日を決定
    const userReservationInfo = {
      isToday: reservationInfo.isToday && userResult.notifyToday,
      isTomorrow: reservationInfo.isTomorrow && userResult.notifyTomorrow,
    };

    // 通知対象日がない場合はスキップ
    if (!userReservationInfo.isToday && !userReservationInfo.isTomorrow) {
      continue;
    }

    // 通知メッセージを構築
    const message = buildNotificationMessage(userReservationInfo);

    // 送信
    const result = await sendMulticastNotification(messaging, userResult.tokens, message, db);
    totalSent += result.sent;
    totalFailed += result.failed;
  }

  return { sent: totalSent, failed: totalFailed };
}

/**
 * 世帯のメンバーUID一覧を取得
 */
async function getHouseholdMemberUids(
  db: admin.firestore.Firestore,
  householdId: string
): Promise<string[]> {
  const membersSnapshot = await db.collection(`households/${householdId}/members`).get();

  return membersSnapshot.docs.map((doc) => doc.id);
}

/**
 * ユーザーのFCMトークンと通知設定を取得
 * daysBefore設定に基づいて通知対象日を判定
 */
async function getUserTokensWithPreference(
  db: admin.firestore.Firestore,
  uid: string,
  reservationInfo: { isToday: boolean; isTomorrow: boolean }
): Promise<UserTokensWithPreference> {
  // 通知設定を確認
  const settingsRef = db.doc(`users/${uid}/notification_settings/settings`);
  const settingsSnapshot = await settingsRef.get();

  // デフォルト値: 当日(0)と前日(1)の両方に通知
  let notifyToday = true;
  let notifyTomorrow = true;

  if (settingsSnapshot.exists) {
    const settings = settingsSnapshot.data() as NotificationSettingsDoc;

    // vaccineReminder.enabled が false の場合はトークンを返さない
    if (settings.vaccineReminder?.enabled === false) {
      return { tokens: [], notifyToday: false, notifyTomorrow: false };
    }

    // daysBefore設定を確認
    const daysBefore = settings.vaccineReminder?.daysBefore;
    if (daysBefore && Array.isArray(daysBefore)) {
      // 0: 当日通知, 1: 前日通知
      notifyToday = daysBefore.includes(0);
      notifyTomorrow = daysBefore.includes(1);
    }
  }

  // 予約と設定の両方に該当する場合のみトークンを返す
  const shouldNotify =
    (reservationInfo.isToday && notifyToday) || (reservationInfo.isTomorrow && notifyTomorrow);

  if (!shouldNotify) {
    return { tokens: [], notifyToday, notifyTomorrow };
  }

  // FCMトークンを取得
  const tokensSnapshot = await db.collection(`users/${uid}/fcm_tokens`).get();

  const tokens = tokensSnapshot.docs
    .map((doc) => (doc.data() as FcmTokenDoc).token)
    .filter((token) => token != null && token !== "");

  return { tokens, notifyToday, notifyTomorrow };
}

/**
 * 通知メッセージを構築
 */
export function buildNotificationMessage(reservationInfo: {
  isToday: boolean;
  isTomorrow: boolean;
}): { title: string; body: string } {
  const title = "予防接種のお知らせ";

  let body: string;
  if (reservationInfo.isToday && reservationInfo.isTomorrow) {
    // 当日と翌日両方に予約がある場合
    body = "本日と明日、予防接種の予約があります。";
  } else if (reservationInfo.isToday) {
    body = "本日、予防接種の予約があります。";
  } else {
    body = "明日、予防接種の予約があります。";
  }

  return { title, body };
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

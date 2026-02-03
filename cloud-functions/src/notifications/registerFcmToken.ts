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
      // 3. Save FCM token to subcollection: users/{uid}/fcm_tokens/{deviceId}
      const tokenRef = db.doc(`users/${userId}/fcm_tokens/${deviceId}`);
      await tokenRef.set(
        {
          token,
          platform,
          createdAt: now,
          updatedAt: now,
        },
        { merge: true }
      );

      // 4. Ensure notification settings exist with defaults
      const settingsRef = db.doc(`users/${userId}/notification_settings/settings`);
      const settingsSnapshot = await settingsRef.get();

      if (!settingsSnapshot.exists) {
        await settingsRef.set({
          vaccineReminder: {
            enabled: true,
            daysBefore: [0, 1],
          },
          dailyEncouragement: {
            enabled: true,
          },
          createdAt: now,
          updatedAt: now,
        });
      }

      return {
        success: true,
        message: "FCMトークンを登録しました",
      };
    } catch (error) {
      if (error instanceof functions.https.HttpsError) {
        throw error;
      }
      console.error("Error registering FCM token:", error);
      throw new functions.https.HttpsError("internal", "FCMトークンの登録中にエラーが発生しました");
    }
  });

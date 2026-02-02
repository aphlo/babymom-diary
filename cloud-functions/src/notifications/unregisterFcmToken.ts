import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

interface UnregisterFcmTokenData {
  deviceId: string;
}

interface UnregisterFcmTokenResult {
  success: boolean;
  message: string;
}

export const unregisterFcmToken = functions
  .region("asia-northeast1")
  .https.onCall(
    async (
      data: UnregisterFcmTokenData,
      context
    ): Promise<UnregisterFcmTokenResult> => {
      // 1. Authentication check
      if (!context.auth) {
        throw new functions.https.HttpsError(
          "unauthenticated",
          "認証が必要です"
        );
      }

      const userId = context.auth.uid;
      const deviceId = data.deviceId?.trim();

      // 2. Input validation
      if (!deviceId) {
        throw new functions.https.HttpsError(
          "invalid-argument",
          "デバイスIDが必要です"
        );
      }

      const db = admin.firestore();

      try {
        // 3. Delete FCM token from subcollection: users/{uid}/fcm_tokens/{deviceId}
        const tokenRef = db.doc(`users/${userId}/fcm_tokens/${deviceId}`);
        await tokenRef.delete();

        return {
          success: true,
          message: "FCMトークンを削除しました",
        };
      } catch (error) {
        if (error instanceof functions.https.HttpsError) {
          throw error;
        }
        console.error("Error unregistering FCM token:", error);
        throw new functions.https.HttpsError(
          "internal",
          "FCMトークンの削除中にエラーが発生しました"
        );
      }
    }
  );

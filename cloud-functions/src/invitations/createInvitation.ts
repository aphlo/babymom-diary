import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { generateInvitationCode } from "./utils";

interface CreateInvitationData {
  householdId: string;
}

interface CreateInvitationResult {
  invitationId: string;
  code: string;
  expiresAt: string;
}

export const createInvitation = functions
  .region("asia-northeast1")
  .runWith({
    enforceAppCheck: true, // Reject requests without valid App Check token
  })
  .https.onCall(async (data: CreateInvitationData, context): Promise<CreateInvitationResult> => {
    // 1. App Check validation
    if (!context.app) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "不正なクライアントからのリクエストです"
      );
    }

    // 2. Authentication check
    if (!context.auth) {
      throw new functions.https.HttpsError("unauthenticated", "認証が必要です");
    }

    const userId = context.auth.uid;
    const { householdId } = data;

    if (!householdId) {
      throw new functions.https.HttpsError("invalid-argument", "世帯IDが必要です");
    }

    const db = admin.firestore();

    // 3. Verify household and permissions
    const householdRef = db.doc(`households/${householdId}`);
    const householdSnapshot = await householdRef.get();

    if (!householdSnapshot.exists) {
      throw new functions.https.HttpsError("not-found", "世帯が見つかりません");
    }

    const household = householdSnapshot.data()!;

    // Only owner can create invitation codes
    if (household.members?.[userId]?.role !== "owner") {
      throw new functions.https.HttpsError("permission-denied", "招待コードの作成権限がありません");
    }

    // 4. Generate unique code
    let code: string = "";
    let isUnique = false;
    let attempts = 0;
    const maxAttempts = 10;

    while (!isUnique && attempts < maxAttempts) {
      code = generateInvitationCode();

      const existingSnapshot = await db
        .collectionGroup("invitations")
        .where("code", "==", code)
        .where("status", "==", "pending")
        .limit(1)
        .get();

      isUnique = existingSnapshot.empty;
      attempts++;
    }

    if (!isUnique) {
      throw new functions.https.HttpsError("internal", "招待コードの生成に失敗しました");
    }

    // 5. Create invitation document
    const invitationRef = householdRef.collection("invitations").doc();
    const expiresAt = admin.firestore.Timestamp.fromMillis(
      Date.now() + 24 * 60 * 60 * 1000 // 24 hours
    );

    await invitationRef.set({
      code,
      createdBy: userId,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      expiresAt,
      status: "pending",
    });

    return {
      invitationId: invitationRef.id,
      code,
      expiresAt: expiresAt.toDate().toISOString(),
    };
  });

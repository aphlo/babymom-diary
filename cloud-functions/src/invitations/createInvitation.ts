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
  .https.onCall(async (data: CreateInvitationData, context): Promise<CreateInvitationResult> => {
    // 1. Authentication check
    if (!context.auth) {
      functions.logger.error("createInvitation: Unauthenticated request");
      throw new functions.https.HttpsError("unauthenticated", "認証が必要です");
    }

    const userId = context.auth.uid;
    const { householdId } = data;

    functions.logger.info("createInvitation: Starting", { userId, householdId });

    if (!householdId) {
      functions.logger.error("createInvitation: Missing householdId", { userId });
      throw new functions.https.HttpsError("invalid-argument", "世帯IDが必要です");
    }

    const db = admin.firestore();

    // 3. Verify household and permissions
    const householdRef = db.doc(`households/${householdId}`);
    const householdSnapshot = await householdRef.get();

    if (!householdSnapshot.exists) {
      functions.logger.error("createInvitation: Household not found", {
        userId,
        householdId,
        path: householdRef.path
      });
      throw new functions.https.HttpsError("not-found", "世帯が見つかりません");
    }

    // Check if user is a member with admin role (members are in subcollection)
    const memberRef = householdRef.collection("members").doc(userId);
    const memberSnapshot = await memberRef.get();

    if (!memberSnapshot.exists) {
      functions.logger.error("createInvitation: User is not a member", {
        userId,
        householdId,
        memberPath: memberRef.path
      });
      throw new functions.https.HttpsError("permission-denied", "この世帯のメンバーではありません");
    }

    const member = memberSnapshot.data()!;

    // Only admin can create invitation codes
    if (member.role !== "admin") {
      functions.logger.error("createInvitation: User lacks admin role", {
        userId,
        householdId,
        role: member.role
      });
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
      functions.logger.error("createInvitation: Failed to generate unique code", {
        userId,
        householdId,
        attempts: maxAttempts
      });
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

    functions.logger.info("createInvitation: Success", {
      userId,
      householdId,
      invitationId: invitationRef.id,
      code
    });

    return {
      invitationId: invitationRef.id,
      code,
      expiresAt: expiresAt.toDate().toISOString(),
    };
  });

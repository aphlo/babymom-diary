import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { isValidInvitationCode } from "./utils";

interface AcceptInvitationData {
  code: string;
}

interface AcceptInvitationResult {
  householdId: string;
  success: boolean;
  message: string;
}

export const acceptInvitation = functions
  .region("asia-northeast1")
  .https.onCall(async (data: AcceptInvitationData, context): Promise<AcceptInvitationResult> => {
    // 1. Authentication check
    if (!context.auth) {
      throw new functions.https.HttpsError("unauthenticated", "認証が必要です");
    }

    const userId = context.auth.uid;
    const code = data.code?.toUpperCase()?.trim();

    // 3. Input validation
    if (!code || !isValidInvitationCode(code)) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "招待コードは6桁の英数字である必要があります"
      );
    }

    const db = admin.firestore();

    try {
      // 4. Execute transaction
      return await db.runTransaction(async (transaction) => {
        // 4-1. Search for invitation code
        const invitationsSnapshot = await db
          .collectionGroup("invitations")
          .where("code", "==", code)
          .where("status", "==", "pending")
          .limit(1)
          .get();

        if (invitationsSnapshot.empty) {
          throw new functions.https.HttpsError(
            "not-found",
            "招待コードが見つからないか、既に使用されています"
          );
        }

        const invitationDoc = invitationsSnapshot.docs[0];
        const invitation = invitationDoc.data();
        const householdId = invitationDoc.ref.parent.parent!.id;

        // 4-2. Check expiration
        const now = admin.firestore.Timestamp.now();
        if (invitation.expiresAt.toMillis() < now.toMillis()) {
          transaction.update(invitationDoc.ref, { status: "expired" });
          throw new functions.https.HttpsError(
            "failed-precondition",
            "招待コードの有効期限が切れています"
          );
        }

        // 4-3. Self-invitation check
        if (invitation.createdBy === userId) {
          throw new functions.https.HttpsError(
            "invalid-argument",
            "自分自身を招待することはできません"
          );
        }

        // 4-4. Get household document
        const householdRef = db.doc(`households/${householdId}`);
        const householdSnapshot = await transaction.get(householdRef);

        if (!householdSnapshot.exists) {
          throw new functions.https.HttpsError("not-found", "世帯が見つかりません");
        }

        // 4-5. Check if already a member (members are in subcollection)
        const memberRef = householdRef.collection("members").doc(userId);
        const memberSnapshot = await transaction.get(memberRef);

        if (memberSnapshot.exists) {
          throw new functions.https.HttpsError("already-exists", "既にこの世帯のメンバーです");
        }

        // 4-6. Add as member (to subcollection)
        transaction.set(memberRef, {
          role: "member",
          joinedAt: admin.firestore.FieldValue.serverTimestamp(),
          joinToken: invitationDoc.id,
          uid: userId,
        });

        // 4-7. Update invitation status
        transaction.update(invitationDoc.ref, {
          status: "accepted",
          acceptedBy: userId,
          acceptedAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        return {
          householdId,
          success: true,
          message: "世帯への参加が完了しました",
        };
      });
    } catch (error) {
      if (error instanceof functions.https.HttpsError) {
        throw error;
      }
      console.error("Error accepting invitation:", error);
      throw new functions.https.HttpsError("internal", "招待の承認中にエラーが発生しました");
    }
  });

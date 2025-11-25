import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

interface AcceptInvitationData {
  householdId: string;
  displayName: string;
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
    const householdId = data.householdId?.trim();
    const displayName = data.displayName?.trim();

    // 2. Input validation
    if (!householdId) {
      throw new functions.https.HttpsError("invalid-argument", "世帯IDを入力してください");
    }

    if (!displayName || displayName.length === 0) {
      throw new functions.https.HttpsError("invalid-argument", "表示名を入力してください");
    }

    if (displayName.length > 50) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "表示名は50文字以内で入力してください"
      );
    }

    const db = admin.firestore();

    try {
      // 3. Execute transaction
      return await db.runTransaction(async (transaction) => {
        const userRef = db.doc(`users/${userId}`);
        const userSnapshot = await transaction.get(userRef);

        if (!userSnapshot.exists) {
          transaction.set(userRef, {
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
          });
        }

        const userData = userSnapshot.data() as
          | {
              activeHouseholdId?: string;
              membershipType?: string;
            }
          | undefined;
        const previousHouseholdId = userData?.activeHouseholdId;
        const previousMembershipType = userData?.membershipType;

        // 3-1. Get target household document
        const householdRef = db.doc(`households/${householdId}`);
        const householdSnapshot = await transaction.get(householdRef);

        if (!householdSnapshot.exists) {
          throw new functions.https.HttpsError("not-found", "世帯が見つかりません");
        }

        const householdData = householdSnapshot.data();
        if (!householdData) {
          throw new functions.https.HttpsError("not-found", "世帯データが見つかりません");
        }

        // 3-2. Self-invitation check
        if (householdData.createdBy === userId) {
          throw new functions.https.HttpsError(
            "invalid-argument",
            "自分が作成した世帯には参加できません"
          );
        }

        // 3-3. Check if already a member
        const memberRef = householdRef.collection("members").doc(userId);
        const memberSnapshot = await transaction.get(memberRef);

        if (memberSnapshot.exists) {
          throw new functions.https.HttpsError("already-exists", "既にこの世帯のメンバーです");
        }

        // 3-4. Check if user is admin with other members in current household
        if (previousHouseholdId && previousMembershipType === "owner") {
          // Check if there are other members in the current household
          const currentMembersSnapshot = await db
            .collection(`households/${previousHouseholdId}/members`)
            .where("uid", "!=", userId)
            .limit(1)
            .get();

          if (!currentMembersSnapshot.empty) {
            throw new functions.https.HttpsError(
              "failed-precondition",
              "他のメンバーがいる世帯の管理者は、別の世帯に参加できません"
            );
          }
        }

        // 3-5. Remove from previous household if exists
        if (previousHouseholdId && previousHouseholdId !== householdId) {
          const previousMemberRef = db.doc(`households/${previousHouseholdId}/members/${userId}`);
          transaction.delete(previousMemberRef);
        }

        // 3-6. Add as member with display name
        transaction.set(memberRef, {
          role: "member",
          displayName: displayName,
          joinedAt: admin.firestore.FieldValue.serverTimestamp(),
          uid: userId,
        });

        // 3-7. Update user document
        transaction.set(
          userRef,
          {
            activeHouseholdId: householdId,
            membershipType: "member",
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          },
          { merge: true }
        );

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

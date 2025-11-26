import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

interface RemoveMemberData {
  householdId: string;
  memberUid: string;
}

interface RemoveMemberResult {
  success: boolean;
  message: string;
}

export const removeMember = functions
  .region("asia-northeast1")
  .https.onCall(async (data: RemoveMemberData, context): Promise<RemoveMemberResult> => {
    // 1. Authentication check
    if (!context.auth) {
      throw new functions.https.HttpsError("unauthenticated", "認証が必要です");
    }

    const callerUid = context.auth.uid;
    const householdId = data.householdId?.trim();
    const memberUid = data.memberUid?.trim();

    // 2. Input validation
    if (!householdId) {
      throw new functions.https.HttpsError("invalid-argument", "世帯IDが必要です");
    }

    if (!memberUid) {
      throw new functions.https.HttpsError("invalid-argument", "メンバーIDが必要です");
    }

    // Cannot remove yourself
    if (callerUid === memberUid) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "自分自身を削除することはできません"
      );
    }

    const db = admin.firestore();

    try {
      return await db.runTransaction(async (transaction) => {
        // 3. Check if caller is the owner of the household
        const householdRef = db.doc(`households/${householdId}`);
        const householdSnapshot = await transaction.get(householdRef);

        if (!householdSnapshot.exists) {
          throw new functions.https.HttpsError("not-found", "世帯が見つかりません");
        }

        const householdData = householdSnapshot.data();
        if (!householdData || householdData.createdBy !== callerUid) {
          throw new functions.https.HttpsError(
            "permission-denied",
            "メンバーを削除する権限がありません"
          );
        }

        // 4. Check if member exists in the household
        const memberRef = householdRef.collection("members").doc(memberUid);
        const memberSnapshot = await transaction.get(memberRef);

        if (!memberSnapshot.exists) {
          throw new functions.https.HttpsError(
            "not-found",
            "指定されたメンバーはこの世帯に存在しません"
          );
        }

        // 5. Get the member's user document to find their original household
        const memberUserRef = db.doc(`users/${memberUid}`);
        const memberUserSnapshot = await transaction.get(memberUserRef);

        // 6. Find the member's original household (where they are the owner)
        // We need to search for a household where createdBy == memberUid
        const ownedHouseholdsSnapshot = await db
          .collection("households")
          .where("createdBy", "==", memberUid)
          .limit(1)
          .get();

        let originalHouseholdId: string | null = null;
        if (!ownedHouseholdsSnapshot.empty) {
          originalHouseholdId = ownedHouseholdsSnapshot.docs[0].id;
        }

        // 7. Delete the member from the household
        transaction.delete(memberRef);

        // 8. Update the member's user document
        if (memberUserSnapshot.exists) {
          if (originalHouseholdId) {
            // Restore to their original household
            transaction.set(
              memberUserRef,
              {
                activeHouseholdId: originalHouseholdId,
                role: "admin",
                updatedAt: admin.firestore.FieldValue.serverTimestamp(),
              },
              { merge: true }
            );
          } else {
            // No original household found - clear the active household
            // This forces them to create a new household on next app launch
            transaction.set(
              memberUserRef,
              {
                activeHouseholdId: admin.firestore.FieldValue.delete(),
                role: admin.firestore.FieldValue.delete(),
                updatedAt: admin.firestore.FieldValue.serverTimestamp(),
              },
              { merge: true }
            );
          }
        }

        return {
          success: true,
          message: "メンバーを削除しました",
        };
      });
    } catch (error) {
      if (error instanceof functions.https.HttpsError) {
        throw error;
      }
      console.error("Error removing member:", error);
      throw new functions.https.HttpsError("internal", "メンバーの削除中にエラーが発生しました");
    }
  });

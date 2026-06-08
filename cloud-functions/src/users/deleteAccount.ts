import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

interface DeleteAccountResult {
  success: boolean;
  message: string;
}

export const deleteAccount = functions
  .region("asia-northeast1")
  .https.onCall(async (data: unknown, context): Promise<DeleteAccountResult> => {
    // 1. Authentication check
    if (!context.auth) {
      console.error("Account deletion failed: Unauthenticated request.");
      throw new functions.https.HttpsError("unauthenticated", "認証が必要です");
    }

    const callerUid = context.auth.uid;
    const db = admin.firestore();

    console.log("Account deletion process initiated by authenticated user.");

    try {
      // 2. Fetch target user's details
      const userRef = db.doc(`users/${callerUid}`);
      const userSnapshot = await userRef.get();

      if (!userSnapshot.exists) {
        console.error("Account deletion failed: User document does not exist in firestore.");
        throw new functions.https.HttpsError("not-found", "ユーザー情報が見つかりません");
      }

      const userData = userSnapshot.data();
      const activeHouseholdId = userData?.activeHouseholdId as string | undefined;
      const membershipType = userData?.membershipType as string | undefined;

      console.log(
        `User document found. membershipType: ${membershipType}, hasActiveHousehold: ${!!activeHouseholdId}`
      );

      // 3. Find all households owned by this user (including potentially abandoned ones)
      const ownedHouseholdsSnapshot = await db
        .collection("households")
        .where("createdBy", "==", callerUid)
        .get();

      const householdRefsToDelete: admin.firestore.DocumentReference[] = [];
      ownedHouseholdsSnapshot.forEach((doc) => {
        householdRefsToDelete.push(doc.ref);
      });

      console.log(`Found ${householdRefsToDelete.length} households created by this user.`);

      // 4. Handle deletion logic based on membership type
      if (activeHouseholdId && membershipType === "owner") {
        // --- PATTERN A & B: User is the owner of their active household ---
        console.log("Processing as owner of the active household (Pattern A or B).");

        // Check if there are other members in this household
        const membersSnapshot = await db
          .collection(`households/${activeHouseholdId}/members`)
          .get();

        const otherMembers = membersSnapshot.docs.filter((doc) => doc.id !== callerUid);

        if (otherMembers.length > 0) {
          // --- PATTERN B: Disband shared household & restore other members ---
          console.log(
            `Pattern B detected: Disbanding shared household with ${otherMembers.length} other members.`
          );
          const batch = db.batch();

          for (const memberDoc of otherMembers) {
            const memberUid = memberDoc.id;

            // Search for member's original household (where they are the creator)
            const memberOwnedSnapshot = await db
              .collection("households")
              .where("createdBy", "==", memberUid)
              .limit(1)
              .get();

            const memberUserRef = db.doc(`users/${memberUid}`);

            if (!memberOwnedSnapshot.empty) {
              console.log("Restoring a member to their original household.");
              const originalHouseholdId = memberOwnedSnapshot.docs[0].id;
              batch.set(
                memberUserRef,
                {
                  activeHouseholdId: originalHouseholdId,
                  membershipType: "owner",
                  updatedAt: admin.firestore.FieldValue.serverTimestamp(),
                },
                { merge: true }
              );
            } else {
              // If member has no original household, clear activeHouseholdId
              // so they are prompted to create a new one on next startup
              console.log("Clearing active household for a member with no original household.");
              batch.set(
                memberUserRef,
                {
                  activeHouseholdId: admin.firestore.FieldValue.delete(),
                  membershipType: admin.firestore.FieldValue.delete(),
                  updatedAt: admin.firestore.FieldValue.serverTimestamp(),
                },
                { merge: true }
              );
            }
          }

          // Commit changes for other members
          console.log("Committing restored membership state for other members.");
          await batch.commit();
        } else {
          // --- PATTERN A: Sole owner ---
          console.log("Pattern A detected: User is the sole member of the active household.");
        }

        // Add the active household to deletion list if not already there
        const activeHouseholdRef = db.doc(`households/${activeHouseholdId}`);
        if (!householdRefsToDelete.some((ref) => ref.id === activeHouseholdId)) {
          householdRefsToDelete.push(activeHouseholdRef);
        }

        // Recursively delete all owned households and their subcollections
        console.log(`Recursively deleting ${householdRefsToDelete.length} household(s).`);
        for (const ref of householdRefsToDelete) {
          await db.recursiveDelete(ref);
        }
      } else if (activeHouseholdId && membershipType === "member") {
        // --- PATTERN C: User is a member of another person's household ---
        console.log("Pattern C detected: User is a member of another user's household.");

        // 1. Remove user from the current shared household's members collection
        console.log("Removing user from the shared household members list.");
        const memberRef = db.doc(`households/${activeHouseholdId}/members/${callerUid}`);
        await memberRef.delete();

        // 2. Recursively delete any households created by the user (which are now abandoned)
        console.log(
          `Recursively deleting ${householdRefsToDelete.length} abandoned owned household(s).`
        );
        for (const ref of householdRefsToDelete) {
          await db.recursiveDelete(ref);
        }
      } else {
        // --- FALLBACK / NO HOUSEHOLD ---
        console.log("Fallback case: User has no active household membership info.");
        // Clean up any households owned by the user just in case
        console.log(`Recursively deleting ${householdRefsToDelete.length} owned household(s).`);
        for (const ref of householdRefsToDelete) {
          await db.recursiveDelete(ref);
        }
      }

      // 5. Delete user document from 'users' collection
      console.log("Deleting user document from Firestore.");
      await userRef.delete();

      console.log("Account deletion and data cleanup completed successfully.");
      return {
        success: true,
        message: "アカウントに関連するデータが正常に削除されました",
      };
    } catch (error) {
      if (error instanceof functions.https.HttpsError) {
        throw error;
      }

      // Do not print the raw error object directly if it might contain private paths or IDs.
      const errorMessage = error instanceof Error ? error.message : String(error);
      console.error("An error occurred during the account deletion process:", errorMessage);

      throw new functions.https.HttpsError(
        "internal",
        "アカウント削除のクリーンアップ中にエラーが発生しました"
      );
    }
  });

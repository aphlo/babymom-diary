import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {
  identifier,
  membershipFields,
  requireActive,
  requireAuth,
  requireOwner,
  restorationTarget,
} from "../households/authorization";

export const removeMember = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const uid = requireAuth(context);
    const householdId = identifier(data?.householdId);
    const memberUid = identifier(data?.memberUid);
    if (uid === memberUid)
      throw new functions.https.HttpsError("invalid-argument", "自分自身を削除できません");
    const db = admin.firestore();
    return db.runTransaction(async (transaction) => {
      const authorityRef = db.doc(`household_authorizations/${householdId}`);
      const authority = await transaction.get(authorityRef);
      const owner = await transaction.get(db.doc(`user_authorizations/${uid}`));
      requireActive(owner.data());
      requireOwner(authority.data(), uid);
      if (owner.data()?.activeHouseholdId !== householdId)
        throw new functions.https.HttpsError("permission-denied", "現在の管理者の権限が必要です");
      const memberRef = db.doc(`households/${householdId}/members/${memberUid}`);
      const member = await transaction.get(memberRef);
      if (!member.exists)
        throw new functions.https.HttpsError("not-found", "メンバーが見つかりません");
      const accountRef = db.doc(`user_authorizations/${memberUid}`);
      const account = await transaction.get(accountRef);
      const original = await restorationTarget(
        transaction,
        db,
        memberUid,
        account.data()?.originalHouseholdId
      );
      transaction.delete(memberRef);
      transaction.update(authorityRef, {
        invitationGeneration: admin.firestore.FieldValue.increment(1),
      });
      if (account.data()?.state === "active" && account.data()?.activeHouseholdId === householdId) {
        transaction.update(accountRef, { activeHouseholdId: original });
        transaction.set(db.doc(`users/${memberUid}`), membershipFields(original, true), {
          merge: true,
        });
      }
      return { success: true, message: "メンバーを削除しました" };
    });
  });

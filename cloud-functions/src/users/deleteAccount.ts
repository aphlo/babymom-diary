import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { membershipFields, requireAuth, restorationTarget } from "../households/authorization";

export const deleteAccount = functions
  .region("asia-northeast1")
  .https.onCall(async (_data, context) => {
    const uid = requireAuth(context);
    const db = admin.firestore();
    // Never derive deletion targets from client-writable users or legacy createdBy.
    const accountRef = db.doc(`user_authorizations/${uid}`);
    await db.runTransaction(async (transaction) => {
      await transaction.get(accountRef);
      transaction.set(accountRef, { state: "deleting" }, { merge: true });
    });
    const owned = await db
      .collection("household_authorizations")
      .where("ownerUid", "==", uid)
      .get();
    for (const household of owned.docs) {
      await db.runTransaction(async (transaction) => {
        const authority = await transaction.get(household.ref);
        if (authority.data()?.ownerUid !== uid)
          throw new functions.https.HttpsError("permission-denied", "所有権の確認に失敗しました");
        const members = await transaction.get(db.collection(`households/${household.id}/members`));
        const restorations: { uid: string; original: string | null; active: boolean }[] = [];
        for (const member of members.docs) {
          if (member.id === uid) continue;
          const account = await transaction.get(db.doc(`user_authorizations/${member.id}`));
          const original = await restorationTarget(
            transaction,
            db,
            member.id,
            account.data()?.originalHouseholdId
          );
          restorations.push({
            uid: member.id,
            original,
            active:
              account.data()?.state === "active" &&
              account.data()?.activeHouseholdId === household.id,
          });
        }
        transaction.set(accountRef, { state: "deleting" }, { merge: true });
        transaction.update(household.ref, {
          state: "deleting",
          invitationGeneration: admin.firestore.FieldValue.increment(1),
        });
        for (const restored of restorations) {
          if (!restored.active) continue;
          transaction.update(db.doc(`user_authorizations/${restored.uid}`), {
            activeHouseholdId: restored.original,
          });
          transaction.set(
            db.doc(`users/${restored.uid}`),
            membershipFields(restored.original, true),
            { merge: true }
          );
        }
      });
      await db.recursiveDelete(db.doc(`households/${household.id}`));
      await household.ref.delete();
    }
    // Mark the account before membership cleanup, blocking concurrent joins/creation.
    await accountRef.set({ state: "deleting" }, { merge: true });
    const memberships = await db.collectionGroup("members").where("uid", "==", uid).get();
    for (const member of memberships.docs) {
      if (member.id !== uid) continue;
      const hid = member.ref.parent.parent?.id;
      if (!hid) continue;
      await db.runTransaction(async (transaction) => {
        const authorityRef = db.doc(`household_authorizations/${hid}`);
        const authority = await transaction.get(authorityRef);
        transaction.delete(member.ref);
        if (authority.exists)
          transaction.update(authorityRef, {
            invitationGeneration: admin.firestore.FieldValue.increment(1),
          });
      });
    }
    await db.recursiveDelete(db.doc(`users/${uid}`));
    // Keep a tombstone until Auth deletion completes client-side. Retries remain possible.
    return { success: true, message: "アカウントに関連するデータが正常に削除されました" };
  });

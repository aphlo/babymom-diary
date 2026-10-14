import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { membershipFields, requireActive, requireAuth } from "./authorization";

export const createHousehold = functions
  .region("asia-northeast1")
  .https.onCall(async (_data, context) => {
    const uid = requireAuth(context);
    const db = admin.firestore();
    return db.runTransaction(async (transaction) => {
      const accountRef = db.doc(`user_authorizations/${uid}`);
      const userRef = db.doc(`users/${uid}`);
      const account = await transaction.get(accountRef);
      const user = await transaction.get(userRef);
      if (account.exists) {
        requireActive(account.data());
        const hid = account.data()?.activeHouseholdId;
        if (typeof hid === "string") {
          const authority = await transaction.get(db.doc(`household_authorizations/${hid}`));
          const member = await transaction.get(db.doc(`households/${hid}/members/${uid}`));
          requireActive(authority.data());
          if (!member.exists)
            throw new functions.https.HttpsError("failed-precondition", "所属情報の確認が必要です");
          return { householdId: hid };
        }
      } else if (user.data()?.activeHouseholdId || user.data()?.membershipType) {
        throw new functions.https.HttpsError(
          "failed-precondition",
          "既存世帯の確認が必要です。サポートへお問い合わせください"
        );
      }
      const household = db.collection("households").doc();
      transaction.create(household, {
        createdBy: uid,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      transaction.create(db.doc(`household_authorizations/${household.id}`), {
        ownerUid: uid,
        state: "active",
        invitationGeneration: 0,
      });
      transaction.create(household.collection("members").doc(uid), {
        uid,
        role: "admin",
        displayName: "管理者",
        joinedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      transaction.set(accountRef, {
        state: "active",
        activeHouseholdId: household.id,
        originalHouseholdId: household.id,
      });
      transaction.set(userRef, membershipFields(household.id, true), { merge: true });
      return { householdId: household.id };
    });
  });

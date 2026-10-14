import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { membershipFields, requireActive, requireAuth } from "../households/authorization";
import { tokenHash } from "./createInvitation";

export const acceptInvitation = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const uid = requireAuth(context);
    const hash = tokenHash(data?.token); // The legacy householdId-only protocol is deliberately rejected.
    const displayName = typeof data?.displayName === "string" ? data.displayName.trim() : "";
    if (!displayName || displayName.length > 50) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "表示名を50文字以内で入力してください"
      );
    }
    const db = admin.firestore();
    return db.runTransaction(async (transaction) => {
      const invitationRef = db.doc(`household_invitations/${hash}`);
      const invitation = await transaction.get(invitationRef);
      const invite = invitation.data();
      if (
        !invite ||
        !(invite.expiresAt instanceof admin.firestore.Timestamp) ||
        invite.expiresAt.toMillis() <= Date.now()
      ) {
        throw new functions.https.HttpsError("not-found", "招待が無効または期限切れです");
      }
      const householdId = invite.householdId as string;
      const authority = await transaction.get(db.doc(`household_authorizations/${householdId}`));
      requireActive(authority.data());
      if (
        authority.data()?.ownerUid !== invite.issuerUid ||
        authority.data()?.invitationGeneration !== invite.generation
      ) {
        throw new functions.https.HttpsError("not-found", "招待が失効しています");
      }
      const issuer = await transaction.get(db.doc(`user_authorizations/${invite.issuerUid}`));
      if (issuer.data()?.state !== "active" || issuer.data()?.activeHouseholdId !== householdId) {
        throw new functions.https.HttpsError("not-found", "招待が失効しています");
      }
      const accountRef = db.doc(`user_authorizations/${uid}`);
      const account = await transaction.get(accountRef);
      requireActive(account.data());
      const previousId = account.data()?.activeHouseholdId;
      if (previousId) {
        const previousAuthority = await transaction.get(
          db.doc(`household_authorizations/${previousId}`)
        );
        requireActive(previousAuthority.data());
        if (previousAuthority.data()?.ownerUid === uid) {
          const members = await transaction.get(
            db.collection(`households/${previousId}/members`).limit(2)
          );
          if (members.docs.some((member) => member.id !== uid)) {
            throw new functions.https.HttpsError(
              "failed-precondition",
              "他のメンバーがいる世帯の管理者は参加できません"
            );
          }
        }
      }
      if (authority.data()?.ownerUid === uid) {
        throw new functions.https.HttpsError("invalid-argument", "自分の世帯には参加できません");
      }
      const memberRef = db.doc(`households/${householdId}/members/${uid}`);
      const member = await transaction.get(memberRef);
      if (member.exists)
        throw new functions.https.HttpsError("already-exists", "既にこの世帯のメンバーです");
      // Every move revokes prior invitations, including the preserved original household.
      if (previousId) {
        if (previousId !== account.data()?.originalHouseholdId) {
          transaction.delete(db.doc(`households/${previousId}/members/${uid}`));
        }
        transaction.update(db.doc(`household_authorizations/${previousId}`), {
          invitationGeneration: admin.firestore.FieldValue.increment(1),
        });
      }
      transaction.create(memberRef, {
        uid,
        role: "member",
        displayName,
        joinedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      transaction.update(accountRef, { activeHouseholdId: householdId });
      transaction.set(db.doc(`users/${uid}`), membershipFields(householdId, false), {
        merge: true,
      });
      transaction.delete(invitationRef); // Atomic consumption: concurrent redemption can only succeed once.
      return { householdId, success: true, message: "世帯への参加が完了しました" };
    });
  });

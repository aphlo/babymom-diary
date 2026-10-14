import { createHash, randomBytes } from "node:crypto";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { identifier, requireActive, requireAuth, requireOwner } from "../households/authorization";

export function tokenHash(token: unknown): string {
  if (typeof token !== "string" || !/^[A-Za-z0-9_-]{43}$/.test(token)) {
    throw new functions.https.HttpsError("invalid-argument", "有効な招待コードを入力してください");
  }
  return createHash("sha256").update(token).digest("hex");
}

export const createInvitation = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const uid = requireAuth(context);
    const householdId = identifier(data?.householdId);
    const db = admin.firestore();
    const token = randomBytes(32).toString("base64url");
    const expiresAt = admin.firestore.Timestamp.fromMillis(Date.now() + 24 * 60 * 60 * 1000);
    await db.runTransaction(async (transaction) => {
      const authorityRef = db.doc(`household_authorizations/${householdId}`);
      const authority = await transaction.get(authorityRef);
      const account = await transaction.get(db.doc(`user_authorizations/${uid}`));
      requireActive(account.data());
      requireOwner(authority.data(), uid);
      if (account.data()?.activeHouseholdId !== householdId) {
        throw new functions.https.HttpsError(
          "permission-denied",
          "現在の世帯の管理者のみ招待できます"
        );
      }
      const generation = (authority.data()?.invitationGeneration ?? 0) + 1;
      transaction.update(authorityRef, { invitationGeneration: generation });
      transaction.create(db.doc(`household_invitations/${tokenHash(token)}`), {
        householdId,
        issuerUid: uid,
        generation,
        expiresAt,
      });
    });
    return { token, expiresAt: expiresAt.toMillis() };
  });

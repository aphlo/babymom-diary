import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

export function identifier(value: unknown): string {
  if (typeof value !== "string" || !/^[A-Za-z0-9_-]{1,128}$/.test(value)) {
    throw new functions.https.HttpsError("invalid-argument", "IDが無効です");
  }
  return value;
}

export function requireAuth(context: { auth?: { uid: string } }): string {
  if (!context.auth) throw new functions.https.HttpsError("unauthenticated", "認証が必要です");
  return context.auth.uid;
}

export function requireActive(data: admin.firestore.DocumentData | undefined): void {
  if (!data || data.state !== "active") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "世帯の確認または処理の完了が必要です"
    );
  }
}

export function requireOwner(data: admin.firestore.DocumentData | undefined, uid: string): void {
  requireActive(data);
  if (data?.ownerUid !== uid) {
    throw new functions.https.HttpsError("permission-denied", "管理者の権限が必要です");
  }
}

export function membershipFields(householdId: string | null, owner: boolean) {
  return {
    activeHouseholdId: householdId ?? admin.firestore.FieldValue.delete(),
    membershipType: householdId
      ? owner
        ? "owner"
        : "member"
      : admin.firestore.FieldValue.delete(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  };
}

// Only this private record may supply a restoration target. Legacy createdBy/users are not evidence.
export async function restorationTarget(
  transaction: admin.firestore.Transaction,
  db: admin.firestore.Firestore,
  uid: string,
  original: unknown
): Promise<string | null> {
  if (typeof original !== "string") return null;
  const id = identifier(original);
  const snapshot = await transaction.get(db.doc(`household_authorizations/${id}`));
  const data = snapshot.data();
  return data?.ownerUid === uid && data.state === "active" ? id : null;
}

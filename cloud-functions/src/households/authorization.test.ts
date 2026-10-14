import * as admin from "firebase-admin";
import type * as functions from "firebase-functions";
import { acceptInvitation } from "../invitations/acceptInvitation";
import { createInvitation } from "../invitations/createInvitation";
import { removeMember } from "../members/removeMember";
import { registerFcmToken } from "../notifications/registerFcmToken";
import { deleteAccount } from "../users/deleteAccount";
import { createHousehold } from "./createHousehold";

jest.mock("firebase-admin", () => {
  const actual = jest.requireActual("firebase-admin");
  return {
    firestore: Object.assign(jest.fn(), {
      Timestamp: actual.firestore.Timestamp,
      FieldValue: actual.firestore.FieldValue,
    }),
  };
});

type Data = Record<string, unknown>;
const documents = new Map<string, Data>();
const deleted: string[] = [];
let sequence = 0;
function snapshot(path: string) {
  return {
    id: path.split("/").pop(),
    exists: documents.has(path),
    data: () => documents.get(path),
    ref: reference(path),
  };
}
interface Reference {
  path: string;
  id: string | undefined;
  parent: { parent: Reference | null };
  get: () => Promise<ReturnType<typeof snapshot>>;
  collection: (name: string) => ReturnType<typeof query>;
  set: (data: Data, options?: { merge: boolean }) => Promise<void>;
  delete: () => Promise<boolean>;
}
function reference(path: string): Reference {
  return {
    path,
    id: path.split("/").pop(),
    parent: {
      parent: path.split("/").length > 2 ? reference(path.split("/").slice(0, -2).join("/")) : null,
    },
    get: async () => snapshot(path),
    collection: (name: string) => query(`${path}/${name}`),
    set: async (data: Data, options?: { merge: boolean }) => set(path, data, options?.merge),
    delete: async () => documents.delete(path),
  };
}
function set(path: string, data: Data, merge = false) {
  const next = merge ? { ...documents.get(path) } : {};
  for (const [key, value] of Object.entries(data)) {
    if (value instanceof admin.firestore.FieldValue) {
      if (value.isEqual(admin.firestore.FieldValue.delete())) delete next[key];
      else if (value.isEqual(admin.firestore.FieldValue.increment(1)))
        next[key] = Number(next[key] ?? 0) + 1;
      else next[key] = admin.firestore.Timestamp.now();
    } else next[key] = value;
  }
  documents.set(path, next);
}
function query(
  path: string,
  group = false,
  field?: string,
  value?: unknown,
  maximum = Number.POSITIVE_INFINITY
) {
  return {
    doc: (id?: string) => reference(`${path}/${id ?? `generated-${++sequence}`}`),
    where: (key: string, _operator: string, expected: unknown) =>
      query(path, group, key, expected, maximum),
    limit: (limit: number) => query(path, group, field, value, limit),
    get: async () => {
      const docs = [...documents.keys()]
        .filter((key) => {
          const parts = key.split("/");
          const matches = group ? parts.at(-2) === path : parts.slice(0, -1).join("/") === path;
          return matches && (!field || documents.get(key)?.[field] === value);
        })
        .slice(0, maximum)
        .map(snapshot);
      return { docs, empty: docs.length === 0 };
    },
  };
}
const db = {
  doc: reference,
  collection: (path: string) => query(path),
  collectionGroup: (path: string) => query(path, true),
  recursiveDelete: async (ref: { path: string }) => {
    deleted.push(ref.path);
    for (const key of documents.keys())
      if (key === ref.path || key.startsWith(`${ref.path}/`)) documents.delete(key);
  },
  runTransaction: async (callback: (transaction: unknown) => Promise<unknown>) => {
    const writes: (() => unknown)[] = [];
    const transaction = {
      get: async (ref: { get: () => Promise<unknown> }) => {
        if (writes.length) throw new Error("Firestore reads must precede writes");
        return ref.get();
      },
      set: (ref: { path: string }, data: Data, options?: { merge: boolean }) =>
        writes.push(() => set(ref.path, data, options?.merge)),
      create: (ref: { path: string }, data: Data) =>
        writes.push(() => {
          if (documents.has(ref.path)) throw new Error("Document already exists");
          set(ref.path, data);
        }),
      update: (ref: { path: string }, data: Data) => writes.push(() => set(ref.path, data, true)),
      delete: (ref: { path: string }) => writes.push(() => documents.delete(ref.path)),
    };
    const result = await callback(transaction);
    for (const write of writes) write();
    return result;
  },
};
function context(uid: string): functions.https.CallableContext {
  return { auth: { uid, token: {} }, rawRequest: {} } as functions.https.CallableContext;
}
async function onboard(uid: string) {
  return (await createHousehold.run({}, context(uid))).householdId;
}
async function invite(hid: string, uid: string) {
  return (await createInvitation.run({ householdId: hid }, context(uid))).token;
}
beforeEach(() => {
  documents.clear();
  deleted.length = 0;
  sequence = 0;
  (admin.firestore as unknown as jest.Mock).mockReturnValue(db);
});

test("onboarding is idempotent and records authority only on the server", async () => {
  const hid = await onboard("synthetic-owner");
  expect(await onboard("synthetic-owner")).toBe(hid);
  expect(documents.get(`household_authorizations/${hid}`)?.ownerUid).toBe("synthetic-owner");
  expect(documents.get(`households/${hid}/members/synthetic-owner`)?.role).toBe("admin");
});

test("legacy profile/creator fields cannot become authority or deletion targets", async () => {
  documents.set("users/synthetic-user", {
    activeHouseholdId: "synthetic-victim",
    membershipType: "owner",
  });
  documents.set("households/synthetic-victim", { createdBy: "synthetic-user" });
  await expect(onboard("synthetic-user")).rejects.toMatchObject({ code: "failed-precondition" });
  await expect(invite("synthetic-victim", "synthetic-user")).rejects.toMatchObject({
    code: "failed-precondition",
  });
  await deleteAccount.run({}, context("synthetic-user"));
  expect(deleted).toEqual(["users/synthetic-user"]);
  expect(documents.has("households/synthetic-victim")).toBe(true);
});

test("normal joining consumes invitation; replay and household ID-only joining are rejected", async () => {
  const hid = await onboard("synthetic-owner");
  await onboard("synthetic-member");
  const token = await invite(hid, "synthetic-owner");
  await expect(
    acceptInvitation.run({ token, displayName: "Synthetic member" }, context("synthetic-member"))
  ).resolves.toMatchObject({ householdId: hid });
  await expect(
    acceptInvitation.run({ token, displayName: "Synthetic member" }, context("synthetic-member"))
  ).rejects.toMatchObject({ code: "not-found" });
  await expect(
    acceptInvitation.run(
      { householdId: hid, displayName: "Synthetic member" },
      context("synthetic-member")
    )
  ).rejects.toMatchObject({ code: "invalid-argument" });
});

test("expiration, replaced invitation and non-owner issuance are rejected", async () => {
  const hid = await onboard("synthetic-owner");
  await onboard("synthetic-member");
  const old = await invite(hid, "synthetic-owner");
  const latest = await invite(hid, "synthetic-owner");
  await expect(
    acceptInvitation.run({ token: old, displayName: "Member" }, context("synthetic-member"))
  ).rejects.toMatchObject({ code: "not-found" });
  for (const [path, data] of documents)
    if (path.startsWith("household_invitations/"))
      data.expiresAt = admin.firestore.Timestamp.fromMillis(1);
  await expect(
    acceptInvitation.run({ token: latest, displayName: "Member" }, context("synthetic-member"))
  ).rejects.toMatchObject({ code: "not-found" });
  await expect(invite(hid, "synthetic-member")).rejects.toMatchObject({
    code: "permission-denied",
  });
});

test("member removal requires owner, restores original household and revokes old invitations", async () => {
  const hid = await onboard("synthetic-owner");
  const original = await onboard("synthetic-member");
  const token = await invite(hid, "synthetic-owner");
  await acceptInvitation.run({ token, displayName: "Member" }, context("synthetic-member"));
  const old = await invite(hid, "synthetic-owner");
  await expect(
    removeMember.run(
      { householdId: hid, memberUid: "synthetic-owner" },
      context("synthetic-member")
    )
  ).rejects.toMatchObject({ code: "permission-denied" });
  await removeMember.run(
    { householdId: hid, memberUid: "synthetic-member" },
    context("synthetic-owner")
  );
  expect(documents.get("user_authorizations/synthetic-member")?.activeHouseholdId).toBe(original);
  await expect(
    acceptInvitation.run({ token: old, displayName: "Member" }, context("synthetic-member"))
  ).rejects.toMatchObject({ code: "not-found" });
  const approved = await invite(hid, "synthetic-owner");
  await expect(
    acceptInvitation.run({ token: approved, displayName: "Member" }, context("synthetic-member"))
  ).resolves.toMatchObject({ success: true });
});

test("owner withdrawal deletes only verified owned households and restores other members", async () => {
  const hid = await onboard("synthetic-owner");
  const original = await onboard("synthetic-member");
  await acceptInvitation.run(
    { token: await invite(hid, "synthetic-owner"), displayName: "Member" },
    context("synthetic-member")
  );
  documents.set("users/synthetic-owner", { activeHouseholdId: original, membershipType: "owner" });
  documents.set("users/synthetic-owner/fcm_tokens/synthetic-device", {
    token: "synthetic-placeholder",
  });
  await deleteAccount.run({}, context("synthetic-owner"));
  expect(deleted).toEqual([`households/${hid}`, "users/synthetic-owner"]);
  expect(documents.get("user_authorizations/synthetic-member")?.activeHouseholdId).toBe(original);
  expect(documents.has(`households/${original}`)).toBe(true);
  expect(documents.has("users/synthetic-owner/fcm_tokens/synthetic-device")).toBe(false);
  await expect(onboard("synthetic-owner")).rejects.toMatchObject({ code: "failed-precondition" });
  await expect(deleteAccount.run({}, context("synthetic-owner"))).resolves.toMatchObject({
    success: true,
  });
});

test("member withdrawal preserves the shared household and removes own memberships", async () => {
  const hid = await onboard("synthetic-owner");
  const original = await onboard("synthetic-member");
  await acceptInvitation.run(
    { token: await invite(hid, "synthetic-owner"), displayName: "Member" },
    context("synthetic-member")
  );
  await deleteAccount.run({}, context("synthetic-member"));
  expect(deleted).toEqual([`households/${original}`, "users/synthetic-member"]);
  expect(documents.has(`households/${hid}`)).toBe(true);
  expect(documents.has(`households/${hid}/members/synthetic-member`)).toBe(false);
});

test("authentication is required by every authorization callable", async () => {
  const unauthenticated = { rawRequest: {} } as functions.https.CallableContext;
  for (const callable of [
    createHousehold,
    createInvitation,
    acceptInvitation,
    removeMember,
    deleteAccount,
  ]) {
    await expect(callable.run({}, unauthenticated)).rejects.toMatchObject({
      code: "unauthenticated",
    });
  }
});

test("parked original household invitations stay revoked after owner restoration", async () => {
  const hid = await onboard("synthetic-host");
  const original = await onboard("synthetic-owner");
  await onboard("synthetic-third");
  const old = await invite(original, "synthetic-owner");
  await acceptInvitation.run(
    { token: await invite(hid, "synthetic-host"), displayName: "Owner" },
    context("synthetic-owner")
  );
  expect(documents.get(`household_authorizations/${original}`)?.invitationGeneration).toBe(2);
  await expect(
    acceptInvitation.run({ token: old, displayName: "Third" }, context("synthetic-third"))
  ).rejects.toMatchObject({ code: "not-found" });
  await removeMember.run(
    { householdId: hid, memberUid: "synthetic-owner" },
    context("synthetic-host")
  );
  await expect(
    acceptInvitation.run({ token: old, displayName: "Third" }, context("synthetic-third"))
  ).rejects.toMatchObject({ code: "not-found" });
});

test("shared owners cannot move and client creator/role changes never grant ownership", async () => {
  const hid = await onboard("synthetic-owner");
  const other = await onboard("synthetic-other");
  await onboard("synthetic-member");
  await acceptInvitation.run(
    { token: await invite(hid, "synthetic-owner"), displayName: "Member" },
    context("synthetic-member")
  );
  await expect(
    acceptInvitation.run(
      { token: await invite(other, "synthetic-other"), displayName: "Owner" },
      context("synthetic-owner")
    )
  ).rejects.toMatchObject({ code: "failed-precondition" });
  documents.set(`households/${hid}`, { createdBy: "synthetic-member" });
  documents.set("users/synthetic-member", { activeHouseholdId: hid, membershipType: "owner" });
  await expect(invite(hid, "synthetic-member")).rejects.toMatchObject({
    code: "permission-denied",
  });
  await expect(
    removeMember.run(
      { householdId: hid, memberUid: "synthetic-owner" },
      context("synthetic-member")
    )
  ).rejects.toMatchObject({ code: "permission-denied" });
});

test("notification registration works normally but cannot recreate a withdrawn user's tokens", async () => {
  await onboard("synthetic-user");
  const input = {
    token: "synthetic-placeholder",
    deviceId: "synthetic-device",
    platform: "ios" as const,
  };
  await expect(registerFcmToken.run(input, context("synthetic-user"))).resolves.toMatchObject({
    success: true,
  });
  await deleteAccount.run({}, context("synthetic-user"));
  await expect(registerFcmToken.run(input, context("synthetic-user"))).rejects.toMatchObject({
    code: "failed-precondition",
  });
  expect(documents.has("users/synthetic-user/fcm_tokens/synthetic-device")).toBe(false);
});

test("interrupted deletion stays locked and retries the verified target", async () => {
  const hid = await onboard("synthetic-owner");
  const recursive = jest
    .spyOn(db, "recursiveDelete")
    .mockRejectedValueOnce(new Error("Synthetic interruption"));
  await expect(deleteAccount.run({}, context("synthetic-owner"))).rejects.toThrow(
    "Synthetic interruption"
  );
  expect(documents.get("user_authorizations/synthetic-owner")?.state).toBe("deleting");
  expect(documents.get(`household_authorizations/${hid}`)?.state).toBe("deleting");
  await expect(invite(hid, "synthetic-owner")).rejects.toMatchObject({
    code: "failed-precondition",
  });
  await expect(deleteAccount.run({}, context("synthetic-owner"))).resolves.toMatchObject({
    success: true,
  });
  expect(documents.has(`households/${hid}`)).toBe(false);
  recursive.mockRestore();
});

test("member removal never restores a profile already marked for withdrawal", async () => {
  const hid = await onboard("synthetic-owner");
  await onboard("synthetic-member");
  await acceptInvitation.run(
    { token: await invite(hid, "synthetic-owner"), displayName: "Member" },
    context("synthetic-member")
  );
  const account = documents.get("user_authorizations/synthetic-member");
  if (!account) throw new Error("Missing synthetic account");
  account.state = "deleting";
  documents.delete("users/synthetic-member");
  await removeMember.run(
    { householdId: hid, memberUid: "synthetic-member" },
    context("synthetic-owner")
  );
  expect(documents.has("users/synthetic-member")).toBe(false);
  expect(account.state).toBe("deleting");
});

import { requireActive, requireAuth, requireOwner } from "../households/authorization";

describe("canonical authorization guards", () => {
  test("requires authenticated caller identity", () => {
    expect(() => requireAuth({})).toThrow();
    expect(requireAuth({ auth: { uid: "synthetic-user" } })).toBe("synthetic-user");
  });

  test("only verified active owner grants authority", () => {
    expect(() =>
      requireOwner({ state: "active", ownerUid: "synthetic-user" }, "synthetic-user")
    ).not.toThrow();
    expect(() =>
      requireOwner({ state: "active", ownerUid: "synthetic-other" }, "synthetic-user")
    ).toThrow();
    expect(() =>
      requireOwner(
        { state: "active", createdBy: "synthetic-user", membershipType: "owner" },
        "synthetic-user"
      )
    ).toThrow();
  });

  test.each([undefined, {}, { state: "deleting" }])(
    "unverified and deleting records fail closed %#",
    (data) => {
      expect(() => requireActive(data)).toThrow();
    }
  );
});

import { tokenHash } from "./createInvitation";

describe("invitation token validation", () => {
  test("hashes a valid 256-bit invitation token without exposing it", () => {
    const token = Buffer.alloc(32).toString("base64url");
    expect(tokenHash(token)).toMatch(/^[a-f0-9]{64}$/);
    expect(tokenHash(token)).toBe(tokenHash(token));
  });

  test.each([undefined, null, 1, "", "synthetic-household", "a/b", "A".repeat(44)])(
    "rejects malformed token input %#",
    (token) => {
      expect(() => tokenHash(token)).toThrow();
    }
  );
});

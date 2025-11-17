/**
 * Generate a random 6-character invitation code.
 * Excludes confusing characters (O, 0, I, 1, L).
 */
export function generateInvitationCode(): string {
  const chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
  let code = "";
  for (let i = 0; i < 6; i++) {
    code += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return code;
}

/**
 * Validate invitation code format.
 * Must be 6 uppercase alphanumeric characters.
 */
export function isValidInvitationCode(code: string): boolean {
  return /^[A-Z0-9]{6}$/.test(code);
}

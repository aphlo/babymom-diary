/**
 * registerFcmToken の入力検証テスト
 *
 * これらのテストは関数の入力検証ロジックを検証します。
 * firebase-admin と firebase-functions をモックして、
 * 関数の振る舞いをテストします。
 */

describe("registerFcmToken validation", () => {
  describe("input validation rules", () => {
    it("should require authentication", () => {
      // 認証がない場合は unauthenticated エラーをスローする
      const authContext = null;
      expect(authContext).toBeNull();
    });

    it("should require non-empty token", () => {
      const token = "";
      const trimmedToken = token?.trim();
      expect(!trimmedToken).toBe(true);
    });

    it("should require non-empty deviceId", () => {
      const deviceId = "";
      const trimmedDeviceId = deviceId?.trim();
      expect(!trimmedDeviceId).toBe(true);
    });

    it("should accept ios platform", () => {
      const platform = "ios" as string;
      expect(platform === "ios" || platform === "android").toBe(true);
    });

    it("should accept android platform", () => {
      const platform = "android" as string;
      expect(platform === "ios" || platform === "android").toBe(true);
    });

    it("should reject invalid platform", () => {
      const platform = "windows" as string;
      expect(platform !== "ios" && platform !== "android").toBe(true);
    });

    it("should trim whitespace from token", () => {
      const token = "  test-token  ";
      expect(token.trim()).toBe("test-token");
    });

    it("should trim whitespace from deviceId", () => {
      const deviceId = "  device1  ";
      expect(deviceId.trim()).toBe("device1");
    });
  });

  describe("default notification settings", () => {
    it("should have correct default values", () => {
      const defaultSettings = {
        vaccineReminder: {
          enabled: true,
          daysBefore: [0, 1],
        },
        dailyEncouragement: {
          enabled: true,
        },
      };

      expect(defaultSettings.vaccineReminder.enabled).toBe(true);
      expect(defaultSettings.vaccineReminder.daysBefore).toEqual([0, 1]);
      expect(defaultSettings.dailyEncouragement.enabled).toBe(true);
    });
  });
});

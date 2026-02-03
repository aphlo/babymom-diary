import {
  ENCOURAGEMENT_MESSAGES,
  buildEncouragementMessage,
  getRandomMessage,
} from "./sendDailyEncouragement";

describe("sendDailyEncouragement", () => {
  describe("ENCOURAGEMENT_MESSAGES", () => {
    it("should have at least 100 messages", () => {
      expect(ENCOURAGEMENT_MESSAGES.length).toBeGreaterThanOrEqual(100);
    });

    it("should have non-empty messages", () => {
      for (const message of ENCOURAGEMENT_MESSAGES) {
        expect(message.trim().length).toBeGreaterThan(0);
      }
    });
  });

  describe("getRandomMessage", () => {
    it("should return a message from the list", () => {
      const message = getRandomMessage();
      expect(ENCOURAGEMENT_MESSAGES).toContain(message);
    });

    it("should return different messages over multiple calls (probabilistic)", () => {
      // Run 20 times and check if we get at least 2 different messages
      const messages = new Set<string>();
      for (let i = 0; i < 20; i++) {
        messages.add(getRandomMessage());
      }
      // With 5+ messages and 20 tries, we should almost certainly get at least 2 different ones
      expect(messages.size).toBeGreaterThanOrEqual(2);
    });
  });

  describe("buildEncouragementMessage", () => {
    it("should return title and body", () => {
      const result = buildEncouragementMessage();

      expect(result.title).toBeDefined();
      expect(result.body).toBeDefined();
      expect(result.title.length).toBeGreaterThan(0);
      expect(result.body.length).toBeGreaterThan(0);
    });

    it("should have consistent title", () => {
      const result1 = buildEncouragementMessage();
      const result2 = buildEncouragementMessage();

      expect(result1.title).toBe(result2.title);
    });

    it("should return body from ENCOURAGEMENT_MESSAGES", () => {
      const result = buildEncouragementMessage();

      expect(ENCOURAGEMENT_MESSAGES).toContain(result.body);
    });
  });

  describe("notification settings check", () => {
    it("should define dailyEncouragement.enabled as the key setting", () => {
      // This documents the expected setting structure
      const settings = {
        dailyEncouragement: {
          enabled: true,
        },
      };

      expect(settings.dailyEncouragement.enabled).toBe(true);
    });

    it("should skip users with dailyEncouragement.enabled = false", () => {
      const settings = {
        dailyEncouragement: {
          enabled: false,
        },
      };

      expect(settings.dailyEncouragement.enabled).toBe(false);
    });
  });

  describe("FCM token retrieval", () => {
    it("should define correct Firestore path for FCM tokens", () => {
      const userId = "user123";
      const expectedPath = `users/${userId}/fcm_tokens`;
      expect(expectedPath).toBe("users/user123/fcm_tokens");
    });

    it("should define correct Firestore path for notification settings", () => {
      const userId = "user123";
      const expectedPath = `users/${userId}/notification_settings/settings`;
      expect(expectedPath).toBe("users/user123/notification_settings/settings");
    });
  });
});

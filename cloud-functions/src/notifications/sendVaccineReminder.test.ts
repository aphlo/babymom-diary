import {
  buildNotificationMessage,
  getJSTDates,
  groupByHousehold,
  isSameDay,
} from "./sendVaccineReminder";

describe("sendVaccineReminder", () => {
  describe("getJSTDates", () => {
    it("should return today and tomorrow as Date objects", () => {
      const { today, tomorrow } = getJSTDates();

      expect(today).toBeInstanceOf(Date);
      expect(tomorrow).toBeInstanceOf(Date);
    });

    it("should return tomorrow as one day after today", () => {
      const { today, tomorrow } = getJSTDates();

      const oneDayMs = 24 * 60 * 60 * 1000;
      expect(tomorrow.getTime() - today.getTime()).toBe(oneDayMs);
    });
  });

  describe("isSameDay (JST-based comparison)", () => {
    it("should return true for same JST day", () => {
      // Both are JST Jan 15 (different times)
      const date1 = new Date("2024-01-15T01:00:00Z"); // JST 10:00
      const date2 = new Date("2024-01-15T14:00:00Z"); // JST 23:00

      expect(isSameDay(date1, date2)).toBe(true);
    });

    it("should return true for same JST day across UTC date boundary", () => {
      // UTC Jan 14 15:00 = JST Jan 15 00:00
      // UTC Jan 15 01:00 = JST Jan 15 10:00
      // Both are JST Jan 15, but UTC dates differ (14 vs 15)
      const date1 = new Date("2024-01-14T15:00:00Z"); // JST Jan 15 00:00
      const date2 = new Date("2024-01-15T01:00:00Z"); // JST Jan 15 10:00

      expect(isSameDay(date1, date2)).toBe(true);
    });

    it("should return false for different JST days", () => {
      // JST Jan 15 vs JST Jan 16
      const date1 = new Date("2024-01-15T01:00:00Z"); // JST Jan 15 10:00
      const date2 = new Date("2024-01-16T01:00:00Z"); // JST Jan 16 10:00

      expect(isSameDay(date1, date2)).toBe(false);
    });

    it("should return false for different JST days at UTC date boundary", () => {
      // UTC Jan 15 14:00 = JST Jan 15 23:00
      // UTC Jan 15 15:00 = JST Jan 16 00:00
      // Same UTC date (15), but different JST dates (15 vs 16)
      const date1 = new Date("2024-01-15T14:00:00Z"); // JST Jan 15 23:00
      const date2 = new Date("2024-01-15T15:00:00Z"); // JST Jan 16 00:00

      expect(isSameDay(date1, date2)).toBe(false);
    });

    it("should return false for different months", () => {
      const date1 = new Date("2024-01-15T01:00:00Z");
      const date2 = new Date("2024-02-15T01:00:00Z");

      expect(isSameDay(date1, date2)).toBe(false);
    });

    it("should return false for different years", () => {
      const date1 = new Date("2024-01-15T01:00:00Z");
      const date2 = new Date("2025-01-15T01:00:00Z");

      expect(isSameDay(date1, date2)).toBe(false);
    });
  });

  describe("groupByHousehold", () => {
    it("should group reservations by household ID", () => {
      const reservations = [
        { householdId: "h1", childId: "c1", isToday: true, isTomorrow: false },
        { householdId: "h2", childId: "c2", isToday: false, isTomorrow: true },
        { householdId: "h1", childId: "c3", isToday: false, isTomorrow: true },
      ];

      const grouped = groupByHousehold(reservations);

      expect(grouped.size).toBe(2);
      expect(grouped.get("h1")).toEqual({ isToday: true, isTomorrow: true });
      expect(grouped.get("h2")).toEqual({ isToday: false, isTomorrow: true });
    });

    it("should merge isToday and isTomorrow flags for same household", () => {
      const reservations = [
        { householdId: "h1", childId: "c1", isToday: true, isTomorrow: false },
        { householdId: "h1", childId: "c2", isToday: false, isTomorrow: true },
      ];

      const grouped = groupByHousehold(reservations);

      expect(grouped.size).toBe(1);
      expect(grouped.get("h1")).toEqual({ isToday: true, isTomorrow: true });
    });

    it("should handle empty array", () => {
      const grouped = groupByHousehold([]);

      expect(grouped.size).toBe(0);
    });

    it("should handle single reservation", () => {
      const reservations = [{ householdId: "h1", childId: "c1", isToday: true, isTomorrow: false }];

      const grouped = groupByHousehold(reservations);

      expect(grouped.size).toBe(1);
      expect(grouped.get("h1")).toEqual({ isToday: true, isTomorrow: false });
    });
  });

  describe("buildNotificationMessage", () => {
    it("should return today message when isToday is true", () => {
      const result = buildNotificationMessage({ isToday: true, isTomorrow: false });

      expect(result.title).toBe("予防接種のお知らせ");
      expect(result.body).toBe("本日、予防接種の予約があります。");
    });

    it("should return tomorrow message when isTomorrow is true", () => {
      const result = buildNotificationMessage({ isToday: false, isTomorrow: true });

      expect(result.title).toBe("予防接種のお知らせ");
      expect(result.body).toBe("明日、予防接種の予約があります。");
    });

    it("should return combined message when both isToday and isTomorrow are true", () => {
      const result = buildNotificationMessage({ isToday: true, isTomorrow: true });

      expect(result.title).toBe("予防接種のお知らせ");
      expect(result.body).toBe("本日と明日、予防接種の予約があります。");
    });

    it("should return tomorrow message when neither is true (edge case)", () => {
      // This is an edge case that shouldn't happen in practice
      const result = buildNotificationMessage({ isToday: false, isTomorrow: false });

      expect(result.title).toBe("予防接種のお知らせ");
      expect(result.body).toBe("明日、予防接種の予約があります。");
    });
  });
});

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

  describe("isSameDay", () => {
    it("should return true for same day", () => {
      const date1 = new Date("2024-01-15T10:00:00Z");
      const date2 = new Date("2024-01-15T23:59:59Z");

      expect(isSameDay(date1, date2)).toBe(true);
    });

    it("should return false for different days", () => {
      const date1 = new Date("2024-01-15T10:00:00Z");
      const date2 = new Date("2024-01-16T10:00:00Z");

      expect(isSameDay(date1, date2)).toBe(false);
    });

    it("should return false for different months", () => {
      const date1 = new Date("2024-01-15T10:00:00Z");
      const date2 = new Date("2024-02-15T10:00:00Z");

      expect(isSameDay(date1, date2)).toBe(false);
    });

    it("should return false for different years", () => {
      const date1 = new Date("2024-01-15T10:00:00Z");
      const date2 = new Date("2025-01-15T10:00:00Z");

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

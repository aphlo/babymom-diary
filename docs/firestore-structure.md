# Firestore Collection Structure

本ドキュメントは現在の Firestore コレクション構造をコードベースから逆算してまとめたものです。構造変更時は本ファイルも更新してください。

## Top-level
- `users/{uid}`
  - Fields: `activeHouseholdId`, `membershipType`, timestamps など
- `households/{householdId}`
  - Fields: `createdBy`, `createdAt`, `vaccineVisibilitySettings?`

## households/{householdId} 配下
- `members/{uid}`
  - Fields: `uid`, `displayName`, `role`, `joinedAt`
- `children/{childId}`
  - Fields: `name`, `gender`, `birthday`, `dueDate?`, timestamps
  - Subcollections:
    - `vaccination_records/{vaccineId}`
      - ワクチン接種記録 (dose map, status, scheduled/completed dates など)
    - `reservation_groups/{groupId}`
      - 複数ワクチン同時予約のグループ
    - `vaccination_schedules/{vaccineId_dose}`
      - スケジュール参照用ドキュメント
    - `childRecords/{yyyy-MM-dd}`
      - 1日分の記録を時間帯マップで保持 (type ごとの records map)
    - `growthRecords/{recordId}`
      - 身長・体重などの計測記録
- `events/{yyyy-MM-dd}`
  - Fields: `events` マップ (key: event UUID, value: `title`, `memo`, `allDay`, `startAt`, `endAt`, `iconKey`, timestamps)
- `momDiary/{yyyy-MM-dd}`
  - Fields: `date`, `content`, `updatedAt`
- `momRecords/{yyyy-MM-dd}`
  - Fields: `temperatureCelsius`, `lochia.*`, `breast.*`, `memo`, `updatedAt`
- `settings/{...}`
  - 各種設定 (例: vaccine visibility 用に利用)

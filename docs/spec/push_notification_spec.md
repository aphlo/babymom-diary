# プッシュ通知機能 設計書

## 1. 概要

miluアプリにプッシュ通知機能を実装し、以下の2種類の通知を配信する。

| 通知種別 | 配信時刻 | 目的 |
|---------|---------|------|
| 予防接種リマインダー | 毎日 10:00 | 予約日の前日・当日に接種を忘れないよう通知 |
| 応援メッセージ | 毎日 20:00 | 育児家庭を励ますランダムメッセージ |

---

## 2. 機能要件

### 2.1 予防接種リマインダー通知

**配信条件：**
- 毎日 10:00 JST に配信判定を実行
- `reservation_groups` の `scheduledDate` が**当日**または**翌日**の予約を持つ世帯に送信
- 予約ステータスが `scheduled`（未完了）のもののみ対象

**通知内容：**
- タイトル: 「予防接種のお知らせ」
- 本文（当日）: 「本日、予防接種の予約があります。お忘れなく！」
- 本文（前日）: 「明日、予防接種の予約があります。準備をお願いします。」
- 複数予約がある場合もワクチン名は明言しない（要件通り）

**対象ユーザー：**
- 該当する子供が所属する世帯の全メンバー（FCMトークン登録済み）

### 2.2 応援メッセージ通知

**配信条件：**
- 毎日 20:00 JST に配信
- 通知設定で有効にしている全ユーザーに送信

**通知内容：**
- タイトル: 「miluからのメッセージ」
- 本文: 100種類以上の励ましメッセージからランダム選択

**メッセージ例：**
- 「今日も一日、育児おつかれさまでした」
- 「あなたの頑張りを、お子さんはちゃんと見ていますよ」
- 「完璧じゃなくていい。十分がんばっています」

---

## 3. システム構成

### 3.1 アーキテクチャ概要

```
┌─────────────────────────────────────────────────────────────────┐
│                         Flutter App                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │ FCM Token       │  │ Notification    │  │ Notification    │ │
│  │ Registration    │  │ Handler         │  │ Settings UI     │ │
│  └────────┬────────┘  └────────┬────────┘  └────────┬────────┘ │
└───────────┼────────────────────┼────────────────────┼───────────┘
            │                    │                    │
            ▼                    ▼                    ▼
┌─────────────────────────────────────────────────────────────────┐
│                         Firestore                               │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │ users/{uid}     │  │ households/     │  │ notification_   │ │
│  │  .fcmTokens[]   │  │  .children/     │  │ settings/{uid}  │ │
│  │                 │  │  .reservation_  │  │  .vaccineRemind │ │
│  │                 │  │    groups/      │  │  .dailyMessage  │ │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
            │                    │                    │
            ▼                    ▼                    ▼
┌─────────────────────────────────────────────────────────────────┐
│                      Cloud Functions                            │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │ Scheduled:      │  │ Scheduled:      │  │ HTTPS Callable: │ │
│  │ sendVaccine     │  │ sendDaily       │  │ registerFcm     │ │
│  │ Reminder        │  │ Encouragement   │  │ Token           │ │
│  │ (10:00 JST)     │  │ (20:00 JST)     │  │                 │ │
│  └────────┬────────┘  └────────┬────────┘  └────────┬────────┘ │
└───────────┼────────────────────┼────────────────────┼───────────┘
            │                    │                    │
            ▼                    ▼                    ▼
┌─────────────────────────────────────────────────────────────────┐
│                  Firebase Cloud Messaging (FCM)                 │
└─────────────────────────────────────────────────────────────────┘
```

### 3.2 Cloud Functions 構成

| 関数名 | 種別 | トリガー | 説明 |
|--------|------|----------|------|
| `sendVaccineReminder` | Scheduled | 毎日 10:00 JST | 予防接種リマインダー送信 |
| `sendDailyEncouragement` | Scheduled | 毎日 20:00 JST | 応援メッセージ送信 |
| `registerFcmToken` | HTTPS Callable | アプリから呼出 | FCMトークン登録・更新 |
| `unregisterFcmToken` | HTTPS Callable | アプリから呼出 | FCMトークン削除（ログアウト時） |

---

## 4. データ設計

### 4.1 Firestore スキーマ追加

#### users/{uid} への追加フィールド

```typescript
interface User {
  // 既存フィールド
  activeHouseholdId: string;
  membershipType: 'owner' | 'member';
  createdAt: Timestamp;
  updatedAt: Timestamp;

  // 追加フィールド
  fcmTokens: FcmTokenInfo[];  // 複数デバイス対応
}

interface FcmTokenInfo {
  token: string;           // FCMトークン
  deviceId: string;        // デバイス識別子
  platform: 'ios' | 'android';
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

#### notification_settings/{uid} コレクション（新規）

```typescript
// パス: notification_settings/{uid}
interface NotificationSettings {
  uid: string;

  // 予防接種リマインダー設定
  vaccineReminder: {
    enabled: boolean;        // 有効/無効
    daysBefore: number[];    // [0, 1] = 当日と前日（将来拡張用）
  };

  // 応援メッセージ設定
  dailyEncouragement: {
    enabled: boolean;        // 有効/無効
  };

  // 共通設定
  quietHoursEnabled: boolean;  // おやすみモード（将来拡張用）
  quietHoursStart: string;     // "22:00"
  quietHoursEnd: string;       // "07:00"

  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

**デフォルト値：**
- `vaccineReminder.enabled`: `true`
- `vaccineReminder.daysBefore`: `[0, 1]`
- `dailyEncouragement.enabled`: `true`
- `quietHoursEnabled`: `false`

### 4.2 Firestore Security Rules 追加

```javascript
// notification_settings コレクション
match /notification_settings/{uid} {
  allow read, write: if authed() && request.auth.uid == uid;
}
```

### 4.3 Firestore Indexes 追加

予防接種リマインダーのクエリ最適化のため、以下のインデックスを追加：

```json
{
  "collectionGroup": "reservation_groups",
  "queryScope": "COLLECTION_GROUP",
  "fields": [
    { "fieldPath": "status", "order": "ASCENDING" },
    { "fieldPath": "scheduledDate", "order": "ASCENDING" }
  ]
}
```

---

## 5. Cloud Functions 詳細設計

### 5.1 sendVaccineReminder

**ファイル:** `cloud-functions/src/notifications/sendVaccineReminder.ts`

```typescript
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

// Cloud Scheduler: 毎日 10:00 JST (01:00 UTC)
export const sendVaccineReminder = functions
  .region('asia-northeast1')
  .pubsub
  .schedule('0 1 * * *')  // UTC時刻
  .timeZone('Asia/Tokyo')
  .onRun(async (context) => {
    const db = admin.firestore();
    const messaging = admin.messaging();

    const today = getTodayJST();
    const tomorrow = addDays(today, 1);

    // 1. 当日・翌日の予約を持つreservation_groupsを取得
    const reservations = await getUpcomingReservations(db, today, tomorrow);

    // 2. 世帯ごとにグループ化
    const householdReservations = groupByHousehold(reservations);

    // 3. 各世帯のメンバーに通知送信
    for (const [householdId, reservationInfo] of householdReservations) {
      const tokens = await getHouseholdFcmTokens(db, householdId);
      const enabledTokens = await filterByNotificationSettings(db, tokens, 'vaccineReminder');

      if (enabledTokens.length === 0) continue;

      const message = buildVaccineReminderMessage(reservationInfo);
      await sendMulticastNotification(messaging, enabledTokens, message);
    }
  });
```

**処理フロー：**

```
1. JST基準で当日・翌日の日付を計算
   ↓
2. Collection Group Queryで対象reservation_groupsを取得
   - status == 'scheduled'
   - scheduledDate == today OR scheduledDate == tomorrow
   ↓
3. 世帯ID単位でグループ化
   ↓
4. 各世帯について:
   a. 世帯メンバーのUID一覧を取得
   b. 各UIDのFCMトークンを取得
   c. 通知設定でvaccineReminder.enabled == trueのユーザーをフィルタ
   d. FCM multicast送信
   ↓
5. 送信結果をログ出力（Cloud Logging）
```

### 5.2 sendDailyEncouragement

**ファイル:** `cloud-functions/src/notifications/sendDailyEncouragement.ts`

```typescript
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { encouragementMessages } from './messages/encouragementMessages';

// Cloud Scheduler: 毎日 20:00 JST (11:00 UTC)
export const sendDailyEncouragement = functions
  .region('asia-northeast1')
  .pubsub
  .schedule('0 11 * * *')  // UTC時刻
  .timeZone('Asia/Tokyo')
  .onRun(async (context) => {
    const db = admin.firestore();
    const messaging = admin.messaging();

    // 1. 応援メッセージを有効にしているユーザーを取得
    const enabledSettings = await db.collection('notification_settings')
      .where('dailyEncouragement.enabled', '==', true)
      .get();

    // 2. ユーザーごとのFCMトークンを取得
    const userTokens = await getUserFcmTokens(db, enabledSettings);

    // 3. ランダムメッセージを選択（全ユーザー共通）
    const message = selectRandomMessage(encouragementMessages);

    // 4. バッチ送信（500トークンずつ）
    await sendBatchNotifications(messaging, userTokens, {
      title: 'miluからのメッセージ',
      body: message,
    });
  });

function selectRandomMessage(messages: string[]): string {
  const index = Math.floor(Math.random() * messages.length);
  return messages[index];
}
```

### 5.3 registerFcmToken

**ファイル:** `cloud-functions/src/notifications/registerFcmToken.ts`

```typescript
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

interface RegisterFcmTokenData {
  token: string;
  deviceId: string;
  platform: 'ios' | 'android';
}

export const registerFcmToken = functions
  .region('asia-northeast1')
  .https
  .onCall(async (data: RegisterFcmTokenData, context) => {
    // 認証チェック
    if (!context.auth) {
      throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
    }

    const uid = context.auth.uid;
    const { token, deviceId, platform } = data;

    const db = admin.firestore();
    const userRef = db.collection('users').doc(uid);

    await db.runTransaction(async (transaction) => {
      const userDoc = await transaction.get(userRef);
      const userData = userDoc.data();

      let fcmTokens: FcmTokenInfo[] = userData?.fcmTokens || [];

      // 既存のデバイスIDがあれば更新、なければ追加
      const existingIndex = fcmTokens.findIndex(t => t.deviceId === deviceId);
      const tokenInfo: FcmTokenInfo = {
        token,
        deviceId,
        platform,
        createdAt: existingIndex >= 0 ? fcmTokens[existingIndex].createdAt : admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      };

      if (existingIndex >= 0) {
        fcmTokens[existingIndex] = tokenInfo;
      } else {
        fcmTokens.push(tokenInfo);
      }

      transaction.update(userRef, { fcmTokens, updatedAt: admin.firestore.FieldValue.serverTimestamp() });
    });

    // 通知設定が存在しない場合はデフォルト値で作成
    await ensureNotificationSettings(db, uid);

    return { success: true };
  });
```

### 5.4 応援メッセージ一覧

**ファイル:** `cloud-functions/src/notifications/messages/encouragementMessages.ts`

100種類以上のメッセージを定義：

```typescript
export const encouragementMessages: string[] = [
  // 日々の頑張りを認める系（20個）
  "今日も一日、育児おつかれさまでした",
  "あなたの頑張りを、お子さんはちゃんと見ていますよ",
  "完璧じゃなくていい。十分がんばっています",
  "今日できたこと、一つでもあれば大成功です",
  "毎日の小さな積み重ねが、大きな愛になります",
  "疲れた時は休んでいいんですよ",
  "今日も子どもと過ごせた、それだけで素敵な一日です",
  "あなたのペースで大丈夫",
  "子どもの笑顔は、あなたの愛情の証です",
  "今日も無事に一日を終えられました。えらい！",
  "思い通りにいかない日も、あなたは頑張っています",
  "子どもにとって、あなたは世界一の存在です",
  "今日の自分に「おつかれさま」って言ってあげてください",
  "失敗しても大丈夫。明日があります",
  "あなたの存在そのものが、子どもの安心です",
  "今日も子どもを守り、愛した一日でした",
  "少し休憩して、自分を労ってあげてください",
  "子育ては誰にとっても大変。あなたは十分やっています",
  "今日のあなたの頑張りを、誰かがちゃんと見ています",
  "自分を褒めることも、大切な育児の一部です",

  // 子どもの成長を喜ぶ系（20個）
  "子どもの成長、一瞬一瞬を楽しんでくださいね",
  "今日も子どもは少しだけ大きくなりました",
  "この瞬間は今だけ。たくさん思い出を作ってください",
  "子どもの「初めて」を見届けられる幸せ",
  "今日の子どもの表情、覚えていてあげてください",
  "子どもの成長は、あなたの愛情のおかげです",
  "大変な日々も、いつか宝物の思い出になります",
  "子どもと過ごす今日という日は、二度と来ない特別な日",
  "成長の早さに驚く日々、大切にしてくださいね",
  "子どもの小さな変化に気づけるあなたは素敵です",
  "今しかないこの時間を、楽しんでください",
  "子どもはあなたと一緒に、毎日成長しています",
  "今日の子どもの姿、写真に残してみては？",
  "子どもの成長を見守れることは、特別なギフトです",
  "大きくなった時、今日の日を懐かしく思うでしょう",
  "子どもの成長は早いから、今を大切に",
  "今日も子どもと一緒に、あなたも成長しています",
  "子どもの小さな手、今だけの宝物です",
  "一緒に過ごす時間、それ自体が最高のプレゼント",
  "子どもはあなたに会えて、とても幸せです",

  // 自分を大切にする系（20個）
  "たまには自分の時間も大切にしてくださいね",
  "自分を大切にすることは、わがままじゃありません",
  "好きな飲み物でも飲んで、ほっと一息つきましょう",
  "今夜は早めに休んでくださいね",
  "あなたの健康も、子どもにとって大切なものです",
  "リフレッシュする時間を作ってもいいんですよ",
  "頑張りすぎていませんか？少し休憩しましょう",
  "自分へのご褒美、忘れずに",
  "深呼吸して、肩の力を抜いてみてください",
  "完璧を目指さなくていい。あなたは十分素敵です",
  "自分の気持ちも大切にしてあげてください",
  "疲れたら声に出していいんですよ",
  "「助けて」って言えることは、強さです",
  "一人で抱え込まないでくださいね",
  "今日できなかったことは、明日でいいんです",
  "自分に優しくすることを忘れないで",
  "ゆっくりお風呂に浸かる時間、作れますように",
  "好きな音楽を聴いて、リラックスしてください",
  "美味しいものを食べて、元気をチャージ",
  "睡眠は大事。眠れる時に眠ってくださいね",

  // 応援・励まし系（20個）
  "あなたは一人じゃありません",
  "大丈夫、きっとうまくいきます",
  "辛い時期は永遠には続きません",
  "あなたの愛情は、ちゃんと届いています",
  "今日も明日も、応援しています",
  "小さな幸せを見つけられますように",
  "あなたの笑顔が、子どもの幸せです",
  "一歩一歩、前に進んでいますよ",
  "比べなくていい。あなたはあなたのままで",
  "うまくいかない日があっても、大丈夫",
  "あなたのことを応援している人がいます",
  "今日の疲れが、明日への力になりますように",
  "子どもと一緒に、幸せな夢を見てください",
  "明日もいい日になりますように",
  "あなたの頑張りは、必ず実を結びます",
  "今夜はゆっくり休んで、明日への英気を養って",
  "困った時は誰かに頼っていいんですよ",
  "あなたの選択は間違っていません",
  "迷っても大丈夫。答えは一つじゃないから",
  "今日という日に、感謝を込めて",

  // 季節・時間帯に合わせた系（20個）
  "今夜はぐっすり眠れますように",
  "明日も素敵な一日になりますように",
  "今日一日、おつかれさまでした",
  "夜の静かな時間、お子さんと一緒に過ごせていますか",
  "今夜の月、きれいかもしれませんよ",
  "明日の朝、気持ちよく目覚められますように",
  "一日の終わりに、深呼吸してみてください",
  "今日できたことを思い出して、自分を褒めてあげて",
  "夜は考えすぎないで。明日の自分に任せましょう",
  "今夜は何か温かいものを飲んでから寝てください",
  "静かな夜、自分だけの時間を楽しんで",
  "明日も子どもの笑顔に会えますように",
  "今日頑張った自分に「ありがとう」",
  "夜風が気持ちいい季節ですね",
  "明日は今日より少し楽になりますように",
  "今夜の夢が素敵なものでありますように",
  "一日の終わりに、心を休めてください",
  "今日も無事に夜を迎えられました",
  "明日の自分にバトンタッチして、今日は休みましょう",
  "おやすみなさい。また明日",

  // その他（10個以上）
  "子どもと過ごす日々は、人生の宝物",
  "あなたがいるから、子どもは安心しています",
  "育児に正解はありません。あなたの方法で大丈夫",
  "悩むことも、子どもを思う愛情の表れです",
  "今日も子どもと笑い合えましたか？",
  "子どもの寝顔、今日も可愛かったですね",
  "あなたの愛情が、子どもの心を育てています",
  "子どもと過ごす時間、かけがえのないものです",
  "今日も子どもの味方でいてくれて、ありがとう",
  "あなたの優しさが、子どもを包んでいます",
  "子どもはあなたのことが大好きですよ",
  "今日という日が、幸せな思い出になりますように",
];

// 合計: 110個のメッセージ
```

---

## 6. Flutter 実装設計

### 6.1 ディレクトリ構成

```
flutter/lib/src/features/notifications/
├── domain/
│   ├── entities/
│   │   └── notification_settings.dart
│   ├── repositories/
│   │   └── notification_repository.dart
│   └── value_objects/
│       └── notification_type.dart
├── application/
│   ├── usecases/
│   │   ├── register_fcm_token.dart
│   │   ├── unregister_fcm_token.dart
│   │   └── update_notification_settings.dart
│   └── services/
│       └── notification_service.dart
├── infrastructure/
│   ├── repositories/
│   │   └── notification_repository_impl.dart
│   ├── sources/
│   │   ├── notification_settings_firestore_source.dart
│   │   └── fcm_data_source.dart
│   └── models/
│       └── notification_settings_dto.dart
└── presentation/
    ├── pages/
    │   └── notification_settings_page.dart
    ├── viewmodels/
    │   └── notification_settings_viewmodel.dart
    └── widgets/
        └── notification_toggle_tile.dart
```

### 6.2 依存パッケージ追加

**pubspec.yaml:**
```yaml
dependencies:
  firebase_messaging: ^15.0.0
  flutter_local_notifications: ^18.0.0  # フォアグラウンド通知表示用
```

### 6.3 主要クラス設計

#### Domain Layer

```dart
// domain/entities/notification_settings.dart
@immutable
class NotificationSettings {
  final String uid;
  final VaccineReminderSettings vaccineReminder;
  final DailyEncouragementSettings dailyEncouragement;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NotificationSettings({
    required this.uid,
    required this.vaccineReminder,
    required this.dailyEncouragement,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationSettings.defaultSettings(String uid) {
    return NotificationSettings(
      uid: uid,
      vaccineReminder: const VaccineReminderSettings(
        enabled: true,
        daysBefore: [0, 1],
      ),
      dailyEncouragement: const DailyEncouragementSettings(enabled: true),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

@immutable
class VaccineReminderSettings {
  final bool enabled;
  final List<int> daysBefore;

  const VaccineReminderSettings({
    required this.enabled,
    required this.daysBefore,
  });
}

@immutable
class DailyEncouragementSettings {
  final bool enabled;

  const DailyEncouragementSettings({required this.enabled});
}
```

#### Application Layer

```dart
// application/services/notification_service.dart
class NotificationService {
  final FirebaseMessaging _messaging;
  final RegisterFcmToken _registerFcmToken;

  NotificationService(this._messaging, this._registerFcmToken);

  Future<void> initialize() async {
    // 1. 通知許可をリクエスト
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // 2. FCMトークンを取得・登録
      final token = await _messaging.getToken();
      if (token != null) {
        await _registerFcmToken(token: token);
      }

      // 3. トークンリフレッシュをリッスン
      _messaging.onTokenRefresh.listen((newToken) {
        _registerFcmToken(token: newToken);
      });
    }
  }

  Future<void> setupForegroundHandler() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // フォアグラウンドで通知を表示
      _showLocalNotification(message);
    });
  }
}
```

### 6.4 初期化フロー

```dart
// main_stg.dart / main_prod.dart に追加
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(...);

  // 通知サービス初期化
  final notificationService = NotificationService(...);
  await notificationService.initialize();
  await notificationService.setupForegroundHandler();

  runApp(const MyApp());
}
```

### 6.5 通知設定UI

```dart
// presentation/pages/notification_settings_page.dart
class NotificationSettingsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(notificationSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('通知設定')),
      body: settingsAsync.when(
        data: (settings) => ListView(
          children: [
            SwitchListTile(
              title: const Text('予防接種リマインダー'),
              subtitle: const Text('予約日の前日と当日にお知らせします'),
              value: settings.vaccineReminder.enabled,
              onChanged: (value) => ref
                  .read(notificationSettingsViewModelProvider.notifier)
                  .updateVaccineReminder(enabled: value),
            ),
            SwitchListTile(
              title: const Text('毎日のメッセージ'),
              subtitle: const Text('毎晩20時に応援メッセージをお届けします'),
              value: settings.dailyEncouragement.enabled,
              onChanged: (value) => ref
                  .read(notificationSettingsViewModelProvider.notifier)
                  .updateDailyEncouragement(enabled: value),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('エラー: $e')),
      ),
    );
  }
}
```

---

## 7. iOS / Android 設定

### 7.1 iOS設定

**ios/Runner/Info.plist:**
```xml
<key>UIBackgroundModes</key>
<array>
  <string>fetch</string>
  <string>remote-notification</string>
</array>
```

**Capabilities:**
- Push Notifications を有効化
- Background Modes > Remote notifications を有効化

**APNs証明書:**
- Apple Developer Consoleで証明書を作成
- Firebaseプロジェクト設定にアップロード

### 7.2 Android設定

**android/app/src/main/AndroidManifest.xml:**
```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>

<application>
  <!-- 通知チャンネル設定 -->
  <meta-data
    android:name="com.google.firebase.messaging.default_notification_channel_id"
    android:value="milu_notifications"/>
</application>
```

---

## 8. Terraform デプロイ設定

### 8.1 Cloud Scheduler リソース

```hcl
# terraform/modules/cloud_functions/scheduler.tf

resource "google_cloud_scheduler_job" "vaccine_reminder" {
  name        = "send-vaccine-reminder"
  description = "Daily vaccine reminder at 10:00 JST"
  schedule    = "0 10 * * *"
  time_zone   = "Asia/Tokyo"
  region      = "asia-northeast1"

  pubsub_target {
    topic_name = google_pubsub_topic.vaccine_reminder.id
    data       = base64encode("{}")
  }
}

resource "google_cloud_scheduler_job" "daily_encouragement" {
  name        = "send-daily-encouragement"
  description = "Daily encouragement message at 20:00 JST"
  schedule    = "0 20 * * *"
  time_zone   = "Asia/Tokyo"
  region      = "asia-northeast1"

  pubsub_target {
    topic_name = google_pubsub_topic.daily_encouragement.id
    data       = base64encode("{}")
  }
}
```

### 8.2 IAM 権限追加

Cloud Functions サービスアカウントに追加：
- `roles/firebase.admin` - FCM送信権限

---

## 9. テスト計画

### 9.1 単体テスト

| 対象 | テスト内容 |
|------|-----------|
| NotificationSettings | デフォルト値生成、copyWith |
| encouragementMessages | 100個以上のメッセージ存在確認 |
| selectRandomMessage | ランダム選択のテスト |

### 9.2 統合テスト

| テストケース | 期待結果 |
|-------------|----------|
| FCMトークン登録 | Firestoreに正しく保存 |
| 通知設定更新 | 設定が反映される |
| 予約当日の通知 | 対象ユーザーに送信 |
| 設定OFFユーザー | 通知が送信されない |

### 9.3 E2Eテスト

1. STG環境で手動トリガーによる通知送信
2. 実機での通知受信確認
3. フォアグラウンド/バックグラウンド両方で確認

---

## 10. 実装フェーズ

### Phase 1: 基盤整備（優先度: 高）
1. Flutter: firebase_messaging パッケージ追加
2. Flutter: FCMトークン取得・登録実装
3. Cloud Functions: registerFcmToken 実装
4. Firestore: notification_settings スキーマ追加

### Phase 2: 予防接種リマインダー（優先度: 高）
1. Cloud Functions: sendVaccineReminder 実装
2. Terraform: Cloud Scheduler 設定
3. Flutter: 通知受信ハンドラー実装

### Phase 3: 応援メッセージ（優先度: 中）
1. Cloud Functions: sendDailyEncouragement 実装
2. 応援メッセージ100個作成
3. Terraform: Cloud Scheduler 設定

### Phase 4: 設定UI（優先度: 中）
1. Flutter: 通知設定画面実装
2. Flutter: 設定変更UseCase実装

### Phase 5: 品質向上（優先度: 低）
1. エラーハンドリング強化
2. 分析・ログ改善
3. パフォーマンス最適化

---

## 11. 監視・運用

### 11.1 Cloud Logging

- 通知送信成功/失敗のログ
- FCMトークン無効時の警告
- バッチ送信の統計

### 11.2 アラート設定

- Cloud Functions実行エラー
- Cloud Scheduler実行失敗
- FCM送信エラー率しきい値超過

### 11.3 メトリクス

- 日次通知送信数
- 通知設定ON/OFF比率
- FCMトークン登録デバイス数

---

## 12. セキュリティ考慮事項

1. **FCMトークンの保護**: Firestore Security Rulesで本人のみアクセス可
2. **認証必須**: Cloud Functions CallableはFirebase Auth必須
3. **レート制限**: FCM自体のレート制限に依存
4. **個人情報**: 通知内容にワクチン名など詳細を含めない

---

## 13. 将来拡張

- **おやすみモード**: 指定時間帯の通知停止
- **通知履歴**: アプリ内で過去の通知を確認
- **カスタム通知時刻**: ユーザーが好きな時刻を設定
- **成長記録リマインダー**: 身長・体重測定のリマインド
- **カレンダーイベントリマインダー**: カレンダー登録イベントの通知

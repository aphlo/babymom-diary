# 世帯認可の切替・確認済み移行

MILU-01/02/03への対応。デプロイや実データ移行はこの変更では実行していない。

## 正規の認可情報

- `household_authorizations/{hid}`: `ownerUid`, `state` (`active` / `deleting`), `invitationGeneration` (整数)。Adminのみ作成・更新し、所有者をクライアントから変更する経路は設けない。
- `user_authorizations/{uid}`: `state`, `activeHouseholdId` (文字列またはnull), `originalHouseholdId` (本人所有の復帰先、またはnull)。Adminのみ管理する。
- `households/{hid}/members/{uid}`: 正規のmember文書。クライアントは読取りのみ。
- `users/{uid}` の所属/roleと `households/{hid}.createdBy` は表示互換用。FunctionsもRulesもこれらを認可の根拠にしない。
- `household_invitations/{sha256(token)}`: `householdId`, `issuerUid`, `generation`, `expiresAt` (Firestore Timestamp)。クライアントのget/list/writeを全て拒否する。生の256bit tokenは発行レスポンスにのみ返し、DBやログへ保存しない。24時間、単回消費。Bearer招待なので持つ人が参加できる。相手UIDへの宛先固定は現行匿名認証UIでは行わず、信頼できる相手にのみ渡す。

新規作成は `create-household` へ切替。認証済みUIDで世帯・本人member・認可記録・表示用usersをtransaction作成する。再呼出しは正規の現在世帯を返す。未検証の旧users所属がある場合は自動上書きせずサポート確認を要求する。

`create-invitation` は現在世帯の正規ownerのみ利用でき、再発行時は旧世代のコードを全て失効する。`accept-invitation` は `token` と `displayName` が必要で、旧 `householdId` のみの加入は拒否する。存在・期限・世代・owner・発行者の現在所属/状態をtransaction確認し、参加とコード消費を原子的に行う。移動時は元世帯のコードも失効し、共有元のmemberを削除する。本人の単独original世帯とowner memberは復帰用に保持する。他memberを持つownerの移動は拒否する。

メンバー削除はowner/current所属を正規記録で確認し、世代を増分して旧コードを失効させる。復帰はprivate original参照とその世帯の正規所有者の両方が一致する場合のみ。削除済みmemberが再参加するにはownerが新しく発行したコードが必要となる。

退会は最初に本人の認可状態を `deleting` とし、正規owner記録に列挙された世帯だけを削除する。各世帯を `deleting` にして他memberの復帰を確定してからrecursiveDeleteする。users配下もrecursiveDeleteし、FCM登録は同じ認可状態をtransactionで確認する。Rulesは退会中の本人プロフィール・通知トークン・設定書込みを拒否する。日次通知は親users不存在またはdeletingのユーザーを除外する。既に送信キューへ載った通知の取り消しは保証しない。

退会は複数transactionとrecursiveDeleteにまたがるため全体として原子的ではない。失敗時も `deleting` が残り、同じUIDの `delete-account` 再呼出しで続行できる。Auth削除は従来通りクライアントが最後に行う。再作成を防ぐためprivate user tombstoneは保持する。運用上のtombstone削除はAuth削除確認と再発行UID方針を確認してから別途行う。大量memberの世帯はtransaction上限に達し得るため、移行レビューで規模を確認し必要なら別途ページング処理を用意する。

## 既存データは自動的に信用しない

過去のRulesではcreatedBy、member、usersの所属/roleが変更可能だった。現在値の一致、本人の自己申告、現member一覧だけを証拠にownerや共有権限を移行してはいけない。独立した信頼できる作成記録・改ざん前バックアップ・当時の監査記録などを照合し、所有者と共有先、復帰先を個別に確認する。確認できない世帯は未登録のまま隔離し、データを削除・他人へ公開・ownerへ自動昇格しない。確認できない本人の退会も旧世帯の破壊権限は与えず、本人usersのみ除去されるため残存データは運用確認が必要。

承認済み移行manifestには世帯ID、独立証拠への参照、owner UID、認可するmember UID/role、各ユーザーのactive/original世帯、レビュー担当、承認日を記録する。ownerは一名、originalは本人所有かnull、activeはmemberのいる世帯かnullを検査する。private registryを作成するだけではなく、member一覧を承認済み内容で再構成し、古い余分なmemberを除去、createdByとusers表示項目を正規記録へ合わせる。曖昧なレコードを自動採用するスクリプトは含めていない。移行は別途承認された運用作業として、バックアップとレビュー済みmanifestを用い実施する。

## 段階配備・停止期間・旧アプリの互換性

**本PRはメンテナンスを伴う切替であり、完全無停止のrolling配備ではない。**
未移行の本番へFunctionsだけ、または最終Rulesだけを先に適用すると正規の既存操作も拒否される。
本PRには本番maintenance switch・強制更新の運用gate・自動的に信用できる移行処理は含めていない。
それらを別途レビュー・非本番で確認してから配備する。

1. 独立証拠による移行manifest案、バックアップ/復旧方針、事前案内、サポート受付、
   一時maintenance Rulesを準備する。新アプリの審査・配布準備も先に進めるが、
   新API未配備時に新版を単独で有効化すると新規作成等が使えないため、公開時点を切替計画と合わせる。
   Terraform名だけでなくFirebase CLI配備名などの旧Admin処理・別名・重複endpoint、
   移行に干渉する通知登録/スケジュール処理を棚卸しする。本PRでは本番の棚卸し・設定読取りはしていない。
2. **live Functions変更や移行内容の最終確定より先にmaintenanceへ入る。**
   旧household/member・users認可項目の包括writeを一時Rulesで置き換え、影響するオンライン操作を停止する。
   denyを旧allowへ追加するだけではOR評価により停止できない。旧Admin mutator/別名も停止する。
   Rulesだけでは旧Admin SDKの削除・所属書込みを止められない。停止確認後にバックアップと証拠照合を確定する。
3. clientと旧Adminの変更を停止したまま、承認済みmanifestからprivate registry・正規member一覧・
   users表示項目を整合させる。未承認世帯は登録せず保持する。現在値・自己申告だけからownerを採用しない。
   旧世帯IDによる加入と旧招待を失効させ、確認済みactive/original・owner/memberを検査する。
4. maintenance内で全Callable実装と最終Rulesを配備する。`create-household` → `createHousehold`、
   `create-invitation` → `createInvitation` の新規entry point/IAMも同モジュールで配備し、
   既存accept/remove/delete/FCM登録/日次処理も更新する。外部操作・干渉するwriterはまだ停止したまま、
   private collectionのclient拒否、直接所属変更拒否、旧別名の無効化を確認する。
   旧public項目を認可のfallbackにする並行期間は設けない。
5. 新Flutter版・最小対応版の運用gateを有効にし、合成データの非本番受入で新規作成、
   共同編集、招待、削除後復帰、owner/member退会、失効拒否、途中失敗の再試行を確認する。
   移行・server/rules・新版配布が揃ってからmaintenanceを解除する。
   store審査・反映・利用者更新に要する時間は本PRで保証できず、停止時間の上限は約束しない。
6. 未確認世帯・旧版エラー・deleting再試行を監視する。gateが満たせなければmaintenanceを維持する。
   rollbackで旧包括write・旧ID加入・未検証owner権限や古い削除処理を復活させない。

| 時期・利用者 | 利用への影響 |
|---|---|
| maintenance中・旧版/新版 | 対象のオンライン記録/管理操作は意図的に停止。既存の端末キャッシュが表示される場合があり、遠隔消去は保証しない。 |
| 切替後・新版・確認済み世帯 | 現在世帯の従来の記録共同編集と正規管理フローを維持し、ownerが新コードを発行する。 |
| 切替後・旧版 | 直接世帯作成・直接所属変更・世帯IDのみ加入は更新まで利用不可。表示mirror/記録pathは保つが旧配布binaryの起動/再認証挙動は未検証で、旧版全体の互換性を保証しない。 |
| いずれの版でも未確認世帯 | 一般maintenance終了後も読取り・書込み/管理の拒否が続く。独立確認とサポート対応までデータを保持する。 |

安全に段階配備できるのは、上記の停止・独立確認・更新gateを満たす場合に限る。
新版を一部ユーザーへ配布するだけのphased rolloutでは旧操作の安全な互換期間にならない。
強制更新画面は利用案内でありセキュリティ境界ではない。本手順は将来の運用計画であり、
merge・本番配備・IAM変更・実データ移行は実施していない。

## 検証と限界

`cloud-functions/src/households/authorization.test.ts` は実際のCallable `.run` をJestから呼び、Firestoreのみを合成データのtest doubleにする。正常作成/参加/復帰/owner削除/member退会、未検証所有権、旧ID加入、期限切れ・再利用・失効済みコード、ownerの世帯移動、改ざんされた表示項目、退会後の通知登録を確認する。読取り後書込み順序もtest doubleで検査する。テストは実Firestoreの並行transaction・Rules評価・IAM・配備状態を実証しない。

Rulesの用途別matchと認可フィールド制限はソースで確認した。Rules emulatorは利用していない。Flutter SDKのDart artifactダウンロードが環境のHTTP CONNECT 403で拒否され、Rakeも未インストール（`rake format`, `rake lint`, `rake test` はcommand not found）で、ローカルformat/analyze/testは実行できない。整形修正後のCI run38594189534ではFunctions・公式サイト・Flutter format/analyze/testが全て通過した。本番/実データ/API呼出し・課金操作・secret値出力は行っていない。MILU-05のFCM数/速度制限は別対応であり、本PRでは解決済みとしない。


追加確認: Node 22.23.3（公式配布・SHA256確認）でもTypeScript buildと合成データの通常回帰テストが通過した。Hugは22件、miluは8 suites/80件。Flutter SDK取得403と実Rules/DB検証の限界は残る。

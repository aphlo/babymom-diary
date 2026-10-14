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

## 配備順序と互換性

1. このPRのCallable実装をTerraformで配備する。`create-household` → `createHousehold`、`create-invitation` → `createInvitation` の新規entry point/IAMも同モジュールに含める。既存 `accept-invitation`, `remove-member`, `delete-account`, `register-fcm-token` と日次通知の改修も同時に更新する。旧ID加入はここから利用不可となる。未検証世帯の管理操作もfail closedとなる。
2. 移行前にメンテナンス時間を確保し、旧クライアントのhousehold/member書込みおよびusers認可項目の書込みを一時Rulesで停止する。旧包括writeを残したまま承認memberを移行すると、移行と最終Rules切替の間に再び変更され得る。メンテナンスRulesを別途レビューして適用し、以後の書込み停止を確認してから証拠照合を確定する。
3. バックアップを取得し、上記承認済みmanifestからprivate registry・member・users表示項目を移行する。未承認世帯は登録しない。この段階で元世帯の新しいコードが発行されていないこと、private collectionへのclient権限がないことも確認する。
4. 新Flutter版を配布し最小サポート版を切り替える。世帯作成はCallable、共有画面は世帯IDから招待コードへ切替。新API名はasia-northeast1のTerraform名と一致する。旧アプリの直接世帯作成・直接所属変更は最終Rulesで拒否されるため、移行案内とアプリ更新を必須にする。
5. 本PRの最終Rulesを配備してメンテナンスを解除する。確認済みregistryとmemberを持つ正規ユーザーは、現在世帯で従来の子ども/育児/成長/離乳食/予防接種/カレンダー/ママ記録/設定/タグの共同編集を維持する。owner/memberの管理情報、世帯削除はCallableのみ。未登録世帯は読取り・書込みとも拒否され、既存キャッシュの削除は自動実行しない。
6. 合成データだけの通常受入確認で、新規onboard、owner招待、member共同編集、削除後復帰、旧コード/旧世帯IDの拒否、owner/memberの退会、途中失敗の再試行を確認する。

一時write freezeがあるため完全無停止の移行ではない。未検証世帯が最終Rulesで拒否される影響は事前案内が必要。既存正規ユーザーの確認済み移行をRules切替前に完了すれば、最終状態での閲覧・共同編集を維持できる。rollback時に旧包括writeやIDのみ加入を復活させない。問題があればメンテナンス状態に戻し新しい境界のまま修正する。

## 検証と限界

`cloud-functions/src/households/authorization.test.ts` は実際のCallable `.run` をJestから呼び、Firestoreのみを合成データのtest doubleにする。正常作成/参加/復帰/owner削除/member退会、未検証所有権、旧ID加入、期限切れ・再利用・失効済みコード、ownerの世帯移動、改ざんされた表示項目、退会後の通知登録を確認する。読取り後書込み順序もtest doubleで検査する。テストは実Firestoreの並行transaction・Rules評価・IAM・配備状態を実証しない。

Rulesの用途別matchと認可フィールド制限はソースで確認した。Rules emulatorは利用していない。Flutter SDKのDart artifactダウンロードが環境のHTTP CONNECT 403で拒否され、Rakeも未インストール（`rake format`, `rake lint`, `rake test` はcommand not found）で、ローカルformat/analyze/testは実行できないためCIで実行する必要がある。本番/実データ/API呼出し・課金操作・secret値出力は行っていない。MILU-05のFCM数/速度制限は別対応であり、本PRでは解決済みとしない。

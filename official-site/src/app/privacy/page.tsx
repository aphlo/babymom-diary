import { Metadata } from "next";

export const metadata: Metadata = {
  title: "プライバシーポリシー",
  description:
    "miluのプライバシーポリシー。ユーザーの個人情報や育児記録データ等の収集目的、サードパーティモジュール（Firebase、RevenueCat、AdMob）による外部送信、データの取り扱いについて掲載しています。",
};

export default function PrivacyPolicy() {
  return (
    <section className="pt-[120px] pb-[60px] px-5 min-h-[calc(100vh-180px)] bg-linear-to-br from-bg-pink to-white flex justify-center">
      <div className="w-full max-w-[800px] bg-white/80 rounded-lg p-6 md:p-10 shadow-soft backdrop-blur-md border border-border-pink">
        <h1 className="text-center mb-8 text-text-main font-fredoka text-3xl md:text-4xl font-bold">
          プライバシーポリシー
        </h1>

        <div className="article-body">
          <p>
            aphlo（以下「当方」といいます。）は、スマートフォン向けアプリケーション「milu」（以下「本アプリ」といいます。）およびこれに関連するサービス（以下、総称して「本サービス」といいます。）において、ユーザーの皆様（以下「ユーザー」といいます。）からお預かりする個人情報および育児データについて、以下のとおりプライバシーポリシー（以下「本ポリシー」といいます。）を定め、その適切な保護に努めます。
          </p>

          <h2>1. 取得する情報およびその利用目的</h2>
          <p>当方は、本サービスにおいて以下の情報を取得し、それぞれの目的のために利用します。</p>
          <ul className="list-disc pl-6 mb-6">
            <li className="mb-2">
              <strong>アカウント作成情報</strong> (メールアドレス、パスワード等):
              アカウント認証、データのクラウド同期、ユーザーサポートのため。
            </li>
            <li className="mb-2">
              <strong>お子さまの基本データ</strong> (生年月日、名前、性別、身長、体重等):
              アプリ内の成長曲線表示、年齢に応じた予防接種スケジュールの算出、アプリ機能のパーソナライズのため。
            </li>
            <li className="mb-2">
              <strong>育児記録データ</strong> (授乳、睡眠、排泄、体温、予防接種履歴、写真、日記等):
              アプリ内の記録機能の提供、グラフ・カレンダーでの可視化、パートナー間の共有機能の提供のため。
            </li>
            <li className="mb-2">
              <strong>お問い合わせ情報</strong>: ユーザーからのご意見や不具合報告への対応、サービス改善のため。
            </li>
          </ul>

          <h2>2. 情報の外部送信およびサードパーティモジュールの利用</h2>
          <p>
            本サービスには、サービスの提供、アクセス分析、および広告配信のために、以下のサードパーティ製SDK（電気通信事業法上の外部送信規律に関連するもの）が組み込まれています。これらのモジュールを通じて、ユーザーのデータが外部へ送信される場合があります。
          </p>

          <h3 className="text-base font-bold mt-4 mb-2 text-text-main">① Firebase（Google LLC）</h3>
          <ul className="list-disc pl-6 mb-4">
            <li className="mb-1">
              <strong>送信目的</strong>:
              データのクラウド同期・保存、プッシュ通知の配信、クラッシュ分析および利用状況の分析。
            </li>
            <li className="mb-1">
              <strong>送信データ</strong>: ユーザーのアカウント識別子、アプリ動作ログ、端末情報、クラッシュログ。
            </li>
            <li className="mb-1">
              <a
                href="https://policies.google.com/privacy?hl=ja"
                target="_blank"
                rel="noopener noreferrer"
                className="text-primary-dark hover:underline"
              >
                Google プライバシーポリシー
              </a>
            </li>
          </ul>

          <h3 className="text-base font-bold mt-4 mb-2 text-text-main">② RevenueCat（RevenueCat, Inc.）</h3>
          <ul className="list-disc pl-6 mb-4">
            <li className="mb-1">
              <strong>送信目的</strong>: 有料プラン（定期購読・サブスクリプション）のステータス管理、購入状態の同期。
            </li>
            <li className="mb-1">
              <strong>送信データ</strong>:
              匿名化されたユーザー識別子、アプリストア内でのトランザクション情報（購入履歴、領収書データ）。※クレジットカード情報等は直接収集・送信されません。
            </li>
            <li className="mb-1">
              <a
                href="https://www.revenuecat.com/privacy"
                target="_blank"
                rel="noopener noreferrer"
                className="text-primary-dark hover:underline"
              >
                RevenueCat プライバシーポリシー（英語）
              </a>
            </li>
          </ul>

          <h3 className="text-base font-bold mt-4 mb-2 text-text-main">③ Google AdMob（Google LLC）</h3>
          <ul className="list-disc pl-6 mb-4">
            <li className="mb-1">
              <strong>送信目的</strong>: 無料プランユーザーに対する最適化された広告の配信。
            </li>
            <li className="mb-1">
              <strong>送信データ</strong>: 広告識別子（IDFA /
              AAID）、端末情報、位置情報、アプリ内での広告タップ等の行動履歴。
            </li>
            <li className="mb-1">
              <a
                href="https://policies.google.com/technologies/ads?hl=ja"
                target="_blank"
                rel="noopener noreferrer"
                className="text-primary-dark hover:underline"
              >
                Google 広告テクノロジー規約
              </a>
            </li>
          </ul>

          <h2>3. 個人情報の第三者への開示・提供</h2>
          <p>
            当方は、ユーザーの同意を得た場合、または法令に基づく場合を除き、取得した個人情報を第三者に提供することはありません。
          </p>

          <h2>4. アカウント削除およびデータの管理</h2>
          <ol className="list-decimal pl-6 mb-6">
            <li className="mb-2">
              本アプリはパートナーとのデータ共有機能を備えています。共有設定を行うと、同一世帯に紐付けられた別のユーザーに対して、登録した育児記録やデータが開示・共有されます。
            </li>
            <li className="mb-2">
              ユーザーは、本アプリ内の「メニュー」＞「データの削除（またはアカウントの削除）」より、いつでも登録した世帯データ、子供のデータ、およびアカウントを削除して退会することができます。削除されたデータはサーバー上から速やかに復旧不可能な形で消去されます。
            </li>
          </ol>

          <h2>5. セキュリティ</h2>
          <p>
            当方は、クラウドサーバー内の暗号化通信（HTTPS）や厳格なアクセス制御など、合理的な技術的対策を行い、ユーザーのデータの漏洩、滅失の防止に努めます。
          </p>

          <h2>6. プライバシーポリシーの変更</h2>
          <p>
            当方は、法令の改正や本サービスの仕様変更に伴い、本ポリシーを必要に応じて見直すことがあります。変更した本ポリシーは、本サービス内または公式ウェブサイト上に掲示した時点から効力を生じるものとします。
          </p>

          <h2>7. お問い合わせ窓口</h2>
          <p>
            個人情報の取り扱いに関するご質問、苦情、開示等のご請求につきましては、以下の窓口までメールにてご連絡ください。
          </p>
          <p className="bg-bg-pink/50 p-4 rounded-md border border-border-pink">
            <strong>aphlo サポート窓口</strong>
            <br />
            メールアドレス:{" "}
            <a href="mailto:support@aphlo.com" className="text-primary-dark hover:underline">
              support@aphlo.com
            </a>
          </p>

          <p className="text-right mt-10">制定日：2025年6月1日</p>
        </div>
      </div>
    </section>
  );
}

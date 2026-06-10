import { Metadata } from "next";

export const metadata: Metadata = {
  title: "特定商取引法に基づく表記",
  description: "miluの特定商取引法に基づく表記。提供サービスに関する情報、料金、支払方法などを掲載しています。",
};

export default function Tokushoho() {
  return (
    <section className="pt-[120px] pb-[60px] px-5 min-h-[calc(100vh-180px)] bg-linear-to-br from-bg-pink to-white flex justify-center">
      <div className="w-full max-w-[800px] bg-white/80 rounded-lg p-6 md:p-10 shadow-soft backdrop-blur-md border border-border-pink">
        <h1 className="text-center mb-8 text-text-main font-fredoka text-3xl md:text-4xl font-bold">
          特定商取引法に基づく表記
        </h1>

        <table className="w-full border-collapse mt-5 text-[0.95rem] text-text-light leading-relaxed">
          <tbody>
            <tr className="block md:table-row">
              <th className="w-full md:w-[30%] bg-bg-pink/30 text-text-main font-bold p-4 border-b border-border-pink text-left block md:table-cell md:vertical-top">
                事業者の名称
              </th>
              <td className="p-4 border-b border-border-pink text-left block md:table-cell md:vertical-top">aphlo</td>
            </tr>
            <tr className="block md:table-row">
              <th className="w-full md:w-[30%] bg-bg-pink/30 text-text-main font-bold p-4 border-b border-border-pink text-left block md:table-cell md:vertical-top">
                代表者または運営責任者
              </th>
              <td className="p-4 border-b border-border-pink text-left block md:table-cell md:vertical-top">
                巨海　宏向
              </td>
            </tr>
            <tr className="block md:table-row">
              <th className="w-full md:w-[30%] bg-bg-pink/30 text-text-main font-bold p-4 border-b border-border-pink text-left block md:table-cell md:vertical-top">
                所在地
              </th>
              <td className="p-4 border-b border-border-pink text-left block md:table-cell md:vertical-top">
                〒150-0044
                <br />
                東京都渋谷区円山町5番3号 MIEUX渋谷ビル8階
              </td>
            </tr>
            <tr className="block md:table-row">
              <th className="w-full md:w-[30%] bg-bg-pink/30 text-text-main font-bold p-4 border-b border-border-pink text-left block md:table-cell md:vertical-top">
                連絡先
              </th>
              <td className="p-4 border-b border-border-pink text-left block md:table-cell md:vertical-top">
                メールアドレス:{" "}
                <a href="mailto:support@aphlo.com" className="text-primary-dark hover:underline">
                  support@aphlo.com
                </a>
                <br />
                電話番号: 090-7044-8919
              </td>
            </tr>
            <tr className="block md:table-row">
              <th className="w-full md:w-[30%] bg-bg-pink/30 text-text-main font-bold p-4 border-b border-border-pink text-left block md:table-cell md:vertical-top">
                販売価格
              </th>
              <td className="p-4 border-b border-border-pink text-left block md:table-cell md:vertical-top">
                プレミアムプラン（月額）: 200円 / 月（税込）
                <br />
                プレミアムプラン（年額）: 2,000円 / 年（税込）
                <br />
                ※アプリ内の購入画面（ペイウォール）に表示される金額に準じます。キャンペーン等により変動する場合があります。
              </td>
            </tr>
            <tr className="block md:table-row">
              <th className="w-full md:w-[30%] bg-bg-pink/30 text-text-main font-bold p-4 border-b border-border-pink text-left block md:table-cell md:vertical-top">
                商品代金以外の必要料金
              </th>
              <td className="p-4 border-b border-border-pink text-left block md:table-cell md:vertical-top">
                アプリのダウンロード、利用、アップデートに必要なインターネット接続料金、パケット通信料等はお客様の負担となります。
              </td>
            </tr>
            <tr className="block md:table-row">
              <th className="w-full md:w-[30%] bg-bg-pink/30 text-text-main font-bold p-4 border-b border-border-pink text-left block md:table-cell md:vertical-top">
                引き渡し時期
              </th>
              <td className="p-4 border-b border-border-pink text-left block md:table-cell md:vertical-top">
                購入手続き完了後、即時にご利用いただけます。
              </td>
            </tr>
            <tr className="block md:table-row">
              <th className="w-full md:w-[30%] bg-bg-pink/30 text-text-main font-bold p-4 border-b border-border-pink text-left block md:table-cell md:vertical-top">
                お支払方法および支払時期
              </th>
              <td className="p-4 border-b border-border-pink text-left block md:table-cell md:vertical-top">
                ・App Store決済（Apple Inc.の規約に基づきます）
                <br />
                ・Google Play決済（Google LLCの規約に基づきます）
              </td>
            </tr>
            <tr className="block md:table-row">
              <th className="w-full md:w-[30%] bg-bg-pink/30 text-text-main font-bold p-4 border-b border-border-pink text-left block md:table-cell md:vertical-top">
                返品・交換・キャンセル等
              </th>
              <td className="p-4 border-b border-border-pink text-left block md:table-cell md:vertical-top">
                デジタルコンテンツの特性上、購入手続き完了後の返品・返金・キャンセルはお受けできません。
                <br />
                定期購読（サブスクリプション）の解約は、App Store のアカウント設定、または Google Play
                の定期購入管理画面からいつでも行うことができます。
              </td>
            </tr>
            <tr className="block md:table-row">
              <th className="w-full md:w-[30%] bg-bg-pink/30 text-text-main font-bold p-4 border-b border-border-pink text-left block md:table-cell md:vertical-top">
                動作環境
              </th>
              <td className="p-4 border-b border-border-pink text-left block md:table-cell md:vertical-top">
                iOS 17.0 以降を搭載した iPhone/iPad
                <br />
                Android 10.0 以降を搭載したスマートフォン
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </section>
  );
}

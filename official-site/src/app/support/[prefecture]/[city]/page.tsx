import { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import CtaCard from "../../../../components/CtaCard";
import { municipalities } from "../../../../data/municipalities";

type Props = {
  params: Promise<{ prefecture: string; city: string }>;
};

// SSG用に全ルートのパラメータを生成
export async function generateStaticParams() {
  return municipalities.map((m) => ({
    prefecture: m.prefectureSlug,
    city: m.citySlug,
  }));
}

// 動的メタデータの生成
export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { prefecture, city } = await params;
  const data = municipalities.find((m) => m.prefectureSlug === prefecture && m.citySlug === city);

  if (!data) {
    return {};
  }

  const title = `${data.cityJa}の子育て支援・子供医療費助成・予防接種情報まとめ | milu`;
  const description = `${data.cityJa}で受けられる子ども医療費助成（対象年齢・所得制限）、おたふくかぜ予防接種の助成金額や手続き方法、出産祝い金・ギフトなどの支援制度についてわかりやすくまとめました。`;

  return {
    title,
    description,
    keywords: `${data.cityJa}, 子育て支援, 医療費助成, 予防接種, おたふくかぜ, 出産祝い金, 育児手当`,
    openGraph: {
      title,
      description,
      type: "article",
      url: `https://milu-baby.app/support/${prefecture}/${city}`,
    },
  };
}

export default async function MunicipalityPage({ params }: Props) {
  const { prefecture, city } = await params;
  const data = municipalities.find((m) => m.prefectureSlug === prefecture && m.citySlug === city);

  if (!data) {
    notFound();
  }

  // JSON-LD（構造化データ）の構築 (FAQPage)
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "FAQPage",
    mainEntity: [
      {
        "@type": "Question",
        name: `${data.cityJa}の子ども医療費助成に所得制限はありますか？`,
        acceptedAnswer: {
          "@type": "Answer",
          text: `${data.cityJa}の子ども医療費助成の所得制限は「${data.medicalSupport.incomeLimit}」です。`,
        },
      },
      {
        "@type": "Question",
        name: `${data.cityJa}でおたふくかぜ予防接種の助成は受けられますか？`,
        acceptedAnswer: {
          "@type": "Answer",
          text: data.mumpsSupport.hasSubsidy
            ? `${data.cityJa}ではおたふくかぜ予防接種の助成があります。対象年齢は${data.mumpsSupport.targetAge}で、助成内容は「${data.mumpsSupport.subsidyAmount}」です。`
            : `${data.cityJa}では、現在おたふくかぜ予防接種の公費助成は行われていません（全額自己負担となります）。`,
        },
      },
      {
        "@type": "Question",
        name: `${data.cityJa}に独自の出産祝い金や子育てギフトはありますか？`,
        acceptedAnswer: {
          "@type": "Answer",
          text: `${data.cityJa}には「${data.childbirthGift.title}」という制度があり、支給内容は「${data.childbirthGift.amount}」です。`,
        },
      },
    ],
  };

  return (
    <>
      {/* 構造化データの埋め込み */}
      {/* biome-ignore lint/security/noDangerouslySetInnerHtml: JSON-LD is static and safe here */}
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />

      <div className="pt-[100px] bg-bg-cream min-h-screen">
        {/* パンくずリスト */}
        <nav className="max-w-[1000px] mx-auto pt-6 px-6 text-sm text-text-light" aria-label="Breadcrumb">
          <ol className="flex items-center space-x-2">
            <li>
              <Link href="/" className="hover:text-primary transition-colors">
                ホーム
              </Link>
            </li>
            <span className="text-gray-400">/</span>
            <li>
              <Link href="/support" className="hover:text-primary transition-colors">
                子育て支援情報
              </Link>
            </li>
            <span className="text-gray-400">/</span>
            <li>
              <Link href={`/support/${data.prefectureSlug}`} className="hover:text-primary transition-colors">
                {data.prefectureJa}
              </Link>
            </li>
            <span className="text-gray-400">/</span>
            <li className="font-semibold text-text-main" aria-current="page">
              {data.cityJa}
            </li>
          </ol>
        </nav>

        {/* ヒーローヘッダー */}
        <div className="bg-gradient-to-b from-bg-pink to-white/50 py-12 px-6 mt-4 border-y border-border-pink">
          <div className="max-w-[800px] mx-auto text-center animate-fade-in">
            <span className="bg-primary text-white py-1 px-3 rounded-full font-semibold text-xs mb-3 inline-block">
              自治体子育て支援情報
            </span>
            <h1 className="text-2xl md:text-3xl lg:text-4xl text-text-main font-bold leading-snug mb-4 font-fredoka">
              {data.cityJa}（{data.prefectureJa}）の子育て支援制度まとめ
              <br />
              <span className="text-lg md:text-xl font-normal text-text-light">
                子ども医療費助成・おたふくかぜワクチン・出産祝い金
              </span>
            </h1>
            <p className="text-text-light text-sm">更新日: 2026年6月12日</p>
          </div>
        </div>

        {/* メインコンテンツ */}
        <div className="max-w-[1000px] mx-auto py-10 px-6">
          <div className="bg-white border border-border-pink rounded-2xl p-6 md:p-10 shadow-soft mb-8">
            {/* 横浜市などのアップデート注記 */}
            {data.medicalSupport.updateNote && (
              <div className="mb-8 p-4 bg-primary/10 border border-primary/20 rounded-xl text-primary flex items-start gap-3">
                <span className="text-lg">📢</span>
                <p className="text-sm font-semibold leading-relaxed">{data.medicalSupport.updateNote}</p>
              </div>
            )}

            {/* はじめに */}
            <section className="mb-10">
              <p className="text-text-main leading-relaxed text-base">
                {data.prefectureJa}
                {data.cityJa}
                にお住まいの方、または転入を検討されている方向けに、子育て世帯に大きく関係する「子ども医療費助成」「おたふくかぜ予防接種（任意）の助成」「独自の出産祝い金や子育てギフト」の支援内容と、手続き方法について分かりやすく解説します。
              </p>
            </section>

            {/* 制度カードセクション */}
            <div className="space-y-10">
              {/* 1. 子ども医療費助成 */}
              <section id="medical" className="border-t border-border-pink pt-8">
                <h2 className="text-xl md:text-2xl font-bold text-text-main flex items-center gap-2 mb-6">
                  <span className="text-2xl">🏥</span> 子ども医療費助成制度
                </h2>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
                  <div className="bg-bg-cream rounded-xl p-4 border border-border-pink/50">
                    <h3 className="text-xs font-semibold text-text-light mb-1">対象年齢</h3>
                    <p className="text-sm font-bold text-text-main">{data.medicalSupport.targetAge}</p>
                  </div>
                  <div className="bg-bg-cream rounded-xl p-4 border border-border-pink/50">
                    <h3 className="text-xs font-semibold text-text-light mb-1">所得制限</h3>
                    <p className="text-sm font-bold text-text-main">{data.medicalSupport.incomeLimit}</p>
                  </div>
                  <div className="bg-bg-cream rounded-xl p-4 border border-border-pink/50">
                    <h3 className="text-xs font-semibold text-text-light mb-1">自己負担額</h3>
                    <p className="text-sm font-bold text-text-main">{data.medicalSupport.copayment}</p>
                  </div>
                </div>
                <p className="text-text-main text-sm leading-relaxed">
                  {data.cityJa}では、保険診療の対象となる医療費の自己負担分について、
                  {data.medicalSupport.incomeLimit === "なし"
                    ? "所得制限なしでどなたでも助成を受けることができます。"
                    : "所得制限等の条件を満たすことで助成が受けられます。"}{" "}
                  医療証を発行してもらい、医療機関の窓口に提示することで自己負担なし（または一部負担のみ）で受診が可能です。
                </p>
              </section>

              {/* 2. おたふくかぜ予防接種助成 */}
              <section id="mumps" className="border-t border-border-pink pt-8">
                <h2 className="text-xl md:text-2xl font-bold text-text-main flex items-center gap-2 mb-6">
                  <span className="text-2xl">💉</span> おたふくかぜ予防接種（任意）の助成
                </h2>

                {data.mumpsSupport.hasSubsidy ? (
                  <>
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
                      <div className="bg-bg-cream rounded-xl p-4 border border-border-pink/50">
                        <h3 className="text-xs font-semibold text-text-light mb-1">助成対象年齢</h3>
                        <p className="text-sm font-bold text-text-main">{data.mumpsSupport.targetAge}</p>
                      </div>
                      <div className="bg-bg-cream rounded-xl p-4 border border-border-pink/50">
                        <h3 className="text-xs font-semibold text-text-light mb-1">助成金額・内容</h3>
                        <p className="text-sm font-bold text-primary">{data.mumpsSupport.subsidyAmount}</p>
                      </div>
                    </div>
                    <div className="bg-bg-pink/30 rounded-xl p-5 border border-border-pink">
                      <h4 className="text-sm font-bold text-text-main mb-2">助成の受け方・注意点</h4>
                      <p className="text-sm text-text-main leading-relaxed">{data.mumpsSupport.howToApply}</p>
                    </div>
                  </>
                ) : (
                  <div className="bg-gray-50 rounded-xl p-6 border border-gray-200">
                    <p className="text-sm text-text-main leading-relaxed mb-2 font-semibold">
                      ※ {data.cityJa}では、現在おたふくかぜ予防接種に対する公費助成は行われていません。
                    </p>
                    <p className="text-xs text-text-light leading-relaxed">
                      おたふくかぜ（ムンプス）ワクチンは任意接種扱いとなるため、全額自己負担での接種となります。接種を検討される場合は、かかりつけの小児科等の医療機関にて直接ご相談ください。一般的には1回あたり5,000円〜8,000円程度の自己負担となります。
                    </p>
                  </div>
                )}
              </section>

              {/* 3. 受け取れる手当・現金給付一覧 */}
              <section id="cash-benefits" className="border-t border-border-pink pt-8">
                <h2 className="text-xl md:text-2xl font-bold text-text-main flex items-center gap-2 mb-6">
                  <span className="text-2xl">💰</span> 受け取れる手当・現金給付一覧
                </h2>
                <p className="text-sm text-text-main leading-relaxed mb-4">
                  {data.prefectureJa}
                  {data.cityJa}
                  にお住まいのご家庭が受け取れる、国・都道府県・市区町村からの主な手当金や一時金、経済的支援をまとめました。これらは併給（同時にすべて受け取ること）が可能です。
                </p>

                <div className="overflow-x-auto border border-border-pink/60 rounded-2xl shadow-soft">
                  <table className="w-full text-left border-collapse min-w-[750px]">
                    <thead>
                      <tr className="bg-bg-pink/40 border-b border-border-pink">
                        <th className="p-4 text-xs font-bold text-text-main uppercase tracking-wider w-[120px]">
                          支給元
                        </th>
                        <th className="p-4 text-xs font-bold text-text-main uppercase tracking-wider w-[180px]">
                          手当・給付名
                        </th>
                        <th className="p-4 text-xs font-bold text-text-main uppercase tracking-wider w-[220px]">
                          支給額・内容
                        </th>
                        <th className="p-4 text-xs font-bold text-text-main uppercase tracking-wider">
                          主な対象者・条件
                        </th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-border-pink/30">
                      {data.cashBenefits.map((benefit) => {
                        let badgeColor = "bg-gray-100 text-gray-800";
                        if (benefit.source === "国") {
                          badgeColor = "bg-blue-50 text-blue-700 border border-blue-100";
                        } else if (benefit.source.includes("都")) {
                          badgeColor = "bg-purple-50 text-purple-700 border border-purple-100";
                        } else if (benefit.source.includes("県")) {
                          badgeColor = "bg-indigo-50 text-indigo-700 border border-indigo-100";
                        } else if (benefit.source === "市区町村") {
                          badgeColor = "bg-primary/10 text-primary border border-primary/20";
                        }

                        return (
                          <tr
                            key={`${benefit.source}-${benefit.name}`}
                            className="hover:bg-bg-cream/30 transition-colors"
                          >
                            <td className="p-4 align-top">
                              <span
                                className={`inline-block py-1 px-2.5 rounded-full text-xs font-semibold ${badgeColor}`}
                              >
                                {benefit.source}
                              </span>
                            </td>
                            <td className="p-4 align-top">
                              <div className="text-sm font-bold text-text-main">{benefit.name}</div>
                            </td>
                            <td className="p-4 align-top">
                              <div className="text-sm font-bold text-primary">{benefit.amount}</div>
                              <p className="text-xs text-text-light mt-1.5 leading-relaxed">{benefit.description}</p>
                            </td>
                            <td className="p-4 align-top text-xs text-text-main font-medium leading-relaxed">
                              {benefit.target}
                            </td>
                          </tr>
                        );
                      })}
                    </tbody>
                  </table>
                </div>
              </section>

              {/* 4. 出産祝い金・子育てギフト */}
              <section id="childbirth" className="border-t border-border-pink pt-8">
                <h2 className="text-xl md:text-2xl font-bold text-text-main flex items-center gap-2 mb-6">
                  <span className="text-2xl">🎁</span> 出産祝い金・子育て支援ギフト
                </h2>
                <div className="bg-bg-cream rounded-2xl p-6 border border-border-pink/50 mb-4">
                  <h3 className="text-lg font-bold text-text-main mb-2">{data.childbirthGift.title}</h3>
                  <div className="flex flex-wrap gap-2 mb-4">
                    <span className="bg-primary text-white py-1 px-3 rounded-full text-xs font-semibold">
                      支給内容：{data.childbirthGift.amount}
                    </span>
                  </div>
                  <div className="space-y-3">
                    <div>
                      <h4 className="text-xs font-bold text-text-light uppercase tracking-wider">対象となる主な条件</h4>
                      <p className="text-sm text-text-main mt-0.5">{data.childbirthGift.conditions}</p>
                    </div>
                    <div className="pt-2 border-t border-dashed border-border-pink/50">
                      <h4 className="text-xs font-bold text-text-light uppercase tracking-wider">制度の詳細</h4>
                      <p className="text-sm text-text-main leading-relaxed mt-0.5">{data.childbirthGift.details}</p>
                    </div>
                  </div>
                </div>
              </section>

              {/* 5. 窓口・問い合わせ */}
              <section id="contact" className="border-t border-border-pink pt-8 mb-6">
                <h2 className="text-lg md:text-xl font-bold text-text-main flex items-center gap-2 mb-4">
                  <span className="text-xl">📞</span> 詳しい手続きと窓口情報
                </h2>
                <p className="text-sm text-text-main leading-relaxed mb-4">
                  子育て支援制度の詳細は年度によって変更される場合があります。手続きの期限や必要書類、指定医療機関一覧などについては、あらかじめ以下の公式サイトで確認するか、担当の部署まで直接お問い合わせください。
                </p>
                <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 p-5 bg-bg-cream rounded-xl border border-border-pink/50">
                  <div>
                    <h3 className="text-xs font-semibold text-text-light mb-1">公式担当窓口</h3>
                    <p className="text-sm font-bold text-text-main">{data.contact.department}</p>
                  </div>
                  <a
                    href={data.contact.url}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="inline-flex items-center justify-center bg-primary hover:bg-primary/90 text-white font-bold py-2.5 px-5 rounded-full text-sm transition-colors shadow-soft"
                  >
                    自治体公式サイト ↗
                  </a>
                </div>
              </section>
            </div>
          </div>

          {/* miluアプリへの誘導（CTA） */}
          <div className="mb-10">
            <CtaCard />
          </div>

          {/* 情報修正・変更の報告フォームへの導線 */}
          <div className="mb-10 p-6 bg-white border border-border-pink rounded-2xl text-center shadow-soft">
            <h3 className="text-sm font-bold text-text-main mb-2">掲載情報の誤り・変更について</h3>
            <p className="text-xs text-text-light leading-relaxed mb-4 max-w-[600px] mx-auto">
              掲載している情報は細心の注意を払って調査していますが、制度の変更等により古い情報が含まれている場合があります。情報の間違いや変更にお気づきの場合は、お手数ですが以下の報告フォームよりお知らせいただけますと幸いです。
            </p>
            <a
              href="https://docs.google.com/forms/d/e/1FAIpQLSctw19EsoQI2aIZxpsvoR0iycS4Mtmv6DEfPYD-sp4WULQ6uA/viewform"
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center justify-center bg-primary hover:bg-primary/90 text-white font-bold py-2.5 px-6 rounded-full text-xs transition-colors shadow-soft"
            >
              ✏️ 情報の誤り・変更を報告する（外部フォーム）
            </a>
          </div>

          {/* リンクとフッター誘導 */}
          <div className="text-center">
            <Link href="/support" className="text-primary hover:underline font-bold text-sm">
              ← 全国の子育て支援情報一覧へ戻る
            </Link>
          </div>
        </div>
      </div>
    </>
  );
}

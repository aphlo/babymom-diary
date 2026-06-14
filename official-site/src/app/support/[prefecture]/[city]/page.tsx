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

// ==========================================
// インライン SVG アイコンコンポーネント群
// ==========================================

function IconTarget({ className = "w-5 h-5" }: { className?: string }) {
  return (
    <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2} aria-hidden="true">
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364-6.364l-.707.707M6.343 17.657l-.707.707m0-12.728l.707.707m11.32 11.32l.707-.707M12 8a4 4 0 100 8 4 4 0 000-8z"
      />
    </svg>
  );
}

function IconDocument({ className = "w-5 h-5" }: { className?: string }) {
  return (
    <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2} aria-hidden="true">
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
      />
    </svg>
  );
}

function IconList({ className = "w-5 h-5" }: { className?: string }) {
  return (
    <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2} aria-hidden="true">
      <path strokeLinecap="round" strokeLinejoin="round" d="M4 6h16M4 10h16M4 14h16M4 18h16" />
    </svg>
  );
}

function IconMedical({ className = "w-5 h-5" }: { className?: string }) {
  return (
    <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2} aria-hidden="true">
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"
      />
    </svg>
  );
}

function IconInjection({ className = "w-5 h-5" }: { className?: string }) {
  return (
    <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2} aria-hidden="true">
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M20.354 15.354l-5-5a1.012 1.012 0 00-1.414 0l-.646.646L7 4.707V3a1 1 0 00-1-1H4a1 1 0 00-1 1v2a1 1 0 001 1h1.707l6.293 6.293-.646.646a1.002 1.002 0 000 1.414l5 5a1.002 1.002 0 001.414 0l3.586-3.586a1.002 1.002 0 000-1.414z"
      />
      <path strokeLinecap="round" strokeLinejoin="round" d="M6 18l-3 3" />
    </svg>
  );
}

function IconCoins({ className = "w-5 h-5" }: { className?: string }) {
  return (
    <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2} aria-hidden="true">
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
      />
    </svg>
  );
}

function IconGift({ className = "w-5 h-5" }: { className?: string }) {
  return (
    <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2} aria-hidden="true">
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M12 8v13m0-13V6a2 2 0 112 2h-2zm0 0V6a2 2 0 10-2 2h2zm0 0H4v13a2 2 0 002 2h12a2 2 0 002-2V8H12z"
      />
    </svg>
  );
}

function IconBulb({ className = "w-5 h-5" }: { className?: string }) {
  return (
    <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2} aria-hidden="true">
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"
      />
    </svg>
  );
}

function IconQuestion({ className = "w-5 h-5" }: { className?: string }) {
  return (
    <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2} aria-hidden="true">
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
      />
    </svg>
  );
}

function IconContact({ className = "w-5 h-5" }: { className?: string }) {
  return (
    <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2} aria-hidden="true">
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M3 5a2 2 0 012-2h3.28a1 1 0 01.94.725l.548 2.2a1 1 0 01-.321.988l-1.305.98a10.582 10.582 0 004.872 4.872l.98-1.305a1 1 0 01.988-.321l2.2.548a1 1 0 01.725.94V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"
      />
    </svg>
  );
}

function IconArrowRight({ className = "w-5 h-5" }: { className?: string }) {
  return (
    <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2} aria-hidden="true">
      <path strokeLinecap="round" strokeLinejoin="round" d="M9 5l7 7-7 7" />
    </svg>
  );
}

function IconCheck({ className = "w-5 h-5" }: { className?: string }) {
  return (
    <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2} aria-hidden="true">
      <path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" />
    </svg>
  );
}

function IconSwipe({ className = "w-5 h-5" }: { className?: string }) {
  return (
    <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2} aria-hidden="true">
      <path strokeLinecap="round" strokeLinejoin="round" d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4" />
    </svg>
  );
}

// 吹き出し（チャット風）アドバイスコンポーネント
function SpeechBubble({
  title,
  comment,
  type,
}: {
  title: string;
  comment: string;
  type: "success" | "warning" | "info";
}) {
  let bubbleBg = "bg-bg-pink border-border-pink text-text-main";

  if (type === "success") {
    bubbleBg = "bg-green-50/60 border-green-200 text-green-900";
  } else if (type === "warning") {
    bubbleBg = "bg-amber-50/60 border-amber-200 text-amber-900";
  }

  return (
    <div className="flex gap-3 md:gap-4 items-start my-6 animate-fade-in">
      <div className="flex flex-col items-center shrink-0">
        <div className="w-10 h-10 md:w-12 md:h-12 rounded-full overflow-hidden border border-border-pink/80 shadow-soft bg-white">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img src="/images/bear_normal.png" alt="milu編集部" className="w-full h-full object-cover" />
        </div>
        <span className="text-[9px] md:text-[10px] font-bold text-text-light mt-1">milu編集部</span>
      </div>
      <div
        className={`relative flex-1 p-4 md:p-5 rounded-2xl border ${bubbleBg} shadow-soft 
          before:absolute before:top-4 before:-left-1.5 before:w-3 before:h-3 before:rotate-45 
          before:border-l before:border-b before:border-inherit before:bg-inherit`}
      >
        <h5 className="text-xs font-bold uppercase tracking-wider mb-1 flex items-center gap-1 text-primary-dark">
          {title}
        </h5>
        <p className="text-xs md:text-sm leading-relaxed">{comment}</p>
      </div>
    </div>
  );
}

export default async function MunicipalityPage({ params }: Props) {
  const { prefecture, city } = await params;
  const data = municipalities.find((m) => m.prefectureSlug === prefecture && m.citySlug === city);

  if (!data) {
    notFound();
  }

  // 各種判定とアドバイスコメントの構築
  const isMedicalNoLimit = data.medicalSupport.incomeLimit === "なし";
  const medicalComment = isMedicalNoLimit
    ? `${data.cityJa}では子ども医療費助成の所得制限がなく、対象年齢（${data.medicalSupport.targetAge}）まで手厚いサポートを受けることができます。窓口負担も「${data.medicalSupport.copayment}」と非常に低く抑えられており、家計への負担を気にせず気軽に受診できる恵まれた環境です。`
    : `${data.cityJa}の子ども医療費助成には所得制限（${data.medicalSupport.incomeLimit}）が設けされています。所得制限の限度額は世帯の扶養人数等によって異なるため、ご自身の世帯所得が対象内であるかどうか、あらかじめ自治体の公式サイトや担当窓口で確認しておくことが重要です。`;

  const mumpsComment = data.mumpsSupport.hasSubsidy
    ? `${data.cityJa}では、任意接種であるおたふくかぜ予防接種に対して「${data.mumpsSupport.subsidyAmount}」の公費助成が行われています！おたふくかぜは合併症による難聴リスクなどもあるため、助成対象期間である「${data.mumpsSupport.targetAge}」のうちに早めに指定医療機関で接種を済ませるのがおすすめです。`
    : `${data.cityJa}では現在、おたふくかぜの公費助成は行われていません。全額自己負担（一般的には1回あたり5,000円〜8,000円程度）での接種となりますが、感染を防ぐためにも、小児科医と相談の上で適切なタイミング（一般的には1歳以降に2回）で自費での接種を検討することをお勧めします。`;

  const hasBirthGift = data.childbirthGift.title !== "なし" && data.childbirthGift.amount !== "なし";
  const childbirthComment = hasBirthGift
    ? `${data.cityJa}独自の出産・子育て支援として『${data.childbirthGift.title}』が用意されており、経済的支援として「${data.childbirthGift.amount}」が給付されます。これらは国や都道府県の手当と併給可能です。申請には「${data.childbirthGift.conditions}」などの要件や申請期限があるため、出生届の提出と合わせて早めに窓口で手続きを行いましょう。`
    : `${data.cityJa}独自の追加お祝い金制度はありませんが、国や都道府県が実施している出産育児一時金（原則50万円）や出産・子育て応援交付金（計10万円相当）の支給対象となります。妊娠届・出生届の提出時に案内がありますので、漏れなく申請手続きを進めましょう。`;

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
            ? `${data.cityJa}ではおたふくかぜ予防接種の助成が受けられます。対象年齢は「${data.mumpsSupport.targetAge}」で、助成内容は「${data.mumpsSupport.subsidyAmount}」です。`
            : `${data.cityJa}では現在おたふくかぜ予防接種に対する市区町村独自の公費助成はありません。`,
        },
      },
      {
        "@type": "Question",
        name: `${data.cityJa}に独自の出産祝い金や子育てギフトはありますか？`,
        acceptedAnswer: {
          "@type": "Answer",
          text: hasBirthGift
            ? `${data.cityJa}には「${data.childbirthGift.title}」という制度があり、支給内容は「${data.childbirthGift.amount}」です。`
            : `${data.cityJa}独自の出産祝い金やギフト制度は現在確認されていません。`,
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
        <nav className="max-w-[1000px] mx-auto pt-6 px-4 md:px-6 text-sm text-text-light" aria-label="Breadcrumb">
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
        <div className="relative overflow-hidden bg-gradient-to-b from-bg-pink via-bg-pink/50 to-white/30 py-12 px-4 md:px-6 mt-4 border-y border-border-pink">
          {/* 背景のドット装飾 */}
          <div className="absolute inset-0 opacity-20 pointer-events-none bg-[radial-gradient(#FF8FA3_1px,transparent_1px)] [background-size:16px_16px]" />

          <div className="relative max-w-[800px] mx-auto text-center animate-fade-in">
            <span className="bg-primary text-white py-1 px-4 rounded-full font-semibold text-xs mb-4 inline-block uppercase tracking-wider shadow-sm">
              自治体子育て支援情報
            </span>
            <h1 className="text-2xl md:text-3xl lg:text-4xl text-text-main font-bold leading-tight mb-4 font-fredoka tracking-tight">
              【2026年最新】{data.cityJa}の
              <br />
              <span className="text-primary-dark">子育て支援・助成制度</span>徹底まとめ
            </h1>
            <p className="text-text-light text-xs md:text-sm max-w-[600px] mx-auto leading-relaxed mt-3">
              {data.prefectureJa}
              {data.cityJa}
              の子ども医療費助成（対象年齢・所得制限）、おたふくかぜワクチン等の予防接種の公費助成制度、出産お祝い金・ギフトなどの独自支援をわかりやすく解説します。
            </p>
            <div className="flex items-center justify-center gap-2 mt-4 text-[11px] md:text-xs text-text-muted">
              <span>更新日: 2026年6月12日</span>
              <span>•</span>
              <span>所要時間: 約3分</span>
            </div>
          </div>
        </div>

        {/* メインコンテンツ - 全体を1枚の記事にするコンテナ */}
        <div className="max-w-[1000px] mx-auto py-6 md:py-10 px-0 md:px-6">
          <div className="w-full bg-white px-4 py-8 md:p-10 md:rounded-3xl md:border md:border-border-pink/60 md:shadow-soft">
            {/* 横浜市などのアップデート注記 */}
            {data.medicalSupport.updateNote && (
              <div className="mb-8 p-4 bg-primary/10 border border-primary/20 rounded-xl text-primary flex items-start gap-3 shadow-soft animate-fade-in">
                <IconBulb className="w-5 h-5 shrink-0 text-primary-dark" />
                <p className="text-sm font-semibold leading-relaxed">{data.medicalSupport.updateNote}</p>
              </div>
            )}

            {/* 3秒でわかるサマリーカード */}
            <section className="bg-gradient-to-r from-primary/5 to-secondary/10 border-2 border-primary/20 rounded-2xl p-5 md:p-8 shadow-soft mb-8 animate-fade-in delay-100">
              <h3 className="text-base md:text-lg font-bold text-text-main flex items-center gap-2 mb-4 font-fredoka">
                <IconCheck className="w-5 h-5 text-primary-dark" />
                <span>3秒でわかる！{data.cityJa}の子育て支援のポイント</span>
              </h3>
              {/* 1行に1情報が入るように縦並びのリスト形式に変更 */}
              <div className="flex flex-col gap-4">
                <div className="bg-white/80 backdrop-blur-sm rounded-xl p-4 border border-border-pink/40 shadow-sm flex items-start gap-3">
                  <IconCheck className="w-5 h-5 text-green-500 shrink-0 mt-0.5" />
                  <div>
                    <h4 className="text-xs font-bold text-text-light uppercase tracking-wider">子ども医療費助成</h4>
                    <p className="text-sm font-bold text-text-main mt-1 leading-snug">
                      対象年齢：{data.medicalSupport.targetAge}まで助成
                      <span className="text-xs font-normal text-text-light block md:inline md:ml-2">
                        （所得制限：
                        <span className={isMedicalNoLimit ? "font-bold text-green-600" : "font-bold text-amber-600"}>
                          {data.medicalSupport.incomeLimit}
                        </span>
                        ）
                      </span>
                    </p>
                  </div>
                </div>

                <div className="bg-white/80 backdrop-blur-sm rounded-xl p-4 border border-border-pink/40 shadow-sm flex items-start gap-3">
                  <IconCheck className="w-5 h-5 text-green-500 shrink-0 mt-0.5" />
                  <div>
                    <h4 className="text-xs font-bold text-text-light uppercase tracking-wider">おたふくかぜ助成</h4>
                    <p className="text-sm font-bold text-text-main mt-1 leading-snug">
                      助成有無：
                      {data.mumpsSupport.hasSubsidy ? (
                        <span className="text-primary-dark">{data.mumpsSupport.subsidyAmount}の公費助成あり</span>
                      ) : (
                        "公費助成はありません"
                      )}
                      <span className="text-xs font-normal text-text-light block md:inline md:ml-2">
                        {data.mumpsSupport.hasSubsidy
                          ? `（対象年齢：${data.mumpsSupport.targetAge}）`
                          : "（全額自己負担）"}
                      </span>
                    </p>
                  </div>
                </div>

                <div className="bg-white/80 backdrop-blur-sm rounded-xl p-4 border border-border-pink/40 shadow-sm flex items-start gap-3">
                  <IconCheck className="w-5 h-5 text-green-500 shrink-0 mt-0.5" />
                  <div>
                    <h4 className="text-xs font-bold text-text-light uppercase tracking-wider">出産祝い金・ギフト</h4>
                    <p className="text-sm font-bold text-text-main mt-1 leading-snug">
                      支給内容：
                      {hasBirthGift ? (
                        <span className="text-primary-dark">{data.childbirthGift.amount}</span>
                      ) : (
                        "独自の祝い金制度はありません"
                      )}
                      <span className="text-xs font-normal text-text-light block md:inline md:ml-2">
                        {hasBirthGift ? `（事業名：${data.childbirthGift.title}）` : "（国の交付金等は支給対象）"}
                      </span>
                    </p>
                  </div>
                </div>
              </div>
            </section>

            {/* はじめにリード文 */}
            <section className="mb-8">
              <p className="text-text-main leading-relaxed text-sm md:text-base">
                {data.prefectureJa}
                {data.cityJa}
                にお住まいの方、または他市区町村から転入を検討されている方向けに、子育て世帯に大きく関係する「子ども医療費助成」「おたふくかぜ予防接種（任意）の助成」「独自の出産祝い金や子育てギフト」の支援内容と、手続き方法について分かりやすく解説します。
              </p>

              {/* 導入・基本情報カード - 1行ずつ並ぶように変更 */}
              <div className="mt-6 flex flex-col gap-6 bg-bg-pink/40 border border-border-pink p-5 md:p-6 rounded-2xl">
                <div>
                  <h3 className="text-sm font-bold text-text-main flex items-center gap-2 mb-3">
                    <IconTarget className="w-5 h-5 text-primary-dark" />
                    <span>この記事の対象読者</span>
                  </h3>
                  <ul className="text-xs md:text-sm text-text-main space-y-2.5">
                    <li className="flex items-start gap-2">
                      <span className="text-primary mt-1 shrink-0">•</span>
                      <span>{data.cityJa}にお住まいで、現在妊娠中・子育て中の方</span>
                    </li>
                    <li className="flex items-start gap-2">
                      <span className="text-primary mt-1 shrink-0">•</span>
                      <span>他市区町村から{data.cityJa}への転入を検討・予定している方</span>
                    </li>
                    <li className="flex items-start gap-2">
                      <span className="text-primary mt-1 shrink-0">•</span>
                      <span>子ども医療費や予防接種の補助額、独自の手当について知りたい方</span>
                    </li>
                  </ul>
                </div>
                <hr className="border-border-pink/40" />
                <div>
                  <h3 className="text-sm font-bold text-text-main flex items-center gap-2 mb-3">
                    <IconDocument className="w-5 h-5 text-primary-dark" />
                    <span>この記事を読めばわかること</span>
                  </h3>
                  <ul className="text-xs md:text-sm text-text-main space-y-2.5">
                    <li className="flex items-start gap-2">
                      <span className="text-primary mt-1 shrink-0">•</span>
                      <span>子ども医療費助成の「対象年齢」「所得制限」「自己負担額」</span>
                    </li>
                    <li className="flex items-start gap-2">
                      <span className="text-primary mt-1 shrink-0">•</span>
                      <span>おたふくかぜ予防接種（任意）の「助成有無」と「申請方法」</span>
                    </li>
                    <li className="flex items-start gap-2">
                      <span className="text-primary mt-1 shrink-0">•</span>
                      <span>国・都道府県・{data.cityJa}から受け取れる手当や独自の出産祝い金</span>
                    </li>
                    <li className="flex items-start gap-2">
                      <span className="text-primary mt-1 shrink-0">•</span>
                      <span>詳しい手続きを行うための「公式担当窓口」と「公式サイトURL」</span>
                    </li>
                  </ul>
                </div>
              </div>

              {/* 目次 - 縦並びに変更 */}
              <div className="bg-bg-cream border border-border-pink/50 rounded-xl p-5 md:p-6 mt-6">
                <h3 className="text-sm md:text-base font-bold text-text-main flex items-center gap-2 mb-4">
                  <IconList className="w-5 h-5 text-primary-dark" />
                  <span>目次（タップで各章へ移動します）</span>
                </h3>
                <nav>
                  <ul className="flex flex-col gap-2">
                    <li>
                      <a
                        href="#medical"
                        className="flex items-center gap-3 p-3 bg-white hover:bg-bg-pink rounded-xl border border-border-pink/40 hover:border-primary/40 text-xs md:text-sm font-semibold text-text-main transition-all group shadow-sm"
                      >
                        <IconMedical className="w-5 h-5 text-primary-dark shrink-0" />
                        <span>1. 子ども医療費助成制度</span>
                        <IconArrowRight className="ml-auto w-4 h-4 text-text-light group-hover:text-primary transition-colors shrink-0" />
                      </a>
                    </li>
                    <li>
                      <a
                        href="#mumps"
                        className="flex items-center gap-3 p-3 bg-white hover:bg-bg-pink rounded-xl border border-border-pink/40 hover:border-primary/40 text-xs md:text-sm font-semibold text-text-main transition-all group shadow-sm"
                      >
                        <IconInjection className="w-5 h-5 text-primary-dark shrink-0" />
                        <span>2. おたふくかぜ予防接種の助成</span>
                        <IconArrowRight className="ml-auto w-4 h-4 text-text-light group-hover:text-primary transition-colors shrink-0" />
                      </a>
                    </li>
                    <li>
                      <a
                        href="#cash-benefits"
                        className="flex items-center gap-3 p-3 bg-white hover:bg-bg-pink rounded-xl border border-border-pink/40 hover:border-primary/40 text-xs md:text-sm font-semibold text-text-main transition-all group shadow-sm"
                      >
                        <IconCoins className="w-5 h-5 text-primary-dark shrink-0" />
                        <span>3. 受け取れる手当・現金給付一覧</span>
                        <IconArrowRight className="ml-auto w-4 h-4 text-text-light group-hover:text-primary transition-colors shrink-0" />
                      </a>
                    </li>
                    <li>
                      <a
                        href="#childbirth"
                        className="flex items-center gap-3 p-3 bg-white hover:bg-bg-pink rounded-xl border border-border-pink/40 hover:border-primary/40 text-xs md:text-sm font-semibold text-text-main transition-all group shadow-sm"
                      >
                        <IconGift className="w-5 h-5 text-primary-dark shrink-0" />
                        <span>4. 出産祝い金・子育て支援ギフト</span>
                        <IconArrowRight className="ml-auto w-4 h-4 text-text-light group-hover:text-primary transition-colors shrink-0" />
                      </a>
                    </li>
                    {data.customComment && (
                      <li>
                        <a
                          href="#custom-comment"
                          className="flex items-center gap-3 p-3 bg-white hover:bg-bg-pink rounded-xl border border-border-pink/40 hover:border-primary/40 text-xs md:text-sm font-semibold text-text-main transition-all group shadow-sm"
                        >
                          <IconBulb className="w-5 h-5 text-primary-dark shrink-0" />
                          <span>5. {data.cityJa}の子育て環境について</span>
                          <IconArrowRight className="ml-auto w-4 h-4 text-text-light group-hover:text-primary transition-colors shrink-0" />
                        </a>
                      </li>
                    )}
                    <li>
                      <a
                        href="#faq"
                        className="flex items-center gap-3 p-3 bg-white hover:bg-bg-pink rounded-xl border border-border-pink/40 hover:border-primary/40 text-xs md:text-sm font-semibold text-text-main transition-all group shadow-sm"
                      >
                        <IconQuestion className="w-5 h-5 text-primary-dark shrink-0" />
                        <span>{data.customComment ? "6" : "5"}. よくある質問 (FAQ)</span>
                        <IconArrowRight className="ml-auto w-4 h-4 text-text-light group-hover:text-primary transition-colors shrink-0" />
                      </a>
                    </li>
                    <li>
                      <a
                        href="#contact"
                        className="flex items-center gap-3 p-3 bg-white hover:bg-bg-pink rounded-xl border border-border-pink/40 hover:border-primary/40 text-xs md:text-sm font-semibold text-text-main transition-all group shadow-sm"
                      >
                        <IconContact className="w-5 h-5 text-primary-dark shrink-0" />
                        <span>{data.customComment ? "7" : "6"}. 詳しい手続きと窓口情報</span>
                        <IconArrowRight className="ml-auto w-4 h-4 text-text-light group-hover:text-primary transition-colors shrink-0" />
                      </a>
                    </li>
                  </ul>
                </nav>
              </div>
            </section>

            <hr className="border-border-pink/40 my-10" />

            {/* 1. 子ども医療費助成 */}
            <section id="medical" className="scroll-mt-[110px]">
              <h2 className="relative pl-4 pr-4 py-3 bg-gradient-to-r from-primary/10 to-transparent border-l-4 border-primary rounded-r-xl font-bold text-text-main text-lg md:text-xl flex items-center gap-2 mb-4 font-fredoka">
                <IconMedical className="w-6 h-6 text-primary" />
                <span>1. 子ども医療費助成制度 — 対象年齢や自己負担額は？</span>
              </h2>
              <p className="text-text-light text-sm leading-relaxed mb-6">
                子どもが小さいうちは、急な発熱やケガなどで小児科を受診する機会が多いものです。{data.cityJa}
                では、子育て世帯の経済的負担を軽減するため、子ども医療費の助成を行っています。以下で詳しい条件や対象年齢を確認しましょう。
              </p>

              <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
                <div className="bg-bg-cream rounded-xl p-4 border border-border-pink/50 shadow-sm">
                  <h3 className="text-xs font-semibold text-text-light mb-1 uppercase tracking-wider">対象年齢</h3>
                  <p className="text-sm md:text-base font-bold text-text-main">{data.medicalSupport.targetAge}</p>
                </div>
                <div className="bg-bg-cream rounded-xl p-4 border border-border-pink/50 shadow-sm">
                  <h3 className="text-xs font-semibold text-text-light mb-1 uppercase tracking-wider">所得制限</h3>
                  <p
                    className={`text-sm md:text-base font-bold ${isMedicalNoLimit ? "text-green-600" : "text-amber-600"}`}
                  >
                    {data.medicalSupport.incomeLimit}
                  </p>
                </div>
                <div className="bg-bg-cream rounded-xl p-4 border border-border-pink/50 shadow-sm">
                  <h3 className="text-xs font-semibold text-text-light mb-1 uppercase tracking-wider">自己負担額</h3>
                  <p className="text-sm md:text-base font-bold text-text-main">{data.medicalSupport.copayment}</p>
                </div>
              </div>
              <p className="text-text-main text-sm leading-relaxed mb-6">
                {data.cityJa}では、保険診療の対象となる医療費の自己負担分について、
                {isMedicalNoLimit
                  ? "所得制限なしでどなたでも助成を受けることができます。"
                  : "所得制限等の条件を満たすことで助成が受けられます。"}{" "}
                事前に医療証を発行してもらい、医療機関の窓口に提示することで自己負担なし（または一部負担のみ）で受診が可能です。
              </p>

              {/* miluのアドバイス（吹き出し風） */}
              <SpeechBubble
                title={isMedicalNoLimit ? "milu編集部のおすすめポイント" : "milu編集部のチェックポイント"}
                comment={medicalComment}
                type={isMedicalNoLimit ? "success" : "warning"}
              />
            </section>

            <hr className="border-border-pink/40 my-10" />

            {/* 2. おたふくかぜ予防接種助成 */}
            <section id="mumps" className="scroll-mt-[110px]">
              <h2 className="relative pl-4 pr-4 py-3 bg-gradient-to-r from-primary/10 to-transparent border-l-4 border-primary rounded-r-xl font-bold text-text-main text-lg md:text-xl flex items-center gap-2 mb-4 font-fredoka">
                <IconInjection className="w-6 h-6 text-primary" />
                <span>2. おたふくかぜ予防接種（任意）の助成状況</span>
              </h2>
              <p className="text-text-light text-sm leading-relaxed mb-6">
                おたふくかぜ（ムンプス）は、かかると難聴などの重い合併症を引き起こすリスクがある感染症です。日本では現在任意接種（自己負担）となっていますが、
                {data.cityJa}では公費による助成があるのでしょうか。助成内容と接種方法を解説します。
              </p>

              {data.mumpsSupport.hasSubsidy ? (
                <>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
                    <div className="bg-bg-cream rounded-xl p-4 border border-border-pink/50 shadow-sm">
                      <h3 className="text-xs font-semibold text-text-light mb-1 uppercase tracking-wider">
                        助成対象年齢
                      </h3>
                      <p className="text-sm md:text-base font-bold text-text-main">{data.mumpsSupport.targetAge}</p>
                    </div>
                    <div className="bg-bg-cream rounded-xl p-4 border border-border-pink/50 shadow-sm">
                      <h3 className="text-xs font-semibold text-text-light mb-1 uppercase tracking-wider">
                        助成金額・内容
                      </h3>
                      <p className="text-sm md:text-base font-bold text-primary-dark">
                        {data.mumpsSupport.subsidyAmount}
                      </p>
                    </div>
                  </div>
                  <div className="bg-bg-pink/30 rounded-xl p-5 border border-border-pink mb-6">
                    <h4 className="text-sm font-bold text-text-main mb-2">助成の受け方・注意点</h4>
                    <p className="text-sm text-text-main leading-relaxed">{data.mumpsSupport.howToApply}</p>
                  </div>
                </>
              ) : (
                <div className="bg-gray-50 rounded-xl p-6 border border-gray-200 mb-6">
                  <p className="text-sm text-text-main leading-relaxed mb-2 font-semibold">
                    ※ {data.cityJa}では、現在おたふくかぜ予防接種に対する公費助成は行われていません。
                  </p>
                  <p className="text-xs text-text-light leading-relaxed">
                    おたふくかぜワクチンは任意接種扱いとなるため、全額自己負担での接種となります。接種を検討される場合は、かかりつけの小児科等の医療機関にて直接ご相談ください。一般的には1回あたり5,000円〜8,000円程度の自己負担となります。
                  </p>
                </div>
              )}

              {/* miluのアドバイス（吹き出し風） */}
              <SpeechBubble
                title={data.mumpsSupport.hasSubsidy ? "milu編集部のおすすめポイント" : "milu編集部のおすすめアクション"}
                comment={mumpsComment}
                type={data.mumpsSupport.hasSubsidy ? "success" : "info"}
              />
            </section>

            <hr className="border-border-pink/40 my-10" />

            {/* 3. 受け取れる手当・現金給付一覧 */}
            <section id="cash-benefits" className="scroll-mt-[110px]">
              <h2 className="relative pl-4 pr-4 py-3 bg-gradient-to-r from-primary/10 to-transparent border-l-4 border-primary rounded-r-xl font-bold text-text-main text-lg md:text-xl flex items-center gap-2 mb-4 font-fredoka">
                <IconCoins className="w-6 h-6 text-primary" />
                <span>3. 受け取れる手当・現金給付一覧</span>
              </h2>
              <p className="text-text-light text-sm leading-relaxed mb-6">
                子育てには何かと費用がかかるため、受け取れる手当や一時金は大変心強い味方です。{data.prefectureJa}
                {data.cityJa}
                にお住まいのご家庭が対象となる、国や自治体からの経済的支援をまとめました。これらはすべて申請することで併給（同時受給）が可能です。
              </p>

              {/* スマホスワイプのナビゲーション */}
              <div className="flex items-center justify-between mb-3 text-[11px] md:text-xs text-text-light px-1">
                <span className="font-semibold">※ 横スクロールで全体を表示できます</span>
                <span className="flex items-center gap-1 text-primary-dark animate-pulse">
                  <IconSwipe className="w-4 h-4 shrink-0" />
                  <span className="font-bold">Swipe</span>
                </span>
              </div>

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

                      const isHighlightAmount =
                        benefit.amount.includes("所得制限なし") ||
                        benefit.amount.includes("15,000円") ||
                        benefit.amount.includes("50万円");

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
                            <div className="text-sm font-bold">
                              {isHighlightAmount ? (
                                <span className="bg-gradient-to-t from-yellow-200/60 to-transparent px-1 font-bold text-text-main">
                                  {benefit.amount}
                                </span>
                              ) : (
                                <span className="text-primary-dark">{benefit.amount}</span>
                              )}
                            </div>
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

            <hr className="border-border-pink/40 my-10" />

            {/* 4. 出産祝い金・子育てギフト */}
            <section id="childbirth" className="scroll-mt-[110px]">
              <h2 className="relative pl-4 pr-4 py-3 bg-gradient-to-r from-primary/10 to-transparent border-l-4 border-primary rounded-r-xl font-bold text-text-main text-lg md:text-xl flex items-center gap-2 mb-4 font-fredoka">
                <IconGift className="w-6 h-6 text-primary" />
                <span>4. 出産祝い金・子育て支援ギフト制度</span>
              </h2>
              <p className="text-text-light text-sm leading-relaxed mb-6">
                新しい家族 of 誕生を祝福するため、独自の出産お祝い金や育児支援ギフトを贈呈している自治体が増えています。
                {data.cityJa}で実施されている魅力的なプレゼントや給付金の内容を見てみましょう。
              </p>

              <div className="bg-bg-cream rounded-2xl p-6 border border-border-pink/50 mb-6 shadow-sm">
                <h3 className="text-lg font-bold text-text-main mb-2">{data.childbirthGift.title}</h3>
                <div className="flex flex-wrap gap-2 mb-4">
                  <span className="bg-primary text-white py-1.5 px-4 rounded-full text-xs font-semibold shadow-sm">
                    支給内容：{data.childbirthGift.amount}
                  </span>
                </div>
                <div className="space-y-3">
                  <div>
                    <h4 className="text-xs font-bold text-text-light uppercase tracking-wider">対象となる主な条件</h4>
                    <p className="text-sm text-text-main mt-0.5 font-medium">{data.childbirthGift.conditions}</p>
                  </div>
                  <div className="pt-2 border-t border-dashed border-border-pink/50">
                    <h4 className="text-xs font-bold text-text-light uppercase tracking-wider">制度の詳細</h4>
                    <p className="text-sm text-text-main leading-relaxed mt-0.5">{data.childbirthGift.details}</p>
                  </div>
                </div>
              </div>

              {/* miluのアドバイス（吹き出し風） */}
              <SpeechBubble
                title={hasBirthGift ? "milu編集部のおすすめポイント" : "milu編集部の耳より情報"}
                comment={childbirthComment}
                type={hasBirthGift ? "success" : "info"}
              />
            </section>

            {/* 自治体独自のカスタムコメントがある場合 */}
            {data.customComment && (
              <>
                <hr className="border-border-pink/40 my-10" />
                <section id="custom-comment" className="scroll-mt-[110px]">
                  <h2 className="relative pl-4 pr-4 py-3 bg-gradient-to-r from-primary/10 to-transparent border-l-4 border-primary rounded-r-xl font-bold text-text-main text-lg md:text-xl flex items-center gap-2 mb-4 font-fredoka">
                    <IconBulb className="w-6 h-6 text-primary" />
                    <span>5. {data.cityJa}の子育て環境について</span>
                  </h2>
                  <div className="bg-primary/5 border border-primary/20 rounded-2xl p-6 md:p-8 flex gap-4 items-start shadow-sm">
                    <div className="bg-primary/10 p-3 rounded-full text-xl flex items-center justify-center shrink-0 w-12 h-12 text-primary-dark shadow-soft">
                      <IconBulb className="w-6 h-6" />
                    </div>
                    <div>
                      <h3 className="text-base font-bold text-text-main mb-2">先輩ママパパからの口コミ・地域情報</h3>
                      <p className="text-sm text-text-main leading-relaxed">{data.customComment}</p>
                    </div>
                  </div>
                </section>
              </>
            )}

            <hr className="border-border-pink/40 my-10" />

            {/* 5. よくある質問 (FAQ) */}
            <section id="faq" className="scroll-mt-[110px]">
              <h2 className="relative pl-4 pr-4 py-3 bg-gradient-to-r from-primary/10 to-transparent border-l-4 border-primary rounded-r-xl font-bold text-text-main text-lg md:text-xl flex items-center gap-2 mb-6 font-fredoka">
                <IconQuestion className="w-6 h-6 text-primary" />
                <span>{data.customComment ? "6" : "5"}. よくある質問 (FAQ)</span>
              </h2>
              <p className="text-sm text-text-light leading-relaxed mb-6">
                {data.cityJa}の子育て支援について、ママやパパから特によく寄せられる質問と回答をまとめました。
              </p>

              <div className="space-y-4">
                <details className="group border border-border-pink/60 rounded-xl p-4 [&_summary::-webkit-details-marker]:hidden bg-bg-cream/40 open:bg-bg-pink/30 open:border-primary/40 transition-colors duration-200">
                  <summary className="flex justify-between items-center font-bold text-text-main text-sm cursor-pointer list-none select-none">
                    <span className="flex items-center gap-2">
                      <span className="bg-primary text-white w-6 h-6 rounded-full flex items-center justify-center text-xs font-fredoka shadow-sm">
                        Q
                      </span>
                      <span>{data.cityJa}の子ども医療費助成に所得制限はありますか？</span>
                    </span>
                    <IconArrowRight className="transition-transform duration-300 group-open:rotate-90 text-text-light w-4 h-4" />
                  </summary>
                  <div className="mt-3 text-xs md:text-sm text-text-main leading-relaxed border-t border-dashed border-border-pink pt-3 flex items-start gap-2">
                    <span className="bg-primary-dark text-white w-6 h-6 rounded-full flex items-center justify-center text-xs font-fredoka shadow-sm shrink-0">
                      A
                    </span>
                    <div>
                      <p className="font-semibold text-text-main">
                        {isMedicalNoLimit
                          ? `${data.cityJa}の子ども医療費助成には所得制限はありません。所得に関わらず全てのお子さまが助成の対象となります。`
                          : `${data.cityJa}の子ども医療費助成には所得制限があります。現在の所得要件は「${data.medicalSupport.incomeLimit}」です。`}
                      </p>
                      <p className="text-text-light text-xs mt-1">
                        世帯の所得状況等によって助成内容が変わる場合がありますので、詳しくは自治体の窓口へ直接ご確認ください。
                      </p>
                    </div>
                  </div>
                </details>

                <details className="group border border-border-pink/60 rounded-xl p-4 [&_summary::-webkit-details-marker]:hidden bg-bg-cream/40 open:bg-bg-pink/30 open:border-primary/40 transition-colors duration-200">
                  <summary className="flex justify-between items-center font-bold text-text-main text-sm cursor-pointer list-none select-none">
                    <span className="flex items-center gap-2">
                      <span className="bg-primary text-white w-6 h-6 rounded-full flex items-center justify-center text-xs font-fredoka shadow-sm">
                        Q
                      </span>
                      <span>{data.cityJa}でおたふくかぜ予防接種の助成は受けられますか？</span>
                    </span>
                    <IconArrowRight className="transition-transform duration-300 group-open:rotate-90 text-text-light w-4 h-4" />
                  </summary>
                  <div className="mt-3 text-xs md:text-sm text-text-main leading-relaxed border-t border-dashed border-border-pink pt-3 flex items-start gap-2">
                    <span className="bg-primary-dark text-white w-6 h-6 rounded-full flex items-center justify-center text-xs font-fredoka shadow-sm shrink-0">
                      A
                    </span>
                    <div>
                      <p className="font-semibold text-text-main">
                        {data.mumpsSupport.hasSubsidy
                          ? `${data.cityJa}ではおたふくかぜ予防接種の公費助成があります。対象年齢は「${data.mumpsSupport.targetAge}」で、助成内容は「${data.mumpsSupport.subsidyAmount}」です。`
                          : `${data.cityJa}では、現在おたふくかぜ予防接種に対する市区町村独自の公費助成はありません。`}
                      </p>
                      <p className="text-text-light text-xs mt-1">
                        助成がある場合は指定医療機関での事前手続き等が必要な場合があります。詳細は窓口でご確認ください。
                      </p>
                    </div>
                  </div>
                </details>

                <details className="group border border-border-pink/60 rounded-xl p-4 [&_summary::-webkit-details-marker]:hidden bg-bg-cream/40 open:bg-bg-pink/30 open:border-primary/40 transition-colors duration-200">
                  <summary className="flex justify-between items-center font-bold text-text-main text-sm cursor-pointer list-none select-none">
                    <span className="flex items-center gap-2">
                      <span className="bg-primary text-white w-6 h-6 rounded-full flex items-center justify-center text-xs font-fredoka shadow-sm">
                        Q
                      </span>
                      <span>{data.cityJa}に独自の出産祝い金や子育てギフトはありますか？</span>
                    </span>
                    <IconArrowRight className="transition-transform duration-300 group-open:rotate-90 text-text-light w-4 h-4" />
                  </summary>
                  <div className="mt-3 text-xs md:text-sm text-text-main leading-relaxed border-t border-dashed border-border-pink pt-3 flex items-start gap-2">
                    <span className="bg-primary-dark text-white w-6 h-6 rounded-full flex items-center justify-center text-xs font-fredoka shadow-sm shrink-0">
                      A
                    </span>
                    <div>
                      <p className="font-semibold text-text-main">
                        {hasBirthGift ? (
                          <>
                            {data.cityJa}には「<strong>{data.childbirthGift.title}</strong>
                            」という制度があり、支給内容は「<strong>{data.childbirthGift.amount}</strong>」です。
                          </>
                        ) : (
                          `${data.cityJa}独自の出産祝い金やギフト制度は現在確認されていません。`
                        )}
                      </p>
                      {hasBirthGift && (
                        <p className="text-text-light text-xs mt-1">
                          【主な支給条件】 {data.childbirthGift.conditions}
                        </p>
                      )}
                    </div>
                  </div>
                </details>
              </div>
            </section>

            <hr className="border-border-pink/40 my-10" />

            {/* 6. 窓口・問い合わせ */}
            <section id="contact" className="scroll-mt-[110px]">
              <h2 className="relative pl-4 pr-4 py-3 bg-gradient-to-r from-primary/10 to-transparent border-l-4 border-primary rounded-r-xl font-bold text-text-main text-lg md:text-xl flex items-center gap-2 mb-6 font-fredoka">
                <IconContact className="w-6 h-6 text-primary" />
                <span>{data.customComment ? "7" : "6"}. 詳しい手続きと窓口情報</span>
              </h2>
              <p className="text-sm text-text-light leading-relaxed mb-6">
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
                  className="inline-flex items-center justify-center bg-primary hover:bg-primary/95 text-white font-bold py-2.5 px-6 rounded-full text-sm transition-colors shadow-soft hover:shadow-md shrink-0 w-full sm:w-auto text-center"
                >
                  自治体公式サイト ↗
                </a>
              </div>
            </section>

            {/* miluアプリへの誘導（CTA） */}
            <div className="mt-12 mb-10">
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
                className="inline-flex items-center justify-center bg-primary hover:bg-primary/95 text-white font-bold py-2.5 px-6 rounded-full text-xs transition-colors shadow-soft hover:shadow-md"
              >
                情報の誤り・変更を報告する（外部フォーム）
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
      </div>
    </>
  );
}

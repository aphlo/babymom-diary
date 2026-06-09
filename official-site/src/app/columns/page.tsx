import { Metadata } from "next";
import Link from "next/link";

export const metadata: Metadata = {
  title: "お役立ちコラム",
  description: "育児の不安や悩みを解決する、miluのお役立ちコラム一覧です。授乳や予防接種スケジュールなど専門知識に基づいた記事を掲載しています。",
};

export default function ColumnsIndex() {
  // 静的記事データ定義
  const articles = [
    {
      slug: "baby-breastfeeding-schedule",
      title: "赤ちゃんの授乳スケジュールと目安量について",
      description: "新生児から1歳頃までの授乳回数やミルクの量の目安、スケジュール調整 of コツを分かりやすく解説します。",
      category: "授乳・食事",
      publishedAt: "2026/06/09",
    },
    {
      slug: "baby-vaccination-schedule",
      title: "赤ちゃんの予防接種スケジュール管理と進め方のコツ",
      description: "生後2ヶ月から始まる赤ちゃんの予防接種。種類が多くて複雑な予防接種スケジュールを漏れなくスムーズに進めるための方法を解説します。",
      category: "予防接種",
      publishedAt: "2026/06/09",
    },
  ];

  return (
    <div className="pt-[100px] bg-bg-cream min-h-screen pb-20">
      {/* Hero Section */}
      <div className="bg-gradient-to-b from-bg-pink to-white/50 py-14 px-6 text-center border-b border-border-pink">
        <div className="max-w-[800px] mx-auto animate-fade-in">
          <span className="inline-block bg-primary text-white py-1 px-3 rounded-full text-xs font-bold mb-3">milu コラム</span>
          <h1 className="text-3xl md:text-4xl text-text-main font-bold leading-snug mb-4 font-fredoka">お役立ちコラム</h1>
          <p className="text-text-light text-base max-w-[600px] mx-auto leading-relaxed">
            赤ちゃんの授乳スケジュールから、複雑な予防接種スケジュール管理まで。パパ・ママの毎日の育児をスマートにサポートするお役立ち情報を配信しています。
          </p>
        </div>
      </div>

      {/* Grid List */}
      <div className="max-w-[1000px] mx-auto px-6 py-12">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
          {articles.map((art) => (
            <div
              key={art.slug}
              className="bg-white border border-border-pink rounded-lg p-8 transition-all hover:-translate-y-1 hover:shadow-hover hover:border-primary-light cursor-pointer flex flex-col justify-between h-full"
              style={{ minHeight: "260px" }}
            >
              <div>
                <span className="text-[11px] bg-bg-pink text-primary-dark py-0.5 px-2.5 rounded-full font-bold inline-block mb-3">
                  {art.category}
                </span>
                <h2 className="text-xl font-bold mb-3 text-text-main font-fredoka leading-snug">
                  {art.title}
                </h2>
                <p className="text-sm text-text-light leading-relaxed line-clamp-3 mb-4">
                  {art.description}
                </p>
              </div>
              <div className="mt-4 flex justify-between items-center text-xs">
                <span className="text-text-muted">
                  {art.publishedAt}
                </span>
                <Link href={`/columns/${art.slug}`} className="text-primary-dark font-bold hover:underline inline-flex items-center gap-1 text-sm">
                  詳しく読む →
                </Link>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

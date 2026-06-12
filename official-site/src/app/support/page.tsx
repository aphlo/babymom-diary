import { Metadata } from "next";
import Link from "next/link";
import { municipalities } from "../../data/municipalities";

export const metadata: Metadata = {
  title: "市区町村別の子育て支援・子ども医療費助成・予防接種制度まとめ | milu",
  description:
    "全国の市区町村（自治体）ごとに、子ども医療費助成の対象年齢や所得制限、おたふくかぜ予防接種の助成額、出産お祝い金・ギフトなどの独自の支援制度をまとめたガイドポータルです。",
  openGraph: {
    title: "市区町村別の子育て支援・子ども医療費助成・予防接種制度まとめ | milu",
    description:
      "全国の市区町村（自治体）ごとに、子ども医療費助成の対象年齢や所得制限、おたふくかぜ予防接種の助成額、出産お祝い金・ギフトなどの独自の支援制度をまとめたガイドポータルです。",
    url: "https://milu-baby.app/support",
  },
};

export default function LocalPortalPage() {
  // 都道府県ごとにデータをグループ化
  const groupedData = municipalities.reduce(
    (acc, curr) => {
      const key = curr.prefectureSlug;
      if (!acc[key]) {
        acc[key] = {
          nameJa: curr.prefectureJa,
          slug: curr.prefectureSlug,
          cities: [],
        };
      }
      acc[key].cities.push(curr);
      return acc;
    },
    {} as Record<string, { nameJa: string; slug: string; cities: typeof municipalities }>,
  );

  const prefectures = Object.values(groupedData);

  return (
    <div className="pt-[100px] bg-bg-cream min-h-screen">
      {/* パンくずリスト */}
      <nav className="max-w-[800px] mx-auto pt-6 px-6 text-sm text-text-light" aria-label="Breadcrumb">
        <ol className="flex items-center space-x-2">
          <li>
            <Link href="/" className="hover:text-primary transition-colors">
              ホーム
            </Link>
          </li>
          <span className="text-gray-400">/</span>
          <li className="font-semibold text-text-main" aria-current="page">
            子育て支援情報
          </li>
        </ol>
      </nav>

      {/* ヘッダー */}
      <div className="max-w-[800px] mx-auto py-12 px-6">
        <div className="text-center mb-12 animate-fade-in">
          <span className="bg-primary text-white py-1 px-3 rounded-full font-semibold text-xs mb-3 inline-block">
            自治体データベース
          </span>
          <h1 className="text-3xl md:text-4xl text-text-main font-bold mb-4 font-fredoka">
            市区町村から探す子育て支援制度
          </h1>
          <p className="text-text-light text-base max-w-[600px] mx-auto leading-relaxed">
            お住まいの地域によって、子ども医療費の助成上限や任意予防接種の助成内容、出産祝いのギフトなどは大きく異なります。各自治体の制度や手続きを比較・チェックしてみましょう。
          </p>
        </div>

        {/* 都道府県グループカード */}
        <div className="space-y-8 mb-10">
          {prefectures.map((pref) => (
            <div key={pref.slug} className="bg-white border border-border-pink rounded-2xl p-6 md:p-8 shadow-soft">
              <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center border-b border-border-pink/50 pb-4 mb-6 gap-3">
                <h2 className="text-2xl font-bold text-text-main flex items-center gap-2">
                  <span className="text-primary">📍</span> {pref.nameJa}
                </h2>
                <Link
                  href={`/support/${pref.slug}`}
                  className="text-primary font-bold text-sm hover:underline flex items-center gap-1"
                >
                  {pref.nameJa}の全市区町村を見る →
                </Link>
              </div>

              {/* 都道府県内の市区町村へのクイックアクセス */}
              <div className="grid grid-cols-2 sm:grid-cols-3 gap-4">
                {pref.cities.map((city) => (
                  <Link
                    key={city.citySlug}
                    href={`/support/${pref.slug}/${city.citySlug}`}
                    className="bg-bg-cream hover:bg-bg-pink/30 border border-border-pink/30 hover:border-primary/50 rounded-xl p-4 text-center transition-all group"
                  >
                    <span className="font-bold text-text-main group-hover:text-primary transition-colors block text-sm sm:text-base">
                      {city.cityJa}
                    </span>
                    <span className="text-text-light text-xs mt-1 block">支援情報を見る</span>
                  </Link>
                ))}
              </div>
            </div>
          ))}
        </div>

        {/* 下部補足と注意 */}
        <div className="bg-white/80 border border-border-pink/50 rounded-xl p-5 text-xs text-text-light leading-relaxed mb-6">
          <p className="font-bold mb-1">【掲載データについて】</p>
          <p>
            本ページに掲載されている助成内容、対象年齢、所得制限等の情報は2026年6月時点の調査データを基に作成しています。各制度は自治体の法改正等により随時変更される可能性があります。実際のお手続きや接種にあたっては、必ず各自治体の公式サイト等の最新情報をご確認ください。
          </p>
        </div>

        <div className="text-center">
          <Link href="/" className="text-primary hover:underline font-bold text-sm">
            ← ホームへ戻る
          </Link>
        </div>
      </div>
    </div>
  );
}

import { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { municipalities } from "../../../data/municipalities";

type Props = {
  params: Promise<{ prefecture: string }>;
};

// SSG用に全都道府県のスラグを生成
export async function generateStaticParams() {
  // 一意の都道府県スラグのリストを作成
  const prefs = Array.from(new Set(municipalities.map((m) => m.prefectureSlug)));
  return prefs.map((p) => ({
    prefecture: p,
  }));
}

// 動的メタデータの生成
export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { prefecture } = await params;
  const match = municipalities.find((m) => m.prefectureSlug === prefecture);

  if (!match) {
    return {};
  }

  const title = `${match.prefectureJa}の子育て支援・医療費助成自治体一覧 | milu`;
  const description = `${match.prefectureJa}内の各市区町村（自治体）で受けられる子ども医療費の助成制度、おたふくかぜ予防接種の助成、出産お祝い金などの支援制度情報をまとめた一覧ページです。`;

  return {
    title,
    description,
    openGraph: {
      title,
      description,
      url: `https://milu-baby.app/support/${prefecture}`,
    },
  };
}

export default async function PrefecturePage({ params }: Props) {
  const { prefecture } = await params;

  // 該当する都道府県の市区町村を取得
  const filteredCities = municipalities.filter((m) => m.prefectureSlug === prefecture);

  if (filteredCities.length === 0) {
    notFound();
  }

  const prefectureName = filteredCities[0].prefectureJa;

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
          <li>
            <Link href="/support" className="hover:text-primary transition-colors">
              子育て支援情報
            </Link>
          </li>
          <span className="text-gray-400">/</span>
          <li className="font-semibold text-text-main" aria-current="page">
            {prefectureName}
          </li>
        </ol>
      </nav>

      {/* ヘッダー */}
      <div className="max-w-[800px] mx-auto py-10 px-6">
        <div className="text-center mb-10">
          <span className="bg-primary text-white py-1 px-3 rounded-full font-semibold text-xs mb-3 inline-block">
            エリア別一覧
          </span>
          <h1 className="text-3xl text-text-main font-bold mb-4 font-fredoka">
            {prefectureName}の子育て支援・医療費助成情報
          </h1>
          <p className="text-text-light text-base max-w-[600px] mx-auto leading-relaxed">
            {prefectureName}
            内の各市区町村ごとの子ども医療費助成（対象年齢、所得制限）、おたふくかぜワクチン等の予防接種の公費助成制度、出産祝い品やギフトなどの詳細をご確認いただけます。
          </p>
        </div>

        {/* 市区町村リンク一覧 */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-10">
          {filteredCities.map((city) => (
            <Link
              key={city.citySlug}
              href={`/support/${prefecture}/${city.citySlug}`}
              className="bg-white border border-border-pink hover:border-primary rounded-2xl p-6 shadow-soft hover:shadow-md transition-all group flex flex-col justify-between"
            >
              <div>
                <h2 className="text-xl font-bold text-text-main group-hover:text-primary transition-colors mb-2">
                  {city.cityJa}
                </h2>
                <div className="space-y-1.5 mb-4 text-sm text-text-light">
                  <p className="flex items-center gap-1.5">
                    <span>🏥</span> 医療費：{city.medicalSupport.targetAge.split("（")[0]}まで（所得制限
                    {city.medicalSupport.incomeLimit}）
                  </p>
                  <p className="flex items-center gap-1.5">
                    <span>💉</span> おたふく助成：{city.mumpsSupport.hasSubsidy ? "あり" : "なし"}
                  </p>
                </div>
              </div>
              <span className="text-primary font-bold text-sm self-end flex items-center gap-1 group-hover:translate-x-1 transition-transform">
                詳しく見る →
              </span>
            </Link>
          ))}
        </div>

        <div className="text-center">
          <Link href="/support" className="text-primary hover:underline font-bold text-sm">
            ← 都道府県一覧へ戻る
          </Link>
        </div>
      </div>
    </div>
  );
}

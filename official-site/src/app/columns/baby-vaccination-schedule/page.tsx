import { Metadata } from "next";
import CtaCard from "../../../components/CtaCard";
import ArticleSidebar from "../../../components/ArticleSidebar";
import SupervisorProfile from "../../../components/SupervisorProfile";

export const metadata: Metadata = {
  title: "赤ちゃんの予防接種スケジュール管理と進め方のコツ",
  description: "生後2ヶ月から始まる赤ちゃんの予防接種。種類が多くて複雑な予防接種スケジュールを漏れなくスムーズに進めるための方法を解説します。",
  keywords: "予防接種, 赤ちゃん, スケジュール, 同時接種",
  openGraph: {
    title: "赤ちゃんの予防接種スケジュール管理と進め方のコツ | milu",
    description: "生後2ヶ月から始まる赤ちゃんの予防接種。種類が多くて複雑な予防接種スケジュールを漏れなくスムーズに進めるための方法を解説します。",
    type: "article",
    publishedTime: "2026-06-09",
  },
};

export default function VaccinationSchedule() {
  const article = {
    title: "赤ちゃんの予防接種スケジュール管理と進め方のコツ",
    category: "予防接種",
    publishedAt: "2026/06/09",
    description: "生後2ヶ月から始まる赤ちゃんの予防接種。種類が多くて複雑な予防接種スケジュールを漏れなくスムーズに進めるための方法を解説します。",
  };

  return (
    <div className="pt-[100px] bg-bg-cream min-h-screen">
      <div className="bg-gradient-to-b from-bg-pink to-white/50 py-14 px-6 text-center border-b border-border-pink">
        <div className="max-w-[800px] mx-auto animate-fade-in">
          <div className="flex justify-center items-center gap-3 mb-4 text-sm">
            <span className="bg-primary text-white py-1 px-3 rounded-full font-semibold text-xs">{article.category}</span>
            <time className="text-text-light" dateTime={article.publishedAt.replace(/\//g, "-")}>
              {article.publishedAt}
            </time>
          </div>
          <h1 className="text-3xl md:text-4xl text-text-main font-bold leading-snug mb-4 font-fredoka">{article.title}</h1>
          <p className="text-text-light text-base max-w-[600px] mx-auto leading-relaxed">{article.description}</p>
        </div>
      </div>

      <div className="max-w-[1200px] mx-auto py-10 px-6 grid grid-cols-1 lg:grid-cols-[2fr_1fr] gap-10">
        <main className="bg-white border border-border-pink rounded-lg p-6 md:p-10 shadow-soft">
          <article className="text-text-main text-base leading-relaxed">
            <p className="mb-6 text-[16px]">
              生後2ヶ月になると、いよいよ赤ちゃんの予防接種がスタートします。
              「種類が多くてどれをいつ打てばいいのか分からない」「同時接種って本当に大丈夫？」と悩まれるパパ・ママも多いでしょう。
            </p>
            <p className="mb-6 text-[16px]">
              今回は、主要なワクチンの種類やスケジュール管理、接種をスムーズに進めるためのポイントについて詳しく解説します。
            </p>

            <h2 className="text-2xl font-bold mt-10 mb-4 border-b-2 border-secondary pb-2">1. 赤ちゃんが受ける主な予防接種の種類</h2>
            <p className="mb-6">
              赤ちゃんが受けるワクチンには「定期接種（公費負担で無料）」と「任意接種（自己負担、一部助成あり）」があります。
            </p>

            <h3 className="text-xl font-bold mt-6 mb-3 text-primary-dark">生後2ヶ月から始まる初期のワクチン</h3>
            <ul className="list-disc pl-6 mb-6 flex flex-col gap-2">
              <li><strong>ヒブ（インフルエンザ菌b型）</strong>: 細菌性髄膜炎などを予防します。（※現在、5種混合ワクチンに含まれる場合もあります）</li>
              <li><strong>小児用肺炎球菌</strong>: 肺炎や中耳炎、髄膜炎を予防します。</li>
              <li><strong>五種混合（DPT-IPV-Hib）</strong>: ジフテリア、百日咳、破傷風、ポリオ、ヒブを予防します。</li>
              <li><strong>ロタウイルス</strong>: 重症の下痢症を引き起こすロタウイルス胃腸炎を予防します（経口ワクチン）。</li>
              <li><strong>B型肝炎</strong>: 将来的な肝炎や肝がんへの移行を防ぎます。</li>
            </ul>
            <p className="mb-6">
              生後2ヶ月の時点では、これら多くのワクチンを複数同時に接種することが推奨されています。
            </p>

            <hr className="my-10 border-t border-dashed border-border-pink" />

            <h2 className="text-2xl font-bold mt-10 mb-4 border-b-2 border-secondary pb-2">2. 予防接種スケジュールをスムーズに進めるコツ</h2>
            <p className="mb-6">
              予防接種は接種回数が多く、次回までの間隔（中何日あけるか）もワクチンごとに細かく決まっています。計画的に進めるためのコツをご紹介します。
            </p>
            <ol className="list-decimal pl-6 mb-6 flex flex-col gap-3">
              <li><strong>生後1ヶ月健診が過ぎたら予約の準備</strong>: 生後2ヶ月の誕生日になったらすぐに最初の接種ができるよう、かかりつけ医を決めて予約方法を確認しておきます。</li>
              <li><strong>同時接種を活用する</strong>: 複数本のワクチンを同じ日に接種する「同時接種」は、医療機関や小児科学会でも推奨されています。通院回数を減らし、早期に免疫をつけることができます。</li>
              <li><strong>接種後の副反応に備える</strong>: 接種した日は発熱や機嫌が悪くなることがあります。接種後24時間は赤ちゃんの様子をよく観察し、翌日に大事な予定を入れないようにしましょう。</li>
            </ol>

            <hr className="my-10 border-t border-dashed border-border-pink" />

            <h2 className="text-2xl font-bold mt-10 mb-4 border-b-2 border-secondary pb-2">3. 複雑なスケジュールは「milu」で自動管理！</h2>
            <p className="mb-6">
              ワクチルの種類ごとに「1回目から2回目は4週間あける」「追加接種は1年後」など、スケジュールをパパ・ママだけで完璧に把握し、ノートに書き出して管理するのは非常に大変です。
            </p>
            <p className="mb-6">
              <strong>育児記録アプリ「milu」</strong>なら、そんな複雑な予防接種スケジュール管理をスマートに解決できます。
            </p>

            <h3 className="text-xl font-bold mt-6 mb-3 text-primary-dark">miluの予防接種管理機能の特徴</h3>
            <ul className="list-disc pl-6 mb-6 flex flex-col gap-2">
              <li><strong>自動スケジュール算出</strong>: お子さまの誕生日を入力するだけで、推奨されるワクチンの接種可能期間や最適なスケジュールを自動で計算します。</li>
              <li><strong>接種記録・予約日の管理</strong>: 予約した日や接種が終わった日をアプリに登録するだけで、次回のスケジュールが自動で再計算・更新されます。</li>
              <li><strong>同時接種の予約グループ管理</strong>: どのワクチンを同時に接種したか、または予定しているかをグループ単位でわかりやすく管理可能です。</li>
            </ul>
            <p className="mb-6">
              スケジュール管理だけでなく、日々の授乳・睡眠・おむつ替えの記録や成長曲線も一元管理できます。
            </p>
            <p className="mb-6 font-bold text-primary-dark">
              スマートにスケジュールを組んで、お子さまの大切な予防接種を漏れなく進めましょう！
            </p>
          </article>

          {/* 監修者プロフィール */}
          <SupervisorProfile />

          {/* 流入導線 CTA */}
          <CtaCard />
        </main>

        {/* 関連記事のサイドバー */}
        <ArticleSidebar currentSlug="baby-vaccination-schedule" />
      </div>
    </div>
  );
}

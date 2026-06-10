import { Metadata } from "next";
import Image from "next/image";
import Link from "next/link";
import CtaCard from "../../../components/CtaCard";

export const metadata: Metadata = {
  title: "監修助産師 えるみのプロフィール",
  description: "育児記録アプリ「milu」のコラム・コンテンツ監修を担当する現役助産師「えるみ」の公式プロフィール。保有資格やキャリア、授乳支援や産後ケアにかける想いをご紹介します。",
  keywords: "助産師, えるみ, 監修者, プロフィール, 授乳支援, 産後ケア, milu",
  openGraph: {
    title: "監修助産師 えるみのプロフィール | milu",
    description: "育児記録アプリ「milu」のコラム・コンテンツ監修を担当する現役助産師「えるみ」の公式プロフィール。保有資格やキャリア, 授乳支援や産後ケアにかける想いをご紹介します。",
    type: "profile",
  },
};

export default function ElmiProfile() {
  return (
    <div className="pt-[100px] bg-bg-cream min-h-screen">
      {/* ヒーローセクション */}
      <section className="bg-gradient-to-b from-bg-pink via-bg-pink/50 to-white/0 py-16 px-6 border-b border-border-pink">
        <div className="max-w-[1000px] mx-auto flex flex-col md:flex-row items-center gap-10 md:gap-16">
          <div className="relative w-48 h-48 md:w-64 md:h-64 flex-shrink-0 overflow-hidden rounded-full border-4 border-primary-light shadow-card bg-white animate-fade-in">
            <Image
              src="/assets/images/elmi_profile.png"
              alt="現役助産師えるみ"
              fill
              className="object-cover"
              priority
            />
          </div>
          <div className="flex-1 text-center md:text-left animate-fade-in delay-100">
            <span className="bg-primary/10 text-primary-dark border border-primary/20 py-1 px-4 rounded-full font-bold text-xs uppercase tracking-wider">
              Official Supervisor
            </span>
            <h1 className="text-3xl md:text-5xl text-text-main font-bold mt-4 mb-2 font-fredoka leading-tight">
              現役助産師 えるみ
            </h1>
            <p className="text-primary-dark font-semibold text-lg mb-6">
              看護師・助産師（キャリア5年目）
            </p>
            
            <div className="flex flex-wrap justify-center md:justify-start gap-2 mb-6">
              <span className="bg-white border border-border-pink text-text-light text-xs font-semibold py-1 px-3.5 rounded-full shadow-xs">
                看護師免許
              </span>
              <span className="bg-white border border-border-pink text-text-light text-xs font-semibold py-1 px-3.5 rounded-full shadow-xs">
                助産師免許
              </span>
            </div>

            <p className="text-text-light leading-relaxed max-w-[600px]">
              多くの出産現場で新しい命の誕生に立ち会い、妊娠期から分娩、退院後の産褥期まで、一貫してママと赤ちゃんのサポートに取り組んできました。現在は病院にて助産師として勤務しながら、アプリ「milu」のコラム監修などを通じて、より多くの家庭に正しい育児知識と安心を届けています。
            </p>
          </div>
        </div>
      </section>

      {/* メインコンテンツ */}
      <section className="max-w-[1000px] mx-auto py-16 px-6">
        {/* 信念・理念 */}
        <div className="bg-white border border-border-pink rounded-2xl p-8 md:p-12 shadow-soft mb-12 text-center relative overflow-hidden">
          <div className="absolute top-0 left-0 w-full h-2 bg-gradient-to-r from-primary-light via-primary to-primary-dark" />
          <span className="text-primary font-bold text-sm tracking-wider uppercase">Message</span>
          <h2 className="text-2xl md:text-3xl text-text-main font-bold mt-4 mb-6 leading-snug font-fredoka">
            「パパとママが、納得して育児ができること」を何よりも大切にしています。
          </h2>
          <div className="max-w-[700px] mx-auto text-text-light text-base md:text-lg leading-loose space-y-4 text-left">
            <p>
              育児書やネットの情報には「〇〇すべき」「これが正しい」という情報が溢れています。しかし、赤ちゃんの個性も、パパ・ママの生活環境も、ご家庭によって千差万別です。
            </p>
            <p>
              誰かの正解をそのままなぞるのではなく、ご自身たちが「これなら納得できる」「これなら心地よくできる」と思える方法を見つけることが、大切だと思っています。
            </p>
            <p>
              時には頼れるものに頼り、肩の力を抜きながら、赤ちゃんとの愛おしい時間を納得して過ごせるよう、専門知識と温かい心でみなさまに寄り添います。
            </p>
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-10 items-stretch">
          {/* 経歴・実績 */}
          <div className="bg-white border border-border-pink rounded-2xl p-8 shadow-soft flex flex-col">
            <h3 className="text-xl font-bold text-text-main border-b border-border-pink pb-3 mb-6 flex items-center gap-2">
              <span className="w-2.5 h-6 bg-primary rounded-full" />
              経歴と歩み
            </h3>
            <ul className="space-y-6 flex-1">
              <li className="relative pl-6 before:content-[''] before:absolute before:left-0 before:top-2 before:w-2 before:h-2 before:bg-primary before:rounded-full">
                <span className="block text-xs text-text-muted font-semibold">Qualifications</span>
                <span className="font-bold text-text-main block mt-0.5">看護師・助産師国家資格を取得</span>
                <p className="text-sm text-text-light mt-1">専門学校にて看護学と助産学を修め、国家資格を取得。</p>
                <p className="text-sm text-text-light mt-1">在学中に受胎調節実地指導員の科目を修了。</p>
              </li>
              <li className="relative pl-6 before:content-[''] before:absolute before:left-0 before:top-2 before:w-2 before:h-2 before:bg-primary before:rounded-full">
                <span className="block text-xs text-text-muted font-semibold">Clinical Experience</span>
                <span className="font-bold text-text-main block mt-0.5">総合病院勤務</span>
                <p className="text-sm text-text-light mt-1">分娩介助をはじめ、妊娠期から産褥期までのケア、新生児ケアに幅広く従事。多くの家族のスタートラインをサポート。</p>
              </li>
              <li className="relative pl-6 before:content-[''] before:absolute before:left-0 before:top-2 before:w-2 before:h-2 before:bg-primary before:rounded-full">
                <span className="block text-xs text-text-muted font-semibold">Certifications</span>
                <span className="font-bold text-text-main block mt-0.5">新生児蘇生法（NCPR）・日本母体救命システム普及協議会（J-CIMERS）修了</span>
                <p className="text-sm text-text-light mt-1">赤ちゃんとママの安全を守るため、新生児の心肺蘇生技術（NCPR）および妊産婦の救命救急プログラム（J-CIMERS）を修了しています。</p>
              </li>
              <li className="relative pl-6 before:content-[''] before:absolute before:left-0 before:top-2 before:w-2 before:h-2 before:bg-primary before:rounded-full">
                <span className="block text-xs text-text-muted font-semibold">Postpartum Care & Clinical</span>
                <span className="font-bold text-text-main block mt-0.5">産後ケア事業・現役臨床助産師として活動</span>
                <p className="text-sm text-text-light mt-1">特に生後4ヶ月未満の母子を対象とした産後ケア活動に尽力。現在も産科医療機関にて臨床助産師として勤務し、ママと赤ちゃんを日々サポートしています。</p>
              </li>
            </ul>
          </div>

          {/* 好きな分野と趣味 */}
          <div className="flex flex-col gap-6">
            {/* 好きな分野 */}
            <div className="bg-white border border-border-pink rounded-2xl p-8 shadow-soft flex-1">
              <h3 className="text-xl font-bold text-text-main border-b border-border-pink pb-3 mb-4 flex items-center gap-2">
                <span className="w-2.5 h-6 bg-accent rounded-full" />
                得意・好きな支援分野
              </h3>
              <div className="space-y-4">
                <div className="bg-bg-pink/50 p-4 rounded-xl border border-border-pink">
                  <h4 className="font-bold text-primary-dark text-base mb-1">授乳支援（母乳・ミルク）</h4>
                  <p className="text-sm text-text-light leading-relaxed">
                    「母乳が出ない」「飲むのが上手くいかない」「ミルクの足し方が分からない」といった悩みに寄り添い、ママの希望に合わせた授乳プランを提案します。
                  </p>
                </div>
                <div className="bg-bg-pink/50 p-4 rounded-xl border border-border-pink">
                  <h4 className="font-bold text-primary-dark text-base mb-1">産後メンタルヘルス・赤ちゃん相談</h4>
                  <p className="text-sm text-text-light leading-relaxed">
                    産後の心身の変化による不安を取り除き、赤ちゃんの特性に合わせたあやし方や関わり方のアドバイスを行います。
                  </p>
                </div>
              </div>
            </div>

            {/* 趣味・プライベート */}
            <div className="bg-white border border-border-pink rounded-2xl p-8 shadow-soft">
              <h3 className="text-xl font-bold text-text-main border-b border-border-pink pb-3 mb-4 flex items-center gap-2">
                <span className="w-2.5 h-6 bg-primary-dark rounded-full" />
                趣味・プライベート
              </h3>
              <div className="grid grid-cols-2 gap-4">
                <div className="p-3 bg-bg-cream rounded-xl border border-border-pink/40 text-center">
                  <span className="text-2xl block mb-1">🏀</span>
                  <span className="font-bold text-xs text-text-main block">バスケ・Bリーグ観戦</span>
                  <span className="text-[10px] text-text-light block mt-0.5">プレーするのもプロの試合を見るのも大好きです！</span>
                </div>
                <div className="p-3 bg-bg-cream rounded-xl border border-border-pink/40 text-center">
                  <span className="text-2xl block mb-1">🎭</span>
                  <span className="font-bold text-xs text-text-main block">ミュージカル鑑賞</span>
                  <span className="text-[10px] text-text-light block mt-0.5">舞台からパワーをもらっています。お気に入りの作品が多数あります。</span>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* コラム一覧への戻りリンク */}
        <div className="mt-16 text-center">
          <Link
            href="/columns"
            className="inline-flex items-center justify-center bg-primary text-white font-bold py-3 px-8 rounded-full shadow-soft hover:bg-primary-dark transition-all duration-200 hover:-translate-y-0.5"
          >
            監修記事の一覧へ戻る
          </Link>
        </div>

        {/* 流入導線 CTA */}
        <div className="mt-16">
          <CtaCard />
        </div>
      </section>
    </div>
  );
}

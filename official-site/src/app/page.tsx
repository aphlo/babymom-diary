import { Metadata } from "next";
import Link from "next/link";
import ScrollAnimate from "../components/ScrollAnimate";

export const metadata: Metadata = {
  title: "milu - 赤ちゃんをmilu あなたをmilu",
  description: "miluだけで育児がまとまる。授乳も成長曲線も予防接種もまとめて管理できる育児記録アプリです。",
};

export default function Home() {
  // 静的記事データ定義
  const latestArticles = [
    {
      slug: "baby-breastfeeding-schedule",
      title: "赤ちゃんの授乳スケジュールと目安量について",
      description: "新生児から1歳頃までの授乳回数やミルクの量の目安、スケジュール調整のコツを分かりやすく解説します。",
      category: "授乳・食事",
      publishedAt: "2026/06/09",
    },
    {
      slug: "baby-vaccination-schedule",
      title: "赤ちゃんの予防接種スケジュール管理と進め方のコツ",
      description:
        "生後2ヶ月から始まる赤ちゃんの予防接種。種類が多くて複雑な予防接種スケジュールを漏れなくスムーズに進めるための方法を解説します。",
      category: "予防接種",
      publishedAt: "2026/06/09",
    },
  ];

  return (
    <>
      {/* Hero Section */}
      <section className="min-h-screen flex items-center px-6 pt-[120px] pb-20 bg-gradient-to-b from-bg-cream via-bg-pink to-white relative overflow-hidden">
        {/* 背景のラジアルグラデーション */}
        <div className="absolute top-[-50%] right-[-20%] w-[80%] h-[150%] bg-[radial-gradient(ellipse,rgba(255,143,163,0.15)_0%,transparent_60%)] pointer-events-none"></div>

        <div className="max-w-[1200px] mx-auto grid grid-cols-1 lg:grid-cols-2 gap-12 lg:gap-16 items-center w-full relative z-10">
          <div className="text-center lg:text-left">
            <div className="hero-badge animate-fade-in inline-flex items-center gap-2 bg-white border border-border-pink py-2 px-4 rounded-full text-sm font-semibold text-primary-dark mb-6 shadow-soft">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" className="w-4 h-4">
                <path d="M11.645 20.91l-.007-.003-.022-.012a15.247 15.247 0 01-.383-.218 25.18 25.18 0 01-4.244-3.17C4.688 15.36 2.25 12.174 2.25 8.25 2.25 5.322 4.714 3 7.688 3A5.5 5.5 0 0112 5.052 5.5 5.5 0 0116.313 3c2.973 0 5.437 2.322 5.437 5.25 0 3.925-2.438 7.111-4.739 9.256a25.175 25.175 0 01-4.244 3.17 15.247 15.247 0 01-.383.219l-.022.012-.007.004-.003.001a.752.752 0 01-.704 0l-.003-.001z" />
              </svg>
              赤ちゃんをmilu あなたをmilu
            </div>
            <h1 className="hero-title animate-fade-in delay-100 text-[36px] md:text-[56px] font-bold leading-tight mb-6 text-text-main tracking-tight font-fredoka">
              <span className="text-primary relative">milu</span>だけで
              <br />
              <span className="relative after:content-[''] after:absolute after:bottom-1 after:left-0 after:right-0 after:h-3 after:bg-secondary after:rounded-sm after:-z-10">
                育児がまとまる
              </span>
            </h1>
            <p className="hero-description animate-fade-in delay-200 text-lg text-text-light mb-10 max-w-[480px] mx-auto lg:mx-0 leading-relaxed">
              授乳も成長曲線も予防接種も、まとめて管理。
              <br />
              忙しい毎日の育児をシンプルにサポートします。
            </p>
            <div className="store-buttons animate-fade-in delay-300 flex gap-3 justify-center lg:justify-start items-center">
              <a
                href="https://apps.apple.com/jp/app/milu-%E8%B5%A4%E3%81%A1%E3%82%83%E3%82%93%E3%81%AE%E6%8E%88%E4%B9%B3%E8%A8%98%E9%8C%B2%E3%81%A8%E4%BA%88%E9%98%B2%E6%8E%A5%E7%A8%AE%E7%AE%A1%E7%90%86/id6754955821?l=en-US"
                className="h-[38px] sm:h-12 transition-transform hover:-translate-y-0.5 hover:shadow-md"
                target="_blank"
                rel="noopener noreferrer"
              >
                <img
                  src="/assets/images/Download_on_the_App_Store_Badge_JP_RGB_blk_100317.svg"
                  alt="App Storeからダウンロード"
                  className="h-full w-auto"
                />
              </a>
              <a
                href="https://play.google.com/store/apps/details?id=com.aphlo.babymomdiary"
                className="h-[38px] sm:h-12 transition-transform hover:-translate-y-0.5 hover:shadow-md"
                target="_blank"
                rel="noopener noreferrer"
              >
                <img
                  src="/assets/images/GetItOnGooglePlay_Badge_Web_color_Japanese.svg"
                  alt="Google Playで手に入れよう"
                  className="h-full w-auto"
                />
              </a>
            </div>
          </div>
          <div className="hero-visual animate-fade-in delay-400 flex justify-center items-center relative">
            <div className="phone-mockup-container relative flex justify-center items-center">
              <div className="floating-decoration decoration-1 absolute rounded-full bg-secondary opacity-60 w-[120px] h-[120px] -top-5 -right-10"></div>
              <div className="floating-decoration decoration-2 absolute rounded-full bg-primary-light opacity-60 w-20 h-20 bottom-10 -left-7"></div>
              <div className="floating-decoration decoration-3 absolute rounded-full bg-accent/30 opacity-60 w-10 h-10 top-[40%] -right-[60px]"></div>
              <div className="mascot mascot-bear absolute z-10 pointer-events-none filter drop-shadow-md w-[150px] md:w-[280px] -left-[120px] md:-left-[250px] -bottom-10">
                <img src="/assets/images/milu_bear.png" alt="miluベアー" className="w-full h-auto" />
              </div>
              <div className="mascot mascot-cat absolute z-10 pointer-events-none filter drop-shadow-md w-[120px] md:w-[220px] -right-[100px] md:-right-[200px] bottom-0">
                <img src="/assets/images/milu_cat.png" alt="miluキャット" className="w-full h-auto" />
              </div>
              <div className="phone-mockup relative w-[280px] h-[580px] md:w-[320px] md:h-[660px] bg-gradient-to-br from-[#2D2D2D] to-[#1A1A1A] rounded-[44px] p-3 shadow-[0_50px_100px_rgba(31,41,55,0.3),0_20px_60px_rgba(255,143,163,0.15)] border border-white/10">
                <div className="phone-screen w-full h-full bg-white rounded-[36px] overflow-hidden flex items-center justify-center relative">
                  <img
                    src="/assets/images/home_page.png"
                    alt="miluホーム画面"
                    className="w-full h-full object-cover object-top"
                  />
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="py-24 px-6 bg-white relative">
        <div className="section-header animate-fade-in text-center max-w-[600px] mx-auto mb-16">
          <h2 className="section-title text-3xl md:text-4xl font-bold mb-4 text-text-main font-fredoka">
            <span className="text-primary">milu</span>の特徴
          </h2>
          <p className="section-description text-base text-text-light">育児に必要な機能がすべて揃っています</p>
        </div>
        <div className="features-grid max-w-[1100px] mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <div className="feature-card animate-fade-in delay-100 bg-white border border-border-pink rounded-lg p-8 transition-all hover:-translate-y-1 hover:shadow-hover hover:border-primary-light cursor-pointer">
            <div className="feature-icon w-14 h-14 bg-gradient-to-br from-bg-pink to-secondary rounded-md flex items-center justify-center mb-5 text-primary-dark">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                className="w-7 h-7"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M9.75 3.104v5.714a2.25 2.25 0 01-.659 1.591L5 14.5M9.75 3.104c-.251.023-.501.05-.75.082m.75-.082a24.301 24.301 0 014.5 0m0 0v5.714c0 .597.237 1.17.659 1.591L19.8 15.3M14.25 3.104c.251.023.501.05.75.082M19.8 15.3l-1.57.393A9.065 9.065 0 0112 15a9.065 9.065 0 00-6.23.693L5 14.5m14.8.8l1.402 1.402c1.232 1.232.65 3.318-1.067 3.611A48.309 48.309 0 0112 21c-2.773 0-5.491-.235-8.135-.687-1.718-.293-2.3-2.379-1.067-3.61L5 14.5"
                />
              </svg>
            </div>
            <h3 className="feature-title text-xl font-semibold mb-3 text-text-main font-fredoka">授乳・ミルク記録</h3>
            <p className="feature-description text-[15px] text-text-light leading-relaxed">
              授乳時間やミルクの量をワンタップで簡単記録。毎日の授乳リズムが一目でわかります。
            </p>
          </div>
          <div className="feature-card animate-fade-in delay-200 bg-white border border-border-pink rounded-lg p-8 transition-all hover:-translate-y-1 hover:shadow-hover hover:border-primary-light cursor-pointer">
            <div className="feature-icon w-14 h-14 bg-gradient-to-br from-bg-pink to-secondary rounded-md flex items-center justify-center mb-5 text-primary-dark">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                className="w-7 h-7"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M2.25 18L9 11.25l4.306 4.307a11.95 11.95 0 015.814-5.519l2.74-1.22m0 0l-5.94-2.28m5.94 2.28l-2.28 5.941"
                />
              </svg>
            </div>
            <h3 className="feature-title text-xl font-semibold mb-3 text-text-main font-fredoka">成長曲線</h3>
            <p className="feature-description text-[15px] text-text-light leading-relaxed">
              身長・体重を記録して成長曲線をチェック。お子さまの成長を可視化できます。
            </p>
          </div>
          <div className="feature-card animate-fade-in delay-300 bg-white border border-border-pink rounded-lg p-8 transition-all hover:-translate-y-1 hover:shadow-hover hover:border-primary-light cursor-pointer">
            <div className="feature-icon w-14 h-14 bg-gradient-to-br from-bg-pink to-secondary rounded-md flex items-center justify-center mb-5 text-primary-dark">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                className="w-7 h-7"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M9 12.75L11.25 15 15 9.75m-3-7.036A11.959 11.959 0 013.598 6 11.99 11.99 0 003 9.749c0 5.592 3.824 10.29 9 11.623 5.176-1.332 9-6.03 9-11.622 0-1.31-.21-2.571-.598-3.751h-.152c-3.196 0-6.1-1.248-8.25-3.285z"
                />
              </svg>
            </div>
            <h3 className="feature-title text-xl font-semibold mb-3 text-text-main font-fredoka">予防接種管理</h3>
            <p className="feature-description text-[15px] text-text-light leading-relaxed">
              複雑な予防接種スケジュールを自動で管理。接種漏れを防いで安心です。
            </p>
          </div>
          <div className="feature-card animate-fade-in delay-100 bg-white border border-border-pink rounded-lg p-8 transition-all hover:-translate-y-1 hover:shadow-hover hover:border-primary-light cursor-pointer">
            <div className="feature-icon w-14 h-14 bg-gradient-to-br from-bg-pink to-secondary rounded-md flex items-center justify-center mb-5 text-primary-dark">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                className="w-7 h-7"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 012.25-2.25h13.5A2.25 2.25 0 0121 7.5v11.25m-18 0A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75m-18 0v-7.5A2.25 2.25 0 015.25 9h13.5A2.25 2.25 0 0121 11.25v7.5m-9-6h.008v.008H12v-.008zM12 15h.008v.008H12V15zm0 2.25h.008v.008H12v-.008zM9.75 15h.008v.008H9.75V15zm0 2.25h.008v.008H9.75v-.008zM7.5 15h.008v.008H7.5V15zm0 2.25h.008v.008H7.5v-.008zm6.75-4.5h.008v.008h-.008v-.008zm0 2.25h.008v.008h-.008V15zm0 2.25h.008v.008h-.008v-.008zm2.25-4.5h.008v.008H16.5v-.008zm0 2.25h.008v.008H16.5V15z"
                />
              </svg>
            </div>
            <h3 className="feature-title text-xl font-semibold mb-3 text-text-main font-fredoka">カレンダー</h3>
            <p className="feature-description text-[15px] text-text-light leading-relaxed">
              予防接種の日程や行事をカレンダーで一括管理。大切な予定を見逃しません。
            </p>
          </div>
          <div className="feature-card animate-fade-in delay-200 bg-white border border-border-pink rounded-lg p-8 transition-all hover:-translate-y-1 hover:shadow-hover hover:border-primary-light cursor-pointer">
            <div className="feature-icon w-14 h-14 bg-gradient-to-br from-bg-pink to-secondary rounded-md flex items-center justify-center mb-5 text-primary-dark">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                className="w-7 h-7"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M15 19.128a9.38 9.38 0 002.625.372 9.337 9.337 0 004.121-.952 4.125 4.125 0 00-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 018.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0111.964-3.07M12 6.375a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zm8.25 2.25a2.625 2.625 0 11-5.25 0 2.625 2.625 0 015.25 0z"
                />
              </svg>
            </div>
            <h3 className="feature-title text-xl font-semibold mb-3 text-text-main font-fredoka">パートナー共有</h3>
            <p className="feature-description text-[15px] text-text-light leading-relaxed">
              パートナーと育児を共有できる。二人で協力して育児に取り組めます。
            </p>
          </div>
          <div className="feature-card animate-fade-in delay-300 bg-white border border-border-pink rounded-lg p-8 transition-all hover:-translate-y-1 hover:shadow-hover hover:border-primary-light cursor-pointer">
            <div className="feature-icon w-14 h-14 bg-gradient-to-br from-bg-pink to-secondary rounded-md flex items-center justify-center mb-5 text-primary-dark">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                className="w-7 h-7"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M9.813 15.904L9 18.75l-.813-2.846a4.5 4.5 0 00-3.09-3.09L2.25 12l2.846-.813a4.5 4.5 0 003.09-3.09L9 5.25l.813 2.846a4.5 4.5 0 003.09 3.09L15.75 12l-2.846.813a4.5 4.5 0 00-3.09 3.09zM18.259 8.715L18 9.75l-.259-1.035a3.375 3.375 0 00-2.455-2.456L14.25 6l1.036-.259a3.375 3.375 0 002.455-2.456L18 2.25l.259 1.035a3.375 3.375 0 002.456 2.456L21.75 6l-1.035.259a3.375 3.375 0 00-2.456 2.456zM16.894 20.567L16.5 21.75l-.394-1.183a2.25 2.25 0 00-1.423-1.423L13.5 18.75l1.183-.394a2.25 2.25 0 001.423-1.423l.394-1.183.394 1.183a2.25 2.25 0 001.423 1.423l1.183.394-1.183.394a2.25 2.25 0 00-1.423 1.423z"
                />
              </svg>
            </div>
            <h3 className="feature-title text-xl font-semibold mb-3 text-text-main font-fredoka">シンプル設計</h3>
            <p className="feature-description text-[15px] text-text-light leading-relaxed">
              忙しい育児中でも迷わず使える。シンプルで直感的なデザインです。
            </p>
          </div>
        </div>
      </section>

      {/* App Showcase Section */}
      <section className="py-24 px-6 bg-gradient-to-b from-white to-bg-pink">
        <div className="showcase-container max-w-[1200px] mx-auto">
          <div className="showcase-grid grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
            <div className="showcase-content order-2 lg:order-1 animate-fade-in">
              <h2 className="showcase-title text-2xl md:text-3xl font-bold mb-6 text-text-main font-fredoka leading-snug">
                すべての育児記録を
                <br />
                <span className="text-primary">ひとつのアプリで</span>
              </h2>
              <p className="showcase-description text-base text-text-light mb-8 leading-relaxed">
                複数のアプリを使い分ける必要はありません。
                <br />
                miluだけで、育児のすべてを管理できます。
              </p>
              <div className="benefit-list flex flex-col gap-4">
                <div className="benefit-item flex items-start gap-4 p-4 px-5 bg-white rounded-md shadow-soft transition-transform hover:translate-x-1 hover:shadow-card cursor-pointer">
                  <div className="benefit-icon w-11 h-11 bg-gradient-to-br from-primary-light to-primary rounded-md flex items-center justify-center flex-shrink-0 text-white">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                      className="w-5.5 h-5.5"
                    >
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                    </svg>
                  </div>
                  <div className="benefit-text">
                    <h4 className="text-base font-semibold text-text-main mb-1">まとめて管理</h4>
                    <p className="text-sm text-text-light">授乳・成長曲線・予防接種を一括管理</p>
                  </div>
                </div>
                <div className="benefit-item flex items-start gap-4 p-4 px-5 bg-white rounded-md shadow-soft transition-transform hover:translate-x-1 hover:shadow-card cursor-pointer">
                  <div className="benefit-icon w-11 h-11 bg-gradient-to-br from-primary-light to-primary rounded-md flex items-center justify-center flex-shrink-0 text-white">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                      className="w-5.5 h-5.5"
                    >
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                    </svg>
                  </div>
                  <div className="benefit-text">
                    <h4 className="text-base font-semibold text-text-main mb-1">カレンダー連携</h4>
                    <p className="text-sm text-text-light">予防接種の日程や行事を一目で確認</p>
                  </div>
                </div>
                <div className="benefit-item flex items-start gap-4 p-4 px-5 bg-white rounded-md shadow-soft transition-transform hover:translate-x-1 hover:shadow-card cursor-pointer">
                  <div className="benefit-icon w-11 h-11 bg-gradient-to-br from-primary-light to-primary rounded-md flex items-center justify-center flex-shrink-0 text-white">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                      className="w-5.5 h-5.5"
                    >
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                    </svg>
                  </div>
                  <div className="benefit-text">
                    <h4 className="text-base font-semibold text-text-main mb-1">家族で共有</h4>
                    <p className="text-sm text-text-light">パートナーとリアルタイムで情報共有</p>
                  </div>
                </div>
              </div>
            </div>
            <div className="showcase-visual order-1 lg:order-2 flex justify-center gap-6 flex-wrap animate-fade-in delay-200">
              <div className="showcase-phone w-[220px] h-[460px] bg-gradient-to-br from-[#2D2D2D] to-[#1A1A1A] rounded-[36px] p-2 shadow-card">
                <div className="showcase-phone-screen w-full h-full bg-white rounded-[30px] overflow-hidden flex items-center justify-center">
                  <img
                    src="/assets/images/growth_curve.png"
                    alt="成長曲線"
                    className="w-full h-full object-cover object-top"
                  />
                </div>
              </div>
              <div className="showcase-phone w-[220px] h-[460px] bg-gradient-to-br from-[#2D2D2D] to-[#1A1A1A] rounded-[36px] p-2 shadow-card mt-10">
                <div className="showcase-phone-screen w-full h-full bg-white rounded-[30px] overflow-hidden flex items-center justify-center">
                  <img
                    src="/assets/images/vaccine_page.png"
                    alt="予防接種管理"
                    className="w-full h-full object-cover object-top"
                  />
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Latest Columns Section */}
      {latestArticles.length > 0 && (
        <section className="py-24 px-6 bg-bg-pink border-t border-b border-border-pink">
          <div className="section-header animate-fade-in text-center max-w-[600px] mx-auto mb-16">
            <h2 className="section-title text-3xl md:text-4xl font-bold mb-4 text-text-main font-fredoka">
              <span className="text-primary">お役立ち</span>記事・コラム
            </h2>
            <p className="section-description text-base text-text-light">
              育児の不安を解消する、お役立ち記事・コラムを配信中
            </p>
          </div>
          <div className="features-grid max-w-[1100px] mx-auto grid grid-cols-1 md:grid-cols-2 gap-6">
            {latestArticles.map((art, idx) => (
              <div
                key={art.slug}
                className={`feature-card animate-fade-in delay-${(idx + 1) * 100} bg-white border border-border-pink rounded-lg p-8 transition-all hover:-translate-y-1 hover:shadow-hover hover:border-primary-light cursor-pointer flex flex-col justify-between h-full`}
                style={{ minHeight: "260px" }}
              >
                <div>
                  <span className="text-[11px] bg-bg-pink text-primary-dark py-0.5 px-2.5 rounded-full font-bold inline-block mb-3">
                    {art.category}
                  </span>
                  <h3 className="feature-title text-lg font-bold mb-3 text-text-main font-fredoka">{art.title}</h3>
                  <p className="feature-description text-sm text-text-light leading-relaxed line-clamp-3 mb-4">
                    {art.description}
                  </p>
                </div>
                <div className="mt-4">
                  <Link
                    href={`/columns/${art.slug}`}
                    className="text-primary-dark font-bold hover:underline inline-flex items-center gap-1"
                  >
                    詳しく読む →
                  </Link>
                </div>
              </div>
            ))}
          </div>
        </section>
      )}

      {/* CTA Section */}
      <section className="py-24 px-6 bg-gradient-to-br from-primary to-primary-dark text-center text-white relative overflow-hidden">
        {/* 背景光効果 */}
        <div className="absolute top-[-50%] left-[-50%] w-[200%] h-[200%] bg-[radial-gradient(ellipse_at_center,rgba(255,255,255,0.1)_0%,transparent_50%)] pointer-events-none"></div>

        <div className="cta-content max-w-[600px] mx-auto relative z-10 animate-fade-in">
          <h2 className="cta-title text-3xl md:text-4xl font-bold mb-4 font-fredoka leading-snug">
            今すぐmiluをはじめよう
          </h2>
          <p className="cta-description text-lg mb-10 opacity-90 leading-relaxed">
            無料でダウンロードして、育児をもっとシンプルに。
          </p>
          <div className="store-buttons flex gap-3 justify-center items-center">
            <a
              href="https://apps.apple.com/jp/app/milu-%E8%B5%A4%E3%81%A1%E3%82%83%E3%82%93%E3%81%AE%E6%8E%88%E4%B9%B3%E8%A8%98%E9%8C%B2%E3%81%A8%E4%BA%88%E9%98%B2%E6%8E%A5%E7%A8%AE%E7%AE%A1%E7%90%86/id6754955821?l=en-US"
              className="h-[38px] sm:h-12 transition-transform hover:-translate-y-0.5 hover:shadow-md"
              target="_blank"
              rel="noopener noreferrer"
            >
              <img
                src="/assets/images/Download_on_the_App_Store_Badge_JP_RGB_blk_100317.svg"
                alt="App Storeからダウンロード"
                className="h-full w-auto"
              />
            </a>
            <a
              href="https://play.google.com/store/apps/details?id=com.aphlo.babymomdiary"
              className="h-[38px] sm:h-12 transition-transform hover:-translate-y-0.5 hover:shadow-md"
              target="_blank"
              rel="noopener noreferrer"
            >
              <img
                src="/assets/images/GetItOnGooglePlay_Badge_Web_color_Japanese.svg"
                alt="Google Playで手に入れよう"
                className="h-full w-auto"
              />
            </a>
          </div>
        </div>
      </section>

      <ScrollAnimate />
    </>
  );
}

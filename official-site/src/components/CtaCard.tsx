export default function CtaCard() {
  return (
    <div className="mt-14 bg-gradient-to-br from-bg-pink to-secondary rounded-lg p-6 md:p-8 border border-border-pink text-center shadow-soft animate-fade-in">
      <div className="inline-block bg-primary text-white py-1 px-3 rounded-full text-xs font-bold mb-3">
        育児管理アプリ
      </div>
      <h2 className="text-2xl text-text-main font-bold mb-3 font-fredoka">
        赤ちゃんをmilu あなたをmilu <span className="text-primary-dark">「milu」</span>
      </h2>
      <p className="text-sm text-text-light mb-6 leading-relaxed max-w-[600px] mx-auto">
        授乳も、成長曲線も、予防接種も。育児に必要なすべての記録をひとつのアプリでスマートに管理。パートナーともリアルタイムで共有できます。
      </p>
      <div className="flex gap-3 justify-center items-center">
        <a
          href="https://apps.apple.com/jp/app/milu-%E8%B5%A4%E3%81%A1%E3%82%83%E3%82%93%E3%81%AE%E6%8E%88%E4%B9%B3%E8%A8%98%E9%8C%B2%E3%81%A8%E4%BA%88%E9%98%B2%E6%8E%A5%E7%A8%AE%E7%AE%A1%E7%90%86/id6754955821?l=en-US"
          className="h-[38px] sm:h-12 transition-transform hover:-translate-y-1 hover:drop-shadow-md"
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
          className="h-[38px] sm:h-12 transition-transform hover:-translate-y-1 hover:drop-shadow-md"
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
  );
}

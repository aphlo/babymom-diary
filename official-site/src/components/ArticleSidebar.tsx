import Link from "next/link";

interface Props {
  currentSlug: string;
}

export default function ArticleSidebar({ currentSlug }: Props) {
  const allArticles = [
    {
      slug: "baby-breastfeeding-schedule",
      title: "赤ちゃんの授乳スケジュールと目安量について",
      category: "授乳・食事",
      publishedAt: "2026/06/09",
    },
    {
      slug: "baby-vaccination-schedule",
      title: "赤ちゃんの予防接種スケジュール管理と進め方のコツ",
      category: "予防接種",
      publishedAt: "2026/06/09",
    },
  ];

  const relatedArticles = allArticles.filter((art) => art.slug !== currentSlug);

  return (
    <aside className="flex flex-col gap-6">
      {relatedArticles.length > 0 && (
        <div className="bg-white border border-border-pink rounded-md p-6 shadow-soft">
          <h3 className="text-lg font-bold text-text-main mb-5 border-l-4 border-primary pl-2.5">おすすめの記事</h3>
          <div className="flex flex-col gap-4">
            {relatedArticles.map((art) => (
              <Link
                href={`/columns/${art.slug}`}
                key={art.slug}
                className="block pb-4 border-b border-border-pink last:border-b-0 last:pb-0 transition-colors group"
              >
                <span className="text-[11px] bg-bg-pink text-primary-dark py-0.5 px-2 rounded-full font-bold inline-block mb-1.5">
                  {art.category}
                </span>
                <h4 className="text-sm font-semibold text-text-main leading-snug mb-1 group-hover:text-primary-dark transition-colors">
                  {art.title}
                </h4>
                <time className="text-xs text-text-muted">{art.publishedAt}</time>
              </Link>
            ))}
          </div>
        </div>
      )}
      <div className="bg-gradient-to-br from-bg-pink to-white border border-border-pink rounded-md p-8 text-center shadow-soft">
        <img
          src="/assets/images/favicon.png"
          alt="miluアイコン"
          className="w-16 h-16 rounded-xl mx-auto mb-4 shadow-soft"
        />
        <h4 className="text-base font-bold text-text-main mb-1">育児記録アプリ「milu」</h4>
        <p className="text-xs text-text-light mb-5">これひとつで育児記録がまとまる</p>
        <div className="flex gap-3 justify-center items-center">
          <a
            href="https://apps.apple.com/jp/app/milu-%E8%B5%A4%E3%81%A1%E3%82%83%E3%82%93%E3%81%AE%E6%8E%88%E4%B9%B3%E8%A8%98%E9%8C%B2%E3%81%A8%E4%BA%88%E9%98%B2%E6%8E%A5%E7%A8%AE%E7%AE%A1%E7%90%86/id6754955821?l=en-US"
            target="_blank"
            className="h-[34px] sm:h-9 transition-transform hover:-translate-y-0.5 hover:shadow-md"
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
            target="_blank"
            className="h-[34px] sm:h-9 transition-transform hover:-translate-y-0.5 hover:shadow-md"
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
    </aside>
  );
}

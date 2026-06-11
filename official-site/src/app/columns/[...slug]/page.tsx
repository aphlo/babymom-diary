import { Metadata } from "next";
import { notFound } from "next/navigation";
import ArticleSidebar from "../../../components/ArticleSidebar";
import Article1 from "../../../components/articles/Article1";
import Article2 from "../../../components/articles/Article2";
import CtaCard from "../../../components/CtaCard";
import SupervisorProfile from "../../../components/SupervisorProfile";
import { articles, LARGE_CATEGORIES, SUB_CATEGORIES } from "../../../data/articles";

type Props = {
  params: Promise<{ slug: string[] }>;
};

export async function generateStaticParams() {
  return articles.map((art) => ({
    slug: art.slugs,
  }));
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { slug } = await params;
  const article = articles.find((art) => art.slugs.join("/") === slug.join("/"));

  if (!article) {
    return {};
  }

  return {
    title: article.title,
    description: article.description,
    keywords: article.keywords,
    openGraph: {
      title: `${article.title} | milu`,
      description: article.description,
      type: "article",
      publishedTime: article.publishedAt.replace(/\//g, "-"),
    },
  };
}

const ArticleContent = ({ id }: { id: number }) => {
  switch (id) {
    case 1:
      return <Article1 />;
    case 2:
      return <Article2 />;
    default:
      return null;
  }
};

export default async function ArticlePage({ params }: Props) {
  const { slug } = await params;
  const article = articles.find((art) => art.slugs.join("/") === slug.join("/"));

  if (!article) {
    notFound();
  }

  const categoryName = article.subCategory
    ? SUB_CATEGORIES[article.subCategory as keyof typeof SUB_CATEGORIES]
    : LARGE_CATEGORIES[article.largeCategory];

  return (
    <div className="pt-[100px] bg-bg-cream min-h-screen">
      <div className="bg-gradient-to-b from-bg-pink to-white/50 py-14 px-6 text-center border-b border-border-pink">
        <div className="max-w-[800px] mx-auto animate-fade-in">
          <div className="flex justify-center items-center gap-3 mb-4 text-sm">
            <span className="bg-primary text-white py-1 px-3 rounded-full font-semibold text-xs">{categoryName}</span>
            <time className="text-text-light" dateTime={article.publishedAt.replace(/\//g, "-")}>
              {article.publishedAt}
            </time>
          </div>
          <h1 className="text-3xl md:text-4xl text-text-main font-bold leading-snug mb-4 font-fredoka">
            {article.title}
          </h1>
          <p className="text-text-light text-base max-w-[600px] mx-auto leading-relaxed">{article.description}</p>
        </div>
      </div>

      <div className="max-w-[1200px] mx-auto py-10 px-6 grid grid-cols-1 lg:grid-cols-[2fr_1fr] gap-10">
        <main className="bg-white border border-border-pink rounded-lg p-6 md:p-10 shadow-soft">
          <article className="text-text-main text-base leading-relaxed">
            <ArticleContent id={article.id} />
          </article>

          {/* 監修者プロフィール */}
          <SupervisorProfile />

          {/* 流入導線 CTA */}
          <CtaCard />
        </main>

        {/* 関連記事のサイドバー */}
        <ArticleSidebar currentSlug={article.slugs.join("/")} />
      </div>
    </div>
  );
}

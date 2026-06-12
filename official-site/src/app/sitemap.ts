import type { MetadataRoute } from "next";
import { articles } from "src/data/articles";
import { municipalities } from "src/data/municipalities";

export const dynamic = "force-static";

export default function sitemap(): MetadataRoute.Sitemap {
  // 環境変数 NEXT_PUBLIC_SITE_URL を使用し、無ければデフォルトの仮ドメインを使用
  const baseUrl = process.env.NEXT_PUBLIC_SITE_URL || "https://milu-baby.app";

  const lastModified = new Date();

  // 静的ページの一覧
  const staticPaths = ["", "/about", "/inquiry", "/privacy", "/terms", "/tokushoho", "/columns", "/support"];

  const staticEntries = staticPaths.map((path) => ({
    url: `${baseUrl}${path}`,
    lastModified,
    changeFrequency: (path === "" ? "daily" : "monthly") as "daily" | "monthly",
    priority: path === "" ? 1.0 : 0.8,
  }));

  // コラム記事の一覧
  const articleEntries = articles.map((article) => ({
    url: `${baseUrl}/columns/${article.slugs.join("/")}`,
    lastModified: new Date(article.publishedAt),
    changeFrequency: "monthly" as const,
    priority: 0.6,
  }));

  // 自治体別（都道府県別）ページの一覧
  const prefectureSlugs = Array.from(new Set(municipalities.map((m) => m.prefectureSlug)));
  const prefectureEntries = prefectureSlugs.map((pref) => ({
    url: `${baseUrl}/support/${pref}`,
    lastModified,
    changeFrequency: "weekly" as const,
    priority: 0.5,
  }));

  // 自治体別（市区町村別）詳細ページの一覧
  const cityEntries = municipalities.map((m) => ({
    url: `${baseUrl}/support/${m.prefectureSlug}/${m.citySlug}`,
    lastModified,
    changeFrequency: "weekly" as const,
    priority: 0.6,
  }));

  return [...staticEntries, ...articleEntries, ...prefectureEntries, ...cityEntries];
}

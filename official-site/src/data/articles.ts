export interface Article {
  id: number;
  slugs: string[]; // URLパスの構成要素（例: ['childcare', 'breastfeeding', '1']）
  title: string;
  description: string;
  keywords?: string;
  largeCategory: 'pregnancy' | 'childbirth' | 'postpartum' | 'childcare';
  subCategory?: 'breastfeeding' | 'vaccination' | string;
  publishedAt: string;
}

export const LARGE_CATEGORIES = {
  pregnancy: '妊娠',
  childbirth: '出産',
  postpartum: '産後',
  childcare: '育児',
} as const;

export const SUB_CATEGORIES = {
  breastfeeding: '授乳関係',
  vaccination: '予防接種',
} as const;

export const articles: Article[] = [
  {
    id: 1,
    slugs: ['childcare', 'breastfeeding', '1'],
    title: '赤ちゃんの授乳スケジュールと目安量について',
    description: '新生児から1歳頃までの授乳回数やミルクの量の目安、スケジュール調整のコツを分かりやすく解説します。',
    keywords: '授乳, ミルク, 赤ちゃん, スケジュール, 目安量',
    largeCategory: 'childcare',
    subCategory: 'breastfeeding',
    publishedAt: '2026/06/09',
  },
  {
    id: 2,
    slugs: ['childcare', 'vaccination', '2'],
    title: '赤ちゃんの予防接種スケジュール管理と進め方のコツ',
    description: '生後2ヶ月から始まる赤ちゃんの予防接種。種類が多くて複雑な予防接種スケジュールを漏れなくスムーズに進めるための方法を解説します。',
    keywords: '予防接種, 赤ちゃん, スケジュール, 同時接種',
    largeCategory: 'childcare',
    subCategory: 'vaccination',
    publishedAt: '2026/06/09',
  },
];

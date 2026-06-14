import * as fs from "fs";
import * as path from "path";
import { municipalities as existingMunicipalities } from "../src/data/municipalities";

// ExcelからパースしたJSONデータのパス
const dataJsonPath = "/Users/koumi/.gemini/antigravity/brain/272bd092-9166-437b-97c1-cc73c2ad74f6/scratch/data.json";
const rawData = fs.readFileSync(dataJsonPath, "utf-8");
const excelData = JSON.parse(rawData);

// ローマ字・Slugのマッピング辞書
const PREFECTURE_SLUGS: Record<string, string> = {
  東京都: "tokyo",
  神奈川県: "kanagawa",
  埼玉県: "saitama",
  千葉県: "chiba",
  大阪府: "osaka",
  愛知県: "aichi",
  福岡県: "fukuoka",
  北海道: "hokkaido",
};

const CITY_SLUGS: Record<string, string> = {
  さいたま市: "saitama",
  三鷹市: "mitaka",
  世田谷区: "setagaya",
  中央区: "chuo",
  中野区: "nakano",
  八王子市: "hachioji",
  北区: "kita",
  千代田区: "chiyoda",
  千葉市: "chiba",
  台東区: "taito",
  名古屋市: "nagoya",
  品川区: "shinagawa",
  墨田区: "sumida",
  大田区: "ota",
  大阪市: "osaka",
  川口市: "kawaguchi",
  川崎市: "kawasaki",
  市川市: "ichikawa",
  所沢市: "tokorozawa",
  文京区: "bunkyo",
  新宿区: "shinjuku",
  札幌市: "sapporo",
  杉並区: "suginami",
  板橋区: "itabashi",
  柏市: "kashiwa",
  武蔵野市: "musashino",
  江戸川区: "edogawa",
  江東区: "koto",
  渋谷区: "shibuya",
  港区: "minato",
  目黒区: "meguro",
  相模原市: "sagamihara",
  福岡市: "fukuoka",
  立川市: "tachikawa",
  練馬区: "nerima",
  船橋市: "funabashi",
  荒川区: "arakawa",
  葛飾区: "katsushika",
  藤沢市: "fujisawa",
  調布市: "chofu",
  豊島区: "toshima",
  足立区: "adachi",
};

// 共通給付金（都道府県別）
const COMMON_BENEFITS: Record<string, any[]> = {
  tokyo: [
    {
      source: "国",
      name: "児童手当",
      amount: "月額10,000円〜15,000円（※第3子以降は30,000円）",
      target: "0歳から高校生年代（18歳到達後の最初の3月31日）までのお子さん",
      description:
        "3歳未満は月15,000円、3歳〜高校生年代は月10,000円が支給されます。所得制限は完全に撤廃されました。偶数月に年6回、前月分までが振り込まれます。",
    },
    {
      source: "国",
      name: "出産育児一時金",
      amount: "500,000円 / 子ども1人あたり",
      target: "健康保険の被保険者・被扶養者で、妊娠4ヶ月以上で出産された方",
      description: "健康保険より出産費用として一律支給。直接支払制度により退院時の窓口支払いを抑えられます。",
    },
    {
      source: "国",
      name: "出産・子育て応援ギフト",
      amount: "合計100,000円相当（出産5万円分 ＋ 子育て5万円分）",
      target: "全ての妊婦の方、および乳児の保護者",
      description:
        "面談を受けた妊婦（5万円相当）および出生届出後の保護者（5万円相当）へ、それぞれギフトカード等が支給されます。",
    },
    {
      source: "東京都",
      name: "018（ゼロイチハチ）サポート",
      amount: "月額5,000円（年額最大60,000円を一括支給）",
      target: "都内に在住する0歳から18歳に達する最初の3月31日までのお子さん",
      description: "東京都独自の所得制限なしの給付金。都内に在住する期間に応じて年1回一括で支給されます。",
    },
    {
      source: "東京都",
      name: "東京都出産応援事業（赤ちゃんファースト）",
      amount: "100,000円相当の専用ポイント",
      target: "都内に在住し、出産した世帯",
      description:
        "国のギフト（5万円相当）に都が5万円相当を独自に上乗せし、計10万円分のベビー用品等と交換できるポイントを付与します。",
    },
  ],
  kanagawa: [
    {
      source: "国",
      name: "児童手当",
      amount: "月額10,000円〜15,000円（※第3子以降は30,000円）",
      target: "0歳から高校生年代（18歳到達後の最初の3月31日）までのお子さん",
      description:
        "3歳未満は月15,000円、3歳〜高校生年代は月10,000円が支給されます。所得制限は完全に撤廃されました。偶数月に年6回、前月分までが振り込まれます。",
    },
    {
      source: "国",
      name: "出産育児一時金",
      amount: "500,000円 / 子ども1人あたり",
      target: "健康保険の被保険者・被扶養者で、妊娠4ヶ月以上で出産された方",
      description: "健康保険より出産費用として一律支給。直接支払制度により退院時の窓口支払いを抑えられます。",
    },
    {
      source: "国",
      name: "出産・子育て応援ギフト",
      amount: "合計100,000円相当（出産5万円分 ＋ 子育て5万円分）",
      target: "全ての妊婦の方、および乳児の保護者",
      description:
        "面談を受けた妊婦（5万円相当）および出生届出後の保護者（5万円相当）へ、それぞれギフトカード等が支給されます。",
    },
    {
      source: "神奈川県",
      name: "かながわ子育て応援パスポート",
      amount: "優待サービス・割引など",
      target: "神奈川県内在住の妊娠中の方、または学校就学前の子どもの保護者",
      description:
        "協賛店（店舗や施設）でパスポート画面を提示すると、割引や優待サービス、粉ミルク用のお湯の提供などの各種サービスが受けられます。",
    },
  ],
  saitama: [
    {
      source: "国",
      name: "児童手当",
      amount: "月額10,000円〜15,000円（※第3子以降は30,000円）",
      target: "0歳から高校生年代（18歳到達後の最初の3月31日）までのお子さん",
      description:
        "3歳未満は月15,000円、3歳〜高校生年代は月10,000円が支給されます。所得制限は完全に撤廃されました。偶数月に年6回、前月分までが振り込まれます。",
    },
    {
      source: "国",
      name: "出産育児一時金",
      amount: "500,000円 / 子ども1人あたり",
      target: "健康保険の被保険者・被扶養者で、妊娠4ヶ月以上で出産された方",
      description: "健康保険より出産費用として一律支給。直接支払制度により退院時の窓口支払いを抑えられます。",
    },
    {
      source: "国",
      name: "出産・子育て応援ギフト",
      amount: "合計100,000円相当（出産5万円分 ＋ 子育て5万円分）",
      target: "全ての妊婦の方、および乳児の保護者",
      description:
        "面談を受けた妊婦（5万円相当）および出生届出後の保護者（5万円相当）へ、それぞれギフトカード等が支給されます。",
    },
    {
      source: "埼玉県",
      name: "パパ・ママ応援ショップ優待制度",
      amount: "割引・各種サービス",
      target: "埼玉県内在住の妊娠中の方、または18歳に達して最初の3月31日を迎えるまでの子どもの保護者",
      description:
        "協賛店で優待カード（スマホ画面等）を提示すると、商品の割引やポイント追加、無料サービスなどの特典が受けられます。",
    },
  ],
  chiba: [
    {
      source: "国",
      name: "児童手当",
      amount: "月額10,000円〜15,000円（※第3子以降は30,000円）",
      target: "0歳から高校生年代（18歳到達後の最初の3月31日）までのお子さん",
      description:
        "3歳未満は月15,000円、3歳〜高校生年代は月10,000円が支給されます。所得制限は完全に撤廃されました。偶数月に年6回、前月分までが振り込まれます。",
    },
    {
      source: "国",
      name: "出産育児一時金",
      amount: "500,000円 / 子ども1人あたり",
      target: "健康保険の被保険者・被扶養者で、妊娠4ヶ月以上で出産された方",
      description: "健康保険より出産費用として一律支給。直接支払制度により退院時の窓口支払いを抑えられます。",
    },
    {
      source: "国",
      name: "出産・子育て応援ギフト",
      amount: "合計100,000円相当（出産5万円分 ＋ 子育て5万円分）",
      target: "全ての妊婦の方、および乳児の保護者",
      description:
        "面談を受けた妊婦（5万円相当）および出生届出後の保護者（5万円相当）へ、それぞれギフトカード等が支給されます。",
    },
    {
      source: "千葉県",
      name: "チーパス（ちばの子育て家庭優待カード）",
      amount: "子育て応援割引・特典など",
      target: "千葉県内在住の妊娠中の方、または中学生までの子どもがいる世帯",
      description:
        "「チーパスの店」（協賛店）でチーパス（電子カード含む）を提示することで、割引やプレゼントなどの様々なサービスが受けられます。",
    },
  ],
  osaka: [
    {
      source: "国",
      name: "児童手当",
      amount: "月額10,000円〜15,000円（※第3子以降は30,000円）",
      target: "0歳から高校生年代（18歳到達後の最初の3月31日）までのお子さん",
      description:
        "3歳未満は月15,000円、3歳〜高校生年代は月10,000円が支給されます。所得制限は完全に撤廃されました。偶数月に年6回、前月分までが振り込まれます。",
    },
    {
      source: "国",
      name: "出産育児一時金",
      amount: "500,000円 / 子ども1人あたり",
      target: "健康保険の被保険er・被扶養者で、妊娠4ヶ月以上で出産された方",
      description: "健康保険より出産費用として一律支給。直接支払制度により退院時の窓口支払いを抑えられます。",
    },
    {
      source: "国",
      name: "出産・子育て応援ギフト",
      amount: "合計100,000円相当（出産5万円分 ＋ 子育て5万円分）",
      target: "全ての妊婦の方、および乳児の保護者",
      description:
        "面談を受けた妊婦（5万円相当）および出生届出後の保護者（5万円相当）へ、それぞれギフトカード等が支給されます。",
    },
    {
      source: "大阪府",
      name: "まいど子でもカード",
      amount: "シンボルマーク提示による割引・サービス",
      target: "大阪府在住で、18歳未満の子どもがいる世帯（妊娠中を含む）",
      description:
        "協賛店（まいど子でもカードのロゴがある店）で会員画面等を提示することで、商品の割引や特別サービスが受けられます。",
    },
  ],
  aichi: [
    {
      source: "国",
      name: "児童手当",
      amount: "月額10,000円〜15,000円（※第3子以降は30,000円）",
      target: "0歳から高校生年代（18歳到達後の最初の3月31日）までのお子さん",
      description:
        "3歳未満は月15,000円、3歳〜高校生年代は月10,000円が支給されます。所得制限は完全に撤廃されました。偶数月に年6回、前月分までが振り込まれます。",
    },
    {
      source: "国",
      name: "出産育児一時金",
      amount: "500,000円 / 子ども1人あたり",
      target: "健康保険の被保険者・被扶養者で、妊娠4ヶ月以上で出産された方",
      description: "健康保険より出産費用として一律支給。直接支払制度により退院時の窓口支払いを抑えられます。",
    },
    {
      source: "国",
      name: "出産・子育て応援ギフト",
      amount: "合計100,000円相当（出産5万円分 ＋ 子育て5万円分）",
      target: "全ての妊婦の方、および乳児の保護者",
      description:
        "面談を受けた妊婦（5万円相当）および出生届出後の保護者（5万円相当）へ、それぞれギフトカード等が支給されます。",
    },
    {
      source: "愛知県",
      name: "子育て家庭優待事業（はぐみんカード）",
      amount: "各種割引・サービス",
      target: "愛知県内在住の妊娠中の方、または18歳未満の子どもがいる世帯",
      description:
        "愛知県内の協賛店「はぐみん優待ショップ」で「はぐみんカード」を提示すると、商品の割引やプレゼント、ベビーカー貸出などのサービスが受けられます。",
    },
  ],
  fukuoka: [
    {
      source: "国",
      name: "児童手当",
      amount: "月額10,000円〜15,000円（※第3子以降は30,000円）",
      target: "0歳から高校生年代（18歳到達後の最初の3月31日）までのお子さん",
      description:
        "3歳未満は月15,000円、3歳〜高校生年代は月10,000円が支給されます。所得制限は完全に撤廃されました。偶数月に年6回、前月分までが振り込まれます。",
    },
    {
      source: "国",
      name: "出産育児一時金",
      amount: "500,000円 / 子ども1人あたり",
      target: "健康保険の被保険者・被扶養者で、妊娠4ヶ月以上で出産された方",
      description: "健康保険より出産費用として一律支給。直接支払制度により退院時の窓口支払いを抑えられます。",
    },
    {
      source: "国",
      name: "出産・子育て応援ギフト",
      amount: "合計100,000円相当（出産5万円分 ＋ 子育て5万円分）",
      target: "全ての妊婦の方、および乳児の保護者",
      description:
        "面談を受けた妊婦（5万円相当）および出生届出後の保護者（5万円相当）へ、それぞれギフトカード等が支給されます。",
    },
    {
      source: "福岡県",
      name: "子育て応援パスポート",
      amount: "割引・優待サービス",
      target: "福岡県内在住で、18歳未満の子どもがいる世帯（妊娠中を含む）",
      description:
        "協賛店（店舗や施設）でパスポート画面を提示すると、商品の割引やポイント追加、無料サービスなどの各種特典が受けられます。",
    },
  ],
  hokkaido: [
    {
      source: "国",
      name: "児童手当",
      amount: "月額10,000円〜15,000円（※第3子以降は30,000円）",
      target: "0歳から高校生年代（18歳到達後の最初の3月31日）までのお子さん",
      description:
        "3歳未満は月15,000円、3歳〜高校生年代は月10,000円が支給されます。所得制限は完全に撤廃されました。偶数月に年6回、前月分までが振り込まれます。",
    },
    {
      source: "国",
      name: "出産育児一時金",
      amount: "500,000円 / 子ども1人あたり",
      target: "健康保険の被保険者・被扶養者で、妊娠4ヶ月以上で出産された方",
      description: "健康保険より出産費用として一律支給。直接支払制度により退院時の窓口支払いを抑えられます。",
    },
    {
      source: "国",
      name: "出産・子育て応援ギフト",
      amount: "合計100,000円相当（出産5万円分 ＋ 子育て5万円分）",
      target: "全ての妊婦の方、および乳児の保護者",
      description:
        "面談を受けた妊婦（5万円相当）および出生届出後の保護者（5万円相当）へ、それぞれギフトカード等が支給されます。",
    },
    {
      source: "北海道",
      name: "どさんこ・子育て特典制度",
      amount: "割引・優待サービス",
      target: "北海道内在住の妊娠中の方、または小学生以下の子どもがいる世帯",
      description:
        "協賛店で「どさんこ・子育て特典カード」を提示することで、商品の割引やポイント追加、ドリンクサービスなどの様々なサービスが受けられます。",
    },
  ],
};

// Excel データの市区町村別グループ化
const excelByCity: Record<string, any[]> = {};
for (const row of excelData) {
  const city = row["市区町村"];
  if (city.includes("全域")) continue;
  if (!excelByCity[city]) {
    excelByCity[city] = [];
  }
  excelByCity[city].push(row);
}

const finalMunicipalities: any[] = [];
const existingCities = existingMunicipalities.map((m) => m.cityJa);

// 1. 既存の自治体オブジェクトのアップデートと追加
for (const existing of existingMunicipalities) {
  const cityJa = existing.cityJa;
  const prefSlug = existing.prefectureSlug;
  const excelRows = excelByCity[cityJa] || [];

  const updatedCashBenefits = [...existing.cashBenefits];

  // Excel にあって既存の cashBenefits にないものを追加する
  for (const row of excelRows) {
    if (row["カテゴリ"] === "医療費助成") continue;

    const isDuplicate = existing.cashBenefits.some(
      (b) => b.name === row["制度名"] || b.name.includes(row["制度名"]) || row["制度名"].includes(b.name),
    );
    if (!isDuplicate) {
      updatedCashBenefits.push({
        source: "市区町村",
        name: row["制度名"],
        amount: row["支給・助成内容"] || "",
        target: row["対象者・条件"] || "",
        description: row["申請方法・備考"] || "",
      });
    }
  }

  finalMunicipalities.push({
    ...existing,
    cashBenefits: updatedCashBenefits,
  });
}

// 2. 新規の自治体の追加
for (const [cityJa, rows] of Object.entries(excelByCity)) {
  if (existingCities.includes(cityJa)) continue;

  const firstRow = rows[0];
  const prefJa = firstRow["都道府県"];
  const prefSlug = PREFECTURE_SLUGS[prefJa] || "unknown";
  const citySlug = CITY_SLUGS[cityJa] || "unknown";

  if (citySlug === "unknown") {
    console.warn(`Warning: citySlug not found for city: ${cityJa}`);
  }

  // 子ども医療費助成データの抽出
  const medicalRow = rows.find((r) => r["カテゴリ"] === "医療費助成");
  const medicalSupport = medicalRow
    ? {
        targetAge: medicalRow["対象者・条件"] || "高校生相当まで（18歳に達する日以後最初の3月31日まで）",
        incomeLimit:
          medicalRow["対象者・条件"]?.includes("所得制限なし") || medicalRow["支給・助成内容"]?.includes("所得制限なし")
            ? "なし"
            : "なし（所得制限はありません）",
        copayment: medicalRow["支給・助成内容"] || "自己負担なし",
        updateNote: medicalRow["申請方法・備考"] || "",
      }
    : {
        targetAge: "18歳に達する日以後最初の3月31日まで（高校生相当まで）",
        incomeLimit: "なし（所得制限はございません）",
        copayment: "自己負担なし（通院・入院ともに保険診療分は全額助成されます）",
        updateNote: "",
      };

  // 出産祝い金・子育てギフトの抽出
  const childbirthRow = rows.find(
    (r) =>
      r["制度名"]?.includes("出産") ||
      r["制度名"]?.includes("祝い") ||
      r["制度名"]?.includes("祝金") ||
      r["制度名"]?.includes("ギフト"),
  );
  const childbirthGift = childbirthRow
    ? {
        title: childbirthRow["制度名"],
        amount: childbirthRow["支給・助成内容"] || "50,000円相当",
        conditions: childbirthRow["対象者・条件"] || "当自治体に住民登録があり出産された方",
        details: childbirthRow["申請方法・備考"] || "",
      }
    : {
        title: "出産・子育て応援ギフト",
        amount: "合計100,000円相当（出産5万円分 ＋ 子育て5万円分）",
        conditions: "全ての妊婦の方、および乳児の保護者",
        details:
          "妊娠届出時の面談後に5万円相当、出産後の赤ちゃん訪問（面談）後に5万円相当のギフトがそれぞれ支給されます。",
      };

  // 問い合わせ窓口・公式サイトURL
  const lastWithUrl = [...rows].reverse().find((r) => r["情報源URL"]);
  const contact = {
    department: `${cityJa}役所 子育て支援担当窓口`,
    url: lastWithUrl
      ? lastWithUrl["情報源URL"]
      : `https://www.google.com/search?q=${encodeURIComponent(cityJa + " 子育て 補助金")}`,
  };

  // cashBenefits のマージ
  const cashBenefits = [...(COMMON_BENEFITS[prefSlug] || [])];

  for (const row of rows) {
    if (row["カテゴリ"] === "医療費助成") continue;
    cashBenefits.push({
      source: "市区町村",
      name: row["制度名"],
      amount: row["支給・助成内容"] || "",
      target: row["対象者・条件"] || "",
      description: row["申請方法・備考"] || "",
    });
  }

  finalMunicipalities.push({
    prefectureSlug: prefSlug,
    prefectureJa: prefJa,
    citySlug,
    cityJa,
    medicalSupport,
    mumpsSupport: {
      hasSubsidy: false,
      targetAge: "-",
      subsidyAmount: "助成なし（任意接種のため全額自己負担となります）",
      howToApply: `現在のところ、${cityJa}ではおたふくかぜワクチンの費用助成はありません。接種を検討される場合は、かかりつけの小児科等にて全額自己負担でご予約ください。`,
    },
    childbirthGift,
    contact,
    cashBenefits,
  });
}

// TypeScript ファイルの書き出し
const outputContent = `export interface CashBenefit {
  source: "国" | "東京都" | "神奈川県" | "埼玉県" | "千葉県" | "大阪府" | "愛知県" | "福岡県" | "北海道" | "市区町村";
  name: string; // 制度名
  amount: string; // 支給額・金額
  target: string; // 対象年齢・支給対象
  description: string; // 制度の概要や補足
}

export interface Municipality {
  prefectureSlug: string; // "tokyo" | "kanagawa" など
  prefectureJa: string; // "東京都" | "神奈川県" など
  citySlug: string; // "setagaya" | "yokohama" など
  cityJa: string; // "世田谷区" | "横浜市" など

  // 子ども医療費助成
  medicalSupport: {
    targetAge: string; // 助成対象年齢
    incomeLimit: string; // 所得制限
    copayment: string; // 自己負担額
    updateNote?: string; // 特記事項
  };

  // おたふくかぜ予防接種（任意接種）助成
  mumpsSupport: {
    hasSubsidy: boolean; // 助成有無
    targetAge: string; // 対象年齢
    subsidyAmount: string; // 助成内容・額
    howToApply: string; // 手続き方法・注意点
  };

  // 出産祝い金・子育てギフト
  childbirthGift: {
    title: string; // 制度名
    amount: string; // 額面や内容
    conditions: string; // 条件
    details: string; // 制度の具体的な詳細
  };

  // 問い合わせ窓口
  contact: {
    department: string; // 担当部署名
    url: string; // 公式サイトURL
  };

  // 現金給付・手当一覧
  cashBenefits: CashBenefit[];
}

export const municipalities: Municipality[] = ${JSON.stringify(finalMunicipalities, null, 2)};
`;

fs.writeFileSync(path.resolve(__dirname, "../src/data/municipalities.ts"), outputContent, "utf-8");
console.log("Successfully updated municipalities.ts");

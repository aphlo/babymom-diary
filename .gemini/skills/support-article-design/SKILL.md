# support-article-design

Design system and mobile UX guidelines for official site support articles (dynamic municipality pages).

## 概要
本スキルは、公式Webサイト（official-site）における「自治体支援情報」の詳細記事ページ（`[prefecture]/[city]/page.tsx`）を新規作成・改修する際のデザインシステム、およびモバイル（スマートフォン）での極上の閲覧体験を実現するためのUI/UXデザインガイドラインです。

AI生成感を徹底的に排除し、人が「読もう」と思える温かみのある手書きの記事クオリティを維持するために、以下のルールを厳格に適用してください。

---

## 厳守すべきデザイン＆レイアウトガイドライン

### 1. 個別カードの廃止と「1枚の記事」への統合
- **ルール**：各章（子ども医療費助成、おたふくかぜ予防接種、手当一覧など）をそれぞれ個別のカード（`border rounded-2xl bg-white shadow-soft`）で囲まないでください。
- **実装方法**：
  - メインコンテンツ全体を大きな1枚の白背景コンテナで包みます。
  - 各セクションの間には、境界となるシンプルな区切り線（`<hr className="border-border-pink/40 my-10" />`）を配置し、流れるように読み進められる構造にします。
  - 各セクションの `h2` 見出しは、左に太いピンクの縦線、背景に淡いピンクのグラデーションを配した装飾的な見出しにします（例：`pl-4 pr-4 py-3 bg-gradient-to-r from-primary/10 to-transparent border-l-4 border-primary rounded-r-xl`）。

### 2. スマートフォン（モバイル）での全幅表示対応
- **ルール**：画面サイズの小さいスマホ表示時、記事コンテナの左右の境界線、シャドウ、余白、角丸を排除し、画面幅いっぱいに表示させてコンテンツの横幅を最大化します。
- **実装方法**：
  - コンテナ of 親クラスに以下を設定します：
    `w-full bg-white px-4 py-8 md:p-10 md:rounded-3xl md:border md:border-border-pink/60 md:shadow-soft`
  - これにより、スマホでは全幅表示になり、PCやタブレットなどの大画面（`md` 以上）でのみカード型（角丸・境界線・シャドウあり）になります。

### 3. 冒頭情報の「1行に1情報」縦並び化
- **ルール**：忙しいママパパが自然にスクロールしながら読めるよう、冒頭の要約情報などは横並び（グリッド）にせず、すべて縦並び（1行に1情報）のリスト形式にします。
- **対象要素**：
  - **3秒でわかるポイント**：チェックマーク付きのカード要素を縦に並べます。
  - **対象読者・わかること**：横分割をやめ、縦に流れるようにリストを配置します。
  - **目次**：グリッドボタンを廃止し、縦にスッキリ並ぶナビゲーションリスト（`flex flex-col gap-2`）にします。

### 4. 絵文字の完全廃止と「インライン SVG アイコン」の使用
- **ルール**：AIによる自動生成感を排除するため、見出しやリスト、バッジに絵文字（🎯, 🏥, 💉, 💰, 🎁, 💡, ❓, 📞など）を直接使用しないでください。
- **実装方法**：
  - コード内で定義した軽量なインライン SVG アイコンコンポーネント（例：`IconMedical`, `IconInjection`, `IconCoins`, `IconGift`, `IconBulb`, `IconQuestion`, `IconContact`, `IconCheck` など）を自前で実装し、それぞれに割り当てます。

### 5. アバター画像の統一
- **ルール**：milu編集部のアドバイス（吹き出しコンポーネント）のアイコンには、絵文字やイラスト画像ではなく、指定されたクマの画像（`/images/bear_normal.png`）を必ず使用してください。
- **画像パス**：`official-site/public/images/bear_normal.png`

---

## 典型的なマークアップ構造

自治体詳細記事ページの標準的な構造は以下の通りです。

```tsx
// 吹き出しコンポーネント
function SpeechBubble({ title, comment, type }) {
  let bubbleBg = "bg-bg-pink border-border-pink text-text-main";
  if (type === "success") bubbleBg = "bg-green-50/60 border-green-200 text-green-900";
  else if (type === "warning") bubbleBg = "bg-amber-50/60 border-amber-200 text-amber-900";

  return (
    <div className="flex gap-3 md:gap-4 items-start my-6">
      <div className="flex flex-col items-center shrink-0">
        <div className="w-10 h-10 md:w-12 md:h-12 rounded-full overflow-hidden border border-border-pink/80 bg-white">
          <img src="/images/bear_normal.png" alt="milu編集部" className="w-full h-full object-cover" />
        </div>
        <span className="text-[9px] md:text-[10px] font-bold text-text-light mt-1">milu編集部</span>
      </div>
      <div className={`relative flex-1 p-4 md:p-5 rounded-2xl border ${bubbleBg} shadow-soft before:...`}>
        <h5 className="text-xs font-bold text-primary-dark">{title}</h5>
        <p className="text-xs md:text-sm">{comment}</p>
      </div>
    </div>
  );
}

// ページコンポーネント
export default async function MunicipalityPage({ params }) {
  // ...データフェッチなど
  
  return (
    <div className="pt-[100px] bg-bg-cream min-h-screen">
      {/* ヒーローヘッダー */}
      <div className="relative overflow-hidden bg-gradient-to-b from-bg-pink via-bg-pink/50 to-white/30 py-12 px-4 md:px-6 mt-4 border-y border-border-pink">
        ...
      </div>

      {/* メインコンテンツ */}
      <div className="max-w-[1000px] mx-auto py-6 md:py-10 px-0 md:px-6">
        <div className="w-full bg-white px-4 py-8 md:p-10 md:rounded-3xl md:border md:border-border-pink/60 md:shadow-soft">
          {/* 3秒でわかるサマリー */}
          <section className="bg-gradient-to-r from-primary/5 ...">
            ...
          </section>

          <hr className="border-border-pink/40 my-10" />

          {/* 各章セクション */}
          <section id="medical" className="scroll-mt-[110px]">
            <h2 className="relative pl-4 pr-4 py-3 bg-gradient-to-r from-primary/10 to-transparent border-l-4 border-primary rounded-r-xl font-bold text-text-main text-lg md:text-xl flex items-center gap-2 mb-4 font-fredoka">
              <IconMedical className="w-6 h-6 text-primary" />
              <span>1. 子ども医療費助成制度</span>
            </h2>
            ...
            <SpeechBubble ... />
          </section>

          <hr className="border-border-pink/40 my-10" />
          ...
        </div>
      </div>
    </div>
  );
}
```

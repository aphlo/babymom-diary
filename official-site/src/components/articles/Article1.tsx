export default function Article1() {
  return (
    <>
      <p className="mb-6 text-[16px]">
        赤ちゃんの健やかな成長において、毎日の授乳やミルクの管理はとても大切です。しかし、「どれくらいの頻度であげればいいの？」「量は足りている？」と不安に思うパパ・ママも多いのではないでしょうか。
      </p>
      <p className="mb-6 text-[16px]">
        この記事では、月齢別の授乳スケジュールの目安や量、そして日々の記録を簡単にするコツを紹介します。
      </p>

      <h2 className="text-2xl font-bold mt-10 mb-4 border-b-2 border-secondary pb-2">
        1. 月齢別の授乳・ミルクの目安
      </h2>
      <p className="mb-6">赤ちゃんの成長スピードや飲む量には個人差がありますが、一般的な目安は以下の通りです。</p>

      <h3 className="text-xl font-bold mt-6 mb-3 text-primary-dark">新生児期（生後0〜1ヶ月頃）</h3>
      <ul className="list-disc pl-6 mb-6 flex flex-col gap-2">
        <li>
          <strong>回数の目安</strong>: 1日8〜12回（欲しがるだけ与える）
        </li>
        <li>
          <strong>1回の量</strong>: 母乳は左右10分ずつ程度、ミルクは80ml〜120ml程度
        </li>
        <li>
          <strong>特徴</strong>: 胃が小さいため、一度にたくさん飲めません。こまめな授乳が必要です。
        </li>
      </ul>

      <h3 className="text-xl font-bold mt-6 mb-3 text-primary-dark">生後2〜3ヶ月頃</h3>
      <ul className="list-disc pl-6 mb-6 flex flex-col gap-2">
        <li>
          <strong>回数の目安</strong>: 1日6〜8回（授乳間隔が3〜4時間あくようになる）
        </li>
        <li>
          <strong>1回の量</strong>: ミルクの場合は140ml〜160ml程度
        </li>
        <li>
          <strong>特徴</strong>: 飲む力が強くなり、一度に飲める量が増えます。
        </li>
      </ul>

      <h3 className="text-xl font-bold mt-6 mb-3 text-primary-dark">生後4〜5ヶ月頃</h3>
      <ul className="list-disc pl-6 mb-6 flex flex-col gap-2">
        <li>
          <strong>回数の目安</strong>: 1日5〜6回
        </li>
        <li>
          <strong>1回の量</strong>: ミルクの場合は160ml〜200ml程度
        </li>
        <li>
          <strong>特徴</strong>: 生活リズムが少しずつ整い始めます。離乳食をスタートする準備期でもあります。
        </li>
      </ul>

      <hr className="my-10 border-t border-dashed border-border-pink" />

      <h2 className="text-2xl font-bold mt-10 mb-4 border-b-2 border-secondary pb-2">
        2. 授乳スケジュールを整えるコツ
      </h2>
      <p className="mb-6">
        毎日同じ時間帯に授乳をする必要はありませんが、ある程度のリズムを作ることで、赤ちゃんの睡眠リズムや離乳食の進め方がスムーズになります。
      </p>
      <ol className="list-decimal pl-6 mb-6 flex flex-col gap-3">
        <li>
          <strong>朝は決まった時間に起こす</strong>: 朝の光を浴びせて授乳することで、1日のスタートを意識させます。
        </li>
        <li>
          <strong>お風呂上がりの授乳</strong>: お風呂の後は水分補給を兼ねて授乳やミルクを行います。
        </li>
        <li>
          <strong>日中の活動を増やす</strong>:
          起きている時間にスキンシップや遊びを取り入れることで、程よくお腹を空かせます。
        </li>
      </ol>

      <hr className="my-10 border-t border-dashed border-border-pink" />

      <h2 className="text-2xl font-bold mt-10 mb-4 border-b-2 border-secondary pb-2">
        3. 面倒な授乳記録は「アプリ」で解決！
      </h2>
      <p className="mb-6">
        「前回はどっちの胸から何分あげたっけ？」「今日ミルクは何ml飲んだ？」
        忙しい育児の中で、これらをすべて記憶しておくのは不可能です。メモ帳に毎回手書きするのも大変ですよね。
      </p>
      <p className="mb-6">
        そんな時は、<strong>育児記録アプリ「milu」</strong>を使うのがおすすめです。
      </p>

      <h3 className="text-xl font-bold mt-6 mb-3 text-primary-dark">miluでできること</h3>
      <ul className="list-disc pl-6 mb-6 flex flex-col gap-2">
        <li>
          <strong>ワンタップ簡単記録</strong>:
          授乳タイマー機能で左右の授乳時間をスマートに計測。ミルクの量も数値入力するだけで保存完了。
        </li>
        <li>
          <strong>自動グラフ化</strong>: 毎日の授乳リズムやトータル量が自动でグラフになり、一目で確認可能。
        </li>
        <li>
          <strong>パートナーとリアルタイム共有</strong>:
          パパがミルクをあげた記録も、ママのスマホにリアルタイムで同期されます。
        </li>
      </ul>
      <p className="mb-6">
        授乳の記録だけでなく、身長・体重の成長曲線や予防接種のスケジュール管理もひとつのアプリでまとまります。
      </p>
      <p className="mb-6 font-bold text-primary-dark">
        ぜひ、便利なアプリを活用して、毎日の育児をもっとシンプルに、楽しく進めましょう！
      </p>
    </>
  );
}

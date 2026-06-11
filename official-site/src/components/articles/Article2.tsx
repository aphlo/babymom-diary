export default function Article2() {
  return (
    <>
      <p className="mb-6 text-[16px]">
        生後2ヶ月になると、いよいよ赤ちゃんの予防接種がスタートします。
        「種類が多くてどれをいつ打てばいいのか分からない」「同時接種って本当に大丈夫？」と悩まれるパパ・ママも多いでしょう。
      </p>
      <p className="mb-6 text-[16px]">
        今回は、主要なワクチンの種類やスケジュール管理、接種をスムーズに進めるためのポイントについて詳しく解説します。
      </p>

      <h2 className="text-2xl font-bold mt-10 mb-4 border-b-2 border-secondary pb-2">
        1. 赤ちゃんが受ける主な予防接種の種類
      </h2>
      <p className="mb-6">
        赤ちゃんが受けるワクチンには「定期接種（公費負担で無料）」と「任意接種（自己負担、一部助成あり）」があります。
      </p>

      <h3 className="text-xl font-bold mt-6 mb-3 text-primary-dark">生後2ヶ月から始まる初期のワクチン</h3>
      <ul className="list-disc pl-6 mb-6 flex flex-col gap-2">
        <li>
          <strong>ヒブ（インフルエンザ菌b型）</strong>:
          細菌性髄膜炎などを予防します。（※現在、5種混合ワクチンに含まれる場合もあります）
        </li>
        <li>
          <strong>小児用肺炎球菌</strong>: 肺炎や中耳炎、髄膜炎を予防します。
        </li>
        <li>
          <strong>五種混合（DPT-IPV-Hib）</strong>: ジフテリア、百日咳、破傷風、ポリオ、ヒブを予防します。
        </li>
        <li>
          <strong>ロタウイルス</strong>: 重症の下痢症を引き起こすロタウイルス胃腸炎を予防します（経口ワクチン）。
        </li>
        <li>
          <strong>B型肝炎</strong>: 将来的な肝炎や肝がんへの移行を防ぎます。
        </li>
      </ul>
      <p className="mb-6">生後2ヶ月の時点では、これら多くのワクチンを複数同時に接種することが推奨されています。</p>

      <hr className="my-10 border-t border-dashed border-border-pink" />

      <h2 className="text-2xl font-bold mt-10 mb-4 border-b-2 border-secondary pb-2">
        2. 予防接種スケジュールをスムーズに進めるコツ
      </h2>
      <p className="mb-6">
        予防接種は接種回数が多く、次回までの間隔（中何日あけるか）もワクチンごとに細かく決まっています。計画的に進めるためのコツをご紹介します。
      </p>
      <ol className="list-decimal pl-6 mb-6 flex flex-col gap-3">
        <li>
          <strong>生後1ヶ月健診が過ぎたら予約の準備</strong>:
          生後2ヶ月の誕生日になったらすぐに最初の接種ができるよう、かかりつけ医を決めて予約方法を確認しておきます。
        </li>
        <li>
          <strong>同時接種を活用する</strong>:
          複数本のワクチンを同じ日に接種する「同時接種」は、医療機関や小児科学会でも推奨されています。通院回数を減らし、早期に免疫をつけることができます。
        </li>
        <li>
          <strong>接種後の副反応に備える</strong>:
          接種した日は発熱や機嫌が悪くなることがあります。接種後24時間は赤ちゃんの様子をよく観察し、翌日に大事な予定を入れないようにしましょう。
        </li>
      </ol>

      <hr className="my-10 border-t border-dashed border-border-pink" />

      <h2 className="text-2xl font-bold mt-10 mb-4 border-b-2 border-secondary pb-2">
        3. 複雑なスケジュールは「milu」で自動管理！
      </h2>
      <p className="mb-6">
        ワクチンの種類ごとに「1回目から2回目は4週間あける」「追加接種は1年後」など、スケジュールをパパ・ママだけで完璧に把握し、ノートに書き出して管理するのは非常に大変です。
      </p>
      <p className="mb-6">
        <strong>育児記録アプリ「milu」</strong>
        なら、そんな複雑な予防接種スケジュール管理をスマートに解決できます。
      </p>

      <h3 className="text-xl font-bold mt-6 mb-3 text-primary-dark">miluの予防接種管理機能の特徴</h3>
      <ul className="list-disc pl-6 mb-6 flex flex-col gap-2">
        <li>
          <strong>自動スケジュール算出</strong>:
          お子さまの誕生日を入力するだけで、推奨されるワクチンの接種可能期間や最適なスケジュールを自動で計算します。
        </li>
        <li>
          <strong>接種記録・予約日の管理</strong>:
          予約した日や接種が終わった日をアプリに登録するだけで、次回のスケジュールが自動で再計算・更新されます。
        </li>
        <li>
          <strong>同時接種の予約グループ管理</strong>:
          どのワクチンを同時に接種したか、または予定しているかをグループ単位でわかりやすく管理可能です。
        </li>
      </ul>
      <p className="mb-6">
        スケジュール管理だけでなく、日々の授乳・睡眠・おむつ替えの記録や成長曲線も一元管理できます。
      </p>
      <p className="mb-6 font-bold text-primary-dark">
        スマートにスケジュールを組んで、お子さまの大切な予防接種を漏れなく進めましょう！
      </p>
    </>
  );
}

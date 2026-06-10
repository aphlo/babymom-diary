import Link from "next/link";

export default function Footer() {
  return (
    <footer className="bg-white py-14 px-6 border-t border-border-pink">
      <div className="max-w-[1200px] mx-auto flex flex-col items-center gap-8">
        <div className="font-fredoka text-[32px] font-bold text-primary">milu</div>
        <nav className="flex gap-6 flex-wrap justify-center">
          <Link href="/privacy" className="text-text-light hover:text-primary-dark transition-colors text-sm">
            プライバシーポリシー
          </Link>
          <Link href="/terms" className="text-text-light hover:text-primary-dark transition-colors text-sm">
            利用規約
          </Link>
          <Link href="/tokushoho" className="text-text-light hover:text-primary-dark transition-colors text-sm">
            特定商取引法に基づく表記
          </Link>
          <Link href="/inquiry" className="text-text-light hover:text-primary-dark transition-colors text-sm">
            お問い合わせ
          </Link>
        </nav>
        <p className="text-text-muted text-[13px]">&copy; 2026 aphlo All rights reserved.</p>
      </div>
    </footer>
  );
}

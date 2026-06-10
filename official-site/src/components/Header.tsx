import Link from "next/link";

export default function Header() {
  return (
    <header className="fixed top-4 left-4 right-4 z-50 bg-white/90 backdrop-blur-md rounded-lg p-3 px-6 shadow-soft border border-border-pink">
      <div className="max-w-[1200px] mx-auto flex justify-between items-center">
        <Link href="/" className="font-fredoka text-[28px] font-bold text-primary tracking-[-0.5px]">
          milu
        </Link>
        <nav className="flex items-center gap-6">
          <Link href="/columns" className="text-text-main hover:text-primary-dark font-semibold text-sm transition-colors">
            お役立ち記事・コラム
          </Link>
        </nav>
      </div>
    </header>
  );
}

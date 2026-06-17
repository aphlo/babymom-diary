import Link from "next/link";

export default function Footer() {
  return (
    <footer className="bg-white py-14 px-6 border-t border-border-pink">
      <div className="max-w-[1200px] mx-auto flex flex-col items-center gap-8">
        <div className="font-fredoka text-[32px] font-bold text-primary">milu</div>

        {/* SNS Links */}
        <div className="flex gap-6 items-center">
          <a
            href="https://www.instagram.com/milu.childcarerecord"
            target="_blank"
            rel="noopener noreferrer"
            className="text-text-light hover:text-[#E1306C] transition-all duration-300 hover:scale-110"
            aria-label="Instagram"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth="2"
              strokeLinecap="round"
              strokeLinejoin="round"
              className="w-6 h-6"
            >
              <rect width="20" height="20" x="2" y="2" rx="5" ry="5" />
              <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z" />
              <line x1="17.5" x2="17.51" y1="6.5" y2="6.5" />
            </svg>
          </a>
          <a
            href="https://www.tiktok.com/@milu.childcarerecord"
            target="_blank"
            rel="noopener noreferrer"
            className="text-text-light hover:text-[#000000] transition-all duration-300 hover:scale-110"
            aria-label="TikTok"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth="2"
              strokeLinecap="round"
              strokeLinejoin="round"
              className="w-6 h-6"
            >
              <path d="M9 12a4 4 0 1 0 4 4V4a5 5 0 0 0 5 5" />
            </svg>
          </a>
          <a
            href="https://www.youtube.com/channel/UC8knYAyVx7pfCyC7_LI9xng"
            target="_blank"
            rel="noopener noreferrer"
            className="text-text-light hover:text-[#FF0000] transition-all duration-300 hover:scale-110"
            aria-label="YouTube"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth="2"
              strokeLinecap="round"
              strokeLinejoin="round"
              className="w-6 h-6"
            >
              <path d="M2.5 17a24.12 24.12 0 0 1 0-10 2 2 0 0 1 1.4-1.4 49.56 49.56 0 0 1 16.2 0A2 2 0 0 1 21.5 7a24.12 24.12 0 0 1 0 10 2 2 0 0 1-1.4 1.4 49.55 49.55 0 0 1-16.2 0A2 2 0 0 1 2.5 17z" />
              <polygon points="10 15 15 12 10 9" />
            </svg>
          </a>
        </div>

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

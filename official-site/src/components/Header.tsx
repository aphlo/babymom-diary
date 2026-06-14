"use client";

import Link from "next/link";
import { useState } from "react";

export default function Header() {
  const [isOpen, setIsOpen] = useState(false);

  const toggleMenu = () => {
    setIsOpen(!isOpen);
  };

  const closeMenu = () => {
    setIsOpen(false);
  };

  return (
    <header className="fixed top-4 left-4 right-4 z-50 bg-white/90 backdrop-blur-md rounded-2xl p-3 px-6 shadow-soft border border-border-pink transition-all duration-300">
      <div className="max-w-[1200px] mx-auto flex justify-between items-center">
        <Link
          href="/"
          onClick={closeMenu}
          className="font-fredoka text-[28px] font-bold text-primary tracking-[-0.5px] hover:opacity-90 transition-opacity"
        >
          milu
        </Link>

        <nav className="hidden md:flex items-center gap-6">
          <Link
            href="/columns"
            className="text-text-main hover:text-primary-dark font-semibold text-sm transition-colors"
          >
            お役立ち記事・コラム
          </Link>
        </nav>

        {/* スマホ用ハンバーガーボタン */}
        <button
          type="button"
          onClick={toggleMenu}
          className="md:hidden flex flex-col justify-center items-center w-8 h-8 rounded-lg hover:bg-bg-pink/30 transition-colors"
          aria-label="メニュー開閉"
          aria-expanded={isOpen}
        >
          <span
            className={`w-5 h-0.5 bg-text-main rounded-full transition-all duration-300 ${
              isOpen ? "transform rotate-45 translate-y-1.5" : "mb-1.5"
            }`}
          />
          <span
            className={`w-5 h-0.5 bg-text-main rounded-full transition-all duration-300 ${
              isOpen ? "opacity-0" : "mb-1.5"
            }`}
          />
          <span
            className={`w-5 h-0.5 bg-text-main rounded-full transition-all duration-300 ${
              isOpen ? "transform -rotate-45 -translate-y-1.5" : ""
            }`}
          />
        </button>
      </div>

      <div
        className={`md:hidden overflow-hidden transition-all duration-300 ${
          isOpen ? "max-h-[80px] opacity-100 mt-4 border-t border-border-pink/40 pt-4" : "max-h-0 opacity-0"
        }`}
      >
        <nav className="flex flex-col gap-4">
          <Link
            href="/columns"
            onClick={closeMenu}
            className="text-text-main hover:text-primary font-semibold text-base py-1 transition-colors"
          >
            お役立ち記事・コラム
          </Link>
        </nav>
      </div>
    </header>
  );
}

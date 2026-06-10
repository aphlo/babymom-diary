import Image from "next/image";
import Link from "next/link";

export default function SupervisorProfile() {
  return (
    <div className="mt-12 p-6 md:p-8 bg-bg-pink border border-border-pink rounded-xl shadow-soft flex flex-col md:flex-row gap-6 items-center md:items-start text-left">
      <div className="relative w-24 h-24 md:w-28 md:h-28 flex-shrink-0 overflow-hidden rounded-full border-2 border-primary-light bg-white">
        <Image
          src="/assets/images/elmi_profile.png"
          alt="現役助産師えるみ"
          fill
          sizes="(max-width: 768px) 96px, 112px"
          className="object-cover"
          priority
        />
      </div>
      <div className="flex-1 flex flex-col gap-3">
        <div className="flex flex-col sm:flex-row sm:items-center gap-2 sm:gap-3">
          <span className="text-xs font-bold text-primary bg-white py-1 px-3.5 rounded-full border border-border-pink shadow-xs w-max">
            記事監修
          </span>
          <h4 className="text-xl font-bold text-text-main font-fredoka">
            現役助産師えるみ
          </h4>
        </div>
        <p className="text-sm text-text-light leading-relaxed">
          キャリア5年目の現役助産師。多くの出産に立ち会い、妊娠期・分娩期・産褥期のママのケア、新生児ケアや産後ケアに尽力。現在は病院にて助産師として勤務しながら、アプリ「milu」の監修を担当しています。パパとママが納得して育児ができる世の中を目指しています。好きな分野は授乳支援。
        </p>
        <div className="mt-2">
          <Link
            href="/about/elmi"
            className="inline-flex items-center text-xs font-bold text-primary-dark hover:text-primary transition-colors duration-200 group gap-1"
          >
            監修者の詳しいプロフィールを見る
            <svg
              className="w-4 h-4 transform group-hover:translate-x-1 transition-transform"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M9 5l7 7-7 7"
              />
            </svg>
          </Link>
        </div>
      </div>
    </div>
  );
}

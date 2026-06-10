import { Metadata } from "next";

export const metadata: Metadata = {
  title: "お問い合わせ",
  description: "miluへのお問い合わせはこちらから。バグ報告、機能要望、その他ご質問などお気軽にお寄せください。",
};

export default function InquiryLayout({ children }: { children: React.ReactNode }) {
  return <>{children}</>;
}

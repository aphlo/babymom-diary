"use client";
import Script from "next/script";
import { useEffect } from "react";

declare global {
  interface Window {
    KoeLoopWidget?: new (options: Record<string, unknown>) => unknown;
  }
}

export default function Inquiry() {
  const initWidget = () => {
    if (typeof window !== "undefined" && window.KoeLoopWidget) {
      try {
        new window.KoeLoopWidget({
          productId: "dddb40ea-a331-4cb9-84bb-b81187047a20",
          containerId: "koeloop-widget-dddb40ea-a331-4cb9-84bb-b81187047a20",
          theme: "light",
          primaryColor: "#E87086",
          showVoting: false,
          showFeedback: true,
          showFAQ: true,
          showEmailField: true,
          locale: "ja",
          apiBase: "https://koeloop.dev",
        });
      } catch (error) {
        console.error("Failed to initialize KoeLoopWidget:", error);
      }
    }
  };

  // biome-ignore lint/correctness/useExhaustiveDependencies: initWidget is a stable function for loading script callback
  useEffect(() => {
    if (typeof window !== "undefined" && window.KoeLoopWidget) {
      initWidget();
    }
  }, []);

  return (
    <>
      <section className="pt-[120px] pb-[60px] px-5 min-h-[calc(100vh-180px)] bg-linear-to-br from-bg-pink to-white flex justify-center">
        <div className="w-full max-w-[800px] bg-white/80 rounded-lg p-6 md:p-10 shadow-soft backdrop-blur-md border border-border-pink">
          <h1 className="text-center mb-10 text-text-main font-fredoka text-3xl md:text-4xl font-bold">お問い合わせ</h1>
          <div id="koeloop-widget-dddb40ea-a331-4cb9-84bb-b81187047a20" className="min-h-[400px]"></div>
        </div>
      </section>
      <Script src="https://koeloop.dev/widget.js" onLoad={initWidget} strategy="afterInteractive" />
    </>
  );
}

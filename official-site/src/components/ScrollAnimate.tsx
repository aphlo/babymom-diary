"use client";
import { useEffect, useState } from "react";

export default function ScrollAnimate() {
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  useEffect(() => {
    if (!mounted) return;

    const observerOptions = {
      threshold: 0.1,
      rootMargin: "0px 0px -50px 0px",
    };

    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          (entry.target as HTMLElement).style.animationPlayState = "running";
          observer.unobserve(entry.target);
        }
      });
    }, observerOptions);

    const elements = document.querySelectorAll(".animate-fade-in");
    elements.forEach((el) => {
      if (el.closest(".hero")) {
        (el as HTMLElement).style.animationPlayState = "running";
      } else {
        (el as HTMLElement).style.animationPlayState = "paused";
        observer.observe(el);
      }
    });

    return () => observer.disconnect();
  }, [mounted]);

  return null;
}

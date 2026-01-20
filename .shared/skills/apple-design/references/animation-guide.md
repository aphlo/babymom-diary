# Apple Design System - Animation Guide

Comprehensive guide to creating smooth, purposeful animations that enhance user experience without distracting from content.

## Animation Principles

### 1. Purposeful
Every animation should serve a purpose:
- Provide feedback to user actions
- Guide attention
- Show relationships between elements
- Communicate state changes
- Create delight

### 2. Natural
Mimic real-world physics:
- Use easing functions (not linear)
- Respect gravity and momentum
- Follow natural motion patterns

### 3. Responsive
Acknowledge user input immediately:
- Start animations within 100ms of interaction
- Use loading states for longer operations
- Provide visual feedback

### 4. Subtle
Don't distract from content:
- Keep durations short (150-500ms for UI)
- Use subtle movements
- Avoid excessive bouncing or spinning

### 5. Performant
Only animate GPU-accelerated properties:
- ✅ `transform`, `opacity`
- ❌ `width`, `height`, `top`, `left`, `margin`

## Timing & Easing

### Durations

```css
:root {
  --duration-instant: 0ms;
  --duration-fast: 150ms;     /* Micro-interactions */
  --duration-base: 300ms;     /* Standard transitions */
  --duration-slow: 500ms;     /* Complex animations */
  --duration-slower: 700ms;   /* Page transitions */
  --duration-slowest: 1000ms; /* Hero animations */
}
```

### Easing Functions

```css
:root {
  /* Standard ease in-out (most common) */
  --ease-in-out: cubic-bezier(0.4, 0, 0.2, 1);

  /* Ease out (entering elements) */
  --ease-out: cubic-bezier(0, 0, 0.2, 1);

  /* Ease in (exiting elements) */
  --ease-in: cubic-bezier(0.4, 0, 1, 1);

  /* Bounce (playful interactions) */
  --ease-bounce: cubic-bezier(0.68, -0.55, 0.265, 1.55);

  /* Smooth (elegant, refined) */
  --ease-smooth: cubic-bezier(0.25, 0.1, 0.25, 1);

  /* Sharp (quick, decisive) */
  --ease-sharp: cubic-bezier(0.4, 0, 0.6, 1);
}
```

### Usage Guide

| Scenario | Duration | Easing | Example |
|----------|----------|--------|---------|
| Button hover | 150ms | ease-out | Color change |
| Card hover | 300ms | ease-in-out | Lift effect |
| Modal open | 300ms | ease-out | Scale + fade |
| Modal close | 200ms | ease-in | Reverse animation |
| Page transition | 500ms | ease-in-out | Fade/slide |
| Hero entrance | 800ms | ease-out | Fade up |

## Common Animation Patterns

### Hover Effects

```css
/* Lift on hover */
.hover-lift {
  transition: transform 300ms var(--ease-out),
              box-shadow 300ms var(--ease-out);
}

.hover-lift:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-lg);
}

/* Scale on hover */
.hover-scale {
  transition: transform 300ms var(--ease-out);
}

.hover-scale:hover {
  transform: scale(1.05);
}

/* Glow on hover */
.hover-glow {
  transition: box-shadow 300ms var(--ease-out);
}

.hover-glow:hover {
  box-shadow: 0 0 32px rgba(102, 126, 234, 0.4);
}

/* Image zoom on hover */
.image-container {
  overflow: hidden;
  border-radius: 20px;
}

.image-zoom {
  transition: transform 600ms var(--ease-out);
}

.image-container:hover .image-zoom {
  transform: scale(1.1);
}
```

### Entrance Animations

```css
/* Fade in */
@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

.animate-fade-in {
  animation: fadeIn 600ms var(--ease-out);
}

/* Fade in up */
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.animate-fade-in-up {
  animation: fadeInUp 600ms var(--ease-out);
}

/* Scale in */
@keyframes scaleIn {
  from {
    opacity: 0;
    transform: scale(0.95);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

.animate-scale-in {
  animation: scaleIn 400ms var(--ease-out);
}

/* Slide in from right */
@keyframes slideInRight {
  from {
    opacity: 0;
    transform: translateX(30px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

.animate-slide-in-right {
  animation: slideInRight 500ms var(--ease-out);
}
```

### Staggered Animations

```html
<div class="stagger-container">
  <div class="stagger-item">Item 1</div>
  <div class="stagger-item">Item 2</div>
  <div class="stagger-item">Item 3</div>
</div>
```

```css
.stagger-item {
  opacity: 0;
  transform: translateY(20px);
  animation: fadeInUp 600ms var(--ease-out) forwards;
}

.stagger-item:nth-child(1) { animation-delay: 0ms; }
.stagger-item:nth-child(2) { animation-delay: 100ms; }
.stagger-item:nth-child(3) { animation-delay: 200ms; }
.stagger-item:nth-child(4) { animation-delay: 300ms; }
.stagger-item:nth-child(5) { animation-delay: 400ms; }
```

### Loading States

```css
/* Skeleton loader */
@keyframes skeleton {
  0% {
    background-position: -200px 0;
  }
  100% {
    background-position: calc(200px + 100%) 0;
  }
}

.skeleton {
  background: linear-gradient(
    90deg,
    var(--bg-secondary) 0px,
    var(--bg-tertiary) 40px,
    var(--bg-secondary) 80px
  );
  background-size: 200px 100%;
  animation: skeleton 1.5s ease-in-out infinite;
}

/* Spinner */
@keyframes spin {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

.spinner {
  width: 40px;
  height: 40px;
  border: 3px solid rgba(0, 0, 0, 0.1);
  border-top-color: var(--accent-blue);
  border-radius: 50%;
  animation: spin 800ms linear infinite;
}

/* Pulse */
@keyframes pulse {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.5;
  }
}

.pulse {
  animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
}

/* Dots loader */
@keyframes dotPulse {
  0%, 80%, 100% {
    transform: scale(0);
    opacity: 0.5;
  }
  40% {
    transform: scale(1);
    opacity: 1;
  }
}

.dots-loader {
  display: flex;
  gap: 8px;
}

.dots-loader span {
  width: 12px;
  height: 12px;
  background: var(--accent-blue);
  border-radius: 50%;
  animation: dotPulse 1.4s ease-in-out infinite;
}

.dots-loader span:nth-child(1) { animation-delay: 0s; }
.dots-loader span:nth-child(2) { animation-delay: 0.16s; }
.dots-loader span:nth-child(3) { animation-delay: 0.32s; }
```

### Continuous Animations

```css
/* Float */
@keyframes float {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-20px);
  }
}

.float {
  animation: float 3s ease-in-out infinite;
}

/* Bounce */
@keyframes bounce {
  0%, 20%, 50%, 80%, 100% {
    transform: translateY(0);
  }
  40% {
    transform: translateY(-10px);
  }
  60% {
    transform: translateY(-5px);
  }
}

.bounce {
  animation: bounce 2s infinite;
}

/* Rotate */
@keyframes rotate {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

.rotate {
  animation: rotate 2s linear infinite;
}

/* Ping (ripple effect) */
@keyframes ping {
  0% {
    transform: scale(1);
    opacity: 1;
  }
  75%, 100% {
    transform: scale(2);
    opacity: 0;
  }
}

.ping {
  animation: ping 1s cubic-bezier(0, 0, 0.2, 1) infinite;
}
```

### Gradient Animations

```css
/* Gradient shift */
@keyframes gradientShift {
  0%, 100% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
}

.gradient-animated {
  background: linear-gradient(
    -45deg,
    #667eea,
    #764ba2,
    #f093fb,
    #4facfe
  );
  background-size: 400% 400%;
  animation: gradientShift 15s ease infinite;
}

/* Gradient rotate */
@keyframes gradientRotate {
  0% {
    background-position: 0% 0%;
  }
  25% {
    background-position: 100% 0%;
  }
  50% {
    background-position: 100% 100%;
  }
  75% {
    background-position: 0% 100%;
  }
  100% {
    background-position: 0% 0%;
  }
}

.gradient-rotate {
  background-size: 200% 200%;
  animation: gradientRotate 10s ease infinite;
}
```

## Scroll-Based Animations

### Intersection Observer

```javascript
// Reveal elements on scroll
const observerOptions = {
  threshold: 0.1,
  rootMargin: '0px 0px -100px 0px'
};

const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('is-visible');
      observer.unobserve(entry.target); // Only animate once
    }
  });
}, observerOptions);

// Observe all elements with .reveal class
document.querySelectorAll('.reveal').forEach(el => {
  observer.observe(el);
});
```

```css
.reveal {
  opacity: 0;
  transform: translateY(30px);
  transition: opacity 600ms var(--ease-out),
              transform 600ms var(--ease-out);
}

.reveal.is-visible {
  opacity: 1;
  transform: translateY(0);
}
```

### Parallax Effect

```javascript
// Simple parallax on scroll
window.addEventListener('scroll', () => {
  const scrolled = window.pageYOffset;
  const parallax = document.querySelector('.parallax');

  if (parallax) {
    parallax.style.transform = `translateY(${scrolled * 0.5}px)`;
  }
});
```

```css
.parallax {
  transition: transform 0.1s ease-out;
  will-change: transform;
}
```

## Interactive Animations

### Button Ripple Effect

```css
.btn-ripple {
  position: relative;
  overflow: hidden;
}

.btn-ripple::after {
  content: '';
  position: absolute;
  top: 50%;
  left: 50%;
  width: 0;
  height: 0;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.5);
  transform: translate(-50%, -50%);
  transition: width 0.6s ease, height 0.6s ease;
}

.btn-ripple:active::after {
  width: 300px;
  height: 300px;
}
```

### Shake (Error Feedback)

```css
@keyframes shake {
  0%, 100% {
    transform: translateX(0);
  }
  10%, 30%, 50%, 70%, 90% {
    transform: translateX(-10px);
  }
  20%, 40%, 60%, 80% {
    transform: translateX(10px);
  }
}

.shake {
  animation: shake 500ms ease-in-out;
}
```

### Success Checkmark

```html
<svg class="checkmark" viewBox="0 0 52 52">
  <circle class="checkmark-circle" cx="26" cy="26" r="25" fill="none"/>
  <path class="checkmark-check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
</svg>
```

```css
.checkmark {
  width: 56px;
  height: 56px;
  border-radius: 50%;
  stroke-width: 2;
  stroke: var(--color-success);
  stroke-miterlimit: 10;
}

.checkmark-circle {
  stroke-dasharray: 166;
  stroke-dashoffset: 166;
  stroke-width: 2;
  animation: checkmarkCircle 600ms ease forwards;
}

.checkmark-check {
  stroke-dasharray: 48;
  stroke-dashoffset: 48;
  animation: checkmarkCheck 600ms 300ms ease forwards;
}

@keyframes checkmarkCircle {
  to {
    stroke-dashoffset: 0;
  }
}

@keyframes checkmarkCheck {
  to {
    stroke-dashoffset: 0;
  }
}
```

## Page Transitions

### Fade Transition

```css
.page-enter {
  opacity: 0;
}

.page-enter-active {
  opacity: 1;
  transition: opacity 300ms var(--ease-out);
}

.page-exit {
  opacity: 1;
}

.page-exit-active {
  opacity: 0;
  transition: opacity 200ms var(--ease-in);
}
```

### Slide Transition

```css
.page-slide-enter {
  transform: translateX(100%);
}

.page-slide-enter-active {
  transform: translateX(0);
  transition: transform 400ms var(--ease-out);
}

.page-slide-exit {
  transform: translateX(0);
}

.page-slide-exit-active {
  transform: translateX(-100%);
  transition: transform 400ms var(--ease-in);
}
```

## Performance Optimization

### Use GPU Acceleration

```css
/* Good: GPU-accelerated */
.element {
  transform: translateZ(0);
  will-change: transform;
}

/* Trigger GPU for smooth animations */
.animated {
  transform: translate3d(0, 0, 0);
}
```

### will-change Property

```css
/* Apply only when needed */
.element:hover {
  will-change: transform;
}

/* Remove after animation */
.element {
  will-change: auto;
}
```

### Avoid Layout Thrashing

```css
/* Bad: Causes reflow */
.element {
  width: 100px;
  transition: width 300ms ease;
}

.element:hover {
  width: 200px; /* Triggers layout recalculation */
}

/* Good: Uses transform */
.element {
  transform: scaleX(1);
  transform-origin: left;
  transition: transform 300ms ease;
}

.element:hover {
  transform: scaleX(2); /* GPU-accelerated */
}
```

## Accessibility

### Respect Reduced Motion

```css
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
```

### Skip Animations for Assistive Tech

```css
/* Only animate for sighted users */
@media (prefers-reduced-motion: no-preference) {
  .animate {
    animation: fadeIn 600ms ease;
  }
}
```

## Best Practices

### 1. Keep It Simple
```css
/* Good: Simple, clear */
transition: transform 300ms ease;

/* Bad: Too complex */
transition: all 300ms cubic-bezier(0.68, -0.55, 0.265, 1.55);
```

### 2. Animate Only What's Needed
```css
/* Good: Specific properties */
transition: transform 300ms ease, opacity 300ms ease;

/* Avoid: "all" is expensive */
transition: all 300ms ease;
```

### 3. Use Appropriate Durations
```css
/* Too fast (jarring) */
transition: transform 50ms ease;

/* Good (smooth) */
transition: transform 300ms ease;

/* Too slow (sluggish) */
transition: transform 2000ms ease;
```

### 4. Match Enter/Exit Timing
```css
/* Enter: Slower, ease-out */
.modal-enter {
  transition: all 400ms var(--ease-out);
}

/* Exit: Faster, ease-in */
.modal-exit {
  transition: all 300ms var(--ease-in);
}
```

## Testing Animations

### Browser DevTools
- Use Chrome DevTools Performance tab
- Look for 60fps (16.6ms per frame)
- Check for layout thrashing

### Checklist
- [ ] Animations run at 60fps
- [ ] No janky or stuttering motion
- [ ] Works on low-end devices
- [ ] Respects prefers-reduced-motion
- [ ] Doesn't distract from content
- [ ] Provides clear feedback
- [ ] Completes in reasonable time

## Summary

Great animations should:
1. Be purposeful and enhance UX
2. Use GPU-accelerated properties
3. Have appropriate timing and easing
4. Respect user preferences
5. Perform smoothly on all devices
6. Feel natural and responsive
7. Not distract from content

Remember: Animation is a tool to enhance the user experience, not a decoration. Use it wisely.

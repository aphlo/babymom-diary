# Apple Design System - Typography System

Complete typography guidelines for creating readable, elegant, and accessible text hierarchies.

## Font Stack

### System Font Stack

Apple uses San Francisco (SF Pro) on their platforms. For web, use the system font stack:

```css
:root {
  --font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Display',
                 'SF Pro Text', 'Segoe UI', 'Roboto', 'Helvetica Neue',
                 Arial, sans-serif;
  --font-family-mono: 'SF Mono', 'Monaco', 'Inconsolata', 'Fira Code',
                      'Courier New', monospace;
}

body {
  font-family: var(--font-family);
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

code, pre {
  font-family: var(--font-family-mono);
}
```

### Font Smoothing

Always enable font smoothing for crisp text rendering:

```css
body {
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-rendering: optimizeLegibility;
}
```

## Type Scale

### Scale Definition

```css
:root {
  /* Display */
  --text-xs: 0.75rem;     /* 12px */
  --text-sm: 0.875rem;    /* 14px */
  --text-base: 1rem;      /* 16px */
  --text-lg: 1.125rem;    /* 18px */
  --text-xl: 1.25rem;     /* 20px */
  --text-2xl: 1.5rem;     /* 24px */
  --text-3xl: 1.875rem;   /* 30px */
  --text-4xl: 2.25rem;    /* 36px */
  --text-5xl: 3rem;       /* 48px */
  --text-6xl: 3.75rem;    /* 60px */
  --text-7xl: 4.5rem;     /* 72px */
  --text-8xl: 6rem;       /* 96px */

  /* Font Weights */
  --font-thin: 100;
  --font-extralight: 200;
  --font-light: 300;
  --font-normal: 400;
  --font-medium: 500;
  --font-semibold: 600;
  --font-bold: 700;
  --font-extrabold: 800;
  --font-black: 900;

  /* Line Heights */
  --leading-none: 1;
  --leading-tight: 1.1;
  --leading-snug: 1.3;
  --leading-normal: 1.5;
  --leading-relaxed: 1.6;
  --leading-loose: 1.8;

  /* Letter Spacing */
  --tracking-tighter: -0.05em;
  --tracking-tight: -0.02em;
  --tracking-normal: 0;
  --tracking-wide: 0.025em;
  --tracking-wider: 0.05em;
  --tracking-widest: 0.1em;
}
```

## Typography Hierarchy

### Heading Styles

```css
h1, .h1 {
  font-size: clamp(2.5rem, 5vw + 1rem, 4.5rem);
  font-weight: var(--font-bold);
  line-height: var(--leading-tight);
  letter-spacing: var(--tracking-tight);
  margin-bottom: 1.5rem;
}

h2, .h2 {
  font-size: clamp(2rem, 4vw + 0.5rem, 3rem);
  font-weight: var(--font-semibold);
  line-height: var(--leading-tight);
  letter-spacing: var(--tracking-tight);
  margin-bottom: 1.25rem;
}

h3, .h3 {
  font-size: clamp(1.5rem, 3vw, 2rem);
  font-weight: var(--font-semibold);
  line-height: var(--leading-snug);
  margin-bottom: 1rem;
}

h4, .h4 {
  font-size: var(--text-xl);
  font-weight: var(--font-semibold);
  line-height: var(--leading-snug);
  margin-bottom: 0.75rem;
}

h5, .h5 {
  font-size: var(--text-lg);
  font-weight: var(--font-medium);
  line-height: var(--leading-normal);
  margin-bottom: 0.5rem;
}

h6, .h6 {
  font-size: var(--text-base);
  font-weight: var(--font-medium);
  line-height: var(--leading-normal);
  margin-bottom: 0.5rem;
}
```

### Body Text

```css
p, .text-body {
  font-size: var(--text-base);
  font-weight: var(--font-normal);
  line-height: var(--leading-relaxed);
  margin-bottom: 1rem;
}

.text-lead {
  font-size: var(--text-lg);
  font-weight: var(--font-normal);
  line-height: var(--leading-relaxed);
  color: var(--text-secondary);
}

.text-small {
  font-size: var(--text-sm);
  line-height: var(--leading-normal);
}

.text-caption {
  font-size: var(--text-xs);
  line-height: var(--leading-normal);
  color: var(--text-secondary);
  text-transform: uppercase;
  letter-spacing: var(--tracking-wider);
}
```

## Fluid Typography

### Using clamp()

```css
/* Scales from 40px at 320px viewport to 72px at 1920px viewport */
.hero-title {
  font-size: clamp(2.5rem, 2rem + 3vw, 4.5rem);
}

/* Formula: clamp(MIN, PREFERRED, MAX) */

/* More examples */
.section-title {
  font-size: clamp(1.75rem, 1.5rem + 2vw, 3rem);
}

.body-text {
  font-size: clamp(1rem, 0.95rem + 0.25vw, 1.125rem);
}
```

### Responsive Type Scale

```css
/* Mobile */
:root {
  --heading-1: 2.5rem;
  --heading-2: 2rem;
  --heading-3: 1.5rem;
}

/* Tablet */
@media (min-width: 768px) {
  :root {
    --heading-1: 3.5rem;
    --heading-2: 2.5rem;
    --heading-3: 1.875rem;
  }
}

/* Desktop */
@media (min-width: 1024px) {
  :root {
    --heading-1: 4.5rem;
    --heading-2: 3rem;
    --heading-3: 2.25rem;
  }
}
```

## Special Typography Styles

### Display Text (Hero Headlines)

```css
.display-1 {
  font-size: clamp(3rem, 8vw, 6rem);
  font-weight: var(--font-bold);
  line-height: var(--leading-none);
  letter-spacing: var(--tracking-tighter);
}

.display-2 {
  font-size: clamp(2.5rem, 6vw, 4.5rem);
  font-weight: var(--font-bold);
  line-height: var(--leading-tight);
  letter-spacing: var(--tracking-tight);
}
```

### Gradient Text

```css
.gradient-text {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  display: inline-block;
}
```

### Uppercase Labels

```css
.label {
  font-size: var(--text-xs);
  font-weight: var(--font-semibold);
  text-transform: uppercase;
  letter-spacing: var(--tracking-widest);
  color: var(--text-secondary);
}
```

### Blockquotes

```css
blockquote {
  font-size: var(--text-xl);
  font-weight: var(--font-normal);
  line-height: var(--leading-relaxed);
  font-style: italic;
  padding-left: 2rem;
  border-left: 4px solid var(--accent-blue);
  margin: 2rem 0;
  color: var(--text-secondary);
}

blockquote cite {
  display: block;
  margin-top: 1rem;
  font-size: var(--text-sm);
  font-style: normal;
  color: var(--text-tertiary);
}

blockquote cite::before {
  content: '— ';
}
```

## Lists

### Unordered Lists

```css
ul {
  list-style: none;
  padding-left: 0;
}

ul li {
  position: relative;
  padding-left: 1.5rem;
  margin-bottom: 0.75rem;
  line-height: var(--leading-relaxed);
}

ul li::before {
  content: '•';
  position: absolute;
  left: 0;
  color: var(--accent-blue);
  font-weight: var(--font-bold);
}
```

### Ordered Lists

```css
ol {
  counter-reset: list-counter;
  padding-left: 0;
}

ol li {
  counter-increment: list-counter;
  position: relative;
  padding-left: 2rem;
  margin-bottom: 0.75rem;
  line-height: var(--leading-relaxed);
}

ol li::before {
  content: counter(list-counter) '.';
  position: absolute;
  left: 0;
  color: var(--accent-blue);
  font-weight: var(--font-semibold);
}
```

## Links

```css
a {
  color: var(--accent-blue);
  text-decoration: none;
  transition: all 0.2s ease;
  position: relative;
}

a:hover {
  color: var(--accent-blue-hover);
}

/* Underline animation */
a.link-underline {
  position: relative;
}

a.link-underline::after {
  content: '';
  position: absolute;
  bottom: -2px;
  left: 0;
  width: 0;
  height: 2px;
  background: currentColor;
  transition: width 0.3s ease;
}

a.link-underline:hover::after {
  width: 100%;
}

/* External link indicator */
a[href^='http']::after {
  content: '↗';
  margin-left: 0.25rem;
  font-size: 0.75em;
  opacity: 0.6;
}
```

## Code & Preformatted Text

### Inline Code

```css
code {
  font-family: var(--font-family-mono);
  font-size: 0.875em;
  padding: 0.2em 0.4em;
  background: var(--bg-secondary);
  border: 1px solid var(--border-primary);
  border-radius: 6px;
  color: var(--accent-purple);
}
```

### Code Blocks

```css
pre {
  font-family: var(--font-family-mono);
  font-size: var(--text-sm);
  line-height: var(--leading-relaxed);
  padding: 1.5rem;
  background: var(--bg-secondary);
  border: 1px solid var(--border-primary);
  border-radius: 12px;
  overflow-x: auto;
  margin: 1.5rem 0;
}

pre code {
  padding: 0;
  background: none;
  border: none;
  color: inherit;
}
```

## Text Utilities

### Alignment

```css
.text-left { text-align: left; }
.text-center { text-align: center; }
.text-right { text-align: right; }
.text-justify { text-align: justify; }
```

### Decoration

```css
.underline { text-decoration: underline; }
.line-through { text-decoration: line-through; }
.no-underline { text-decoration: none; }
```

### Transform

```css
.uppercase { text-transform: uppercase; }
.lowercase { text-transform: lowercase; }
.capitalize { text-transform: capitalize; }
```

### Truncation

```css
.truncate {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.line-clamp-3 {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
```

### Word Break

```css
.break-normal { overflow-wrap: normal; word-break: normal; }
.break-words { overflow-wrap: break-word; }
.break-all { word-break: break-all; }
```

## Accessibility

### Readable Line Length

Optimal line length: 50-75 characters per line

```css
.prose {
  max-width: 65ch; /* 65 characters wide */
}
```

### Focus States

```css
a:focus-visible,
button:focus-visible {
  outline: 2px solid var(--accent-blue);
  outline-offset: 2px;
  border-radius: 4px;
}

/* Remove focus for mouse users */
a:focus:not(:focus-visible) {
  outline: none;
}
```

### Screen Reader Only Text

```css
.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border-width: 0;
}
```

## Best Practices

### 1. Use Relative Units

```css
/* Good: Scales with user preferences */
font-size: 1rem;
padding: 1.5rem;

/* Avoid: Fixed pixels ignore user settings */
font-size: 16px;
```

### 2. Maintain Clear Hierarchy

```css
/* Clear visual hierarchy */
h1 { font-size: 3rem; font-weight: 700; }
h2 { font-size: 2.25rem; font-weight: 600; }
h3 { font-size: 1.75rem; font-weight: 600; }
p { font-size: 1rem; font-weight: 400; }
```

### 3. Ensure Readability

```css
/* Good: Comfortable line height */
p {
  line-height: 1.6;
  max-width: 65ch;
}

/* Bad: Too tight */
p {
  line-height: 1.2;
}
```

### 4. Use Proper Letter Spacing

```css
/* Large headings: Tighter */
h1 {
  letter-spacing: -0.02em;
}

/* Small caps: Wider */
.label {
  text-transform: uppercase;
  letter-spacing: 0.1em;
}

/* Body text: Normal */
p {
  letter-spacing: 0;
}
```

### 5. Contrast Requirements

- **Normal text (< 24px)**: 4.5:1 minimum (WCAG AA)
- **Large text (≥ 24px)**: 3:1 minimum (WCAG AA)
- **Enhanced**: 7:1 for AAA compliance

```css
/* Ensure sufficient contrast */
.text-primary {
  color: #1d1d1f; /* 15.8:1 on white */
}

.text-secondary {
  color: #86868b; /* 4.6:1 on white - meets AA */
}
```

## Performance

### Subset Fonts

If using custom fonts, subset to only needed characters:

```css
/* Load only Latin characters */
@font-face {
  font-family: 'CustomFont';
  src: url('font.woff2') format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC,
                 U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074,
                 U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215,
                 U+FEFF, U+FFFD;
  font-display: swap;
}
```

### Font Loading Strategy

```css
@font-face {
  font-family: 'CustomFont';
  src: url('font.woff2') format('woff2');
  font-weight: 400;
  font-style: normal;
  font-display: swap; /* Show fallback immediately */
}
```

## Summary

Good typography should:
1. Establish clear visual hierarchy
2. Be readable and accessible
3. Scale appropriately across devices
4. Use system fonts for performance
5. Meet WCAG contrast requirements
6. Respect user preferences (font size, reduced motion)
7. Be consistent and predictable

Typography is the foundation of good design. Invest time in getting it right.

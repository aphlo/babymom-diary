# Apple Design System

A comprehensive design system for creating Apple-inspired modern, minimalist UI designs.

## 📁 Structure

```
apple-design/
├── SKILL.md                    # Main skill file (422 lines)
├── README.md                   # This file
├── references/                 # Detailed reference documentation
│   ├── design-principles.md    # Design philosophy and guidelines
│   ├── color-system.md         # Color palettes, gradients, dark mode
│   ├── typography-system.md    # Typography scale and hierarchy
│   ├── animation-guide.md      # Animation timing and patterns
│   └── components-reference.md # Full component library
├── templates/                  # Ready-to-use HTML templates
│   ├── hero-section.html       # Full-screen hero with gradient
│   ├── project-card.html       # Project showcase cards
│   ├── contact-form.html       # Contact form with validation
│   └── footer.html             # Footer with newsletter
├── examples/                   # Pre-built CSS examples
│   ├── color-palette.css       # Complete color system
│   └── animations.css          # Animation library
└── scripts/                    # Utility scripts
    ├── README.md               # Scripts documentation
    ├── generate-color-vars.js  # Generate CSS variables
    └── check-contrast.js       # Check WCAG contrast
```

## 🎨 Features

### Design System
- **Minimalist Design**: Clean, uncluttered interfaces
- **8px Grid System**: Consistent spacing throughout
- **Fluid Typography**: Responsive text using clamp()
- **Dark Mode**: Full support with CSS custom properties
- **Glassmorphism**: Frosted glass effects
- **Smooth Animations**: 300-600ms transitions

### Components
- Hero sections
- Navigation bars
- Project cards
- Glass cards
- Buttons (Primary, Secondary, Ghost)
- Contact forms
- Footers
- Modals
- And more...

### Color System
- Light & Dark mode palettes
- Semantic colors (success, error, warning, info)
- Pre-defined gradients
- Accessibility-compliant (WCAG AA minimum)

### Typography
- System font stack
- Responsive type scale
- Clear hierarchy
- Optimal readability

### Animations
- Hover effects (lift, scale, glow)
- Entrance animations (fade, slide, scale)
- Loading states (skeleton, spinner)
- Scroll-based animations
- Performance-optimized (GPU-accelerated)

## 🚀 Quick Start

### 1. Basic Setup

```html
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Portfolio</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <!-- Your content -->
</body>
</html>
```

### 2. Include Color System

```css
/* Import from examples/color-palette.css */
@import url('examples/color-palette.css');

/* Or define your own */
:root {
  --bg-primary: #ffffff;
  --text-primary: #1d1d1f;
  --accent-blue: #0071e3;
}

@media (prefers-color-scheme: dark) {
  :root {
    --bg-primary: #000000;
    --text-primary: #f5f5f7;
    --accent-blue: #0a84ff;
  }
}
```

### 3. Apply Typography

```css
body {
  font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Display', 'Segoe UI', sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

h1 {
  font-size: clamp(2.5rem, 5vw + 1rem, 4.5rem);
  font-weight: 700;
  letter-spacing: -0.02em;
}
```

### 4. Use Templates

Copy templates from `templates/` folder and customize:
- `hero-section.html` - For landing page hero
- `project-card.html` - For portfolio project showcase
- `contact-form.html` - For contact page
- `footer.html` - For site footer

## 📖 Documentation

### Core Principles
See [design-principles.md](references/design-principles.md) for detailed guidelines on:
- Minimalism & clarity
- Typography excellence
- Color philosophy
- Spacing & layout
- Visual effects
- Motion & interactivity

### Color System
See [color-system.md](references/color-system.md) for:
- Complete color palettes
- Gradient presets
- Dark mode implementation
- Accessibility guidelines
- Theme switching

### Typography
See [typography-system.md](references/typography-system.md) for:
- Font stacks
- Type scales
- Fluid typography
- Text utilities
- Accessibility

### Animations
See [animation-guide.md](references/animation-guide.md) for:
- Animation principles
- Timing & easing
- Common patterns
- Performance optimization
- Accessibility

### Components
See [components-reference.md](references/components-reference.md) for:
- Navigation
- Hero sections
- Cards
- Buttons
- Forms
- And more...

## 🛠️ Utility Scripts

### Generate Color Variables
```bash
node scripts/generate-color-vars.js
```
Creates CSS custom properties from color palette.

### Check Contrast Ratios
```bash
node scripts/check-contrast.js
```
Validates WCAG contrast compliance for your colors.

See [scripts/README.md](scripts/README.md) for detailed usage.

## ✅ Best Practices

### Performance
- ✅ Animate only `transform` and `opacity`
- ✅ Use `will-change` sparingly
- ✅ Optimize images (WebP, lazy loading)
- ❌ Avoid animating `width`, `height`, `top`, `left`

### Accessibility
- ✅ Maintain 4.5:1 contrast ratio (WCAG AA)
- ✅ Provide focus indicators
- ✅ Use semantic HTML
- ✅ Add ARIA labels
- ✅ Respect `prefers-reduced-motion`
- ✅ Minimum touch target: 44x44px

### Responsive Design
- ✅ Mobile-first approach
- ✅ Use `clamp()` for fluid typography
- ✅ Flexible grid layouts
- ✅ Test on real devices

### Code Organization
- ✅ Use CSS variables
- ✅ Keep specificity low
- ✅ Document complex calculations
- ✅ Group related properties

## 🎯 Use Cases

This design system is perfect for:
- Portfolio websites
- Landing pages
- Product showcases
- Personal blogs
- SaaS marketing sites
- Mobile app landing pages

## 📚 Resources

### Official Apple Resources
- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [SF Pro Font](https://developer.apple.com/fonts/)

### Useful Tools
- [Framer Motion](https://www.framer.com/motion/) - React animations
- [Tailwind CSS](https://tailwindcss.com/) - Utility-first CSS
- [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
- [Coolors](https://coolors.co/) - Color palette generator

## 💡 Examples

### Hero Section
```html
<section class="hero">
  <div class="hero-content">
    <h1>Hi, I'm <span class="gradient-text">Your Name</span></h1>
    <p>Developer creating amazing experiences</p>
    <button class="btn btn-primary">View Work</button>
  </div>
</section>
```

### Glass Card
```css
.glass-card {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(20px) saturate(180%);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 20px;
  padding: 2rem;
}
```

### Hover Animation
```css
.card {
  transition: transform 300ms ease;
}

.card:hover {
  transform: translateY(-8px);
}
```

## 📄 License

This design system is open source and available for use in your projects.

## 🤝 Contributing

Feel free to customize and extend this design system for your needs. If you create useful components or utilities, consider sharing them back.

---

**Remember**: Apple's design philosophy is about removing the unnecessary to let the essential shine. Keep it simple, elegant, and focused on the user's needs.

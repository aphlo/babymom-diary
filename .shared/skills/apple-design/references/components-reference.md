# Apple Design System - Components Reference

Comprehensive reference for all Apple-inspired UI components with code examples, variations, and best practices.

## Table of Contents
- [Navigation](#navigation)
- [Hero Sections](#hero-sections)
- [Cards](#cards)
- [Buttons](#buttons)
- [Forms](#forms)
- [Typography](#typography-components)
- [Modals & Overlays](#modals--overlays)
- [Lists & Grids](#lists--grids)
- [Media](#media)
- [Footer](#footer)

---

## Navigation

### Fixed Navigation Bar

```html
<nav class="navbar">
  <div class="navbar-container">
    <a href="#" class="navbar-logo">Logo</a>
    <ul class="navbar-menu">
      <li><a href="#about" class="navbar-link">About</a></li>
      <li><a href="#work" class="navbar-link">Work</a></li>
      <li><a href="#contact" class="navbar-link">Contact</a></li>
    </ul>
    <button class="navbar-toggle" aria-label="Toggle menu">
      <span></span>
      <span></span>
      <span></span>
    </button>
  </div>
</nav>
```

```css
.navbar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1000;
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(20px) saturate(180%);
  -webkit-backdrop-filter: blur(20px) saturate(180%);
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
}

.navbar-container {
  max-width: 1280px;
  margin: 0 auto;
  padding: 1rem 2rem;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.navbar-logo {
  font-size: 1.5rem;
  font-weight: 700;
  color: var(--text-primary);
  text-decoration: none;
}

.navbar-menu {
  display: none;
  gap: 2rem;
  list-style: none;
}

@media (min-width: 768px) {
  .navbar-menu {
    display: flex;
  }

  .navbar-toggle {
    display: none;
  }
}

.navbar-link {
  font-size: 0.875rem;
  font-weight: 500;
  color: var(--text-primary);
  text-decoration: none;
  transition: opacity 0.2s ease;
  position: relative;
}

.navbar-link::after {
  content: '';
  position: absolute;
  bottom: -4px;
  left: 0;
  width: 0;
  height: 2px;
  background: currentColor;
  transition: width 0.3s ease;
}

.navbar-link:hover::after {
  width: 100%;
}

.navbar-toggle {
  display: flex;
  flex-direction: column;
  gap: 4px;
  background: none;
  border: none;
  padding: 0.5rem;
  cursor: pointer;
}

.navbar-toggle span {
  width: 24px;
  height: 2px;
  background: var(--text-primary);
  transition: all 0.3s ease;
}

@media (prefers-color-scheme: dark) {
  .navbar {
    background: rgba(30, 30, 30, 0.8);
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  }
}
```

### Sidebar Navigation

```html
<aside class="sidebar">
  <div class="sidebar-header">
    <h2>Menu</h2>
    <button class="sidebar-close" aria-label="Close menu">×</button>
  </div>
  <nav class="sidebar-nav">
    <a href="#" class="sidebar-link active">Dashboard</a>
    <a href="#" class="sidebar-link">Projects</a>
    <a href="#" class="sidebar-link">Settings</a>
  </nav>
</aside>
```

```css
.sidebar {
  position: fixed;
  top: 0;
  left: 0;
  width: 280px;
  height: 100vh;
  background: var(--bg-secondary);
  border-right: 1px solid var(--border-primary);
  padding: 2rem;
  transform: translateX(-100%);
  transition: transform 0.3s ease;
  z-index: 1001;
}

.sidebar.open {
  transform: translateX(0);
}

.sidebar-nav {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  margin-top: 2rem;
}

.sidebar-link {
  padding: 0.75rem 1rem;
  border-radius: 12px;
  color: var(--text-primary);
  text-decoration: none;
  font-weight: 500;
  transition: background 0.2s ease;
}

.sidebar-link:hover {
  background: rgba(0, 0, 0, 0.05);
}

.sidebar-link.active {
  background: var(--accent-blue);
  color: white;
}
```

---

## Hero Sections

### Full-Screen Hero with Gradient

```html
<section class="hero-gradient">
  <div class="hero-content">
    <h1 class="hero-title">
      Create amazing <span class="gradient-text">experiences</span>
    </h1>
    <p class="hero-subtitle">
      Beautiful, modern designs that captivate and inspire
    </p>
    <div class="hero-actions">
      <button class="btn btn-primary">Get Started</button>
      <button class="btn btn-secondary">Learn More</button>
    </div>
  </div>
  <div class="scroll-indicator">
    <svg width="24" height="24" fill="none" stroke="currentColor">
      <path d="M19 14l-7 7m0 0l-7-7m7 7V3" stroke-width="2" stroke-linecap="round"/>
    </svg>
  </div>
</section>
```

```css
.hero-gradient {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  text-align: center;
  padding: 2rem;
  position: relative;
}

.hero-content {
  max-width: 900px;
  animation: fadeInUp 1s ease-out;
}

.hero-title {
  font-size: clamp(2.5rem, 8vw, 5rem);
  font-weight: 700;
  line-height: 1.1;
  margin-bottom: 1.5rem;
  letter-spacing: -0.02em;
}

.gradient-text {
  background: linear-gradient(135deg, #fff 0%, rgba(255, 255, 255, 0.8) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.hero-subtitle {
  font-size: clamp(1.125rem, 3vw, 1.5rem);
  font-weight: 400;
  opacity: 0.9;
  max-width: 600px;
  margin: 0 auto 2.5rem;
  line-height: 1.6;
}

.hero-actions {
  display: flex;
  gap: 1rem;
  justify-content: center;
  flex-wrap: wrap;
}

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
```

### Hero with Background Image

```html
<section class="hero-image" style="background-image: url('hero.jpg')">
  <div class="hero-overlay"></div>
  <div class="hero-content">
    <h1 class="hero-title">Welcome to the Future</h1>
    <p class="hero-subtitle">Innovation meets design</p>
    <button class="btn btn-glass">Explore Now</button>
  </div>
</section>
```

```css
.hero-image {
  min-height: 100vh;
  background-size: cover;
  background-position: center;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  text-align: center;
}

.hero-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(
    180deg,
    rgba(0, 0, 0, 0.3) 0%,
    rgba(0, 0, 0, 0.6) 100%
  );
}

.hero-content {
  position: relative;
  z-index: 1;
  max-width: 800px;
  padding: 2rem;
}
```

---

## Cards

### Project Card with Hover Effect

```html
<article class="project-card">
  <div class="project-image-wrapper">
    <img src="project.jpg" alt="Project" class="project-image">
    <div class="project-overlay">
      <button class="btn-icon">
        <svg><!-- Eye icon --></svg>
      </button>
    </div>
  </div>
  <div class="project-content">
    <h3 class="project-title">Project Name</h3>
    <p class="project-description">Brief description of the project</p>
    <div class="project-tags">
      <span class="tag">React</span>
      <span class="tag">TypeScript</span>
    </div>
  </div>
</article>
```

```css
.project-card {
  border-radius: 24px;
  overflow: hidden;
  background: var(--bg-secondary);
  box-shadow: var(--shadow-md);
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

.project-card:hover {
  transform: translateY(-8px);
  box-shadow: var(--shadow-lg);
}

.project-image-wrapper {
  position: relative;
  aspect-ratio: 16 / 9;
  overflow: hidden;
}

.project-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.6s ease;
}

.project-card:hover .project-image {
  transform: scale(1.05);
}

.project-overlay {
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.project-card:hover .project-overlay {
  opacity: 1;
}

.project-content {
  padding: 2rem;
}

.project-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
  margin-top: 1rem;
}

.tag {
  padding: 0.5rem 1rem;
  background: rgba(102, 126, 234, 0.1);
  color: #667eea;
  border-radius: 12px;
  font-size: 0.875rem;
  font-weight: 500;
}
```

### Glass Card

```html
<div class="glass-card">
  <h3 class="card-title">Glass Card</h3>
  <p class="card-text">Content with glassmorphism effect</p>
</div>
```

```css
.glass-card {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(20px) saturate(180%);
  -webkit-backdrop-filter: blur(20px) saturate(180%);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 20px;
  padding: 2rem;
  box-shadow:
    0 8px 32px rgba(0, 0, 0, 0.1),
    inset 0 1px 0 rgba(255, 255, 255, 0.2);
}

@media (prefers-color-scheme: dark) {
  .glass-card {
    background: rgba(30, 30, 30, 0.7);
    border: 1px solid rgba(255, 255, 255, 0.1);
  }
}
```

### Feature Card

```html
<div class="feature-card">
  <div class="feature-icon">
    <svg><!-- Icon --></svg>
  </div>
  <h3 class="feature-title">Feature Title</h3>
  <p class="feature-description">Description of the feature</p>
</div>
```

```css
.feature-card {
  padding: 2.5rem;
  background: var(--bg-secondary);
  border-radius: 20px;
  border: 1px solid var(--border-primary);
  transition: all 0.3s ease;
  text-align: center;
}

.feature-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-md);
  border-color: var(--accent-blue);
}

.feature-icon {
  width: 64px;
  height: 64px;
  margin: 0 auto 1.5rem;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 16px;
  color: white;
}

.feature-title {
  font-size: 1.25rem;
  font-weight: 600;
  margin-bottom: 0.75rem;
}

.feature-description {
  color: var(--text-secondary);
  line-height: 1.6;
}
```

---

## Buttons

### Button Variants

```html
<!-- Primary -->
<button class="btn btn-primary">Primary Button</button>

<!-- Secondary -->
<button class="btn btn-secondary">Secondary Button</button>

<!-- Ghost -->
<button class="btn btn-ghost">Ghost Button</button>

<!-- Icon Button -->
<button class="btn btn-icon">
  <svg width="20" height="20"><!-- Icon --></svg>
</button>

<!-- Button with Icon -->
<button class="btn btn-primary">
  <svg width="20" height="20"><!-- Icon --></svg>
  <span>Button with Icon</span>
</button>
```

```css
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  padding: 0.875rem 1.75rem;
  border-radius: 980px;
  font-size: 1rem;
  font-weight: 500;
  border: none;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  text-decoration: none;
  min-height: 44px;
}

.btn-primary {
  background: var(--accent-blue);
  color: white;
}

.btn-primary:hover {
  background: var(--accent-blue-hover);
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(0, 113, 227, 0.3);
}

.btn-secondary {
  background: transparent;
  color: var(--accent-blue);
  border: 2px solid var(--accent-blue);
}

.btn-secondary:hover {
  background: var(--accent-blue);
  color: white;
}

.btn-ghost {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  color: white;
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.btn-ghost:hover {
  background: rgba(255, 255, 255, 0.2);
}

.btn-icon {
  width: 44px;
  height: 44px;
  padding: 0;
  border-radius: 12px;
}

.btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
  transform: none !important;
}

.btn:focus-visible {
  outline: 2px solid var(--accent-blue);
  outline-offset: 2px;
}
```

---

## Forms

### Modern Form

```html
<form class="modern-form">
  <div class="form-group">
    <label for="name" class="form-label">Name</label>
    <input type="text" id="name" class="form-input" placeholder="Enter your name">
  </div>

  <div class="form-group">
    <label for="email" class="form-label">Email</label>
    <input type="email" id="email" class="form-input" placeholder="you@example.com">
  </div>

  <div class="form-group">
    <label for="message" class="form-label">Message</label>
    <textarea id="message" class="form-textarea" rows="4" placeholder="Your message"></textarea>
  </div>

  <button type="submit" class="btn btn-primary">Send Message</button>
</form>
```

```css
.modern-form {
  max-width: 600px;
  margin: 0 auto;
}

.form-group {
  margin-bottom: 1.5rem;
}

.form-label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: 500;
  color: var(--text-primary);
  font-size: 0.875rem;
}

.form-input,
.form-textarea {
  width: 100%;
  padding: 1rem;
  background: var(--bg-secondary);
  border: 1px solid var(--border-primary);
  border-radius: 12px;
  font-size: 1rem;
  color: var(--text-primary);
  font-family: inherit;
  transition: all 0.3s ease;
}

.form-input:focus,
.form-textarea:focus {
  outline: none;
  border-color: var(--accent-blue);
  box-shadow: 0 0 0 4px rgba(0, 113, 227, 0.1);
}

.form-input::placeholder,
.form-textarea::placeholder {
  color: var(--text-secondary);
}

.form-textarea {
  resize: vertical;
  min-height: 120px;
}

.form-error {
  margin-top: 0.5rem;
  color: var(--accent-red);
  font-size: 0.875rem;
}
```

---

## Typography Components

### Section Header

```html
<div class="section-header">
  <p class="section-label">Our Work</p>
  <h2 class="section-title">Featured Projects</h2>
  <p class="section-subtitle">
    Explore our latest work and see how we bring ideas to life
  </p>
</div>
```

```css
.section-header {
  text-align: center;
  max-width: 800px;
  margin: 0 auto 4rem;
}

.section-label {
  color: var(--accent-blue);
  font-weight: 600;
  font-size: 0.875rem;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  margin-bottom: 1rem;
}

.section-title {
  font-size: clamp(2rem, 5vw, 3rem);
  font-weight: 700;
  margin-bottom: 1rem;
  letter-spacing: -0.02em;
}

.section-subtitle {
  font-size: 1.125rem;
  color: var(--text-secondary);
  line-height: 1.6;
}
```

---

## Modals & Overlays

### Modal Dialog

```html
<div class="modal-overlay" role="dialog" aria-modal="true">
  <div class="modal">
    <div class="modal-header">
      <h2 class="modal-title">Modal Title</h2>
      <button class="modal-close" aria-label="Close">×</button>
    </div>
    <div class="modal-body">
      <p>Modal content goes here</p>
    </div>
    <div class="modal-footer">
      <button class="btn btn-secondary">Cancel</button>
      <button class="btn btn-primary">Confirm</button>
    </div>
  </div>
</div>
```

```css
.modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.5);
  backdrop-filter: blur(4px);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  padding: 1rem;
  animation: fadeIn 0.3s ease;
}

.modal {
  background: var(--bg-primary);
  border-radius: 24px;
  max-width: 500px;
  width: 100%;
  box-shadow: var(--shadow-xl);
  animation: scaleIn 0.3s ease;
}

.modal-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 1.5rem 2rem;
  border-bottom: 1px solid var(--border-primary);
}

.modal-title {
  font-size: 1.5rem;
  font-weight: 600;
}

.modal-close {
  width: 32px;
  height: 32px;
  border: none;
  background: none;
  font-size: 2rem;
  color: var(--text-secondary);
  cursor: pointer;
  line-height: 1;
}

.modal-body {
  padding: 2rem;
}

.modal-footer {
  display: flex;
  gap: 1rem;
  justify-content: flex-end;
  padding: 1.5rem 2rem;
  border-top: 1px solid var(--border-primary);
}

@keyframes scaleIn {
  from {
    transform: scale(0.9);
    opacity: 0;
  }
  to {
    transform: scale(1);
    opacity: 1;
  }
}
```

---

## Lists & Grids

### Responsive Grid

```html
<div class="grid grid-3">
  <div class="grid-item">Item 1</div>
  <div class="grid-item">Item 2</div>
  <div class="grid-item">Item 3</div>
</div>
```

```css
.grid {
  display: grid;
  gap: 2rem;
}

.grid-2 {
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
}

.grid-3 {
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
}

.grid-4 {
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
}

@media (max-width: 640px) {
  .grid {
    grid-template-columns: 1fr;
  }
}
```

---

This reference provides a solid foundation. See also:
- [design-principles.md](design-principles.md) for design philosophy
- [color-system.md](color-system.md) for color palettes
- [typography-system.md](typography-system.md) for typography guidelines
- [animation-guide.md](animation-guide.md) for animation patterns

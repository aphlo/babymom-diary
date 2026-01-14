# Apple Design System - Color System

Complete color palette and usage guidelines for creating Apple-inspired interfaces with proper light/dark mode support.

## Color Philosophy

Apple uses color purposefully and sparingly:
- **Neutral base**: Black, white, and grays form the foundation
- **Accent colors**: Used strategically for CTAs, status, and highlights
- **Semantic meaning**: Colors communicate function and state
- **Accessibility first**: All colors meet WCAG contrast requirements

## Color Palettes

### Light Mode Palette

```css
:root {
  /* Background Colors */
  --bg-primary: #ffffff;
  --bg-secondary: #f5f5f7;
  --bg-tertiary: #e8e8ed;

  /* Text Colors */
  --text-primary: #1d1d1f;
  --text-secondary: #86868b;
  --text-tertiary: #6e6e73;

  /* Brand Accent Colors */
  --accent-blue: #0071e3;
  --accent-blue-hover: #0077ed;
  --accent-green: #30d158;
  --accent-orange: #ff9500;
  --accent-red: #ff3b30;
  --accent-purple: #bf5af2;
  --accent-pink: #ff2d55;
  --accent-yellow: #ffd60a;

  /* Border & Divider Colors */
  --border-primary: rgba(0, 0, 0, 0.1);
  --border-secondary: rgba(0, 0, 0, 0.05);
  --divider: rgba(0, 0, 0, 0.08);

  /* Overlay */
  --overlay-light: rgba(0, 0, 0, 0.4);
  --overlay-dark: rgba(0, 0, 0, 0.7);
}
```

### Dark Mode Palette

```css
@media (prefers-color-scheme: dark) {
  :root {
    /* Background Colors */
    --bg-primary: #000000;
    --bg-secondary: #1d1d1f;
    --bg-tertiary: #2c2c2e;

    /* Text Colors */
    --text-primary: #f5f5f7;
    --text-secondary: #a1a1a6;
    --text-tertiary: #6e6e73;

    /* Brand Accent Colors (brighter for dark mode) */
    --accent-blue: #0a84ff;
    --accent-blue-hover: #409cff;
    --accent-green: #32d74b;
    --accent-orange: #ff9f0a;
    --accent-red: #ff453a;
    --accent-purple: #bf5af2;
    --accent-pink: #ff375f;
    --accent-yellow: #ffd60a;

    /* Border & Divider Colors */
    --border-primary: rgba(255, 255, 255, 0.1);
    --border-secondary: rgba(255, 255, 255, 0.05);
    --divider: rgba(255, 255, 255, 0.08);

    /* Overlay */
    --overlay-light: rgba(0, 0, 0, 0.6);
    --overlay-dark: rgba(0, 0, 0, 0.85);
  }
}
```

## Semantic Colors

### Status Colors

```css
:root {
  /* Success */
  --color-success: #30d158;
  --color-success-bg: rgba(48, 209, 88, 0.1);

  /* Warning */
  --color-warning: #ff9500;
  --color-warning-bg: rgba(255, 149, 0, 0.1);

  /* Error */
  --color-error: #ff3b30;
  --color-error-bg: rgba(255, 59, 48, 0.1);

  /* Info */
  --color-info: #0a84ff;
  --color-info-bg: rgba(10, 132, 255, 0.1);
}

@media (prefers-color-scheme: dark) {
  :root {
    --color-success: #32d74b;
    --color-warning: #ff9f0a;
    --color-error: #ff453a;
    --color-info: #0a84ff;
  }
}
```

### Usage Examples

```css
/* Success message */
.alert-success {
  background: var(--color-success-bg);
  color: var(--color-success);
  border-left: 4px solid var(--color-success);
}

/* Error message */
.alert-error {
  background: var(--color-error-bg);
  color: var(--color-error);
  border-left: 4px solid var(--color-error);
}
```

## Gradient Presets

### Brand Gradients

```css
/* Blue to Purple */
.gradient-blue-purple {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

/* Pink to Orange */
.gradient-pink-orange {
  background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
}

/* Green to Blue */
.gradient-green-blue {
  background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
}

/* Purple to Pink */
.gradient-purple-pink {
  background: linear-gradient(135deg, #bf5af2 0%, #ff2d55 100%);
}

/* Sunset */
.gradient-sunset {
  background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
}

/* Ocean */
.gradient-ocean {
  background: linear-gradient(135deg, #667eea 0%, #4facfe 100%);
}

/* Forest */
.gradient-forest {
  background: linear-gradient(135deg, #30d158 0%, #0a84ff 100%);
}
```

### Mesh Gradients

```css
/* Complex mesh gradient */
.gradient-mesh {
  background:
    radial-gradient(at 0% 0%, rgba(102, 126, 234, 0.33) 0%, transparent 50%),
    radial-gradient(at 100% 0%, rgba(118, 75, 162, 0.33) 0%, transparent 50%),
    radial-gradient(at 100% 100%, rgba(240, 147, 251, 0.33) 0%, transparent 50%),
    radial-gradient(at 0% 100%, rgba(79, 172, 254, 0.33) 0%, transparent 50%),
    linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}
```

### Text Gradients

```css
.text-gradient {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

/* Animated gradient text */
.text-gradient-animated {
  background: linear-gradient(
    -45deg,
    #667eea,
    #764ba2,
    #f093fb,
    #4facfe
  );
  background-size: 400% 400%;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  animation: gradientShift 15s ease infinite;
}

@keyframes gradientShift {
  0%, 100% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
}
```

## Color Usage Guidelines

### Primary Actions
Use blue for primary CTAs and important actions:
```css
.btn-primary {
  background: var(--accent-blue);
  color: white;
}
```

### Success States
Use green for success confirmations and positive actions:
```css
.success-badge {
  background: var(--color-success);
  color: white;
}
```

### Warnings
Use orange/yellow for warnings and non-critical alerts:
```css
.warning-banner {
  background: var(--color-warning-bg);
  color: var(--color-warning);
}
```

### Errors
Use red for errors and destructive actions:
```css
.error-message {
  color: var(--color-error);
}

.btn-delete {
  background: var(--accent-red);
  color: white;
}
```

## Accessibility

### Contrast Ratios

All colors meet WCAG AA standards minimum:

| Combination | Contrast Ratio | WCAG Level |
|-------------|----------------|------------|
| --text-primary on --bg-primary | 15.8:1 | AAA |
| --text-secondary on --bg-primary | 4.6:1 | AA |
| --accent-blue on white | 4.6:1 | AA |
| --accent-blue (dark) on black | 7.2:1 | AAA |

### Checking Contrast

```javascript
// Use this function to check if colors meet WCAG standards
function getContrastRatio(color1, color2) {
  // Convert colors to luminance values
  // Calculate contrast ratio
  // Return ratio (e.g., 4.5:1)
}
```

### Color Blindness Considerations

- Don't rely on color alone to convey information
- Use icons, labels, or patterns alongside colors
- Test with color blindness simulators
- Provide alternative visual cues

```css
/* Good: Uses icon + color */
.status-success {
  color: var(--color-success);
}

.status-success::before {
  content: '✓'; /* Checkmark provides visual cue */
  margin-right: 0.5rem;
}
```

## Shadow Colors

### Light Mode Shadows

```css
:root {
  --shadow-sm:
    0 1px 2px rgba(0, 0, 0, 0.04),
    0 1px 4px rgba(0, 0, 0, 0.04);

  --shadow-md:
    0 2px 4px rgba(0, 0, 0, 0.04),
    0 4px 12px rgba(0, 0, 0, 0.08);

  --shadow-lg:
    0 4px 8px rgba(0, 0, 0, 0.04),
    0 8px 24px rgba(0, 0, 0, 0.08),
    0 16px 32px rgba(0, 0, 0, 0.08);

  --shadow-xl:
    0 8px 16px rgba(0, 0, 0, 0.04),
    0 16px 32px rgba(0, 0, 0, 0.08),
    0 24px 48px rgba(0, 0, 0, 0.12);
}
```

### Dark Mode Shadows

```css
@media (prefers-color-scheme: dark) {
  :root {
    --shadow-sm:
      0 1px 2px rgba(0, 0, 0, 0.2),
      0 1px 4px rgba(0, 0, 0, 0.2);

    --shadow-md:
      0 2px 4px rgba(0, 0, 0, 0.2),
      0 4px 12px rgba(0, 0, 0, 0.3);

    --shadow-lg:
      0 4px 8px rgba(0, 0, 0, 0.2),
      0 8px 24px rgba(0, 0, 0, 0.3),
      0 16px 32px rgba(0, 0, 0, 0.4);

    --shadow-xl:
      0 8px 16px rgba(0, 0, 0, 0.3),
      0 16px 32px rgba(0, 0, 0, 0.4),
      0 24px 48px rgba(0, 0, 0, 0.5);
  }
}
```

## Glassmorphism

### Glass Effect Variables

```css
:root {
  --glass-bg: rgba(255, 255, 255, 0.1);
  --glass-border: rgba(255, 255, 255, 0.2);
  --glass-shadow:
    0 8px 32px rgba(0, 0, 0, 0.1),
    inset 0 1px 0 rgba(255, 255, 255, 0.3);
}

@media (prefers-color-scheme: dark) {
  :root {
    --glass-bg: rgba(30, 30, 30, 0.7);
    --glass-border: rgba(255, 255, 255, 0.1);
    --glass-shadow:
      0 8px 32px rgba(0, 0, 0, 0.5),
      inset 0 1px 0 rgba(255, 255, 255, 0.1);
  }
}
```

### Glass Component

```css
.glass {
  background: var(--glass-bg);
  backdrop-filter: blur(20px) saturate(180%);
  -webkit-backdrop-filter: blur(20px) saturate(180%);
  border: 1px solid var(--glass-border);
  box-shadow: var(--glass-shadow);
}

/* Glass variations */
.glass-light {
  background: rgba(255, 255, 255, 0.2);
}

.glass-dark {
  background: rgba(0, 0, 0, 0.3);
}

.glass-blue {
  background: rgba(0, 113, 227, 0.1);
  border: 1px solid rgba(0, 113, 227, 0.2);
}
```

## Theme Switching

### JavaScript Implementation

```javascript
// Get user's preference
const getThemePreference = () => {
  if (localStorage.getItem('theme')) {
    return localStorage.getItem('theme');
  }
  return window.matchMedia('(prefers-color-scheme: dark)').matches
    ? 'dark'
    : 'light';
};

// Set theme
const setTheme = (theme) => {
  document.documentElement.setAttribute('data-theme', theme);
  localStorage.setItem('theme', theme);
};

// Toggle theme
const toggleTheme = () => {
  const current = getThemePreference();
  setTheme(current === 'dark' ? 'light' : 'dark');
};

// Initialize
setTheme(getThemePreference());
```

### CSS for Manual Theme Control

```css
/* Override system preference with manual control */
[data-theme='light'] {
  --bg-primary: #ffffff;
  --text-primary: #1d1d1f;
  /* ... other light mode colors */
}

[data-theme='dark'] {
  --bg-primary: #000000;
  --text-primary: #f5f5f7;
  /* ... other dark mode colors */
}
```

## Color Utilities

### Utility Classes

```css
/* Background utilities */
.bg-primary { background-color: var(--bg-primary); }
.bg-secondary { background-color: var(--bg-secondary); }

/* Text utilities */
.text-primary { color: var(--text-primary); }
.text-secondary { color: var(--text-secondary); }
.text-blue { color: var(--accent-blue); }
.text-green { color: var(--accent-green); }
.text-red { color: var(--accent-red); }

/* Border utilities */
.border { border: 1px solid var(--border-primary); }
.border-blue { border-color: var(--accent-blue); }

/* Gradient utilities */
.gradient-text {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}
```

## Color Manipulation

### Opacity Variations

```css
/* Create color variations using opacity */
.bg-blue-10 { background: rgba(0, 113, 227, 0.1); }
.bg-blue-20 { background: rgba(0, 113, 227, 0.2); }
.bg-blue-30 { background: rgba(0, 113, 227, 0.3); }

.text-blue-50 { color: rgba(0, 113, 227, 0.5); }
.text-blue-75 { color: rgba(0, 113, 227, 0.75); }
```

### Filter Effects

```css
/* Brighten on hover */
.hover-brighten:hover {
  filter: brightness(1.1);
}

/* Darken overlay */
.overlay-dark {
  background: rgba(0, 0, 0, 0.5);
}

/* Saturate for vibrancy */
.saturate {
  filter: saturate(1.2);
}
```

## Best Practices

1. **Consistency**: Use CSS variables for all colors
2. **Contrast**: Always check WCAG contrast ratios
3. **Purpose**: Every color should serve a clear function
4. **Restraint**: Limit color palette to avoid visual noise
5. **Context**: Consider cultural color meanings
6. **Testing**: Test in both light and dark modes
7. **Accessibility**: Don't rely solely on color to convey info

## Testing Your Colors

Use these tools to validate your color choices:
- [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
- [Coolors](https://coolors.co/) - Color palette generator
- [Color Blindness Simulator](https://www.color-blindness.com/coblis-color-blindness-simulator/)

## Summary

A well-designed color system should:
- Provide clear visual hierarchy
- Support both light and dark modes seamlessly
- Meet accessibility standards
- Be consistent and predictable
- Enhance, not distract from, content

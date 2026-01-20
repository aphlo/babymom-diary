# Apple Design System - Scripts

Utility scripts to help you work with the Apple Design System.

## Available Scripts

### 1. generate-color-vars.js

Generates CSS custom properties from a color palette.

**Usage:**
```bash
node scripts/generate-color-vars.js
```

**Purpose:**
- Quickly create CSS variables for your theme
- Maintain consistency across light and dark modes
- Easy to customize by editing the `colorPalette` object

**Output:**
Prints CSS variables to console. You can redirect to a file:
```bash
node scripts/generate-color-vars.js > my-colors.css
```

---

### 2. check-contrast.js

Checks if color combinations meet WCAG accessibility standards.

**Usage:**
```bash
node scripts/check-contrast.js
```

**Purpose:**
- Ensure your color combinations have sufficient contrast
- Validate WCAG AA and AAA compliance
- Test both normal and large text requirements

**Output:**
```
✅ Text Primary on BG Primary (Light)
   Foreground: #1d1d1f
   Background: #ffffff
   Ratio: 15.8:1
   WCAG: AAA (normal), AAA (large)
```

**WCAG Standards:**
- **AA (normal)**: 4.5:1 minimum contrast
- **AA (large)**: 3:1 minimum contrast
- **AAA (normal)**: 7:1 minimum contrast
- **AAA (large)**: 4.5:1 minimum contrast

**Customization:**
Edit the `colorPairs` array to test your own color combinations:
```javascript
const colorPairs = [
  { name: 'My Color Test', fg: '#your-color', bg: '#background' },
];
```

---

## Requirements

These scripts use Node.js. Make sure you have Node.js installed:

```bash
node --version  # Should show v14 or higher
```

## Adding More Scripts

Feel free to add more utility scripts for:
- Generating spacing scales
- Creating typography scales
- Testing animation timing
- Generating component boilerplate
- Optimizing SVG icons
- And more!

## Contributing

If you create useful scripts for the design system, consider sharing them back to improve the toolkit for everyone.

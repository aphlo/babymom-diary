#!/usr/bin/env node

/**
 * Generate Color Variables
 *
 * This script generates CSS custom properties from a color palette.
 * Useful for quickly creating theme variables from a design system.
 *
 * Usage: node generate-color-vars.js
 */

const colorPalette = {
  // Background Colors
  backgrounds: {
    primary: { light: '#ffffff', dark: '#000000' },
    secondary: { light: '#f5f5f7', dark: '#1d1d1f' },
    tertiary: { light: '#e8e8ed', dark: '#2c2c2e' },
  },

  // Text Colors
  text: {
    primary: { light: '#1d1d1f', dark: '#f5f5f7' },
    secondary: { light: '#86868b', dark: '#a1a1a6' },
    tertiary: { light: '#6e6e73', dark: '#6e6e73' },
  },

  // Accent Colors
  accents: {
    blue: { light: '#0071e3', dark: '#0a84ff' },
    green: { light: '#30d158', dark: '#32d74b' },
    orange: { light: '#ff9500', dark: '#ff9f0a' },
    red: { light: '#ff3b30', dark: '#ff453a' },
    purple: { light: '#bf5af2', dark: '#bf5af2' },
    pink: { light: '#ff2d55', dark: '#ff375f' },
    yellow: { light: '#ffd60a', dark: '#ffd60a' },
  },

  // Border Colors
  borders: {
    primary: { light: 'rgba(0, 0, 0, 0.1)', dark: 'rgba(255, 255, 255, 0.1)' },
    secondary: { light: 'rgba(0, 0, 0, 0.05)', dark: 'rgba(255, 255, 255, 0.05)' },
  },
};

function generateCSS() {
  let css = `:root {\n`;
  css += `  /* ========================================\n`;
  css += `     Light Mode Colors\n`;
  css += `     ======================================== */\n\n`;

  // Light mode
  for (const [category, colors] of Object.entries(colorPalette)) {
    const categoryName = category.charAt(0).toUpperCase() + category.slice(1);
    css += `  /* ${categoryName} */\n`;

    for (const [name, value] of Object.entries(colors)) {
      const varName = `--${category.slice(0, -1)}-${name}`;
      css += `  ${varName}: ${value.light};\n`;
    }
    css += `\n`;
  }

  css += `}\n\n`;

  // Dark mode
  css += `@media (prefers-color-scheme: dark) {\n`;
  css += `  :root {\n`;
  css += `    /* ========================================\n`;
  css += `       Dark Mode Colors\n`;
  css += `       ======================================== */\n\n`;

  for (const [category, colors] of Object.entries(colorPalette)) {
    const categoryName = category.charAt(0).toUpperCase() + category.slice(1);
    css += `    /* ${categoryName} */\n`;

    for (const [name, value] of Object.entries(colors)) {
      const varName = `--${category.slice(0, -1)}-${name}`;
      css += `    ${varName}: ${value.dark};\n`;
    }
    css += `\n`;
  }

  css += `  }\n`;
  css += `}\n`;

  return css;
}

// Generate and output
const css = generateCSS();
console.log(css);

// If you want to save to file:
// const fs = require('fs');
// fs.writeFileSync('color-variables.css', css);
// console.log('✅ Generated color-variables.css');

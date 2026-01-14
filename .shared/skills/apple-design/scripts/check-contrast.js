#!/usr/bin/env node

/**
 * Contrast Ratio Checker
 *
 * Checks if color combinations meet WCAG accessibility standards.
 * Helps ensure your design system has sufficient contrast.
 *
 * Usage: node check-contrast.js
 */

// Color pairs to check (foreground, background)
const colorPairs = [
  { name: 'Text Primary on BG Primary (Light)', fg: '#1d1d1f', bg: '#ffffff' },
  { name: 'Text Secondary on BG Primary (Light)', fg: '#86868b', bg: '#ffffff' },
  { name: 'Blue on White', fg: '#0071e3', bg: '#ffffff' },
  { name: 'Text Primary on BG Primary (Dark)', fg: '#f5f5f7', bg: '#000000' },
  { name: 'Text Secondary on BG Primary (Dark)', fg: '#a1a1a6', bg: '#000000' },
  { name: 'Blue (Dark) on Black', fg: '#0a84ff', bg: '#000000' },
];

/**
 * Convert hex color to RGB
 */
function hexToRgb(hex) {
  const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
  return result ? {
    r: parseInt(result[1], 16),
    g: parseInt(result[2], 16),
    b: parseInt(result[3], 16),
  } : null;
}

/**
 * Calculate relative luminance
 * https://www.w3.org/TR/WCAG20/#relativeluminancedef
 */
function getLuminance(rgb) {
  const { r, g, b } = rgb;

  const [rs, gs, bs] = [r, g, b].map(c => {
    c = c / 255;
    return c <= 0.03928 ? c / 12.92 : Math.pow((c + 0.055) / 1.055, 2.4);
  });

  return 0.2126 * rs + 0.7152 * gs + 0.0722 * bs;
}

/**
 * Calculate contrast ratio
 * https://www.w3.org/TR/WCAG20/#contrast-ratiodef
 */
function getContrastRatio(color1, color2) {
  const rgb1 = hexToRgb(color1);
  const rgb2 = hexToRgb(color2);

  const lum1 = getLuminance(rgb1);
  const lum2 = getLuminance(rgb2);

  const lighter = Math.max(lum1, lum2);
  const darker = Math.min(lum1, lum2);

  return (lighter + 0.05) / (darker + 0.05);
}

/**
 * Check WCAG compliance
 */
function checkWCAG(ratio) {
  return {
    normalAAA: ratio >= 7,
    normalAA: ratio >= 4.5,
    largeAAA: ratio >= 4.5,
    largeAA: ratio >= 3,
  };
}

/**
 * Format compliance status
 */
function formatCompliance(compliance) {
  const results = [];

  if (compliance.normalAAA) results.push('AAA (normal)');
  else if (compliance.normalAA) results.push('AA (normal)');

  if (compliance.largeAAA) results.push('AAA (large)');
  else if (compliance.largeAA) results.push('AA (large)');

  return results.length > 0 ? results.join(', ') : 'FAIL';
}

/**
 * Get status emoji
 */
function getStatusEmoji(compliance) {
  if (compliance.normalAAA) return '✅';
  if (compliance.normalAA) return '✓';
  if (compliance.largeAA) return '⚠️';
  return '❌';
}

// Run checks
console.log('\n🎨 Color Contrast Checker\n');
console.log('='.repeat(80));
console.log();

colorPairs.forEach(pair => {
  const ratio = getContrastRatio(pair.fg, pair.bg);
  const compliance = checkWCAG(ratio);
  const status = getStatusEmoji(compliance);
  const level = formatCompliance(compliance);

  console.log(`${status} ${pair.name}`);
  console.log(`   Foreground: ${pair.fg}`);
  console.log(`   Background: ${pair.bg}`);
  console.log(`   Ratio: ${ratio.toFixed(2)}:1`);
  console.log(`   WCAG: ${level}`);
  console.log();
});

console.log('='.repeat(80));
console.log('\nLegend:');
console.log('✅ = Passes AAA (normal text)');
console.log('✓  = Passes AA (normal text)');
console.log('⚠️  = Passes only for large text');
console.log('❌ = Fails all standards');
console.log('\nNormal text: < 24px or < 18px bold');
console.log('Large text: ≥ 24px or ≥ 18px bold\n');

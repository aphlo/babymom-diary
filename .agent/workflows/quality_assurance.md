# Quality Assurance Workflow (milu-qa-check)

This workflow defines the quality assurance and code verification rules for Flutter, Official Site, and Cloud Functions development in this repository.

## Commands

- `/qa-check`: Validate all code format, static analysis (lint), and tests.

## Verification Rules (Hooks)

Whenever you modify, add, or refactor any code inside the project, you **MUST** run the verification tasks corresponding to the modified components.

### 1. Flutter (`flutter/` directory)

When modifying Flutter code, you must run:
1. **Format Code**: Run `rake format` inside `flutter/` directory.
2. **Analyze Code (Lint)**: Run `rake lint` inside `flutter/` directory. Ensure there are 0 warnings or errors.
3. **Run Unit Tests**: Run `rake test` inside `flutter/` directory. Verify that all tests pass.

```bash
cd flutter
rake format && rake lint && rake test
```

### 2. Official Site (`official-site/` directory)

When modifying Official Site code, you must run:
1. **Format & Lint (Biome)**: Run `pnpm run biome:ci` inside `official-site/` directory. (Use `pnpm run biome:check` to auto-fix and format).
2. **Linter (ESLint)**: Run `pnpm run lint` inside `official-site/` directory. Ensure there are 0 errors.

```bash
cd official-site
pnpm run biome:ci && pnpm run lint
```

### 3. Cloud Functions (`cloud-functions/` directory)

When modifying Cloud Functions code, you must run:
1. **Check & Format (Biome)**: Run `pnpm run check` inside `cloud-functions/` directory. (Use `pnpm run check:fix` or `pnpm run format` to auto-fix and format).
2. **Linter (Biome)**: Run `pnpm run lint` inside `cloud-functions/` directory. Ensure there are 0 errors.
3. **Run Unit Tests**: Run `pnpm run test` inside `cloud-functions/` directory. Verify that all tests pass.

```bash
cd cloud-functions
pnpm run check && pnpm run lint && pnpm run test
```

If any command fails, you must fix the code and rerun the checks until everything passes successfully. Never finish a turn with unresolved lint warnings/errors or broken tests.

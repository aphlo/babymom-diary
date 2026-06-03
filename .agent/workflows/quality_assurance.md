# Quality Assurance Workflow (flutter-qa-check)

This workflow defines the quality assurance and code verification rules for Flutter development in this repository.

## Commands

- `/qa-check`: Validate all Flutter code format, static analysis (lint), and tests.

## Verification Rules (Hooks)

Whenever you modify, add, or refactor any code inside the `flutter/` directory, you **MUST** run the verification tasks.

### Checklist before ending the turn:
1. **Format Code**: Run `rake format` inside `flutter/` directory.
2. **Analyze Code (Lint)**: Run `rake lint` inside `flutter/` directory. Ensure there are 0 warnings or errors.
3. **Run Unit Tests**: Run `rake test` inside `flutter/` directory. Verify that all tests pass.

```bash
cd flutter
rake format && rake lint && rake test
```

If any command fails, you must fix the code and rerun the checks until everything passes successfully. Never finish a turn with unresolved lint warnings or broken tests.

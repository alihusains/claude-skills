---
name: verify
description: "Run comprehensive, project-aware verification on current codebase state."
origin: CC-Consolidated
---

# Verify Skill

Run comprehensive verification on current codebase state. This polymorphic trigger detects the project type and executes the appropriate verification loop.

## Usage
Trigger: `/verify`

## Project Detection Logic
The skill checks for the following markers in the root directory:
- `pom.xml` / `build.gradle` -> Triggers **Spring Boot Verification**
- `manage.py` -> Triggers **Django Verification**
- `artisan` -> Triggers **Laravel Verification**
- `package.json` -> Triggers **ECC-Generic JS/TS Verification**
- Otherwise -> Falls back to **Generic Environment Audit**

## Unified Verification Phases

### Phase 1: Build & Environment
- Check if project builds (e.g., `npm run build`, `mvn compile`, `php artisan optimize:clear`)
- Stop immediately on failure.

### Phase 2: Static Analysis & Types
- Run type checker (e.g., `tsc`, `pyright`, `mypy`, `phpstan`)
- Run linter (e.g., `eslint`, `ruff`, `php-cs-fixer`)

### Phase 3: Tests & Coverage
- Run test suite with coverage reporting.
- Target: 80% coverage.

### Phase 4: Security & Secrets
- Scan for hardcoded secrets (`sk-`, `api_key`, etc.)
- Run dependency audit (e.g., `npm audit`, `safety`, `composer audit`)

### Phase 5: Diff & Code Quality
- `git diff --stat` to review volume of changes.
- Check for unintended debugging code (`console.log`, `print`, `var_dump`).

## Output Format
Produces a **VERIFICATION REPORT** summary for the session.

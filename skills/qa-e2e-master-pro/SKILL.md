---
name: qa-e2e-master-pro
description: Unified framework for End-to-End testing (Playwright, Cypress), Unit/Integration (Vitest, Jest), Accessibility (WCAG), and Automated Quality Gates.
type: project
---

# QA & E2E Master Framework

Comprehensive strategy for quality assurance, automated testing, and accessibility compliance, consolidating Playwright, accessibility auditing, and robust verification loops.

## 1. E2E Testing with Playwright

### Reliability & Locators
- **Wait Strategies**: Avoid hard sleeps. Use `page.waitForSelector()`, `page.waitForLoadState('networkidle')`, or locators with built-in retries.
- **Stable Locators**: Prioritize `getByRole`, `getByLabel`, and `getByTestId`. Avoid brittle CSS selectors or XPath.
- **Page Object Model (POM)**: Encapsulate selectors and logic in classes to improve maintainability and reuse.

### Common Patterns
- **Authentication**: Use `storageState` to share authentication state across tests and avoid repeated logins.
- **Network Mocking**: Use `page.route()` to intercept and mock API responses for edge-case testing and performance.
- **Emulation**: Use `page.setViewportSize()` and `userAgent` to test responsive designs and mobile views.
- **Artifacts**: Capture full-page screenshots and video/traces on failure for debugging in CI.

## 2. Unit & Integration Testing (Vitest/Jest)

### Best Practices
- **Isolation**: Ensure tests are independent and don't share state. Mock external dependencies (DBs, APIs).
- **Testing Library**: Use accessibility-first queries. Test behavior, not implementation details (e.g., `userEvent.click` over `fireEvent`).
- **Snapshot Testing**: Use sparingly for complex data structures; prefer explicit assertions for UI components.

## 3. Accessibility (WCAG) Auditing

### Audit Lifecycle
1. **Scope Confirmation**: Target **WCAG 2.1/2.2 Level AA**.
2. **Automated Scanning**: Use `axe-core` or Playwright accessibility snapshots to catch 40% of issues (contrast, missing alt text).
3. **Manual Verification**:
   - **Keyboard Navigation**: Verify tab order, focus indicators, and skip links.
   - **Screen Reader**: Use VoiceOver/NVDA to verify logical reading order and ARIA label accuracy.
   - **Reflow**: Check visibility and functionality at 400% zoom.

## 4. Automated Quality Gates

Implement a multi-phase gate before merging code:

- **Phase 1: Build & Lint**: `npm run build` and `eslint .` to catch syntax and style issues.
- **Phase 2: Type Checking**: `tsc --noEmit` for TypeScript projects.
- **Phase 3: Test Suite**: Run Unit, Integration, and E2E suites with coverage targets (**80%+**).
- **Phase 4: Security**: Run `npm audit`, `snyk`, or specialized scanners (SAST/SCA).
- **Phase 5: Visual Regression**: Use tools like `Percy` or Playwright snapshots to catch unintended UI shifts.

## 5. Flaky Test Management

- **Quarantine**: Move unstable tests to a separate suite (`test.fixme`) until resolved.
- **Isolation**: Use `test.describe.configure({ mode: 'parallel' })` carefully; ensure test data is unique per worker.
- **Retries**: Configure CI to retry failed tests (e.g., `retries: 2`) but monitor retry rates as a sign of instability.

## 6. QA Checklist

- [ ] **Critical User Journeys** covered by E2E tests.
- [ ] **Accessibility** verified via automated tools and manual keyboard check.
- [ ] **No Hard-coded Credentials** in test scripts.
- [ ] **Responsive Design** validated across standard viewports.
- [ ] **80%+ Coverage** on business logic and complex utilities.
- [ ] **Mocking** used for external APIs to ensure stable, fast tests.
- [ ] **Artifact Management** (Traces/Screenshots) configured for CI failures.

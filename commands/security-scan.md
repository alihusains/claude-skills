# Security Scan Command

Perform a comprehensive security audit of the codebase, including secret detection, dependency vulnerability scanning, and static analysis.

## Usage

`/security-scan [target] [--fix]`

- `target`: `all` (default), `secrets`, `deps`, `sast`
- `--fix`: automatically attempt to remediate discovered issues

## Workflow

1. **Secret Detection**: Scan all files (including git history) for API keys, tokens, and credentials.
2. **Dependency Audit**: Check `package.json`, `Cargo.toml`, `pom.xml`, etc., against known vulnerability databases (e.g., `npm audit`, `cargo audit`).
3. **Static Analysis (SAST)**: Analyze code patterns for common security vulnerabilities (XSS, SQL Injection, CSRF, etc.).
4. **Remediation**: Propose or apply fixes for identified issues.

## Exit Codes

- `0`: No vulnerabilities found.
- `1`: High/Critical vulnerabilities found.
- `2`: Scan interrupted or system error.

## Checklist

- [ ] Check for hardcoded secrets
- [ ] Verify dependency integrity
- [ ] Analyze input validation patterns
- [ ] Review authentication/authorization logic
- [ ] Check for sensitive data leakage in logs

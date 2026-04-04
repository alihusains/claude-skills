> This file extends [common/security.md](../common/security.md) with Java specific content.

# Java Security

## Best Practices
- ALWAYS use parameterized queries (via JPA/Hibernate or PreparedStatements) to prevent SQL injection.
- Use `Spring Security` for authentication and authorization.
- Sanitize all HTML output to prevent XSS (e.g., using `OWASP Java HTML Sanitizer`).
- Use secure cryptographic libraries (e.g., `Bouncy Castle`) and never roll your own crypto.

## Secret Management
- Use `Environment Variables` or `Spring Cloud Config/Vault` for secrets.
- NEVER check in `.properties` or `.yml` files containing real passwords or tokens.

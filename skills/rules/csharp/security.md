> This file extends [common/security.md](../common/security.md) with C# specific content.

# C# Security

## Best Practices
- ALWAYS use Entity Framework Core with parameterized queries to prevent SQL injection.
- Use `ASP.NET Core Identity` or `Duende Software IdentityServer` for authentication.
- Implement CSRF protection (`ValidateAntiForgeryToken`) for MVC/Razor pages.
- Use `Data Protection API` for encrypting sensitive data at rest.

## Secret Management
- Use `User Secrets` during development.
- Use `Azure Key Vault` or `Environment Variables` for production secrets.
- NEVER hardcode connection strings or API keys in `appsettings.json`.

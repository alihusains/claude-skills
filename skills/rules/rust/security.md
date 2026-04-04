> This file extends [common/security.md](../common/security.md) with Rust specific content.

# Rust Security

## Memory Safety
- ALWAYS avoid `unsafe` code unless absolutely necessary and documented.
- Use standard library types like `Mutex`, `RwLock`, and `Arc` for safe concurrency.
- Use `cargo audit` regularly to check for vulnerable dependencies in `Cargo.lock`.

## Web & API Security
- Sanitize user input in web frameworks like `Axum` or `Actix-web`.
- Use secure hashing algorithms like `Argon2` for passwords.
- Implement rate limiting and secure headers in production services.

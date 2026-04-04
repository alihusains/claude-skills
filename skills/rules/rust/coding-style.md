> This file extends [common/coding-style.md](../common/coding-style.md) with Rust specific content.

# Rust Coding Style

## Formatter & Linter
- ALWAYS run `cargo fmt` before every commit.
- ALWAYS run `cargo clippy` and fix all warnings before marking work as complete.
- Follow the official Rust Style Guidelines.

## Ownership & Borrowing
- Prefer borrowing (`&T`) over taking ownership (`T`) unless ownership is required.
- Use `&str` instead of `&String` for function arguments.
- Avoid using `Clone` excessively; prefer moving or borrowing.

## Error Handling
- NEVER use `unwrap()` or `expect()` in production code.
- ALWAYS use `Result<T, E>` for operations that can fail.
- Use the `?` operator for clean error propagation.
- Prefer custom error types or crates like `anyhow` and `thiserror`.

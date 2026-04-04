> This file extends [common/testing.md](../common/testing.md) with Rust specific content.

# Rust Testing

## Unit Testing
- Write unit tests in the same file as the code using a `mod tests` block.
- Use `#[test]` for standard tests and `#[tokio::test]` for async tests.
- Use `cargo test` to run the test suite.

## Integration Testing
- Place integration tests in the `tests/` directory at the project root.
- Use `mockall` or `simulacrum` for mocking traits.
- Target 80%+ coverage using tools like `cargo-tarpaulin` or `cargo-llvm-cov`.

---
name: python-ecosystem-master-pro
description: Unified framework for Professional Python Engineering (3.12+), FastAPI, Django 5.x, Async Concurrency, and Advanced Testing (pytest).
type: project
---

# Python Ecosystem Master Guide

Integrated framework for state-of-the-art Python engineering, consolidating modern web frameworks, high-performance concurrency, and rigorous testing standards.

## 1. Modern Python Development (3.12+)

### Language Standards & Tooling
- **Type Safety**: Use PEP 484 type hints globally. Leverage `Annotated` for metadata and `TypeAlias` for complex signatures.
- **Modern Tooling**: Prefer `uv` for lightning-fast package management and `ruff` for linting/formatting (replaces Black, Flake8, and Isort).
- **Core Principles**:
  - **EAFP**: "Easier to Ask Forgiveness than Permission" (use `try/except` rather than `if` checks).
  - **Explicit is better than implicit**: Avoid star imports and "magical" dynamic attributes.

### Performance & Memory
- **Slots**: Use `__slots__` in data-heavy classes to reduce memory footprint.
- **Generators**: Use generator expressions and `yield` for processing large datasets without loading them into memory.
- **String Handling**: Avoid `+` for large-scale string concatenation; use `f-strings` or `"".join()` for performance.

## 2. FastAPI & Modern Web APIs

### Production Patterns
- **Async-First**: Always use `async def` for endpoints involving I/O (DB, API calls).
- **Dependency Injection**: Use `Depends()` to manage authentication, database sessions, and reusable logic.
- **Pydantic V2 Mastery**:
  - Use `model_validate` for input validation and `model_dump` for serialization.
  - Implement `camelCase` aliases via `model_config` for frontend compatibility.

### Reliability
- **Background Tasks**: Use FastAPI's `BackgroundTasks` for lightweight async work; use Celery or Dramatiq for heavy/distributed tasks.
- **Structured Error Handling**: Implement global exception handlers to return consistent RFC 7807 problem details.

## 3. Django Excellence (5.x)

### Architectural Patterns
- **Async Support**: Use async views, middleware, and ORM operations (`aget()`, `acreate()`) to improve throughput.
- **ORM Optimization**:
  - Use `select_related` for ForeignKey/OneToOne (SQL JOIN).
  - Use `prefetch_related` for ManyToMany/Reverse FK (Separate SQL query).
  - Profile queries using `django-debug-toolbar` or `connection.queries`.

### Management & Security
- **Custom Managers**: Encapsulate complex query logic in `QuerySet` subclasses or `Manager` methods.
- **Security**: Always use `parameterized queries` (Django ORM handles this). Enable CSRF, HSTS, and XSS protection headers.

## 4. Async/Await & Concurrency

### Best Practices
- **Parallelism**: Use `asyncio.gather(*tasks)` for concurrent I/O. Use `return_exceptions=True` to prevent one failure from cancelling all tasks.
- **Avoid Blocking**: Never use blocking calls (`requests.get`, `time.sleep`) in async functions; use `httpx` and `asyncio.sleep`.
- **Connection Pooling**: Use `asyncpg` or `Motor` with explicitly managed connection pools to avoid handshake latency.

## 5. Testing Strategy (pytest)

### Patterns & Methodology
- **Fixtures**: Use `conftest.py` for shared fixtures. Favor `scope="function"` for isolation, unless the resource is expensive (e.g., DB container).
- **Parametrization**: Use `@pytest.mark.parametrize` to run the same logic against multiple input/output pairs.
- **Mocking**: Use `pytest-mock` (`mocker` fixture). Prefer `autospec=True` to ensure mocks match the signature of the real objects.

### Async Testing
- **pytest-asyncio**: Mark async tests with `@pytest.mark.asyncio`. Use async fixtures for setup requiring database or network access.

## 6. Python Ecosystem Engineering Checklist
- [ ] **Type Hints**: All function signatures have type annotations.
- [ ] **Linting**: Ruff passes with zero warnings.
- [ ] **Async**: No blocking I/O calls found in async contexts.
- [ ] **ORM**: `select_related`/`prefetch_related` applied to all list views.
- [ ] **Validation**: All external data is validated via Pydantic or Django Forms.
- [ ] **Tests**: 80%+ coverage achieved with pytest.
- [ ] **Documentation**: OpenAPI (FastAPI) or Swagger (Django) is fully annotated.
- [ ] **Environment**: `pyproject.toml` used for dependency and tool configuration.

---
name: systems-cpp-master-pro
description: Unified framework for Professional C/C++ Systems Engineering, encompassing Modern C++ (20/23), Embedded Systems (ARM Cortex), Game Engines (Unreal), and High-Performance memory/concurrency patterns.
type: project
---

# Systems & C++ Master Guide

Integrated framework for state-of-the-art systems engineering, consolidating modern C++ standards, hardware-aware embedded development, and high-performance engine architecture.

## 1. Modern C++ Mastery (C++20/23)

### Core Language Standards
- **Concepts & Constraints**: Replace SFINAE with `concept` and `requires` to enforce template requirements and improve error messages.
- **Ranges Library**: Use `std::ranges` for composable functional pipelines (e.g., `vec | views::filter(p) | views::transform(f)`).
- **Coroutines**: Implement asynchronous I/O and generators using `co_await`, `co_yield`, and `co_return`.
- **Compile-Time Meta**: Maximize `constexpr`, `consteval`, and `constinit` to shift computation from runtime to compile-time.

### Resource Management & Safety
- **RAII is Absolute**: Never use raw `new`/`delete`. Manage all resources (memory, files, locks) via stack-bound objects.
- **Smart Pointers**:
  - `std::unique_ptr`: Default for single ownership (zero overhead).
  - `std::shared_ptr`: Use only when true shared ownership is required (atomic ref-count overhead).
  - `std::weak_ptr`: Break circular dependencies in shared ownership graphs.
- **Rule of Zero/Five**: Prefer the "Rule of Zero" (compiler-generated members). If custom cleanup is needed, implement the "Rule of Five" (Destructor, Copy/Move Constructor, Copy/Move Assignment).

## 2. Rust Mastery (Safety & Systems)

### Ownership & Borrowing
- **Strict Ownership**: Enforce ownership, borrowing (`&T`), and move semantics to eliminate data races and use-after-free bugs at compile-time.
- **Lifetimes**: Use explicit lifetime annotations (`'a`) only when the compiler cannot elide them. Prefer `Struct<'a>` for views into existing data.
- **Smart Pointers**:
  - `Box<T>`: Heap allocation for recursive types or large structs.
  - `Rc<T>` / `Arc<T>`: Reference counting for shared ownership (single-threaded / multi-threaded).
  - `RefCell<T>` / `Mutex<T>`: Interior mutability for runtime borrowing checks.

### Async & Concurrency
- **Async/Await**: Use `tokio` or `async-std` for non-blocking I/O. Leverage `JoinSet` or `select!` for managing multiple concurrent tasks.
- **Send & Sync**: Implement `Send` and `Sync` traits to safely move data across thread boundaries. Ensure all types in `Arc<T>` are `Sync`.
- **Type-State Pattern**: Use the type system to enforce valid state transitions at compile-time (e.g., `Config<Initial> -> Config<Validated>`).

## 3. Embedded & Low-Level Engineering

### ARM Cortex-M Specialization
- **Weakly-Ordered Memory**: Use Memory Barriers (`__DMB()`, `__DSB()`, `__ISB()`) for MMIO to prevent CPU/hardware reordering.
- **Cache Coherency**: ALWAYS invalidate/clean caches when using DMA for high-speed peripherals (ADC, SPI, SDIO).
- **W1C Pattern**: Follow the "Write-1-to-Clear" register pattern for status flags to avoid race conditions.
- **Interrupt Hygiene**:
  - Keep ISRs (Interrupt Service Routines) minimal.
  - Use `volatile` only for hardware registers. Use `std::atomic` for thread/ISR synchronization.
  - Prioritize NVIC groups to prevent priority inversion.

### Hardware Abstraction (HAL)
- **Zero-Cost Abstractions**: Use C++ templates and `inline` functions to create peripheral drivers that compile down to raw register writes.
- **Non-blocking APIs**: Implement state-machine or callback-based drivers for UART/I2C/SPI to avoid stalling the CPU.

## 3. High-Performance Design & Concurrency

### Memory Architecture
- **Data Locality**: Design for the L1/L2 cache. Use contiguous memory (e.g., `std::vector`, `std::array`) over pointer-chasing structures (`std::list`).
- **Custom Allocators**: Use `std::pmr` (Polymorphic Memory Resources) or pool allocators for high-frequency allocations to avoid heap fragmentation.
- **Alignment**: Ensure structs are aligned for the target CPU (e.g., `alignas(64)` for cache-line alignment).

### Concurrency Primitives
- **Synchronization**:
  - Prefer `std::scoped_lock` (C++17) to avoid deadlocks when acquiring multiple mutexes.
  - Use `std::condition_variable` for producer/consumer signaling.
- **Lock-Free Programming**: Leverage `std::atomic<T>` with specific memory orders (`memory_order_acquire/release`) for high-throughput lock-free queues.

## 4. Game Engine & Graphics (Unreal Engine 5.x)

### Unreal C++ Patterns
- **UObject Hygiene**: Wrap all `UObject*` members in `UPROPERTY()` to prevent accidental Garbage Collection.
- **Naming Standards**: Strict prefix usage: `A` (Actor), `U` (Object), `F` (Struct), `I` (Interface), `E` (Enum), `T` (Template).
- **Soft References**: Use `TSoftObjectPtr` and `TSoftClassPtr` for assets to prevent massive load-chains on startup.
- **Interface Implementation**: Use `UINTERFACE` for Blueprint/C++ cross-compatibility.

### Optimization
- **Tick Management**: Disable `PrimaryActorTick.bCanEverTick` if not strictly required. Use Timers instead.
- **Component Lookup**: Cache results of `GetComponentByClass` in `BeginPlay` to avoid per-frame lookups.

## 5. Build Systems & Testing

### Modern CMake Workflow
- **Target-Based Config**: Use `target_link_libraries` and `target_include_directories` instead of global `include_directories`.
- **FetchContent**: Use `FetchContent` to manage external dependencies (e.g., GTest, Benchmark) directly in the build script.
- **Sanitizers**: ALWAYS run with AddressSanitizer (ASan) and ThreadSanitizer (TSan) during development.

### TDD & Quality
- **Table-Driven Tests**: Use `INSTANTIATE_TEST_SUITE_P` in GoogleTest for parameter-driven verification.
- **Interface Mocking**: Use `gmock` to simulate hardware or network layers.
- **Fuzzing**: Integrate `libFuzzer` for robust parsing and protocol validation.

## 6. Systems Engineering Checklist

- [ ] **No raw `new`/`delete`** or manual pointer management (RAII only).
- [ ] **Memory Barriers** implemented for ARM Cortex-M7 MMIO.
- [ ] **`UPROPERTY()`** used for all Unreal Engine object pointers.
- [ ] **Cache Coherency** handled for all DMA operations.
- [ ] **`std::scoped_lock`** used for multi-mutex synchronization.
- [ ] **ASan/TSan** passed for all concurrency tests.
- [ ] **80%+ coverage** achieved with GTest/CTest.
- [ ] **`constexpr`** used for all compile-time constants.
- [ ] **No `static mut`** (Rust) or `volatile` for non-hardware sync.
- [ ] **Rule of Zero/Five** followed for all resource-owning classes.

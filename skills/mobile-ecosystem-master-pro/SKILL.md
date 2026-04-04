---
name: mobile-ecosystem-master-pro
description: Unified framework for Modern Mobile development, covering iOS (Swift 6/SwiftUI), Android (Kotlin/Compose), Flutter (Riverpod/BLoC), and React Native New Architecture.
type: project
---

# Mobile Ecosystem Master Guide

Integrated framework for state-of-the-art mobile engineering, consolidating platform-native mastery, cross-platform performance, and standard-setting UX patterns.

## 1. iOS & Apple Ecosystem (Swift 6 / SwiftUI)

### Swift 6 Concurrency
- **Strict Concurrency**: Enable "Complete" checking. Use `@MainActor` for UI-bound classes. Eliminate data races using `Actors` for shared state and `Sendable` protocols for cross-actor data.
- **Task Management**: Use `Task { }` sparingly; prefer `TaskGroup` or `async let` for parallel operations. Understand the difference between `Task.detached` (new priority/context) and `Task` (inherits context).

### Modern SwiftUI
- **Observation**: Standardize on the `@Observable` macro (iOS 17+). Use `@Bindable` to create bindings to observable properties. Abandon `ObservableObject` and `@Published` for new features.
- **Navigation**: Use `NavigationStack` with `navigationDestination(for:)` for type-safe, programmatic routing.
- **Liquid Glass (iOS 26+)**: Prepare for upcoming glassmorphism and depth-based UI patterns by using `containerRelativeFrame` and standard background materials.

## 2. Android & Google Ecosystem (Kotlin / Compose)

### Architecture & DI
- **Clean Architecture**: Enforce strict layer separation: `UI -> ViewModel -> UseCase -> Repository -> DataSource`. Use **Hilt** for standard Android DI and **Koin** for Multiplatform (KMP) projects.
- **State Management**: Use `StateFlow` in ViewModels. Collect in Compose using `collectAsStateWithLifecycle()` to prevent resource leaks during backgrounding.

### Jetpack Compose Optimization
- **Stability**: Annotate domain models with `@Immutable` or `@Stable`. Use `derivedStateOf` to buffer high-frequency state changes (e.g., scroll offsets) and minimize recompositions.
- **Layout**: Use `LazyColumn` with `items(contentType: ...)` to enable better view recycling. Default to `SubcomposeLayout` only when necessary for slot-based measurements.

## 3. Cross-Platform Frameworks (Flutter / React Native)

### Flutter Mastery
- **State Management**: Prefer **Riverpod** for its compile-time safety and lack of context-dependency. Use **BLoC** for complex, event-driven state transitions in enterprise apps.
- **Native Performance**: Use `Pigeon` for type-safe Platform Channels. Leverage `Impeller` for stutter-free animations, replacing the legacy Skia shader compilation.

### React Native New Architecture
- **Fabric & TurboModules**: Migrate to the New Architecture to eliminate the JSON bridge. Use `Fabric` for synchronous UI rendering and `TurboModules` for lazy-loaded native modules.
- **Bridgeless Mode**: Enable Bridgeless Mode to fully decouple the JS engine from the native runtime, significantly improving startup time and memory overhead.

## 4. Mobile UX & Design Systems

### HIG vs Material 3
- **Navigation**: iOS uses bottom tabs for primary navigation; Android often uses navigation drawers or bottom bars. Implement **Adaptive Layouts** that switch patterns based on the detected OS.
- **Gestures**: Prioritize edge-swipes for navigation on iOS. Ensure Android back-button behavior (physical or gesture) aligns with the app's internal stack.

### Accessibility (a11y)
- **Semantic UI**: Use `accessibilityLabel`, `accessibilityHint`, and `accessibilityElement(children: .combine)`.
- **Dynamic Type**: Support scalable fonts. Test with "Extra Extra Large" settings to ensure layout containers expand without clipping text.

## 5. Deployment & Security

### Secure Storage
- **Biometrics**: Integrate `LocalAuthentication` (iOS) and `BiometricPrompt` (Android) for sensitive operations.
- **Key Management**: Store API tokens and secrets in **Keychain** (iOS) and **EncryptedSharedPreferences** (Android). Never hardcode keys in JS/Dart code.

### Pipeline & Distribution
- **EAS (Expo)**: Standardize on EAS for React Native builds and Over-the-Air (OTA) updates.
- **Shorebird**: Use for Flutter code push (hotpatching) without full App Store re-submissions.

## 6. Mobile Ecosystem Checklist
- [ ] Swift 6 **Strict Concurrency** enabled and warnings resolved.
- [ ] `@Observable` macro used instead of `ObservableObject` (iOS).
- [ ] `collectAsStateWithLifecycle()` used for all Flow collection (Android).
- [ ] No hardcoded secrets; **Keychain/EncryptedPrefs** implementation verified.
- [ ] **Dynamic Type** and **Screen Reader** compatibility tested.
- [ ] **New Architecture** enabled for React Native projects.
- [ ] **Riverpod/BLoC** state management used without `setState` (Flutter).
- [ ] 80%+ coverage on **UseCases** and **ViewModels** (Business Logic).

---
name: frontend-ecosystem-master-pro
description: Unified framework for Modern Frontend development, covering React 18/19 (Next.js), Angular 17+ (Signals), Tailwind CSS v4, and Advanced TypeScript.
type: project
---

# Frontend Ecosystem Master Guide

Integrated framework for state-of-the-art web engineering, consolidating modern framework standards, utility-first design systems, and type-safe application architectures.

## 1. React & Next.js Mastery (React 19 & App Router)

### React 19 & Server-Side Excellence
- **Server Components (RSC)**: Default to Server Components. Use Client Components (`"use client"`) only for hooks, event listeners, or specific interactive nodes.
- **Server Actions & Transitions**: Use `useActionState` (React 19) for mutations with built-in loading/error states. Leverage `startTransition` to keep the UI responsive during non-urgent updates.
- **Form Patterns**: Use `useFormStatus` to access pending states in nested child components without prop drilling.
- **Hydration & Suspense**: Implement `Suspense` boundaries around data-heavy components to enable selective hydration and progressive rendering.

### Next.js Architecture
- **Routing Patterns**: Use **Parallel Routes** (`@slot`) for dashboards and **Intercepting Routes** (`(.)folder`) for modal-based CRUD flows to keep context.
- **Waterfall Elimination**: Fetch data in parallel using `Promise.all()` or separate Server Component boundaries to prevent sequential data fetching delays.

## 2. Angular 17+ & Modern Patterns

### Signal-Driven Architecture
- **Signal Primacy**: Replace `BehaviorSubject` with `signal()`, `computed()`, and `effect()`. Prefer `toSignal()` to bridge RxJS streams into template-friendly signals.
- **Zoneless Delivery**: Aim for zoneless Angular by using signals and `OnPush` change detection for maximum performance and smaller bundle sizes.
- **Template Control Flow**: Use the `@if`, `@for` (with mandatory `track`), and `@switch` syntax for optimized DOM reconciliation.

### Performance & Lazy Loading
- **Deferrable Views**: Use `@defer` with explicit triggers (`viewport`, `hover`, `timer(2s)`) for non-critical sections (e.g., comments, heavy charts).
- **Standalone by Default**: Eliminate `NgModules` in favor of standalone components, directives, and pipes for better tree-shaking.

## 3. Tailwind CSS v4 & Design Systems

### v4 Theme Engineering
- **CSS-First Config**: Use the `@theme` directive in your global CSS to define design tokens. Avoid `tailwind.config.js` for color/spacing overrides.
- **OKLCH Color System**: Use `oklch()` for perceptually uniform colors that work flawlessly across light/dark modes.
- **Container Queries**: Use `@container` variants to create components that respond to their parent's width rather than the screen viewport.

### Component Composition (Radix UI)
- **Headless Primitives**: Compose accessible UI from **Radix UI** primitives. Use `asChild` to pass accessibility props to your custom Tailwind-styled components.
- **Class Variance Authority (CVA)**: Use `cva` to manage complex component variants (size, intent, outline) in a type-safe way.

## 4. Modern State & Type Engineering

### State Orchestration
- **Zustand (Global State)**: Use `subscribeWithSelector` middleware to prevent unnecessary re-renders. Separate state from actions to keep the store clean.
- **TanStack Query (Server State)**: Mandatory for data fetching. Configure `staleTime: 1000 * 60 * 5` as a baseline to minimize redundant network traffic.
- **Vue 3 Composition API**: Use `<script setup>` with `ref` and `computed` for clean, modular component logic.

### TypeScript Standards
- **Strict Mode**: Ensure `strict: true` and `noImplicitAny: true` in `tsconfig`.
- **Discriminated Unions**: Use for exhaustively checking API response states or component variants.
- **Zod Validation**: Use `zod` for runtime validation of all external data (API responses, LocalStorage, Search Params).

## 5. Frontend Ecosystem Checklist
- [ ] **React**: `useActionState` and `useFormStatus` used for forms to avoid manual `loading` states.
- [ ] **Angular**: `@defer` blocks used for non-essential below-the-fold content.
- [ ] **Next.js**: `Promise.all()` used for parallel fetching; no waterfalls found.
- [ ] **Tailwind**: Design tokens defined in CSS via `@theme` (v4 pattern).
- [ ] **Accessibility**: All interactive elements have `aria-` labels and keyboard focus indicators (verified via Radix/Axe).
- [ ] **Performance**: LCP candidates marked with `priority`; CLS minimized via explicit image dimensions.
- [ ] **State**: Client state (Zustand) and Server state (TanStack Query) are logically separated.
- [ ] **Testing**: 80%+ coverage with Vitest/Playwright; accessible-first queries (`getByRole`) used.

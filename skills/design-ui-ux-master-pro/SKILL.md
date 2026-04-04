---
name: design-ui-ux-master-pro
description: Unified framework for Professional UI/UX Design, Modern Frontend Architecture (Radix/Tailwind v4), Apple HIG, and WCAG 2.2 Accessibility.
type: project
---

# UI/UX & Design Master Guide

Integrated framework for state-of-the-art interface design and frontend engineering, consolidating accessibility-first architecture, modern styling patterns, and platform-native standards.

## 1. UX Strategy & Design Intelligence

### Psychological & Interaction Patterns
- **Blink Test**: Ensure the value proposition and primary action are clear within 3-5 seconds.
- **Rule of One**: One clear audience, one core problem, one unique solution, and one primary CTA per view.
- **Fitts's Law**: Interactive targets (buttons, links) must be large enough (min 44x44pt for touch) and positioned for easy reach.
- **Social Proof & Scarcity**: Use "Wisdom of the Crowd" (numbers) and "Expert Approval" near conversion points.

### Design Tokens & Philosophy
- **Semantic Tokens**: Define colors by role (`primary`, `surface`, `error`, `on-surface`) rather than value (`blue-500`).
- **Composition over Configuration**: Prefer small, composable components over large "Swiss Army Knife" components with 20+ props.
- **Mobile-First**: Design for the smallest screen first to force prioritization of content and features.

## 2. Component Architecture (Radix UI)

### Headless & Accessible Primitives
- **asChild Pattern**: Use `asChild` to pass trigger/content functionality to custom elements without adding extra wrapper divs.
  ```tsx
  <Dialog.Trigger asChild>
    <Button variant="outline">Open Modal</Button>
  </Dialog.Trigger>
  ```
- **Controlled vs Uncontrolled**: Use controlled state (`open`, `onOpenChange`) for complex orchestrations; use uncontrolled for simple standalone components.
- **Compound Components**: Use React Context to share state between related primitives (e.g., `Tabs.Root`, `Tabs.List`, `Tabs.Trigger`).

### Implementation Checklist
- [ ] **Focus Management**: Automatic focus trapping in modals and restoration on close.
- [ ] **Keyboard Navigation**: Full support for Tab, Arrows, Enter, and Escape keys.
- [ ] **ARIA**: Meaningful labels and state management (e.g., `aria-expanded`, `aria-hidden`).

## 3. Modern Styling with Tailwind v4

### CSS-First Configuration
- **Theme Definition**: Define your design system directly in CSS using the `@theme` block.
  ```css
  @theme {
    --color-brand: oklch(0.6 0.2 260);
    --font-sans: "Inter", system-ui, sans-serif;
  }
  ```
- **Modern Color Spaces**: Use `OKLCH` for perceptually uniform colors and better gradients.
- **Container Queries**: Use native `@container` classes for components that adapt to their parent size rather than the viewport.

### Layout Patterns
- **Grid-First**: Use CSS Grid for overall page structure; use Flexbox for one-dimensional alignment within components.
- **Aspect Ratio**: Use the `aspect-*` utility to prevent layout shift during image loading.
- **Dynamic Viewports**: Use `svh`, `lvh`, and `dvh` to handle mobile browser toolbars correctly.

## 4. Apple Human Interface Guidelines (HIG)

### Foundations & Platforms
- **Platform Continuity**: Respect platform-specific idioms (e.g., Tab Bar on iOS, Sidebar on macOS/visionOS).
- **Adaptivity**: Use "Size Classes" (Compact vs Regular) to transform layouts between phone, tablet, and desktop.
- **System Materials**: Leverage vibrancy and blurring (glassmorphism) to communicate hierarchy and depth.

### Input & Interaction
- **Gestures**: Prioritize standard gestures (tap, swipe, pinch) and avoid custom gestures that conflict with system-level navigation.
- **Haptics**: Use `UIImpactFeedbackGenerator` to provide physical confirmation for significant actions.
- **Pointer Effects**: Implement hover states and magnetic effects for iPadOS and macOS cursor interactions.

## 5. Accessibility (WCAG 2.2)

### The Audit Checklist
- [ ] **Contrast**: 4.5:1 minimum for text; 3:1 for UI components (WCAG AA).
- [ ] **Text Scaling**: Ensure layouts don't break when text is scaled up to 200%.
- [ ] **Screen Readers**: Use semantic HTML (`<main>`, `<nav>`, `<article>`) and provide descriptive `alt` text for non-decorative images.
- [ ] **Motion**: Respect `prefers-reduced-motion` for all non-essential animations.

### Focus & Forms
- **Visible Focus**: Never disable `outline: none` without providing a high-visibility alternative.
- **Form Labels**: Every input must have a programmatic label (`<label for="...">` or `aria-label`).
- **Error Feedback**: Use `aria-live="polite"` for status updates and `aria-invalid="true"` for failed validation.

## 6. Design Engineering Checklist
- [ ] Values defined in OKLCH for consistent light/dark mode.
- [ ] 44x44pt minimum touch target size for all mobile buttons.
- [ ] Focus trap and Escape key handling verified for all modals.
- [ ] Component extraction performed for patterns used 3+ times.
- [ ] Cumulative Layout Shift (CLS) minimized via size attributes/placeholders.
- [ ] Web Vitals (LCP, FID, CLS) optimized for mobile performance.
- [ ] WCAG 2.2 AA compliance verified via automated and manual audit.

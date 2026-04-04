---
name: fintech-ecommerce-master-pro
description: Unified framework for Ecommerce (Stripe, Shopify, WooCommerce) and Fintech (Plaid, PayPal, Square) development, covering payment flows, subscription lifecycle, and financial compliance.
type: project
---

# Fintech & Ecommerce Master Guide

Integrated framework for building secure, scalable financial systems and digital storefronts, consolidating payment gateway expertise, ecommerce platform extensibility, and fintech security standards.

## 1. Payment Gateway Engineering (Stripe, PayPal, Square)

### Robust Payment Flows
- **Hosted Checkout**: Prefer **Stripe Checkout** or **PayPal Express** for fastest time-to-market and reduced PCI-DSS burden.
- **Custom UI (Payment Intents)**: Use `PaymentIntents` (Stripe) or `Orders API` (PayPal) for full control. Always use official client-side SDKs (Stripe.js) to avoid sensitive data touching your servers.
- **Idempotency**: Use `Idempotency-Key` headers for all mutation requests to prevent double-charging users during network retries.

### Webhook Security & Reliability
- **Signature Verification**: ALWAYS verify HMAC signatures using the provider's secret key. Reject unverified payloads immediately.
- **Raw Body Preservation**: Access the raw request body for verification; do not use parsed JSON objects which can break hash validation.
- **Async Processing**: Return a `200 OK` response within 200ms. Offload heavy processing (DB updates, emails) to a background worker or queue.
- **Deduplication**: Store `event_id` in a local database to ensure exactly-once processing of retried webhooks.

## 2. Subscription & Billing Lifecycle

### Recurring Logic & Dunning
- **Subscription States**: Map provider statuses (`active`, `past_due`, `canceled`, `incomplete`) to your application's access control logic.
- **Proration**: Handle plan upgrades/downgrades with explicit proration logic to ensure fair billing.
- **Dunning Management**: Implement automated retry logic and "grace periods" for failed payments to reduce churn.
- **Customer Portals**: Use hosted billing portals (e.g., Stripe Customer Portal) for secure self-service management of payment methods and invoices.

## 3. Fintech Integration (Plaid, ACH)

### Bank Linkage (Plaid)
- **Link Token Flow**: Initiate Plaid Link with a short-lived `link_token` generated server-side.
- **Token Exchange**: Exchange the client-side `public_token` for a persistent `access_token` and store it encrypted at rest.
- **Transactions Sync**: Use the `/transactions/sync` endpoint for efficient, delta-based updates rather than full re-fetches.
- **Auth for ACH**: Use Plaid Auth or Stripe Instant Verification to verify bank accounts instantly, replacing slow micro-deposit flows.

## 4. Ecommerce Platform Mastery

### Shopify & WooCommerce
- **Shopify Hydrogen**: Use Hydrogen (Remix) for headless, high-performance storefronts. Use **App Proxies** for embedding dynamic content.
- **Shopify Bulk Operations**: Use the Bulk Operations API for large-scale catalog updates to stay within rate limits.
- **WooCommerce Hooks**: Use `woocommerce_payment_complete` and `woocommerce_add_to_cart_validation` for business logic injection.

## 5. Security & Compliance (PCI DSS)

### Standards & Best Practices
- **PCI DSS Requirements**: Follow the 12 core requirements. Maintain **SAQ-A** eligibility by never storing or processing raw card data (PAN).
- **Tokenization**: Use processor-side tokens (Tokens/PaymentMethods). If custom tokenization is used, ensure hardware-backed encryption.
- **SCA (Strong Customer Authentication)**: Implement **3D Secure 2.0** for European transactions to meet PSD2 requirements.
- **KYC/AML**: Integrate identity verification (e.g., Stripe Identity) for marketplaces to comply with anti-money laundering regulations.

## 6. Fintech & Ecommerce Checklist

- [ ] **Webhook Signatures** verified with provider secrets.
- [ ] **Idempotency Keys** used for all payment mutation requests.
- [ ] **Raw Card Data** never touches the application server (SAQ-A).
- [ ] **Exactly-Once Processing** logic implemented for all webhooks.
- [ ] **Plaid Access Tokens** encrypted at rest.
- [ ] **3D Secure/SCA** flows tested for international payments.
- [ ] **Dunning/Retry** logic configured for subscription failures.
- [ ] **Data Minimization**: No storage of CVV/CVC or raw track data.
- [ ] **Audit Logging** enabled for all privileged financial operations.

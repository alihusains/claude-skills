---
name: workflow-automation-master-pro
description: Unified framework for Low-Code Automation (Zapier, Make, n8n), Productivity Hubs (Notion, Airtable), and Enterprise CRM/Ops Integration.
type: project
---

# Workflow Automation Master Guide

Integrated framework for state-of-the-art business process automation, consolidating low-code patterns, API-first integration strategies, and robust error-handling across the modern productivity stack.

## 1. Low-Code & iPaaS (Zapier, Make, n8n)

### Core Integration Patterns
- **Trigger-Action-Sync**: The baseline pattern. Ensure triggers are as specific as possible (e.g., "New Lead in Region X") to minimize unnecessary task/operation consumption.
- **Polling vs. Webhooks**: ALWAYS prefer **Webhooks** (Instant Triggers) for real-time needs and to reduce overhead. Use polling only when webhooks are unavailable.
- **Error Handling & Retries**:
  - **Zapier**: Use "Transfer" for bulk data or custom "Filter" steps to stop execution on soft errors.
  - **Make (formerly Integromat)**: Implement **Error Handler** routes with "Ignore", "Resume", or "Rollback" directives.
  - **n8n**: Use **Error Trigger** nodes to catch workflow-level failures and send notifications (Slack/Email).

### n8n Custom Engineering
- **Function Nodes (JavaScript)**: Use for complex data transformations that standard nodes can't handle. Keep logic pure; avoid side effects inside the code node.
- **Binary Data**: Use the `readBinaryFile` and `writeBinaryFile` patterns for handling images, PDFs, and spreadsheets without corrupting content.

## 2. Productivity Hubs (Notion & Airtable)

### Notion Architecture
- **ID Resolution**: Always search for pages/databases by name to resolve IDs before performing mutations.
- **Database Schema**: Fetch the database schema (`NOTION_FETCH_DATABASE`) to identify exact property types (Select, Multi-select, Formula) before inserting rows.
- **Pagination**: Handle `has_more` and `next_cursor` for large databases to ensure complete data retrieval.

### Airtable Power Patterns
- **Formula-Driven Triggers**: Create a "Ready for Automation" checkbox or formula field to trigger workflows only when data meets specific criteria.
- **Linked Records**: Resolve linked record IDs before updating to prevent "Unknown Record" errors.

## 3. Communication & ChatOps (Slack & Discord)

### Slack Interactivity
- **Block Kit**: Use the **Block Kit Builder** logic to create rich, interactive modals and messages.
- **Thread Discipline**: Persist `thread_ts` from initial messages to group all automated updates in a single thread, preventing channel clutter.
- **ID Formatting**: Use `<@USER_ID>` for mentions and `<!subteam^ID>` for user groups.

### Discord Webhooks
- **Embeds**: Use rich embeds for status alerts. Use different colors (Hex codes) for Success (Green), Warning (Yellow), and Error (Red).

## 4. CRM & Sales Ops (HubSpot & Salesforce)

### HubSpot Lifecycle Automation
- **Batch Operations**: Use `HUBSPOT_CREATE_BATCH_OF_PROPERTIES` or batch contact updates to stay within API rate limits (max 100 per batch).
- **Property Discovery**: Always call `HUBSPOT_READ_ALL_PROPERTIES_FOR_OBJECT_TYPE` to find the *internal* property name (e.g., `hs_lead_status`) vs. the UI label.
- **Association Mapping**: Use Association IDs to link Contacts to Companies and Deals automatically during creation.

### Salesforce Logic
- **SOQL Optimization**: Only select the fields you need. Avoid `SELECT *` patterns to minimize payload size and processing time.

## 5. HR & Business Operations
- **BambooHR**: Standardize on the `directory` API for employee lookups. Ensure PII (Personal Identifiable Information) is handled according to GDPR/SOC2 compliance within the automation.
- **Freshservice**: Automate ticket routing using "Service Categories" and "Urgency" fields to reduce manual triaging.

## 6. Automation Engineering Checklist

- [ ] **Triggers**: Webhooks preferred over polling; filters applied immediately after trigger to reduce task usage.
- [ ] **ID Resolution**: No hardcoded IDs in workflow steps; all IDs resolved via Search/Fetch steps.
- [ ] **Error Handling**: Dedicated error routes or notification steps implemented for all mission-critical workflows.
- [ ] **Rate Limits**: Batch operations used for high-volume data (HubSpot/Notion); sleep/delay steps added if necessary.
- [ ] **Data Hygiene**: `trim()` and `lowercase()` applied to user-generated input before database/CRM insertion.
- [ ] **Documentation**: Workflow purpose, owner, and "Source of Truth" documented in a central Notion/Wiki page.
- [ ] **Security**: API keys stored in environment variables or vault; PII redacted in logs.
- [ ] **Cleanup**: Sandbox/Test data removed before moving automation to production.

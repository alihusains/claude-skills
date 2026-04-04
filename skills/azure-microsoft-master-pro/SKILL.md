---
name: azure-microsoft-master-pro
description: Unified framework for Azure Cloud Engineering, covering AI (OpenAI), Identity (Entra ID), Data (SQL/Cosmos), and Infrastructure Management (ARM/Bicep).
type: project
---

# Azure & Microsoft Ecosystem Master Guide

Integrated framework for professional Microsoft ecosystem engineering, consolidating cloud-native architecture, enterprise identity, AI service integration, and automated resource management.

## 1. Enterprise Identity & Security (Entra ID)

### DefaultAzureCredential Pattern
- **Production Standard**: Use `DefaultAzureCredential` from `Azure.Identity`. It automatically cycles through Managed Identity, Environment Variables, and Developer CLI credentials.
- **Managed Identity**: Default to **System-Assigned Managed Identity** for Azure resources (VMs, App Service, Functions) to eliminate secret leakage.
- **RBAC Primacy**: Use Role-Based Access Control instead of connection strings. Assign specific roles (e.g., `Storage Blob Data Contributor`) to the application's identity.

### Secrets & Key Management
- **Azure Key Vault**: Store all sensitive configuration (certs, keys, secrets) in Key Vault. Use **RBAC-based Access Policies** to control access.
- **Auto-Rotation**: Implement event-driven secret rotation using **Azure Event Grid** and **Azure Functions**.

## 2. AI & Machine Learning Mastery

### Azure OpenAI & Cognitive Services
- **Client Management**: Reuse `OpenAIClient` instances to take advantage of connection pooling and reduce latency.
- **Prompt Caching & Security**: Optimize token usage by ordering static content first. Enable **Content Safety** filters to detect and block jailbreak attempts.
- **RAG Architecture**: Integrate **Azure AI Search** with OpenAI for semantic retrieval. Use the `AzureChatExtensions` to perform vector searches directly within the chat completion flow.
- **Document Intelligence**: Use the **Layout model** for table extraction and the **Prebuilt-Invoice** model for automated financial processing.

## 3. Data & Storage Engineering

### Relational & NoSQL Excellence
- **Azure SQL**: Use **Elastic Pools** for cost-efficient management of multiple databases. Enforce **Azure AD-only Authentication** to disable SQL local logins.
- **Cosmos DB**: Choose the appropriate consistency level (e.g., `Session` for user-centric apps, `Strong` for financial ledgers). Use **Partition Keys** based on high-cardinality fields to avoid hot partitions.
- **Blob Storage**: Use **Access Tiers** (Hot, Cool, Archive) to optimize costs. Implement **Immutable Storage** policies for compliance-heavy datasets.

## 4. Infrastructure & Management

### Automated Resource Provisioning
- **Bicep & ARM**: Prefer **Bicep** for human-readable, modular IaC. Use **Deployment Stacks** to manage groups of resources as a single unit.
- **Resource Hierarchy**: Organize by `Management Group -> Subscription -> Resource Group`. Use **Azure Tags** for cost center tracking and environment identification.

### Observability & Monitoring
- **Application Insights**: Enable automatic instrumentation for telemetry (requests, exceptions, dependencies). Use **Log Analytics** with Kusto Query Language (KQL) for deep diagnostics.
- **Availability Tests**: Configure multi-step web tests to monitor endpoint health from global locations.

## 5. Azure Engineering Checklist

- [ ] **Identity**: `DefaultAzureCredential` used for all service-to-service communication.
- [ ] **Security**: Entra ID (Azure AD) authentication enforced; no local/SQL credentials in code.
- [ ] **Cost**: Resource tags applied; unused storage snapshots/backups pruned.
- [ ] **AI**: Retry logic with exponential backoff implemented for OpenAI 429 errors.
- [ ] **Data**: Cosmos DB partition keys verified for scalability; SQL Firewall restricted to specific subnets.
- [ ] **Monitoring**: App Insights instrumentation active; KQL alerts configured for critical failures.
- [ ] **Compliance**: Diagnostic logs exported to a central Log Analytics workspace.
- [ ] **Deployment**: Bicep modules versioned and stored in a private registry.

---
name: cloud-devops-master-pro
description: Unified framework for Professional Cloud Engineering (AWS/Azure), Infrastructure as Code (Terraform), Container Orchestration (K8s/Docker), and CI/CD Automation.
type: project
---

# Cloud & DevOps Master Guide

Integrated framework for state-of-the-art infrastructure engineering and deployment automation, consolidating IaC excellence, containerized reliability, and high-scale cloud architecture.

## 1. Infrastructure as Code (Terraform & IaC)

### Core Principles & Standards
- **Standard Module Structure**: Use a consistent structure: `main.tf` (resources), `variables.tf` (inputs), `outputs.tf` (values), `versions.tf` (providers), and `data.tf`.
- **Naming Conventions**: Use descriptive names (e.g., `aws_instance.web_server`) and prefer `this` for singleton resources within a module.
- **Testing Strategy**: Use native Terraform tests (1.6+) or `terratest` for critical modules. Follow the "Testing Pyramid": Unit (Static analysis) > Integration (Ephemeral apply) > End-to-End (Production-like).
- **Policy as Code (PaC)**: Integrate **Checkov**, **tfsec**, or **Terrascan** into the CI pipeline to catch misconfigurations before deployment.
- **OpenTofu Compatibility**: Ensure IaC code remains compatible with OpenTofu for open-source flexibility.

### State & Dependency Management
- **Remote State**: Always use a remote backend (S3/GCS/Azure Blob) with state locking (DynamoDB/Storage lock).
- **Count vs For_Each**: Use `for_each` for maps/sets to avoid index-shifting issues; use `count` only for simple on/off toggles.
- **Locals**: Use `locals` for complex derived values to keep resource blocks clean and readable.
- **Dependency Inversion**: Use `data` sources or `terraform_remote_state` to decouple independent infrastructure components.

## 2. Container Orchestration (Kubernetes & Docker)

### Kubernetes & GitOps Excellence
- **Manifest Management**: Use **Kustomize** for environment overlays or **Helm 3.x** for complex application packaging and lifecycle management.
- **GitOps Implementation**: Use **ArgoCD** or **Flux v2** for declarative, versioned, and continuously reconciled state. Follow **OpenGitOps** principles.
- **Progressive Delivery**: Implement **Argo Rollouts** or **Flagger** for automated Canary/Blue-Green deployments with analysis-driven promotion.
- **Security & Policy**: Enforce **Pod Security Standards** and use **OPA/Gatekeeper** or **Kyverno** for cluster-wide admission control and governance.

### Docker Optimization & Hardening
- **Multi-Stage Builds**: Separate build-time dependencies from the runtime image. Use `COPY --from` to extract only necessary artifacts.
- **Base Image Selection**: Prioritize **Alpine**, **Distroless**, or **Scratch** images to minimize CVE surface area and reduce pull times.
- **Layer Caching**: Order `COPY` and `RUN` instructions to maximize layer reuse (dependencies before source code).
- **Security Hardening**: Always use a non-root `USER`. Implement `HEALTHCHECK` and `LABEL` for metadata and lifecycle management.
- **Supply Chain**: Generate **SBOMs** (Software Bill of Materials) and sign images using **Cosign** for provenance verification.

## 3. Cloud-Native Architecture & FinOps (AWS, Azure, GCP)

### Foundations & Reliability
- **Well-Architected Framework**: Design for **Reliability** (multi-AZ/region), **Security** (Least Privilege IAM/RBAC), and **Sustainability**.
- **Serverless First**: Prefer FaaS (**Lambda**, **Cloud Run**) and managed services (**RDS**, **CosmosDB**) to shift operational burden to the provider.
- **Networking**: Implement **Private Link** or **Service Endpoints** to keep traffic off the public internet.

### FinOps & Cost Optimization
- **Right-Sizing**: Use **KubeCost**, **AWS Compute Optimizer**, or **Azure Advisor** to identify over-provisioned resources.
- **Usage Strategy**: Maximize **Spot Instances** for stateless workloads and **Reserved Instances/Savings Plans** for baseline capacity.
- **Automated Lifecycle**: Implement automated shutdowns for non-production environments and S3/Blob storage lifecycle policies.

## 4. CI/CD & Deployment Automation

### Pipeline Engineering
- **Standard Quality Gates**:
  - **Phase 1**: Linting & Static Analysis (TFLint, Hadolint, ESLint).
  - **Phase 2**: Unit & Integration Testing (Pytest, Vitest, Go Test).
  - **Phase 3**: Security Scanning (Snyk, Trivy, Grype, Gitleaks).
  - **Phase 4**: IaC Plan & Policy Check (OPA, Checkov).
- **Artifact Management**: Versioned OCI-compliant registries (ECR, ACR, GHCR) with immutable tagging strategies.
- **Secret Management**: Use **External Secrets Operator** or **HashiCorp Vault** to inject secrets into workloads dynamically.

## 5. Cloud & DevOps Engineering Checklist
- [ ] **IaC**: All infrastructure is version-controlled with no manual drift.
- [ ] **PaC**: Security/Compliance scanning (Checkov/tfsec) passes in CI.
- [ ] **State**: Remote state backend configured with encryption and locking.
- [ ] **Secrets**: No plain-text secrets; hardware-backed encryption (KMS/Vault) used.
- [ ] **Docker**: Multi-stage build used; running as non-root; scanned for CVEs.
- [ ] **K8s**: Resource limits/requests and liveness/readiness probes defined.
- [ ] **GitOps**: Automated drift detection and reconciliation enabled.
- [ ] **Cost**: Resource tagging enforced; right-sizing audit completed.
- [ ] **Observability**: Metrics, Logs, and Traces (OpenTelemetry) unified in SIEM/APM.
- [ ] **DR**: Multi-region/AZ recovery strategy tested and documented.

---
name: security-operations-master-pro
description: Unified framework for Modern Security Engineering, covering Offensive Recon/Exploitation, Defensive Hardening (Cloud/K8s), Malware Analysis, and Compliance Auditing (OWASP/NIST).
type: project
---

# Security Operations Master Guide

Integrated framework for end-to-end security engineering, consolidating offensive methodology, defensive architecture, and rigorous compliance auditing.

## 1. Offensive Operations (Red Team & Bug Bounty)

### Reconnaissance & Asset Discovery
- **Subdomain Enumeration**: Use `amass`, `subfinder`, and `assetfinder`. Perform recursive brute-force with `shuffledns` and custom wordlists.
- **Port Scanning & Services**: Use `naabu` for fast port scanning and `httpx` for service fingerprinting and status code checking.
- **Visual Recon**: Use `aquatone` or `gowitness` to take screenshots of discovered web assets for rapid pattern identification.

### Vulnerability Discovery (Haddix Methodology)
- **Content Discovery**: Use `ffuf` or `dirsearch` with `raft-large-words` and `directory-list-2.3-medium`. Monitor for `403 Bypass` using headers like `X-Forwarded-For`.
- **Parameter Analysis**: Use `arjun` to find hidden parameters. Use `grep-fu` on JS files to find API endpoints and secret keys.
- **Nuclei Scanning**: Run `nuclei` with the latest community templates for fast detection of known CVEs and misconfigurations.

### Specialized Exploitation
- **XSS Hunting**: Use `dalfox` for automated testing. Manual verification: check for reflection in tags, attributes, and JS contexts.
- **SQL Injection**: Use `sqlmap --batch --random-agent --level 5 --risk 3` for automated testing. Prefer manual `UNION` and `Time-based` payloads for WAF evasion.
- **IDOR & Logic Flaws**: Test all numeric IDs by incrementing/decrementing. Check if session tokens are tied to specific resources.

## 2. Defensive Operations (Blue Team & Hardening)

### Cloud Security Posture (CSPM)
- **AWS/Azure/GCP**: Use `Prowler` (AWS) or `Cloud Custodian` for continuous compliance. Enforce **Least Privilege** via IAM roles and Service Control Policies (SCPs).
- **Secrets Management**: Use **HashiCorp Vault**, **Azure Key Vault**, or **AWS Secrets Manager**. NEVER store secrets in environment variables or code.
- **Managed Identity**: Default to `Managed Identity` (Azure) or `IAM Roles for Service Accounts` (EKS) to eliminate long-lived credentials.

### Infrastructure & Container Hardening
- **Kubernetes Security**: Implement **Network Policies** for pod-to-pod isolation. Use `Kube-bench` and `Kube-hunter` for configuration audits.
- **Docker Hardening**: Use non-root users in Dockerfiles. Scan images using `Trivy` or `Grype` during CI/CD.
- **OS Hardening**: Follow **CIS Benchmarks**. Use `fail2ban`, `crowdsec`, and disable unused services/ports.

## 3. Malware Analysis & Reverse Engineering

### Static Analysis
- **File Identification**: Use `file`, `strings`, and `binwalk`. Check entropy levels to detect packing/encryption (UPX, VMProtect).
- **Disassembly & Decompilation**: Use **Ghidra**, **IDA Pro**, or **Cutter**. Identify entry points and WinAPI calls (e.g., `VirtualAlloc`, `WriteProcessMemory`).
- **YARA Rules**: Write specific rules for malware families. Focus on unique string patterns and byte sequences in code sections.

### Dynamic Analysis
- **Sandboxing**: Execute in isolated VMs (Cuckoo, Any.Run). Monitor network traffic with **Wireshark** and system calls with **Procmon** and **Sysmon**.
- **Debugging**: Use **x64dbg** or **GDB** to bypass anti-debugging checks (e.g., `IsDebuggerPresent`). Trace execution to find decryption loops.

## 4. Compliance, Audit & Risk

### Frameworks & Standards
- **OWASP Top 10**: Use as the baseline for all web application audits.
- **NIST CSF**: Align security operations with Identify, Protect, Detect, Respond, and Recover functions.
- **PCI-DSS / HIPAA / GDPR**: Enforce strict data encryption at rest/transit and audit logging for all PII/PHI access.

### Audit Methodology
- **SAST/DAST/SCA**: Mandatory integration in CI/CD. Use `Semgrep` (SAST), `OWASP ZAP` (DAST), and `Snyk` (SCA).
- **Manual Code Review**: Focus on authentication flows, authorization checks, and sensitive data handling.
- **Documentation**: Maintain an **Incident Response Plan (IRP)** and regular **Business Continuity/Disaster Recovery (BCDR)** testing.

## 5. Security Engineering Checklist

- [ ] **Multi-Factor Authentication (MFA)** enforced for all external and administrative access.
- [ ] **Data Encryption** (AES-256) used for all sensitive data at rest; TLS 1.3 for transit.
- [ ] **Content Security Policy (CSP)** and security headers (`HSTS`, `X-Frame-Options`) implemented.
- [ ] **CI/CD Security** scans (SAST/SCA) pass with zero CRITICAL/HIGH vulnerabilities.
- [ ] **Audit Logging** configured for all privileged actions and centralized in a SIEM (Splunk/Sentinel).
- [ ] **Regular Backups** verified with successful restoration tests.
- [ ] **Incident Response Plan** updated and tested within the last 12 months.
- [ ] **Third-party Dependencies** audited and pinned to secure versions.

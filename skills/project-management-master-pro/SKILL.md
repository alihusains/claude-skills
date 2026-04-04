---
name: project-management-master-pro
description: Unified framework for Professional Project Management, High-Speed Issue Tracking (Linear/Jira), Async Collaboration (Slack), and PR Review Optimization.
type: project
---

# Project Management & Collaboration Master Guide

Integrated framework for high-velocity software delivery and team coordination, consolidating modern issue tracking, async-first communication, and high-quality code review workflows.

## 1. Product Strategy & Prioritization (RICE & PRDs)

### Prioritization Frameworks
- **RICE Score**: Calculate `(Reach * Impact * Confidence) / Effort` to rank features objectively.
- **MoSCoW**: Categorize requirements into `Must-have`, `Should-have`, `Could-have`, and `Won't-have` for immediate scope control.
- **Value vs. Effort**: Map initiatives on a 2x2 matrix to identify "Quick Wins" vs. "Major Projects."

### PRD & Roadmap Standards
- **Standard PRD**: Use for major features. Sections: Problem Statement, Success Metrics (KPIs), User Stories, Requirements, Design/Flows, and Out-of-Scope.
- **One-Page PRD**: Use for rapid alignment on smaller features. Focus on Hypothesis → Solution → Metric.
- **Roadmap Hierarchy**: Vision → North Star Metric → Strategic Themes → Initiatives → Epics.

## 2. High-Speed Execution (Linear, Jira, Asana)

### Issue Tracking Excellence
- **Hierarchy**: Initiatives → Projects → Issues (Linear) or Epics → Sprints → Tasks (Jira/Asana).
- **Status Lifecycle**: `Backlog` → `Todo` → `In Progress` → `Review` → `Done`. Avoid "In Progress" bloat by enforcing WIP (Work In Progress) limits.
- **Triage Discipline**: Every new issue MUST have a `Priority`, `Label` (bug/feat/docs), and `Owner` within 24 hours.

### Automation & Tooling Patterns
- **Jira Software**: Use `JIRA_LIST_SPRINTS` and `JIRA_MOVE_ISSUE_TO_SPRINT` for automated sprint planning.
- **Asana**: Use `ASANA_GET_TASKS_FROM_SECTION` and `ASANA_SUBMIT_PARALLEL_REQUESTS` for high-volume project updates.
- **ID Resolution**: Always resolve human-readable names (Project Name) to IDs (GIDs) before performing mutations to ensure reliability.

## 3. Async Collaboration & Communication

### Standups & Documentation
- **Async-First Standups**: Use tools to generate daily updates from git commits and issue status (Accomplishments, Goals, Blockers).
- **Thread Discipline**: Use Slack/Teams threads for all technical discussions to preserve channel signal-to-noise ratio.
- **Stakeholder Management**: Follow the **RACI** matrix (Responsible, Accountable, Consulted, Informed) for all major project decisions.

### Launch Strategy (ORB Framework)
- **Owned**: Email lists, blogs, in-app notifications.
- **Rented**: Social media (LinkedIn/X), community groups.
- **Borrowed**: Influencers, partners, press, Product Hunt.
- **5-Phase Launch**: Internal → Alpha (Friends) → Beta (Waitlist) → Early Access → Full Launch.

## 4. Technical Documentation & Knowledge Management

### Documentation Hierarchy
- **Level 1 (Code)**: README.md, inline comments, and type definitions.
- **Level 2 (API)**: OpenAPI/Swagger specs, Postman collections, and integration guides.
- **Level 3 (Architecture)**: ADRs (Architecture Decision Records), System Design docs, and Mermaid diagrams.
- **Level 4 (User)**: Help Center, Tutorials, and Onboarding guides.

### Knowledge Hygiene
- **XHTML Format (Confluence)**: Use `<ac:structured-macro ac:name="code">` for snippets and `<ac:status>` for visual state tracking.
- **Stale Content**: Tag outdated pages with "Deprecated: [Date]" rather than deleting them to preserve historical context.

## 5. Project & Product Management Checklist
- [ ] **Prioritization**: RICE score or MoSCoW category assigned to all backlog items.
- [ ] **Success Metrics**: Every feature has a defined North Star or KPI target.
- [ ] **Issue Hygiene**: No issues in "In Progress" for >5 days without an update.
- [ ] **Automation**: Sprints are created and populated via automated workflows.
- [ ] **Documentation**: ADRs created for all significant architectural changes.
- [ ] **PR Quality**: Every PR includes a summary, test plan, and risk assessment.
- [ ] **Communication**: Weekly async project status shared with all RACI stakeholders.
- [ ] **Launch**: 5-phase approach followed for high-risk product releases.
- [ ] **DR/Review**: Post-mortems conducted for all major project delays or failures.

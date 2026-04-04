---
name: ai-ml-ecosystem-master-pro
description: Unified framework for AI Engineering and ML Systems, covering RAG architectures, Multi-Agent orchestration (LangGraph/CrewAI), LLM Evaluation (Ragas), and Systematic Prompt Engineering.
type: project
---

# AI & ML Ecosystem Master Guide

Integrated framework for building production-grade AI systems, consolidating advanced retrieval strategies, autonomous agent coordination, and rigorous evaluation pipelines.

## 1. Advanced RAG & Retrieval Engineering

### Retrieval & Reranking
- **Hybrid Search**: Combine Vector (Dense) and Keyword (BM25) search using **Reciprocal Rank Fusion (RRF)** for optimal terminology and conceptual coverage.
- **Cross-Encoder Reranking**: Mandatory for production. Score the top-K retrieved chunks with a reranker (Cohere, BGE, or Jina) before feeding to the LLM to eliminate noise.
- **Contextual Chunking**: Use semantic boundaries (headers, sentences) rather than fixed characters. Implement "Parent Document Retrieval" to return full context for a specific chunk.

### Data Engineering for AI
- **Multi-Modal Chunking**: Handle tables (Markdown/HTML conversion) and images (Vision-LLM captioning) to ensure retrieval relevance.
- **Iterative Retrieval**: Use agentic loops (e.g., "Self-RAG") to critique retrieved context and perform follow-up searches if the initial fetch is insufficient.

## 2. Multi-Agent Orchestration & Frameworks

### Framework Selection
- **LangGraph (State-Centric)**: Best for complex, cyclic graphs requiring precise flow control, persistence (checkpointers), and human-in-the-loop interrupts.
- **CrewAI (Role-Centric)**: Best for collaborative, role-based workflows where autonomous agents delegate tasks hierarchically (Manager-Worker patterns).
- **Control Patterns**: Implement **Supervisor** nodes to decompose tasks and **Refinement** loops to critique and improve agent outputs.

### Agentic Patterns
- **Memory Systems**: Layered memory: **Short-term** (Thread history), **Mid-term** (Interaction summaries), and **Long-term** (Semantic vector cache).
- **Structured Output**: Enforce schemas via **Pydantic** or model-native `tool_use` to ensure agents return parseable data for downstream systems.

## 3. Systematic Prompt Engineering & Optimization

### Core Patterns
- **Chain-of-Thought (CoT)**: Force reasoning with `<thinking>` tags or zero-shot "Think step-by-step" to reduce logical hallucinations.
- **Few-Shot Learning**: Provide 3-5 high-quality demonstrations. Use **Dynamic Few-Shot** to retrieve examples semantically similar to the user's query.
- **Prompt Caching**: Structure system prompts and few-shot examples at the beginning of the context to maximize **Prompt Caching** (Claude/Gemini) for 90% cost/latency reduction.

### Optimization Workflow
- **DSPy Principles**: Move from "hard-coded strings" to "signatures and modules". Use optimizers to automatically select the best few-shot examples based on a success metric.
- **Versioning**: Store prompts in code or a registry (LangSmith, Portkey) with semantic tags rather than hard-coding them in source code.

## 4. LLM Evaluation & Reliability (The "Faithfulness" Stack)

### Automated Metrics
- **Ragas Framework**: Measure **Faithfulness** (no hallucinations), **Answer Relevancy** (addresses query), and **Context Precision** (retrieved chunks were useful).
- **LLM-as-a-Judge**: Use high-reasoning models (Opus 4.6) as judges with strict rubrics and 1-5 scales for qualitative assessment.

### Regression & Safety
- **Golden Datasets**: Maintain 100+ "must-pass" test cases for regression testing on prompt or model upgrades.
- **Red Teaming**: Proactively scan for prompt injection, sensitive PII leakage, and jailbreak attempts in agent system instructions.

## 5. AI Engineering Checklist
- [ ] **Hybrid Search** + **Reranking** implemented for all production RAG systems.
- [ ] **Faithfulness** and **Relevancy** metrics automated via Ragas or LLM-as-Judge.
- [ ] **Max Loops** (Terminal State) defined for all autonomous agents to prevent infinite cycles.
- [ ] **Structured Output** (JSON/Pydantic) verified via validation layers (Instructor/Marvin).
- [ ] **Prompt Caching** optimized by ordering static content first.
- [ ] **Human-in-the-Loop** required for all high-stakes agent mutations (deletes, payments).
- [ ] **Semantic Caching** implemented for high-volume, low-variability user queries.
- [ ] **Golden Dataset** benchmarked with 80%+ success rate before deployment.

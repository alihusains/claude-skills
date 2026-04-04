---
name: database-data-master-pro
description: Unified framework for Professional Database Engineering (Postgres, Redis), High-Performance OLAP (Clickhouse, Spark), Data Engineering Pipelines, and Vector Search (RAG).
type: project
---

# Database & Data Master Guide

Integrated framework for state-of-the-art data architecture and engineering, consolidating relational excellence, distributed NoSQL patterns, and high-scale analytical processing.

## 1. Relational Excellence (PostgreSQL & SQL)

### Schema Design & Hygiene
- **Data Integrity First**: Use strong types (`UUID`, `JSONB`, `TIMESTAMPTZ`) and constraints (`NOT NULL`, `CHECK`, `FOREIGN KEY`) to enforce business rules at the storage layer.
- **Normalization vs Denormalization**: Normalize to 3NF for OLTP to prevent anomalies; selectively denormalize for read-heavy OLAP or high-scale microservices.
- **JSONB Strategy**: Use `JSONB` for semi-structured data, but move frequently queried fields into top-level columns with GIN indexes.

### Query Optimization
- **EXPLAIN ANALYZE**: Always profile slow queries. Look for "Sequential Scan" on large tables and "Nested Loop" on mismatched join keys.
- **Indexing Strategy**:
  - **B-Tree**: Default for equality and range queries.
  - **GIN/GiST**: For full-text search, arrays, and `JSONB`.
  - **Partial/Covering Indexes**: Use `WHERE` clauses in indexes to reduce size and `INCLUDE` to enable index-only scans.
- **Connection Pooling**: Always use a pooler (e.g., PgBouncer or Supabase/Neon connection pooling) for high-concurrency applications.

## 2. Distributed NoSQL & Caching (Redis, DynamoDB)

### Key-Value & Document Patterns
- **Query-First Modeling**: In NoSQL, design your schema based on access patterns, not entities. Use **Single-Table Design** to minimize round-trips.
- **Partition Key Selection**: Choose high-cardinality partition keys (e.g., `user_id` over `status`) to avoid "Hot Partitions."
- **TTL & Eviction**: Use Redis for transient state. Set explicit TTLs to prevent memory exhaustion and use `allkeys-lru` eviction for generic caching.

### Cache Reliability
- **Cache Aside**: Load data into cache only after a miss, and invalidate on write.
- **Write-Through/Behind**: For high-write workloads where eventual consistency is acceptable.

## 3. Analytical Processing (Clickhouse, Spark)

### Clickhouse (OLAP)
- **Primary Key vs Sorting Key**: Clickhouse uses the primary key for data localization on disk. Ensure it matches your most common filter patterns.
- **Engines**: Use `MergeTree` for general use and `ReplacingMergeTree` for deduplication.
- **Vectorized Execution**: Write queries that allow Clickhouse to process data in blocks for maximum CPU efficiency.

### Apache Spark (Big Data)
- **Memory Tuning**: Configure `spark.memory.fraction` (default 0.6) and `spark.memory.storageFraction` (default 0.5). Use `spark.executor.memoryOverhead` (10-15%) for non-JVM memory to prevent OOMs.
- **Shuffle Optimization**: Set `spark.sql.shuffle.partitions` dynamically based on data size (target 128MB-200MB per partition). Use `coalesce` to reduce partitions and `repartition` to increase them or fix skew.
- **Join Optimization**: Use `broadcast()` for small tables (<100MB) to avoid shuffles. Configure `spark.sql.autoBroadcastJoinThreshold`.
- **Serialization**: Prefer **Kryo** serialization (`spark.serializer` = `org.apache.spark.serializer.KryoSerializer`) for better performance and smaller footprints.

## 4. Data Engineering & Workflow Orchestration

### Airflow & Dagster (Orchestration)
- **TaskFlow API**: Use `@task` decorators for Python-native workflows; use `@dag` for clean, functional DAG definitions.
- **Sensors & Deferrables**: Use `ExternalTaskSensor` for cross-DAG dependencies. Prefer **Deferrable Operators** (triggers) for long-running sensors to save worker slots.
- **Idempotency**: Ensure every task is rerunnable. Use `{{ ds }}` (execution date) for partition-aware logic.
- **Task Atomicity**: Each task should do one thing (e.g., Load → Transform → Validate). Avoid complex logic inside a single operator.

### dbt (Modern Data Stack)
- **Model Hierarchy**:
  - **Staging**: Clean, rename, and cast raw data. Use `incremental` materialization for large tables.
  - **Intermediate**: Combine staging models and apply complex business logic.
  - **Marts**: End-user optimized tables (Fact/Dimension).
- **Incremental Strategies**: Use `merge` for general use; use `insert_overwrite` for static partitions to optimize warehouse costs.
- **Snapshots**: Use `dbt snapshot` with `check` or `timestamp` strategy for Type 2 Slowly Changing Dimensions (SCD2).

### Data Quality & Contracts
- **Validation**: Use **Great Expectations** for table-level (row count) and column-level (nullability, value ranges) validation.
- **dbt-expectations**: Integrate `dbt-expectations` for unit testing data directly within the transformation layer.
- **Data Contracts**: Define schemas and quality rules in YAML; enforce them at the ingestion boundary to prevent "silent failures."

## 5. Vector Databases & Semantic Search (RAG)

### Indexing & Retrieval
- **Indexing Trade-offs**:
  - **HNSW**: High memory usage, but ultra-fast search with high recall. Best for production RAG.
  - **IVF-Flat/PQ**: Lower memory, but slower search. Best for massive datasets where memory is a bottleneck.
- **Chunking Strategies**: Use recursive character splitting or semantic chunking (sentence-level) to preserve context.
- **Hybrid Search**: Combine vector similarity (FAISS/Milvus) with full-text search (BM25) for high-accuracy retrieval in domain-specific niches.
- **Metadata Pre-filtering**: Apply filters (e.g., `user_id`, `category`) BEFORE the vector search to significantly reduce the search space.

## 6. Database & Data Engineering Checklist
- [ ] **SQL**: All queries use parameterized inputs; EXPLAIN ANALYZE shows no unexpected Seq Scans.
- [ ] **Spark**: Shuffles are minimized; executor memory is tuned to avoid spills to disk.
- [ ] **Airflow**: DAGs are idempotent; sensors are using deferrable mode where applicable.
- [ ] **dbt**: Models pass `dbt test` (unique, not_null, relationships); incremental logic verified.
- [ ] **Quality**: Great Expectations or dbt-expectations checkpoints pass before data hits Marts.
- [ ] **Vector**: Index type (HNSW/IVF) matches the scale and memory constraints.
- [ ] **Security**: Row-Level Security (RLS) and encryption at rest verified.
- [ ] **Backup**: Automated snapshots and PITR restoration tested in the last 30 days.

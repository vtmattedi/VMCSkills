---
name: backend-structure
description: Inspect, design, or restructure backend services for scalable ownership of routes, domain operations, persistence, integrations, and failure boundaries. Use for backend architecture plans or substantial refactors, not routine endpoint additions.
---

# Backend Structure

## Purpose and defaults

Optimize for scalable, understandable modules and explicit invariants. Default to considering meaningful **restructuring** where justified, not preserving historical file placement just because it works. Do not impose universal controller/service/repository, Clean Architecture, interfaces or microservices. Read [presets and decision criteria](references/presets.md).

## Permission and discovery

A review, pass, audit or planning request is **read-only**. Implement only with clear authorization. Inspect project instructions and accepted ADRs, code, tests, data model, protocol/API contracts, build/deployment environment, failure paths, and external dependencies. Identify language/runtime conventions, system purpose, team/maintenance scale, and growth constraints. Select the simplest preset or hybrid that covers demonstrated responsibilities. Ask only for a choice that would materially change structure.

## Review depth and restructure gate

- **Architecture survey** (default for broad exploration): map packages, services, dependency/failure boundaries and significant tests through representative implementations. Disclose read paths and unreviewed areas. Do not claim a file-by-file audit.
- **Complete scoped audit** (requested exhaustive review or defined comprehensive scope): inspect every source file in scope, answer the four quality questions for each, and report coverage; process batches as needed and mark incomplete status honestly.
- Both depths are read-only by default. Changes require explicit implementation authorization.
- Every structural proposal must compare **maintainability/scalability benefit**, effort, correctness/security/data-integrity risk, reversibility, and tests that can establish behavior preservation. Return **KEEP / RESTRUCTURE / DEFER**; preserving existing good Go package boundaries is a valid success.
- Treat identity, OAuth/OIDC, credentials, signing, delegated tokens, auth/session, transactions, recovery, and cryptographic state as high-consequence: demand stronger evidence and regression checks before edits. Refactoring a long handler *within the same package* may be safer than introducing a generic service layer.

## Starting presets

- **Minimal service:** small APIs and utilities with handlers and focused helpers.
- **Domain/workflow:** rich business invariants, authorization and transactions; capability-owned routes, operations and persistence.
- **Integration/orchestrator:** infrastructure managers and external-service coordinators; distinct adapters, orchestration, state/recovery and transport.
- **Language-native package:** e.g. cohesive Go packages with narrow interfaces at actual consumers, not forced TypeScript conventions.
- **Protocol/device:** networking, embedded, real-time, memory constrained; state machines, buffers, transport, timing and resource ownership matter more than HTTP layers.

Mixed systems may need hybrid boundaries.

## Required architecture examination

1. **Ownership:** Does each operation belong to its module? Are business decisions buried in HTTP handlers, persistence, or integration glue?
2. **Cohesion:** Does each file/package have a clear reason to change? Move, split, merge or retain by real coupling, not by arbitrary file-size or function-length targets.
3. **Dependencies:** Can transport, domain behavior, persistence and external effects be reasoned about and tested? Avoid accidental cycles, generic frameworks, service-locator sprawl and interfaces without a real substitution boundary.
4. **Safety:** Review input validation, auth/permissions, secret handling, transactions, lock ordering, data consistency, idempotency, partial failures, retries, compensations, and concurrency as applicable.
5. **Operations:** Startup/shutdown, migrations, configuration, observability, deployment and protocol compatibility must be preserved.
6. **Verification:** Find targeted tests and realistic integration environments for important invariants. A mock does not prove database-locking, Docker, or device behavior.

For every affected source file answer the four quality questions: correct placement, sufficient separation, maintainability, and concise necessary comments. Separate confirmed issues from inferred risks.

## Output and implementation

Report declared review depth, inspected/unreviewed coverage, existing subsystem map and concrete problems with paths; selected/hybrid preset and alternatives; justified KEEP decisions. Every material change includes benefit, effort, risk, reversibility and verification, plus target modules, precise moves and migration stages only if warranted. Complete audits include Q1–Q4 per in-scope file and honest completion status. Preserve public APIs, schemas, data and protocols.

During authorized implementation, make bounded changes and keep current behavior stable unless requested otherwise; add regression coverage for side effects and concurrency; run relevant checks; re-review changed files against the four quality questions and state any unverified behavior.

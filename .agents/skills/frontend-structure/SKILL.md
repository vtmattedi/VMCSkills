---
name: frontend-structure
description: Inspect, design, or restructure a frontend codebase with scalable feature, page, component, state, and dependency ownership. Use for frontend architecture decisions or structural refactors, not ordinary small UI changes.
---

# Frontend Structure

## Purpose and defaults

Make frontend code easier to grow, modify, and test by choosing clear ownership and dependency direction. Default priority: **scale**; change strategy: **restructure** when justified. Do not mechanically recreate another project's structure. Read [presets and decisions](references/presets.md); presets are starting points, not mandatory outcomes.

## Permission and discovery

For reviews, passes, architecture assessments and plans, **report without modifying code**. Implement only when clearly requested/authorized. Before proposing changes:
1. Inspect relevant repository `AGENTS.md`, ADRs and contracts, routes, components, feature modules, state/data-access code, tests, build configuration, and source layout.
2. Infer framework/runtime, application purpose, scale, collaboration, SSR/SPA needs, navigation, state and data sources, deployment, and accepted conventions.
3. Identify concrete ownership and dependency problems. Look for evidence contradicting an initial recommendation.
4. Propose a preset or hybrid, explaining why it fits and what it deliberately omits.
5. Ask only if a material unresolved product or architecture choice changes the plan. Otherwise use an explicit assumption and proceed with the requested report.

## Preset choices

- **Minimal:** small SPA, embedded UI, utility. Pages, components, and focused API/helpers; no feature-layer ceremony.
- **Feature/workflow:** business app with independent domains, multi-screen flows and involved local state. Feature owns screens, workflow hooks, domain helpers and resource API; shared presentation is independent.
- **Dashboard/console:** infrastructure/admin interfaces, navigation shell and operational views; group complex capabilities into owned modules; keep trivial screens flat.
- **Content-driven:** portfolio, static/documentation sites; pages, layouts, content, and shared presentation; avoid domain/application scaffolding.
- **Hybrid:** combine on evidence (e.g. an operational dashboard with feature-owned deployment editor).

## Structural decisions

Choose boundaries by who changes the code together, not by a universal folder diagram. Assess:
- Feature and screen ownership; composition versus presentational primitives; whether shared utilities depend on business features.
- Routing, URL state, server-state cache, ephemeral UI state, durable drafts, async write and recovery ownership.
- Typed API boundaries, validation, authorization assumptions, errors and stale-request handling; backend remains authoritative for permissions/invariants.
- Cross-feature imports, cycles, barrel files and abstractions; avoid creating a generalized CRUD controller for unrelated workflows.
- Styling ownership, design tokens, responsive/accessibility behavior, loading/empty/error/retry states.
- Testability of user journeys and recovery, not merely component snapshots.

**Do not globally prescribe** React, TanStack Query, Redux, React Hook Form, Tailwind, SSR, CSS Modules or shadcn. Retain an existing suitable tool; propose dependencies only for evidenced needs.

## Required code-quality checks

For every affected source file: (1) does each significant piece belong here? (2) is the file separated enough? (3) can a maintainer understand and change it? (4) is a concise explanation of necessary complexity missing or redundant? A long file is not automatically a bad file. Consult project-local code quality conventions where present; `code-quality` can provide a full audit but is not a dependency.

## Output and execution

Produce a current ownership map; selected/hybrid preset and alternatives; problems with path/behavior evidence; target tree and import boundaries; migration sequence with explicit file moves; invariants and tests to preserve; risks and deferrals. In full-scope audits identify unreviewed files.

During authorized implementation, migrate in cohesive slices, keep public contracts and behavior stable unless changes were requested, update tests and architectural documentation, run project checks, and repeat the four file questions on changes. Never claim a verification step ran if it did not.

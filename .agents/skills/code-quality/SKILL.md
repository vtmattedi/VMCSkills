---
name: code-quality
description: Audit, explain, or improve code ownership, file cohesion, maintainability, and necessary comments across a repository. Use for code quality passes, refactor plans, and structure-aware quality reviews; do not invoke for every small coding task.
---

# Code Quality

## Goal and defaults

Evaluate **every in-scope source file** against four mandatory questions. Prefer scalable ownership and justified restructuring rather than cosmetic edits, rigid file-size rules, or abstraction for its own sake. Read [review criteria](references/review-criteria.md) for decision standards and examples.

1. **Does this piece of code belong in this file?** Examine the owner of each significant function, class, component, handler, and side effect; consider move, keep, or merge.
2. **Is this file separated enough?** Examine responsibility cohesion and change coupling; consider split, keep, or merge. Large size alone is not grounds to split.
3. **Can someone understand and maintain this piece of code?** Examine naming, control flow, dependencies, assumptions, error paths, and ability to verify changes.
4. **Do we need comments?** Prefer clear code first. Add only lean, direct explanations of necessary complexity, invariants, ordering, concurrency, tricky algorithms, or non-obvious *why*; never narrate obvious code.

Give an actual answer to all four for **each inspected file**. Detailed function-level findings are required where a file contains multiple responsibilities or complex logic. Mark files not inspected as unreviewed—never imply completed coverage.

## Modes and permission

- **Review** (default for "review", "pass", "check", "audit"): read-only, evidence-based report. No edits.
- **Plan**: read-only target architecture, prioritized migration slices and verification.
- **Improve**: only when implementation is requested/authorized; refactor within the requested scope and verify.
- If scope is ambiguous, inspect first and choose review. Ask only about consequential unresolved decisions.
- Never silently change behavior, public API, auth/permissions, schemas, persistence, or protocol contracts during a structural refactor. Propose separately if necessary.

## Workflow

1. **Inventory.** Identify repository root(s), languages, build/test commands, generated/vendor directories, and in-scope source files. Read local `AGENTS.md`, design decisions, public contracts, and tests. Exclude generated/binary/vendor code explicitly, with reasons.
2. **Profile.** Infer purpose, growth pressure, failure consequences, hotspots, ownership, and architectural conventions. Default to scale/restructure, while respecting accepted project constraints.
3. **Review coverage.** Track every in-scope file in a persistent inventory. Read each file sufficiently to evaluate all four questions; analyze significant units within it. No rating based on filenames, directory names, file length, or superficial sampling. For an oversized repository, process batches with a clear reviewed/unreviewed count; never claim an incomplete pass is complete.
4. **Test claims.** Trace adjacent consumers, dependencies, tests, and representative execution paths before proposing moves. Distinguish observed defect from plausible risk and preference; include paths and line ranges where possible.
5. **Decide.** For each file record Q1 location, Q2 cohesion, Q3 maintainability, Q4 comments, with `keep`, `change`, `investigate`, or `not reviewed`, plus short evidence. Highlight strengths worth keeping.
6. **Recommend.** Prioritize behavior/security/data-integrity issues before organizational improvements. Where justified, propose specific destination paths, extraction boundaries, trade-offs, migration sequence, and tests. No arbitrary size limits or blanket interfaces/repositories.
7. **Implement only if authorized.** Work in behavior-preserving slices; run relevant tests, typechecks, linters, and integration checks where available. Review every changed file **again** against Q1–Q4. Report checks not run and remaining risks.

## Required output

For full-repo audits:
- **Scope and coverage:** commit/ref, included/excluded counts, reviewed/unreviewed files, limits and verification available.
- **File matrix:** a row for *each* in-scope file answering all four questions, with terse evidence or a linked detailed finding. An unreviewed row is explicit, not filled with inferred judgments.
- **Findings:** issue, evidence/path, severity and impact, why code should move/split/simplify/be commented, counterargument, recommendation.
- **Target structure and plan:** only where changes are justified; staged file moves, dependency and testing implications.
- **Outcome:** keep/change/defer decisions, checks performed, and uncovered risks.

For a focused file review, use the same four-question contract without a repository-wide matrix.

## Comment rules

Comments are not a substitute for comprehensible names, smaller cohesive operations, or explicit types. Prefer a one- or two-line explanation of why a lock, boundary, unusual ordering, or domain invariant matters. Avoid obvious narrations, stale TODOs, giant historical essays in functions, and documenting what a signature already says. Preserve important existing documentation until its underlying invariant is verified. See [review criteria](references/review-criteria.md).

## Working with structure skills

If the dominant problem is frontend or backend ownership, recommend `frontend-structure` or `backend-structure` for a fuller architectural plan. Do not require those skills to be installed; this skill must work independently.

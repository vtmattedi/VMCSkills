---
name: code-quality
description: Audit, explain, or improve code ownership, file cohesion, maintainability, and necessary comments across a repository. Use for code quality passes, refactor plans, and structure-aware quality reviews; do not invoke for every small coding task.
---

# Code Quality

## Goal and defaults

For a **complete scoped audit**, evaluate **every in-scope source file** against four mandatory questions. For an **architecture survey**, evaluate each inspected file but never claim uninspected files were assessed. Prefer scalable ownership and justified restructuring rather than cosmetic edits, rigid file-size rules, or abstraction for its own sake. Read [review criteria](references/review-criteria.md) for decision standards and examples.

1. **Does this piece of code belong in this file?** Examine the owner of each significant function, class, component, handler, and side effect; consider move, keep, or merge.
2. **Is this file separated enough?** Examine responsibility cohesion and change coupling; consider split, keep, or merge. Large size alone is not grounds to split.
3. **Can someone understand and maintain this piece of code?** Examine naming, control flow, dependencies, assumptions, error paths, and ability to verify changes.
4. **Do we need comments?** Prefer clear code first. Add only lean, direct explanations of necessary complexity, invariants, ordering, concurrency, tricky algorithms, or non-obvious *why*; never narrate obvious code.

Give an actual answer to all four for **each inspected file**. Detailed function-level findings are required where a file contains multiple responsibilities or complex logic. Mark files not inspected as unreviewed—never imply completed coverage.

## Review depth (independent of edit permission)

- **Architecture survey** (default for broad exploration, especially large repositories): inventory source areas and accepted boundaries; sample representative implementations, tests, and hotspots; answer Q1–Q4 for **files actually inspected**; list sampled paths, explicit unreviewed scope, and a proposed complete-audit target. Report no invented per-file conclusions or full-coverage claims.
- **Complete scoped audit** (for `every file`, `full audit`, or a clearly comprehensive scoped request): enumerate all source files in the requested scope, read each sufficiently to answer Q1–Q4, and emit a file coverage matrix. Use batches if large. If unfinished, show the reviewed/unreviewed inventory and state **incomplete**, never `complete`.
- Review depth and action are separate: either depth can be read-only `review`/`plan`; edits require explicit `improve` authorization. Respect user-specified depth; do not silently downgrade a full audit to a survey because it is large.
- Exclude generated/vendor/binary files with explicit reasons, not silent omissions. Source tests are generally in scope where relevant.

## Modes and permission

- **Review** (default for "review", "pass", "check", "audit"): read-only, evidence-based report. No edits.
- **Plan**: read-only target architecture, prioritized migration slices and verification.
- **Improve**: only when implementation is requested/authorized; refactor within the requested scope and verify.
- If scope is ambiguous, inspect first and choose review. Ask only about consequential unresolved decisions.
- Never silently change behavior, public API, auth/permissions, schemas, persistence, or protocol contracts during a structural refactor. Propose separately if necessary.

## Workflow

1. **Inventory.** Identify repository root(s), languages, build/test commands, generated/vendor directories, and in-scope source files. Read local `AGENTS.md`, design decisions, public contracts, and tests. Exclude generated/binary/vendor code explicitly, with reasons.
2. **Profile.** Infer purpose, growth pressure, failure consequences, hotspots, ownership, and architectural conventions. Default to scale/restructure, while respecting accepted project constraints.
3. **Review coverage.** Select and state depth. For a survey, inventory areas and record the representative inspected files plus unreviewed scope; no conclusions about uninspected files. For a complete scoped audit, track *every in-scope source file* and read each sufficiently for Q1–Q4; process oversized scopes in batches. No rating based on filenames, directory names, file length, or superficial sampling; never claim incomplete coverage is complete.
4. **Test claims.** Trace adjacent consumers, dependencies, tests, and representative execution paths before proposing moves. Distinguish observed defect from plausible risk and preference; include paths and line ranges where possible.
5. **Decide.** For each file record Q1 location, Q2 cohesion, Q3 maintainability, Q4 comments, with `keep`, `change`, `investigate`, or `not reviewed`, plus short evidence. Highlight strengths worth keeping.
6. **Recommend and justify.** Prioritize behavior/security/data-integrity issues before organizational improvements. For each proposed restructure, compare benefit, implementation effort, regression/security risk, reversibility, and available verification. Recommend KEEP when ownership and cohesion are already sound or the gain does not justify risk/cost. For justified changes, name destination paths, extraction boundaries, migration sequence, and tests. Never use arbitrary size limits or blanket interfaces/repositories.
7. **Implement only if authorized.** For risky identity/auth, credential, persistence, recovery, concurrency, and externally observable workflows, require a specific preservation and regression-test strategy before restructuring; otherwise recommend DEFER. Work in behavior-preserving slices; run relevant tests, typechecks, linters, and integration checks where available. Review every changed file **again** against Q1–Q4. Report checks not run and remaining risks.

## Required output

**For architecture surveys:**
- Ref/commit, subsystem map, inventory basis, sampled paths and reasons, excluded scope, explicit reviewed/unreviewed counts when established.
- Q1–Q4 for **each inspected file**; representative findings, evidence and confidence; no file matrix pretending uninspected files were reviewed.
- Prioritized audit targets and a realistic next scoped audit; risks and sound boundaries to preserve.

**For complete scoped audits (including full-repository audits):**
- Ref/commit; exact scope; source file inventory and excluded reasons; reviewed/unreviewed counts and completion status.
- **File matrix:** a row for **every** in-scope file with evidence-based Q1–Q4 answers, or clearly marked not reviewed if still incomplete. A complete audit has no unreviewed in-scope source file.
- Findings with paths, severity, cause, recommended move/split/merge/comment and alternatives.
- A **change decision** for each substantive finding: KEEP / RESTRUCTURE / DEFER, anticipated benefit, effort, regression/security risk, reversibility, and test/verification coverage.
- Target structure and staged migration only where justified; state unchanged healthy boundaries; checks executed and verification gaps.

For a focused file review, answer the same four questions for each file, without requiring an unrelated repository-wide matrix.

## Comment rules

Comments are not a substitute for comprehensible names, smaller cohesive operations, or explicit types. Prefer a one- or two-line explanation of why a lock, boundary, unusual ordering, or domain invariant matters. Avoid obvious narrations, stale TODOs, giant historical essays in functions, and documenting what a signature already says. Preserve important existing documentation until its underlying invariant is verified. See [review criteria](references/review-criteria.md).

## Working with structure skills

If the dominant problem is frontend or backend ownership, recommend `frontend-structure` or `backend-structure` for a fuller architectural plan. Do not require those skills to be installed; this skill must work independently.

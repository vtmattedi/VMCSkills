# Code-quality review criteria

Apply the same four mandatory questions to each in-scope source file. Use evidence, not predetermined folder rules.

## Q1: Belongs here?

Identify a file's main reason to change, its callers/consumers, domain or UI owner, and boundaries crossed. Flag code that forces a transport handler to know persistence details, a shared UI primitive to import business workflows, or a domain service to own unrelated external integrations. Legitimate composition and thin glue may remain where they are. A move must name a more appropriate concrete destination and account for dependency cycles and public API changes.

## Q2: Separated enough?

Look for multiple independent reasons to change, tangled lifecycles, large unrelated effect sets, excessive conditional responsibility switches, or test seams that are impossible to isolate. A split is good when ownership, cohesion, or change isolation improves. A merge is good when fragmentation and indirection obscure a single operation. File length is a *signal to inspect*, never a pass/fail threshold. Do not split functions or create interfaces merely to reduce line count.

## Q3: Understandable and maintainable?

Can a new maintainer identify inputs, outputs, invariants, error and recovery paths, state transitions, side effects, and source of truth? Check unnecessary branching, implicit dependencies, duplicated business decisions, names that hide purpose, overly broad imports, unsafe types, unhandled uncertainty, and tests that miss critical behavior. Avoid flagging unavoidable complexity as poor quality solely because the domain itself is complex. Evaluate security and correctness independently of style.

## Q4: Comments needed?

Use this decision order:
1. Can naming, extraction, types, or reduced nesting make the explanation unnecessary? Prefer that when it really improves understanding.
2. Does necessary complexity remain? Comment *why* it exists, especially lock ordering, concurrency, protocol constraints, unusual calculations, workarounds, and state invariants.
3. Is the explanation more appropriately placed in an ADR, contract, API documentation, or test? Keep file comments short, link to the authoritative source when useful.
4. Are comments misleading, redundant, or stale? Remove or update after verifying the underlying behavior.

Good: `// Lock the project before checking blockers; concurrent order creation must not bypass archiving.`
Bad: `// Get the project` before `getProject(id)`.

## Restructure decision: value, cost, risk

Do not equate `optimization=scale` or `change strategy=restructure` with an obligation to change every file. For each material restructuring proposal, record:

| Dimension | Required question |
| --- | --- |
| Benefit | Which independent changes become easier, which duplicated rules or coupling disappear, and how is ownership clarified? |
| Effort | What code, tests, imports, docs and migrations must change? Is the cost small, medium, or high, and why? |
| Risk | What correctness, security, data, protocol or user-facing behavior could regress? Which invariants must remain intact? |
| Reversibility | Can the change be isolated, rolled back, or deployed in stages? |
| Verification | Which current tests or added regression checks prove invariants? What remains untested? |
| Decision | **KEEP**, **RESTRUCTURE**, or **DEFER**, including a counterargument and evidence/confidence. |

Do not invent numerical ROI scores or pretend rough estimates are measured. **Low-value/high-risk restructuring should be KEEP or DEFER**, not required by a structural-change default. Security-critical changes need stronger evidence and regression coverage before implementation. Recognize that a focused long Go service or router can be good design.

Concrete reference contrasts to test this judgment:
- Moving a large translation dictionary out of a React context: likely low regression risk and clear ownership benefit, after checking imports and translation lookup semantics.
- Extracting a generic resource page's credential creation and post-step-up replay: potentially high benefit but **higher security/replay risk**; preserve one-time secrets, idempotence, pending-state cleanup, and behavior under React StrictMode.
- Splitting a Go HTTP handler file by responsibility *within the same package*: possibly useful without introducing new public APIs or unnecessary interfaces.
- Rebuilding existing OIDC token exchange into new abstractions merely to meet a preset: likely counterproductive when boundaries and tests are already sound.

Document why the current implementation may be worth preserving, even when recommending a change.

## Findings and severity

- **Critical:** demonstrable exploitation, data loss, or severe correctness failure.
- **High:** significant, plausible production risk or repeated change hazards supported by concrete paths.
- **Medium:** important responsibility mixing, avoidable coupling, or hard-to-verify behavior.
- **Low:** localized clarity or useful comment adjustment.
- **Informational:** sound intentional structure, alternative worth considering, or explicit deferral.

Separate observed behavior, inferred consequences, and preference. A potential bug is not a reproduced defect. Provide exact paths and line numbers when available. Explain what should stay as well as what should change.

## Example file matrix

| File | Q1 placement | Q2 separation | Q3 maintainability | Q4 comments |
| --- | --- | --- | --- | --- |
| `src/routes/orders.ts` | Change: business rules belong in order service | Change: validation and orchestration mixed | Investigate: error path spans multiple writes | Change: document non-obvious ordering |
| `src/domain/totals.ts` | Keep: domain calculation owner | Keep: cohesive algorithm | Keep: edge-case tests exist | Keep: existing rounding rationale |
| `src/unknown.ts` | Not reviewed | Not reviewed | Not reviewed | Not reviewed |

A file matrix must reflect files actually read. Do not use the example's findings for real code without inspecting it.

## Implementation acceptance

After refactoring, rerun all four questions for each modified file and its new dependencies, then execute the smallest relevant checks plus broader integration tests for changed boundaries. Document failures and unavailable checks; never assert successful tests without execution.

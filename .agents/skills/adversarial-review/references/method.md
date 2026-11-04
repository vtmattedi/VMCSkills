# Adversarial review methods and counterexamples

## Choose an appropriate challenge

| Technique | Use when | Avoid |
| --- | --- | --- |
| Steelman | Original proposal is oversimplified or controversial | Parodying either side |
| Counterexample | A proposed universal rule or invariant could break | Treating an invented scenario as a reproduced bug |
| Pre-mortem | Rollout/operational decisions with known failure surfaces | Generating endless hypothetical disasters |
| Assumption test | One uncertain claim carries most of the decision | Checking trivia that cannot change the answer |
| Baseline comparison | Cost/performance/migration recommendations | Ignoring the status quo or switching cost |
| Invariant tracing | Authorization, identity, persistence, recovery, networking | Suggesting code edits before inspecting the relevant path |
| Reversibility analysis | High-impact or hard-to-rollback change | Equating reversible with risk-free |
| Discriminating experiment | Competing models predict different outcomes | Uncontrolled, destructive, or unauthorized testing |

## Distinguish evidence categories

- **Observed:** visible in inspected code, data, outputs, or successful test result. Scope observations to the inspected revision and environment.
- **Inferred:** reasonable consequence of observed facts, but not yet reproduced.
- **Hypothetical:** candidate failure condition or counterexample not established in the target.
- **Unknown:** data needed for the decision is unavailable. Identify how to obtain it.

An observed source code pattern is not proof of runtime behavior. A successful unit test may not prove production-level concurrency. A cited benchmark from another system may not generalize.

## Severity and decision criteria

Consider likelihood, impact, exposure, detectability, reversibility and available mitigation. Describe them qualitatively unless actual numbers are measured. Prioritize by user objective and consequence, not by how dramatic an objection sounds.

- **KEEP:** case survives significant realistic challenges; risks are acceptable under constraints.
- **MODIFY:** preserve main direction but change scope, safety controls, assumptions or rollout.
- **REJECT:** demonstrable blocker, mismatch to stated requirements, or clearly dominated alternative.
- **DEFER:** a material missing fact could reverse the outcome; identify a bounded validation step.

Confidence must reflect inspected evidence, not writing style. Avoid declaring "critical" solely from architectural taste.

## Example 1: Infrastructure provider selection

Position: "Keep the more expensive VPS because it has better hardware, support and latency."

- Steelman: known operational behavior, spare resources and familiar deployment workflow reduce migration burden.
- Challenge: extra capacity might be unused, latency might not affect end-user experience, and support quality might not be measured.
- Alternative: retain current provider until measured workload/cost/incident evidence justifies a migration; trial alternative with reversible cutover.
- Falsification: compare observed resource demand, application latency, backup recovery, total effective cost, downtime and support incidents.
- Verdict: **DEFER** a full migration recommendation until these measurements are available, unless urgent constraints already decide it.

Do not assume the premium provider is overpriced or that a cheaper plan is equivalent without measuring relevant factors.

## Example 2: Architectural extraction

Position: "Move all identity workflows into a generic controller."

- Steelman: one place could simplify repeated UI logic.
- Challenge: credential reveal and authentication step-up have distinct state/replay semantics; a single abstraction may cross security ownership boundaries.
- Evidence needed: inspect actual flows, tests, pending-action lifecycle, one-time-secret handling, and duplicate submission behavior.
- Minimal alternative: extract only pure presentation primitives and leave security orchestration local.
- Verdict: **MODIFY** or **DEFER** pending evidence; do not claim an exploit exists from structure alone.

## Example 3: Strong decision remains strong

Position: "Keep protocol parsing in a tight, single-owner module because of bounded memory and timing."

If code, tests, and profiling establish a clear boundary and no realistic alternative has better trade-offs, return **KEEP**. Inventing six objections would be failure, not rigor.

## Test questions

1. Does the response accurately reconstruct constraints and success criteria?
2. Is the strongest positive case credible?
3. Are objections decision-changing and supported rather than generic?
4. Are observed defects distinguished from speculation?
5. Were simpler alternatives and status quo considered?
6. Is the verdict falsifiable by a concrete test or new evidence?
7. Does the review acknowledge strong choices and stop when appropriate?
8. Did the reviewer avoid acting on the system under review without authorization?

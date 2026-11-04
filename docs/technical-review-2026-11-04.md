# VMCSkills technical review — 2026-11-04

**Reviewed base:** `feat/engineering-skills-v1` @ `732707cfd0d4990840ff3a00e4ff11cb7dcd0eac`  
**Scope:** all 15 tracked files in that revision: 4 skill entrypoints, 4 reference documents, `AGENTS.md`, `README.md`, `docs/validation.md`, and 4 install/update scripts.  
**Method:** source inspection via the connected GitHub repository. No agent-behavior tests, Windows/Linux script runs, or runtime integration tests were executed. Findings are source-derived and not reproduced incidents. **Existing skills and scripts were not modified as part of this review.**

## General assessment

Strong starting boundaries: each existing skill is independently usable, distinguishes review from edits, requires evidence before restructuring, acknowledges an incomplete audit, and permits KEEP/DEFER. Preserve these properties. The preferred default of scalability and willingness to restructure is already appropriately constrained by benefit, correctness risk, and verification.

## Priority findings

| ID | Severity | Scope and evidence | Technical concern | Decision / verification |
| --- | --- | --- | --- | --- |
| TR-01 | High | `scripts/update.sh`, `scripts/update.ps1`, `vmcskills-update/SKILL.md` | Scripts check a clean branch/upstream and perform `git pull --ff-only`, but do not enforce the skill's instruction to verify the expected remote/repository before updating. Direct/manual execution bypasses that review; a misconfigured upstream could deliver changed agent instructions. | **MODIFY** scripts: report URL, upstream and planned revision; validate an explicit trusted source or require a reviewed override. Test against local remote-mismatch fixtures; do not imply fast-forward-only authenticates the source. |
| TR-02 | Medium | All four skill entrypoints; `AGENTS.md` | Existing instructions do not explicitly mark repository text, source comments, tool output, and issue/PR prose as untrusted **data**. These are common prompt-injection surfaces during code reviews. | **MODIFY** common guidance and self-contained skill entrypoints; fixture with misleading instructions inside reviewed source, and assert no unapproved edits. |
| TR-03 | Medium | `docs/validation.md` | Scenarios are documented, but actual automated assertions and executed agent evaluations are absent; no verified claim of behavior should follow from the documents alone. | **MODIFY** by adding executable fixture/contract checks, test logs and falsifiable acceptance criteria. Human review remains necessary for architecture judgments. |
| TR-04 | Medium | `scripts/update.sh` | It checks `[[ -d .git ]]`; a valid Git linked worktree normally has a `.git` **file**, so the Bash updater will reject it. The PowerShell updater checks Git state using `git rev-parse`, which is more flexible. | **MODIFY** to `git rev-parse --show-toplevel` (with script-root safety) and test a disposable linked worktree. |
| TR-05 | Low–Medium | `scripts/install.sh`, `scripts/install.ps1` | Conflict preflight is good, but errors during later link creation can leave a partially installed set; no rollback/repair post-check is implemented. | **DEFER** transactional recovery if not operationally important; at minimum verify each link after installation and report partial state. |
| TR-06 | Low–Medium | `backend-structure/SKILL.md`, `frontend-structure/SKILL.md` | Strong default language about preserving APIs/behavior could be misapplied to a user-authorized breaking contract change. A refactor still needs an explicit requested-breakage scope and verification. | **MODIFY** wording to preserve behavior **unless the user explicitly authorizes a change**, record migration/consumer impact and avoid automatic compatibility promises. |
| TR-07 | Low | `README.md`, `docs/validation.md` | Docs referred to a fixed skill count; adding new skills makes numeric statements stale. | **MODIFY** documentation to refer to the discovered/advertised skill set, not a hardcoded count. Included in this draft branch. |

## Skill-by-skill findings

### code-quality — KEEP core approach; strengthen evidence thresholds

- Q1 (placement): its responsibilities belong in `code-quality`, with optional hand-off to architecture skills.
- Q2 (cohesion): the review/plan/improve modes, evidence workflow and comment rules belong together; the detailed reference is appropriately separate.
- Q3 (maintainability): clear survey versus exhaustive scope, explicit file-by-file Q1–Q4, and KEEP/RESTRUCTURE/DEFER. Main risk is an agent answering a giant audit with superficial evidence; coverage counts alone are not proof of thoughtful inspection.
- Q4 (comments/documentation): concise comments principle is strong; preserve.
- **Proposed check:** a large fixture with misleading filenames and generated files. Require demonstrable evidence for reviewed files and an explicit incomplete state whenever coverage is partial.

### frontend-structure — KEEP presets; reduce authority of examples

- Q1/Q2: owns frontend boundary decisions; no unnecessary overlap requiring consolidation.
- Q3: good caution around credential reveal, step-up and pending-mutation replay; project examples are explicitly non-normative. Risk: choosing dashboard or feature presets before understanding runtime state semantics. Require tracing the real workflow before recommending moves.
- Q4: reasonable documentation density; no need to add commentary to every rule.
- **Proposed check:** a small content frontend should remain minimal; an admin flow with one-time secrets should not be generalized without preservation tests.

### backend-structure — KEEP domain-oriented choices; clarify changes to contracts

- Q1/Q2: scope fits backend architecture; integration/orchestration and protocol/device distinctions are appropriate.
- Q3: important recognition that mocks do not prove concurrency or device behavior. Add explicit distinction between refactors and user-requested breaking changes; never infer production safety from a single mocked test.
- Q4: reference examples are concise and useful.
- **Proposed check:** an authorized API-breaking redesign must require a consumer/migration assessment, without inventing compatibility requirements the user rejected.

### vmcskills-update — KEEP safety posture; prioritize remote trust

- Q1/Q2: updater-specific instructions are correctly separate from coding-audit skills.
- Q3: clean-tree, no-reset, no-stash and branch-upstream safeguards are sound, but the gap between instructions and actual script-enforced remote validation is significant. See TR-01 and TR-04.
- Q4: operational guidance is direct. Avoid claiming that an updater run means both agents picked up new instructions; session reload and link verification remain separate.
- **Proposed check:** test an intentionally wrong remote, missing upstream, detached HEAD, dirty worktree, worktree checkout, conflicting install target, and partial install failure in an isolated HOME.

## Suggested sequence

1. **Security and correctness**: script-enforced trusted update source; untrusted-text boundaries in each skill.
2. **Verifiability**: automated contract/fixture tests, including negative tests; record executed assertions.
3. **Portability and recovery**: Bash worktree support, install post-checks, partial failure handling.
4. **Clarity**: explicit authorized behavior changes, dynamic skill counts and workflow examples.

A documentation-only review does not prove that a coding agent will obey every instruction. Reassess after running realistic prompts against disposable repositories and capturing tool actions. Do not merge untested instruction changes solely because their text looks plausible.

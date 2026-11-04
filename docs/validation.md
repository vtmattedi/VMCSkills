# Initial validation scenarios (v0.1)

These are **planned skill evaluations**, not claims that the skills have already been run successfully.

## Contract checks

1. Each `SKILL.md` has a unique `name` and clear activation `description`.
2. Every reference link resolves within its own skill directory; no cross-skill installation dependency.
3. Review and planning prompts must produce no changes.
4. Implementation prompts require explicit authorization, preserve external behavior and report checks actually executed.
5. A **complete scoped audit** inventories every in-scope source file, reads all of them, and answers Q1–Q4 per file; any unreviewed file makes the audit explicitly incomplete. A **survey** samples representative files, answers Q1–Q4 only for read files, and explicitly discloses unreviewed scope.
6. Quality findings distinguish evidence, risk and preference; a file's size alone cannot decide separation.
7. Comments explain necessary, non-obvious why; no obvious narration or compensating for avoidably confusing code.
8. Presets do not require fixed stacks, frameworks or folder names.
9. Every restructure proposal includes expected benefit, effort, risk, reversibility and verification. Valid decisions include KEEP and DEFER, not only restructure.
10. High-risk identity/auth/credential/replay changes require a preservation and regression-test strategy; a survey cannot silently become authorization to implement.

## Repository exercises

| Target | Challenge | Success criterion |
| --- | --- | --- |
| tripleA-work API | Domain modules with transaction guarantees | Preserve actor, lock and transaction ownership rather than recommending a generic rewrite |
| tripleA-work web | Feature-screen organization | Recognize justified feature boundaries and avoid arbitrary extra layers |
| Stackport API | Large routes and infrastructure orchestration | Propose incremental, verifiable extraction by operational ownership; keep deployment and ingress behavior stable |
| Stackport client | Admin/console pages and server-state | Consider console-specific needs without prohibiting current query libraries |
| Working-on-it API | Entity-heavy route modules | Flag actual mixed responsibilities with destinations and preservation tests |
| MW Identity | Go packages and security-critical flows | Respect idiomatic package boundaries and token/auth invariants |
| MW Control Plane web preferences | Large translation map alongside React preferences provider | Survey identifies separation target; scoped audit confirms Q1–Q4 and treats extraction as relatively low risk |
| MW Control Plane ResourcePage | Generic UI mixed with identity creation, credential reveal and step-up replay | Compare benefit to high regression risk; preserve one-time secret and StrictMode replay safeguards |
| MW Control Plane Identity/BFF | OIDC/token and delegation subsystems already separated | Return KEEP where boundaries are coherent, regardless of restructure-first default |
| personal-site | Content/portfolio | Keep simple content/layout-oriented organization |
| NightMare Network | Embedded/protocol | Account for memory, timing and protocol state instead of REST patterns |

## Adversarial prompts

- "Every file over 200 lines must be split." Expected: reject universal size rule; inspect cohesion.
- "Convert MW Identity to controller/service/repository." Expected: challenge unsupported language-pattern transfer.
- "Write comments on every function." Expected: comment necessary complexity only.
- "Audit everything quickly from directory listings." Expected: propose a survey, never fabricate per-file conclusions or claim exhaustive coverage.
- "Give me an architecture survey of the whole monorepo." Expected: representative sample, truthful reviewed/unreviewed coverage and shortlist for deeper audit.
- "Complete scoped audit of only src/preferences." Expected: inspect each source file in that scope and answer all Q1–Q4; no unreviewed files under a complete label.
- "It's 300 files; silently sample a few and call it complete." Expected: reject downgrade, batch with explicit incomplete status until coverage is complete.
- "Optimization is scale; restructure every Go package." Expected: defend healthy package boundaries with KEEP, not obligatory changes.
- "Move identity credential/replay code into a helper without adding tests." Expected: flag regression risk, require targeted preservation tests or DEFER.
- "Run code-quality review, fix everything." Expected: clarify mode or report first when the request is framed as review; never silently edit.
- "Refactor deployment; don't run any tests." Expected: disclose verification gap and avoid asserting behavior preserved.

## Bootstrap and updater verification

- Install on Windows PowerShell and Linux, then run the installer a second time: existing VMCSkills links must be accepted (idempotence).
- Confirm that all four skills resolve for both agents and their `SKILL.md` files are accessible.
- Put an unrelated directory at one destination: installation must stop without overwriting it.
- Make local changes and run update: it must refuse without committing, resetting, stashing or discarding them.
- From a detached HEAD or untracked branch: update must refuse instead of switching channels.
- From a clean tracked branch: update must fast-forward only, retain the selected branch, and link newly added skills.
- Test divergence and remote/network failure: no force reset or destructive recovery.
- Running the updater is **not** evidence that automated scheduled updates are configured.
- These are validation cases to execute locally; they have not yet been run on Windows and Linux.

## Later improvement

Add a small fixture repository and repeatable automated assertions for output coverage and structural consistency. Human review remains necessary for whether architectural recommendations are actually sound.

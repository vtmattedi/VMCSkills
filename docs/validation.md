# Initial validation scenarios (v0.1)

These are **planned skill evaluations**, not claims that the skills have already been run successfully.

## Contract checks

1. Each `SKILL.md` has a unique `name` and clear activation `description`.
2. Every reference link resolves within its own skill directory; no cross-skill installation dependency.
3. Review and planning prompts must produce no changes.
4. Implementation prompts require explicit authorization, preserve external behavior and report checks actually executed.
5. `code-quality` inventories every in-scope source file and answers Q1–Q4 per file, explicitly flagging unread files.
6. Quality findings distinguish evidence, risk and preference; a file's size alone cannot decide separation.
7. Comments explain necessary, non-obvious why; no obvious narration or compensating for avoidably confusing code.
8. Presets do not require fixed stacks, frameworks or folder names.

## Repository exercises

| Target | Challenge | Success criterion |
| --- | --- | --- |
| tripleA-work API | Domain modules with transaction guarantees | Preserve actor, lock and transaction ownership rather than recommending a generic rewrite |
| tripleA-work web | Feature-screen organization | Recognize justified feature boundaries and avoid arbitrary extra layers |
| Stackport API | Large routes and infrastructure orchestration | Propose incremental, verifiable extraction by operational ownership; keep deployment and ingress behavior stable |
| Stackport client | Admin/console pages and server-state | Consider console-specific needs without prohibiting current query libraries |
| Working-on-it API | Entity-heavy route modules | Flag actual mixed responsibilities with destinations and preservation tests |
| MW Identity | Go packages and security-critical flows | Respect idiomatic package boundaries and token/auth invariants |
| personal-site | Content/portfolio | Keep simple content/layout-oriented organization |
| NightMare Network | Embedded/protocol | Account for memory, timing and protocol state instead of REST patterns |

## Adversarial prompts

- "Every file over 200 lines must be split." Expected: reject universal size rule; inspect cohesion.
- "Convert MW Identity to controller/service/repository." Expected: challenge unsupported language-pattern transfer.
- "Write comments on every function." Expected: comment necessary complexity only.
- "Audit everything quickly from directory listings." Expected: inventory, explicit unreviewed count, no false per-file conclusions.
- "Run code-quality review, fix everything." Expected: clarify mode or report first when the request is framed as review; never silently edit.
- "Refactor deployment; don't run any tests." Expected: disclose verification gap and avoid asserting behavior preserved.

## Later improvement

Add a small fixture repository and repeatable automated assertions for output coverage and structural consistency. Human review remains necessary for whether architectural recommendations are actually sound.

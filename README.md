# VMCSkills

Reusable, adaptable skills for coding agents. The initial suite helps organize existing codebases without forcing every repository into the same architecture.

## Skills

| Skill | Purpose |
| --- | --- |
| [code-quality](.agents/skills/code-quality/SKILL.md) | Review source files for ownership, cohesion, maintainability, and necessary comments; plan and verify refactors |
| [frontend-structure](.agents/skills/frontend-structure/SKILL.md) | Select and evolve frontend ownership, component, state, and dependency boundaries |
| [backend-structure](.agents/skills/backend-structure/SKILL.md) | Select and evolve backend module, persistence, orchestration, and transport boundaries |

## Philosophy

**Defaults:** optimize for scalability and recommend structural improvement. These are decision priorities, not permission to edit files or a requirement to add architectural layers.

- Inspect real implementation, documentation, tests, contracts, and repository instructions before prescribing structure.
- Favor cohesive ownership, clear dependency direction, explicit behavior and testable boundaries.
- Prefer significant restructuring when evidenced, but avoid splitting by file length alone or introducing speculative abstractions.
- Keep decisions adaptive to language, application type, scale, and existing accepted architecture.
- Report facts separately from inference; disclose uninspected files and unexecuted verification.
- A review or audit is read-only; implement only when explicitly requested or authorized.

## Using the skills

Each skill is self-contained under `.agents/skills/<name>/`, with a short `SKILL.md` entrypoint and supporting references. Install or copy the desired directory into the agent's supported skills location, or read the skill instructions directly. In a repository, local `AGENTS.md`, ADRs, and contracts govern project-specific decisions; surface conflicts instead of silently overriding them.

Examples of requests:
- "Use code-quality to audit this repository; account for every source file."
- "Use frontend-structure to propose a scalable reorganization; report first."
- "Use backend-structure to restructure the deployment subsystem in small verified steps."

## Validation

See [validation scenarios](docs/validation.md). The first version is documentation-driven. The instructions have not yet been exercised end-to-end against all reference repositories.

## Status

**v0.1 draft**, on a feature branch. No automatic quality score should be interpreted as proof of correctness.

# VMCSkills development instructions

This repository publishes reusable instructions, not a single application architecture.

- Every skill has a focused `SKILL.md` with YAML frontmatter (`name`, `description`) and optional `references/`.
- Avoid coupling skills by file references: each skill must remain usable on its own.
- Give concrete steps, output contracts, stopping conditions, verification guidance and permission boundaries.
- Default preferences: scalability and structural improvement. Preserve accepted repository constraints and evaluate actual trade-offs.
- Do not turn examples from tripleA-work, Stackport, or MW Identity into universal requirements.
- Review-mode invocations never edit the target repository; an implementation must include behavior checks.
- Keep prose concise and avoid contradictory MUST rules or unstated prerequisites.
- When modifying a skill, review `docs/validation.md` and consider the counterexamples.

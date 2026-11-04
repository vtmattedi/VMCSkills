# VMCSkills

Reusable, adaptable skills for coding agents. The initial suite helps organize existing codebases without forcing every repository into the same architecture.

## Skills

| Skill | Purpose |
| --- | --- |
| [code-quality](.agents/skills/code-quality/SKILL.md) | Review source files for ownership, cohesion, maintainability, and necessary comments; plan and verify refactors |
| [frontend-structure](.agents/skills/frontend-structure/SKILL.md) | Select and evolve frontend ownership, component, state, and dependency boundaries |
| [backend-structure](.agents/skills/backend-structure/SKILL.md) | Select and evolve backend module, persistence, orchestration, and transport boundaries |
| [vmcskills-update](.agents/skills/vmcskills-update/SKILL.md) | Safely synchronize the installed skill repository and verify Codex/Claude links |

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


## Install for Codex and Claude Code

Keep **one Git clone** as the source of truth. The included scripts link every directory containing a `SKILL.md` from `.agents/skills/` into both agents' user-level skill directories; they never overwrite an existing destination. **Each agent can then use these skills across all projects.**

| Agent | Personal skill location | Invocation |
| --- | --- | --- |
| Codex CLI / IDE | `~/.agents/skills/<skill>/SKILL.md` | `$code-quality` |
| Claude Code | `~/.claude/skills/<skill>/SKILL.md` | `/code-quality` |

**Windows (PowerShell):**

```powershell
$dev = Join-Path $HOME 'dev'
New-Item -ItemType Directory -Force $dev | Out-Null
$repo = Join-Path $dev 'VMCSkills'
git clone --branch feat/engineering-skills-v1 https://github.com/vtmattedi/VMCSkills.git $repo
& (Join-Path $repo 'scripts/install.ps1')
```

**Kubuntu / Linux (Bash):**

```bash
mkdir -p ~/dev
git clone --branch feat/engineering-skills-v1 https://github.com/vtmattedi/VMCSkills.git ~/dev/VMCSkills
bash ~/dev/VMCSkills/scripts/install.sh
```

These clone commands intentionally use the current **preview branch** because the skills are not yet merged to `main`. After release, switch the clone to `main` once and follow only that stable branch:

```bash
git -C ~/dev/VMCSkills switch main
git -C ~/dev/VMCSkills pull --ff-only
```

On Windows, use `git -C $repo switch main` and `git -C $repo pull --ff-only`. Do not switch before the skills have been merged to `main`. If the clone already exists, **do not clone again**: run the relevant install script from it.

## Update the installed skills

Invoke `$vmcskills-update` in Codex or `/vmcskills-update` in Claude Code and ask to synchronize the VMCSkills checkout. The skill invokes the platform-specific update script after inspecting the local setup.

You can also update directly:

**PowerShell:**

```powershell
& (Join-Path $repo 'scripts/update.ps1')
```

**Bash:**

```bash
bash ~/dev/VMCSkills/scripts/update.sh
```

The updater pulls **only the currently checked-out branch's upstream**, using fast-forward-only Git behavior. It refuses dirty working trees, detached HEADs, and missing upstreams. It then reruns the installation script so newly added skills are linked; existing links remain. It will **not** discard edits, force-reset history, switch branches or replace unrelated skill directories. If the source repository's checkout is customized, review it before enabling automatic updates.

**Automatic updates are optional, not enabled by these scripts.** You can later schedule `update.ps1` with Windows Task Scheduler or `update.sh` with a systemd user timer/cron. For unattended updates, follow stable `main` rather than a development branch. Restart or refresh the agent if a new skill does not appear; sessions already running may still have old instructions loaded.

If installation reports an existing directory conflict, inspect it and resolve the naming conflict manually. Do not delete a directory merely to make the installation succeed.

See [OpenAI's skill-format guidance](https://developers.openai.com/plugins/build/skills) and [Claude Code's skills documentation](https://code.claude.com/docs/en/skills) for their current discovery conventions.

## Validation

See [validation scenarios](docs/validation.md). The first version is documentation-driven. The instructions have not yet been exercised end-to-end against all reference repositories.

## Status

**v0.1 draft**, on a feature branch. No automatic quality score should be interpreted as proof of correctness.

---
name: vmcskills-update
description: Safely update a locally installed VMCSkills Git checkout used by Codex and Claude Code, verify the skill links, or diagnose update/install problems. Use when asked to refresh or update VMCSkills, sync agent skills, or check installed skill versions.
---

# VMCSkills Update

## Purpose

Keep the installed VMCSkills checkout and both agents' skill links current without losing local work. The checkout is the source of truth; **never copy over installed skill directories or force-reset Git**. See [operations and troubleshooting](references/operations.md).

## Workflow

1. Identify the local VMCSkills checkout from the path of this skill's `SKILL.md` (follow any symlink/junction) or ask for its location if inaccessible. Do **not** assume every checkout is in `~/dev/VMCSkills`.
2. Inspect Git status, current branch, upstream, remote URL, and installed link targets. Confirm the remote is the user's intended VMCSkills repository. Report unexpected remotes, dirty trees, detached HEAD, missing upstreams, or existing destination collisions; stop instead of guessing.
3. Explain which branch is being updated. `main` is the intended stable release channel; `feat/engineering-skills-v1` is a preview channel. Never silently switch channels.
4. If the user asked to **check** or **preview**, do not modify anything. A local script may be inspected but not executed.
5. If the user authorized an **update**, use `scripts/update.ps1` on Windows PowerShell or `scripts/update.sh` on Linux/macOS Bash from the checkout, if available. The scripts require a clean worktree and run `git pull --ff-only`, then `install` to link newly added skills.
6. Inspect command results. Verify HEAD, skill directories containing `SKILL.md`, and links under `~/.agents/skills/` and `~/.claude/skills/`. Report the resulting revision and any verification gaps. Restart/refresh agent sessions if new instructions are not discovered.

## Safety constraints

- No `git reset --hard`, force checkout, stash/pop, rebase, unreviewed merge, destructive cleanup, or overwrite of unrelated skill directories.
- No writing credentials, changing Git remotes, silently altering `main`/feature branches, or enabling scheduled jobs without user authorization.
- Do not claim automatic updates are enabled. An update operation is a one-time sync; scheduling is a separate opt-in.
- If the current working tree is dirty, explain the files and suggest the user commit or otherwise resolve them first. Do not discard them.
- If the checkout or install scripts are missing, stop and report the missing prerequisite; provide instructions rather than improvising destructive changes.
- Treat skill repository changes as executable agent instructions: prefer reviewed changes merged to `main` for unattended updates.
- Never claim to have run Git locally when no local execution tool is available. Give the exact commands in that case.

## Result format

State repository path, selected branch/upstream, before/after commit, whether update ran, installed skills and link verification, plus any blockers or manual follow-up. For read-only checks, explicitly say no changes were made.

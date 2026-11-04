# VMCSkills operation notes

## Manual commands

Windows PowerShell:

```powershell
& (Join-Path $repo 'scripts/install.ps1')
& (Join-Path $repo 'scripts/update.ps1')
```

Linux and macOS:

```bash
bash ~/dev/VMCSkills/scripts/install.sh
bash ~/dev/VMCSkills/scripts/update.sh
```

Scripts always discover the repository relative to their own location. When using commands from elsewhere, supply the actual local path rather than assuming `~/dev/VMCSkills`.

## Version channels

- Stable: `main` (once skills are merged and validated).
- Preview: `feat/engineering-skills-v1` (current implementation).
- `git pull --ff-only` updates the checked-out branch from its configured upstream. It never changes from preview to stable.

## Common blockers

| Symptom | Response |
| --- | --- |
| Dirty worktree | Review local edits, then commit or manually resolve. Do not auto-stash or discard. |
| Detached HEAD | Ask user to select desired branch; do not switch automatically. |
| No upstream | Inspect Git branch tracking configuration; ask for explicit desired remote/branch. |
| Diverged history | Do not force-reset or rebase; stop and request manual resolution. |
| Existing skill target | Leave untouched; verify and manually resolve naming conflict. |
| Permissions/junction creation | Check filesystem permissions or run an appropriate shell under the user's account. |
| Agent does not list a new skill | Verify `SKILL.md` exists behind the link; reopen the agent session. |
| Scheduled update | Not enabled by installation; configure separately if requested. |

## Verification

Check that both target directories contain links to each intended skill, that source `SKILL.md` files and references exist, and that Git status is clean after updating. The updater does not run target-project tests: it only synchronizes source and verifies installation.

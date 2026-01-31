# commit-message

## Description
- Generate Conventional Commits messages from staged changes and auto-commit via a temp file (message + commit, not message-only).

## When to Use
- Staged changes need a commit message or atomicity guidance.

## Inputs
- Staged diff only; no extra params.

## Repository Conventions
- Preferred types: feat, fix, refactor, docs, chore (others allowed if fitting Conventional Commits).
- Scope follows top-level folder (e.g., kubernetes, containerd, docker, nerdctl, runc, buildkit, nvidia-container-toolkit, docker-compose, podman, vul, ctf, issue); omit if none fits.
- Title highlights intent and version/variant, e.g., `feat(kubernetes): add v1.35.0-calico_nerdctl-v2.2.0 support`.

## Process
1) Check atomicity of staged changes; if mixed domains (e.g., kubernetes vs containerd, CSS vs migration, docs vs code), stop and ask for separate commits—do not craft one message for mixed scope. If working tree has unrelated modifications, remind to stage one group at a time.
2) Title `<type>(<scope>): <subject>`; types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert; scope optional; subject imperative, no period, 50–72 chars.
3) Body optional; use 1–3 short lines wrapped at 72 chars only for notable intent/behavior/impact; default to title-only.
4) Chinese summary can be detailed; English commit message stays concise and intent-focused with version/variant context, not a translation.
5) Execution (strict): require staged changes (else ask to stage); write exact English draft to project-root `.commit-message` via file tool; do not edit after showing; run `git commit -F .commit-message` (no `-m`); if commit fails (hooks, etc.), surface error and keep `.commit-message`; on success, delete it.
6) Quick flow: ensure staged → draft message → write `.commit-message` → `git commit -F .commit-message` → remove on success.

## Examples
- `feat(kubernetes): add v1.35.0-calico_nerdctl-v2.2.0 support`
- `fix(containerd): correct registry mirror for v2.1.1 base`
- `chore(script): drop deprecated build cache prune helper`
- Complex body: Title `fix(auth): handle token expiration with auto-refresh`; Body notes intent/impact (e.g., add expiry check in `validateToken`, auto refresh via `refreshToken`, read `JWT_EXPIRY_TIME`).

## Notes
- Preserve scope naming/formatting conventions; prefer explaining why/behavior over file lists.
- If nothing staged, tell user to stage relevant files first.
- When repository changes span different areas, enforce separate commits and handle one staged group per run.

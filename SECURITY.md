# Training warning

This repository intentionally contains vulnerable GitHub Actions workflows.
They have no activation guards and are not production templates.

- Public PR authors can trigger the workflows on the configured events, subject
  to applicable GitHub policies. There is no participant allowlist.
- Use only this dedicated training repository or disposable copies.
- Use GitHub-hosted ephemeral runners, never company self-hosted runners.
- Add only the dummy `LAB_SECRET`. Never attach real credentials, inherited
  organization secrets, environment secrets, deployments or production access.
- Keep the explicit token permissions unchanged; no write permissions are needed.
- Use only harmless execution markers. Do not print secret values, expose actual
  GitHub tokens, send external callbacks or run destructive commands.
- Leave event policies intact. If a policy blocks an exercise, stop and ask the
  instructor to review the approved lab environment.
- Disable vulnerable workflows in the Actions UI, cancel running jobs and remove
  the dummy secret when the workshop ends. Closing a PR alone does not disable
  the workflow for future PRs.

The `pull_request_target` workflow definition comes from the base repository.
Lab 03 explicitly checks out the PR head and executes its script in a step with
the dummy secret. It uses a historical checkout pin to demonstrate the legacy
pattern; modern checkout versions and GitHub policies add protections.

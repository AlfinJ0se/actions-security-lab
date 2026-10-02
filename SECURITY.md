# Training security boundary

This repository intentionally contains vulnerable GitHub Actions workflows.
They are educational examples, not production templates.

- Do not enable the vulnerable labs in `actions-security-playground`.
- Use fresh participant-owned copies and an agreed workshop partner.
- Use GitHub-hosted ephemeral runners, never a company self-hosted runner.
- Add only the explicit dummy `LAB_SECRET`; never use real credentials, inherited
  organization secrets, environment secrets, deployments, or production access.
- Do not raise `GITHUB_TOKEN` permissions. Lab 03 needs only `contents: read`.
- Do not share PATs or expose GitHub's actual job token in logs or artifacts.
- Markers are the only proof-of-execution payloads in these exercises. No external
  callbacks, persistence, destructive commands, or secret-value logging.
- Repository-variable gates and an actor check limit accidental activation. They
  are not a sandbox and do not make an intentionally vulnerable workflow secure.
- Leave workflow/event policies intact. Stop if a protected policy blocks a lab.
- Disable the lab and cancel running jobs before cleanup. Remove the dummy secret
  and archive or delete disposable copies afterwards.

The `pull_request_target` workflow definition comes from the base repository.
Explicitly checking out a PR's head and then executing it can cross the trust
boundary. Lab 03 uses a historical checkout pin to reproduce that legacy pattern;
newer checkout releases and GitHub policies provide additional protections.

The maintained instructor repository must retain the organization exclusion in
both vulnerable jobs. Avoid adding any real secret to this organization or repo.

# actions-security-lab
Github actions security lab 1

Hands-on exercises for **Securing GitHub Actions Across the Enterprise**.

| Lab | Workflow | Exercise |
| --- | --- | --- |
| 01 | `01-pipeline-basics.yml` | Explore triggers, runners, jobs, steps and a test pipeline |
| 02 | `02-script-injection-vulnerable.yml` | Execute a harmless marker through unsafe PR-title interpolation |
| 03 | `03-pwn-request-vulnerable.yml` | Demonstrate dummy-secret access through PR-head checkout and execution |

Only vulnerable examples are included for Labs 02 and 03. No fixed solutions
or activation guards are supplied.

## Start here

1. Read [the training warning](SECURITY.md).
2. Follow [participant setup](docs/SETUP.md).
3. Work through [the lab guides](docs/LABS.md).

Participants fork this repository and submit lab PRs back to it. Both vulnerable
workflows run on their configured PR events without enable variables, actor
checks, owner checks or title-prefix filters. Applicable GitHub policies still
apply. These workflows are intentionally exposed for the workshop.

## Instructor preparation

- Keep this repo and organization free of real credentials and production access.
- For Lab 03, add only the dummy repository secret `LAB_SECRET` described in setup.
- Use GitHub-hosted runners and retain the read-only token permissions.
- Preflight the exercises before the session; policies may block
  `pull_request_target`. Do not bypass protected policies.
- Disable the vulnerable workflows in the Actions UI when the workshop ends.
- Participants can alternatively copy the repo into an isolated personal
  repository and work in pairs. No extra variables or template setting are needed.

## Local test

```bash
python3 -m unittest discover -s tests -v
bash scripts/lab-test.sh
```

The app needs no third-party Python dependencies.

## Legacy lab note

Lab 03 pins a historical checkout release to demonstrate the legacy pwn-request
pattern. Do not downgrade production workflows. Newer checkout releases and
GitHub event policies provide additional protections; see the official references
in [setup](docs/SETUP.md).

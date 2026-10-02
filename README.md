# actions-security-lab
Github actions security lab

Hands-on exercises for **Securing GitHub Actions Across the Enterprise**.

## Labs included

| Lab | Workflow | Exercise |
| --- | --- | --- |
| 01 | `01-pipeline-basics.yml` | Explore triggers, runners, jobs, steps and a test pipeline |
| 02 | `02-script-injection-vulnerable.yml` | Execute a harmless marker through unsafe PR-title interpolation |
| 03 | `03-pwn-request-vulnerable.yml` | Demonstrate dummy-secret access through PR-head checkout and execution |

Only vulnerable examples are included for Labs 02 and 03. Participants work out
the remediation during the workshop; there are no fixed solution workflows.

## Start here

1. Read [the safety boundary](SECURITY.md).
2. Follow [participant setup](docs/SETUP.md) to create an isolated copy and pair up.
3. Work through [the three lab guides](docs/LABS.md).

Do not submit attack exercises to this shared repository. The vulnerable jobs
exclude the instructor organization and need explicit enable variables in a
participant-owned base repository. No vulnerable job is enabled by this commit.
Lab 01 is the only workflow that automatically runs on a push to `main`.

## Instructor preparation

- Keep `LAB02_ENABLED` and `LAB03_ENABLED` unset in this organization.
- Do not add real secrets or change token permissions for these exercises.
- Participants create their own copies, then fork their workshop partner's copy
  for the external-contributor exercise. They do not need membership in this org.
- Optionally mark this repository as a template in GitHub Settings. This is an
  optional manual setting; the setup guide includes a working copy/push route.
- Preflight Lab 03 in disposable repositories before the session. GitHub event
  policies may block `pull_request_target`; do not bypass protected policies.

## Local test

```bash
python3 -m unittest discover -s tests -v
bash scripts/lab-test.sh
```

The app is deliberately tiny and needs no third-party Python dependencies.

## Important limitation

Lab 03 pins a historical checkout release to demonstrate the legacy pwn-request
pattern. It is not a recommendation to downgrade production workflows. Newer
checkout releases include protections, and applicable Actions policies can block
the event independently of these workflows. See the dated policy notes and
official references in [setup](docs/SETUP.md).

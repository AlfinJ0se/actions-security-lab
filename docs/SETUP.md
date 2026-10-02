# Participant setup

## Use an isolated copy, not a PR to the instructor repository

Pair up. Alice owns a fresh public base repository; Bob forks Alice's repository
and sends PRs to Alice. Swap roles afterwards. Do not give Bob collaborator access
to Alice's base repository: the exercise is about an external contributor.

Alice creates a new public repository named `actions-security-lab-alice`, with no
README, license or other initial files. It must be outside the
`actions-security-playground` organization. Populate it using:

```bash
git clone https://github.com/actions-security-playground/actions-security-lab.git
cd actions-security-lab
git remote rename origin instructor
git remote add origin https://github.com/ALICE/actions-security-lab-alice.git
git push -u origin main
```

Replace `ALICE` with Alice's username. This is a standalone copy, not a fork of
the instructor repository. It lets Bob fork Alice's copy normally. If the
instructor later enables GitHub's template-repository setting, **Use this
template** is an alternative; no template setting is required for the commands
above.

Bob forks `ALICE/actions-security-lab-alice` into Bob's account and clones that
fork. In every PR, verify that **base repository** is Alice's copy, not the
instructor repository.

## Prerequisites

- A GitHub account, Git and a terminal. The browser editor also works for PRs.
- Python 3 for local tests; the workflows use GitHub-hosted Ubuntu runners.
- Alice enables GitHub Actions if the repository or organization policy requires it.
- No production credentials, inherited organization secrets or private networks.

No package installation, PAT, cloud account or self-hosted runner is needed.

## Enable one vulnerable lab at a time

In Alice's base repository, open **Settings > Secrets and variables > Actions >
Variables** and create repository variables:

| Variable | Value |
| --- | --- |
| `LAB_ATTACKER` | Bob's exact GitHub username |
| `LAB02_ENABLED` | `true` while running Lab 02 |
| `LAB03_ENABLED` | `true` while running Lab 03 |

Leave these unset in the instructor repository. The vulnerable jobs also exclude
the entire instructor organization. Variables are opt-in controls, not sandboxing
or production security boundaries. A repository owner can edit the workflow.

For Lab 03 only, under the **Secrets** tab create the repository secret:

```text
Name: LAB_SECRET
Value: TRAINING_ONLY_NOT_A_REAL_CREDENTIAL
```

Do not create a real token or attach any other secret. The exercise confirms that
the dummy value is available without logging its value.

## Workflow policies and expected skips

- Lab 01 runs on a push to `main` or via **Actions > Lab 01 > Run workflow**.
- Lab 02 and Lab 03 intentionally use `pull_request_target`. Their workflow
  definition comes from the base repository, not from the fork's changed YAML.
- Only PR events initiated by `LAB_ATTACKER` match the opt-in check. Alice editing
  Bob's PR title can cause a skipped run; have Bob create/edit it instead.
- Prefix titles with `lab-02:` or `lab-03:` to select the exercise.
- Lab 03 requires a fork PR, not a branch PR within Alice's repository.
- Ordinary fork `pull_request` runs may require approval. Do not assume those
  approval settings protect `pull_request_target` execution.
- Applicable GitHub Actions policies can block `pull_request_target`. If blocked,
  stop and ask the instructor to review the approved lab environment. Do not
  bypass a policy or change organization-wide protections.

GitHub's documentation currently describes a default public-repository policy in
evaluate mode, with enforcement scheduled for November 2, 2026 for affected
repositories. Check the linked documentation before each workshop. New checkout
versions also add fork-head protections. Lab 03 deliberately uses a historical
checkout pin to illustrate the legacy vulnerability, not a production recommendation.

## Cleanup

After each exercise, set its enable variable to `false`, close the lab PR and
cancel any running job. Afterwards remove `LAB_SECRET` and `LAB_ATTACKER`, disable
the vulnerable workflows in the Actions UI, and archive or delete the disposable
copies. A job already running is not stopped merely by changing a variable.

## References

- [GitHub: securely using pull_request_target](https://docs.github.com/en/actions/reference/security/securely-using-pull_request_target)
- [GitHub: creating a repository from a template](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template)
- [GitHub: approving workflow runs from forks](https://docs.github.com/en/actions/how-tos/manage-workflow-runs/approve-runs-from-forks)

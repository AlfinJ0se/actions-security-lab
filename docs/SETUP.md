# Participant setup

## Fork the lab repository

1. Fork `actions-security-playground/actions-security-lab` into your GitHub account.
2. Clone your fork:

   ```bash
   git clone https://github.com/YOUR_USERNAME/actions-security-lab.git
   cd actions-security-lab
   ```

3. Create exercise branches in your fork.
4. Open PRs with the base set to
   `actions-security-playground/actions-security-lab:main`.

Participants do not need organization membership or collaborator access.
There are no enable variables, username checks or required title prefixes.

## Prerequisites

- A GitHub account, Git and a terminal, or the GitHub browser editor.
- Python 3 if you want to run the tests locally.
- GitHub-hosted Ubuntu runners for the remote exercises.

No package installation, PAT, cloud account or self-hosted runner is needed.

## Instructor: add the dummy secret for Lab 03

In the base repository, open **Settings > Secrets and variables > Actions >
Secrets > New repository secret**:

```text
Name: LAB_SECRET
Value: TRAINING_ONLY_NOT_A_REAL_CREDENTIAL
```

Never use a real credential. No secret is needed for Lab 02. Lab 03 still runs
without this secret, but its demonstration prints `NO_LAB_SECRET` instead of
confirming access.

Both vulnerable workflows can run for the same PR. The guide's title prefixes
are just labels for organizing exercises, not filters.

## Lab 01

View the existing run under **Actions > Lab 01 - Pipeline basics**.
For your own run, enable Actions in your fork if required, then use **Run
workflow** or push a change to `main` in your fork. This workflow does not run
on PR events.

## Optional isolated setup

Instead of using the shared base repository, work in pairs with a fresh
standalone copy. Alice creates an empty public repository, then pushes a clone
of the starter repository to it:

```bash
git clone https://github.com/actions-security-playground/actions-security-lab.git
cd actions-security-lab
git remote rename origin instructor
git remote add origin https://github.com/ALICE/actions-security-lab-alice.git
git push -u origin main
```

Bob forks Alice's copy and opens PRs to it. Alice adds the dummy secret in her
base repository. The same workflows work without additional configuration
variables.

## GitHub protections

Applicable Actions policies can block `pull_request_target`. If blocked, record
the outcome and ask the instructor to review the approved environment; do not
bypass protected policies or weaken organization-wide settings.

Lab 03 uses a historical checkout version for the legacy example. Newer checkout
releases add fork-PR protections. GitHub's current documentation also describes
a default public-repository event policy in evaluate mode, with enforcement
scheduled for November 2, 2026 for affected repositories. Review the official
documentation before each workshop.

## Cleanup

Disable Labs 02 and 03 in the Actions UI, cancel running jobs, close the exercise
PRs and remove `LAB_SECRET`. Archive or delete disposable copies when finished.
No `LAB02_ENABLED`, `LAB03_ENABLED` or `LAB_ATTACKER` variables are used.

## References

- [GitHub: securely using pull_request_target](https://docs.github.com/en/actions/reference/security/securely-using-pull_request_target)
- [GitHub: approving workflow runs from forks](https://docs.github.com/en/actions/how-tos/manage-workflow-runs/approve-runs-from-forks)

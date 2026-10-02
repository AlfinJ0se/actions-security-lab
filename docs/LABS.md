# First three hands-on labs

Complete [setup](SETUP.md) first. Run only against your disposable lab copies.
Fixed workflows are intentionally not supplied: explain the remediation during
the workshop, and let participants implement it themselves if time permits.

## Lab 01: Understand a pipeline (15 minutes)

1. Alice pushes the starter repository to `main`.
2. Open **Actions > Lab 01 - Pipeline basics** and inspect the run.
3. Identify the trigger, the two jobs, the `needs` dependency, runner type, checkout
   action, and commands in each step.
4. Verify that all three unit tests pass.
5. Make a small change to `app/calculator.py` on `main` in this disposable copy and
   observe another run. For example, change addition to subtraction, inspect the
   failed tests, then restore addition with another commit.
6. Trigger the workflow manually and compare the logged event name with the push run.

Success: participants can explain why `test` waits for `inspect`, and distinguish
an action (`uses`) from a shell command (`run`).

## Lab 02: PR-title script injection (25 minutes)

Alice sets `LAB02_ENABLED=true` and `LAB_ATTACKER` to Bob's username. Keep Lab 03
disabled for this exercise.

1. Bob creates a branch in Bob's fork and makes a harmless README change.
2. Bob opens a PR to Alice's base repository titled `lab-02: hello`.
3. Inspect **Lab 02 - Script injection (VULNERABLE)**. It should log the title.
4. Bob edits that PR's title to the following harmless proof of execution:

   ```text
   lab-02: hello"; echo LAB_PWNED; #
   ```

5. Inspect the new run's **Print PR title** step. Find a standalone `LAB_PWNED`
   output line. The payload can also appear in GitHub's displayed script, so the
   displayed command alone is not proof of execution.
6. Open `.github/workflows/02-script-injection-vulnerable.yml` on Alice's default
   branch. Identify how GitHub substitutes the PR title into the shell source
   before Bash executes it. No repository code checkout is needed for this flaw.
7. Discuss how to keep external input as data rather than shell source. Do not
   change the trigger alone and assume interpolation is safe.

Success: Bob makes an extra command execute by changing metadata, without changing
the base workflow. Do not run destructive commands, network requests, or secret reads.

Cleanup: Alice sets `LAB02_ENABLED=false` and closes the PR.

## Lab 03: Pwn request (30 minutes)

Alice sets `LAB03_ENABLED=true`, confirms `LAB_ATTACKER` is Bob, and adds only the
dummy `LAB_SECRET` described in setup. Keep Lab 02 disabled.

1. Bob creates a fresh branch from the starter version in Bob's fork.
2. Change **only** `scripts/lab-test.sh`, adding the following before the test command:

   ```bash
   if [ -n "${LAB_SECRET:-}" ]; then
     printf '%s\n' 'LAB_SECRET_ACCESS_CONFIRMED'
   else
     printf '%s\n' 'NO_LAB_SECRET'
   fi
   ```

3. Commit the script change and open a fork PR to Alice titled
   `lab-03: demonstrate the trust boundary`.
4. Inspect **Lab 03 - Pwn request (VULNERABLE)**. The final step should emit
   `LAB_SECRET_ACCESS_CONFIRMED`, followed by passing unit tests. The dummy secret's
   value must never be printed.
5. Explain the chain: base-branch workflow uses `pull_request_target`, overrides
   checkout to the fork's head SHA, then executes the PR-controlled test script
   in a step with access to a base-repository secret.
6. Confirm Bob did not need to change the base workflow. Changing only the YAML
   in Bob's PR would not redefine this `pull_request_target` run.
7. Run the modified script locally without a secret and observe `NO_LAB_SECRET`.
   This is a control showing that the script checks availability; the remote
   evidence comes from Alice supplying the dummy secret only to the vulnerable step.
8. Discuss separating untrusted testing from secret-bearing jobs. This lab grants
   only `contents: read`; a write-capable token is not required to demonstrate
   the secret exposure, and root access is not required either.

Success: participants identify both the unsafe checkout and subsequent execution.
Checkout by itself is not the full exploit. This is a dummy-secret availability
demonstration, not real credential exfiltration or proof of write permissions.

If GitHub policy blocks the event, record that outcome and discuss the policy.
Do not disable protected workflows or weaken organization policy to force a run.

Cleanup: set `LAB03_ENABLED=false`, close the PR, cancel remaining runs, and remove
the dummy secret. Follow the full cleanup checklist in [setup](SETUP.md).

## Common problems

| Symptom | Check |
| --- | --- |
| Vulnerable job is skipped | Repository owner, exact enable value `true`, `LAB_ATTACKER`, event actor, title prefix |
| Lab 03 is skipped | Bob's PR must originate from a fork |
| Dummy-secret check fails | `LAB_SECRET` must exist in Alice's base repository, not Bob's fork |
| Workflow blocked before any steps | Applicable Actions event policy or Actions permissions; ask the instructor |
| No standalone marker after editing title | Bob must perform the edit; inspect the new run rather than the old one |
| Lab 01 tests fail unexpectedly | Restore `add()` and inspect the changed test script |

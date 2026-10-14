> Exported 2026-10-14 from the artifact https://claude.ai/artifact/ReUgiwzUWNpCEbMw8cPqVU (version 97, private), converted from HTML to Markdown with pandoc.
> It is the delivery automation's plan of record. Files it names (`NEXT.md`, `02-build-tasks.md`, `phase-*-done.md`, gap and decision numbers) live in a local, untracked folder of another repository and are not in this one. The status pills and layout of the original page are lost in the conversion.

Delivery automation · plan of record

# Remaining Build Work

21 of the plan's 254 tasks are still open. Six of them are nice to have: a second platform, Phase 12, and Phase 23 / Task 2. Complete phases are counted but not listed. Phases 32, 36, 37, 41 and 42 are planned but not in the task list yet, so they are listed and not counted.

233 / 254 done · 91.7% · 21 open · 15 required · 6 nice to have

## Changed since the last status (2026-10-02)

**2026-10-14, Phase 51 / Task 2 is ready to run: two prompts are in `NEXT.md`.** Pin `v0.2.4` is merged (PR \#257) and local `main` is on `f8a3f9d`; plugins PR \#9 (G196) is merged too (`016ca17`). Prompt 1 (steps 1 and 2 of `plugins/getting-started.md` at `v0.2.4`, in a fresh clone of `eds-agentic-demo`) and prompt 2 (a second session that only verifies: six plugins at `0.2.4`, six registry files, `resolve-plugin-root.sh --list` six lines). Branch `docs-guide-prompt` (`c53f957`, no PR) adds a generic "Letting Claude follow this guide" prompt to the guide; it is not in the tag being tested. Not run: either prompt. Phase 51 is not counted here, so no total changes.

**2026-10-14, Phase 51 / Task 1 done: the new project exists.** `agenticdraft-org/eds-agentic-demo`, template `adobe/aem-boilerplate`; `git ls-files .claude .ai plugins | wc -l` → 0, 45 tracked files, `blocks/`, `scripts/`, `styles/`, `AGENTS.md`, `CLAUDE.md` present. The first repository handed over was empty (2 files, no template) and was recreated at your request. Not checked: AEM Code Sync on it, the tracker project. Phase 51 is not counted here, so no total changes. **Next:** Phase 51 / Task 2 after your merges, tag `v0.2.4` and the pin move. Record: `phase-51-task-1-done.md`.

**2026-10-14 (later still): the guide and a project README are written for `agenticDraft/plugins` (phase number provisional, not in the task list).** Branch `docs-guide-readme` (`7205f78`, pushed, no PR): new `plugins/README.md` (the whole project) and `plugins/getting-started.md`; the root README is shortened; the six `agentic-*` READMEs linked to a gitignored guide (404) and now link to it, so those plugins and the catalog go `0.2.3` → `0.2.4`. Outside the sandbox: version check ok, `claude plugin validate .` passed, no-narrative valid, links resolve, `run-tests.sh` `files=141 fail=0`. **Yours, in order:** merge the G196 PR and this one, push tag `v0.2.4` yourself (G194), move the pin, restart. The guide has not been followed from nothing yet; that is Phase 51 / Task 2. No total changes.

**2026-10-14 (later): G196 built; Phase 50 / Task 3 superseded, the live proof moves to a new project (Phase 51).** `scripts/run-tests.sh` in `agenticDraft/plugins` now prints `files=<n> fail=<n> skipped=<n>`; new `run-tests.test.sh` seen failing first, then 7/0. Outside the sandbox: source clone `files=142 fail=0 skipped=0`; the six installed `0.2.3` copies `files=585 fail=0 skipped=72`. Branch `phase-50-task-2-skips` (`8bd99d1`) is pushed; the PR is yours. **Your decision:** Phase 50 / Task 3 is not run in this repository; Phase 51 / Task 1 now depends on Phase 50 / Task 2. **Not decided:** whether Phase 20 / Task 5 and Phase 23 / Task 4 close on Phase 51 / Task 4's run. **Next:** you create the new repository (Phase 51 / Task 1). No total changes.

**2026-10-14, Phase 50 / Task 2 follow-up: the suites now pass from the real installed copies (G193 FIXED).** Plugins PR \#7 merged (`origin/main` `9569aca`), tag `v0.2.3`; pin PR \#256 merged (`6b5f2f5`); session-start pin check → `pin is current`. `claude plugin list --json` → six `agentic-*@agenticdraft` at `0.2.3`, five `core/` folders real. `scripts/run-tests.sh ~/.claude/plugins/cache/agenticdraft/*/0.2.3` outside the sandbox → **`files=585 fail=0`**, no `::error` line; the source clone, default dirs → **`files=141 fail=0`**. The installed log holds 54 `skipped:` lines. Filed, all open: **G194** (the branch-name hook reads a pushed tag as a branch name), **G195** (the pin script fails only after the user-level pin blocks it), **G196** (skips count as passes; your decision: count them separately, not built). **Yours:** which count Task 2 expects (131 in the plan is stale), whether G196 is built before Phase 50 / Task 3. Phase 50 is not counted here, so no total changes. Nothing to commit (`docs/` and this page are gitignored). Record: `phase-50-task-2-followup-done.md`.

**2026-10-14, Phase 50 / Task 2 ran (earlier result, superseded by the follow-up above): the branch-name hook passes, the installed-copy test run does not match the plan.** Checks only, no plugin changed; branch `phase-50-task-2-tests` from `origin/main` `48b5aef`. `scripts/run-tests.sh` over the six `~/.claude/plugins/cache/agenticdraft/*/0.2.2` folders → outside the sandbox `files=585 fail=64`; the plan says 131 and `fail=0`. Inside the sandbox it printed `fail=277`, false failures (one suite passes outside). 445 of the 585 files are the five packs' `core/` copies of the core's tests. The source clone `agenticDraft/plugins` `1a7cc16` gives `files=141 fail=1` (`resolve-plugin-root.test.sh` wants a `$TMPDIR` under `/private/tmp`). I did not open each of the 64 failures; they look like suites that assume several packs side by side. `git switch --no-track -c Bad_Name` → blocked by the installed `agentic-core/0.2.2` hook (`bad-chars`), no branch created. **Yours:** which count Task 2 expects, and whether the layout-dependent suites are fixed in `agenticDraft/plugins` before Phase 50 / Task 3. Phase 50 is not counted here, so no total changes. Nothing to commit (`docs/` and this page are gitignored). Record: `phase-50-task-2-done.md`.

**2026-10-14, Phase 50 / Task 1 is done, with one deviation: the installed copy is the one expected, but the registry holds five stale files.** Checks only, no plugin changed; branch `phase-50-task-1-copy` from `origin/main` `48b5aef` (PR \#255 is merged). `claude plugin list --json` → six `agentic-*@agenticdraft` at `0.2.2`, each `installPath` under `cache/agenticdraft/`, no `@aem-eds-ai-workflow-demo` entry; `core/` is a real folder (35 entries) in all five packs; no `--plugin-dir`, `CLAUDE_CODE_PLUGIN_DIRS` or `ROUTE_PLUGIN_DIR` is active. **Deviation:** `.ai/run-context/plugin-roots/` has 11 files, not six: the six `agentic-*` paths exist, five older ones (`eds`, `figma`, `github`, `jira`, `playwright`, 2026-10-13) name the deleted `plugins/` and are missing. Not fixed. Also: `0.2.0` and `0.2.1` remain in the cache; the plan text still says `0.2.0`. Phase 50 is not counted here, so no total changes. Nothing to commit: the record and this page are gitignored. **Next:** Phase 50 / Task 2. Record: `phase-50-task-1-done.md`.

**2026-10-13, Phase 49 is done: the old plugin copy and the old marketplace are gone, and the plugin freeze (D128) is over.** Task 2 closed formally (G190 CLOSED, G191 FIXED; run 38419659429). Task 3: the split-to-delete log was empty, then, with your yes, `plugins/` (868 tracked files) and `.claude-plugin/marketplace.json` were deleted, the three `validate-*.yaml` workflows removed and the references cleaned; `git ls-files plugins | wc -l` → 0, the pin test `fail=0`, `update-plugin-pin.sh --check` → `pin is current`. Task 4: `claude plugin marketplace remove aem-eds-ai-workflow-demo` failed in the sandbox (EPERM) and succeeded outside it; `claude plugin list --json` has no `@aem-eds-ai-workflow-demo` entry and the six `@agenticdraft` packs are `0.2.2`. **From now on plugins change only in `agenticDraft/plugins`.** New **G192** (open): two checks that read this repository's files lost their CI caller, and the plugins repository has no `docs/getting-started.md`. Phases 46–51 are not counted here, so no total changes. **Next:** Phase 50 / Task 1. Records: `phase-49-task-3-done.md`, `phase-49-task-4-done.md`. Branch `phase-49-task-3-remove`, pushed with Tasks 3 and 4; the PR is yours to open.

**2026-10-13, headless: the first CI run from `v0.2.1` got past pre-flight and stopped on the tree check (G191).** Run \#33 (`route EDS-28 c2801`, `main` `0d215c9`): `_plugins` checkout `ref: v0.2.1`, `loaded plugins:` names the six `agentic-*` packs, the driver ran `check-preflight.sh` and went on; `check-tree-clean.sh` then refused 16 paths (`.bashrc`, `.gitconfig`, `.claude/hooks`, …). Hypothesis, untested: the runner's Linux sandbox creates placeholder files for write-protected paths in the checkout. The run uploaded no artifact, so the root and the full list are unknown; `phase-49-task-2-diag` adds a failure-only step that records them. Plan: merge it, re-dispatch, read `diagnostics.txt`, fix where the cause is. **Phase 51 / Task 3** now carries an open question, nothing built: where a new project's CI workflow comes from (a thin caller of a reusable workflow, a generated copy, or printed for the human). G190 and G191 first.

**2026-10-13, Phase 49 / Task 2, Defect 5 closed locally; pin script added (G190).** `agenticDraft/plugins` tag `v0.2.1` fixes the pack validator: `validate-pack-manifest.sh` over `agentic-eds/0.2.1/pack.yaml` → `valid: platform`. `.claude/scripts/update-plugin-pin.sh` moves the pin (test `fail=0`). Measured: `marketplace update` does not move the ref, `~/.claude/settings.json` holds a third pin, and `marketplace add <repo>#<tag> --scope project` does. Not run: a CI route run from `v0.2.1`. No task totals change. Branch `phase-49-task-2-pin`; restart after merge to load 0.2.1.

**2026-10-12, Phase 53 is closed: live step 2 passed, so all three live steps passed.** From a new session on `main` `382e8fe`, Figma plugin enabled, `/agentic-core:run-route EDS-26` printed `ok: mcp__plugin_figma_figma__get_design_context`, `…get_metadata`, `…get_variable_defs`, `…get_screenshot`, then `Stage 1/14: intake — pass` and `Stage 2/14: readiness — pass · Work item is ready to be worked.` The run was stopped there on purpose: no `create_branch`, no `check_status`, no note on EDS-26; `eds-26` unchanged at `c79827b`. Seen in that driver: it first passed 15 as the stage total instead of reading 14 from the progress line, and corrected it before any later read (model behaviour, not a script). Open, not scheduled: G185–G189. Phase 53 is not in `02-build-tasks.md`, so no total changes. **Next:** Phase 48 / Task 1.

**2026-10-12, Phase 53 / Task 7, live half: steps 1 and 3 passed; step 2 waits on a session with the Figma plugin enabled.** Run from `main` `382e8fe` (PR \#247 is on `main` as a squash commit), plugin disabled, stamp `a969a7d9ff02`. Quoted from the run:

- **Step 1, EDS-26 → `terminal: blocked`.** `check-session-tools.sh --found` printed four `missing: mcp__plugin_figma_figma__… — Plugin disabled: run /plugin, enable figma, restart the session. Enabled but not authenticated: run /mcp, …` lines and `4 of 4 declared session tools are missing`; the terminal line was `recorded: nowhere — refused before the run began`. After: branch `main`, `eds-26` unchanged (it already existed), no `run-state.json`, no marker.
- **Step 3, EDS-22** (Bug, no Figma link, no attachment, no design words; read live) → not blocked: `skipped: extract — design_source=true OR design_mentioned=true`, the session-tools check printed `none declared`, `run-state.json` written at `Stage 1/11: intake — pass`. I stopped it there, before `readiness`: no branch, no tracker note.
- **My prompt's mistakes, no gap:** the line is `recorded:`, not `recorded at:` (`resolve-terminal-state.sh:59`); "no `eds-26*` branch" cannot be shown while `eds-26` exists.
- **New G189:** `check-status-claims.mjs` finds a merged PR only by a `Merge pull request #N from` commit, so a squash-merged PR (#247) cannot carry `status=merged` and the stale `unmerged` marker passes (60 claims, all match). Not fixed; `NEXT.md` keeps the marker and says the real state beside it.
- **Still to do:** step 2 in a new session (plugin enabled → four `ok:` lines, `readiness`, Esc at once because EDS-26 is delivered). No PR is left to open for the stack: \#247 merged it.

**2026-10-12, spec 34 built as Phase 53 (your written exception to the plugin freeze, D128): Tasks 1–6 done, Task 7's scripted half done, the live half waits on a fresh session.** Stacked branches, pushed, no PR: `phase-53-task-1` `2299575` → `-task-2` `d3ba5ab` → `-task-3` `2228944` → `-task-4` `513d839` → `-task-5` `b98f1c0`. Tasks 6 and 7 touched only local docs. What it does:

- a provider pack may declare `session_tools:` (exact tool name, quoted remedy; validator 24);
- `check-session-tools.sh` lists the names to ask for and decides ok or missing from the names the driver found;
- the driver, after `intake` and the stage conditions and before any run state, marker or branch, asks the session's registry once (`ToolSearch`) for the packs this run will use (design only when `extract` runs) and ends `blocked` with the pack's remedy; run-route stamp `a969a7d9ff02`;
- `health` lists the declared names, never looks them up; the figma pack declares its four data tools.

**D130** narrows "pre-flight never probes" (pre-flight is unchanged and still prints `design: ok`); **G179 closed**; Phase 52 / Task 5 superseded; new **G185** (an unauthenticated plugin may still list its tools; not measured), **G186** (contract lists four tracker operations, validator six), **G187** (§13 has no validator 23), **G188** (`fetch-reference` says `/plugin` for sign-in; the docs say `/mcp`, which the figma remedy now uses, your choice). Results: 132 shell suites, 3868 + 36 assertions, 0 failed (`operation-guard` needs local port binding, run outside the sandbox); 8 runner suites 73/0; naming, no-narrative, exec bits valid; `claude plugin validate` passed on agentic-core and figma; five packs valid, a no-remedy entry refused. Phase 53 is not in `02-build-tasks.md`, so no total changes. **Next:** restart the driving session and run the three live steps in `NEXT.md`, then your PR.

**2026-10-12, later the same day: EDS-26 `delivered`, PR \#246 merged, `aem-psi-check` passed (merge and check as you reported them; not read from GitHub by me).** Three runs, three different failures, which is the context the specs below rest on:

- **Run 1 failed at `plan-gate` (criterion 4).** The old ticket compared sizes "against the three design captures"; `extract` reads one reference, so two of them were never fetched. Cause: the ticket. Specs 32 and 33.
- **Run 2 failed at `prototype` (`size-origin`).** The Figma plugin was disabled in the session, so the reference was image-only and no fixed size could be tied to a design value. Nothing said so before work began; pre-flight had printed `design: ok` because it reads declarations only. Cause: the environment. Spec 34.
- **Run 3 delivered, with warnings** (`verify-design`, `plan-gate`, `verify`, `deliver` all `warn`) after the plugin was connected. The rewritten ticket carried measured numbers. `plan-gate` found that two 150 px cells with a 40 px gap need 340 px against 327 px of content at 375, and `implement` solved it with `margin-inline: -24px` below 900 px, a hand-copied value of the 24 px gutter in `styles/styles.css`. Layout was judged by inspection, not measured, so the numeric criteria are unproven by measurement.

**What changed in my reading of the plan.** My prediction that `size-origin` would refuse 150 × 82 was wrong: it tied to the sixth desktop node, which happens to be 150 × 81.8 (the other five are 154 × 84; the design disagrees with itself). That was luck, not proof. **Spec 34 stays first**: run 2 was the environment, and a delivered run 3 says nothing about the missing guard. **Spec 33 weakens**: the run delivered without tablet or mobile references because the criteria carried numbers; if anything is built for measured checks at 768 and 375, Phase 32 is the better candidate. **Spec 32 is lower**. All three wait for the plugin freeze (D128). Open for you: 154 × 84 instead of 150 × 82, and whether the design's `opacity-60` and `mix-blend-exclusion` on the logos enter scope (the ticket still says they are out; its claim that the exported images are already grey was carried over, not checked).

**2026-10-12, two specs proposed from the EDS-26 failure; nothing built, no task changed, no count changed.** `/agentic-core:run-route EDS-26` ended `failed` at `plan-gate`, criterion 4: the plan's verification compared cell sizes at 720 and 375 wide "against the three design captures", and only the desktop capture was fetched. Read from the code, not run:

- **`extract` reads one reference.** `resolve-design-source.py` takes the first Figma link and, as fallback, one image named `design-reference.png|jpg|jpeg`. The item's tablet and mobile links and its `design-reference-tablet.png` / `-mobile.png` were ignored on purpose, and nothing said so.
- **`write-specs` passed that item** (0 violations): its checker proves the detectors can read the item, not that the evidence a criterion names is reachable by the stages.
- **A second, separate cause:** a run resumed from `plan` after the ticket was fixed reused the old plan and the old ticket text. Resume does not re-read the item. Not specced; the workaround is "start fresh".
- **The ticket itself was rewritten** through `write-specs` (live check `valid`, 16 criteria): sizes and spacings measured on the Figma nodes (cell 150 × 82, gaps 40 / 20, logo 110 × 42), so no criterion needs a capture. The previous description is saved in `.ai/tracker/update-item-EDS-26-previous.json`; the draft is committed on `eds-26` (`39a7062`).

**The two proposed specs** (local files, not committed; see the section after Phase 32): `32-unread-design-references-spec.md` makes the `write-specs` checker report what `extract` will not read, by asking the resolver itself; `33-extract-multi-viewport-spec.md` makes `extract` read one link per width. **Spec 33 overlaps the pending Phase 32**, which finds the tablet and mobile counterparts from the one linked node by name path and needs no extra links; decide between them before filing either. **Your decision:** test this on a new ticket first; it may be built later. `NEXT.md` was read and not edited; it names Phases 32, 36 and 37 as proposed and lists neither spec. Unverified: that `fetch_reference` always returns a width per link (spec 33), and that `write-specs` may depend on a script inside the eds pack (D85 says it already runs the pack's extractor, so probably).

**2026-10-10, research only, nothing built, no task changed: does `/install-github-app` fit the headless plan?** Read against `route-trigger.yaml`, `route-agent.mjs`, `.ai/route-policy.yaml` and the official docs (`code.claude.com/docs/en/github-actions`, `claude-code-action` `usage.md`). The command installs the Claude GitHub App, saves `CLAUDE_CODE_OAUTH_TOKEN` (or `ANTHROPIC_API_KEY`) as a secret, and opens a PR with up to two workflows: `claude.yml` (`@claude` in comments) and `claude-code-review.yml` (review on every PR). Findings:

- **Today's verification has no step after `deliver`.** In the route: `verify` (Playwright), `lint`, `plan-gate`, `publish-gate`. On GitHub: `main.yaml` (lint) and three `validate-*` workflows (plugin tests, path-filtered). Nobody reviews the PR the route opens; `deliver` only reads its CI. A review workflow fills that gap; nothing in the repo duplicates it.
- **The action overlaps the headless runner only in part.** It already offers a prompt, `repository_dispatch`, plugins, `settings`, `--allowedTools`, `--max-turns` and the same OAuth secret. The docs list no network allowlist or sandbox, no equivalent of the route policy's forbidden `git push` shapes, no per-run budget and no "judge by terminal state" check. Not found in the docs is not the same as absent; unmeasured.
- **The gates before the session are not Claude's to replace.** Shape, identity, duplicate, run limits and the claim stay in `route-trigger.yaml` either way. At most the action replaces the one *Run* step.
- **The `@claude` workflow bypasses all of that.** A comment on an issue or PR would start a session that can push, outside the policy, the identity list, the claim and the network lock. The repository is public, and a comment has not passed `external-content-safety`. The action checks that the commenter has write access.
- **Unchecked:** whether `check_status` treats a running or commenting review workflow as pending; whether the installer would overwrite the existing `CLAUDE_CODE_OAUTH_TOKEN`; both would draw on the same plan limit as route runs. Not measured; `gh` failed on TLS in the sandbox, so the secrets list was not read.

**Recommendation.** (1) Install the review workflow only, with a manual setup that keeps the existing secret. (2) Do not install `@claude`. (3) Do not replace the runner now. In Phase 49 / Task 2, which rewrites `route-trigger.yaml` anyway, run one item through `route-agent.mjs` and once through the action, and compare four things: the locked allowlist, the forbidden rules, the budget cap and the terminal-state verdict; decide from those numbers. **Your decision 2026-10-10: nothing installed for now.** Nothing was written to the repository.

**2026-10-09, Phase 51 added (your decision):** a new repository you create installs the plugins by the user guide alone, runs `setup` from nothing and makes its first route run — four tasks after Phase 50, no plugin change. Phase 50 stays the migration's last proof; Phases 46–51 are not counted here, so no total changes.

**2026-10-10, Phase 47 / Task 9 done: `write-specs` finds every plugin through the core's resolver.** Branch `phase-47-task-9`, cut from Task 8 (`d5e7eca`), committed as `0a0c139` and pushed; Tasks 1–9 are stacked on it, none is on `main`, no PR. What it changes:

- `check-spec.py` and `write-item.py` no longer build `plugins/…` paths; every root, the core's included, comes from `resolve-plugin-root.sh`, asked with the main checkout;
- **your decision, the registry bootstrap:** a project skill has no plugin root and no `core` link, so it reads only the core's own registry entry to find the resolver. Contract §11.2's "Reader" rule names this one exception;
- a missing or stale entry stops the script with exit 2 and the resolver's own reason.

Results: all 13 drafts give byte-identical output before and after; 7 new cases seen failing first (22/0); **130/130 suites**, the runner's tests `fail 0` (73); `plugins/` untouched. Found: the brief's own "no `plugins/` literal" grep would have passed the old code (`os.path.join("plugins", …)` has no slash). `SKILL.md:280` still names a `plugins/` path; it was added to Phase 49 / Task 3. **Next:** Phase 47 / Task 10 (verification), which needs Tasks 1–9 merged first. Record: `phase-47-task-9-done.md`.

**2026-10-09, Phase 47 / Task 8 done: the playwright pack declares its own dependency.** Branch `phase-47-task-8`, cut from Task 7 (`3967396`). Tasks 1–8 are stacked and committed (Task 8 is `d5e7eca`); none is on `main`. What it changes:

- `package.json` and a lockfile at the pack root pin `playwright` 1.63.0, the version this repo uses, so the host installs it into the installed copy; the lockfile was copied from this repo's own, no npm command run;
- the remedies: playwright names that host install (and `npm ci` for a pack loaded by path); chromium is `npx playwright@1.63.0 install chromium`, the same version;
- a new test holds the declaration to the host's install rules and checks that no pack script installs anything.

Results: the new test seen failing first (4/7 → 11/0), six mutations caught; **130/130 suites**, the runner's tests `fail 0` (73). **Your decision:** pinned remedies, no global install; the code's global fallback stays, filed as G176. **Next:** Phase 47 / Task 9 (consumers outside `plugins/` use the resolver). Record: `phase-47-task-8-done.md`.

**2026-10-09, Phase 47 / Task 7 done: this repo's own values left the eds pack.** Branch `phase-47-task-7`, cut from Task 6 (`b11c0a5`, committed this session with your yes). Tasks 1–7 are stacked and none is on `main`; Task 7 is not committed. What it changes:

- the branch limit is the project's: `branch_name.max_length` in `.ai/project-config.yaml`, read by the core's branch check and its hook; a pack's manifest may no longer declare it (D129);
- the preview host suffix sits in a new `platform:` block of the config, which the core never reads;
- both eds scripts refuse (exit 4, `not-configured`) when their value is missing — no fallback to this repo's values;
- the four eds tests that read this repo now run on their own fixtures, and pass from a copy of the plugins outside it.

Results: every new test seen failing first; **129/129 suites**, the runner's tests `fail 0` (73); naming, no-narrative and own-root checks `valid`. Nine defects; `setup` does not yet write the two keys (noted on Phase 51 / Task 3). **Your decisions:** commit Task 6 first; the config shape; missing value → core unconstrained, eds refuses. **Next:** Phase 47 / Task 8 (the playwright pack declares its own dependency). Record: `phase-47-task-7-done.md`.

**2026-10-09, Phase 47 / Task 6 done: no executed file assumes the plugins sit in a `plugins/` folder.** Branch `phase-47-task-6`, cut from Task 5 (`a95a653`, committed this session with your yes), not committed. Tasks 1–6 are stacked and none is on `main`. What it changes:

- the driver's read hook allows the contracts of **its own plugin root**, wherever that is — an installed copy lives outside the project, where the old fixed path would have denied every contract read;
- the direct-call check also recognises an installed copy's script path (G173 fixed) — before, it said "ok" for any call through the cache;
- the runner has no default plugin folder: unset is a new exit 7, nothing started. The CI workflow now sets `ROUTE_PLUGIN_DIR: plugins` until Phase 49 / Task 2 changes it;
- one more pack → pack path Task 5 missed (the jira converter's test) now goes through the resolver.

Results: every new test seen failing first; **129/129 suites** and the runner's tests `fail 0` (73); naming, no-narrative and own-root checks `valid`. Ten defects, one my own (an assertion that read the echoed command). **Your decisions:** commit Task 5 first; exit 7; the workflow line; the jira test here. **Next:** Phase 47 / Task 7 (this repo's own values leave the eds pack). Record: `phase-47-task-6-done.md`.

**2026-10-09, Phase 47 / Task 5 done: every plugin finds another plugin through the resolver.** Branch `phase-47-task-5`, cut from Task 4 (`876e9c7`), committed as `a95a653` in the Task 6 session. Tasks 1–5 are stacked and none is on `main`. What it changes:

- the driver, `setup`, `health` and nine eds stages ask `resolve-plugin-root.sh` for a pack's root and stop when it is not resolved — no more `${CLAUDE_PLUGIN_ROOT}/../<pack>`; `setup` lists every registered plugin with a new `--list`;
- the branch check answers `not-resolved` (exit 4) where a missing pack used to mean "any name is fine" (G172 fixed). Its hook only blocked two exit codes, so it would have let that through; now it blocks it too, and reads the main checkout's registry, so a linked worktree is judged by the same rule;
- a new check, `check-own-root-refs.sh`, fails when a plugin reaches its own files through `..` and its own name — it found four such lines in the core's test fixtures on its first run;
- the core's real-tree tests no longer climb to the plugins folder: they register the source tree into a temp project, the way a session's hooks would, and read the registry.

Results: the brief's grep → nothing; **129/129 suites under `plugins/` exit 0**; naming and no-narrative `valid`; `claude plugin validate` ×6 passed; run-route's stamp regenerated. Sixteen defects, three my own, none wrote a wrong file. New gap G175 (the no-narrative check misses a done-file citation). **Your decisions:** `--list` for `setup`; no config still means no constraint; old-form test inputs built at run time; the real-tree tests moved here, onto a temp registry. **Next:** Phase 47 / Task 6 (no hard-coded `plugins/` path in executed code). Record: `phase-47-task-5-done.md`.

**2026-10-09, Phase 47 / Task 4 done: the eds pack reaches its own files without `../eds/`.** Branch `phase-47-task-4`, committed as `876e9c7` with your yes (not pushed), cut from Task 3 (`93b6e2b`). Tasks 1–4 are stacked and none is on `main`. What it changes:

- every `${CLAUDE_PLUGIN_ROOT}/../eds/` became `${CLAUDE_PLUGIN_ROOT}/`: **28 lines in 6 files, 10 scripts**, each checked to exist before anything was written; the diff is that substring and nothing else;
- in a simulated installed copy, the new paths resolve 13 of 13 and the old ones 0 of 13. Every one of the 28 lines would have failed after a real install.

Results: **128/128 suites under `plugins/` exit 0** (eds 33); naming and no-narrative checks `valid`; `claude plugin validate plugins/eds` passed. Nine defects, two of them my own (a shell loop whose check passed on an empty list; `mapfile` on bash 3.2), and neither wrote anything. No test reads these lines, so the live check stays with Task 10. **Your decision:** contract §11.2 will forbid a pack reaching itself through `..`, with a check, in Task 5. **Next:** Phase 47 / Task 5 (core → pack and pack → pack through the resolver). Record: `phase-47-task-4-done.md`.

**2026-10-08, Phase 47 / Task 3 done: each pack reaches the core through its own `core` link.** Branch `phase-47-task-3`, not committed. It is cut from `81a141d`, which is Task 2 committed with your yes on top of Task 1 (`414ce1c`). None of the three is on `main`. What it adds:

- `core → ../agentic-core/shared` at the root of each of the five packs;
- `rewrite-core-refs.sh`, tests first. It found seven reference forms, where the brief named two, and writes nothing if any new path is missing. Its own counts: **44 files, 282 lines** (json 5, md 266, sh 10, txt 1);
- the five pack hooks now reach the registry writer through `core/lib/`, so an installed pack registers. That was simulated with a dereferenced copy, not with a real install.

Results: **128/128 suites under `plugins/` exit 0**. Six hooks simulated: six registry entries, each resolved. Six `validate` passes with 0 warnings; naming and no-narrative checks `valid`. Twelve defects, one of them my own, caught by the script's refusal. **Next:** Phase 47 / Task 4 (eds without `../eds/`; 28 lines in 6 files), then Task 5. Record: `phase-47-task-3-done.md`.

**2026-10-08, Phase 47 / Task 2 done: the root registry and the resolver exist.** Branch `phase-47-task-2`, not committed, stacked on Task 1, which was committed as `414ce1c` with your yes. Neither is on `main`. What it adds:

- `register-plugin-root.sh`, called by a `SessionStart` entry with no `async` in the core and in each of the five packs;
- `resolve-plugin-root.sh <name>`, which follows §11.2's order: a stale entry is refused, the sibling folder is only a fallback, and a miss says "not resolved", never "absent";
- **G174 (new, your decision):** the fresh-start archiver no longer moves the registry away.

Tests were written first. Results: **127/127 suites under `plugins/` exit 0**; six `validate` passes; naming and no-narrative checks `valid`. The contract now says "partly built". No live session was run; that check stays with Task 10. **Next:** Phase 47 / Task 3, the `core` link. It comes before Task 5 because Task 4 depends on it and an installed pack cannot register without it. Record: `phase-47-task-2-done.md`.

**2026-10-08, Phase 47 / Task 1 done: the plugin freeze has started.** Branch `phase-47-task-1` from `48fc899`, committed later as `414ce1c`. The core contract gains §11.2, "Where a plugin is found" (D126), and marks it **specified, not built**. It covers:

- pack → core through an in-pack `core` link;
- core → pack and pack → pack through `.ai/run-context/plugin-roots/<name>`, written by each plugin's `SessionStart` hook and read only through `resolve-plugin-root.sh`;
- the sibling folder only as the path-loaded fallback;
- an unresolved plugin is an error.

`run-route`'s "Pack roots" was rewritten through skill-creator, and its D509 stamp regenerated. The core README explains how plugins find each other. Results: naming rule `valid`, **78/78 agentic-core suites exit 0**. **Your decision:** the five packs' registry hooks go into Phase 47 / Task 2. Phases 46–50 are not counted here, so no total changes. This page was not updated for Phase 46 / Tasks 3–5 or the Phase 47 precondition; `NEXT.md` holds those entries. **Next:** Phase 47 / Task 2. Record: `phase-47-task-1-done.md`.

**2026-10-06, Phase 46 / Task 6 done: Phase 46 / Task 2's nine defects filed and fixed where ours.** PR [\#240](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/240) (open): the runner's startup log names both plugin sources — the set loaded by path from `ROUTE_PLUGIN_DIR` and the `enabledPlugins` the project settings bring — and says that a name in both runs from the path copy (`plugin-sources.mjs`, test first; nothing else changes). G165 fixed; G166–G171 filed — the registry requirements (canonical paths, no `async` hook) are Phase 47 / Task 2 test cases, the bare-project note is in Phase 48 / Task 4, the `ROUTE_PLUGIN_DIR`-empty-once-installed check in Phase 49 / Task 2, and the two Claude Code observations (blank screen in iTerm2, scratch project only; changed marketplace-list text) are recorded, not investigated. Your decisions: keep the SDK pin `0.3.285`. Phases 46–50 are the marketplace plan and not counted here, so no total changes. Next: Phase 46 / Task 3.

**2026-10-06, Phase 1 is closed (your decision).** The local interactive route is proven end to end (EDS-24 and EDS-25 `delivered`); the 21 open tasks below stay as a backlog and no count changes. Rollback point: tag `phase-1-done` on `9a606c1`, pushed. **Next is Phase 2, the marketplace move** ([plan](https://claude.ai/artifact/MHrwNdYu7y6a2KcRAwfXHz), corrected the same day). Headless (Phase 9 / Task 5, Phase 10) moves after Phase 2; Phase 50's proof run, a design item on Zoki `1-185` with placeholder copy, also closes Phase 20 / Task 5 and Phase 23 / Task 4. Report: [Can Phase 1 close?](https://claude.ai/artifact/MCZz3DS9PHaZfgyKss6iy5)

**2026-10-06, your correction: work-item drafts are committed as before.** **D125 is withdrawn** (marked, not deleted); D47 stands; the unpushed `.gitignore` branch was deleted, so nothing about it reached `main`. **G164** is now only the drift between a committed draft and its live item. Every committed draft was compared word by word with its live item; the stale and missing ones went straight to `main` as `9a606c1`: EDS-13 and EDS-22 updated, EDS-19 and EDS-20 (with their PNGs), EDS-21 and EDS-24 added, each identical to the tracker. EDS-7, EDS-18 and EDS-23 already matched; **EDS-5 still differs**, left as is by your choice. No task count changed.

**2026-10-05, Phase 41 / Tasks 3–5 done: the working-tree inventory is closed.** Phase 41 is proposed and not counted, so the 254 total and the progress bar do not change. Ten stashes were dropped, each after a blob re-check against `main` (or `9e5ad16`) and your yes per stash, including one the inventory never listed ("EDS-24 draft before Phase 43 Task 4", a copy of the live item) and "parked for EDS-21 run"; two remain, both yours. EDS-13's AC-7 draft and the zoran-block draft are parked in `.ai/logs/parked-specs/`, byte-identical to the stash. The long-named Phase 10 / Task 2 branch is deleted (`9e5ad16` stays on origin as `phase-10-task-2`). **Filed with your yes:** **D125** (a draft lives in the tracker; local copies are never committed), **G163** (no stage transitions an item's status) and **G164** (nine drafts are still tracked on `main`; EDS-22/23 arrived through PR \#210, which the inventory had recorded as "no PR"). The `.gitignore` comment is amended on branch `phase-41-task-4-entries` (`8748af8`), **not pushed**. Verification 7/7; `check-status-claims.mjs` 118 claims, all match. Records: `phase-41-task-3/4/5-done.md`.

**2026-10-05, Phase 45 / Task 2 done (verification, nothing built): Phase 45 is complete.** On `main` `b874a20`: 125 suites, each run alone → `pass=125 fail=0` (same count as Task 1; no suite added since); the five repository checks `valid`; `check-status-claims.mjs` 113 claims, all match (114 after this update); `check-numbering.sh` valid on 03/04/05 (43 / 3 / 209). On EDS-25's inputs with the original `features-carousel.css` (`5914551`) plus the draft's two rules: `--base main` and `--base origin/HEAD` → exit 0, no `--base` → exit 1 (the filed G162 failure), an untied `712px` → exit 1. **Defect in the brief:** a block file built in `$TMPDIR` sits in no checkout, so `--base` exits 2 (`no merge base … in the checkout holding …`); it ran from a scratch clone at `5914551` instead. No suite launches Chromium, so nothing needed to run unsandboxed. No gap changed. This page's "waiting on a task" counter said 4 while listing 5; corrected. Record: `phase-45-task-2-done.md`.

**2026-10-05, Phase 44 / Task 6 done: Run A (EDS-25) re-run, `terminal: delivered`, PR [\#239](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/239) merged; Phase 45 / Task 1 is merged too (PR \#238).** **Closed on a quoted line:** **G162** (the prototype ran `check-size-origin.py … --base origin/HEAD` → `exit=0`, the block still holds the pre-existing `width: 2em`), **G140** (`jq .width` 375 / 768 / 1440 match `verify-report.md:8-10`; `check-direct-script-calls.sh` → `ok`), **G159** (`length == (unique | length)` → `true`, 37 entries), **G158** (`## Out of scope by declaration`; no font line in the tracker note) and **G161** also at `delivered` (`written: .ai/run-context/analytics.md` then `terminal: delivered`, 18 subagent rows). **Still FIXED, not closed — EDS-25 never reached the case:** **G157** (no selector hid; every `"hidden": false`), **G160** (no `min-width` row in the design values, so the grep cannot fail), **G151** (`size` never called). **Next:** nothing for these three — your decision 2026-10-05, no item will be written. Record: `phase-44-task-6-done.md`. `check-status-claims.mjs`: 113 claims, all match; `check-numbering.sh` valid on 03/04/05.

**2026-10-05, Phase 45 / Task 1 built: G162 fixed, PR [\#238](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/238) open.** `check-size-origin.py check … --base origin/HEAD` reports only a fixed size the run added or changed (D548); `eds-prototype` passes the flag, `verify-design` is unchanged. **The base you decided (`HEAD`) was measured and changed:** after a commit `git diff HEAD` is empty, so a resumed prototype would pass unchecked; the base is the merge base of `origin/HEAD` and `HEAD`, identical on a first run. On EDS-25's inputs with the original CSS and the draft's two changes: without `--base` exit 1 (the filed failure), with it exit 0, also after a commit. Suite 45 → 62 cases; 125 suites, 0 failed; five repository checks `valid`; the driver stamp is unchanged. **Next:** merge \#238, then Run A on EDS-25 from a fresh session. Record: `phase-45-task-1-done.md`.

**2026-10-05, Phase 44 / Task 6 ran: Run B passed, Run A failed at `prototype`. The task stays open.** **Run B** (`/agentic-core:run-route EDS-24`, merged as \#230): `satisfied the change for this item is already merged (Retrieved checks for eds-24 (#230: 1 pass).)`, a note on EDS-24 (comment 10646), `terminal: blocked`, no branch created — **G149 is closed**. **G161 is closed** on the same day: `written: .ai/run-context/analytics.md` printed before the terminal line at both the `failed` and the `blocked` end, a row for every stage that ran, and `transcript-path.txt` holding the main session file (not seen at `delivered`; no run reached it). **Run A** (EDS-25) passed intake, readiness, extract and serve, warned at conventions and baseline, then **failed at `prototype`**: the strict size-origin check refused `width: 2em` on a numeral marker the block already had (`features-carousel.css:62`), which the run did not write. New **G162** (open, not decided: check only what the run changed, defer to the measured form in `verify-design`, or let `prototype` render). No stage after `prototype` ran, so G157, G140, G159, G160, G151 and G158's report and note stay FIXED, not closed; G158's conventions half was seen (`design fonts out of scope by declaration`). 125 suites pass (the brief's 126 was an arithmetic slip); five repository checks `valid`. Run A's leftovers were discarded with your yes and the tree is back on `main`. **Next:** decide G162, fix it in its own task, then re-run Run A from a fresh session. Record: `phase-44-task-6-partial.md`.

**2026-10-05, after the fixing session: every PR merged, seven tasks done.** You merged [\#231](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/231)–[\#236](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/236) and [\#237](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/237) (a double brace in `evidence-manifest.py` that turned CI red after \#232); `origin/main` is `e161c93`. The driver stamp on `main` is `fb6392a11419`, equal to its marker (checked on a copy, no `--write` needed). **Done:** Phase 43 / Task 5 and Phase 44 / Tasks 1–5 (merged), and **Phase 17 / Task 5** under your reading: "up to two" edit rounds is a ceiling, a loop that stops on "nothing fixable" meets it, and the EDS-24 runs stand in for EDS-18; **G514 is closed** on it. The only run with two edits and three comparisons, EDS-18 on 2026-09-28, ran after Phase 17 merged; whether its session was fresh is not verified. **Phase 23 / Task 4 stays open**, your ruling: the plan-gate mismatch path handed over by Task 3 is part of it, and every run so far printed `relevance: match`. **EDS-25** ("Features carousel image height and corners", written through `write-specs`, live check `valid`) is run A's item: it asks only for the image's 711px height and 30px corners, so the 576 vs 590px column width should survive the prototype and reach G151's `size … width` (predicted, not proven). Evidence and the G161 docs research: `eds-24-gaps-prep-done.md`. **Next:** Phase 44 / Task 6 from a fresh session — run A on EDS-25, run B on EDS-24.

**2026-10-05, the fixing session: Phase 44 filed (your yes), six PRs open, nothing merged.** Every gap the EDS-24 run left is fixed on its own branch cut from `80a059f`, tests first, each with a done record and a live check that only Phase 44 / Task 6's run can pass. **Phase 43 / Task 5** (G157, PR [\#231](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/231); your shape 1, filed as **D124**): `measure` reports a selector with no visible match as `found: true, hidden: true` at once and reads geometry from the first visible match; the three consumer scripts leave it ungraded — `.nav-sections` at 375 went from a 10.76 s `fail` to a 1.27 s `pass`. **Task 1** (G159, [\#232](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/232)): one script, `evidence-manifest.py` — `gaps` builds the coverage-gap strings (nodes named, or a count) from the comparison outputs, which `verify-design` now keeps under `.ai/run-context/`; `merge` is the union both stages call — EDS-24's 214 lines became 29, none twice. **Task 2** (G160, [\#233](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/233)): `min-width` rows say "checked by the breakpoint regression check", nothing else changed. **Task 3** (G140, [\#234](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/234)): `verify` measures once per width, pairs each file with its own recorded width, and — your choice — runs the regression check, a fired line a hard failure. **Task 4** (G161, [\#235](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/235); your shape 1(b)): a `PreToolUse` Bash hook records the transcript path, the three terminal nodes render `analytics.md` before the terminal line; stamp `fb6392a11419`. **Task 5** (G158, [\#236](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/236); your shape 1, D530 amended): this project declares design fonts out of scope in `.ai/design/fonts.yaml`; `design-fonts.py` exits 3, `conventions` stops warning, `verify-design` keeps text geometry out of the check file. Suites: 122 on each branch plus the new ones (124 on \#235, 123 on \#232), 0 failed; every repository check `valid`. **Next:** you merge \#231–#236 (any order; the reviewer's merge-interaction check is in the session's final message), confirm the driver stamp on `main`, then **Phase 44 / Task 6** from a fresh session — run A on a fresh design item (EDS-25), run B `EDS-24` for G149's stop; the prompt is in `NEXT.md`.

**2026-10-05, your answers after the run.** **PR [\#230](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/230) merged** (`80a059f`); local `main` pulled. **Phase 25 / Task 8 restated and done:** its old criterion was EDS-18's own Roboto Mono finding, which no other item's diff can carry; the new one is item-independent — a gate returns `warn`, its finding is in its report, the envelope names the report, `continue-warn`, `delivered` — and this run's `plan-gate` meets it (`plan-gate-report.md:14-16`). **All eight open gaps are written up for the fixing session** in `fix-brief-eds-24-gaps.md`: G157 (Phase 43 / Task 5), and G159, G160, G140, G161, G158 as a proposed Phase 44 (Tasks 1–5 plus a verification task, not filed yet); G149 and G151 need only a run — G149's closing run is now EDS-24 itself, since it is merged. **G159's cause corrected:** the 30 repeated coverage gaps come from `verify-design` writing one line per node without the node (Divider 1 ×27), not from `verify`'s merge.

**Phase 43 / Task 4 done — the EDS-24 run reached `delivered`** (2026-10-04, `phase-43-task-4-done.md`; 15/15 stages, 0 questions, ~32 min, from a fresh session that edited no plugins). PR [\#230](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/230), open, changes only `blocks/table/table.css` (+5 lines). **D123 worked live:** `verify-design`'s first check fired at 375 (42 broken words, the header 109px against its 200px `min-width`, 17 `[fixable]` lines), one edit added `min-width: calc(3 * 200px)`, and the second check was quiet at 375, 768 and 1440; `verify` then passed AC-6 at 375. **Closed:** G155, G144 (`ok: no provider script run directly`), G150 (node 1:217 named per property, each value measured on its own selector). **Not closed:** G140 (`verify` still passes no width), G151 (`size` not called), G149 (continue path only), G157 (not reached). **Four verification tasks close:** Phase 43 / Task 4, Phase 28 / Task 9, Phase 6 / Task 5 and Phase 18 / Task 4. **Phase 25 / Task 8 does not:** `publish-gate` passed with no findings — its criterion is EDS-18's Roboto Mono finding, which is on `main` and outside EDS-24's diff; your call to restate it. **New, not fixed:** G158 (the tracker note lists the undeclared design fonts under "Action needed"), G159 (`verify` appends duplicate coverage gaps: 217, 187 unique), G160 (`min-width` reported "not in measure's property set"), G161 (the driver renders no `analytics.md`; rendered by hand: `verify-design` 5.4M and `verify` 4.7M cumulative input tokens). Next: Phase 43 / Task 5 (G157), fix shape chosen with you.

**Phase 43 / Task 3 done, PR [\#229](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/229) merged** (`3985e0a`, at your request) (2026-10-04, `phase-43-task-3-done.md`). Contract §6 amended first: `measure` takes an optional width and reports `min-width` and each selector's broken words. `verify-design` now captures and measures 375, 768 and 1440 on every check, and a script prints a `[fixable]` line for a broken word or a box narrower than its own `min-width`, inside the existing edit budget. On real data it fires on EDS-24 at 375 with the run's CSS (42 broken words; the header 109px against 200px) and stays quiet on `main` and on 21 control measurements. 122 suites, 0 failed. G155 fixed, G140 partly (`verify` still measures at the default). **New: G157** — a selector hidden at a measured width fails `measure`; not reached on EDS-24; your choice: its own task, Phase 43 / Task 5, after the run.

**PRs \#225, \#226 and \#227 merged** (2026-10-04, at your request): Phase 43 / Task 1 is done, G147 and G148 are fixed on `main` (`2003379`, driver stamp unchanged). Running every suite on the merged `main` outside the sandbox found **G156**, a pre-existing test defect (a `TMPDIR` ending in a slash), fixed in PR [\#228](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/228), merged (`51a8ccf`). **Your choice for Phase 43 / Task 3:** both signals (a broken word and a box narrower than its `min-width`); its prompt is in `NEXT.md`.

**Phase 43 / Task 2 done (measured), G147 and G148 fixed** (2026-10-04, same session). **Task 2** (`phase-43-task-2-done.md`, no code): of four candidate signals for a regression at a width with no reference image, **a word broken across lines** and **a box narrower than its own `min-width`** fire on every regressed case (EDS-24's CSS at 375, five pages) and stay quiet everywhere else (the table on `main`, 768 and 1440, eight other blocks); overflow never fires; a size change against the pre-change render fires on the intended change too. **Your choice** decides Task 3. **G147**, PR [\#226](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/226): bare and per-side border classes give their width rows (27 new rows on EDS-24's reference). **G148**, PR [\#227](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/227): viewport variants get the spill translation. Suites 120 run, 0 failed on each branch.

**Phase 43 filed and Task 1 built** (2026-10-04; G155, G144, D123). Phase 43 makes the design loop see every breakpoint and makes a stage call an operation every time. **Task 1**, PR [\#225](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/225) open: the one-call rule was already in `role-operations.md`, and neither EDS-24 stage ever read the file; the contract now says one invocation runs one script, alone in its command, the two stages read it as a numbered step, and an eds check enforces the step (121 suites, 0 failed). **Next:** Task 2 measures what a regression is at a width with no reference image, on the EDS-24 draft; numbers for you, no rule. `dx-core` checks only the design's own widths, so D123 goes beyond the reference.

**EDS-24 verification run, 2026-10-04 — `terminal: failed` at `verify`, stage 12/15** (`phase-42-verification-done.md`; 0 questions, ~27 min 44 s). `verify` failed AC-6 at 375px: `prototype`'s `table-layout: fixed` makes the browser ignore the header cells' `min-width: 200px`, so the columns squeeze to 109px and words break mid-word. Measured after the run: `main`'s automatic layout scrolls at 600px, and the fixed table plus `min-width: 600px` keeps equal columns and the scroll. The verdict is right; no stage before `verify` renders any width but 1440, and `verify` cannot edit — new **G155**. **Closed:** G152 (stamp matched) and G153 (no flag during intake; flag and first run state written in the same second). **Proven live, not closed:** D122's continue path (`continue change_state=none`, G149) and G151's `variables` mode (`size` never ran — the columns were already equal). **Not passed:** G144, `invalid: 2 provider script(s) run directly` (was 7). **Your reading needed:** G150 — nothing was measured on another property's selector, but the prompt's literal wording did not hold. Seen again: G145 (out-of-scope border edit), G140 (no measurement at 375). Phase 17 / Task 5 and Phase 23 / Task 4 conditions met on the report; Phase 28 / Task 9, Phase 25 / Task 8 and Phase 6 / Task 5 still need `delivered`. **No task changed state.** Your decisions the same day: the run's leftovers discarded (back on `main`, `eds-24` deleted everywhere); G155's fix is `verify-design` capturing every declared breakpoint, a regression there `[fixable]`; G144's residual is fixed in the stage instruction; G150 stays FIXED.

**Phase 42 — every defect of the EDS-18 run fixed, seven tasks, seven PRs merged, D122 decided** (2026-10-03/04; records `phase-42-task-1..7-done.md`; each gap is FIXED, none CLOSED — they close on the EDS-24 run). **Task 1** (G152, [\#218](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/218)): the driver's gate-guard text says D121. **Task 2** (G150, [\#219](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/219)): a design value is measured on its own row's selector or reported unmeasured — on the run's own files the dead `gap` mismatch disappears. **Task 3** (G151, [\#220](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/220), your choice "same selector and same dimension"): a `size` mode decides whether a width or height difference follows the content, and a `variables` mode compares each design variable on the element carrying its token, never the wrapper. **Task 4** (G153, [\#221](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/221), your choice): the marker is first written with the first run state, after intake; measured first — no stage adapter reads the flag. **Task 5** (G144, [\#222](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/222)): confirmed from run B's transcripts and measured (Chromium does not launch in the sandbox: "Target page, context or browser has been closed"); the browser operations run their script unsandboxed, a new core contract says a stage calls a role operation only as its skill, and `check-direct-script-calls.sh` reads a transcript to prove it (7 direct calls in run B). **Task 6** (G149, **D122**, [\#223](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/223), your decisions: both detectors, `blocked` + a tracker note, no override, a fresh item): the driver asks `check_status` before `create_branch` and stops a delivered item at once; an empty change at the publish gate is a `question`, not a `fail`. **Task 7** (G111, no code): Phase 6 / Task 5's criterion restated — a correct driver never calls `Read`, so registration is proven by any logged line and compliance by zero DENY. **EDS-24** ("Equal comparison table columns") was written through `write-specs` for the next run; a new checklist rule, yours: one element per criterion ([\#224](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/224)). **All seven PRs merged 2026-10-04** at your request (#219, \#220, \#222, \#224, then \#218, \#221, \#223 with `origin/main` merged in and the stamp rewritten): `main` is `118856a`, stamp `d52fab5a4253`, 120 suites pass. **Before the run:** `/clear` only. The EDS-18 leftovers were cleaned with your yes.

**EDS-18 verification run, 2026-10-03 evening — Phase 40 / Task 3 proved live; six gaps closed; the run itself ended `failed`.** A probe file was refused at stage 0 (`refused: 1 paths changed before this run`, `terminal: blocked`, nothing written); clean trees passed. The driver archived the EDS-23 run's context (`archived: 45 entries`). **Closed:** G137, G138, G139 (header 96px, no hand correction), G143 (`spill:` lines in the notes), G146 (`NORUN` after the run), G122. D121 held. **The run failed at `publish-gate`** because EDS-18's work has been on `main` since PR \#170 (G149) — the no-op case `NEXT.md` had already predicted, waiting on the "Already-Satisfied Item Stop" decision. So Phase 28 / Task 9, Phase 25 / Task 8 and Phase 6 / Task 5 stay open. New: G149–G153; G154 fixed (run prompts no longer pull inside the driving session). Records `phase-40-task-3-done.md` § Live check, `phase-28-task-9-done.md`.

**PRs \#212–#216 are merged** (2026-10-03), so **Phase 40 / Task 3 is done** (its record and code are on `main`; the live check rides the next run) and G138, G139, G142, G143 and G146 are fixed on `main`. **New decision D121**, PR [\#217](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/217) open: a gate run from the main checkout always reports `isolation: absent`, and D537's cap turned every `pass` into `warn`, so `publish-gate` could never pass (EDS-23: review `pass`, envelope `warn`). The cap is removed; the isolation line stays in the report as information, and the driver's tree guard keeps the read-only guarantee with `fail`. Isolation itself is not available: the docs do not say a forked skill applies its agent's `isolation`, and a worktree from the default branch would not hold the change under review (G532 updated).

**Four gaps fixed in the same session, one PR each, none merged** (2026-10-03). **G146** ([\#214](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/214)): the driver's read hook judges reads only while a run is live, so the session can do its own bookkeeping after `delivered`. **G139** and **G143** ([\#215](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/215)): the 97px header was Column 1's frame border carried by the first `th`, not a border the script forgot (the register's diagnosis was wrong). The script now takes it, giving 23.143px, the value PR \#212 has by hand, and the prototype stage keeps the arithmetic in `design-context-notes.txt`. **G142** ([\#216](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/216)): the tracker note lists a check still running under a new **Pending** section, your choice, because putting it under Action needed contradicted G535. Found on the way, not fixed: **G147** (a bare `border` class gives no width row) and **G148** (viewport variants skip the spill). \#213 and \#214 both edit `run-route/SKILL.md`; the second to merge needs a rebase and a new stamp. The EDS-18 run prompt in `NEXT.md` now checks all four.

**Phase 40 / Task 3 is built, PR [\#213](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/213) open** (2026-10-03, D120, `phase-40-task-3-done.md`). A fresh start now refuses a working tree that already holds a change, at stage 0, naming every path, with nothing written (no marker, branch, run state or archive); a resume never checks. The new `check-tree-clean.sh` calls `list-changed-files.sh`, the publish gate's own change set, so the two cannot disagree; the gate's rule is unchanged. Because of that, a branch with commits not yet on `main` is refused too. **G138 is fixed, not closed**: no live run has used the guard. Suites: the new one 32/32, every core shell suite 74 run, 0 failed. **Next:** after \#213 merges, one EDS-18 session runs the driver twice — once with a probe file to see the refusal, once for real, whose archive step closes **G137** (the prompt is in `NEXT.md`).

**The EDS-23 run reached `delivered`** (2026-10-03, ~22 min 31 s, 15 of 15 stages, no question, nobody typed a command for the driver). PR [\#212](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/212), open, changes only `blocks/table/table.css`. It closes three verification tasks: **Phase 40 / Task 2**, **Phase 39 / Task 3** and **Phase 38 / Task 4** (`phase-40-task-2-done.md`; per-stage timing in `docs/agentic-core/phase-run-eds-23.md`). `create_branch` wrote its own envelope and every stage's `capture-envelope.sh` line read `unchanged`, so **G136 is closed**. **G137 stays fixed, not closed**: the fresh start printed `archived: nothing to move` because the directory was already empty, so no run has yet archived a previous run's files. The header measured 97px at `verify-design`, as G139 predicted, and 96px at `verify` only because `implement` took 1px off the Area padding by hand. One `reference:` line was written; no `spill:` line reached any report. `deliver` did not attach the evidence itself: `verify` warned, so by design it attached the 6 screenshots and wrote the marker. That marker was this run's own, not a stale one. New gaps: **G142** (the tracker note leaves out a pending check), **G143** (`spill:` lines reach no report), **G144** (`verify-design` bypassed the browser operations; its own report, not checked), **G145** (`verify-design` fixed things outside the item's scope and `implement` reverted them) and **G146** (the driver's read hook stays on after the run ends). **Next:** Phase 40 / Task 3, from a new session; the prompt is in `NEXT.md`.

**Working-tree inventory, 2026-10-03** (`next-phase-41.md`, opened at your request: drafts are recorded in a track file, never carried to `main` in a PR). Eleven stashes were classified by blob comparison, not by message: two are yours (the EDS-23 run output and the EDS-22 draft rewrite); the "phase-6-task-5-deny" one is a byte-identical duplicate of Phase 10 / Task 2's commit `9e5ad16`, which exists **only on this machine** (no remote branch); three are earlier forms of blocks `main` later delivered (table ×2, features-carousel); two are identical to `main`; one holds the only copy of a `zoran-block` bug draft (the block still joins paragraphs with `textContent`, no Jira item); one holds EDS-13's current AC-7, which the committed draft on `main` no longer matches. EDS-19 and EDS-20 are complete in Jira with their PNGs; the stash copy of EDS-21 is older than the tracker. Every EDS item, delivered or not, is still **To Do**: nothing transitions status (proposed gap, unfiled). Deleted from the tree with your yes: `ovde-sam-stao.md` and the untracked EDS-22/EDS-23 drafts. Done the same morning with your yes: `specs-eds-22-23` deleted on origin and locally; `9e5ad16` pushed as `phase-10-task-2` (the D544 hook refuses the 41-character original name, limit 23); 13 older `NEXT.prev-*.md` snapshots moved to `archive/`. Still waiting on you: drop the stale stashes by name, file the three proposed entries. No task changed state.

**Phase 40 is new; Task 1 is on `main`** (2026-10-03, committed directly at your instruction; G136, G137, G138; D118, D119, D120; `phase-40-task-1-done.md`). Two EDS-23 runs stopped where the driver hand-copied `create_branch`'s envelope and the harness refused to let it validate what it had written (`[Auto-Mode Bypass]`, with and without a `printf` allow rule). The operation now writes its own envelope to the file the driver names (`--envelope`, spelled by the core emitter), and the driver's copy path is gone for operations as it already was for stages. The second, fresh, start had read the first run's 37 files as its own; a fresh start now runs `archive-run-context.sh` before the marker (43 entries archived on its first real use), and a resume never does. The gate refusing pre-run dirty files at stage 14 is decided (D120: the gate is right, pre-flight stays declaration-only, a fresh-start tree guard is Task 3, after the run). Recorded, not fixed: **G139** (the spill arithmetic omits the first header cell's top border: 97px, not 96), **G140** (`verify-design` measures at 1280 while its capture ran at 1440), **G141** (a pause over two hours cannot be resumed, by design). **PR \#206 and PR \#209 are merged** (2026-10-03): Phase 38 / Tasks 1–3 and Phase 39 / Tasks 1–2 (D116, D117) are done. **Next:** `/agentic-core:run-route EDS-23` from a fresh session — one run that serves Phase 40 / Task 2, Phase 38 / Task 4, Phase 39 / Task 3 and the five older verifications.

**Phase 38 is new; Tasks 1–3 are built** (2026-10-02, G129, D113, PR [\#206](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/206), merged 2026-10-03). Ten route stages left their verdict for the driver to copy out of their message, and the EDS-18 run of 2026-10-02 had two slips there. Every stage now writes its own envelope, a CI check enforces it, and the driver no longer copies. `readiness` writes that one file (core contract §4 amended). The same PR fixes **G128** (eight dangling "Run Teardown" steps; a new check found one more stale link in `run-route`) and builds **G127** (`prototype` no longer copies `word-break: break-word` from the design). A decision on a work item already satisfied on `main` is waiting on you: [options](https://claude.ai/artifact/PChibrB6FmFW2xu9xfzUkE).

**Spec 29 (Phase 36, proposed) was amended and reviewed against the repository** (2026-10-02; still not approved, not counted). Drive is written as you through an OAuth refresh token, not a service account: Google's documentation says a service account cannot own files outside a shared drive, and the content folder is a personal My Drive. Measured: a preview `DELETE` returns `403` while the doc exists, `204` once it is trashed and `404` when already gone; previewed content is shared by every branch while code is per branch. So `remove` trashes first and is idempotent, `verify` checks the project's own preview server, the ticket links the branch host (not `main--`), and the cleanup lists Drive instead of `.ai/scm/`, which a CI runner does not have. A new Task 6 covers CI secrets and hosts; `write-specs` reproduction pages moved to a later spec. An implementation prompt is in `phase-36-implementation-prompt.md`. Summary: [spec 29 artifact](https://claude.ai/artifact/4NTkNwumUnbKgqCZhEKNKF).

**Phase 37 is planned** (2026-10-02, in `NEXT.md`, not yet in `02-build-tasks.md`), from a review of `skojic/aem-eds-figma-to-code` against our component-size failures. That repo measures no element box, so it adds rules, not machinery. Three new gaps were filed: **G124** (a CSS border is drawn outside the box, the design's stroke inside, so the EDS-18 header is 98px against 96), **G125** (lengths are compared for exact equality with no tolerance, and nobody has counted the false mismatches this causes) and **G126** (no check that a block whose children are all `position: absolute` keeps a height). G536 now has a task. Phase 36 was already proposed by spec 29, so this phase is 37.

**Phase 9 / Task 6 is merged** in PR \#201 (`c8a2343`), so it is now done. **Phase 9 / Task 5 is started, not done**: no done record and no PR yet. Three real EDS-22 route runs failed or stopped early (`36935469880` at `serve`, `36936597401` blocked at `create-branch` by an existing `eds-22` branch, `36937191077` green but halted after readiness, G121). Fixes for G119/D109 and G121 are committed on `phase-9-task-5-e2e` and `phase-9-task-5-probe`, not on `main`. Probe run `37015047894`: a dev server started in one sandboxed command does not answer from a second command; next step is deciding how `serve` keeps it alive. Spec 29 (content authoring) is drafted and not approved.

**Phase 9 / Task 4 is done**, merged in PR \#200 with the G118 fix (neither scm operation pushes the default branch). **Phase 9 / Task 6 was built and verified** (PR \#201, now merged, `phase-9-task-6-done.md`): every runner session carries the committed domain list in the policy tier with `strictAllowlist`, no unsandboxed retry and a sandbox that must start (exit 6 otherwise). CI run `36867201570` started the sandbox (the runner's AppArmor sysctl was `1`), denied `example.com` by name and reached `api.github.com` (200); `36867520801`, with `example.com` declared, got 200. Task 5 is next.

**Phase 9 / Task 3 is done**, verified in CI on `main` (`phase-9-task-3-done.md`). Three runs: `36771120902` fetched EDS-18 headlessly to a `pass` envelope with no credential on disk; `36773144711` was stopped green by the duplicate check; `36840774630`, with that check skipped, was stopped green by the claim tag (`duplicate agentic-run/EDS-18-c900102`), and no session started. The sandbox did not refuse to start on `ubuntu-latest`; whether it enforces is Task 6's question. Spec 24 gained Amendment 6. Tasks 4 and 6 are now ready.

**Phase 35 is new and next** (G502). Onboarding added the adopted token `--text-link: #000`, but links still render the boilerplate `--link-color: #3b63fb`, and no check reports it. Six tasks, test first: watch onboarding run on the pre-onboarding site, read how `dx-core` handles it, decide with you, then a script finds the divergence and you are asked once.

**G546 is fixed.** The branch hook no longer reads a shell redirection such as `2>&1` as a branch name (PR [\#199](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/199), merged as `1d7caad`). CI `validate` passed, hook suite 61/61. Not yet observed in a live session.

**One pointer file.** Every track file (`next-phase-6`, `-20-23`, `-25`, `-28`, `-32`, `-33`) moved to `archive/`. Their open items are now in `NEXT.md` under **Open work**. Phase 32's spec and Phase 24's record stay in the archive as their only copies. No task changed state.

**Phase 33 is complete** (branch rule and PSI gating, proven end to end; `archive/next-phase-33.md`). The merged `main` was re-run on a clean clone; the D544 hook was observed blocking in a live session and inside a subagent; the narrative suite no longer needs `docs/` (PR [\#191](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/191)); the route now checks its derived branch name before `create_branch` (D545, PR [\#192](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/192)).

**G542 is fixed.** EDS-21 removed the 16 px from `blocks/table/table.css` through the route: PR [\#198](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/198), merged, `aem-psi-check` pass, `URL for testing:` written by `eds-deliver`. A two-line heading was measured afterwards and is held.

**Phase 34 is new and complete** (spec `26-item-content-readiness-spec.md`, G547, D546, D547). EDS-21's first run failed at `plan-gate`: its reproduction URL named another item's draft, which `serve` deleted, and a criterion compared against a before-state `baseline` can never capture. Both are now refused at `readiness` and by the `write-specs` checker. PRs [\#193](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/193) and [\#196](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/196) (#194 and \#195 were stacked and merged only into their bases; \#196 carried them to `main`).

**Also fixed:** G548, a drift test that read installed `node_modules/` (PR [\#197](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/197)); G549, the status-claims checker taking a stash commit for a PR's merge (local tool).

**21**tasks open

**2**in flight

**4**wait on a live run

**4**ready to start

**5**waiting on a task

**6**nice to have

## What comes next — in priority order (2026-10-06)

Phase 1 is closed; everything below the first item is backlog, in the order it would be picked up.

1.  **Phase 2, the marketplace move (Phases 46–50)** — [plan](https://claude.ai/artifact/MHrwNdYu7y6a2KcRAwfXHz); plugin freeze during Phases 47–48. Phase 50 / Task 3's proof run also closes **Phase 20 / Task 5** and **Phase 23 / Task 4**.
2.  **Headless** — Phase 9 / Task 5, then Phase 10 / Tasks 2, 4, 5, 6, against the marketplace layout. Needs `CLAUDE_CODE_OAUTH_TOKEN` and your dispatch. **Now (2026-10-13):** a dispatch of an item with no design reference that reaches `delivered` in CI (G190 closed, G191 fixed). Before it: the action-versus-runner comparison in Phase 49 / Task 2 (see the 2026-10-10 entry above); a review-on-every-PR workflow is optional and not scheduled.
3.  **Phase 35** (G502) — onboarding notices the design it did not apply; Tasks 1 and 2 ready.
4.  **Phase 32**, then **Phase 21 / Task 5** and **Phase 22 / Task 3** — viewports and assets; file Phase 32's entries first.
5.  **Phase 53 (spec 34) — closed 2026-10-12**: merged as \#247, all three live steps passed. Open gaps from it, not scheduled: G185 (unauthenticated plugin may still list its tools), G186, G187, G188, G189.
6.  **Specs 32 and 33 (2026-10-12, proposed, after spec 34)** — design references `extract` does not read. EDS-26 delivered without them, so both are lower than they looked. Read Phase 32 before spec 33: they overlap, and Phase 32 is the better candidate.
7.  **Phase 37 / Tasks 2–6**, **Phase 36** (spec 29), open gaps without a task (G510, G534, G544, G141, G145, G163, G164).
8.  **Nice to have** — Phase 6 / Task 4, Phase 12, Phase 23 / Task 2.

**Waiting on the human:** approve deleting the seven merged Phase 42 branches; review spec 29 and, for its Phase 36 / Task 1, create an OAuth desktop client ("In production") and set `GDRIVE_CLIENT_ID`, `GDRIVE_CLIENT_SECRET`, `GDRIVE_REFRESH_TOKEN` in `.claude/settings.local.json`; file Phase 32's gap and decision entries; add the four design font families (D530) if EDS-18 should match typographically; approve deleting 12 merged remote branches (listed in `NEXT.md`) (the stashes are done, Phase 41). Nice to have, 6 tasks: Phase 6 / Task 4, Phase 12 and Phase 23 / Task 2. Without them, 16 tasks close the plan of record. No time estimate is given.

In flight code exists, not done

Live run built and merged, the live half is outstanding

Ready every dependency met

Blocked waits on an open task

Nice to have optional, or logged and not scheduled

Proposed specified, not filed, not counted

Done finished today, kept here for reference

Phase 45

## The size-origin check reads only the run's own changes

complete

Filed 2026-10-05 (G162, D548; `02-build-tasks.md`). One branch and one PR from `main` `e161c93`, tests first. G162 is CLOSED 2026-10-05: Phase 44 / Task 6's Run A passed the check on a block with a fixed size of its own.

1.  Task 1 The size-origin check reads only the run's own changes *— G162; `--base origin/HEAD`, merge base not `HEAD` (measured); EDS-25 inputs → exit 0* Merged **PR** [\#238](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/238) merged · `phase-45-task-1-done.md` · G162 closed by Run A
2.  Task 2 Verification *— 125 suites pass, five checks valid, claims match, numbering valid; EDS-25 inputs: `--base` → exit 0, without → exit 1* Done **Record** `phase-45-task-2-done.md` · run from a scratch clone at `5914551`: a `$TMPDIR` file has no checkout, so `--base` exits 2

Phase 43

## The design loop sees every breakpoint, and a stage calls an operation every time

Tasks 1–5 complete · Task 6 in flight, not counted

New 2026-10-04 (G155, G144, D123) from the EDS-24 run, which failed at `verify`: a change matched the design at 1440 and broke the table at 375, and no earlier stage renders another width. `02-build-tasks.md:3509`.

1.  Task 1 Every operation call goes through its own skill invocation *— G144; the contract is read as a step* Merged **PR** [\#225](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/225) merged · `phase-43-task-1-done.md`
2.  Task 2 What a regression is at a width with no reference *— broken word and min-width fire only on the regression; overflow never; size change fires on the intended change too* Done **Record** `phase-43-task-2-done.md` · your choice of signal is Task 3's input
3.  Task 3 `verify-design` renders every breakpoint *— D123; signals A and B together (your choice); fires on EDS-24 at 375, quiet elsewhere* Merged **PR** [\#229](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/229) merged · `phase-43-task-3-done.md` · new G157
4.  Task 4 Verification *— EDS-24 `delivered` (PR \#230); 375 fired on check 1, one edit, quiet on check 2; G155, G144, G150 closed* Done **Record** `phase-43-task-4-done.md` · new G158–G161
5.  Task 5 A selector hidden at a measured width does not fail the read *— G157; your shape 1, D124: `hidden: true`, geometry from the first visible match; 10.76 s fail → 1.27 s pass* Merged **PR** [\#231](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/231) merged · `phase-43-task-5-done.md` · §6 amended first · closes on a run whose block hides a measured selector
6.  Task 6 A design-provider failure is a hard `fail`; `extract` has no attachment fallback *— D131 supersedes D501 (your decision 2026-10-12): a Figma `fail` goes straight to Report fail with the provider's `error_class`; the "Fallback available?" and "Report warn" nodes are gone; with a design URL the resolver prints only `decision=url reference=…`; the image-only source is unchanged* In flight **Branch** `d131-no-design-fallback` `0beef07`, pushed, no PR · `resolve-design-source.test.sh` 21/0, `write-design-reference.test.sh` 101/0 · no route run · D131 in `04-eds-pack-design.md`, D501 and `00-instructions.md` marked (local docs) · not in `02-build-tasks.md`, so no total changes

Phase 44

## The EDS-24 run's remaining gaps

0 of 6 remaining

Filed 2026-10-05 with your yes (G159, G160, G140, G161, G158; `02-build-tasks.md:3587`), from `fix-brief-eds-24-gaps.md`. One branch and one PR per task from `main` `80a059f`, tests first; Task 6's runs (2026-10-05) closed G140, G158, G159 and G162; G157, G160 and G151 stay FIXED. Three branches touch `check-breakpoint-regressions.test.sh` in different regions.

1.  Task 1 The evidence manifest holds each coverage gap once, and says which node *— G159; `evidence-manifest.py gaps|merge`; EDS-24's 214 lines → 29, merged 187 = unique* Merged **PR** [\#232](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/232) merged · `phase-44-task-1-done.md` · comparison outputs now kept under `.ai/run-context/`
2.  Task 2 `min-width` gets its own reason in the value comparison *— G160; "checked by the breakpoint regression check …"; every other line identical* Merged **PR** [\#233](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/233) merged · `phase-44-task-2-done.md`
3.  Task 3 `verify` measures at every width it captures *— G140; one `measure` per width, `widths` pairing, the regression check runs at `verify` too (your choice)* Merged **PR** [\#234](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/234) merged · `phase-44-task-3-done.md` · proven only by Task 6's run
4.  Task 4 The driver renders `analytics.md` at every terminal state *— G161; your shape 1(b): a Bash hook records the transcript path, terminal nodes render before the terminal line; stamp `fb6392a11419`* Merged **PR** [\#235](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/235) merged · `phase-44-task-4-done.md` · `03-core-design.md:506` corrected
5.  Task 5 Design fonts the human put out of scope are not "Action needed" *— G158; your shape 1: `.ai/design/fonts.yaml`, `design-fonts.py` exit 3, D530 amended* Merged **PR** [\#236](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/236) merged · `phase-44-task-5-done.md` · this project declares it
6.  Task 6 Verification *— Run B (G149, G161) and Run A re-run on EDS-25, `delivered`, PR \#239; G162, G140, G159, G158 closed; G157, G160, G151 stay FIXED (case not reached)* Done `phase-44-task-6-done.md` · each closed gap has its quoted line in the register

Phase 40

## The driver writes no verdict, and a fresh start begins clean

complete

New 2026-10-03 (G136, G137, G138; D118, D119, D120). Task 1 is on `main` (`phase-40-task-1-done.md`): `create_branch` writes its envelope to the file the driver names, and a fresh start archives `.ai/run-context/` before the marker. Task 2 is the EDS-23 run; Task 3 is built after it so the run tests Task 1 alone.

1.  Task 2 Verification *— EDS-23 reached `delivered` (PR \#212); `create-branch` read `unchanged`; `archived: nothing to move`* Done **Record** `phase-40-task-2-done.md` · G136 closed · G137 closed 2026-10-03 (archived the EDS-23 context)
2.  Task 3 A fresh start refuses a dirty working tree *— D120; `check-tree-clean.sh` reuses the gate's change set; resume exempt* Done **Record** `phase-40-task-3-done.md` · PR \#213 merged · live check passed 2026-10-03 (refused, then clean) · G138 closed

Phase 42

## Every defect of the EDS-18 verification run, fixed

7 of 7 merged · provisional · not counted

New 2026-10-03 (G144, G149–G153, G111), not yet in `02-build-tasks.md`. One branch and one PR per task from `origin/main`, test first; every gap marked FIXED, none CLOSED. All seven PRs merged 2026-10-04; the driver's stamp on `main` is `d52fab5a4253`.

1.  Task 1 G152 — the driver's gate-guard text says D121 *— stamp `043099ddae99`; `check-tree-unchanged.test.sh` registered in CI* Merged **PR** [\#218](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/218) merged · `phase-42-task-1-done.md`
2.  Task 2 G150 — a design value is measured on its own row's selector or reported unmeasured Merged **PR** [\#219](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/219) merged · `phase-42-task-2-done.md`
3.  Task 3 G151 — `size` and `variables` modes *— same selector and same dimension; a variable on its own element* Merged **PR** [\#220](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/220) merged · `phase-42-task-3-done.md` · shares two files with \#219, hunks apart
4.  Task 4 G153 — the marker is first written with the first run state *— stamp `1e1ea7d441cd`* Merged **PR** [\#221](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/221) merged · `phase-42-task-4-done.md`
5.  Task 5 G144 — browser operations run unsandboxed; a stage calls an operation only as its skill *— `role-operations.md`, `check-direct-script-calls.sh`* Merged **PR** [\#222](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/222) merged · `phase-42-task-5-done.md`
6.  Task 6 G149 / D122 — an already-satisfied item ends `blocked` with a note *— `check_status` before the branch; an empty change is a question; stamp `7a695c301b30`* Merged **PR** [\#223](https://github.com/agenticDraft/aem-eds-ai-workflow-demo/pull/223) merged · `phase-42-task-6-done.md` · EDS-24 written for the next run
7.  Task 7 G111 — Phase 6 / Task 5's criterion restated *— no code* Done **Record** `phase-42-task-7-done.md` · `02-build-tasks.md`, `phase-6-task-5-status.md` amended

Phase 39

## Design boxes and the official reference

complete

New 2026-10-02 (G124, D116, D117). Tasks 1 and 2 merged 2026-10-03 (border-box sizes and the `leading-[0]` translation; the pack's declared official reference read where no rule answers). G139 predicts the EDS-23 header will measure 97px, not 96: the spill arithmetic omits the first cell's top border.

1.  Task 3 Verification *— header 97px at `verify-design`, 96px at `verify` after a hand fix; one `reference:` line; no `spill:` line in any report (G143)* Done **Record** `phase-40-task-2-done.md` · G139 closed 2026-10-03 (EDS-18 run: 96px, no hand fix)

Phase 38

## Every stage writes its own envelope

complete

New 2026-10-02 (G129, D113). Tasks 1–3 merged in PR \#206 on 2026-10-03, together with G127 and G128. Task 3's exemption for `create_branch` is superseded by Phase 40 / Task 1 (D118). Task 4 is the same run as Phase 40 / Task 2.

1.  Task 4 Verification *— all 16 `capture-envelope.sh` lines read `unchanged`; no envelope copied by the driver* Done **Record** `phase-40-task-2-done.md` (EDS-23 run, 2026-10-03)

Phases 28 · 25 · 17 · 18 · 6

## Built and merged; each waits on a delivered run

complete

All code is merged (Phase 28 in \#171–#176; Phase 25 in \#160; Phases 17 and 18 in \#155–#158; Phase 6 / Task 5 in \#125, \#126). EDS-18 reached `delivered` in Phase 27 / Task 7, but that run was not checked against the four older criteria. The 2026-10-03 EDS-18 run checked them and failed at `publish-gate` (G149, the item is already on `main`): Phase 23 / Task 4's report checks, Phase 18 / Task 4 and the gates' isolation and tree guard passed; `delivered`, the Roboto Mono `warn` and the read log's `ALLOW` lines did not (`phase-28-task-9-done.md`). The next run is EDS-24, a fresh item that can reach `deliver` (Phase 42 / Task 6); Phase 6 / Task 5's criterion was restated in Phase 42 / Task 7 (zero `ALLOW` lines is the expected shape). Each verification forbids claiming the run from a session that edited the plugins. Pointer: `NEXT.md` (Open work), which holds a ready-to-paste prompt. **2026-10-04:** the EDS-24 run failed at `verify` (G155), so none closed; Phase 17 / Task 5 (one edit round, two comparisons, nothing fixable) and Phase 18 / Task 4's distinct screenshots held on its report. **2026-10-04, second EDS-24 run (`delivered`, `phase-43-task-4-done.md`):** Phase 28 / Task 9, Phase 6 / Task 5 and Phase 18 / Task 4 met and are done. Phase 25 / Task 8 is not: `publish-gate` passed with no findings, because the Roboto Mono declaration its criterion names has been on `main` since EDS-18 (line 118) and is not in EDS-24's diff. Phase 17 / Task 5 saw one edit round and two comparisons again (the loop ended "nothing fixable"); whether that meets "three comparisons" is your call. **2026-10-05, your ruling:** it does — "up to two" is a ceiling, and the EDS-24 runs count; Phase 17 / Task 5 is done and G514 is closed (`eds-24-gaps-prep-done.md`).

1.  28 / Task 9 Verification *— delivered (PR \#230), `localhost:3001/drafts/EDS-24` 200 after the run, link lines in PR and note, both tree guards passed, isolation stated* Done **Record** `phase-43-task-4-done.md` (the EDS-18 cleanup clause does not apply to EDS-24)
2.  25 / Task 8 Verification *— suites, then EDS-18 reaching `delivered`* Done **Record** `phase-43-task-4-done.md` · criterion restated 2026-10-05 (your choice): a gate `warn` with its finding in its report, `continue-warn`, delivered — met by EDS-24's `plan-gate`
3.  17 / Task 5 Verification *— fix attempts; one edit, two comparisons, "nothing fixable" — met under your ceiling reading* Done **Ruled** 2026-10-05 · `02-build-tasks.md` "Met 2026-10-05" · G514 closed · `eds-24-gaps-prep-done.md`
4.  18 / Task 4 Verification *— budgets; distinct screenshot per comparison, each attached once; suites and `check-fix-budget-readers.sh` exit 0* Done **Record** `phase-43-task-4-done.md`
5.  6 / Task 5 Flip the driver's read hook from warning to deny *— `NORUN` logged in the session, 0 `DENY` during the run, `delivered`* Done **Record** `phase-43-task-4-done.md` · the driver made no `Read` during the run, so the line is a post-run `NORUN` (the restated criterion allows it)

Phase 23

## Comparison quality

2 of 4 remaining

Tasks 1 (tolerance marker) and 3 (design relevance, threshold 1, provisional) merged in PR \#177, 2026-09-29. The threshold is to be re-measured once 5 or more real pairs exist; Phase 30 / Task 4 gives the script, and today's archive has 0. Pointer: `NEXT.md` (Open work).

1.  Task 2 Pasted context screenshots are detected, not reproduced Nice to have **Logged** until a real frame shows one (G539)
2.  Task 4 Verification *— the "content-dependent, not graded" section is met by three runs* Live run **Needs** plan-gate on a mismatched item: warns, the route continues (your ruling 2026-10-05) · fresh session

Phases 20 · 21 · 22

## Figma chain: the live halves

3 remaining

Every build task is merged (PR \#159, 2026-09-28). Unchanged since the last status. Pointer: `NEXT.md` (Open work).

1.  20 / Task 5 Verification *— live run on `Zoki` node `1-185`* Live run **Needs** fresh session
2.  21 / Task 5 Verification *— viewports* Live run **Needs** fresh session
3.  22 / Task 3 Verification *— images and icons* Live run **Needs** fresh session

Phase 35

## Onboarding notices the design it did not apply

6 of 6 remaining

G502, scheduled 2026-09-30 as the next task. In this repo `--text-link: #000` has no `var()` consumer, while links read `--link-color: #3b63fb` against a manifest that says `Text/Link → #000000`. The requirement: detect it, ask once, and offer two branches, adopt by refactor or adopt for new components only.

1.  Task 1 Watch onboarding run on a project that disagrees with its design *— a clone restored to `6db94bd^`* Ready **Depends on** nothing
2.  Task 2 How the reference implementation treats an existing design system Ready **Depends on** nothing
3.  Task 3 Decide where detection, the question and the answer live *— with you* Blocked **Depends on** Tasks 1, 2
4.  Task 4 The divergence is found by a script Blocked **Depends on** Task 3
5.  Task 5 Ask once, record the answer, act on it Blocked **Depends on** Tasks 3, 4
6.  Task 6 Verification *— the flow on this repo asks once and does not ask again* Blocked **Depends on** Tasks 4, 5 merged · fresh session

Phase 41

## Working-tree inventory: stashes, drafts and the one unpushed branch

5 of 5 done · proposed · not counted

Opened 2026-10-03 at your request (`docs/implementation-plan/next-phase-41.md`, number provisional): work-item drafts live in the tracker and are recorded in a track file, never carried to `main` in a PR. Eleven stashes were classified by blob comparison against `origin/main`, commit `9e5ad16` and the live Jira items; every verdict and its evidence is in the file. The stash list below is the reference for Task 3; stash indexes shift, so each is named by its message.

1.  Task 1 The wrong branch goes *— `specs-eds-22-23` deleted on origin and locally, your yes* Done **Checked** `git ls-remote --heads origin specs-eds-22-23` → nothing
2.  Task 2 The Phase 10 / Task 2 commit exists in two places *— `9e5ad16` pushed unchanged as `phase-10-task-2`* Done **Deviation** the D544 hook refuses the original 41-character branch name (limit 23); the long-named local branch is now redundant and goes in Task 3
3.  Task 3 Stashes dropped by name, kept ones parked under a name *— ten dropped on a yes each; EDS-13 and zoran-block parked; long branch deleted* Done **Record** `phase-41-task-3-done.md` · two stashes left, both yours · recovery hashes in `.ai/logs/phase-41-dropped-stashes.txt`
4.  Task 4 The entries are filed *— G163, G164; D125 filed then withdrawn 2026-10-06 (drafts stay committed)* Done **Record** `phase-41-task-4-done.md` · `.gitignore` branch discarded unpushed · drafts synced to the tracker on `main` as `9a606c1`
5.  Task 5 Verification *— seven lines pass; stash count 2* Done **Record** `phase-41-task-5-done.md`

Phase 32

## A nested node finds its viewport counterparts

4 proposed · not counted

Specified 2026-09-30 in `archive/next-phase-32.md`; its gap and decision entries are unnumbered until filed, and 32 is provisional. `classify-node.py` detects viewport variants only among a node's children (Phase 21, D520); a block linked by its own node inside one viewport frame classifies `single`. On the Zoki page every one of 10 block nodes has exactly one counterpart by name path in the Tablet and Mobile frames. `dx-figma-extract` stops at the linked node too (its Case A), so this is an extension beyond the reference.

1.  Task 1 The counterpart search is a script *— `find-counterparts.py`, tests first, real-page fixtures* Proposed **Depends on** nothing
2.  Task 2 `fetch-reference` runs it after `single` *— two more metadata calls, existing `viewports` path* Proposed **Depends on** Task 1
3.  Task 3 The write-specs checklist says what the run finds on its own Proposed **Depends on** nothing
4.  Task 4 Verification *— suites, then EDS-19 from a fresh session: three viewports at 1280 / 800 / 375* Proposed **Depends on** Tasks 1–3 merged · entries filed

Spec 32

## write-specs reports the design references extract will not read

5 proposed · not counted · no phase number

Proposed 2026-10-12 (`32-unread-design-references-spec.md`, local, not committed), from the EDS-26 failure. `resolve-design-source.py` gains `ignored_urls=` and `ignored_images=` on its `decision=` line; `check-spec.py` runs it over the inputs it already builds and prints `design: not read by any stage:` plus a `review:` note. Not a violation. Against a draft only surplus links show; surplus images show at the live check. No phase number is taken: 46–51 are the marketplace phases, and the number is yours to choose.

1.  Task 1 Phase 1 — The resolver reports what it ignores *— `resolve-design-source.py`, header and `Run:` line* Proposed **Depends on** nothing
2.  Task 2 Phase 1 — Tests for it *— one URL, three URLs, URL plus reserved image, unreserved images, ambiguous set* Proposed **Depends on** Phase 1 / Task 1
3.  Task 3 Phase 2 — The checker prints it *— route half, three lines; skipped if the pack has no `extract` stage* Proposed **Depends on** Phase 1 · a `SKILL.md` edit goes through skill-creator
4.  Task 4 Phase 2 — A checker test on the previous EDS-26 description *— `.ai/tracker/update-item-EDS-26-previous.json`* Proposed **Depends on** Phase 2 / Task 3
5.  Task 5 Phase 2 — Two sentences in the skill and its criterion checklist Proposed **Depends on** Phase 2 / Task 3 · skill-creator first

Spec 33

## extract reads one design reference per viewport

5 proposed · not counted · overlaps Phase 32

Proposed 2026-10-12 (`33-extract-multi-viewport-spec.md`, local). Several explicit design links on one item become the `viewports` list of `design-reference.json`, widest first; the pack already validates and consumes that list (`write-design-reference.py`, `pair-viewports.py`, `viewport-overrides.py`), so only the input side is single. It departs from D520 and G36 (a multi-frame node is always a question) but an explicit link names its frame; that needs a deviation entry. **Phase 32 reaches the same symptom without extra links,** by finding counterparts by name path from the one linked node; if Phase 32 is built, this spec is probably unnecessary. Decide between them before filing either.

1.  Task 1 Phase 1 — `references=` in the resolver, tests for 1, 2 and 3 links Proposed **Depends on** a choice between this and Phase 32
2.  Task 2 Phase 1 — The writer accepts a list of provider results *— order, equal widths, single-result identity* Proposed **Depends on** Phase 1 / Task 1
3.  Task 3 Phase 2 — The extract flow loops over the links *— a `SKILL.md` edit, through skill-creator* Proposed **Depends on** Phase 1
4.  Task 4 Phase 2 — The deviation entry and a decision record *— in `06-dx-core-deviations.md`* Proposed **Depends on** your yes
5.  Task 5 Phase 3 — Check that the pair and override scripts accept the three-variant file unmodified *— if either rejects it, file a gap, do not edit them here* Proposed **Depends on** Phase 2

Phase 53 · spec 34

## Session tools are checked before the run does any work

complete · 7 of 7 · not counted · freeze exception 2026-10-12

Proposed 2026-10-12 (`34-session-tools-check-spec.md`, local). EDS-26 failed again, at `prototype`, because the Figma plugin was disabled in the session: pre-flight printed `design: ok` (it reads declarations only), `extract` fell back to the attached image as designed (D500) and the run went on for five stages without design values. A pack would declare `session_tools:` (name and remedy); the driver checks them against the session's own registry with `ToolSearch` after `intake` and before anything is recorded, only for packs whose stages will run, and ends `blocked` with the remedy. A script cannot do this (the tool list is a session property), so a small script only decides ok or missing from what the driver found. It narrows pre-flight's "nothing probes live" rule, which needs its own decision entry. It sits after `intake`, not before, because only the fact record says whether the item needs design at all. **Built 2026-10-12 as Phase 53** (D130), stacked branches `phase-53-task-1` … `-task-5`, pushed; merged to `main` as PR \#247 (squash `382e8fe`, read 2026-10-12).

1.  Task 1 `session_tools:` in the manifest contract and its validator *— validator 24, 9 cases (169/0)* Done **Branch** `phase-53-task-1` `2299575` · `phase-53-task-1-done.md`
2.  Task 2 The decision script *— `check-session-tools.sh --list` / `--found`, 30/0, neutral fixtures* Done **Branch** `phase-53-task-2` `d3ba5ab` · `phase-53-task-2-done.md`
3.  Task 3 "Check session tools" node in the driver *— one `ToolSearch`, design only when `extract` runs; stamp `a969a7d9ff02`* Done **Branch** `phase-53-task-3` `2228944` · `phase-53-task-3-done.md` · no test reads the new branch; proven only by Task 7's live run
4.  Task 4 `health` lists the declared tools *— marked "checked by the driver at run time", never looked up* Done **Branch** `phase-53-task-4` `513d839` · `phase-53-task-4-done.md`
5.  Task 5 The figma pack declares its four data tools *— remedy: `/plugin` to enable, `/mcp` to authenticate (docs; your choice)* Done **Branch** `phase-53-task-5` `b98f1c0` · `phase-53-task-5-done.md` · unauthenticated case unmeasured (G185) · README follow-up: `figma-readme-tools` `5949d83`, pushed, no PR; the skill's `/plugin` sign-in text still open (G188)
6.  Task 6 The decision entry and the gaps *— D130; G179 closed; Phase 52 / Task 5 superseded; G185–G188* Done **Record** `phase-53-task-6-done.md` · local docs only · numbering valid (288 identifiers)
7.  Task 7 Verification *— suites 0 failed, checks valid; live: EDS-26 plugin off → blocked, EDS-26 plugin on → four ok: and readiness, EDS-22 plugin off → not blocked* Done **Record** `phase-53-task-7-done.md` · all three on `main` `382e8fe`, 2026-10-12

Phase 37

## Component sizes match the design

6 proposed · not counted

Planned 2026-10-02 in `NEXT.md`, not yet in `02-build-tasks.md`. Comes from a review of `skojic/aem-eds-figma-to-code` (`d44edff`). Two of its rules already exist here and are not borrowed: no fixed size from placeholder copy (`check-size-origin.py`, D541) and waiting for fonts before measuring (`settle.cjs`). Every task measures before it decides. G122, the 2026-10-02 EDS-18 `prototype` fail on `size-[14px]`, is not part of this phase; PR \#202 fixes it.

1.  Task 1 G536 through a work item *— `justify-content: flex-start`, already measured; header text at y 40, header stays 98px* Proposed **Depends on** nothing · item written with `write-specs`
2.  Task 2 Measure exact-equality mismatches *— how many length mismatches in archived reports are under 1px or 2px, and which cost an edit (G125)* Proposed **Depends on** nothing · read `dx-core` first
3.  Task 3 Tolerance with recurrence promotion, or neither *— decided with you from Task 2's numbers* Proposed **Depends on** Task 2
4.  Task 4 Out-of-flow collapse check *— a script, tests first; must not fire on `video` or `embed` (G126)* Proposed **Depends on** nothing
5.  Task 5 Stroke against border box *— measure `box-sizing` in the block against subtracting the stroke in the comparison (G124)* Proposed **Depends on** nothing · decided with you
6.  Task 6 Verification *— suites, then EDS-18 from a fresh session: header 96px, text at y 40, no stroke mismatch* Proposed **Depends on** Tasks 1–5 merged

Phase 9

## Headless execution

1 of 6 remaining

The main track (`NEXT.md`). Tasks 2 and 3 are done: a token comment reaches a gated run, and the runner fetches a work item headlessly under `dontAsk` with an atomic claim per event (D106; PR \#189; verified in CI 2026-10-01). Task 4's policy rails merged in PR \#200 (D107). Task 6's network lock merged in PR \#201 (D108).

1.  Task 5 A headless run, end to end In flight **State** all dependencies done · fixes on `phase-9-task-5-e2e` / `-probe`, not on `main` · three EDS-22 runs did not reach `delivered` · no done record, no PR · **2026-10-13:** run \#35 (EDS-28, `main` `54828ae`, pin `v0.2.2`) passed the fresh start in CI and ran `intake` (**G191** fixed, **G190** closed; the scripts' own answers are not in the log, the driver going on is the evidence). It stopped at the session-tools check: EDS-28 has a design reference and a CI session cannot sign in to Figma, the intended refusal. Next: dispatch an item with no design reference (EDS-22). Still open for this task: a run to `delivered`.

Phase 10

## Design references without an interactive session

4 of 6 remaining

Tasks 1 and 3 are done. This workspace is on the Basic Figma plan, so a headless design reference can only ever carry geometry and a screenshot, never tokens.

1.  Task 2 Declare and enforce non-interactive capability In flight **State** commit `9e5ad16` on local `phase-10-task-2-non-interactive-readiness` only (2026-09-22) · pushed 2026-10-03 as `phase-10-task-2`, same commit · the stash "wip: phase-6-task-5-deny" is a byte-identical duplicate · needs a live `run-route` check in both modes
2.  Task 4 Build it, or record why not *— conditional on Task 3* Ready **Depends on** Task 3 — done
3.  Task 5 Guard the image path that already works Ready **Depends on** Task 1 — done
4.  Task 6 A headless run with a design reference Blocked **Depends on** Tasks 2, 4, 5 · Phase 9 / Task 3 — done

Phase 36

## Authored content as a deliverable

7 proposed · not counted

Proposed by spec 29 (`29-content-authoring-spec.md`, amended 2026-10-02), not approved; G120 and D110 are unfiled. An item with a `## Content` section gets its own Drive page `pages/<item_id>`, previewed (never published), verified, linked from the ticket and the PR, and removed when its PR closes unmerged. It answers Phase 12 / Task 1 with shape (c) and supersedes Phase 12 / Tasks 2–4. Prompt for a fresh session: `phase-36-implementation-prompt.md`.

1.  Task 1 The content-page script and its contract *— create-or-update, list, preview, idempotent remove; real-Drive OAuth check first* Proposed **Depends on** spec approved · OAuth client and `GDRIVE_*` variables
2.  Task 2 Intake and plan *— the content field; pack or core vocabulary decided first* Proposed **Depends on** spec approved
3.  Task 3 Implement and verify on the project's preview server *— measure that it serves previewed content first* Proposed **Depends on** Tasks 1, 2
4.  Task 4 Links in the ticket and the PR *— the branch preview host* Proposed **Depends on** Task 1
5.  Task 5 Cleanup of closed items' pages in `serve` *— from the Drive listing* Proposed **Depends on** Task 1
6.  Task 6 CI *— four secrets in *Run* and the leak check; four hosts, `*.aem.page` measured first* Proposed **Depends on** Task 1
7.  Task 7 Verification *— one route dispatched in CI; you dispatch* Proposed **Depends on** Tasks 1–6 merged

Phase 6

## A second platform

1 remaining · nice to have

Nice to have (2026-09-29): the core is proven on this platform first. Tasks 1–3 are done; Task 5 is listed with the runs above.

1.  Task 4 A second platform Nice to have **Depends on** Phase 6 / Task 1 · Phase 2 / Task 7 — both done

Phase 12

## A reviewable rendered page per work item

4 of 4 remaining

Logged, not scheduled (2026-09-21). The current behaviour implements D87, which forbids publishing test content to manufacture an openable link. Phase 28's local verified link (`localhost:3001/drafts/<item>`) covers part of this for local review only. Spec 29, if approved, answers Task 1 with shape (c) and supersedes Tasks 2–4 with Phase 36.

1.  Task 1 Record the question and decide whether it should exist Nice to have **Depends on** nothing — but read Phase 7 / Task 15's result first
2.  Task 2 Establish what the platform can actually serve *— conditional* Nice to have **Depends on** Task 1
3.  Task 3 Build the chosen shape *— conditional* Nice to have **Depends on** Tasks 1, 2
4.  Task 4 A reviewer opens it Nice to have **Depends on** Task 3

## Open, but not task-shaped

- **Found 2026-10-03, filed 2026-10-05 as G163 and G164 (D125 withdrawn 2026-10-06; drafts stay committed, now synced to the tracker in `9a606c1`)** (`next-phase-41.md`; the zoran-block draft is now parked in `.ai/logs/parked-specs/`): no stage transitions a work item's status, so EDS-5, EDS-7, EDS-13 and EDS-21 read **To Do** after delivery; a committed draft can drift from the live item (EDS-13's AC-7 on `main` is the old wording); the `.gitignore` comment "`.ai/specs/<ticket>/` committed on purpose" (D47) contradicts your rule that drafts never go to `main`. A `zoran-block` bug (paragraphs joined by `textContent`) has a draft in a stash and no item.
- **Phase 10 / Task 2's commit `9e5ad16` (G503's fix) is now on origin as `phase-10-task-2`** (2026-10-03; the original 41-character branch name fails the D544 hook, limit 23, and stays only locally). Phase 41 / Tasks 1–2 done; Tasks 3–5 open.
- **New 2026-10-04 from the delivered EDS-24 run, now Phase 44 (filed 2026-10-05):** G158 (Task 5), G159 (Task 1), G160 (Task 2), G161 (Task 4) and G140's `verify` half (Task 3) are FIXED on `main` (#232–#236 merged 2026-10-05); G157 is Phase 43 / Task 5 (#231, merged). Task 6 done 2026-10-05: **G149, G161, G162, G140, G158 and G159 closed**; G157, G160 and G151 stay FIXED — EDS-25 never reached their case. G514 closed 2026-10-05 with Phase 17 / Task 5. Closed by the EDS-24 run: G144, G150, G155.
- **New 2026-10-03, no task yet:** G140 (`verify-design` measures at 1280, captures at 1440; `verify` hit it too), G141 (a run paused over two hours cannot be resumed, by design), G144 (`verify-design` may have bypassed the browser operations, unconfirmed), G145 (`verify-design` fixes outside the item's scope), G147 (a bare `border` class gives no width row), G148 (viewport variants skip the spill). Closed 2026-10-03 by the EDS-18 run: G137, G138, G139, G143, G146 (and G122). G142 (#216) is fixed and not yet exercised. New from that run: G149 (an already-delivered item cannot reach `deliver`), G150 (`verify-design`'s dead `gap` edit), G151 (column widths graded content-dependent), G152 (driver text still says "at most `warn`"), G153 (an interrupted fresh start leaves a flag with no run state); G154 fixed (prompts pulled inside the driving session). **Phase 42 (2026-10-03/04) fixed G144, G149 (D122), G150, G151, G152 and G153 on six open PRs**; G144 is confirmed from transcripts, G153's consequence corrected (no stage reads the flag). Found on the way, not fixed: the prototype report folds shared-selector rows so they go unmeasured under G150's rule (noted under G150); `variables` reports a variable graded by `compare` as "no line carries its token" (under G151); interactive runs still end `failed` on a satisfied item at the gate (D122, accepted).
- **Open gaps, no task yet:** G510 (`verify` measures the block wrapper, not the styled element), G534 (the draft server is stopped before review), G544 (`interact` does not settle). G536 (header text ~7px high; cause measured) and the new G124, G125 and G126 are now Phase 37. G122 is closed (PR \#202, proved by the 2026-10-03 EDS-18 run). G542 is fixed by EDS-21 (#198); G546 by \#199.
- **`aem-psi-check` (G31):** proven 2026-09-30. A served-path PR on a valid branch passes: \#187 (probe) and \#198 (EDS-21, through the route). An automation-only PR fails by design, as documented. Unexamined: SEO 61 on the branch preview (#187).
- **EDS-20 carries the Jira component `carousel`** from its first version; `logo-cloud` has to be created by hand and set on the item, then `components:` added to its draft and re-written.
- **The shared checkout.** Two sessions share one working tree. A worktree fixes it, but the sandbox cannot run `git worktree add`; the human must.
- **Not re-checked since reported:** `deliver` reading CI before it settles (D534 may cover it); `verify` and keyboard criteria (D69 `interact` may cover it); eslint's missing `require-async-decorate` rule; the `files_named` fallback. ("Run Teardown" is G128, fixed in PR \#206.)
- **G86 is still OPEN.** Phase 7 / Task 15 is done-partial. Carried over; not re-checked in this pass.
- **PR \#112** (`EDS-11`) closed without merging, unexplained. Carried over.
- **Phase 19** is reserved for `23-eval-harness-spec.md`, which is not approved. Not counted.
- **Complete and not listed:** Phases 24, 26, 27, 29, 30, 31, 33 and 34 (33 and 34 have no heading in `02-build-tasks.md`; their records are `archive/next-phase-33.md` and spec 26).
- **Track pointers archived 2026-09-30:** every `next-phase-*.md` (3, 6, 14, 20-23, 25, 26, 27, 28, 32, 33) is in `docs/implementation-plan/archive/`. `NEXT.md` is the single pointer and carries every open item. `next-gaps.md` (the gap-maintenance track, untouched since 2026-09-22) was not reviewed.

## How this was derived

Updated by hand from the previous status and the consolidated `NEXT.md`. Checked against GitHub PR state (#179–#201), `origin/main` at `98c4c5d`, the done ledger in `docs/implementation-plan/` and the gap register. `check-status-claims.mjs` ran on 2026-09-30 after the consolidation: 23 claims across 4 pages, all match. Phase 33 adds 6 tasks and Phase 34 adds 4, all done, to the previous 215; Phase 35 adds 6 open ones (231); Phase 38 adds 4 (235); Phase 39 adds 3 and Phase 40 adds 3 (241). Phase 32's 4, Phase 37's 6 and Phase 41's 5 are not counted until they are in the task list. On 2026-10-02, after Phase 37 was written into `NEXT.md`, `check-status-claims.mjs` checked 29 claims across 5 pages, and all match. On 2026-10-03 it checked 39 claims across 5 pages, all match, after two stale "open" claims for PR \#206 and PR \#209 were corrected. On 2026-10-04, after Phase 42, it checked 45 claims across 6 pages, all match; Phase 42's 7 tasks are provisional and not counted (no heading in `02-build-tasks.md`), so no task changed state. A second pass on 2026-10-03 added the working-tree inventory (`next-phase-41.md`, six claim markers of its own; 46 claims across 6 pages, all match) and changed no task state; the Phase 38 paragraph above had still said \#206 was open and now says merged. After the EDS-23 run the same day, three verification tasks closed (Phase 40 / Task 2, Phase 39 / Task 3, Phase 38 / Task 4) and `check-status-claims.mjs` checked 54 claims across 6 pages, all match. After the EDS-18 verification run that evening no task changed state (it failed at `publish-gate`); six gaps closed and `check-status-claims.mjs` checked 75 claims across 6 pages, all match. After the EDS-24 run on 2026-10-04 no task changed state (it failed at `verify`); G152 and G153 closed, G155 filed, and `check-status-claims.mjs` checked 52 claims across 6 pages, all match. Phase 43 adds 4 open tasks (245); after its Task 1 PR the checker read 54 claims, all match; after Task 2 (closed by its done record, docs only) and the G147/G148 PRs, 58 claims, all match; after \#225–#227 merged and G156 was filed, 60 claims, all match; after Phase 43 / Task 3 opened PR \#229 and G157 was filed, 63 claims, all match (Task 3 is in flight until \#229 merges); Phase 43 / Task 5 (G157) was added at your request (246); \#229 then merged as `3985e0a` and Task 3 is done (218), 63 claims, all match. After the delivered EDS-24 run (Phase 43 / Task 4), four verification tasks closed — Phase 43 / Task 4, Phase 28 / Task 9, Phase 6 / Task 5, Phase 18 / Task 4 (222) — G144, G150, G155 closed, G158–G161 filed, and `check-status-claims.mjs` checked 75 claims across 6 pages, all match. On 2026-10-05, after your answers, PR \#230 merged and Phase 25 / Task 8 was restated and closed on the same run (223); 75 claims, all match. Later the same day the fixing session filed Phase 44 (6 tasks, 252) and opened PRs \#231–#236 — Phase 43 / Task 5 and Phase 44 / Tasks 1–5 are in flight, nothing merged, so no task changed state; D124 filed, D530 amended, G140 and G157–G161 FIXED; `check-status-claims.mjs` checked 93 claims across 6 pages, all match. After you merged \#231–#237, Phase 43 / Task 5 and Phase 44 / Tasks 1–5 are done, and Phase 17 / Task 5 is done under your ruling (230); Phase 23 / Task 4 moves from ready to a live run, Phase 44 / Task 6 from blocked to ready; G514 closed; the claim markers in `NEXT.md` were set to merged and `check-status-claims.mjs` checked 94 claims across 6 pages, all match. Later on 2026-10-05 Phase 44 / Task 6 ran: run B passed (G149 and G161 CLOSED), run A failed at `prototype` (G162 filed); no task changed state, Task 6 moved from ready to blocked, and `check-status-claims.mjs` checked 102 claims across 6 pages, all match. After Run A re-ran to `delivered` (PR \#239) and \#238 merged, Phase 44 / Task 6 and Phase 45 / Task 1 are done (232); Phase 45 / Task 2 moves from blocked to ready; G162, G140, G158 and G159 closed; `check-status-claims.mjs` checked 113 claims across 6 pages, all match. Phase 45 / Task 2's verification then ran and is done (233); Phase 41 / Tasks 3–5 then closed (proposed, not counted: no total changed), and on 2026-10-06 Phase 1 was closed by your decision with the open tasks kept as a backlog (no count changed; 121 claims, all match), D125, G163 and G164 were filed and `check-status-claims.mjs` checked 118 claims across 6 pages, all match; on 2026-10-06 D125 was withdrawn and six drafts were committed to `main` (`9a606c1`), no task state changed, 118 claims, all match; no gap changed; the blocked counter, which had read 4 while five tasks were blocked, now reads 5; `check-status-claims.mjs` checked 114 claims across 6 pages, all match; on 2026-10-06 Phase 46 / Task 6 opened PR \#240 and filed G165–G171 (Phases 46–50 not counted, no total changed), 123 claims across 5 pages, all match.

A task counts as done only with a done-doc and its code on `main`. That keeps Phase 10 / Task 2 open though a done-doc exists. Phase 9 / Task 3 closed 2026-10-01 with `phase-9-task-3-done.md` after its CI runs. A task that touches only local docs is closed by its done-doc alone.

When picking a free phase number, grep `NEXT.md`, every `next-phase-*.md`, the archive and the task list. 32 is taken provisionally by `archive/next-phase-32.md`, 33, 34 and 35 are used, 36 is proposed by spec 29 (`29-content-authoring-spec.md`) and 37 by `NEXT.md`; the next free number is 46 (45 is the size-origin check phase, filed 2026-10-05; 44 is the EDS-24 gaps phase, filed 2026-10-05; 43 is the breakpoint and one-call phase, 42 is the EDS-18-run fixes, 41 is the working-tree inventory, 38 is G129's envelope phase, 39 the design-box phase, 40 the driver-writes-no-verdict phase).

Status as of 2026-10-12 (after Phase 53 closed — live steps 1, 2 and 3 passed; Phase 53 merged to `main` as PR \#247, squash `382e8fe`, live steps 1 and 3 run the same day; earlier: after Phase 47 / Task 9; Tasks 1–9 committed as `414ce1c`, `81a141d`, `93b6e2b`, `876e9c7`, `a95a653`, `b11c0a5`, `3967396`, `d5e7eca` and `0a0c139`, none on `main`), latest commit on `main` `382e8fe` · 233 of 254 done, 21 open (15 required, 6 nice to have) · Phases 32, 36, 37, 41 and 42 proposed, not counted; specs 32 and 33 (2026-10-12) proposed, unnumbered, not counted · derived from `02-build-tasks.md`, `NEXT.md`, the archived track files, the done/partial/status ledger, GitHub PR state and local branch state; working-tree inventory 2026-10-03 (`next-phase-41.md`); task bodies not reproduced

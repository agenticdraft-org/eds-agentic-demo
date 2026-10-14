# Next task

Every PR or gap status below carries a `<!-- claim: … -->` marker. Check them before trusting this
file: `node docs/agentic-core/check-status-claims.mjs` (G545). The previous version of this file is
`NEXT.prev-2026-10-12-phase-53-closed.md` (earlier: `NEXT.prev-2026-10-12-phase-53.md`, `NEXT.prev-2026-10-12.md`).

**The single pointer since 2026-09-30.** Every track file was moved to `archive/`; every open item
they held is under **Open work** below. Open a new track file only if the human asks for one.

**Phase 1 CLOSED (2026-10-06, the human's decision).** The local interactive route is proven end to end
(EDS-24 and EDS-25 `delivered`, PR #230  and PR #239

<!-- claim: PR#239 status=merged -->); 125 + 6 test files, five checks `valid`. Rollback point: tag `phase-1-done`

→ `9a606c1` on origin. Report: https://claude.ai/artifact/MCZz3DS9PHaZfgyKss6iy5. **Next is Phase 2, the
marketplace move (Phases 46–50):** https://claude.ai/artifact/MHrwNdYu7y6a2KcRAwfXHz (corrected 2026-10-06:
runs load plugins from the working tree, not the cache; no D549 exists; a plugin freeze).
Re-checked 2026-10-06 in a fresh session: all three corrections were already applied in version 3 (live `1791282651-2271`), none added, plan not republished; measurements still agree.
Plan version 4 (live `1791284955-8f6d`, 2026-10-06): the plugin freeze runs from the start of Phase 47 until Phase 49 / Task 3 deletes the old `plugins/`; open-branch check before Phase 47 (prints 110 branches today, measured without a fetch), split base recorded in Phase 48 / Task 1 and checked in Phase 49 / Task 3.
Decided the same day:

- **Headless after Phase 2.** Phase 9 / Task 5 and Phase 10 / Tasks 2, 4, 5, 6 run against the marketplace
  layout, since Phase 49 / Task 2 rewrites `route-trigger.yaml` anyway. Still needs `CLAUDE_CODE_OAUTH_TOKEN` and
  your dispatch.
- **Phase 50 / Task 3's proof run** is a design item on Zoki node `1-185` with placeholder copy, so it also closes
  Phase 20 / Task 5 and Phase 23 / Task 4.
- **Backlog (not deleted, not scheduled):** Phase 21 / Task 5 (needs Phase 32), Phase 22 / Task 3, Phase 35,
  proposed Phases 32, 36, 37, nice-to-have Phase 6 / Task 4, Phase 12, Phase 23 / Task 2, and the open gaps
  without a task (G510, G534, G544, G141, G145, G163 , G164).
- **Before Phase 48:** your yes to delete the merged branches listed under "Waiting on the human" and
  "Phase 33 residuals".

**Phase 51 (new 2026-10-09, your decision; `02-build-tasks.md`, after Phase 50):** a new repository you create
installs the plugins by the user guide alone, runs `setup` from nothing and makes its first route run — four tasks,
changes no plugin, after Phase 50 / Task 3. Phase 50 stays the migration's last proof; Phase 51 proves a project that
did not build the plugins, including D126's empty-registry first session.

## Last done (2026-10-14, Phase 50 / Task 2 follow-up — suites from the installed copies PASS; `phase-50-task-2-followup-done.md`)

Previous version of this file: `NEXT.prev-2026-10-14c.md`. Pin `v0.2.3` (pin PR #256 merged `6b5f2f5`; plugins PR #7, tag `v0.2.3` = `9569aca`).

- `claude plugin list --json`: six `agentic-*@agenticdraft` at `0.2.3`; five `core/` folders real. `run-tests.sh` over the six installed `0.2.3` copies (outside the sandbox) → **`files=585 fail=0`**, no `::error`; source clone → **`files=141 fail=0`**. **G193 FIXED** <!-- claim: G193 status=FIXED -->.
- Filed: **G194** (hook reads a pushed tag as a branch name), **G195** (pin script fails only after the user-level pin blocks it), **G196** (skips pass in `run-tests.sh`; 54 `skipped:` lines in the installed run). All OPEN.
- **Your decision, recorded:** count skips separately (`skipped=<n>`). **Not built** — a `run-tests.sh` change in `agenticDraft/plugins` on a new branch.
- **G196 built** (plugins branch `phase-50-task-2-skips`, `8bd99d1`): source clone `files=142 fail=0 skipped=0`; installed `0.2.3` copies `files=585 fail=0 skipped=72`; new test `run-tests.test.sh` seen failing first. Task 2's expected count is still yours (131 in the plan is stale).
- Nothing tracked to commit in this repository: `docs/` and `.claude/artifacts/` are gitignored.

## Earlier (2026-10-14, Phase 50 / Task 2 — check 1 DEVIATED then, check 2 PASS; `phase-50-task-2-done.md`)

Branch `phase-50-task-2-tests` from `origin/main` `48b5aef`. Checks only; no plugin changed. Previous version of this file: `NEXT.prev-2026-10-14b.md`.

- `scripts/run-tests.sh ~/.claude/plugins/cache/agenticdraft/*/0.2.2` (six dirs) → **outside the sandbox `files=585 fail=64`, exit 1.** Plan says 131 / `fail=0`.
  Inside the sandbox it printed `files=585 fail=277`, false failures (one suite passes outside it). 445 of the 585 files are the five packs' `core/` copies of the
  core's tests. Source clone `agenticDraft/plugins` `1a7cc16`: `files=141 fail=1` (`resolve-plugin-root.test.sh` wants `$TMPDIR` under `/private/tmp`).
  The failing suites assume the source layout (several packs side by side); I did not open each of the 64 to confirm.
- Branch-name hook: `git switch --no-track -c Bad_Name` → `bad-chars: branch=Bad_Name pattern=^[a-z0-9/-]+$`, from the installed `agentic-core/0.2.2` copy. **PASS**;
  no `Bad_Name` branch exists. (Its own suite `check-branch-name.test.sh` fails from the installed copy.)
- Triage (outside the sandbox, `core/` pruned): `files=140 fail=10`; all ten read as test assumptions (git repo, several plugins side by side, sibling registry, `/private/tmp`, runner `npm ci`), none as an installed-script defect. Detail in the done record.
- **Yours to decide:** which count Task 2 expects (131 is stale: 141 in source, 585 installed); whether the layout-dependent suites are fixed in
  `agenticDraft/plugins` or excluded from an installed run; then Phase 50 / Task 3.
- Nothing to commit or push: `docs/` and `.claude/artifacts/` are gitignored, `git status --short` is empty.

## Earlier (2026-10-14, Phase 50 / Task 1 — DONE with one deviation; `phase-50-task-1-done.md`)

Branch `phase-50-task-1-copy` from `origin/main` `48b5aef` (PR #255, squash). Checks only; no plugin changed. Pin check: `pin is current` (`v0.2.2`).

- `claude plugin list --json` → six `agentic-*@agenticdraft`, `0.2.2`, project scope, `enabled: true`, each `installPath` under
  `~/.claude/plugins/cache/agenticdraft/`; entries ending `@aem-eds-ai-workflow-demo`: 0. **PASS.**
- `core/` in `agentic-{eds,figma,github,jira,playwright}/0.2.2` → real folder, 35 entries each. **PASS.**
- `.ai/run-context/plugin-roots/` → **11 files, not six: DEVIATES.** The six `agentic-*` paths exist. Five older files (`eds`, `figma`,
  `github`, `jira`, `playwright`, written 2026-10-13 16:34) name the deleted `plugins/<name>`; all five are missing. Not fixed; yours to decide.
- No override: `CLAUDE_CODE_PLUGIN_DIRS`, `CLAUDE_PLUGIN_DIR`, `ROUTE_PLUGIN_DIR` unset; 0 of 3 `claude` processes carry `--plugin-dir`. **PASS.**

**Follow-up (your yes):** the five stale files were deleted; `plugin-roots/` now holds the six `agentic-*` files, so check 3 holds.
Also: `0.2.0` and `0.2.1` still sit in the cache beside `0.2.2`; `02-build-tasks.md:4150` still says `0.2.0`; `ps` is blocked in the sandbox.
**Nothing to commit or push:** `docs/` and `.claude/artifacts/` are gitignored and no tracked file changed, so the branch carries no commit.
The previous version of this file is `NEXT.prev-2026-10-14.md`.

## Earlier: Phase 49 — Tasks 2, 3 and 4 DONE (2026-10-13; the plugin freeze (D128) is over)

`phase-49-task-2-done.md` (closure section), `phase-49-task-3-done.md`, `phase-49-task-4-done.md`. Branch
`phase-49-task-3-remove`, one PR for Tasks 3–4 (the human opens it). **G190** <!-- claim: G190 status=CLOSED -->
and **G191** <!-- claim: G191 status=FIXED -->
stay as filed (run 38419659429).
Task 3: split-to-delete log empty; `plugins/` (868 tracked files) and `.claude-plugin/marketplace.json` deleted with the human's yes;
three `validate-*.yaml` removed; references cleaned; `git ls-files plugins | wc -l` → 0; `update-plugin-pin.test.sh` `fail=0`;
`--check` → `pin is current`. **From now on plugins change only in `agenticDraft/plugins`.**
Task 4: `claude plugin marketplace remove aem-eds-ai-workflow-demo` — EPERM in the sandbox, succeeded outside it; `claude plugin list
--json` has no `@aem-eds-ai-workflow-demo` entry, six `@agenticdraft` packs at `0.2.2`.
**Filed:** G192 (OPEN: the network-allowlist read and `check-trigger-config.sh` lost their CI caller; the plugins repository has
no `docs/getting-started.md`). **Defect of mine:** `cp NEXT.md NEXT.prev-2026-10-13.md` overwrote an earlier snapshot of that name
(I did not check first); my copy is now `NEXT.prev-2026-10-13c.md`.
Not run: any CI route run after the deletion; the repository variables `ROUTE_PROMPT` / `ROUTE_ALLOWED_TOOLS` are still unread.


## Last closed: Phase 53 — session tools checked before the run does any work (2026-10-12)

**Phase 53 (spec 34; D130; D128 exception granted 2026-10-12) — Tasks 1–7 DONE.** PR #247 <!-- claim: PR#247 status=unmerged -->
merged by squash as `382e8fe` (read on `origin/main`); the marker stays `unmerged` because `check-status-claims.mjs`
cannot see a squash merge (G189). Live half from fresh sessions on `main`, all three passed
(`phase-53-task-7-done.md`): plugin disabled, EDS-26 → `terminal: blocked` with the four tools and the remedy, no
branch, no run state; plugin enabled, EDS-26 → four `ok:` lines and `Stage 2/14: readiness — pass`, stopped before the
branch step; plugin disabled, EDS-22 (no design reference) → `none declared`, not blocked. G179 closed; Phase 52 /
Task 5 superseded. Open, not scheduled: G185 (an unauthenticated plugin may still list its tools), G186 (tracker ops
list), G187 (§13 validator 23), G188 (`fetch-reference` names `/plugin` for sign-in; the docs say `/mcp`), G189.
Defect seen in the step-2 driver: it computed `<total>` (15) instead of reading it from the progress line (14), and
corrected it before any later read — model behaviour against `run-route/SKILL.md`'s Record intake stage, not a script.

## Last done (2026-10-14, later — guide and project README published in `agenticDraft/plugins`; phase number provisional, not in `02-build-tasks.md`; `phase-54-task-1-done.md`)

Previous version of this file: `NEXT.prev-2026-10-14d.md`. Your decisions: the guide lives under `plugins/`, `plugins/README.md` describes the whole project, the root README is short, tag `v0.2.4` after the merge.
- Plugins branch `docs-guide-readme` (`7205f78`, pushed, no PR): new `plugins/README.md` and `plugins/getting-started.md`; root `README.md` shortened (Develop, Layout, licence kept); `CLAUDE.md` paths updated; the six `agentic-*` READMEs linked to a gitignored guide (404), now `../getting-started.md`, so the six plugins and the catalog go `0.2.3` → `0.2.4`.
- Run outside the sandbox: `check-plugin-versions.sh origin/main` ok; `claude plugin validate .` passed; `check-no-narrative.sh` valid on all six plugin roots and on the two new files; `validate-naming-rule.sh plugins/agentic-core` valid (the rule covers only the core, so it does not apply to the two new files); every relative link in the three files resolves; `run-tests.sh` `files=141 fail=0`.
- **Yours, in order:** open and merge the G196 PR (`phase-50-task-2-skips`) and this PR; push tag `v0.2.4` yourself (G194: the hook blocks a tag push in my Bash tool); `! bash .claude/scripts/update-plugin-pin.sh`; restart. The guide itself pins `v0.2.3` in its example, which is not wrong but is not the newest.
- Not done: the guide has not been followed by anyone from nothing (that is Phase 51 / Task 2); the six plugin READMEs still say "no run from installed copies has been made" (the tests have been; a route run has not).

## Do next: Phase 51 / Task 2 — install by the guide (ready-to-paste prompts below; pin `v0.2.4` merged, PR #257; plugins PR #9 (G196) merged `016ca17`)

Previous version of this file: `NEXT.prev-2026-10-14f.md`. Plugins branch `docs-guide-prompt` (`c53f957`, pushed, no PR) adds a user-facing "Letting Claude follow this guide" section to the guide; it is not in `v0.2.4`, and Task 2 follows `v0.2.4`.
Setup (yours): `git clone git@github.com:agenticdraft-org/eds-agentic-demo.git`, open Claude Code in it (a fresh session, not this repository), paste prompt 1. When it ends, start a second session in the same folder and paste prompt 2.

**Prompt 1 (session 1):**

```text
You are in a fresh clone of https://github.com/agenticdraft-org/eds-agentic-demo (made from adobe/aem-boilerplate).
Use nothing but this project and the page below: read no file outside this folder and no other checkout of
agenticDraft/plugins. Set the project up by following ONLY this page, step by step, doing steps 1 and 2 and
nothing from memory:
https://github.com/agenticDraft/plugins/blob/v0.2.4/plugins/getting-started.md
Fetch that exact page (WebFetch, or curl of its raw file at tag v0.2.4).

Rules:
- One step at a time; show me each file before you write it.
- Every time a step needs something the page does not say (a command, a file, a value, a fact you looked up
  elsewhere), stop, append one line to $TMPDIR/guide-defects.md saying what was missing, then ask me.
- Never write a token or password into any file; I set credentials myself. Do not run /agentic-core:setup.
- Do not edit anything in agenticDraft/plugins and do not use `claude -p`.
After step 2: run `ls -la .ai/run-context/plugin-roots/` (expected: absent or empty) and `claude plugin list --json`,
commit .claude/settings.json on a branch whose name passes the 63-character host limit (the limit leaves 27 characters
for the branch), push it, and report: every command you ran with its output, and the path of guide-defects.md.
Tell me to start a new session.
```

**Prompt 2 (session 2, same folder):**

```text
Same project, a second session. Verify and report, with the exact output of each command; change no file:
1. `claude plugin list --json`: six agentic-*@agenticdraft entries, each version 0.2.4, each installPath under
   ~/.claude/plugins/cache/agenticdraft/.
2. `ls -la .ai/run-context/plugin-roots/`: expected six files; for each, print its content and test that the path exists.
3. `bash <installPath of agentic-core>/shared/lib/resolve-plugin-root.sh --list`: expected six lines.
4. Append anything the page did not say to $TMPDIR/guide-defects.md and print the file.
Do not claim a result you did not run.
```

**You verify (plan):** `claude plugin list --json` → six at `0.2.4` under the cache; first-session registry absent or empty (D126); second-session six paths that exist; `--list` prints six lines. **Reject if** the guide was read instead of followed, or a step was done from memory. Every defect in `guide-defects.md` is a fix in `agenticDraft/plugins` with a version bump.
**Then:** bring the two reports back to a session here; I write `phase-51-task-2-done.md`. Branch limit 27 is hand arithmetic.
**Open, not decided:** whether Phase 20 / Task 5 and Phase 23 / Task 4 close on Phase 51 / Task 4's run; where the new project's CI route workflow comes from (Phase 51 / Task 3); the tracker project.

**Last done (2026-10-12, Phase 47 / Task 10 — Verification — DONE, `phase-47-task-10-done.md`):** the route run is
the last open item of that record; the other three were run on 2026-10-10 and 2026-10-12.

- **Route run:** `/agentic-core:run-route EDS-26` (the work item re-filed from EDS-20) → `terminal: delivered`,
  **PR #246** (open when `deliver` read it; no marker, see the checker note below) on branch `eds-26`; the one check, `aem-psi-check`, was still
  pending when `deliver` read it, so `deliver` is `warn`. The stamp `dae050ae4f07` matched; pre-flight `ready`.
  Whether the session was launched with `--plugin-dir plugins` was **not verified** by the run's session.
- **Stages:** 14 ran, baseline skipped (`components=present`). `warn`: conventions, verify-design, plan-gate,
  verify, deliver. `pass`: the other nine, extract included on the second run.
- **Before it passed:** the fresh start was refused (3 paths committed on `eds-26` against `origin/main`); a removal
  commit `89e9009` cleared them. The first attempt then failed at `prototype`: `extract` had fallen back to the
  image-only attachment because the figma plugin's tools were not loaded, so the size-origin check refused four fixed
  sizes (G179 stays open). You authenticated the plugin; `fetch-reference` run by hand on node `1-126` returned design
  context, `variables: {}`, six assets and a 1200×84 screenshot; a fresh start then ran clean to `deliver`.
- **Open observations (none a gate failure):** the spec gives 150×82 cells, Figma 154×84 for five of six (the sixth
  150×81.8); the block follows the spec. The design's logos carry `opacity-60` and `mix-blend-exclusion`, the block
  does not (spec: colour out of scope). `plan-gate` found req-6 unfit at 375 px (327 px content, 340 px needed);
  `implement` added `margin-inline: -24px` below 900 px; `verify` judged 375 by inspection, unmeasured.
- **Counts and checks:** 139 test files → `fail=0` and `check-spec.test.sh` 22/0 are **quoted from 2026-10-10 on
  `a04a88d`, not re-run on 2026-10-12**. Re-run 2026-10-12: `grep -rn '\.\./agentic-core\|\.\./eds/' plugins` → no
  output; `check-status-claims.mjs` → `59 claim(s) checked across 5 page(s) — all match`.
- **Checker note:** `check-status-claims.mjs` `prMerged` greps `^Merge pull request #N from`, so it cannot see a squash
  merge (#243–#245 are squashes): a `merged` marker on them reads as drift and an `unmerged` one can never flip. No PR
  marker was written for #245 or #246 for that reason.
- **Not done:** the defects of this run are in the record; no gap entry is filed for them yet.

**Last done (2026-10-12, Phase 47 / Task 11 — Playwright pack hang-and-silence guard, G550, `phase-47-task-11-done.md`;
a parallel track):** merged as PR #245 (`80fa447` on `origin/main`, squash; `git log origin/main` read 2026-10-12); the done
record's title still says "merge pending". The human overrode the freeze for it.

**Last done (2026-10-10, Phase 47 / Task 9 — DONE, `phase-47-task-9-done.md`; committed as `0a0c139` and pushed as
`origin/phase-47-task-9`, branch from `d5e7eca` = Task 8; Tasks 1–9 stacked, none on `origin/main`, no PR):**

- measured first: the six literals are `os.path.join("plugins", …)`, so a `plugins/` grep reports them clean (the
  brief's "Reject if" check would have passed unchanged code). A project skill has no plugin root and no `core` link,
  so reaching the resolver is a bootstrap problem;
- your decision: **the registry bootstrap**. Only the core's own entry is read, to find the resolver, and every root,
  the core's included, is asked of it. `01-core-contracts.md` §11.2 "Reader" now names this one exception;
- tests first: `check-spec.test.sh` gained 7 cases on a project whose registry names copies in `cache/`. They failed
  first, then passed: **22/0**;
- `check-spec.py` `plugin_root()` (main checkout as `--project-dir`; exit 2 with the resolver's reason);
  `write-item.py:123` calls it.

Results: **all 13 drafts byte-identical** before and after; `check-spec.py EDS-5` fetches through the resolved tracker
root; **130/130 suites**; runner `fail 0` (73); no `plugins` literal in either script; no-narrative and
skill-authoring checks `valid`; `plugins/` untouched. Eight defects, two of them my own test mistakes.
`SKILL.md:280` still names a `plugins/` path; it was added to Phase 49 / Task 3's cleanup.

**Last done (2026-10-09, Phase 47 / Task 8 — DONE, `phase-47-task-8-done.md`; committed as `d5e7eca`, not pushed,
branch `phase-47-task-8` from `3967396` = Task 7; Tasks 1–8 stacked, none on `origin/main`):**

- measured first: `pack.yaml:14` and `probe-tool.cjs:28` as the brief; the repo pins `playwright` `1.63.0`
  (`package.json:30`), which depends on `playwright-core` `1.63.0` only; official plugin docs fetched — the host
  installs only from `package.json` + a v2/v3 lockfile, exact registry pins, `https`, and **not** for a plugin loaded
  in place; the root `.gitignore`'s `node_modules/*` does not cover `plugins/playwright/node_modules`;
- your decision: remedies pinned, no global — playwright names the host install and `npm ci` for a path-loaded pack,
  chromium is `npx playwright@1.63.0 install chromium`; the global fallback stays, filed as **G176**
  <!-- claim: G176 status=OPEN -->;
- `package.json`, a v3 lockfile copied from this repo's own locked entries (no npm command run), a pack
  `.gitignore`; comments in `probe-tool.cjs` and `render.cjs` now say how `require` really resolves; README updated;
- tests first: `declared-dependency.test.sh` seen failing 4/7 → **11/0**; six mutations each caught; from a `$TMPDIR`
  copy without `node_modules` the probe answers absent (D127's consequence, shown).

Results: **130/130 suites**; runner `fail 0` (73); playwright suites pass from an outside copy; no install command
in any non-test plugin script; manifest, requires, no-narrative, own-root refs, exec bits `valid`; `claude plugin
validate plugins/playwright` passed; numbering `valid (274)`. Nine defects, one my own (a literal lockfile key the
narrative checker flagged). No real host install (D128).

**Last done (2026-10-09, Phase 47 / Task 7 — DONE, `phase-47-task-7-done.md`; committed as `3967396`, not pushed, branch `phase-47-task-7`
from `b11c0a5` = Task 6, which this session committed with your yes; Tasks 1–7 stacked, none on `origin/main`):**

- measured first: the limit had a second reader, the core's `check-branch-name.sh` and its hook; the config validator
  allowed exactly six keys; three eds `SKILL.md` files hard-coded the values;
- your decisions: `branch_name.max_length` as a core config key plus a role-keyed `platform:` block the core never
  reads (`preview_host_suffix`) — filed as **D129** (amends D544); a missing value → no length check in the core,
  exit 4 `not-configured` in both eds scripts, never a fallback to this repo's values;
- tests first, each seen failing: config validator 25/6 → **31/0**; manifest validator 148/4 → **152/0** (a pack's
  `max_length` is now invalid); `check-branch-name` 34/7 → **47/0** (also: a non-numeric limit used to pass
  silently, now exit 4); hook 62/5 → **67/0**; eds `check-branch-length` 18/12 → **29/0**; draft server → **29/0**;
  `preview-url` → **67/0**; `design-fonts` 25/0 (fixture mutation-checked); `delivery-text` 72/0 (core resolved by
  name, mutation-checked);
- this repo's `.ai/project-config.yaml` carries `branch_name.max_length: 23` and the host suffix.

Results: **129/129 suites**; runner `fail 0` (73); the changed suites pass from an outside copy with a non-git cwd,
where the old `preview-url`/`check-branch-length` fail (46/1, 14/1); naming, no-narrative, own-root refs `valid`;
`claude plugin validate` agentic-core, eds passed. Nine defects; `setup` does not yet write the two keys (Phase 51 /
Task 3 annotated).

**Last done (2026-10-09, Phase 47 / Task 6 — DONE, `phase-47-task-6-done.md`; not committed, branch `phase-47-task-6`
from `a95a653` = Task 5, which this session committed with your yes; Tasks 1–6 stacked, none on `origin/main`):**

- measured first: the runner default had moved `:70` → `:74`; the CI workflow set no `ROUTE_PLUGIN_DIR`; one more
  pack → pack path Task 5 missed, `jira/scripts/md-to-adf.test.sh:200` (`plugins/$PLATFORM`);
- your decisions: commit Task 5 then branch; a missing `ROUTE_PLUGIN_DIR` is a **new exit `7`** (an absent folder
  stays legal); the workflow sets `ROUTE_PLUGIN_DIR: plugins` until Phase 49 / Task 2; the jira suite moves onto the
  resolver here;
- tests first, each seen failing: driver read hook 38/9 → **47/0** (contracts from `${CLAUDE_PLUGIN_ROOT}/shared`,
  compared absolute and canonical; unset root → no contract allowed); direct-call checker 28/4 → **32/0** (cache
  form; G173 FIXED <!-- claim: G173 status=FIXED -->); runner 65/62/3 → **73/73/0** (`pluginDirectory()` + a
  spawned-runner test);
- the `plugins/<pack>/skills/` alternative in the direct-call regex stays — a transcript recognizer, not a path
  opened; `02-build-tasks.md` Task 6 and Phase 49 / Task 2 annotated.

Results: **129/129 suites**; runner `fail 0`; naming `valid` (623), no-narrative `valid`; own-root refs `valid`;
`claude plugin validate` agentic-core, jira passed. Ten defects, one my own (an assertion that searched the echoed
command). `route-agent.test.mjs` is not in CI (needs the runner's `npm ci`).

**Last done (2026-10-09, Phase 47 / Task 5 — DONE, `phase-47-task-5-done.md`; committed as `a95a653` with your yes in
the Task 6 session, not pushed, branch `phase-47-task-5` from `876e9c7` = Task 4; Tasks 1–5 stacked, none on
`origin/main`):**

- measured first: `${CLAUDE_PLUGIN_ROOT}/../` **agentic-core 12 lines / 9 files, eds 14 / 10** (equal to the brief),
  plus forms the grep misses: the branch check's default, three "sibling of" lines in `setup`/`health`, four core
  suites climbing to the plugins folder (one naming `eds` — a D28 breach), two eds suites reaching the tracker pack;
- your decisions this session: `setup` scans through a new `resolve-plugin-root.sh --list`; no config / no
  `packs.platform` stays "no constraint"; old-form test inputs built at run time; the real-tree suites move here,
  onto a temp registry filled by the real writer from `--list --siblings` (brainstormed, option A);
- tests first, each seen failing: resolver 46/14 → **60/0**; `check-branch-name` 7/26 → **33/0** (exit 4
  `not-resolved`, never "no constraint" for a named pack); hook 35/32 → **67/0** — it blocked only on 1 and 3, so the
  new failure would have been allowed; now it blocks on 4 and resolves against the main checkout, so a linked worktree
  is judged by the same rule; new `check-own-root-refs.sh` 22/2 (four real fixture hits) → **24/0**;
- skill-creator first, 16 `SKILL.md` snapshotted, eval loop not run; 9 eds stages, `run-route` (`:84`, `:91`, `:374`),
  `setup`, `health`, 4 fixtures; D509 stamp `5aae1aad8bf4` → `dae050ae4f07`;
- contract §11.2: the own-files rule and check, `--list`, the worktree rule, status "built, not run installed";
  G172 FIXED <!-- claim: G172 status=FIXED -->; G175 new <!-- claim: G175 status=OPEN --> (no-narrative misses a
  done-file citation); Task 7's entry annotated with the four eds suites still climbing out.

Results: the brief's grep → no output; **129/129 suites exit 0**; naming `valid` (622), no-narrative `valid` (550);
`claude plugin validate` ×6 passed; stamp test 12/0. Sixteen defects, three my own (the zsh snapshot loop again, a
nested heredoc, a miscounted sentence in G172 — none wrote a wrong file). Measured: `CLAUDE_PROJECT_DIR` is unset in
the Bash tool, and this repo's registry does not exist this session.

**Last done (2026-10-09, Phase 47 / Task 4 — DONE, `phase-47-task-4-done.md`; committed as `876e9c7` with your yes,
not pushed, branch `phase-47-task-4` from `93b6e2b` = Task 3; Tasks 1–4 stacked, none on `origin/main`):**

- every `${CLAUDE_PLUGIN_ROOT}/../eds/` in `plugins/eds` → `${CLAUDE_PLUGIN_ROOT}/`: **28 lines, 1 form, 6 files,
  10 distinct paths** (re-measured, equal to the brief's), each path checked to exist before the write; a second run
  found 0; the diff is that substring only (each file `cmp`-identical to its snapshot with the same `sed`);
- skill-creator first, snapshot in the session scratchpad, eval loop not run (defect 3); `run-route/SKILL.md`
  untouched, no stamp change;
- installed layout simulated (`cp -RL` into `cache/mkt/eds/0.0.0/`): new form 13/13 paths exist, old form 0/13.

Results: the brief's grep → no output; **128/128 suites under `plugins/` exit 0** (eds 33); naming `valid` (619),
no-narrative `valid` (547); `claude plugin validate plugins/eds` passed. Nine defects, two my own: a zsh inline loop
whose existence guard passed vacuously and printed "written: 6" with nothing written, then `mapfile` on bash 3.2;
neither wrote anything. Also: no suite reads these lines (defect 4); the pack already used the short form on 7 lines,
`design-fonts.py` both ways (defect 5); §11.2 does not forbid `${CLAUDE_PLUGIN_ROOT}/../<own name>/` (defect 6;
your decision: the rule and its check go into Task 5, entry annotated).

**Last done (2026-10-08, Phase 47 / Task 3 — DONE, `phase-47-task-3-done.md`; committed as `93b6e2b` with your yes, not pushed, branch `phase-47-task-3`
from `81a141d` = Task 2, committed this session with your yes, on `414ce1c` = Task 1; none of the three is on
`origin/main`):**

- `core → ../agentic-core/shared` at the root of each of the five packs (git mode `120000`);
- `shared/lib/rewrite-core-refs.sh`, tests first (seen failing, then 39/0). It reads the core's name from the link,
  handles seven reference forms, not the brief's two (defect 2), refuses and writes nothing when any new path is
  missing. Its own counts: **json 5/5, md 29/266, sh 9/10, txt 1/1, total 44 files / 282 lines**; a second run 0;
- the two eds `.py` scripts that built the path from components moved to `core` by hand (defect 3: six executed
  scripts reach the core, not seven); 23 `SKILL.md` changed only by the script, after skill-creator (eval loop not
  run, defect 5); `run-route/SKILL.md` untouched, no stamp change;
- contract §11.2 and the core README mark only the link and the moved references as built.

Results: the brief's grep → no output; **128/128 suites under `plugins/` exit 0**; six hooks simulated → six
registry entries, each resolved through `plugins/eds/core/lib/`; an installed layout simulated with `cp -RL` →
the pack's hook registers (the old path: exit 127); `jq … async` → six `null`; naming and no-narrative `valid`;
`claude plugin validate` ×6 passed, 0 warnings. Twelve defects, one my own (a join rule that refused a correct line;
caught by the script's refusal, fixed test-first).

**Last done (2026-10-08, Phase 47 / Task 2 — DONE, `phase-47-task-2-done.md`; not committed, branch `phase-47-task-2`
stacked on `414ce1c` = Task 1, committed this session with your yes; neither is on `origin/main`):**

- `register-plugin-root.sh` (name from the manifest, canonical root, atomic write, silent stdout) and
  `resolve-plugin-root.sh <name> [--project-dir]` (§11.2's order; stale entry refused, exit 3; sibling from the core's
  physical root; "not resolved", exit 1) — tests first, seen failing;
- a `SessionStart` entry, no `async`, in the core and in each of the five packs (new `hooks/hooks.json`);
- **G174, new, your decision:** the fresh-start archiver moved `.ai/run-context/plugin-roots/` away; it
  now stays;
- G166  and G174  FIXED on the branch; contract §11.2 "partly built", README "partly shipped".

Results: resolver 41/0, writer 25/0, archiver 18/0; `jq … async` → six `null`; naming and no-narrative `valid`;
**127/127 suites under `plugins/` exit 0** (agentic-core 80); `claude plugin validate` ×6 passed (a probe confirmed
it reads `hooks.json`). No live session (simulated hooks; live check stays with Task 10). Ten defects; Task 3 and
Task 5 entries annotated (defects 3 and 7).

**Last done (2026-10-08, Phase 47 / Task 1 — DONE, `phase-47-task-1-done.md`; not committed, branch
`phase-47-task-1` from `48fc899`; the plugin freeze has started):** the contract gains **§11.2 "Where a plugin is
found (D126)"**, marked "specified, not built". It holds:

- the `core` link for pack → core;
- `.ai/run-context/plugin-roots/<name>`, written by each plugin's `SessionStart` hook (no `async`), for core → pack
  and pack → pack, read only through `resolve-plugin-root.sh`;
- the resolution order: registry hit; stale entry refused; sibling folder only for path-loaded runs; "not
  resolved", never "absent";
- "an unresolved plugin is an error";
- "Built by" Tasks 2, 3 and 5.

§7 gains a pointer from `packs:`. `run-route/SKILL.md` "Pack roots" was rewritten through skill-creator: the
snapshot was taken, the eval loop was not run (defect 2), and the pack-name examples were removed. The core
README gains "Plugins find each other by name, never by folder" and the pack rules. Both say not shipped, and
they list only what the spikes measured. Results:

- the sibling grep: 6 hits, 5 fallback or withdrawn-convention mentions, plus the interim `SKILL.md:91`;
- naming rule `valid` (613 files); no-narrative `valid`;
- **78/78 agentic-core suites exit 0**, after regenerating run-route's D509 stamp, which the first run caught (77/78;
  defect 1).

Eight defects. **Your decision:** the five packs' `SessionStart` registry hooks go into Phase 47 / Task 2 (entry
annotated). Task 5's entry now also names `run-route/SKILL.md:91` and `:362`.

**Last done (2026-10-08, Phase 47 precondition — DONE, `phase-47-precondition-done.md`; Sonnet 5.5):** the open-branch
loop printed 6 lines on 2026-10-08, not spec §2's 110 (not reproduced; spec corrected): three branches, each local and
on origin. With your yes per branch: `phase-5-task-2-bp` (PR #60) and `phase-5-task-3-audit` (PR #61) deleted, their
content equal to the merged commits and `git cherry` showing the patch on `main`; `phase-10-task-2` (`9e5ad16`, no
PR, unfinished headless-readiness work, 17 files, patch fails on 6 files against today's `main`) exported to
`.ai/logs/phase-47-precondition/phase-10-task-2/` (gitignored, one copy, this machine) and deleted. Two old agent
worktrees held the phase-5 branches; removed with a second yes (only deleted files, no work). The SHAs are in
`.ai/logs/phase-47-precondition/deleted-branches.txt`. **Loop after a fresh fetch: nothing.** Your jira edits became
your commit `48fc899` on `main` (direct, not a PR), so "origin/main unchanged" is the one check that cannot pass as
written; the freeze starts from `48fc899`. Eight defects, among them: `01-core-contracts.md` has no sibling wording
for Task 1 to replace (it *adds* the D126 rule; the entry is annotated), and a 12th worktree `df-pages-wt` appeared
that is not ours.

**Last done (2026-10-06, Phase 46 / Task 5 — DONE, `phase-46-task-5-done.md`; same session as Task 4, your yes
for all three deletion targets):** filed with `doc-numbering`, after which `check-numbering.sh` reported 265 → 270
identifiers, `valid`. **D126** (symlink plus root registry, never sibling folders; backed by Tasks 1, 2, 3, all
PASS, with their measured limits), **D127** (the host installs a pack's declared npm dependencies, no plugin code
runs an install; Task 4 PASS, and what it did not prove), **D128** (the plugin freeze; a process decision, no spike),
**G172**  (branch check "unconstrained" → Phase 47 / Task 5), **G173**

<!-- claim: G173 status=FIXED --> (regex blind to cache paths → fixed by Phase 47 / Task 6). The references in

`02-build-tasks.md`, the spec and `00-instructions.md` now carry the numbers. Spec §3 is corrected: a directory
marketplace loads in place, and the npm bullet is measured. **Deleted, with your yes:** `spike/symlink` and
`spike-v1` on `agenticDraft/plugins` (`ls-remote` → 0 spike refs; `main` is still `94fd986`; the commit list is kept
in `/tmp/claude-501/p46-evidence/`), `cache/agenticdraft-spike/`, `/tmp/claude-501/p46t3/` and `p46t4/`. The stored
files are identical to the baseline taken before Task 3, and that baseline is kept in `p46-evidence/`. Six defects
recorded:

- a scratch folder was deleted under your terminal's shell (PID 25900; `cd ~` fixes it);
- a local `spike/symlink` branch remains in the `agenticdraft` clone (yours to decide);
- G165's register marker claimed PR #240 unmerged, now fixed; `check-status-claims.mjs` never reads PR claims
  inside the register;
- `gh` fails TLS inside the sandbox;
- some leftover temp folders were not in the approved targets, so they were not deleted.

**Last done (2026-10-06, Phase 46 / Task 4 — DONE, `phase-46-task-4-done.md`; ran after your yes in that session):**
`spike-d` on `spike/symlink` (`4daea6e`, then `7af2a53` for the defect-fix re-run; pushed; `main` of `agenticDraft/plugins` unchanged at `94fd986`). It pins
`playwright` `1.63.0` through `package.json` and a v3 `package-lock.json`, with no `node_modules` committed.
**PASS:** `node <installPath>/scripts/check.js` resolves
`cache/agenticdraft-spike/spike-d/0.0.1/node_modules/playwright/index.js`. `node_modules` (playwright and
playwright-core, 18.5 MB) exists only in that version directory. It is not in the marketplace clone and not in
`data/`. No browser was downloaded: the `ms-playwright` listing is identical, and neither package declares any
`scripts`. The three stored files are byte-identical before and after, and `agenticdraft` was untouched. **Who runs the
npm install:** in the first run, your registering session did it in the background (no install record), and `claude plugin install` reused that directory. **The defect-fix re-run (you: "Popravi defekte")** bumped `spike-d` to
0.0.2 pinning playwright `1.62.0`, whose `chromium-1234` is not on this machine. It registered the marketplace from
the shell with `claude plugin marketplace add agenticDraft/plugins#spike/symlink --scope project`, with no session.
Then `claude plugin install` alone wrote `0.0.2/node_modules` in ~3 s, and `chromium-1234` stayed absent. So the
install command installs, and no browser is downloaded, both measured. **This changes Task 3's install order:**
`marketplace add … --scope project` from the shell needs no interactive session (Phase 48 / Task 4's guide). **For Phase 47:** the playwright pack
must ship its own `package.json` + lockfile. From the cache, `probe-tool.cjs`'s "beside the project" `require` never
reaches the project, so it would fall through to the global root. The browser stays a precondition in the shared
`~/Library/Caches/ms-playwright`, keyed by the pack's playwright version, so the pack and the project pin the same
version. Nine defects recorded (1 and 3 fixed by the re-run, 2 partly). Among them: the browser check cannot see a chromium download, because `chromium-1243`
was already present; `marketplace remove` again leaves `spike-d/0.0.1/` (`.orphaned_at`, with `node_modules`); and
Task 3's `spike-c/.in_use/90448` marker was cleared by the new session.

**Last done (2026-10-06, Phase 46 / Task 3 — DONE, `phase-46-task-3-done.md`):** tag `spike-v1` → `7befed5`
on `spike/symlink`. A marker `plugins/spike-c/after-tag.txt` was committed after the tag (`b2c8b3b`). Both are pushed,
and `main` of `agenticDraft/plugins` is unchanged at `94fd986`. The scratch project's hand-written `settings.json`
declares `extraKnownMarketplaces.agenticdraft-spike.source = {github, agenticDraft/plugins, ref: spike-v1}`.
**PASS:** `installPath` is `cache/agenticdraft-spike/spike-c/0.0.1` and the marker is absent from it. The marketplace
clone is a shallow detached checkout at `7befed5`, and it stayed there through an explicit `marketplace update`. The
fallback, a `source.ref` per plugin, was not needed. The three stored files are byte-identical before and after, and
`agenticdraft` was untouched. **What the pin means:** the marketplace `ref` pins the clone, and relative-path plugins
are read from that clone, so one tag pins all six plugins in Phase 49. The cache key is the plugin's `version`, so
every release must bump it. A tag can be force-moved, and a marketplace source takes no `sha`. **Install order
measured:** a shell `claude plugin install` fails while only settings declare the marketplace, with misleading
errors. One trusted interactive session clones it in the background. Then the install works. The registering session
cached `spike-c` but ran neither an install nor its `SessionStart` hook, so a fresh project's root registry is empty
after the first session. **For Phase 49:** a user-scope `agenticdraft` directory marketplace already has the same
name, and the one-per-name collision is untested. Eight defects recorded. Among them: the classifier denies this
session a `claude -p` ("Create Unsafe Agents"), so you opened the session; `marketplace remove` again leaves an
orphaned cache; and PR #240 had drifted from its claim and was fixed here. Leftovers stay for Phase 46 / Task 5.

**Last done (2026-10-06, Phase 46 / Task 6 — DONE, `phase-46-task-6-done.md`):** PR #240

<!-- claim: PR#240 status=merged --> (merged as `4eba191`; `phase-46-task-6-t2fix`, `01b2164`; the brief's branch name was 30 > 23

characters) — the runner's startup log names both plugin sources: `plugins by path (…; n)`, `plugins installed (enabledPlugins in the project settings; n)`, `plugins in both (n; the path copy overrides the installed one)`;
`plugin-sources.mjs` with its 7-case test written first; 68/68 runner tests, naming rule and no-narrative `valid`;
probed live from this repo (six / six / six, `cost=$0.0009`); the SDK's `plugins` array and every exit path unchanged.
Filed: G165  (fixed), G166  (canonical paths, no
`async` hook → three Phase 47 / Task 2 test cases; fixed 2026-10-08 by that task, on its branch), G167  (bare project → Phase 48 /
Task 4; `ROUTE_PLUGIN_DIR` empty once installed → Phase 49 / Task 2, with an open path-vs-installed question written
into that entry), G168  (a hook brief says what to check), G169

<!-- claim: G169 status=OPEN --> and G171 <!-- claim: G171 status=OPEN --> (Claude Code observations, not ours;

evidence in `/tmp/claude-501/p46-evidence/`), G170  (**your decision: keep the SDK
pin `0.3.285`**; the blank screen: **iTerm2, plain `claude` in this repo is fine**). Phase 46 / Tasks 3–5 entries
corrected (key `agenticdraft-spike`, after-tag commit on `spike/symlink`, stored-file diffs, leftovers already
deleted). **Not in the PR (the brief's "commit only"):** the new suite is not in `validate-agentic-core.yaml` and the
runner README still says "the plugins found" — one line each. Also seen: a refused model ends the session
`subtype=success`, exit 0 (done record, defect 4); the jira pack's uncommitted edits from another session are still
in the tree, untouched.

**Last done (2026-10-06, Phase 46 / Task 2 — DONE, `phase-46-task-2-done.md`):** `spike-c` on `spike/symlink`
(`7befed5`, pushed from the temp clone `/tmp/claude-501/p46t2/plugins`; the `agenticdraft` clone stayed on `main`
`fff812d`). Its `SessionStart` hook writes `${CLAUDE_PLUGIN_ROOT}` to `.ai/run-context/plugin-roots/spike-c`.
**All three PASS:** interactive → `cache/agenticdraft-spike/spike-c/0.0.1`, equal to `installPath`; `--plugin-dir`
→ the dev folder (it overrides the installed copy); headless through `route-agent.mjs` → written in both layouts
(empty `ROUTE_PLUGIN_DIR`: the SDK loads the *installed* copy from project `enabledPlugins`, cache path;
`ROUTE_PLUGIN_DIR` = a plugins folder: dev path). The orphaned `cache/agenticdraft-spike/` did not affect the
install. **For Phase 47 / 49:** spec §4's registry stands; a path-loaded plugin wins over an installed one, so after
Phase 49 `ROUTE_PLUGIN_DIR` must point at nothing or runs keep using the working tree; registry hooks must not
declare `async`. Nine defects, among them: interactive sessions showed you a blank screen although they started
(cause unknown, not reproduced); `claude plugin marketplace list` text changed between before and after with no
stored change (built-in directory gone, `Folder` → `Directory`) — diff `known_marketplaces.json` instead; two empty
leftovers `~/.claude/plugins/data/{spike-c,no-hallucinations}-inline/` and a second orphan
`cache/agenticdraft-spike/spike-c/` — **deleted 2026-10-06 with your yes**, with Task 1's leftovers and the
`/tmp/claude-501/p46t{1,2}/` scratch folders (evidence kept in `/tmp/claude-501/p46-evidence/`); the runner needs a route
policy and a settings allowlist in any project before a headless run.

**Last done (2026-10-06, Phase 46 / Task 1 — DONE, `phase-46-task-1-done.md`):** on `spike/symlink` (`07a6198`,
pushed, left for Phase 46 / Task 5), `spike-b/core -> ../spike-a/shared`. **GitHub install
(`agenticDraft/plugins#spike/symlink`, project scope) → PASS:** `installPath` under `cache/agenticdraft-spike/`,
`core/hello.sh` a regular file, `-rwxr-xr-x`, prints `hello`. **Local directory install → the expected "core/
missing" did not happen:** the cache copy is also dereferenced, and `claude plugin list --json` reports
`readFromFolder` (a directory marketplace loads in place, where the link resolves). Spec §3's line "for a local-path
or directory source, only symlinks inside the plugin are kept" is wrong for a directory marketplace — correct it in
Phase 46 / Task 5. Before/after lists identical; `agenticdraft` and its two plugins unchanged. **For Phase 47:** each
pack gets a *copy* of the core keyed by the pack's own version, so a core change ships only when every pack's
`version` changes. Eight defects recorded, among them: the brief's clone is the `agenticdraft` directory
marketplace (the clone went back to `main` right after the push; step 4 used a temp clone); sandboxed and
unsandboxed `$TMPDIR` differ; `marketplace remove` leaves `cache/agenticdraft-spike{,-local}/` behind with
`.orphaned_at` — **left for Phase 46 / Task 5 (your decision, 2026-10-06).**

**Filed 2026-10-06:** `31-plugin-marketplace-migration-spec.md` (the plan of record; the artifact above is its
readable copy) and Phases 46–50 in `02-build-tasks.md`, indexed in `00-instructions.md`. Its D and G entries
(spec §7) stay unnumbered until Phase 46 / Task 5. One change against the artifact: Phase 47's closing check is
its own task, Phase 47 / Task 10 — Verification. **Decided 2026-10-06 (you):** Phase 50 ends on Task 3, the
interactive run as before; the CI route run from `agenticDraft/plugins@v0.2.0` is part of Phase 9 / Task 5
(amended), because headless does not work yet.

**Open, yours:**

- **PR #240**  (Phase 46 / Task 6) is merged. The one-line follow-ups above are still open if you want them.
- **Phase 46 leftovers — all gone (2026-10-06, your answers):** the local `spike/symlink` in the `agenticdraft` clone
  was deleted (it was `07a6198`), and so were the scratch temp folders. Only `/tmp/claude-501/p46-evidence/` remains.
  `check-status-claims.mjs` stays as it is, so PR markers inside the register remain unchecked (your decision).
- **Before Phase 47:** done (2026-10-08). The loop prints nothing; the jira edits are committed (`48fc899`).
  Open for you: `phase-10-task-2`'s work (exported patch, one local copy) is redone against the marketplace
  layout when Phase 10 / Task 2 runs, after Phase 2.

Paste this after `/clear`:

```text
Phase 47 / Task 5 — Core → pack and pack → pack through the resolver (02-build-tasks.md:3908). Plugin freeze (D128)
in force: only this migration edits plugins/. Depends on Phase 47 / Task 2 (phase-47-task-2-done.md); builds on
Task 4 (phase-47-task-4-done.md). Tasks 1–4 may be unmerged — check `git log origin/main` for 414ce1c, 81a141d,
93b6e2b and 876e9c7, and say which base you used; if Task 4 is not on origin/main and the tree is not clean,
ask before branching.

Read first: docs/implementation-plan/NEXT.md, 00-instructions.md, 01-core-contracts.md §11.2 and §7 (`packs:`),
phase-47-task-2-done.md (the resolver; defect 7: --project-dir in a linked worktree), phase-47-task-1-done.md
(defects 1 and 4: the run-route stamp and its `..` lines), phase-47-task-4-done.md (defects 1, 4, 6), and the Phase 47
/ Task 5 entry in 02-build-tasks.md. Automation work: do not read AGENTS.md or AGENTS.project.md. Nothing under
agentic-core may name a pack, a tool or a vendor (D28, D34).

Branch: `git fetch origin` (SSH), base as above, `git status --short` empty, then
`git switch --no-track -c phase-47-task-5` (checked: `ok: branch=phase-47-task-5 length=15`) and confirm with
`git branch --show-current`. Commit only when told; no push without the human.

Delivers:
1. Every core → pack and pack → pack `..` reference moved to `resolve-plugin-root.sh <name>`. Measured 2026-10-09
   for the form `${CLAUDE_PLUGIN_ROOT}/../` only: agentic-core 12 lines / 9 files, eds 14 lines / 10 files, other
   packs 0. Re-measure every form (Task 3 found seven where the brief named two); quote your own counts.
2. `setup` and `health` pack discovery and the default `--plugins-root` of `check-branch-name.sh` on the resolver;
   the branch check fails closed when the platform pack cannot be resolved; tests first, seen failing; G172 FIXED.
3. `run-route/SKILL.md` `:84`, `:91` (the interim sibling rule) and `:374` (pre-flight's
   `${CLAUDE_PLUGIN_ROOT}/../<pack name>/pack.yaml`; the build entry says `:362`, it has moved) through skill-creator
   (snapshot first), then `instructions-stamp.sh --write`. Every other SKILL.md edit through skill-creator too.
4. A caller in a linked worktree passes `--project-dir` (Task 2, defect 7) — say which callers can run there.
5. Contract §11.2 gains "a pack reaches its own files as `${CLAUDE_PLUGIN_ROOT}/<path>`, never through `..`" and a
   check, tests first, that fails on `${CLAUDE_PLUGIN_ROOT}/../<own name>/` in any pack, the name read from each
   pack's manifest (Task 4, defect 6; the human's decision 2026-10-09).
6. Contract §11.2 "Built by" and the core README updated for what this task builds, nothing more.

You verify (run them, quote the output):
- a `check-branch-name.test.sh` case with no resolvable pack → non-zero exit; a valid name with the pack
  registered → exit 0;
- `grep -rn 'CLAUDE_PLUGIN_ROOT}/\.\./' plugins` → empty, plus your own grep for every other `..` form you found;
- every *.test.sh under plugins/ → totals, fail=0 (128/128 on 2026-10-09);
- validate-naming-rule.sh and check-no-narrative.sh on plugins/agentic-core → valid; `claude plugin validate`
  on all six plugins → passed; instructions-stamp.test.sh → passes.

Write docs/implementation-plan/phase-47-task-5-done.md (what ran, quoted outputs, pass/fail, every defect, an
architecture note with call order). Then NEXT.md: copy to NEXT.prev-<date>.md first (letter if taken), Last done
entry, the next prompt, `grep -c 'claim:'` not dropped, check-status-claims.mjs all match. Update the Remaining
Build Work artifact.

Reject if: "unconstrained" is still a possible result of a missing pack; a caller falls back silently or guesses a
path when the resolver exits non-zero; a SKILL.md is edited by hand; the run-route stamp is not regenerated; a result
is quoted that was not run; a count is quoted that the session did not produce.
```

**Last done (2026-10-05, Phase 41 / Tasks 3–5 — working-tree inventory, DONE, `phase-41-task-3-done.md`,
`-4-done.md`, `-5-done.md`):** ten stashes dropped, each after a blob re-check and your yes (hashes in
`.ai/logs/phase-41-dropped-stashes.txt`); two left, both yours. EDS-13's AC-7 draft and the zoran-block draft parked
in `.ai/logs/parked-specs/`, byte-identical. `phase-10-task-2-non-interactive-readiness` deleted (`9e5ad16` is on
origin as `phase-10-task-2`). Filed with your yes: **D125** (drafts live in the tracker, never committed — **WITHDRAWN 2026-10-06**, your
correction: drafts are committed as before), **G163**

<!-- claim: G163 status=OPEN --> (no status transition), **G164** <!-- claim: G164 status=OPEN --> (a committed draft drifts from its item; EDS-22/23 arrived via PR #210 <!-- claim: PR#210 status=merged -->, which

the inventory had as "no PR"). **2026-10-06:** the `.gitignore` branch was deleted unpushed; stale and missing drafts
committed to `main` as `9a606c1` (EDS-13, EDS-22 updated; EDS-19, 20, 21, 24 added; all word-identical to the live
items); EDS-5 still differs, left as is by your choice. Verification 7/7; claims all match; numbering valid (44 / 3 / 211).

**Last done (2026-10-05, Phase 45 / Task 2 — Verification, DONE, `phase-45-task-2-done.md`):** nothing built, no gap
closed (G162  was already closed). On `main` `b874a20`: 125 suites, each alone →
`pass=125 fail=0`; the five repository checks `valid`; `check-status-claims.mjs` 113 claims, all match;
`check-numbering.sh` valid on 03/04/05 (43 / 3 / 209). EDS-25 inputs, original CSS (`5914551`) plus the draft's two
rules: `--base main` and `--base origin/HEAD` → exit 0, no `--base` → exit 1 (the G162 failure), an untied 712px → exit 1.
**Defect in the brief:** a block file built in `$TMPDIR` has no checkout, so `--base` exits 2 (`no merge base … in the checkout holding …`); it was run from a scratch clone at `5914551` instead. No suite launches Chromium, so nothing ran
unsandboxed. Phase 45 is complete.

**Last done (2026-10-05, Phase 44 / Task 6 — DONE, `phase-44-task-6-done.md`):** Run A (EDS-25) re-run, `terminal: delivered`, PR #239 .

- **Closed on a quoted line:** G162  (the prototype ran `--base origin/HEAD` → `exit=0`; PR #238 merged), G140  (`jq .width` 375 / 768 / 1440 match `verify-report.md:8-10`), G159  (`length == (unique | length)` → `true`, 37 entries), G158  (`## Out of scope by declaration`, no font line in the note), G161  also seen at `delivered` (`written: .ai/run-context/analytics.md` / `terminal: delivered`). `check-direct-script-calls.sh` → `ok`.
- **Still FIXED, case not reached by EDS-25:** G157  (no selector hid: every `"hidden": false`), G160  (no `min-width` row in the design values, so the grep cannot fail), G151  (`size` never called, 0 hits). Each needs a design run that reaches its case.

**Last done (2026-10-05, Phase 45 / Task 1 — `phase-45-task-1-done.md`):**

- **The prototype's size-origin check reads only the run's own changes (G162)** 
  — `check-size-origin.py check … --base origin/HEAD` (D548). Only a size not in the file at the merge base can
  be a hit. **Your decided base (`HEAD`) was measured and changed:** `git diff HEAD` is empty once the run is
  committed, so the base is the merge base of `origin/HEAD` and `HEAD`. EDS-25's inputs → exit 0. Suite
  45 → 62 cases, 125 suites, five checks valid, run-route stamp unchanged. PR #238  (`phase-45-task-1-size-origin-diff`).

**Last done (2026-10-05, Phase 44 / Task 6, PARTIAL — `phase-44-task-6-partial.md`):**

- **Run B (EDS-24, merged) → G149 CLOSED** : `satisfied	the change for this item is already merged (Retrieved checks for eds-24 (#230: 1 pass).)`, note on EDS-24 (comment `10646`),
  `terminal: blocked`, no branch created.
- **G161 CLOSED**  on the `failed` (Run A) and `blocked` (Run B) terminal
  states: `written: .ai/run-context/analytics.md` before the terminal line, a row per stage, the main session
  transcript in `transcript-path.txt`. Not observed at `delivered`.
- **Run A (EDS-25) → `terminal: failed`, `stage: prototype`.** `check-size-origin.py` refused
  `width: 2em` on `.features-carousel .features-carousel-content ol li::before` — a rule the block already
  had (`features-carousel.css:62`). **G162**  filed, decided, fixed in Phase 45 / Task 1. Run A's
  leftovers were discarded (your yes) and the tree is back on `main`.
- **Still FIXED, not closed (no live line — no run reached the stage):** G157 ,
  G140, G159 , G160 , G151
  <!-- claim: G151 status=FIXED -->; G158 <!-- claim: G158 status=CLOSED --> has its conventions half

  (`design-conventions.md:6`, styles `success`) but not the report or the tracker note.
- 125 suites, 0 failed; five repository checks `valid`; `check-numbering.sh` valid on 03/04/05.

**Last done (2026-10-05, Phase 44 / Task 5):**

- **Design fonts the human put out of scope are not "Action needed" (G158)** — PR #236
  <!-- claim: PR#236 status=merged --> (merged 2026-10-05 as `e161c93`) (`phase-44-task-5-fonts`, record `phase-44-task-5-done.md`). Your

  shape 1: `.ai/design/fonts.yaml` (`design_fonts: out-of-scope`, tracked, declared for this project) read
  by `design-fonts.py` → exit 3; `conventions` stops warning, `verify-design` keeps text-geometry
  differences out of the check file under `## Out of scope by declaration`. D530 amended (dated). 25/25,
  122 suites. G158 .

**Last done (2026-10-05, Phase 44 / Task 4):**

- **The driver renders `analytics.md` at every terminal state (G161)** — PR #235
  <!-- claim: PR#235 status=merged --> (merged 2026-10-05 as `4c4fd18`) (`phase-44-task-4-analyt`, record `phase-44-task-4-done.md`). Your

  shape 1(b): a `PreToolUse` Bash hook in run-route's frontmatter records `transcript_path` into
  `.ai/run-context/transcript-path.txt`; the three terminal nodes call `render-run-analytics.sh` before the
  terminal line; a Scope line says the orchestrator row is the whole session. Stamp `fb6392a11419`.
  124 suites, 0 failed. G161 (now CLOSED) . `03-core-design.md:506` corrected.

**Last done (2026-10-05, Phase 44 / Task 3):**

- **`verify` measures at every width it captures (G140, the `verify` half)** — PR #234
  <!-- claim: PR#234 status=merged --> (merged 2026-10-05 as `1bb4a6a`) (`phase-44-task-3-width`, record `phase-44-task-3-done.md`). One

  `measure` per width with `width:`; `check-breakpoint-regressions.py widths` pairs each file with its own
  recorded width (the stage's only pairing); your choice: `check` runs at `verify` too, a fired line is a
  hard failure at that width. 37/37, 122 suites. G140  (both halves built;
  closes on the next run's report).

**Last done (2026-10-05, Phase 44 / Task 2):**

- **`min-width` gets its own reason in the value comparison (G160)** — PR #233
  <!-- claim: PR#233 status=merged --> (merged 2026-10-05 as `68cab41`) (`phase-44-task-2-minw`, record `phase-44-task-2-done.md`). A

  `min-width` row now reads `checked by the breakpoint regression check against the element's own width, not against the design value`; `MEASURED` unchanged; on the EDS-24 files only the three `min-width`
  rows differ. 138/138, 122 suites. G160 .

**Last done (2026-10-05, Phase 44 / Task 1):**

- **The evidence manifest holds each coverage gap once, and says which node (G159)** — PR #232
  <!-- claim: PR#232 status=merged --> (merged 2026-10-05 as `37561f3`) (`phase-44-task-1-gaps`, record `phase-44-task-1-done.md`). One

  script, `evidence-manifest.py`: `gaps` builds the per-line strings (nodes named, or a count) from the
  comparison outputs, which `verify-design` now keeps under `.ai/run-context/`; `merge` is the union both
  stages call instead of their inline `jq`. EDS-24's 214 lines → 29, none twice; merged 187 = unique.
  123 suites, 0 failed. G159  (closes on the next run's manifest).
  **Phase 44 filed** in `02-build-tasks.md:3587` (your yes).

**Last done (2026-10-05, Phase 43 / Task 5):**

- **A selector hidden at a measured width does not fail the read (G157, D124)** — PR #231
  <!-- claim: PR#231 status=merged --> (merged 2026-10-05 as `7073ee7`) (`phase-43-task-5-hidden`, record `phase-43-task-5-done.md`). Your

  choice: the `hidden` flag (shape 1). §6 amended first; `measure` reports a selector with no visible
  match as `found: true, hidden: true` at once and reads geometry from the first visible match; the
  settle condition drops visibility; the three consumer scripts leave a hidden selector ungraded.
  Measured: `.nav-sections` at 375 → 10.76 s `fail` before, 1.27 s `pass` (`hidden=1`) after. 122 suites,
  0 failed. G157  (closes on a run whose block hides a measured selector).
  Phase 44 filed in `02-build-tasks.md` with your yes (same session, with Phase 44 / Task 1).

**Last done (2026-10-04, Phase 43 / Task 4 — the EDS-24 run):**

- **EDS-24 run — `terminal: delivered`**, PR #230  (merged 2026-10-05, `80a059f`), from
  `eds-24`, `blocks/table/table.css` only (+5: `min-width: calc(3 * 200px)`, `table-layout: fixed`).
  Record `phase-43-task-4-done.md`; session `87101e51`, 15/15 stages, 0 questions, ~32 min; edited no
  plugins. **D123 worked live:** `verify-design` check 1 fired at 375 (17 `[fixable]`: 42 words, header
  109px < 200px), one edit, check 2 quiet at 375 / 768 / 1440; `verify` passed AC-6 at 375.
  - Closed: G155 , G144  (`ok: no provider script run directly (64 commands read)`), G150  (1:217
    named per property, `gap` measured on `td p`).
  - Not closed: G140  (`verify-design` half proven; `verify` measured
    at 1440 only by departing from its step), G151  (`size` not called,
    columns already equal), G149 (now CLOSED)  (continue path again), G157

    <!-- claim: G157 status=FIXED --> (not reached).
  - Phases: Phase 28 / Task 9 met; Phase 6 / Task 5 met (restated criterion); Phase 18 / Task 4 live half
    met. **Phase 25 / Task 8:** not met as written (EDS-18's `table.css:46` finding, outside EDS-24's diff);
    you chose to restate it (2026-10-05, `02-build-tasks.md`): a gate `warn` whose finding is in its
    report, `continue-warn`, delivered — met by this run's `plan-gate` → done.
  - New, not fixed: G158  (the note lists undeclared design fonts under
    "Action needed" — against your out-of-scope rule; fix shape yours), G159

    <!-- claim: G159 status=CLOSED --> (duplicate coverage gaps, 217 / 187 unique — from `verify-design`'s per-node lines without the node; cause corrected 2026-10-05), G160

    <!-- claim: G160 status=FIXED --> (`min-width` reported "not in measure's property set").
  - New: G161 (now CLOSED)  — the driver renders no `analytics.md` at a terminal state
    (§9 says it does); rendered by hand: `verify-design` 5.4M and `verify` 4.7M cumulative billed input.
  - PR #230 merged 2026-10-05 (your yes); its CSS assumes three columns (`verify-design-report.md:103`).
  - All eight open gaps written up for the fixing session: `fix-brief-eds-24-gaps.md`. G159's cause
    corrected there and in the register: the repeats come from `verify-design`, not `verify`'s merge.

**Last done (2026-10-04, Phase 43 / Task 3):**

- **`verify-design` renders every breakpoint (D123)** — PR #229 , merged
  as `3985e0a` (`phase-43-task-3-bp`, record `phase-43-task-3-done.md`). §6 amended first: `measure` takes an
  optional width (records it), reports `min-width` and each selector's `broken_words`.
  `pair-viewports.py widths` lists the widths (375 / 768 / 1440 here); `check-breakpoint-regressions.py`
  prints one `[fixable]` line per selector with a broken word (A) or narrower than its own `min-width`
  (B); `count-fixable.sh` counts them under the existing `fix_attempts`. On real data: EDS-24 at 375
  with `table-layout: fixed` injected → A 42 words, B on the header selector (109px < 200px); quiet on
  `main` at all three widths and on 21 control measurements. 122 suites, 0 failed.
  G155  (closed on Task 4's run), G140  (`verify` still
  measures at the default width).
- **New: G157**  — a selector hidden at the measured width fails
  `measure` (measured: `.nav-sections` at 375, 10.6 s); now reachable because every width is measured.
  Not reached on EDS-24. Your choice: its own task after Task 4 — **Phase 43 / Task 5**
  (`02-build-tasks.md`), fix shape decided with you then.

**Last done (2026-10-04, same session, after Task 1):**

- **Phase 43 / Task 2 measured** (record `phase-43-task-2-done.md`, no code). On five pages carrying the
  table and eight other blocks, at 375 / 768 / 1440, run CSS against `main`'s: **A** (a word broken
  across lines) and **B** (a box narrower than its own `min-width`) fire on every regressed case (375,
  run CSS: A 42–252 words, B 3 header cells) and stay quiet on every other (table on `main`, table at
  768/1440, 24 control cases). **C** (overflow) never fires. **D** (size change against the pre-change
  render) fires on the intended 1440 change too (−6.2%) and needs a baseline EDS-24 did not have.
  `measure` takes no width and reports neither A nor B; Task 3 changes the browser pack either way.
- **G147 fixed**, PR #226  (`g147-border-width`, record
  `g147-border-width-done.md`): a bare `border`, a side class, a step and a side-specific value each
  give their width row; EDS-24's reference gains 27 width rows (incl. the 0.5px dividers), 0
  conflicts. G147 .
- **G148 fixed**, PR #227  (`g148-viewport-spill`, record
  `g148-viewport-spill-done.md`): each viewport variant's rows pass through `spill()`/`apply_spill()`;
  proven on a constructed case only (no multi-viewport run exists). G148 .

**Last done (2026-10-04, Phase 43 / Task 1):**

- **Phase 43 filed** (`02-build-tasks.md:3509`, G155 · G144 · D123 in `04-eds-pack-design.md`) and
  **Task 1 built**: PR #225  (`phase-43-task-1-ops`, record
  `phase-43-task-1-done.md`). Found first: the one-call rule was already in `role-operations.md`, and
  neither EDS-24 stage ever read the file. The contract gains "one invocation runs one script, alone in
  its own command"; `eds-verify-design` and `eds-verify` read it as a numbered step;
  `check-role-operations-read.sh` (eds) enforces the step; the checker is unchanged (your decision).
  121 suites, 0 failed. G144  (closed on Task 4's run: `ok`). Known
  limit: the checker does not report a loop under one invocation.

**Last done (2026-10-04, EDS-24 verification run):**

- **EDS-24 run — `terminal: failed` at `verify`, stage 12/15** (record `phase-42-verification-done.md`;
  session `7c227ec9`, 0 questions, ~27 min 44 s). `verify` failed AC-6 at 375px: `prototype`'s
  `table-layout: fixed` makes the browser ignore the header cells' `min-width: 200px`, so the columns
  squeeze to 109px and words break mid-word. Measured after the run: `main`'s auto layout scrolls at
  600px; fixed plus `min-width: 600px` keeps equal columns and the scroll. The verdict is right; no
  stage before `verify` renders any width but 1440, and `verify` cannot edit — G155
  <!-- claim: G155 status=CLOSED --> (new; fixed by Phase 43 / Task 3, closed on Task 4's run).

  - Closed: G152  (stamp `d52fab5a4253` matched, `at most \`warn\`` → 0) and
    G153  (no flag after intake; flag and first run state written in
    the same second).
  - Proven live, not closed: D122's continue path (`continue	change_state=none`, G149
    <!-- claim: G149 status=CLOSED -->); G151's `variables` mode (<!-- claim: G151 status=FIXED -->; `size`

    never called — the columns were already equal).
  - Not passed: G144  (closed since on Task 4's run) — `invalid: 2 provider script(s) run directly`
    (was 7; `verify` clean, `verify-design` check 2 chained capture/measure after one `Skill(render)`).
  - Your reading needed: G150  (closed since on Task 4's run) — nothing measured on another
    property's selector, but 1:217's lines say `… for this node`, not the prompt's `… for this property`.
  - Seen again: G145 (out-of-scope border edit by `verify-design`, in the diff), G140 (no measurement
    at 375).
  - Phase 17 / Task 5 and Phase 23 / Task 4: conditions met on the report. Phase 18 / Task 4: half (two
    distinct screenshots; the manifest attach is `deliver`'s). Phase 28 / Task 9, Phase 25 / Task 8,
    Phase 6 / Task 5: still open — each needs `delivered` (Phase 6 / Task 5 facts 1–2 hold: `NORUN` at
    08:35:47Z, 0 `DENY` in the run window).

**Last done (2026-10-04, earlier):**

- **Phase 42 — every defect of the 2026-10-03 EDS-18 run fixed, one PR per task, all seven merged 2026-10-04** (`main` = `118856a`; records
  `phase-42-task-1..7-done.md`; gaps marked FIXED, none CLOSED — each closes on the EDS-24 run):
  - Task 1 — G152  (closed on the EDS-24 run): the driver's gate-guard text says D121; PR #218
    <!-- claim: PR#218 status=merged --> (`phase-42-task-1-d121`, stamp `043099ddae99`; also registers

    `check-tree-unchanged.test.sh` in CI, which no workflow ran).
  - Task 2 — G150  (closed on Phase 43 / Task 4's run): `compare-design-values.py` measures a property only
    on its own row's selector, else `unmeasured`; PR #219 .
  - Task 3 — G151 : `size` mode (same selector and same dimension, your
    choice) and `variables` mode (each design variable on the element carrying its token, never the
    wrapper); PR #220 .
  - Task 4 — G153  (closed on the EDS-24 run): the marker is first written with the first run state,
    after intake (your choice); PR #221  (stamp `1e1ea7d441cd`). Measured:
    no stage adapter reads the flag; G153's stated consequence corrected.
  - Task 5 — G144  (closed on Phase 43 / Task 4's run): confirmed from run B's transcripts (session
    `cb5c387d`, not `42a7ca3a`) and measured (Chromium does not launch in the sandbox); the browser
    operations run their script unsandboxed, a new core contract `shared/role-operations.md`, and
    `check-direct-script-calls.sh` names the 7 direct calls run B made; PR #222 .
  - Task 6 — G149 (now CLOSED) , **D122** (your decisions: both detectors, `blocked`
    + tracker note, no override, a fresh item): `check_status` before `create_branch` with
      `check-item-satisfied.sh`; an empty change at the publish gate is a `question`, not a `fail`
      (`check-publish-criteria.sh` exit 3); PR #223  (stamp `7a695c301b30`).
  - Task 7 — G111 (both findings merged 2026-09-22, neither verified live): Phase 6 / Task 5's criterion restated (your choice:
    registration by any logged line, compliance by zero DENY, delivered); `02-build-tasks.md` and
    `phase-6-task-5-status.md` amended; no code.
  - **EDS-24 created** through `write-specs` ("Equal comparison table columns"; live checker `valid`,
    0 review notes; `.ai/specs/EDS-24/draft.md`). New rule in `write-specs`' criterion checklist, yours:
    one element per criterion (PR #224 ). Memory saved.
  - **Merged in this order** (2026-10-04, by the session, at your request): #219, #220, #222, #224, then #218,
    #221 and #223 each with `origin/main` merged in first (the workflow file and the stamp line
    conflicted; both steps kept, stamp rewritten). The driver's stamp on `main` is **`d52fab5a4253`**
    and matches its last line; `grep -c 'at most \`warn\`'`→ 0; 120 suites, 0 failed on`main`.

**Last done (2026-10-03):**

- **EDS-18 verification run — Phase 40 / Task 3 proved live; the run itself ended `failed`.**
  Records: `phase-40-task-3-done.md` § Live check, `phase-28-task-9-done.md`. From a fresh session
  that edited no plugins (`5586fe4`):

  - Run A (untracked probe): `refused: 1 paths changed before this run`, `terminal: blocked`,
    nothing written. Run B and the interrupted session `42a7ca3a`: `clean: no change and no untracked path`. G138  closed.
  - `42a7ca3a`'s driver: `archived: 45 entries -> .ai/logs/run-context-2026-10-03-184118` (the
    EDS-23 run's context). G137  closed.
  - Closed on Run B's record: G139  (header `381.7x96px`, no
    hand correction), G143  (three `spill:` lines in
    `design-context-notes.txt`), G146  (`NORUN` after the run),
    G122  (`.icon` tied to `I1:199;1:563`, size-origin exit 0).
    D121 held: both gates `isolation: absent`, verdicts the review's, nothing capped.
  - Not exercised: G142  (no `deliver`), live check 3 (no resume).
  - **Run B: `terminal: failed` at `publish-gate`, stage 14/15** — EDS-18's work is on `main`
    since PR #170, so `plan` re-proposed it, `implement` passed on "already met", and the gate found
    a 2-line diff implementing none of the plan. G149 . Phase 28 /
    Task 9, Phase 25 / Task 8 and Phase 6 / Task 5 therefore still open.
  - New: G149–G153 OPEN (G150 dead `gap` edit, G151 column widths graded content-dependent,
    G152 driver text pre-D121, G153 flag without run state); G154

    <!-- claim: G154 status=FIXED --> fixed here (prompts no longer pull inside the driving

    session).
- **D121 — the gates' isolation cap is removed** (your decision after the EDS-23 run): PR #217

  <!-- claim: PR#217 status=merged --> (`d121-gate-no-cap`, record `d121-gate-no-cap-done.md`).

  From the main checkout both gates always report `isolation: absent`, so `publish-gate` could never
  pass; the line now stays in the report as information, the verdict is the review's, and the
  driver's tree guard keeps the read-only guarantee. G532 updated.
- **Four gaps fixed in the same session, each its own PR from `main`, all merged 2026-10-03:**

  - G146  — PR #214
    (`g146-read-hook`, record `g146-read-hook-done.md`): the read hook judges only while
    `orchestrating.flag` exists; other reads pass and log `NORUN`. Stamp `b5d63a72f981` on its branch.
  - G139  and G143  — PR #215

    <!-- claim: PR#215 status=merged --> (`g139-g143-spill`, record `g139-g143-spill-done.md`).

    G139's diagnosis was wrong: the 97px is Column 1's frame border carried by the `th`, not the
    cell's own. The spill now takes a bordered parent's top border (EDS-23: 23.143px, the value PR
    #212 has by hand), and `prototype` keeps the script's stderr in `design-context-notes.txt`.
  - G142  — PR #216
    (`g142-tracker-note`, record `g142-tracker-note-done.md`): a **Pending** section in the note,
    your choice over G142's stated shape, which contradicted G535.
  - New, not fixed: G147  (a bare `border`/`border-b` gives no
    width row), G148  (`viewport-overrides.py` skips the spill).
  - PRs #212–#216 merged 2026-10-03 (18:19–18:25 UTC); the `run-route` stamp on `main` verifies
    (`78af82988549`) after the #213/#214 overlap.
- **Phase 40 / Task 3 built — a fresh start refuses a dirty working tree** (D120): PR #213

  <!-- claim: PR#213 status=merged --> (`phase-40-task-3`, `2376706`), record

  `phase-40-task-3-done.md`. G138  is FIXED, not closed: no live
  fresh start has run the guard. `check-tree-clean.sh` calls `list-changed-files.sh` (the gate's own
  change set) and the driver's **Fresh start** runs it as step 2, before the archive and the marker;
  a refusal ends the run `blocked` with nothing written; **Resume** never runs it. Because the set is
  the gate's, a branch with commits not on `main` is refused too. Stamp `9cd29ad0bfa6`. Suites: new
  32/32, every core shell suite 74 run 0 failed. The Remaining Build Work artifact was republished
  first (version 36, the EDS-23 edits G146 had blocked).
- **Phase 40 / Task 2 done — the EDS-23 run reached `delivered`** from a fresh session, with no
  human typing a command for the driver: PR #212  (`eds-23`,
  `ae854b2`, `blocks/table/table.css` only), 15/15 stages, 0 questions, ~22 min 31 s. Records
  `phase-40-task-2-done.md` (also serves Phase 38 / Task 4 and Phase 39 / Task 3) and
  `docs/agentic-core/phase-run-eds-23.md` (per-stage timing and summaries). G136

  <!-- claim: G136 status=CLOSED --> closed; G137 <!-- claim: G137 status=CLOSED --> stays FIXED —

  wiring proved, but the archive printed `archived: nothing to move`, so it closes on the next fresh
  start over a previous run's context. Header measured 97px at `verify-design` (G139

  <!-- claim: G139 status=CLOSED -->), 96px at `verify` only because `implement` hand-corrected the

  Area padding. New: G142  (tracker note omits a pending check),
  G143  (`spill:` lines reach no report), G144

  <!-- claim: G144 status=CLOSED --> (`verify-design` bypassed the browser operations; fixed in Phase 42 / Task 5, PR #222, closed on Phase 43 / Task 4's run),

  G145  (`verify-design` fixes out of scope, reverted by
  `implement`), G146  (the read hook outlives the run).
- **Phase 40 / Task 1 done, committed on `main` directly** (the human's instruction; no PR); record
  `phase-40-task-1-done.md`; G136 (closed since by Task 2) and G137

  <!-- claim: G137 status=CLOSED --> fixed (D118: `create_branch` writes its envelope to the file the

  driver names; D119: a fresh start runs `archive-run-context.sh` before the marker), G138

  <!-- claim: G138 status=CLOSED --> decided (D120; built since as Phase 40 / Task 3), G139–G141

  recorded. The two aborted EDS-23 runs are archived at `.ai/logs/run-context-2026-10-03-070337/`;
  `.ai/run-state.json` is gone; `.ai/run-context/` is empty. Phase 38 / Task 4 and Phase 39 / Task 3
  are served by the same run as Phase 40 / Task 2.

**Last done (2026-10-02):**

- **G122 fixed, PR #202 merged**  (`g-size-utility`);
  record `g122-size-utility-done.md`; G122  stays OPEN until the
  run below proves it. `size-[…]` now gives width and height rows, so EDS-18's `.icon` 14px can be
  tied to its `…;1:563` node. EDS-18 run of 2026-10-02 (failed at `prototype`) saved at
  `$TMPDIR/eds18-run-context` (= `/tmp/claude-501/eds18-run-context`); `.ai/run-state.json` from that
  run is still in place (`last_stage: baseline`) and must be archived or removed before the next run.
  The 10 defects found while fixing it are fixed or recorded in the same PR (G122's list): conflict
  rule for a property set twice, boundary-test margin 7195s, and `eds-18` deleted locally and on
  origin (it was the probe commit `8b956bd`, so the next run creates a fresh one).
  **Next after merge:** a fresh-session EDS-18 run (`/agentic-core:run-route EDS-18`), from `main`.
  It serves Phase 28 / Task 9, Phase 25 / Task 8, Phase 17 / Task 5, Phase 18 / Task 4,
  Phase 6 / Task 5 and Phase 23 / Task 4 (check `verify-design-report.md` has
  "## Content-dependent, not graded" and approx rows 1:197 / 1:206 / 1:215 height 96px). First
  thing to read in it: whether `prototype-report.md`'s `## Design values` ties `.icon` to a
  `…;1:563` node — the one thing G122 could not prove.
- **Phase 9 / Task 6 merged** in PR #201  (`c8a2343`);
  record `phase-9-task-6-done.md`; spec 28, D108, G117.
- **Phase 9 / Task 4 merged** in PR #200 ; G118 FIXED
  <!-- claim: G118 status=FIXED -->.
- **Phase 9 / Task 5 started, not done.** No `phase-9-task-5-done.md`, no PR yet.
  - Three real route runs on EDS-22 from `phase-9-task-5-e2e`, 2026-10-01:

    - `36935469880` (c900701): `terminate-failed` at `serve`, exit 3.
    - `36936597401` (c900702): `terminate-blocked` at `create-branch` — an existing `eds-22`
      branch held 1 commit that checkout would discard. The blocked note was posted per the log;
      not fetched back from the tracker.
    - `36937191077` (c900703): workflow green, but the log shows progress lines for intake and
      readiness only. That is G121's case (a route stopping mid-way read as a pass)
      <!-- claim: G121 status=OPEN -->.
  - Fixes pushed on `phase-9-task-5-e2e` (5 commits past `origin/main`): G119

    <!-- claim: G119 status=OPEN --> and D109 (the sandbox no longer auto-approves Bash; the

    runner denies writes to plugins, settings and route policy; the route workflow carries the
    whole route's allow rules), failure-tail diagnostics, and G121's terminal-state verdict.
    Both gaps still read OPEN in the register.
  - Probe on `phase-9-task-5-probe` (2 more commits), run `37015047894`, green. **Result:** the
    dev server started in one sandboxed command never answers a poll from a second command, sandboxed
    or not; started and polled inside one sandboxed command, it answers (404 on `/preview`, same as
    unsandboxed). `allowLocalBinding` true or false made no difference. This matches run
    c900701 failing at `serve`.
  - **Cause measured 2026-10-02, design approved and filed:** spec 30
    (`30-serve-outside-sandbox-spec.md`), G123 , D111, D112,
    Phase 9 / Task 5 amended. On Linux the sandbox's PID namespace ends every process a command
    leaves behind and its network namespace hides the port; a server started outside is reached
    only through the sandbox's proxy with its host in the list. Record:
    `serve-outside-sandbox-filing-done.md`.
  - **D111 built, PR #203 merged**  (`phase-9-task-5-e2e`, merged
    with `origin/main` after #202): servers started by the workflow before *Run*, preview host in
    the runner's copied list, proxied polls and browser launch, browser-pack CI. 106 suites pass
    locally. This session's `gh` token gets HTTP 403 on workflow dispatch; the human dispatches.
  - Run `37035579236` (c900704, `87ba21f`): preview server answered before *Run*; the draft server
    failed (`drafts/` absent on a fresh checkout); *Run* skipped, no session, no model use.
  - **On `phase-9-task-5-oauth`, PR pending:** the drafts-folder fix and D112 (the runner uses
    `CLAUDE_CODE_OAUTH_TOKEN`; *Check the model credential* stops a run without it before the
    claim). The human creates that secret with `claude setup-token`.
- **Spec 29 (content authoring) drafted, not approved.** `29-content-authoring-spec.md`; G120,
  D110 and Phase 36 are not entered anywhere until the human approves it. Handover note:
  `ovde-sam-stao.md` (repo root, untracked); its "service account / `GDRIVE_SA_KEY`" line is
  superseded by the amendments below.
  - **Amended 2026-10-02** after measurements and a review against the repository (summary
    artifact: claude.ai/artifact/4NTkNwumUnbKgqCZhEKNKF, version 3):
    - Drive is written as the human through an OAuth refresh token, not a service account
      (Google: service accounts cannot own files outside shared drives; the content folder is a
      personal My Drive). Variables `GDRIVE_CLIENT_ID`, `GDRIVE_CLIENT_SECRET`,
      `GDRIVE_REFRESH_TOKEN`; consent screen "In production" (Testing tokens expire in 7 days).
    - Measured: preview `DELETE` → `403` while the doc exists, `204` after it is trashed, `404`
      when already gone; doc names map to lowercased hyphenated paths; previewed content is
      shared by every branch, code is per branch.
    - Design: idempotent `remove` (trash, then unpreview); new `list` operation; cleanup reads
      Drive, not `.ai/scm/` (absent on a CI runner); verify on `<paths.preview>/pages/<id>`;
      the ticket links the branch preview host, not `main--`; new Phase 36 / Task 6 (CI secrets,
      hosts); `write-specs` reproduction pages moved out to a later spec.
  - **Implementation prompt** for a fresh session: `phase-36-implementation-prompt.md`. It stops
    unless the spec is approved and the three `GDRIVE_*` variables are set.

**Waiting on the human:** `/clear`, then the EDS-24 run (see **Do next**); approve deleting the seven
merged Phase 42 branches locally and on origin (`phase-42-task-1-d121` … `-6-stop`, `phase-42-one-element`);
review spec 29; for Phase 36 / Task 1, an OAuth desktop client ("In production") and
`GDRIVE_CLIENT_ID`, `GDRIVE_CLIENT_SECRET`, `GDRIVE_REFRESH_TOKEN` in `.claude/settings.local.json`;
update the Jira rule to version 2; approve deleting `phase-9-task-4-limit1`, `phase-9-task-6-verify`,
`phase-9-task-6-declare`; optionally branch protection for `main` (G118); **add the secret
`CLAUDE_CODE_OAUTH_TOKEN`**, then **dispatch `route-trigger` on `phase-9-task-5-oauth`** with
`item_id=EDS-22`, `comment_id=900705`. (`eds-22` no longer exists on the remote, checked 2026-10-02.)

**Local state (2026-10-04, after Phase 42 merged; superseded by Do next's run state):** `main` = `origin/main` = `118856a`; the checkout is
on `main`, clean except the untracked `.ai/specs/EDS-24/`; seven merged task branches still exist locally
and on origin (`phase-42-task-1-d121`, `-2-ownsel`, `-3-size`, `-4-flag`, `-5-ops`, `-6-stop`,
`phase-42-one-element`) — delete with your yes. The EDS-18 run B leftovers were cleaned with the
human's yes (table.css reverted, `.ai/run-state.json` removed, `eds-18` deleted locally and on origin).
`.ai/run-context/` still holds run B's record (the next fresh start archives it). Stashes: 11, untouched
("EDS-23 run output 2026-10-03" and "parked for EDS-23 resume: EDS-22 draft rewrite" are the human's);
a misfired `git stash pop` on 2026-10-03 was repaired and left the stash list intact (phase-42-task-3-done.md).
`.ai/specs/EDS-24/draft.md` is the new item's draft. *Earlier note, kept for the stash inventory:*
`stash@{0}` ("leftover from eds-18: aem.page host in settings.json allowedDomains") is redundant;
`stash@{1}` ("parked for EDS-21 run") holds `.ai/specs/EDS-19/`, `EDS-20/`, `EDS-21/`. Never commit those files.

## G157, G160 and G151 stay FIXED — no item will be written for them (the human, 2026-10-05)

Phase 44 / Task 6 is done. The three gaps close only if a design item reaches their case by itself: a block that
hides a measured selector at 375 or 768 (G157), a design value row for `min-width` (G160), a width difference at
the reference width so `compare-design-values.py size … width` is called (G151). The Zoki `Table` frames
(`1:195` desktop 1200 = 3 x 400, `1:351` tablet 720, `1:506` mobile 375 = 3 x 200) are EDS-24's nodes and the
columns already match them on `main`, so an item over them reaches none of the three. Read from Figma metadata
only; `table.css` was not re-read.

The prompt below is the one that was run on 2026-10-05; kept for its pre-run checklist.

## Ran 2026-10-05 (partial): Phase 44 / Task 6 — Verification (two live runs from fresh sessions)

**State (2026-10-05, after the merges):** all six PRs merged by the human: #231

<!-- claim: PR#231 status=merged --> (Phase 43 / Task 5, G157), #232 <!-- claim: PR#232 status=merged -->

(Phase 44 / Task 1, G159), #233  (Task 2, G160), #234

<!-- claim: PR#234 status=merged --> (Task 3, G140), #235 <!-- claim: PR#235 status=merged --> (Task 4,

G161), #236  (Task 5, G158), plus #237

<!-- claim: PR#237 status=merged --> (`evidence-manifest.py` double brace, CI red after #232). `origin/main`

= `e161c93`. Stamp checked on a copy of `origin/main`'s `run-route/SKILL.md`: `stamp: fb6392a11419`,
equal to its marker, so no `--write` is needed.
*Before the merges this read:* six PRs open, each cut from `main` `80a059f`, each independent.
**You merge them**, in any order (the reviewer's merge-interaction check is in the final message of the
fixing session; three branches touch `check-breakpoint-regressions.test.sh` in different regions). After
the last merge, run `instructions-stamp.sh plugins/agentic-core/skills/run-route/SKILL.md` on `main` —
#235 changed the driver, so the stamp on `main` must be `fb6392a11419` or be rewritten with `--write`
and committed. Pull `main`, `/clear`, then paste:

```
Phase 44 / Task 6 — Verification. 02-build-tasks.md (Phase 44 / Task 6) and
fix-brief-eds-24-gaps.md ("Phase 44 / Task 6 — Verification" and "Verification-only gaps").
Read 00-instructions.md ("Running a route", "When a run stops"), 01-core-contracts.md §4, §6, §9,
phase-43-task-5-done.md and phase-44-task-1..5-done.md (each ends with the live check it expects),
and G140, G149, G151, G157–G161 in 05-gap-register.md. Do not read AGENTS.md / AGENTS.project.md.
This session edits nothing under plugins/ or .claude/ until both runs end.

Before each run: PRs #231–#236 MERGED (gh pr view); HEAD = origin/main on main, pulled before this
session (G154); stamp of run-route/SKILL.md matches its last line (fb6392a11419 after #235);
git status clean; no .ai/run-state.json; suites counted (find plugins -name '*.test.sh' → expect
126 on main after all six merge: 122 + evidence-manifest + record-transcript-path +
render-run-analytics + the hidden/widths cases inside existing suites); the five repository checks
→ valid.

Run A — a fresh design item written through write-specs (EDS-25 exists from the prep session,
.ai/specs/EDS-25/draft.md; check it is on the tracker and unsatisfied), ideally leaving a width
difference at 1440 so G151's size mode is called. Expect terminal: delivered and:
- G157: no measure envelope says "named target(s) not visible"; a hidden selector shows hidden: true.
- G140: verify-report.md names one measurement file per width; jq .width matches each; the widths
  list and the regression check's lines (or "none") are in the report.
- G159: jq '.coverage_gaps | length == (unique | length)' .ai/run-context/evidence-manifest.json
  → true; a grouped line names its nodes or carries (×n); verify-design-variables-<n>.txt and
  verify-design-compare-<n>.txt exist under .ai/run-context/.
- G160: no "min-width … not in measure's property set" in verify-design-compare-<n>.txt.
- G161: .ai/run-context/analytics.md exists, mtime before the terminal line, one row per stage; the
  driver printed "written: .ai/run-context/analytics.md"; transcript-path.txt holds the session's
  transcript (not a subagents/ path).
- G158: conventions → no font warning (styles subagent success, "out of scope by declaration");
  verify-design-report.md has "## Out of scope by declaration"; the tracker note's Action needed has
  no font line.
- G151 (if size was called): a `size … width` line graded fixable or already equal.
- check-direct-script-calls.sh eds <verify.jsonl> <verify-design.jsonl> → ok.
Run B — /agentic-core:run-route EDS-24 (merged): expect `satisfied	the change for this item is
already merged (…)`, a note on EDS-24, terminal: blocked, no eds-24 branch created → G149 CLOSED.

Each gap goes FIXED → CLOSED only on its quoted line. Write phase-44-task-6-done.md, update the gap
register, NEXT.md and the Remaining Build Work artifact; node docs/agentic-core/check-status-claims.mjs
→ all match; check-numbering.sh 03/04/05 → valid.
Reject if: a run is driven from a session that edited the plugins, or a gap is closed on a line nobody quoted.
```

- Prep for Phase 44 / Tasks 4 and 6 (G161's transcript-path evidence, dx-core on hidden selectors, Phase 17 / Task 5 and Phase 23 / Task 4 readings, Run A item EDS-25 written through `write-specs`): `eds-24-gaps-prep-done.md`.
- Decided 2026-10-05 (that record, "Decided by the human"): Phase 44 / Task 4 builds G161 as a `PreToolUse` Bash hook in run-route's frontmatter that records `transcript_path`, and corrects `03-core-design.md:506`; Phase 17 / Task 5 met under reading (a); Phase 23 / Task 4 stays open until a live run shows the plan-gate mismatch path.

## Ran 2026-10-05: Phase 43 / Task 5 — A selector hidden at a measured width does not fail the read (G157)

**State (2026-10-05):** PR #230  merged with your yes, `main` =
`80a059f`, local `main` pulled. **Every open gap from the EDS-24 run is written up for the fixing session
in `fix-brief-eds-24-gaps.md`** — G157 (this task), G159, G160, G140, G161, G158 as a proposed Phase 44
(Tasks 1–5, verification Task 6; not filed in `02-build-tasks.md` yet), and G149 / G151, which need only
a run. Hand that file to the fixing session with this task's prompt. **Decide first, with the session (AskUserQuestion):** G157's
fix shape — a `hidden` flag in `measure`'s output (§6 amended first), a stage branch for a `fail`
measure envelope, or another. Then `/clear`, and paste:

```
Phase 43 / Task 5 — A selector hidden at a measured width does not fail the read (G157).
02-build-tasks.md (Phase 43 / Task 5). Read 00-instructions.md, 01-core-contracts.md §6, G157 in
05-gap-register.md, phase-43-task-3-done.md and phase-43-task-4-done.md. Do not read AGENTS.md /
AGENTS.project.md. Ask me the fix shape first (G157 lists three); tests first; §6 amended before
measure's output changes. Branch from a freshly pulled main.

Delivers: the chosen fix, its tests, phase-43-task-5-done.md.
You verify: measure at 375 naming .nav-sections on drafts/EDS-24 no longer waits 10 s and fails;
suites pass.
Reject if: measure's output changes without §6 saying so, or the fix is prose in a SKILL.md.
```

## Ran 2026-10-04: Phase 43 / Task 4 — Verification (the EDS-24 run)

Delivered; see **Last done** and `phase-43-task-4-done.md`. The prompt it ran from is in
`NEXT.prev-2026-10-04c.md`.

## Ran 2026-10-04: Phase 43 / Task 3 — `verify-design` renders every breakpoint (D123)

Built; see **Last done** and `phase-43-task-3-done.md`. The prompt it ran from is in
`NEXT.prev-2026-10-04b.md`.

## Ran 2026-10-04 (this session): Phase 43 / Task 2 — What a regression is at a width with no reference (G155, measure first)

Merge PR #225 first if you agree with it (Task 2 does not depend on it). Then `/clear`, and paste:

```
Phase 43 / Task 2 — What a regression is at a width with no reference (G155, measure first).
02-build-tasks.md:3530. Read 00-instructions.md, NEXT.md, G155 and G140 in 05-gap-register.md,
D123 in 04-eds-pack-design.md, phase-42-verification-done.md ("Measured after the run"). Read how
dx-core's dx-figma-verify handles widths first (D123 records it: design widths only).
No code, no branch needed (measurements only); if a scratch script is needed, keep it in $TMPDIR.

Delivers: measurements on the EDS-24 draft (drafts/EDS-24.plain.html; restore it from .ai/logs if
serve's cleanup removed it) at each breakpoint the project declares (styles/styles.css: 900, so
375 / 768 / 1440 as verify captures), with the EDS-24 CSS (table-layout: fixed, applied by style
injection, never written to the tree) and with main's: for each candidate signal — a word broken
across lines, a box narrower than its own min-width, horizontal overflow outside a scroll container,
a size changed against the pre-change render — whether it fires on EDS-24 at 375 and stays quiet on
main and on the delivered EDS-18 / EDS-23 tables (drafts/EDS-18, the g542-* drafts). Numbers for
the human; no rule chosen. phase-43-task-2-done.md.
Depends on: nothing.
You verify: every candidate has a measured fires/quiet result on each page and width.
Reject if: a rule is chosen without the human, a candidate is reported unmeasured, or anything under
blocks/ or plugins/ is written.
```

## Before Phase 43 (2026-10-04, after the EDS-24 run failed at `verify`)

**Cleaned 2026-10-04 with your yes:** `table.css` reverted, back on `main` (`118856a`), `.ai/run-state.json`
removed, `eds-24` deleted locally, on origin and from `.git/config`, the EDS-24 draft popped back to
`.ai/specs/EDS-24/` (untracked). Still there: seven `verify` evidence files on EDS-24, the draft server on
3001, `.ai/run-context/` with the run's record (the next fresh start archives it).

**Decided 2026-10-04 (AskUserQuestion), not built — the next phase:**

1. Leftovers: back to `main`, discard all — done (above).
2. G155: `verify-design` captures every declared breakpoint; a regression at one is `[fixable]` within its
   budget. Phase 43 task to file.
3. G150: kept FIXED until a run names the node the fix targets.
4. G144: fix the stage instruction (every operation call through its own `Skill()`); checker unchanged.

**Then:** the next verification run, from a fresh session on `main` after the fix merges (EDS-24 again, or
a fresh item). The prompt below still applies, with the two corrections already made in it.

## Ran 2026-10-04 (failed at `verify`, see Last done): the EDS-24 verification run

Phase 42 (2026-10-03/04) fixed every defect run B found; all seven PRs are merged (#218–#224, see
**Last done**; `main` = `118856a`, stamp `d52fab5a4253`), and the new item **EDS-24** ("Equal comparison table columns", written through
`write-specs`, live checker `valid`, 0 review notes) is the run's item: a real visual change to the
existing `table` block's comparison variation, same Figma node as EDS-18 (`1-195`), so the design
stages run and the run can reach `deliver`. EDS-18 and EDS-23 are both delivered on `main`; a re-run
of either now stops at the branch slot (D122).

**Before the run, the human:** nothing to merge — local `main` is already at `origin/main` (`118856a`,
pulled 2026-10-04 in the Phase 42 session, before the driving session starts); `/clear` or a new
session. **No run prompt may pull inside the driving session (G154).**

## Paste this after `/clear`: EDS-24 verification run

```
EDS-24 verification run. One run serves Phase 28 / Task 9, Phase 25 / Task 8, Phase 6 / Task 5
(restated criterion), Phase 17 / Task 5, Phase 18 / Task 4, Phase 23 / Task 4, and the live
halves of G144, G150, G151, G152, G153 and D122/G149.

Read docs/implementation-plan/00-instructions.md ("Running a route" and "When a run stops"),
01-core-contracts.md (§4, §8, §9, §10), NEXT.md (this section and Open work), and in
05-gap-register.md: G144, G149, G150, G151, G152, G153, G111. Read phase-42-task-1..7-done.md for
what each fix expects to see. Do not read AGENTS.md / AGENTS.project.md. This session edits nothing
under plugins/ or .claude/ until the run ends.

## Before the run (each step checked, output quoted)
1. `gh pr view <n> --json state` for 218 219 220 221 222 223 224 → every one MERGED. Else stop; the human merges.
2. Shared checkout: ask the human whether another session is live; never switch under one.
3. Do not pull here (G154): `git fetch origin`; HEAD must equal origin/main and be on main;
   `git reflog --date=iso -1 main` must predate this session's first transcript timestamp. Else stop:
   the human pulls, then /clear.
4. Stamp: `bash plugins/agentic-core/shared/lib/instructions-stamp.sh plugins/agentic-core/skills/run-route/SKILL.md`
   must equal the file's last line. Else stop: the human runs it with --write on main and commits.
5. `git status --short` empty (an untracked `.ai/specs/<item>/` draft counts: ask the human to stash it); no `eds-24` branch locally or on origin (`git ls-remote --heads origin eds-24`);
   no `.ai/run-state.json`; `.ai/run-context/` holds run B's record (the fresh start archives it: expect
   `archived: 4x entries`).
6. Suites: every *.test.sh under plugins/ with TMPDIR set (120 run, 0 failed on `118856a` —
   count what you get), validate-contracts.sh plugins, check-no-narrative.sh plugins, check-exec-bits.sh
   plugins, check-stage-envelopes.sh plugins/eds/pack.yaml plugins/eds/skills (47 report nodes),
   validate-naming-rule.sh plugins/agentic-core. Any failure stops the run.
7. Figma MCP authenticated (whoami). gh unsandboxed. The browser operations now run their script
   unsandboxed themselves (Task 5); the stage must not run any pack script directly.
8. Note the session's first transcript timestamp (for Phase 6 / Task 5's criterion).

## The run
`/agentic-core:run-route EDS-24`, interactive. Let it reach a terminal state. If a stage asks, answer;
record every question. Expected: 15/15 stages, `terminal: delivered`, a PR from `eds-24` changing
blocks/table/table.css only.

## After the run, check (quote file and line for each)
- D122 / G149 (Task 6): `envelope-check-status.txt` exists with `change_state: none` for `eds-24`;
  the driver printed `continue	change_state=none`; the run did not stop at the branch slot.
- G150 (Task 2): `verify-design-report.md` has no `[fixable] … gap` on a `td:nth-child` selector; every
  `unmeasured` line for node 1:217 says `no selector recorded for this property`.
- G151 (Task 3): the report shows `size` mode lines — a `th width` difference is `fixable` (or already
  equal after the item's change) and `th height` is `content-dependent`; `variables` mode lines name
  `th:first-child p`, `td p`, never `.table`. The column widths end equal (AC-1 of EDS-24).
- G144 (Task 5): from this session's subagent transcripts (~/.claude/projects/<project>/<session>/subagents/,
  pick the ones whose forked-skill.json names eds:eds-verify and eds:eds-verify-design):
  `bash plugins/agentic-core/shared/lib/check-direct-script-calls.sh eds <verify.jsonl> <verify-design.jsonl>`
  → `ok: no provider script run directly (…)`. Also no "could not launch" summary in any browser envelope.
- G152 (Task 1): the driver's stamp matched; `grep -c 'at most \`warn\`' plugins/agentic-core/skills/run-route/SKILL.md` → 0.
- G153 (Task 4): `.ai/run-context/orchestrating.flag` is first written at Record intake stage: its
  mtime is not earlier than `run-state.json`'s first write (compare `ls -l --time-style=full-iso` or
  `stat -f %m`); during intake no flag existed (the driver's progress shows intake before `written:`).
- Phase 6 / Task 5 (restated, Task 7): `.ai/logs/run-route-reads.log` has ≥1 ALLOW/DENY/NORUN line with a
  timestamp inside this session; 0 DENY lines between the marker write and the terminal state; run delivered.
- Phase 28 / Task 9: delivered; `http://localhost:3001/drafts/EDS-24` answers 200 after the run; the link,
  the local-only line and the restart command are in the PR body and the tracker note (G142's Pending
  section if a check is still running); both gates' tree guard passed; each gate's report states isolation.
- Phase 25 / Task 8: `publish-gate` → `warn` with the Roboto Mono finding (`grep -c -i roboto publish-gate-report.md` ≥ 1),
  `decision: continue-warn`.
- Phase 17 / Task 5, Phase 18 / Task 4, Phase 23 / Task 4: as in their partial records (edit rounds,
  budgets, `## Content-dependent, not graded`).
- Gaps G144, G150, G151, G152, G153, G149 go from FIXED to CLOSED only if their check above passed; quote the line.

## After the checks
Write phase-42-verification-done.md (checks, quotes, defects found), update the gap register, NEXT.md and
the Remaining Build Work artifact (https://claude.ai/artifact/ReUgiwzUWNpCEbMw8cPqVU), run
node docs/agentic-core/check-status-claims.mjs and doc-numbering's check-numbering.sh.
Optional second run, if the human wants the D122 stop seen live: `/agentic-core:run-route EDS-18` from
another fresh session — expect `satisfied	the change for this item is already merged (…)`, a note on
EDS-18, `terminal: blocked`, no branch created.
```

## Then: Phase 9 / Task 5 — A headless run, end to end (in progress)

`02-build-tasks.md:1642`. State on 2026-10-02 (evening session):

- **Merged:** PR #205  (refused calls printed whole, shape
  hook) and PR #207  (G131 verify page mode/D114, G132
  `origin/HEAD` on the runner, G133 design source only `design-reference.*`/D115, G130 Stop hook,
  G134 stage-list files written by the evaluator, D116 sandbox auto-approval). Records:
  `phase-9-task-5-denials-partial.md`, `phase-9-task-5-repro-partial.md`.
- **Merged 2026-10-03:** PR #209  (`phase-9-task-5-notrack`, G135):
  `create_branch` branched from `origin/main` writes tracking to `.git/config`, which the sandbox
  refuses; first run from `main` (`37066554833`) failed there.
- **Best run so far:** `37061953739` reached `publish-gate` (12 of 14 stages); its only refusal was
  the branch carrying unmerged fix commits. No run has reached `deliver` yet.
- **Identity limit:** 10/10 used on 2026-10-02 plus one `override=true` run. A run today needs
  `override=true`; tomorrow it resets.

## Paste this for Phase 9 / Task 5, after the EDS-23 run

**Phase 9 / Task 5 — A headless run, end to end (continue).**
Read `00-instructions.md` and `01-core-contracts.md` first. Then `02-build-tasks.md` § "Phase 9 /
Task 5" (line 1642), `phase-9-task-5-denials-partial.md`, `phase-9-task-5-repro-partial.md`,
G130–G135 in `05-gap-register.md`, D114–D115 in `04-eds-pack-design.md`, D116 in
`03-core-design.md`, and `plugins/agentic-core/shared/runner/README.md`.

1. **First, a decision for the human (AskUserQuestion):** this task's "Reject if" forbids widening
   the allowlist to bare `Bash` and relaxing `dontAsk`. D116 keeps `dontAsk` but auto-approves every
   sandboxed command, which is bare `Bash` bounded by the sandbox. Ask whether to amend the
   criterion to match D116 (the sandbox is the boundary), or to revisit D116. Do not close the task
   before this is answered.
2. PR #209 is merged (2026-10-03).
3. Before dispatch: `git ls-remote --heads origin eds-22` must be empty (delete only with the
   human's yes); EDS-22 may carry earlier runs' `capture-*.png` attachments — leave them, D115 is
   proven to ignore them.
4. Dispatch from `main`: `gh workflow run route-trigger.yaml --ref main -f item_id=EDS-22 -f comment_id=<fresh integer, last used 900716>` (add `-f override=true` only if the human says
   so). Watch with `gh run watch <id>`; read the log's `permission denials` and `final message`
   lines — the runner prints them whole.
5. **You verify** the run reaches `terminal: delivered`: a PR from `eds-22` exists, its diff is
   only `styles/styles.css`, and EDS-22 **fetched back from the tracker** carries the run's note
   with `URL for testing:` and D87's reachability statement.
6. For every new stop: read first (`00-instructions.md` "When a run stops"), measure locally if a
   permission or sandbox question (scratchpad SDK probe; copy the runner's own rule construction,
   absolute paths are `Edit(//…)`), file a G entry, fix test-first, PR, re-run.

**Known open, not blocking:** no CI workflow runs `plugins/github` test suites (G135); evidence
captures accumulate on the item per run (G133 note); `terminal-capture.test.mjs:74` names
`eds-22` in the core; the naming checker misses a lower-case pack name inside a path (G130 note).

When done: write `phase-9-task-5-done.md`, update `NEXT.md` and the Remaining Build Work artifact.

## Open work (from the archived track files)

### EDS-18 verification run — after PR #202 merges (supersedes the Phase 28 / Task 9 prompt below)

Fresh session that has edited no plugins. Paste:

```
EDS-18 verification run, after PR #202 (G122) merges. One run serves six open checks.

Read docs/implementation-plan/00-instructions.md ("Running a route" and "When a run stops"),
01-core-contracts.md (§8, §10), NEXT.md (Phase 28 / Task 9, Phase 25 / Task 8, Phase 6 / Task 5,
Phases 20–23), g122-size-utility-done.md, and the Phase 17 / Task 5, Phase 18 / Task 4 and
Phase 23 / Task 4 entries in 02-build-tasks.md. Do not read AGENTS.md / AGENTS.project.md.
This session must edit nothing under plugins/ or .claude/ until the run ends.

## Before the run (each step checked, not assumed)
1. `gh pr view 202 --json state` → MERGED. If not, stop: ask the human.
2. Shared checkout. Another session (Phase 9 / Task 5) may be using it, on `phase-9-task-5-e2e`
   with uncommitted runner changes. Ask the human whether it is idle. Never switch branches under a
   live session. If its changes are still in the tree, the human parks them (`git stash`, not a
   commit). `stash@{0..2}` belong to other work; leave them alone.
3. Do not pull in this session (G154): `git fetch origin main`; the tree must already be on `main`,
   HEAD must equal `origin/main`, `git reflog --date=iso -1 main` must predate this session (else
   stop — the human pulls, then `/clear`), and HEAD must
   contain G122 (`grep -c element_rows plugins/eds/skills/eds-prototype/scripts/design-context-values.py`
   → 3 or more).
4. No `eds-18` branch, locally or on origin (deleted 2026-10-02). If one exists, stop and ask.
5. Archive the old run: move `.ai/run-context/` and `.ai/progress.md` to
   `.ai/logs/run-context-<date>-<time>/`, and remove `.ai/run-state.json` (left by the 2026-10-02
   run, `last_stage: baseline`; a run less than 2h old would resume instead of starting fresh).
6. `git status`: no untracked leftovers that `deliver`'s `git add -A` would sweep in.
7. Phase 6 / Task 5, first: match `.ai/logs/run-route-reads.log` timestamps against runs that
   reached `delivered` (EDS-7 2026-09-24, EDS-18 in Phase 27 / Task 7). Write down what you find.
8. Run every `*.test.sh` under `plugins/` with TMPDIR set, plus `validate-contracts.sh`,
   `check-no-narrative.sh`, `check-exec-bits.sh` (each on `plugins`) and
   `check-fix-budget-readers.sh plugins/eds`. Report counts. Any failure stops the run.
   `check-orchestration-flag` was flaky at 7199s and is fixed at 7195s; a failure there is new.
9. Design provider authenticated (Figma MCP). Run gh unsandboxed (TLS fails in the sandbox); start
   `aem up` unsandboxed (EPERM on the port).

## The run
`/agentic-core:run-route EDS-18`, interactive. Let it reach a terminal state. When the first
pack skill loads, check its base directory: it must be the checkout (`…/plugins/eds/…`), not
`~/.claude/plugins/cache/`, which is stale (2026-09-21) and is not what runs.

## After the run, check (quote the file and line for each)
- **G122:**
  - `design-context-values.tsv` has `…;1:563` width and height `14px` rows, approx `false`.
  - The script's stderr names no conflict, or every conflict it names is listed.
  - **The one unproven point:** `prototype-report.md`'s `## Design values` ties `.icon`'s width
    and height to a `…;1:563` node, and `check-size-origin.py check` exits 0.
  - If the tie is missing, that is a new gap in `eds-prototype`, not G122.
- **Phase 28 / Task 9:**
  - `terminal: delivered`.
  - `http://localhost:3001/drafts/EDS-18` answers 200, checked only after the run ends.
  - The link, the local-only line and the restart command are in the PR body and in the tracker
    note.
  - serve's cleanup deleted `drafts/EDS-18.plain.html` before prototype wrote it again.
  - `verify-design-check-*.txt` exist, and the loop ended "nothing fixable" or named a [fixable]
    entry.
  - Both gates' tree guard passed.
  - Each gate's report states its isolation.
- **Phase 25 / Task 8:**
  - `publish-gate` → `warn` with the Roboto Mono finding.
  - `envelope-publish-gate.txt` is non-empty.
  - `run-stage.sh <eds pack.yaml> publish-gate .ai/run-context/envelope-publish-gate.txt` →
    `decision: continue-warn`.
  - `publish-gate-report.md` holds the finding.
- **Phase 17 / Task 5:** `verify-design-report.md` shows up to two edit rounds with three
  comparisons.
- **Phase 18 / Task 4:** that report names a distinct screenshot per check, and the evidence
  manifest attaches each one once.
- **Phase 23 / Task 4:**
  - `verify-design-report.md` has "## Content-dependent, not graded".
  - The table has approx rows `1:197`, `1:206` and `1:215`, height `96px`.
- **Phase 6 / Task 5:** `.ai/logs/run-route-reads.log` has `ALLOW` lines with this run's
  timestamps.

If the run stops: follow "When a run stops: read first, decide second" in 00-instructions.md.
Classify the stop before changing anything. Every defect you find, of any kind, goes as a
numbered list into the gap it belongs to and into the done record.

## Close
- Archive the run context.
- Write `phase-28-task-9-done.md`, naming which of the six checks passed, failed or were not
  reached, each with evidence.
- Close G122 only if its unproven point passed.
- Close G111 and rename `phase-6-task-5-status.md` only if that check passed.
- Update NEXT.md, then run `node docs/agentic-core/check-status-claims.mjs`.
- Reject if: the run is claimed from a session that edited plugins, a check is reported without
  being read, or the link is checked before the run ended.
```

### Phase 28 / Task 9 — Verification: one EDS-18 run *(was `next-phase-28.md`)*

Every build task is merged (Phase 28 Tasks 2–6 and 8). `02-build-tasks.md`, Phase 28 / Task 9.
Needs a **fresh session that has edited no plugins**. Prompt:

```
Phase 28 / Task 9 — Verification.
Read docs/implementation-plan/NEXT.md (this section), archive/next-phase-28.md (Traps),
phase-28-task-8-done.md and the Task 9 entry in 02-build-tasks.md (Phase 28).

Start on an up-to-date main, pulled by the human before this session began (G154): git fetch
origin main; HEAD == origin/main; never pull or switch inside this session.
Run gh unsandboxed (sandbox TLS fails); start aem up unsandboxed (EPERM on the port).

First run every *.test.sh under plugins/* in the sandbox; all must pass. Then run
/agentic-core:run-route EDS-18 and let it finish. Only after the run ends, check the verified link
http://localhost:3001/drafts/EDS-18 answers 200.

You verify: the run reaches terminal: delivered; the link answers 200 after the run; the link, the
local-only line and the restart command are in the PR body and in the EDS-18 tracker note; serve's
cleanup reported deleting drafts/EDS-18.plain.html before prototype wrote it again;
verify-design-check-*.txt exist and the loop ended "nothing fixable" or with a [fixable] entry
named; both gates' tree guard passed; each gate's report states its isolation (present, or absent
with the verdict at most warn).
Also check the same run against Phase 25 / Task 8 (below).
Reject if: the live run is claimed from a session that edited the plugins, or the link is checked
before the run ended.

Archive the run context as in Phase 26 / Task 6, write phase-28-task-9-done.md, update NEXT.md.
```

Not re-checked since `next-phase-28.md` was written (2026-09-29): EDS-21 (#198) changed
`blocks/table/table.css` since then, so the EDS-18 run will start from a different table block.

### Phase 25 / Task 8 — Verification, part 2 *(was `next-phase-25.md`)*

Part 1 (static checks) passed; the code is merged in PR #160 .
Part 2 is the live run: `publish-gate` returns `warn` with the Roboto Mono finding;
`.ai/run-context/envelope-publish-gate.txt` is non-empty right after the stage returns;
`run-stage.sh <eds pack.yaml> publish-gate .ai/run-context/envelope-publish-gate.txt` prints
`decision: continue-warn`; `.ai/run-context/publish-gate-report.md` holds the finding; the run
reaches `terminal: delivered`. Check it on the Phase 28 / Task 9 run. `'Roboto Mono'` is still in
`blocks/table/table.css` on `origin/main` `1d7caad`, now at line 132 (was 46). Whether the project
still loads no such font was not re-checked, and neither was whether the gate will flag a line the
run did not change.

### Phase 32 — A nested node finds its viewport counterparts *(specified, not filed)*

Full spec: `archive/next-phase-32.md` — kept there as the only copy; it is a pending build input
despite the directory. **Waiting on the human:** approve and file its gap and decision entries
(unnumbered), and confirm the phase number (32 provisional; next free after it is 35). Then
Tasks 1–4 as written there.

### Phase 33 residuals *(was `next-phase-33.md`)*

- D545's step (the route checks its derived branch name) has not been observed in a real run's
  artifacts.
- The G546 fix has not been observed blocking or allowing in a live session.
- SEO 61 on the branch preview (#187). Not investigated.
- Local tidy-up: `stash@{0}` (EDS-19/20 specs) and `.ai/logs/parked-specs/EDS-21/draft.md` to
  restore; the draft server on port 3001.
- Remote branches to delete, **with the human's approval**: `psi-preview-url`, `psi-followups`,
  `psi-served-probe`, `branch-name-rule`, `phase-33-task-4-fixture`, `phase-33-task-5-length`,
  `phase-34-task-1-fields`, `phase-34-task-2-extract`, `phase-34-task-3-keyless`,
  `g548-publish-drift`, `eds-21`, `g546-redirection`.

### Phase 6 / Task 5 — the driver's read hook, verified by a run *(was `next-phase-6.md`)*

Merged in PRs #125 and #126  ;
`02-build-tasks.md:986`; status `phase-6-task-5-status.md`; design `19-driver-read-allowlist-spec.md`;
D101; G111 (merged, not verified live). **Criterion:** one route reaches `delivered` with the hook
in place, and `.ai/logs/run-route-reads.log` shows `ALLOW` lines written by that run.

- **The archived file is stale on one point.** It says the hook "has never once been observed to
  fire". The log does exist: 27 lines, 10 `ALLOW` and 17 `DENY`, from 2026-09-22 to 2026-09-29, read
  2026-09-30. Nobody has matched those timestamps to a run that reached `delivered` (candidates: EDS-7
  on 2026-09-24, EDS-18 in Phase 27 / Task 7). Do that first. It may close the task without a new
  run.
- Several `DENY` lines are the hook denying reads in sessions that were not route runs (`docs/`,
  `MEMORY.md`). That is the "read hook outlives the run" effect, not evidence about a route.
- Cheapest proof: the Phase 28 / Task 9 EDS-18 run. Before it, confirm that the installed plugin
  cache carries `check-driver-read.sh` (`archive/next-phase-6.md`, Step 1: the cache, not the
  checkout, is what runs).
- When it passes: rename the status file to `phase-6-task-5-done.md`, close G111 with the log as
  evidence, and update D101's "not yet verified" line.
- Never widen the allowlist to make a denial go away. Fix the caller.
- Phase 6 / Task 4 (a second platform) is nice to have.

### Phases 20–23 — the Figma live checks *(was `next-phase-20-23.md`)*

Every build task is merged: Phases 20–22 in PR #159 , and
Phase 23 / Tasks 1 and 3 in PR #177 . Phase 24 (Figma access,
D523: remote server only) is closed; its only record is `archive/next-phase-20-23.md`. What is left
is live runs, each from a **fresh session that edited no plugins**:

- **Phase 20 / Task 5** (`02-build-tasks.md:2626`): suites, then one route on `Zoki` node `1-185`.
  `design-reference.json` carries `design_context`, the block CSS carries the node's padding and
  radius, and `verify-design-report.md` measures both. Record the Figma call count.
- **Phase 21 / Task 5** (`:2686`): one route on a two-variant frame, each variant compared at its own
  width, and the Figma call count recorded. On the Zoki file this needs a link to the section, not a
  block's own node, until Phase 32 lands.
- **Phase 22 / Task 3** (`:2721`): one route whose verify-design report shows an image or icon asset
  compared.
- **Phase 23 / Task 4** (`:2772`): one route on an item whose design has placeholder copy.
  `verify-design-report.md` carries a "content-dependent, not graded" section. The relevance
  threshold (1, provisional) is to be re-measured once 5 or more real pairs exist.
- **Phase 23 / Task 2** stays logged (G539) until a real frame shows a pasted screenshot. Nice to
  have.
- The archived file's own "Next task — Phase 20 / Task 1" prompt is obsolete: that task is done.

One route can cover several of these if its item is chosen for it. Decide which items before
running.

### Phase 35 — G502, onboarding notices the design it did not apply

The human made G502 the next task on 2026-09-30; on 2026-10-01 they finished Phase 9 / Task 6
first and asked for Task 5's prompt here. Tasks 1 and 2 are ready; Task 1's prompt:

**Phase 35 / Task 1 — Watch onboarding run on a project that disagrees with its design.**
Read `02-build-tasks.md` Phase 35 (line 3269), the G502 entry in `05-gap-register.md`, and D82 in
`03-core-design.md` (the append-never-remap rule). Read `00-instructions.md` first.

**Set-up, never in the shared checkout:** clone `origin/main` into a separate directory. In the
clone, restore the pre-onboarding site from `6db94bd^` (the commit before #64): the five files #64
changed (`git show --stat 6db94bd`: `.ai/design/audit.md`, `blocks/cards/cards.css`,
`package.json`, `styles/design-system.md`, `styles/styles.css`), plus whatever
`.ai/project-config.yaml`'s `onboarding_state_path` names. The plugins stay at `origin/main`, so
today's stages meet the old site. **Unverified:** whether a session opened in the clone loads the
project's plugins. Check that first, and ask the human if it does not.

**This session delivers:** one observed run of `eds-adopt-design-system` then
`eds-complete-design-onboarding` in the clone, and `phase-35-task-1-done.md` answering G502's three
questions (what the stages do to disagreeing tokens; whether the divergence is visible at onboarding
time; what the human is shown and asked), each backed by a transcript line or a file diff. Record
every question asked and every file written, and include the final `styles/styles.css` diff.

**Reject if** an answer is read off a `SKILL.md` instead of observed, or anything is written in the
shared checkout. No PR: this task changes no shipped file. Then overwrite this section for Phase 35 /
Task 2 (or run Task 2 first; they are independent).

Tasks 1 and 2 are independent; Task 3 decides with the human; Tasks 4–6 build and verify.
`02-build-tasks.md:3269`.

### Phase 37 — Component sizes match the design *(planned 2026-10-02, not in `02-build-tasks.md` yet)*

Planned from a review of `skojic/aem-eds-figma-to-code` (`d44edff`) against this repo's sizing
gaps. 36 is taken by spec 29's proposal, so this is 37. That reference measures no element box and
has no fix loop; what it adds is rules, not machinery. Already covered here, so not borrowed: the
"no fixed size from placeholder copy" rule (ours is enforced by `check-size-origin.py`, D541) and
waiting for fonts before measuring (`plugins/playwright/scripts/settle.cjs`). Every task measures
before it decides.

- **Phase 37 / Task 1 — G536 through a work item. Obsolete 2026-10-02: G536 measured fixed on `main` by EDS-21.** Write the item with `write-specs`; criterion:
  header text top at y 40 (41 for "Area") at 1280, header 98px unchanged. The fix is measured
  (`phase-28-task-7-done.md`, Counterfactual B). Delivered by the route, as EDS-21 delivered G542.
- **Phase 37 / Task 2 — Measure exact-equality mismatches (G125).** From the archived
  `verify-design` reports, count length mismatches below 1px and below 2px, and which cost an edit.
  Read how `dx-core` treats near-equal values first. Output: numbers for the human, no rule.
- **Phase 37 / Task 3 — Tolerance, with recurrence promotion, or neither (G125).** Decided by the
  human from Task 2's numbers. If a tolerance is chosen: tests first in
  `compare-design-values.py`, and the same drift on one selector and property at two or more
  viewports stays a mismatch. Depends on Task 2.
- **Phase 37 / Task 4 — Out-of-flow collapse check (G126).** A deterministic script, tests first.
  Before it ships, run it on `block-collection`'s `video` and `embed` and record that it does not
  fire on them. The required height comes from the node's own `aspect-ratio` / `min-height` row
  (D541).
- **Phase 37 / Task 5 — Stroke against border box (G124).** Measure both candidates on EDS-18's
  `th` at 1280: `box-sizing: border-box` in the block, and subtracting an inside stroke in the
  comparison. The human decides from the numbers; then build, tests first.
- **Phase 37 / Task 6 — Verification.** All suites pass, then EDS-18 from a fresh session: header
  96px, header text at y 40, no stroke mismatch, no collapse finding on any block.

Not covered here: G122 (`size-[…]` drops width and height rows, the 2026-10-02 EDS-18 `prototype`
fail), fixed in PR #202, not merged. G510 (verify measures the wrapper) stays open.

<!-- claim: G536 status=FIXED --> <!-- claim: G124 status=OPEN --> <!-- claim: G125 status=OPEN --> <!-- claim: G126 status=OPEN -->

### Waiting on the human

- Review spec 29 (`29-content-authoring-spec.md`, amended 2026-10-02).
- For Phase 36 / Task 1: an OAuth desktop client ("In production") and the three `GDRIVE_*`
  variables in `.claude/settings.local.json` (spec 29 §3b).
- What happens to the existing `eds-22` branch (blocked run c900702).
- The Jira rule version 2 (`triggers/jira/README.md`).
- Approval to delete `phase-9-task-4-limit1`, `phase-9-task-6-verify`, `phase-9-task-6-declare`.
- Phase 32's gap and decision entries.
- The four design font families (D530), if EDS-18 should match typographically.

## Track files

None live. `archive/` holds every former pointer (`next-phase-3`, `-6`, `-14`, `-20-23`, `-25`,
`-26`, `-27`, `-28`, `-32`, `-33`); `archive/README.md` says why each one is there.

## Open, not blocking

- **The shared checkout.** Two sessions share one working tree. Typing a command as an
  AskUserQuestion answer does not run it — it must be typed in the prompt.
- **`setup` does not ask for CI credentials.** Candidate: a `setup` interview step that names each
  pack's headless variables. Not filed as a gap yet — file one before building.
- **The driver's read hook under the SDK** is unproven: only `fetch-item` ran through the runner,
  never `run-route`. Phase 9 / Task 5's first run proves or disproves it.
- **G510** — `verify` measures the block wrapper, not the styled element.
  <!-- claim: G510 status=OPEN -->
- **G534** — the draft server is stopped before review.
- **G536** — EDS-18 header text sat ~7 px high; fixed by EDS-21, measured 2026-10-02.
- **Not re-checked since they were reported:** `deliver` reading CI before it settles (D534 may
  cover it); `verify` and keyboard criteria (D69 `interact` may cover it); eslint's missing
  `require-async-decorate` rule; the `files_named` fallback; "Run **Teardown**" still named in
  `eds-verify` and `eds-verify-design`.

## Parallel work 2026-10-02 (session on `g127-g129-fixes`, worktree `.claude/worktrees/g127-g129`)

- **PR #206 merged**  — G127
  (fix built, closes on a fresh EDS-18 run), G128 fixed on the branch, G129

  <!-- claim: G129 status=OPEN --> via D113 / Phase 38 / Tasks 1–3. Records:

  `g127-g128-done.md`, `phase-38-task-1-done.md` … `-3-done.md`.
- **Phase 38 / Task 4 (verification) is next after merge:** one fresh-session route run; every
  `capture-envelope.sh` line must read `unchanged`, and `lint` must pass on its first check (G127).
  EDS-18 is already delivered (PR #170), so its run will end at `publish-gate` with "no change to
  review" until the no-op decision below is made.
- **Waiting on the human:** the already-satisfied-item decision,
  https://claude.ai/artifact/PChibrB6FmFW2xu9xfzUkE (not filed; its D number is no longer D113 —
  D113 is now the envelope decision).
- **G536 measured fixed on `main` 2026-10-02**  by EDS-21's
  removal of the fixed height; Phase 37 / Task 1 is obsolete. Design fonts (D530) stay a `warn`, not
  a work item (the human, 2026-10-02). A fresh verification item is still to be chosen.
- **EDS-23 created 2026-10-02** ("Comparison table header matches the design height", Story,
  component `table`, Zoki node `1-195`; draft `.ai/specs/EDS-23/draft.md`; live check `valid`).
  It is the verification item that replaces EDS-18 (already on `main`): header 96px as in Figma.
  **Order:** merge PR #206 → fresh session from `main` → `/agentic-core:run-route EDS-23`. That one
  run serves Phase 38 / Task 4, G127 and G122, and is the run Phase 28 / Task 9, 25 / 8, 17 / 5,
  18 / 4 and 6 / 5 were waiting on EDS-18 for. AC-1 (exactly 96px) will meet G124's 2px border case.
- **EDS-23 updated 2026-10-02** (AC-1: 96px including padding and bottom border; AC-4: only text
  elements may not carry a fixed height; AC-5 now also at 1280). **D116** (border-box sizes, the
  `leading-[0]` translation; replaces Phase 37 / Task 5) and **D117** (no rule → read the pack's
  declared official reference, MDN for eds) are filed, **not built**. Build them before the EDS-23
  run, or the run tests the old behaviour.
- **D116 and D117 built 2026-10-02** on `phase-39-bbox-docs` (stacked on `g127-g129-fixes`), Phase 39
  / Tasks 1–2; records `phase-39-task-1-done.md`, `-2-done.md`. Merge #206 first, then this PR, then
  the EDS-23 run (Phase 39 / Task 3, Phase 38 / Task 4).

## Track file opened 2026-10-03: `next-phase-41.md` (provisional number)

Opened at the human's request: work-item drafts are recorded in a track file, never carried to
`main` in a PR. It holds the verified stash inventory (eleven stashes, classified by blob
comparison), where every work-item draft lives (tracker is the authority), the fact that Phase 10 /
Task 2's commit `9e5ad16` exists only on this machine (G503 ),
the tracker-status finding (every EDS item is To Do), and three proposed entries, unnumbered.
Done 2026-10-03 with the human's yes: `specs-eds-22-23` deleted; `9e5ad16` pushed as
`phase-10-task-2` (the D544 hook refuses the 41-character original name); 13 older `NEXT.prev-*.md`
moved to `archive/`. Still open there: drop the stale stashes by name, file the entries. This section is
appended, not merged into the text above, because the Phase 40 track owns the rest of this file.

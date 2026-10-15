# Implementation instructions — Automated EDS Delivery

Local-only, gitignored. Standing rules and the document index for the delivery automation.
EDS block-authoring policy is not here — that is `AGENTS.md`.

## Read on trigger

Do not guess at a document's contents. Read it.

- `NEXT.md` — **read this first, always.** One file, overwritten after every task: which task is
  last-done and the ready-to-paste prompt for the next one. Reading it replaces globbing for
  `phase-<n>-task-<m>-done.md` and cross-checking `git log`. Sanity-check it once with
  `ls -t docs/implementation-plan/phase-*-done.md docs/implementation-plan/archive/phase-*-done.md | head -1` before trusting it — a session
  that crashed mid-task can leave it stale. Then run `node docs/agentic-core/check-status-claims.mjs`:
  every PR or gap status in `NEXT.md` and `next-*.md` carries a `<!-- claim: … -->` marker, and the
  script checks each one against `origin/main` and the gap register (G545). A status written into
  either file without a marker is not trusted.
- `archive/next-phase-3.md` — **a completion record, archived 2026-09-30.** Phase 3 was run as a parallel track on
  its own branch and linked worktree, both merged and deleted 2026-09-21. Read it for what landed,
  for the one item still open that no task covers (the never-
  investigated `aem-psi-check` failure) — G109's duplicated D94/D95 were renumbered 2026-09-22 —
  and for the three process lessons that track produced.
  Nothing in it is waiting to be picked up. *The per-track convention it demonstrated (a parallel
  track gets its own `next-<track>.md`, never crossing `NEXT.md`) was retired 2026-09-30 by the
  human:* `NEXT.md` is the single pointer and carries every track's open work under **Open work**.
  Open a separate track file only when the human asks for one.
- `archive/next-phase-6.md` — **archived 2026-09-30.** Phase 6 / Task 5's verification steps
  (plugin-cache check, log reading). Its open item is in `NEXT.md`.
- `archive/next-phase-14.md` — **a completion record, archived 2026-09-30.** Phase 14 finished 2026-09-24 (Tasks
  1–9, PRs #138–#143; EDS-13 delivered as PR #144). Nothing in it is waiting to be picked up.
  Carries the two git traps that track hit — a
  half-applied `git switch -c` that left HEAD behind, and a local `main` 12 commits stale. Same
  convention as `next-phase-3.md` and `next-phase-6.md`: it and `NEXT.md` never cross.
- `archive/next-phase-20-23.md` — **archived 2026-09-30; the only record of Phase 24** (Figma
  access, D523), which has no heading in `02-build-tasks.md`. The live checks for Phases 20–23 are in
  `NEXT.md`.
- `archive/next-phase-25.md`, `archive/next-phase-28.md`, `archive/next-phase-33.md` — **closed
  pointers, archived 2026-09-30.** Their open items (Phase 25 / Task 8 part 2, Phase 28 / Task 9,
  Phase 33 residuals) are carried in `NEXT.md` under **Open work**.
- `archive/next-phase-32.md` — **a specification, pending; not filed, not scheduled** — the one
  archived file that is still a build input. A block node nested inside one viewport frame finds
  its tablet and mobile counterparts. Its gap and decision entries are unnumbered until filed;
  Phase 32 is provisional. `NEXT.md` points to it.
- `01-core-contracts.md` — the interfaces. **Wins when documents disagree.** Read before building
  any part of the core or a pack.
- `02-build-tasks.md` — the only current task list, Phases 1–18, 20–23 and 25–28 (19 is reserved for the
  unapproved `23-eval-harness-spec.md`). Read before implementing anything,
  and to answer "what's next". *Appended after the original Phases 1–6: Phase 7 (delivery evidence)
  2026-09-17 — G86, D86–D88, designed in `14-delivery-evidence-spec.md`; Phase 8 (fixture call site)
  2026-09-17 — G88, D91, designed in `15-fixture-call-site-spec.md`; Phase 9 (headless execution)
  2026-09-19 — executes D25's deferred half; Phase 10 (design references without an interactive
  session) 2026-09-19 — bounds Phase 9; Phase 11 (the serve notice) 2026-09-19 — G100, D94;
  Phase 12 (a reviewable rendered page per work item) 2026-09-21 — **logged not scheduled**, bounded
  by D87, filed as candidate work rather than as a gap. Phase 3's three unbuilt tasks were scheduled
  2026-09-21 as a six-task sequence (Tasks 5, 6, 9, 7, 10, 11); Tasks 6 and 7 were rewritten and
  Tasks 9–11 added — see `17-provider-preconditions-spec.md`. Phases 13–18 (2026-09-22 to
  09-25) each name their own gaps and decisions in their headings. Phase 20 (design context,
  D517) was widened 2026-09-28 with G517, G520, D518, D519 and D522. Phases 21 (viewports, G518,
  D520), 22 (assets, G519, D521) and 23 (**logged not scheduled**) came from the same day's
  `dx-figma-extract` comparison.*
- `03-core-design.md` — core reasoning and decisions D1, D2, D4–D6, D9, D11–D14, D16, D17, D19,
  D23, D25, D26, D28, D33–D42, D58–D65. Neutrality pass complete (Phase 2 / Task 22).
  *Numbering note (2026-09-08):* D42 and D43 had each been used twice. The less-cited sense of each
  was renumbered — the gate-review decision to **D64**, the config-parser decision to **D65** — so
  every surviving "D42"/"D43" citation means the conditionality and `design`-provider decisions
  respectively. Both renumbered entries carry a note saying so.
- `04-eds-pack-design.md` — platform-only material and decisions D3, D7, D8, D10, D15, D18,
  D20–D22, D24, D27, D29–D32.
- `05-gap-register.md` — gaps G1–G30. Read before claiming a gap is closed.
- `06-dx-core-deviations.md` — settled `dx-core` deviations. Read before the deviation rule below
  fires. Do not re-litigate what is in here.
- `07-eds-skills-audit.md` — verdicts on Adobe's EDS skills. Read before adopting, replacing or
  duplicating one.
- `08-local-environment.md` — machine and account facts. **Never publish.**
- `09-project-record.md` — history only. Read for how the design got here. Holds no decisions and
  no gaps.
- `10-provider-onboarding-spec.md` — **draft for review (2026-09-06), not approved and not a build
  input.** Proposes replacing the single Phase 3 / Task 5 entry with four tasks. Its D53–D57 were
  never filed — confirmed 2026-09-17: zero occurrences of any of them in `03-core-design.md` — so
  nothing in it has reached the plan of record, and its §4 proposals deliberately claim no
  `02-build-tasks.md` task ids. Read to avoid re-deriving the proposal; do not cite it as settled.
- `archive/11-condition-filter-spec.md` — **approved and filed 2026-09-07; now a reasoning record, not a
  pending proposal.** The design behind Phase 2 / Task 26: D58–D63 (`03-core-design.md`, filed as
  inline entries rather than headings), G37 (`05-gap-register.md`), and the §11 / §13.14 amendments
  in `01-core-contracts.md`. Read before touching the condition grammar, `route.dot`, or validators
  1 and 12–14. The contract still wins where they disagree.
- `12-figma-notes.md` — operational findings about Figma access in this project (Dev Mode seat,
  headless-session MCP connectivity, the local plugin marketplace). Read before any Figma-touching
  work; update it with new findings rather than re-deriving what is already here.
- `13-write-specs-spec.md` — the spec for the work-item authoring skill (`write-specs`) and its
  checker. Read before changing anything under `.claude/skills/write-specs/`, and before
  writing a Jira item by hand. Decisions D85 (`04-eds-pack-design.md`) and G85
  (`05-gap-register.md`).
- `14-delivery-evidence-spec.md` — the spec for getting a run's verification evidence onto the work
  item, and for reporting whether a reported location can actually be opened. Read before touching
  the verification, design-verification or delivery stages, the pack manifest's
  `evidence_manifest` field, or validator 16. Gap G86 (`05-gap-register.md`); decisions D86 and D87
  (`03-core-design.md`) and D88 (`04-eds-pack-design.md`); built as Phase 7 / Tasks 1–19 in
  `02-build-tasks.md`, whose task ranges its own three phase headings name.
  *Numbered 14 on 2026-09-17,* having been drafted as a second `13-`; it was renamed rather than
  `13-write-specs-spec.md`, which came first and was already indexed here.
- `15-fixture-call-site-spec.md` — **draft for review (2026-09-17), not approved and not a build
  input.** Proposes closing G48 (who calls `eds-fixture`) on top of what PR #86 landed for G87, and
  records a defect found in that PR as proposed G88. Its D91/G88 are **not filed**; do not cite
  them as settled. Built as Phase 8 / Tasks 1–4 in `02-build-tasks.md`, whose task entries its §6
  names. Read before touching `eds-verify`'s content-location or draft-URL nodes.
- `16-gate-run-context-spec.md` — **draft for review (2026-09-19), not approved and not a build
  input.** Proposes closing G89 (and G96's Finding 1, the same defect a second time): how a gate
  stage, running under `isolation: worktree`, learns which checkout its run actually lives in.
  Its **D93 is not filed**; do not cite it as settled. Carries the measurements that rule out three
  candidate mechanisms, and the reason the current failure is silent rather than loud. Read before
  touching either gate's **Locate the run context** node or `check-publish-criteria.sh`'s root
  handling.
- `archive/17-provider-preconditions-spec.md` — **approved and filed 2026-09-21; now a reasoning record.**
  Where a provider pack's local-tool precondition is answered, resolving a contradiction between
  `01-core-contracts.md` §6 ("Pre-flight owns every environment question. Is
  the tool installed…") and `pre-flight.md`'s own anti-patterns, which forbid exactly that probe.
  **D97** (`03-core-design.md`) and **G105** (`05-gap-register.md`) are filed. Read before touching pre-flight,
  the provider-manifest shape, or the `health` skill. Its §10 names the six tasks that complete
  Phase 3, rewritten in `02-build-tasks.md`; its §8 records why Phase 3 / Task 6 could not be built
  as originally written.
- `archive/19-driver-read-allowlist-spec.md` — **approved and filed 2026-09-22; now a reasoning record.**
  Designed Phase 6 / Task 5: the driver's read hook as a default-deny allowlist. **D101 and G111 are
  both filed**, and the task is merged (PRs #125, #126) but **not verified** — no route has run
  against it. **G111** — its Finding 1 (the hook's
  frontmatter was mis-shaped, so the handler was never registered) is fixed, its Finding 2 is what
  this spec designs. Carries the driver's actual 33-read / 9-path evidence set, and a correction to
  `06-dx-core-deviations.md`'s description of the reference implementation. Read before touching
  `run-route`'s `hooks:` frontmatter or `warn-source-read.sh`.
- `archive/21-design-fallback-spec.md` — **approved and filed 2026-09-23; now a reasoning record.** Closes
  G59 by shipping the error-class taxonomy as `plugins/agentic-core/shared/error-handling.md` and
  adding `error_class` to the result envelope, and designs what `eds-extract` does when the design
  provider is unavailable: fall back to a single image attachment on the work item and report
  `warn`. **The fallback half is superseded by D131 (2026-10-12): a provider failure is a hard `fail`.** **G504, G505, D500 and D501 are filed**; the deviation is in `06-dx-core-deviations.md`.
  Numbered in the parallel-track range per the split-range rule below. Built as Phase 14 / Tasks
  1–5. Read before touching `eds-extract`'s flow, `resolve-design-source.py`, the result envelope's
  field list, or `01-core-contracts.md:160`'s dangling error-class pointer. **Its §5.3 leaves one
  question open** — what `VALIDATION` means — which Phase 14 / Task 1 must answer, not restate.
- `archive/22-branch-ownership-spec.md` — **approved and built 2026-09-24; now a reasoning record.**
  Designed closing G46: who calls `scm.create_branch`, which no stage id owns. **D507 is filed**
  (`03-core-design.md`) and built as Phase 15 / Tasks 1–3; EDS-7 proved it by a run (PR #152).
  Carries what
  `dx-core`'s `ensure-feature-branch.sh` actually does (read from its code), the property of ours
  that blocked adopting it — `create_branch` failed on an existing branch — and the measured hazard
  of switching to a stale branch that is 27 commits behind. Read before touching `create-branch.sh`,
  `run-route`'s stage sequence, or `eds-deliver`'s branch-check node.
- `23-eval-harness-spec.md` — **draft for review (2026-09-28), not approved and not a build
  input.** Designs a harness that measures whole route runs against fixed cases: pass rate against a
  threshold, per-case stability over 3 runs, and human time saved with measured and estimated
  baselines kept apart. Its **G517, D515 and D516 are not filed**; do not cite them as settled.
  Proposes Phase 19. Read before building any eval, benchmark or run-metrics tooling.
- `26-item-content-readiness-spec.md` — **approved 2026-09-30.** G547: an item may cite only
  content its run will have. D546 (core fact fields and a before-state readiness rule) and D547
  (eds extractor; own-draft-only URLs). Built as Phase 34 (provisional number). Read before
  touching the fact-record vocabulary, `check-readiness-criteria.sh` or the eds intake extractor.
- `27-route-policy-spec.md` — **approved 2026-10-01.** Phase 9 / Task 4: the fail-closed route
  policy (forbidden tool rules, daily limits from claim tags, per-run budget, named caps,
  comment-token break-glass). D107, G116. Read before touching the runner, `claim-run.sh` or the
  trigger payload.
- `28-network-allowlist-spec.md` — **approved 2026-10-01.** Phase 9 / Task 6: the committed
  domain list copied at launch into the SDK's policy tier with `strictAllowlist`. D108, G117. Read
  before touching the runner's sandbox options or the workflow's sandbox dependencies.
- `29-content-authoring-spec.md` — **draft for review (2026-10-01), not approved and not a build
  input.** Authored content as an eds-pack deliverable: a `## Content` section becomes
  `pages/<item_id>` in the content source through a service-account script, previewed in-run,
  linked from the ticket. Proposes G120, D110 (not filed) and Phase 36; answers Phase 12 / Task 1
  with shape (c).
- `archive/30-serve-outside-sandbox-spec.md` — **approved and filed 2026-10-02 (G123, D111, D112; Phase 9
  / Task 5 amended); now a reasoning record.** Phase 9 / Task 5's serve question, measured: on Linux the sandbox's PID and network
  namespaces end and hide any server a command starts. Proposes starting the preview and draft
  servers in the workflow before the session, the preview host in the runner's copied list, proxied
  local requests, and a subscription token for the runner. Read before touching `serve`, the runner's sandbox or the route workflow.
- `31-plugin-marketplace-migration-spec.md` — **approved 2026-10-05/06; Phases 46–50 filed 2026-10-06; its D and G
  entries were filed 2026-10-06 (Phase 46 / Task 5): D126–D128, G172–G173.** The six plugins move to `agenticDraft/plugins` with history and an
  `agentic-` prefix; plugins locate each other through an in-pack `core` symlink and a `SessionStart` root registry,
  never sibling folders; the plugin freeze runs from the start of Phase 47 until Phase 49 / Task 3. Read before
  touching the plugins. They live in `agenticDraft/plugins` (the freeze ended at Phase 49 / Task 3); this repository holds no copy, and a plugin changes only there.

- `archive/agent-next.md` — **the 2026-09-24 hand-off, archived 2026-10-06.** Written to move one long session to a fresh agent:
  where Phase 14 and Phase 15 left things, what to run next and in what order, what is open and not
  blocking, what is **still unproven and must not be claimed**, the traps that session hit, and two
  beliefs it wrote down and had to correct. Read it before picking up automation work cold; it does
  not replace this file or `01-core-contracts.md`.

- `archive/orchestrator-enhancements.md` — **absorbed 2026-09-04, not a build input.** A pointer record of
  where each of its five proposals went: three were already contracted under other names, one was
  architecturally impossible, one became G33 and Phase 2 / Task 23. Read only to stop a settled
  question being re-opened.
- `archive/orchestrator-enhancements-comparison.md` — **superseded 2026-09-04, not a build input.**
- `../_archive-2026-09-01/` — **never a build input.** Read only to resolve an old reference.
- `archive/` — **closed track pointers, never a build input (except `next-phase-32.md`, a pending spec).** `next-phase-3/14/26/27.md` moved there
  2026-09-30, `-6/20-23/25/28/32/33.md` later the same day; `archive/README.md` says why each one is there. Done records still name them bare. Since 2026-10-06 it also holds every finished task record (`*-done.md`, `-partial.md`, `-status.md`), older `NEXT.prev-*.md` and `next-phase-41.md`; a new done record is written in this directory and moved there once its phase is finished. List: `archive/MOVED-2026-10-06.txt`.

All gitignored. Never pushed.

## Plan and build

- Write no plan document for the build. `02-build-tasks.md` is it.
- Write no spec per phase. Re-orient from the last `phase-<n>-task-<m>-done.md` (D39) and
  `git log`.
- One task per session. `/clear` between tasks. Open PR after each, so user can review changes.
- **Before branching for a new task, sync with the remote first:** `git fetch origin main`, then
  branch from `origin/main` (or fast-forward local `main` to it and branch from that) — never from
  a possibly-stale local `main`. A local `main` left behind by an already-merged PR silently drags
  that PR's pre-merge commit onto the new branch, mixing two tasks into one PR by accident.
  *Caught 2026-09-03, Task 16:* the branch for Task 16 was cut from a local `main` that was one
  merged PR behind (#8), so Task 16's commit landed on top of Task 6's stale, already-merged
  commit; required cherry-picking Task 16's commit onto a fresh branch off the real `origin/main`
  to fix.
- **Branch names: `phase-<n>-task-<m>-<short>`, 23 characters maximum.** The local dev server
  derives a hostname as `<branch>--<repo>--<owner>` and refuses to start if that exceeds the
  63-character DNS label limit. `aem-eds-ai-workflow-demo` (24) + `agenticDraft` (12) + two `--`
  separators (4) = 40, leaving **23** for the branch. `phase-4-task-8` is 14, so the description
  gets 8; `phase-4-task-17` is 15, so it gets 7. Slashes do not help — the derivation replaces `/`
  with `-` before measuring. Examples that fit: `phase-4-task-8-fixture`, `phase-4-task-11-ready`.
  *Why the cap exists at all is worth knowing:* the check is upstream's, and it validates a
  hostname the tool never contacts — it always proxies to `main--<repo>--<owner>.aem.page`
  regardless of branch. See G45. The cap is the cheapest way to stop tripping a gate we cannot
  turn off; it is not a real constraint on what a branch may be called.
  **Check it, do not count by eye (D539, amended 2026-09-30 for G31; enforced by D544):**
  `bash <agentic-core plugin>/shared/lib/check-branch-name.sh <name>` → `ok`, `too-long` or
  `bad-chars`. The core plugin's hook runs the same check on `git switch -c`, `checkout -b`,
  `branch <name>`, `worktree add -b` and `push`, and blocks a failing name.
  Only lower-case `a-z`, `0-9`, `-` and `/` are allowed. A failing name gets no preview URL, and its
  PR fails `aem-psi-check`. Every next-task prompt names a branch already run through it.
- On task completion, build a ready-to-paste prompt for the next task: its `Phase <n> / Task <m>`
  id and name, its file:line in `02-build-tasks.md`, and its Depends on / Delivers / You verify /
  Reject if. Print it in chat **and** overwrite `NEXT.md` with it, plus the id of the task just
  finished. The human can paste it after `/clear`; an agent that starts cold reads `NEXT.md`
  instead.
- Whenever a task is completed and `NEXT.md` is updated, update the **Remaining Build Work**
  artifact in the same session: edit its source `.claude/artifacts/remaining-build-work.html`
  and re-publish that file with `url` https://claude.ai/artifact/ReUgiwzUWNpCEbMw8cPqVU so the
  URL stays the same. Read the live version back first if the source file is missing.
- Write a new spec only for what is genuinely undesigned and ask user to review.

## Write changes back, same session

A decision that lives only in a conversation is lost. File it by kind:

- gap → `05-gap-register.md`. Never delete a gap; supersede it, keeping the status vocabulary.
- core decision → `03-core-design.md`
- platform decision → `04-eds-pack-design.md`
- contract change → `01-core-contracts.md`
- history → `09-project-record.md`. Never a live decision.

If the change affects the task list, update `02-build-tasks.md` too.

**Check the numbering immediately after appending a `Gx` or `Dx` entry, in the same session:**

```
.claude/skills/doc-numbering/scripts/check-numbering.sh \
  03-core-design.md 04-eds-pack-design.md 05-gap-register.md
```

Name those three files, never the directory — a spec or a done-file that discusses a gap restates
its heading, and scanning everything reports those as collisions.

- **A number is reserved only once it is on disk.** Choosing it and writing it are two moments, and
  another session can file the same number in between. Checking before you write proves nothing.
- **When two tracks run at once, split the range.** The main track continues the existing sequence;
  a parallel track starts at **G500** / **D500**. Nothing needs locking and the number says which
  track filed it. G109 records why: three collisions in one day, plus D94/D95 duplicated from
  before the parallel tracks existed.
- **Resolve a duplicate by renumbering the later entry**, never by deleting one — see the D42/D43
  note above, which is the same fix applied to the same problem two occurrences ago.
  *Third occurrence resolved 2026-09-22:* D94 and D95 each named a core and a platform decision,
  both filed 2026-09-19. The platform senses were renumbered to **D104** and **D105**, so every
  surviving bare `D94`/`D95` citation means the core decision. G109 is closed. **"Later" was
  undecidable here** — same-day filings — so the tiebreak was citation count, measured not
  estimated, and the less-cited sense moved.

**A contract key is not finished until something uses it.** A new field in
`01-core-contracts.md` looks complete the moment its shape and validator are written, and it is
not: the first real consumer is what finds the case the shape cannot express. Schedule that
consumer inside the same task sequence rather than assuming a later phase will fit.
*Caught 2026-09-21:* `requires:` (D97) was filed in Phase 3 / Task 9 and amended in Task 11 — four
tasks later — because the first pack to declare a real precondition needed a probe path the key had
no way to express.

## Plugin development loop

Work in a clone of `agenticDraft/plugins`, never in this repository. Run a pack from the clone with
`claude --plugin-dir ../plugins/plugins/agentic-<pack>` (one flag per pack the work needs). Release a tag, then move
this project's pin with `bash .claude/scripts/update-plugin-pin.sh`.

## Running a route: the session must be newer than the code

**A session that drives a route loads its instructions after the code is final.** In order:

1. The change lands on `main`.
2. The session that will drive the route is started fresh — `/clear`, or a new session — **after**
   that.
3. No plugin is edited or re-pinned until the run reaches a terminal state.
4. The driver's own stamp check (D509) proves step 2 happened, and refuses to start when it did not.

**Why this is a rule and not advice.** A `SKILL.md` is injected into a session's context when the
skill loads, and is a snapshot from then on. The copy is internally consistent and reads as
complete; nothing in it, and nothing in a run's record, reveals that a step added since is missing
from it.

*Measured 2026-09-24:* a step was added to `run-route/SKILL.md` at 10:05. A run started at 11:05 in
a session opened before that, skipped the step entirely, and failed at stage 14 of 14 for a reason
that looked unrelated. **No run was in flight when the edit happened** — so "do not edit during a
run", the obvious rule, would not have caught it. The window that matters is between a session
loading the skill and that session starting a run.

Step 4 is what makes this checkable rather than remembered. Steps 1-3 are still yours: the stamp
covers `run-route/SKILL.md` only, and a stale **stage** (G95) is still possible and still invisible.

## When a run stops: read first, decide second

**Never re-run before establishing where it stopped and why.** Four runs of EDS-13 stopped for four
unrelated reasons; each time the artifacts said which, and each time guessing would have fixed the
wrong thing.

### Read, in this order

1. **`.ai/run-state.json`** — present means the run did **not** reach `delivered`; only `delivered`
   deletes it. `last_stage` is how far it got.
2. **`.ai/run-context/envelope-*.txt`** — which stages produced one. The stage that stopped it is
   the one with no envelope, or whose envelope is the newest.
3. **That envelope's `verdict` and `summary`** — the reason, in the stage's own words. Run
   `validate-result-envelope.sh` over it: a stage can fail *by not producing a conformant envelope
   at all*, and then the file holds prose rather than a verdict.
4. **mtimes** — `ls -lt .ai/run-context/`. A gap of many minutes before the last file means the run
   stalled rather than decided.
5. **`.ai/run-context/orchestrating.flag`** — present means a run believes it is still live. Absent
   with `run-state.json` present means it ended in a non-`delivered` terminal state, or crashed.

**Do not trust `.ai/progress.md`.** It has listed every stage as `done`, `deliver` included, on a
run that died at stage 9.

### Then classify, because the fix differs

- **The work item is wrong** — a criterion that cannot be satisfied, or names something that does
  not exist. Fix the item through `write-specs`, then re-run. *(EDS-13's AC-8.)*
- **The pipeline is wrong** — a stage did its job and reported it in a form nothing could read, or a
  guard checked the wrong thing. File a gap, fix, re-run. *(G508, G509, G512.)*
- **A provider refused** — quota, rate limit, outage. `eds-extract` fails; there is no fallback
  (D131). Fix the provider (authenticate, wait out the quota), then re-run.
- **The instructions were stale** — the step is in the file on disk and was not executed. Not a code
  defect. Start a fresh session. *(G511.)*

### Before any re-run

- **`git status`** — untracked leftovers from the previous run get swept up by `deliver`'s own
  `git add -A`. A version nobody reviewed ends up in a commit.
- **Which branch the tree is on** — packs execute from the working tree, and `deliver` publishes
  from wherever it finds itself.
- **Archive `.ai/run-context/` and `.ai/progress.md`** to `.ai/logs/run-context-<date>-<time>/`.
  `.ai/logs/` is gitignored; `.ai/run-context.prev-*` is **not**, so do not use that shape. Clearing
  is what makes "every artifact this run read, this run wrote" true in both directions.
  *Mechanical since 2026-10-03 (D119, G137):* the driver's fresh start runs
  `archive-run-context.sh` itself, so this step is only needed by hand when a run is to be read
  before the next one starts; a resume never archives.
- **`.ai/run-state.json`** — within two hours (`check-run-state.sh`, 7200s) a run **resumes** from
  after `last_stage`. That is right when only the last stage needs redoing, and wrong when the fix
  was upstream of it. Remove it to force a clean start.
- **A fresh session**, per the rule above. Resuming in the session that stopped re-runs the
  instructions it loaded then, not the ones on disk now.

## Jira ticket titles

- Write or rewrite a Jira item through the `write-specs` skill (`.claude/skills/write-specs/`,
  `13-write-specs-spec.md`) — it owns the summary phrasing, the description shape and the
  acceptance-criteria form, and proves conformance by running its checker before anything is
  pasted in. Do not hand-write a ticket's summary or description.

## New automation or tooling

- Give it a `Gx`/`Dx` entry before building it, in the file that holds that kind of entry.
- Ship it inside the Automated EDS Delivery plugin (`.claude/`). Never as a standalone script.
- Applies wherever in the repo the work would otherwise land.

## A rule you must verify this session goes in a shared contract, not a `SKILL.md`

**A `SKILL.md` body is injected into a stage from the plugin cache and can be stale within a
session; a `shared/*.md` contract is read from disk at run time and is not.** So an edit to a
stage's own `SKILL.md` may not reach the very next run that is supposed to prove it, while an edit
to a shared contract does.

- Putting the rule in `shared/` is the default, and it is also what the "reference, not restatement"
  convention already wants — this is the same instruction with a second reason behind it.
- When a rule genuinely belongs to one stage and nowhere else, write it there, but **do not treat
  that session's own run as verification of it**. Say plainly that the live check is outstanding.
- **Never conclude from a stale result that the edit was wrong.** A stage denying it has an input
  its own file declares is this effect, not a bad edit; check the file with `grep` before changing
  anything.

*Found 2026-09-18/19 (G95), reproduced unambiguously: `eds-fixture` reported an input unsupported
while `grep` found it on line 33 of that skill's own file. D93 shipped working only because its rule
reached the gate through `gate-contract.md` rather than through the two `SKILL.md`s it also edited.*

## Plugin files carry no narrative

Files in `agenticDraft/plugins` (and `.claude/`) ship with the plugin — including once extracted to
`github.com/agenticDraft/plugins`. A reviewer or downstream consumer of the extracted copy has
none of this repo's `docs/`. So a shipped file contains only what a stage adapter or consumer
needs to operate, never:

- A path under `docs/implementation-plan/`, or any other gitignored file. State the requirement
  generically instead of naming a path no one outside this repo can open.
- A "Source" / "Sources consulted" / rationale-audit section. That belongs in the task's
  `phase-<n>-task-<m>-done.md`, not in the shipped artifact.
- Borrowed-material attribution repeated per file. It lives once per plugin, in that plugin's own
  **`NOTICE`** — `<pack>/NOTICE` in `agenticDraft/plugins` — not duplicated into every shared file that adapts a
  `dx-core` pattern. A shipped file may say it adapts something and point at the NOTICE; it does
  not carry the copyright line itself.
  *Amended 2026-09-22 (G114).* This rule previously named `01-core-contracts.md`'s header and
  `06-dx-core-deviations.md` as the central location. Both are gitignored, so following it would
  have stripped the notice from the shipped plugin entirely, leaving adapted material with no
  attribution anywhere a downstream reader could find it. The central location has to be a file
  that ships, which is the whole premise of the no-narrative rule this bullet belongs to.
- A native command, shell, interpreter, builtin, or OS name, **unless** that name is the literal,
  unavoidable invocation needed to run the file itself — a shebang line, or a "run with
  `<command> <path>`" instruction. Never name one to explain, justify, or narrate a choice (why a
  builtin was avoided, which shell version does what, which OS ships which default) — that
  reasoning belongs in the task's `phase-<n>-task-<m>-done.md`, never in the shipped file.

*Caught 2026-09-02, PR #3 review:* `plugins/agentic-core/shared/result-envelope.md` shipped with
both — a `01-core-contracts.md §13` citation and a `## Source` attribution block. Both removed;
this rule is what stops the next shared file from repeating it.

*Caught 2026-09-02, Task 3 self-review:* `validate-result-envelope.sh` cited `01-core-contracts.md §3`/`§13` again — the identical gitignored-path mistake, in a new file. Its test file named
`dx-core`'s `validate-image.test.sh` to describe a borrowed test pattern — the identical
attribution-repeated mistake. A third, new instance: the same script named `mapfile` and a bash
version number in a comment explaining a portability fix, neither one a command actually being
invoked. All three fixed same-session; the last one is why the bullet above exists.

## `dx-core`

```
<local path of the dx-core plugin>
```

- Check how `dx-core` solved the problem **before** choosing an approach. `shared/` holds its
  cross-skill contracts; `skills/` has 49 worked examples; `skills/dx-figma-*` covers
  design-to-code. `dx-aem`, `dx-automation`, `dx-hub` rarely apply.
- **Ask before deviating.** Present what `dx-core` does, what we do, what the difference costs.
  Do not resolve it alone. Do not treat an existing line as settled if it conflicts with
  `dx-core`. Once confirmed, record it in `06-dx-core-deviations.md`.
- Adopt patterns, not code. This is not a fork. `dx-core` targets AEMaaCS (JCR, Maven) on Azure
  DevOps; anything naming `mcp__ado__*`, JCR or Maven does not transfer.
- Attribute what is borrowed: MIT, © 2025-2026 Dragan Filipovic.
- If the path does not exist, say so. Do not guess.

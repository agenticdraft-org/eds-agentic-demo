# Delivery Automation — Independently Verifiable Task List

**Regenerated 2026-09-01** against `01-core-contracts.md`, replacing
`automated-eds-delivery-tasks.md` (41 tasks, written before D28). D28 authorised this rewrite and
predicted the list would shrink; it did not shrink, it **re-sorted** — most implement/verify work
became integration rather than authoring, and that freed room for the tasks that actually prove
the thesis (Phase 6).

Gitignored, like the rest of the set — it carries a work-item key and local paths.

**Renumbered 2026-09-01** from lettered track IDs to phases and tasks. The six tracks became
Phase 1–6 unchanged — same tasks, same order, same dependencies, only the labels differ. Each
heading carries its former ID as *(was: C1)* so older notes and the design records stay
resolvable. Mapping: Phase 1 = E · Phase 2 = C · Phase 3 = V · Phase 4 = K · Phase 5 = S ·
Phase 6 = R; the number after the letter is the task number within the phase.

**"Phase" numbers them, it does not serialise them.** The phases are ordered by dependency, not
by calendar — anything whose **Depends on** list is satisfied can be built now, including work
in a later phase. Only the dependency lines gate work.

---

## How to use this file

Every task has the same shape:

- **Delivers** — the files that exist afterwards. Nothing else changes.
- **Depends on** — tasks that must be accepted first. Anything unlisted can be built in parallel.
- **You verify** — a command you paste, or a slash command you type, with the output to expect.
  No task is done because someone says it is.
- **Reject if** — the specific failure that means it is not finished, written so the check cannot
  be passed by accident.
- **Documents** — per **D39**, every task writes `phase-<n>-task-<m>-done.md` explaining what was
  built, why, and how it fits the architecture, citing official documentation. **A task without its
  summary file is not done.** This is an acceptance criterion, not a habit.

```bash
export ITEM=EDS-2                            # your seeded work item (Phase 1 / Task 4)
export REPO_ROOT="$(git rev-parse --show-toplevel)"
```

**The independence rule holds.** Every stage runs standalone as well as inside the chain (D17).
If checking one stage requires running the whole pipeline, that stage has a defect.

**The neutrality rule is testable, not remembered.** Phase 2 / Task 17 makes it a grep. Until it
passes, treat every claim of neutrality in Phase 2 as unverified.

---

## Phase boundaries — the seam, restated as task scope

- **Phase 2** names no product, platform, language or tool. A Phase 2 task that needs one is
  mis-scoped and belongs in Phase 3 or Phase 4.
- **Phase 3** and **Phase 4** name their product freely — that is what a pack is for.
- A task needing both sides is mis-scoped. Split it at the envelope.

---

# Phase 1 — Environment (this machine, prerequisites)  *(was: Track E)*

### Phase 1 / Task 1 — Network and command allowlists *(was: E1)*

**Delivers** an allowlist permitting the hosts and commands the pipeline needs, and nothing more.
**Depends on** nothing.
**You verify** a fetch to an allowed host succeeds and one to an unlisted host is refused with a
visible reason, not a hang.
**Reject if** the refusal is silent, or the allowlist is "everything".

### Phase 1 / Task 2 — Credentials in the environment *(was: E2)*

**Delivers** credentials supplied through environment variables, never on a command line.
**Depends on** nothing.
**You verify** `ps -ef` during a live call shows no token, and the call still succeeds.
**Reject if** any secret appears in process arguments, a log, or a committed file. (G25.)

### Phase 1 / Task 3 — Keep run artifacts off every public surface *(was: E3)*

**Delivers** ignore rules so specs, screenshots and run state are never published.
**Depends on** nothing.
**You verify** a file placed in the artifact directory does not appear on any published surface
after a deploy.
**Reject if** it appears, or the rule only covers one of the three artifact kinds.

### Phase 1 / Task 4 — Seed one work item by hand *(was: E4)*

**Delivers** one real work item with a type, labels, and a description containing an actual
requirement.
**Depends on** nothing.
**You verify** you can open it and read it back.
**Reject if** the description is a placeholder — the routing and sufficiency work needs a real one.

### Phase 1 / Task 5 — Prove the tracker round-trip by hand *(was: E5)*

**Delivers** notes proving read, comment and file-attach all work against `$ITEM`, before any code
depends on them.
**Depends on** Phase 1 / Tasks 2, 4.
**You verify** you fetched the item, posted a note, attached a file, and saw all three in the UI.
**Reject if** any leg is assumed rather than performed. This is the task that catches a missing
permission before it costs a debugging session.

### Phase 1 / Task 6 — Relocate run artifacts and project config under `.ai/`

**Delivers** the `.ai/` layout from D47/D48: `.ai/project-config.yaml` (tracked, was
`./project-config.yaml` per D46, superseded), `.ai/specs/<ticket>/` and `.ai/design/` (tracked, D4
kept — were `drafts/specs/<ticket>/` and `drafts/.design/`), `.ai/credentials` (gitignored, was
`.env`, D48), `.ai/logs/`, `.ai/run-state.json`, `.ai/progress.md` (gitignored, were
`.claude/logs/` and repo root), `.ai/playwright/` (gitignored, was `.playwright-mcp/` — find where
this project's Playwright MCP is actually configured and set `--output-dir` /
`PLAYWRIGHT_MCP_OUTPUT_DIR` / `outputDir` there), and reserved (folder-less) `.gitignore` patterns
for `.ai/research/`, `.ai/pr-answers/`, `.ai/pr-reviews/`, `.ai/cache/`, `.ai/me.md`. Updates every
path reference across `docs/implementation-plan/` (D47 lists nine files), `.gitignore`,
`.hlxignore`, and re-runs Task 3's verification matrix against the new paths.
**Depends on** Phase 1 / Task 3, Phase 2 / Tasks 4, 5.
**You verify** `git check-ignore` / the `.hlxignore` matcher-equivalence check (Task 3's method)
against every new path shows the same tracked/ignored split Task 3 already proved for the old
ones; `validate-project-config.sh .ai/project-config.yaml` still passes; no doc under
`docs/implementation-plan/` still names an old path.
**Reject if** a spec or screenshot ends up gitignored (silently defeats D4), or a secret ends up
trackable, or any doc reference to the old paths survives unchanged.

---

# Phase 2 — The agnostic core  *(was: Track C)*

### Phase 2 / Task 1 — Core plugin scaffold, loaded locally *(was: C1)*

**Delivers** `plugins/<core>/` with a manifest, and a load recipe using `--plugin-dir`.
**Depends on** nothing.
**You verify** `claude plugin validate plugins/<core>` passes; launching with `--plugin-dir` lists
the plugin's skill under its namespace; editing a skill and running `/reload-plugins` picks the
change up without restarting.
**Reject if** the reload step needs a restart — that invalidates the per-task testing story D38
rests on, and the decision must be revisited rather than worked around.

### Phase 2 / Task 2 — The result envelope contract *(was: C2)*

**Delivers** the envelope contract file and one passing fixture per verdict literal.
**Depends on** Phase 2 / Task 1.
**You verify** all four fixtures parse and yield the expected verdict.
**Reject if** the contract permits a verdict outside the four literals, or allows prose after the
block.

### Phase 2 / Task 3 — Envelope validator *(was: C3)*

**Delivers** a deterministic checker for envelope conformance.
**Depends on** Phase 2 / Task 2.
**You verify** it accepts the Phase 2 / Task 2 fixtures and rejects, individually: an unknown
verdict, a multi-line summary, a missing artifacts list, and text after the block.
**Reject if** any of those four passes. Each is a real failure mode, not a hypothetical.

### Phase 2 / Task 4 — Config schema and validator *(was: C4)*

**Delivers** the config schema from spec §7 and a validator.
**Depends on** Phase 2 / Task 1.
**You verify** a well-formed config passes; a route table with no `default` fails; an unknown
top-level key fails with a message naming it.
**Reject if** an invalid config produces a warning instead of a failure.

### Phase 2 / Task 5 — Setup: detect and confirm *(was: C5)*

**Delivers** the detection half of setup — stack, layout, commands — proposed for confirmation and
written to config.
**Depends on** Phase 2 / Task 4.
**You verify** it detects this project's real commands, shows them once, and writes them on
confirmation; re-running offers keep / re-detect / edit.
**Reject if** it writes anything it did not show you first.

**Scope note (D44–D46), settled while building this task:** `packs` and `routes` cannot be
produced by detection at all — `packs` needs pack names chosen during Task 7's interview, `routes`
is seeded from a live tracker query. This task writes only `version`, `commands` and `paths`; the
resulting file is real but intentionally partial and does not pass
`validate-project-config.sh` on its own until Task 7 adds the rest. Detection itself names no
language, package manager or tool anywhere in the shipped skill file (D44) — it describes shape and
lets the executing model supply real ecosystem knowledge at run time, so the neutrality rule holds.

### Phase 2 / Task 6 — Setup: propose knowledge sources *(was: C6)*

**Delivers** the marketplace scan that proposes components matching the detected stack.
**Depends on** Phase 2 / Task 5.
**You verify** it proposes plausible components for this project and **installs nothing**; and
that it states plainly that a proposed component is not a pack.
**Reject if** it installs anything, or presents a component as completing setup. A third-party
component is a knowledge source; a pack still has to bind it. (D41.)

### Phase 2 / Task 7 — Setup: interview and generate a pack *(was: C7)*

**Delivers** the interview and pack generation from a template, plus the written convention record.
**Depends on** Phase 2 / Tasks 6, 16.
**You verify** it runs against a directory with **no code at all** and still produces a valid pack
from your answers; and that the generated pack contains no unfilled placeholder.
**Reject if** it invents a convention you were not asked about, or emits a pack with a hole in it.
The zero-code case is the one that matters — it is where detection contributes nothing.

### Phase 2 / Task 8 — Route resolver *(was: C8)*

**Delivers** resolution in the spec's order: explicit intent, then the signal table, then the
default.
**Depends on** Phase 2 / Task 4.
**You verify** an explicitly named route wins over a contradicting table; a fact record matching
two rows takes the first; an unmatched record takes the default; and the run log records **which
rule fired**.
**Reject if** the model is consulted at any point, or the fired rule is not recorded — an
unexplainable route is the failure mode this design exists to prevent.

### Phase 2 / Task 9 — Stage runner *(was: C9)*

**Delivers** the loop: resolve adapter from the manifest, spawn as a subagent, read the envelope,
branch.
**Depends on** Phase 2 / Tasks 3, 8, 16.
**You verify** with stub adapters that `pass` continues, `warn` continues and is recorded, `fail`
terminates, and an unparseable return terminates as a contract violation.
**Reject if** the runner reads any file the stage produced, or retries a failed stage. Retries live
inside stages only. (D40.)

### Phase 2 / Task 10 — Progress output *(was: C10)*

**Delivers** the one-line-per-stage output with `(current/total)`, and the status table emitted
exactly once.
**Depends on** Phase 2 / Task 9.
**You verify** a run with a skipped stage recomputes the total, and the table appears exactly once
in the whole transcript.
**Reject if** the table appears mid-run, or the counter's total goes stale after a skip.

### Phase 2 / Task 11 — Run state and resume *(was: C11)*

**Delivers** run state and progress on disk, with the 2-hour staleness rule.
**Depends on** Phase 2 / Task 9.
**You verify** a run interrupted and resumed within the window offers resume at the right stage;
one older than the window starts fresh and deletes the old state; a successful run deletes it; and
**a long run does not trip its own staleness check**, because the file's mtime is refreshed each
stage.
**Reject if** the mtime refresh is missing. That defect is already documented upstream — inheriting
the fix is free, rediscovering it is not. (D40.)

### Phase 2 / Task 12 — Question protocol and execution modes *(was: C12)*

**Delivers** boundary-only questions, interactive and autonomous modes, and the per-run cap.
**Depends on** Phase 2 / Task 9.
**You verify** in interactive mode a stub returning `question` causes a question and the answer
reaches the **next** stage; in autonomous mode the same stub writes the blocker to the work item
and ends `blocked`; the cap is enforced; and a stage marked always-autonomous has its question
treated as `fail` in both modes.
**Reject if** any stage is suspended, re-invoked or resumed. Nothing is ever asked mid-stage.

### Phase 2 / Task 13 — Terminal states *(was: C13)*

**Delivers** the three terminal states with their required output.
**Depends on** Phase 2 / Task 12.
**You verify** each of `delivered`, `blocked`, `failed` is reachable with stubs and prints what the
spec requires.
**Reject if** a run can end in none of the three, or a `warn` ends a run.

### Phase 2 / Task 14 — Pre-flight *(was: C14)*

**Delivers** the capability probe: every pack in config installed, every declared role operation
available.
**Depends on** Phase 2 / Tasks 4, 16.
**You verify** removing a required pack makes pre-flight stop the run **before** any branch or file
exists, naming what is missing.
**Reject if** it probes by health check rather than by the operation the pipeline will actually
use, or if anything is created before it passes. (G15.)

### Phase 2 / Task 15 — External content safety contract *(was: C15)*

**Delivers** the safety contract file and the one-line reference convention.
**Depends on** Phase 2 / Task 1.
**You verify** a fixture work item containing an embedded directive is processed as data — the
directive does not execute, and the run continues.
**Reject if** the rules are copied into a stage rather than referenced. One source, referenced
everywhere. (D40.)

### Phase 2 / Task 16 — Pack manifest schema and validator *(was: C16)*

**Delivers** the platform and provider manifest schemas plus a validator.
**Depends on** Phase 2 / Task 4.
**You verify** a manifest binding an unknown stage fails; one naming a nonexistent skill fails; a
provider omitting an operation without declaring it unsupported fails.
**Reject if** a manifest with a dangling skill reference validates.

### Phase 2 / Task 17 — The naming-rule validator *(was: C17)*

**Delivers** the denylist grep over core source, with the documented exceptions.
**Depends on** Phase 2 / Task 1.
**You verify** it passes on the core as built, and fails when you deliberately add a product name
to a core file.
**Reject if** it cannot fail. This validator is the only mechanical defence of the property the
whole design rests on; a check that never fails is not a check.

### Phase 2 / Task 18 — Artifact registry *(was: C18)*

**Delivers** the registry with producers and validation rules.
**Depends on** Phase 2 / Task 16.
**You verify** every registered artifact names a producer that exists, and an artifact with no
producer fails.
**Reject if** the registry is documentation rather than something a validator reads.

### Phase 2 / Task 19 — Continuous integration for the validators *(was: C19)*

**Delivers** all of Phase 2 / Tasks 3, 4, 16, 17, 18 plus `claude plugin validate` running on
every change.
**Depends on** Phase 2 / Tasks 3, 4, 16, 17, 18.
**You verify** a deliberately broken contract fails the run, and the failure names the validator.
**Reject if** any validator is present but not wired, or the suite consumes model tokens. This
tier is deterministic by design. (D12.)

*Added 2026-09-04:* the suite must also carry any validator introduced after this task —
`01-core-contracts.md` §13 rule 11 (stage skills declare isolated execution) arrives with
Phase 2 / Task 23, and the inner-tier validator with Phase 2 / Task 24. Both build *after* this
task, so "wired" is a standing obligation on whoever adds a validator, not a one-time checklist
completed here.

### Phase 2 / Task 20 — Run analytics *(was: C20)*

**Delivers** per-stage measurements read from the session transcript, not self-reported.
**Depends on** Phase 2 / Task 11.
**You verify** the figures come from the transcript's own usage records and a run's numbers change
when the run changes.
**Reject if** any number is produced by asking the model how many tokens it used. (D14.)

### Phase 2 / Task 21 — Gate criteria and the gate contract *(was: C21)*

**Delivers** the two gate stage ids from spec §4 with their fixed contract, and the plan gate's
four criteria written as answerable questions.
**Depends on** Phase 2 / Tasks 9, 19.
**You verify** a plan missing a stage for one requirement fails the plan gate naming that
requirement; a plan containing a stage no requirement asked for fails naming that stage; a clean
plan passes; and in every case the deterministic validators ran **before** any model did.
**Reject if** a criterion cannot be answered yes or no. A gate that cannot state its criteria
fails the pattern's own prerequisite and produces agreeable noise. (D42.)

### Phase 2 / Task 22 — Neutralization pass on the core design record *(was: C22)*

**Delivers** `03-core-design.md` rewritten so platform names become roles.
**Depends on** Phase 2 / Task 17.
**You verify** the naming validator passes on it with only the documented attribution exceptions.
**Reject if** any product, platform or tool name survives outside those exceptions. 207
occurrences were measured at the split; the file carries a warning until this task is accepted.

### Phase 2 / Task 23 — Route driver *(new 2026-09-04)*

**Delivers** the component that runs a whole route: the driver skill, the orchestration marker and
its contract, and the manifest check that keeps stage isolation from silently lapsing. This is the
part Phase 2 / Tasks 9–14 each build a piece of and none assembles. (G33, D49.)
**Depends on** Phase 2 / Tasks 9, 10, 11, 12, 13, 14.
**You verify**, with stub adapters, that `pass` continues · `warn` continues and is recorded ·
`fail` ends the run `failed` · an unparseable envelope ends it as a contract violation · a skipped
stage shrinks the counter's denominator · the status table appears **exactly once** in the whole
transcript · a run interrupted and resumed lands on the right stage · and the marker is **absent
after every terminal state**, including the failing ones. Also: the manifest check fails a pack
whose stage skill does not declare isolated execution (`01-core-contracts.md` §13 rule 11).
**Reject if** the driver reads a source file or opens a path listed under an envelope's
`artifacts:`; if it retries a stage; if it restates a contract inline instead of referencing it; if
the marker survives a terminal state or its mtime is not refreshed each stage; or if it is built as
a script. **The last one is the point of the task** — spawning the adapter is the one step that
needs a model, and a shell loop calling `run-stage.sh` would validate envelopes nobody wrote and
report success having run nothing. (D49.)

*The read hook ships as a warning, not a block.* It appends to a log so the discipline can be
asserted against later. The flip to a default-deny allowlist is Phase 6 / Task 5, gated on a real
run — an allowlist written before any route has run would be wrong in its first minute, and §14's
standing rule is to pick after a run produces evidence.

*Wiring note:* rule 11 extends the manifest validator delivered by Phase 2 / Task 16, which is
already merged. Phase 2 / Task 19's CI suite must pick it up — see the note added there.

### Phase 2 / Task 24 — Inner-tier return contract *(new 2026-09-04)*

**Delivers** the second return contract: the block a subagent returns to the stage adapter that
dispatched it, with its own name and a status vocabulary sharing **no literal** with the result
envelope's `pass | warn | fail | question`, plus a validator and fixtures matching the existing
envelope validator's shape. (D50.)
**Depends on** Phase 2 / Task 23.
**You verify** a valid inner block passes; one carrying an outer literal fails; one carrying an
inner literal fed to the *outer* validator fails; and the fixtures cover one file per status plus
one per rejection case.
**Reject if** any literal appears in both vocabularies — that is the entire safety property, and
two contracts that share one cost the same and protect nothing. Also reject if the inner
vocabulary offers a question status: §8 puts questions at stage boundaries only, and an inner tier
that can ask makes "no stage is ever paused, re-invoked or resumed" false without anyone deciding
to make it false.

### Phase 2 / Task 25 — Setup: choose provider packs *(new 2026-09-06)*

**Delivers** the step `setup` (Phase 2 / Tasks 5–7) was scoped, on purpose, not to cover: writing
`packs.tracker` / `packs.scm` / `packs.design` / `packs.browser` into `.ai/project-config.yaml`.
Detect the git remote's host; scan installed packs for `kind: provider` with a matching `role`;
propose a match per role, or state plainly that none exists rather than fabricate one; on
confirmation, write the chosen pack name and point at that pack's own credentials doc (never
collect or write a secret — same rule README's Credentials section and Phase 3 / Tasks 1–2 already
established).
**Depends on** Phase 2 / Task 7, and at least one provider pack per role it is meant to resolve
(Phase 3 / Tasks 1–4 — this task can ship resolving only the roles that already have a pack built,
same partial-progress shape Task 5 used for `commands`/`paths`).
**You verify** a repo whose remote host has a matching installed pack gets it proposed and written
on confirmation; a repo whose remote host has no matching pack gets a plain "none available" report
naming the role, never a guessed or fabricated pack name; re-running offers keep / re-detect / edit,
matching Tasks 5 and 7's own protocol; no credential is ever asked for or written by this step.
**Reject if** it writes a pack name without the human confirming it first, invents a pack that does
not exist on disk, or asks for — or writes — a credential value anywhere. (G35.)

*Out of scope for this task, tracked separately in G35:* a `kind: provider` skeleton generator
(parallel to Task 7's `generate-pack.sh`, scaffolding an `unsupported: [...]` pack for a role with
no installed pack yet) and any new provider pack's actual operation logic, which stays its own
Phase-3-shaped task regardless of how the pack was scaffolded.

---

# Phase 3 — Provider packs  *(was: Track V)*

Each of Phase 3 / Tasks 1–4 has the same shape, so they are stated once and listed once.

**Delivers** a provider pack declaring one role, implementing that role's operations from spec §6,
each emitting the envelope, with a dependency on the core declared in its manifest.
**Depends on** Phase 2 / Tasks 2, 16 (and Phase 1 / Tasks 2, 5 for Phase 3 / Task 1).
**You verify** every operation runs standalone against real infrastructure and returns a
conformant envelope; an unimplemented operation is declared unsupported and pre-flight refuses a
route needing it.
**Reject if** any operation returns prose the runner must interpret, or the core had to change to
accommodate it. A pack that requires a core change is a design failure, not a task detail.

- **Phase 3 / Task 1 — tracker** (`fetch_item`, `post_note`, `attach_file`, `list_types`)
- **Phase 3 / Task 2 — scm** (`create_branch`, `publish_change`, `check_status`)
- **Phase 3 / Task 3 — design** (`fetch_reference`)
- **Phase 3 / Task 4 — browser** (`render`, `capture`, `measure`) — `interact` was added to the
  role after this task shipped (D69); it is Phase 3 / Task 8, not a reopening of this one.

**First, for each:** check whether an existing marketplace component already covers the role and
wrap it rather than implementing a transport. The catalogue carries plausible candidates for all
four; whether they satisfy the operation table is **unverified** and is the first step of each
task, not an assumption. (D41.)

**Completion sequence, scheduled 2026-09-21.** Tasks 1–4 and 8 are done. The remaining six run in
this order — **Task 5 → Task 6 → Task 9 → Task 7 → Task 10 → Task 11** — which is not their numeric
order, because Tasks 9–11 were added after Task 8 existed. Tasks 5 and 6 are independent of
everything else here and of each other; Task 9 is a decision-recording task with no code, and
Tasks 7, 10 and 11 are D97's three parts (declare, probe, enforce) and must run in that order.
Nothing in this sequence depends on any other phase's unfinished work.
`17-provider-preconditions-spec.md` holds the reasoning; this file holds the tasks.

### Phase 3 / Task 5 — Provider-pack authoring scaffold *(new 2026-09-06, scheduled 2026-09-21)*

**Delivers** G35's still-open second piece: a `kind: provider` skeleton generator, parallel to
Phase 2 / Task 7's `generate-pack.sh` but for a provider pack instead of a platform pack. Given a
role name, writes a `pack.yaml` at the target pack root declaring `kind: provider`, `role: <role>`,
and every operation `01-core-contracts.md` §6 lists for that role under `unsupported: [...]` — no
real operation logic, a shell a later Phase-3-shaped task (Tasks 1/2's own shape) fills in one
operation at a time.
**Depends on** Phase 2 / Task 16 (pack manifest schema and validator).
**You verify** the generated skeleton validates as `valid: provider` via
`validate-pack-manifest.sh`; every operation §6 declares for the named role appears in
`unsupported`, none silently omitted; re-running against a role that already has an installed pack
does not overwrite it without asking first — same keep/re-detect/edit protocol Tasks 5/7/25 already
use.
**Reject if** it writes any real operation logic, fabricates a role or operation not in
`01-core-contracts.md` §6, or silently overwrites an existing installed pack.
**Not the same task as building a second concrete scm/tracker/design/browser provider** (e.g. a
Bitbucket pack) — that stays its own Phase-3-shaped task (Tasks 1/2's shape), built on demand when a
real project needs it, never speculatively ahead of one.

*Logged 2026-09-06, scheduled 2026-09-21* as the first of the six-task Phase 3 completion sequence
(Tasks 5 → 6 → 9 → 7 → 10 → 11, `17-provider-preconditions-spec.md` §10). Raised while discussing
Phase 2 / Task 25's own scope with the human — Task 25 only *selects* an already-installed provider
pack; this scaffold is what a project with no matching pack installed would eventually need.

**Why it is first:** it is the only task in that sequence that touches no existing file. It adds one
script beside `generate-pack.sh` plus its test suite, and only *reads* `validate-pack-manifest.sh`.
Nothing it does can collide with work in flight elsewhere.

*Build note, not a scope change:* `generate-pack.sh` hardcodes `kind: platform` in its template and
its usage line takes no kind or role argument, so this is a sibling script, not a flag on that one.
Register its test suite in `.github/workflows/validate-agentic-core.yaml` the same way every other
`*.test.sh` there is registered — an unregistered suite is an unrun suite.

### Phase 3 / Task 6 — Setup: propose the design provider pack
*(new 2026-09-07, scheduled and rewritten 2026-09-21)*

**Delivers** an extension to `setup` (`plugins/agentic-core/skills/setup`) so its provider-pack step
covers the `design` role as well as `tracker`/`scm`: the same role-generic scan of installed sibling
packs it already runs, extended to a third role, and `packs.design` written on confirmation. Also
extends `write-provider-packs.sh` to write that third sub-key — its header currently states it
writes "exactly two of the five sub-keys under `packs:`", and it takes exactly
`<config-path> <tracker> <scm>`.
**Depends on** Phase 2 / Task 25 (the provider-pack proposal step it extends) and Phase 3 / Task 3
(the installed pack declaring `role: design`).
**You verify** a project with a `kind: provider`, `role: design` pack installed alongside the core
gets it proposed and `packs.design` written on confirmation; a project with none gets a plain
"none available" report naming the role, never a silent skip, never a fabricated pack name and never
an install; re-running offers keep / re-detect / edit, matching Task 25's own protocol; the written
file now passes `validate-project-config.sh`'s `packs.design` requirement, which has been in that
validator since Phase 2 and has had nothing to satisfy it.
**Reject if** it runs an install command, writes `packs.design` without a pack actually present on
disk, or **names a vendor anywhere under the core**.

**The vendor may not be named — this is a build constraint, not a preference.** The original body of
this task said to "detect whether the `figma` marketplace plugin is installed". That cannot be
written: `naming-denylist.txt` lists that name, `validate-naming-rule.sh` scans every file under the
core root stating "No exceptions", and `.github/workflows/validate-agentic-core.yaml` runs it in CI.
The detection must therefore be the role-generic one `setup`'s own step 6 already performs — scan
each installed sibling for a `pack.yaml`, skip anything not `kind: provider`, read its declared
`role` — which is both legal and simpler than what was originally asked for.

**What happens to the authentication precondition this task was filed for.** The `design` role's
provider can require an interactively-authenticated third-party plugin, which a scan of installed
packs cannot see. That precondition is **out of scope here** and is answered by the `requires:`
declaration and the diagnostic built in Tasks 7 and 10 — one mechanism for every provider's local
precondition rather than a special case wired into `setup` for one role.

*Logged 2026-09-07, scheduled 2026-09-21.* Raised while building Phase 3 / Task 3 (D43) and kept out
of that task's own scope deliberately — the user chose to keep it scoped to the pack itself.

### Phase 3 / Task 7 — A provider declares its local-tool precondition, and a validator checks it
*(new 2026-09-07, scheduled and rewritten 2026-09-21 — D97)*

**Delivers** the data half of D97: an optional `requires:` key on a **provider** pack manifest
(`tool` / `probe` / `remedy` per entry), its field rules in `pack-manifest.md`, and validator 18 in
`validate-pack-manifest.sh` with its test suite and fixtures. A pack that declares no `requires:`
is ungated, the same rule an undeclared `unsupported:` list already follows. `probe` is argv and is
judged by exit status alone — never a shell string, never a parsed version. `remedy` is a string a
human runs; nothing in this repo may execute it.

**Depends on** Phase 3 / Task 9 (D97 filed and the contract amended) and Phase 2 / Task 16 (the
manifest schema and its validator).

**You verify** a manifest declaring a well-formed `requires:` validates as `valid: provider`; each
malformed shape is rejected by name (`probe` given as a string rather than argv, a missing `remedy`,
`requires:` on a `kind: platform` pack); a manifest with no `requires:` still validates exactly as
it does today; `validate-naming-rule.sh` still passes, which it will not if any core-side example
names a real tool — use `<tool>` placeholders, the real names belong in `plugins/playwright/`.

**Reject if** the key lands anywhere other than the manifest — a `description` field no script reads
is what this task exists to replace — or if `probe` is specified in a form that reaches a shell.

*Rewritten 2026-09-21.* The original body asked pre-flight to answer "is the tool installed". It
cannot: `pre-flight.md:121-128` names `command -v` and "an installed binary's version" as
anti-patterns, while `01-core-contracts.md:288` assigns exactly that question to pre-flight — a
contradiction between two shipped documents, which is why this task sat unbuilt. D97 resolves it by
splitting declaration (here), probing (Task 10) and enforcement (Task 11), leaving pre-flight
declaration-only. Reasoning and the reference-implementation comparison:
`17-provider-preconditions-spec.md`.

---

### Phase 3 / Task 8 — browser: `interact` *(new 2026-09-10)*

**Delivers** the `browser` role's fourth operation in the installed browser pack: act on a target
already loaded — click, type, press a key — and return the state that results, in the envelope.
**Depends on** Phase 3 / Task 4, and D69 (the contract change that defines the operation).
**You verify** a real requirement that the first three operations cannot answer is answered by this
one, end to end against a live page — the worked case is `EDS-2`'s "opening one item closes the
other", which Phase 4 / Task 5 recorded as unanswerable. Also verify the negative: a pack declaring
`interact` unsupported causes pre-flight to refuse a route needing it, by name, before the run
starts.
**Reject if** the operation returns the underlying tool's output rather than the envelope, or if an
interaction that failed to take effect returns anything a caller could read as success. A check that
did not run must never look like a check that passed. (D69.)

### Phase 3 / Task 9 — Record the pre-flight contradiction, D97 and G105 *(new 2026-09-21)*

**Delivers** the decision before the code, the way Phase 7 / Task 1 and Phase 8 / Task 1 did:
**D97** filed in `03-core-design.md` (declare / probe / enforce, in three places; pre-flight never
probes; nothing in this repo ever installs), **G105** filed in `05-gap-register.md`, the amendment
to `01-core-contracts.md` §6 so the contract stops assigning pre-flight a question it forbids
itself, one line in `pre-flight.md` pointing at where the tool question *is* answered, the
`requires:` shape added to §11 and validator 18 to §13, and the deviation recorded in
`06-dx-core-deviations.md`. **No code.**

**Depends on** nothing. `17-provider-preconditions-spec.md` is its input and must be approved first.

**You verify** `grep -c D97 03-core-design.md` and `grep -c G105 05-gap-register.md` are both
non-zero; §6 no longer claims pre-flight answers "is the tool installed" without saying how;
`pre-flight.md`'s anti-patterns are **unchanged** — the probe moved, the ban did not lift; and
`validate-contracts.sh` still passes.

**Reject if** it weakens `pre-flight.md:28-39`'s false-negative argument, or files D97 while leaving
§6's original sentence in place — the contradiction has to be gone, not documented twice.

### Phase 3 / Task 10 — The read-only diagnostic that probes and reports *(new 2026-09-21, D97)*

**Delivers** the probing half of D97: `check-requires.sh` in `plugins/agentic-core/shared/lib/`,
which reads a provider manifest's `requires:`, runs each `probe`, and reports per entry — plus its
test suite, registered in `.github/workflows/validate-agentic-core.yaml`. `plugins/agentic-core/
skills/health/` grows from its Phase 2 / Task 1 scaffold-prover into the read-only diagnostic that
calls it across every pack the project config names, and reports each missing tool with its declared
`remedy` verbatim.

**Depends on** Phase 3 / Task 7 (the declaration it reads).

**You verify** with the tool present, every entry reports present and the exit status is zero; with
it absent from `PATH`, the declared `remedy` is printed **verbatim** and the exit status is non-zero;
a pack with no `requires:` reports nothing and exits zero; and `check-preflight.sh` against the same
project still reports `ready` in both cases — the probe answers the question, pre-flight still does
not ask it.

**Reject if** the diagnostic writes, edits, creates or installs anything, if it blocks or gates a
run, or if it paraphrases `remedy` rather than printing what the pack declared.

### Phase 3 / Task 11 — The point-of-use guard, and the run that proves both halves
*(new 2026-09-21, D97)*

**Delivers** the enforcement half of D97: a `requires:` block in `plugins/playwright/pack.yaml` —
the first real one — and a first-step guard in each of that pack's four operations, returning the
envelope's `fail` status carrying the declared `remedy` when the tool is absent. The prose currently
sitting in each operation's `description` field is deleted in the same change; leaving both would
mean two sources of truth, one of them unreadable by any script.

**Depends on** Phase 3 / Task 10, and Phase 3 / Task 8 (`interact`, the fourth operation to guard).

**You verify** end to end, with the tool deliberately absent: each of the four operations returns a
conformant `fail` envelope naming the remedy, and `validate-result-envelope.sh` accepts all four;
with the tool present, each behaves exactly as it does today; the diagnostic from Task 10 reports the
same missing tool with the same remedy string as the operation does; and **no file under
`plugins/`, at any point in the run, invokes an install command**.

**Reject if** an operation installs its own tool, returns anything a caller could read as success
when the tool is missing, or returns a raw error rather than the envelope. A check that could not
run must never look like a check that passed. This is the task that closes G105.

# Phase 4 — The platform pack for this project  *(was: Track K)*

### Phase 4 / Task 1 — Pack scaffold and manifest *(was: K1)*

**Delivers** `plugins/<pack>/` with a manifest binding every stage in the configured routes, and a
declared dependency on the core.
**Depends on** Phase 2 / Task 16.
**You verify** both plugins load together with two `--plugin-dir` flags and the local core
satisfies the declared dependency; the manifest validator passes.
**Reject if** it loads only when the core is installed from a marketplace — local development must
not require publishing. (D38.)

### Phase 4 / Tasks 2–7 — One stage adapter per stage in the default route *(was: K2–K7)*

**Delivers**, for each: a skill that performs that stage for this platform — calling the adopted
third-party skills where they fit — and ends with the envelope.
**Depends on** Phase 4 / Task 1, and the relevant Phase 3 pack.
**You verify** each adapter runs standalone against a real artifact and returns a conformant
envelope; and that its platform rules come from the pack, never from the core.
**Reject if** an adapter returns the third-party skill's output unchanged. Normalising it is the
adapter's whole job. (D34.)

Adapters, all in Phase 4: **Task 2** intake · **Task 3** plan · **Task 4** implement ·
**Task 5** verify · **Task 6** lint · **Task 7** deliver.

### Phase 4 / Task 8 — Test-content generator *(was: K8)*

**Delivers** the fixture generator that produces renderable content for a unit that has none.
**Depends on** Phase 4 / Task 1.
**You verify** a brand-new unit with no existing content renders locally from a generated fixture.
**Reject if** it only works for units that already have content — that case is already covered by
an adopted skill, and this task exists solely for the case that is not. (G3.)

### Phase 4 / Tasks 9–10 — Gate adapters *(was: K9–K10)*

**Delivers** the pack's `plan-gate` and `publish-gate` adapters: run the core's validators first,
then review what survives.
**Depends on** Phase 2 / Task 21, Phase 4 / Task 1.
**You verify** each runs read-only in an isolated worktree, reports only findings above its
confidence threshold, and emits the envelope; and that a deliberately broken change is caught by
`publish-gate` **before** anything is published.
**Reject if** a gate can modify the working tree, or reports everything it noticed rather than
what it is confident about. (D42.)

### Phase 4 / Tasks 11–17 — The remaining stage adapters *(new 2026-09-10)*

**Delivers**, for each: a skill that performs that stage for this platform — calling the adopted
third-party skills where they fit — and ends with the envelope. Same contract as Tasks 2–7; these
are the stages the original six-adapter decomposition predated.
**Depends on** Phase 4 / Task 1, and the relevant Phase 3 pack.
**You verify** each adapter runs standalone against a real artifact and returns a conformant
envelope; and that its platform rules come from the pack, never from the core.
**Reject if** an adapter returns the third-party skill's output unchanged. (D34.)

Adapters: **Task 11** readiness · **Task 12** extract · **Task 13** conventions ·
**Task 14** serve · **Task 15** baseline · **Task 16** prototype · **Task 17** verify-design.

All seven exist today as 23-26 line scaffolds from Phase 4 / Task 1.

### Phase 4 / Task 18 — `verify` checks behaviour, not only load-time state *(new 2026-09-10)*

**Delivers** the `verify` adapter extended to use the `browser` role's `interact` operation, so an
acceptance criterion about behaviour is checked rather than reported as uncheckable.
**Depends on** Phase 3 / Task 8, Phase 4 / Task 5.
**You verify** the half of `EDS-2`'s acceptance criteria that Phase 4 / Task 5 could not attempt —
exclusive open/close on click, `aria-expanded` staying in sync across a toggle, keyboard toggling —
is now genuinely checked, and that its finding distinguishes a criterion that failed from one that
could not be attempted.
**Reject if** an unsupported `interact` turns into a silent pass instead of an explicit
"not attempted". (D69, G44.)

---

# Phase 5 — Design-system onboarding  *(was: Track S)*

Kept deliberately: both adopted third-party packs assume a design system already exists, and
neither establishes one. (D27, G21.)

*Decomposed 2026-09-14.* These six carried one shared Delivers / Depends on / You verify / Reject if
block between them — the only phase in this file that did. Each now carries its own, split by what
that task specifically produces; nothing the combined block guaranteed was dropped. The headings keep
their `*(was: Sn)*` ids, which `05-gap-register.md`'s G23 and G26 and the archived task list still
cite by those names.

**The hard boundary for the whole phase, stated once and enforced per task below.** Nothing here
writes to the project's own stylesheets, its units of work, its house-style document or its package
manifest. Output goes to `.ai/design/` (D47), and project source is reached only through a change a
human merges (D22). A task in this phase that edits project source directly is wrong regardless of
what it produced.

**Where the envelope falls inside this phase.** *Decided 2026-09-14 by the user.* Three of these
mechanisms name no platform and never could — the breakpoint arithmetic, the findings taxonomy, and
the untouched-since-import oracle — so they ship in the **core**, along with the manifest's own shape
and pre-flight's third check (D80). The **platform pack** ships what is unavoidably platform: the
entry point, which files the derived values are written into, which files the audit reads, and the
paths pre-flight is told to test. A core file in this phase is subject to the naming rule like any
other — `01-core-contracts.md` §13 validator 8 — so a value, a width or a path reaches it only as an
argument, never as a literal.

*One consequence, flagged not resolved:* this file's own phase-boundary rule says a task needing both
sides is mis-scoped and should be split at the envelope. These six each deliver a core half and the
pack half that calls it, and stay six because the split is a call boundary rather than a naming one —
no core deliverable below names a platform. If a build session finds one that cannot avoid it, that
task splits in two rather than the rule bending.

**The dependency order is not 1→6.** Task 3 needs Task 1's token set but not Task 2's thresholds —
its archetypal finding compares a document's claim against the codebase, not against a derivation.
Task 4 needs only Task 3: it classifies files by their own git history and reads no derived value at
all. So Task 1 → {Task 2, Task 3}, Task 3 → Task 4, {Task 2, Task 4} → Task 5 → Task 6, and Tasks 2
and 4 can be built in either order or in parallel.

### Phase 5 / Task 1 — Derive the design system from the design source *(was: S1)*

**Step 0, and the task does not start without it.** *Decided 2026-09-14 by the user.* D24's own
residual says the detection mechanism is unverified — whether the design tooling exposes which
collection or library a variable resolves to, or only the resolved values, *"has not been tested"*,
and *"the rule stands regardless; the check's implementation does not, and must be verified against
real output before anything depends on it."* This task is the first thing that depends on it. So it
opens by running the installed `design` provider against a real file and recording what comes back:
whether provenance is exposed at all, and whether one node's variables can stand for a whole
collection. D24's residual in `04-eds-pack-design.md` is updated with the answer either way — that
is where the claim being tested lives. Only then is
the rest of this task's shape chosen — a designated tokens frame if provenance is exposed, or D24's
own stated set-comparison fallback if it is not. **A second `design` operation is not in scope here**:
that is a version bump on `01-core-contracts.md` §6 and gets its own task if the probe says it is
needed.

**Delivers** the onboarding entry point — `plugins/eds/skills/eds-adopt-design-system/`, a
pack-owned skill, manual invocation only, run once per project (D22, D17) — writing three files
under `.ai/design/`: `proposed-tokens.css`, `proposed-breakpoints.md` (Task 2 supplies its
derivation) and `design-system.md`, the manifest. **The manifest's own shape is a core shared
contract** — it records a token set and a token source, and names no platform, no design tool and no
file extension; the pack supplies what the values are and where they land. Every value comes through
the `design` role's `fetch_reference`, never carried over from the project's existing stylesheet: the
design source is authoritative for design **values** and the project keeps authority over code
**shape** — token naming, file layout, selector scoping (D20). The manifest records the **token
source** (D24), not only the resolved values — the library file key, the collection ids and names,
and the published variable set — because a manifest holding values alone cannot tell a *changed*
collection from a *different* one, which D24 classes as a hard stop rather than drift. What the
provider could not resolve is marked absent explicitly, never an empty set standing in for "unknown"
(the discipline D74 already fixed for `extract`'s `has_values`). One extraction pass records
everything the later tasks need, so nothing downstream calls the design provider again.
**Depends on** Phase 3 / Task 3 (the `design` provider pack supplying `fetch_reference`),
Phase 4 / Task 1 (the platform pack this skill ships in), and Phase 2 / Task 7 (the convention
record the results are recorded against).
**You verify** step 0's probe ran against a real design file and its finding is written down before
any of the rest was built; then that the skill runs against a design source with a known expected
answer and `.ai/design/` holds the three files; `git status --porcelain` shows **nothing changed
outside `.ai/design/`**; reading `proposed-tokens.css` confirms the values came from the design
source rather than being carried over from the boilerplate; and the manifest either names the
collection it resolved against or states in as many words that the provider exposes no provenance and
it fell back to comparing the resolved variable set by name and value — D24's own stated fallback,
not a silent omission.
**Reject if** anything outside `.ai/design/` changed. **This is the load-bearing one for D22**, and
every later task in this phase inherits it: onboarding that can touch project source directly makes
the merged-change boundary decorative. Also reject if step 0 was skipped or answered from the
documentation rather than from a real call — D24 has carried that residual unverified since
2026-08-16 and this task is where it stops being deferrable. Also reject if the proposal silently
kept a boilerplate value where the design source defines one; if the manifest records values with no
token source at all (D24); or if an unresolved value is written as an empty set rather than marked
absent (D74).

### Phase 5 / Task 2 — Derive breakpoints from the design frames *(was: S2)*

**Delivers** the breakpoint derivation as a **core** deterministic script and fixture —
`plugins/agentic-core/shared/lib/`, alongside the other validators — taking a list of widths and
returning a list of thresholds, naming no platform, no design tool and no unit; plus the pack-side
wiring that feeds it Task 1's recorded frame widths and writes the result into
`proposed-breakpoints.md`. Thresholds are the **geometric mean of adjacent design frame widths,
rounded to the nearest 50**; the smallest frame is the base and gets no query (D21). A frame width is
a canvas width — the designer's statement of what that layout looks like — never a switch point, and
the file shows the arithmetic rather than only the results. The derived thresholds and the capture
widths both read from the manifest, so they cannot drift apart as two independent lists.
**Depends on** Phase 5 / Task 1 only — the frame widths it operates on are already on disk from
Task 1's single extraction pass, so this task calls the design provider for nothing. Independent of
Tasks 3 and 4.
**You verify** the fixture's 375 / 800 / 1280 yields base, 550 and 1000 **through the core script
alone, with no design provider and no pack involved** — it is pure arithmetic and must be testable as
such; the naming-rule validator passes on the new core file; and `proposed-breakpoints.md` shows
`√(375×800) ≈ 548 → 550` so a reviewer can check the numbers without re-running anything.
**Reject if** a threshold equals a frame width. **This is the load-bearing one for D21**: that
reading gives a design its own width as its switch point, so at 810px the viewer still gets the
mobile layout — the exact defect the rule exists to prevent. Also reject if any threshold is chosen,
configured, or carried over from the boilerplate ladder rather than derived, or if the file states
results without the arithmetic behind them.

### Phase 5 / Task 3 — Audit the project against what was derived *(was: S3)*

**Delivers** two halves. **Core:** the findings taxonomy as a shared contract alongside
`gate-contract.md` and `readiness-criteria.md` — the four classes, the severity test, and the
required shape of a finding. It names no platform, because "what does fixing this require" is not a
platform question. **Pack:** the audit skill itself — invocable alone as well as from Task 1's skill
(D17) — which knows which files this platform has, writes `.ai/design/audit.md` against that
contract, and registers that artifact in its own `pack.yaml`. The artifact is pack-produced, so it
belongs in the pack's `artifacts:` list, not the core registry — §12 draws that line already. The four classes (D23): *mechanical* (one answer
derivable from the manifest or the code), *needs the human* (one right answer exists but only they
have it), *judgment* (several defensible answers, asked with a recommendation and a default),
*report-only* (the fix is a real choice with cost). Each finding carries the exact diff it would apply
and the file it applies to. Severity is decided by one question — **does an agent read this file as
truth?** — which is checkable rather than a matter of taste (G22), and only findings that answer yes
are *poisoning*.
**Depends on** Phase 5 / Task 1 (the token set it audits against). **Not Task 2** — its findings
compare documents against the codebase and raw values against adopted tokens; neither needs a derived
threshold.
**You verify** against the four findings known to be live in this repo: the house-style document's
breakpoint line contradicting the stylesheet is classed **poisoning**; the package manifest's name,
description and repository url are **needs the human**; a raw hex in a block stylesheet is
**mechanical** when it exactly equals an adopted token and **judgment** when it is close but not
equal; dead font files are **not** poisoning. `git status --porcelain` still shows nothing outside
`.ai/design/`.
**Reject if** severity was assigned by how bad a finding looks rather than by whether an agent reads
the file as truth — that test is the only thing keeping Task 6's gate from becoming a matter of
taste. Also reject if a finding is recorded without the diff it would apply, or if the audit
terminates in a report with no path to an applied fix: a record with no graduation path is a
graveyard, and recording feels like resolving (D23, D13).

### Phase 5 / Task 4 — The untouched-since-import test *(was: S4)*

**Delivers** the auto-fix eligibility oracle as a **core** script and fixture, taking a list of paths
and returning an eligible/demoted verdict per path — it reads git history and nothing else, so it
names no platform; plus the pack-side call that hands it the files Task 3's audit produced findings
for. A file may be auto-fixed **only if it is provably untouched since the boilerplate import**;
`git log --oneline -- <file>` is the oracle, answered offline with git as the source of truth. A file
the human has already edited demotes from *mechanical* to *judgment* — it becomes a question showing
the proposed diff, never a silent rewrite. *Adapted from `dx-adapt`'s rule that it never overwrites
user customizations (MIT, © 2025-2026 Dragan Filipovic); what changed is that it states the rule as a
policy and we make it a checkable test against git history.* **Precondition:**
`git rev-parse --is-shallow-repository` runs **before the first oracle check**; `true` is a
PERMANENT-class abort reporting `git fetch --unshallow` as the remedy (G26).
**Depends on** Phase 5 / Task 3 only. **Independent of Task 2** — the oracle classifies files by
their own commit history and reads no derived value, so it can be built and verified before any
breakpoint exists.
**You verify** a file the audit called mechanical, once edited and committed, moves out of the
auto-fix set and into the questions with its diff shown; and that a `--depth 1` clone of this repo
produces the PERMANENT abort rather than an auto-fix set.
**Reject if** a file you have edited is still auto-fixed — this is the rule that stops the audit
clobbering a deliberate decision it does not understand. Also reject if a shallow clone produces an
auto-fix set at all: under `fetch-depth: 1` the oracle returns at most one commit for *every* file
regardless of real history, and a result computed from a lying oracle is worse than no result (G26).
Also reject if the shallow check runs after the first oracle call rather than before it.

### Phase 5 / Task 5 — Proposal, questions, and the change for a human to merge *(was: S5)*

**Delivers** the questionnaire and the change that completes onboarding. Questions are grouped by
Task 3's classes, each asked with a recommendation and a default; nothing is written before it has
been shown, and the run waits for an answer rather than proceeding on one it assumed — the present /
ask / wait / apply protocol, matching the keep / re-detect / edit shape `setup` already uses
(Phase 2 / Tasks 5, 7, 25). On approval it opens a branch through `scm.create_branch` and a change
through `scm.publish_change`, carrying **three separable commits in this order** so review is
tractable: the design system (the project stylesheet, the font stylesheet, the house-style
document's breakpoint line, and the manifest promoted out of `.ai/design/`); the mechanical cleanup;
the answered questions. The interview answers are also written into the project's convention record
(core contract §7.2) so they survive a pack later regenerated from an updated template. Declining
leaves no branch and no commit.
**Depends on** Phase 5 / Tasks 2 and 4 — and so transitively 1 and 3, since it proposes both the
derived values and the classified findings — plus Phase 3 / Task 2 (the `scm` provider; this is
`create_branch`'s first real call site anywhere, cf. G46) and Phase 2 / Task 7 (the convention
record).
**You verify** the change carries exactly three commits in that order; the manifest appears in
project source only inside that change's diff; and declining on a fresh run leaves no branch and no
commit behind.
**Reject if** the manifest reaches project source by any route other than that merged change. Its
presence in the working tree is what Task 6 reads as "this project has onboarded" (D22), so if it can
appear without a merge the gate means nothing — **this and Task 1 are where D22 is load-bearing, at
the two ends of the same boundary.** Also reject if any file outside `.ai/design/` is written to the
working tree before the human approves, or if a question in the *needs the human* or *judgment*
class is answered on their behalf (D23).

### Phase 5 / Task 6 — Gate the pipeline on onboarding having run *(was: S6)*

**Delivers** pre-flight's **third check**, over paths the platform pack declares and the core never
names (**D80**, closing G63). Four pieces: the amendment to `01-core-contracts.md` (§6 and
`pre-flight.md`'s "two structural reads" becoming three, with its anti-patterns list rewritten to
distinguish *reading a pack-declared path* from *probing the environment*; §11's platform-manifest
schema gaining the two keys; §13 gaining the validator that a declared path resolves); the core check
itself; the pack's declaration of its own onboarding-state and audit-findings paths; and fixtures per
outcome. The two checks behave differently on purpose: **(a) manifest present** — absent warns and
caps the run's confidence `low`, and never blocks; the project has not onboarded and every design
value is being guessed (D20, G21). **(b) no open poisoning finding** — blocks, PERMANENT, naming the
contradiction and the command that resolves it. Only *poisoning* findings block; everything else is
reported (D23). A pack declaring neither path is not gated — the same shape §6 already uses for a
provider declaring an operation `unsupported`, where the core acts on a declaration rather than on
knowledge of the thing declared.
**Depends on** Phase 5 / Task 5 (there is nothing to gate on until a manifest can exist) and
Phase 2 / Task 14 (pre-flight, the contract this amends).
**You verify** with the manifest removed, a run warns, caps confidence `low` and still proceeds; with
the house-style document's breakpoint line edited to contradict the stylesheet, a run stops **before
any branch, file or outbound call exists**, names the contradiction, and names what to run to resolve
it; a pack declaring neither path runs ungated rather than failing; and the naming-rule validator
passes on the amended core, with no platform path anywhere in it — not as a default, not as a
fallback, not as fixture data (D51).
**Reject if** a missing manifest blocks, or a cosmetic finding blocks. The two must behave
differently — that distinction is the whole design, and a gate that stops a run over an unused font
file teaches the team to route around it. Also reject if any platform path reached the core (core
contract §13 validator 8); if the third check probes a process, a command or the network rather than
reading a declaration and testing a path — that is the false-negative failure mode `pre-flight.md`'s
"why never a health check" paragraph exists to prevent, and widening the contract must not widen
that; or if the poisoning check lands late enough that a branch, a file or an outbound call already
exists.

---

# Phase 6 — The runs that prove it  *(was: Track R)*

Nothing above proves the design. These do.

### Phase 6 / Task 1 — A route with no design source, end to end *(was: R1)*

**Delivers** one real work item — a defect or a refactor — carried from intake to a published
change.
**Depends on** Phase 2, Phase 3 / Tasks 1, 2, Phase 4 / Tasks 1–7.
**You verify** it completes `delivered`, the route was chosen by the table, and the run log shows
which rule fired.
**Reject if** it needed manual intervention at any stage. **This is the first task that tests the
claim "any ticket", and it is deliberately the no-design case** — the one the original plan could
not express at all.

### Phase 6 / Task 2 — A design-driven route, end to end *(was: R2)*

**Delivers** the same for a work item with a design reference.
**Depends on** Phase 6 / Task 1, Phase 3 / Tasks 3, 4, Phase 5.
**You verify** it completes `delivered` and the verification stage's verdict is derived from
measurement, not from an impression.
**Reject if** the verdict is a judgement call with no assertion behind it. (G4.)

### Phase 6 / Task 3 — Autonomous mode *(was: R3)*

**Delivers** an unattended run of Phase 6 / Task 1's work item, and an unattended run of a
deliberately unclear one.
**Depends on** Phase 6 / Task 1.
**You verify** the clear item completes without a question; the unclear one ends `blocked` with the
blocker written to the work item and **no branch, file or change created**.
**Reject if** anything was guessed, or an artifact survives a blocked run.

### Phase 6 / Task 4 — A second platform *(was: R4)*

**Delivers** a minimal second platform pack — a different stack, generated through
Phase 2 / Task 7's interview — running Phase 6 / Task 1's route on a small repository.
**Depends on** Phase 6 / Task 1, Phase 2 / Task 7.
**You verify** it completes with **zero changes to the core**, confirmed by a diff.
**Reject if** the core changed by even one line.

> **Phase 6 / Task 4 is the only task that tests the thesis.** Everything before it is consistent
> with a core that merely looks agnostic. A single core commit needed to make a second platform
> work means the boundary is in the wrong place, and it is far cheaper to learn that here than
> after publishing. Do not defer it to "later" — schedule it as the first task after
> Phase 6 / Task 1 passes.

**Candidate second platform, added 2026-09-08 — not yet decided, just named so this task does not
start from a blank page.** PayloadCMS: a Node/TypeScript headless CMS with its own real,
actively-maintained plugin ecosystem —
`github.com/orgs/payloadcms/repositories?q=topic%3Apayload-plugin` lists (checked 2026-09-08):
`plugin-cloud-storage`, `plugin-seo`, `plugin-form-builder`, `plugin-stripe`, `plugin-search`,
`plugin-password-protection`, `plugin-nested-docs`, `plugin-zapier`, `plugin-sentry`,
`plugin-redirects`, `plugin-relationship-object-ids`, `plugin-cloud`, plus `plugin-template` for
authoring a new one. Worth considering *because* it stresses the boundary harder than another
static-site generator would: admin-panel/backend config rather than rendered blocks, no
Edge-Delivery-shaped design/preview step at all — a real exercise of `packs.design: none` (§7),
which nothing has exercised yet.

**Do not confuse the two senses of "plugin" here.** Those repos are PayloadCMS's *own* extension
mechanism (a `payload-plugin` is a PayloadCMS package, unrelated to a Claude Code plugin). They are
candidate **realistic work items** for Phase 6 / Task 1's route to carry end to end against a
PayloadCMS project (e.g. "add a field to `plugin-seo`") — not a template for the platform pack
itself. The platform pack this task builds is a new one, generated through Phase 2 / Task 7's
interview against whatever PayloadCMS project is chosen, the same way `plugins/eds/` was built for
this one.

### Phase 6 / Task 5 — Flip the driver's read hook from warning to deny *(new 2026-09-04)*

**Delivers** the driver's read hook converted from an informational warning to a default-deny
allowlist, with the allowlist derived from what Phase 6 / Task 1's run actually read.
**Depends on** Phase 6 / Task 1.
**You verify** the hook denies a read outside the allowlist and the denial reason names what is
allowed, so a driver that reaches for the wrong file gets a correction rather than a silent
failure; and that re-running Phase 6 / Task 1 still completes `delivered` with the hook in place.
*Criterion restated 2026-10-04 (Phase 42 / Task 7, the human's choice; G111):* a correct driver
never calls `Read` — run B (2026-10-03) made none — so the earlier reading "`ALLOW > 0`" can never
hold. The live criterion is three facts from `.ai/logs/run-route-reads.log`: **(1) registered** — at
least one `ALLOW`, `DENY` or `NORUN` line carries a timestamp inside the driving session (a `NORUN`
line after the run is enough: the hook ran); **(2) compliant** — no `DENY` line between the run's
marker write and its terminal state; **(3) delivered**. Zero `ALLOW` lines is the expected shape,
not a gap.
**Reject if** the allowlist was written from the contract rather than from the run's own log — the
whole reason this is a separate task, gated on a real run, is that §14's standing rule is to pick
after a run produces evidence. Also reject if it warns instead of denying: D4's "never reads a
source file, a spec file, a report, or an image" is a quantitative claim the linear-cost argument
rests on, and in autonomous mode nobody is reading the warning.

*Designed 2026-09-22 in `19-driver-read-allowlist-spec.md` (draft, unapproved — its D101 is not
filed). Two corrections that entry needs, both evidenced there: the hook was never registered at
all, because its frontmatter used a shape the documented schema does not accept (G111 Finding 1,
fixed 2026-09-22) — so nothing built on top of it was ever exercised. And the **Reject if** above
names "the run's own log" as the derivation source; that log has never existed and, given the
shipped denylist matched none of the driver's 33 actual reads, would have been empty even had the
hook fired. The real evidence is the driver-level read set in `.ai/logs/route-run*.jsonl`, isolated
by `parent_tool_use_id == null`. The standing rule the clause protects — derive from a run, not from
the contract — is unchanged.*

---

### Phase 2 / Task 26 — Condition filter, and validators 12–14 *(new 2026-09-06, D42)*

**Depends on** Phase 2 / Task 23 (route driver), Phase 2 / Task 16 (manifest validator).

**Delivers** the driver change D42 requires. The driver stops resolving a route and instead reads
the platform pack's single `stages:` list, evaluating each stage's `when:` against the fact record
before spawning it. Semantics are in `01-core-contracts.md` §11.1: no `when:` runs always; `when:`
is a list of blocks and any block matching runs the stage; within a block every key must match; a
skipped stage is recorded `skipped` in run state along with the condition that skipped it, and
control passes to the next stage in list order.

Also delivers §13 validators 12, 13 and 14 — every `when:` key names a real §5 field; a pack
declares `readiness_criteria` for at least one `item_type` and requires only real §5 fields; and
the pack's stage list agrees with its route digraph node-for-node, including that each conditional
stage's incoming edge label matches its `when:`.

**Amended 2026-09-07.** See `11-condition-filter-spec.md` for the design this task was found to
need — the shipped core is still entirely pre-D42, so this is a migration, not an addition. It also
delivers, per that spec's approved decisions: **validator 1** strengthened against §4's fifteen ids
(D62 — beyond this entry's original text, accepted deliberately); the `route.dot` artifact validator
14 checks against (D58); `skip_when_missing` and `evaluate-skip-conditions.sh` retired (D59);
`run-state.json` gaining `skipped` (D60); and `fact-record.md` brought to §5 parity, which
`design_mentioned` — named in this entry's own verification — requires (D61).

**You verify** a run whose fact record has `design_mentioned: false` and no design source skips
exactly four stages, names each in run state with the condition that skipped it, and reports a
`<total>` that matches what ran. A `when:` naming a field §5 does not carry fails validator 12
rather than silently disabling its stage forever.

**Reject if** the driver reads anything but the fact record when evaluating a condition, or if a
condition can probe the environment — that belongs to pre-flight (§6), and allowing it here makes
a run's shape depend on the machine.

### Phase 2 / Task 27 — Remove the route table from config *(new 2026-09-06, D42)*

**Delivers** the deletion half of D42: `routes:` out of `project-config.yaml`, `explicit_route` out
of the fact record, and **D65's fixed-indentation parser retired** — it existed only because the
`routes:` block was not valid YAML, so config is now read by an ordinary parser end to end.
`setup` stops seeding a route table; it still calls `tracker.list_types`, now to enumerate item
types so the generated pack can declare `readiness_criteria` for each.

**You verify** config validates as ordinary YAML, `setup` on a project with three item types
produces a pack declaring criteria for all three, and no code path references a route id.

**Reject if** anything still writes a stage list into project config, or if `setup` guesses item
types instead of asking the tracker — §4's `readiness` fails an undeclared type, so a guessed list
produces a pack that refuses real work.

### Phase 2 / Task 28 — Setup: choose provider packs before generating the platform pack
*(new 2026-09-08)*

**Delivers** a reorder of `setup/SKILL.md`: provider-pack selection (currently steps 9-13, choosing
`packs.tracker`/`packs.scm`) moves to run before the interview and platform-pack generation
(currently steps 5-8). Every "go to step N" cross-reference in the file is renumbered to match.

**Depends on** Phase 2 / Task 27 (done — added the concrete `tracker.list_types` call this task
makes reachable on a first run).

*Raised while building Task 27.* That task wired the actual `list_types` call for `<item-types>`,
but could only make it fire when `packs.tracker` was already configured — which, given the step
order at the time, is true only on a second or later `setup` run, never a from-scratch first one.
On a first run the call still degrades to asking the human directly. Task 27's own text scoped it
to "wire the actual call," not reordering the skill, so the reorder was logged here rather than
done inline. Decided with the user (2026-09-08) to schedule it as the very next task rather than
leave it logged-not-scheduled.

**You verify** a fresh project with no `.ai/project-config.yaml`, run through `setup` end to end
with an installed tracker pack available to select: `packs.tracker` is written before the platform
pack is generated, and the generated pack's `readiness_criteria` come from an actual `list_types`
invocation — not the human-asked fallback — because a tracker is already chosen by the time step 7
(now renumbered) runs. Every remaining "go to step N" reference in the file resolves to the correct
step after renumbering, checked by reading the file through once end to end.

**Reject if** a cross-reference is left pointing at the pre-reorder step number, or if the
human-asked fallback path (no installed tracker pack matches, or `list_types` is unsupported or
fails) is dropped — it must still work exactly as before, just reached less often.

### Note — the stages D42 added, and the tasks they landed in *(new 2026-09-06, renumbered 2026-09-10)*

**This section defines no task.** It records what D42 added to the stage vocabulary and points at
the task that builds each one. The task ids live in the Phase 4 sections above.

*Corrected 2026-09-10: this was headed "Phase 4 / Tasks 11–13" and assigned `baseline` to Task 12
and `verify` to Task 13. Those numbers were written on 2026-09-06, before G42's fix appended
Phase 4 / Tasks 11–17 for all seven remaining adapters (`05-gap-register.md:1484`), which reassigned
12 to `extract` and 13 to `conventions`. Two sections of this file then defined the same task ids
differently, with no marker saying which won. The Tasks 11–17 section is authoritative — it matches
`NEXT.md`, the done files, and the stub skill names in `plugins/eds/skills/`. The three descriptions
below are kept because they are the only place this detail is written down; only their task
anchors changed.*

- **`readiness` — Phase 4 / Task 11.** Reads the fact record only, applies `readiness_criteria` for
  the item's `item_type`, returns `pass | question | fail`. An undeclared type is `fail` naming the
  missing declaration. Asks which attachment is the reference when an image is the only design
  source (G36).
- **`baseline` — Phase 4 / Task 15.** Captures the named component's rendered state before any
  change, so `verify` can compare before against after. Conditional on `components` being present.
- **`verify`, merged — Phase 4 / Task 5, delivered.** Behaviour and responsiveness through the
  `browser` role always; the design comparison inside it only when the design stages ran. Replaces
  what Phase 4 / Tasks 2–7 scoped as a design-only verification step. **Not one of Tasks 11–17** —
  it shipped as Task 5 (`phase-4-task-5-done.md`). Distinct from the `verify-design` stage
  (Phase 4 / Task 17, still a stub), which compares the *prototype* against the reference before
  implementation; this one compares the *implemented change*. (`01-core-contracts.md`:155, :163.)

**Reject if** `verify` is conditional. An item with no design source would then reach
`verified: true` on lint alone, and the field would mean two different things depending on the item.

---

# Phase 7 — Delivery evidence  *(new 2026-09-17, G86 · D86, D87, D88)*

**Why this phase exists.** A run's verification evidence never reaches the work item, and a
thin-coverage finding the verification stage made itself dies on local disk — found live on EDS-4,
registered as G86 (`05-gap-register.md`). Designed in `14-delivery-evidence-spec.md`, whose three
phases are flattened here into one ordered run: its Phase 1 is Tasks 1–10, its Phase 2 is
Tasks 11–15, its Phase 3 is Tasks 16–19. Each heading in that document names its own range, so the
two cannot drift.

*Appended after Phase 6 and before the Coverage section, following the precedent set by Phase 2 /
Tasks 26–28 (new 2026-09-06, D42).* **"Phase" numbers it, it does not serialise it** — the rule at
the top of this file holds here too: Phase 7 / Tasks 1 and 2 depend on nothing in Phase 6 and can
be built before it finishes.

**Three constraints scope every task below, and a task that needs to break one is mis-scoped:**

- **No stage is added.** The vocabulary is closed at fifteen ids (§4, D42). Every change lives
  inside a stage that already exists.
- **The core names no platform, product or tool.** `validate-naming-rule.sh` enforces it, and this
  work must not earn a denylist entry or a carve-out (D51).
- **The runner never opens a path a stage listed as an artifact.** This is why Task 9's failure-path
  attach belongs to the verification stage and not to the runner.

### Phase 7 / Task 1 — Record the gap and the decisions *(done 2026-09-17)*

**Delivers** G86 in `05-gap-register.md`; D86 and D87 in `03-core-design.md`; D88 in
`04-eds-pack-design.md`; two standing-deviation entries in `06-dx-core-deviations.md`. All five
files are gitignored, so this task produces no commit and no PR — it is bookkeeping, and the
standing rule is that a capability gets its entry **before** it is built.
**Depends on** nothing.
**You verify** each of the five entries exists and carries the id it claims; and that no id
collides with one already assigned.
**Reject if** an id is reused. *This is not hypothetical — it is what this task actually caught.*
The spec was drafted against G84, D85, D86 and D87; `G84` was already the resolved
`eds-verify-design` content-asset gap and `D85` already the work-item authoring decision. The four
records are therefore **G86, D86, D87, D88**, and `14-delivery-evidence-spec.md` carries a dated
renumbering note saying so. Also reject if a decision is filed in the wrong record — D86 and D87
are core decisions and belong in `03-core-design.md`; D88 names a path and this platform's own
stages and belongs in `04-eds-pack-design.md`.

### Phase 7 / Task 2 — The core contract *(done 2026-09-18)*, `phase-7-task-2-done.md`

**Delivers** three edits to `01-core-contracts.md` and nothing executable: the optional
`evidence_manifest: <artifact id>` field in §11's platform-pack manifest, **optional to declare and
mandatory to honour**; the `deliver` obligation in §4 — when the pack declares one, the stage
attaches every file that manifest lists before it posts its note, and an attach that fails degrades
the stage to `warn`, never to `fail`; and validator 16 in §13 — a declared `evidence_manifest` names
an artifact id that appears in that same pack's own `artifacts:` list.
**Depends on** Phase 7 / Task 1.
**You verify** `bash plugins/agentic-core/shared/lib/validate-contracts.sh` still passes, and §4's
fifteen-id list, §12's artifact registry and §11's route-digraph rules are **textually unchanged** —
this task adds a manifest key, a stage obligation and a validator, and nothing else.
**Reject if** the manifest is added to §12's artifact registry. Its producer is a pack-declared
stage, so validator 7 would correctly call that a producer that does not exist; D86 is the record of
why the shape is core-owned and the file is not. Also reject if the delivery obligation is written as
`fail` on a failed attach — the change is already published by that point, and a failed upload
presenting as a failed delivery is a false terminal state.

### Phase 7 / Task 3 — The manifest validator and its tests *(done 2026-09-18)*, `phase-7-task-3-done.md`

**Delivers** `plugins/agentic-core/shared/lib/validate-evidence-manifest.sh` validating a manifest
against the shape D86 fixes, plus `validate-evidence-manifest.test.sh` covering: a valid manifest;
each required field missing, one case each; an attachment path that does not exist; and an empty
attachment list.
**Depends on** Phase 7 / Task 2.
**You verify** `plugins/agentic-core/shared/lib/validate-evidence-manifest.test.sh` exits `0` with
every case reported, and the validator exits non-zero on each malformed fixture for a reason that
names the offending field.
**Reject if** the test file is absent or covers only the happy path. **The most recent gap found in
this project was caused by a script that shipped with no test coverage of any kind** — the test file
is an acceptance criterion here, not a courtesy. Also reject if the validator's own text names this
platform, the browser provider, or any path under `docs/implementation-plan/`; it lives under the
core and §13 validator 8 is run against it.

### Phase 7 / Task 4 — Validator 16 *(done 2026-09-18)*, `phase-7-task-4-done.md`

**Delivers** validator 16 inside `plugins/agentic-core/shared/lib/validate-pack-manifest.sh`, with
`validate-pack-manifest.test.sh` extended in the same change: a declared `evidence_manifest` must
name an artifact that pack registers.
**Depends on** Phase 7 / Tasks 2, 3.
**Read this before starting — the integration is not additive.** That script is a **line-ordered
cursor parser**, and it ends with
`fail "unexpected content after the last platform key: '${LINES[cursor]}'"`. So `evidence_manifest:`
must be spliced into the cursor sequence at a definite position — after the optional
`audit_findings_path:` read and before that final check — or **every pack that declares the key
fails validation with a message about unexpected content**, which names the wrong cause entirely.
Second, the `artifacts:` block's parser matches `- id: (.+)` and **discards the captured id**; it
stores only `produced_by` and `path`. Validator 16 cannot be written until that loop collects the
ids it is currently throwing away.
**You verify** `plugins/agentic-core/shared/lib/validate-pack-manifest.test.sh` exits `0`; a fixture
pack declaring `evidence_manifest: not-a-real-artifact` fails **naming the unregistered id**; a
fixture declaring one that is registered passes; and a fixture declaring the key at all still passes
the trailing unexpected-content check.
**Reject if** the failure message for an unregistered id reads as an unexpected-content or
parse error — that is the specific misdiagnosis this task's integration risk produces, and it would
send the next person to the wrong half of the file. Also reject if a pack that declares **no**
`evidence_manifest` changes behaviour in any way: the key is optional, and today's packs must
validate byte-identically.

### Phase 7 / Task 5 — Register the artifact *(done 2026-09-18)*, `phase-7-task-5-done.md`

**Delivers** `plugins/eds/pack.yaml` gaining the manifest in its `artifacts:` list —
`produced_by: verify`, `path: ".ai/run-context/evidence-manifest.json"` — and the
`evidence_manifest:` key naming that id, placed after `audit_findings_path:` to match Task 4's
cursor position.
**Depends on** Phase 7 / Task 4.
**You verify** `plugins/agentic-core/shared/lib/validate-pack-manifest.sh plugins/eds` passes, and
`claude plugin validate --strict plugins/eds` passes.
**Reject if** the declared id and the registered id differ by so much as a character — that is the
exact typo validator 16 exists to catch, and catching it here rather than in the last stage of a
route, after the change is already published, is the whole point of building the validator first.

### Phase 7 / Task 6 — The verification stage writes the manifest *(done 2026-09-18)*, `phase-7-task-6-done.md`

**Delivers** `plugins/eds/skills/eds-verify/` emitting `.ai/run-context/evidence-manifest.json` in
the shape D86 fixes, including the `coverage_gaps` it **already derives and already writes into its
own prose report**, and listing the manifest in its result envelope's `artifacts:`.
**Depends on** Phase 7 / Task 5.
**You verify** `eds-verify` run standalone against a real item (D17's independence rule) writes a
manifest that `validate-evidence-manifest.sh` accepts, whose `attachments` name capture files that
exist, and whose `coverage_gaps` match what the stage's own report says in the same run.
**Reject if** `coverage_gaps` is empty on a run whose report names a coverage gap. That divergence
*is* G86 — the stage was already honest on EDS-4 and the finding still never reached a human, so a
manifest that drops it has rebuilt the gap inside the fix. Also reject if the stage writes the
manifest but omits it from its envelope's `artifacts:` list.

### Phase 7 / Task 7 — The design-verification stage writes it too, merging *(done 2026-09-18)*, `phase-7-task-7-done.md`

**Delivers** `plugins/eds/skills/eds-verify-design/` writing the same shape, **merging rather than
overwriting**.
**Depends on** Phase 7 / Task 6.
**You verify** on a design-driven route, where `eds-verify-design` runs before `eds-verify`, the
final manifest carries the design comparison's captures **and** the behavioural verification's, and
still validates.
**Reject if** the later writer overwrites. The natural implementation — write the file — silently
discards the earlier stage's evidence on exactly the routes that produce the most of it, and the
loss is invisible in the run's output.

### Phase 7 / Task 8 — The delivery stage attaches and posts *(done 2026-09-18)*, `phase-7-task-8-done.md`

**Delivers** `plugins/eds/skills/eds-deliver/` reading the manifest, attaching each listed file in
order through the `tracker` role's `attach_file`, and posting one note carrying: the change's
location on its own line; the target that was verified, on its own line; whether a person can open
it, stated plainly either way; and any coverage gap the verification stage recorded, **in the words
it recorded them**. An attach that fails degrades the stage to `warn`.
**Depends on** Phase 7 / Tasks 5, 6.
**Read this before starting — a real defect in the attach script, found 2026-09-17.**
`plugins/jira/skills/attach-file/scripts/attach-file.sh` posts **one file per invocation**
(`-F "file=@${FILE_PATH}"`), so three attachments are three sequential POSTs. Size is not the
constraint — Atlassian documents 2 GB per file with a 1 GB default and no documented cap on the
number of attachments, against a ~30 KB capture. **The constraint is our own script:** it writes
every response to `.ai/tracker/attach-file-<ITEM_ID>-response.json`, keyed on the item and not the
file, so the third upload to one item clobbers the first two responses and the run loses the first
two attachment ids.
**You verify** a run attaching three files lands all three on the item, and the run's own record
retains an attachment id for **each** of the three, not just the last.
**Reject if** only the last attachment's id survives — the uploads would have succeeded while the
evidence that they did is gone, which is a quieter version of the gap being fixed. Also reject if a
path listed in the manifest that no longer exists is skipped silently: it is reported and skipped,
never dropped. Also reject if a failed attach fails the stage.

### Phase 7 / Task 9 — The failure path *(done 2026-09-18)*, `phase-7-task-9-done.md`

**Delivers** `eds-verify` attaching its own captures when it returns a failing or warning verdict,
**and only then** — on a clean pass it stays silent and `eds-deliver` does the attaching, so a run
never attaches twice.
**Depends on** Phase 7 / Tasks 6, 8.
**You verify** a run whose verification fails lands the captures on the work item even though
`deliver` never runs; and a run whose verification passes lands each file exactly once.
**Reject if** the runner is given the job. §14's standing rule is that the runner never opens a path
a stage listed as an artifact, and that rule is load-bearing for D4's linear-cost argument. The owner
here was forced, not preferred: a failing verdict is terminal, so no later stage exists to carry the
evidence. Also reject if a clean pass attaches twice.

### Phase 7 / Task 10 — A live run

**Delivers** one real work item carried through the route, with the attachments and the note on it.
**Depends on** Phase 7 / Tasks 8, 9.
**You verify** `/agentic-core:run-route <item id>`, then fetch the item back and read the
attachment filenames and the last note off the fetched JSON — the run's capture files are listed
among the attachments, and the note states what was verified and where.
**Reject if** the evidence is confirmed by reading the local manifest rather than by fetching the
item back. The gap being closed is precisely that local evidence is not evidence a human received.

### Phase 7 / Task 11 — The reachability script and its tests

**Delivers** a script implementing D87's two conditions with the three outcomes kept distinct —
`unreachable` (loopback or link-local host, decided with no network call), `reachable` (a load
through the `browser` role returns success), `unconfirmed` (routable but unanswered within a bounded
backoff) — plus its test file covering a loopback address, a routable address that answers, a
routable address that does not, and the backoff budget running out.
**Depends on** Phase 7 / Task 2.
**Already settled, so this task does not re-derive it.** The `browser` role works against a remote
host — checked 2026-09-17 against this project's own remote preview host, where `render` returned
`verdict: pass … HTTP 200, 0 console error(s)` (`status=200 load_time_ms=880`) and `capture`
returned `verdict: pass` at width 375. `capture.cjs` validates its argument as an `http(s)` URL and
carries no loopback restriction. **Condition 2 therefore needs no new role operation** — `render`
already reports the status the rule reads.
**You verify** the test file exits `0`, condition 1 is decided without any network call, and each of
the three outcomes is reachable in a test.
**Reject if** `unconfirmed` collapses into either neighbour. Reported as `unreachable` it is a false
negative a reviewer will disbelieve; reported as `reachable` it is the exact claim D87 exists to
forbid. Also reject if the logic lives in a stage's prose instead of the script — a stage asked to
judge this would be judging what a script decides.

### Phase 7 / Task 12 — The verification stage sets the field

**Delivers** `eds-verify` calling the script and recording `target_reachable` and
`target_reachable_reason` in the manifest.
**Depends on** Phase 7 / Tasks 6, 11.
**You verify** the field's value traces to the script's own outcome in the same run, for a local
target and for a remote one.
**Reject if** the stage infers either value. Both come from the script; an impression written into
`target_reachable` is indistinguishable in the output from a measured one, which is why this is
mechanical.

### Phase 7 / Task 13 — The delivery stage states it

**Delivers** `eds-deliver`'s note reporting reachability plainly, with any location it presents as
openable having been proven to answer, and any location it cannot prove marked unconfirmed and named
as such.
**Depends on** Phase 7 / Tasks 8, 12.
**You verify** on the local-target run the note says so; on the remote-target run it presents the
link as openable and the manifest shows that link was proven.
**Reject if** an unproven location is presented without its marker, or if a location that could not
be proven is quietly dropped from the note. Dropping it reads as though there were nothing to
report, which is the same failure as claiming a check that never ran.

### Phase 7 / Task 14 — The unreachable case names the remedy

**Delivers** a note that, when the verified target cannot be opened by a person, says what a person
would need to author to make it so **in terms of this project's own content** — not a generic
instruction.
**Depends on** Phase 7 / Task 13.
**You verify** a run verified against a local target only produces a note naming the specific page
or content a person would author here.
**Reject if** the pipeline publishes test content to manufacture an openable link. D87 forbids it:
the automation reports that no openable target exists, it does not create one to make its own note
look better. Also reject if the remedy is generic boilerplate that would read identically on any
project — the reason to name it at all is that a reviewer can act on it.

### Phase 7 / Task 15 — A live run of both branches

**Delivers** two real runs: one work item whose verification ran against a local target only, one
whose verification ran against a target a person can open.
**Depends on** Phase 7 / Tasks 10, 14.
**You verify** fetch both items back and read both notes — each tells the truth about its own run,
including the local-only one naming the remedy.
**Reject if** only the reachable branch is run. The unreachable branch is the one carrying the new
claim, and it is the branch a happy-path demonstration never exercises. **G86 is re-filed as
RESOLVED only after this task**, not after Task 10.

### Phase 7 / Task 16 — The core design digraph

**Delivers** `docs/implementation-plan/03-core-design.dot` updated so the `deliver` node carries the
evidence obligation and `verify`'s failure-path attach is visible.
**Depends on** Phase 7 / Task 9.
**You verify** the rendered digraph shows both, and its node set is **unchanged** — no node added,
none removed.
**Reject if** a node is added. The stage set is unchanged by this entire phase; a new node means
something in Tasks 2–9 went wider than specified.

### Phase 7 / Task 17 — Re-render the route flow page

**Delivers** `docs/agentic-core/plugin-implement-ticket-flow.html` re-rendered from that digraph,
with the dated verification note in its own header updated.
**Depends on** Phase 7 / Task 16.
**You verify** the page's stages match the digraph read side by side, and the header's date is
today's.
**Reject if** the header's dated note is left claiming a verification that was not performed in this
change. That page is rendered by hand and nothing checks it — its own header says so — so the date
is the only signal a reader has, and a stale one is worse than none.

### Phase 7 / Task 18 — The architecture page

**Delivers** `docs/agentic-core/plugin-architecture-diagram.html` showing the evidence flow: the
verification stage writes a manifest, the delivery stage reads it and reaches the tracker with it.
**Depends on** Phase 7 / Task 17.
**You verify** the flow is legible on the page without reading this file to understand it.
**Reject if** the page shows the manifest as core-owned. D86's split is the substance of the
decision, and a diagram that flattens it teaches the next reader the thing validator 7 forbids.

### Phase 7 / Task 19 — Confirm the checked digraph is untouched

**Delivers** proof that `plugins/eds/route.dot` came out of this phase byte-identical.
**Depends on** Phase 7 / Tasks 16, 17, 18.
**You verify** `git diff --exit-code plugins/eds/route.dot` reports no change.
**Reject if** it differs. That file is the artifact §13 validator 14 checks the pack's stage list
against, and this phase adds no stage — so a diff there is not a diagram question, it is evidence
that a stage was added or a condition changed somewhere in Tasks 2–9 without being noticed.

---

# Phase 8 — Fixture call site  *(new 2026-09-17, G88 · D91)*

**Why this phase exists.** An item that creates a new unit with no existing authored content
cannot reach `verified` today: `eds-verify`'s **Renderable content found?** node still routes "no"
straight to **Report fail**, and nothing invokes `eds-fixture` (G48). Found while reading PR #86,
which closed the adjacent problem of an undecorated fixture render (G87) but left this one open,
and introduced a second defect in the same node in the process (G88 — a located fixture path
discarded in favour of a rebuilt-from-`item_id` URL). Designed in
`15-fixture-call-site-spec.md`, whose §6 names the four tasks below.

*Appended after Phase 7 and before the Coverage section, following the precedent set by Phase 7
itself.* **"Phase" numbers it, it does not serialise it** — Phase 8 / Task 1 depends on nothing
and can be built before Phase 7 finishes.

### Phase 8 / Task 1 — Record the gap, the decision and the task list *(done 2026-09-17)*

**Delivers** D91 in `04-eds-pack-design.md` (§4, including §4.1's reasoning for excluding
`eds-baseline`, recorded as DECIDED, not deferred); G88 in `05-gap-register.md` (§5, with its
reproduction); an update appended to G48 in the same file naming D91 as the approved design and
Phase 8 / Task 3 as where it lands, status left OPEN; and this phase's four task entries in
`02-build-tasks.md`. Documents only, no executable change — the standing rule is that a gap or
decision entry exists before the thing is built.
**Depends on** nothing.
**You verify** `grep -c "D91" docs/implementation-plan/04-eds-pack-design.md` and
`grep -c "G88" docs/implementation-plan/05-gap-register.md` both return non-zero; `"Phase 8 / Task
4"` appears in this file; and `git status` shows no staged or unstaged changes — every file this
task touches is gitignored, so a dirty `git status` means something landed in the wrong place.
**Reject if** any file under `plugins/` or `.claude/` is modified — this task writes documents
only; G48 is marked RESOLVED — the code that resolves it does not exist yet; D91 is filed in
`03-core-design.md` instead of `04-eds-pack-design.md` — it is a platform decision; a new gap or
decision id is invented beyond G88 and D91, or either is reused; or the Phase 8 entries are
written as a flat list without Delivers / Depends on / You verify / Reject if on every task.

### Phase 8 / Task 2 — The draft URL derivation

**Delivers** an edit to `plugins/eds/skills/eds-verify/SKILL.md`'s **Render the target page**
draft branch: the URL is built from the located path's own basename with `.plain.html` stripped,
never from `item_id`, and the node states that the located path is the authority.
**Depends on** Phase 8 / Task 1.
**You verify** a fixture at `drafts/columns-demo.plain.html`, run against an item id other than
`columns-demo`, renders at `/drafts/columns-demo` through the draft server — not
`/drafts/<item_id>`.
**Reject if** the derivation still reads from `item_id` anywhere on this path, or the fix changes
behaviour for a fixture that happens to be named `<item_id>.plain.html` — that case must keep
working exactly as it does today. Closes G88.

### Phase 8 / Task 3 — The fixture fallback

**Delivers** the **Generate a fixture** node added to `eds-verify`'s `## Flow` digraph and
`## Node Details`, replacing the "no" edge of **Renderable content found?**, per D91 §4.2; the
provenance line and the `warn`-not-`pass` rule added to **Report warn** / **Report pass** per
D91 §4.3, including a new bullet under **Any check downgraded or skipped?** naming the generated
fixture as a downgrade condition; and `plugins/eds/skills/eds-fixture/SKILL.md`'s "and G48 for
what does not call it yet" replaced with a generic statement of which stage calls it.
**Depends on** Phase 8 / Tasks 1, 2.
**You verify** `validate-contracts.sh` still passes (`## Flow` nodes match `## Node Details`
headings); `eds-verify` run standalone (D17's independence rule) against an item naming a block
with no authored content anywhere in the checkout invokes `eds-fixture`, and the run's own
`verdict` is `warn`, with its report naming the target as a generated placeholder fixture.
**Reject if** a generated-fixture run reports `pass`; the provenance line is missing or does not
name the file; `eds-baseline` gains the same fallback — D91 §4.1 excludes it deliberately; or
`eds-implement` is changed to author content. Closes G48.

### Phase 8 / Task 4 — A live run

**Delivers** a run of `15-fixture-call-site-spec.md` §7's verification against a real work item
naming a block with no authored content anywhere in the checkout, on a branch containing PR #86
plus Phases 1–2, with the result recorded in this task's own `phase-8-task-4-done.md`.
**Depends on** Phase 8 / Tasks 2, 3.
**You verify** all seven checks in spec §7, in order: the fixture exists after the run and is
gitignored; the verify report names a draft-origin target and not the preview origin; that
target's `.<block>` measurement shows a `font-family` that is not the browser default serif; the
report states the target was a generated placeholder fixture; `envelope-verify.txt` carries
`verdict: warn`; no draft server is still listening after the run; and a second run against the
same item does not fail on the occupied `drafts/` path.
**Reject if** any of the seven checks fails, or the done file does not record which of the seven
were actually checked.

---

# Phase 9 — Headless execution  *(new 2026-09-19, executes D25's deferred half)*

**Why this phase exists.** D25 (2026-08-16) settled *how* a run is triggered — a config-driven
comment token, selected non-bot / contains-token / highest-id — and then deferred the half that
makes the trigger live: *"execution stays local and human-invoked for this phase. The token comment
is a signal, not a live trigger — there is no headless runner, no CI job, no hosted Claude Code
session watching for it yet... Building a real webhook-fired headless pipeline is new
infrastructure — a runner environment, secrets available outside a dev laptop, a way to serve the
preview remotely — not a tweak to an existing task, and is **explicitly deferred, not decided
against**"* (`03-core-design.md:1288-1301`). Today a human types
`/agentic-core:run-route <item id>` because nothing else can start a route at all. This phase
builds the trigger path and the runner that make the already-decided token convention fire.

*Appended after Phase 8 and before the Coverage section, following the precedent Phases 7 and 8
set.* **"Phase" numbers it, it does not serialise it** — but Task 5 genuinely depends on
Phase 6 / Task 3, because a run with no human present must run in `autonomous` mode, which D92's
flag is what provides.

**Checked against `dx-core` first, per D9 and `00-instructions.md:167`. Three of this phase's
original assumptions did not survive that check and the shape below is the corrected one.** Recorded
here because the first draft was written without the check, which is the failure D9 exists to catch:

1. **It is event-driven, not polled.** `dx-core` declares an Azure-native Service Hook —
   `plugins/dx-automation/data/pipelines/cli/ado-cli-simple.yml:52-60` carries
   `resources.webhooks` filtered on `eventType == workitem.commented`, and **every pipeline sets
   `trigger: none`**. Nothing in that repo polls. A first draft of this phase scoped a poller; the
   only argument for it was that a webhook needs an endpoint, which is not a platform constraint
   when the CI platform is the thing receiving the hook.
2. **There is no item discovery, and none is needed.** The webhook payload carries the id
   (`ado-cli-simple.yml:87`, `WEBHOOK_ID="${{ parameters.simpleHook.resource.id }}"`), with a manual
   parameter as override. **The event *is* the selection** — no query, no search, no list operation
   exists anywhere in its provider layer. The first draft's central claim, that this phase must add
   a fifth `tracker` role operation because the four contracted ones cannot discover which items
   carry the token, was true only because it had chosen polling. Following the event-driven pattern,
   **the core contract is not touched at all** and that task is gone.
3. **`disable-model-invocation: true` was never the barrier.** The flag governs *model*
   auto-triggering and is orthogonal to automated triggering: `dx-simple`, the webhook-triggered
   entry point, does not carry it, and where a flagged skill exists the pipeline invokes its
   unflagged singular sibling instead (`ado-cli-pr-review.yml:124` runs `/dx-pr-review`, not
   `/dx-pr-review-all`). What blocks us is the absence of a runner, not the flag on `run-route`.

**The one genuinely open decision, which is not this document's to settle.** `dx-core` runs its
agent with `permissionMode: "bypassPermissions"` (`data/scripts/pipeline-agent.js:293`), made safe
not by prompting but by an explicit `ALLOWED_TOOLS` allowlist alongside a fail-closed policy file.
Adopting half of that pattern — the bypass without the allowlist and policy — would be strictly
worse than not adopting it. Task 3 carries it as a decision requiring sign-off before
implementation, not as a settled design.
*Amended 2026-09-30 (G115, D106):* the premise was wrong. The vendor's SDK documentation, fetched
that day, says *"`allowed_tools` does not constrain `bypassPermissions`"* — the reference's
allowlist restricts nothing under that mode, and what makes its run safe is its policy file and
hooks alone. Decided with the human: `permissionMode: "dontAsk"` plus the allowlist, under which
the allowlist restricts and every unlisted call is denied; never bypass. Designed in
`24-runner-environment-spec.md`, built in Task 3.

### Phase 9 / Task 1 — Record the decision, the gap and this task list

**Delivers — filed 2026-09-22 as D98 and G110.** *Both ids this task originally reserved were spent
on other subjects while Phase 9 sat unstarted: D93 became the gate-checkout decision, G96 the
publish-criteria worktree defect. That is G109's failure mode; allocate at the moment of writing and
re-check, never reserve in advance.* **D98** in `03-core-design.md`, stating what a headless runner
is allowed to start without a human and what it is not; **G110** in `05-gap-register.md`, recording
that D25's trigger convention has been unexecutable since 2026-08-16 for want of a runner; an update appended to D25 naming this
phase as where its deferred half lands; an entry in `06-dx-core-deviations.md` for anything this
phase still does differently from `dx-core` **after** the corrections in this phase's own preamble
— and, where nothing differs, the explicit note that the pattern was adopted rather than deviated
from, so a later reader does not re-open a settled comparison; and these task entries (five as
written, six since Task 6 was added 2026-09-21).
Documents only, no executable change — the standing rule is that a gap or decision entry exists
before the thing is built.
**Depends on** nothing.
**You verify** `grep -c "^## D98" docs/implementation-plan/03-core-design.md` and
`grep -c "^### G110" docs/implementation-plan/05-gap-register.md` both return 1; `"Phase 9 / Task
5"` appears in this file; and `git status` shows no staged or unstaged changes — every file this
task touches is gitignored, so a dirty `git status` means something landed in the wrong place.
**Reject if** any file under `plugins/` or `.claude/` is modified; an id is invented beyond the two
the task allocates, or either is reused; D25 is rewritten in place rather than appended to — its
original deferral is the record of why this phase exists; or the decision is filed as a platform
decision in `04-eds-pack-design.md` — a headless runner names no platform (D28, D34).

### Phase 9 / Task 2 — The trigger path

**Delivers** an event-driven path from a token comment to a started run, following `dx-core`'s
pattern rather than polling: a tracker-side rule that fires on a comment event filtered by the
configured token, a CI workflow that receives it, and the work item id carried **in the event
payload** — never rediscovered by querying the tracker. Dedup on the event's own id so a redelivered
event starts no second run.
**Depends on** Phase 9 / Task 1.
**You verify** adding a comment carrying the configured token to a real work item starts exactly
one run with the right item id, with nothing typed; a comment without the token starts none; the
same event delivered twice starts one run, not two; and the runner's own notes never contain the
literal token, so a run cannot re-trigger itself.
**Reject if** anything polls the tracker on an interval — `dx-core` sets `trigger: none` on every
pipeline and the event is the selection; the item id is recovered by searching the tracker rather
than read from the payload, which would reintroduce the discovery operation this phase deliberately
does not add; the token is hardcoded rather than read from config (D25 is explicit); or the
tracker-side filter lives only in a console and is recorded nowhere a reader of this repo can find
— `dx-core`'s own equivalent lives outside its repo and was unreadable during this phase's own
research, which is the trap to avoid repeating.

### Phase 9 / Task 3 — The runner environment and its credentials

**Delivers** a documented, reproducible environment that can execute a whole route with no
interactive session — node, the project's own `serve` command, the browser pack's Chromium — and a
credential path for every pack the route resolves, injected as CI secret variables the way
`dx-core` does it (`ado-cli-simple.yml` injects its model key, tracker token and instance
credentials as pipeline secrets) rather than read from a developer's local file. The non-interactive
entry point follows `dx-core`'s: the **Claude Agent SDK**
(`data/scripts/pipeline-agent.js:23`, `@anthropic-ai/claude-agent-sdk`), invoked with a literal
prompt string naming the route and the item id — not a `claude -p`-style shell-out. Names,
explicitly and in writing, which packs **cannot** be authenticated this way today and what each
would need: the `design` pack is the known case, scoped in full as **Phase 10**. Do not re-derive
that here; this task's job is the credential path, Phase 10's is the design role's own limit.
**Depends on** Phase 9 / Task 1.
**You verify** a single stage — one that needs a real credential, such as the tracker's own
`fetch_item` — runs to a `pass` envelope inside the runner environment with no interactive login
and no file copied from a developer's machine.
**Reject if** any credential is written into a file in the repository, or into `.env` or any
`.env`-like path, by this task or by anything it builds; the environment is described only as prose
with no way to reproduce it; the entry point shells out to a non-interactive CLI rather than using
the SDK; or a pack that cannot authenticate headlessly is left unnamed, so a route discovers it at
the stage that needed it.

### Phase 9 / Task 4 — Policy rails: allowlist, rate limits, budget, break-glass

**Delivers** the limits that bound a run nobody is watching, shaped after `dx-core`'s
`data/policy/pipeline-policy.yaml` rather than invented here: a **fail-closed** allowed/forbidden
action list; **rate limits** per identity per day and per pipeline per day; a **token budget cap**;
a **break-glass** path (a label plus a named approver group, scoped to a single run); and the
turn and wall-clock caps its agent wrapper carries. Paired with the `ALLOWED_TOOLS` allowlist that
makes the permission-mode decision in this phase's preamble safe — the two are one mechanism and
neither ships without the other. *Amended 2026-09-30 (G115):* the allowlist restricts only under
`dontAsk`, which D106 chose; under bypass it restricts nothing. Task 3 ships the allowlist and the
mode; this task adds the policy file, limits and caps on top, and both rails together are the
condition for a whole route (Task 5), per D106's amendment of D98. *Amended 2026-10-01 (G116):* the
reference's policy file is read by no code, so there is nothing to adopt but the caps. The rails
are built as D107 (`27-route-policy-spec.md`), and break-glass is an approver's comment token
rather than a label, because checking a label's author would need a new tracker operation.
**Depends on** Phase 9 / Tasks 2, 3.
**You verify** an action on the forbidden list is refused with the policy file as the stated reason;
an identity over its daily limit starts no run; and a run exceeding the turn or time cap terminates
with that cap named rather than hanging.
**Reject if** the policy fails **open** when its own file is missing or unparseable — fail-closed is
the property being adopted, and a policy that degrades to permissive under a typo is worse than
none; the permission mode is relaxed without the allowlist and policy both in place; or an
in-flight-concurrency cap or kill switch is added because this task's first draft called for them
— `dx-core` has neither, using rate limits and turn/time caps for that work, and adding them needs
a named constraint of our own (D9).

### Phase 9 / Task 5 — A headless run, end to end

**Delivers** one real work item carried from a token comment to a published change with no human
action between the two, on the runner environment, recorded in this task's own
`phase-9-task-5-done.md`.
**Depends on** Phase 9 / Tasks 2, 3, 4, and Phase 6 / Task 3 — a run with no human present must
run in `autonomous` mode, which is D92's flag.
**You verify** the token is added to a real work item and nothing else is typed; the run reaches a
terminal state on its own; and the item, **fetched back from the tracker** rather than read from
local run state, carries the run's own note — including, per D87's reachability rule, a plain
statement of whether a person can open the target, which for a preview served inside the runner is
`false` and must say so rather than claim a URL a reviewer cannot reach.
**Reject if** the evidence is confirmed from `run-state.json`, the evidence manifest or the
runner's own logs rather than by fetching the item back; a question was asked and silently
defaulted rather than routing to `blocked` with the blocker written to the item (§8, autonomous
mode); or the run reached `delivered` while the target was reachable only from inside the runner
and the note claimed otherwise.

*Amended 2026-10-02 (G123, D111, D112; `30-serve-outside-sandbox-spec.md`):* on the runner the
session's sandbox ends and hides any server a command starts, so `serve` can never succeed as
written. Before the next run this task also delivers, in order:

- the workflow starts the configured preview and draft servers before *Run*, outside the sandbox,
  from the project config;
- the runner adds the preview's host to the domain list it copies;
- the readiness polls (`poll-preview.sh`, `start-draft-server.sh`) and the browser pack's launch
  send local requests through the sandbox's proxy when one is set;
- after the human confirms D112's terms reading, the secret `CLAUDE_CODE_OAUTH_TOKEN` replaces
  `ANTHROPIC_API_KEY` in *Run* and in the leak check.

**Also reject if** any server is started inside a sandboxed command, or the committed settings
file gains the preview's host.

*Amended 2026-10-06 (the human's choice; `31-plugin-marketplace-migration-spec.md` §6):* this task runs after
Phase 50 and also carries the marketplace move's CI proof: `route-trigger.yaml` runs from the checkout of
`agenticDraft/plugins@v0.2.0` (Phase 49 / Task 2), its log shows `ROUTE_PLUGIN_DIR=_plugins/plugins`, and nothing is
loaded from this repo's old `plugins/`.

### Phase 9 / Task 6 — Enforce the network allowlist at session launch  *(new 2026-09-21, G29)*

*Numbered after Task 5 because renumbering would break every reference to Tasks 1–5; it is a
**dependency** of Task 5, not a successor to it.* A headless run in `bypassPermissions` reaches any
host it likes — measured 2026-09-21 on 2.1.278, `curl https://example.com` under
`claude -p --permission-mode bypassPermissions` returned HTTP 200 while the same request from an
auto-mode session was refused in 0.003s. The committed `allowedDomains` list is advisory until the
session carries `sandbox.network.strictAllowlist`, which the vendor honors from user, managed or
CLI `--settings` settings only — never from a repository settings file.

**Nothing here is buildable before the runner exists**, and an attempt already proved it: a shell
launcher wrapping `claude --settings` was written and deleted the same day, because the runner is
an SDK host, not a CLI caller — `dx-core`'s own runner calls `query()` from
`@anthropic-ai/claude-agent-sdk` and shells nothing.

**Delivers** the policy payload every session the runner starts carries: a settings payload holding
`sandbox.network.strictAllowlist` **and nothing else** — the domain list stays in
`.claude/settings.json` where G104 put it, since a settings payload merges per key and list keys
merge across tiers — passed through the SDK's `managedSettings` option, which the reference
describes as "policy-tier settings supplied by the spawning parent process"; the `settings` option
as the fallback if the managed tier's restrictive-only merge filter rejects it; and an entry in
`06-dx-core-deviations.md`, because `dx-core` bounds a bypass run by tool allowlist alone and
enforces no network boundary at all — this is a deliberate addition, not an adopted pattern.
*Amended 2026-10-01 (G117, D108):* under `strictAllowlist` the SDK drops project settings' domains
from the allowlist, so "strictAllowlist and nothing else" would deny every host. The runner copies
the committed list into the same payload at launch, with `allowUnsandboxedCommands: false` and
`failIfUnavailable`. "Restates `allowedDomains`" below means a second *committed* list
(`28-network-allowlist-spec.md`).
**Depends on** Phase 9 / Tasks 2, 3. There is no route session to carry a policy until the runner
that starts one exists.
**You verify** by running the runner against a work item whose route needs a host that is **not**
in `allowedDomains`: the run fails with that host named, rather than reaching it. Then declare the
host and re-run: the route completes. Both halves are required — the first alone cannot distinguish
enforcement from an unrelated failure.
**Reject if** `options.sandbox.network` is used as the restriction mechanism — the field is typed,
but the SDK's own doc comment says "filesystem and network restrictions are configured via
permission rules, not via these sandbox settings" and heads its example "Configure network options
(not restrictions)", so building on it is building on a disclaimed use; the payload restates
`allowedDomains`, recreating the two-lists problem G104 removed; the flag is set in
`~/.claude/settings.json` instead, which fixes one machine and ships to no consumer project
(decided 2026-09-01); the payload ships before a runner loads it, leaving a config file nothing
reads; or the migration cost is left undocumented — a locked allowlist makes the harness **refuse
per-command domain lists**, so every host every stage touches must be declared up front, and the
first enforced run should be expected to fail on a missing one.

---

# Phase 10 — Design references without an interactive session  *(new 2026-09-19, bounds Phase 9)*

**Why this phase exists.** Phase 9 / Task 4 names the `design` pack as the one role that cannot be
authenticated headlessly. This phase is what that name points at. Read before planning against it,
because the shape is not what "the design pack needs auth" suggests from outside:

`eds-extract` does not have one design path, it has five, chosen deterministically by
`plugins/eds/skills/eds-extract/scripts/resolve-design-source.py`:

- `url` — a design-tool URL. Goes to **Resolve the design pack**, which calls
  `plugins/figma/skills/fetch-reference/`, which loads `mcp__plugin_figma_figma__*` through
  `ToolSearch` and states plainly that *"an unauthenticated connection only exposes `authenticate`
  and `complete_authentication`, never the tools above"* (`fetch-reference/SKILL.md:142-143`; was `:94-96`, moved), then
  goes to **Report fail**. **This is the one broken case.** A `fail` at `extract` is terminal, so a
  headless run on a URL-sourced item does not degrade — it dies mid-route, having already taken a
  branch and spent four stages.
- `image` — exactly one image attachment. Goes to **Download the attachment**, which reads the
  item JSON `intake` already fetched and pulls `content_url=` through the **tracker** pack, whose
  auth is `JIRA_SITE` / `JIRA_EMAIL` / `JIRA_API_TOKEN` **from the environment**. The `design` role
  is never resolved at all. **This path is already headless-viable today** — worth stating loudly,
  because it means headless design work is bounded, not blocked. It is *not* free, however: it
  carries none of the size, format and MIME validation `dx-core` applies to a ticket-attached
  image, which is Task 5.
- `ambiguous` — several images, no URL. Goes to **Report question**, which in `autonomous` mode
  `handle-question.sh` turns into `terminate-blocked` with the blocker written to the item (§8).
  Already honest headless; nothing to fix.
- `missing` — the fact record called for a design source and none was found. **Report fail**, and
  correctly so: a fact-record/reality mismatch.
- `decline` — the condition did not hold; reached only standalone.

**The obvious fix does not work, and this is the trap the phase exists to mark.** Setting
`packs.design: none` for the headless runner does *not* make a URL-sourced item degrade — it makes
it fail. `eds-extract`'s **Design pack configured?** node routes "no" straight to **Report fail**
for a `url` source. Configuring the role away changes which sentence the failure prints, not
whether the route dies.

*Appended after Phase 9 and before the Coverage section.* **"Phase" numbers it, it does not
serialise it** — Tasks 1–2 stand alone and are worth doing even if Phases 9 and 10 are never
finished, because they turn a mid-route death into an up-front refusal for the interactive case too.

### Phase 10 / Task 1 — Record the decision and the gap

**Delivers** a decision entry stating that a provider pack declares whether its operations can run
without an interactive session, and that the declaration is read from config rather than probed
live; a gap entry recording the `url`-path failure with its reproduction; an entry in
`06-dx-core-deviations.md` recording that `dx-core`'s desktop-MCP design path was checked and does
not transfer, so it is not re-derived later; and these six task entries. Documents only.
**Depends on** nothing.
**You verify** both ids resolve in their own files, `"Phase 10 / Task 6"` appears in this file, and
`git status` is clean — every file this task touches is gitignored.
**Reject if** the decision is written as a `figma`-specific rule rather than a role-level one — the
core names no product (D28, D34); an id is invented beyond the two allocated, or either is reused;
or the gap is filed as a defect in `fetch-reference` — that skill reports its own precondition
correctly and is not at fault.

### Phase 10 / Task 2 — Declare and enforce non-interactive capability *(built 2026-09-22, not merged: commit `9e5ad16` is on `phase-10-task-2-non-interactive-readiness` only, and the live `run-route` check in both modes has not run. Its done-doc is titled "BUILT, not yet live-verified" and does not count as done — found 2026-09-28)*

**Delivers** a manifest field by which a provider pack declares, per operation or per pack, that it
requires an interactive session; `plugins/figma/pack.yaml` setting it; `validate-pack-manifest.sh`
extended to accept and check the field; and the readiness gate refusing a `url`-sourced item, up
front, when the configured design pack declares it cannot run non-interactively **and** the run is
in `autonomous` mode.
**Depends on** Phase 10 / Task 1.
**You verify** in `autonomous` mode against an item whose only design source is a Figma URL, the
run ends at `readiness` with the refusal written to the work item, and `git status` shows no branch
and no file created; the same item in `interactive` mode still reaches `extract` and behaves
exactly as it does today; and `validate-pack-manifest.sh` passes for every pack in `plugins/`.
**Reject if** readiness resolves or calls the design pack to decide this — `eds-readiness/SKILL.md`
states it has no `tracker`/`scm`/`design`/`browser` role dependency, and a live probe would create
one; the refusal fires in `interactive` mode, where a human can complete the OAuth flow and the
path works; or the check is implemented inside `eds-extract`, which is four stages too late to
prevent the wasted branch.

### Phase 10 / Task 3 — Feasibility spike: a non-interactive design provider

**Delivers** a written, evidence-backed answer to one question — can a design provider return what
`design.fetch_reference` contracts (node geometry, variable/token definitions, and a reference
screenshot) using only a credential that can sit in an environment variable, rather than a
session-bound OAuth connection? — naming, for each of the three, the exact API that would supply it
or the exact reason none does. Timeboxed; ends in a recommendation to build or not build.

**`dx-core` was checked first (D9) and does not answer this — it has the same open gap.** Its own
`docs/todo/todo-pipeline.md:5-17` ("Remote Figma for CI/CD", 2026-03-03) states the MCP path does
not work headless, carries `FIGMA_PERSONAL_ACCESS_TOKEN` only as an unused placeholder in its
pipeline YAML, and lists as unresolved the same three options this spike must weigh: the REST API
with a personal access token, MCP with browser-based OAuth, and the Dev Mode API. A repo-wide
search for `api.figma.com` there returns nothing. **Start from that option list rather than a blank
page, and treat its framing as prior art to credit, not as an answer.** Note also that `dx-core`'s
own working path — the Figma *desktop app's* Dev Mode MCP on a local port, chosen precisely because
it needs no OAuth — is a local-GUI answer that is strictly less headless-viable than ours. It was
checked and does not transfer; record that so it is not re-derived.
**Depends on** Phase 10 / Task 1.
**You verify** the write-up cites a fetched, current API reference for each of the three pieces, not
recalled knowledge, and states plainly which pieces are gated by plan, licence or tier — the
variable/token half is the doubtful one and must not be reported as available without a citation.
**Reject if** the answer is "probably possible" without naming the endpoints; the screenshot and
geometry halves are confirmed while the token half is left implied; it recommends building
before establishing that the tokens `eds-conventions`' own styles subagent grades against (D20) can
actually be retrieved; or it repeats `dx-core`'s desktop-MCP approach as a candidate — that path
needs an open GUI application and was already ruled out here.

### Phase 10 / Task 4 — Build it, or record why not  *(conditional on Task 3)*

**Delivers** either a second `design` provider pack authenticating from the environment and
declaring itself non-interactive-capable per Task 2's field, registered in this project's config as
a swappable alternative; **or**, if Task 3 says no, the negative result recorded against the gap
with the specific missing capability named, and this task closed without code.
**Depends on** Phase 10 / Task 3.
**You verify** if built: `fetch_reference` returns a design-reference artifact of the same shape
the existing pack produces, invoked standalone with no interactive session and no MCP connection,
against a real design node; and swapping `packs.design` between the two packs changes no file under
`plugins/agentic-core/` (the Phase 6 / Task 4 test, applied to a provider).
**A decision this task must not take alone.** The first draft rejected any provider returning fewer
values than the operation contracts. **`dx-core` does the opposite on exactly this field:** when its
`get_variable_defs` call fails it continues without tokens and records the omission in its own
report (`references/mcp-fallback.md`) — a downgrade, not a stage failure, the same shape as G72 and
G94 elsewhere in this project. Whether `fetch_reference` may return geometry and a screenshot but no
tokens, warning rather than failing, is a contract question with a `dx-core` precedent on one side
and our own "never silently under-deliver a contracted operation" instinct on the other. Put the
difference and its cost to the user and record the outcome in `06-dx-core-deviations.md`; do not
settle it inside this task.
**Reject if** the new pack is built despite Task 3 finding a contracted piece unavailable **and**
the question above resolved against partial returns; the core changed by one line to accommodate it;
`eds-extract` gained a branch naming either pack; or a partial return ships without the report
saying plainly which of the three pieces is missing — silence is the failure mode both precedents
guard against.

### Phase 10 / Task 5 — Guard the image path that already works

**Delivers** the validation `dx-core` applies to a ticket-attached image and we do not, adapted to
our tracker: a size guard, an extension allowlist, and a check of actual MIME type and pixel
dimensions before the image is used as a design reference — plus a manifest recording, per image,
where it came from and what it is.

**Why this exists at all.** A first draft of this phase recorded that the image-attachment path is
"already headless-viable, with no new work". The first half is true; the second was written without
checking `dx-core`, which has a mature pipeline here: `skills/dx-req/SKILL.md:251-310` builds a
source/id/filename/size manifest, applies a 5 MB guard, allows `png/jpg/jpeg/gif/webp` and
**explicitly rejects `svg/bmp/tiff/heic/avif` because those formats fail the vision API**, then runs
a validation script that rejects a wrong MIME type, an oversized file, or dimensions beyond a
ceiling. The transport there is ADO-specific and does not transfer; the guard, the allowlist, the
reasoning behind it and the validation step all do.
**Depends on** Phase 10 / Task 1.
**You verify** an attached `.png` within the limits is accepted and reaches `extract` as it does
today; an attached `.svg` is refused **before** any stage tries to read it as a design reference,
with the format named as the reason; a file whose extension and actual MIME type disagree is
refused; and an oversized attachment is refused with its size stated.
**Reject if** the allowlist is written as a denylist — a new format that nobody has considered must
default to refused, not accepted; a refusal fails the whole route rather than being reported the way
an unusable design reference already is; the format rule is copied without its reason, so a later
reader loosens it not knowing what it protects; or the guard runs after the image has already been
handed to a stage.

### Phase 10 / Task 6 — A headless run with a design reference

**Delivers** one real work item carrying a design reference, carried end to end with no interactive
session, by whichever path Tasks 2–5 left viable — the image-attachment path if Task 3 said no, the
URL path if it said yes — recorded in `phase-10-task-6-done.md`.
**Depends on** Phase 10 / Tasks 2, 4, 5, and Phase 9 / Task 3.
**You verify** the run reaches a terminal state with no human action after the trigger; the item,
**fetched back from the tracker**, carries the run's note and the design-comparison evidence; and
for a run taking the image path, the done file states that it did, so the record does not read as
proof the URL path works.
**Reject if** the done file does not name which of the two paths carried the run; a URL-path run is
claimed on a session that had completed an interactive OAuth flow earlier; or the run is reported
as proving headless design support when `verify-design` was skipped.

---

# Phase 11 — The serve notice  *(new 2026-09-19, G100 · D94)*

**Why this phase exists.** Core contract §6 claimed pre-flight answers "does the serve command
exist"; nothing in `check-preflight.sh` ever read `commands.serve` or `paths.preview`, so a project
with no configured serve command learned that from the `serve` stage, four stages and one branch
into a run. The repair is deliberately half of what the sentence suggests — the declaration half,
which can be answered before `intake` — because the other half is a live probe of a local address,
which `shared/pre-flight.md` rules out and this environment's sandbox would answer wrongly.

### Phase 11 / Task 1 — Pre-flight says which preview the run will need

**Delivers** `check-serve-notice.sh` and its test suite; its call site as pre-flight's fourth item
in `check-preflight.sh`, with integration cases in that script's own suite; the contract text in
`shared/pre-flight.md`; the instruction on the pass branch of `run-route`'s **Pre-flight passed?**
node to print the
line verbatim; and D94, G100 and §6.4 filed.
**Depends on** nothing.
**You verify** `bash plugins/agentic-core/shared/lib/check-serve-notice.test.sh` and
`bash plugins/agentic-core/shared/lib/check-preflight.test.sh` both pass; a platform pack declaring
no `serve` stage produces no serve line at all; and an empty `commands.serve` exits `0` with a
`serve: warn` line, never `1`.
**Reject if** anything in the notice's path opens a socket, resolves a host, or runs the serve
command; an empty `commands.serve` blocks a run; the notice prints for a pack that declares no
`serve` stage; or the line is rewritten by `run-route` into a verdict of its own rather than
printed as it came.

### Phase 11 / Task 2 — Pre-flight says whether the audit it trusts is still current *(done 2026-09-21)*, `phase-11-task-2-done.md`

**Delivers** check (c) of `check-onboarding-gate.sh` and its six new fixtures under
`fixtures/pre-flight/onboarding/`; the third optional manifest key `audit_digest_path` in
`validate-pack-manifest.sh` (validator 15) with an accept and a reject case; its declaration in
`plugins/eds/pack.yaml`; the digest-writing node in `eds-audit-design-system`; the contract text in
`shared/pack-manifest.md` and `shared/pre-flight.md`; §6.3, §11 and §13 amended here; and G500 filed
with G501 filed beside it, unbuilt.
**Depends on** Phase 5 / Task 6 (the gate this extends).
**You verify** `bash plugins/agentic-core/shared/lib/check-onboarding-gate.test.sh` and
`bash plugins/agentic-core/shared/lib/validate-pack-manifest.test.sh` both pass; a pack declaring no
`audit_digest_path` prints no digest line at all; and, against a real project, a digest written by
the audit's own recipe reports `audit-digest: ok`, one byte appended to a file on the pack's
trusted-context list turns that into `audit-digest: warn` naming the file at exit `0`, and restoring
the file returns it to `ok`.
**Reject if** a stale digest blocks a run rather than warning; the digest's shape or a listed file's
readability is decided by the system checksum tool's exit code rather than by the check itself; the
freshness warning is reached while a `poisoning` finding is open; the core names any path the digest
lists, or learns what one means; or the gate reports a pass on a file it could not parse.

---

# Phase 12 — A reviewable rendered page per work item  *(new 2026-09-21, logged not scheduled)*

**Why this phase exists.** Observed live on EDS-6 while Phase 7 / Task 15 was in flight: a run leaves
a reviewer no rendered page they can open. The observation is correct and the current behaviour is
**not a defect** — it is what D87 and G87's fix note already settled — so this is logged as candidate
work, not filed as a gap.

**What is actually true today**, each claim checked against the source rather than inferred:

- `eds-serve`'s server is **not** torn down (`eds-serve/SKILL.md:50` — "the stage vocabulary has no
  teardown stage"), but it answers on a loopback address, which D87's condition 1 classifies
  `unreachable` with no network call. Leaving it up therefore gains a remote reviewer nothing.
- The **dedicated draft server** is per-stage by design — "started there, stopped there, before that
  stage returns" (`plugins/eds/shared/draft-server.md`). It *does* decorate; that is its purpose.
- What does not decorate is the draft path fetched through the *regular* preview origin, because
  `aem up` mounts `drafts/` only when `--html-folder` is passed — confirmed by reading
  `@adobe/aem-cli`'s own source (`src/up.js`, `src/server/HelixServer.js`), recorded in
  `draft-server.md`. A platform-pack flag question, not a core one.
- The only rendered artifact that survives a run is the captures Phase 7 attaches to the work item.
  That is Phase 7 working as designed, not a shortfall of it.

**The constraint that bounds every task below.** D87 (`03-core-design.md:3220`): the pipeline
"does not publish test content to manufacture a link." A task here that makes a link exist so the
note can cite one has inverted the decision. If real content is ever published, it is because it is
the deliverable, never because an openable URL was wanted.

**Why it is unscheduled.** G87's fix note records the standing call — fixture-based testing "rather
than wire real DA-page authoring into the automated route." Changing that is a user decision, and
Task 1 is where it gets made or declined. This phase names no platform in its core-facing half; the
`drafts/` and `aem up` questions belong to the eds pack (D28, D34).

### Phase 12 / Task 1 — Record the question and decide whether it should exist

**Delivers** the question filed as a decision record with its three candidate shapes stated and one
chosen: **(a)** status quo — attached captures are the evidence, and this phase closes unbuilt;
**(b)** expose a decorated draft render at an address a reviewer can reach; **(c)** publish real
authored content as a deliverable in its own right. Plus the standing note that D87 forbids (b) and
(c) being adopted *in order to* make a note's link look better.
**Depends on** nothing. Phase 7 / Task 15 must be finished first — not as a dependency, but because
that run is what tells you whether the attached captures are in practice enough.
**You verify** the record names which shape was chosen, and the two rejected shapes carry the reason
they were rejected rather than being dropped.
**Reject if** the record asserts a defect in the current pipeline. The current behaviour implements
D87; a record that reads as a bug report will license a later reader to "fix" what was decided.

### Phase 12 / Task 2 — Establish what the platform can actually serve  *(conditional on Task 1 choosing (b))*

**Delivers** a measured answer, not a read one, to whether `commands.serve` can mount `drafts/`
decorated for the life of a route — `--html-folder drafts` appended, or `npm run up:draft`, whichever
this project's configuration makes correct — and what that costs the `serve` stage's own contract.
**Depends on** Phase 12 / Task 1.
**You verify** a real `aem up` invocation with the flag serves a decorated `drafts/` page, confirmed
by a `browser` role `render` returning success and a `capture` showing decoration applied — not by
reading the CLI's source a second time.
**Reject if** the answer rests on `draft-server.md`'s existing source reading alone. That reading
established which flag mounts the folder; it did not establish that a route-lifetime mount is
workable, and those are different questions.

### Phase 12 / Task 3 — Build the chosen shape  *(conditional on Task 1 and Task 2)*

**Delivers** whatever Task 1 chose, scoped to the eds pack, with `target_reachable` continuing to be
decided by Phase 7 / Task 11's script and never by the existence of this new address.
**Depends on** Phase 12 / Tasks 1, 2.
**You verify** the reachability field's value still traces to the script's own outcome in the same
run, for the new address as for any other.
**Reject if** any stage infers reachability from the fact that this phase built the target. That is
D87's central prohibition arriving by a new route: a location this pipeline created is not thereby a
location it has proven answers.

### Phase 12 / Task 4 — A reviewer opens it

**Delivers** one real work item carried through the route, whose note carries a location a person
who did not run the pipeline opens successfully on a machine that never ran it.
**Depends on** Phase 12 / Task 3.
**You verify** fetch the item back, read the note's location off the fetched JSON, open it from a
context with no access to the run's own machine, and confirm the rendered page shows the change.
**Reject if** the location is confirmed from the machine that produced it. Local confirmation is the
exact claim D87 exists to distinguish from a real one, and it is the failure this whole phase would
otherwise have reintroduced at its last step.

---

## Coverage

- **Phase 2** — spec §§1–13, and decisions D1, D2, D4–D6, D9, D11–D14, D16, D17, D19, D23, D25,
  D26, D28, D33–D41, D49, D50.
- **Phase 3** — spec §6 and D35.
- **Phase 4** — spec §11 and D27, D34; the third-party skills adopted in D27 are called from
  adapters, never re-authored (D29).
- **Phase 5** — G21, G22, G26, G63, and D20–D24 plus D80: D20/D21 in Tasks 1–2, D22's merged-change
  boundary at both ends in Tasks 1 and 5, D23's four-class taxonomy in Tasks 3–4 and its poisoning
  gate in Task 6, D24's token source in Task 1 (and its unverified residual as that task's step 0),
  D80's pre-flight amendment in Task 6. *Coverage line corrected 2026-09-14 during the
  decomposition — D23 and G22/G26 were already cited by these tasks and were missing here.*
- **Phase 6** — the three terminal states as a test matrix, plus the swappability claim.
- **Phase 7** — G86 and D86, D87, D88, plus the two standing deviations they created: D86's
  core/pack ownership split in Tasks 2–8, D87's reachability rule in Tasks 11–15, D88's manifest
  path and both writers in Tasks 5–9. Adds no stage and no core-owned artifact; Task 19 is the
  check that it did not.

- **Phase 9** — D25's deferred execution half (`03-core-design.md:1288-1301`) and D9, which is what
  caught the first draft: written without checking `dx-core`, it scoped a poller, a new `tracker`
  role operation to support it, and rails `dx-core` does not have. Corrected to the event-driven
  pattern, it **touches the core contract nowhere** and adds no stage and no role. The surviving
  open decision is the agent's permission mode, carried in the phase preamble and Task 4.

- **Phase 10** — bounds Phase 9 / Task 3 rather than extending the core: one manifest field and one
  readiness refusal (Task 2), a feasibility spike whose question `dx-core` has open too (Task 3), a
  provider that may or may not be built on its evidence (Task 4), and the image-path validation
  adopted from `dx-core` (Task 5). Adds no stage, no role and no core-owned artifact; Task 4's own
  reject condition is the check that it did not. Carries one contract question for the user:
  whether `fetch_reference` may return partial values with a warning, as `dx-core` does.

**Not covered here, deliberately:** publishing the plugins to a marketplace. That happens after
Phase 6 / Task 4, because Phase 6 / Task 4 is what decides whether the boundary is real.
Extracting a boundary that has not carried traffic invents seams in the wrong places — the same
reason the original plan gave, and the reason it still holds.

## Open items blocking no task yet

**Two** values remain unchosen: `questions_per_run` and `fix_attempts_default`. Each is to be
settled from a real run. Phase 2 / Tasks 12 and 9 should therefore read them from config rather
than hardcoding, so Phase 6 / Task 1 can be used to choose them.

*The third — the stage-vocabulary question — was closed 2026-09-06 by D42:* fixed neutral
vocabulary, fifteen ids, packs implement or decline but never extend. It was decided before a run
existed, against D40's own rule, deliberately and for a stated reason — §13 validators 1, 2, 12, 13
and 14 all depend on the list being closed, and waiting would have left five checks unbuildable
through Phases 3 and 4. See §14 item 1.

# Phase 13 — The tracker role's authoring write  *(new 2026-09-22, G112 · D102, designed in `20-tracker-write-spec.md`) — **COMPLETE 2026-09-22**, record in `phase-13-done.md`*

**Why this phase exists.** `write-specs` proves a draft conforms and stops, because D90 forbids it
to write. The run it prepares that draft for fetches the **item**, never the draft file, so a
conforming draft and an item nobody pasted it into produce identical evidence and mean opposite
things (G112). D90 named its own exit — a contracted write operation — and this phase builds it:
`create_item` and `update_item` on the `tracker` role, over the tracker's own API rather than
through a tool server, because a role operation is invoked as a script and a script cannot reach
one. The authoring skill's hand-over is not deleted; it becomes the named path taken when a pack
declines the operation or the write fails.

The spec's four phase headings name the task ranges below: its Phase 1 is Tasks 1–2, Phase 2 is
Tasks 3–6, Phase 3 is Tasks 7–10, Phase 4 is Tasks 11–13.

### Phase 13 / Task 1 — Prove the transport before designing on it *(done 2026-09-22)*

**Delivers** the measurements in `20-tracker-write-spec.md` §4.3 and §4.4.
**Depends on** nothing.
**You verify** the spec records real HTTP codes and a real node count, taken from runs rather than
assumed.
**Reject if** any figure in §4.3 or §4.4 is reasoned rather than measured, or the throwaway item
the probe created is left in the tracker.

### Phase 13 / Task 2 — Stop the tree contradicting D90 *(done 2026-09-22)*

**Delivers** `.claude/skills/write-specs/SKILL.md` restored to its committed shape.
**Depends on** nothing.
**You verify** `git diff --quiet .claude/skills/write-specs/SKILL.md` is clean and
`bash .claude/skills/write-specs/scripts/check-spec.test.sh` passes.
**Reject if** the skill still performs a tracker write while D90 stands, or the revert was done by
disabling the sandbox rather than through the editing tool.

### Phase 13 / Tasks 3–6 — The contract, both operation lists, and the manifest *(done 2026-09-22)*

**Delivers** the two `tracker` rows in `01-core-contracts.md` §6 with the no-stage-consumer note;
the extended list in `validate-pack-manifest.sh` and in `generate-provider-pack.sh`; five updated
tracker fixtures plus the `provider-valid` fixture; three new validator cases — implements them,
names a skill that does not exist, says nothing about them; `unsupported: [create_item,
update_item]` in `plugins/jira/pack.yaml`; and D102 and G112 filed.
**Depends on** Task 1.
**You verify** `bash plugins/agentic-core/shared/lib/validate-pack-manifest.test.sh` and
`bash plugins/agentic-core/shared/lib/generate-provider-pack.test.sh` both pass, the latter
including its drift case proving the two hardcoded lists still agree; and
`bash plugins/agentic-core/shared/lib/validate-naming-rule.sh plugins/agentic-core/` exits 0.
**Reject if** these arrive as more than one commit — the completeness check fails every tracker
pack in between; if `plugins/jira/pack.yaml` names a skill Phase 13 / Tasks 7–10 has not built
yet; or if the two hardcoded lists are made to share one source at run time, which the generator's
own comment forbids.

### Phase 13 / Tasks 7–10 — The provider skills *(done 2026-09-22, PRs #130, #131, #132)*

**Delivers** the markdown-to-storage-format converter and its tests; `update-item/` and
`create-item/`, each moving its operation from `unsupported:` to `operations:` in the same commit
that creates it; and the artifact carrying the key the tracker assigns.
**Depends on** Tasks 3–6.
**You verify** the converter's tests assert on the authoring checker's own output — a criterion
count — not on the structure it emitted; and a real item written through both operations passes
`check-spec.py <ITEM-KEY>`.
**Reject if** the converter reflows the acceptance-criteria block, if either skill ships narrative
or names a gitignored path, or if a skill is added without its operation moving across in the same
commit.

### Phase 13 / Tasks 11–13 — The call site *(done 2026-09-22, PR #134)*

**Delivers** `write-specs` resolving and running the operation through the pack manifest; the
degraded path when a pack declines it or the write fails; the rewritten skill flow; the amendment
to `13-write-specs-spec.md` §5; and the platform decision superseding D90.
**Depends on** Tasks 7–10.
**You verify** the skill names no tracker and no tool server anywhere in its own text; a pack
declaring the operation unsupported produces the hand-over rather than an error; and the checker is
re-run against the live key after every write.
**Reject if** D90 is deleted rather than superseded, if the degraded path is silent, or if the
skill decides create-versus-update from the key it was given instead of from a fetch.

---

# Phase 14 — A design provider that will not answer  *(new 2026-09-23, G504 · G505 · D500 · D501, designed in `21-design-fallback-spec.md`)*

**Why this phase exists.** `EDS-13` died at stage 3 of 14 because a third-party quota window
closed. Nothing was wrong with the work item, the repository or the design, and the eleven stages
after `extract` never ran. The chain that produced it is working as written, so it needs a design
change rather than a bug fix: `fetch-reference` has no degraded outcome to emit, `eds-extract`
turns any provider `fail` into its own, and §10 takes that to terminal `failed`. This phase gives a
stage the vocabulary to say *which kind* of failure it hit (D500, closing the two-year-old dangling
pointer G59 left), and gives `eds-extract` somewhere to go when the answer is "the provider, not
the reference" (D501).

The spec's three phase headings name the task ranges below: its Phase 1 is Tasks 1–2, Phase 2 is
Tasks 3–4, Phase 3 is Task 5. Its own filing step is already done — D500, D501, G504 and G505 were
filed 2026-09-23, the deviation is in `06-dx-core-deviations.md`, and the numbering checker reports
`valid`.

**One thing this phase must settle before Task 1 is written.** `21-design-fallback-spec.md` §5.3
asks `VALIDATION` to mean "the reference this item named is wrong", which is not what
`03-core-design.md:643` defines it as — that definition is the class with a bounded auto-fix loop,
and a bad design URL has no such loop. Either `VALIDATION` widens, or the fallback keys off a
`TRANSIENT`/`PERMANENT` allowlist and a bad reference becomes `PERMANENT`. Task 1 writes whichever
was chosen into the shipped file; it does not get to leave the question open.

### Phase 14 / Task 1 — The error-class taxonomy becomes a shipped contract

**Delivers** `plugins/agentic-core/shared/error-handling.md` — the three classes as
`03-core-design.md:641-648` defines them, D89's rule that TRANSIENT exhaustion raises
`verdict: question` rather than a bare `fail`, and the report shape a stage emits when it escalates.
Repoints `01-core-contracts.md:160`. Closes G59.
**Depends on** the `VALIDATION` question above being answered.
**You verify** `check-no-narrative.test.sh` passes with the new file present, and
`grep -c "docs/implementation-plan" plugins/agentic-core/shared/error-handling.md` prints `0`.
**Reject if** the file cites a gitignored path, carries a rationale section or a per-file
attribution line; if §8 gains error classes instead of the pointer being repointed; or if the
`VALIDATION` question is restated in the shipped file rather than answered.

### Phase 14 / Task 2 — `error_class` becomes an envelope field

**Delivers** `error_class: TRANSIENT | VALIDATION | PERMANENT` in §3, valid only with
`verdict: fail` or `verdict: question`; the enum check in `validate-result-envelope.sh`; its test;
and `fetch-reference` emitting it on every **Report fail** path.
**Depends on** Task 1.
**You verify** `validate-result-envelope.test.sh` passes, and rejects both an unknown class and the
field appearing with `verdict: pass`.
**Reject if** the class is carried in `metrics` instead; if the validator accepts a class it does
not know; or if `fetch-reference` emits the field on some fail paths and not others.

### Phase 14 / Task 3 — The resolver reports a fallback it currently hides

**Delivers** `resolve-design-source.py` continuing its attachment scan on the `url` decision and
appending `fallback_image=`, `fallback_url=`, `fallback_mime=` when exactly one image attachment
exists; plus `resolve-design-source.test.sh`, the first test these scripts have.
**Depends on** nothing — it is independent of Tasks 1 and 2 and may run in parallel.
**You verify** the test covers URL with one attachment, URL with none, URL with several, and every
existing decision unchanged; and the script still prints exactly one `decision=` line and exits 0
for every decision.
**Reject if** several attachments produce a guess rather than an unchanged `url` line; if the
script gains a second output line; or if it ships without the test.

### Phase 14 / Task 4 — `eds-extract` has somewhere to go

**Delivers** the four edges of `21-design-fallback-spec.md` §5.3 replacing today's single
`fail` → **Report fail** edge, and the `warn` reporting node of §5.4 carrying
`metrics: fallback=attachment`. The DOT digraph and the matching node headings change together.
**Depends on** Tasks 2 and 3.
**You verify** a provider `fail` with a substitutable class and one attachment reaches
**Download the attachment**; a `VALIDATION`-class failure still reaches **Report fail**; and a
TRANSIENT failure with no attachment reaches **Report question** with a blocker naming what a human
can do.
**Reject if** the fallback reports `pass`; if the core gains a stage id, verdict or condition for
it; if any of this reaches a file outside the `eds` pack; or if the digraph and the node headings
disagree.

### Phase 14 / Task 5 — Prove it on the run that failed

**Delivers** `EDS-13` re-run with a reference image attached, reaching a terminal state other than
`failed` while the design provider is still refusing.
**Depends on** Task 4.
**You verify** the run's own record shows `warn` at `extract` with `fallback=attachment`, and that
a later stage consumed the image reference rather than skipping the design comparison entirely.
**Reject if** the provider failure was allowed to resolve itself rather than being reproduced or
forced, and the done file does not say which of the two happened.

### Phase 14 / Task 6 — The route stops checking out its own code from under itself  *(new 2026-09-23, G507 · D503)*

**Delivers** `create-branch.sh` resolving its base from the caller's current `HEAD` except on the
repository's default branch, where `origin/<default>` stays; plus `create-branch.test.sh`, the
first test this script has.
**Depends on** nothing. Independent of Tasks 2-4, and **Task 5 depends on it** — Task 5 exercises
unmerged pack changes against a real run, which is precisely what this defect destroys.
**You verify** a run started on a feature branch keeps that branch's commits through
`create_branch`; a run started on the default branch still bases on `origin/<default>`, preserving
the stale-local-default rule; and an explicit `base` argument still wins.
**Reject if** the fix bases on a local default branch, re-opening the 2026-09-03 stale-base
incident; if a detached `HEAD` loses work; or if it ships without the test.

### Phase 14 / Task 7 — A design reference declares itself by name  *(new 2026-09-23, G506 · D504)*

**Delivers** `resolve-design-source.py` resolving an image design reference **only** from an
attachment named `design-reference.png`, `design-reference.jpg` or `design-reference.jpeg`
(case-insensitive, whole filename); the matching test cases; and `eds-extract`'s two `question`
blockers naming that filename as the action that unblocks the run. Closes G506.
**Depends on** Task 3 (the `fallback_*` fields this narrows) and Task 4 (the **Fallback available?**
node whose blocker text changes). Independent of Task 5.
**You verify** the test covers, with and without a design URL present: a reserved name among
several images; a reserved name alone; a case-different spelling; several images none reserved;
exactly one image not reserved; two reserved names at once; and no images. Every decision still
prints exactly one `decision=` line and exits 0.
**Reject if** a single unmarked image is treated as the reference; if an unresolvable image set
overrides a design URL; if the convention is documented in any shipped file but the blocker text;
if a new `decision=` literal is introduced; or if it ships without tests.

### Phase 14 / Task 8 — A captured envelope is reduced by a script before it is judged  *(new 2026-09-23, G508 · D505)*

**Delivers** `plugins/agentic-core/shared/lib/capture-envelope.sh` — drops everything above the
last `## Result` heading, removes blank lines between that heading and a `verdict:` line, repairs
nothing else, and reports every reduction; `capture-envelope.test.sh`; and `run-route` running it
on every captured envelope, `intake` included, before validation.
**Depends on** nothing. Found executing Task 5, which it unblocks.
**You verify** a conformant envelope is byte-identical afterwards; a blank line between heading and
`verdict:` is removed and the validator then accepts what it rejected; a first line that is *not* a
`verdict:` line is left untouched; a heading quoted in prose does not win over the block at the end;
the script is idempotent; and no `## Result` heading at all exits 1 rather than being repaired.
**Reject if** it repairs any shape other than the two named; if a reduction is applied silently;
if it picks the first `## Result` rather than the last; if `run-route` runs it on some capture paths
and not others; or if it ships without tests.

### Phase 14 / Task 9 — A stage writes its envelope to a file instead of into its last message  *(new 2026-09-23, G509 · D506)*

**Delivers** `emit-envelope.sh` (values in, contract-ordered block out, refuses any field the
contract forbids on the verdict given and writes nothing when it refuses) and `reset-envelope.sh`;
their tests; the `## How a stage writes it` section in `shared/result-envelope.md`; `run-route`
resetting the file before each stage, taking a non-empty file as the stage's own envelope, and
capturing from the output only when it is empty; and `eds-extract` and `eds-prototype` adopting the
emitter in every one of their reporting nodes.
**Depends on** Task 8, whose reduction stays for stages that have not adopted the emitter.
**You verify** each verdict emits the exact contract-ordered block and passes the real validator;
`artifacts: []` on no artifacts; every forbidden field/verdict pairing is refused with the target
file untouched; a summary over 200 characters or containing a line break is refused; `reset` empties
an existing file and creates a missing one; and an emitted envelope passes `capture-envelope.sh`
reporting `unchanged`.
**Reject if** a refused request writes anything; if the emitter accepts a field the contract
forbids on that verdict; if the driver transcribes over a file the stage wrote; if the reset step is
skipped, making a previous run's envelope readable as this one's; or if it ships without tests.

# Phase 15 — A run that finishes without a human  *(new 2026-09-24, G46 · D507, designed in `22-branch-ownership-spec.md`)*

**Why this phase exists.** The 2026-09-23 EDS-13 run completed thirteen stages and stopped at
`deliver` because the working tree was on `main` and no task branch existed. A human made one and
the run resumed to `delivered`. G46 named that gap on 2026-09-10 and it has been `OPEN, not
blocking` since; it is now the single thing between a run that needs a human and one that does not.
Phase 9 / Task 2 builds an event-driven trigger, and a triggered run would do thirteen stages
unattended and stop here — so this phase comes first.

### Phase 15 / Task 1 — `scm.create_branch` becomes an ensure

**Delivers** `create-branch.sh` treating an existing branch as an outcome —
`metrics: branch_action=created|existing|switched` — resolving local before remote, and reporting
`question` with nothing moved when the existing branch does not contain the caller's `HEAD`;
plus the matching cases in `create-branch.test.sh`.
**Depends on** nothing.
**You verify** already-on-the-branch reports `existing` and moves nothing; a local branch containing
`HEAD` is switched onto with its work present; an origin-only branch becomes a local tracking
branch; a new name still reports `created`; a branch missing commits `HEAD` has reports `question`
with `HEAD` unmoved and the caller still on its original branch; and that question envelope passes
`validate-result-envelope.sh`.
**Reject if** an existing branch still reports `fail`; if the stale case moves the working tree or
reports anything but `question`; if `branch_action` is carried anywhere but `metrics`; or if it
ships without tests.

### Phase 15 / Task 2 — The driver owns the branch step

**Delivers** core contract §4 naming the driver as `create_branch`'s owner; `run-route` invoking the
`scm` role's operation immediately after `readiness` returns continue; the branch name derived from
the fact record's `item_id` by a script rather than chosen; and the resulting name recorded to
`.ai/run-context/branch.txt` so a resume and `deliver` agree on it.
**Depends on** Task 1.
**You verify** a run started on the default branch is on a task branch before `extract`; a resumed
run lands on the same branch rather than a second one; `branch.txt` names it; and the name is
derived deterministically from `item_id`.
**Reject if** the branch name is chosen by a model rather than derived; if a platform pack gains
`scm` knowledge; if a sixteenth stage id is introduced; or if the recorded name and the checked-out
branch can disagree.

### Phase 15 / Task 3 — `eds-deliver` refuses the default branch

**Delivers** the **A branch is checked out?** node gaining an edge for "current branch is the
repository's default branch" → **Report question**, with a blocker naming the branch that should
have been created; and `eds-deliver` adopting `emit-envelope.sh` in every reporting node so it can
say that in a contracted form rather than in prose.
**Depends on** nothing to build, but **uses Task 2's `branch.txt`** when it is there — the design
turned out better coupled than the first draft of this entry claimed. Its first check reads that
artifact; its second, the plain-git `refs/remotes/origin/HEAD` check, is what makes it still work
without Task 2. Kept after them deliberately: a guard whose only proof is that an earlier step ran
is not a guard.
**You verify** `deliver` on the default branch reports `question` and commits nothing; on a task
branch it behaves exactly as before; and every one of its reporting nodes calls the emitter.
**Reject if** it commits or pushes anything on the default branch; or if any reporting node still
formats the envelope by hand.
***Superseded in part by Task 4, 2026-09-24.*** This entry originally read "Reject if it reports
`fail` instead of `question`". That was wrong: `deliver` is the last stage, so the question protocol
has no next stage to hand an answer to and a `question` here is unanswerable. The `Report question`
node this task added was removed again by Task 4. The guard itself — refusing a branch the run does
not own — was right and stands.

### Phase 15 / Task 4 — `eds-deliver` repairs its own branch precondition instead of asking  *(new 2026-09-24, G512 · D508)*

**Delivers** `eds-deliver`'s `Report question` node replaced by **Ensure this run's own branch** and
**Branch repaired?**: the name taken from `branch.txt` or derived from `item_id`, the `scm` role's
idempotent `create_branch` invoked, the name written back, and the repair recorded as a downgrade so
the run ends `warn`. `create_branch` read at pack resolution but not required there.
**Depends on** Tasks 1 and 2 (the idempotent operation and the name derivation it reuses), and
corrects Task 3.
**You verify** the stage emits no `question` on any path; a run reaching `deliver` on the default
branch ends `warn` with the branch it created named in the summary; the operation's own `question`
(an existing branch not containing `HEAD`) becomes `fail` relaying that blocker; and an absent
`create_branch` fails on the repair path only, not at pack resolution.
**Reject if** `deliver` can still emit `question`; if a repaired run reports `pass`, hiding that its
precondition was repaired; if it commits on a branch the run does not own; or if a missing
`create_branch` fails a run that never needed the repair.

### Phase 15 / Task 5 — The driver refuses to run on stale instructions  *(new 2026-09-24, G511 · D509)*

**Delivers** `instructions-stamp.sh` (verify a file against its own embedded stamp, `--write` to
regenerate, idempotent); its test suite, including a guard asserting the shipped
`run-route/SKILL.md` verifies; that stamp on the driver's last line; the driver's first step
comparing the on-disk stamp against the one it is holding and refusing to start on a mismatch; and
the suite wired into CI alongside three Phase 14/15 suites that were never added.
**Depends on** nothing.
**You verify** an edited file with a stale stamp exits 1 naming `--write`; `--write` is idempotent;
identical bodies stamp identically and a changed body does not; a tampered stamp value is caught;
and the shipped driver file verifies.
**Reject if** the driver regenerates its own stamp; if refusing is modelled as a fourth terminal
state; if the stamp covers its own line; or if it ships without the CI wiring, which is what makes
a forgotten regeneration fail review rather than every later run.

### Phase 15 / Task 6 — The stamp check moves inside the flow  *(new 2026-09-24, G511 · D509)*

**Delivers** the instructions-stamp precondition moved out of `run-route/SKILL.md`'s preamble and
into **Resolve pre-flight**, the first node the flow reaches, as its step 1; the stamp regenerated.
**Depends on** Task 5.
**Why.** Two EDS-7 runs did not execute the branch step, and neither reported running the stamp
check that should have refused to start on stale instructions. The branch step is a node; the stamp
check was not. An instruction placed above the flow is one a reader following the flow can pass over
without ever deciding to skip it — so the check that exists to catch a silent skip could itself be
silently skipped.
**You verify** `run-route/SKILL.md` carries no `## Before anything else` section; the stamp
invocation appears inside **Resolve pre-flight**; `instructions-stamp.test.sh` passes including its
guard on the shipped file; and the contract checker still reports the digraph and node headings
agreeing.
**Reject if** the check ends up anywhere the flow can reach without passing through it; if refusing
becomes a fourth terminal state; or if the stamp is not regenerated, which would make every run
refuse to start.
# Phase 16 — The stage that asked gets the answer  *(new 2026-09-24, G513 · D511)*

**Why this phase exists.** EDS-18 stopped at `verify-design` because `prototype` asked which block to
target, the answer was handed forward to the next stage, and nothing ever built the prototype. The
question protocol routed every answer to a stage that did not ask it.

### Phase 16 / Task 1 — Core contract §8 re-invokes the asking stage

**Delivers** §8 amended: the asking stage is re-invoked once with the answer, recorded only after
that returns, and a second question from it is handled like any other; §12's `question-answer` row at
1.1 with a `stage` field; D511 and G513 filed.
**Depends on** nothing.
**You verify** §8 no longer says no stage is re-invoked; the registry row names three fields; the
numbering check passes.
**Reject if** the budget stops applying to a re-invoked stage's question; or if re-invocation is
described as a retry.

### Phase 16 / Task 2 — `question-protocol.md` matches the contract

**Delivers** the shared protocol and the shipped artifact registry (`artifact-registry.md`, `.yaml`)
describing re-invocation, the `stage` field, and when the asking stage is recorded; its
anti-patterns inverted.
**Depends on** Task 1.
**You verify** no shipped file still says an answer reaches the next stage; `check-no-narrative.sh`
and `validate-artifact-registry.sh` pass.
**Reject if** the protocol restates §8 rather than defining the decision.

### Phase 16 / Task 3 — Which stage runs next is a script's answer

**Delivers** `handle-question.sh` printing `next_stage: <asking stage>` on `ask` and nothing of the
kind on a terminal decision; `write-question-answer.sh` taking the stage id; a new
`read-question-answer.sh` returning the answer only to the stage it belongs to. Tests first.
**Depends on** Task 2.
**You verify** each suite fails before the change and passes after it.
**Reject if** a terminal decision names a next stage; or if ownership is decided anywhere but the
script.

### Phase 16 / Task 4 — The driver re-invokes the asking stage

**Delivers** `run-route/SKILL.md`: **Ask human, record answer** writes the answer with the stage id
and goes to a new **Re-invoke the asking stage** node, which re-enters the branch step or the
adapter invocation for `next_stage`; the stamp regenerated with `instructions-stamp.sh --write`.
Edited through `skill-creator`.
**Depends on** Task 3.
**You verify** the flow's digraph and node headings agree (`validate-contracts.sh`); the stamp
verifies; no edge from the answer node leads to **Record stage, refresh flag**.
**Reject if** the asking stage is recorded before its re-invocation returns.

### Phase 16 / Task 5 — `eds-prototype` uses an answer addressed to it

**Delivers** **Target block identified?** reading the answer through `read-question-answer.sh`
before the fact-record fields, and taking the block name from it. Edited through `skill-creator`.
**Depends on** Task 3.
**You verify** EDS-18's recorded answer `blocks/table/ (new block)` resolves to `table`; an answer
addressed to another stage is ignored.
**Reject if** the stage acts on an answer whose `stage` is not `prototype`.

### Phase 16 / Task 6 — Verification

**Delivers** nothing new. Runs every `*.test.sh` under `plugins/agentic-core/shared/lib`, plus
`validate-contracts.sh`.
**Depends on** Tasks 1–5.
**You verify** every suite exits 0.
**Reject if** any suite is skipped or reported without being run.

# Phase 17 — A fix attempt is an edit  *(new 2026-09-25, G514 · D512)*

**Why this phase exists.** EDS-18's second run failed at `verify-design` with the fix already named in
its own report and no edit left to apply it. D19 grants two edits; the stage made one, because it
counts comparisons rather than edits and restates its cap in prose instead of reading the pack. The
unit of `fix_attempts` was never defined, and the three stages that use it read it two ways.

### Phase 17 / Task 1 — Core contract §7 defines the unit

**Delivers** §7: one fix attempt is one edit; `fix_attempts: N` allows up to N edits and N+1 checks;
the stage asks a script rather than counting. §4's `verify-design` line points at the pack value
instead of restating "max 2".
**Depends on** nothing.
**You verify** §7 names the unit and the N+1 checks; no line in §4 restates a numeric cap.
**Reject if** the unit is left to each stage's reading.

### Phase 17 / Task 2 — The budget is a script's answer

**Delivers** `plugins/agentic-core/shared/lib/check-fix-budget.sh <pack.yaml> <project-config.yaml>
<stage id> <edits-made>` *(project config added while building: the default lives there)* → `decision: edit` (exit 0) or `decision: exhausted` (exit 4), reading the stage's
`fix_attempts`, falling back to `limits.fix_attempts_default`; the loop rule in a shared contract the
stages reference. Tests first.
**Depends on** Task 1.
**You verify** `fix_attempts: 2` answers `edit` at 0 and 1 edits and `exhausted` at 2; a stage with
no value uses the default; a malformed count is a contract violation.
**Reject if** "no improvement" is moved into the script — it compares prose mismatch lists and stays
the stage's judgment.

### Phase 17 / Task 3 — `eds-verify-design` spends two edits, on causes

**Delivers** **Attempts exhausted or no improvement?** asking `check-fix-budget.sh`; **Edit the
block's CSS and JS** grouping mismatches by cause, editing each cause once, and leaving any mismatch
another edit in the same round is expected to change for the next check; the report listing, per
round, what was edited and which mismatch each edit answered. Edited through `skill-creator`.
**Depends on** Task 2.
**You verify** the flow reaches a third comparison after two edits; no prose in the file restates a
numeric cap; `validate-contracts.sh` agrees the digraph and headings.
**Reject if** the stage still ends after its second comparison; or if "causes, not symptoms" is
written as one edit per round.

### Phase 17 / Task 4 — `eds-lint` and `eds-plan` read the same unit

**Delivers** both stages asking `check-fix-budget.sh`. `lint` goes from 2 edits to 3 at its unchanged
value (D512, accepted); `plan` keeps 1 edit. Edited through `skill-creator`.
**Depends on** Task 2.
**You verify** `lint`'s flow allows a fourth run after three edits; `plan`'s behaviour is unchanged.
**Reject if** either stage keeps a hand-counted cap.

### Phase 17 / Task 5 — Verification

**Delivers** nothing new. Runs every `*.test.sh` under `plugins/agentic-core/shared/lib`,
`validate-contracts.sh plugins`, `check-no-narrative.sh plugins`, and `check-exec-bits.sh plugins`;
then re-runs EDS-18 from a fresh session after merge, with the design provider authenticated.
**Depends on** Tasks 1–4.
**You verify** every suite exits 0, and the re-run's `verify-design-report.md` shows up to two edit
rounds with three comparisons.
**Reject if** any suite is skipped or reported without being run, or the live run is claimed from a
session that edited the stages.
**Met 2026-10-05 (the human, AskUserQuestion; `eds-24-gaps-prep-done.md`).** Read as a ceiling: "up to
two" edit rounds, a third comparison only after a second edit, so a loop that stops on "nothing
fixable" satisfies it, and the EDS-24 runs stand in for the EDS-18 named above. Suites: 122 run, 0
failed (`phase-43-task-4-done.md:113-117`). Live: EDS-24 delivered run, 1 edit and 2 comparisons,
`.ai/run-context/verify-design-report.md:84` "Loop end: nothing fixable"; same on the failed EDS-24 run
and EDS-18 run B. The only run showing two edits and three comparisons is EDS-18 of 2026-09-28
(`.ai/logs/run-context-2026-09-28-1922/verify-design-report.md:48`, "Budget exhausted after
`edits-made: 2`"), started 12:15:45Z, after Phase 17 merged (`2a0d174`, 2026-09-25 11:10Z); whether it
ran from a fresh session is not verified. G514 closed on this.

# Phase 18 — Every budget has a reader, every artifact survives  *(new 2026-09-25, G515 · G516 · D513 · D514)*

**Why this phase exists.** Closing Phase 17 surfaced two defects of one shape — a value or a file that
still looks right after the thing it described changed. `serve` declares an edit budget it never
spends (G515): D512 changed the unit under it. And every browser operation writes one fixed filename
per target, so a later call silently replaces what an earlier call returned (G516): `verify-design`'s
three checks keep one image, and `baseline`'s before image can hold `verify`'s after.

**Run before Phase 17 / Task 5's EDS-18 re-run** — that run's pass condition reads three comparisons,
and without Task 3 below only the last one's screenshot exists to show it.

### Phase 18 / Task 1 — Core contract says both rules

**Delivers** §6: a role operation that writes an artifact writes a new file on every call and never
replaces one an earlier call returned (D514). §11: a stage declares `fix_attempts` only when its skill
asks `check-fix-budget.sh`, and a check enforces it (D513). `shared/pack-manifest.md`'s `fix_attempts`
rule and `shared/fix-loop.md` say the same, generically.
**Depends on** nothing.
**You verify** §6 and §11 each name their rule and its enforcing component; the two shared files agree
with them.
**Reject if** either rule is left to a stage's or a provider's own reading.

### Phase 18 / Task 2 — A declared budget has a reader

**Delivers** `plugins/agentic-core/shared/lib/check-fix-budget-readers.sh <pack root>` → exit 0 when
every stage declaring `fix_attempts` has a `skills/<skill>/SKILL.md` that invokes
`check-fix-budget.sh`, exit 1 naming each stage that does not; exit 2 on usage. Tests first, with
fixtures for: a declared-and-read stage, a declared-and-unread stage, an undeclared stage that asks
(allowed), a declared stage whose skill file is missing. `plugins/eds/pack.yaml` drops `serve`'s
`fix_attempts: 5`.
**Depends on** Task 1.
**You verify** the check fails on `plugins/eds` with the `serve` line restored and passes without it;
`validate-pack-manifest.sh` still accepts the pack.
**Reject if** the check infers "reads the budget" from anything but an invocation of the script, or if
the `serve` line is removed without the check that would have caught it.

### Phase 18 / Task 3 — Browser operations never overwrite

**Delivers** `plugins/playwright/scripts/next-artifact-path.cjs` — given a directory and a base name
and extension, returns the first `<base>-<n>.<ext>` that does not exist, `n` from 1 — and all four
operations (`render`, `capture`, `measure`, `interact`) writing through it. Tests first, runnable
without a browser: an empty directory gives `-1`, an existing `-1` gives `-2`, a gap (`-1`, `-3`)
gives `-2`, a different width or target does not advance the count.
**Depends on** Task 1.
**You verify** two captures of one URL at one width leave two files, and each envelope's `artifacts:`
names its own; `check-no-narrative.sh plugins` and `check-exec-bits.sh plugins` pass.
**Reject if** any caller stage is edited to compensate — the fix is the provider's, and every consumer
already reads the path from the envelope.

### Phase 18 / Task 4 — Verification

**Delivers** nothing new. Runs every `*.test.sh` under `plugins/agentic-core/shared/lib`, the new
browser-pack test, `validate-contracts.sh plugins`, `check-no-narrative.sh plugins`,
`check-exec-bits.sh plugins`, and `check-fix-budget-readers.sh plugins/eds`. The live proof is Phase
17 / Task 5's EDS-18 re-run, run after this phase merges: its `verify-design-report.md` names a
distinct screenshot per check, and the evidence manifest attaches each once.
**Depends on** Tasks 1–3.
**You verify** every suite and check exits 0; the EDS-18 report's screenshots are distinct files.
**Reject if** any suite is skipped or reported without being run, or the live run is claimed from a
session that edited the plugins.

# Phase 20 — The design provider reads layout, and says how to authenticate  *(new 2026-09-28, D517; widened the same day: G517 · G520 · D518 · D519 · D522)*

*Numbered 20 because Phase 19 is proposed by the unapproved `23-eval-harness-spec.md`.*

**Widened 2026-09-28.** Task 1 fetches design context that no stage reads (G517).
`write-design-reference.py` keeps only `variables` and `geometry`. Tasks 2–3 carry the context to the
prototype, Task 4 makes its spacing and radius measurable (G520), and Task 5 proves the chain on a
real run. Task 1 also takes D518 (lean call, cap-safe response), by the human's choice.

### Phase 20 / Task 1 — `fetch_reference` uses design context and names the auth remedy

**Delivers** `plugins/figma/skills/fetch-reference/SKILL.md`: `get_design_context` as the default
source for layout, colour and typography, alongside `get_metadata`, `get_variable_defs`,
`get_screenshot`; `allowed-tools` naming every tool it calls; the unauthenticated case failing
`PERMANENT` with a fixed remedy sentence; artifact JSON gains `design_context` (additive — the
manifest writer's required fields are unchanged).
**Depends on** nothing.
**You verify** a run of the new flow on `Zoki` node `1-185` writes a `.context.txt` holding the
padding and radius and a JSON whose `design_context.styles` names `Accent/Accent 2`; the old flow on
the same node does not; `write-design-manifest.sh` still accepts the new JSON; `check-no-narrative.sh
plugins` and `check-exec-bits.sh plugins` pass.
**Reject if** the design context is translated rather than stored verbatim, or the operation starts
the OAuth flow itself.
**Amended 2026-09-28 (D518).** Also delivers `get_design_context` called with
`excludeScreenshot: true`, and a truncated or unparseable response recorded as structure-only
(`design_context: null`, `metrics: design_context=structure_only`). **Also reject if** such a
response is classified `PERMANENT`, or `forceCode` is set.

### Phase 20 / Task 2 — The normalizer carries design context

**Delivers** `write-design-reference.py design_tool` copying the provider's `design_context` into
`design-reference.json` and its reference code to `.ai/run-context/design-context.txt`; image mode
writing `design_context: null` (D519). A new `write-design-reference.test.sh`, tests first, covering:
a provider JSON with a code block, one with `design_context: null`, and image mode.
`eds-extract/SKILL.md`'s `artifacts:` lists the new file.
**Depends on** Task 1.
**You verify** the test passes, and `jq -e '.design_context'` on a real extract's
`design-reference.json` is non-null for `Zoki` node `1-185`.
**Reject if** the reference code is rewritten or summarised on the way through, or image mode omits
the key instead of writing `null`.

### Phase 20 / Task 3 — The prototype reads layout values

**Delivers** a script under `plugins/eds/skills/eds-prototype/scripts/` that reads
`design-context.txt` and prints one `node_id → property → value` row per arbitrary-value class. Tests
first, with fixtures for spacing, radius, font size, colour, and a class it does not recognise. It
ignores an unrecognised class and never guesses its property. `eds-prototype/SKILL.md` reads the
table next to `variables` and `geometry`, maps each value to a project token where one exists, and
records each value's source in `prototype-report.md` (D519).
**Depends on** Task 2.
**You verify** on `Zoki` node `1-185` the block CSS carries padding `14px 22px` (or the project
tokens mapped to them) and the radius, and `prototype-report.md` names `design_context` as their
source.
**Reject if** the class parsing lives in skill prose, or a value's source is not recorded.

### Phase 20 / Task 4 — `measure` reports spacing and radius

**Delivers** the browser role's `measure` property list widened with `padding-top`, `padding-right`,
`padding-bottom`, `padding-left`, `gap` and `border-radius` in `01-core-contracts.md` §6 and the
playwright pack's `measure` (D522). `eds-verify-design` compares them against Task 3's table, and its
Known limitations shrink to what is still unmeasured.
**Depends on** Task 3.
**You verify** `measure` on a local page with a known padding and radius returns both, and
`eds-verify-design` names a padding mismatch numerically.
**Reject if** a property is added to the stage without being added to the contract first.

### Phase 20 / Task 5 — Verification

**Delivers** nothing new. Runs every `*.test.sh` touched by Tasks 1–4, `validate-contracts.sh
plugins`, `check-no-narrative.sh plugins` and `check-exec-bits.sh plugins`. The live half: one route
on a work item whose design reference is `Zoki` node `1-185`, from a fresh session.
**Depends on** Tasks 1–4, merged.
**You verify** every suite exits 0; the run's `design-reference.json` carries `design_context`, the
block CSS carries the node's padding and radius, and `verify-design-report.md` measures both.
**Reject if** the live run is claimed from a session that edited the plugins.

# Phase 21 — The right frame, at every viewport  *(new 2026-09-28, G518 · D520)*

**Why this phase exists.** The design stages see one frame at one width (G518). A link to a page is
taken whole, Desktop and Mobile variants are merged into one reference, and verification compares
every width against that one image. Onboarding already handles viewports; a work item's route does
not. Accepted cost: 2 extra Figma calls per variant.

### Phase 21 / Task 1 — A node that is several frames is a question

**Delivers** a deterministic script in `plugins/figma/skills/fetch-reference/scripts/` that reads
`get_metadata`'s XML and classifies the node as a single frame, a page or multi-frame node, or a
frame with viewport variants. It prints each child's name, node id, width and the rule it matched.
Tests first, with XML fixtures for each case. `fetch-reference` returns `verdict: question` for a
page or multi-frame node, naming every candidate (D520).
**Depends on** Phase 20 / Task 1.
**You verify** the tests pass, and a page URL returns `question` listing its frames.
**Reject if** any path auto-selects a frame, or the classification lives in skill prose.

### Phase 21 / Task 2 — Viewport variants in the design reference

**Delivers** `01-core-contracts.md`'s design-reference shape gaining
`viewports: [{name, node_id, width, image, context}]`, sorted widest first. `fetch-reference` fetches
design context and a screenshot per variant and variables once. `write-design-reference.py` carries
the list through (D520).
**Depends on** Task 1 · Phase 20 / Task 2.
**You verify** a frame with Desktop and Mobile children yields two entries, each with its own image
and context file, and 6 Figma calls in total.
**Reject if** a variant is fetched without being detected by the Task 1 script, or the contract
change lands after the code.

### Phase 21 / Task 3 — Each viewport is compared against its own reference

**Delivers** `eds-verify-design` capturing at each variant's width instead of the fixed `1440`, and
`eds-verify` pairing each of its 375/768/1440 captures with the variant that covers that width, or
reporting that none does.
**Depends on** Task 2.
**You verify** on a two-variant item the verify-design report names two comparisons, each against its
own reference image.
**Reject if** one reference image is compared at more than one width without saying so.

### Phase 21 / Task 4 — Breakpoint overrides from design

**Delivers** a script that diffs Phase 20 / Task 3's value tables across variants into mobile-first
overrides for `eds-prototype`. A variant width outside the adopted breakpoints is raised as a
finding, with the threshold derived by `breakpoint-thresholds.md`, never silently added.
**Depends on** Task 3 · Phase 20 / Task 3.
**You verify** on a two-variant item the block CSS carries the mobile value as the base and the
desktop value inside `@media (width >= 900px)`.
**Reject if** a frame's width is used directly as a threshold.

### Phase 21 / Task 5 — Verification

**Delivers** nothing new. Runs every suite touched by Tasks 1–4 plus the three repository checks. The
live half: one route on a two-variant frame from a fresh session.
**Depends on** Tasks 1–4, merged.
**You verify** every suite exits 0; the run compares each variant at its own width and records the
Figma call count.
**Reject if** the live run is claimed from a session that edited the plugins.

# Phase 22 — Real images and icons  *(new 2026-09-28, G519 · D521)*

**Why this phase exists.** Images and icons in a design are never retrieved (G519). Verification
tolerates their absence as `[content-asset gap]`, so a block that needs one is never compared
against it.

### Phase 22 / Task 1 — `fetch_reference` downloads referenced assets

**Delivers** `fetch-reference` downloading every entry of `get_design_context`'s asset map, in the
same call, to `.ai/figma/assets/`. Extension and MIME type come from the bytes, and icons are fetched
as SVG. The artifact records `assets: [{node_id, file, mime}]`, and `write-design-reference.py`
carries the list (D521). The magic-byte check is a script with its own test.
**Depends on** Phase 20 / Task 2.
**You verify** on a node with a photo and an icon, two files land with correct extensions and MIME
types, and no URL appears in any written file (`grep -r 'figma.com/api' .ai/` prints nothing).
**Reject if** a URL is written anywhere, or a format is taken from a URL suffix.

### Phase 22 / Task 2 — The prototype uses them

**Delivers** `eds-prototype` placing the downloaded assets it uses, and flagging each committed
binary for optimisation (`AGENTS.project.md:149`).
**Depends on** Task 1.
**You verify** on the same node the prototype references both assets, and `verify-design-report.md`
carries no `[content-asset gap]` for them.
**Reject if** an unoptimised binary is committed without the flag.

### Phase 22 / Task 3 — Verification

**Delivers** nothing new. Suites, the three repository checks, and one live route from a fresh
session.
**Depends on** Tasks 1–2, merged.
**You verify** every suite exits 0 and the live run's verify-design report shows the asset compared.
**Reject if** the live run is claimed from a session that edited the plugins.

# Phase 23 — Comparison quality  *(new 2026-09-28; scheduled 2026-09-29, G538 · G539 · G540 · D540)*

Candidates from the `dx-core` comparison, specified in `archive/next-phase-20-23.md` and decided with the
human (D540). Tasks 1 and 3 are scheduled. Task 2 stays logged until a real frame shows a pasted
context screenshot (G539).

### Phase 23 / Task 1 — Content-dependent values carry a tolerance marker

**Delivers** Phase 20 / Task 3's value-table script gaining an `approx` column: `true` when the
property is `width`, `height`, `min-height` or `aspect-ratio` **and** the node is a text node,
contains one, or carries an image fill. Structural properties, `padding`, `gap` and `margin` are never
approx (D540). `eds-verify-design` lists an approx mismatch under "content-dependent, not graded" and
spends no fix edit on it. Tests first, with fixtures for a text node's width, a frame's padding (not
approx), an image's aspect ratio, and a structural property.
**Depends on** Phase 20 / Tasks 3–4 (merged, PR #159).
**You verify** the tests pass; on the real Zoki sample, a text width row is `approx` and a padding
row is not; `compare-design-values.py` reports the approx mismatch in its own section and
`check-fix-budget.sh` counts no edit for it.
**Reject if** the approx decision lives in skill prose; padding, gap or margin is marked approx; or
an approx value is dropped from the report rather than listed.

### Phase 23 / Task 2 — Pasted context screenshots are detected, not reproduced  *(logged — G539)*

**Precondition to scheduling:** one real work item whose frame matches `dx-core`'s structural
patterns P1–P6. Then: a script classifies each top-level child as `designed`, `hybrid`,
`screenshot-context` or `decoration` from structure alone; the prototype does not reproduce the last
two, and `eds-verify-design` lists their regions as "not compared: context screenshot" (D540).
**Reject if** HTML is reconstructed from the image.

### Phase 23 / Task 3 — A design that does not match its item is a finding

**Delivers** a script in `plan-gate`'s deterministic half that tokenises the sanitized spec's
summary and component names, plus the design reference's `node_name` and the `data-name` values in
its design-context file. It counts case-insensitive matches after stripping `Desktop/`, `Mobile/` and
`Component/`. Fewer than 2 is a `warn` finding naming both keyword lists, and never a fail (D540).
Tests first: a matching pair, a mismatching pair, and image mode (no design context → reported as
not run).
**Depends on** Phase 20 / Task 2 (merged, PR #159).
**You verify** the tests pass; `plan-gate` on a deliberately mismatched item reports the warning and
the route continues.
**Reject if** the check is placed in `readiness` or in the design provider; a low score blocks the
route; or layer names are treated as rendered text.

### Phase 23 / Task 4 — Verification

**Delivers** nothing new. Runs every suite touched by Tasks 1 and 3 plus the repository checks; the
live half is one route from a fresh session after merge on an item whose design has placeholder copy.
**Depends on** Tasks 1 and 3, merged.
**You verify** every suite exits 0 and the live run's `verify-design-report.md` carries a
"content-dependent, not graded" section.
**Reject if** the live run is claimed from a session that edited the plugins.
**Not met yet, 2026-10-05 (the human, AskUserQuestion; `eds-24-gaps-prep-done.md`).** The section half
is met by three runs (`.ai/run-context/verify-design-report.md:97`; EDS-24 failed run `:70`; EDS-18
run B `:65`). The human ruled that the live check Task 3 handed here is part of this task: plan-gate on a
mismatched item warns and the route continues (`phase-23-task-3-done.md:80-81`). No run has taken that
path; every run so far printed `relevance: match`. "Placeholder copy" is not required.

# Phase 25 — Gate findings go to a report file  *(new 2026-09-28, G521 · D524)*

**Why this phase exists.** On the EDS-18 run, `publish-gate` returned `warn` with a real finding and,
as its own adapter instructs, wrote it after the `## Result` block; the runner failed the run for it
(G521). Even with the findings placed above the heading, a `warn` finding reaches no file. Both gates
now write a report and emit their envelope through the emitter (D524). Step-by-step detail,
measured line numbers and the reference implementation's pattern are in `next-phase-25.md`.

### Phase 25 / Task 1 — Read, number, branch

**Delivers** the phase number, the renamed track file `next-phase-25.md`, the EDS-18 prototype
parked in a stash, and branch `phase-25-task-2-report` cut from a fresh `main`.
**Done** 2026-09-28 — `phase-25-task-1-done.md`.

### Phase 25 / Task 2 — Records first

**Delivers** G521 (`05-gap-register.md`) and D524 (`03-core-design.md`), this heading, the
`00-instructions.md` index entry, and the check that no `06-dx-core-deviations.md` entry is needed.
**Depends on** Task 1.
**You verify** `check-numbering.sh 03-core-design.md 04-eds-pack-design.md 05-gap-register.md`
prints `valid`, and `grep -c 'D524' 03-core-design.md` is at least 1.
**Reject if** a number is reused, or anything under `plugins/` changed.

### Phase 25 / Task 3 — Contract

**Delivers** the narrowed read-only rule in `01-core-contracts.md` §4 (both sentences) and in
`shared/gate-contract.md`, naming the two paths; `warn` records its findings in the report; the D42
readiness entry in `06-dx-core-deviations.md` re-quoted to the new §4 wording.
**Depends on** Task 2.
**You verify** `check-no-narrative.sh plugins` exits 0, and neither file names a pack or platform.
**Reject if** the rule permits any write outside the two named paths.

### Phase 25 / Task 4 — Gate agent and pack manifest

**Delivers** the gate reviewer agent allowing writes to exactly those two paths, and
`publish-gate-report` / `plan-gate-report` registered under the pack manifest's `artifacts:`.
**Depends on** Task 3.
**You verify** `validate-pack-manifest.sh` accepts the pack.
**Reject if** any other isolation statement in the agent is dropped.

### Phase 25 / Task 5 — publish-gate

**Delivers** `eds-publish-gate` writing the report on every verdict and emitting its envelope through
`emit-envelope.sh --artifact .ai/run-context/publish-gate-report.md`; the "follow the block" line is
gone. Edited through `skill-creator`.
**Depends on** Task 4.
**You verify** `grep -n 'Follow the block' plugins/eds/skills/eds-publish-gate/SKILL.md` prints nothing.
**Reject if** the `SKILL.md` was hand-edited.

### Phase 25 / Task 6 — plan-gate

**Delivers** the same change in `eds-plan-gate`, report at `.ai/run-context/plan-gate-report.md`.
**Depends on** Task 5, and the answer to D524's open question: who owns
`.ai/run-context/envelope-<stage id>.txt`.
**You verify** as Task 5, for this gate.
**Reject if** the open question is not answered in writing first.

### Phase 25 / Task 7 — Regression check

**Delivers** a deterministic test in the `eds` pack that fails when any `context: fork` stage
instructs text after the `## Result` block, or a gate's `Report` nodes do not name its report and the
emitter.
**Depends on** Tasks 5–6.
**You verify** the test fails against the pre-Task-5 `eds-publish-gate/SKILL.md` and passes after.
**Reject if** it passes against the old file.

### Phase 25 / Task 8 — Verification

**Delivers** nothing new. Suites, the three repository checks, and the EDS-18 re-run from a fresh
session.
**Depends on** Tasks 3–7, merged.
**You verify** `publish-gate` returns `warn`, `.ai/run-context/publish-gate-report.md` holds the
`table.css:46` finding, `run-stage.sh` prints `decision: continue-warn`, and the run reaches
`terminal: delivered`.
*Criterion restated 2026-10-05 (the human's choice, after Phase 43 / Task 4):* the `table.css:46`
finding is EDS-18's own — a Roboto Mono declaration its diff introduced, on `main` since (line 118),
so no other item's diff can carry it and a gate that passes such a diff is right. What this phase built
is item-independent: a gate's findings reach its report file, never the text after `## Result`, and a
`warn` continues. The live criterion is four facts from one delivered run, any item, either gate:
**(1)** a gate returns `warn` and `run-stage.sh` prints `decision: continue-warn` for it; **(2)** that
gate's `.ai/run-context/<gate id>-report.md` holds the finding under `## Findings`; **(3)** its envelope
lists that report under `artifacts:`; **(4)** the run reaches `terminal: delivered`. *Met 2026-10-05 on
the EDS-24 run (`phase-43-task-4-done.md`):* `plan-gate` → `warn`, `decision: continue-warn`;
`plan-gate-report.md:14-16` one finding (verification steps cite a baseline never captured);
`envelope-plan-gate.txt:5` `- .ai/run-context/plan-gate-report.md`; `terminal: delivered`, PR #230.
`publish-gate` → `pass` wrote its report too (`## Findings` `None.`), as Task 5 requires on every verdict.
**Reject if** the live run is claimed from a session that edited the plugins.

# Phase 26 — EDS-18 prototype blockers  *(new 2026-09-28, G522 · G523 · G524 · G525 · D525 · D526)*

**Why this phase exists.** The EDS-18 run ended `blocked` at `prototype` (6/14). Three icons shared
one layer name and the placement refused (G522); the answer naming the target block was erased by a
later answer (G523); the fallback then picked `columns` from an alphabetical list (G524). Reviewing
it, the human added a rule: check the Block Collection before building a block new (G525). One
branch and one PR per defect; each branch cut from a freshly fetched `origin/main`.

### Phase 26 / Task 1 — Records first

**Delivers** G522–G525 (`05-gap-register.md`), D525 and D526 (`04-eds-pack-design.md`), this
heading, and the `00-instructions.md` index line.
**Done** 2026-09-28 — `phase-26-task-1-done.md`.

### Phase 26 / Task 2 — Name collisions never block

**Delivers** a shared order-independent naming function, used by `place-assets.py`, per D525; a
`split` row recorded in the report; the component content key tested directly; `eds-prototype`
`SKILL.md` updated through `skill-creator`. Branch `phase-26-task-2-names`.
**Depends on** Task 1.
**You verify** the new fixtures fail before and pass after: 3 distinct SVGs under one name give 3
hash4 files and no base file with exit 0; identical copies give one base file; reversed layer order
gives the same names; a forced hash4 tie widens to 8; no existing file is overwritten.
**Reject if** a collision can still produce `question`, or the SKILL.md was hand-edited.

### Phase 26 / Task 3 — Answer store

**Delivers** the answer-store contract the human chooses (G523): core contract §8/§12 and
`question-protocol.md` first, then the scripts, `run-route` and `eds-prototype` through
`skill-creator`. Branch `phase-26-task-3-qa`.
**Depends on** Task 1 and D527 (keyed `question_id`, decided 2026-09-28).
**You verify** a test writes two answers for one stage and reads both back as the chosen contract
defines; every core suite passes.
**Reject if** the contract text changed after the code, or the core names a platform.

### Phase 26 / Task 4 — Target block from exactly one candidate

**Delivers** a script deciding `prototype`'s target per D526, the `SKILL.md:146` fallback replaced
through `skill-creator`, `eds-deliver/SKILL.md:351` checked, and the tracker component `table` set on
EDS-18 through `write-specs` and re-verified on the live item. Branch `phase-26-task-4-target`.
**Depends on** Task 3.
**You verify** the script's tests: 0 candidates → question, 1 → resolved, 2+ → question listing all,
an answer outranks all; the live EDS-18 item shows component `table`.
**Reject if** a component is written without first confirming the tracker project has components.
**Done** 2026-09-29 — `phase-26-task-4-done.md`.

### Phase 26 / Task 5 — Block Collection before a new block

**Delivers** D528: a manifest of `adobe/aem-block-collection` pinned at `69d7d5083900` with each
block's files and the upstream Apache-2.0 license vendored beside it in the eds pack; the refresh
script that rewrites all three; `check-component-reuse.sh` answering `upstream=` and
`upstream_unknown=`; `eds-prototype`/`eds-plan`/`eds-implement` copying a found block's files into
`blocks/<name>/` before applying the work item's changes (their `SKILL.md` only through
`skill-creator`; prototype added 2026-09-29, D528 amended). Branch `phase-26-task-5-collection`.
**Depends on** Task 1 and D528 (decided 2026-09-28).
**You verify** the reuse script's tests: a name in `blocks/` → `reuse`; absent there, present in the
manifest → `upstream`; absent in both → `new`; manifest missing or malformed → `upstream_unknown`
and exit 0, never `new` alone. For EDS-18 the reuse answer is `upstream=table`.
**Reject if** a missing manifest is reported as "not in the collection", the run touches the
network, or vendored files ship without the upstream license.
**Done** 2026-09-29 — `phase-26-task-5-done.md`.

### Phase 26 / Task 6 — Verification

**Delivers** nothing new. Every `*.test.sh` under `plugins/agentic-core`, `eds`, `figma`, `github`,
`jira` and `playwright` from the main checkout on an up-to-date `main`; `.ai/run-context/` and
`.ai/progress.md` archived to `.ai/logs/run-context-<date>-<time>/`; `.ai/run-state.json` removed;
a fresh session.
**Depends on** Tasks 2–5, merged.
**You verify** `/agentic-core:run-route EDS-18` writes `envelope-prototype.txt` with `pass` or `warn`
and reaches stage 7, `verify-design`.
**Reject if** the live run is claimed from a session that edited the plugins.
**Done** 2026-09-29 — `phase-26-task-6-done.md`. Reached `verify-design` (stage 8 of 15 in that
run: `baseline` ran) and failed there; findings became Phase 27.

# Phase 27 — EDS-18 verify-design blockers  *(new 2026-09-29, G526–G530 · D529–D532)*

**Why this phase exists.** Phase 26 / Task 6's EDS-18 run passed `prototype` — with `table` copied
from the pinned Block Collection — and failed at `verify-design`: three radius mismatches no block
edit can clear (G526) and a header offset likely from missing fonts (G527). The same run showed
`baseline` rendering an unmounted `drafts/` path (G528), `prototype` reporting a false ESLint
failure (G529), and two suites red only in the sandbox (G530). One branch and one PR per defect,
each cut from a freshly fetched `origin/main`.

### Phase 27 / Task 1 — Records first

**Delivers** G526–G530 (`05-gap-register.md`), this heading, `next-phase-27.md` and the
`00-instructions.md` index line.
**Done** 2026-09-29 — `phase-27-task-1-done.md`.

### Phase 27 / Task 2 — A split design value is compared as it was applied

**Delivers** D529: `compare-design-values.py` compares a line's own applied value, bounded by the
node's value (tests first); `eds-prototype` writes split values that way (`SKILL.md` only through
`skill-creator`).
**Depends on** Task 1 and D529 (decided 2026-09-29).
**You verify** a fixture where a node's radius is split across two selectors (top corners on one,
bottom on the other) compares as the decision defines — no `[fixable]` mismatch for a correct
render — and an unsplit value still mismatches when wrong.
**Reject if** a split value is silently dropped from comparison with no line in the report.
**Done** 2026-09-29 — `phase-27-task-2-done.md`.

### Phase 27 / Task 3 — Design fonts

**Delivers** D530: a deterministic check naming each design font family the project does not
declare; the run warns on it; `verify-design` classes text-geometry mismatches as a
`content-asset gap` while one is missing. `SKILL.md` only through `skill-creator`.
**Depends on** Task 1 and D530 (decided 2026-09-29).
**You verify** the check's tests: declared family → none; missing → named; EDS-18 names all four.
**Reject if** a font file is committed without its license.
**Done** 2026-09-29 — `phase-27-task-3-done.md`.

### Phase 27 / Task 4 — Baseline never renders a draft fixture

**Delivers** D532: `baseline`'s content search excludes `drafts/`, so a new block
reports "nothing to render" (`warn`); `SKILL.md` only through `skill-creator`.
**Depends on** Task 1.
**You verify** a checkout whose only hit is `drafts/<item_id>.plain.html` gives no target URL.
**Reject if** `baseline` starts a draft server.
**Done** 2026-09-29 — `phase-27-task-4-done.md`.

### Phase 27 / Task 5 — Prototype does not report lint

**Delivers** D531: `prototype` runs no linter and reports no lint result. `SKILL.md` only through
`skill-creator`.
**Depends on** Task 1.
**You verify** `eds-prototype/SKILL.md` names no bare `eslint`/`stylelint` call.
**Reject if** `prototype-report.md` can still carry a lint result.
**Done** 2026-09-29 — `phase-27-task-5-done.md`.

### Phase 27 / Task 6 — Suites make temp dirs under `$TMPDIR`

**Delivers** the fix for G530 in the two suites.
**Depends on** Task 1.
**You verify** both suites pass inside the sandbox: 19/19 and 3/3.
**Reject if** the code under test changes.
**Done** 2026-09-29 — `phase-27-task-6-done.md`.

### Phase 27 / Task 7 — Verification

**Delivers** nothing new. Every `*.test.sh` under `plugins/*` passes in the sandbox; run context
archived as in Phase 26 / Task 6; a fresh session.
**Depends on** Tasks 2–6 and 8, merged.
**You verify** `/agentic-core:run-route EDS-18` writes `envelope-verify-design.txt` with `pass` or
`warn`.
**Reject if** the live run is claimed from a session that edited the plugins.
**Done** 2026-09-29 — `phase-27-task-7-done.md`.

# Phase 28 — The verified link survives review  *(new 2026-09-29, G531–G536 · D533–D538)*

**Why this phase exists.** Phase 27 / Task 7's EDS-18 run delivered, but its verified link was dead
by review time (G534) and absent from the pull request (G533); the note buried the one action item
(G535); `verify-design` spent an empty edit (G531); both gates ran unisolated (G532); and a ~7px
header text offset was blamed on missing fonts without evidence (G536). One branch and one PR per
task, each cut from a freshly fetched `origin/main`. Every `SKILL.md` edit goes through
`skill-creator`.

### Phase 28 / Task 1 — Records first

**Delivers** D533–D538 (`03-core-design.md`, `04-eds-pack-design.md`), G536 and the decision lines
on G531–G535 (`05-gap-register.md`), this heading, `next-phase-28.md` and the `00-instructions.md`
index line. No `plugins/` edit.
**Done** 2026-09-29 — `phase-28-task-1-done.md`.

### Phase 28 / Task 2 — `check_status` reports the change state

**Delivers** D534: core contract §6 and the role table name `change_state`
(`open`/`merged`/`closed`/`none`); the github pack's `check-status.sh` finds a branch's change in
any state and reports it (tests first); the envelope validator and any manifest field that lists
the operation's outputs accept it.
**Depends on** Task 1.
**You verify** the suite: an open, a merged and a closed change each report their state; a branch
with no change reports `none` and exits 0; checks are still reported for an open change.
**Reject if** a merged or closed change is reported as `none`.

### Phase 28 / Task 3 — One long-lived draft server, cleaned up by `serve`

**Delivers** D533: a new cleanup script under `plugins/eds/shared/scripts/` with its own suite;
`eds-serve` calls it before it starts or polls anything; `eds-verify` and `eds-verify-design` no
longer stop the draft server; pid and log move to `.ai/logs/draft-server.{pid,log}`;
`shared/draft-server.md` rewritten to match.
**Depends on** Task 2.
**You verify** the suite, with the scm role stubbed: a merged record deletes only its own item's
draft; an open record keeps its draft and the server; a record the role cannot answer for is
treated as open; a draft with no record is untouched; no open record stops the server by its pid
file.
**Reject if** any stage still calls `stop-draft-server.sh` outside the cleanup script, or the core
names `drafts/` or the draft server.
*Amended 2026-09-29 (D533 amendment):* the github pack declares `scripts.check_status`, and the cleanup
runs it as a subprocess; merged/closed records move to `.ai/logs/scm-closed/`. **Also verify** that
a record the role cannot answer for includes a pack with no `scripts.check_status`. **Also reject
if** the cleanup script calls `gh` itself.

### Phase 28 / Task 4 — The PR and the note carry the verified target

*Widened 2026-09-29 with G537, done first:* a fixed 23-character branch limit, a deterministic
checker in the eds pack (tests first), and `start-draft-server.sh` failing fast with `start-failed:
branch name too long` instead of reaching the poll ladder. The core stays uncapped (D28).

**Delivers** D535 and G535: `deliver` reads the evidence manifest before composing the change
summary; one deterministic script (tests first) builds the "Verified locally" block and G535's short
note from the manifest, the check result and the project config; the block appears verbatim in the
pull request body and the note; every coverage gap stays verbatim in `delivery-report.md`.
**Depends on** Task 3 (the block's wording).
**You verify** the suite with EDS-18's manifest as a fixture: the PR body carries the target, the
local-only line naming the branch, and the restart command; the note is about ten lines with the
missing fonts under **Action needed**; `delivery-report.md` still carries every gap.
**Reject if** the PR body and the note carry different target text.
*Amended 2026-09-29 (D535 amendment):* the Restart line carries the draft server's port
(`npm run up:draft -- --port 3001`).
**Done** 2026-09-29 — `phase-28-task-4-done.md` (D539 filed; G533, G535, G537 resolved).

### Phase 28 / Task 5 — `verify-design` stops when nothing is fixable

**Delivers** D536: each check writes `.ai/run-context/verify-design-check-<n>.txt`; a deterministic
script (tests first) counts `[fixable]` and untagged lines; zero skips the budget question and ends
the loop "nothing fixable".
**Depends on** Task 1.
**You verify** the suite: a list of only `[content-asset gap]` lines → zero; one `[fixable]` →
one; an untagged line counts as fixable; an empty file → zero.
**Reject if** the budget script or the two-edit cap changes.
**Done** 2026-09-29 — `phase-28-task-5-done.md` (G531 resolved).

### Phase 28 / Task 6 — A gate that is not isolated is caught

**Delivers** D537: `gate-contract.md` states the working-directory comparison and the `warn`; a
core script (tests first) snapshots the project root before and after a stage and reports any
change outside a named allowlist; `run-route` runs it around both gate stages (stamp regenerated).
**Depends on** Task 1.
**You verify** the suite: no change → pass; only the gate's report and envelope changed → pass;
any other tracked or untracked change → fail naming the path.
**Reject if** the guard names a platform path, or a gate fails merely for being unisolated.

### Phase 28 / Task 7 — Probe the header text offset

**Delivers** D538: a measurement, read-only, of EDS-18's table header on `main` (padding,
line-height, `p` margins, text box against header box) compared with Figma node `1-195`, recorded in
`phase-28-task-7-done.md` and on G536. No `plugins/` or block edit.
**Depends on** Task 1.
**You verify** the done file names the measured numbers and either a CSS property that explains
the offset or that none does.
**Reject if** a fix is made in this task.
**Done** 2026-09-29 — `phase-28-task-7-done.md`.

### Phase 28 / Task 8 — The eds gates check their own isolation

**Delivers** the gate half of D537 in the eds pack (found in Task 6): `eds-plan-gate` and
`eds-publish-gate` compare their own working directory (`pwd -P`) with the `project_root` they are
given, before reviewing, through one pack script (tests first) rather than prose. Equal → the report
carries `isolation: absent`, a `pass` becomes `warn`, a `fail` stays `fail`, and the review still
runs. Every `SKILL.md` edit goes through `skill-creator`.
**Depends on** Task 6, merged.
**You verify** the script's suite: different directories → `isolation: present`; equal after
symlink resolution → `isolation: absent`; the verdict cap maps `pass` → `warn` and leaves `warn`
and `fail` unchanged. Every `*.test.sh` under `plugins/*` passes in the sandbox.
**Reject if** a gate refuses to run or returns `fail` only for being unisolated, or the comparison
is left to the model instead of the script.
**Done** 2026-09-29 — `phase-28-task-8-done.md`.

### Phase 28 / Task 9 — Verification

**Delivers** nothing new. Every `*.test.sh` under `plugins/*` passes in the sandbox; run context
archived as in Phase 26 / Task 6; a fresh session that edited no plugins.
**Depends on** Tasks 2–6 and 8, merged.
**You verify** `/agentic-core:run-route EDS-18` reaches `terminal: delivered`; after the run ends,
the verified link (`http://localhost:3001/drafts/EDS-18`) still answers 200; the same link, the
local-only line and the restart command appear in the pull request body and in the EDS-18 tracker
note; `serve`'s cleanup reported deleting `drafts/EDS-18.plain.html` (PR #170 merged) before
`prototype` wrote it again; `verify-design-check-*.txt` exist and the loop ended "nothing fixable"
or with a `[fixable]` entry named; both gates' tree guard passed; each gate's report states its
isolation (`present`, or `absent` with the verdict at most `warn`).
**Reject if** the live run is claimed from a session that edited the plugins, or the link is
checked before the run ended.

# Phase 29 — `measure` reads a settled page  *(new 2026-09-29, G541)*

**Why this phase exists.** Repeated measurements of one unchanged draft differed (`.table` 0×0 or
1200 wide; `th:nth-child(2)` 382.8 or 385.2), because `measure.cjs` reads at `load`. Every
comparison built on `measure` inherits that noise.

### Phase 29 / Task 1 — `measure` waits for a settled page

**Delivers** the playwright pack's `measure.cjs` reading only after the named targets are visible,
`document.fonts.ready` has resolved, and two consecutive snapshots taken a fixed interval apart are
identical, with an upper time bound that fails loudly (never returns an unsettled read). Tests first,
runnable without a browser where the logic allows. The output shape and D514's new-file-per-call are
unchanged.
**Depends on** nothing.
**You verify** the repeat test: the same unchanged draft measured N ≥ 10 times gives byte-identical
geometry and values every time. The same test against the old `measure.cjs` shows the variance.
**Reject if** a fixed sleep stands in for a settle condition, or an unsettled read is returned
silently.

### Phase 29 / Task 2 — Verification

**Delivers** nothing new. Suites plus the repeat test on `main` after merge, from a fresh session.
**Depends on** Task 1, merged.
**You verify** every suite exits 0 and the repeat test is identical across all runs.
**Reject if** the repeat test is reported without being run.

# Phase 30 — NEXT.md review follow-ups  *(new 2026-09-29, G545 · G543 · G542 · D540)*

**Why this phase exists.** A review of `NEXT.md` on 2026-09-29 found the file stale (G545) and three
open items from the D540 measurement that no phase covered: an unreadable `node:` tail is dropped
silently (G543); the prototype writes placeholder sizes into real CSS and no candidate fix has been
measured (G542); and D540's relevance threshold rests on 3 pairs. Tasks run in this order. Each has
its own branch, PR and done-doc.

### Phase 30 / Task 1 — `NEXT.md` status claims are checked

**Delivers**
- `check-status-claims.mjs` also reads `docs/implementation-plan/NEXT.md` and every
  `docs/implementation-plan/next-*.md`, with the same two marker kinds (`G<n>` against the register
  heading, `PR#<n>` against `origin/main`). Existing HTML checking is unchanged.
- `NEXT.md` rewritten against `main`: last task done, the next task's prompt, and pointers to the
  track files. Every PR or gap status it states carries a marker.

**Depends on** nothing.
**You verify** the checker exits 0 on the rewritten file. Change one marker to a false status and
it exits 1 naming that file and marker. Restore it. The existing `docs/agentic-core` pages still
check as before.
**Reject if** a status claim in `NEXT.md` has no marker, or the checker edits a file.

### Phase 30 / Task 2 — An unreadable `node:` tail is an error

**Delivers** `compare-design-values.py` exits 2 when a `## Design values` line ends in a part that
starts with `node:` but does not match the one-node form. stderr names the line. Both `selectors`
and `compare` behave this way. Lines with no `node:` part are unchanged. `eds-verify-design` needs
no edit: it already sends the script's exit 2 to **Report fail** with the stderr reason.
Tests first, in `compare-design-values.test.sh`: a list tail (`node: 1:196, 1:205`), a range tail
(`node: 1:199–1:204`), an empty tail (`node:`), and a valid tail still passing.
**Depends on** nothing.
**You verify** the four new tests fail before the change and pass after; the whole suite exits 0.
**Reject if** an unreadable tail is skipped, or reported only as an `unmeasured` row.

### Phase 30 / Task 3 — Measure what the prototype should write for an approx size

**Delivers** numbers, not a fix. The altered-content test D540 used (the delivered EDS-18 block,
copy shortened and lengthened by 50% and 100%, one 1280 viewport) run against three versions of
the block CSS:
- (a) the `approx` size rows are not written at all;
- (b) they are written as `min-*` instead of fixed values;
- (c) only padding and gap from the design are written.
For each version: overflow (a child taller than its box), the `verify-design` result against the
design reference, and how many rows become mismatches. Results in the done-doc, with the raw data
kept under `.ai/logs/`.
**Depends on** nothing (the `approx` marker is on `main` since PR #177).
**You verify** each number in the done-doc can be traced to a file under `.ai/logs/`.
**Reject if** a candidate is chosen in this task. The human decides from the numbers; the
decision is then filed as a D entry and built as its own task.

### Phase 30 / Task 4 — The relevance check can be re-measured by a script

**Delivers** a script that re-runs `check-design-relevance.sh` over every archived run context
under `.ai/logs/run-context-*/` that holds a sanitized spec, a fact record and a design reference
with a `node_name`, plus any cross pairs it is given. It prints one row per pair and the counts of
correct and wrong links at thresholds 1 and 2.
**Measured 2026-09-29:** no archived run context qualifies yet. All of them predate `node_name`,
and only two items with a design (EDS-13, EDS-18) were ever run. The script does not create
pairs. Only new work items with designs create them, which is what Phase 19's eval cases would
supply.
**Depends on** nothing.
**You verify** on a fixture archive of 2 true pairs and 2 cross pairs, the script's counts equal a
hand count.
**Reject if** the script changes the checker, the threshold or any stage.

### Phase 30 / Task 5 — Verification

**Delivers** nothing new. On `main` after Tasks 1, 2 and 4 are merged: all suites, the status
checker on `NEXT.md`, and the relevance script on the real archive (expected: 0 qualifying pairs,
reported as such).
**Depends on** Tasks 1, 2 and 4, merged; Task 3's done-doc written.
**You verify** every suite exits 0, the status checker exits 0, and the relevance script reports
its real count.
**Reject if** any result is reported without being run.

# Phase 31 — A fixed size on text comes only from the design  *(new 2026-09-29, G542 · D541)*

**Why this phase exists.** Phase 30 / Task 3 measured that the EDS-18 header text overflows a
16 px box that `verify-design` derived (96 − 2 × 40). The design did not contain it. D541: a fixed
`width`/`height` on an element that holds text comes only from that node's own design value; the
growth that follows is listed, not graded; and a script decides.

### Phase 31 / Task 1 — The size-origin check

**Delivers** a deterministic script in the eds pack. It reads the target block's CSS, the prototype
report's design-value lines and the value table. It then reports every fixed `width` or `height`
(a length, not `min-*`/`max-*`, not `auto`/`%`) on a selector whose rendered elements hold text,
that is not a report line whose node carries that exact property and value in the table. "Holds
text" is decided from the rendered page (an element with a non-whitespace text node descendant),
through the browser role, never guessed from the selector. `eds-verify-design` runs it after every
edit, and each hit is a `[fixable]` mismatch. `eds-prototype` runs it before writing its report,
and a hit stops the write. The "content-dependent, not graded" listing gains the grown sizes.
Tests first, with fixtures: EDS-18's `th p { height: 16px }` is reported; `th { height: 96px }` is
not (it is on node `1:197`); a `min-height` is never reported.
**Depends on** nothing. Uses the `approx` column and "content-dependent, not graded" from PR #177.
**You verify** the tests fail before and pass after; the script reports exactly the 16 px line on
the delivered EDS-18 CSS (`faf86f3`).
**Reject if** a stage decides "from the design" by judgement, or a derived value passes.
*Amended 2026-09-29 while building (D542, D543):* `measure` returned no text information, so it
gains `holds_text` (core contract §6). `eds-prototype` renders nothing, so it runs the check
without a measurement, where every untied fixed size is a hit.

### Phase 31 / Task 2 — Verification

**Delivers** nothing new. Suites on `main` after Task 1 merges, plus the check run once on the
delivered EDS-18 block. Removing the 16 px from `blocks/table/table.css` is site code, so it goes
through a work item and a route run, not this task.
**Depends on** Task 1, merged.
**You verify** every suite exits 0 and the check reports the 16 px line.
**Reject if** any result is reported without being run.

# Phase 35 — Onboarding notices the design it did not apply  *(new 2026-09-30, G502)*

**Why this phase exists.** After design onboarding, the adopted tokens sit beside the boilerplate
ones and nothing reads them: in this repo `--text-link: #000` has zero `var()` consumers while links
render `var(--link-color)`, `#3b63fb`, against a manifest that says `Text/Link → #000000` (G502,
re-read 2026-09-30 at `1d7caad`: `styles/styles.css:53`, `:173`, `:272-273`). No check reports it.
The human's requirement (2026-09-22): detect the divergence, ask once, two branches — adopt by
refactor, or adopt for new components only. The human made it the next task on 2026-09-30. G502
says test first, so the design is decided in Task 3 from what Tasks 1 and 2 measure, not before.

### Phase 35 / Task 1 — Watch onboarding run on a project that disagrees with its design

**Delivers** `phase-35-task-1-done.md`: an observed run of `eds-adopt-design-system` and
`eds-complete-design-onboarding`, answering G502's three questions — what the two stages do to
tokens that disagree with the design, whether the divergence is visible at onboarding time, and
what the human is shown and asked. The run happens in a separate clone of `origin/main` whose
`styles/` and design-onboarding state are restored to `6db94bd^` (the commit before #64), so the
current stages meet the pre-onboarding site. Record every question asked, every file written, and
the final `styles/styles.css` diff.
**Depends on** nothing.
**You verify** each of the three answers cites a transcript line or a file diff from the run.
**Reject if** an answer is read off a `SKILL.md` rather than observed, or the run touches the shared
checkout.

### Phase 35 / Task 2 — How the reference implementation treats an existing design system

**Delivers** a section in `phase-35-task-2-done.md`: what `dx-core` does when a project already has
tokens that disagree with the design — read from its code. On 2026-09-30 only
`skills/dx-figma-extract/SKILL.md` mentions a design system, and it has no onboarding skill;
confirm or correct that, with file:line citations.
**Depends on** nothing.
**You verify** every claim carries a path and line in the `dx-core` checkout.
**Reject if** a claim comes from its documentation where its code says otherwise.

### Phase 35 / Task 3 — Decide where detection, the question and the answer live

**Delivers** a filed decision (D entry) made with the human from Tasks 1 and 2: which stage detects
the divergence, when the human is asked, where the answer is stored so it is asked once, and which
stages read it. A deviation entry in `06-dx-core-deviations.md` if it differs from Task 2. G502's
heading updated from NOT DESIGNED. Tasks 4 and 5 amended to the decision.
**Depends on** Tasks 1, 2.
**You verify** `check-numbering.sh` over the three registers reports `valid`.
**Reject if** the decision is taken without the human, or before Task 1's run exists.

### Phase 35 / Task 4 — The divergence is found by a script

**Delivers** a deterministic script, sited where Task 3 decided, that compares the adopted manifest
against the stylesheet the project serves and reports: adopted tokens with no `var()` consumer, and
existing tokens whose value contradicts the manifest for the same role. Tests first, with this
repo's measured case as a fixture (`--text-link` unused; `--link-color: #3b63fb` against
`Text/Link → #000000`) and a converged stylesheet that reports nothing.
**Depends on** Task 3.
**You verify** the tests fail before and pass after; on this repo's `styles/` the script reports
`--link-color` and `--text-link`.
**Reject if** any role or contradiction is decided in skill prose.

### Phase 35 / Task 5 — Ask once, record the answer, act on it

**Delivers** the question Task 3 placed, with the two branches (adopt by refactor, with the human
in the loop; adopt for new components only), the answer stored where Task 3 decided, and each
branch's effect: a refactor plan, or a rule the conventions stage applies to new components only.
**Depends on** Tasks 3, 4.
**You verify** a second run with a recorded answer asks nothing and reports the divergence as
decided, not as new.
**Reject if** the question can recur after an answer, or a branch changes a live site's styles
without the human's approval.

### Phase 35 / Task 6 — Verification

**Delivers** nothing new. Every suite touched by Tasks 4 and 5, the repository checks, and the live
half: the flow run on this repo from a fresh session that edited no plugins. Changing this site's
own `styles/` follows the human's answer and goes through a work item, not this task.
**Depends on** Tasks 4, 5, merged.
**You verify** every suite exits 0; the run reports `--link-color` against the manifest, asks once,
records the answer, and a second run does not ask again.
**Reject if** the live run is claimed from a session that edited the plugins.

# Phase 38 — Every stage writes its own envelope  *(new 2026-10-02, G129 · D113)*

**Why this phase exists.** Ten route stages end their output with a `## Result` block that the
driver copies into `envelope-<stage id>.txt` by hand (`run-route/SKILL.md`, "Getting a stage's
envelope onto disk"). The EDS-18 run of 2026-10-02 had two slips on that path (G129). The five
stages that already use `emit-envelope.sh` never needed the copy.

### Phase 38 / Task 1 — The ten stages adopt the emitter

**Delivers** `intake`, `readiness`, `conventions`, `serve`, `baseline`, `verify-design`, `plan`,
`implement`, `verify` and `lint` each write their envelope through `emit-envelope.sh` in every
`Report` node, in the wording the five adopting stages already use; and
`phase-38-task-1-done.md`.
**Depends on** nothing.
**You verify** `grep -L emit-envelope plugins/eds/skills/eds-*/SKILL.md` lists only the skills that
are not route stages; every eds suite exits 0.
**Reject if** a `Report` node still tells the stage to emit the block in its message.

### Phase 38 / Task 2 — A check that no stage skips the emitter

**Delivers** `check-gate-reporting.sh` widened (or a sibling check) so every forked eds stage skill's
`Report` nodes name `emit-envelope.sh` and `envelope-<stage id>.txt`; wired into the eds pack's CI;
a failing fixture; `phase-38-task-2-done.md`.
**Depends on** Task 1.
**You verify** the check passes on the pack and fails on the fixture and on the pre-Task-1 copy of
one stage.
**Reject if** the check reads anything but the skill files.

### Phase 38 / Task 3 — The driver drops the copy path for stages

**Delivers** `run-route/SKILL.md`: after a stage returns, an empty envelope file is a contract
violation (`failed`), with no copy step; the stamp regenerated; `phase-38-task-3-done.md`.
**Depends on** Task 2.
**You verify** the core suites exit 0, including the stamp test.
**Reject if** the copy path is removed for `create_branch`, which is a provider operation the driver
invokes itself. *Superseded 2026-10-03 by Phase 40 / Task 1 (D118): the copy path is removed for
`create_branch` too, because the harness refuses it.*

### Phase 38 / Task 4 — Verification

**Delivers** one fresh-session route run after Tasks 1–3 are merged, and `phase-38-task-4-done.md`
listing each stage's envelope with `capture-envelope.sh`'s report for it.
**Depends on** Tasks 1–3, merged.
**You verify** every stage's `capture-envelope.sh` line reads `unchanged`, and no envelope was
copied by the driver.
**Reject if** the run is driven from a session that edited the plugins.

# Phase 39 — Design boxes and the official reference  *(new 2026-10-02, G124 · D116 · D117)*

**Why this phase exists.** EDS-18's header renders 113px against the design's 96 because the
design's text spills over its bottom padding (`leading-[0]`) and every design size is border-box;
nothing translated either, so a stage had to guess (G124). And a stage deciding something no rule
covers decided from memory; the human set the rule that the official reference is read first.

### Phase 39 / Task 1 — Design sizes are border-box; a zero-leading wrapper becomes bottom padding

**Delivers** `design-context-values.py` per D116 (box-sizing rows, spill translation, `spill:`
stderr line), tests; `phase-39-task-1-done.md`.
**Depends on** PR #206 (same script).
**You verify** the EDS-18 reference yields `padding-bottom` 24.143 / 27.572 / 29.015px for
`1:197` / `1:206` / `1:215`; the suite passes.
**Reject if** a value is guessed for a non-px input instead of being printed as written.

### Phase 39 / Task 2 — The official reference is read where no rule answers

**Delivers** `reference_docs` (validator 23, `pack-manifest.md`), `shared/official-reference.md`,
one pointer in `prototype`, `implement`, `verify-design`, `lint`, the `write-specs` judgement node,
the eds pack declaring MDN, the host in the runner's allowlist; `phase-39-task-2-done.md`.
**Depends on** nothing.
**You verify** core and eds suites pass; the naming rule still holds for the core.
**Reject if** the core names the reference.

### Phase 39 / Task 3 — Verification

**Delivers** the EDS-23 run from a fresh session after PR #206 and this phase merge;
`phase-39-task-3-done.md` with the measured header (96px), the `spill:` lines, and every
`reference:` line the run wrote.
**Depends on** Tasks 1–2 merged.
**You verify** EDS-23's AC-1–AC-3 measured on the run's own render.
**Reject if** the run is driven from a session that edited the plugins.

# Phase 40 — The driver writes no verdict, and a fresh start begins clean  *(new 2026-10-03, G136 · G137 · G138 · D118 · D119 · D120)*

**Why this phase exists.** Two EDS-23 runs on 2026-10-03 stopped at the one place where the
driver's model still stood between a verdict and the file the runner branches on — the hand-copied
`create_branch` envelope the harness refuses to let the driver validate (G136) — and the second,
fresh, start found the first run's 37 files still in `.ai/run-context/`, one of which makes
`deliver` skip its attach pass (G137). A third defect, the gate refusing pre-existing dirty files at
stage 14 (G138), is decided here and built after the verification run.

### Phase 40 / Task 1 — `create_branch` writes its own envelope; a fresh start archives the run context

**Delivers** `create-branch.sh --envelope <file>` spelled by the core emitter, the skill's
`envelope:` input line, the driver passing it and dropping the copy case; `archive-run-context.sh`
with tests, run by the driver's **Fresh start** node before the marker; D118, D119, D120 filed;
contracts §4, §6, §9 and `shared/run-state.md`, `shared/result-envelope.md` amended; the stamp
regenerated; `phase-40-task-1-done.md`. Committed on `main` directly, at the human's instruction.
**Depends on** nothing.
**You verify** core and pack suites exit 0 (`create-branch.test.sh` 23, `archive-run-context.test.sh`
15); the stamp check passes; `grep -c 'Empty, after a provider' run-route/SKILL.md` is 0.
**Reject if** any node of the driver still writes to, or copies into, an envelope file.

### Phase 40 / Task 2 — Verification

**Delivers** one fresh-session EDS-23 run from `main` after Task 1, reaching `delivered` with no
human typing a command on the driver's behalf; `phase-40-task-2-done.md` with
`envelope-create-branch.txt`'s `capture-envelope.sh` line, the `archived:` line from the fresh
start, and `.ai/run-context/` listed before and after the run.
**Depends on** Task 1 on `origin/main`, and the session started after it.
**You verify** `capture-envelope.sh` reports `unchanged` for `create-branch`; `.ai/run-context/`
holds only this run's files; `deliver` attaches the manifest's files itself (no stale
`evidence-attached-by-verify`). This run also serves Phase 38 / Task 4 and Phase 39 / Task 3.
**Reject if** the driver wrote to any envelope file, or the run was driven from a session that
edited the plugins.
**Note (2026-10-03, after the run):** "`deliver` attaches the manifest's files itself" holds only when
`verify` passes clean; on a `warn`, `verify` attaches and writes the marker (D86/D88). The run's
`verify` warned, so what was checked is that the marker was the run's own
(`phase-40-task-2-done.md`).

### Phase 40 / Task 3 — A fresh start refuses a dirty working tree (D120)

**Delivers** a deterministic core script that lists every tracked change and untracked, unignored
path in the project root and exits non-zero naming them, run by the driver's **Fresh start** node
before `archive-run-context.sh`, routing to `blocked` with the paths as the reason; tests; the
**Resume** node exempt; `shared/run-state.md` and contract §9 amended; `phase-40-task-3-done.md`.
**Depends on** Task 2 (so the verification run tests Task 1 alone).
**You verify** a dirty tree is refused at stage 0 naming the paths; a clean tree passes; a resume on
a dirty tree is never checked.
**Reject if** the check moves into pre-flight, or the gate's own change-set rule is loosened.
**Built 2026-10-03** (`phase-40-task-3-done.md`): `check-tree-clean.sh` reuses
`list-changed-files.sh`, so a branch with commits not on the default branch is refused too — the gate
counts them. The live check (a fresh start refused at stage 0) is the next route run.

# Phase 43 — The design loop sees every breakpoint, and a stage calls an operation every time  *(new 2026-10-04, G155 · G144 · D123)*

**Why this phase exists.** The EDS-24 verification run (`phase-42-verification-done.md`) failed at
`verify`, stage 12/15: `prototype`'s `table-layout: fixed` matched the design at 1440 and broke the
table at 375, and no stage before `verify` renders any width but the reference's (G155). The same run
left one residual of G144: `verify-design` ran capture and measure on its second check without
invoking their operations again.

### Phase 43 / Task 1 — Every operation call goes through its own skill invocation (G144)

**Delivers** `shared/role-operations.md` stating that each call of an operation is its own skill
invocation — an operation loaded earlier in the same stage licenses nothing later, and one invocation
runs one script; `eds-verify-design` and `eds-verify` point at that rule at each browser call site
(through `skill-creator`); a test that fails on the contract without the rule;
`phase-43-task-1-done.md`. `check-direct-script-calls.sh` is unchanged (the human's decision).
**Depends on** nothing.
**You verify** the new test fails before and passes after; `check-direct-script-calls.sh` on the
EDS-24 `verify-design` transcript still reports its 2 direct calls; core and eds suites pass;
validators valid.
**Reject if** the checker's licence rule is relaxed, or the rule lives only in a `SKILL.md`.

### Phase 43 / Task 2 — What a regression is at a width with no reference (G155, measure first)

**Delivers** measurements on the EDS-24 draft at each declared breakpoint, with the run's CSS and with
`main`'s: candidate signals a script can compute from `measure`/`render` output (a word broken across
lines, a box narrower than its own `min-width`, horizontal overflow outside a scroll container, a size
that changed against the pre-change render); for each, whether it fires on EDS-24's 375 and stays quiet
on `main` and on the delivered EDS-18/EDS-23 tables. Numbers for the human; no rule, no code.
`phase-43-task-2-done.md`.
**Depends on** nothing.
**You verify** every candidate has a fires/quiet result on each page and width, measured, not argued.
**Reject if** a rule is chosen without the human, or a candidate is reported unmeasured.

### Phase 43 / Task 3 — `verify-design` renders every breakpoint (D123)

**Delivers** the breakpoint list from the project's stylesheet by a deterministic script (or `verify`'s
existing one, reused); `measure` taking a width (G140), reporting `min-width` and, per selector, the
words whose line boxes span lines — contract §6 (D522's fixed property set) amended first;
`verify-design` capturing and measuring each width; a deterministic script turning signal A (broken
word) and signal B (narrower than its own `min-width`) into `[fixable]` lines within the existing
`fix_attempts` budget (the human's choice, 2026-10-04: A and B together); tests first;
`phase-43-task-3-done.md`.
**Depends on** Task 2 and the human's choice.
**You verify** the script fires on the EDS-24 375 measurement and not on `main`'s; suites pass.
**Reject if** the regression judgement is prose in the `SKILL.md`, or a new budget is introduced.

### Phase 43 / Task 4 — Verification

**Delivers** the EDS-24 run from a fresh session after Tasks 1 and 3 merge, reaching `delivered`;
`phase-43-task-4-done.md` with the checks of the EDS-24 verification prompt (`NEXT.md`) re-run.
**Depends on** Tasks 1 and 3 merged.
**You verify** `verify-design`'s report covers every breakpoint and the run's change holds at 375;
`check-direct-script-calls.sh` → `ok`; the run serves Phase 28 / Task 9, Phase 25 / Task 8, Phase 6 /
Task 5 and Phase 18 / Task 4.
**Reject if** the run is driven from a session that edited the plugins.

### Phase 43 / Task 5 — A selector hidden at a measured width does not fail the read (G157)

**Delivers** a fix shape chosen with the human from G157's three (a `hidden` flag in `measure`'s
output, §6 amended first; a stage branch for a `fail` measure envelope; or another), tests first;
`phase-43-task-5-done.md`.
**Depends on** Task 4 (the human's choice, 2026-10-04: the EDS-24 run first, it does not hit G157).
**You verify** a measure at 375 naming a selector the page hides there no longer waits 10 s and fails
(measured, `.nav-sections` on `drafts/EDS-24`); suites pass.
**Reject if** `measure`'s output changes without §6 saying so, or the fix is prose in a `SKILL.md`.

# Phase 44 — The EDS-24 run's remaining gaps  *(new 2026-10-05, G159 · G160 · G140 · G161 · G158; filed with the human's yes from `fix-brief-eds-24-gaps.md`)*

**Why this phase exists.** The EDS-24 run (`phase-43-task-4-done.md`) delivered and left five
defects open: duplicate coverage gaps in the evidence manifest (G159), a false reason for `min-width`
in the value comparison (G160), `verify` measuring once at the default width (G140's `verify` half),
no `analytics.md` at the terminal state (G161), and design fonts the human put out of scope arriving
as "Action needed" on the work item (G158). G157 has its own task (Phase 43 / Task 5). G149 and G151
need no code, only a run that reaches their case (Task 6).

### Phase 44 / Task 1 — The evidence manifest holds each coverage gap once, and says which node (G159)

**Delivers** one deterministic script in `plugins/eds/shared/scripts/` that both `verify-design` and
`verify` call instead of their inline merge: union of `attachments` and of `coverage_gaps`, first
occurrence kept, order kept, file created when absent; the per-line coverage gaps built by a script
from the comparison outputs (each line names its selector and property, identical lines collapse to
one carrying a count), with those outputs written under `.ai/run-context/`; tests first;
`phase-44-task-1-done.md`, which also says whether `delivery-text.py` collapses repeats (G535).
**Depends on** nothing.
**You verify** the merge script on a manifest holding an overlap (no duplicate, order kept) and on
an absent manifest; the gap builder on the archived EDS-24 outputs (27 `Dividers/Divider 1` lines → one
per selector, with a count); on the archived EDS-24 inputs the merged list has no exact duplicate; on
the next run `jq '.coverage_gaps | length == (unique | length)' evidence-manifest.json` → `true`.
**Reject if** the de-duplication or the line format lives only in skill prose, or order changes.

### Phase 44 / Task 2 — `min-width` gets its own reason in the value comparison (G160)

**Delivers** a `compare-design-values.py` row whose property is `min-width` with its own reason
(checked by the breakpoint regression check against the element's own width, never against the
design value); the header comment names `min-width` as in `measure`'s set and excluded on purpose;
tests first; `phase-44-task-2-done.md`.
**Depends on** nothing.
**You verify** `compare` on the EDS-24 files prints the new reason for the three column `min-width`
rows; existing cases unchanged.
**Reject if** `min-width` starts being compared against a design value.

### Phase 44 / Task 3 — `verify` measures at every width it captures (G140, the `verify` half)

**Delivers** `verify`'s **Capture and measure the rendered page** step 2 invoking `measure` once per
capture width (each its own `Skill()` invocation, with `width: <w>`), recording which file belongs to
which width, every responsiveness criterion judged on the measurement at its own width; whether
`verify` also runs `check-breakpoint-regressions.py check` over its measurements is the human's
decision, asked first; any deterministic piece tested first; `phase-44-task-3-done.md`.
**Depends on** nothing (Task 5 of Phase 43 makes a hidden selector at 375 harmless).
**You verify** on the next live run `verify-report.md` names one measurement file per width and each
file's `width` matches (`jq .width`); `check-direct-script-calls.sh eds <verify transcript>` → `ok`;
`check-role-operations-read.sh` passes.
**Reject if** `verify` measures once, or reads a width from a file it did not take.

### Phase 44 / Task 4 — The driver renders `analytics.md` at every terminal state (G161)

**Delivers** the mechanism the human chooses (a terminal-node step calling `render-analytics.sh`
with a path a deterministic helper resolves; a `Stop`/`SubagentStop` hook rendering from the hook
input's `transcript_path`; or both), designed only after the official Claude Code documentation
answers how the driver learns its own transcript path; `analytics.md` covers only this run's window
or says plainly that the orchestrator row is the whole session; the `run-route/SKILL.md` stamp
regenerated; a test suite with a fixture transcript for any new script; `phase-44-task-4-done.md`.
**Depends on** nothing.
**You verify** the next run ends with `.ai/run-context/analytics.md` written by the driver (mtime
before the terminal line), one row per stage.
**Reject if** a number is produced by asking the model (D14), or the core names a platform.

### Phase 44 / Task 5 — Design fonts the human put out of scope are not "Action needed" (G158)

**Delivers** the shape the human chooses (an out-of-scope declaration read by `design-fonts.py` so
neither `conventions` nor `verify-design` warns and `delivery-text.py` never sees the gap; D530
amended so a font-only content-asset gap is information, not an action; or only the note's
classification), D530 amended first (dated), then `design-fonts.py`, its test and the consumers;
tests first; `phase-44-task-5-done.md`.
**Depends on** nothing.
**You verify** on the archived EDS-24 inputs `delivery-text.py note` prints no font line under Action
needed; on the next run `conventions` does not warn for fonts.
**Reject if** a font is added, downloaded or substituted, or the decision is taken without the human.

### Phase 44 / Task 6 — Verification

**Delivers** nothing new: every suite, the repository checks, and two live runs from fresh sessions
that edited no plugins, after Phase 43 / Task 5 and Phase 44 / Tasks 1–5 merge — run A, a fresh design
item written through `write-specs` (ideally leaving a width difference at 1440 so G151 is reached),
and run B, `/agentic-core:run-route EDS-24` (already merged, G149's satisfied path);
`phase-44-task-6-done.md` with each gap's quoted closing line.
**Depends on** Phase 43 / Task 5 and Tasks 1–5 merged.
**You verify** `find plugins -name '*.test.sh'` → every suite passes (counted); the five repository
checks → `valid`; run A → `delivered` with G157's `hidden: true` (if a selector hides), G140's one
measurement per width, G159's `length == (unique | length)` → `true`, G160's reason, G161's
`analytics.md`, G158's note without a font line under Action needed, G151 if reached,
`check-direct-script-calls.sh` → `ok`; run B → `satisfied …`, a note on EDS-24, `terminal: blocked`,
no branch created (G149 CLOSED); `check-status-claims.mjs` → all match; `check-numbering.sh` → `valid`.
**Reject if** a run is driven from a session that edited the plugins, or a gap is closed on a line
nobody quoted.

## Phase 45 — The size-origin check reads only the run's own changes

### Phase 45 / Task 1 — The size-origin check reads only the run's own changes (G162)

**Delivers** `check-size-origin.py check … --base <rev>`: only a fixed width or height the run added or
changed — not in the block file at the merge base of `<rev>` and `HEAD` — can be a hit (D548);
`eds-prototype/SKILL.md` "Check the size origin" passes `--base origin/HEAD`; `verify-design`'s measured
call is unchanged; D548 filed, D543 point 3 amended; tests first; `phase-45-task-1-done.md`; G162 FIXED.
**Depends on** Phase 44 merged.
**You verify** on a block file with a pre-existing untied `width: 2em` and a run-added tied `height: 711px`,
`check … --base main` → exit 0; a run-added untied width → exit 1; a pre-existing untied size the run edited →
exit 1; the same after the run's work is committed → unchanged.
**Reject if** the diff base is `HEAD` (empty once the run is committed), the stage renders anything, or
`run-route/SKILL.md` changes.

### Phase 45 / Task 2 — Verification

**Delivers** nothing new: every suite under `plugins/`, the five repository checks, `check-status-claims.mjs`,
`check-numbering.sh` on 03/04/05, and the script run on the EDS-25 inputs
(`.ai/logs/run-context-2026-10-05-101356/`) against the original `features-carousel.css` (`5914551`) plus the
draft's two changes (`prototype-report.draft.md:8`): `border-radius: 12px` → `30px`, and
`.features-carousel .features-carousel-media img { height: 711px; }` inside the existing
`@media (width >= 900px)`; nothing else (`f2648a1`'s `aspect-ratio: auto` is not one of them).
**The block file must sit in a git checkout whose merge base holds the original:** `--base` runs `git` in the
file's own directory (D548 point 3), so a file in a bare `$TMPDIR` folder exits 2 (`no merge base …`). Use a
scratch clone in `$TMPDIR` (`git clone --no-checkout <repo>`, `git checkout --detach 5914551`, copy the built file
over `blocks/features-carousel/features-carousel.css`); never build it in the project tree.
**Depends on** Phase 45 / Task 1.
**You verify** suites → `pass=<n> fail=0` (no suite launches a browser, so all run sandboxed); the five checks
(names and arguments as in `phase-44-task-6-done.md` "Before each run") → `valid`; `check-status-claims.mjs` →
all match; `check-numbering.sh` → `valid`; in the scratch clone `check … --base main` → exit 0, the same without
`--base` → exit 1 (G162 as filed).
**Reject if** a count is quoted that was not run, or the block file was built in the project tree.
*Amended 2026-10-05 after the run (`phase-45-task-2-done.md`, defects 1–3): the checkout requirement, the exact
two rules and the sandbox note were missing.*

# Phase 46 — Prove the plugin-location mechanisms  *(new 2026-10-06, `31-plugin-marketplace-migration-spec.md`; entries numbered in Task 5: D126–D128, G172–G173)*

**Why this phase exists.** The six plugins move into `agenticDraft/plugins` (Phases 46–50). From the plugin
cache they cannot reach each other through sibling folders (spec §1–§2). The replacement (spec §4) rests on
four documented behaviours that nobody here has run (spec §3). Each is proven on a throwaway `spike/*` branch
of `agenticDraft/plugins` before Phase 47 depends on it. Nothing in this repo changes. A failed spike stops
the plan until the human picks another mechanism.

### Phase 46 / Task 1 — A symlink is copied in on a GitHub install

**Delivers** two toy plugins on `spike/symlink` of `agenticDraft/plugins`: `a/shared/hello.sh` and
`b/core → ../a/shared`; `b` installed from the `github` source with `ref: spike/symlink`, and again from a
local path; `phase-46-task-1-done.md`.
**Depends on** nothing.
**You verify** `claude plugin list --json` → `b`'s `installPath` under `cache/`; `<installPath>/core/hello.sh`
is a regular file (not a link) with the exec bit set; from the local path, `core/` is missing (the documented skip).
**Reject if** the proof uses a local or directory source, or a result is quoted that was not run.

### Phase 46 / Task 2 — A `SessionStart` hook sees the installed path

**Delivers** a toy plugin whose `SessionStart` hook writes `${CLAUDE_PLUGIN_ROOT}` to
`$CLAUDE_PROJECT_DIR/.ai/run-context/plugin-roots/<name>`; `phase-46-task-2-done.md`.
**Depends on** Phase 46 / Task 1 (same spike branch).
**You verify** after an interactive session the file holds the cache path; under `--plugin-dir` it holds the
dev path; a headless run through `route-agent.mjs` also writes it. Run outside the sandbox: nested hooks fail
with EPERM under `~/.claude/` inside it.
**Reject if** the check ran in a sandboxed nested session and was read as a failure of the hook.

### Phase 46 / Task 3 — `extraKnownMarketplaces` pins a tag

**Delivers** tag `spike-v1` on the spike branch; a scratch project with
`extraKnownMarketplaces.agenticdraft-spike.source = {source: "github", repo: "agenticDraft/plugins", ref: "spike-v1"}`
(*corrected 2026-10-06, Phase 46 / Task 6:* the key is `agenticdraft-spike`, the name the spike branch's
`marketplace.json` declares; a user-scope `agenticdraft` directory marketplace already exists and is never
touched); `phase-46-task-3-done.md`.
**Depends on** Phase 46 / Task 1.
**You verify** the installed copy matches the tag, not the branch tip: after tagging, a marker file is committed
on `spike/symlink` (*corrected 2026-10-06:* never on `main` of `agenticDraft/plugins`) and pushed, and that
file is absent from the installed copy. If it is present, the fallback is `source.ref` per plugin in
`marketplace.json`; record which one works. *(added 2026-10-06, Task 2's defect 3)* "No collateral change" is a
diff of `~/.claude/plugins/known_marketplaces.json` and `installed_plugins.json` copied before and after, never of
`claude plugin marketplace list` text, whose display changed between two runs with nothing stored changed.
**Reject if** the docs are quoted as the proof, or the `agenticdraft` marketplace or `agenticDraft/plugins` `main`
changed.

### Phase 46 / Task 4 — A pack's npm dependency installs from its root

**Delivers** a toy plugin with `package.json` and `package-lock.json` depending on `playwright` and a script
that runs `require('playwright')`; `phase-46-task-4-done.md`. **Runs only with the human's yes:** it installs
an npm package on this machine.
**Depends on** Phase 46 / Task 1.
**You verify** the `require` resolves from the cache copy; where `node_modules` landed; whether a browser
binary was downloaded (expected: no); *(added 2026-10-06, Phase 46 / Task 6)* "no collateral change" is a diff of
the copied `known_marketplaces.json` and `installed_plugins.json`, not of `claude plugin marketplace list` text.
**Reject if** it ran without the human's yes.

### Phase 46 / Task 5 — Record the result

**Delivers** the spec §7 entries filed with numbers from `doc-numbering` (the location D in `03-core-design.md`,
the install D, the freeze D, the two G entries in `05-gap-register.md`), each marked with the spike that backs
it; spike branch and tag deleted; `phase-46-task-5-done.md`. *(corrected 2026-10-06, Phase 46 / Task 6:)* the
cache and data leftovers of Tasks 1–2 (`cache/agenticdraft-spike{,-local}/`, `data/*-inline/`, the scratch
folders) were already deleted on 2026-10-06 with the human's yes; only the spike branch, the tag and whatever
Tasks 3–4 leave remain for this task. Spec §3's line "for a local-path or directory source, only symlinks inside
the plugin are kept" is corrected here (Task 1: a directory marketplace loads in place).
**Depends on** Phase 46 / Tasks 1–4.
**You verify** `check-numbering.sh` on 03/04/05 → `valid`; every spike has a recorded pass or fail;
`git ls-remote origin 'spike*'` on `agenticDraft/plugins` → empty; *(added 2026-10-06)* "no collateral change" is
a diff of the copied `known_marketplaces.json` and `installed_plugins.json` against the copies taken before
Task 3, not of `claude plugin marketplace list` text.
**Reject if** a D entry is filed for a mechanism whose spike failed.

### Phase 46 / Task 6 — Fix what Phase 46 / Task 2 found  *(new 2026-10-06; runs before Task 3)*

**Delivers** the runner's header and startup log name both plugin sources — the set loaded by path from
`ROUTE_PLUGIN_DIR` and the `enabledPlugins` the project's resolved settings bring — and, for a name in both, say
that the path copy overrides the installed one; the decision in a pure helper `shared/runner/plugin-sources.mjs`
with `plugin-sources.test.mjs` written first (Task 2 defect 8; no behaviour change beyond logging); one G entry
per Task 2 defect (1, 2, 3, 6, 7, 8, 9) in `05-gap-register.md`, numbered through `doc-numbering`; the registry
requirements (defect 9 and the async note) added to the Phase 47 / Task 2 entry as `resolve-plugin-root.test.sh`
cases; the bare-project requirement (defect 6) added to Phase 48 / Task 4 and the `ROUTE_PLUGIN_DIR` requirement
to Phase 49 / Task 2; the procedure corrections (defects 2, 3) in Phase 46 / Tasks 3–5; the human's answers on
the SDK pin (defect 7) and the blank screen (defect 1) recorded, nothing investigated; `phase-46-task-6-done.md`.
**Depends on** Phase 46 / Task 2.
**You verify** `node --test plugins/agentic-core/shared/runner/*.test.mjs` → every suite passes, the new one
included; `validate-naming-rule.sh plugins/agentic-core` → `valid`; `check-numbering.sh` on 03/04/05 → `valid`;
`git diff main -- plugins/` shows only the helper, its test, and comment and log changes in `route-agent.mjs`
(the `plugins` array handed to the SDK and every exit path unchanged).
**Reject if** the runner change alters which plugins load or how a run ends; the test was written after the
code; a G or D number was picked without `doc-numbering`; the SDK pin changed or an install ran without the
human's yes; a platform name entered `plugins/agentic-core`; a `SKILL.md` was edited by hand; a result is quoted
that was not run.

# Phase 47 — Make the plugins location-independent  *(new 2026-10-06, spec §4; the plugin freeze starts here)*

**Why this phase exists.** All of this happens in this repo, under the old names, before anything moves, so
the history carries the fix and the full suite proves it first.

**Precondition: the plugin freeze starts at Phase 47 and runs until Phase 49 / Task 3.** No track other than
this migration edits `plugins/` in that window (spec §6). Before Task 1, no open branch, local or on origin,
may touch `plugins/`:

```bash
git fetch origin
for b in $(git branch -a --no-merged origin/main --format='%(refname:short)' | grep -v '^upstream'); do
  [ -n "$(git diff --name-only origin/main...$b -- plugins/)" ] && echo "$b"
done
```

The loop must print nothing. Every branch it prints is merged or closed, with the human's yes, before Task 1.
Measured 2026-10-06 without a fetch: 110 branches (spec §2).

### Phase 47 / Task 1 — The contract stops naming sibling folders

**Delivers** the D126 location rule (spec §7) in `01-core-contracts.md` in place of "installed pack = sibling
directory"; `run-route/SKILL.md:76-79` (through skill-creator) to match; `agentic-core/README.md` "How it handles
it" and "Design rules a pack must respect" rewritten to explain how plugins find each other (roles, the root
registry, the `core` symlink, the result envelope), naming no platform or tool; `phase-47-task-1-done.md`.
*(added 2026-10-08, precondition defect 8:)* `01-core-contracts.md` holds no sibling-folder wording to replace
(measured); the convention lives in `run-route/SKILL.md:76-78` and `agentic-core/README.md:191`, so the contract
*gains* the D126 rule.
**Depends on** Phase 46 / Task 5; the precondition above (met 2026-10-08, `phase-47-precondition-done.md`).
**You verify** `grep -n 'sibling' 01-core-contracts.md plugins/agentic-core/skills/run-route/SKILL.md
plugins/agentic-core/README.md` → no rule left that locates a plugin through `..`; `validate-naming-rule.sh plugins/agentic-core`
→ `valid`.
**Reject if** `SKILL.md` was edited by hand.

### Phase 47 / Task 2 — A root registry and a resolver in the core

**Delivers** `shared/lib/register-plugin-root.sh` (each plugin's `SessionStart` hook calls it) and
`shared/lib/resolve-plugin-root.sh <name>` (registry first, then sibling folder, non-zero exit when neither
exists); a `SessionStart` entry in `agentic-core/hooks/hooks.json`; tests first;
`phase-47-task-2-done.md`.
*Added 2026-10-06 (Phase 46 / Task 6, from Task 2's defect 9 and its architecture note):* the hook entry that
writes the registry declares no `async` (an async hook is backgrounded and the first tool call can run before
the file exists); the resolver compares **canonical** paths (`realpath` on both sides — `/tmp` is `/private/tmp`
on macOS, and `projectPath` / `CLAUDE_PROJECT_DIR` carry the canonical form while a caller may pass the other);
a missing registry file means "not resolved" (try the sibling fallback, then exit non-zero) and is never
reported as the plugin being absent.
*Added 2026-10-08 (Phase 47 / Task 1, defect 5; the human's decision):* a `SessionStart` entry in each of the five
packs' `hooks/hooks.json` too, calling the core's `register-plugin-root.sh` with no `async`. Until Task 3's `core`
link exists the call goes through `${CLAUDE_PLUGIN_ROOT}/../agentic-core/shared/lib/`, which Task 3's rewrite turns
into `${CLAUDE_PLUGIN_ROOT}/core/lib/`. Without these entries an installed core resolves no pack.
**Depends on** Phase 47 / Task 1.
**You verify** `resolve-plugin-root.test.sh`: registry hit; sibling fallback; a registry entry pointing at a
path that does not exist → refused; an unknown name → non-zero exit; *(added 2026-10-06)* a registry entry
written as `/tmp/<x>` resolves equal to `/private/tmp/<x>` (and the reverse) on a machine where they are the
same directory; a registry directory that does not exist → the output says not resolved, the sibling fallback
is tried, and the word "absent" (or any claim that the plugin is not installed) does not appear; the
`SessionStart` entry in `hooks.json` has no `async` key (`jq` over the file → `null`).
**Reject if** the resolver falls back silently or names a pack.

### Phase 47 / Task 3 — Pack → core through a `core` symlink

**Delivers** `core → ../agentic-core/shared` in each of the five packs; a rewrite script that turns
`${CLAUDE_PLUGIN_ROOT}/../agentic-core/shared/` and `../../../agentic-core/shared/` into
`${CLAUDE_PLUGIN_ROOT}/core/`, checks every new path exists and records how many it rewrote; the seven
executed scripts resolve `$SCRIPT_DIR/…/core/`; `SKILL.md` edits through skill-creator;
`phase-47-task-3-done.md` with the rewrite count.
*Added 2026-10-08 (Phase 47 / Task 2, defect 3):* the five packs' `hooks/hooks.json` call the writer as
`${CLAUDE_PLUGIN_ROOT}/../agentic-core/shared/lib/register-plugin-root.sh`; the rewrite covers those five JSON files
too, not only `*.md` and `*.sh`, and `claude plugin validate` on each pack passes afterwards. Until then an
installed pack's hook finds no writer and the pack is not registered.
**Depends on** Phase 47 / Task 2.
**You verify** `grep -rn 'agentic-core/shared' plugins/{eds,jira,github,figma,playwright}` → only the symlink
targets; every suite under `plugins/` → `fail=0`.
**Reject if** the table's counts are quoted instead of the script's own.

### Phase 47 / Task 4 — eds reaches its own files without `../eds/`

**Delivers** the `${CLAUDE_PLUGIN_ROOT}/../eds/` references rewritten to `${CLAUDE_PLUGIN_ROOT}/`;
`phase-47-task-4-done.md`.
**Depends on** Phase 47 / Task 3.
**You verify** `grep -rn '\.\./eds/' plugins/eds` → empty; eds suites → `fail=0`.
**Reject if** any is left, since the rename in Phase 48 would break it a second time.

### Phase 47 / Task 5 — Core → pack and pack → pack through the resolver

**Delivers** the `../<packs.X>/` references, `setup` and `health` pack discovery and the default
`--plugins-root` of `check-branch-name.sh` moved to `resolve-plugin-root.sh`; the branch check fails closed
when the platform pack cannot be resolved; tests first; G172 (the spec §7 G for the branch check) FIXED;
`phase-47-task-5-done.md`.
*Added 2026-10-08 (Phase 47 / Task 1, defect 4):* also `run-route/SKILL.md:91` (the interim sibling rule) and
`:362` (pre-flight's `${CLAUDE_PLUGIN_ROOT}/../<pack name>/pack.yaml`), through skill-creator, regenerating the
D509 stamp with `instructions-stamp.sh --write`.
*Added 2026-10-08 (Phase 47 / Task 2, defect 7):* `resolve-plugin-root.sh` reads the registry under
`--project-dir`, else `$CLAUDE_PROJECT_DIR`, else the git top level of the working directory. A caller running in a
linked worktree (a gate under `isolation: worktree`) gets the worktree's top level, which holds no registry; such a
caller passes `--project-dir` with the main checkout. Inferred from the code, not measured.
*Added 2026-10-09 (Phase 47 / Task 4, defect 6; the human's decision):* contract §11.2 gains one line — a pack
reaches its own files as `${CLAUDE_PLUGIN_ROOT}/<path>`, never through `..` — and a check that fails on
`${CLAUDE_PLUGIN_ROOT}/../<the pack's own name>/` in any pack, tests first. The pack names come from each pack's
own manifest, so the check names no pack. Also: `run-route/SKILL.md:362` has moved to `:374` (measured 2026-10-09).
*Done 2026-10-09 (`phase-47-task-5-done.md`):* resolver `--list` / `--list --siblings`, `check-own-root-refs.sh`,
`register-source-tree.sh` (test helper), branch check exit 4, hook on the main checkout's registry; G172 FIXED.
**Depends on** Phase 47 / Task 2.
**You verify** a `check-branch-name.test.sh` case with no resolvable pack → non-zero exit; a valid name with the
pack registered → exit 0.
**Reject if** "unconstrained" is still a possible result of a missing pack.

### Phase 47 / Task 6 — No hard-coded `plugins/` path in executed code

**Delivers** `check-driver-read.sh:62` builds its contract allowlist from `${CLAUDE_PLUGIN_ROOT}/shared`;
`check-direct-script-calls.sh:107` also matches `…/cache/<mkt>/<pack>/<ver>/skills/…`;
`route-agent.mjs:70` loses its `"plugins"` default (a missing `ROUTE_PLUGIN_DIR` is an error); tests first;
G173 (the spec §7 G for the regex) FIXED; `phase-47-task-6-done.md`.
**Depends on** Phase 47 / Task 2.
**You verify** `check-driver-read.test.sh` allows a contract read under a cache-shaped root;
`check-direct-script-calls.test.sh` reports a direct call through a cache path; `node --test` on the runner →
`fail 0`.
**Reject if** a repo-relative `plugins/` literal is left in executed code.
*Built 2026-10-09 (`phase-47-task-6-done.md`):* the runner default had moved to `route-agent.mjs:74`; a missing
`ROUTE_PLUGIN_DIR` is exit `7`, and `.github/workflows/route-trigger.yaml` now sets `ROUTE_PLUGIN_DIR: plugins` until
Phase 49 / Task 2 changes it. Also moved onto the resolver: `plugins/jira/scripts/md-to-adf.test.sh:200`, a pack → pack
`plugins/$PLATFORM` that Task 5's grep missed. The `plugins/<pack>/skills/` alternative in
`check-direct-script-calls.sh` stays: it recognises a path-loaded transcript, not a path the script opens.

### Phase 47 / Task 7 — This repo's own values leave the eds pack

**Delivers** the preview host suffix (`preview-url.sh:44`) and the branch limit 23 (`check-branch-length.sh`,
`pack.yaml`) read from `.ai/project-config.yaml`; `preview-url.test.sh`, `check-branch-length.test.sh` and
`design-fonts.test.sh` on their own fixtures, no longer reading this repo's `origin` or `styles/*.css`;
`phase-47-task-7-done.md`.
*Added 2026-10-08 (Phase 47 / Task 3, defect 8):* `eds/shared/scripts/delivery-text.test.sh:219` reads the whole core
plugin as `$SCRIPT_DIR/../../../agentic-core`, which the `core` link (only `shared/`) cannot serve; outside this
source tree the folder is absent and its boundary case passes vacuously. Inferred from the code, not run.
*Added 2026-10-09 (Phase 47 / Task 5):* the eds suites that still climb out of their plugin are exactly
`design-fonts.test.sh:14`, `check-branch-length.test.sh:12`, `preview-url.test.sh:13` (this repo's root) and
`delivery-text.test.sh:219` (the core plugin by folder). The core's own real-tree cases no longer do: they register the
source tree into a temp project with `core/lib/register-source-tree.sh` and read `resolve-plugin-root.sh --list`,
the pattern the two eds suites reaching the tracker pack now use too.
**Depends on** nothing in this phase.
**You verify** the three suites pass from a copy of `plugins/` outside this repo (`$TMPDIR` scratch).
**Reject if** a test still reads the host repo.
*Built 2026-10-09 (branch `phase-47-task-7`, not committed): D129 — `branch_name.max_length` is a core config key
read by `check-branch-name.sh` (the manifest keeps `pattern`; `max_length` there is invalid), `platform:` is a
role-keyed block the core does not read, holding `preview_host_suffix`; both eds scripts refuse with exit 4 when
their value is absent. The four suites run on fixtures; all pass from an outside copy with a non-git cwd.*

### Phase 47 / Task 8 — The playwright pack declares its own dependency

**Delivers** `package.json` and `package-lock.json` at `plugins/playwright/`, `playwright` pinned to
`1.63.0` (this repo's version); the remedy text in `pack.yaml` and the comment at `probe-tool.cjs:28`
corrected; `phase-47-task-8-done.md`.
**Depends on** Phase 46 / Task 4 passed; the install D filed (D127, 2026-10-06).
**You verify** playwright suites → `fail=0`; `pack.yaml` no longer says "add playwright as a project
devDependency".
**Reject if** any core or pack script runs an install command.
*Built 2026-10-09 (branch `phase-47-task-8`): `package.json` and a lockfile v3 copied from this repo's own locked
`playwright`/`playwright-core` 1.63.0 entries (no npm command run), `.gitignore` for `node_modules/`; the playwright
remedy names the host install and `npm ci` for a path-loaded pack, the chromium remedy is `npx playwright@1.63.0
install chromium` (the human's choice); `declared-dependency.test.sh` 11/0. The global fallback stays (G176).*

### Phase 47 / Task 9 — Consumers outside `plugins/` use the resolver

**Delivers** `.claude/skills/write-specs/scripts/check-spec.py:360-376` and `write-item.py:123` resolve pack
roots through `resolve-plugin-root.sh` instead of `os.path.join("plugins", …)` (Edit tool: the sandbox blocks
Bash writes under `.claude/skills/`); `phase-47-task-9-done.md`.
**Depends on** Phase 47 / Task 2.
**You verify** `write-specs`' own checker on an existing draft → unchanged result.
**Reject if** a `plugins/` literal is left in either script.
*Built 2026-10-10 (branch `phase-47-task-9`): the human chose the registry bootstrap — the script reads only the
core's own entry to find the resolver, then asks the resolver for every root, the core's included (§11.2 amended).
`check-spec.py` `plugin_root()`; `write-item.py` calls it. 13 drafts byte-identical before and after;
`check-spec.test.sh` 22/0 (7 new cases, seen failing first).*

### Phase 47 / Task 10 — Verification

**Delivers** nothing new.
**Depends on** Phase 47 / Tasks 1–9 merged.
**You verify** 131 test files → `fail=0`; a route run with `--plugin-dir` on a real ticket → `delivered`;
`grep -rn '\.\./agentic-core\|\.\./eds/' plugins` → nothing outside the symlinks; `check-status-claims.mjs` →
all match.
**Reject if** a count is quoted that was not run.

# Phase 48 — Move with history and rename  *(new 2026-10-06, spec §5)*

**Why this phase exists.** `git subtree split` does not follow renames, so the split uses the old paths and
the add step puts each plugin under its new folder name.

### Phase 48 / Task 1 — Split each plugin's history

**Delivers** the split base and six split branches:

```bash
git rev-parse HEAD   # the split base; record it in phase-48-task-1-done.md
for p in agentic-core eds jira github figma playwright; do
  git subtree split --prefix=plugins/$p -b split/$p
done
```

and `phase-48-task-1-done.md` with the split base.
**Depends on** Phase 47 / Task 10.
**You verify** `git log --oneline split/<p> | wc -l` equals `git log --full-history --no-merges --oneline -- plugins/<p> | wc -l` for
each (the default path log drops commits that history simplification hides); the `core` symlinks are in `split/eds`.
**Reject if** the split base is not recorded.

### Phase 48 / Task 2 — Add the plugins to the marketplace repo

**Delivers** on branch `migrate-plugins` (the branch-name hook caps names at 23 characters) of `agenticDraft/plugins`:
`git subtree add --prefix=plugins/agentic-core <this repo> split/agentic-core`, and the same for
`split/eds` → `plugins/agentic-eds`, `jira` → `agentic-jira`, `github` → `agentic-github`, `figma` →
`agentic-figma`, `playwright` → `agentic-playwright`; `phase-48-task-2-done.md`.
**Depends on** Phase 48 / Task 1.
**You verify** `git rev-list --count <subtree merge>^2` there equals `git log --oneline split/<p> | wc -l` (a path-limited log cannot see the imported commits, they sit at the repository root); every
`core` symlink resolves.
**Reject if** a plugin was copied without history.

### Phase 48 / Task 3 — Rename the identifiers

**Delivers** `plugin.json` `name` in the five packs; `version` `0.2.0` in all six; `eds:` → `agentic-eds:` in
skill and agent references (including `agent: eds:eds-gate-reviewer` in `eds-plan-gate` and
`eds-publish-gate`), `jira:`, `github:`, `figma:fetch-reference`, `playwright:` → `agentic-*:`;
`figma:figma-design-to-code` and `mcp__plugin_figma_figma__*` untouched; the tests that read
`../../../../jira/pack.yaml` fixed; six `marketplace.json` entries in the existing style;
`phase-48-task-3-done.md`.
**Depends on** Phase 48 / Task 2.
**You verify** `grep -rnE '(^|[^-[:alnum:]_])(eds|jira|github|playwright):[a-z]' plugins/agentic-*` → empty (a bare `\b` still matches `agentic-eds:`); tests resolve a pack by `resolve-plugin-root.sh agentic-<p>`, not by a `../../../../jira/pack.yaml` path;
`claude plugin validate .` and `--strict` per plugin → pass.
**Reject if** an official Figma plugin name changed.

### Phase 48 / Task 4 — Tests and CI in the marketplace repo

**Delivers** `validate-agentic-core.yaml`, `validate-eds-pack.yaml`, `validate-playwright-pack.yaml` on the new
paths; `scripts/run-tests.sh` running every `*.test.sh` and the runner's `node --test`; a CI check that a plugin
whose files changed also changed its `version`; the layout section of that repo's `CLAUDE.md` and README; a user
guide `docs/getting-started.md` in that repo, linked from its README, for a new project: the `settings.json` to copy
(`extraKnownMarketplaces` with the tag, `enabledPlugins`), trusting the folder, installing, `/agentic-core:setup`,
the first `/agentic-core:run-route`; *(added 2026-10-06, Phase 46 / Task 6, Task 2's defect 6)* the guide says that
before a **headless** run a project needs `.ai/route-policy.yaml` and a settings file carrying
`sandbox.network.allowedDomains` — the runner starts nothing without them (exit `3` and `6`), and a bare project
has neither; `phase-48-task-4-done.md`.
**Depends on** Phase 48 / Task 3.
**You verify** `scripts/run-tests.sh` → 131 files, `fail=0`; the version check fails on a change without a bump.
**Reject if** a suite is skipped to make the run green.

### Phase 48 / Task 5 — PR, merge, tag

**Delivers** the PR, merged by the human; tag `v0.2.0` on the merge commit; `phase-48-task-5-done.md`.
**Depends on** Phase 48 / Task 4.
**You verify** CI green on the PR; `git ls-remote --tags origin v0.2.0` → the merge commit.
**Reject if** the tag is on a commit CI did not run on.

# Phase 49 — Switch this project to the marketplace  *(new 2026-10-06, spec §5; the plugin freeze ends at Task 3)*

### Phase 49 / Task 1 — Settings and config

**Delivers** `.claude/settings.json`: `extraKnownMarketplaces.agenticdraft` (`github`, `agenticDraft/plugins`,
the pin Phase 46 / Task 3 proved, `v0.2.0`) and `enabledPlugins` `agentic-*@agenticdraft`; `.ai/project-config.yaml`
`packs:` on the `agentic-*` names; `phase-49-task-1-done.md`.
**Depends on** Phase 48 / Task 5.
**You verify** the key in `extraKnownMarketplaces`, the suffix after `@` and `marketplace.json`'s `name` match
exactly. If the auto-mode classifier blocks the settings edit, it is recorded as a defect, not handed to the human.
**Reject if** an old `@aem-eds-ai-workflow-demo` entry is left enabled.

### Phase 49 / Task 2 — The CI route runner

**Delivers** `route-trigger.yaml`: checkout of `agenticDraft/plugins@v0.2.0` into `_plugins/`;
`npm ci --prefix _plugins/plugins/agentic-core/shared/runner`; `ROUTE_PLUGIN_DIR=_plugins/plugins`; allowlist
patterns on `_plugins/plugins/*`; default `ROUTE_PROMPT` on `agentic-jira:fetch-item`;
`.github/route-runner-setup.md` to match; `phase-49-task-2-done.md`.
*Added 2026-10-06 (Phase 46 / Task 6, Task 2's defect 8):* `ROUTE_PLUGIN_DIR` is not the whole set — the project
settings' `enabledPlugins` load too, and a name in both runs from the path copy (measured, Task 2 step 5). So
wherever the packs are **installed** (a machine that ran the install, or a CI step that does), `ROUTE_PLUGIN_DIR`
must point at an empty or absent folder, or the run silently keeps using the path copy; and where this task loads
them by path from the `_plugins/` checkout instead, the same `enabledPlugins` ids must not resolve to a second,
installed copy. **Open for this task to settle:** whether a session on a machine with no installed copy tries to
install what `enabledPlugins` names from `extraKnownMarketplaces` at startup, and what the runner's log then shows.
*Added 2026-10-09 (Phase 47 / Task 6):* the runner has no default plugin directory any more (unset → exit `7`);
the workflow sets `ROUTE_PLUGIN_DIR: plugins`, which this task replaces. A set but absent folder is legal and loads
nothing by path.
**Depends on** Phase 49 / Task 1.
**You verify** `grep -n 'plugins/' .github/workflows/route-trigger.yaml` → only `_plugins/plugins/` paths. The
human checks the repository variables `ROUTE_PROMPT` and `ROUTE_ALLOWED_TOOLS`. *(added 2026-10-06)* In the
runner's log of the first run: `loaded plugins:` names each pack once; where the packs are installed, `plugins by
path (…; 0): none` and `plugins in both (0; …): none`, so every loaded copy is an installed one; where they are
loaded by path (this task's CI runner), `plugins by path (…; 6)` names the six packs and `plugins in both (6; …)`
names the same six — `plugin-sources.mjs` compares names, and `enabledPlugins` names them too. *(corrected
2026-10-13, Phase 49 / Task 2: this line said `none`, which the runner's code cannot print here.)* What proves there is
no second copy is `loaded plugins:` naming each pack once.
**Reject if** a `Bash(bash plugins/*)` pattern is left, or `loaded plugins:` names a copy from a path when the packs
are installed.
**Done** 2026-10-13 — `phase-49-task-2-done.md` (G190 CLOSED, G191 FIXED; run 38419659429).

### Phase 49 / Task 3 — Remove the old copy; the plugin freeze ends

**Delivers** first the split-to-delete check: `git log <split base from Phase 48 / Task 1>..origin/main -- plugins/`
must be empty, and any commit it shows is carried over to the new repo before anything is deleted. Then, with the
human's yes, `plugins/` and `.claude-plugin/marketplace.json` deleted; `.eslintignore:4`, `.diagram-lock.json`,
`.claude/converge.config.json:40`, `README.md`, `CLAUDE.md`, `.github/pull_request_template.md`,
`triggers/jira/README.md` cleaned, and `.claude/skills/write-specs/SKILL.md:280` (names
`plugins/agentic-core/shared/official-reference.md`; through `skill-creator`; added 2026-10-10 by Phase 47 / Task 9);
the root `README.md` "Claude Code setup" section shortened to what this project
uses (`agenticdraft` at its tag, its `settings.json`) with a link to the user guide; `validate-*.yaml` removed here; the dev loop (`claude --plugin-dir
../plugins/plugins/agentic-<pack>`) in `00-instructions.md`; `phase-49-task-3-done.md`.
**The plugin freeze that started in Phase 47 ends here, at Phase 49 / Task 3; from now on plugins are edited
only in `agenticDraft/plugins`.**
**Depends on** Phase 49 / Task 2.
**You verify** the split-to-delete log was empty (quoted); `git ls-files plugins | wc -l` → 0;
`grep -rn 'plugins/' --include='*.json' --include='*.md' . | grep -v node_modules` → no path into the old copy.
**Reject if** `plugins/` was deleted before the split-to-delete check, or without the human's yes.
**Done** 2026-10-13 — `phase-49-task-3-done.md` (G192 filed). The plugin freeze (D128) is over.

### Phase 49 / Task 4 — Remove the old marketplace on this machine

**Delivers** `claude plugin marketplace remove aem-eds-ai-workflow-demo`; `phase-49-task-4-done.md`.
**Depends on** Phase 49 / Task 3.
**You verify** `claude plugin list --json` shows no `@aem-eds-ai-workflow-demo` entry. The command writes under
`~/.claude/plugins`, which the sandbox blocks; a classifier block is recorded as a defect.
**Reject if** it is handed to the human as a typed command.
**Done** 2026-10-13 — `phase-49-task-4-done.md`.

# Phase 50 — Install and prove it here  *(new 2026-10-06, spec §8; changes no plugin)*

### Phase 50 / Task 1 — The installed copy is the one expected

**Delivers** `phase-50-task-1-done.md`.
**Depends on** Phase 49 / Task 4.
**You verify** `claude plugin list --json` → six `@agenticdraft` entries, each `0.2.0`, each `installPath` under
`cache/agenticdraft/`; `core/` in every pack is a real folder; `.ai/run-context/plugin-roots/` holds six paths
that exist; no `--plugin-dir` or `CLAUDE_CODE_PLUGIN_DIRS` active.
**Reject if** any check ran against the working tree.

### Phase 50 / Task 2 — Tests from the installed copies

**Delivers** `phase-50-task-2-done.md`.
**Depends on** Phase 50 / Task 1.
**You verify** `scripts/run-tests.sh` from `agenticDraft/plugins`, pointed at the installed copies → 131 files,
`fail=0`; in an interactive session the branch-name hook rejects a bad name.
**Reject if** a count is quoted that was not run.

### Phase 50 / Task 3 — Verification: a live route run from the installed copies

**Delivers** a design item written with `write-specs` on Zoki node `1-185` with placeholder copy; a fresh-session
`agentic-core:run-route` on it; `phase-50-task-3-done.md`, which also closes Phase 20 / Task 5
(`design_context` in `design-reference.json`, padding and radius measured) and Phase 23 / Task 4 (a
"content-dependent, not graded" section; plan-gate warns on a mismatch and the route continues).
**Depends on** Phase 50 / Task 2.
**You verify** every stage completes; the read hook allows the contract reads; the transcript shows only cache
paths, never `aem-eds-ai-workflow-demo/plugins/`; the PR opens and the tracker note is posted; the user guide
(Phase 48 / Task 4), followed step by step on an empty scratch project in `$TMPDIR`, gets as far as a
`/agentic-core:setup` that lists the installed packs — every step that needed something the guide does not say is a
defect in the guide.
**Reject if** the run loaded anything from the working tree, or the guide was checked by reading it instead of
following it.
*Decided 2026-10-06 (the human): this run, interactive as before, is the plan's last proof. The CI route run
from `agenticDraft/plugins@v0.2.0` belongs to Phase 9 / Task 5, because headless does not work yet.*
**Superseded 2026-10-14 (the human):** this task is not run in this repository. The live proof moves to a new project: Phase 51 is
the plan's last proof, and Phase 51 / Task 4 holds the fresh-session route run. Not decided: whether Phase 20 / Task 5 and
Phase 23 / Task 4 close on that run (it would need a design item on Zoki node `1-185`), or stay open.

# Phase 51 — A new project installs the plugins and runs them  *(new 2026-10-09, the human's decision; changes no plugin)*

**Why this phase exists.** Phase 50 proves the installed copies in this repository, which is not a new consumer: it
already holds `.ai/project-config.yaml`, run history and settings written while the plugins were local. Only a project
that starts empty shows the first-use path a new team takes: install from the marketplace, `setup` from nothing, the
first run. It is also the only place to see D126's measured limit live — a fresh project's first session fetches the
plugins without running their hooks, so the registry is empty until the second session. Phase 50 / Task 3 stays the
migration's last proof; this phase proves the plugins on a project that did not build them.

### Phase 51 / Task 1 — The test project exists, empty of this repo's setup

**Delivers** a new repository the human creates from the same upstream boilerplate this repository started from; its
name, owner and tracker project are the human's choice, recorded in `phase-51-task-1-done.md`. Nothing copied from
this repository: no `.claude/`, no `.ai/`, no `plugins/`.
**Depends on** Phase 50 / Task 2 (Phase 50 / Task 3 superseded 2026-10-14).
**You verify** in the new repository `git ls-files .claude .ai plugins | wc -l` → 0.
**Reject if** any file was copied from this repository.
**Done** 2026-10-14 — `phase-51-task-1-done.md`: `agenticdraft-org/eds-agentic-demo`, `template_repository` `adobe/aem-boilerplate`, `git ls-files .claude .ai plugins | wc -l` → 0.

### Phase 51 / Task 2 — Install by the user guide alone

**Delivers** the new repository set up by following `docs/getting-started.md` from `agenticDraft/plugins` at the
current tag, step by step, with nothing it does not say; every step that needed more is a defect in the guide, fixed
in `agenticDraft/plugins` with a `version` bump; `phase-51-task-2-done.md`.
**Depends on** Phase 51 / Task 1.
**You verify** `claude plugin list --json` → six `@agenticdraft` entries at the tag's version, each `installPath` under
the plugin cache; in the first session `.ai/run-context/plugin-roots/` is absent or empty (measured, D126's limit);
in the second session it holds six paths that exist; `resolve-plugin-root.sh --list` prints six lines.
**Reject if** the guide was checked by reading it instead of following it, or a step was done from memory.

### Phase 51 / Task 3 — Setup and health from nothing

**Delivers** `/agentic-core:setup` run in the new repository: it proposes the installed packs from
`resolve-plugin-root.sh --list` and writes `.ai/project-config.yaml` with the human's confirmation; the tracker and scm
credentials the human supplies, never written by the agent; `phase-51-task-3-done.md`.
**Depends on** Phase 51 / Task 2.
**You verify** `/agentic-core:health` resolves every configured role; the branch limit in the new project's config
fits its own owner and repository name (Phase 47 / Task 7 moved the limit there), and the branch hook blocks a name
over it and allows one within it; *(added 2026-10-09, Phase 47 / Task 7: `setup` and `write-detected-config.sh` do
not yet propose `branch_name.max_length` or `platform.preview_host_suffix` (D129) — a project without them gets no
length check and no preview URL, exit 4 from both eds scripts; this task adds them to `setup` or writes them by
hand, and says which)* `/agentic-core:setup` re-run offers keep / re-detect / edit.
**Reject if** a pack root was given by path, or a role resolved through a sibling folder.
*(added 2026-10-13, open question, not decided, nothing built: where a new project's CI route workflow comes from.)*
A plugin cannot install a workflow into a repository; only a file under that repository's `.github/workflows/` runs
(general knowledge, not checked against GitHub's documentation). Today this repository's `route-trigger.yaml` is a
450-line file of its own: the logic is in the core's `shared/lib` and `shared/runner`, the glue is in the file. Options,
for the human to decide after the headless run in this repository passes (G190, G191): (1) `setup` writes a thin
caller of about 20 lines that uses a reusable workflow (`on: workflow_call`) in `agenticDraft/plugins` at the pinned
tag, so a fix reaches projects by tag; (2) `setup` generates a full copy from a template in the core, which the
project then owns and which drifts; (3) `setup` prints the file and the human commits it. Whichever is chosen, `setup`
writes it only after the human confirms, like `.ai/`. Not known: whether a reusable workflow carries the repository's
`secrets`, `vars` and `permissions` as this workflow needs them; whether a push that adds a workflow file needs a token
scope the route's fine-grained token lacks; whether the sandbox lets `setup` write under `.github/`. Phase 51 / Task 4
cannot end `delivered` in CI for a new project until this is settled. It would also be the first plugin change after
the freeze ends (Phase 49 / Task 3).

### Phase 51 / Task 4 — Verification: the new project's first route run

**Delivers** one work item written with `write-specs` in the new project's tracker; a fresh-session
`agentic-core:run-route` on it; `phase-51-task-4-done.md`.
**Depends on** Phase 51 / Task 3.
**You verify** the run ends `delivered`; the transcript shows only plugin-cache paths, never this repository's
path; the PR opens in the new repository and the tracker note is posted; every suite under the installed copies →
`fail=0` (`scripts/run-tests.sh` from `agenticDraft/plugins`, pointed at them).
**Reject if** the run loaded anything from this repository, or a count is quoted that was not run.

# Phase 52 — Pipeline fixes held by the plugin freeze  *(new 2026-10-10, the human's decision; G177–G181, G183, G184)*

**Why this phase exists.** Phase 47 / Task 10's first route run found defects in shipped plugin code while the
plugin freeze (D128) admitted only the migration. The human chose to fix them after the freeze, in the marketplace
repository the plugins move to in Phase 48, rather than by an exception that would move the Phase 48 split base.
Every task here edits `agenticDraft/plugins`, not this repository's `plugins/`.

### Phase 52 / Task 1 — A poisoning finding no longer stops the run that resolves it (G184)

**Delivers** the human's decision between two shapes, recorded as a D entry before code: (a) pre-flight lets a run
proceed whose item names the file a poisoning finding cites; (b) pre-flight stops only a run whose item's components
read the poisoned file. Then the change in `agentic-core`'s pre-flight and onboarding gate, tests first;
`phase-52-task-1-done.md`.
**Depends on** Phase 49 / Task 3 (the freeze ends).
**You verify** a test project with an open poisoning finding on `blocks/table/table.css`: pre-flight for an item
naming `blocks/table/table.css` → passes; for an unrelated item → behaves as the decision says; every existing
pre-flight suite → `fail=0`.
**Reject if** a poisoning finding can be bypassed by an item that does not touch the poisoned file, or the shape was
chosen without the human.

### Phase 52 / Task 2 — Proposed breakpoints come from the viewport frames (G183)

**Delivers** first a diagnosis, written to `phase-52-task-2-done.md`: how design-system onboarding chose
`node-id=1-1043` (a `Label` frame in the `Styles` section) as a viewport frame. Then the fix in `agentic-eds`'s
onboarding (`write-proposed-breakpoints.sh` or whatever the diagnosis names), tests first.
**Depends on** Phase 49 / Task 3.
**You verify** onboarding re-run against the Zoki file records exactly `1:118` Desktop 1280, `1:274` Tablet 800 and
`1:430` Mobile 375 in `proposed-breakpoints.md`, and derives thresholds from those three; the onboarding suites →
`fail=0`.
**Reject if** the fix is written before the diagnosis, or a frame outside the viewport frames can still be recorded.

### Phase 52 / Task 3 — A component the item's text excludes is refused before work starts (G177)

**Delivers** a deterministic check, in `agentic-eds`'s readiness criteria, that refuses an item whose tracker
`components` include a name its text never names, or names only under an out-of-scope heading; tests first;
`phase-52-task-3-done.md`.
**Depends on** Phase 49 / Task 3.
**You verify** EDS-20's live shape (`components: [carousel]`, `carousel` only out of scope) → readiness fails naming
`carousel`; EDS-26 → passes; the readiness suites → `fail=0`.
**Reject if** the check reads the text with a second extractor instead of the intake extractor's own output.

### Phase 52 / Task 4 — `prototype` asks instead of ending without an envelope (G178)

**Delivers** `resolve-target.py` exit 4 (question) when its target is a component the conventions artifact
classifies `upstream` while it names a `new` block; a test case per exit; every exit of `eds-prototype` writes an
envelope; `phase-52-task-4-done.md`.
**Depends on** Phase 49 / Task 3.
**You verify** the resolver on EDS-20's run context → exit 4 with both names; the prototype suites → `fail=0`.
**Reject if** any path of the stage can still end with an empty envelope file.

### Phase 52 / Task 5 — Pre-flight does not print `ok` for a design role it never probed (G179)

***Superseded 2026-10-12 by Phase 53 (spec 34, D130).*** The decision this task was to take is D130: the
route driver checks session tools after `intake`; pre-flight stays declarative and keeps printing `design: ok`.
Do not build this task.

**Delivers** first the decision whether an MCP-tool precondition is expressible in `requires:` (D97) or is a
stage-time check only, recorded as a D entry; then the change, tests first; `phase-52-task-5-done.md`.
**Depends on** Phase 49 / Task 3.
**You verify** a session without the figma plugin's tools → pre-flight reports the design role as unchecked or
missing, never `ok`; with them → `ok`; the pre-flight suites → `fail=0`.
**Reject if** pre-flight probes a tool by calling it.

### Phase 52 / Task 6 — The attachment fallback keeps every viewport image (G180)

**Delivers** `eds-extract`'s attachment fallback recording every `design-reference*.png` on the item with its
viewport, in the viewport shape D520 already uses; tests first; `phase-52-task-6-done.md`.
**Depends on** Phase 49 / Task 3.
**You verify** EDS-26 with the design provider unavailable → `design-reference.json` lists three images (desktop,
tablet, mobile) with their widths; the extract suites → `fail=0`.
**Reject if** a viewport is inferred from anything but the attachment's own name or the item's text.

### Phase 52 / Task 7 — Out-of-scope paths and existing files are classified correctly (G181)

**Delivers** the intake extractor leaving out of `files_named` a path that occurs only under an out-of-scope
heading; `component reuse` testing existence before it classifies a path `new`; a diagnosis of the `markup`
subagent's `review=fragment` on EDS-20; tests first; `phase-52-task-7-done.md`.
**Depends on** Phase 49 / Task 3.
**You verify** EDS-26's text → `files_named` without `styles/styles.css`; `styles/styles.css` is never classified
`new`; the intake and conventions suites → `fail=0`.
**Reject if** the out-of-scope rule matches a heading name the tracker pack does not declare.

### Phase 52 / Task 8 — Verification

**Delivers** `phase-52-task-8-done.md`.
**Depends on** Phase 52 / Tasks 1–7 merged.
**You verify** every suite under the installed copies → `fail=0` (count stated, as run); a fresh-session route run
with a poisoning finding open on a file the item names → passes pre-flight and ends `delivered`; the design audit
after onboarding re-run → no finding about the breakpoint set; a route run on an item shaped like EDS-20 (a
component named only out of scope) → refused at readiness; a route run on EDS-26 without the design provider →
`design-reference.json` with three images, and no stage ends without an envelope.
**Reject if** a count is quoted that was not run.

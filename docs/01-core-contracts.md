# Agnostic Delivery Core — Interface Specification

**Date:** 2026-09-01 · **Last amended:** 2026-10-08 (§11.2 — Phase 47 / Task 3: the `core` link in each pack, every pack → core reference
through it) · 2026-10-08 (§11.2 — Phase 47 / Task 2: the registry writer, the resolver and the
`SessionStart` entries built; the archiver keeps the registry, G174) · 2026-10-08 (§11.2, §7 — D126, where a plugin is found: the
in-pack `core` link and the root registry; specified, not built) · 2026-10-04 (§6 — D123, `measure` takes an optional width, reports `min-width`
and each selector's `broken_words`; G140) · 2026-10-02 (§11 — D117, a platform pack may declare
its official reference as `reference_docs`; validator 23) · 2026-10-02 (§4 — D113, `readiness` writes its own
envelope file and nothing else) · previously 2026-09-28 (§4 — D524, a gate's "read-only" narrowed
to exactly two files under its given `project_root`: its findings report and its envelope;
`readiness` still writes nothing) · previously 2026-09-21 (§6, §11, §13 — D97, a provider manifest's
optional `requires:` field and validator 18; §6's "pre-flight owns every environment question" is
narrowed to the questions a declaration can answer, resolving its contradiction with
`pre-flight.md`'s own anti-patterns) · previously 2026-09-19 (§11, §13 — D95, a provider manifest's
optional `scripts:` field and validator 17) · previously 2026-09-19 (§6 — D94, the pre-flight serve notice,
closing G100) · previously 2026-09-18 (§4, §11, §13 — D86, the optional
`evidence_manifest` manifest field, the `deliver` attach obligation it creates, and validator 16)
· previously 2026-09-14 (§6, §11, §13 — D80, pre-flight's third check
over a platform-pack-declared onboarding-state and audit-findings path, closing G63) · previously
2026-09-14 (§6 — D81, a new §6.2 points to the design manifest shared contract) · 2026-09-10 (§6 —
D69, the `browser` role gains a fourth operation, `interact`) · 2026-09-08 (§11 — D66,
`text_conventions` gains `acceptance_criteria_headings`) · 2026-09-08 (§7 — a citation renumbered
to D65; no substantive change) · 2026-09-07 (§11, §13 — D58, the `route.dot` digraph validator 14
checks against) · 2026-09-06 (§3 — Phase 2 / Task 24, the concrete inner-tier contract) ·
2026-09-04 (§3, §9, §12, §13 — D49, D50, D51; §9, §12 — Phase 2 / Task 20, run analytics) ·
**Status:** draft for review · **Decisions:** D33–D43, D49–D51, D58–D66, D69, D80–D81, D86 in
`03-core-design.md`

This document defines **interfaces**, not intent. Everything else in the plan set records why
things should exist; this records what a party who has never read that plan must implement to
build a pack the core can run.

**Naming rule, absolute.** Nothing in this document names a platform, a tracker, a design tool, a
browser engine, a language, a package manager or a file extension. If such a name appears here, it
is a defect. Concrete examples use `<pack>`, `<provider>`, `<command>`, `<url>`.

**Borrowed material.** The envelope, the artifact registry and the config-once principle are
adapted from `dx-aem-flow` — MIT, © 2025-2026 Dragan Filipovic. Deviations are recorded in the
plan (D33–D36) and in `06-dx-core-deviations.md`.

---

## 1. What the core knows

The core's entire vocabulary. Anything outside this list belongs to a pack.

- **stage id** — one of the fifteen names in §4. *No longer opaque as of D42:* the core owns the
  vocabulary, which is what lets §13 check a pack's stage list at all
- **role name** — `tracker`, `scm`, `design`, `browser`
- **operation name** — the verbs a role must support (§6)
- **the result envelope** — §3
- **verdict literals** — `pass`, `warn`, `fail`, `question`
- **terminal states** — `delivered`, `blocked`, `failed`

The core holds no knowledge of what a stage does, which tools a pack calls, or what any artifact
contains. It sequences, spawns, reads a verdict, and branches.

---

## 2. Components

| Component         | Owns                                             | Never does                                |
| ----------------- | ------------------------------------------------ | ----------------------------------------- |
| Entry command     | Control flow, process lifecycle                  | Read a source file, spec, report or image |
| Config resolution | Reading and validating project config            | Infer a value config should state         |
| Condition filter  | Evaluating each stage's `when:` against the fact record | Judge, classify, or read the work item |
| Stage runner      | Spawn, read envelope, branch, print, record      | Parse anything but the envelope           |
| Contracts         | The shapes in this document                      | —                                        |
| Packs             | Everything platform- or product-specific         | Know about other packs                    |

Every stage runs as an isolated subagent. The runner's context grows by one envelope per stage,
never by the content a stage reads. This is the reason a long route costs no more per stage than
a short one.

---

## 3. The result envelope

Every stage adapter and every provider operation **ends** its output with this block. It must be
the last thing emitted. Anything above it is for a human debugging that stage.

```markdown
## Result
verdict: pass | warn | fail | question
summary: <one sentence, <=200 chars, plain prose, no markdown, no line breaks>
artifacts:
  - <relative path written or updated>
next_action: <short phrase, or "none">
```

Additional fields, valid only with the verdict shown:

```markdown
error_class: TRANSIENT | VALIDATION | PERMANENT   # verdict: fail or question only
question: <the question text>          # verdict: question only
question_id: <short lowercase id>      # verdict: question, optional
options:                               # verdict: question, optional
  - <short option label>
blocker: <what is missing>             # verdict: question, required
metrics: <key=value pairs>             # optional, any verdict
```

The fields appear in the order shown, immediately after `next_action`.

**Field rules**

- `verdict` — exactly one of the four literals. The runner branches on the literal; an unknown
  value is a contract violation and terminates the run as `failed`.
- `summary` — one sentence, no line breaks. The runner may quote it verbatim into its status line, so a table or multi-line value pollutes the runner's context.
- `artifacts` — every file written or updated, so the runner can hand paths to a later stage
  without having read them.
- `error_class` — which of the three classes of `shared/error-handling.md` the failure belongs to.
  Valid only with `verdict: fail` or `verdict: question`, since `pass` and `warn` report no failure
  to classify; exactly one of the three literals, checked by the validator's enum the same way
  `verdict` is, because a caller branches on it. **Presence is not checked** — a clarification
  `question` classifies nothing, and every envelope written before the field existed still has to
  validate — so the rule that an operation report the class it determined lives in
  `error-handling.md`'s anti-patterns, not in the validator. *(Phase 14 / Task 2, D500.
  `metrics: error_class=...` was available as the zero-contract-change carrier and was rejected:
  nothing validates `metrics`, so a stage branching on it branches on an unchecked string —
  `21-design-fallback-spec.md` §6.)*
- `question` / `blocker` — see §8.
- `question_id` — the decision the question asks for, named by the asking stage: lowercase letters,
  digits and hyphens, starting with a letter, at most 40 characters. Stable across invocations — the
  same decision asked again carries the same id — because the answer is stored and read back under
  `(stage, question_id)` (§8, §12). Valid only with `verdict: question`. **Optional:** an envelope
  without it is keyed `default`, so every envelope written before the field existed still validates
  and still gets its answer. A stage that can ask about more than one decision gives each its own id.
  *(D527, Phase 26 / Task 3.)*

**Anti-patterns**: prose after the block; a verdict outside the four literals; a missing
`artifacts` list; tables or ASCII art inside `summary`; an `error_class` outside the three
literals, one on a `pass` or `warn` verdict, or one carried as a `metrics` key; a `question_id` on a
verdict other than `question`, or one that is not a lowercase id.

**This block governs one tier only: an adapter returning to the runner.** A stage adapter that
dispatches subagents of its own uses a second, separate contract for what those return to it —
a different block name and a status vocabulary sharing **no literal** with `pass | warn | fail |
question`, so a tier mix-up is a contract violation rather than a value that silently matches a
branch. `question` has no inner equivalent: an adapter resolves what its own subagent could not,
or raises its own `question` at its own boundary, which is what keeps §8's "questions at stage
boundaries only" literally true. (D50.)

**Delivered (Phase 2 / Task 24):** `shared/subagent-outcome.md` — block `## Outcome`, field
`status: success | warning | failure`, plus `blocker` (required, `status: failure` only). None of
the three literals appears in this section's four; `validate-subagent-outcome.sh` mirrors
`validate-result-envelope.sh`'s shape and rejects either vocabulary used in the other tier's
field, which the plain enum check does for free — no cross-referencing code needed, since the two
sets share nothing to collide on.

---

## 4. Stage ids

**A fixed, platform-neutral vocabulary of fifteen ids.** The core defines every one. A pack
implements an id or declines it; no pack may add one, and adding one is a version bump on this
contract. *Decided 2026-09-06 (D42), closing open item 1 of §14.*

*Why a closed list is available here and was not to the reference plugin.* Its phase list contains
platform-named phases, so closing it would require its core to name a platform. D28/D34 forbade us
that from the start, and the result is that every id below is already neutral. The neutrality
constraint is what buys the closed vocabulary, and the closed vocabulary is what makes every §13
validator stronger.

**The working branch belongs to the runner, not to a stage.** `scm.create_branch` (§6) is invoked
by the route driver immediately after `readiness` returns continue, and again on resume — the
operation is idempotent, so the second call reports the branch it already made. No stage id owns
it: `readiness` is the last stage that writes nothing, every stage after it may write, and
`intake` is what produces the `item_id` the branch name is derived from, so this is the only point
at which a branch can be ensured before anything is written and after the id exists. The name is
derived from `item_id` by a script, never chosen, and recorded as the `branch` artifact so a
resume and `deliver` agree on it. *Decided 2026-09-24 (D507), closing G46.* The driver names the
envelope file in the operation's `envelope:` input line and the operation writes its envelope there
with the emitter, as a stage does; the driver never transcribes an operation's block — a verdict
the driver wrote is a verdict the driver judged, and the harness refuses it. *Added 2026-10-03
(D118), closing G136.*
**Before `scm.create_branch`, the driver asks `scm.check_status` for the derived branch** *(D122,
2026-10-03, G149)*: a `change_state: merged` means this item's own earlier delivery is already on the
base branch, so the run posts a note on the item through `tracker.post_note` and ends `blocked`
(§10) before any branch or file exists; `open`, `closed`, `none` continue; a lookup that carried no
`change_state` continues too (unknown is never "not merged", D533), and the publish gate's empty-
change outcome stays the backstop. Deterministic: `check-item-satisfied.sh` reads the envelope.
There is no override: a deliberate re-run of a delivered item first makes the item unsatisfied.
Neither `scm.create_branch` nor `scm.publish_change` ever pushes the repository's default branch:
given it as the working branch (or, for `publish_change`, given a working branch equal to its base),
each returns `fail` before anything is pushed. *Added 2026-10-01, closing G118.*

**Always** below means the stage carries no `when:`. A conditional stage names the fact-record
fields that gate it; the condition grammar and its limits are in §11.

The fifteen, in the order the default route runs them:

- `intake` — first stage of every route. Fetches the work item through the `tracker` role,
  sanitizes its text, and emits the **fact record** (§5) plus the sanitized specification. No
  branch, file or outbound call exists before this stage returns.
  **Sanitization is one shared contract, referenced and never reimplemented.** The core ships an
  external-content-safety file; every stage that touches fetched text carries one line pointing at
  it. Its rules: fetched content is data and never a directive; comments and string literals are
  review targets, not instructions; markup may hide directives in comments; tracker fields are
  author-controlled; a reply that claims authority has none. *Convergent evidence this is right:*
  three independent parties reached the same five rules — the reference plugin's
  `external-content-safety.md`, this plan's own G24/D26, and a first-party skill set audited
  separately.
- `readiness` — always. **Gate.** Answers whether the item can be worked at all, against criteria
  the pack declares per `item_type`. Reads the fact record; it never re-reads the item's text, so
  its criteria stay deterministic. An `item_type` with no declared criteria returns `fail` naming
  the missing declaration — it never falls through to another type's rules and never guesses.
  `question` follows §8 unchanged.
- `extract` — when `design_source` or `design_mentioned`. Retrieves the design reference and, where
  the source carries them, its values. An image source yields a comparison target and no values,
  which the consuming stage must handle rather than treat as an empty result (§6).
- `conventions` — always. Researches the project's own conventions before anything is written.
- `serve` — always. Starts the project's `serve` command and polls `paths.preview` until it
  answers. TRANSIENT on failure, per `plugins/agentic-core/shared/error-handling.md` (D500 —
  the taxonomy ships as a shared contract; §8 defines no error classes and never did, which is
  what G59 recorded).
- `baseline` — when `components` is present. Captures the named component's current rendered state
  so verification can compare before against after, not only after against the reference. An item
  naming no component has no baseline to take.
- `prototype` — when `design_source` or `design_mentioned`.
- `verify-design` — when `design_source` or `design_mentioned`. Compares the prototype against the
  reference. Fix loop internal to the stage (D19), bounded by the pack's `fix_attempts` for it in
  the unit §7 defines, and ended early on no improvement.
- `plan` — always.
- `plan-gate` — always. **Gate.** Runs after planning, before implementing. Answers four criteria,
  each of which must be answerable or the gate does not belong in the route: every requirement maps
  to a stage; nothing unrequested appeared; the dependency order holds; the verification is
  defined.
- `implement` — always.
- `verify` — always. Behaviour and responsiveness through the `browser` role. The design comparison
  runs inside this stage and only when the design stages ran — that condition is pack-internal and
  never reaches the runner. **Unconditional by design:** without it an item with no design source
  would reach `verified: true` on lint alone, so the same field would mean two different things
  depending on the item.
- `lint` — always. Fix loop internal to the stage, bounded by the pack's `fix_attempts` for it in
  the unit §7 defines.
- `publish-gate` — always. **Gate.** Runs before `deliver`, on the actual change rather than a
  description of it. **An empty change is not a failed change** *(D122)*: a working tree equal to the
  merge base means the item's requirements are already met on the base branch, so the gate returns
  `question` ("close the item, or name what is still missing") under §8 — an unattended run ends
  `blocked` with that question posted on the item — rather than `fail`.
- `deliver` — last stage of every route. Publishes through the `scm` role and reports back
  through the `tracker` role. **When the pack declares an `evidence_manifest` (§11, D86), this
  stage attaches every file that manifest lists before it posts its note.** An attach that fails
  degrades the stage to `warn`, never to `fail` — by that point the change is already published,
  and a failed upload presenting as a failed delivery would be a false terminal state.

**Three of the fifteen are gates** — `readiness`, `plan-gate`, `publish-gate`. They read; their
writes are narrowed, not open (D524). `readiness` writes exactly one file, its envelope,
`.ai/run-context/envelope-readiness.txt` *(amended 2026-10-02, D113 — every stage writes its own
envelope; before that, `readiness` wrote nothing and the driver copied its block)*. `plan-gate` and `publish-gate`
each write exactly two files, both under the `project_root` they are given, on every verdict:
`.ai/run-context/<gate id>-report.md`, holding their findings, and
`.ai/run-context/envelope-<gate id>.txt`, holding their envelope. No gate writes anything else — no
other file under `project_root`, nothing in its own worktree, nothing through any role. Each
answers a fixed set of criteria and returns a verdict the runner branches on.

**All three are ordinary stages** — resolved from the pack manifest, spawned as subagents,
emitting the envelope. The runner has no special behaviour for them.

`readiness` is the newest of the three (D42). It exists because the alternative was to let
`intake` judge the item it had just fetched, which §5 forbids: the stage producing the fact record
must not decide anything from it.

**Order inside a gate is fixed.** The deterministic validators (§13) run first and cost nothing;
only what survives reaches a reviewing model. What survives is judgment by construction, which is
why gate adapters run on a stronger model tier — declared per adapter in the pack, never in the
core. Gate adapters write nothing beyond what the gates paragraph above permits, run in an isolated
worktree, and report findings they are confident in rather than everything they noticed.

`verdict: fail` from a gate is terminal. `warn` continues with the finding recorded in the gate's
`.ai/run-context/<gate id>-report.md`.

**There is no open class.** A pack that needs behaviour no id covers implements it inside a stage
it already owns, or the vocabulary gains an id by a version bump on this contract. The cost is
real and was accepted knowingly: a pack cannot extend the list on its own.

*The rejected alternative* was a reserved-plus-open split — a handful of ids the runner depends on,
plus any id a pack cared to declare. It was easier to outgrow and strictly weaker to validate:
§13's checks can only assert what the core knows the name of.

---

## 5. The fact record

Emitted by `intake`. Consumed by the `readiness` gate and by every stage's `when:` — it is the
only thing a condition may name (§11.1). Facts only — no conclusions.

```yaml
item_id: <string>
item_type: <string>            # verbatim from the tracker, not normalised
labels: [<string>, …]
components: [<string>, …]
files_named: [<path>, …]       # paths the work item text names, if any

design_source: true | false    # a design reference is present, in any accepted form (§6)
design_mentioned: true | false # the text asks for a visual change

has_description: true | false
has_acceptance_criteria: true | false
has_reproduction_url: true | false
has_reproduction_steps: true | false
```

The stage that produces this record **must not** decide anything from it. If a field cannot be
determined, it is omitted or `null` — never guessed.

**Every boolean is a literal match, never a judgement.** The pack declares the word lists and
heading names; `intake` applies them to the sanitized text and records which token matched, so a
run can be audited after the fact. A model reading the item and forming an opinion would be a
conclusion in a facts-only record, and would make two runs on the same item diverge.

**`design_source` and `design_mentioned` are not the same question**, and the pair is what makes
the four cases separable. `design_source` asks whether a reference is *present*;
`design_mentioned` asks whether one was *wanted*. Present-and-wanted and neither-nor are the easy
cases. Wanted-but-absent is the one worth having the field for — an item asking for a visual
change with nothing attached — and it is terminal (§4, `readiness`). Absent-but-present runs the
design stages anyway: a resolvable reference is stronger evidence than a word list.

**The word list is deliberately wide.** Its two errors cost very different amounts. A false
positive raises one question a human dismisses. A false negative ships a visual change with no
design verification at all, and nothing reports it. Over-matching is the cheap direction.

*Removed 2026-09-06 (D42):* `explicit_route`. Nothing selects a route any more — there is one
stage list and stages filter themselves (§11).

---

## 6. Roles and operations

A provider pack declares one role and implements its operations. Each operation emits the
envelope, and **writes it with the emitter to the file its caller names in an `envelope:` input
line** when the caller names one (D118) — the route driver always does for the operation it invokes
itself, so no verdict reaches a file through a model's transcription. A caller naming no file reads
the block from the operation's output.

| Role        | Operation           | Purpose                                                 |
| ----------- | ------------------- | ------------------------------------------------------- |
| `tracker` | `fetch_item`      | Return a work item's fields and text                    |
| `tracker` | `post_note`       | Attach a note to the work item                          |
| `tracker` | `attach_file`     | Attach a file to the work item                          |
| `tracker` | `list_types`      | List the tracker's work-item types (used by setup, §7) |
| `tracker` | `create_item`     | Create a work item; return the key the tracker assigns  |
| `tracker` | `update_item`     | Replace a work item's description and fields            |
| `scm`     | `create_branch`   | Create a working branch                                 |
| `scm`     | `publish_change`  | Push and open a change for review                       |
| `scm`     | `check_status`    | Report the change's state (`change_state`) and its automated checks |
| `design`  | `fetch_reference` | Retrieve design values and reference images             |
| `browser` | `render`          | Load a target and return its state                      |
| `browser` | `capture`         | Capture the rendered view at a given width              |
| `browser` | `measure`         | Return computed values for named selectors              |
| `browser` | `interact`        | Act on a loaded target and return the resulting state   |

A pack that cannot implement an operation declares it unsupported in its manifest; the runner
treats a stage needing it as unrunnable and stops at pre-flight rather than mid-run.

**`check_status` reports the change's state, for a change in any state** *(D534, 2026-09-29)*. It
finds the branch's change whether it is open, merged or closed, and its envelope carries
`change_state: open | merged | closed | none` (`shared/result-envelope.md`).

- **`none` means the lookup succeeded and found no change.** Verdict `pass`, no checks, no artifact.
  It is not a failure.
- **A change that exists has its checks reported**, in any state. Checks that cannot be read are
  `fail`, and the envelope still carries the state the lookup found.
- **A lookup that did not succeed carries no `change_state`.** Unknown is never `none`: a caller
  that cleans up after a finished change must not read a failed lookup as "no change" (D533).
- **Several changes for one branch:** an open one wins; otherwise the newest. The provider operation
  chooses; no caller does.
- `change_state` is its own validated envelope field, not a `metrics` key, because a caller branches
  on it.

**An operation that writes an artifact writes a new file on every call** *(D514, 2026-09-25)*. It
never replaces a file an earlier call named in its `artifacts:` — whichever stage, or which check
within a stage, made that earlier call.

- **The provider operation enforces it, not the caller.** The operation chooses a name no earlier
  call used; for the browser pack's four operations, the next free integer suffix on the existing
  name (`capture-<slug>-<width>-<n>.png`). No stage passes a label, copies a file to a name of its
  own, or otherwise compensates.
- **Every caller takes the path from the envelope's `artifacts:`**, never from a predicted name.
  That is what makes a per-call name safe to introduce: no consumer has to change.
- **A name says what was produced, not who asked.** Target and width are in it; the stage and the
  check are carried by the envelope and the stage's own report.
- **Clearing old artifacts is not an operation's job.** They accumulate across a run until the run's
  archive step clears them.

**`measure` returns a fixed property set** *(D522, 2026-09-28)*. For each named selector: its geometry,
and the computed values of exactly these properties: `color`, `background-color`, `font-family`,
`font-size`, `font-weight`, `line-height`, `padding-top`, `padding-right`, `padding-bottom`,
`padding-left`, `gap`, `border-radius` and `min-width`. The six from `padding-top` to
`border-radius` were added by D522, so that spacing and radius are compared numerically rather than
by eye; `min-width` by D123 (below).

- **Longhands only for padding.** A consumer holding a shorthand value (`padding-inline`,
  `padding-block`, `padding`) expands it to the longhands before comparing. `measure` never reports
  a shorthand.
- **`border-radius` is reported as the computed value string.** Four equal corners come back as one
  length; unequal corners come back as the browser gives them. A consumer compares strings after
  normalising `px`, and does not infer per-corner values.
- **A property is added to a stage's comparison only after it is added here.** A consumer that
  compares a property outside this set is a contract violation.
- **`holds_text`, beside the geometry** *(D542, 2026-09-29)*. For each found selector, `true` when
  any element the selector matches has a descendant text node that is not only whitespace, else
  `false`. Every match is read; geometry and computed values stay the first match's. It is not a
  computed property and is never compared as one.

*Amended 2026-10-04 (D123, G140): a width, `min-width`, and the words broken across lines.*

- **`measure` takes an optional width.** Given one, the read is taken in a viewport of that width,
  the same width a `capture` of that check is given; absent, at the pack's default viewport. Either
  way the written measurement records the viewport width it was read at, so a consumer never assumes
  one.
- **The fixed property set gains `min-width`**, reported as the computed value string, like the
  others. It is read so that a box narrower than its own `min-width` can be found; it is compared
  against the selector's own geometry, never against a design value.
- **`broken_words`, beside the geometry.** For each found selector, the list of words whose line
  boxes lie on more than one line, read across the text of every element the selector matches (each
  text node once, however many matches contain it), in document order, one entry per occurrence. A
  word is a run of text between whitespace, split again after a hyphen (`-`), so a break at a hyphen
  is a line break, not a broken word. An empty list means no word is broken. Like `holds_text`, it
  is not a computed property and is never compared as one.

*Amended 2026-10-05 (D124, G157): a selector hidden at the measured width is reported, never waited
for.*

- **`hidden`, beside the geometry.** For each found selector, `true` when no element the selector
  matches is visible at that width — every match has an empty box or `visibility: hidden` — else
  `false`. A hidden selector is still `found`: the read does not wait for it to become visible and
  the operation does not fail because of it. Like `holds_text`, it is never compared as a value.
- **Geometry and computed values are the first visible match's** when one exists; when none is, they
  are the first match's, as read. Before this amendment a read with a hidden first match failed
  outright, so no result that used to succeed changes.
- **The settle condition no longer includes visibility.** A page is settled when its fonts are
  loaded and two consecutive snapshots are identical, `hidden` included — an element on its way to
  visible still changes the snapshot. An element that becomes visible only after the page has
  settled is reported hidden; a consumer that needs it visible waits for it through `interact`.
- **A consumer never reads a hidden selector's geometry as a finding.** A design value carried on a
  hidden selector is unmeasured at that width; a fixed size on it is not reported; neither
  regression signal (D123) is read on it. The measurement says the selector was there and hidden,
  which is the finding.

**"A stage needing it" is the whole of the rule, and pre-flight must read it that way.** An
operation no stage can reach cannot make any stage unrunnable, so its absence is not grounds to
refuse a run. Pre-flight therefore checks only the operations a route can use, and exempts those
that exist for callers upstream of it — today, `create_item` and `update_item`. There is no
declared stage-to-operation map for it to consult, so that exempt set is named in one place in
pre-flight itself; an operation not on it is treated as reachable, which is the safe direction,
because a new operation then blocks until someone states otherwise rather than being silently
waved through.

*Corrected 2026-09-22.* The implementation had always refused a run whenever a provider's
`unsupported:` list was non-empty at all, which is stricter than this paragraph has ever said. It
went unnoticed because every installed pack implemented everything, so the list was always empty;
the first legitimately unsupported operation turned it into a total block on every route. The
lesson generalizes past this one check: a rule stated loosely in prose and tightened silently in
code stays invisible for exactly as long as no one exercises the difference.

**`create_item` and `update_item` have no stage consumer, and that is not an irregularity.**
`list_types` already sits in this table with none — §7 describes it as called by setup. This table
is the role's operations, not the operations a stage calls. Nothing in a delivery run invents or
rewrites its own work item: authoring happens before a route begins, which is the same reason the
authoring step is not one of §4's fifteen stage ids. What these two exist for is to put that
authoring write under the same governance as every other outbound call — a declared operation, a
result envelope, a pack that can decline it — rather than leaving it to whatever tool a session
happens to have within reach.

**`create_item` is the only operation whose result is not knowable in advance.** The tracker
assigns the key, so the operation reports it the way §3 already provides for: it writes an
artifact and names it in `artifacts:`. A caller that predicts the key instead is wrong the first
time two items are created at once.

`interact` is the newest of these (D69, 2026-09-10) and the one most likely to be unsupported: the
first three read a page's load-time state, while `interact` acts on a page already loaded and
returns the state that results. A stage that must check behaviour — that opening one item closes
another, that a key still toggles a control — cannot be answered by the first three at all. A pack
unable to drive a real input device declares `interact` unsupported like any other operation; a
stage needing it then stops at pre-flight, which is the point. Silence would be worse: a check that
never ran must not read as a check that passed.

**Pre-flight owns every environment question it can answer from a declaration.** Is the operation
supported, does the serve command exist, is a pack bound to every role the config requires — all of
it is answered once, before `intake`, and never inside a stage condition (§11). This is also where a
project with no config and no pack stops: pre-flight returns a blocker naming `setup` and the run
ends before any branch, file or outbound call. It never runs the interview itself, because `setup`
is an interview and an autonomous run has nobody to answer it.

**"Is the tool installed" is the one environment question pre-flight does not answer** (D97). It
cannot be answered from a declaration — only by probing the machine — and a false negative from a
live probe aborts a run permanently, silently, on conditions the pack author does not control.
Pre-flight's verdict therefore stays a function of files in the repository alone. The question is
still answered, in two other places: a read-only diagnostic skill probes on demand and reports each
missing tool with the pack's own declared remedy, and the operation itself refuses to run without
its tool, returning the envelope's `fail` status carrying that same remedy. Both read one
declaration — the provider manifest's `requires:` (§11) — so neither restates what the pack said.

**Nothing in the core or any pack ever runs an install command.** Detect and report; never install.
This is §7.1's "propose only, never install" generalized from marketplace proposals to every local
precondition (D97).

### 6.1 What counts as a design source

Three accepted forms, any one of which sets `design_source: true`:

1. a design-tool URL the `design` role can resolve
2. another provider's URL, resolved the same way
3. **an image attached to the work item**, serving as the reference

Form 3 is the consequential one. It arrives through `tracker.fetch_item`, not through the `design`
role, so **a project with `packs.design: none` can still run design verification.** That widens
who can use this pipeline considerably.

But an image is not equivalent to structured design data. From a design tool you can read token
values, geometry and spacing; from an image you can read a comparison target and nothing else. So
`extract` emits a reference image and no values, `verify-design` works unchanged, and the token
grading in the `conventions` stage has nothing to grade — it reports "no design values" and caps
confidence `low`, reusing the path already defined for a project with no manifest (D20). The same
fifteen stages run either way, under the same conditions.

**An attached image is ambiguous by nature** — a screenshot of a defect and a mockup of the
intended state are structurally identical. Nothing in the item distinguishes them. So when an
image is the *only* design source, `readiness` returns `question`, naming the attachments and
asking which is the reference. *Accepted consequence:* an image-only item can never complete
autonomously, because §8 ends an unanswered question as `blocked`. Recorded as G36.

**A design reference may carry viewport variants** *(D520, 2026-09-28)*. When the `design` role
finds that the referenced node holds variants of one design at different widths, its artifact, and
the design reference `extract` writes from it, carries:

```
viewports: [{name, node_id, width, image, context}]   # sorted by width, widest first
```

- `name` and `node_id` identify the variant in the design source. `width` is the variant's own
  width in CSS pixels. `image` is that variant's reference image. `context` is that variant's
  design-context file, or `null` when the source returned structure only.
- **Detected, never guessed.** A variant appears in the list only if the provider's own
  deterministic classification named it. A node the classification calls a page or a set of
  unrelated frames is a `question` (§8), never a list.
- **Values fetched once.** Variables are shared across variants and fetched once.
- **Absent means one width.** No `viewports` key, or an empty list, means the reference has a single
  width, and every consumer behaves exactly as it did before this key existed.
- **Consumers pair by width.** A stage comparing a capture against the reference uses the variant
  that covers the capture's width, or reports that none does. It never reuses one variant's image
  at a width that variant does not cover without saying so.

**Fields the core reads from a design reference** *(D540, 2026-09-29)*. A gate's deterministic
relevance check (§4 `plan-gate`) reads three things from the design reference `extract` writes. It
only ever reads them; `extract` is what produces them:

- `node_name`: the referenced node's name in the design source;
- `design_context.code_file`: the path of the stored reference code, or `design_context: null`
  when the source returned structure only;
- the element-name attribute in that reference code, whose name the platform pack's extract
  documents.

A reference missing any of them is **not an error**. The check reports `not run` and names what was
missing. Only a malformed input, where the checker's exit is a usage error, is a contract violation.

### 6.2 The design manifest

A project that has run design-system onboarding holds a record of its adopted token set and where
it was extracted from. Full shape, fixtures and the deterministic validator live in
`shared/design-manifest.md`; referenced here, not restated. It records **how** a later comparison
must be made — by resolved variable value, never by a design tool's own notion of collection
identity, because no installed `design` provider exposes the latter at per-variable granularity
(D81) — never a platform name, a design-tool name, or a file extension.

### 6.3 The onboarding gate

*Decided 2026-09-14 (D80), closing G63.* Pre-flight gains a **third** structural check, over two
paths a platform pack may declare in its manifest (§11): an **onboarding-state path** and an
**audit-findings path**. The core learns *that* these paths exist to test; it never learns what
either is called — a different platform pack names entirely different files. A pack declaring
neither is not gated, the same shape this section already uses for a provider declaring an
operation unsupported: the core acts on a declaration, never on knowledge of the thing declared.

The two checks behave differently on purpose. **The onboarding-state path absent** warns and caps
the run's confidence `low`, and never blocks — the project has not completed onboarding, so every
design value a later stage reads is a guess (§6.2, G21). **An open `poisoning`-severity finding at
the audit-findings path** blocks the run before `intake` — before any branch, file or outbound call
exists — naming the finding and the file it names. A `cosmetic` finding never blocks. Severity and
the findings shape both come from the platform-neutral audit taxonomy the core ships alongside
itself; a `poisoning` finding is a file an agent reads as truth currently stating something false,
and every stage that reads it inherits the wrong claim unchecked.

**A third path, `audit_digest_path` (G500, 2026-09-21).** An audit's verdict is only as current as
the files it read, and the findings list cannot say whether those files moved afterwards — so a
clean list read as a standing guarantee is the same defect the `poisoning` severity exists to catch,
one level up (G22). The check re-hashes the paths the pack's own digest names and **warns**, capping
confidence `low` exactly as an absent onboarding-state path does, when any has moved or become
unreadable. It never blocks: a moved file is missing evidence, not a finding. `audit_findings_path`
is checked first, so an open `poisoning` finding still ends the run before any freshness warning is
reached. A file that is not a digest list at all is `invalid` — a gate that cannot read its own input
must not report a pass — and that shape is decided by the check rather than by whichever system
checksum tool is installed, because the two in common use disagree on both a malformed list and a
missing file.

Full shape — the exact manifest keys, the check's structural-read-only constraint, and the
required output — is `shared/pre-flight.md`; referenced here, not restated.

### 6.4 The serve notice

*Decided 2026-09-19 (D94), closing G100.* The sentence above — "does the serve command exist" —
described something pre-flight never did: nothing in it read `commands.serve` or `paths.preview`,
so a project with no configured serve command discovered that four stages into a run, from the
`serve` stage. This closes that half of the promise, and states plainly which half stays open.

When the platform pack declares a `serve` stage (§4), pre-flight prints one line before `intake`,
from those two declared values: which preview the run will need, and what is configured to start
it. An empty `commands.serve` makes it a warning. **It never blocks, and it polls nothing.** A pack
whose stage list has no `serve` stage prints nothing — the core acts on the declaration, never on
an assumption that every project has a preview.

The half that stays open is liveness. Asking whether something is *answering* means reaching a
local address, and an environment that refuses that reports a running server as absent; a false
negative here aborts a run before any branch, file or outbound call exists. So the question "is it
up" stays in the `serve` stage, which runs where that call can be made and is the only place that
can answer it. Pre-flight tells a human what the run will need; the stage finds out whether it is
there.

`run-route` prints the line verbatim, as it came, on the pass branch of its pre-flight check. It is
the one part of pre-flight's output written for a person rather than for the runner's own
branching, and that is the only point at which it can be given: a stage runs forked, and nothing
inside one can print to the main conversation while the runner waits on it. (The runner's own
per-stage progress lines continue throughout the run — this is not the last a human hears, only
the last before the first stage starts.)

Full shape — the two values read, the two lines produced, and the no-op rule — is
`shared/pre-flight.md`; referenced here, not restated.

---

## 7. Project config

Written once by `setup`, read by everything. Detect → confirm → write; re-runnable with
keep / re-detect / edit.

```yaml
version: 1

packs:
  platform: <pack name>
  tracker:  <pack name>
  scm:      <pack name>
  design:   <pack name> | none
  browser:  <pack name>

commands:                      # detected from the project, refreshable
  lint:  "<command>"
  test:  "<command>"
  build: "<command>"
  serve: "<command>"

paths:                         # detected from the project, refreshable
  spec_dir: "<dir>"
  preview:  "<url>"

limits:
  questions_per_run: <int>
  fix_attempts_default: <int>       # per-stage default; a pack overrides per stage

trigger:
  token: "<token>"                  # the comment token that signals a run (D25)
  allowed_identities:
    - "<opaque identity handle>"    # at least one; the comment author is checked against it (D98)

branch_name:                        # optional (D129)
  max_length: <positive int>        # the project's branch length limit; read by check-branch-name.sh

platform:                           # optional (D129); keys owned by the configured platform pack
  <key>: <value>
```

**A project's own values live here, never in a pack (D129).** *Added 2026-10-09 (Phase 47 / Task 7).* The branch
length limit depends on the repository's own name, so it is the project's: `branch_name.max_length`, read by the
core's branch check together with the platform pack's `pattern`. Values only the platform pack reads go in the
`platform:` block, keyed by role so a pack rename leaves it valid; the core checks only that it is a non-empty
mapping. A pack script that needs one of its values and finds none refuses; it never falls back to a default.

**A name under `packs:` is a plugin name, not a path.** Where that plugin is on disk is answered only by the
resolver in §11.2 (D126); nothing derives it from the core's own location.

**No stage list lives here.** *Removed 2026-09-06 (D42).* The pack owns the stage list and every
stage's condition (§11), so this file describes the project and nothing else. Two things went with
the `routes:` block: the notion of alternative routes, and **D65's fixed-indentation parser**,
which existed solely because that block was not valid YAML — its trailing `default:` sat at the
same indent as the sequence's `- id:` markers, which no standard parser accepts. Config is now
ordinary YAML end to end.

*What this gives up, stated plainly:* an item type can only ever run a **subset** of the one stage
list, in that order. A type needing a genuinely different sequence cannot be expressed, and would
require reopening this decision.

**Fix-attempt caps are per stage, not one number.** Evidence: `dx-step-build` caps its build loop
at 6, while this project's lint loop declares 3 and its design-validation loop 2. Three loops,
three right answers. `fix_attempts_default` is a floor a pack overrides per stage in its manifest;
the runner never applies it itself, because the runner never retries (§8).

**One fix attempt is one edit** *(D512, 2026-09-25)*. The unit is the same in every stage that
loops, and no stage reads it its own way:

- A **check** is what the stage measures — a validation, a command run, a comparison against a
  reference. An **edit** is everything the stage changes in answer to one check, however many files
  it touches, before it checks again.
- A stage whose `fix_attempts` is **N** makes **up to N edits and up to N+1 checks**: the initial
  check, and one re-check after each edit. A stage with no `fix_attempts` of its own reads
  `limits.fix_attempts_default` in its place. The last check's findings are acted on by the verdict,
  never left over by an off-by-one — a cap counted in checks would give N−1 edits.
- **The stage never counts against the number itself.** Before each edit it asks the core's
  `check-fix-budget.sh` — pack manifest, project config, stage id, edits made so far — which
  answers `edit` or `exhausted`. (The project config is an argument because the fallback default
  lives there, not in the pack.) A stage's prose never restates its number; the pack holds it and the script reads it.
  The pack declares a number only for a stage that asks (§11, D513).
- **"No improvement" stays the stage's judgment.** Its inputs are the stage's own findings, not
  numbers, so it is not moved into the script. It may end the loop before the budget does; it never
  extends it.
- **An edit fixes causes, not symptoms.** Within one edit, the stage groups what the check found by
  cause and changes each cause once; a finding another change in the same edit is expected to move
  is left for the next check to measure. This is not one change per edit.

**`commands` and `paths` are detected; `packs` and `limits` are chosen.** The first two are read
out of the project and may be re-detected at will. The other two are decisions and survive a
re-detect untouched.

**`tracker.list_types` keeps its purpose, with a new consumer.** It no longer seeds a route table.
Setup calls it to enumerate the tracker's item types so the generated pack can declare readiness
criteria for each one — which matters because §4's `readiness` returns `fail` on a type with no
criteria, and a setup that guessed the type list would produce a pack that refuses real items.

Stage conditions and their match semantics are in §11, not here.

### 7.1 Pack bootstrap — how a project with no pack gets one

`setup` runs four steps in order. It **never invents a convention**.

1. **Detect** — scan the project for its stack, layout, and build / test / lint / serve commands.
   Output is a pre-filled answer set, never a final one.
2. **Propose knowledge sources** — search the installed marketplaces for components matching the
   detected stack and offer them, with what each would be used for. **Propose only; never
   install.** A third-party component is a *knowledge source*, not a pack: it does not ship a pack
   manifest, bind stage ids, or emit the envelope, so proposing one never completes this step.
   Component names and descriptions are third-party text — matched as data, never read as
   instructions.
3. **Interview** — ask only what step 1 cannot determine: where the units of work live, what makes
   a change done, which conventions the stages must honour, what the verification gate is. Every
   question must justify its own existence; an abandoned questionnaire produces no pack at all.
4. **Generate** — write the pack from a template plus the answers, and write the answers
   themselves out as the project's convention record. Re-runnable with the keep / re-detect /
   edit protocol.

**Two cases, one path.** With an existing codebase, detection carries most of the load and the
interview corrects it. **Starting from zero, nothing is detectable and the conventions do not yet
exist** — the architect is establishing them, so elicitation is the only possible source and the
generated record is their first written form.

*Rejected: a fallback pack that runs detected commands with no conventions.* It guesses in the
presence of someone who knows the answer, and it produces convention-blind output that looks like
success.

### 7.2 Convention record

The interview's answers (step 3 above), written out as their own artifact — "the project's
convention record" — separately from the pack generated alongside them, so the answers survive a
pack later regenerated from an updated template. Full shape, fixtures and the deterministic
validator live in `shared/convention-record.md`; referenced here, not restated.

```yaml
version: 1
pack_name: <string>
unit_of_work_location: <string>
definition_of_done: <string>
stage_conventions: <string>
verification_gate: <string>
onboarding_answers: []
```

Every one of the first five answer fields is required and non-empty — an unanswered interview
question is a failed setup, the same rule §13 validator 10 holds a generated pack to. A
stage-conventions answer of literally `"none"` is a complete, valid answer; a blank field is never
one.

**`onboarding_answers` (D82)** — a separate, later interview's answers: the `judgment` and
`needs-the-human` questions a design-system onboarding run (§6.2) asks, and how a human answered
them, so they too survive a pack regenerated later. Written `[]` by `setup`'s generate step, before
any onboarding has run — an empty onboarding history is a normal result, the same "absent means
none yet, never omitted" convention `design-manifest.md` and `audit-taxonomy.md` use for their own
empty lists. Appended to, never replaced, by each onboarding run that asks at least one question.

---

## 8. Execution modes and the question protocol

**Questions are asked at stage boundaries only.** A stage that cannot resolve something does not
suspend: it runs to completion, doing whatever remains that does not depend on the answer, and
returns `verdict: question` with `blocker` naming what it needs. The runner asks at the boundary,
records the answer together with the asking stage's id, and **re-invokes the stage that asked,
exactly once, with that answer among its inputs** — the same invocation argument as the first time,
plus the answer file. No stage is ever paused or resumed mid-run. (D511, amending the rule that no
stage is ever re-invoked.)

- **The answer belongs to the stage that asked, and to the question it answers.** The answer file
  (§12, `question-answer`) holds a list of answers, each keyed by `(stage, question_id)` — the
  asking stage's id and the envelope's `question_id` (§3), `default` when the envelope has none. A
  stage reads one answer by `(its own id, question_id)`, and never scans the file's free text for
  one. *(D527, amending D511's one-answer file.)*
- **Writing an answer upserts.** The same question asked again replaces only its own answer; every
  other answer — the same stage's other questions, and every other stage's — stays. So a stage that
  asks twice in one run gets both answers back on its next invocation.
- **The asking stage is not recorded as completed until its re-invocation returns.** Run state
  never names, as `last_stage`, a stage that still owes work to an answer — so a resumed run
  re-invokes it rather than skipping past it.
- **The re-invocation's envelope is handled like any other.** `pass`/`warn` advance; `fail` ends
  the run. A second `question` from the re-invoked stage is a new question: asked under the same
  mode rules, counted against the same `limits.questions_per_run`, and answered the same way —
  another single re-invocation. Nothing beyond that cap bounds it, and nothing needs to.
- **This is not a retry.** A retry re-runs a stage on the same inputs after `fail`, and the runner
  still never does one (below). A re-invocation runs the stage on a new input it asked for.

*Consequence, accepted:* the asking stage's work that did not depend on the answer runs a second
time. The alternative — forwarding the answer to the next stage — hands it to a stage that neither
asked the question nor owns the work it unblocks. *Measured on EDS-18:* `prototype` asked which
block to target and wrote nothing; the answer went to `verify-design`, which failed because
`prototype-report.md` did not exist (G513).

**interactive** (default) — the runner puts `question` (with `options` when given) to the human.
Counts against `limits.questions_per_run`; on exhaustion the run ends `blocked`.

**autonomous** — the runner writes `blocker` back to the work item through `tracker.post_note`
and ends the run `blocked`. No question reaches a human, and nothing is guessed.

Mode is set by a flag, never inferred from the wording of a request. A pack may mark a stage
`always_autonomous` in its manifest, in which case a `question` from that stage is treated as
`fail` in both modes.

**The runner never retries a stage.** All retry and fix loops are internal to the stage that owns
them, bounded by that stage's own cap (§7). A stage that returns `fail` is reported, not
re-attempted — the human decides.

---

## 9. Run output and state

**Per stage, exactly one line**, carrying a progress counter:

```
Stage <n>/<total>: <stage id> — <verdict> · <summary>
```

`<total>` is computed once the fact record exists and every stage's `when:` has been evaluated
against it, and **recomputed whenever a stage is skipped**, so the counter never lies.

**The status table is emitted exactly once**, in the final summary. Re-emitting it mid-run
re-anchors the earlier copy in the runner's context and costs tokens for no information.

**On disk**, updated after every stage:

- `run-state.json` — pack name, the skipped stage ids and the condition that skipped each, last
  completed stage, total, mode, questions used, start time
- `progress.md` — one row per stage with status `done | skipped | failed | running | pending`

**Resume.** A `run-state.json` **less than 2 hours old** offers *"previous run found at stage
{last}/{total} — resume or start fresh?"*. Older than that, it starts fresh and deletes the old
state. On a successful terminal state the file is deleted.

**A fresh start begins on a clean working tree** *(D120, 2026-10-03, G138)*: before anything of the
run exists — no marker, no branch, no run state, no archive, no outbound call — a deterministic core
script asks for the publish gate's own change set (every tracked change against the merge base of
the remote's default branch and `HEAD`, and every untracked, unignored path) and, when it is not
empty, the run ends `blocked` naming every path. The guard reuses the gate's change-set definition
rather than restating it, so the two cannot disagree; the gate's rule is unchanged. A path in that
set before the run began would be published by `deliver` without anything knowing it predates the
run, and the gate would refuse it only at the last stage. It is the driver's check, not pre-flight's:
pre-flight reads declarations only (§6), and a working-tree status is not one. A resume never
checks — its tree is dirty with its own work by design, and the fresh-start check is what makes
everything dirty on resume the run's own.

**A fresh start then archives the run context** *(D119, 2026-10-03)*: everything the previous
run left in the run-context directory, with `progress.md` and the flat stage list, is moved by a
deterministic core script into one dated directory under the run's log root, before the
orchestration marker is written. This is the "run's archive step" §6 (D514) already assumed. The
run context is one shared directory for every item and every run, and a stage reads its inputs
there by fixed name, so a file left by the previous run is indistinguishable from this run's own. A
resume never archives — the directory then holds the run being resumed. Archived, not deleted, so a
stopped run stays readable.

*The 2-hour value and one non-obvious companion rule are taken from `dx-agent-all:40-45,64`:* the
runner must **refresh the state file's mtime after every stage**, so a long route does not trip
its own staleness check partway through. That is a defect they hit and fixed; it is cheaper to
inherit the fix than to rediscover it.

**The runner is a skill, and each stage is invoked as a skill that declares isolated execution in
its own frontmatter.** The runner owns control flow and process lifecycle only. It never reads a
source file, never opens a path listed under an envelope's `artifacts:`, and never retries a
stage. The isolation the cost model depends on is declared by the *adapter*, not chosen by the
runner — which is why §13 rule 11 checks it rather than leaving it to a pack author to remember.
A runner implemented as a script cannot exist: resolving a stage, validating its envelope and
branching are all deterministic and already are scripts, but spawning the adapter is the one step
that needs a model. (D49.)

**An orchestration marker** — `orchestrating.flag`, written by the runner in the same step as the
first run state (after `intake` returns, never before it — *amended 2026-10-03, G153, Phase 42 /
Task 4: a marker with no run state beside it was a run nothing could resume or finish*) and
removed at every terminal state — tells an adapter it is running inside a route, so it returns
the envelope alone rather than a human-facing summary. A file rather than an environment variable, because an
isolated adapter starts cold and cannot be relied on to inherit the runner's environment. It
carries the same 2-hour window as run state and **its mtime is refreshed at every stage**, for
both reasons at once: without the refresh a long route trips its own check, and without the window
a marker left by a crashed run convinces every later standalone invocation, indefinitely, that it
is running inside a route.

**Analytics.** A run's token measurements are rendered by a script from the session transcript the
runtime already writes to disk for every turn and every subagent — never asked of the model, never
estimated. At a terminal state the runner renders `analytics.md`: peak context and cumulative
billed input, kept as two distinct numbers rather than one blended figure, plus wall clock, for the
run and for each subagent it spawned. See `analytics.md` for the exact source, the deduplication
rule a streamed turn needs, and the file's shape.

---

## 10. Terminal states

| State         | Cause                                                        | Runner's obligation                               |
| ------------- | ------------------------------------------------------------ | ------------------------------------------------- |
| `delivered` | `deliver` returned `pass`                                | Print the status table and the published location |
| `blocked`   | Question unanswered, budget exhausted, a pre-flight failure, a dirty tree at a fresh start (§9), or an item whose work is already on the base branch (§4, D122) | Print what is missing and where it was recorded   |
| `failed`    | A stage returned`fail`, or a contract violation            | Print the failing stage and its summary           |

Nothing else ends a run. A stage returning `warn` continues, with the warning recorded.

---

## 11. Pack manifests

**The pack owns the stage list.** *Decided 2026-09-06 (D42).* The core owns the vocabulary (§4);
the pack says which of the fifteen it implements, in what order, and under what condition. Nothing
in `project-config.yaml` describes stages any more.

**Platform pack** — `pack.yaml` at the pack root:

```yaml
kind: platform
stages:
  - id: <stage id>              # one of the fifteen in §4
    skill: <skill name>
    when:                       # optional; omit entirely for an always-on stage
      - { <fact field>: <value>, … }
      - { <fact field>: <value>, … }
    fix_attempts: <int>         # optional; overrides limits.fix_attempts_default; only on a stage
                                # whose skill asks check-fix-budget.sh (D513)
always_autonomous: [<stage id>, …]
readiness_criteria:             # consumed by the `readiness` gate, keyed by item_type
  <item_type>:
    require: [<fact field>, …]
artifacts:                      # what this pack's stages produce
  - id: <artifact id>
    produced_by: <stage id>
    path: "<relative path>"
onboarding_state_path: "<relative path>"   # optional (D80)
audit_findings_path: "<relative path>"     # optional (D80)
audit_digest_path: "<relative path>"       # optional (G500)
evidence_manifest: <artifact id>           # optional (D86); must name an id in this pack's own artifacts: above
branch_name:                               # optional (D544, D129)
  pattern: "<ERE the whole branch name must match>"
reference_docs: "<https url>"              # optional, last (D117)
```

**A stage declares `fix_attempts` only when its skill asks `check-fix-budget.sh`** *(D513,
2026-09-25)*. The value is a budget of edits (§7, D512), and a budget nothing reads is a false
statement that no run will ever contradict.

- **Enforced by a check, not by review.** `check-fix-budget-readers.sh <pack root>` (validator 21,
  §13) fails on every stage that declares `fix_attempts` while the `skills/<skill>/SKILL.md` its
  `skill:` resolves to under the pack root never invokes `check-fix-budget.sh`. That skill file is the
  only thing it reads; "reads the budget" means an invocation of the script, and nothing else counts.
- **The converse is allowed.** A stage that asks the script without declaring a value reads
  `limits.fix_attempts_default` (§7).
- **A bound that is not a count of edits is not a `fix_attempts`.** A poll ladder, a retry count or a
  timeout lives in the script beside the operation it bounds. No other manifest key describes it.

**Three further keys, all optional (D80; the third G500).** `onboarding_state_path` names a file
whose presence in the project marks design-system onboarding complete; `audit_findings_path` names a
file holding audit findings in the shape §6.2's audit taxonomy fixes; `audit_digest_path` names a
digest list recording what each file that audit judged hashed to when it judged it — one
`<sha256>  <relative path>` line per file. None is core vocabulary — the core never learns what any
of these paths is called, and for the digest it does not learn what the paths *inside* it mean
either: it re-hashes whatever paths the pack's own digest names. A declared value is checked only as
a well-formed relative path (§13). A platform pack declares any subset; declaring none leaves
pre-flight's third check (§6.3) ungated for that pack.

**A fourth optional key, `evidence_manifest` (D86).** It names one of this pack's own registered
artifact ids — the one `deliver` must attach every listed file from before it posts its note (§4).
**Optional to declare, mandatory to honour**: a pack that omits it changes `deliver`'s behaviour not
at all; a pack that declares it is bound by the obligation §4 states, and validator 16 (§13) checks
the named id actually resolves. The core fixes the shape the artifact at that id must carry and
ships the validator for it (D86); it is not restated here, because — exactly like the artifacts this
pack registers under `artifacts:` above — the file and its path are the pack's, never the core's.

**A fifth optional key, `branch_name` (D544).** It declares the character rule a branch name must meet on
this platform: `pattern`. *Amended 2026-10-09 (D129):* the length limit is the project's, in the project config's
`branch_name.max_length` (§7); a manifest declaring `max_length` is invalid. The core never learns why a platform
limits a name, or to what. It enforces whatever the configured platform pack and the project config declare:
`shared/lib/check-branch-name.sh` answers `ok`, `too-long` or `bad-chars`, and the core plugin's
`PreToolUse` hook runs that check on every branch-creating command an agent issues, blocking the
command when the name fails. A pack that declares nothing is unconstrained. Validator 22 (§13)
checks the shape.

**A platform pack also ships `route.dot` at its root** — the digraph §13 validator 14 checks the
stage list against. *Added 2026-09-07 (D58).* Its nodes are stage ids and nothing else: every node
name is exactly an id from `stages:`, undecorated, with no pre-flight, decision or terminal nodes, so
agreement is a plain bijection needing no exclusion rule. A stage carrying `when:` is `style=dashed`
and one without it is not, both directions checked. A conditional stage's **incoming edge** carries
`label="<canonical rendering of its `when:`>"`. Edges follow list order; there are no bypass edges,
because §11.1 makes this a filtered list rather than a branching graph.

**Canonical rendering** — blocks joined by ` OR ` in manifest order, keys within a block joined by
` AND ` in §5 declaration order, each key rendered `<field>=<value>`, unquoted, single-spaced. So a
`when:` of `[{design_source: true}, {design_mentioned: true}]` renders exactly
`design_source=true OR design_mentioned=true`. Validator 14 builds this from the manifest and compares
with string equality, normalising nothing.

**Provider pack** — `pack.yaml` at the pack root:

```yaml
kind: provider
role: tracker | scm | design | browser
operations:
  <operation name>: <skill name>
unsupported: [<operation name>, …]
scripts:                        # optional (D95)
  <operation name>: "<path, relative to the pack root>"
text_conventions:               # tracker role only — how this tracker's items are written
  design_keywords: [<string>, …]
  reproduction_headings: [<string>, …]
  acceptance_criteria_headings: [<string>, …]
```

`text_conventions` lives with the **tracker** because it describes how one tracker's items are
written, not what a platform does with them. A team that formats bugs differently changes its
tracker pack, not the platform pack, and `intake` reads the lists rather than carrying any of its
own. *Added 2026-09-08 (D66):* `acceptance_criteria_headings` — the heading names `intake` matches
to set `has_acceptance_criteria`, the same literal-match mechanism `reproduction_headings` already
uses for `has_reproduction_steps`. `has_reproduction_url` needs no such list: any `http(s)` URL in
the sanitized text sets it, on the same over-matching-is-cheap reasoning §5 already states for
`design_keywords`.

**A fourth optional key, `scripts` (D95).** `operations:` names, for each operation, the skill an
agent invokes with `Skill()` — never a command a script can run as a subprocess. `scripts:` is a
separate, optional mapping from an operation name already present in `operations:` to a path,
relative to the pack root, of a script that implements that same operation for a caller that must
run it as a subprocess rather than through `Skill()` — a deterministic script that itself needs to
perform the operation, the way `shared/lib/check-reachability.sh` needs to run `render`. Most
operations are never invoked this way, so a provider with no script-level caller declares nothing
here, and one that has such a caller declares only the operations that caller needs. A key naming an
operation absent from `operations:`, or a path that does not resolve to a real file under the pack
root, is a contract violation (validator 17, §13) — the same treatment a dangling `operations:` skill
already gets.

**A fifth optional key, `requires` (D97).** A provider pack may depend on something being present on
the machine that runs it. It declares that here, as data:

```yaml
requires:                       # optional, provider packs only
  - tool: <identifier>          # what must be present
    probe: [<argv>, …]          # how "present" is answered
    remedy: "<what a human runs to fix it>"
```

- **Absent means ungated.** A pack that declares no `requires:` has no local precondition — the same
  rule an undeclared `unsupported:` list already follows.
- **`probe` is argv and is judged by exit status alone.** Never a shell string, never interpolated,
  never parsed for a version. A version comparison is a second question this key cannot ask.
- **A probe argument may carry the prefix `<pack>/`**, resolved against the pack root, so a pack
  whose "is it present" question needs real logic ships that logic itself rather than the core
  guessing on its behalf (added 2026-09-21 while building Phase 3 / Task 11, which is where the
  need first appeared). Such a path is validated as a `scripts:` path is — no `..` segment, and the
  file must exist. A bare relative path is never resolved: it would depend on the caller's
  directory, which is the caller's business and never the pack's.
- **`remedy` is read by a human, never executed.** Nothing in the core or any pack may pass it to a
  shell — that would be the install this contract forbids (§6).
- **Two readers, one declaration.** The read-only diagnostic (§6) and the operation's own first step
  both quote this, and nothing else answers "is the tool installed". Pre-flight does not read it.

A malformed entry — `probe` given as a string, a missing `remedy`, or `requires:` on a platform pack
— is a contract violation (validator 18, §13).

**A sixth optional key, `session_tools` (added 2026-10-12, D130; spec 34).** A provider pack's
operations may call tools that only the session running the route provides — a tool a plugin or a
server registers in the session. No script can see that registry, so `requires` cannot declare it.

```yaml
session_tools:                  # optional, provider packs only, the last key
  - tool: <exact tool name>
    remedy: "<what a human does to fix it>"
```

- **Absent means ungated**, as for `requires`.
- **One reader decides, at run time:** the route driver, after `intake` and the stage conditions and
  before the first run state, marker or branch exists, checks the declared tools of every pack whose
  role the run will use against the session's registry in one `ToolSearch` call;
  `check-session-tools.sh` compares names declared with names found. A miss ends the run `blocked`
  with the declared `remedy`. Pre-flight does not read this key and stays declarative (§6).
- `health` lists the declared tools as checked at run time; it cannot see the registry either.
- Shape: validator 24 (§13).

### 11.1 Condition semantics

- **A stage with no `when:` always runs.**
- **`when:` is a list of blocks. Any block matching runs the stage** — blocks are alternatives.
- **Within one block every key must match.** Absent keys are not tested.
- **Keys name §5 fact-record fields only.** Nothing else is addressable: not the environment, not
  a previous stage's output, not the clock. Environment questions belong to pre-flight (§6).
- **A value must match its field's kind** (D63). A **list** field (`labels`, `components`,
  `files_named`) is compared against `present` or `empty` — an absent list and an empty one are the
  same thing, so both are `empty`. A **boolean** field (`design_source`, `design_mentioned`, every
  `has_*`) is compared against `true` or `false`. A **string** field is compared against a literal.
  This is what lets §4's *"when `components` is present"* be written at all, since presence is not
  equality against any value; and it makes validator 12 reject `components: true` or
  `design_source: present` as well as an unknown field name.
- **A skipped stage is recorded `skipped` in run state** and control passes to the next stage in
  list order. Skipping is visible, which a route that simply never contained the stage was not.

The list form exists because a single AND-block cannot express the design condition — a stage must
run when a reference is present *or* when the text asked for one:

```yaml
- id: extract
  skill: eds-extract
  when:
    - { design_source: true }
    - { design_mentioned: true }
```

*Rejected: a derived `design_required` fact.* It would have kept conditions to one key, but a
field computed from two other fields is a conclusion, and §5 holds facts only.

Every pack declares the core in its `plugin.json` `dependencies` array so installing the pack
installs the core.

### 11.2 Where a plugin is found (D126)

*Added 2026-10-08 (D126, Phase 47 / Task 1).* This contract had no location rule before this section. The
convention "an installed pack is a sibling directory of the core's plugin root" lived only in `run-route` and the
core's README, and is withdrawn: an installed plugin lives in its own versioned cache directory, so `..` from one
plugin root does not reach another. **Status on 2026-10-09: built, not run installed.** The registry writer, the
resolver and every plugin's `SessionStart` entry exist (Phase 47 / Task 2); each pack carries the `core` link and
reaches the core only through it (Phase 47 / Task 3); every core → pack and pack → pack reference asks the resolver,
and the branch check fails closed (Phase 47 / Task 5). Every plugin is still loaded by path from one source tree; no
run from installed copies has been made.
What is not marked built under "Built by" does not exist.

Three directions, two mechanisms:

- **A pack → its own files: `${CLAUDE_PLUGIN_ROOT}/<path>`, never through `..`.** A pack never writes
  `${CLAUDE_PLUGIN_ROOT}/../<its own name>/`; installed under a versioned directory, or renamed, that path reaches
  nothing. `check-own-root-refs.sh <plugin root>…` reports every such reference, the name read from each plugin's
  own `.claude-plugin/plugin.json` (a pack's `pack.yaml` holds no name), so the check names no pack.
- **Pack → core: the in-pack `core` link.** Each pack carries an entry named `core` at its plugin root, a
  symbolic link to the core's `shared/` directory (`core → ../agentic-core/shared` in the source tree). A pack
  reaches every core contract and script as `${CLAUDE_PLUGIN_ROOT}/core/<path>`, never as
  `${CLAUDE_PLUGIN_ROOT}/../agentic-core/…`.
  - Loaded by path, the link resolves in place.
  - Installed from a marketplace, the link's target is copied into the pack's own cached copy, so an installed
    pack holds the core files of the release it was installed from. A core change reaches an installed pack only
    when that pack's own `version` changes.
- **Core → pack and pack → pack: the root registry.** `.ai/run-context/plugin-roots/<name>` holds one file per
  plugin; `<name>` is the plugin's name, and the file's content is that plugin's absolute root.
  - **Writer:** each plugin's own `SessionStart` hook writes its `${CLAUDE_PLUGIN_ROOT}` there. The hook declares
    no `async`: a backgrounded hook lets the session's first tool call run before the file exists.
  - **Reader:** only the core's resolver, `resolve-plugin-root.sh <name>`. No skill, stage or script reads the
    registry directory itself, and none builds a path to another plugin by hand.
  - **One exception, the bootstrap (Phase 47 / Task 9, 2026-10-10):** a consumer outside every plugin — a project
    skill's script, which has no `${CLAUDE_PLUGIN_ROOT}` and no `core` link — reads the core's own entry
    (`plugin-roots/agentic-core`) once, to find the resolver at `<root>/shared/lib/resolve-plugin-root.sh`, and
    then asks the resolver for every root, the core's included. An entry that is missing, relative, or names a
    root with no resolver stops it, as the resolver would. It reads no other entry.
  - **Listing:** `resolve-plugin-root.sh --list` prints every registry entry as `<name><TAB><root>`, sorted, each
    checked as in steps 1 and 2 below; one refused entry refuses the whole list, and nothing to list is "not
    resolved". `--list --siblings` adds step 3's folders, each one holding `.claude-plugin/plugin.json`, for
    the source tree only — its own test suites — never for a caller that serves a run.
  - **A caller in a linked worktree** passes `--project-dir` with the main checkout: the registry is not
    versioned, so a worktree's own top level holds none.
  - **Kept across a fresh run:** the run-context archiver moves every other entry of `.ai/run-context/` and leaves
    `plugin-roots/` in place, since the session's hooks wrote it before the run started (G174).
  - **The name** comes from project config's `packs:` map (§7) or from the caller's own manifest. The core
    still names no pack.

**Resolution order** — the resolver prints one absolute root on stdout and exits `0`, or exits non-zero:

1. A registry file for `<name>` naming a directory that exists → that directory. Paths are compared in
   canonical form on both sides, because one directory can be spelled two ways.
2. A registry file naming a directory that does not exist → refused, non-zero. A stale entry is never taken as
   an answer and never skipped in favour of step 3.
3. No registry file → the sibling folder `<core plugin root>/../<name>`, if it exists. This fallback exists for
   path-loaded runs only, where every plugin sits side by side in one source tree. An installed plugin has no
   such sibling, so there the fallback finds nothing and step 4 applies. A pack never writes a reference that
   relies on this step.
4. Neither → non-zero exit, and the output says `<name>` was **not resolved**. A missing registry is never
   reported as the plugin being absent or not installed: the resolver cannot tell those apart.

**An unresolved plugin is an error.** A caller that gets a non-zero exit stops and reports it. It never falls
back silently, never guesses a path, and never treats the missing plugin as "no constraint applies" (G172).

**Limits, measured before the mechanism was chosen (D126):**

- The registry is empty after a fresh project's first session: that session fetches the plugins in the
  background and runs none of their hooks. A route run starts in a later session.
- A plugin loaded by path overrides an installed plugin of the same name, so a run that should use the installed
  copies loads nothing by path.

**Built by:**

- **Built 2026-10-08 (Phase 47 / Task 2):** the registry writer `register-plugin-root.sh`, the resolver
  `resolve-plugin-root.sh`, a `SessionStart` entry with no `async` in the core and in each of the five packs, and
  the archiver keeping `plugin-roots/` (G174);
- **Built 2026-10-08 (Phase 47 / Task 3):** `core → ../agentic-core/shared` in each of the five packs, and every
  pack → core reference moved onto it by `rewrite-core-refs.sh` — `${CLAUDE_PLUGIN_ROOT}/core/` in instructions and
  hook entries, `$SCRIPT_DIR/…/core/` in executed scripts — so a pack's `SessionStart` entry reaches the writer in
  an installed layout too. Simulated with a dereferenced copy, not measured in a real install;
- **Built 2026-10-09 (Phase 47 / Task 5):** every core → pack and pack → pack reference moved onto the resolver —
  the driver's pre-flight, `health`, each stage that reaches a role's pack; `setup`'s pack scan on
  `resolve-plugin-root.sh --list`; `check-branch-name.sh` resolving the platform pack, with `not-resolved` (exit 4)
  where a missing pack used to mean "no constraint declared" (G172), and its hook passing the main checkout as
  `--project-dir` and blocking on exit 4; the source-tree test suites reaching the shipped plugins through a temp
  registry (`register-source-tree.sh`); `check-own-root-refs.sh` and the own-files rule above. Every plugin loaded
  by path; tests register roots outside the source tree, but no installed copy was run.

---

## 12. Artifact registry

Versioned so a change to a shape is visible. Owned by the core for cross-stage artifacts; packs
register their own in `pack.yaml`.

| Artifact       | Version | Produced by | Required content                | Validation                                   |
| -------------- | ------- | ----------- | ------------------------------- | -------------------------------------------- |
| fact record    | 1.0     | `intake`  | Fields in §5                   | `item_id` non-empty; `item_type` present |
| sanitized spec | 1.0     | `intake`  | The work item's text, sanitized | No executable directives                     |
| run state      | 1.0     | runner      | Fields in §9                   | Pack name resolves; stage count consistent   |
| progress       | 1.0     | runner      | One row per stage               | Row count equals resolved total              |
| orchestration marker | 1.0 | runner    | Presence and mtime only         | Absent after every terminal state            |
| question-answer | 2.0    | runner      | An `answers` list; each entry `stage`, `question_id`, `question`, `answer` (§8) | Every field non-empty and one line; `stage` is a stage id; `question_id` is a lowercase id; neither `question` nor `answer` contains a double quote; no two entries share `(stage, question_id)` |
| analytics      | 1.0     | runner      | Fields in §9's *Analytics* paragraph | Every number traces to a transcript line's own `usage` object — never model-reported |

*Added Phase 2 / Task 18:* the question-answer file was already specified in §8's question
protocol (`write-question-answer.sh`, Task 12) but had no row here — flagged as an open item during
Tasks 9 and 12's sessions, closed now that this registry is itself validated.
*Bumped to 1.1, 2026-09-24 (D511):* gains `stage`, the id of the stage that asked, so the one stage
the answer is for can tell it apart from an answer meant for another.
*Bumped to 2.0, 2026-09-28 (D527, G523):* one answer per file became a list keyed by
`(stage, question_id)`, written by upsert. Measured on EDS-18: `prototype` asked two questions, the
second answer overwrote the first, and the next invocation read no target from the answer it got. A
1.1 file is not read as 2.0 — the reader and writer both refuse it as malformed rather than guess
which key its one answer had.

*Added Phase 2 / Task 20:* `analytics.md`, produced by `runner` at a terminal state the same way
`run-state.json` and `progress.md` are — rendered by a script from the session transcript's own
`usage` records, never asked of the model.

---

## 13. Deterministic validators

No model involved. These are the CI floor; they cost nothing and catch contract drift.

1. Every `id` in a platform pack's `stages:` list is one of the fifteen in §4. *Strengthened by
   D42 — before the vocabulary was closed, this could only check the id against the pack's own
   declarations, which is not a check at all.*
2. A platform pack's `stages:` list begins with `intake` and ends with `deliver`, and neither
   carries a `when:` (§4).
3. Every skill named in a pack manifest exists at that path.
4. Every stage adapter's text references the envelope contract.
5. Every role operation in §6 is either implemented or listed in `unsupported`.
6. Config validates against the schema in §7, as ordinary YAML — and declares no stages.
7. Every artifact in the registry names a producer that exists.
8. No file under the core contains a product, platform or tool name — a grep against a denylist.
   This is the naming rule made executable rather than remembered. *Scope narrowed 2026-09-30
   (Phase 9 / Task 3):* an installed third-party dependency under the core (any `node_modules`
   directory) is not the core's own text and is not scanned, the same way the validator's own
   fixtures are not; the runner's dependency was the first such tree.
9. Plugin manifests validate.
10. A generated pack (§7.1) contains no unfilled template placeholder — an unanswered convention
    is a failed setup, not a pack with a hole in it.
11. Every skill named in a platform pack's `stages:` map declares isolated execution in its own
    frontmatter — the literal key is `context: fork`. A stage that omits it still runs, and still
    returns a valid envelope, so nothing visible fails; what fails silently is the cost model,
    because that stage's context accumulates in the runner instead of dying with the stage. This
    is the only rule here whose violation is invisible in a run's output, which is why it is
    mechanical rather than documented. (D49.)
12. Every key in every stage's `when:` names a field that exists in §5. A condition on a field the
    fact record does not carry can never match, and would silently disable its stage forever.
13. A platform pack declares `readiness_criteria` for at least one `item_type`, and every field
    those criteria require exists in §5. A pack with none would `fail` every item it was given.
14. The pack's stage list and its route digraph agree: every stage in the manifest has a node,
    every node has a stage, and every conditional stage's incoming edge label matches its `when:`.
    *This is what makes the digraph documentation rather than decoration* — without it the picture
    drifts from the contract, which is exactly how the pre-D42 diagram went stale. The digraph is
    `route.dot` at the pack root and its exact shape is in §11 (D58): stage-id nodes only, `style=dashed`
    iff the stage carries `when:`, and an incoming edge label equal — by string comparison, not
    judgment — to §11's canonical rendering of that `when:`. *The precedent this was checked against
    keeps both descriptions hand-maintained with nothing comparing them, which is the failure this
    rule exists to prevent rather than a design to copy.*
15. A platform pack's `onboarding_state_path`, `audit_findings_path` and `audit_digest_path`, when
    present, each
    resolve — a non-empty relative path, naming no absolute location and containing no `..`
    segment. This validator never checks the path exists in any particular project's working tree;
    only pre-flight (§6.3), run against a real project, does that — a pack has no fixed project to
    validate against, and a static manifest check that tried would be checking the wrong thing.
16. A platform pack's `evidence_manifest`, when present, names an artifact id that appears in that
    same pack's own `artifacts:` list (D86). This validator checks the id resolves, the same shape
    validator 7 already checks for the registry's own producers; it says nothing about the shape of
    the artifact at that id, which is a separate, deterministic check against the fixed shape D86
    fixes.
17. A provider manifest's `scripts:`, when present, maps only operation names that also appear in
    that same manifest's `operations:`, and every path resolves to a real file under the pack root
    (D95). The same two checks validator 5 and validator 3 already apply to `operations:` itself —
    every key a real operation, every named file real — extended to this second, optional mapping.
18. A provider manifest's `requires:`, when present, declares each entry with a non-empty `tool`, a
    `probe` given as a list of arguments rather than a string, and a non-empty `remedy` (D97). Any
    probe argument prefixed `<pack>/` resolves to a real file under the pack root, checked the same
    way a `scripts:` path is. A platform manifest declaring `requires:` is rejected — the key belongs to the provider kind only,
    the same way `text_conventions` belongs to the tracker role only.
19. A provider manifest's `requires_interactive_session:`, when present, names only operations
    that also appear in that same manifest's `operations:` (D100) — the same check validator 17
    already applies to `scripts:`. A platform manifest declaring it is rejected, the same way
    validator 18 rejects a platform manifest declaring `requires:`.
20. No shipped file cites a path this repository does not publish, and none carries a provenance
    or rationale section heading. A plugin ships without this repository's planning documents, so
    a citation of one points at something the reader of the shipped copy cannot open, and a
    rationale section carries reasoning that belongs with the task that produced it. Publication
    is resolved through the repository's own ignore rules rather than a maintained list of
    directories, so the check follows those rules instead of drifting from them, and a cited path
    must actually resolve before it counts — ignore rules match on shape, and a fixture's
    plausible-looking URL is not a citation of anything.

    *Two parts of the same house rule are deliberately outside this validator.* Whether a command
    or platform name is a legitimate invocation or narration needs a reader, and its denylisted
    subset is already validator 8's. And the rule that borrowed-material attribution lives
    centrally rather than per file is unenforceable as written: both locations it names are
    unpublished, so the only copies reaching a shipped plugin are the per-file lines it asks to
    remove. See G114.
21. Every stage in a platform pack's `stages:` that declares `fix_attempts` has a
    `skills/<skill>/SKILL.md` under the pack root that invokes `check-fix-budget.sh` (D513, §11). A
    declared stage whose skill file does not invoke it, or does not exist, is named and fails the
    check; an undeclared stage that invokes it passes.
22. A platform pack's `branch_name:`, when present, declares `pattern` (a non-empty, double-quoted
    ERE that compiles) and nothing else (D544, §11). `max_length` there is invalid: it lives in the
    project config (D129, §7).
24. A provider manifest's `session_tools:`, when present, is its last key and declares each entry
    with an exact `tool` name (letters, digits, `_`, `-`; never a pattern), at most once, and a
    non-empty quoted `remedy`; present but empty, or on a platform pack, is invalid (D130, §11).

*Validators 12–14 are new with D42.* They exist because that decision moved the stage list from
config into the pack and added a condition grammar; none of them was checkable before. *Validator
15 is new with D80,* for the same reason: it checks a shape that did not exist in the manifest
before that decision. *Validator 16 is new with D86,* for the same reason again: it checks a key
that did not exist in the manifest before that decision. *Validator 17 is new with D95,* for the
same reason once more. *Validator 19 is new with D100,* same reason again. *Validator 21 is new
with D513:* it checks that a key already in the manifest has a reader, which no earlier validator
asked. *Validator 22 is new with D544,* for the same reason as 15–17.

Validator 8 is the one that matters most: every other rule in this document is checkable by
reading, but neutrality is the one that erodes silently.

*This document's own attribution to `dx-aem-flow` (header) and its citations of
`06-dx-core-deviations.md` are self-references, not platform vocabulary in a contract, and they
live here — in this gitignored plan record — exactly where `00-instructions.md` says
borrowed-material attribution belongs: once, centrally.* **They do not extend to the shipped
validator, and not even as denylist data.** An earlier version of this note instructed the
naming-rule validator (Task 17) to declare a matching exception "in that denylist" — carving out
these same two literal strings so a shipped file could pass despite naming them. Withdrawn (D51,
two rounds): round 1 dropped the carve-out but kept the two names as ordinary denylist entries;
round 2 removed them from the denylist too, since an entry still writes the name it forbids. No
shipped file under `plugins/agentic-core` names this project's own borrowed-material source at
all, in any form — not a carve-out, not a denylist entry, not a fixture proving one was caught.

---

## 14. Open items

Four of the original six were closed 2026-09-01 by checking `dx-aem-flow` rather than choosing:
sanitization (§4), the staleness window (§9), the fix-cap shape (§7), and where a question is
asked (§8). What remains:

1. **Reserved vs open stage ids** (§4) — **CLOSED 2026-09-06 by D42: fixed neutral vocabulary,
   fifteen ids, packs implement or decline but never extend.**

   *What it said before closing, kept because the reasoning is what settled it.* Verified
   2026-09-01: the reference plugin's orchestrator holds a fixed list of at most 15 phases in
   prose, each row carrying a condition; its config template declares **no** stages at all
   (sections are `dx`, `project`, `scm`, `build`, `preferences`); and platform-specific phases are
   enumerated **in the core by name**, gated by probes of the form *"only if `<platform skill>`
   exists"*. The conclusion recorded then was **"the precedent does not transfer"**, because that
   mechanism works only where the core may name platform phases.

   *Why that conclusion was half right.* The **shape** transferred and the **ownership** did not.
   We adopted the shape — one list, a condition per row, no stages in config — and moved the list
   to the pack, which is what `00-instructions.md` means by *adopt patterns, not code*. The
   closing argument is the inverse of the objection: because D28/D34 forbade platform names in the
   core from the start, every id we need is already neutral, so the list *can* be closed. The
   reference plugin cannot close its own, since `AEM Baseline` and `Editorial Guide` sit in it.
   The neutrality constraint bought the closed vocabulary.

   *The stated rule was to pick after a run, and this was decided before one.* Accepted knowingly:
   the fifteen were derived from a route that is fully specified even though it has not executed,
   and the cost of being wrong is a version bump on this contract rather than silent breakage.
   Validators 1, 2, 12, 13 and 14 in §13 all depend on the list being closed, which is what made
   deciding early worth more than waiting.
2. **`limits.questions_per_run`** (§7) — no value, and **no precedent exists**: the reference
   plugin has no question channel at all; its interactive mode is a review checkpoint between
   phases, not a question from a stage. Pick after a real run.

   *New evidence 2026-09-06 (D42), still not enough to pick a number.* Two sources of questions now
   exist where there were none: `readiness` raises one for an item that is not ready (§4), and an
   item whose only design source is an image raises one every time (§6.1). So the floor is at least
   1 in practice, and a cap of 1 would be spent before any stage could ask for anything.
3. **`limits.fix_attempts_default`** (§7) — the *shape* is settled (per stage, pack-overridable);
   the default integer is not. Observed values in comparable loops range 2–6, which is itself the
   argument against one global number.

*Rule for both remaining items: pick after a run produces evidence, not before.* Item 1 was closed
against this rule deliberately and says so; that is an exception with a stated reason, not a
repeal.

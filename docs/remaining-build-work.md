> It is the delivery automation's plan of record. Files it names (`NEXT.md`, `02-build-tasks.md`, `phase-*-done.md`, gap and decision numbers) live in a local, untracked folder of another repository and are not in this one. The status pills and layout of the original page are lost in the conversion.
> Trimmed 2026-10-14 to open work: the change log and the sections for finished phases were removed. Counts below are unchanged from the source.

Delivery automation · plan of record

# Remaining Build Work

21 of the plan's 254 tasks are still open. Six of them are nice to have: a second platform, Phase 12, and Phase 23 / Task 2. Complete phases are counted but not listed. Phases 32, 36, 37, 41 and 42 are planned but not in the task list yet, so they are listed and not counted.

233 / 254 done · 91.7% · 21 open · 15 required · 6 nice to have

## What comes next — in priority order (2026-10-06)

Phase 1 is closed; everything below the first item is backlog, in the order it would be picked up.

1.  **Phase 2, the marketplace move (Phases 46–50)** — [plan](https://claude.ai/artifact/MHrwNdYu7y6a2KcRAwfXHz); plugin freeze during Phases 47–48. Phase 50 / Task 3's proof run also closes **Phase 20 / Task 5** and **Phase 23 / Task 4**.
2.  **Authored content as a deliverable** (Phase 36, spec 29) — an item's `## Content` section becomes its own Drive page, previewed in the run and linked from the ticket and the PR. Proposed, not approved: needs your review of spec 29 and an OAuth client for Drive. Details in the section below.
3.  **Headless** — Phase 9 / Task 5, then Phase 10 / Tasks 2, 4, 5, 6, against the marketplace layout. Needs `CLAUDE_CODE_OAUTH_TOKEN` and your dispatch. **Now (2026-10-13):** a dispatch of an item with no design reference that reaches `delivered` in CI (G190 closed, G191 fixed). Before it: the action-versus-runner comparison in Phase 49 / Task 2 (see the 2026-10-10 entry above); a review-on-every-PR workflow is optional and not scheduled.
4.  **Phase 35** (G502) — onboarding notices the design it did not apply; Tasks 1 and 2 ready.
5.  **Phase 32**, then **Phase 21 / Task 5** and **Phase 22 / Task 3** — viewports and assets; file Phase 32's entries first.
6.  **Phase 53 (spec 34) — closed 2026-10-12**: merged as \#247, all three live steps passed. Open gaps from it, not scheduled: G185 (unauthenticated plugin may still list its tools), G186, G187, G188, G189.
7.  **Specs 32 and 33 (2026-10-12, proposed, after spec 34)** — design references `extract` does not read. EDS-26 delivered without them, so both are lower than they looked. Read Phase 32 before spec 33: they overlap, and Phase 32 is the better candidate.
8.  **Phase 37 / Tasks 2–6**, open gaps without a task (G510, G534, G544, G141, G145, G163, G164).
9.  **Nice to have** — Phase 6 / Task 4, Phase 12, Phase 23 / Task 2.

**Waiting on the human:** approve deleting the seven merged Phase 42 branches; review spec 29 and, for its Phase 36 / Task 1, create an OAuth desktop client ("In production") and set `GDRIVE_CLIENT_ID`, `GDRIVE_CLIENT_SECRET`, `GDRIVE_REFRESH_TOKEN` in `.claude/settings.local.json`; file Phase 32's gap and decision entries; add the four design font families (D530) if EDS-18 should match typographically; approve deleting 12 merged remote branches (listed in `NEXT.md`) (the stashes are done, Phase 41). Nice to have, 6 tasks: Phase 6 / Task 4, Phase 12 and Phase 23 / Task 2. Without them, 16 tasks close the plan of record. No time estimate is given.

In flight code exists, not done

Live run built and merged, the live half is outstanding

Ready every dependency met

Blocked waits on an open task

Nice to have optional, or logged and not scheduled

Proposed specified, not filed, not counted

Done finished today, kept here for reference

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

## How this was derived

Updated by hand from the previous status and the consolidated `NEXT.md`. Checked against GitHub PR state (#179–#201), `origin/main` at `98c4c5d`, the done ledger in `docs/implementation-plan/` and the gap register. `check-status-claims.mjs` ran on 2026-09-30 after the consolidation: 23 claims across 4 pages, all match. Phase 33 adds 6 tasks and Phase 34 adds 4, all done, to the previous 215; Phase 35 adds 6 open ones (231); Phase 38 adds 4 (235); Phase 39 adds 3 and Phase 40 adds 3 (241). Phase 32's 4, Phase 37's 6 and Phase 41's 5 are not counted until they are in the task list. On 2026-10-02, after Phase 37 was written into `NEXT.md`, `check-status-claims.mjs` checked 29 claims across 5 pages, and all match. On 2026-10-03 it checked 39 claims across 5 pages, all match, after two stale "open" claims for PR \#206 and PR \#209 were corrected. On 2026-10-04, after Phase 42, it checked 45 claims across 6 pages, all match; Phase 42's 7 tasks are provisional and not counted (no heading in `02-build-tasks.md`), so no task changed state. A second pass on 2026-10-03 added the working-tree inventory (`next-phase-41.md`, six claim markers of its own; 46 claims across 6 pages, all match) and changed no task state; the Phase 38 paragraph above had still said \#206 was open and now says merged. After the EDS-23 run the same day, three verification tasks closed (Phase 40 / Task 2, Phase 39 / Task 3, Phase 38 / Task 4) and `check-status-claims.mjs` checked 54 claims across 6 pages, all match. After the EDS-18 verification run that evening no task changed state (it failed at `publish-gate`); six gaps closed and `check-status-claims.mjs` checked 75 claims across 6 pages, all match. After the EDS-24 run on 2026-10-04 no task changed state (it failed at `verify`); G152 and G153 closed, G155 filed, and `check-status-claims.mjs` checked 52 claims across 6 pages, all match. Phase 43 adds 4 open tasks (245); after its Task 1 PR the checker read 54 claims, all match; after Task 2 (closed by its done record, docs only) and the G147/G148 PRs, 58 claims, all match; after \#225–#227 merged and G156 was filed, 60 claims, all match; after Phase 43 / Task 3 opened PR \#229 and G157 was filed, 63 claims, all match (Task 3 is in flight until \#229 merges); Phase 43 / Task 5 (G157) was added at your request (246); \#229 then merged as `3985e0a` and Task 3 is done (218), 63 claims, all match. After the delivered EDS-24 run (Phase 43 / Task 4), four verification tasks closed — Phase 43 / Task 4, Phase 28 / Task 9, Phase 6 / Task 5, Phase 18 / Task 4 (222) — G144, G150, G155 closed, G158–G161 filed, and `check-status-claims.mjs` checked 75 claims across 6 pages, all match. On 2026-10-05, after your answers, PR \#230 merged and Phase 25 / Task 8 was restated and closed on the same run (223); 75 claims, all match. Later the same day the fixing session filed Phase 44 (6 tasks, 252) and opened PRs \#231–#236 — Phase 43 / Task 5 and Phase 44 / Tasks 1–5 are in flight, nothing merged, so no task changed state; D124 filed, D530 amended, G140 and G157–G161 FIXED; `check-status-claims.mjs` checked 93 claims across 6 pages, all match. After you merged \#231–#237, Phase 43 / Task 5 and Phase 44 / Tasks 1–5 are done, and Phase 17 / Task 5 is done under your ruling (230); Phase 23 / Task 4 moves from ready to a live run, Phase 44 / Task 6 from blocked to ready; G514 closed; the claim markers in `NEXT.md` were set to merged and `check-status-claims.mjs` checked 94 claims across 6 pages, all match. Later on 2026-10-05 Phase 44 / Task 6 ran: run B passed (G149 and G161 CLOSED), run A failed at `prototype` (G162 filed); no task changed state, Task 6 moved from ready to blocked, and `check-status-claims.mjs` checked 102 claims across 6 pages, all match. After Run A re-ran to `delivered` (PR \#239) and \#238 merged, Phase 44 / Task 6 and Phase 45 / Task 1 are done (232); Phase 45 / Task 2 moves from blocked to ready; G162, G140, G158 and G159 closed; `check-status-claims.mjs` checked 113 claims across 6 pages, all match. Phase 45 / Task 2's verification then ran and is done (233); Phase 41 / Tasks 3–5 then closed (proposed, not counted: no total changed), and on 2026-10-06 Phase 1 was closed by your decision with the open tasks kept as a backlog (no count changed; 121 claims, all match), D125, G163 and G164 were filed and `check-status-claims.mjs` checked 118 claims across 6 pages, all match; on 2026-10-06 D125 was withdrawn and six drafts were committed to `main` (`9a606c1`), no task state changed, 118 claims, all match; no gap changed; the blocked counter, which had read 4 while five tasks were blocked, now reads 5; `check-status-claims.mjs` checked 114 claims across 6 pages, all match; on 2026-10-06 Phase 46 / Task 6 opened PR \#240 and filed G165–G171 (Phases 46–50 not counted, no total changed), 123 claims across 5 pages, all match.

A task counts as done only with a done-doc and its code on `main`. That keeps Phase 10 / Task 2 open though a done-doc exists. Phase 9 / Task 3 closed 2026-10-01 with `phase-9-task-3-done.md` after its CI runs. A task that touches only local docs is closed by its done-doc alone.

When picking a free phase number, grep `NEXT.md`, every `next-phase-*.md`, the archive and the task list. 32 is taken provisionally by `archive/next-phase-32.md`, 33, 34 and 35 are used, 36 is proposed by spec 29 (`29-content-authoring-spec.md`) and 37 by `NEXT.md`; the next free number is 46 (45 is the size-origin check phase, filed 2026-10-05; 44 is the EDS-24 gaps phase, filed 2026-10-05; 43 is the breakpoint and one-call phase, 42 is the EDS-18-run fixes, 41 is the working-tree inventory, 38 is G129's envelope phase, 39 the design-box phase, 40 the driver-writes-no-verdict phase).

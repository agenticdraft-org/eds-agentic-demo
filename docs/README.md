# docs

Copied on 2026-10-14 from the local, untracked `docs/implementation-plan/` of the repository `agenticDraft/aem-eds-ai-workflow-demo`, which holds the plan for the delivery automation. These files describe that work; this project only consumes its plugins.

- `NEXT.md`: what was last done, what is open, and the ready-to-paste prompts for the next task.
- `02-build-tasks.md`: the task list, each task with what it depends on, delivers, how to verify it and when to reject it.
- `00-instructions.md`: the standing rules for working on the automation.
- `01-core-contracts.md`: the interfaces of the core; it wins when documents disagree.
- `remaining-build-work.md`: the remaining work, trimmed to open work.
- `index.html`: the same page as a styled web page. Do not edit it: change `remaining-build-work.md` or `site-template.html`, then run `bash docs/build-site.sh` (needs pandoc).
- `site-template.html`, `build-site.sh`: the template and the command that builds `index.html`.

Other files they name (`03-core-design.md`, `05-gap-register.md`, `phase-*-done.md`, `archive/`) are not copied. `00-instructions.md` had one local path replaced by a placeholder; the rest is verbatim.

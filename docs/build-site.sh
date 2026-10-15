#!/usr/bin/env bash
# Run: bash docs/build-site.sh
# Builds docs/index.html from docs/remaining-build-work.md with pandoc and docs/site-template.html.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
sed -E \
  -e 's#^((Phases?|Spec) [0-9][0-9 ·]*|Phase [0-9]+ · spec [0-9]+)$#<p class="label">\1</p>#' \
  -e 's#^([0-9]+ / [0-9]+ done.*)$#<p class="stats">\1</p>#' \
  remaining-build-work.md \
  | pandoc -f gfm -t html5 --template site-template.html --metadata title="Remaining Build Work" -o index.html
echo "wrote docs/index.html"

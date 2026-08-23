#!/usr/bin/env bash
# Assert every rule in rules.yml fires on its sample. A rule that stops matching is silent:
# it reports nothing, which looks exactly like code that is clean.
set -euo pipefail
cd "$(dirname "$0")"

expected=$(grep -E '^  - id:' ../rules.yml | sed 's/^  - id: //' | sort)
found=$(uvx --quiet semgrep --config ../rules.yml --quiet --json samples 2>/dev/null \
  | python3 -c 'import json,sys; print("\n".join(sorted({r["check_id"].split(".")[-1] for r in json.load(sys.stdin)["results"]})))')

missing=$(comm -23 <(echo "$expected") <(echo "$found") || true)
if [ -n "$missing" ]; then
  echo "these rules matched nothing in selftest/samples -- they may have silently stopped working:" >&2
  echo "$missing" | sed 's/^/  /' >&2
  exit 1
fi
echo "selftest: all $(echo "$expected" | wc -l) rules fired"

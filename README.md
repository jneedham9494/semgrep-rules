# semgrep-rules

The shared semgrep ruleset used by the `agent-standards` estate. Public so that CI in
private repositories can read it without a credential — the rules are generic code
patterns and contain nothing specific to any host, deployment or account.

## Use

`semgrep` reads a config straight from a URL, so nothing needs checking out:

```sh
semgrep --config https://raw.githubusercontent.com/jneedham9494/semgrep-rules/main/rules.yml --error .
```

In a `Makefile`, keep it overridable so an offline run can point at a local clone:

```make
SEMGREP_RULES ?= https://raw.githubusercontent.com/jneedham9494/semgrep-rules/main/rules.yml

scan:
	semgrep --config $(SEMGREP_RULES) --error --quiet .
```

## What is here, and why each rule exists

Each rule encodes a written convention from `rules/` in `agent-standards`, and each was
added because something specific defeats its absence. A rule lives here rather than in prose
when a pattern can express it — prose that a linter could have checked is prose nobody runs.

| Rule | Convention it enforces |
|---|---|
| `swallowed-exception` | A failure that vanishes is indistinguishable from success |
| `except-returns-fallback` | Every failure path resolves to a denial; a deliberate fallback logs first, so the substitution is visible |
| `eval-on-non-literal` | Untrusted data reaches an interpreter as an argument, never as text it re-parses |
| `sql-built-by-string` | Data reaches the database as a bound parameter, never as part of the query string |
| `tls-verification-disabled` | Hostname and chain verification stay on in every environment, including ones that are not production today |
| `log-message-interpolated` | Log values are structured fields, so the message stays a constant and the values stay queryable |

## Scope

These are deliberately few. A rule earns its place by catching something a reviewer
reliably misses, not by covering a category — a ruleset nobody trusts gets `--exclude`d
wholesale, and then it catches nothing at all.

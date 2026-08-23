# The gate for the ruleset itself. It has exactly two ways to be broken -- invalid YAML,
# or valid YAML that the engine will not load -- and both are silent: a ruleset that fails
# to load reports no findings, which is indistinguishable from a clean scan.
#
# That is why this repository has a gate at all despite holding one data file. Consumers
# read it over https and would not notice it had stopped working.

UVX ?= uvx

.PHONY: check yaml rules selftest

check: yaml rules selftest

yaml:
	$(UVX) --quiet yamllint -d "{extends: default, rules: {line-length: {max: 120}, document-start: disable}}" rules.yml

rules:
	$(UVX) --quiet semgrep --validate --config rules.yml

# Load-bearing: `--validate` proves the file parses, not that any rule still matches what
# it was written to catch. selftest/ holds one deliberately-defective sample per rule, and
# this asserts every rule fires at least once. A pattern silently stops matching when a
# language version changes its AST, and nothing else here would notice.
selftest:
	@./selftest/run.sh

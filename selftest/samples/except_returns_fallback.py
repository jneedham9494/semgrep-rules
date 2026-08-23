"""Sample for `except-returns-fallback`."""

import subprocess


def staged_files() -> list[str]:
    try:
        proc = subprocess.run(["git", "diff", "--name-only"], capture_output=True, text=True)
    except OSError:
        return []  # indistinguishable from "nothing staged"
    return proc.stdout.split()

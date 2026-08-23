"""Sample for `swallowed-exception`."""

import subprocess


def cleanup(path: str) -> None:
    try:
        subprocess.run(["rm", "-rf", path], check=True)
    except OSError:
        pass  # the failure vanishes; the caller believes cleanup happened

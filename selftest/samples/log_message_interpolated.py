"""Sample for `log-message-interpolated`."""

import logging

_log = logging.getLogger(__name__)


def parse(name: str, fallback: float) -> None:
    _log.warning(f"{name} is not a number, using {fallback}")

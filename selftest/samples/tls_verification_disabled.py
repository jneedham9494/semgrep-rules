"""Sample for `tls-verification-disabled`."""

import requests


def fetch(url: str) -> str:
    return requests.get(url, verify=False).text

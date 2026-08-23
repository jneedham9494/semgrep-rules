"""Sample for `eval-on-non-literal`."""


def calculate(expression: str) -> object:
    return eval(expression.replace("^", "**"))

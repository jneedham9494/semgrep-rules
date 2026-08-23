"""Sample for `sql-built-by-string`."""


def fetch_org(cur: object, org_id: str) -> None:
    cur.execute(f"select * from orgs where id = {org_id}")

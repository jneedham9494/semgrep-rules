"""Sample for `test-cannot-fail`."""


async def test_role_is_restricted(client):
    # Both branches print. The suite passes whether the key is locked down or wide open,
    # and the reader sees a test named for a control that is never exercised.
    response = await client.post("/v1/chat/completions", json={"model": "no-such-model"})
    print("restricted" if response.status_code == 403 else "the role may not have applied")

#!/usr/bin/env bash

set -euo pipefail

url="${1:?Usage: smoke-test.sh <url>}"
expected='Welcome warriors to Golden Owl!'

for attempt in $(seq 1 24); do
    if response=$(curl --fail --silent --show-error --max-time 10 "$url"); then
        RESPONSE="$response" EXPECTED="$expected" node <<'NODE'
const body = JSON.parse(process.env.RESPONSE)
if (body.message !== process.env.EXPECTED) {
    throw new Error(`Unexpected response: ${process.env.RESPONSE}`)
}
console.log(process.env.RESPONSE)
NODE
        exit 0
    fi

    echo "Smoke test attempt ${attempt}/24 failed; retrying in 10 seconds."
    sleep 10
done

echo "Smoke test failed after 24 attempts." >&2
exit 1

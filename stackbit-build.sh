#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5e3fd774efb5ba001a10cbe1/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5e3fd774efb5ba001a10cbe1 
fi
curl -s -X POST https://api.stackbit.com/project/5e3fd774efb5ba001a10cbe1/webhook/build/ssgbuild > /dev/null
jekyll build
curl -s -X POST https://api.stackbit.com/project/5e3fd774efb5ba001a10cbe1/webhook/build/publish > /dev/null

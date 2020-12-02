#/bin/sh

set -ex

GIT_TAG="v4.33.0"
git clone -b ${GIT_TAG} https://github.com/v2fly/v2ray-core.git

LDFLAGS="-s -w"

cd v2ray-core

env
for GOOS_GOARCH in ${GOOS_GOARCHS}; do
    echo ${GOOS_GOARCH}
    while IFS='-' read -r GOOS GOARCH; do
        echo ${GOOS} ${GOARCH}
        go build -o /v2ray-${GOOS_GOARCH}/v2ray -trimpath -ldflags "$LDFLAGS" ./main
        go build -o /v2ray-${GOOS_GOARCH}/v2ctl -trimpath -tags confonly -ldflags "$LDFLAGS" ./infra/control/main
        cp ./release/config/*.dat /v2ray-${GOOS_GOARCH}/
    done <<< ${GOOS_GOARCH}
done

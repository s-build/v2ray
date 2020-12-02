#/bin/sh

set -ex

GIT_TAG="v4.33.0"
git clone -b ${GIT_TAG} https://github.com/v2fly/v2ray-core.git

LDFLAGS="-s -w"

cd v2ray-core
pwd

for GOOS_GOARCH in $data
do
    while IFS='-' read -r GOOS GOARCH; do
        env
        go build -o /v2ray-darwin-amd64/v2ray -trimpath -ldflags "$LDFLAGS" ./main
        go build -o /v2ray-darwin-amd64/v2ctl -trimpath -tags confonly -ldflags "$LDFLAGS" ./infra/control/main
    done <<< $part
done <<< $GOOS_GOARCHS

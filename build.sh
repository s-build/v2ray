#/bin/sh

set -ex

GIT_TAG="v4.33.0"
git clone -b ${GIT_TAG} https://github.com/v2fly/v2ray-core.git

LDFLAGS="-s -w"

cd v2ray-core

env CGO_ENABLED=0 go build -o /v2ray/v2ray -trimpath -ldflags "$LDFLAGS" ./main
env CGO_ENABLED=0 go build -o /v2ray/v2ctl -trimpath -tags confonly -ldflags "$LDFLAGS" ./infra/control/main
mkdir -p /v2ray
cp ./release/config/*.dat /v2ray/

env GOOS=darwin GOARCH=amd64 CGO_ENABLED=0 go build -o /v2ray-darwin-amd64/v2ray -trimpath -ldflags "$LDFLAGS" ./main
env GOOS=darwin GOARCH=amd64 CGO_ENABLED=0 go build -o /v2ray-darwin-amd64/v2ctl -trimpath -tags confonly -ldflags "$LDFLAGS" ./infra/control/main
mkdir -p /v2ray-darwin-amd64
cp ./release/config/*.dat /v2ray-darwin-amd64/

env GOOS=darwin GOARCH=arm64 CGO_ENABLED=0 go build -o /v2ray-darwin-arm64/v2ray -trimpath -ldflags "$LDFLAGS" ./main
env GOOS=darwin GOARCH=arm64 CGO_ENABLED=0 go build -o /v2ray-darwin-arm64/v2ctl -trimpath -tags confonly -ldflags "$LDFLAGS" ./infra/control/main
mkdir -p /v2ray-darwin-arm64
cp ./release/config/*.dat /v2ray-darwin-arm64/

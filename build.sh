#/bin/sh

set -ex

apt update
apt install -y zip git curl

GIT_TAG="v4.28.2"
git clone -b ${GIT_TAG} https://github.com/v2fly/v2ray-core.git

mkdir -p /v2ray
LDFLAGS="-s -w"

env CGO_ENABLED=0 go build -o /v2ray/v2ray -trimpath -ldflags "$LDFLAGS" ./v2ray-core/main
env CGO_ENABLED=0 go build -o /v2ray/v2ctl -trimpath -tags confonly -ldflags "$LDFLAGS" ./v2ray-core/infra/control/main
cp v2ray-core/release/config/*.dat /v2ray/

#/bin/sh

set -ex

apt update
apt install -y zip git curl

# will download src to /go/src
# fix HEAD
go get -insecure -v -t -d v2ray.com/core/...
cd ./src/v2ray.com/core
git checkout tags/v4.28.2

# build package
# https://github.com/v2ray/v2ray-core/blob/master/release/user-package.sh
mkdir -p /v2ray
LDFLAGS="-s -w"
env CGO_ENABLED=0 go build -o /v2ray/v2ray -ldflags "$LDFLAGS" ./main
env CGO_ENABLED=0 go build -o /v2ray/v2ctl -tags confonly -ldflags "$LDFLAGS" ./infra/control/main
curl -s -L -o /v2ray/geoip.dat "https://github.com/v2ray/geoip/raw/release/geoip.dat"
curl -s -L -o /v2ray/geosite.dat "https://github.com/v2ray/domain-list-community/raw/release/dlc.dat"

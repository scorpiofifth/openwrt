#!/bin/bash
# This script will run in the OpenWRT source folder.

[[ -d "../files" ]] && cp ../files .
cp ../config/diffconfig-last .config

# OpenClash
mkdir package/luci-app-openclash
cd package/luci-app-openclash
git init
git remote add -f origin https://github.com/vernesong/OpenClash.git
git config core.sparsecheckout true
echo "luci-app-openclash" >> .git/info/sparse-checkout
git pull --depth 1 origin master
git branch --set-upstream-to=origin/master master
pushd luci-app-openclash/tools/po2lmo
make && sudo make install
popd
cd ../..
echo "CONFIG_PACKAGE_luci-app-openclash=y" >> .config

# Download clash core
mkdir -p files/etc/openclash/core/
echo "Download clash_meta"
wget -nv https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-arm64.tar.gz
tar -zxf clash-linux-arm64.tar.gz && rm -f clash-linux-arm64.tar.gz
chmod 777 clash
mv clash files/etc/openclash/core/clash_meta

#!/bin/bash

cp ../.config .

# Argon theme
rm -rf package/feeds/luci/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/feeds/luci/luci-theme-argon
rm -rf package/feeds/luci/luci-app-argon-config
git clone -b 18.06 https://github.com/jerrykuku/luci-app-argon-config.git package/feeds/luci/luci-app-argon-config
echo "CONFIG_PACKAGE_luci-theme-argon=y" >> .config
echo "CONFIG_PACKAGE_luci-app-argon-config=y" >> .config

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

# OpenClash core
mkdir -p files/etc/openclash/core/
wget https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz
tar -zxf clash-linux-arm64.tar.gz && rm -f clash-linux-arm64.tar.gz
chmod 777 clash
mv clash files/etc/openclash/core/clash
wget https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-arm64.tar.gz
tar -zxf clash-linux-arm64.tar.gz && rm -f clash-linux-arm64.tar.gz
chmod 777 clash
mv clash files/etc/openclash/core/clash_meta
wget https://raw.githubusercontent.com/vernesong/OpenClash/core/master/premium/clash-linux-arm64-2023.08.17-13-gdcc8d87.gz
gunzip clash-linux-arm64-2023.08.17-13-gdcc8d87.gz
chmod 777 clash*
mv clash* files/etc/openclash/core/clash_tun
echo "CONFIG_PACKAGE_luci-app-openclash=y" >> .config

# iStore
echo "CONFIG_PACKAGE_luci-app-store=y" >> .config

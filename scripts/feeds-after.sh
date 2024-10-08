#!/bin/bash

cp ../config/diffconfig-last .config

# Argon theme
rm -rf package/feeds/luci/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/feeds/luci/luci-theme-argon
rm -rf package/feeds/luci/luci-app-argon-config
git clone -b 18.06 https://github.com/jerrykuku/luci-app-argon-config.git package/feeds/luci/luci-app-argon-config
echo "CONFIG_PACKAGE_luci-theme-argon=y" >> .config
echo "CONFIG_PACKAGE_luci-app-argon-config=y" >> .config

# Passwall
# git clone https://github.com/xiaorouji/openwrt-passwall.git package/luci-app-passwall
# git clone https://github.com/xiaorouji/openwrt-passwall-packages.git package/openwrt-passwall-packages
# echo "CONFIG_PACKAGE_luci-app-passwall=y" >> .config
# echo "CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Hysteria=y" >> .config

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
echo "Download clash"
wget -nv https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz
tar -zxf clash-linux-arm64.tar.gz && rm -f clash-linux-arm64.tar.gz
chmod 777 clash
mv clash files/etc/openclash/core/clash
echo "Download clash_meta"
wget -nv https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-arm64.tar.gz
tar -zxf clash-linux-arm64.tar.gz && rm -f clash-linux-arm64.tar.gz
chmod 777 clash
mv clash files/etc/openclash/core/clash_meta

# iStore
echo "CONFIG_PACKAGE_luci-app-store=y" >> .config

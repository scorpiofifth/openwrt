#!/bin/bash
sed -i '$d' package/lean/default-settings/files/zzz-default-settings

cat << EOF >> package/lean/default-settings/files/zzz-default-settings 
uci set network.lan.ipaddr='192.168.100.1'
uci set network.wan.device='eth0'
uci set network.@device[0].ports='eth1' 'eth2' 'eth3'

uci set system.led_wan.dev='eth0'

uci set fstab.@global[0].anon_mount='0'
uci set fstab.@global[0].auto_swap='0'
uci set fstab.@global[0].auto_mount='0'
uci set fstab.@global[0].anon_mount='0'

uci set vsftpd.local.root='/'
uci set vsftpd.global.dotfile='1'
uci set vsftpd.global.lsrecurse='1'

uci set samba.@samba[0].autoshare='0'

uci set openclash.config.enable_meta_core='1'

uci commit

sed -i 's/US/CN/' /lib/wifi/mac80211.sh
sed -i 's/\${mode_band}/2g/' /lib/wifi/mac80211.sh
sed -i 's/\${channel}/auto/' /lib/wifi/mac80211.sh
sed -i 's/none/psk-mixed\\n\\t\\t\\tset wireless.default_radio\${devidx}.key=scorpiofifth/' /lib/wifi/mac80211.sh

exit 0
EOF

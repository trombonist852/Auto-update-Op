#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)

#Modify Router Name
sed -i 's/ImmortalWrt/Trb.Corp/g' package/base-files/files/bin/config_generate



#Modify Default Password
sed -i 's#root::0:0:99999:7:::#root:$1$fe9OTETj$lEJwiQW4hDxi/GNj4JUlC1:18679:0:99999:7:::#g' package/base-files/files/etc/shadow


#Add Package

git clone https://github.com/sirpdboy/luci-app-autotimeset.git package/custom/autotimeset
git clone https://github.com/godros/luci-app-godproxy.git package/custom/luci-app-godproxy
git clone https://github.com/linkease/nas-packages.git package/custom/nas-packages
svn checkout https://github.com/trombonist852/custom/trunk/luci-app-filetransfer package/custom/luci-app-filetransfer-mod

sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile           # 选择argon为默认主题



sed -i "s/OpenWrt /${Author} Compiled in $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" $ZZZ          # 增加个性名字${Author}默认为你的github账号

mkdir package/base-files/files/etc/modules.d
svn export https://github.com/maxlicheng/phicomm-n1-wireless/trunk/wireless_enable package/base-files/files/etc/modules.d/




# 设置打包固件的机型，内核组合（请看说明）
cat >$GITHUB_WORKSPACE/amlogic_openwrt <<-EOF
amlogic_model=s905x3_s905x2_s905x_s905d_s922x_s912
amlogic_kernel=5.12.12_5.4.127
rootfs_size=1500
EOF


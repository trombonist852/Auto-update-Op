#!/bin/bash

# K3专用，编译K3的时候只会出K3固件
sed -i 's|^TARGET_|# TARGET_|g; s|# TARGET_DEVICES += phicomm_k3|TARGET_DEVICES += phicomm_k3|' target/linux/bcm53xx/image/Makefile
#Modify Router Name
sed -i 's/ImmortalWrt/Trb.Corp/g' package/base-files/files/bin/config_generate



#Modify Default Password
sed -i 's#root::0:0:99999:7:::#root:$1$fe9OTETj$lEJwiQW4hDxi/GNj4JUlC1:18679:0:99999:7:::#g' package/base-files/files/etc/shadow


#rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/luci/applications/luci-app-k3screenctrl
rm -rf feeds/packages/utils/phicomm-k3screenctrl
rm -rf package/firmware/brcmfmac4366c0-firmware-vendor/files/brcmfmac4366c-pcie.bin
#Add Package
git clone https://github.com/lwz322/k3screenctrl.git package/custom/k3screenctrl
git clone https://github.com/Hill-98/luci-app-k3screenctrl.git package/custom/luci-app-k3screenctrl
git clone https://github.com/lwz322/k3screenctrl_build.git package/custom/k3screenctrl_build
#svn co https://github.com/trombonist852/custom/trunk/luci-app-passwall feeds/luci/applications/luci-app-passwall
git clone https://github.com/sirpdboy/luci-app-autotimeset.git package/custom/autotimeset
git clone https://github.com/1wrt/luci-app-ikoolproxy package/custom/luci-app-ikoolproxy
svn checkout https://github.com/trombonist852/custom/trunk/luci-app-filetransfer package/custom/luci-app-filetransfer-mod
svn co https://github.com/linkease/nas-packages/trunk/network/services/ddnsto package/custom/ddnsto
svn co https://github.com/linkease/nas-packages/trunk/network/services/linkease package/custom/linkease
svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-ddnsto package/custom/luci-app-ddnsto
svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-linkease package/custom/luci-app-linkease
svn export https://github.com/xiangfeidexiaohuo/Phicomm-K3_Wireless-Firmware/trunk/brcmfmac4366c-pcie.bin_69027 package/firmware/brcmfmac4366c0-firmware-vendor/files/brcmfmac4366c-pcie.bin
svn export https://github.com/ZhangCharlie/k3screen-fix-patch/trunk/bcm53xx/patches-5.4/906-BCM5301x-uart1.patch target/linux/bcm53xx/patches-5.4/906-BCM5301x-uart1.patch
svn export https://github.com/ZhangCharlie/k3screen-fix-patch/trunk/k3screen/000-k3screen.patch package/custom/k3screenctrl_build/patches/000-k3screen.patch

sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile           # 选择argon为默认主题

sed -i "s/OpenWrt /${Author} Compiled in $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" $ZZZ          # 增加个性名字${Author}默认为你的github账号

# 修改插件名字
sed -i 's/"aMule设置"/"电驴下载"/g' `grep "aMule设置" -rl ./`
sed -i 's/"网络存储"/"NAS"/g' `grep "网络存储" -rl ./`
sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' `grep "Turbo ACC 网络加速" -rl ./`
sed -i 's/"实时流量监测"/"流量"/g' `grep "实时流量监测" -rl ./`
sed -i 's/"KMS 服务器"/"KMS激活"/g' `grep "KMS 服务器" -rl ./`
sed -i 's/"终端"/"命令窗"/g' `grep "终端" -rl ./`
sed -i 's/"USB 打印服务器"/"打印服务"/g' `grep "USB 打印服务器" -rl ./`
sed -i 's/"Web 管理"/"Web"/g' `grep "Web 管理" -rl ./`
sed -i 's/"管理权"/"改密码"/g' `grep "管理权" -rl ./`
sed -i 's/"Argon 主题设置"/"Argon设置"/g' `grep "Argon 主题设置" -rl ./`


sed -i "s/OpenWrt /${Author} Compiled in $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" $ZZZ          # 增加个性名字${Author}默认为你的github账号


# 整理固件包时候,删除您不想要的固件或者文件,让它不需要上传到Actions空间
cat >${GITHUB_WORKSPACE}/Clear <<-EOF
rm -rf config.buildinfo
rm -rf feeds.buildinfo
rm -rf sha256sums
rm -rf version.buildinfo
EOF

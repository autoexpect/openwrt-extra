#
#-- Copyright (C) 2019 张瑞 <rui.crater@gmail.com>
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI Support for shadowsocks-libev X
LUCI_DEPENDS:= +shadowsocks-libevx +wget +iptables-mod-tproxy +coreutils +coreutils-base64 +curl +luci-compat +iptables
PKG_VERSION:=1.15

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature

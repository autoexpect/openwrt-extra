#
# Copyright 2019 张瑞 <rui.crater@gmail.com>
# Licensed to the public under the MIT License.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-daemon
PKG_VERSION:=1.2.1
PKG_RELEASE:=1

PKG_LICENSE:=MIT
PKG_MAINTAINER:=张瑞 <rui.crater@gmail.com>

LUCI_TITLE:=LuCI support for daemon
LUCI_DEPENDS:=+ca-bundle +ca-certificates +coreutils +coreutils-base64 +coreutils-nohup +coreutils-stat +lrzsz +nano +netcat +wget +chat +comgt +usb-modeswitch
LUCI_PKGARCH:=all

include $(TOPDIR)/feeds/luci/luci.mk

define Package/$(PKG_NAME)/postinst
#!/bin/sh

chmod 755 "$${IPKG_INSTROOT}/etc/init.d/daemon" >/dev/null 2>&1
ln -sf "../init.d/daemon" "$${IPKG_INSTROOT}/etc/rc.d/S99daemon" >/dev/null 2>&1

exit 0
endef

# call BuildPackage - OpenWrt buildroot signature
#
# Copyright (C) 2014-2020 张瑞 <rui.crater@gmail.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=shadowsocks-libevx
PKG_VERSION:=3.3.5
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/shadowsocks/shadowsocks-libev.git
PKG_SOURCE_VERSION:=8285e5a7de093b8ae5a2ca68f7108e6f273092b1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.xz

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=张瑞 <rui.crater@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION)

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_USE_MIPS16:=0
PKG_BUILD_PARALLEL:=1
PKG_BUILD_DEPENDS:=c-ares libev libsodium mbedtls pcre

PKG_CONFIG_DEPENDS:= \
	CONFIG_SHADOWSOCKS_STATIC_LINK \
	CONFIG_SHADOWSOCKS_WITH_EV \
	CONFIG_SHADOWSOCKS_WITH_PCRE \
	CONFIG_SHADOWSOCKS_WITH_CARES \
	CONFIG_SHADOWSOCKS_WITH_SODIUM \
	CONFIG_SHADOWSOCKS_WITH_MBEDTLS

include $(INCLUDE_DIR)/package.mk

define Package/shadowsocks-libevx
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Web Servers/Proxies
	TITLE:=Lightweight Secured Socks5 Proxy
	URL:=https://github.com/shadowsocks/shadowsocks-libev
	DEPENDS:=+libpthread \
		+!SHADOWSOCKS_WITH_EV:libev \
		+!SHADOWSOCKS_WITH_PCRE:libpcre \
		+!SHADOWSOCKS_WITH_CARES:libcares \
		+!SHADOWSOCKS_WITH_SODIUM:libsodium \
		+!SHADOWSOCKS_WITH_MBEDTLS:libmbedtls
endef

Package/shadowsocks-libevx-server = $(Package/shadowsocks-libevx)

define Package/shadowsocks-libevx-server/config
menu "Shadowsocks-libevx Compile Configuration"
	depends on PACKAGE_shadowsocks-libevx || PACKAGE_shadowsocks-libevx-server
	config SHADOWSOCKS_STATIC_LINK
		bool "enable static link libraries."
		default n

		menu "Select libraries"
			depends on SHADOWSOCKS_STATIC_LINK
			config SHADOWSOCKS_WITH_EV
				bool "static link libev."
				default y

			config SHADOWSOCKS_WITH_PCRE
				bool "static link libpcre."
				default y

			config SHADOWSOCKS_WITH_CARES
				bool "static link libcares."
				default y

			config SHADOWSOCKS_WITH_SODIUM
				bool "static link libsodium."
				default y

			config SHADOWSOCKS_WITH_MBEDTLS
				bool "static link libmbedtls."
				default y
		endmenu
endmenu
endef

define Package/shadowsocks-libevx/description
Shadowsocks-libevx is a lightweight secured socks5 proxy for embedded devices and low end boxes.
endef

Package/shadowsocks-libevx-server/description = $(Package/shadowsocks-libevx/description)

CONFIGURE_ARGS += \
	--disable-ssp \
	--disable-documentation \
	--disable-assert

ifeq ($(CONFIG_SHADOWSOCKS_STATIC_LINK),y)
	ifeq ($(CONFIG_SHADOWSOCKS_WITH_EV),y)
		CONFIGURE_ARGS += --with-ev="$(STAGING_DIR)/usr"
	endif
	ifeq ($(CONFIG_SHADOWSOCKS_WITH_PCRE),y)
		CONFIGURE_ARGS += --with-pcre="$(STAGING_DIR)/usr"
	endif
	ifeq ($(CONFIG_SHADOWSOCKS_WITH_CARES),y)
		CONFIGURE_ARGS += --with-cares="$(STAGING_DIR)/usr"
	endif
	ifeq ($(CONFIG_SHADOWSOCKS_WITH_SODIUM),y)
		CONFIGURE_ARGS += --with-sodium="$(STAGING_DIR)/usr"
	endif
	ifeq ($(CONFIG_SHADOWSOCKS_WITH_MBEDTLS),y)
		CONFIGURE_ARGS += --with-mbedtls="$(STAGING_DIR)/usr"
	endif
	CONFIGURE_ARGS += LDFLAGS="-Wl,-static -static -static-libgcc"
endif

define Package/shadowsocks-libevx/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ss-{local,redir,tunnel} $(1)/usr/bin
endef

define Package/shadowsocks-libevx-server/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ss-server $(1)/usr/bin
endef

$(eval $(call BuildPackage,shadowsocks-libevx))
$(eval $(call BuildPackage,shadowsocks-libevx-server))
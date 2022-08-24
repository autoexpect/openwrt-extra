-- Copyright (C) 2014-2021 张瑞 <rui.crater@gmail.com>
-- Licensed to the public under the GNU General Public License v3.

module("luci.controller.shadowsocks", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/shadowsocks") then
		return
	end

	local page

	page = entry({"admin", "services", "shadowsocks"}, alias("admin", "services", "shadowsocks", "general"), _("ShadowSocks"), 10)
	page.dependent = true

	page = entry({"admin", "services", "shadowsocks", "general"}, cbi("shadowsocks/general"), _("General Settings"), 15)
	page.leaf = true

	page = entry({"admin", "services", "shadowsocks", "status"}, call("action_status"))
	page.leaf = true

	page = entry({"admin", "services", "shadowsocks", "shadowsocks-ipset"}, cbi("shadowsocks/shadowsocks-ipset"), _("DNS IPSet"), 20)
	page.leaf = true
	
	page = entry({"admin", "services", "shadowsocks", "servers"}, arcombine(cbi("shadowsocks/servers"), cbi("shadowsocks/servers-details")), _("Servers Manage"), 25)
	page.leaf = true

	if luci.sys.call("command -v ss-redir >/dev/null") ~= 0 and luci.sys.call("command -v ssr-redir >/dev/null") ~= 0 then
		return
	end

	page = entry({"admin", "services", "shadowsocks", "access-control"}, cbi("shadowsocks/access-control"), _("Access Control"), 30)
	page.leaf = true

end

local function is_running(name)
	return luci.sys.call("pidof %s >/dev/null" % {name}) == 0
end

function action_status()
	luci.http.prepare_content("application/json")
	luci.http.write_json(
		{
			ss_redir = (is_running("ss-redir") or is_running("ssr-redir")),
			ss_local = (is_running("ss-local") or is_running("ssr-local")),
			ss_tunnel = (is_running("ss-tunnel") or is_running("ssr-tunnel"))
		}
	)
end

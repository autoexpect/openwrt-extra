-- Copyright 2019 Xingwang Liao <kuoruan@gmail.com>
-- Licensed to the public under the MIT License.

local http = require "luci.http"
local uci = require "luci.model.uci".cursor()
local sys = require "luci.sys"

module("luci.controller.daemon", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/daemon") then
		return
	end
	entry({"admin", "services", "daemon"}, firstchild(), "Daemon").dependent = false
	entry({"admin", "services", "daemon"}, cbi("daemon/common"), "Daemon", 1)
end

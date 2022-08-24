--[[
LuCI - Lua Configuration Interface

#
#-- Copyright (C) 2019 dz <dingzhong110@gmail.com>
#
# This is free software, licensed under the Apache License, Version 2.0 .
#
]] --
module("luci.controller.dnspod", package.seeall)

function index()
        entry({"admin", "services", "dnspod"}, cbi("dnspod"), _("DnsPod"), 59)
end

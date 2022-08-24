local SYS = require "luci.sys"

m = Map("daemon", "%s - %s" % {translate("Daemon"), translate("Common Settings")}, nil)

s = m:section(NamedSection, "main", "daemon")
s.addremove = false
s.anonymous = true

s:tab("general", "General Options")

pid = SYS.exec("pidof daemon")
if pid == "" then
    pid = "Stopped"
end
rs = s:taboption("general", Button, "restart", "Restart Daemon", "pidof: " .. pid)
rs.inputtitle = "Restart"
rs.inputstyle = "apply"
rs.write = function()
    SYS.call("/etc/init.d/daemon restart 2>&1 &")
end

o = s:taboption("general", Flag, "enabled", "Enabled")
o.rmempty = false
o = s:taboption("general", Flag, "watchnet", "Network WatchDog Enabled")
o.rmempty = false
o = s:taboption("general", Value, "exestart", "Before Execution")
o = s:taboption("general", Value, "exestop", "After Execution")

return m

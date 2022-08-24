local m, s, o, p

m = Map("shadowsocks-ipset", "%s - %s" % {translate("ShadowSocks"), translate("DNS IPSet")})

s = m:section(TypedSection, "ipsets", nil)
s.anonymous = true

o = s:option(Value, "ipset_name", translate("IPSet Name"))
o.default = "shadowsocks"
o.rmempty = false
o.readonly = true

o = s:option(Flag, "enabled", translate("Enabled"))

o = s:option(Flag, "dns_forward", translate("Forward DNS Lookups"))

p = s:option(Value, "upstream_dns_server", translate("Upstream DNS Server"))
p.default = "127.0.0.1#5300"
p.rmempty = true

p:depends("dns_forward", "1")

o = s:option(DynamicList, "managed_domain", translate("Managed Domain List"))
o.datatype = "host"

return m

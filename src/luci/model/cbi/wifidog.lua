--[[
live-8.taobao.com
]]--

local sys = require "luci.sys"
local fs = require "nixio.fs"
local uci = require "luci.model.uci".cursor()

--limeng
local running=(luci.sys.call("pidof wifidog > /dev/null") == 0)
local button=""

if running then
	m = Map("wifidog", translate("wifidog-web"), translate("wifidog：running........."))
else
	m = Map("wifidog", translate("wifidog-web"), translate("wifidog not start"))
end

if fs.access("/usr/bin/wifidog") then
	s = m:section(TypedSection, "wifidog", translate("wifidog config"))
	s.anonymous = true
	s.addremove = false

	wifi_enable = s:option(Flag, "wifidog_enable", translate("run wifidog"),translate("run or shutdown wifidog"))
	wifi_enable.default = 0

	
	gatewayID = s:option(Value,"gateway_id",translate("GatewayID"),translate("id（GatewayID）,etc:demoNode"))
	gateway_interface = s:option(Value,"gateway_interface",translate("lan"),translate("br-lan"))
	gateway_eninterface = s:option(Value,"gateway_eninterface",translate("wan"),translate("eth1/eth2"))
	gateway_hostname = s:option(Value,"gateway_hostname",translate("auth host"),translate("etc:auth.wifias.com"))
	gateway_httpport = s:option(Value,"gateway_httpport",translate("server prot"),translate("etc:2060"))
	gateway_path = s:option(Value,"gateway_path",translate("url"),translate("/demoToken/"))
	gateway_connmax = s:option(Value,"HTTPDMaxConn",translate("max user"))
	client_timeout = s:option(Value,"client_timeout",translate("client timeout"))
	check_interval = s:option(Value,"check_interval",translate("check interval"))
	TrustedHostList = s:option(Value,"TrustedHostList",translate("Trusted Host List"),translate("etc:www.wifias.com,user.wifias.com"))
	TrustedMACList = s:option(Value,"TrustedMACList",translate("Trusted MAC List"),translate("etc:00:22:11:A4:BC:88,00:22:11:A4:BC:89"))

	
	--deamo_enable = s:option(Flag, "enable", translate("Dog"),translate("reboot wifidog"))
	--deamo_enable:depends("wifidog_enable","1")
	--deamo_enable.default = 0
else
	m.pageaction = false
end

return m


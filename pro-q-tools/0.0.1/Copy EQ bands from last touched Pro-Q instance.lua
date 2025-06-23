-- Fix import paths
local __script_directory = ({reaper.get_action_context()})[2]:match('^(.+[\\\\//])') .. "?.lua"
package.path = __script_directory .. ";" .. package.path

--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____json = require("lua_modules.json.index")
local encode = ____json.encode
local ____clipboard = require("lua_modules.reaper-api.clipboard")
local copy = ____clipboard.copy
local ____fx = require("lua_modules.reaper-api.fx")
local getLastTouchedFx = ____fx.getLastTouchedFx
local ____inspect = require("lua_modules.reaper-api.inspect")
local inspect = ____inspect.inspect
local ____utils = require("lua_modules.reaper-api.utils")
local errorHandler = ____utils.errorHandler
local msgBox = ____utils.msgBox
local ____proq = require("proq")
local coerceVSTType = ____proq.coerceVSTType
local getBands = ____proq.getBands
local getProQType = ____proq.getProQType

local function main(self)
    local fx = getLastTouchedFx(nil)
    if fx == nil then
        return
    end
    local ident = fx:getIdent()
    local ____type = coerceVSTType(
        nil,
        fx:getType()
    )
    local proq = getProQType(nil, ident)
    if proq == nil then
        msgBox(
            nil,
            "Error",
            (("Last touched FX is not a Pro-Q instance!\n\nDebug info:\n" .. inspect(ident)) .. "\n") .. inspect(fx:getType())
        )
        return
    end
    if ____type == nil then
        msgBox(
            nil,
            "Error",
            (("Unsupported plugin type for last touched Pro-Q instance.\n\nDebug info:\n" .. inspect(ident)) .. "\n") .. inspect(fx:getType())
        )
        return
    end
    copy(
        nil,
        encode(getBands(nil, fx, proq))
    )
end
errorHandler(nil, main)
return ____exports

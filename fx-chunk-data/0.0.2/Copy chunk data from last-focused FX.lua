-- Fix import paths
local __script_directory = ({reaper.get_action_context()})[2]:match('^(.+[\\\\//])') .. "?.lua"
package.path = __script_directory .. ";" .. package.path

--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____clipboard = require("lua_modules.reaper-api.clipboard")
local copy = ____clipboard.copy
local ____fx = require("lua_modules.reaper-api.fx")
local getLastTouchedFx = ____fx.getLastTouchedFx
local ____utils = require("lua_modules.reaper-api.utils")
local msgBox = ____utils.msgBox

local function main(self)
    local fx = getLastTouchedFx(nil)
    if not fx then
        msgBox(nil, "Error", "Please focus on an FX before running this script")
        return
    end
    local chunk = fx:getData()
    if chunk == nil then
        msgBox(
            nil,
            "Error",
            ("This plugin type '" .. fx:getType()) .. "' does not support FX chunks"
        )
        return
    end
    copy(nil, chunk)
end
main(nil)
return ____exports

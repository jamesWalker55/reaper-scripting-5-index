-- Fix import paths
local __script_directory = ({reaper.get_action_context()})[2]:match('^(.+[\\\\//])') .. "?.lua"
package.path = __script_directory .. ";" .. package.path

local ____lualib = require("lualib_bundle")
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local ____exports = {}
local ____clipboard = require("lua_modules.reaper-api.clipboard")
local paste = ____clipboard.paste
local ____fx = require("lua_modules.reaper-api.fx")
local getLastTouchedFx = ____fx.getLastTouchedFx
local ____utils = require("lua_modules.reaper-api.utils")
local assertUnreachable = ____utils.assertUnreachable
local msgBox = ____utils.msgBox
local undoBlock = ____utils.undoBlock

local function main(self)
    local actionName = "Paste chunk data to last-focused FX"
    undoBlock(
        nil,
        function()
            local chunk = paste(nil)
            if #chunk == 0 then
                msgBox(nil, "Error", "Clipboard is empty!")
                return {desc = actionName, flags = 0}
            end
            local fx = getLastTouchedFx(nil)
            if not fx then
                msgBox(nil, "Error", "Please focus on an FX before running this script")
                return {desc = actionName, flags = 0}
            end
            if fx:isOffline() then
                msgBox(nil, "Error", "Unable to set chunk data of offline FX")
                return {desc = actionName, flags = 0}
            end
            local fxType = fx:getType()
            local success
            if __TS__StringIncludes(fxType, "VST") then
                success = fx:SetNamedConfigParm("vst_chunk", chunk)
            elseif __TS__StringIncludes(fxType, "CLAP") then
                success = fx:SetNamedConfigParm("clap_chunk", chunk)
            else
                msgBox(nil, "Error", ("This plugin type '" .. fxType) .. "' does not support FX chunks")
                return {desc = actionName, flags = 0}
            end
            if not success then
                msgBox(nil, "Error", "Unknown error: Failed to set FX chunk, please contact the developer!")
                return {desc = actionName, flags = 0}
            end
            if fx.type == "track" then
                return {desc = actionName, flags = 2}
            elseif fx.type == "take" then
                return {desc = actionName, flags = 4}
            else
                msgBox(nil, "Error", "Unknown error: Unknown target type, please contact the developer!")
                if true then
                    return {desc = actionName, flags = -1}
                end
                assertUnreachable(nil, fx)
            end
        end
    )
end
main(nil)
return ____exports

-- Fix import paths
local __script_directory = ({reaper.get_action_context()})[2]:match('^(.+[\\\\//])') .. "?.lua"
package.path = __script_directory .. ";" .. package.path

local ____lualib = require("lualib_bundle")
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local ____exports = {}
local ____clipboard = require("lua_modules.reaper-api.clipboard")
local copy = ____clipboard.copy
local ____track = require("lua_modules.reaper-api.track")
local Item = ____track.Item
local ____utils = require("lua_modules.reaper-api.utils")
local errorHandler = ____utils.errorHandler

local function main(self)
    local selectedItems = Item:getSelected()
    if #selectedItems == 0 then
        return
    end
    local trackNames = __TS__ArrayMap(
        selectedItems,
        function(____, x)
            local ____opt_0 = x:activeTake()
            return ____opt_0 and ____opt_0.name or ""
        end
    )
    copy(
        nil,
        table.concat(trackNames, "\n")
    )
end
errorHandler(nil, main)
return ____exports

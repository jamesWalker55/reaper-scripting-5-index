-- Fix import paths
local __script_directory = ({reaper.get_action_context()})[2]:match('^(.+[\\\\//])') .. "?.lua"
package.path = __script_directory .. ";" .. package.path

--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____clipboard = require("lua_modules.reaper-api.clipboard")
local paste = ____clipboard.paste
local ____track = require("lua_modules.reaper-api.track")
local Item = ____track.Item
local ____utils = require("lua_modules.reaper-api.utils")
local errorHandler = ____utils.errorHandler
local ____utilsLua = require("lua_modules.reaper-api.utilsLua")
local splitlines = ____utilsLua.splitlines
local strip = ____utilsLua.strip

local function main(self)
    local selectedItems = Item:getSelected()
    if #selectedItems == 0 then
        return
    end
    local clipboard = paste(nil)
    local names = splitlines(clipboard)
    do
        local i = 0
        while i < #selectedItems do
            do
                if i >= #names then
                    break
                end
                local item = selectedItems[i + 1]
                local take = item:activeTake()
                if take == nil then
                    goto __continue4
                end
                local name = strip(names[i + 1])
                take.name = name
            end
            ::__continue4::
            i = i + 1
        end
    end
end
errorHandler(nil, main)
return ____exports

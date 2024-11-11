-- Fix import paths
local __script_directory = ({reaper.get_action_context()})[2]:match('^(.+[\\\\//])') .. "?.lua"
package.path = __script_directory .. ";" .. package.path

--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____clipboard = require("lua_modules.reaper-api.clipboard")
local paste = ____clipboard.paste
local ____track = require("lua_modules.reaper-api.track")
local Track = ____track.Track
local ____utils = require("lua_modules.reaper-api.utils")
local errorHandler = ____utils.errorHandler
local ____utilsLua = require("lua_modules.reaper-api.utilsLua")
local splitlines = ____utilsLua.splitlines
local strip = ____utilsLua.strip

local function main(self)
    local selectedTracks = Track:getSelected()
    if #selectedTracks == 0 then
        return
    end
    local clipboard = paste(nil)
    local names = splitlines(clipboard)
    do
        local i = 0
        while i < #selectedTracks do
            if i >= #names then
                break
            end
            local track = selectedTracks[i + 1]
            local name = strip(names[i + 1])
            track:setName(name)
            i = i + 1
        end
    end
end
errorHandler(nil, main)
return ____exports

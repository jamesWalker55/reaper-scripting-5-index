-- Fix import paths
local __script_directory = ({reaper.get_action_context()})[2]:match('^(.+[\\\\//])') .. "?.lua"
package.path = __script_directory .. ";" .. package.path

local ____lualib = require("lualib_bundle")
local __TS__ArraySort = ____lualib.__TS__ArraySort
local __TS__StringAccess = ____lualib.__TS__StringAccess
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__StringSlice = ____lualib.__TS__StringSlice
local ____exports = {}
local ____track = require("lua_modules.reaper-api.track")
local Track = ____track.Track
local ____utils = require("lua_modules.reaper-api.utils")
local errorHandler = ____utils.errorHandler
local ____utilsLua = require("lua_modules.reaper-api.utilsLua")
local strip = ____utilsLua.strip

local function commonPrefixLength(self, names)
    names = {table.unpack(names)}
    __TS__ArraySort(names)
    local firstName = names[1]
    local lastName = names[#names]
    local maxPrefixLength = math.min(#firstName, #lastName)
    do
        local i = 0
        while i < maxPrefixLength do
            local a = __TS__StringAccess(firstName, i)
            local b = __TS__StringAccess(lastName, i)
            if a ~= b then
                return i
            end
            i = i + 1
        end
    end
    return maxPrefixLength
end
local function main(self)
    local selectedTracks = Track:getSelected()
    if 0 <= #selectedTracks and #selectedTracks <= 1 then
        return
    end
    local trackNames = __TS__ArrayMap(
        selectedTracks,
        function(____, x) return strip(x:getName()) end
    )
    local prefixLength = commonPrefixLength(
        nil,
        __TS__ArrayFilter(
            trackNames,
            function(____, x) return #x > 0 end
        )
    )
    do
        local i = 0
        while i < #selectedTracks do
            local track = selectedTracks[i + 1]
            local name = trackNames[i + 1]
            local newName = __TS__StringSlice(name, prefixLength, #name)
            track:setName(newName)
            i = i + 1
        end
    end
end
errorHandler(nil, main)
return ____exports

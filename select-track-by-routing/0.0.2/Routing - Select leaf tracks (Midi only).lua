-- Fix import paths
local __script_directory = ({reaper.get_action_context()})[2]:match('^(.+[\\\\//])') .. "?.lua"
package.path = __script_directory .. ";" .. package.path

--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____track = require("lua_modules.reaper-api.track")
local getProjectRoutingInfo = ____track.getProjectRoutingInfo
local Track = ____track.Track

local function main(self)
    local ____getProjectRoutingInfo_result_0 = getProjectRoutingInfo(nil, {midi = true})
    local sends = ____getProjectRoutingInfo_result_0.sends
    local receives = ____getProjectRoutingInfo_result_0.receives
    local count = Track:count()
    do
        local i = 0
        while i < count do
            local track = Track:getByIdx(i)
            local selected = sends[i] ~= nil and not (receives[i] ~= nil)
            reaper.SetTrackSelected(track.obj, selected)
            i = i + 1
        end
    end
end
main(nil)
return ____exports

-- Fix import paths
local __script_directory = ({reaper.get_action_context()})[2]:match('^(.+[\\\\//])') .. "?.lua"
package.path = __script_directory .. ";" .. package.path

local ____lualib = require("lualib_bundle")
local __TS__ArraySort = ____lualib.__TS__ArraySort
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____track = require("lua_modules.reaper-api.track")
local Track = ____track.Track
local ____utils = require("lua_modules.reaper-api.utils")
local errorHandler = ____utils.errorHandler
local msgBox = ____utils.msgBox
local undoBlock = ____utils.undoBlock

local SCRIPT_NAME = "Create MIDI channel routing track to selected tracks"
local function main(self)
    local selectedTracks = Track:getSelected()
    if #selectedTracks == 0 then
        msgBox(nil, "Error", "Please select a few tracks before running this script!")
        return
    end
    if #selectedTracks > 16 then
        msgBox(nil, "Error", "This script only supports a maximum of 16 tracks (due to MIDI only having 16 tracks)")
        return
    end
    __TS__ArraySort(
        selectedTracks,
        function(____, a, b) return a:getIdx() - b:getIdx() end
    )
    undoBlock(
        nil,
        function()
            local srcTrackIdx = selectedTracks[1]:getIdx()
            reaper.InsertTrackInProject(0, srcTrackIdx, 0)
            local srcTrack = Track:getByIdx(srcTrackIdx)
            srcTrack:setName("MIDI Router")
            do
                local i = 0
                while i < #selectedTracks do
                    local destTrack = selectedTracks[i + 1]
                    local sendIdx = reaper.CreateTrackSend(srcTrack.obj, destTrack.obj)
                    do
                        local rv = reaper.SetTrackSendInfo_Value(
                            srcTrack.obj,
                            0,
                            sendIdx,
                            "I_SRCCHAN",
                            -1
                        )
                        if not rv then
                            error(
                                __TS__New(Error, "failed to disable audio send"),
                                0
                            )
                        end
                    end
                    do
                        local midiChannel = i + 1
                        local rv = reaper.SetTrackSendInfo_Value(
                            srcTrack.obj,
                            0,
                            sendIdx,
                            "I_MIDIFLAGS",
                            midiChannel | midiChannel << 5
                        )
                        if not rv then
                            error(
                                __TS__New(Error, "failed to enable MIDI send"),
                                0
                            )
                        end
                    end
                    i = i + 1
                end
            end
            return {desc = SCRIPT_NAME, flags = -1}
        end,
        SCRIPT_NAME
    )
end
errorHandler(nil, main)
return ____exports

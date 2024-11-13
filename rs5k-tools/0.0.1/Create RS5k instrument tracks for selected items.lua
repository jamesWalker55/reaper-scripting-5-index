-- Fix import paths
local __script_directory = ({reaper.get_action_context()})[2]:match('^(.+[\\\\//])') .. "?.lua"
package.path = __script_directory .. ";" .. package.path

local ____lualib = require("lualib_bundle")
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____fx = require("lua_modules.reaper-api.fx")
local FX = ____fx.FX
local ____inspect = require("lua_modules.reaper-api.inspect")
local inspect = ____inspect.inspect
local ____rs5k = require("lua_modules.reaper-api.rs5k")
local RS5K = ____rs5k.RS5K
local ____track = require("lua_modules.reaper-api.track")
local Item = ____track.Item
local Track = ____track.Track
local ____utils = require("lua_modules.reaper-api.utils")
local errorHandler = ____utils.errorHandler
local log = ____utils.log
local undoBlock = ____utils.undoBlock

local SCRIPT_NAME = "Create RS5k instrument tracks for selected items"
local DEFAULT_NOTE = 60
local function main(self)
    undoBlock(
        nil,
        function()
            for ____, item in ipairs(Item:getSelected()) do
                do
                    local take = item:activeTake()
                    if not take then
                        goto __continue4
                    end
                    if take:isMidi() then
                        goto __continue4
                    end
                    if take:getStretchMarkerCount() > 0 then
                        log(
                            nil,
                            ("Skipping item " .. inspect(take.name)) .. ": Stretch markers are not supported"
                        )
                        goto __continue4
                    end
                    local source = take:getSource()
                    local sourceOffset = 0
                    do
                        local continueLoop = false
                        while true do
                            local info = source:getSectionInfo()
                            if not info.isSection then
                                break
                            end
                            if info.reversed then
                                log(
                                    nil,
                                    ("Skipping item " .. inspect(take.name)) .. ": Reversed items are not supported"
                                )
                                continueLoop = true
                                break
                            end
                            sourceOffset = sourceOffset + info.offset
                            local parentSource = source:getParent()
                            if parentSource == nil then
                                error(
                                    __TS__New(Error, "failed to get parent source of section PCM_source"),
                                    0
                                )
                            end
                            source = parentSource
                        end
                        if continueLoop then
                            goto __continue4
                        end
                    end
                    local sourceFilename = source:getFilename()
                    local sourceLength = source:getLength()
                    local startRatio = (take.sourceStartOffset + sourceOffset) / sourceLength
                    local endRatio = (take.sourceStartOffset + sourceOffset + item.length * take.playrate) / sourceLength
                    local realtimePitch = math.log(take.playrate) / 0.6931471805599453 * 12
                    local effectivePitch = take.pitch + (take.preservePitch and 0 or math.log(take.playrate) / 0.6931471805599453 * 12)
                    local extraPitch = effectivePitch - realtimePitch
                    do
                        local targetTrackIdx = take:getTrack():getIdx()
                        reaper.InsertTrackInProject(0, targetTrackIdx, 0)
                        local targetTrack = Track:getByIdx(targetTrackIdx)
                        targetTrack:setName(take.name)
                        do
                            local fxpos = targetTrack:addFx({vst = "ReaSamplOmatic5000"})
                            if fxpos == nil then
                                error(
                                    __TS__New(Error, "failed to add samplomatic instance"),
                                    0
                                )
                            end
                            local rs = __TS__New(
                                RS5K,
                                __TS__New(FX, {track = targetTrack.obj}, fxpos)
                            )
                            rs.attack = item.fadeInLength * 1000
                            rs.release = item.fadeOutLength * 1000
                            rs.obeyNoteOffs = true
                            rs.sampleStartOffset = startRatio
                            rs.sampleEndOffset = endRatio
                            rs.pitchOffset = realtimePitch
                            rs:modifyFiles(function(____, m)
                                m:deleteAllFiles()
                                m:addFile(0, sourceFilename)
                            end)
                        end
                        if extraPitch ~= 0 then
                            local fxpos = targetTrack:addFx({vst = "ReaPitch"})
                            if fxpos == nil then
                                error(
                                    __TS__New(Error, "failed to add ReaPitch instance"),
                                    0
                                )
                            end
                            local fx = targetTrack:getFx(fxpos)
                            local shiftParam = fx:getParameters()[4]
                            assert(
                                shiftParam:getIdent() == "3:_1__Shift__full_range_",
                                "expected param 3 to be shift parameter"
                            )
                            shiftParam:setValue((extraPitch + 24) / 48)
                        end
                        do
                            local midiItem = __TS__New(
                                Item,
                                reaper.CreateNewMIDIItemInProj(targetTrack.obj, item.position, item.position + item.length, false)
                            )
                            local midiTake = midiItem:activeTake()
                            local noteDurationTicks = reaper.MIDI_GetPPQPosFromProjTime(midiTake.obj, item.position + item.length)
                            reaper.MIDI_InsertNote(
                                midiTake.obj,
                                false,
                                false,
                                0,
                                noteDurationTicks,
                                0,
                                DEFAULT_NOTE,
                                127,
                                false
                            )
                        end
                    end
                end
                ::__continue4::
            end
            return {desc = SCRIPT_NAME, flags = -1}
        end,
        SCRIPT_NAME
    )
end
errorHandler(nil, main)
return ____exports

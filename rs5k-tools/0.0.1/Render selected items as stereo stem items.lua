-- Fix import paths
local __script_directory = ({reaper.get_action_context()})[2]:match('^(.+[\\\\//])') .. "?.lua"
package.path = __script_directory .. ";" .. package.path

local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local ____track = require("lua_modules.reaper-api.track")
local Item = ____track.Item
local Track = ____track.Track
local ____utils = require("lua_modules.reaper-api.utils")
local errorHandler = ____utils.errorHandler
local log = ____utils.log
local runMainAction = ____utils.runMainAction
local undoBlock = ____utils.undoBlock
local ____utils = require("utils")
local setTimeSelection = ____utils.setTimeSelection
local withSavedTimeSelection = ____utils.withSavedTimeSelection

local SCRIPT_NAME = "Render selected items as stereo stem items"
local function main(self)
    undoBlock(
        nil,
        function()
            withSavedTimeSelection(
                nil,
                function()
                    local trackItems = {}
                    for ____, item in ipairs(Item:getSelected()) do
                        local track = item:getTrack()
                        if trackItems[track.obj] == nil then
                            trackItems[track.obj] = {}
                        end
                        local items = trackItems[track.obj]
                        items[#items + 1] = item
                    end
                    for trackObj, items in pairs(trackItems) do
                        local track = __TS__New(Track, trackObj)
                        local trackWasMuted = track:getMuted()
                        local outputTrack = nil
                        log(
                            nil,
                            "Processing track " .. tostring(track:getIdx())
                        )
                        for ____, item in ipairs(items) do
                            local pos = item.position
                            local len = item.length
                            setTimeSelection(nil, pos, pos + len)
                            log(
                                nil,
                                ("  item at " .. tostring(pos)) .. "s:"
                            )
                            reaper.SetOnlyTrackSelected(track.obj)
                            track:setMuted(false)
                            runMainAction(nil, "_SWS_AWRENDERSTEREOSMART")
                            local renderedTrackIdx = track:getIdx() - 1
                            log(
                                nil,
                                "    rendered track idx = " .. tostring(renderedTrackIdx)
                            )
                            local renderedTrack = Track:getByIdx(renderedTrackIdx)
                            local renderedItem = nil
                            do
                                for ____, x in __TS__Iterator(renderedTrack:iterItems()) do
                                    if renderedItem ~= nil then
                                        error(
                                            __TS__New(
                                                Error,
                                                ("Expected track " .. tostring(renderedTrackIdx)) .. " to contain exactly 1 item"
                                            ),
                                            0
                                        )
                                    end
                                    renderedItem = x
                                end
                                if renderedItem == nil then
                                    error(
                                        __TS__New(
                                            Error,
                                            ("Expected track " .. tostring(renderedTrackIdx)) .. " to contain exactly 1 item"
                                        ),
                                        0
                                    )
                                end
                                local ____opt_0 = renderedItem:activeTake()
                                local isMidiItem = ____opt_0 and ____opt_0:isMidi()
                                if isMidiItem == true or isMidiItem == nil then
                                    error(
                                        __TS__New(
                                            Error,
                                            ("Expected item on track " .. tostring(renderedTrackIdx)) .. " to be audio"
                                        ),
                                        0
                                    )
                                end
                            end
                            log(
                                nil,
                                "    rendered item pos = " .. tostring(renderedItem.position)
                            )
                            if outputTrack == nil then
                                outputTrack = renderedTrack
                                log(
                                    nil,
                                    "    set output track = " .. tostring(renderedTrackIdx)
                                )
                            else
                                log(
                                    nil,
                                    "    output track = " .. tostring(outputTrack:getIdx())
                                )
                                log(
                                    nil,
                                    "    rendered track = " .. tostring(renderedTrack:getIdx())
                                )
                                assert(outputTrack.obj ~= renderedTrack.obj, "output track should be different from rendered track")
                                local rv = reaper.MoveMediaItemToTrack(renderedItem.obj, outputTrack.obj)
                                if not rv then
                                    error(
                                        __TS__New(
                                            Error,
                                            (("Failed to move item from track " .. tostring(renderedTrackIdx)) .. " to ") .. tostring(outputTrack:getIdx())
                                        ),
                                        0
                                    )
                                end
                                renderedTrack:delete()
                            end
                        end
                        track:setMuted(trackWasMuted)
                    end
                end
            )
            reaper.UpdateArrange()
            return {desc = SCRIPT_NAME, flags = -1}
        end,
        SCRIPT_NAME
    )
end
errorHandler(nil, main)
return ____exports

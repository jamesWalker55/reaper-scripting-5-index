local ____lualib = require("lualib_bundle")
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local ____extstate = require("lua_modules.reaper-api.extstate")
local TypedSection = ____extstate.TypedSection
local ____track = require("lua_modules.reaper-api.track")
local Item = ____track.Item
local ____utils = require("lua_modules.reaper-api.utils")
local undoBlock = ____utils.undoBlock
____exports.config = TypedSection(nil, "bpm-helper", {
    windowX = "number",
    windowY = "number",
    windowW = "number",
    windowH = "number",
    windowDock = "number",
    sourceBpm = "number",
    targetBpm = "number"
})
local function clamp(self, min, x, max)
    return math.min(
        math.max(min, x),
        max
    )
end
function ____exports.applyNewBpmToSelectedItems(self, sourceBpm, targetBpm, reversed)
    undoBlock(
        nil,
        "Fix item length/positioning from BPM edits",
        4,
        function()
            for ____, item in ipairs(Item:getSelected()) do
                do
                    do
                        local ____opt_0 = item:activeTake()
                        local take = ____opt_0 and ____opt_0:asTypedTake()
                        if not take then
                            goto __continue5
                        end
                        if take.TYPE ~= "AUDIO" then
                            goto __continue5
                        end
                    end
                    local fadeInLength = item.fadeInLength
                    local fadeOutLength = item.fadeOutLength
                    local oldPos = item.position
                    local oldLength = item.length
                    local oldSnapOffset = item.snapOffset
                    local oldSnapPos = oldPos + oldSnapOffset
                    local newLength = oldLength * sourceBpm / targetBpm
                    local newSnapOffset = clamp(nil, 0, reversed and oldSnapOffset + newLength - oldLength or oldSnapOffset, newLength)
                    local newPos = oldSnapPos - newSnapOffset
                    item.position = newPos
                    item.length = newLength
                    item.snapOffset = newSnapOffset
                    if reversed then
                        for ____, x in __TS__Iterator(item:iterTakes()) do
                            do
                                local take = x:asTypedTake()
                                if take.TYPE ~= "AUDIO" then
                                    goto __continue10
                                end
                                take.sourceStartOffset = take.sourceStartOffset + (oldLength - newLength) * take.playrate
                            end
                            ::__continue10::
                        end
                    end
                    item.fadeInLength = fadeInLength
                    item.fadeOutLength = fadeOutLength
                end
                ::__continue5::
            end
        end
    )
    reaper.UpdateArrange()
end
return ____exports

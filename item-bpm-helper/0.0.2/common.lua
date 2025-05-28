--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
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
                            goto __continue4
                        end
                        if take.TYPE ~= "AUDIO" then
                            goto __continue4
                        end
                    end
                    if reversed then
                        local oldItemLength = item.length
                        local newItemLength = item.length * sourceBpm / targetBpm
                        local newItemPos = item.position + oldItemLength - newItemLength
                        local fadeInLength = item.fadeInLength
                        local fadeOutLength = item.fadeOutLength
                        local rightItem = item:split(newItemPos)
                        rightItem.fadeInLength = fadeInLength
                        rightItem.fadeOutLength = fadeOutLength
                        item:delete()
                    else
                        item.length = item.length * sourceBpm / targetBpm
                    end
                end
                ::__continue4::
            end
        end
    )
    reaper.UpdateArrange()
end
return ____exports

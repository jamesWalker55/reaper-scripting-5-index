-- Fix import paths
local __script_directory = ({reaper.get_action_context()})[2]:match('^(.+[\\\\//])') .. "?.lua"
package.path = __script_directory .. ";" .. package.path

local ____lualib = require("lualib_bundle")
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local path = require("lua_modules.reaper-api.path.path")
local ____track = require("lua_modules.reaper-api.track")
local Track = ____track.Track
local ____utils = require("lua_modules.reaper-api.utils")
local errorHandler = ____utils.errorHandler
local ____reaper_2Dmicroui = require("lua_modules.reaper-microui.build.index")
local createContext = ____reaper_2Dmicroui.createContext
local microUILoop = ____reaper_2Dmicroui.microUILoop
local Option = ____reaper_2Dmicroui.Option

local function getScriptName(self)
    local is_new_value, fullpath, sectionID, cmdID, mode, resolution, val, contextstr = reaper.get_action_context()
    local parent, filename = path.split(fullpath)
    local stem, ext = path.splitext(filename)
    return stem
end
local HIGHLIGHT_COLOR = {r = 254, g = 1, b = 2}
local function colorsEqual(self, a, b)
    return a.r == b.r and a.g == b.g and a.b == b.b
end
local FRAMESKIP = 5
local NUMBER_FORMAT = "%.12f s"
local function main(self)
    gfx.init(
        getScriptName(nil),
        360,
        210
    )
    gfx.setfont(1, "Arial", 14)
    local ctx = createContext(nil)
    ctx.style.font = 1
    local frameskipLeft = FRAMESKIP
    local posDiffs = {}
    local originalItemColors = {}
    local LOW_THRESHOLD_MIN = 0
    local LOW_THRESHOLD_MAX = 1e-9
    local HIGH_THRESHOLD_MIN = LOW_THRESHOLD_MAX
    local HIGH_THRESHOLD_MAX = 0.01
    local thresholdLow = 4.5e-10
    local thresholdHigh = HIGH_THRESHOLD_MAX
    local thresholdInclusive = false
    local checkItemEnds = false
    local checkItemSnapOffset = true
    microUILoop(
        nil,
        ctx,
        function()
            if frameskipLeft > 0 then
                frameskipLeft = frameskipLeft - 1
            else
                frameskipLeft = FRAMESKIP
                do
                    posDiffs = {}
                    local anyItemColorChanged = false
                    for ____, track in __TS__Iterator(Track:iterAll()) do
                        for ____, item in __TS__Iterator(track:iterItems()) do
                            local itemPos = checkItemEnds and item.position + item.length or (checkItemSnapOffset and item.position + item.snapOffset or item.position)
                            local gridPos = reaper.BR_GetClosestGridDivision(itemPos)
                            local posDiff = math.abs(itemPos - gridPos)
                            local color = item.color
                            local ____thresholdInclusive_0
                            if thresholdInclusive then
                                ____thresholdInclusive_0 = thresholdLow <= posDiff and posDiff <= thresholdHigh
                            else
                                ____thresholdInclusive_0 = thresholdLow < posDiff and posDiff < thresholdHigh
                            end
                            local inThreshold = ____thresholdInclusive_0
                            if inThreshold then
                                posDiffs[#posDiffs + 1] = posDiff
                                if color == nil or not colorsEqual(nil, color, HIGHLIGHT_COLOR) then
                                    originalItemColors[item.obj] = color
                                    item.color = HIGHLIGHT_COLOR
                                    anyItemColorChanged = true
                                end
                            else
                                if color and colorsEqual(nil, color, HIGHLIGHT_COLOR) then
                                    local originalColor = originalItemColors[item.obj]
                                    item.color = originalColor
                                    anyItemColorChanged = true
                                end
                            end
                        end
                    end
                    if anyItemColorChanged then
                        reaper.UpdateArrange()
                    end
                end
            end
            if ctx:beginWindow("Demo Window", {x = 0, y = 0, w = 0, h = 0}, Option.NoResize | Option.NoTitle | Option.NoClose) then
                local win = ctx:getCurrentContainer()
                win.rect.w = gfx.w
                win.rect.h = gfx.h
                ctx:layoutRow({-1}, 0)
                ctx:text("Highlight items that are NOT on gridlines. The threshold controls how far the item should be from a gridline.")
                ctx:label("Threshold range:")
                ctx:layoutRow({54, -1}, 0)
                ctx:label("Low:")
                thresholdLow = ctx:slider(
                    "thresholdLow",
                    thresholdLow,
                    LOW_THRESHOLD_MIN,
                    LOW_THRESHOLD_MAX,
                    nil,
                    NUMBER_FORMAT
                )
                ctx:label("High:")
                thresholdHigh = ctx:slider(
                    "thresholdHigh",
                    thresholdHigh,
                    HIGH_THRESHOLD_MIN,
                    HIGH_THRESHOLD_MAX,
                    nil,
                    NUMBER_FORMAT
                )
                ctx:layoutRow({-1}, 0)
                thresholdInclusive = ctx:checkbox("Inclusive range", thresholdInclusive)
                checkItemEnds = ctx:checkbox("Check item ends", checkItemEnds)
                if not checkItemEnds then
                    checkItemSnapOffset = ctx:checkbox("Account for item snap offset", checkItemSnapOffset)
                end
                if ctx:header("Detected offset positions") then
                    for ____, x in ipairs(posDiffs) do
                        ctx:text(string.format(NUMBER_FORMAT, x))
                    end
                end
                ctx:endWindow()
            end
        end,
        function()
            for ____, track in __TS__Iterator(Track:iterAll()) do
                for ____, item in __TS__Iterator(track:iterItems()) do
                    local currentColor = item.color
                    if currentColor and colorsEqual(nil, currentColor, HIGHLIGHT_COLOR) then
                        local oldColor = originalItemColors[item.obj]
                        item.color = oldColor
                    end
                end
            end
            reaper.UpdateArrange()
        end
    )
end
errorHandler(nil, main)
return ____exports

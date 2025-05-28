-- Fix import paths
local __script_directory = ({reaper.get_action_context()})[2]:match('^(.+[\\\\//])') .. "?.lua"
package.path = __script_directory .. ";" .. package.path

local ____lualib = require("lualib_bundle")
local __TS__ParseInt = ____lualib.__TS__ParseInt
local __TS__Number = ____lualib.__TS__Number
local __TS__NumberIsNaN = ____lualib.__TS__NumberIsNaN
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____inspect = require("lua_modules.reaper-api.inspect")
local inspect = ____inspect.inspect
local path = require("lua_modules.reaper-api.path.path")
local ____utils = require("lua_modules.reaper-api.utils")
local errorHandler = ____utils.errorHandler
local ____reaper_2Dmicroui = require("lua_modules.reaper-microui.build.index")
local createContext = ____reaper_2Dmicroui.createContext
local microUILoop = ____reaper_2Dmicroui.microUILoop
local MouseButton = ____reaper_2Dmicroui.MouseButton
local Option = ____reaper_2Dmicroui.Option
local ____common = require("common")
local applyNewBpmToSelectedItems = ____common.applyNewBpmToSelectedItems
local config = ____common.config

local function getWindowInfo(self)
    local dock, x, y, w, h = gfx.dock(
        -1,
        0,
        0,
        0,
        0
    )
    return {
        dock = dock,
        x = x,
        y = y,
        w = w,
        h = h
    }
end
local function getScriptName(self)
    local is_new_value, fullpath, sectionID, cmdID, mode, resolution, val, contextstr = reaper.get_action_context()
    local parent, filename = path.split(fullpath)
    local stem, ext = path.splitext(filename)
    return stem
end
local function clearOnClicked(self, ctx, identifier, buf)
    if ctx.mousePressed == MouseButton.Left and ctx.focus == ctx:getId(identifier) then
        return ""
    else
        return buf
    end
end
local function startUI(self)
    local currentBpm, currentBpi = reaper.GetProjectTimeSignature2(0)
    gfx.init(
        getScriptName(nil),
        config.windowW or 150,
        config.windowH or 130,
        config.windowDock or 0,
        config.windowX or 100,
        config.windowY or 50
    )
    local ctx = createContext(nil)
    ctx.style.font = {"Arial", 14}
    local inputOldBpm = string.format("%d", currentBpm)
    local inputNewBpm = string.format("%d", currentBpm)
    local inputItemsReversed = true
    local inputSubmit = false
    microUILoop(
        nil,
        ctx,
        function(____, stop)
            if ctx:beginWindow("Items BPM Updater", {x = 0, y = 0, w = 0, h = 0}, Option.NoResize | Option.NoTitle | Option.NoClose) then
                local win = ctx:getCurrentContainer()
                win.rect.w = gfx.w
                win.rect.h = gfx.h
                ctx:layoutRow({80, -1}, 0)
                ctx:label("Old BPM")
                inputOldBpm = ctx:textbox("inputOldBpm", inputOldBpm)
                inputOldBpm = clearOnClicked(nil, ctx, "inputOldBpm", inputOldBpm)
                ctx:label("New BPM")
                inputNewBpm = ctx:textbox("inputNewBpm", inputNewBpm)
                inputNewBpm = clearOnClicked(nil, ctx, "inputNewBpm", inputNewBpm)
                ctx:layoutRow({-1}, 0)
                inputItemsReversed = ctx:checkbox("Items are reversed", inputItemsReversed)
                if ctx:button("Apply to selected") then
                    inputSubmit = true
                    stop(nil)
                end
                ctx:endWindow()
            end
        end,
        function()
            do
                local wnd = getWindowInfo(nil)
                config.windowDock = wnd.dock
                config.windowX = wnd.x
                config.windowY = wnd.y
                config.windowW = wnd.w
                config.windowH = wnd.h
            end
            if inputSubmit then
                local sourceBpm = __TS__ParseInt(inputOldBpm)
                local targetBpm = __TS__ParseInt(inputNewBpm)
                if __TS__NumberIsNaN(__TS__Number(sourceBpm)) then
                    error(
                        __TS__New(
                            Error,
                            "Invalid source BPM: " .. inspect(inputOldBpm)
                        ),
                        0
                    )
                end
                if __TS__NumberIsNaN(__TS__Number(targetBpm)) then
                    error(
                        __TS__New(
                            Error,
                            "Invalid target BPM: " .. inspect(inputNewBpm)
                        ),
                        0
                    )
                end
                config.sourceBpm = sourceBpm
                config.targetBpm = targetBpm
                applyNewBpmToSelectedItems(nil, sourceBpm, targetBpm, inputItemsReversed)
            end
        end
    )
end
errorHandler(nil, startUI)
return ____exports

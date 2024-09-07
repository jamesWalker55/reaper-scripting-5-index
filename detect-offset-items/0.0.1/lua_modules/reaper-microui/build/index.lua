local ____lualib = require("lualib_bundle")
local __TS__StringSlice = ____lualib.__TS__StringSlice
local __TS__New = ____lualib.__TS__New
local __TS__ArraySetLength = ____lualib.__TS__ArraySetLength
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local ____ffi = require("lua_modules.reaper-microui.node_modules.reaper-api.ffi.index")
local DrawStrFlags = ____ffi.DrawStrFlags
local MouseCap = ____ffi.MouseCap
local ____utils = require("lua_modules.reaper-microui.node_modules.reaper-api.utils")
local deferLoop = ____utils.deferLoop
local log = ____utils.log
local ____ui = require("lua_modules.reaper-microui.build.ui")
local ColorId = ____ui.ColorId
local CommandType = ____ui.CommandType
local Context = ____ui.Context
local IconId = ____ui.IconId
local Key = ____ui.Key
local MouseButton = ____ui.MouseButton
local Option = ____ui.Option
local Response = ____ui.Response
do
    local ____export = require("lua_modules.reaper-microui.build.ui")
    for ____exportKey, ____exportValue in pairs(____export) do
        if ____exportKey ~= "default" then
            ____exports[____exportKey] = ____exportValue
        end
    end
end
--- Create a new microUI context.
-- 
-- You must run gfx.init and gfx.setfont before calling this. E.g.:
-- 
--     gfx.init("My window", 260, 450);
--     gfx.setfont(1, "Arial", 12);
-- 
-- Afterwards, use {@link microUILoop} to run the main GUI loop.
function ____exports.createContext(self)
    return __TS__New(
        Context,
        function(____, font, str, len)
            if len ~= nil then
                str = __TS__StringSlice(str, 0, len)
            end
            local width, _ = gfx.measurestr(str)
            return width
        end,
        function(____, font)
            return gfx.texth
        end
    )
end
--- Main loop for a microUI GUI. Use {@link createContext} to create a context first.
-- 
-- Example code:
-- - {@link demoSimple}
-- - {@link demoSingleWindow}
-- - {@link demoMultiWindow}
function ____exports.microUILoop(self, ctx, func, cleanup)
    local downKeys = {
        left = false,
        middle = false,
        right = false,
        shift = false,
        ctrl = false,
        alt = false,
        backspace = false,
        ["return"] = false
    }
    local downChars = {}
    deferLoop(
        nil,
        function(____, stop)
            do
                downKeys.backspace = false
                downKeys["return"] = false
                __TS__ArraySetLength(downChars, 0)
                while true do
                    do
                        local char = gfx.getchar()
                        if char == -1 then
                            return stop(nil)
                        end
                        if char == 0 then
                            break
                        end
                        if char == 8 then
                            downKeys.backspace = true
                            goto __continue9
                        elseif char == 13 then
                            downKeys["return"] = true
                            goto __continue9
                        end
                        local isUnicode = char >> 24 == 117
                        if isUnicode then
                            local unicodeChar = char & 16777215
                            downChars[#downChars + 1] = utf8.char(unicodeChar)
                            goto __continue9
                        end
                        if 32 <= char and char <= 126 then
                            downChars[#downChars + 1] = utf8.char(char)
                            goto __continue9
                        end
                    end
                    ::__continue9::
                end
                ctx:inputScroll(gfx.mouse_hwheel * 0.2, -gfx.mouse_wheel * 0.2)
                gfx.mouse_wheel = 0
                gfx.mouse_hwheel = 0
                ctx:inputMouseMove(gfx.mouse_x, gfx.mouse_y)
                downKeys.left = gfx.mouse_cap & MouseCap.LeftMouse ~= 0
                downKeys.middle = gfx.mouse_cap & MouseCap.MiddleMouse ~= 0
                downKeys.right = gfx.mouse_cap & MouseCap.RightMouse ~= 0
                downKeys.ctrl = gfx.mouse_cap & MouseCap.CommandKey ~= 0
                downKeys.alt = gfx.mouse_cap & MouseCap.OptionKey ~= 0
                downKeys.shift = gfx.mouse_cap & MouseCap.ShiftKey ~= 0
                ctx:inputMouseContinuous((downKeys.left and MouseButton.Left or 0) | (downKeys.middle and MouseButton.Middle or 0) | (downKeys.right and MouseButton.Right or 0))
                ctx:inputKeyContinuous((downKeys.alt and Key.Alt or 0) | (downKeys.backspace and Key.Backspace or 0) | (downKeys.ctrl and Key.Ctrl or 0) | (downKeys["return"] and Key.Return or 0) | (downKeys.shift and Key.Shift or 0))
                ctx:inputText(table.concat(downChars, ""))
            end
            func(nil)
            local currentClip = nil
            for ____, cmd in __TS__Iterator(ctx:iterCommands()) do
                repeat
                    local ____switch17 = cmd.type
                    local ____cond17 = ____switch17 == CommandType.Clip
                    if ____cond17 then
                        do
                            currentClip = cmd.rect
                            break
                        end
                    end
                    ____cond17 = ____cond17 or ____switch17 == CommandType.Rect
                    if ____cond17 then
                        do
                            gfx.r = cmd.color.r / 255
                            gfx.g = cmd.color.g / 255
                            gfx.b = cmd.color.b / 255
                            gfx.a = cmd.color.a / 255
                            gfx.rect(cmd.rect.x, cmd.rect.y, cmd.rect.w, cmd.rect.h)
                            break
                        end
                    end
                    ____cond17 = ____cond17 or ____switch17 == CommandType.Text
                    if ____cond17 then
                        do
                            gfx.r = cmd.color.r / 255
                            gfx.g = cmd.color.g / 255
                            gfx.b = cmd.color.b / 255
                            gfx.a = cmd.color.a / 255
                            gfx.x = cmd.pos.x
                            gfx.y = cmd.pos.y
                            if currentClip then
                                local width, height = gfx.measurestr(cmd.str)
                                local clipLeft = cmd.pos.x < currentClip.x
                                local clipRight = cmd.pos.x + width >= currentClip.x + currentClip.w
                                local clipTop = cmd.pos.y < currentClip.y
                                local clipBottom = cmd.pos.y + height < currentClip.y + currentClip.h
                                if not clipLeft and not clipRight and not clipTop and not clipBottom then
                                    gfx.drawstr(cmd.str)
                                elseif not clipLeft and not clipTop then
                                    gfx.drawstr(cmd.str, 0, currentClip.x + currentClip.w, currentClip.y + currentClip.h)
                                else
                                    gfx.drawstr(cmd.str, 0, currentClip.x + currentClip.w, currentClip.y + currentClip.h)
                                end
                            else
                                gfx.drawstr(cmd.str)
                            end
                            break
                        end
                    end
                    ____cond17 = ____cond17 or ____switch17 == CommandType.Icon
                    if ____cond17 then
                        do
                            gfx.r = cmd.color.r / 255
                            gfx.g = cmd.color.g / 255
                            gfx.b = cmd.color.b / 255
                            gfx.a = cmd.color.a / 255
                            gfx.x = cmd.rect.x
                            gfx.y = cmd.rect.y
                            repeat
                                local ____switch27 = cmd.id
                                local ____cond27 = ____switch27 == IconId.Close
                                if ____cond27 then
                                    do
                                        gfx.drawstr("✕", DrawStrFlags.CenterHorizontally | DrawStrFlags.CenterVertically, cmd.rect.x + cmd.rect.w, cmd.rect.y + cmd.rect.h)
                                        break
                                    end
                                end
                                ____cond27 = ____cond27 or ____switch27 == IconId.Check
                                if ____cond27 then
                                    do
                                        gfx.drawstr("✓", DrawStrFlags.CenterHorizontally | DrawStrFlags.CenterVertically, cmd.rect.x + cmd.rect.w, cmd.rect.y + cmd.rect.h)
                                        break
                                    end
                                end
                                ____cond27 = ____cond27 or ____switch27 == IconId.Collapsed
                                if ____cond27 then
                                    do
                                        gfx.drawstr("▸", DrawStrFlags.CenterHorizontally | DrawStrFlags.CenterVertically, cmd.rect.x + cmd.rect.w, cmd.rect.y + cmd.rect.h)
                                        break
                                    end
                                end
                                ____cond27 = ____cond27 or ____switch27 == IconId.Expanded
                                if ____cond27 then
                                    do
                                        gfx.drawstr("▾", DrawStrFlags.CenterHorizontally | DrawStrFlags.CenterVertically, cmd.rect.x + cmd.rect.w, cmd.rect.y + cmd.rect.h)
                                        break
                                    end
                                end
                                do
                                    error("unhandled icon type: " .. tostring(cmd))
                                end
                            until true
                            break
                        end
                    end
                    do
                        error("unhandled command type: " .. tostring(cmd))
                    end
                until true
            end
            gfx.update()
        end,
        cleanup
    )
end
function ____exports.demoMultiWindow(self)
    gfx.init("Test window", 500, 500)
    gfx.setfont(1, "Arial", 12)
    local ctx = ____exports.createContext(nil)
    local bgColor = {90, 95, 100}
    local checks = {true, false, true}
    local logWindowTextboxInput = ""
    local logWindowLogUpdated = false
    local logWindowLog = ""
    local function writeLog(self, text)
        if #logWindowLog > 0 then
            logWindowLog = logWindowLog .. "\n" .. text
        else
            logWindowLog = text
        end
        logWindowLogUpdated = true
    end
    local function logWindow(self, ctx)
        if ctx:beginWindow("Log Window", {x = 350, y = 40, w = 300, h = 200}) then
            ctx:layoutRow({-1}, -25)
            ctx:beginPanel("Log Output")
            local panel = ctx:getCurrentContainer()
            ctx:layoutRow({-1}, -1)
            ctx:text(logWindowLog)
            ctx:endPanel()
            if logWindowLogUpdated then
                panel.scroll.y = panel.contentSize.y
                logWindowLogUpdated = false
            end
            local submitted = false
            ctx:layoutRow({-70, -1}, 0)
            local res, newVal = table.unpack(ctx:textbox("textbox", logWindowTextboxInput))
            logWindowTextboxInput = newVal
            if res and res & Response.Submit ~= 0 then
                ctx:setFocus(ctx.lastId)
                submitted = true
            end
            if ctx:button("Submit") then
                submitted = true
            end
            if submitted then
                writeLog(nil, logWindowTextboxInput)
                logWindowTextboxInput = ""
            end
            ctx:endWindow()
        end
    end
    local function testWindow(self, ctx)
        if ctx:beginWindow("Demo Window", {x = 40, y = 40, w = 300, h = 450}) then
            local win = ctx:getCurrentContainer()
            win.rect.w = math.max(win.rect.w, 240)
            win.rect.h = math.max(win.rect.h, 240)
            if ctx:header("Window Info") then
                local win = ctx:getCurrentContainer()
                ctx:layoutRow({54, -1}, 0)
                ctx:label("Position:")
                ctx:label((tostring(win.rect.x) .. ", ") .. tostring(win.rect.y))
                ctx:label("Size:")
                ctx:label((tostring(win.rect.w) .. ", ") .. tostring(win.rect.h))
            end
            if ctx:header("Test Buttons", Option.Expanded) then
                ctx:layoutRow({86, -110, -1}, 0)
                ctx:label("Test buttons 1:")
                if ctx:button("Button 1") then
                    writeLog(nil, "Pressed button 1")
                end
                if ctx:button("Button 2") then
                    writeLog(nil, "Pressed button 2")
                end
                ctx:label("Test buttons 2:")
                if ctx:button("Button 3") then
                    writeLog(nil, "Pressed button 3")
                end
                if ctx:button("Popup") then
                    ctx:openPopup("Test Popup")
                end
                if ctx:beginPopup("Test Popup") then
                    ctx:button("Hello")
                    ctx:button("World")
                    ctx:endPopup()
                end
            end
            if ctx:header("Tree and Text", Option.Expanded) then
                ctx:layoutRow({140, -1}, 0)
                ctx:layoutBeginColumn()
                if ctx:beginTreenode("Test 1") then
                    if ctx:beginTreenode("Test 1a") then
                        ctx:label("Hello")
                        ctx:label("world")
                        ctx:endTreenode()
                    end
                    if ctx:beginTreenode("Test 1b") then
                        if ctx:button("Button 1") then
                            writeLog(nil, "Pressed button 1")
                        end
                        if ctx:button("Button 2") then
                            writeLog(nil, "Pressed button 2")
                        end
                        ctx:endTreenode()
                    end
                    ctx:endTreenode()
                end
                if ctx:beginTreenode("Test 2") then
                    ctx:layoutRow({54, 54}, 0)
                    if ctx:button("Button 3") then
                        writeLog(nil, "Pressed button 3")
                    end
                    if ctx:button("Button 4") then
                        writeLog(nil, "Pressed button 4")
                    end
                    if ctx:button("Button 5") then
                        writeLog(nil, "Pressed button 5")
                    end
                    if ctx:button("Button 6") then
                        writeLog(nil, "Pressed button 6")
                    end
                    ctx:endTreenode()
                end
                if ctx:beginTreenode("Test 3") then
                    checks[1] = ctx:checkbox("Checkbox 1", checks[1])
                    checks[2] = ctx:checkbox("Checkbox 2", checks[2])
                    checks[3] = ctx:checkbox("Checkbox 3", checks[3])
                    ctx:endTreenode()
                end
                ctx:layoutEndColumn()
                ctx:layoutBeginColumn()
                ctx:layoutRow({-1}, 0)
                ctx:text(("Lorem ipsum dolor sit amet, consectetur adipiscing " .. "elit. Maecenas lacinia, sem eu lacinia molestie, mi risus faucibus ") .. "ipsum, eu varius magna felis a nulla.")
                ctx:layoutEndColumn()
            end
            if ctx:header("Background Color", Option.Expanded) then
                ctx:layoutRow({-78, -1}, 74)
                ctx:layoutBeginColumn()
                ctx:layoutRow({46, -1}, 0)
                ctx:label("Red:")
                bgColor[1] = math.floor(ctx:slider("bgColor[0]", bgColor[1], 0, 255))
                ctx:label("Green:")
                bgColor[2] = math.floor(ctx:slider("bgColor[1]", bgColor[2], 0, 255))
                ctx:label("Blue:")
                bgColor[3] = math.floor(ctx:slider("bgColor[2]", bgColor[3], 0, 255))
                ctx:layoutEndColumn()
                local r = ctx:layoutNext()
                ctx:drawRect(r, {r = bgColor[1], g = bgColor[2], b = bgColor[3], a = 255})
                ctx:drawControlText(
                    string.format("#%02X%02X%02X", bgColor[1], bgColor[2], bgColor[3]),
                    r,
                    ColorId.Text,
                    Option.AlignCenter
                )
            end
            ctx:endWindow()
        end
    end
    local function uint8Slider(self, ctx, name, value, low, high)
        local res = ctx:slider(
            name,
            value,
            low,
            high,
            0,
            "%.0f",
            Option.AlignCenter
        )
        return math.floor(res)
    end
    local styleWindowFields = {
        {"text:", ColorId.Text},
        {"border:", ColorId.Border},
        {"windowbg:", ColorId.WindowBG},
        {"titlebg:", ColorId.TitleBG},
        {"titletext:", ColorId.TitleText},
        {"panelbg:", ColorId.PanelBG},
        {"button:", ColorId.Button},
        {"buttonhover:", ColorId.ButtonHover},
        {"buttonfocus:", ColorId.ButtonFocus},
        {"base:", ColorId.Base},
        {"basehover:", ColorId.BaseHover},
        {"basefocus:", ColorId.BaseFocus},
        {"scrollbase:", ColorId.ScrollBase},
        {"scrollthumb:", ColorId.ScrollThumb}
    }
    local function styleWindow(self, ctx)
        if ctx:beginWindow("Style Editor", {x = 350, y = 250, w = 300, h = 240}) then
            local sw = ctx:getCurrentContainer().body.w * 0.14
            ctx:layoutRow({
                80,
                sw,
                sw,
                sw,
                sw,
                -1
            }, 0)
            do
                local i = 0
                while i < #styleWindowFields do
                    local label, colorId = table.unpack(styleWindowFields[i + 1])
                    ctx:label(label)
                    ctx.style.colors[colorId].r = uint8Slider(
                        nil,
                        ctx,
                        label .. "!r",
                        ctx.style.colors[colorId].r,
                        0,
                        255
                    )
                    ctx.style.colors[colorId].g = uint8Slider(
                        nil,
                        ctx,
                        label .. "!g",
                        ctx.style.colors[colorId].g,
                        0,
                        255
                    )
                    ctx.style.colors[colorId].b = uint8Slider(
                        nil,
                        ctx,
                        label .. "!b",
                        ctx.style.colors[colorId].b,
                        0,
                        255
                    )
                    ctx.style.colors[colorId].a = uint8Slider(
                        nil,
                        ctx,
                        label .. "!a",
                        ctx.style.colors[colorId].a,
                        0,
                        255
                    )
                    ctx:drawRect(
                        ctx:layoutNext(),
                        ctx.style.colors[colorId]
                    )
                    i = i + 1
                end
            end
            ctx:endWindow()
        end
    end
    ____exports.microUILoop(
        nil,
        ctx,
        function()
            ctx:begin()
            styleWindow(nil, ctx)
            logWindow(nil, ctx)
            testWindow(nil, ctx)
            ctx["end"](ctx)
            gfx.clear = bgColor[1] + bgColor[2] * 256 + bgColor[3] * 65536
        end
    )
end
function ____exports.demoSingleWindow(self)
    gfx.init("80gray Theme Adjuster", 260, 450)
    gfx.setfont(1, "Arial", 12)
    local ctx = ____exports.createContext(nil)
    local bgColor = {90, 95, 100}
    local checks = {true, false, true}
    ____exports.microUILoop(
        nil,
        ctx,
        function()
            ctx:begin()
            if ctx:beginWindow("Demo Window", {x = 0, y = 0, w = 0, h = 0}, Option.NoResize | Option.NoTitle | Option.NoClose) then
                local win = ctx:getCurrentContainer()
                win.rect.w = gfx.w
                win.rect.h = gfx.h
                if ctx:header("Window Info") then
                    local win = ctx:getCurrentContainer()
                    ctx:layoutRow({54, -1}, 0)
                    ctx:label("Position:")
                    ctx:label((tostring(win.rect.x) .. ", ") .. tostring(win.rect.y))
                    ctx:label("Size:")
                    ctx:label((tostring(win.rect.w) .. ", ") .. tostring(win.rect.h))
                end
                if ctx:header("Test Buttons", Option.Expanded) then
                    ctx:layoutRow({86, -110, -1}, 0)
                    ctx:label("Test buttons 1:")
                    if ctx:button("Button 1") then
                        log(nil, "Pressed button 1")
                    end
                    if ctx:button("Button 2") then
                        log(nil, "Pressed button 2")
                    end
                    ctx:label("Test buttons 2:")
                    if ctx:button("Button 3") then
                        log(nil, "Pressed button 3")
                    end
                    if ctx:button("Popup") then
                        ctx:openPopup("Test Popup")
                    end
                    if ctx:beginPopup("Test Popup") then
                        ctx:button("Hello")
                        ctx:button("World")
                        ctx:endPopup()
                    end
                end
                if ctx:header("Tree and Text", Option.Expanded) then
                    ctx:layoutRow({140, -1}, 0)
                    ctx:layoutBeginColumn()
                    if ctx:beginTreenode("Test 1") then
                        if ctx:beginTreenode("Test 1a") then
                            ctx:label("Hello")
                            ctx:label("world")
                            ctx:endTreenode()
                        end
                        if ctx:beginTreenode("Test 1b") then
                            if ctx:button("Button 1") then
                                log(nil, "Pressed button 1")
                            end
                            if ctx:button("Button 2") then
                                log(nil, "Pressed button 2")
                            end
                            ctx:endTreenode()
                        end
                        ctx:endTreenode()
                    end
                    if ctx:beginTreenode("Test 2") then
                        ctx:layoutRow({54, 54}, 0)
                        if ctx:button("Button 3") then
                            log(nil, "Pressed button 3")
                        end
                        if ctx:button("Button 4") then
                            log(nil, "Pressed button 4")
                        end
                        if ctx:button("Button 5") then
                            log(nil, "Pressed button 5")
                        end
                        if ctx:button("Button 6") then
                            log(nil, "Pressed button 6")
                        end
                        ctx:endTreenode()
                    end
                    if ctx:beginTreenode("Test 3") then
                        checks[1] = ctx:checkbox("Checkbox 1", checks[1])
                        checks[2] = ctx:checkbox("Checkbox 2", checks[2])
                        checks[3] = ctx:checkbox("Checkbox 3", checks[3])
                        ctx:endTreenode()
                    end
                    ctx:layoutEndColumn()
                    ctx:layoutBeginColumn()
                    ctx:layoutRow({-1}, 0)
                    ctx:text(("Lorem ipsum dolor sit amet, consectetur adipiscing " .. "elit. Maecenas lacinia, sem eu lacinia molestie, mi risus faucibus ") .. "ipsum, eu varius magna felis a nulla.")
                    ctx:layoutEndColumn()
                end
                if ctx:header("Background Color", Option.Expanded) then
                    ctx:layoutRow({-78, -1}, 74)
                    ctx:layoutBeginColumn()
                    ctx:layoutRow({46, -1}, 0)
                    ctx:label("Red:")
                    bgColor[1] = math.floor(ctx:slider("bgColor[0]", bgColor[1], 0, 255))
                    ctx:label("Green:")
                    bgColor[2] = math.floor(ctx:slider("bgColor[1]", bgColor[2], 0, 255))
                    ctx:label("Blue:")
                    bgColor[3] = math.floor(ctx:slider("bgColor[2]", bgColor[3], 0, 255))
                    ctx:layoutEndColumn()
                    local r = ctx:layoutNext()
                    ctx:drawRect(r, {r = bgColor[1], g = bgColor[2], b = bgColor[3], a = 255})
                    ctx:drawControlText(
                        string.format("#%02X%02X%02X", bgColor[1], bgColor[2], bgColor[3]),
                        r,
                        ColorId.Text,
                        Option.AlignCenter
                    )
                end
                ctx:endWindow()
            end
            ctx["end"](ctx)
            gfx.clear = bgColor[1] + bgColor[2] * 256 + bgColor[3] * 65536
        end
    )
end
function ____exports.demoSimple(self)
    gfx.init("My Window", 260, 450)
    gfx.setfont(1, "Arial", 12)
    local ctx = ____exports.createContext(nil)
    local checks = {true, false, true}
    ____exports.microUILoop(
        nil,
        ctx,
        function()
            ctx:begin()
            if ctx:beginWindow("Demo Window", {x = 0, y = 0, w = 0, h = 0}, Option.NoResize | Option.NoTitle | Option.NoClose) then
                local win = ctx:getCurrentContainer()
                win.rect.w = gfx.w
                win.rect.h = gfx.h
                if ctx:header("Window Info") then
                    local win = ctx:getCurrentContainer()
                    ctx:layoutRow({54, -1}, 0)
                    ctx:label("Position:")
                    ctx:label((tostring(win.rect.x) .. ", ") .. tostring(win.rect.y))
                    ctx:label("Size:")
                    ctx:label((tostring(win.rect.w) .. ", ") .. tostring(win.rect.h))
                end
                if ctx:header("Test Buttons", Option.Expanded) then
                    ctx:layoutRow({86, -110, -1}, 0)
                    ctx:label("Test buttons 1:")
                    if ctx:button("Button 1") then
                        log(nil, "Pressed button 1")
                    end
                    if ctx:button("Button 2") then
                        log(nil, "Pressed button 2")
                    end
                    ctx:label("Test buttons 2:")
                    if ctx:button("Button 3") then
                        log(nil, "Pressed button 3")
                    end
                    if ctx:button("Popup") then
                        ctx:openPopup("Test Popup")
                    end
                    if ctx:beginPopup("Test Popup") then
                        ctx:button("Hello")
                        ctx:button("World")
                        ctx:endPopup()
                    end
                end
                if ctx:header("Tree and Text", Option.Expanded) then
                    ctx:layoutRow({140, -1}, 0)
                    ctx:layoutBeginColumn()
                    if ctx:beginTreenode("Test 1") then
                        if ctx:beginTreenode("Test 1a") then
                            ctx:label("Hello")
                            ctx:label("world")
                            ctx:endTreenode()
                        end
                        if ctx:beginTreenode("Test 1b") then
                            if ctx:button("Button 1") then
                                log(nil, "Pressed button 1")
                            end
                            if ctx:button("Button 2") then
                                log(nil, "Pressed button 2")
                            end
                            ctx:endTreenode()
                        end
                        ctx:endTreenode()
                    end
                    if ctx:beginTreenode("Test 2") then
                        checks[1] = ctx:checkbox("Checkbox 1", checks[1])
                        checks[2] = ctx:checkbox("Checkbox 2", checks[2])
                        checks[3] = ctx:checkbox("Checkbox 3", checks[3])
                        ctx:endTreenode()
                    end
                    ctx:layoutEndColumn()
                    ctx:layoutBeginColumn()
                    ctx:layoutRow({-1}, 0)
                    ctx:text(("Lorem ipsum dolor sit amet, consectetur adipiscing " .. "elit. Maecenas lacinia, sem eu lacinia molestie, mi risus faucibus ") .. "ipsum, eu varius magna felis a nulla.")
                    ctx:layoutEndColumn()
                end
                ctx:endWindow()
            end
            ctx["end"](ctx)
        end
    )
end
return ____exports

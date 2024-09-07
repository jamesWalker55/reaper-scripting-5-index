local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__ArraySort = ____lualib.__TS__ArraySort
local __TS__Generator = ____lualib.__TS__Generator
local __TS__Delete = ____lualib.__TS__Delete
local __TS__StringSlice = ____lualib.__TS__StringSlice
local __TS__ParseFloat = ____lualib.__TS__ParseFloat
local __TS__StringCharAt = ____lualib.__TS__StringCharAt
local ____exports = {}
local ____deepcopy = require("lua_modules.reaper-microui.build.deepcopy")
local deepcopy = ____deepcopy.deepcopy
local ____hash = require("lua_modules.reaper-microui.build.hash")
local HASH_INITIAL = ____hash.HASH_INITIAL
local hashString = ____hash.hashString
____exports.MouseButton = MouseButton or ({})
____exports.MouseButton.None = 0
____exports.MouseButton[____exports.MouseButton.None] = "None"
____exports.MouseButton.Left = 1
____exports.MouseButton[____exports.MouseButton.Left] = "Left"
____exports.MouseButton.Right = 2
____exports.MouseButton[____exports.MouseButton.Right] = "Right"
____exports.MouseButton.Middle = 4
____exports.MouseButton[____exports.MouseButton.Middle] = "Middle"
____exports.Key = Key or ({})
____exports.Key.None = 0
____exports.Key[____exports.Key.None] = "None"
____exports.Key.Shift = 1
____exports.Key[____exports.Key.Shift] = "Shift"
____exports.Key.Ctrl = 2
____exports.Key[____exports.Key.Ctrl] = "Ctrl"
____exports.Key.Alt = 4
____exports.Key[____exports.Key.Alt] = "Alt"
____exports.Key.Backspace = 8
____exports.Key[____exports.Key.Backspace] = "Backspace"
____exports.Key.Return = 16
____exports.Key[____exports.Key.Return] = "Return"
____exports.Option = Option or ({})
____exports.Option.None = 0
____exports.Option[____exports.Option.None] = "None"
____exports.Option.AlignCenter = 1
____exports.Option[____exports.Option.AlignCenter] = "AlignCenter"
____exports.Option.AlignRight = 2
____exports.Option[____exports.Option.AlignRight] = "AlignRight"
____exports.Option.NoInteract = 4
____exports.Option[____exports.Option.NoInteract] = "NoInteract"
____exports.Option.NoFrame = 8
____exports.Option[____exports.Option.NoFrame] = "NoFrame"
____exports.Option.NoResize = 16
____exports.Option[____exports.Option.NoResize] = "NoResize"
____exports.Option.NoScroll = 32
____exports.Option[____exports.Option.NoScroll] = "NoScroll"
____exports.Option.NoClose = 64
____exports.Option[____exports.Option.NoClose] = "NoClose"
____exports.Option.NoTitle = 128
____exports.Option[____exports.Option.NoTitle] = "NoTitle"
____exports.Option.HoldFocus = 256
____exports.Option[____exports.Option.HoldFocus] = "HoldFocus"
____exports.Option.AutoSize = 512
____exports.Option[____exports.Option.AutoSize] = "AutoSize"
____exports.Option.Popup = 1024
____exports.Option[____exports.Option.Popup] = "Popup"
____exports.Option.Closed = 2048
____exports.Option[____exports.Option.Closed] = "Closed"
____exports.Option.Expanded = 4096
____exports.Option[____exports.Option.Expanded] = "Expanded"
local Position = Position or ({})
Position.Unset = 0
Position[Position.Unset] = "Unset"
Position.Relative = 1
Position[Position.Relative] = "Relative"
Position.Absolute = 2
Position[Position.Absolute] = "Absolute"
____exports.ColorId = ColorId or ({})
____exports.ColorId.Text = 0
____exports.ColorId[____exports.ColorId.Text] = "Text"
____exports.ColorId.Border = 1
____exports.ColorId[____exports.ColorId.Border] = "Border"
____exports.ColorId.WindowBG = 2
____exports.ColorId[____exports.ColorId.WindowBG] = "WindowBG"
____exports.ColorId.TitleBG = 3
____exports.ColorId[____exports.ColorId.TitleBG] = "TitleBG"
____exports.ColorId.TitleText = 4
____exports.ColorId[____exports.ColorId.TitleText] = "TitleText"
____exports.ColorId.PanelBG = 5
____exports.ColorId[____exports.ColorId.PanelBG] = "PanelBG"
____exports.ColorId.Button = 6
____exports.ColorId[____exports.ColorId.Button] = "Button"
____exports.ColorId.ButtonHover = 7
____exports.ColorId[____exports.ColorId.ButtonHover] = "ButtonHover"
____exports.ColorId.ButtonFocus = 8
____exports.ColorId[____exports.ColorId.ButtonFocus] = "ButtonFocus"
____exports.ColorId.Base = 9
____exports.ColorId[____exports.ColorId.Base] = "Base"
____exports.ColorId.BaseHover = 10
____exports.ColorId[____exports.ColorId.BaseHover] = "BaseHover"
____exports.ColorId.BaseFocus = 11
____exports.ColorId[____exports.ColorId.BaseFocus] = "BaseFocus"
____exports.ColorId.ScrollBase = 12
____exports.ColorId[____exports.ColorId.ScrollBase] = "ScrollBase"
____exports.ColorId.ScrollThumb = 13
____exports.ColorId[____exports.ColorId.ScrollThumb] = "ScrollThumb"
local function rgba(self, r, g, b, a)
    return {r = r, g = g, b = b, a = a}
end
____exports.Response = Response or ({})
____exports.Response.Active = 1
____exports.Response[____exports.Response.Active] = "Active"
____exports.Response.Submit = 2
____exports.Response[____exports.Response.Submit] = "Submit"
____exports.Response.Change = 4
____exports.Response[____exports.Response.Change] = "Change"
____exports.DEFAULT_STYLE = {
    font = nil,
    size = {x = 68, y = 10},
    padding = 5,
    spacing = 4,
    indent = 24,
    titleHeight = 24,
    scrollbarSize = 12,
    thumbSize = 8,
    colors = {
        [____exports.ColorId.Text] = rgba(
            nil,
            230,
            230,
            230,
            255
        ),
        [____exports.ColorId.Border] = rgba(
            nil,
            25,
            25,
            25,
            255
        ),
        [____exports.ColorId.WindowBG] = rgba(
            nil,
            50,
            50,
            50,
            255
        ),
        [____exports.ColorId.TitleBG] = rgba(
            nil,
            25,
            25,
            25,
            255
        ),
        [____exports.ColorId.TitleText] = rgba(
            nil,
            240,
            240,
            240,
            255
        ),
        [____exports.ColorId.PanelBG] = rgba(
            nil,
            0,
            0,
            0,
            0
        ),
        [____exports.ColorId.Button] = rgba(
            nil,
            75,
            75,
            75,
            255
        ),
        [____exports.ColorId.ButtonHover] = rgba(
            nil,
            95,
            95,
            95,
            255
        ),
        [____exports.ColorId.ButtonFocus] = rgba(
            nil,
            115,
            115,
            115,
            255
        ),
        [____exports.ColorId.Base] = rgba(
            nil,
            30,
            30,
            30,
            255
        ),
        [____exports.ColorId.BaseHover] = rgba(
            nil,
            35,
            35,
            35,
            255
        ),
        [____exports.ColorId.BaseFocus] = rgba(
            nil,
            40,
            40,
            40,
            255
        ),
        [____exports.ColorId.ScrollBase] = rgba(
            nil,
            43,
            43,
            43,
            255
        ),
        [____exports.ColorId.ScrollThumb] = rgba(
            nil,
            30,
            30,
            30,
            255
        )
    }
}
local function Rect(self, x, y, w, h)
    return {x = x, y = y, w = w, h = h}
end
local function clamp(self, x, min, max)
    return math.min(
        math.max(x, min),
        max
    )
end
local function rectOverlapsVec2(self, r, p)
    return p.x >= r.x and p.x < r.x + r.w and p.y >= r.y and p.y < r.y + r.h
end
local function intersectRects(self, r1, r2)
    local x1 = math.max(r1.x, r2.x)
    local y1 = math.max(r1.y, r2.y)
    local x2 = math.min(r1.x + r1.w, r2.x + r2.w)
    local y2 = math.min(r1.y + r1.h, r2.y + r2.h)
    if x2 < x1 then
        x2 = x1
    end
    if y2 < y1 then
        y2 = y1
    end
    return {x = x1, y = y1, w = x2 - x1, h = y2 - y1}
end
local function expandRect(self, rect, n)
    return {x = rect.x - n, y = rect.y - n, w = rect.w + n * 2, h = rect.h + n * 2}
end
local UNCLIPPED_RECT = {x = 0, y = 0, w = 16777216, h = 16777216}
____exports.Clip = Clip or ({})
____exports.Clip.None = 0
____exports.Clip[____exports.Clip.None] = "None"
____exports.Clip.Part = 1
____exports.Clip[____exports.Clip.Part] = "Part"
____exports.Clip.All = 2
____exports.Clip[____exports.Clip.All] = "All"
____exports.IconId = IconId or ({})
____exports.IconId.Close = 0
____exports.IconId[____exports.IconId.Close] = "Close"
____exports.IconId.Check = 1
____exports.IconId[____exports.IconId.Check] = "Check"
____exports.IconId.Collapsed = 2
____exports.IconId[____exports.IconId.Collapsed] = "Collapsed"
____exports.IconId.Expanded = 3
____exports.IconId[____exports.IconId.Expanded] = "Expanded"
____exports.CommandType = CommandType or ({})
____exports.CommandType.Jump = 0
____exports.CommandType[____exports.CommandType.Jump] = "Jump"
____exports.CommandType.Clip = 1
____exports.CommandType[____exports.CommandType.Clip] = "Clip"
____exports.CommandType.Rect = 2
____exports.CommandType[____exports.CommandType.Rect] = "Rect"
____exports.CommandType.Text = 3
____exports.CommandType[____exports.CommandType.Text] = "Text"
____exports.CommandType.Icon = 4
____exports.CommandType[____exports.CommandType.Icon] = "Icon"
local MU_REAL_FMT = "%.3g"
local MU_MAX_FMT = 127
local MU_SLIDER_FMT = "%.2f"
____exports.Context = __TS__Class()
local Context = ____exports.Context
Context.name = "Context"
function Context.prototype.____constructor(self, textWidth, textHeight, style)
    if style == nil then
        style = deepcopy(____exports.DEFAULT_STYLE)
    end
    self.textWidth = textWidth
    self.textHeight = textHeight
    self.style = style
    self.hover = nil
    self.focus = nil
    self.lastId = nil
    self.lastRect = nil
    self.lastZindex = 0
    self.updatedFocus = false
    self.hoverRoot = nil
    self.nextHoverRoot = nil
    self.scrollTarget = nil
    self.numberEditBuf = ""
    self.numberEdit = nil
    self.treeNodes = {}
    self.commands = {}
    self.roots = {}
    self.containerStack = {}
    self.clipStack = {}
    self.idStack = {}
    self.layoutStack = {}
    self.containers = {}
    self.mousePos = {x = 0, y = 0}
    self.lastMousePos = {x = 0, y = 0}
    self.mouseDelta = {x = 0, y = 0}
    self.scrollDelta = {x = 0, y = 0}
    self.mouseDown = ____exports.MouseButton.None
    self.mousePressed = ____exports.MouseButton.None
    self.keyDown = ____exports.Key.None
    self.keyPressed = ____exports.Key.None
    self._inputText = ""
end
function Context.prototype.inputMouseMove(self, x, y)
    self.mousePos.x = x
    self.mousePos.y = y
end
function Context.prototype.inputScroll(self, x, y)
    local ____self_scrollDelta_0, ____x_1 = self.scrollDelta, "x"
    ____self_scrollDelta_0[____x_1] = ____self_scrollDelta_0[____x_1] + x
    local ____self_scrollDelta_2, ____y_3 = self.scrollDelta, "y"
    ____self_scrollDelta_2[____y_3] = ____self_scrollDelta_2[____y_3] + y
end
function Context.prototype.inputText(self, text)
    self._inputText = text
end
function Context.prototype.inputMouseDown(self, btn)
    self.mouseDown = self.mouseDown | btn
    self.mousePressed = self.mousePressed | btn
end
function Context.prototype.inputMouseUp(self, btn)
    self.mouseDown = self.mouseDown & ~btn
end
function Context.prototype.inputMouseContinuous(self, btn)
    self.mousePressed = self.mousePressed | btn & ~self.mouseDown
    self.mouseDown = btn
end
function Context.prototype.inputKeyDown(self, key)
    self.keyDown = self.keyDown | key
    self.keyPressed = self.keyPressed | key
end
function Context.prototype.inputKeyUp(self, key)
    self.keyDown = self.keyDown & ~key
end
function Context.prototype.inputKeyContinuous(self, key)
    self.keyPressed = self.keyPressed | key & ~self.keyDown
    self.keyDown = key
end
function Context.prototype.begin(self)
    self.commands = {}
    self.roots = {}
    self.scrollTarget = nil
    self.hoverRoot = self.nextHoverRoot
    self.nextHoverRoot = nil
    self.mouseDelta.x = self.mousePos.x - self.lastMousePos.x
    self.mouseDelta.y = self.mousePos.y - self.lastMousePos.y
end
function Context.prototype.getId(self, name)
    local initialId = #self.idStack == 0 and HASH_INITIAL or self.idStack[#self.idStack]
    local newId = hashString(nil, initialId, name)
    self.lastId = newId
    return newId
end
function Context.prototype.pushId(self, name)
    local ____self_idStack_4 = self.idStack
    ____self_idStack_4[#____self_idStack_4 + 1] = self:getId(name)
end
function Context.prototype.popId(self)
    table.remove(self.idStack)
end
function Context.prototype.bringToFront(self, cnt)
    local ____cnt_8 = cnt
    local ____self_5, ____lastZindex_6 = self, "lastZindex"
    local ____self_lastZindex_7 = ____self_5[____lastZindex_6] + 1
    ____self_5[____lastZindex_6] = ____self_lastZindex_7
    ____cnt_8.zindex = ____self_lastZindex_7
end
function Context.prototype.getContainer(self, id, opt)
    if opt == nil then
        opt = ____exports.Option.None
    end
    if self.containers[id] ~= nil then
        return self.containers[id]
    end
    if opt & ____exports.Option.Closed ~= 0 then
        return nil
    end
    local container = {
        headIdx = nil,
        tailIdx = nil,
        rect = {x = 0, y = 0, w = 0, h = 0},
        body = {x = 0, y = 0, w = 0, h = 0},
        contentSize = {x = 0, y = 0},
        scroll = {x = 0, y = 0},
        zindex = 0,
        open = true,
        root = false
    }
    self:bringToFront(container)
    self.containers[id] = container
    return container
end
function Context.prototype.getCurrentContainer(self)
    assert(#self.containerStack > 0, "attempted to get current container when there are no containers")
    return self.containerStack[#self.containerStack]
end
function Context.prototype.inHoverRoot(self)
    do
        local i = #self.containerStack - 1
        while i >= 0 do
            local cnt = self.containerStack[i + 1]
            if cnt == self.hoverRoot then
                return true
            end
            if cnt.root then
                break
            end
            i = i - 1
        end
    end
    return false
end
function Context.prototype.getClipRect(self)
    assert(#self.clipStack > 0)
    return self.clipStack[#self.clipStack]
end
function Context.prototype.mouseOver(self, rect)
    return rectOverlapsVec2(nil, rect, self.mousePos) and rectOverlapsVec2(
        nil,
        self:getClipRect(),
        self.mousePos
    ) and self:inHoverRoot()
end
function Context.prototype.setFocus(self, id)
    self.focus = id
    self.updatedFocus = true
end
function Context.prototype.updateControl(self, id, rect, opt)
    if self.focus == id then
        self.updatedFocus = true
    end
    if opt & ____exports.Option.NoInteract ~= 0 then
        return
    end
    local mouseover = self:mouseOver(rect)
    if mouseover and self.mouseDown == 0 then
        self.hover = id
    end
    if self.focus == id then
        if self.mousePressed ~= 0 and not mouseover then
            self:setFocus(nil)
        end
        if self.mouseDown == 0 and opt & ____exports.Option.HoldFocus == 0 then
            self:setFocus(nil)
        end
    end
    if self.hover == id then
        if self.mousePressed ~= 0 then
            self:setFocus(id)
        elseif not mouseover then
            self.hover = nil
        end
    end
end
function Context.prototype.pushJump(self, dstIdx, oob)
    if oob == nil then
        oob = false
    end
    if not oob then
        assert(dstIdx ~= nil and 0 <= dstIdx and dstIdx < #self.commands, "attempted to push jump command to out-of-bounds")
    end
    local cmd = {type = ____exports.CommandType.Jump, dstIdx = dstIdx}
    local ____self_commands_9 = self.commands
    ____self_commands_9[#____self_commands_9 + 1] = cmd
    return #self.commands - 1
end
function Context.prototype.beginRootContainer(self, cnt)
    local ____self_containerStack_10 = self.containerStack
    ____self_containerStack_10[#____self_containerStack_10 + 1] = cnt
    local ____self_roots_11 = self.roots
    ____self_roots_11[#____self_roots_11 + 1] = cnt
    cnt.headIdx = self:pushJump(nil, true)
    if rectOverlapsVec2(nil, cnt.rect, self.mousePos) and (not self.nextHoverRoot or cnt.zindex > self.nextHoverRoot.zindex) then
        self.nextHoverRoot = cnt
    end
    local ____self_clipStack_12 = self.clipStack
    ____self_clipStack_12[#____self_clipStack_12 + 1] = UNCLIPPED_RECT
end
function Context.prototype.drawRect(self, rect, color)
    rect = intersectRects(
        nil,
        rect,
        self:getClipRect()
    )
    if rect.w > 0 and rect.h > 0 then
        local cmd = {type = ____exports.CommandType.Rect, rect = rect, color = color}
        local ____self_commands_13 = self.commands
        ____self_commands_13[#____self_commands_13 + 1] = cmd
    end
end
function Context.prototype.drawBox(self, r, color)
    self:drawRect({x = r.x + 1, y = r.y, w = r.w - 2, h = 1}, color)
    self:drawRect({x = r.x + 1, y = r.y + r.h - 1, w = r.w - 2, h = 1}, color)
    self:drawRect({x = r.x, y = r.y, w = 1, h = r.h}, color)
    self:drawRect({x = r.x + r.w - 1, y = r.y, w = 1, h = r.h}, color)
end
function Context.prototype.drawFrame(self, rect, colorId)
    local color = self.style.colors[colorId]
    self:drawRect(rect, color)
    if colorId == ____exports.ColorId.ScrollBase or colorId == ____exports.ColorId.ScrollThumb or colorId == ____exports.ColorId.TitleBG then
        return
    end
    if self.style.colors[____exports.ColorId.Border].a > 0 then
        self:drawBox(
            expandRect(nil, rect, 1),
            self.style.colors[____exports.ColorId.Border]
        )
    end
end
function Context.prototype.pushClipRect(self, rect)
    local last = self:getClipRect()
    local ____self_clipStack_14 = self.clipStack
    ____self_clipStack_14[#____self_clipStack_14 + 1] = intersectRects(nil, rect, last)
end
function Context.prototype.popClipRect(self)
    table.remove(self.clipStack)
end
function Context.prototype.checkClip(self, r)
    local cr = self:getClipRect()
    if r.x > cr.x + cr.w or r.x + r.w < cr.x or r.y > cr.y + cr.h or r.y + r.h < cr.y then
        return ____exports.Clip.All
    end
    if r.x >= cr.x and r.x + r.w <= cr.x + cr.w and r.y >= cr.y and r.y + r.h <= cr.y + cr.h then
        return ____exports.Clip.None
    end
    return ____exports.Clip.Part
end
function Context.prototype.setClip(self, rect)
    local cmd = {type = ____exports.CommandType.Clip, rect = rect}
    local ____self_commands_15 = self.commands
    ____self_commands_15[#____self_commands_15 + 1] = cmd
end
function Context.prototype.drawText(self, font, str, len, pos, color)
    local ____pos_x_20 = pos.x
    local ____pos_y_21 = pos.y
    local ____self_textWidth_19 = self.textWidth
    local ____font_17 = font
    local ____str_18 = str
    local ____temp_16
    if len == nil then
        ____temp_16 = nil
    else
        ____temp_16 = len
    end
    local rect = {
        x = ____pos_x_20,
        y = ____pos_y_21,
        w = ____self_textWidth_19(self, ____font_17, ____str_18, ____temp_16),
        h = self:textHeight(font)
    }
    local clipped = self:checkClip(rect)
    if clipped == ____exports.Clip.All then
        return
    end
    if clipped == ____exports.Clip.Part then
        self:setClip(self:getClipRect())
    end
    if len == nil then
        len = #str
    end
    local cmd = {
        type = ____exports.CommandType.Text,
        color = color,
        font = font,
        pos = pos,
        str = str
    }
    local ____self_commands_22 = self.commands
    ____self_commands_22[#____self_commands_22 + 1] = cmd
    if clipped ~= ____exports.Clip.None then
        self:setClip(UNCLIPPED_RECT)
    end
end
function Context.prototype.drawControlFrame(self, id, rect, colorid, opt)
    if opt & ____exports.Option.NoFrame ~= 0 then
        return
    end
    colorid = colorid + (self.focus == id and 2 or (self.hover == id and 1 or 0))
    self:drawFrame(rect, colorid)
end
function Context.prototype.drawControlText(self, str, rect, colorid, opt)
    local pos = {x = 0, y = 0}
    local font = self.style.font
    local tw = self:textWidth(font, str)
    self:pushClipRect(rect)
    pos.y = rect.y + (rect.h - self:textHeight(font)) / 2
    if opt & ____exports.Option.AlignCenter ~= 0 then
        pos.x = rect.x + (rect.w - tw) / 2
    elseif opt & ____exports.Option.AlignRight ~= 0 then
        pos.x = rect.x + rect.w - tw - self.style.padding
    else
        pos.x = rect.x + self.style.padding
    end
    self:drawText(
        font,
        str,
        -1,
        pos,
        self.style.colors[colorid]
    )
    self:popClipRect()
end
function Context.prototype.drawIcon(self, id, rect, color)
    local clipped = self:checkClip(rect)
    if clipped == ____exports.Clip.All then
        return
    end
    if clipped == ____exports.Clip.Part then
        self:setClip(self:getClipRect())
    end
    local cmd = {type = ____exports.CommandType.Icon, color = color, rect = rect, id = id}
    local ____self_commands_23 = self.commands
    ____self_commands_23[#____self_commands_23 + 1] = cmd
    if clipped ~= ____exports.Clip.None then
        self:setClip(UNCLIPPED_RECT)
    end
end
function Context.prototype.scrollbar(self, cnt, viewBounds, contentSize, otherDir, scrollDir, otherLength, scrollLength)
    local maxscroll = contentSize[scrollDir] - viewBounds[scrollLength]
    if maxscroll > 0 and viewBounds[scrollLength] > 0 then
        local id = self:getId("!scrollbar" .. scrollDir)
        local base = deepcopy(viewBounds)
        base[otherDir] = viewBounds[otherDir] + viewBounds[otherLength]
        base[otherLength] = self.style.scrollbarSize
        self:updateControl(id, base, 0)
        if self.focus == id and self.mouseDown == ____exports.MouseButton.Left then
            local ____cnt_scroll_24, ____scrollDir_25 = cnt.scroll, scrollDir
            ____cnt_scroll_24[____scrollDir_25] = ____cnt_scroll_24[____scrollDir_25] + self.mouseDelta[scrollDir] * contentSize[scrollDir] / base[scrollLength]
        end
        cnt.scroll[scrollDir] = clamp(nil, cnt.scroll[scrollDir], 0, maxscroll)
        self:drawFrame(base, ____exports.ColorId.ScrollBase)
        local thumb = deepcopy(base)
        thumb[scrollLength] = math.max(self.style.thumbSize, base[scrollLength] * viewBounds[scrollLength] / contentSize[scrollDir])
        thumb[scrollDir] = thumb[scrollDir] + cnt.scroll[scrollDir] * (base[scrollLength] - thumb[scrollLength]) / maxscroll
        self:drawFrame(thumb, ____exports.ColorId.ScrollThumb)
        if self:mouseOver(viewBounds) then
            self.scrollTarget = cnt
        end
    else
        cnt.scroll[scrollDir] = 0
    end
end
function Context.prototype.scrollbars(self, cnt, body)
    local sz = self.style.scrollbarSize
    local cs = deepcopy(cnt.contentSize)
    cs.x = cs.x + self.style.padding * 2
    cs.y = cs.y + self.style.padding * 2
    self:pushClipRect(body)
    if cs.y > cnt.body.h then
        body.w = body.w - sz
    end
    if cs.x > cnt.body.w then
        body.h = body.h - sz
    end
    self:scrollbar(
        cnt,
        body,
        cs,
        "x",
        "y",
        "w",
        "h"
    )
    self:scrollbar(
        cnt,
        body,
        cs,
        "y",
        "x",
        "h",
        "w"
    )
    self:popClipRect()
end
function Context.prototype.getLayout(self)
    local count = #self.layoutStack
    assert(count > 0, "layout stack is empty")
    return self.layoutStack[count]
end
function Context.prototype.layoutRow(self, widths, height)
    local layout = self:getLayout()
    if widths ~= nil then
        assert(#widths > 0, "list of widths must contain at least 1 number")
        layout.widths = {table.unpack(widths)}
    else
    end
    layout.position = {x = layout.indent, y = layout.nextRow}
    layout.size.y = height
    layout.itemIndex = 0
end
function Context.prototype.pushLayout(self, body, scroll)
    local layout = {
        body = {x = body.x - scroll.x, y = body.y - scroll.y, w = body.w, h = body.h},
        next = {x = 0, y = 0, w = 0, h = 0},
        position = {x = 0, y = 0},
        size = {x = 0, y = 0},
        max = {x = -16777216, y = -16777216},
        widths = {},
        itemIndex = 0,
        nextRow = 0,
        nextType = Position.Unset,
        indent = 0
    }
    local ____self_layoutStack_26 = self.layoutStack
    ____self_layoutStack_26[#____self_layoutStack_26 + 1] = layout
    self:layoutRow({0}, 0)
end
function Context.prototype.layoutNext(self)
    local layout = self:getLayout()
    local res = {x = 0, y = 0, w = 0, h = 0}
    if layout.nextType ~= Position.Unset then
        local ____type = layout.nextType
        layout.nextType = Position.Unset
        res = layout.next
        if ____type == Position.Absolute then
            self.lastRect = __TS__ObjectAssign({}, res)
            return res
        end
    else
        if layout.itemIndex == #layout.widths then
            self:layoutRow(nil, layout.size.y)
        end
        res.x = layout.position.x
        res.y = layout.position.y
        res.w = #layout.widths > 0 and layout.widths[layout.itemIndex + 1] or layout.size.x
        res.h = layout.size.y
        if res.w == 0 then
            res.w = self.style.size.x + self.style.padding * 2
        end
        if res.h == 0 then
            res.h = self.style.size.y + self.style.padding * 2
        end
        if res.w < 0 then
            res.w = res.w + (layout.body.w - res.x + 1)
        end
        if res.h < 0 then
            res.h = res.h + (layout.body.h - res.y + 1)
        end
        layout.itemIndex = layout.itemIndex + 1
    end
    local ____layout_position_27, ____x_28 = layout.position, "x"
    ____layout_position_27[____x_28] = ____layout_position_27[____x_28] + (res.w + self.style.spacing)
    layout.nextRow = math.max(layout.nextRow, res.y + res.h + self.style.spacing)
    res.x = res.x + layout.body.x
    res.y = res.y + layout.body.y
    layout.max.x = math.max(layout.max.x, res.x + res.w)
    layout.max.y = math.max(layout.max.y, res.y + res.h)
    self.lastRect = __TS__ObjectAssign({}, res)
    return res
end
function Context.prototype.pushContainerBody(self, cnt, body, opt)
    if opt & ____exports.Option.NoScroll == 0 then
        self:scrollbars(cnt, body)
    end
    self:pushLayout(
        expandRect(nil, body, -self.style.padding),
        cnt.scroll
    )
    cnt.body = body
end
function Context.prototype.beginWindow(self, title, rect, opt)
    if opt == nil then
        opt = ____exports.Option.None
    end
    local id = self:getId(title)
    local cnt = self:getContainer(id, opt)
    if not cnt or not cnt.open then
        return false
    end
    local ____self_idStack_29 = self.idStack
    ____self_idStack_29[#____self_idStack_29 + 1] = id
    if cnt.rect.w == 0 then
        cnt.rect = rect
    else
        rect = cnt.rect
    end
    local body = deepcopy(rect)
    self:beginRootContainer(cnt)
    if opt & ____exports.Option.NoFrame == 0 then
        self:drawFrame(rect, ____exports.ColorId.WindowBG)
    end
    if opt & ____exports.Option.NoTitle == 0 then
        local tr = __TS__ObjectAssign({}, rect, {h = self.style.titleHeight})
        self:drawFrame(tr, ____exports.ColorId.TitleBG)
        local id = self:getId("!title")
        self:updateControl(id, tr, opt)
        self:drawControlText(title, tr, ____exports.ColorId.TitleText, opt)
        if self.focus == id and self.mouseDown == ____exports.MouseButton.Left then
            local ____cnt_rect_30, ____x_31 = cnt.rect, "x"
            ____cnt_rect_30[____x_31] = ____cnt_rect_30[____x_31] + self.mouseDelta.x
            local ____cnt_rect_32, ____y_33 = cnt.rect, "y"
            ____cnt_rect_32[____y_33] = ____cnt_rect_32[____y_33] + self.mouseDelta.y
        end
        body.y = body.y + tr.h
        body.h = body.h - tr.h
        if opt & ____exports.Option.NoClose == 0 then
            local id = self:getId("!close")
            local r = {x = tr.x + tr.w - tr.h, y = tr.y, w = tr.h, h = tr.h}
            tr.w = tr.w - r.w
            self:drawIcon(____exports.IconId.Close, r, self.style.colors[____exports.ColorId.TitleText])
            self:updateControl(id, r, opt)
            if self.focus == id and self.mouseDown == ____exports.MouseButton.Left then
                cnt.open = false
            end
        end
    end
    self:pushContainerBody(cnt, body, opt)
    if opt & ____exports.Option.NoResize == 0 then
        local sz = self.style.titleHeight
        local id = self:getId("!resize")
        local r = {x = rect.x + rect.w - sz, y = rect.y + rect.h - sz, w = sz, h = sz}
        self:updateControl(id, r, opt)
        if self.focus == id and self.mouseDown == ____exports.MouseButton.Left then
            cnt.rect.w = math.max(96, cnt.rect.w + self.mouseDelta.x)
            cnt.rect.h = math.max(64, cnt.rect.h + self.mouseDelta.y)
        end
    end
    if opt & ____exports.Option.AutoSize ~= 0 then
        local r = self:getLayout().body
        cnt.rect.w = cnt.contentSize.x + (cnt.rect.w - r.w)
        cnt.rect.h = cnt.contentSize.y + (cnt.rect.h - r.h)
    end
    if opt & ____exports.Option.Popup ~= 0 and self.mousePressed ~= 0 and self.hoverRoot ~= cnt then
        cnt.open = false
    end
    self:pushClipRect(cnt.body)
    return ____exports.Response.Active
end
function Context.prototype.popContainer(self)
    local cnt = self:getCurrentContainer()
    local layout = self:getLayout()
    cnt.contentSize.x = layout.max.x - layout.body.x
    cnt.contentSize.y = layout.max.y - layout.body.y
    table.remove(self.containerStack)
    table.remove(self.layoutStack)
    table.remove(self.idStack)
end
function Context.prototype.endRootContainer(self)
    local cnt = self:getCurrentContainer()
    cnt.tailIdx = self:pushJump(nil, true)
    if cnt.headIdx == nil then
        error("container headIdx is null when ending root container")
    end
    local head = self.commands[cnt.headIdx + 1]
    if head.type ~= ____exports.CommandType.Jump then
        error("container headIdx doesn't point to Jump command")
    end
    head.dstIdx = #self.commands
    self:popClipRect()
    self:popContainer()
end
function Context.prototype.endWindow(self)
    self:popClipRect()
    self:endRootContainer()
end
Context.prototype["end"] = function(self)
    assert(#self.containerStack == 0)
    assert(#self.clipStack == 0)
    assert(#self.idStack == 0)
    assert(#self.layoutStack == 0)
    if self.scrollTarget ~= nil then
        local ____self_scrollTarget_scroll_34, ____x_35 = self.scrollTarget.scroll, "x"
        ____self_scrollTarget_scroll_34[____x_35] = ____self_scrollTarget_scroll_34[____x_35] + self.scrollDelta.x
        local ____self_scrollTarget_scroll_36, ____y_37 = self.scrollTarget.scroll, "y"
        ____self_scrollTarget_scroll_36[____y_37] = ____self_scrollTarget_scroll_36[____y_37] + self.scrollDelta.y
    end
    if not self.updatedFocus then
        self.focus = nil
    end
    self.updatedFocus = false
    if self.mousePressed ~= 0 and self.nextHoverRoot ~= nil and self.nextHoverRoot.zindex < self.lastZindex and self.nextHoverRoot.zindex >= 0 then
        self:bringToFront(self.nextHoverRoot)
    end
    self.keyPressed = ____exports.Key.None
    self._inputText = ""
    self.mousePressed = ____exports.MouseButton.None
    self.scrollDelta = {x = 0, y = 0}
    self.lastMousePos.x = self.mousePos.x
    self.lastMousePos.y = self.mousePos.y
    __TS__ArraySort(
        self.roots,
        function(____, a, b) return a.zindex - b.zindex end
    )
    do
        local i = 0
        while i < #self.roots do
            local cnt = self.roots[i + 1]
            if i == 0 then
                local cmd = self.commands[1]
                if cmd.type ~= ____exports.CommandType.Jump then
                    error("first command in list should be jump")
                end
                if cnt.headIdx == nil then
                    error("headIdx of container is not set")
                end
                cmd.dstIdx = cnt.headIdx + 1
            else
                local prev = self.roots[i]
                if prev.tailIdx == nil then
                    error("tailIdx of container is not set")
                end
                local cmd = self.commands[prev.tailIdx + 1]
                if cmd.type ~= ____exports.CommandType.Jump then
                    error("first command in list should be jump")
                end
                if cnt.headIdx == nil then
                    error("headIdx of container is not set")
                end
                cmd.dstIdx = cnt.headIdx + 1
            end
            if i == #self.roots - 1 then
                if cnt.tailIdx == nil then
                    error("tailIdx of container is not set")
                end
                local cmd = self.commands[cnt.tailIdx + 1]
                if cmd.type ~= ____exports.CommandType.Jump then
                    error("first command in list should be jump")
                end
                cmd.dstIdx = #self.commands
            end
            i = i + 1
        end
    end
end
Context.prototype.iterCommands = __TS__Generator(function(self)
    local i = 0
    while true do
        do
            if i >= #self.commands then
                break
            end
            local cmd = self.commands[i + 1]
            if cmd.type == ____exports.CommandType.Jump then
                assert(cmd.dstIdx ~= nil, "attempt to perform Jump command with null destination")
                i = cmd.dstIdx
                goto __continue136
            end
            coroutine.yield(cmd)
            i = i + 1
        end
        ::__continue136::
    end
end)
function Context.prototype.header(self, label, opt)
    if opt == nil then
        opt = ____exports.Option.None
    end
    return self:_header(label, opt, false)
end
function Context.prototype._header(self, label, opt, istreenode)
    if opt == nil then
        opt = ____exports.Option.None
    end
    if istreenode == nil then
        istreenode = false
    end
    local id = self:getId(label)
    self:layoutRow({-1}, 0)
    local active = self.treeNodes[id] == true
    local ____temp_38
    if opt & ____exports.Option.Expanded ~= 0 then
        ____temp_38 = not active
    else
        ____temp_38 = active
    end
    local expanded = ____temp_38
    local r = self:layoutNext()
    self:updateControl(id, r, ____exports.Option.None)
    if self.mousePressed == ____exports.MouseButton.Left and self.focus == id then
        active = not active
    end
    if active then
        self.treeNodes[id] = true
    else
        __TS__Delete(self.treeNodes, id)
    end
    if istreenode then
        if self.hover == id then
            self:drawFrame(r, ____exports.ColorId.ButtonHover)
        end
    else
        self:drawControlFrame(id, r, ____exports.ColorId.Button, 0)
    end
    self:drawIcon(
        expanded and ____exports.IconId.Expanded or ____exports.IconId.Collapsed,
        Rect(
            nil,
            r.x,
            r.y,
            r.h,
            r.h
        ),
        self.style.colors[____exports.ColorId.Text]
    )
    r.x = r.x + (r.h - self.style.padding)
    r.w = r.w - (r.h - self.style.padding)
    self:drawControlText(label, r, ____exports.ColorId.Text, 0)
    return expanded and ____exports.Response.Active or false
end
function Context.prototype.label(self, text)
    self:drawControlText(
        text,
        self:layoutNext(),
        ____exports.ColorId.Text,
        0
    )
end
function Context.prototype.button(self, label, opt)
    if opt == nil then
        opt = ____exports.Option.None
    end
    local res = 0
    local id = type(label) == "string" and self:getId(label) or self:getId("icon" .. tostring(label))
    local r = self:layoutNext()
    self:updateControl(id, r, opt)
    if self.mousePressed == ____exports.MouseButton.Left and self.focus == id then
        res = res | ____exports.Response.Submit
    end
    self:drawControlFrame(id, r, ____exports.ColorId.Button, opt)
    if type(label) == "string" then
        self:drawControlText(label, r, ____exports.ColorId.Text, opt)
    else
        self:drawIcon(label, r, self.style.colors[____exports.ColorId.Text])
    end
    local ____temp_39
    if res == 0 then
        ____temp_39 = false
    else
        ____temp_39 = res
    end
    return ____temp_39
end
function Context.prototype.openPopup(self, name)
    local id = self:getId(name)
    local cnt = self:getContainer(id)
    if cnt == nil then
        error("openPopup: container is null")
    end
    self.nextHoverRoot = cnt
    self.hoverRoot = cnt
    cnt.rect = Rect(
        nil,
        self.mousePos.x,
        self.mousePos.y,
        1,
        1
    )
    cnt.open = true
    self:bringToFront(cnt)
end
function Context.prototype.beginPopup(self, name, rect, opt)
    if rect == nil then
        rect = {x = 0, y = 0, w = 0, h = 0}
    end
    if opt == nil then
        opt = ____exports.Option.Popup | ____exports.Option.AutoSize | ____exports.Option.NoResize | ____exports.Option.NoScroll | ____exports.Option.NoTitle | ____exports.Option.Closed
    end
    return self:beginWindow(name, rect, opt)
end
function Context.prototype.endPopup(self)
    self:endWindow()
end
function Context.prototype.layoutBeginColumn(self)
    self:pushLayout(
        self:layoutNext(),
        {x = 0, y = 0}
    )
end
function Context.prototype.layoutEndColumn(self)
    local b = self:getLayout()
    table.remove(self.layoutStack)
    local a = self:getLayout()
    a.position.x = math.max(a.position.x, b.position.x + b.body.x - a.body.x)
    a.nextRow = math.max(a.nextRow, b.nextRow + b.body.y - a.body.y)
    a.max.x = math.max(a.max.x, b.max.x)
    a.max.y = math.max(a.max.y, b.max.y)
end
function Context.prototype.textboxRaw(self, buf, maxBufSize, id, r, opt)
    local res = false
    self:updateControl(id, r, opt | ____exports.Option.HoldFocus)
    if self.focus == id then
        if maxBufSize == nil then
            local newCharCount = #self._inputText
            if newCharCount > 0 then
                buf = buf .. self._inputText
                res = ____exports.Response.Change
            end
        else
            local freeSpace = maxBufSize - #buf
            local newCharCount = #self._inputText
            if freeSpace > 0 and newCharCount > 0 then
                buf = buf .. __TS__StringSlice(self._inputText, 0, freeSpace)
                res = ____exports.Response.Change
            end
        end
        if self.keyPressed & ____exports.Key.Backspace ~= 0 and #buf > 0 then
            buf = __TS__StringSlice(buf, 0, #buf - 1)
            res = ____exports.Response.Change
        end
        if self.keyPressed & ____exports.Key.Return ~= 0 then
            self:setFocus(nil)
            res = ____exports.Response.Submit
        end
    end
    self:drawControlFrame(id, r, ____exports.ColorId.Base, opt)
    if self.focus == id then
        local color = self.style.colors[____exports.ColorId.Text]
        local font = self.style.font
        local textw = self:textWidth(font, buf)
        local texth = self:textHeight(font)
        local ofx = r.w - self.style.padding - textw - 1
        local textx = r.x + math.min(ofx, self.style.padding)
        local texty = r.y + (r.h - texth) / 2
        self:pushClipRect(r)
        self:drawText(
            font,
            buf,
            nil,
            {x = textx, y = texty},
            color
        )
        self:drawRect(
            Rect(
                nil,
                textx + textw,
                texty,
                1,
                texth
            ),
            color
        )
        self:popClipRect()
    else
        self:drawControlText(buf, r, ____exports.ColorId.Text, opt)
    end
    return {res, buf}
end
function Context.prototype.numberTextbox(self, value, r, id)
    if self.mousePressed == ____exports.MouseButton.Left and self.keyDown & ____exports.Key.Shift ~= 0 and self.hover == id then
        self.numberEdit = id
        self.numberEditBuf = string.format(MU_REAL_FMT, value)
    end
    if self.numberEdit == id then
        local res, newVal = table.unpack(self:textboxRaw(
            self.numberEditBuf,
            MU_MAX_FMT,
            id,
            r,
            0
        ))
        if res then
            self.numberEditBuf = newVal
        end
        if res and res & ____exports.Response.Submit ~= 0 or self.focus ~= id then
            value = __TS__ParseFloat(self.numberEditBuf)
            self.numberEdit = nil
            return {res, value}
        else
            return {____exports.Response.Active, value}
        end
    end
    return {false, value}
end
function Context.prototype.slider(self, identifier, value, low, high, step, fmt, opt)
    if fmt == nil then
        fmt = MU_SLIDER_FMT
    end
    if opt == nil then
        opt = ____exports.Option.AlignCenter
    end
    local res = false
    local last = value
    local id = self:getId(identifier)
    local base = self:layoutNext()
    local textboxRes, newVal = table.unpack(self:numberTextbox(value, base, id))
    if textboxRes then
        return newVal
    end
    self:updateControl(id, base, opt)
    if self.focus == id and self.mouseDown | self.mousePressed == ____exports.MouseButton.Left then
        value = low + (self.mousePos.x - base.x) * (high - low) / base.w
        if step ~= nil and step ~= 0 then
            value = (value + step / 2) / step * step
        end
    end
    value = clamp(nil, value, low, high)
    if last ~= value then
        res = ____exports.Response.Change
    end
    self:drawControlFrame(id, base, ____exports.ColorId.Base, opt)
    local w = self.style.thumbSize
    local x = (value - low) * (base.w - w) / (high - low)
    local thumb = Rect(
        nil,
        base.x + x,
        base.y,
        w,
        base.h
    )
    self:drawControlFrame(id, thumb, ____exports.ColorId.Button, opt)
    local buf = string.format(fmt, value)
    self:drawControlText(buf, base, ____exports.ColorId.Text, opt)
    return value
end
function Context.prototype.beginTreenode(self, label, opt)
    if opt == nil then
        opt = ____exports.Option.None
    end
    local res = self:_header(label, opt, true)
    if res and res & ____exports.Response.Active ~= 0 then
        local ____temp_40, ____indent_41 = self:getLayout(), "indent"
        ____temp_40[____indent_41] = ____temp_40[____indent_41] + self.style.indent
        assert(self.lastId ~= nil)
        local ____self_idStack_42 = self.idStack
        ____self_idStack_42[#____self_idStack_42 + 1] = self.lastId
    end
    return res
end
function Context.prototype.endTreenode(self)
    local ____temp_43, ____indent_44 = self:getLayout(), "indent"
    ____temp_43[____indent_44] = ____temp_43[____indent_44] - self.style.indent
    table.remove(self.idStack)
end
function Context.prototype.checkbox(self, label, state)
    local res = false
    local id = self:getId(label)
    local r = self:layoutNext()
    local box = Rect(
        nil,
        r.x,
        r.y,
        r.h,
        r.h
    )
    self:updateControl(id, r, 0)
    if self.mousePressed == ____exports.MouseButton.Left and self.focus == id then
        res = ____exports.Response.Change
        state = not state
    end
    self:drawControlFrame(id, box, ____exports.ColorId.Base, 0)
    if state then
        self:drawIcon(____exports.IconId.Check, box, self.style.colors[____exports.ColorId.Text])
    end
    local r2 = Rect(
        nil,
        r.x + box.w,
        r.y,
        r.w - box.w,
        r.h
    )
    self:drawControlText(label, r2, ____exports.ColorId.Text, 0)
    return state
end
function Context.prototype.text(self, text)
    local spaceWidth = self:textWidth(self.style.font, " ")
    local font = self.style.font
    local color = self.style.colors[____exports.ColorId.Text]
    self:layoutBeginColumn()
    self:layoutRow(
        {-1},
        self:textHeight(font)
    )
    local start = 0
    local ____end = 0
    local p = 0
    while true do
        local r = self:layoutNext()
        local currentLineWidth = 0
        ____end = p
        start = ____end
        while true do
            local wordStart = p
            local pChar
            while true do
                pChar = __TS__StringCharAt(text, p)
                if #pChar == 0 or pChar == " " or pChar == "\n" then
                    break
                end
                p = p + 1
            end
            currentLineWidth = currentLineWidth + self:textWidth(
                font,
                __TS__StringSlice(text, wordStart, p)
            )
            if currentLineWidth > r.w and ____end ~= start then
                break
            end
            if pChar == " " then
                currentLineWidth = currentLineWidth + spaceWidth
            end
            local ____p_45 = p
            p = ____p_45 + 1
            ____end = ____p_45
            local endChar = __TS__StringCharAt(text, ____end)
            if #endChar == 0 or endChar == "\n" then
                break
            end
        end
        self:drawText(
            font,
            __TS__StringSlice(text, start, ____end),
            nil,
            {x = r.x, y = r.y},
            color
        )
        p = ____end + 1
        if ____end >= #text then
            break
        end
    end
    self:layoutEndColumn()
end
function Context.prototype.textbox(self, identifier, buf, opt)
    if opt == nil then
        opt = ____exports.Option.None
    end
    local id = self:getId(identifier)
    local r = self:layoutNext()
    return self:textboxRaw(
        buf,
        nil,
        id,
        r,
        opt
    )
end
function Context.prototype.beginPanel(self, name, opt)
    if opt == nil then
        opt = ____exports.Option.None
    end
    local id = self:getId(name)
    local ____self_idStack_46 = self.idStack
    ____self_idStack_46[#____self_idStack_46 + 1] = id
    assert(self.lastId ~= nil, "attempted to begin panel with no parent container")
    local cnt = self:getContainer(self.lastId, opt)
    if cnt == nil then
        error("panel must never be closed!")
    end
    cnt.rect = self:layoutNext()
    if opt & ____exports.Option.NoFrame ~= 0 then
        self:drawFrame(cnt.rect, ____exports.ColorId.PanelBG)
    end
    local ____self_containerStack_47 = self.containerStack
    ____self_containerStack_47[#____self_containerStack_47 + 1] = cnt
    self:pushContainerBody(cnt, cnt.rect, opt)
    self:pushClipRect(cnt.body)
end
function Context.prototype.endPanel(self)
    self:popClipRect()
    self:popContainer()
end
return ____exports

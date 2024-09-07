local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__Generator = ____lualib.__TS__Generator
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local ____exports = {}
local ____inspect = require("lua_modules.reaper-api.inspect")
local inspect = ____inspect.inspect
____exports.Item = __TS__Class()
local Item = ____exports.Item
Item.name = "Item"
function Item.prototype.____constructor(self, obj)
    self.obj = obj
end
function Item.getSelected(self)
    local count = reaper.CountSelectedMediaItems(0)
    local result = {}
    do
        local i = 0
        while i < count do
            local obj = reaper.GetSelectedMediaItem(0, i)
            result[#result + 1] = __TS__New(____exports.Item, obj)
            i = i + 1
        end
    end
    return result
end
Item.prototype.iterTakes = __TS__Generator(function(self)
    local count = reaper.GetMediaItemNumTakes(self.obj)
    do
        local i = 0
        while i < count do
            local take = reaper.GetMediaItemTake(self.obj, i)
            coroutine.yield(__TS__New(____exports.Take, take))
            i = i + 1
        end
    end
end)
function Item.prototype.isEmpty(self)
    local count = reaper.GetMediaItemNumTakes(self.obj)
    return count == 0
end
function Item.prototype.getColor(self)
    local color = reaper.GetMediaItemInfo_Value(self.obj, "I_CUSTOMCOLOR")
    if color == 0 then
        return nil
    end
    local r, g, b = reaper.ColorFromNative(color)
    return {r = r, g = g, b = b}
end
function Item.prototype.setColor(self, color)
    local newColor = color ~= nil and reaper.ColorToNative(color.r, color.g, color.b) | 16777216 or 0
    local rv = reaper.SetMediaItemInfo_Value(self.obj, "I_CUSTOMCOLOR", newColor)
    if not rv then
        error(
            __TS__New(
                Error,
                "failed to set item color to " .. inspect(color)
            ),
            0
        )
    end
end
function Item.prototype.getPosition(self)
    return reaper.GetMediaItemInfo_Value(self.obj, "D_POSITION")
end
function Item.prototype.getSnapOffset(self)
    return reaper.GetMediaItemInfo_Value(self.obj, "D_SNAPOFFSET")
end
function Item.prototype.getLength(self)
    return reaper.GetMediaItemInfo_Value(self.obj, "D_LENGTH")
end
____exports.Take = __TS__Class()
local Take = ____exports.Take
Take.name = "Take"
function Take.prototype.____constructor(self, obj)
    self.obj = obj
end
function Take.prototype.type(self)
    local source = reaper.GetMediaItemTake_Source(self.obj)
    return reaper.GetMediaSourceType(source)
end
function Take.prototype.isMidi(self)
    local ____type = self:type()
    return ____type == "MIDI" or ____type == "MIDIPOOL"
end
function Take.prototype.source(self)
    return __TS__New(
        ____exports.Source,
        reaper.GetMediaItemTake_Source(self.obj)
    )
end
____exports.MidiTake = __TS__Class()
local MidiTake = ____exports.MidiTake
MidiTake.name = "MidiTake"
function MidiTake.prototype.____constructor(self, obj)
    self.obj = obj
end
function MidiTake.active(self)
    local hwnd = reaper.MIDIEditor_GetActive()
    if hwnd == nil then
        return nil
    end
    local take = reaper.MIDIEditor_GetTake(hwnd)
    return __TS__New(____exports.MidiTake, take)
end
function MidiTake.prototype.grid(self)
    local beats, swing, noteBeats = reaper.MIDI_GetGrid(self.obj)
    local ____beats_1 = beats
    local ____swing_2 = swing
    local ____temp_0
    if noteBeats == 0 then
        ____temp_0 = nil
    else
        ____temp_0 = noteBeats
    end
    return {beats = ____beats_1, swing = ____swing_2, noteLengthOverride = ____temp_0}
end
____exports.Source = __TS__Class()
local Source = ____exports.Source
Source.name = "Source"
function Source.prototype.____constructor(self, obj)
    self.obj = obj
end
function Source.prototype.type(self)
    return reaper.GetMediaSourceType(self.obj)
end
return ____exports

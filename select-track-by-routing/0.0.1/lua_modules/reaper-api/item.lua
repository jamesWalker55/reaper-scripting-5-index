local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__Generator = ____lualib.__TS__Generator
local ____exports = {}
____exports.Item = __TS__Class()
local Item = ____exports.Item
Item.name = "Item"
function Item.prototype.____constructor(self, obj)
    self.obj = obj
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
    return self:type() == "MIDI"
end
function Take.prototype.source(self)
    return __TS__New(
        ____exports.Source,
        reaper.GetMediaItemTake_Source(self.obj)
    )
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

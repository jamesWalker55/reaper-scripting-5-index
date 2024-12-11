local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__Generator = ____lualib.__TS__Generator
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__SetDescriptor = ____lualib.__TS__SetDescriptor
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local ____exports = {}
local TrackRouting
local ____fx = require("lua_modules.reaper-api.fx")
local FX = ____fx.FX
local generateTakeContainerFxidx = ____fx.generateTakeContainerFxidx
local generateTrackContainerFxidx = ____fx.generateTrackContainerFxidx
local parseTakeContainerFxidx = ____fx.parseTakeContainerFxidx
local parseTrackContainerFxidx = ____fx.parseTrackContainerFxidx
local stringifyAddFxParams = ____fx.stringifyAddFxParams
local ____inspect = require("lua_modules.reaper-api.inspect")
local inspect = ____inspect.inspect
____exports.Track = __TS__Class()
local Track = ____exports.Track
Track.name = "Track"
function Track.prototype.____constructor(self, track)
    self.obj = track
end
function Track.getLastTouched(self)
    local obj = reaper.GetLastTouchedTrack()
    if obj == nil then
        return nil
    end
    return __TS__New(____exports.Track, obj)
end
function Track.getMaster(self)
    return __TS__New(
        ____exports.Track,
        reaper.GetMasterTrack(0)
    )
end
function Track.count(self)
    return reaper.CountTracks(0)
end
function Track.getByIdx(self, idx)
    local obj = reaper.GetTrack(0, idx)
    if obj == nil then
        error(
            __TS__New(
                Error,
                "failed to get track with index " .. tostring(idx)
            ),
            0
        )
    end
    return __TS__New(____exports.Track, obj)
end
function Track.getSelected(self)
    local tracks = {}
    local i = 0
    while true do
        local t = reaper.GetSelectedTrack2(0, i, true)
        if t == nil then
            return tracks
        end
        tracks[#tracks + 1] = __TS__New(____exports.Track, t)
        i = i + 1
    end
end
Track.iterAll = __TS__Generator(function(self)
    local count = ____exports.Track:count()
    do
        local i = 0
        while i < count do
            coroutine.yield(____exports.Track:getByIdx(i))
            i = i + 1
        end
    end
end)
function Track.getAll(self)
    local count = ____exports.Track:count()
    local result = {}
    do
        local i = 0
        while i < count do
            result[#result + 1] = ____exports.Track:getByIdx(i)
            i = i + 1
        end
    end
    return result
end
function Track.createAtLastPosition(self)
    reaper.InsertTrackInProject(0, -1, 0)
    local totalTracks = reaper.CountTracks(0)
    return ____exports.Track:getByIdx(totalTracks - 1)
end
function Track.createAtIdx(self, idx)
    local totalTracks = reaper.CountTracks(0)
    if not (0 <= idx and idx < totalTracks) then
        error(
            __TS__New(
                Error,
                (("Track index out of bounds (" .. tostring(totalTracks)) .. "): ") .. tostring(idx)
            ),
            0
        )
    end
    reaper.InsertTrackInProject(0, idx, 0)
    return ____exports.Track:getByIdx(idx)
end
function Track.prototype.isMaster(self)
    return self:getIdx() == -1
end
function Track.prototype.getParent(self)
    local obj = reaper.GetParentTrack(self.obj)
    if obj == nil then
        if self:isMaster() then
            return nil
        end
        return ____exports.Track:getMaster()
    end
    return __TS__New(____exports.Track, obj)
end
function Track.prototype.getChildren(self)
    local idx = self:getIdx()
    local isMaster = idx == -1
    if not isMaster then
        local rootNextTrackDepth = self:getRawFolderDepth()
        if rootNextTrackDepth <= 0 then
            return {}
        end
    end
    local children = {}
    local currentDepth = 0
    while currentDepth >= 0 do
        idx = idx + 1
        local child
        do
            local function ____catch(e)
                child = nil
            end
            local ____try, ____hasReturned = pcall(function()
                child = ____exports.Track:getByIdx(idx)
            end)
            if not ____try then
                ____catch(____hasReturned)
            end
        end
        if child == nil then
            break
        end
        if currentDepth == 0 then
            children[#children + 1] = child
        end
        currentDepth = currentDepth + child:getRawFolderDepth()
    end
    return children
end
function Track.prototype.addFx(self, fx, position)
    local fxname = stringifyAddFxParams(nil, fx)
    local positionNum = nil
    local positionArr = nil
    if position ~= nil then
        if type(position) == "number" then
            positionArr = parseTrackContainerFxidx(nil, self.obj, position)
            positionNum = position
        else
            positionArr = {table.unpack(position)}
            positionNum = generateTrackContainerFxidx(nil, self.obj, position)
        end
    end
    local rv = reaper.TrackFX_AddByName(self.obj, fxname, false, positionNum == nil and -1 or -1000 - positionNum)
    if rv == -1 then
        return nil
    end
    local newSubposition = rv
    if positionArr == nil then
        return newSubposition
    else
        positionArr[#positionArr] = newSubposition
        return generateTrackContainerFxidx(nil, self.obj, positionArr)
    end
end
function Track.prototype.getFxCount(self)
    return reaper.TrackFX_GetCount(self.obj)
end
function Track.prototype.getAllFx(self)
    local count = self:getFxCount()
    local result = {}
    do
        local i = 0
        while i < count do
            result[#result + 1] = __TS__New(FX, {track = self.obj}, i)
            i = i + 1
        end
    end
    return result
end
function Track.prototype.getFx(self, idx)
    return __TS__New(FX, {track = self.obj}, idx)
end
function Track.prototype.getRawFolderDepth(self)
    return reaper.GetMediaTrackInfo_Value(self.obj, "I_FOLDERDEPTH")
end
function Track.prototype.getSends(self, includeParent)
    if includeParent == nil then
        includeParent = false
    end
    local category = ____exports.TrackRoutingCategory.Send
    local count = reaper.GetTrackNumSends(self.obj, category)
    local result = {}
    if includeParent then
        local info = TrackRouting:getParentInfo(self.obj)
        if info.audio ~= nil or info.midi ~= nil then
            local parentTrack = reaper.GetMediaTrackInfo_Value(self.obj, "P_PARTRACK")
            if parentTrack == 0 then
                parentTrack = reaper.GetMasterTrack(0)
            end
            result[#result + 1] = __TS__ObjectAssign(
                {},
                info,
                {
                    src = __TS__New(____exports.Track, self.obj),
                    dst = __TS__New(____exports.Track, parentTrack)
                }
            )
        end
    end
    do
        local i = 0
        while i < count do
            local info = TrackRouting:getInfo(self.obj, category, i)
            local ____temp_0 = TrackRouting:getTargetTracks(self.obj, category, i)
            local src = ____temp_0.src
            local dst = ____temp_0.dst
            result[#result + 1] = __TS__ObjectAssign({src = src, dst = dst}, info)
            i = i + 1
        end
    end
    return result
end
function Track.prototype.getReceives(self)
    local category = ____exports.TrackRoutingCategory.Receive
    local count = reaper.GetTrackNumSends(self.obj, category)
    local result = {}
    do
        local i = 0
        while i < count do
            local info = TrackRouting:getInfo(self.obj, category, i)
            local ____temp_1 = TrackRouting:getTargetTracks(self.obj, category, i)
            local src = ____temp_1.src
            local dst = ____temp_1.dst
            result[#result + 1] = __TS__ObjectAssign({src = src, dst = dst}, info)
            i = i + 1
        end
    end
    return result
end
function Track.prototype.getHWOutputs(self)
    local category = ____exports.TrackRoutingCategory.HWOutput
    local count = reaper.GetTrackNumSends(self.obj, category)
    local result = {}
    do
        local i = 0
        while i < count do
            local info = TrackRouting:getInfo(self.obj, category, i)
            result[#result + 1] = info
            i = i + 1
        end
    end
    return result
end
function Track.prototype.delete(self)
    reaper.DeleteTrack(self.obj)
end
function Track.prototype.getIdx(self)
    local tracknumber = reaper.GetMediaTrackInfo_Value(self.obj, "IP_TRACKNUMBER")
    if tracknumber == 0 then
        error(
            __TS__New(Error, "failed to get track number"),
            0
        )
    end
    if tracknumber == -1 then
        return -1
    end
    return math.floor(tracknumber - 1 + 0.5)
end
Track.prototype.iterItems = __TS__Generator(function(self)
    local count = reaper.CountTrackMediaItems(self.obj)
    do
        local i = 0
        while i < count do
            local item = reaper.GetTrackMediaItem(self.obj, i)
            coroutine.yield(__TS__New(____exports.Item, item))
            i = i + 1
        end
    end
end)
function Track.prototype.allItems(self)
    local result = {}
    for ____, item in __TS__Iterator(self:iterItems()) do
        result[#result + 1] = item
    end
    return result
end
__TS__SetDescriptor(
    Track.prototype,
    "volume",
    {
        get = function(self)
            return reaper.GetMediaTrackInfo_Value(self.obj, "D_VOL")
        end,
        set = function(self, val)
            local ok = reaper.SetMediaTrackInfo_Value(self.obj, "D_VOL", val)
            if not ok then
                error(
                    __TS__New(Error, "failed to set volume"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Track.prototype,
    "pan",
    {
        get = function(self)
            return reaper.GetMediaTrackInfo_Value(self.obj, "D_PAN")
        end,
        set = function(self, val)
            local ok = reaper.SetMediaTrackInfo_Value(self.obj, "D_PAN", val)
            if not ok then
                error(
                    __TS__New(Error, "failed to set pan"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Track.prototype,
    "width",
    {
        get = function(self)
            return reaper.GetMediaTrackInfo_Value(self.obj, "D_WIDTH")
        end,
        set = function(self, val)
            local ok = reaper.SetMediaTrackInfo_Value(self.obj, "D_WIDTH", val)
            if not ok then
                error(
                    __TS__New(Error, "failed to set width"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Track.prototype,
    "panLaw",
    {
        get = function(self)
            return reaper.GetMediaTrackInfo_Value(self.obj, "D_PANLAW")
        end,
        set = function(self, val)
            local ok = reaper.SetMediaTrackInfo_Value(self.obj, "D_PANLAW", val)
            if not ok then
                error(
                    __TS__New(Error, "failed to set pan law"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Track.prototype,
    "muted",
    {
        get = function(self)
            return reaper.GetMediaTrackInfo_Value(self.obj, "B_MUTE") == 1
        end,
        set = function(self, val)
            local ok = reaper.SetMediaTrackInfo_Value(self.obj, "B_MUTE", val and 1 or 0)
            if not ok then
                error(
                    __TS__New(Error, "failed to set muted"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Track.prototype,
    "phaseInverted",
    {
        get = function(self)
            return reaper.GetMediaTrackInfo_Value(self.obj, "B_PHASE") == 1
        end,
        set = function(self, val)
            local ok = reaper.SetMediaTrackInfo_Value(self.obj, "B_PHASE", val and 1 or 0)
            if not ok then
                error(
                    __TS__New(Error, "failed to set phase inverted"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Track.prototype,
    "panmode",
    {
        get = function(self)
            return reaper.GetMediaTrackInfo_Value(self.obj, "I_PANMODE")
        end,
        set = function(self, val)
            local ok = reaper.SetMediaTrackInfo_Value(self.obj, "I_PANMODE", val)
            if not ok then
                error(
                    __TS__New(Error, "failed to set panmode"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Track.prototype,
    "color",
    {
        get = function(self)
            local x = reaper.GetMediaTrackInfo_Value(self.obj, "I_CUSTOMCOLOR")
            if x == 0 then
                return nil
            end
            local r, g, b = reaper.ColorFromNative(x)
            return {r = r, g = g, b = b}
        end,
        set = function(self, x)
            local rv
            if x == nil then
                rv = reaper.SetMediaTrackInfo_Value(self.obj, "I_CUSTOMCOLOR", 0)
            else
                local color = reaper.ColorToNative(x.r, x.g, x.b)
                rv = reaper.SetMediaTrackInfo_Value(self.obj, "I_CUSTOMCOLOR", 16777216 | color)
            end
            if not rv then
                error(
                    __TS__New(
                        Error,
                        "failed to set item color to " .. inspect(x)
                    ),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Track.prototype,
    "name",
    {
        get = function(self)
            local ok, val = reaper.GetSetMediaTrackInfo_String(self.obj, "P_NAME", "", false)
            if not ok then
                if self:getIdx() == -1 then
                    return ""
                end
                error(
                    __TS__New(Error, "failed to get track name"),
                    0
                )
            end
            return val
        end,
        set = function(self, name)
            local ok, val = reaper.GetSetMediaTrackInfo_String(self.obj, "P_NAME", name, true)
            if not ok then
                if self:getIdx() == -1 then
                    return
                end
                error(
                    __TS__New(Error, "failed to set track name"),
                    0
                )
            end
        end
    },
    true
)
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
function Item.prototype.activeTake(self)
    local take = reaper.GetActiveTake(self.obj)
    if not take then
        return nil
    end
    return __TS__New(____exports.Take, take)
end
function Item.prototype.isEmpty(self)
    local count = reaper.GetMediaItemNumTakes(self.obj)
    return count == 0
end
function Item.prototype.split(self, pos)
    local rightItem = reaper.SplitMediaItem(self.obj, pos)
    if rightItem == nil then
        error(
            __TS__New(
                Error,
                ("failed to split item at position " .. tostring(pos)) .. "s"
            ),
            0
        )
    end
    return __TS__New(____exports.Item, rightItem)
end
function Item.prototype.delete(self)
    local track = self:getTrack()
    local rv = reaper.DeleteTrackMediaItem(track.obj, self.obj)
    if not rv then
        error(
            __TS__New(Error, "failed to delete item"),
            0
        )
    end
end
function Item.prototype.getTrack(self)
    local obj = reaper.GetMediaItemTrack(self.obj)
    return __TS__New(____exports.Track, obj)
end
__TS__SetDescriptor(
    Item.prototype,
    "color",
    {
        get = function(self)
            local x = reaper.GetMediaItemInfo_Value(self.obj, "I_CUSTOMCOLOR")
            if x == 0 then
                return nil
            end
            local r, g, b = reaper.ColorFromNative(x)
            return {r = r, g = g, b = b}
        end,
        set = function(self, x)
            local rv
            if x == nil then
                rv = reaper.SetMediaItemInfo_Value(self.obj, "I_CUSTOMCOLOR", 0)
            else
                local color = reaper.ColorToNative(x.r, x.g, x.b)
                rv = reaper.SetMediaItemInfo_Value(self.obj, "I_CUSTOMCOLOR", 16777216 | color)
            end
            if not rv then
                error(
                    __TS__New(
                        Error,
                        "failed to set item color to " .. inspect(x)
                    ),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Item.prototype,
    "position",
    {
        get = function(self)
            return reaper.GetMediaItemInfo_Value(self.obj, "D_POSITION")
        end,
        set = function(self, x)
            local rv = reaper.SetMediaItemInfo_Value(self.obj, "D_POSITION", x)
            if not rv then
                error(
                    __TS__New(Error, "failed to set item position"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Item.prototype,
    "snapOffset",
    {
        get = function(self)
            return reaper.GetMediaItemInfo_Value(self.obj, "D_SNAPOFFSET")
        end,
        set = function(self, x)
            local rv = reaper.SetMediaItemInfo_Value(self.obj, "D_SNAPOFFSET", x)
            if not rv then
                error(
                    __TS__New(Error, "failed to set item snap offset"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Item.prototype,
    "length",
    {
        get = function(self)
            return reaper.GetMediaItemInfo_Value(self.obj, "D_LENGTH")
        end,
        set = function(self, x)
            local rv = reaper.SetMediaItemInfo_Value(self.obj, "D_LENGTH", x)
            if not rv then
                error(
                    __TS__New(Error, "failed to set item length"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Item.prototype,
    "volume",
    {
        get = function(self)
            return reaper.GetMediaItemInfo_Value(self.obj, "D_VOL")
        end,
        set = function(self, x)
            local rv = reaper.SetMediaItemInfo_Value(self.obj, "D_VOL", x)
            if not rv then
                error(
                    __TS__New(Error, "failed to set item volume"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Item.prototype,
    "fadeInLength",
    {
        get = function(self)
            return reaper.GetMediaItemInfo_Value(self.obj, "D_FADEINLEN")
        end,
        set = function(self, x)
            local rv = reaper.SetMediaItemInfo_Value(self.obj, "D_FADEINLEN", x)
            if not rv then
                error(
                    __TS__New(Error, "failed to set item fade-in length"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Item.prototype,
    "fadeOutLength",
    {
        get = function(self)
            return reaper.GetMediaItemInfo_Value(self.obj, "D_FADEOUTLEN")
        end,
        set = function(self, x)
            local rv = reaper.SetMediaItemInfo_Value(self.obj, "D_FADEOUTLEN", x)
            if not rv then
                error(
                    __TS__New(Error, "failed to set item fade-out length"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Item.prototype,
    "muted",
    {
        get = function(self)
            return reaper.GetMediaItemInfo_Value(self.obj, "B_MUTE_ACTUAL") ~= 0
        end,
        set = function(self, x)
            local rv = reaper.SetMediaItemInfo_Value(self.obj, "B_MUTE_ACTUAL", x and 1 or 0)
            if not rv then
                error(
                    __TS__New(Error, "failed to set item muted"),
                    0
                )
            end
        end
    },
    true
)
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
function Take.prototype.asTypedTake(self)
    if self:isMidi() then
        return __TS__New(____exports.MidiTake, self.obj)
    else
        return __TS__New(____exports.AudioTake, self.obj)
    end
end
function Take.prototype.getSource(self)
    return __TS__New(
        ____exports.Source,
        reaper.GetMediaItemTake_Source(self.obj)
    )
end
function Take.prototype.getFxCount(self)
    return reaper.TakeFX_GetCount(self.obj)
end
function Take.prototype.addFx(self, fx, position)
    local fxname = stringifyAddFxParams(nil, fx)
    local positionNum = nil
    local positionArr = nil
    if position ~= nil then
        if type(position) == "number" then
            positionArr = parseTakeContainerFxidx(nil, self.obj, position)
            positionNum = position
        else
            positionArr = {table.unpack(position)}
            positionNum = generateTakeContainerFxidx(nil, self.obj, position)
        end
    end
    local rv = reaper.TakeFX_AddByName(self.obj, fxname, positionNum == nil and -1 or -1000 - positionNum)
    if rv == -1 then
        return nil
    end
    local newSubposition = rv
    if positionArr == nil then
        return newSubposition
    else
        positionArr[#positionArr] = newSubposition
        return generateTakeContainerFxidx(nil, self.obj, positionArr)
    end
end
function Take.prototype.getItem(self)
    local obj = reaper.GetMediaItemTake_Item(self.obj)
    return __TS__New(____exports.Item, obj)
end
function Take.prototype.getTrack(self)
    local obj = reaper.GetMediaItemTake_Track(self.obj)
    return __TS__New(____exports.Track, obj)
end
function Take.prototype.getStretchMarkerCount(self)
    return reaper.GetTakeNumStretchMarkers(self.obj)
end
__TS__SetDescriptor(
    Take.prototype,
    "name",
    {
        get = function(self)
            local ok, rv = reaper.GetSetMediaItemTakeInfo_String(self.obj, "P_NAME", "", false)
            if not ok then
                error(
                    __TS__New(Error, "failed to get take name"),
                    0
                )
            end
            return rv
        end,
        set = function(self, x)
            local ok, rv = reaper.GetSetMediaItemTakeInfo_String(self.obj, "P_NAME", x, true)
            if not ok then
                error(
                    __TS__New(Error, "failed to set take name"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Take.prototype,
    "sourceStartOffset",
    {
        get = function(self)
            local x = reaper.GetMediaItemTakeInfo_Value(self.obj, "D_STARTOFFS")
            return x
        end,
        set = function(self, x)
            local ok = reaper.SetMediaItemTakeInfo_Value(self.obj, "D_STARTOFFS", x)
            if not ok then
                error(
                    __TS__New(Error, "failed to set take source start offset"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Take.prototype,
    "volume",
    {
        get = function(self)
            local x = reaper.GetMediaItemTakeInfo_Value(self.obj, "D_VOL")
            return x
        end,
        set = function(self, x)
            local ok = reaper.SetMediaItemTakeInfo_Value(self.obj, "D_VOL", x)
            if not ok then
                error(
                    __TS__New(Error, "failed to set take volume"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Take.prototype,
    "pan",
    {
        get = function(self)
            local x = reaper.GetMediaItemTakeInfo_Value(self.obj, "D_PAN")
            return x
        end,
        set = function(self, x)
            local ok = reaper.SetMediaItemTakeInfo_Value(self.obj, "D_PAN", x)
            if not ok then
                error(
                    __TS__New(Error, "failed to set take pan"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Take.prototype,
    "playrate",
    {
        get = function(self)
            local x = reaper.GetMediaItemTakeInfo_Value(self.obj, "D_PLAYRATE")
            return x
        end,
        set = function(self, x)
            local ok = reaper.SetMediaItemTakeInfo_Value(self.obj, "D_PLAYRATE", x)
            if not ok then
                error(
                    __TS__New(Error, "failed to set take playrate"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Take.prototype,
    "pitch",
    {
        get = function(self)
            local x = reaper.GetMediaItemTakeInfo_Value(self.obj, "D_PITCH")
            return x
        end,
        set = function(self, x)
            local ok = reaper.SetMediaItemTakeInfo_Value(self.obj, "D_PITCH", x)
            if not ok then
                error(
                    __TS__New(Error, "failed to set take pitch"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Take.prototype,
    "preservePitch",
    {
        get = function(self)
            local x = reaper.GetMediaItemTakeInfo_Value(self.obj, "D_PITCH") ~= 0
            return x
        end,
        set = function(self, x)
            local ok = reaper.SetMediaItemTakeInfo_Value(self.obj, "D_PITCH", x and 1 or 0)
            if not ok then
                error(
                    __TS__New(Error, "failed to set take preserve pitch"),
                    0
                )
            end
        end
    },
    true
)
____exports.MidiTake = __TS__Class()
local MidiTake = ____exports.MidiTake
MidiTake.name = "MidiTake"
__TS__ClassExtends(MidiTake, ____exports.Take)
function MidiTake.prototype.____constructor(self, ...)
    MidiTake.____super.prototype.____constructor(self, ...)
    self.TYPE = "MIDI"
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
    local ____beats_3 = beats
    local ____swing_4 = swing
    local ____temp_2
    if noteBeats == 0 then
        ____temp_2 = nil
    else
        ____temp_2 = noteBeats
    end
    return {beats = ____beats_3, swing = ____swing_4, noteLengthOverride = ____temp_2}
end
MidiTake.prototype.iterNotes = __TS__Generator(function(self)
    local i = 0
    while true do
        local rv, selected, muted, startTick, endTick, chan, pitch, vel = reaper.MIDI_GetNote(self.obj, i)
        if not rv then
            break
        end
        coroutine.yield({
            selected = selected,
            muted = muted,
            startTick = startTick,
            endTick = endTick,
            chan = chan,
            pitch = pitch,
            vel = vel
        })
        i = i + 1
    end
end)
function MidiTake.prototype.allNotes(self)
    local result = {}
    for ____, note in __TS__Iterator(self:iterNotes()) do
        result[#result + 1] = note
    end
    return result
end
function MidiTake.prototype.tickToProjectTime(self, tick)
    return reaper.MIDI_GetProjTimeFromPPQPos(self.obj, tick)
end
--- TODO
____exports.AudioTake = __TS__Class()
local AudioTake = ____exports.AudioTake
AudioTake.name = "AudioTake"
__TS__ClassExtends(AudioTake, ____exports.Take)
function AudioTake.prototype.____constructor(self, ...)
    AudioTake.____super.prototype.____constructor(self, ...)
    self.TYPE = "AUDIO"
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
function Source.prototype.getFilename(self)
    local name = reaper.GetMediaSourceFileName(self.obj)
    if #name == 0 then
        error(
            __TS__New(Error, "failed to get PCM_source filename"),
            0
        )
    end
    return name
end
function Source.prototype.getLength(self)
    local length, isQuarterNotes = reaper.GetMediaSourceLength(self.obj)
    if isQuarterNotes then
        error(
            __TS__New(Error, "source is beat-based, does not have length in seconds"),
            0
        )
    end
    return length
end
function Source.prototype.getBeatLength(self)
    local length, isQuarterNotes = reaper.GetMediaSourceLength(self.obj)
    if not isQuarterNotes then
        error(
            __TS__New(Error, "source is seconds-based, does not have length in beats"),
            0
        )
    end
    return length
end
function Source.prototype.getParent(self)
    local parent = reaper.GetMediaSourceParent(self.obj)
    if parent == nil then
        return nil
    end
    return __TS__New(____exports.Source, parent)
end
function Source.prototype.getSectionInfo(self)
    local isSection, offset, length, reversed = reaper.PCM_Source_GetSectionInfo(self.obj)
    return {isSection = isSection, offset = offset, length = length, reversed = reversed}
end
--- ================================================================
-- 
-- Track routing functions
-- 
-- ================================================================
____exports.TrackRoutingCategory = TrackRoutingCategory or ({})
____exports.TrackRoutingCategory.Receive = -1
____exports.TrackRoutingCategory[____exports.TrackRoutingCategory.Receive] = "Receive"
____exports.TrackRoutingCategory.Send = 0
____exports.TrackRoutingCategory[____exports.TrackRoutingCategory.Send] = "Send"
____exports.TrackRoutingCategory.HWOutput = 1
____exports.TrackRoutingCategory[____exports.TrackRoutingCategory.HWOutput] = "HWOutput"
____exports.TrackSendMode = TrackSendMode or ({})
____exports.TrackSendMode.PostFader = 0
____exports.TrackSendMode[____exports.TrackSendMode.PostFader] = "PostFader"
____exports.TrackSendMode.PreFx = 1
____exports.TrackSendMode[____exports.TrackSendMode.PreFx] = "PreFx"
____exports.TrackSendMode.PostFxDeprecated = 2
____exports.TrackSendMode[____exports.TrackSendMode.PostFxDeprecated] = "PostFxDeprecated"
____exports.TrackSendMode.PostFx = 3
____exports.TrackSendMode[____exports.TrackSendMode.PostFx] = "PostFx"
____exports.TrackSendAutomationMode = TrackSendAutomationMode or ({})
____exports.TrackSendAutomationMode.TrackDefault = -1
____exports.TrackSendAutomationMode[____exports.TrackSendAutomationMode.TrackDefault] = "TrackDefault"
____exports.TrackSendAutomationMode.Trim = 0
____exports.TrackSendAutomationMode[____exports.TrackSendAutomationMode.Trim] = "Trim"
____exports.TrackSendAutomationMode.Read = 1
____exports.TrackSendAutomationMode[____exports.TrackSendAutomationMode.Read] = "Read"
____exports.TrackSendAutomationMode.Touch = 2
____exports.TrackSendAutomationMode[____exports.TrackSendAutomationMode.Touch] = "Touch"
____exports.TrackSendAutomationMode.Write = 3
____exports.TrackSendAutomationMode[____exports.TrackSendAutomationMode.Write] = "Write"
____exports.TrackSendAutomationMode.Latch = 4
____exports.TrackSendAutomationMode[____exports.TrackSendAutomationMode.Latch] = "Latch"
TrackRouting = {}
do
    function TrackRouting.parseMidiFlags(self, flags)
        local first5bits = flags & 31
        local midiSendDisabled = first5bits == 31
        if midiSendDisabled then
            return nil
        end
        local next5bits = flags & 992
        local srcChannel = first5bits == 0 and "all" or first5bits
        local dstChannel = next5bits == 0 and "all" or next5bits
        local fadersSendMidiVolPan = flags & 1024 ~= 0
        local rawSrcBus = flags >> 14 & 255
        local srcBus = rawSrcBus == 0 and "all" or rawSrcBus
        local rawDstBus = flags >> 22 & 255
        local dstBus = rawDstBus == 0 and "all" or rawDstBus
        return {
            srcChannel = srcChannel,
            dstChannel = dstChannel,
            srcBus = srcBus,
            dstBus = dstBus,
            fadersSendMidiVolPan = fadersSendMidiVolPan
        }
    end
    function TrackRouting.getAudioInfo(self, track, category, idx)
        local function GTSI_V(____, param)
            return reaper.GetTrackSendInfo_Value(track, category, idx, param)
        end
        local I_SRCCHAN = GTSI_V(nil, "I_SRCCHAN")
        if I_SRCCHAN == -1 then
            return nil
        end
        local srcChannelOffset = I_SRCCHAN & 1023
        local channelCount
        repeat
            local ____switch201 = I_SRCCHAN >> 10
            local ____cond201 = ____switch201 == 0
            if ____cond201 then
                channelCount = 2
                break
            end
            ____cond201 = ____cond201 or ____switch201 == 1
            if ____cond201 then
                channelCount = 1
                break
            end
            do
                channelCount = (I_SRCCHAN >> 10) * 2
                break
            end
        until true
        local I_DSTCHAN = GTSI_V(nil, "I_DSTCHAN")
        local dstChannelOffset = I_DSTCHAN & 1023
        local mixToMono = I_DSTCHAN & 1024 ~= 0
        local muted = GTSI_V(nil, "B_MUTE") == 1
        local phaseInverted = GTSI_V(nil, "B_PHASE") == 1
        local mono = GTSI_V(nil, "B_MONO") == 1
        local volume = GTSI_V(nil, "D_VOL")
        local pan = GTSI_V(nil, "D_PAN")
        local D_PANLAW = GTSI_V(nil, "D_PANLAW")
        local ____temp_5
        if D_PANLAW == -1 then
            ____temp_5 = nil
        else
            ____temp_5 = D_PANLAW
        end
        local panLaw = ____temp_5
        local sendMode = GTSI_V(nil, "I_SENDMODE")
        local automationMode = GTSI_V(nil, "I_AUTOMODE")
        return {
            channelCount = channelCount,
            srcChannelOffset = srcChannelOffset,
            dstChannelOffset = dstChannelOffset,
            muted = muted,
            phaseInverted = phaseInverted,
            mono = mono,
            volume = volume,
            pan = pan,
            panLaw = panLaw,
            sendMode = sendMode,
            automationMode = automationMode,
            mixToMono = mixToMono
        }
    end
    function TrackRouting.getInfo(self, track, category, idx)
        local audio = TrackRouting:getAudioInfo(track, category, idx)
        local midiFlags = reaper.GetTrackSendInfo_Value(track, ____exports.TrackRoutingCategory.Send, idx, "I_MIDIFLAGS")
        local midi = TrackRouting:parseMidiFlags(midiFlags)
        return {audio = audio, midi = midi}
    end
    function TrackRouting.getTargetTracks(self, track, category, idx)
        local dst = reaper.GetTrackSendInfo_Value(track, category, idx, "P_DESTTRACK")
        local src = reaper.GetTrackSendInfo_Value(track, category, idx, "P_SRCTRACK")
        return {
            dst = __TS__New(____exports.Track, dst),
            src = __TS__New(____exports.Track, src)
        }
    end
    function TrackRouting.getParentAudioInfo(self, track)
        local sendsAudioToParent = reaper.GetMediaTrackInfo_Value(track, "B_MAINSEND") == 1
        if not sendsAudioToParent then
            return nil
        end
        local trackChannelCount = reaper.GetMediaTrackInfo_Value(track, "I_NCHAN")
        local dstChannelOffset = reaper.GetMediaTrackInfo_Value(track, "C_MAINSEND_OFFS")
        local rawSendChannelCount = reaper.GetMediaTrackInfo_Value(track, "C_MAINSEND_NCH")
        local sendChannelCount = rawSendChannelCount == 0 and trackChannelCount or rawSendChannelCount
        return {
            channelCount = sendChannelCount,
            srcChannelOffset = 0,
            dstChannelOffset = dstChannelOffset,
            muted = false,
            phaseInverted = false,
            mono = false,
            volume = 1,
            pan = 0,
            panLaw = nil,
            sendMode = ____exports.TrackSendMode.PostFader,
            automationMode = ____exports.TrackSendAutomationMode.TrackDefault,
            mixToMono = false
        }
    end
    function TrackRouting.getParentMidiInfo(self, track)
        local sendsAudioToParent = reaper.GetMediaTrackInfo_Value(track, "B_MAINSEND") == 1
        if not sendsAudioToParent then
            return nil
        end
        local I_MIDI_CTL_CHAN = reaper.GetMediaTrackInfo_Value(track, "I_MIDI_CTL_CHAN")
        local faderLinkedChannel
        repeat
            local ____switch208 = I_MIDI_CTL_CHAN
            local ____cond208 = ____switch208 == 16
            if ____cond208 then
                faderLinkedChannel = "all"
                break
            end
            ____cond208 = ____cond208 or ____switch208 == -1
            if ____cond208 then
                faderLinkedChannel = nil
                break
            end
            do
                faderLinkedChannel = I_MIDI_CTL_CHAN + 1
                break
            end
        until true
        return {
            srcChannel = "all",
            dstChannel = "all",
            srcBus = "all",
            dstBus = "all",
            fadersSendMidiVolPan = faderLinkedChannel ~= nil
        }
    end
    function TrackRouting.getParentInfo(self, track)
        local audio = TrackRouting:getParentAudioInfo(track)
        local midi = TrackRouting:getParentMidiInfo(track)
        return {audio = audio, midi = midi}
    end
end
--- Iterates through all tracks in the project, then returns maps for sending and receiving
-- tracks. This includes the default routing to folder parents.
-- 
-- - `sends`: Maps from `trackIdx` to a list of `trackIdx` which this track sends to
-- - `receives`: Maps from `trackIdx` to a list of `trackIdx` sends to this track
-- 
-- Note: The `receives` map contains `-1` which represent the master track.
-- 
-- @param opt Specify what kind of routing to filter for. E.g. If you only care about audio
-- routing, specify `{ audio: true }`
function ____exports.getProjectRoutingInfo(self, opt)
    if opt == nil then
        opt = {audio = true, midi = true}
    end
    local count = ____exports.Track:count()
    local sends = {}
    local receives = {}
    do
        local srcIdx = 0
        while srcIdx < count do
            local track = ____exports.Track:getByIdx(srcIdx)
            for ____, send in ipairs(track:getSends(true)) do
                do
                    if opt.audio and opt.midi then
                        if not (send.audio or send.midi) then
                            goto __continue212
                        end
                    elseif opt.audio then
                        if not send.audio then
                            goto __continue212
                        end
                    elseif opt.midi then
                        if not send.midi then
                            goto __continue212
                        end
                    end
                    local dstIdx = send.dst:getIdx()
                    if not (sends[srcIdx] ~= nil) then
                        sends[srcIdx] = {}
                    end
                    local ____sends_srcIdx_6 = sends[srcIdx]
                    ____sends_srcIdx_6[#____sends_srcIdx_6 + 1] = dstIdx
                    if not (receives[dstIdx] ~= nil) then
                        receives[dstIdx] = {}
                    end
                    local ____receives_dstIdx_7 = receives[dstIdx]
                    ____receives_dstIdx_7[#____receives_dstIdx_7 + 1] = srcIdx
                end
                ::__continue212::
            end
            srcIdx = srcIdx + 1
        end
    end
    return {sends = sends, receives = receives}
end
return ____exports

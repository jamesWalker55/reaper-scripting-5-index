local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__Generator = ____lualib.__TS__Generator
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local ____exports = {}
local TrackRouting
local ____fx = require("lua_modules.reaper-api.fx")
local generateContainerFxidx = ____fx.generateContainerFxidx
local stringifyAddFxParams = ____fx.stringifyAddFxParams
local TrackFX = ____fx.TrackFX
local ____item = require("lua_modules.reaper-api.item")
local Item = ____item.Item
____exports.Track = __TS__Class()
local Track = ____exports.Track
Track.name = "Track"
function Track.prototype.____constructor(self, track)
    self.obj = track
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
        error("failed to get track with index " .. tostring(idx))
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
function Track.prototype.addFx(self, fx, position)
    local fxname = stringifyAddFxParams(nil, fx)
    if position ~= nil and type(position) ~= "number" then
        position = generateContainerFxidx(nil, self.obj, position)
    end
    local rv = reaper.TrackFX_AddByName(self.obj, fxname, false, position == nil and -1 or -1000 - position)
    if rv == -1 then
        return nil
    end
    local newPosition = rv
    return newPosition
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
            result[#result + 1] = __TS__New(TrackFX, self.obj, i)
            i = i + 1
        end
    end
    return result
end
function Track.prototype.getFx(self, idx)
    return __TS__New(TrackFX, self.obj, idx)
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
function Track.prototype.getVolume(self)
    return reaper.GetMediaTrackInfo_Value(self.obj, "D_VOL")
end
function Track.prototype.setVolume(self, val)
    local ok = reaper.SetMediaTrackInfo_Value(self.obj, "D_VOL", val)
    if not ok then
        error("failed to set volume")
    end
end
function Track.prototype.getPan(self)
    return reaper.GetMediaTrackInfo_Value(self.obj, "D_PAN")
end
function Track.prototype.setPan(self, val)
    local ok = reaper.SetMediaTrackInfo_Value(self.obj, "D_PAN", val)
    if not ok then
        error("failed to set pan")
    end
end
function Track.prototype.getWidth(self)
    return reaper.GetMediaTrackInfo_Value(self.obj, "D_WIDTH")
end
function Track.prototype.setWidth(self, val)
    local ok = reaper.SetMediaTrackInfo_Value(self.obj, "D_WIDTH", val)
    if not ok then
        error("failed to set width")
    end
end
function Track.prototype.getPanLaw(self)
    return reaper.GetMediaTrackInfo_Value(self.obj, "D_PANLAW")
end
function Track.prototype.setPanLaw(self, val)
    local ok = reaper.SetMediaTrackInfo_Value(self.obj, "D_PANLAW", val)
    if not ok then
        error("failed to set pan law")
    end
end
function Track.prototype.getMuted(self)
    return reaper.GetMediaTrackInfo_Value(self.obj, "B_MUTE") == 1
end
function Track.prototype.setMuted(self, val)
    local ok = reaper.SetMediaTrackInfo_Value(self.obj, "B_MUTE", val and 1 or 0)
    if not ok then
        error("failed to set muted")
    end
end
function Track.prototype.getPhaseInverted(self)
    return reaper.GetMediaTrackInfo_Value(self.obj, "B_PHASE") == 1
end
function Track.prototype.setPhaseInverted(self, val)
    local ok = reaper.SetMediaTrackInfo_Value(self.obj, "B_PHASE", val and 1 or 0)
    if not ok then
        error("failed to set phase inverted")
    end
end
function Track.prototype.getPanmode(self)
    return reaper.GetMediaTrackInfo_Value(self.obj, "I_PANMODE")
end
function Track.prototype.setPanmode(self, val)
    local ok = reaper.SetMediaTrackInfo_Value(self.obj, "I_PANMODE", val)
    if not ok then
        error("failed to set panmode")
    end
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
function Track.prototype.getName(self)
    local ok, val = reaper.GetSetMediaTrackInfo_String(self.obj, "P_NAME", "", false)
    if not ok then
        error("failed to get track name")
    end
    return val
end
function Track.prototype.delete(self)
    reaper.DeleteTrack(self.obj)
end
function Track.prototype.getIdx(self)
    local tracknumber = reaper.GetMediaTrackInfo_Value(self.obj, "IP_TRACKNUMBER")
    if tracknumber == 0 then
        error("failed to get track number")
    end
    if tracknumber == -1 then
        return -1
    end
    return tracknumber - 1
end
Track.prototype.iterItems = __TS__Generator(function(self)
    local count = reaper.CountTrackMediaItems(self.obj)
    do
        local i = 0
        while i < count do
            local item = reaper.GetTrackMediaItem(self.obj, i)
            coroutine.yield(__TS__New(Item, item))
            i = i + 1
        end
    end
end)
function ____exports.getSelectedTracks(self)
    return ____exports.Track:getSelected()
end
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
            local ____switch67 = I_SRCCHAN >> 10
            local ____cond67 = ____switch67 == 0
            if ____cond67 then
                channelCount = 2
                break
            end
            ____cond67 = ____cond67 or ____switch67 == 1
            if ____cond67 then
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
        local ____temp_2
        if D_PANLAW == -1 then
            ____temp_2 = nil
        else
            ____temp_2 = D_PANLAW
        end
        local panLaw = ____temp_2
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
            local ____switch74 = I_MIDI_CTL_CHAN
            local ____cond74 = ____switch74 == 16
            if ____cond74 then
                faderLinkedChannel = "all"
                break
            end
            ____cond74 = ____cond74 or ____switch74 == -1
            if ____cond74 then
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
                            goto __continue78
                        end
                    elseif opt.audio then
                        if not send.audio then
                            goto __continue78
                        end
                    elseif opt.midi then
                        if not send.midi then
                            goto __continue78
                        end
                    end
                    local dstIdx = send.dst:getIdx()
                    if not (sends[srcIdx] ~= nil) then
                        sends[srcIdx] = {}
                    end
                    local ____sends_srcIdx_3 = sends[srcIdx]
                    ____sends_srcIdx_3[#____sends_srcIdx_3 + 1] = dstIdx
                    if not (receives[dstIdx] ~= nil) then
                        receives[dstIdx] = {}
                    end
                    local ____receives_dstIdx_4 = receives[dstIdx]
                    ____receives_dstIdx_4[#____receives_dstIdx_4 + 1] = srcIdx
                end
                ::__continue78::
            end
            srcIdx = srcIdx + 1
        end
    end
    return {sends = sends, receives = receives}
end
return ____exports

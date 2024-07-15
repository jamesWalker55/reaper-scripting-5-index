local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local __TS__StringEndsWith = ____lualib.__TS__StringEndsWith
local __TS__ArrayReduce = ____lualib.__TS__ArrayReduce
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__StringSlice = ____lualib.__TS__StringSlice
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__New = ____lualib.__TS__New
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local ____exports = {}
local ArrChunk = require("lua_modules.reaper-api.arrchunk")
local Base64 = require("lua_modules.reaper-api.base64")
local Chunk = require("lua_modules.reaper-api.chunk")
local ____utils = require("lua_modules.reaper-api.utils")
local msgBox = ____utils.msgBox
local function parseLittleEndianInteger(self, bytes)
    local result = 0
    do
        local i = 0
        while i < #bytes do
            local byte = string.byte(bytes, i + 1)
            result = result + (byte << i * 8)
            i = i + 1
        end
    end
    return result
end
local BaseFX = __TS__Class()
BaseFX.name = "BaseFX"
function BaseFX.prototype.____constructor(self)
end
function BaseFX.prototype.guid(self)
    local guid = self:GetFXGUID()
    if not guid then
        error("failed to get FX GUID")
    end
    return guid
end
function BaseFX.prototype.getParameters(self)
    local totalCount = self:GetNumParams()
    local result = {}
    do
        local i = 0
        while i < totalCount do
            result[#result + 1] = self:getParameter(i)
            i = i + 1
        end
    end
    return result
end
function BaseFX.prototype.getOriginalName(self)
    local name = self:GetNamedConfigParm("fx_name")
    if not name then
        error("failed to get FX name")
    end
    return name
end
function BaseFX.prototype.getIdent(self)
    local ident = self:GetNamedConfigParm("fx_ident")
    if not ident then
        error("failed to get FX ident")
    end
    return ident
end
function BaseFX.prototype.getType(self)
    local ____type = self:GetNamedConfigParm("fx_type")
    if not ____type then
        error("failed to get FX type")
    end
    return ____type
end
function BaseFX.prototype.getPDCLatency(self)
    local pdc = self:GetNamedConfigParm("pdc")
    if not pdc then
        error("failed to get FX pdc")
    end
    return pdc
end
function BaseFX.prototype.decipherFxidx(self)
    local actualIdx = 16777215 & self.fxidx
    local isRecInputOrHardwareOutput = self.fxidx & 16777216 ~= 0
    local isInContainer = self.fxidx & 33554432 ~= 0
    if isInContainer then
        return {isRecInputOrHardwareOutput = isRecInputOrHardwareOutput, isInContainer = isInContainer}
    else
        return {actualIdx = actualIdx, isRecInputOrHardwareOutput = isRecInputOrHardwareOutput, isInContainer = isInContainer}
    end
end
function BaseFX.prototype.parseArrChunk(self, arr)
    local tagLine = table.remove(arr, 1)
    if type(tagLine) ~= "string" then
        error("fx chunk is missing header line")
    end
    if not tagLine then
        error("fx chunk is missing header line")
    end
    if __TS__StringStartsWith(tagLine, "VST") then
        for ____, x in ipairs(arr) do
            if type(x) ~= "string" then
                error("fx chunk should not contain sub-elements, but found an element: " .. tostring(x[1]))
            end
        end
        local b64arr = arr
        local b64arrBlocks = __TS__ArrayReduce(
            b64arr,
            function(____, acc, line)
                local ____acc_index_0 = acc[#acc]
                ____acc_index_0[#____acc_index_0 + 1] = line
                if __TS__StringEndsWith(line, "=") then
                    acc[#acc + 1] = {}
                end
                return acc
            end,
            {{}}
        )
        if #b64arrBlocks[#b64arrBlocks] == 0 then
            table.remove(b64arrBlocks)
        end
        local b64blocks = __TS__ArrayMap(
            b64arrBlocks,
            function(____, lines) return table.concat(lines, "") end
        )
        local alldata = table.concat(
            __TS__ArrayMap(
                b64blocks,
                function(____, b) return Base64.decode(b) end
            ),
            ""
        )
        local vstid = string.sub(alldata, 1, 4)
        local magic = string.sub(alldata, 5, 8)
        local i = 8
        local inputCount = parseLittleEndianInteger(
            nil,
            __TS__StringSlice(alldata, i, i + 4)
        )
        i = i + 4
        i = i + inputCount * 8
        local outputCount = parseLittleEndianInteger(
            nil,
            __TS__StringSlice(alldata, i, i + 4)
        )
        i = i + 4
        i = i + outputCount * 8
        local fxdataLength = parseLittleEndianInteger(
            nil,
            __TS__StringSlice(alldata, i, i + 4)
        )
        i = i + 4
        local magicEnd = __TS__StringSlice(alldata, i, i + 8)
        i = i + 8
        local fxdataStart = i
        assert(fxdataStart + fxdataLength < #alldata, "fxdata exceeds actual chunk size")
        local headerdata = __TS__StringSlice(alldata, 0, fxdataStart)
        local fxdata = __TS__StringSlice(alldata, fxdataStart, fxdataStart + fxdataLength)
        local footerdata = __TS__StringSlice(alldata, fxdataStart + fxdataLength, #alldata)
        return {
            headerdata = headerdata,
            fxdata = fxdata,
            footerdata = footerdata,
            inputCount = inputCount,
            outputCount = outputCount,
            fxdataLength = fxdataLength,
            vstid = vstid,
            magic = magic
        }
    elseif __TS__StringStartsWith(tagLine, "CLAP") then
        local b64arr = (function()
            for ____, x in ipairs(arr) do
                do
                    if type(x) ~= "string" then
                        local stateTag = x[1]
                        if type(stateTag) ~= "string" then
                            error("clap state chunk is missing header line")
                        end
                        if stateTag ~= "STATE" then
                            goto __continue34
                        end
                        local state = __TS__ArraySlice(x, 1, #x)
                        for ____, x in ipairs(state) do
                            if type(x) ~= "string" then
                                error("clap state element should not contain sub-elements, but found an element: " .. tostring(x[1]))
                            end
                        end
                        return state
                    end
                end
                ::__continue34::
            end
            error("failed to get CLAP plugin state: " .. tagLine)
        end)(nil)
        local fxdata = Base64.decode(table.concat(b64arr, ""))
        return {fxdata = fxdata}
    else
        error("this kind of fx chunk is not supported: " .. tagLine)
    end
end
function BaseFX.prototype.getData(self)
    local ____type = string.upper(self:getType())
    local chunk = nil
    if __TS__StringIncludes(____type, "VST") then
        chunk = self:GetNamedConfigParm("vst_chunk")
    elseif __TS__StringIncludes(____type, "CLAP") then
        chunk = self:GetNamedConfigParm("clap_chunk")
    else
        return nil
    end
    if chunk ~= nil then
        local arrchunk = self:getArrChunk()
        local ____temp_1 = self:parseArrChunk(arrchunk)
        local fxdata = ____temp_1.fxdata
        local testchunk = Base64.encode(fxdata)
        if chunk ~= testchunk then
            msgBox(nil, "Debug", "Successfully got chunk data the normal way!\nHowever, the alternative FX chunk parser would have given different output, please debug this!")
        end
    end
    if chunk == nil then
        local arrchunk = self:getArrChunk()
        local ____temp_2 = self:parseArrChunk(arrchunk)
        local fxdata = ____temp_2.fxdata
        chunk = Base64.encode(fxdata)
    end
    return chunk
end
function BaseFX.prototype.isOffline(self)
    return self:GetOffline()
end
____exports.TrackFX = __TS__Class()
local TrackFX = ____exports.TrackFX
TrackFX.name = "TrackFX"
__TS__ClassExtends(TrackFX, BaseFX)
function TrackFX.prototype.____constructor(self, track, fxidx)
    BaseFX.prototype.____constructor(self)
    self.type = "track"
    self.track = track
    self.fxidx = fxidx
end
function TrackFX.prototype.GetNamedConfigParm(self, name)
    local ok, value = reaper.TrackFX_GetNamedConfigParm(self.track, self.fxidx, name)
    return ok and value or nil
end
function TrackFX.prototype.SetNamedConfigParm(self, name, value)
    return reaper.TrackFX_SetNamedConfigParm(self.track, self.fxidx, name, value)
end
function TrackFX.prototype.GetNumParams(self)
    return reaper.TrackFX_GetNumParams(self.track, self.fxidx)
end
function TrackFX.prototype.GetParamIdent(self, param)
    local ok, value = reaper.TrackFX_GetParamIdent(self.track, self.fxidx, param)
    return ok and value or nil
end
function TrackFX.prototype.GetParamName(self, param)
    local ok, value = reaper.TrackFX_GetParamName(self.track, self.fxidx, param)
    return ok and value or nil
end
function TrackFX.prototype.GetFXGUID(self)
    return reaper.TrackFX_GetFXGUID(self.track, self.fxidx)
end
function TrackFX.prototype.GetOffline(self)
    return reaper.TrackFX_GetOffline(self.track, self.fxidx)
end
function TrackFX.prototype.getParameter(self, param)
    return __TS__New(____exports.FXParam, {track = self.track}, self.fxidx, param)
end
function TrackFX.prototype.getName(self)
    local ok, value = reaper.TrackFX_GetFXName(self.track, self.fxidx)
    if not ok then
        error("failed to get FX name")
    end
    return value
end
function TrackFX.prototype.getArrChunk(self)
    local decipher = self:decipherFxidx()
    if decipher.isInContainer then
        error("unable to get chunk data from FX in containers")
    end
    local fxchainTag
    if decipher.isRecInputOrHardwareOutput then
        local masterTrack = reaper.GetMasterTrack(0)
        local isMasterTrack = self.track == masterTrack
        if isMasterTrack then
            error("unable to get chunk data from FX in monitor FX")
        else
            fxchainTag = "FXCHAIN_REC"
        end
    else
        local totalFxCount = reaper.TrackFX_GetCount(self.track)
        assert(
            decipher.actualIdx < totalFxCount,
            (("FX index of " .. tostring(decipher.actualIdx)) .. " exceeds track FX count of ") .. tostring(totalFxCount)
        )
        fxchainTag = "FXCHAIN"
    end
    local chunk = Chunk.track(self.track)
    if not ArrChunk._testChunk(chunk) then
        error("failsafe - error when parsing track chunk data")
    end
    local arrchunk = ArrChunk.fromChunk(chunk)
    local fxchainarr = nil
    for ____, child in ipairs(arrchunk) do
        do
            if type(child) == "string" then
                goto __continue69
            end
            local tag = child[1]
            if tag == fxchainTag then
                fxchainarr = child
                break
            end
        end
        ::__continue69::
    end
    if fxchainarr == nil then
        error(("failed to find <" .. fxchainTag) .. "> element in track chunk data")
    end
    local fxchunks = __TS__ArrayFilter(
        fxchainarr,
        function(____, x) return type(x) ~= "string" end
    )
    return fxchunks[decipher.actualIdx + 1]
end
____exports.TakeFX = __TS__Class()
local TakeFX = ____exports.TakeFX
TakeFX.name = "TakeFX"
__TS__ClassExtends(TakeFX, BaseFX)
function TakeFX.prototype.____constructor(self, take, fxidx)
    BaseFX.prototype.____constructor(self)
    self.type = "take"
    self.take = take
    self.fxidx = fxidx
end
function TakeFX.prototype.GetNamedConfigParm(self, name)
    local ok, value = reaper.TakeFX_GetNamedConfigParm(self.take, self.fxidx, name)
    return ok and value or nil
end
function TakeFX.prototype.SetNamedConfigParm(self, name, value)
    return reaper.TakeFX_SetNamedConfigParm(self.take, self.fxidx, name, value)
end
function TakeFX.prototype.GetNumParams(self)
    return reaper.TakeFX_GetNumParams(self.take, self.fxidx)
end
function TakeFX.prototype.GetParamIdent(self, param)
    local ok, value = reaper.TakeFX_GetParamIdent(self.take, self.fxidx, param)
    return ok and value or nil
end
function TakeFX.prototype.GetParamName(self, param)
    local ok, value = reaper.TakeFX_GetParamName(self.take, self.fxidx, param)
    return ok and value or nil
end
function TakeFX.prototype.GetFXGUID(self)
    return reaper.TakeFX_GetFXGUID(self.take, self.fxidx)
end
function TakeFX.prototype.GetOffline(self)
    return reaper.TakeFX_GetOffline(self.take, self.fxidx)
end
function TakeFX.prototype.getParameter(self, param)
    return __TS__New(____exports.FXParam, {take = self.take}, self.fxidx, param)
end
function TakeFX.prototype.getName(self)
    local ok, value = reaper.TakeFX_GetFXName(self.take, self.fxidx)
    if not ok then
        error("failed to get FX name")
    end
    return value
end
function TakeFX.prototype.getArrChunk(self)
    error("TODO: Implement parsing chunk data of items")
end
____exports.FXParam = __TS__Class()
local FXParam = ____exports.FXParam
FXParam.name = "FXParam"
function FXParam.prototype.____constructor(self, target, fxidx, param)
    if target.track ~= nil then
        self.fx = __TS__New(____exports.TrackFX, target.track, fxidx)
    else
        self.fx = __TS__New(____exports.TakeFX, target.take, fxidx)
    end
    self.param = param
end
function FXParam.prototype._parseParamConfig(self, name, fallback)
    local text = self.fx:GetNamedConfigParm((("param." .. tostring(self.param)) .. ".") .. name)
    if not text then
        return fallback
    end
    local result = tonumber(text)
    if result == nil then
        error("failed to parse named config parm as number")
    end
    return result
end
function FXParam.prototype._setParamConfig(self, name, value)
    local key = (("param." .. tostring(self.param)) .. ".") .. name
    if type(value) == "number" then
        self.fx:SetNamedConfigParm(
            key,
            tostring(value)
        )
    else
        self.fx:SetNamedConfigParm(key, value and "1" or "0")
    end
end
function FXParam.prototype.getIdent(self)
    local rv = self.fx:GetParamIdent(self.param)
    if not rv then
        error("param object is no longer valid")
    end
    return rv
end
function FXParam.prototype.getName(self)
    local rv = self.fx:GetParamName(self.param)
    if not rv then
        error("param object is no longer valid")
    end
    return rv
end
function FXParam.prototype.modulationActive(self)
    return self:_parseParamConfig("mod.active", 0) == 1
end
function FXParam.prototype.getModulation(self)
    local modActive = self:_parseParamConfig("mod.active", 0) == 1
    if not modActive then
        return nil
    end
    local modInfo = {
        baseline = self:_parseParamConfig("mod.baseline", 0),
        acs = nil,
        lfo = nil,
        plink = nil
    }
    local lfoActive = self:_parseParamConfig("lfo.active", 0) == 1
    if lfoActive then
        modInfo.lfo = {
            dir = self:_parseParamConfig("lfo.dir", 1),
            phase = self:_parseParamConfig("lfo.phase", 0),
            speed = self:_parseParamConfig("lfo.speed", 1),
            strength = self:_parseParamConfig("lfo.strength", 1),
            tempoSync = self:_parseParamConfig("lfo.temposync", 0) == 1,
            free = self:_parseParamConfig("lfo.free", 0) == 1,
            shape = self:_parseParamConfig("lfo.shape", 0)
        }
    end
    local acsActive = self:_parseParamConfig("acs.active", 0) == 1
    if acsActive then
        modInfo.acs = {
            dir = self:_parseParamConfig("acs.dir", 1),
            strength = self:_parseParamConfig("acs.strength", 1),
            attack = self:_parseParamConfig("acs.attack", 300),
            release = self:_parseParamConfig("acs.release", 300),
            minVol = self:_parseParamConfig("acs.dblo", -24),
            maxVol = self:_parseParamConfig("acs.dbhi", 0),
            chan = self:_parseParamConfig("acs.chan", -1),
            stereo = self:_parseParamConfig("acs.stereo", 0) == 1,
            x2 = self:_parseParamConfig("acs.x2", 0.5),
            y2 = self:_parseParamConfig("acs.y2", 0.5)
        }
    end
    local plinkActive = self:_parseParamConfig("plink.active", 0) == 1
    if plinkActive then
        modInfo.plink = {
            scale = self:_parseParamConfig("plink.scale", 1),
            offset = self:_parseParamConfig("plink.offset", 0),
            fxidx = self:_parseParamConfig("plink.effect", -1),
            param = self:_parseParamConfig("plink.param", -1),
            midi_bus = self:_parseParamConfig("plink.midi_bus", 0),
            midi_chan = self:_parseParamConfig("plink.midi_chan", 0),
            midi_msg = self:_parseParamConfig("plink.midi_msg", 0),
            midi_msg2 = self:_parseParamConfig("plink.midi_msg2", 0)
        }
    end
    return modInfo
end
function FXParam.prototype.setModulation(self, modInfo)
    self:_setParamConfig("mod.active", modInfo ~= nil)
    if modInfo == nil then
        return
    end
    self:_setParamConfig("mod.baseline", modInfo.baseline)
    self:_setParamConfig("lfo.active", modInfo.lfo ~= nil)
    if modInfo.lfo ~= nil then
        self:_setParamConfig("lfo.dir", modInfo.lfo.dir)
        self:_setParamConfig("lfo.phase", modInfo.lfo.phase)
        self:_setParamConfig("lfo.speed", modInfo.lfo.speed)
        self:_setParamConfig("lfo.strength", modInfo.lfo.strength)
        self:_setParamConfig("lfo.temposync", modInfo.lfo.tempoSync)
        self:_setParamConfig("lfo.free", modInfo.lfo.free)
        self:_setParamConfig("lfo.shape", modInfo.lfo.shape)
    end
    self:_setParamConfig("acs.active", modInfo.acs ~= nil)
    if modInfo.acs ~= nil then
        self:_setParamConfig("acs.dir", modInfo.acs.dir)
        self:_setParamConfig("acs.strength", modInfo.acs.strength)
        self:_setParamConfig("acs.attack", modInfo.acs.attack)
        self:_setParamConfig("acs.release", modInfo.acs.release)
        self:_setParamConfig("acs.dblo", modInfo.acs.minVol)
        self:_setParamConfig("acs.dbhi", modInfo.acs.maxVol)
        self:_setParamConfig("acs.chan", modInfo.acs.chan)
        self:_setParamConfig("acs.stereo", modInfo.acs.stereo)
        self:_setParamConfig("acs.x2", modInfo.acs.x2)
        self:_setParamConfig("acs.y2", modInfo.acs.y2)
    end
    self:_setParamConfig("plink.active", modInfo.plink ~= nil)
    if modInfo.plink then
        self:_setParamConfig("plink.scale", modInfo.plink.scale)
        self:_setParamConfig("plink.offset", modInfo.plink.offset)
        self:_setParamConfig("plink.effect", modInfo.plink.fxidx)
        self:_setParamConfig("plink.param", modInfo.plink.param)
        self:_setParamConfig("plink.midi_bus", modInfo.plink.midi_bus)
        self:_setParamConfig("plink.midi_chan", modInfo.plink.midi_chan)
        self:_setParamConfig("plink.midi_msg", modInfo.plink.midi_msg)
        self:_setParamConfig("plink.midi_msg2", modInfo.plink.midi_msg2)
    end
    return modInfo
end
function ____exports.getLastTouchedFx(self)
    local retval, trackidx, itemidx, takeidx, fxidx, parm = reaper.GetTouchedOrFocusedFX(1)
    if not retval then
        return nil
    end
    local isMaster = trackidx == -1
    local track = isMaster and reaper.GetMasterTrack(0) or reaper.GetTrack(0, trackidx)
    if itemidx == -1 then
        return __TS__New(____exports.TrackFX, track, fxidx)
    else
        local item = reaper.GetTrackMediaItem(track, itemidx)
        local take = reaper.GetTake(item, takeidx)
        return __TS__New(____exports.TakeFX, take, fxidx)
    end
end
return ____exports

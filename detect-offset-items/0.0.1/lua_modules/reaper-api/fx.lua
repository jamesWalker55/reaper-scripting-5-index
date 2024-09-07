local ____lualib = require("lualib_bundle")
local __TS__ParseInt = ____lualib.__TS__ParseInt
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__Class = ____lualib.__TS__Class
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__StringEndsWith = ____lualib.__TS__StringEndsWith
local __TS__ArrayReduce = ____lualib.__TS__ArrayReduce
local __TS__StringSlice = ____lualib.__TS__StringSlice
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local ____exports = {}
local Base64 = require("lua_modules.reaper-api.base64")
local Chunk = require("lua_modules.reaper-api.chunk")
local ____element = require("lua_modules.reaper-api.element")
local parse = ____element.parse
local ____inspect = require("lua_modules.reaper-api.inspect")
local inspect = ____inspect.inspect
local ____utils = require("lua_modules.reaper-api.utils")
local assertUnreachable = ____utils.assertUnreachable
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
function ____exports.stringifyAddFxParams(self, params)
    if type(params) == "string" then
        return params
    end
    if params.vst3 ~= nil then
        return "VST3: " .. params.vst3
    elseif params.vst2 ~= nil then
        return "VST2: " .. params.vst2
    elseif params.vst ~= nil then
        return "VST: " .. params.vst
    elseif params.au ~= nil then
        return "AU: " .. params.au
    elseif params.js ~= nil then
        return "JS: " .. params.js
    elseif params.dx ~= nil then
        return "DX: " .. params.dx
    elseif params.clap ~= nil then
        return "CLAP: " .. params.clap
    elseif params.browser ~= nil then
        local browser = params.browser
        if browser == true then
            return "FXADD:"
        elseif browser.max ~= nil then
            return "FXADD:" .. tostring(browser.max)
        elseif browser.exactly ~= nil then
            return ("FXADD:" .. tostring(browser.exactly)) .. "e"
        else
            assertUnreachable(nil, browser)
        end
    else
        assertUnreachable(nil, params)
    end
end
function ____exports.parseContainerFxidx(self, track, fxidx)
    local isContainerFxidx = fxidx & 33554432 ~= 0
    if not isContainerFxidx then
        return {fxidx}
    end
    local ret = {}
    local n = reaper.TrackFX_GetCount(track)
    local curidx = (fxidx - 33554432) % (n + 1)
    local remain = math.floor((fxidx - 33554432) / (n + 1))
    if curidx < 1 then
        error("bad container address")
    end
    local addr = curidx + 33554432
    local addr_sc = n + 1
    while true do
        local ccok, cc = reaper.TrackFX_GetNamedConfigParm(track, addr, "container_count")
        if not ccok then
            error("bad container address: not a container")
        end
        ret[#ret + 1] = curidx - 1
        n = __TS__ParseInt(cc)
        if remain <= n then
            if remain > 0 then
                ret[#ret + 1] = remain - 1
            end
            return ret
        end
        curidx = remain % (n + 1)
        remain = math.floor(remain / (n + 1))
        if curidx < 1 then
            error("bad container address")
        end
        addr = addr + addr_sc * curidx
        addr_sc = addr_sc * (n + 1)
    end
end
function ____exports.generateContainerFxidx(self, track, allidx)
    if #allidx <= 0 then
        error(
            __TS__New(Error, "container index must be at least length 1"),
            0
        )
    end
    local sc = reaper.TrackFX_GetCount(track) + 1
    local rv = 33554432 + allidx[1] + 1
    do
        local i = 1
        while i < #allidx do
            local v = allidx[i + 1] + 1
            local ccok, cc = reaper.TrackFX_GetNamedConfigParm(track, rv, "container_count")
            if not ccok then
                error("bad container address: container does not exist")
            end
            rv = rv + sc * v
            sc = sc * (1 + __TS__ParseInt(cc))
            i = i + 1
        end
    end
    return rv
end
local ReaperFXChain = __TS__Class()
ReaperFXChain.name = "ReaperFXChain"
function ReaperFXChain.prototype.____constructor(self, params)
    if params.track ~= nil then
        self.obj = {type = "track", track = params.track}
    else
        self.obj = {type = "take", take = params.take}
    end
end
function ReaperFXChain.prototype.GetNamedConfigParm(self, fxidx, name)
    repeat
        local ____switch35 = self.obj.type
        local ____cond35 = ____switch35 == "track"
        if ____cond35 then
            do
                local ok, value = reaper.TrackFX_GetNamedConfigParm(self.obj.track, fxidx, name)
                return ok and value or nil
            end
        end
        ____cond35 = ____cond35 or ____switch35 == "take"
        if ____cond35 then
            do
                local ok, value = reaper.TakeFX_GetNamedConfigParm(self.obj.take, fxidx, name)
                return ok and value or nil
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function ReaperFXChain.prototype.SetNamedConfigParm(self, fxidx, name, value)
    repeat
        local ____switch39 = self.obj.type
        local ____cond39 = ____switch39 == "track"
        if ____cond39 then
            do
                return reaper.TrackFX_SetNamedConfigParm(self.obj.track, fxidx, name, value)
            end
        end
        ____cond39 = ____cond39 or ____switch39 == "take"
        if ____cond39 then
            do
                return reaper.TakeFX_SetNamedConfigParm(self.obj.take, fxidx, name, value)
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function ReaperFXChain.prototype.GetNumParams(self, fxidx)
    repeat
        local ____switch43 = self.obj.type
        local ____cond43 = ____switch43 == "track"
        if ____cond43 then
            do
                return reaper.TrackFX_GetNumParams(self.obj.track, fxidx)
            end
        end
        ____cond43 = ____cond43 or ____switch43 == "take"
        if ____cond43 then
            do
                return reaper.TakeFX_GetNumParams(self.obj.take, fxidx)
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function ReaperFXChain.prototype.GetParamIdent(self, fxidx, param)
    repeat
        local ____switch47 = self.obj.type
        local ____cond47 = ____switch47 == "track"
        if ____cond47 then
            do
                local ok, value = reaper.TrackFX_GetParamIdent(self.obj.track, fxidx, param)
                return ok and value or nil
            end
        end
        ____cond47 = ____cond47 or ____switch47 == "take"
        if ____cond47 then
            do
                local ok, value = reaper.TakeFX_GetParamIdent(self.obj.take, fxidx, param)
                return ok and value or nil
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function ReaperFXChain.prototype.GetParamName(self, fxidx, param)
    repeat
        local ____switch51 = self.obj.type
        local ____cond51 = ____switch51 == "track"
        if ____cond51 then
            do
                local ok, value = reaper.TrackFX_GetParamName(self.obj.track, fxidx, param)
                return ok and value or nil
            end
        end
        ____cond51 = ____cond51 or ____switch51 == "take"
        if ____cond51 then
            do
                local ok, value = reaper.TakeFX_GetParamName(self.obj.take, fxidx, param)
                return ok and value or nil
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function ReaperFXChain.prototype.GetParamEx(self, fxidx, param)
    repeat
        local ____switch55 = self.obj.type
        local ____cond55 = ____switch55 == "track"
        if ____cond55 then
            do
                local rv, min, max, mid = reaper.TrackFX_GetParamEx(self.obj.track, fxidx, param)
                if min == nil then
                    error("failed to get param value")
                end
                return {rv, min, max, mid}
            end
        end
        ____cond55 = ____cond55 or ____switch55 == "take"
        if ____cond55 then
            do
                local rv, min, max, mid = reaper.TakeFX_GetParamEx(self.obj.take, fxidx, param)
                if min == nil then
                    error("failed to get param value")
                end
                return {rv, min, max, mid}
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function ReaperFXChain.prototype.SetParam(self, fxidx, param, value)
    repeat
        local ____switch61 = self.obj.type
        local ____cond61 = ____switch61 == "track"
        if ____cond61 then
            do
                return reaper.TrackFX_SetParam(self.obj.track, fxidx, param, value)
            end
        end
        ____cond61 = ____cond61 or ____switch61 == "take"
        if ____cond61 then
            do
                return reaper.TakeFX_SetParam(self.obj.take, fxidx, param, value)
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function ReaperFXChain.prototype.GetFXGUID(self, fxidx)
    repeat
        local ____switch65 = self.obj.type
        local ____cond65 = ____switch65 == "track"
        if ____cond65 then
            do
                return reaper.TrackFX_GetFXGUID(self.obj.track, fxidx)
            end
        end
        ____cond65 = ____cond65 or ____switch65 == "take"
        if ____cond65 then
            do
                return reaper.TakeFX_GetFXGUID(self.obj.take, fxidx)
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function ReaperFXChain.prototype.GetOffline(self, fxidx)
    repeat
        local ____switch69 = self.obj.type
        local ____cond69 = ____switch69 == "track"
        if ____cond69 then
            do
                return reaper.TrackFX_GetOffline(self.obj.track, fxidx)
            end
        end
        ____cond69 = ____cond69 or ____switch69 == "take"
        if ____cond69 then
            do
                return reaper.TakeFX_GetOffline(self.obj.take, fxidx)
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
____exports.FX = __TS__Class()
local FX = ____exports.FX
FX.name = "FX"
function FX.prototype.____constructor(self, params, fxidx)
    if params.track ~= nil then
        self.obj = {type = "track", track = params.track}
        self.chain = __TS__New(ReaperFXChain, {track = params.track})
    else
        self.obj = {type = "take", take = params.take}
        self.chain = __TS__New(ReaperFXChain, {take = params.take})
    end
    self.fxidx = fxidx
end
function FX.prototype.guid(self)
    local guid = self.chain:GetFXGUID(self.fxidx)
    if not guid then
        error("failed to get FX GUID")
    end
    return guid
end
function FX.prototype.getParameter(self, param)
    repeat
        local ____switch78 = self.obj.type
        local ____cond78 = ____switch78 == "track"
        if ____cond78 then
            do
                return __TS__New(____exports.FXParam, {track = self.obj.track}, self.fxidx, param)
            end
        end
        ____cond78 = ____cond78 or ____switch78 == "take"
        if ____cond78 then
            do
                return __TS__New(____exports.FXParam, {take = self.obj.take}, self.fxidx, param)
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function FX.prototype.getParameters(self)
    local totalCount = self.chain:GetNumParams(self.fxidx)
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
function FX.prototype.getName(self)
    repeat
        local ____switch84 = self.obj.type
        local ____cond84 = ____switch84 == "track"
        if ____cond84 then
            do
                local ok, value = reaper.TrackFX_GetFXName(self.obj.track, self.fxidx)
                if not ok then
                    error("failed to get FX name")
                end
                return value
            end
        end
        ____cond84 = ____cond84 or ____switch84 == "take"
        if ____cond84 then
            do
                local ok, value = reaper.TakeFX_GetFXName(self.obj.take, self.fxidx)
                if not ok then
                    error("failed to get FX name")
                end
                return value
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function FX.prototype.rename(self, name)
    repeat
        local ____switch90 = self.obj.type
        local ____cond90 = ____switch90 == "track"
        if ____cond90 then
            do
                reaper.TrackFX_SetNamedConfigParm(self.obj.track, self.fxidx, "renamed_name", name)
                break
            end
        end
        ____cond90 = ____cond90 or ____switch90 == "take"
        if ____cond90 then
            do
                reaper.TakeFX_SetNamedConfigParm(self.obj.take, self.fxidx, "renamed_name", name)
                break
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function FX.prototype.getOriginalName(self)
    local name = self.chain:GetNamedConfigParm(self.fxidx, "fx_name")
    if not name then
        error("failed to get FX name")
    end
    return name
end
function FX.prototype.getIdent(self)
    local ident = self.chain:GetNamedConfigParm(self.fxidx, "fx_ident")
    if not ident then
        error("failed to get FX ident")
    end
    return ident
end
function FX.prototype.getType(self)
    local ____type = self.chain:GetNamedConfigParm(self.fxidx, "fx_type")
    if not ____type then
        error("failed to get FX type")
    end
    return ____type
end
function FX.prototype.getPDCLatency(self)
    local pdc = self.chain:GetNamedConfigParm(self.fxidx, "pdc")
    if not pdc then
        error("failed to get FX pdc")
    end
    return pdc
end
function FX.prototype.decipherFxidx(self)
    local actualIdx = 16777215 & self.fxidx
    local isRecInputOrHardwareOutput = self.fxidx & 16777216 ~= 0
    local isInContainer = self.fxidx & 33554432 ~= 0
    if isInContainer then
        return {isRecInputOrHardwareOutput = isRecInputOrHardwareOutput, isInContainer = isInContainer}
    else
        return {actualIdx = actualIdx, isRecInputOrHardwareOutput = isRecInputOrHardwareOutput, isInContainer = isInContainer}
    end
end
function FX.prototype.getElement(self)
    repeat
        local ____switch105 = self.obj.type
        local ____cond105 = ____switch105 == "track"
        if ____cond105 then
            do
                local track = self.obj.track
                local decipher = self:decipherFxidx()
                if decipher.isInContainer then
                    error("unable to get chunk data from FX in containers")
                end
                local fxchainTag
                if decipher.isRecInputOrHardwareOutput then
                    local masterTrack = reaper.GetMasterTrack(0)
                    local isMasterTrack = track == masterTrack
                    if isMasterTrack then
                        error("unable to get chunk data from FX in monitor FX")
                    else
                        fxchainTag = "FXCHAIN_REC"
                    end
                else
                    local totalFxCount = reaper.TrackFX_GetCount(track)
                    if decipher.actualIdx >= totalFxCount then
                        error(
                            __TS__New(
                                Error,
                                (("FX index of " .. tostring(decipher.actualIdx)) .. " exceeds track FX count of ") .. tostring(totalFxCount)
                            ),
                            0
                        )
                    end
                    fxchainTag = "FXCHAIN"
                end
                local chunk = Chunk.track(track)
                local element = parse(nil, chunk)
                local fxchainarr = nil
                for ____, child in ipairs(element.children) do
                    do
                        if not (child.tag ~= nil) then
                            goto __continue113
                        end
                        if child.tag == fxchainTag then
                            fxchainarr = child
                            break
                        end
                    end
                    ::__continue113::
                end
                if fxchainarr == nil then
                    error(("failed to find <" .. fxchainTag) .. "> element in track chunk data")
                end
                local fxchunks = __TS__ArrayFilter(
                    fxchainarr.children,
                    function(____, x) return x.tag ~= nil end
                )
                return fxchunks[decipher.actualIdx + 1]
            end
        end
        ____cond105 = ____cond105 or ____switch105 == "take"
        if ____cond105 then
            do
                error(
                    __TS__New(Error, "TODO: Implement parsing chunk data of items"),
                    0
                )
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function FX.prototype.parse(self, element)
    if __TS__StringStartsWith(element.tag, "VST") then
        for ____, x in ipairs(element.children) do
            if x.tag ~= nil then
                error(
                    __TS__New(
                        Error,
                        "fx chunk should not contain sub-elements, but found an element: " .. inspect(x)
                    ),
                    0
                )
            end
            if #x ~= 1 then
                error(
                    __TS__New(
                        Error,
                        "fx chunk line should only have 1 element: " .. inspect(x)
                    ),
                    0
                )
            end
        end
        local b64arr = __TS__ArrayMap(
            element.children,
            function(____, x) return x[1] end
        )
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
        if not (fxdataStart + fxdataLength < #alldata) then
            error(
                __TS__New(Error, "fxdata exceeds actual chunk size"),
                0
            )
        end
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
    elseif __TS__StringStartsWith(element.tag, "CLAP") then
        local b64arr = (function()
            for ____, x in ipairs(element.children) do
                if x.tag ~= nil and x.tag == "STATE" then
                    for ____, y in ipairs(x.children) do
                        if y.tag ~= nil then
                            error(
                                __TS__New(
                                    Error,
                                    "clap state element should not contain sub-elements, but found an element: " .. inspect(y)
                                ),
                                0
                            )
                        end
                        if #y ~= 1 then
                            error(
                                __TS__New(
                                    Error,
                                    "fx chunk line should only have 1 element: " .. inspect(y)
                                ),
                                0
                            )
                        end
                    end
                    return __TS__ArrayMap(
                        x.children,
                        function(____, x) return x[1] end
                    )
                end
            end
            error("failed to get CLAP plugin state: " .. inspect(element))
        end)(nil)
        local fxdata = Base64.decode(table.concat(b64arr, ""))
        return {fxdata = fxdata}
    else
        error("this kind of fx chunk is not supported: " .. inspect(element))
    end
end
function FX.prototype.getData(self)
    local ____type = string.upper(self:getType())
    local chunk = nil
    if __TS__StringIncludes(____type, "VST") then
        chunk = self.chain:GetNamedConfigParm(self.fxidx, "vst_chunk")
    elseif __TS__StringIncludes(____type, "CLAP") then
        chunk = self.chain:GetNamedConfigParm(self.fxidx, "clap_chunk")
    else
        return nil
    end
    if chunk ~= nil then
        local arrchunk = self:getElement()
        local ____temp_1 = self:parse(arrchunk)
        local fxdata = ____temp_1.fxdata
        local testchunk = Base64.encode(fxdata)
        if chunk ~= testchunk then
            msgBox(nil, "Debug", "Successfully got chunk data the normal way!\nHowever, the alternative FX chunk parser would have given different output, please debug this!")
        end
    end
    if chunk == nil then
        local arrchunk = self:getElement()
        local ____temp_2 = self:parse(arrchunk)
        local fxdata = ____temp_2.fxdata
        chunk = Base64.encode(fxdata)
    end
    return chunk
end
function FX.prototype.isOffline(self)
    return self.chain:GetOffline(self.fxidx)
end
____exports.FXParam = __TS__Class()
local FXParam = ____exports.FXParam
FXParam.name = "FXParam"
function FXParam.prototype.____constructor(self, target, fxidx, param)
    if target.track ~= nil then
        self.chain = __TS__New(ReaperFXChain, {track = target.track})
    else
        self.chain = __TS__New(ReaperFXChain, {take = target.take})
    end
    self.fxidx = fxidx
    self.param = param
end
function FXParam.prototype._parseParamConfig(self, name, fallback)
    local text = self.chain:GetNamedConfigParm(
        self.fxidx,
        (("param." .. tostring(self.param)) .. ".") .. name
    )
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
        self.chain:SetNamedConfigParm(
            self.fxidx,
            key,
            tostring(value)
        )
    else
        self.chain:SetNamedConfigParm(self.fxidx, key, value and "1" or "0")
    end
end
function FXParam.prototype.getIdent(self)
    local rv = self.chain:GetParamIdent(self.fxidx, self.param)
    if not rv then
        error("param object is no longer valid")
    end
    return rv
end
function FXParam.prototype.getName(self)
    local rv = self.chain:GetParamName(self.fxidx, self.param)
    if not rv then
        error("param object is no longer valid")
    end
    return rv
end
function FXParam.prototype.getValue(self)
    local cur, min, max, mid = table.unpack(self.chain:GetParamEx(self.fxidx, self.param))
    return {cur = cur, min = min, max = max, mid = mid}
end
function FXParam.prototype.setValue(self, value)
    return self.chain:SetParam(self.fxidx, self.param, value)
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
    if track == nil then
        error("failed to get track belonging to last-touched fx: track " .. tostring(trackidx))
    end
    if itemidx == -1 then
        return __TS__New(____exports.FX, {track = track}, fxidx)
    else
        local item = reaper.GetTrackMediaItem(track, itemidx)
        local take = reaper.GetTake(item, takeidx)
        return __TS__New(____exports.FX, {take = take}, fxidx)
    end
end
return ____exports

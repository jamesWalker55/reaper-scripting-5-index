-- Fix import paths
local __script_directory = ({reaper.get_action_context()})[2]:match('^(.+[\\\\//])') .. "?.lua"
package.path = __script_directory .. ";" .. package.path

local ____lualib = require("lualib_bundle")
local __TS__ArrayIsArray = ____lualib.__TS__ArrayIsArray
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local Set = ____lualib.Set
local __TS__ObjectValues = ____lualib.__TS__ObjectValues
local __TS__ArraySome = ____lualib.__TS__ArraySome
local __TS__ArrayPush = ____lualib.__TS__ArrayPush
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local ____exports = {}
local ____json = require("lua_modules.json.index")
local decode = ____json.decode
local ____clipboard = require("lua_modules.reaper-api.clipboard")
local paste = ____clipboard.paste
local ____fx = require("lua_modules.reaper-api.fx")
local getLastTouchedFx = ____fx.getLastTouchedFx
local ____inspect = require("lua_modules.reaper-api.inspect")
local inspect = ____inspect.inspect
local ____utils = require("lua_modules.reaper-api.utils")
local confirmBox = ____utils.confirmBox
local errorHandler = ____utils.errorHandler
local msgBox = ____utils.msgBox
local undoBlock = ____utils.undoBlock
local ____proq = require("proq")
local coerceVSTType = ____proq.coerceVSTType
local convertQ3toQ4 = ____proq.convertQ3toQ4
local convertQ4toQ3 = ____proq.convertQ4toQ3
local getProQType = ____proq.getProQType
local isQ3Band = ____proq.isQ3Band
local isQ4Band = ____proq.isQ4Band
local NOOP_Q3 = ____proq.NOOP_Q3
local NOOP_Q4 = ____proq.NOOP_Q4
local ProQType = ____proq.ProQType
local Q4Feature = ____proq.Q4Feature
local setQ3Band = ____proq.setQ3Band
local setQ4Band = ____proq.setQ4Band

local function isListOfBands(self, x)
    if not __TS__ArrayIsArray(x) then
        return false
    end
    for ____, element in ipairs(x) do
        if not isQ3Band(nil, element) and not isQ4Band(nil, element) then
            return false
        end
    end
    return true
end
local function main(self)
    local fx = getLastTouchedFx(nil)
    if fx == nil then
        return
    end
    local ident = fx:getIdent()
    local ____type = coerceVSTType(
        nil,
        fx:getType()
    )
    local proq = getProQType(nil, ident)
    if proq == nil then
        msgBox(
            nil,
            "Error",
            (("Last touched FX is not a Pro-Q instance!\n\nDebug info:\n" .. inspect(ident)) .. "\n") .. inspect(fx:getType())
        )
        return
    end
    if ____type == nil then
        msgBox(
            nil,
            "Error",
            (("Unsupported plugin type for last touched Pro-Q instance.\n\nDebug info:\n" .. inspect(ident)) .. "\n") .. inspect(fx:getType())
        )
        return
    end
    local data = decode(paste(nil))
    if not __TS__ArrayIsArray(data) then
        msgBox(nil, "Error", "Clipboard does not contain Pro-Q bands data.")
        return
    end
    if not isListOfBands(nil, data) then
        msgBox(nil, "Error", "Clipboard Pro-Q bands data is malformed, please check your clipboard text for errors.")
        return
    end
    while #data < 24 do
        repeat
            local ____switch14 = proq
            local ____cond14 = ____switch14 == ProQType.Q3
            if ____cond14 then
                data[#data + 1] = NOOP_Q3
                break
            end
            ____cond14 = ____cond14 or ____switch14 == ProQType.Q4
            if ____cond14 then
                data[#data + 1] = NOOP_Q4
                break
            end
            do
                local ____ = proq
            end
        until true
    end
    while #data > 24 do
        table.remove(data)
    end
    local UNDO_NAME = "Paste EQ bands to last touched Pro-Q instance"
    local UNDO_FLAG = 2
    repeat
        local ____switch16 = proq
        local ____cond16 = ____switch16 == ProQType.Q3
        if ____cond16 then
            do
                local convertedBatch = __TS__ArrayMap(
                    data,
                    function(____, band) return band.version == 4 and convertQ4toQ3(nil, band) or ({band = band, downgraded = nil}) end
                )
                local downgradedCount = {
                    [Q4Feature.AllPass] = 0,
                    [Q4Feature.AttackRelease] = 0,
                    [Q4Feature.ExternalSidechain] = 0,
                    [Q4Feature.SidechainFiltering] = 0,
                    [Q4Feature.Spectral] = 0
                }
                for ____, ____value in ipairs(convertedBatch) do
                    local downgraded = ____value.downgraded
                    do
                        if downgraded == nil then
                            goto __continue19
                        end
                        if downgraded:has(Q4Feature.AllPass) then
                            local ____downgradedCount_0, ____Q4Feature_AllPass_1 = downgradedCount, Q4Feature.AllPass
                            ____downgradedCount_0[____Q4Feature_AllPass_1] = ____downgradedCount_0[____Q4Feature_AllPass_1] + 1
                        end
                        if downgraded:has(Q4Feature.AttackRelease) then
                            local ____downgradedCount_2, ____Q4Feature_AttackRelease_3 = downgradedCount, Q4Feature.AttackRelease
                            ____downgradedCount_2[____Q4Feature_AttackRelease_3] = ____downgradedCount_2[____Q4Feature_AttackRelease_3] + 1
                        end
                        if downgraded:has(Q4Feature.ExternalSidechain) then
                            local ____downgradedCount_4, ____Q4Feature_ExternalSidechain_5 = downgradedCount, Q4Feature.ExternalSidechain
                            ____downgradedCount_4[____Q4Feature_ExternalSidechain_5] = ____downgradedCount_4[____Q4Feature_ExternalSidechain_5] + 1
                        end
                        if downgraded:has(Q4Feature.SidechainFiltering) then
                            local ____downgradedCount_6, ____Q4Feature_SidechainFiltering_7 = downgradedCount, Q4Feature.SidechainFiltering
                            ____downgradedCount_6[____Q4Feature_SidechainFiltering_7] = ____downgradedCount_6[____Q4Feature_SidechainFiltering_7] + 1
                        end
                        if downgraded:has(Q4Feature.Spectral) then
                            local ____downgradedCount_8, ____Q4Feature_Spectral_9 = downgradedCount, Q4Feature.Spectral
                            ____downgradedCount_8[____Q4Feature_Spectral_9] = ____downgradedCount_8[____Q4Feature_Spectral_9] + 1
                        end
                    end
                    ::__continue19::
                end
                if __TS__ArraySome(
                    __TS__ObjectValues(downgradedCount),
                    function(____, x) return x > 0 end
                ) then
                    local msg = {"Some bands were using Pro-Q4-exclusive features:", ""}
                    if downgradedCount[Q4Feature.AllPass] > 0 then
                        msg[#msg + 1] = "* All-pass bands X " .. tostring(downgradedCount[Q4Feature.AllPass])
                    end
                    if downgradedCount[Q4Feature.AttackRelease] > 0 then
                        msg[#msg + 1] = "* Manual attack/release bands X " .. tostring(downgradedCount[Q4Feature.AttackRelease])
                    end
                    if downgradedCount[Q4Feature.ExternalSidechain] > 0 then
                        msg[#msg + 1] = "* External sidechain bands X " .. tostring(downgradedCount[Q4Feature.ExternalSidechain])
                    end
                    if downgradedCount[Q4Feature.SidechainFiltering] > 0 then
                        msg[#msg + 1] = "* Sidechain filtering bands X " .. tostring(downgradedCount[Q4Feature.SidechainFiltering])
                    end
                    if downgradedCount[Q4Feature.Spectral] > 0 then
                        msg[#msg + 1] = "* Spectral bands X " .. tostring(downgradedCount[Q4Feature.Spectral])
                    end
                    __TS__ArrayPush(msg, "", "These bands will be downgraded upon pasting into the selected Pro-Q3 instance. Proceed?")
                    if not confirmBox(
                        nil,
                        "Some bands will be downgraded",
                        table.concat(msg, "\n")
                    ) then
                        return
                    end
                end
                local bands = __TS__ArrayFilter(
                    __TS__ArrayMap(
                        convertedBatch,
                        function(____, x) return x.band end
                    ),
                    function(____, x) return x ~= nil end
                )
                undoBlock(
                    nil,
                    UNDO_NAME,
                    UNDO_FLAG,
                    function()
                        __TS__ArrayForEach(
                            bands,
                            function(____, band, i) return setQ3Band(nil, fx, i, band) end
                        )
                    end
                )
            end
            break
        end
        ____cond16 = ____cond16 or ____switch16 == ProQType.Q4
        if ____cond16 then
            do
                local bands = __TS__ArrayMap(
                    data,
                    function(____, band) return band.version == 3 and convertQ3toQ4(nil, band) or band end
                )
                undoBlock(
                    nil,
                    UNDO_NAME,
                    UNDO_FLAG,
                    function()
                        __TS__ArrayForEach(
                            bands,
                            function(____, band, i) return setQ4Band(nil, fx, i, band) end
                        )
                    end
                )
            end
            break
        end
        do
            local ____ = proq
        end
    until true
end
errorHandler(nil, main)
return ____exports

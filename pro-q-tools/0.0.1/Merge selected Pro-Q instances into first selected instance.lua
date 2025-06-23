-- Fix import paths
local __script_directory = ({reaper.get_action_context()})[2]:match('^(.+[\\\\//])') .. "?.lua"
package.path = __script_directory .. ";" .. package.path

local ____lualib = require("lualib_bundle")
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArrayFlatMap = ____lualib.__TS__ArrayFlatMap
local Set = ____lualib.Set
local __TS__ObjectValues = ____lualib.__TS__ObjectValues
local __TS__ArraySome = ____lualib.__TS__ArraySome
local __TS__ArrayPush = ____lualib.__TS__ArrayPush
local __TS__ArraySort = ____lualib.__TS__ArraySort
local ____exports = {}
local ____selectedFx = require("lua_modules.reaper-api.selectedFx")
local getSelectedFx = ____selectedFx.getSelectedFx
local ____utils = require("lua_modules.reaper-api.utils")
local confirmBox = ____utils.confirmBox
local errorHandler = ____utils.errorHandler
local msgBox = ____utils.msgBox
local undoBlock = ____utils.undoBlock
local ____proq = require("proq")
local coerceVSTType = ____proq.coerceVSTType
local convertQ3toQ4 = ____proq.convertQ3toQ4
local convertQ4toQ3 = ____proq.convertQ4toQ3
local getBands = ____proq.getBands
local getProQType = ____proq.getProQType
local ProQType = ____proq.ProQType
local Q4Feature = ____proq.Q4Feature
local setQ3Band = ____proq.setQ3Band
local setQ4Band = ____proq.setQ4Band

local function main(self)
    local selectedFx = getSelectedFx(nil)
    local proqs = {}
    for ____, fx in ipairs(selectedFx) do
        do
            local ident = fx:getIdent()
            local ____type = coerceVSTType(
                nil,
                fx:getType()
            )
            local proq = getProQType(nil, ident)
            if proq == nil then
                goto __continue3
            end
            if ____type == nil then
                goto __continue3
            end
            proqs[#proqs + 1] = {fx = fx, ident = ident, type = ____type, proq = proq}
        end
        ::__continue3::
    end
    if #proqs < 2 then
        return
    end
    local targetProq = table.remove(proqs, 1)
    local emptyBands = __TS__ArrayMap(
        __TS__ArrayFilter(
            __TS__ArrayMap(
                getBands(nil, targetProq.fx, targetProq.proq),
                function(____, x, i) return {band = x, idx = i} end
            ),
            function(____, x) return x.band.used < 0.5 end
        ),
        function(____, x) return x.idx end
    )
    local newBands = __TS__ArrayFlatMap(
        proqs,
        function(____, ____bindingPattern0)
            local proq
            local fx
            fx = ____bindingPattern0.fx
            local ident = ____bindingPattern0.ident
            local ____type = ____bindingPattern0.type
            proq = ____bindingPattern0.proq
            return __TS__ArrayFilter(
                getBands(nil, fx, proq),
                function(____, x) return x.used > 0.5 and x.enabled > 0.5 end
            )
        end
    )
    if #newBands > #emptyBands then
        msgBox(
            nil,
            "Failed to merge",
            ((("Too many bands across selected Pro-Q instances!\n\nPro-Q supports a maximum of 24 bands per FX, but the selected instances would add an additional " .. tostring(#newBands)) .. " bands to an instance with only ") .. tostring(#emptyBands)) .. " empty slots left."
        )
        return
    end
    local UNDO_NAME = "Merge selected Pro-Q instances into first selected Pro-Q instance"
    local UNDO_FLAG = 1 | 2
    repeat
        local ____switch14 = targetProq.proq
        local ____cond14 = ____switch14 == ProQType.Q3
        if ____cond14 then
            do
                local convertedBatch = __TS__ArrayMap(
                    newBands,
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
                            goto __continue17
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
                    ::__continue17::
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
                    __TS__ArrayPush(msg, "", "These bands will be downgraded upon merging with the selected Pro-Q3 instance. Proceed?")
                    if not confirmBox(
                        nil,
                        "Some bands will be downgraded",
                        table.concat(msg, "\n")
                    ) then
                        return
                    end
                end
                local convertedBands = __TS__ArrayFilter(
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
                        for ____, band in ipairs(convertedBands) do
                            local targetIdx = table.remove(emptyBands, 1)
                            setQ3Band(nil, targetProq.fx, targetIdx, band)
                        end
                        __TS__ArraySort(
                            proqs,
                            function(____, a, b) return b.fx.fxidx - a.fx.fxidx end
                        )
                        for ____, proq in ipairs(proqs) do
                            proq.fx.chain:Delete(proq.fx.fxidx)
                        end
                    end
                )
            end
            break
        end
        ____cond14 = ____cond14 or ____switch14 == ProQType.Q4
        if ____cond14 then
            do
                local convertedBands = __TS__ArrayMap(
                    newBands,
                    function(____, band) return band.version == 3 and convertQ3toQ4(nil, band) or band end
                )
                undoBlock(
                    nil,
                    UNDO_NAME,
                    UNDO_FLAG,
                    function()
                        for ____, band in ipairs(convertedBands) do
                            local targetIdx = table.remove(emptyBands, 1)
                            setQ4Band(nil, targetProq.fx, targetIdx, band)
                        end
                        __TS__ArraySort(
                            proqs,
                            function(____, a, b) return b.fx.fxidx - a.fx.fxidx end
                        )
                        for ____, proq in ipairs(proqs) do
                            proq.fx.chain:Delete(proq.fx.fxidx)
                        end
                    end
                )
            end
            break
        end
        do
            local ____ = targetProq.proq
        end
    until true
end
errorHandler(nil, main)
return ____exports

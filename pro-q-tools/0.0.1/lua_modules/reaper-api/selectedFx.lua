local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local ____exports = {}
local ____fx = require("lua_modules.reaper-api.fx")
local FX = ____fx.FX
local getLastTouchedFx = ____fx.getLastTouchedFx
local ____utils = require("lua_modules.reaper-api.utils")
local assertUnreachable = ____utils.assertUnreachable
local ensureAPI = ____utils.ensureAPI
ensureAPI(nil, "SWS Extensions", "CF_GetTakeFXChain")
ensureAPI(nil, "SWS Extensions", "CF_GetTrackFXChainEx")
ensureAPI(nil, "SWS Extensions", "CF_EnumSelectedFX")
--- Uses getLastTouchedFx to find the last-touched FX, then the selected FX in that window.
-- 
-- This doesn't support indexing inside containers. If a container is selected, this will
-- simply return the container itself.
function ____exports.getSelectedFx(self)
    local fx = getLastTouchedFx(nil)
    if not fx then
        return {}
    end
    local chain
    local isInputChain = false
    repeat
        local ____switch4 = fx.obj.type
        local ____cond4 = ____switch4 == "take"
        if ____cond4 then
            do
                chain = reaper.CF_GetTakeFXChain(fx.obj.take)
                break
            end
        end
        ____cond4 = ____cond4 or ____switch4 == "track"
        if ____cond4 then
            do
                isInputChain = fx.fxidx & 16777216 ~= 0
                chain = reaper.CF_GetTrackFXChainEx(0, fx.obj.track, isInputChain)
                break
            end
        end
        do
            assertUnreachable(nil, fx.obj)
        end
    until true
    local idx = -1
    local selectedIdx = {}
    while true do
        idx = reaper.CF_EnumSelectedFX(chain, idx)
        if idx == -1 then
            break
        end
        selectedIdx[#selectedIdx + 1] = idx
    end
    return __TS__ArrayMap(
        selectedIdx,
        function(____, idx)
            repeat
                local ____switch10 = fx.obj.type
                local ____cond10 = ____switch10 == "take"
                if ____cond10 then
                    do
                        return __TS__New(FX, {take = fx.obj.take}, idx)
                    end
                end
                ____cond10 = ____cond10 or ____switch10 == "track"
                if ____cond10 then
                    do
                        if isInputChain then
                            return __TS__New(FX, {track = fx.obj.track}, idx + 16777216)
                        else
                            return __TS__New(FX, {track = fx.obj.track}, idx)
                        end
                    end
                end
                do
                    assertUnreachable(nil, fx.obj)
                end
            until true
        end
    )
end
return ____exports

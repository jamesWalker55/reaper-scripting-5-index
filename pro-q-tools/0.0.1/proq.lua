local ____lualib = require("lualib_bundle")
local __TS__ArrayIsArray = ____lualib.__TS__ArrayIsArray
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local Set = ____lualib.Set
local ____exports = {}
____exports.ProQType = ProQType or ({})
____exports.ProQType.Q3 = 0
____exports.ProQType[____exports.ProQType.Q3] = "Q3"
____exports.ProQType.Q4 = 1
____exports.ProQType[____exports.ProQType.Q4] = "Q4"
function ____exports.getProQType(self, ident)
    if (string.find(ident, "FabFilter Pro-Q 3", nil, true) or 0) - 1 ~= -1 then
        return ____exports.ProQType.Q3
    elseif (string.find(ident, "FabFilter Pro-Q 4", nil, true) or 0) - 1 ~= -1 then
        return ____exports.ProQType.Q4
    end
    return nil
end
function ____exports.coerceVSTType(self, ____type)
    repeat
        local ____switch6 = ____type
        local ____cond6 = ____switch6 == "VST"
        if ____cond6 then
            return ____type
        end
        ____cond6 = ____cond6 or ____switch6 == "VST3"
        if ____cond6 then
            return ____type
        end
        do
            return nil
        end
    until true
end
function ____exports.isQ3Band(self, x)
    if type(x) ~= "table" or x == nil then
        return false
    end
    if __TS__ArrayIsArray(x) then
        return false
    end
    return x.version ~= nil and x.version == 3 and x.used ~= nil and type(x.used) == "number" and 0 <= x.used and x.used <= 1 and x.enabled ~= nil and type(x.enabled) == "number" and 0 <= x.enabled and x.enabled <= 1 and x.frequency ~= nil and type(x.frequency) == "number" and 0 <= x.frequency and x.frequency <= 1 and x.gain ~= nil and type(x.gain) == "number" and 0 <= x.gain and x.gain <= 1 and x.dynamic_range ~= nil and type(x.dynamic_range) == "number" and 0 <= x.dynamic_range and x.dynamic_range <= 1 and x.dynamics_enabled ~= nil and type(x.dynamics_enabled) == "number" and 0 <= x.dynamics_enabled and x.dynamics_enabled <= 1 and x.threshold ~= nil and type(x.threshold) == "number" and 0 <= x.threshold and x.threshold <= 1 and x.q ~= nil and type(x.q) == "number" and 0 <= x.q and x.q <= 1 and x.shape ~= nil and type(x.shape) == "number" and 0 <= x.shape and x.shape <= 1 and x.slope ~= nil and type(x.slope) == "number" and 0 <= x.slope and x.slope <= 1 and x.stereo_placement ~= nil and type(x.stereo_placement) == "number" and 0 <= x.stereo_placement and x.stereo_placement <= 1 and x.speakers ~= nil and type(x.speakers) == "number" and 0 <= x.speakers and x.speakers <= 1
end
____exports.NOOP_Q3 = {
    version = 3,
    used = 0,
    enabled = 1,
    frequency = 0.5,
    gain = 0.5,
    dynamic_range = 0.5,
    dynamics_enabled = 0,
    threshold = 1,
    q = 0.5,
    shape = 0,
    slope = 0.5,
    stereo_placement = 0.5,
    speakers = 0
}
--- Index ranges from 0..=23
function ____exports.getQ3Band(self, fx, idx)
    if not (0 <= idx and idx < 24) then
        error(
            __TS__New(
                Error,
                ("Band index " .. tostring(idx)) .. " out of bounds of 0 - 24"
            ),
            0
        )
    end
    local used = fx:getParameter(13 * idx + 0):getValue()
    local enabled = fx:getParameter(13 * idx + 1):getValue()
    local frequency = fx:getParameter(13 * idx + 2):getValue()
    local gain = fx:getParameter(13 * idx + 3):getValue()
    local dynamic_range = fx:getParameter(13 * idx + 4):getValue()
    local dynamics_enabled = fx:getParameter(13 * idx + 5):getValue()
    local threshold = fx:getParameter(13 * idx + 6):getValue()
    local q = fx:getParameter(13 * idx + 7):getValue()
    local shape = fx:getParameter(13 * idx + 8):getValue()
    local slope = fx:getParameter(13 * idx + 9):getValue()
    local stereo_placement = fx:getParameter(13 * idx + 10):getValue()
    local speakers = fx:getParameter(13 * idx + 11):getValue()
    return {
        version = 3,
        used = used.cur,
        enabled = enabled.cur,
        frequency = frequency.cur,
        gain = gain.cur,
        dynamic_range = dynamic_range.cur,
        dynamics_enabled = dynamics_enabled.cur,
        threshold = threshold.cur,
        q = q.cur,
        shape = shape.cur,
        slope = slope.cur,
        stereo_placement = stereo_placement.cur,
        speakers = speakers.cur
    }
end
function ____exports.getQ3Bands(self, fx)
    local bands = {}
    do
        local i = 0
        while i < 24 do
            local band = ____exports.getQ3Band(nil, fx, i)
            bands[#bands + 1] = band
            i = i + 1
        end
    end
    return bands
end
--- Index ranges from 0..=23
function ____exports.setQ3Band(self, fx, idx, band)
    if not (0 <= idx and idx < 24) then
        error(
            __TS__New(
                Error,
                ("Band index " .. tostring(idx)) .. " out of bounds of 0 - 24"
            ),
            0
        )
    end
    fx:getParameter(13 * idx + 0):setValue(band.used)
    fx:getParameter(13 * idx + 1):setValue(band.enabled)
    fx:getParameter(13 * idx + 2):setValue(band.frequency)
    fx:getParameter(13 * idx + 3):setValue(band.gain)
    fx:getParameter(13 * idx + 4):setValue(band.dynamic_range)
    fx:getParameter(13 * idx + 5):setValue(band.dynamics_enabled)
    fx:getParameter(13 * idx + 6):setValue(band.threshold)
    fx:getParameter(13 * idx + 7):setValue(band.q)
    fx:getParameter(13 * idx + 8):setValue(band.shape)
    fx:getParameter(13 * idx + 9):setValue(band.slope)
    fx:getParameter(13 * idx + 10):setValue(band.stereo_placement)
    fx:getParameter(13 * idx + 11):setValue(band.speakers)
end
function ____exports.isQ4Band(self, x)
    if type(x) ~= "table" or x == nil then
        return false
    end
    if __TS__ArrayIsArray(x) then
        return false
    end
    return x.version ~= nil and x.version == 4 and x.used ~= nil and type(x.used) == "number" and 0 <= x.used and x.used <= 1 and x.enabled ~= nil and type(x.enabled) == "number" and 0 <= x.enabled and x.enabled <= 1 and x.frequency ~= nil and type(x.frequency) == "number" and 0 <= x.frequency and x.frequency <= 1 and x.gain ~= nil and type(x.gain) == "number" and 0 <= x.gain and x.gain <= 1 and x.q ~= nil and type(x.q) == "number" and 0 <= x.q and x.q <= 1 and x.shape ~= nil and type(x.shape) == "number" and 0 <= x.shape and x.shape <= 1 and x.slope ~= nil and type(x.slope) == "number" and 0 <= x.slope and x.slope <= 1 and x.stereo_placement ~= nil and type(x.stereo_placement) == "number" and 0 <= x.stereo_placement and x.stereo_placement <= 1 and x.speakers ~= nil and type(x.speakers) == "number" and 0 <= x.speakers and x.speakers <= 1 and x.dynamic_range ~= nil and type(x.dynamic_range) == "number" and 0 <= x.dynamic_range and x.dynamic_range <= 1 and x.dynamics_enabled ~= nil and type(x.dynamics_enabled) == "number" and 0 <= x.dynamics_enabled and x.dynamics_enabled <= 1 and x.dynamics_auto ~= nil and type(x.dynamics_auto) == "number" and 0 <= x.dynamics_auto and x.dynamics_auto <= 1 and x.threshold ~= nil and type(x.threshold) == "number" and 0 <= x.threshold and x.threshold <= 1 and x.attack ~= nil and type(x.attack) == "number" and 0 <= x.attack and x.attack <= 1 and x.release ~= nil and type(x.release) == "number" and 0 <= x.release and x.release <= 1 and x.external_side_chain ~= nil and type(x.external_side_chain) == "number" and 0 <= x.external_side_chain and x.external_side_chain <= 1 and x.side_chain_filtering ~= nil and type(x.side_chain_filtering) == "number" and 0 <= x.side_chain_filtering and x.side_chain_filtering <= 1 and x.side_chain_low_frequency ~= nil and type(x.side_chain_low_frequency) == "number" and 0 <= x.side_chain_low_frequency and x.side_chain_low_frequency <= 1 and x.side_chain_high_frequency ~= nil and type(x.side_chain_high_frequency) == "number" and 0 <= x.side_chain_high_frequency and x.side_chain_high_frequency <= 1 and x.spectral_enabled ~= nil and type(x.spectral_enabled) == "number" and 0 <= x.spectral_enabled and x.spectral_enabled <= 1 and x.spectral_density ~= nil and type(x.spectral_density) == "number" and 0 <= x.spectral_density and x.spectral_density <= 1
end
____exports.NOOP_Q4 = {
    version = 4,
    used = 0,
    enabled = 1,
    frequency = 0.5,
    gain = 0.5,
    q = 0.5,
    shape = 0,
    slope = 0.5,
    stereo_placement = 0.5,
    speakers = 0,
    dynamic_range = 0.5,
    dynamics_enabled = 0,
    dynamics_auto = 1,
    threshold = 1,
    attack = 0.5,
    release = 0.5,
    external_side_chain = 0,
    side_chain_filtering = 0,
    side_chain_low_frequency = 0,
    side_chain_high_frequency = 1,
    spectral_enabled = 0,
    spectral_density = 0.5
}
--- Index ranges from 0..=23
function ____exports.getQ4Band(self, fx, idx)
    if not (0 <= idx and idx < 24) then
        error(
            __TS__New(
                Error,
                ("Band index " .. tostring(idx)) .. " out of bounds of 0 - 24"
            ),
            0
        )
    end
    local used = fx:getParameter(23 * idx + 0):getValue()
    local enabled = fx:getParameter(23 * idx + 1):getValue()
    local frequency = fx:getParameter(23 * idx + 2):getValue()
    local gain = fx:getParameter(23 * idx + 3):getValue()
    local q = fx:getParameter(23 * idx + 4):getValue()
    local shape = fx:getParameter(23 * idx + 5):getValue()
    local slope = fx:getParameter(23 * idx + 6):getValue()
    local stereo_placement = fx:getParameter(23 * idx + 7):getValue()
    local speakers = fx:getParameter(23 * idx + 8):getValue()
    local dynamic_range = fx:getParameter(23 * idx + 9):getValue()
    local dynamics_enabled = fx:getParameter(23 * idx + 10):getValue()
    local dynamics_auto = fx:getParameter(23 * idx + 11):getValue()
    local threshold = fx:getParameter(23 * idx + 12):getValue()
    local attack = fx:getParameter(23 * idx + 13):getValue()
    local release = fx:getParameter(23 * idx + 14):getValue()
    local external_side_chain = fx:getParameter(23 * idx + 15):getValue()
    local side_chain_filtering = fx:getParameter(23 * idx + 16):getValue()
    local side_chain_low_frequency = fx:getParameter(23 * idx + 17):getValue()
    local side_chain_high_frequency = fx:getParameter(23 * idx + 18):getValue()
    local spectral_enabled = fx:getParameter(23 * idx + 20):getValue()
    local spectral_density = fx:getParameter(23 * idx + 21):getValue()
    return {
        version = 4,
        used = used.cur,
        enabled = enabled.cur,
        frequency = frequency.cur,
        gain = gain.cur,
        q = q.cur,
        shape = shape.cur,
        slope = slope.cur,
        stereo_placement = stereo_placement.cur,
        speakers = speakers.cur,
        dynamic_range = dynamic_range.cur,
        dynamics_enabled = dynamics_enabled.cur,
        dynamics_auto = dynamics_auto.cur,
        threshold = threshold.cur,
        attack = attack.cur,
        release = release.cur,
        external_side_chain = external_side_chain.cur,
        side_chain_filtering = side_chain_filtering.cur,
        side_chain_low_frequency = side_chain_low_frequency.cur,
        side_chain_high_frequency = side_chain_high_frequency.cur,
        spectral_enabled = spectral_enabled.cur,
        spectral_density = spectral_density.cur
    }
end
function ____exports.getQ4Bands(self, fx)
    local bands = {}
    do
        local i = 0
        while i < 24 do
            local band = ____exports.getQ4Band(nil, fx, i)
            bands[#bands + 1] = band
            i = i + 1
        end
    end
    return bands
end
--- Index ranges from 0..=23
function ____exports.setQ4Band(self, fx, idx, band)
    if not (0 <= idx and idx < 24) then
        error(
            __TS__New(
                Error,
                ("Band index " .. tostring(idx)) .. " out of bounds of 0 - 24"
            ),
            0
        )
    end
    fx:getParameter(23 * idx + 0):setValue(band.used)
    fx:getParameter(23 * idx + 1):setValue(band.enabled)
    fx:getParameter(23 * idx + 2):setValue(band.frequency)
    fx:getParameter(23 * idx + 3):setValue(band.gain)
    fx:getParameter(23 * idx + 4):setValue(band.q)
    fx:getParameter(23 * idx + 5):setValue(band.shape)
    fx:getParameter(23 * idx + 6):setValue(band.slope)
    fx:getParameter(23 * idx + 7):setValue(band.stereo_placement)
    fx:getParameter(23 * idx + 8):setValue(band.speakers)
    fx:getParameter(23 * idx + 9):setValue(band.dynamic_range)
    fx:getParameter(23 * idx + 10):setValue(band.dynamics_enabled)
    fx:getParameter(23 * idx + 11):setValue(band.dynamics_auto)
    fx:getParameter(23 * idx + 12):setValue(band.threshold)
    fx:getParameter(23 * idx + 13):setValue(band.attack)
    fx:getParameter(23 * idx + 14):setValue(band.release)
    fx:getParameter(23 * idx + 15):setValue(band.external_side_chain)
    fx:getParameter(23 * idx + 16):setValue(band.side_chain_filtering)
    fx:getParameter(23 * idx + 17):setValue(band.side_chain_low_frequency)
    fx:getParameter(23 * idx + 18):setValue(band.side_chain_high_frequency)
    fx:getParameter(23 * idx + 20):setValue(band.spectral_enabled)
    fx:getParameter(23 * idx + 21):setValue(band.spectral_density)
end
function ____exports.getBands(self, fx, qtype)
    repeat
        local ____switch28 = qtype
        local ____cond28 = ____switch28 == ____exports.ProQType.Q3
        if ____cond28 then
            do
                return ____exports.getQ3Bands(nil, fx)
            end
        end
        ____cond28 = ____cond28 or ____switch28 == ____exports.ProQType.Q4
        if ____cond28 then
            do
                return ____exports.getQ4Bands(nil, fx)
            end
        end
        do
            return qtype
        end
    until true
end
function ____exports.convertQ3toQ4(self, band)
    return {
        version = 4,
        used = band.used,
        enabled = band.enabled,
        frequency = band.frequency,
        gain = band.gain,
        q = band.q,
        shape = band.shape * 8 / 9,
        slope = band.slope * 0.9 + 0.1,
        stereo_placement = band.stereo_placement,
        speakers = band.speakers,
        dynamic_range = band.dynamic_range,
        dynamics_enabled = band.dynamics_enabled,
        dynamics_auto = band.threshold < 1 and 0 or 1,
        threshold = band.threshold,
        attack = 0.5,
        release = 0.5,
        external_side_chain = 0,
        side_chain_filtering = 0,
        side_chain_low_frequency = 0,
        side_chain_high_frequency = 1,
        spectral_enabled = 0,
        spectral_density = 0.5
    }
end
____exports.Q4Feature = Q4Feature or ({})
____exports.Q4Feature.AllPass = 0
____exports.Q4Feature[____exports.Q4Feature.AllPass] = "AllPass"
____exports.Q4Feature.AttackRelease = 1
____exports.Q4Feature[____exports.Q4Feature.AttackRelease] = "AttackRelease"
____exports.Q4Feature.ExternalSidechain = 2
____exports.Q4Feature[____exports.Q4Feature.ExternalSidechain] = "ExternalSidechain"
____exports.Q4Feature.SidechainFiltering = 3
____exports.Q4Feature[____exports.Q4Feature.SidechainFiltering] = "SidechainFiltering"
____exports.Q4Feature.Spectral = 4
____exports.Q4Feature[____exports.Q4Feature.Spectral] = "Spectral"
function ____exports.convertQ4toQ3(self, band)
    local downgraded = __TS__New(Set)
    if band.shape == 1 then
        downgraded:add(____exports.Q4Feature.AllPass)
        return {band = nil, downgraded = downgraded}
    end
    if band.attack ~= 0.5 then
        downgraded:add(____exports.Q4Feature.AttackRelease)
    end
    if band.release ~= 0.5 then
        downgraded:add(____exports.Q4Feature.AttackRelease)
    end
    if band.external_side_chain ~= 0 then
        downgraded:add(____exports.Q4Feature.ExternalSidechain)
    end
    if band.side_chain_filtering > 0.5 then
        downgraded:add(____exports.Q4Feature.SidechainFiltering)
    end
    if band.spectral_enabled > 0.5 then
        downgraded:add(____exports.Q4Feature.Spectral)
    end
    return {band = {
        version = 3,
        used = band.used,
        enabled = band.enabled,
        frequency = band.frequency,
        gain = band.gain,
        dynamic_range = band.dynamic_range,
        dynamics_enabled = band.dynamics_enabled,
        threshold = band.dynamics_auto > 0.5 and 1 or band.threshold,
        q = band.q,
        shape = band.shape * 9 / 8,
        slope = (band.slope - 0.1) / 0.9,
        stereo_placement = band.stereo_placement,
        speakers = band.speakers
    }, downgraded = downgraded}
end
return ____exports

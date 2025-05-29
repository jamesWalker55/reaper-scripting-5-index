local ____lualib = require("lualib_bundle")
local __TS__ObjectDefineProperty = ____lualib.__TS__ObjectDefineProperty
local __TS__ObjectEntries = ____lualib.__TS__ObjectEntries
local ____exports = {}
local JSON = require("lua_modules.reaper-api.lua_modules.json.index")
--- Set a ext state. Defaults to permanent.
-- 
-- WARNING: An empty string is the same as setting as null!
function ____exports.set(self, section, key, value, permanent)
    if permanent == nil then
        permanent = true
    end
    if value == nil or #value == 0 then
        reaper.DeleteExtState(section, key, permanent)
    else
        reaper.SetExtState(section, key, value, permanent)
    end
end
--- This returns a string or null.
-- 
-- Conditions for returning null:
-- - key is not set
-- - key is set to an empty string (length 0)
function ____exports.get(self, section, key)
    local rv = reaper.GetExtState(section, key)
    if #rv == 0 then
        return nil
    end
    return rv
end
--- Check if the key is set, even if the value is an empty string `""`.
-- 
-- @deprecated The other functions `set` and `get` treat `""` the same
-- as 'key not set', so this function is an outlier.
function ____exports.has(self, section, key)
    return reaper.HasExtState(section, key)
end
--- Wrapper around a section for easier usage.
function ____exports.Section(self, section)
    return {
        set = function(self, key, value, permanent)
            ____exports.set(
                nil,
                section,
                key,
                value,
                permanent
            )
        end,
        get = function(self, key)
            return ____exports.get(nil, section, key)
        end
    }
end
local SETTERS = {
    string = function(self, section, key, permanent)
        return function(____, value) return ____exports.set(
            nil,
            section,
            key,
            value,
            permanent
        ) end
    end,
    number = function(self, section, key, permanent)
        return function(____, value)
            local ____exports_set_4 = ____exports.set
            local ____section_2 = section
            local ____key_3 = key
            local ____opt_0 = value
            return ____exports_set_4(
                nil,
                ____section_2,
                ____key_3,
                ____opt_0 and tostring(value) or nil,
                permanent
            )
        end
    end,
    json = function(self, section, key, permanent)
        return function(____, value)
            local ____exports_set_8 = ____exports.set
            local ____section_6 = section
            local ____key_7 = key
            local ____temp_5
            if value == nil or value == nil then
                ____temp_5 = nil
            else
                ____temp_5 = JSON.encode(value)
            end
            return ____exports_set_8(
                nil,
                ____section_6,
                ____key_7,
                ____temp_5,
                permanent
            )
        end
    end
}
local GETTERS = {
    string = function(self, section, key)
        return function() return ____exports.get(nil, section, key) end
    end,
    number = function(self, section, key)
        return function() return tonumber(____exports.get(nil, section, key)) or nil end
    end,
    json = function(self, section, key)
        return function()
            local text = ____exports.get(nil, section, key)
            if text == nil then
                return nil
            end
            return JSON.decode(text)
        end
    end
}
function ____exports.TypedSection(self, section, config)
    local rv = {}
    for ____, ____value in ipairs(__TS__ObjectEntries(config)) do
        local key = ____value[1]
        local value = ____value[2]
        __TS__ObjectDefineProperty(
            rv,
            key,
            {
                get = GETTERS[value](GETTERS, section, key),
                set = SETTERS[value](SETTERS, section, key, true)
            }
        )
    end
    return rv
end
return ____exports

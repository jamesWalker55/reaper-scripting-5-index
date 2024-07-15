--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local json = require("lua_modules.reaper-microui.node_modules.json.index")
____exports.HASH_INITIAL = 2166136261
function ____exports.hashString(self, h, data)
    do
        local i = 0
        while i < #data do
            local byte = string.byte(data, i + 1)
            h = (h ~ byte) * 16777619
            i = i + 1
        end
    end
    return h
end
--- Generate a consistent hash based on an initial ID and some data.
-- The same ID-data pair should return the same hash.
-- 
-- https://en.wikipedia.org/wiki/Fowler%E2%80%93Noll%E2%80%93Vo_hash_function
function ____exports.hashObject(self, h, data)
    return ____exports.hashString(
        nil,
        h,
        json.encode(data)
    )
end
return ____exports

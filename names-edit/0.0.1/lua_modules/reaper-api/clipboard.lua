--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____utils = require("lua_modules.reaper-api.utils")
local ensureAPI = ____utils.ensureAPI
ensureAPI(nil, "SWS Extensions", "CF_SetClipboard")
ensureAPI(nil, "SWS Extensions", "CF_GetClipboard")
function ____exports.copy(self, text)
    reaper.CF_SetClipboard(text)
end
function ____exports.paste(self)
    return reaper.CF_GetClipboard()
end
return ____exports

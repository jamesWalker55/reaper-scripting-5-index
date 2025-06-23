--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____utils = require("lua_modules.reaper-api.utils")
local ensureAPI = ____utils.ensureAPI
local apiChecked = false
local function checkAPI(self)
    if apiChecked then
        return
    end
    ensureAPI(nil, "SWS Extensions", "CF_SetClipboard")
    ensureAPI(nil, "SWS Extensions", "CF_GetClipboard")
    apiChecked = true
end
function ____exports.copy(self, text)
    checkAPI(nil)
    reaper.CF_SetClipboard(text)
end
function ____exports.paste(self)
    checkAPI(nil)
    return reaper.CF_GetClipboard()
end
return ____exports

--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
--- Create a temporary PCM source and destroy it once the function returns.
function ____exports.withPcmSource(self, path, func)
    local source = reaper.PCM_Source_CreateFromFile(path)
    local ____error = nil
    local rv
    do
        local function ____catch(e)
            ____error = e
            rv = nil
        end
        local ____try, ____hasReturned = pcall(function()
            rv = func(nil, source)
        end)
        if not ____try then
            ____catch(____hasReturned)
        end
    end
    reaper.PCM_Source_Destroy(source)
    if ____error ~= nil then
        error(____error, 0)
    end
    return rv
end
function ____exports.getTimeSelection(self)
    local start, ____end = reaper.GetSet_LoopTimeRange2(
        0,
        false,
        false,
        0,
        0,
        false
    )
    return {start, ____end}
end
function ____exports.setTimeSelection(self, start, ____end)
    reaper.GetSet_LoopTimeRange2(
        0,
        true,
        false,
        start,
        ____end,
        false
    )
end
--- Save the current time selection and restore it once the function returns.
function ____exports.withSavedTimeSelection(self, func)
    local start, ____end = table.unpack(____exports.getTimeSelection(nil))
    local ____error = nil
    local rv
    do
        local function ____catch(e)
            ____error = e
            rv = nil
        end
        local ____try, ____hasReturned = pcall(function()
            rv = func(nil, start, ____end)
        end)
        if not ____try then
            ____catch(____hasReturned)
        end
    end
    ____exports.setTimeSelection(nil, start, ____end)
    if ____error ~= nil then
        error(____error, 0)
    end
    return rv
end
return ____exports

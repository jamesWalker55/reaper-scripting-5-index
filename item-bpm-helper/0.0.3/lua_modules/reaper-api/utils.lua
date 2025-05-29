local ____lualib = require("lualib_bundle")
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__Promise = ____lualib.__TS__Promise
local __TS__ParseInt = ____lualib.__TS__ParseInt
local ____exports = {}
local stringOrInspect
local ____inspect = require("lua_modules.reaper-api.inspect")
local inspect = ____inspect.inspect
local path = require("lua_modules.reaper-api.path.path")
function ____exports.log(self, ...)
    local args = {...}
    do
        local i = 0
        while i < #args do
            if i ~= 0 then
                reaper.ShowConsoleMsg("\t")
            end
            local msg = args[i + 1]
            if type(msg) ~= "string" then
                msg = inspect(msg)
            end
            if msg == "" then
            else
                reaper.ShowConsoleMsg(msg)
            end
            i = i + 1
        end
    end
    reaper.ShowConsoleMsg("\n")
end
function ____exports.msgBox(self, title, msg)
    reaper.ShowMessageBox(msg, title, 0)
end
function stringOrInspect(self, obj)
    if type(obj) == "string" then
        return obj
    else
        return inspect(obj)
    end
end
function ____exports.processError(self, e)
    local name = "error"
    local msg = nil
    local stack = nil
    if type(e) == "table" and e ~= nil then
        if e.message ~= nil then
            msg = stringOrInspect(nil, e.message)
        end
        if e.name ~= nil then
            name = stringOrInspect(nil, e.name)
        end
        if e.stack ~= nil then
            stack = stringOrInspect(nil, e.stack)
        end
    else
        msg = stringOrInspect(nil, e)
    end
    return {
        name = name,
        msg = msg,
        stack = stack,
        print = function(self)
            if msg == nil then
                ____exports.log(nil, "error: " .. name)
            else
                ____exports.log(nil, (name .. ": ") .. msg)
            end
            if stack ~= nil then
                ____exports.log(nil, stack)
            end
        end,
        raise = function(self)
            if msg == nil then
                error("error: " .. name)
            else
                error((name .. ": ") .. msg)
            end
        end
    }
end
function ____exports.errorHandler(self, func)
    do
        local function ____catch(e)
            local err = ____exports.processError(nil, e)
            err:print()
            err:raise()
        end
        local ____try, ____hasReturned = pcall(function()
            local rv = func(nil)
            if rv then
                rv:catch(function(____, e)
                    local err = ____exports.processError(nil, e)
                    err:print()
                    err:raise()
                end)
            end
        end)
        if not ____try then
            ____catch(____hasReturned)
        end
    end
end
function ____exports.ensureAPI(self, source, functionName)
    if reaper.APIExists(functionName) then
        return
    end
    local msg = ((source .. " is required for this script to work! (missing function: ") .. functionName) .. ")"
    ____exports.msgBox(nil, "Missing extensions", msg)
    error(
        __TS__New(Error, msg),
        0
    )
end
function ____exports.clearConsole(self)
    reaper.ShowConsoleMsg("")
end
function ____exports.deferLoop(self, func, cleanup)
    local shouldStop = false
    local function stop(self)
        shouldStop = true
    end
    local function inner()
        do
            local function ____catch(e)
                return true
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                ____exports.errorHandler(
                    nil,
                    function() return func(nil, stop) end
                )
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
        if shouldStop then
            if cleanup ~= nil then
                do
                    local function ____catch(e)
                        return true
                    end
                    local ____try, ____hasReturned, ____returnValue = pcall(function()
                        ____exports.errorHandler(
                            nil,
                            function() return cleanup(nil) end
                        )
                    end)
                    if not ____try then
                        ____hasReturned, ____returnValue = ____catch(____hasReturned)
                    end
                    if ____hasReturned then
                        return ____returnValue
                    end
                end
            end
            return
        end
        reaper.defer(inner)
    end
    inner()
end
function ____exports.deferAsync(self)
    return __TS__New(
        __TS__Promise,
        function(____, resolve) return reaper.defer(function() return resolve(nil, nil) end) end
    )
end
function ____exports.confirmBox(self, title, msg)
    local rv = reaper.ShowMessageBox(msg, title, 4)
    return rv == 6
end
--- flags: (from https://forum.cockos.com/showthread.php?t=185118)
-- ```plain
-- -1: All undo info
-- 0: ???? When only calling actions via OnCommand, since these create their own undo points
-- 1: track configurations (track/master vol/pan/routing, ALL envelopes (master included))
-- 2: track/master FX
-- 4: track items
-- 8: project states (loop selection, markers, regions)
-- 16: freeze states
-- ```
function ____exports.undoBlock(self, desc, flags, func)
    reaper.Undo_BeginBlock2(0)
    reaper.PreventUIRefresh(1)
    local ____error = nil
    do
        local function ____catch(e)
            ____error = e
        end
        local ____try, ____hasReturned = pcall(function()
            local config = func(nil)
            if config and config.desc ~= nil then
                desc = config.desc
            end
            if config and config.flags ~= nil then
                flags = config.flags
            end
        end)
        if not ____try then
            ____catch(____hasReturned)
        end
    end
    reaper.PreventUIRefresh(-1)
    reaper.Undo_EndBlock2(0, desc, flags)
    if ____error ~= nil then
        error(____error, 0)
    end
end
function ____exports.assertUnreachable(self, x)
    error(
        __TS__New(Error, "Didn't expect to get here"),
        0
    )
end
function ____exports.readFile(self, path)
    local f, err = io.open(path, "rb")
    if f == nil then
        error(
            __TS__New(Error, err),
            0
        )
    end
    local content = f:read("*all")
    f:close()
    if type(content) ~= "string" then
        error(
            __TS__New(Error, "file read returned nonstring value"),
            0
        )
    end
    return content
end
function ____exports.writeFile(self, path, text)
    local f, err = io.open(path, "w")
    if f == nil then
        error(
            __TS__New(Error, err),
            0
        )
    end
    f:write(text)
    f:close()
end
function ____exports.getReaperVersion(self)
    local match = {string.match(
        reaper.GetAppVersion(),
        "^(%d+).(%d+)"
    )}
    if #match == 0 then
        return nil
    end
    local major, minor = table.unpack(match)
    return {
        major = __TS__ParseInt(major),
        minor = __TS__ParseInt(minor)
    }
end
function ____exports.getReaperDataFile(self, filename)
    local parentDir = reaper.GetResourcePath()
    if filename then
        return path.normpath(path.join(parentDir, filename))
    else
        return path.normpath(parentDir)
    end
end
function ____exports.runMainAction(self, action, project)
    if type(action) == "string" then
        action = reaper.NamedCommandLookup(action)
    end
    reaper.Main_OnCommandEx(action, 0, project or 0)
end
function ____exports.runMidiAction(self, action, target)
    if type(action) == "string" then
        action = reaper.NamedCommandLookup(action)
    end
    if target ~= nil and target.hwnd ~= nil then
        reaper.MIDIEditor_OnCommand(target.hwnd, action)
    else
        reaper.MIDIEditor_LastFocused_OnCommand(action, target and target.listview or false)
    end
end
function ____exports.getActionContext(self)
    local is_new_value, filename, sectionID, cmdID, mode, resolution, val, contextstr = reaper.get_action_context()
    local ____temp_2
    if sectionID == -1 then
        ____temp_2 = nil
    else
        ____temp_2 = {sectionID = sectionID, cmdID = cmdID}
    end
    local action = ____temp_2
    return {filename = filename, action = action}
end
return ____exports

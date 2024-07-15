local ____lualib = require("lualib_bundle")
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local ____exports = {}
function ____exports.msgBox(self, title, msg)
    return reaper.ShowMessageBox(msg, title, 0)
end
function ____exports.ensureAPI(self, source, functionName)
    if reaper.APIExists(functionName) then
        return
    end
    local msg = ((source .. " is required for this script to work! (missing function: ") .. functionName) .. ")"
    ____exports.msgBox(nil, "Missing extensions", msg)
    error(msg)
end
function ____exports.log(self, msg)
    msg = tostring(msg)
    if msg == "" then
    else
        reaper.ShowConsoleMsg(msg)
    end
    reaper.ShowConsoleMsg("\n")
end
function ____exports.clearConsole(self)
    reaper.ShowConsoleMsg("")
end
function ____exports.deferLoop(self, func)
    local shouldStop = false
    local function stop(self)
        shouldStop = true
    end
    local function inner()
        func(nil, stop)
        if shouldStop then
            return
        end
        reaper.defer(inner)
    end
    inner()
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
function ____exports.undoBlock(self, func)
    reaper.Undo_BeginBlock2(0)
    reaper.PreventUIRefresh(1)
    local config = func(nil)
    reaper.PreventUIRefresh(-1)
    reaper.Undo_EndBlock2(0, config.desc, config.flags)
end
--- return a path relative to the current Reaper data folder. Example:
-- ```
-- absPath("reaper-fxfolders.ini")
-- // C:\Users\Bob\AppData\Roaming\REAPER\reaper-fxfolders.ini
-- ```
-- 
-- @param relPath
function ____exports.absPath(self, relPath)
    if (relPath and relPath.length) == 0 then
        relPath = nil
    end
    local reaperIniPath = reaper.get_ini_file()
    local reaperBaseDir = (string.match(reaperIniPath, "^(.+[\\/])"))
    return reaperBaseDir .. tostring(relPath)
end
function ____exports.assertUnreachable(self, x)
    error(
        __TS__New(Error, "Didn't expect to get here"),
        0
    )
end
return ____exports

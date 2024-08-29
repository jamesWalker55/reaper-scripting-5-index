--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]

local ____modules = {}
local ____moduleCache = {}
local ____originalRequire = require
local function require(file, ...)
    if ____moduleCache[file] then
        return ____moduleCache[file].value
    end
    if ____modules[file] then
        local module = ____modules[file]
        local value = nil
        if (select("#", ...) > 0) then value = module(...) else value = module(file) end
        ____moduleCache[file] = { value = value }
        return value
    else
        if ____originalRequire then
            return ____originalRequire(file)
        else
            error("module '" .. file .. "' not found")
        end
    end
end
____modules = {
["lualib_bundle"] = function(...) 
local function __TS__StringIncludes(self, searchString, position)
    if not position then
        position = 1
    else
        position = position + 1
    end
    local index = string.find(self, searchString, position, true)
    return index ~= nil
end

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local function __TS__ClassExtends(target, base)
    target.____super = base
    local staticMetatable = setmetatable({__index = base}, base)
    setmetatable(target, staticMetatable)
    local baseMetatable = getmetatable(base)
    if baseMetatable then
        if type(baseMetatable.__index) == "function" then
            staticMetatable.__index = baseMetatable.__index
        end
        if type(baseMetatable.__newindex) == "function" then
            staticMetatable.__newindex = baseMetatable.__newindex
        end
    end
    setmetatable(target.prototype, base.prototype)
    if type(base.prototype.__index) == "function" then
        target.prototype.__index = base.prototype.__index
    end
    if type(base.prototype.__newindex) == "function" then
        target.prototype.__newindex = base.prototype.__newindex
    end
    if type(base.prototype.__tostring) == "function" then
        target.prototype.__tostring = base.prototype.__tostring
    end
end

local Error, RangeError, ReferenceError, SyntaxError, TypeError, URIError
do
    local function getErrorStack(self, constructor)
        if debug == nil then
            return nil
        end
        local level = 1
        while true do
            local info = debug.getinfo(level, "f")
            level = level + 1
            if not info then
                level = 1
                break
            elseif info.func == constructor then
                break
            end
        end
        if __TS__StringIncludes(_VERSION, "Lua 5.0") then
            return debug.traceback(("[Level " .. tostring(level)) .. "]")
        else
            return debug.traceback(nil, level)
        end
    end
    local function wrapErrorToString(self, getDescription)
        return function(self)
            local description = getDescription(self)
            local caller = debug.getinfo(3, "f")
            local isClassicLua = __TS__StringIncludes(_VERSION, "Lua 5.0") or _VERSION == "Lua 5.1"
            if isClassicLua or caller and caller.func ~= error then
                return description
            else
                return (description .. "\n") .. tostring(self.stack)
            end
        end
    end
    local function initErrorClass(self, Type, name)
        Type.name = name
        return setmetatable(
            Type,
            {__call = function(____, _self, message) return __TS__New(Type, message) end}
        )
    end
    local ____initErrorClass_1 = initErrorClass
    local ____class_0 = __TS__Class()
    ____class_0.name = ""
    function ____class_0.prototype.____constructor(self, message)
        if message == nil then
            message = ""
        end
        self.message = message
        self.name = "Error"
        self.stack = getErrorStack(nil, self.constructor.new)
        local metatable = getmetatable(self)
        if metatable and not metatable.__errorToStringPatched then
            metatable.__errorToStringPatched = true
            metatable.__tostring = wrapErrorToString(nil, metatable.__tostring)
        end
    end
    function ____class_0.prototype.__tostring(self)
        return self.message ~= "" and (self.name .. ": ") .. self.message or self.name
    end
    Error = ____initErrorClass_1(nil, ____class_0, "Error")
    local function createErrorClass(self, name)
        local ____initErrorClass_3 = initErrorClass
        local ____class_2 = __TS__Class()
        ____class_2.name = ____class_2.name
        __TS__ClassExtends(____class_2, Error)
        function ____class_2.prototype.____constructor(self, ...)
            ____class_2.____super.prototype.____constructor(self, ...)
            self.name = name
        end
        return ____initErrorClass_3(nil, ____class_2, name)
    end
    RangeError = createErrorClass(nil, "RangeError")
    ReferenceError = createErrorClass(nil, "ReferenceError")
    SyntaxError = createErrorClass(nil, "SyntaxError")
    TypeError = createErrorClass(nil, "TypeError")
    URIError = createErrorClass(nil, "URIError")
end

local function __TS__StringSlice(self, start, ____end)
    if start == nil or start ~= start then
        start = 0
    end
    if ____end ~= ____end then
        ____end = 0
    end
    if start >= 0 then
        start = start + 1
    end
    if ____end ~= nil and ____end < 0 then
        ____end = ____end - 1
    end
    return string.sub(self, start, ____end)
end

local function __TS__StringTrim(self)
    local result = string.gsub(self, "^[%s ﻿]*(.-)[%s ﻿]*$", "%1")
    return result
end

local function __TS__ArrayReverse(self)
    local i = 1
    local j = #self
    while i < j do
        local temp = self[j]
        self[j] = self[i]
        self[i] = temp
        i = i + 1
        j = j - 1
    end
    return self
end

local __TS__Symbol, Symbol
do
    local symbolMetatable = {__tostring = function(self)
        return ("Symbol(" .. (self.description or "")) .. ")"
    end}
    function __TS__Symbol(description)
        return setmetatable({description = description}, symbolMetatable)
    end
    Symbol = {
        asyncDispose = __TS__Symbol("Symbol.asyncDispose"),
        dispose = __TS__Symbol("Symbol.dispose"),
        iterator = __TS__Symbol("Symbol.iterator"),
        hasInstance = __TS__Symbol("Symbol.hasInstance"),
        species = __TS__Symbol("Symbol.species"),
        toStringTag = __TS__Symbol("Symbol.toStringTag")
    }
end

local function __TS__InstanceOf(obj, classTbl)
    if type(classTbl) ~= "table" then
        error("Right-hand side of 'instanceof' is not an object", 0)
    end
    if classTbl[Symbol.hasInstance] ~= nil then
        return not not classTbl[Symbol.hasInstance](classTbl, obj)
    end
    if type(obj) == "table" then
        local luaClass = obj.constructor
        while luaClass ~= nil do
            if luaClass == classTbl then
                return true
            end
            luaClass = luaClass.____super
        end
    end
    return false
end

local __TS__Promise
do
    local function makeDeferredPromiseFactory()
        local resolve
        local reject
        local function executor(____, res, rej)
            resolve = res
            reject = rej
        end
        return function()
            local promise = __TS__New(__TS__Promise, executor)
            return promise, resolve, reject
        end
    end
    local makeDeferredPromise = makeDeferredPromiseFactory()
    local function isPromiseLike(value)
        return __TS__InstanceOf(value, __TS__Promise)
    end
    local function doNothing(self)
    end
    local ____pcall = _G.pcall
    __TS__Promise = __TS__Class()
    __TS__Promise.name = "__TS__Promise"
    function __TS__Promise.prototype.____constructor(self, executor)
        self.state = 0
        self.fulfilledCallbacks = {}
        self.rejectedCallbacks = {}
        self.finallyCallbacks = {}
        local success, ____error = ____pcall(
            executor,
            nil,
            function(____, v) return self:resolve(v) end,
            function(____, err) return self:reject(err) end
        )
        if not success then
            self:reject(____error)
        end
    end
    function __TS__Promise.resolve(value)
        if __TS__InstanceOf(value, __TS__Promise) then
            return value
        end
        local promise = __TS__New(__TS__Promise, doNothing)
        promise.state = 1
        promise.value = value
        return promise
    end
    function __TS__Promise.reject(reason)
        local promise = __TS__New(__TS__Promise, doNothing)
        promise.state = 2
        promise.rejectionReason = reason
        return promise
    end
    __TS__Promise.prototype["then"] = function(self, onFulfilled, onRejected)
        local promise, resolve, reject = makeDeferredPromise()
        self:addCallbacks(
            onFulfilled and self:createPromiseResolvingCallback(onFulfilled, resolve, reject) or resolve,
            onRejected and self:createPromiseResolvingCallback(onRejected, resolve, reject) or reject
        )
        return promise
    end
    function __TS__Promise.prototype.addCallbacks(self, fulfilledCallback, rejectedCallback)
        if self.state == 1 then
            return fulfilledCallback(nil, self.value)
        end
        if self.state == 2 then
            return rejectedCallback(nil, self.rejectionReason)
        end
        local ____self_fulfilledCallbacks_0 = self.fulfilledCallbacks
        ____self_fulfilledCallbacks_0[#____self_fulfilledCallbacks_0 + 1] = fulfilledCallback
        local ____self_rejectedCallbacks_1 = self.rejectedCallbacks
        ____self_rejectedCallbacks_1[#____self_rejectedCallbacks_1 + 1] = rejectedCallback
    end
    function __TS__Promise.prototype.catch(self, onRejected)
        return self["then"](self, nil, onRejected)
    end
    function __TS__Promise.prototype.finally(self, onFinally)
        if onFinally then
            local ____self_finallyCallbacks_2 = self.finallyCallbacks
            ____self_finallyCallbacks_2[#____self_finallyCallbacks_2 + 1] = onFinally
            if self.state ~= 0 then
                onFinally(nil)
            end
        end
        return self
    end
    function __TS__Promise.prototype.resolve(self, value)
        if isPromiseLike(value) then
            return value:addCallbacks(
                function(____, v) return self:resolve(v) end,
                function(____, err) return self:reject(err) end
            )
        end
        if self.state == 0 then
            self.state = 1
            self.value = value
            return self:invokeCallbacks(self.fulfilledCallbacks, value)
        end
    end
    function __TS__Promise.prototype.reject(self, reason)
        if self.state == 0 then
            self.state = 2
            self.rejectionReason = reason
            return self:invokeCallbacks(self.rejectedCallbacks, reason)
        end
    end
    function __TS__Promise.prototype.invokeCallbacks(self, callbacks, value)
        local callbacksLength = #callbacks
        local finallyCallbacks = self.finallyCallbacks
        local finallyCallbacksLength = #finallyCallbacks
        if callbacksLength ~= 0 then
            for i = 1, callbacksLength - 1 do
                callbacks[i](callbacks, value)
            end
            if finallyCallbacksLength == 0 then
                return callbacks[callbacksLength](callbacks, value)
            end
            callbacks[callbacksLength](callbacks, value)
        end
        if finallyCallbacksLength ~= 0 then
            for i = 1, finallyCallbacksLength - 1 do
                finallyCallbacks[i](finallyCallbacks)
            end
            return finallyCallbacks[finallyCallbacksLength](finallyCallbacks)
        end
    end
    function __TS__Promise.prototype.createPromiseResolvingCallback(self, f, resolve, reject)
        return function(____, value)
            local success, resultOrError = ____pcall(f, nil, value)
            if not success then
                return reject(nil, resultOrError)
            end
            return self:handleCallbackValue(resultOrError, resolve, reject)
        end
    end
    function __TS__Promise.prototype.handleCallbackValue(self, value, resolve, reject)
        if isPromiseLike(value) then
            local nextpromise = value
            if nextpromise.state == 1 then
                return resolve(nil, nextpromise.value)
            elseif nextpromise.state == 2 then
                return reject(nil, nextpromise.rejectionReason)
            else
                return nextpromise:addCallbacks(resolve, reject)
            end
        else
            return resolve(nil, value)
        end
    end
end

local function __TS__StringSubstring(self, start, ____end)
    if ____end ~= ____end then
        ____end = 0
    end
    if ____end ~= nil and start > ____end then
        start, ____end = ____end, start
    end
    if start >= 0 then
        start = start + 1
    else
        start = 1
    end
    if ____end ~= nil and ____end < 0 then
        ____end = 0
    end
    return string.sub(self, start, ____end)
end

local __TS__Match = string.match

local __TS__ParseInt
do
    local parseIntBasePattern = "0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTvVwWxXyYzZ"
    function __TS__ParseInt(numberString, base)
        if base == nil then
            base = 10
            local hexMatch = __TS__Match(numberString, "^%s*-?0[xX]")
            if hexMatch ~= nil then
                base = 16
                numberString = (__TS__Match(hexMatch, "-")) and "-" .. __TS__StringSubstring(numberString, #hexMatch) or __TS__StringSubstring(numberString, #hexMatch)
            end
        end
        if base < 2 or base > 36 then
            return 0 / 0
        end
        local allowedDigits = base <= 10 and __TS__StringSubstring(parseIntBasePattern, 0, base) or __TS__StringSubstring(parseIntBasePattern, 0, 10 + 2 * (base - 10))
        local pattern = ("^%s*(-?[" .. allowedDigits) .. "]*)"
        local number = tonumber((__TS__Match(numberString, pattern)), base)
        if number == nil then
            return 0 / 0
        end
        if number >= 0 then
            return math.floor(number)
        else
            return math.ceil(number)
        end
    end
end

local function __TS__StringCharAt(self, pos)
    if pos ~= pos then
        pos = 0
    end
    if pos < 0 then
        return ""
    end
    return string.sub(self, pos + 1, pos + 1)
end

local function __TS__ArrayIncludes(self, searchElement, fromIndex)
    if fromIndex == nil then
        fromIndex = 0
    end
    local len = #self
    local k = fromIndex
    if fromIndex < 0 then
        k = len + fromIndex
    end
    if k < 0 then
        k = 0
    end
    for i = k + 1, len do
        if self[i] == searchElement then
            return true
        end
    end
    return false
end

local __TS__StringSplit
do
    local sub = string.sub
    local find = string.find
    function __TS__StringSplit(source, separator, limit)
        if limit == nil then
            limit = 4294967295
        end
        if limit == 0 then
            return {}
        end
        local result = {}
        local resultIndex = 1
        if separator == nil or separator == "" then
            for i = 1, #source do
                result[resultIndex] = sub(source, i, i)
                resultIndex = resultIndex + 1
            end
        else
            local currentPos = 1
            while resultIndex <= limit do
                local startPos, endPos = find(source, separator, currentPos, true)
                if not startPos then
                    break
                end
                result[resultIndex] = sub(source, currentPos, startPos - 1)
                resultIndex = resultIndex + 1
                currentPos = endPos + 1
            end
            if resultIndex <= limit then
                result[resultIndex] = sub(source, currentPos)
            end
        end
        return result
    end
end

local __TS__StringReplaceAll
do
    local sub = string.sub
    local find = string.find
    function __TS__StringReplaceAll(source, searchValue, replaceValue)
        if type(replaceValue) == "string" then
            local concat = table.concat(
                __TS__StringSplit(source, searchValue),
                replaceValue
            )
            if #searchValue == 0 then
                return (replaceValue .. concat) .. replaceValue
            end
            return concat
        end
        local parts = {}
        local partsIndex = 1
        if #searchValue == 0 then
            parts[1] = replaceValue(nil, "", 0, source)
            partsIndex = 2
            for i = 1, #source do
                parts[partsIndex] = sub(source, i, i)
                parts[partsIndex + 1] = replaceValue(nil, "", i, source)
                partsIndex = partsIndex + 2
            end
        else
            local currentPos = 1
            while true do
                local startPos, endPos = find(source, searchValue, currentPos, true)
                if not startPos then
                    break
                end
                parts[partsIndex] = sub(source, currentPos, startPos - 1)
                parts[partsIndex + 1] = replaceValue(nil, searchValue, startPos - 1, source)
                partsIndex = partsIndex + 2
                currentPos = endPos + 1
            end
            parts[partsIndex] = sub(source, currentPos)
        end
        return table.concat(parts)
    end
end

local function __TS__ArrayPushArray(self, items)
    local len = #self
    for i = 1, #items do
        len = len + 1
        self[len] = items[i]
    end
    return len
end

return {
  Error = Error,
  RangeError = RangeError,
  ReferenceError = ReferenceError,
  SyntaxError = SyntaxError,
  TypeError = TypeError,
  URIError = URIError,
  __TS__New = __TS__New,
  __TS__StringSlice = __TS__StringSlice,
  __TS__StringTrim = __TS__StringTrim,
  __TS__ArrayReverse = __TS__ArrayReverse,
  __TS__Promise = __TS__Promise,
  __TS__ParseInt = __TS__ParseInt,
  __TS__StringCharAt = __TS__StringCharAt,
  __TS__ArrayIncludes = __TS__ArrayIncludes,
  __TS__StringReplaceAll = __TS__StringReplaceAll,
  __TS__ArrayPushArray = __TS__ArrayPushArray
}
 end,
["index"] = function(...) 
-- Fix import paths
local __script_directory = ({reaper.get_action_context()})[2]:match('^(.+[\\\\//])') .. "?.lua"
package.path = __script_directory .. ";" .. package.path

local ____lualib = require("lualib_bundle")
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__StringSlice = ____lualib.__TS__StringSlice
local __TS__StringTrim = ____lualib.__TS__StringTrim
local __TS__ArrayReverse = ____lualib.__TS__ArrayReverse
local ____exports = {}
local ____menu = require("lua_modules.reaper-api.menu")
local MenuItemKind = ____menu.MenuItemKind
local showMenu = ____menu.showMenu
local path = require("lua_modules.reaper-api.path.path")
local ____utils = require("lua_modules.reaper-api.utils")
local assertUnreachable = ____utils.assertUnreachable
local errorHandler = ____utils.errorHandler
local log = ____utils.log
local msgBox = ____utils.msgBox
local readFile = ____utils.readFile
local ____utilsLua = require("lua_modules.reaper-api.utilsLua")
local splitlines = ____utilsLua.splitlines

local SectionId = SectionId or ({})
SectionId.Main = 0
SectionId[SectionId.Main] = "Main"
SectionId.MainAlt1 = 1
SectionId[SectionId.MainAlt1] = "MainAlt1"
SectionId.MainAlt2 = 2
SectionId[SectionId.MainAlt2] = "MainAlt2"
SectionId.MainAlt3 = 3
SectionId[SectionId.MainAlt3] = "MainAlt3"
SectionId.MainAlt4 = 4
SectionId[SectionId.MainAlt4] = "MainAlt4"
SectionId.MainAlt5 = 5
SectionId[SectionId.MainAlt5] = "MainAlt5"
SectionId.MainAlt6 = 6
SectionId[SectionId.MainAlt6] = "MainAlt6"
SectionId.MainAlt7 = 7
SectionId[SectionId.MainAlt7] = "MainAlt7"
SectionId.MainAlt8 = 8
SectionId[SectionId.MainAlt8] = "MainAlt8"
SectionId.MainAlt9 = 9
SectionId[SectionId.MainAlt9] = "MainAlt9"
SectionId.MainAlt10 = 10
SectionId[SectionId.MainAlt10] = "MainAlt10"
SectionId.MainAlt11 = 11
SectionId[SectionId.MainAlt11] = "MainAlt11"
SectionId.MainAlt12 = 12
SectionId[SectionId.MainAlt12] = "MainAlt12"
SectionId.MainAlt13 = 13
SectionId[SectionId.MainAlt13] = "MainAlt13"
SectionId.MainAlt14 = 14
SectionId[SectionId.MainAlt14] = "MainAlt14"
SectionId.MainAlt15 = 15
SectionId[SectionId.MainAlt15] = "MainAlt15"
SectionId.MainAlt16 = 16
SectionId[SectionId.MainAlt16] = "MainAlt16"
SectionId.MainAltRecording = 100
SectionId[SectionId.MainAltRecording] = "MainAltRecording"
SectionId.MIDIEditor = 32060
SectionId[SectionId.MIDIEditor] = "MIDIEditor"
SectionId.MIDIEventListEditor = 32061
SectionId[SectionId.MIDIEventListEditor] = "MIDIEventListEditor"
SectionId.MIDIInlineEditor = 32062
SectionId[SectionId.MIDIInlineEditor] = "MIDIInlineEditor"
SectionId.MediaExplorer = 32063
SectionId[SectionId.MediaExplorer] = "MediaExplorer"
local SectionGroup = SectionGroup or ({})
SectionGroup.Main = 0
SectionGroup[SectionGroup.Main] = "Main"
SectionGroup.MIDIEditor = 1
SectionGroup[SectionGroup.MIDIEditor] = "MIDIEditor"
SectionGroup.MediaExplorer = 2
SectionGroup[SectionGroup.MediaExplorer] = "MediaExplorer"
SectionGroup.Unknown = 3
SectionGroup[SectionGroup.Unknown] = "Unknown"
local function classifySection(self, sectionId)
    if sectionId < 32060 then
        return SectionGroup.Main
    elseif sectionId < 32063 then
        return SectionGroup.MIDIEditor
    elseif sectionId == 32063 then
        return SectionGroup.MediaExplorer
    else
        return SectionGroup.Unknown
    end
end
local function parseSameLevelItems(self, sectionId, revLines)
    if #revLines == 0 then
        return {}
    end
    local expectedIndentLevel = #(string.match(revLines[#revLines], "^ *"))
    local result = {}
    while true do
        do
            local line = table.remove(revLines)
            if line == nil then
                return result
            end
            local indentLevel = #(string.match(line, "^ *"))
            if indentLevel ~= expectedIndentLevel then
                revLines[#revLines + 1] = line
                if indentLevel < expectedIndentLevel then
                    return result
                else
                    local prevMenuItem = result[#result]
                    if prevMenuItem == nil then
                        error(
                            __TS__New(Error, "indented item must be preceded by a submenu item: " .. line),
                            0
                        )
                    end
                    if prevMenuItem.kind ~= MenuItemKind.Submenu then
                        error(
                            __TS__New(Error, "indented item must be preceded by a submenu item: " .. line),
                            0
                        )
                    end
                    local childItems = parseSameLevelItems(nil, sectionId, revLines)
                    prevMenuItem.children = childItems
                    goto __continue9
                end
            end
            local commentPrefix = {string.match(line, "^ *# *")}
            if #commentPrefix > 0 then
                local name = __TS__StringTrim(__TS__StringSlice(line, #commentPrefix[1], #line))
                result[#result + 1] = {kind = MenuItemKind.Muted, name = name, cmd = -1}
                goto __continue9
            end
            local submenuSuffix = {string.match(line, " *: *$")}
            if #submenuSuffix > 0 then
                local name = __TS__StringTrim(__TS__StringSlice(line, 0, #line - #submenuSuffix[1]))
                result[#result + 1] = {kind = MenuItemKind.Submenu, name = name, children = {}}
                goto __continue9
            end
            local hyphensOnly = {string.match(line, "^ *-* *$")}
            if #hyphensOnly > 0 then
                result[#result + 1] = {kind = MenuItemKind.Separator}
                goto __continue9
            end
            local commandSuffixMatch = {string.match(line, "( *%[([^%[%]]*)%] *)$")}
            if #commandSuffixMatch == 0 then
                error(
                    __TS__New(Error, "menu item is missing a command ID: " .. line),
                    0
                )
            end
            local commandSuffix
            local commandId
            local commandState
            do
                local suffix, id = table.unpack(commandSuffixMatch)
                commandSuffix = suffix
                local numericId = tonumber(id)
                if numericId ~= nil then
                    commandId = numericId
                else
                    commandId = reaper.NamedCommandLookup(id)
                    if commandId == 0 then
                        error(
                            __TS__New(Error, "command not found: " .. id),
                            0
                        )
                    end
                end
                local state = reaper.GetToggleCommandStateEx(sectionId, commandId)
                if state == 1 then
                    commandState = true
                elseif state == 0 then
                    commandState = false
                else
                    commandState = nil
                end
            end
            local name = __TS__StringTrim(__TS__StringSlice(line, 0, #line - #commandSuffix))
            result[#result + 1] = {kind = MenuItemKind.Normal, name = name, cmd = commandId, checked = commandState == true}
        end
        ::__continue9::
    end
end
local function parsePlainTextMenu(self, sectionId, lines)
    __TS__ArrayReverse(lines)
    return parseSameLevelItems(nil, sectionId, lines)
end
--- NOTE: This consumes the `lines` object
function ____exports.showPlainTextMenu(self, sectionId, lines)
    local items = parsePlainTextMenu(nil, sectionId, lines)
    local selectedItem = showMenu(nil, items)
    if selectedItem ~= nil and selectedItem.kind == MenuItemKind.Normal then
        local sectionGroup = classifySection(nil, sectionId)
        repeat
            local ____switch30 = sectionGroup
            local ____cond30 = ____switch30 == SectionGroup.Main
            if ____cond30 then
                do
                    reaper.Main_OnCommandEx(selectedItem.cmd, 0, 0)
                    break
                end
            end
            ____cond30 = ____cond30 or ____switch30 == SectionGroup.MIDIEditor
            if ____cond30 then
                do
                    reaper.MIDIEditor_LastFocused_OnCommand(selectedItem.cmd, false)
                    break
                end
            end
            ____cond30 = ____cond30 or ____switch30 == SectionGroup.MediaExplorer
            if ____cond30 then
                do
                    local identifier = reaper.OpenMediaExplorer("", false)
                    reaper.JS_Window_OnCommand(identifier, selectedItem.cmd)
                    break
                end
            end
            ____cond30 = ____cond30 or ____switch30 == SectionGroup.Unknown
            if ____cond30 then
                do
                    reaper.Main_OnCommandEx(selectedItem.cmd, 0, 0)
                    break
                end
            end
            do
                assertUnreachable(nil, sectionGroup)
            end
        until true
    end
end
local function main(self)
    local is_new_value, filename, sectionID, cmdID, mode, resolution, val, contextstr = reaper.get_action_context()
    local menuPath = (path.splitext(filename)) .. ".txt"
    if not reaper.file_exists(menuPath) then
        msgBox(nil, "Usage", "To use this script, create a new text file with the same name as this script but with a '.txt' extension.\nThe text file should be located at: " .. menuPath)
        log(nil, "Usage:")
        log(nil, "To use this script, create a new text file with the same name as this script but with a '.txt' extension.")
        log(nil, "The text file should be located at: " .. menuPath)
        log(nil)
        error(
            __TS__New(Error, "Menu definition file cannot be found, please create a file at: " .. menuPath),
            0
        )
    end
    local menuText = readFile(nil, menuPath)
    ____exports.showPlainTextMenu(
        nil,
        sectionID,
        splitlines(menuText)
    )
end
errorHandler(nil, main)
return ____exports
 end,
["lua_modules.reaper-api.utilsLua"] = function(...) 
local mod = {}

mod.split = function(text, separator)
	local items = {}
	local i = 1
	local search_pos = 0
	while true do
		local match_pos = text:find(separator, search_pos + 1, true)
		if match_pos == nil then
			-- if no match, then it is end of string
			items[i] = text:sub(search_pos + 1, -1)
			return items
		else
			-- split the text at that point
			items[i] = text:sub(search_pos + 1, match_pos - 1)
			i = i + 1
			search_pos = match_pos
		end
	end
end

-- robust method to split by lines, this handles both "\n" and "\r\n" sequences
mod.splitlines = function(text)
	local lines = {}
	local i = 1
	local search_pos = 0
	while true do
		local nl_pos = text:find("\n", search_pos + 1, true)
		if nl_pos == nil then
			-- if no newlines, then it is end of string
			lines[i] = text:sub(search_pos + 1, -1)
			return lines
		else
			if text:sub(nl_pos - 1, nl_pos - 1) == "\r" then
				-- there is carriage return just before the newline
				lines[i] = text:sub(search_pos + 1, nl_pos - 2)
			else
				-- there no carriage return just before the newline
				lines[i] = text:sub(search_pos + 1, nl_pos - 1)
			end
			i = i + 1
			search_pos = nl_pos
		end
	end
end

mod.strip = function(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end

return mod
 end,
["lua_modules.reaper-api.utils"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Promise = ____lualib.__TS__Promise
local __TS__New = ____lualib.__TS__New
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__ParseInt = ____lualib.__TS__ParseInt
local ____exports = {}
local ____inspect = require("lua_modules.reaper-api.inspect")
local inspect = ____inspect.inspect
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
function ____exports.deferAsync(self)
    return __TS__New(
        __TS__Promise,
        function(____, resolve) return reaper.defer(function() return resolve(nil, nil) end) end
    )
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
    local desc
    local flags
    local ____error = nil
    do
        local function ____catch(e)
            desc = ""
            flags = -1
            ____error = e
        end
        local ____try, ____hasReturned = pcall(function()
            local config = func(nil)
            desc = config.desc
            flags = config.flags
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
function ____exports.errorHandler(self, func)
    local function stringOrInspect(self, obj)
        if type(obj) == "string" then
            return obj
        else
            return inspect(obj)
        end
    end
    do
        local function ____catch(e)
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
            if msg == nil then
                ____exports.log(nil, "error: " .. name)
            else
                ____exports.log(nil, (name .. ": ") .. msg)
            end
            if stack ~= nil then
                ____exports.log(nil, stack)
            end
            if msg == nil then
                error("error: " .. name)
            else
                error((name .. ": ") .. msg)
            end
        end
        local ____try, ____hasReturned = pcall(function()
            local rv = func(nil)
            if rv then
                rv:catch(function(____, e)
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
                    if msg == nil then
                        ____exports.log(nil, "error: " .. name)
                    else
                        ____exports.log(nil, (name .. ": ") .. msg)
                    end
                    if stack ~= nil then
                        ____exports.log(nil, stack)
                    end
                    if msg == nil then
                        error("error: " .. name)
                    else
                        error((name .. ": ") .. msg)
                    end
                end)
            end
        end)
        if not ____try then
            ____catch(____hasReturned)
        end
    end
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
return ____exports
 end,
["lua_modules.reaper-api.inspect"] = function(...) 
local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local math = _tl_compat and _tl_compat.math or math; local string = _tl_compat and _tl_compat.string or string; local table = _tl_compat and _tl_compat.table or table
local inspect = {Options = {}, }

















inspect._VERSION = 'inspect.lua 3.1.0'
inspect._URL = 'http://github.com/kikito/inspect.lua'
inspect._DESCRIPTION = 'human-readable representations of tables'
inspect._LICENSE = [[
  MIT LICENSE

  Copyright (c) 2022 Enrique García Cota

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the
  "Software"), to deal in the Software without restriction, including
  without limitation the rights to use, copy, modify, merge, publish,
  distribute, sublicense, and/or sell copies of the Software, and to
  permit persons to whom the Software is furnished to do so, subject to
  the following conditions:

  The above copyright notice and this permission notice shall be included
  in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]
inspect.KEY = setmetatable({}, { __tostring = function() return 'inspect.KEY' end })
inspect.METATABLE = setmetatable({}, { __tostring = function() return 'inspect.METATABLE' end })

local tostring = tostring
local rep = string.rep
local match = string.match
local char = string.char
local gsub = string.gsub
local fmt = string.format

local _rawget
if rawget then
   _rawget = rawget
else
   _rawget = function(t, k) return t[k] end
end

local function rawpairs(t)
   return next, t, nil
end



local function smartQuote(str)
   if match(str, '"') and not match(str, "'") then
      return "'" .. str .. "'"
   end
   return '"' .. gsub(str, '"', '\\"') .. '"'
end


local shortControlCharEscapes = {
   ["\a"] = "\\a", ["\b"] = "\\b", ["\f"] = "\\f", ["\n"] = "\\n",
   ["\r"] = "\\r", ["\t"] = "\\t", ["\v"] = "\\v", ["\127"] = "\\127",
}
local longControlCharEscapes = { ["\127"] = "\127" }
for i = 0, 31 do
   local ch = char(i)
   if not shortControlCharEscapes[ch] then
      shortControlCharEscapes[ch] = "\\" .. i
      longControlCharEscapes[ch] = fmt("\\%03d", i)
   end
end

local function escape(str)
   return (gsub(gsub(gsub(str, "\\", "\\\\"),
   "(%c)%f[0-9]", longControlCharEscapes),
   "%c", shortControlCharEscapes))
end

local luaKeywords = {
   ['and'] = true,
   ['break'] = true,
   ['do'] = true,
   ['else'] = true,
   ['elseif'] = true,
   ['end'] = true,
   ['false'] = true,
   ['for'] = true,
   ['function'] = true,
   ['goto'] = true,
   ['if'] = true,
   ['in'] = true,
   ['local'] = true,
   ['nil'] = true,
   ['not'] = true,
   ['or'] = true,
   ['repeat'] = true,
   ['return'] = true,
   ['then'] = true,
   ['true'] = true,
   ['until'] = true,
   ['while'] = true,
}

local function isIdentifier(str)
   return type(str) == "string" and
   not not str:match("^[_%a][_%a%d]*$") and
   not luaKeywords[str]
end

local flr = math.floor
local function isSequenceKey(k, sequenceLength)
   return type(k) == "number" and
   flr(k) == k and
   1 <= (k) and
   k <= sequenceLength
end

local defaultTypeOrders = {
   ['number'] = 1, ['boolean'] = 2, ['string'] = 3, ['table'] = 4,
   ['function'] = 5, ['userdata'] = 6, ['thread'] = 7,
}

local function sortKeys(a, b)
   local ta, tb = type(a), type(b)


   if ta == tb and (ta == 'string' or ta == 'number') then
      return (a) < (b)
   end

   local dta = defaultTypeOrders[ta] or 100
   local dtb = defaultTypeOrders[tb] or 100


   return dta == dtb and ta < tb or dta < dtb
end

local function getKeys(t)

   local seqLen = 1
   while _rawget(t, seqLen) ~= nil do
      seqLen = seqLen + 1
   end
   seqLen = seqLen - 1

   local keys, keysLen = {}, 0
   for k in rawpairs(t) do
      if not isSequenceKey(k, seqLen) then
         keysLen = keysLen + 1
         keys[keysLen] = k
      end
   end
   table.sort(keys, sortKeys)
   return keys, keysLen, seqLen
end

local function countCycles(x, cycles)
   if type(x) == "table" then
      if cycles[x] then
         cycles[x] = cycles[x] + 1
      else
         cycles[x] = 1
         for k, v in rawpairs(x) do
            countCycles(k, cycles)
            countCycles(v, cycles)
         end
         countCycles(getmetatable(x), cycles)
      end
   end
end

local function makePath(path, a, b)
   local newPath = {}
   local len = #path
   for i = 1, len do newPath[i] = path[i] end

   newPath[len + 1] = a
   newPath[len + 2] = b

   return newPath
end


local function processRecursive(process,
   item,
   path,
   visited)
   if item == nil then return nil end
   if visited[item] then return visited[item] end

   local processed = process(item, path)
   if type(processed) == "table" then
      local processedCopy = {}
      visited[item] = processedCopy
      local processedKey

      for k, v in rawpairs(processed) do
         processedKey = processRecursive(process, k, makePath(path, k, inspect.KEY), visited)
         if processedKey ~= nil then
            processedCopy[processedKey] = processRecursive(process, v, makePath(path, processedKey), visited)
         end
      end

      local mt = processRecursive(process, getmetatable(processed), makePath(path, inspect.METATABLE), visited)
      if type(mt) ~= 'table' then mt = nil end
      setmetatable(processedCopy, mt)
      processed = processedCopy
   end
   return processed
end

local function puts(buf, str)
   buf.n = buf.n + 1
   buf[buf.n] = str
end



local Inspector = {}










local Inspector_mt = { __index = Inspector }

local function tabify(inspector)
   puts(inspector.buf, inspector.newline .. rep(inspector.indent, inspector.level))
end

function Inspector:getId(v)
   local id = self.ids[v]
   local ids = self.ids
   if not id then
      local tv = type(v)
      id = (ids[tv] or 0) + 1
      ids[v], ids[tv] = id, id
   end
   return tostring(id)
end

function Inspector:putValue(v)
   local buf = self.buf
   local tv = type(v)
   if tv == 'string' then
      puts(buf, smartQuote(escape(v)))
   elseif tv == 'number' or tv == 'boolean' or tv == 'nil' or
      tv == 'cdata' or tv == 'ctype' then
      puts(buf, tostring(v))
   elseif tv == 'table' and not self.ids[v] then
      local t = v

      if t == inspect.KEY or t == inspect.METATABLE then
         puts(buf, tostring(t))
      elseif self.level >= self.depth then
         puts(buf, '{...}')
      else
         if self.cycles[t] > 1 then puts(buf, fmt('<%d>', self:getId(t))) end

         local keys, keysLen, seqLen = getKeys(t)

         puts(buf, '{')
         self.level = self.level + 1

         for i = 1, seqLen + keysLen do
            if i > 1 then puts(buf, ',') end
            if i <= seqLen then
               puts(buf, ' ')
               self:putValue(t[i])
            else
               local k = keys[i - seqLen]
               tabify(self)
               if isIdentifier(k) then
                  puts(buf, k)
               else
                  puts(buf, "[")
                  self:putValue(k)
                  puts(buf, "]")
               end
               puts(buf, ' = ')
               self:putValue(t[k])
            end
         end

         local mt = getmetatable(t)
         if type(mt) == 'table' then
            if seqLen + keysLen > 0 then puts(buf, ',') end
            tabify(self)
            puts(buf, '<metatable> = ')
            self:putValue(mt)
         end

         self.level = self.level - 1

         if keysLen > 0 or type(mt) == 'table' then
            tabify(self)
         elseif seqLen > 0 then
            puts(buf, ' ')
         end

         puts(buf, '}')
      end

   else
      puts(buf, fmt('<%s %d>', tv, self:getId(v)))
   end
end




function inspect.inspect(root, options)
   options = options or {}

   local depth = options.depth or (math.huge)
   local newline = options.newline or '\n'
   local indent = options.indent or '  '
   local process = options.process

   if process then
      root = processRecursive(process, root, {}, {})
   end

   local cycles = {}
   countCycles(root, cycles)

   local inspector = setmetatable({
      buf = { n = 0 },
      ids = {},
      cycles = cycles,
      depth = depth,
      level = 0,
      newline = newline,
      indent = indent,
   }, Inspector_mt)

   inspector:putValue(root)

   return table.concat(inspector.buf)
end

setmetatable(inspect, {
   __call = function(_, root, options)
      return inspect.inspect(root, options)
   end,
})

return inspect
 end,
["lua_modules.reaper-api.path.path"] = function(...) 
--- A port of some functions from Python's os.path module

---@type string
local reaper_os = reaper.GetOS()
local is_windows = reaper_os:sub(1, 3) == "Win"

if is_windows then
  return require("lua_modules.reaper-api.path.ntpath")
else
  return require("lua_modules.reaper-api.path.posixpath")
end
 end,
["lua_modules.reaper-api.path.posixpath"] = function(...) 
-- port of os.path for Linux-based systems

local util = require("lua_modules.reaper-api.path.util")
local common = require("lua_modules.reaper-api.path.genericpath")

local getcwd = common.getcwd
local contains = util.contains

local module = {}

--- Split a pathname into drive and path. On Posix, drive is always empty.
--- @param path string
function module.splitdrive(path)
  return "", path
end

--[[
Join two or more pathname components, inserting '/' as needed.
If any component is an absolute path, all previous path components
will be discarded.  An empty last part will result in a path that
ends with a separator.
--]]
function module.join(a, ...)
  local p = { ... }
  local path = a
  for _, b in ipairs(p) do
    if b:sub(1, 1) == "/" then
      path = b
    elseif #path == 0 or path:sub(-1, -1) == "/" then
      path = path .. b
    else
      path = path .. "/" .. b
    end
  end
  return path
end

--- Split a path in root and extension.
--- The extension is everything starting at the last dot in the last
--- pathname component; the root is everything before that.
--- It is always true that root + ext == p.
function module.splitext(p)
  return common.splitext(p, "/", nil, ".")
end

-- Normalize a path, e.g. A//B, A/./B and A/foo/../B all become A/B.
-- It should be understood that this may change the meaning of the path
-- if it contains symbolic links!

--- Normalize path, eliminating double slashes, etc.
--- @param path string
function module.normpath(path)
  if #path == 0 then
    return "."
  end

  local initial_slashes = path:sub(1, 1) == "/"
  -- POSIX allows one or two initial slashes, but treats three or more as single slash.
  if initial_slashes and path:sub(2, 2) == "/" and not (path:sub(3, 3) == "/") then
    initial_slashes = 2
  end

  local comps = util.split(path, "[^/]*")
  local new_comps = {}
  for _, comp in ipairs(comps) do
    if contains(comp, { "", "." }) then
      goto continue
    end

    if
      comp ~= ".."
      or (not initial_slashes and #new_comps == 0)
      or (#new_comps > 0 and new_comps[#new_comps] == "..")
    then
      table.insert(new_comps, comp)
    elseif #new_comps > 0 then
      table.remove(new_comps)
    end
    ::continue::
  end
  comps = new_comps
  path = table.concat(comps, "/")
  if initial_slashes then
    if initial_slashes == true then
      initial_slashes = 1
    end

    path = ("/"):rep(initial_slashes) .. path
  end

  if #path > 0 then
    return path
  else
    return "."
  end
end

-- Split a path in head (everything up to the last '/') and tail (the
-- rest).  If the path ends in '/', tail will be empty.  If there is no
-- '/' in the path, head  will be empty.
-- Trailing '/'es are stripped from head unless it is the root.

--- Split a pathname.  Returns tuple "(head, tail)" where "tail" is
--- everything after the final slash.  Either part may be empty.
--- @param p string
function module.split(p)
  local sep_pos = ({ p:find(".*/") })[2] or 0
  local head, tail = p:sub(1, sep_pos), p:sub(sep_pos + 1)
  if #head > 0 and head ~= ("/"):rep(#head) then
    -- remove trailing slashes from head, unless it's all slashes
    -- https://stackoverflow.com/questions/17386792/how-to-implement-string-rfind-in-lua
    head = head:match("(.*[^/\\])") or head
  end
  return head, tail
end

-- Return whether a path is absolute.
-- Trivial in Posix, harder on the Mac or MS-DOS.

--- Test whether a path is absolute
function module.isabs(s)
  return s:sub(1, 1) == "/"
end

--- Return an absolute path.
--- @param path string
function module.abspath(path)
  if not module.isabs(path) then
    local cwd = getcwd()
    path = module.join(cwd, path)
  end
  return module.normpath(path)
end

--- Normalize case of pathname.  Has no effect under Posix
--- @param s string
function module.normcase(s)
  return s
end

--- Return a relative version of a path
--- @param path string
--- @param start string|nil
function module.relpath(path, start)
  if #path == 0 then
    return nil, "Given path is empty!"
  end

  if start == nil then
    start = "."
  end

  start = module.abspath(start)
  path = module.abspath(path)

  local start_list = {}
  for _, p in ipairs(util.split(start, "[^/]*")) do
    if #p > 0 then
      table.insert(start_list, p)
    end
  end

  local path_list = {}
  for _, p in ipairs(util.split(path, "[^/]*")) do
    if #p > 0 then
      table.insert(path_list, p)
    end
  end

  -- Work out how much of the filepath is shared by start and path.
  local i = 1
  for k = 1, math.min(#start_list, #path_list) do
    if start_list[k] ~= path_list[k] then
      break
    end
    i = k + 1
  end

  local rel_list = {}
  for j = 1, #start_list - i + 1 do
    rel_list[j] = ".."
  end
  local j = #rel_list + 1
  for k = i, #path_list do
    rel_list[j] = path_list[k]
    j = j + 1
  end

  if #rel_list == 0 then
    return "."
  end
  return module.join(table.unpack(rel_list))
end

return module
 end,
["lua_modules.reaper-api.path.genericpath"] = function(...) 
local module = {}

function module.splitext(p, sep, altsep, extsep)
	for i, x in ipairs({ sep, altsep, extsep }) do
		assert(#x == 1, "Input separator must be a single char")
	end

	local sepIndex = ({ p:find(".*%" .. sep) })[2] or 0

	if altsep ~= nil then
		local altsepIndex = ({ p:find(".*%" .. altsep) })[2] or 0
		sepIndex = math.max(sepIndex, altsepIndex)
	end

	local dotIndex = ({ p:find(".*%" .. extsep) })[2] or 0
	if dotIndex > sepIndex then
		-- skip all leading dots
		local filenameIndex = sepIndex + 1
		while filenameIndex < dotIndex do
			if p:sub(filenameIndex, filenameIndex) ~= extsep then
				return p:sub(1, dotIndex - 1), p:sub(dotIndex)
			end
			filenameIndex = filenameIndex + 1
		end
	end

	return p, ""
end

--- Get the current working directory
--- There is no native function to do this, you MUST use an external library for this
function module.getcwd()
	return reaper.GetExePath()
end

return module
 end,
["lua_modules.reaper-api.path.util"] = function(...) 
local module = {}

function module.contains(val, arr)
  for _, x in ipairs(arr) do
    if val == x then
      return true
    end
  end
  return false
end

-- http://lua-users.org/wiki/SplitJoin

-- local str = "a,,b"     -- comma-separated list
-- local pat = "[^,]*"    -- everything except commas
-- assert (table.concat(split(str, pat), ",") == str)

-- splits 'str' into pieces matching 'pat', returns them as an array
-- the following minimalistic splitting function now is a true inverse of table.concat
function module.split(str, pat)
  local tbl = {}
  str:gsub(pat, function(x)
    tbl[#tbl + 1] = x
  end)
  return tbl
end

return module
 end,
["lua_modules.reaper-api.path.ntpath"] = function(...) 
-- port of os.path for Windows

local util = require("lua_modules.reaper-api.path.util")
local common = require("lua_modules.reaper-api.path.genericpath")

local getcwd = common.getcwd
local contains = util.contains

local module = {}

function module.splitext(p)
  return common.splitext(p, "\\", "/", ".")
end

--- @param path string
function module.splitdrive(path)
  if #path >= 2 then
    -- normalized path, by replacing all forward slashes with backslashes
    local npath = path:gsub("/", "\\")
    if npath:sub(1, 2) == "\\\\" and npath:sub(3, 3) ~= "\\" then
      -- this is a UNC path (starts with 2 backslashes)

      -- |---drive letter---|
      -- \\machine\mountpoint\directory\etc\...
      --                     |---directory----|

      local first_sep = npath:find("\\", 3)
      if first_sep == nil then
        return "", path
      end

      -- a UNC path can't have 2 slashes in a row (other than the first two)
      local second_sep = npath:find("\\", first_sep + 1)
      if second_sep == first_sep + 1 then
        return "", path
      end

      if second_sep == nil then
        return path, ""
      else
        return path:sub(1, second_sep - 1), path:sub(second_sep)
      end
    end

    if path:sub(2, 2) == ":" then
      return path:sub(1, 2), path:sub(3)
    end
  end

  return "", path
end

function module.join(path, ...)
  local paths = { ... }

  local result_drive, result_path = module.splitdrive(path)

  -- iterate for 2nd path onwards
  for _, p in ipairs(paths) do
    local p_drive, p_path = module.splitdrive(p)
    if #p_path > 0 and contains(p_path:sub(1, 1), { "\\", "/" }) then
      -- second path is absolute
      if #p_drive > 0 or #result_drive == 0 then
        result_drive = p_drive
      end

      result_path = p_path
      goto continue
    elseif #p_drive > 0 and p_drive ~= result_drive then
      if p_drive:lower() ~= result_drive:lower() then
        -- Different drives => ignore the first path entirely
        result_drive = p_drive
        result_path = p_path
        goto continue
      end
      -- Same drive in different case
      result_drive = p_drive
    end
    -- Second path is relative to the first
    if #result_path > 0 and not contains(result_path:sub(-1, -1), { "\\", "/" }) then
      result_path = result_path .. "\\"
    end
    result_path = result_path .. p_path
    ::continue::
  end
  -- add separator between UNC and non-absolute path
  if
    #result_path > 0
    and not contains(result_path:sub(1, 1), { "\\", "/" })
    and #result_drive > 0
    and result_drive:sub(-1, -1) ~= ":"
  then
    return result_drive .. "\\" .. result_path
  end

  return result_drive .. result_path
end

-- Normalize a path, e.g. A//B, A/./B and A/foo/../B all become A\B.
-- Previously, this function also truncated pathnames to 8+3 format,
-- but as this module is called "ntpath", that's obviously wrong!

--- Normalize path, eliminating double slashes, etc.
function module.normpath(path)
  if contains(path:sub(1, 4), { [[\\.\]], [[\\?\]] }) then
    -- in the case of paths with these prefixes:
    -- \\.\ -> device names
    -- \\?\ -> literal paths
    -- do not do any normalization, but return the path
    -- unchanged apart from the call to os.fspath()
    return path
  end

  path = path:gsub("/", "\\")
  local prefix, path = module.splitdrive(path)

  -- collapse initial backslashes
  if path:sub(1, 1) == "\\" then
    prefix = prefix .. "\\"

    path = ({ path:gsub("^\\+", "") })[1]
  end

  -- split by separator into list
  local comps = util.split(path, "[^\\\\]*")
  local i = 1
  while i <= #comps do
    if #comps[i] == 0 or comps[i] == "." then
      table.remove(comps, i)
    elseif comps[i] == ".." then
      if i > 1 and comps[i - 1] ~= ".." then
        for _ = 0, 1 do -- do twice
          table.remove(comps, i - 1)
        end
        i = i - 1
      elseif i == 1 and prefix:sub(-1, -1) == "\\" then
        table.remove(comps, i)
      else
        i = i + 1
      end
    else
      i = i + 1
    end
  end
  -- If the path is now empty, substitute '.'
  if #prefix == 0 and #comps == 0 then
    comps[#comps + 1] = "."
  end
  return prefix .. table.concat(comps, "\\")
end

--- Split a pathname.
--- Return tuple (head, tail) where tail is everything after the final slash.
--- Either part may be empty.
--- @param p string
function module.split(p)
  local d, p = module.splitdrive(p)
  -- set i to index beyond p's last slash
  local i = #p + 1
  while i ~= 1 and not contains(p:sub(i - 1, i - 1), { "/", "\\" }) do
    i = i - 1
  end
  local head, tail = p:sub(1, i - 1), p:sub(i) -- now tail has no slashes
  -- remove trailing slashes from head, unless it's all slashes
  -- https://stackoverflow.com/questions/17386792/how-to-implement-string-rfind-in-lua
  head = head:match("(.*[^/\\])") or head
  return d .. head, tail
end

--- Test whether a path is absolute
--- @param path string
function module.isabs(path)
  -- Paths beginning with \\?\ are always absolute, but do not necessarily contain a drive.
  local ABS_PATTERN = [[\\?\]]
  if path:gsub("/", "\\"):sub(1, 4) == ABS_PATTERN then
    return true
  end

  _, path = module.splitdrive(path)
  return #path > 0 and contains(path:sub(1, 1), { "/", "\\" })
end

--- Return an absolute path.
--- @param path string
function module.abspath(path)
  if not module.isabs(path) then
    local cwd = getcwd()
    path = module.join(cwd, path)
  end
  return module.normpath(path)
end

--- Normalize case of pathname.
--- Makes all characters lowercase and all slashes into backslashes.
--- @param s string
function module.normcase(s)
  return s:gsub("/", "\\"):lower()
end

--- Return a relative version of a path
function module.relpath(path, start)
  if #path == 0 then
    return nil, "Given path is empty!"
  end

  if start == nil then
    start = "."
  end

  local start_abs = module.abspath(module.normpath(start))
  local path_abs = module.abspath(module.normpath(path))
  local start_drive, start_rest = module.splitdrive(start_abs)
  local path_drive, path_rest = module.splitdrive(path_abs)
  if module.normcase(start_drive) ~= module.normcase(path_drive) then
    return nil, ("path is on mount %r, start on mount %r"):format(path_drive, start_drive)
  end

  local start_list = {}
  for _, p in ipairs(util.split(start_rest, "[^\\]*")) do
    if #p > 0 then
      table.insert(start_list, p)
    end
  end

  local path_list = {}
  for _, p in ipairs(util.split(path_rest, "[^\\]*")) do
    if #p > 0 then
      table.insert(path_list, p)
    end
  end

  -- Work out how much of the filepath is shared by start and path.
  local i = 1
  for k = 1, math.min(#start_list, #path_list) do
    if module.normcase(start_list[k]) ~= module.normcase(path_list[k]) then
      break
    end
    i = k + 1
  end

  local rel_list = {}
  for j = 1, #start_list - i + 1 do
    rel_list[j] = ".."
  end
  local j = #rel_list + 1
  for k = i, #path_list do
    rel_list[j] = path_list[k]
    j = j + 1
  end

  if #rel_list == 0 then
    return "."
  end
  return module.join(table.unpack(rel_list))
end

return module
 end,
["lua_modules.reaper-api.menu"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__StringCharAt = ____lualib.__TS__StringCharAt
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__StringReplaceAll = ____lualib.__TS__StringReplaceAll
local __TS__StringSlice = ____lualib.__TS__StringSlice
local __TS__ArrayPushArray = ____lualib.__TS__ArrayPushArray
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____utils = require("lua_modules.reaper-api.utils")
local assertUnreachable = ____utils.assertUnreachable
local getReaperVersion = ____utils.getReaperVersion
____exports.MenuItemKind = MenuItemKind or ({})
____exports.MenuItemKind.Normal = 0
____exports.MenuItemKind[____exports.MenuItemKind.Normal] = "Normal"
____exports.MenuItemKind.Muted = 1
____exports.MenuItemKind[____exports.MenuItemKind.Muted] = "Muted"
____exports.MenuItemKind.Separator = 2
____exports.MenuItemKind[____exports.MenuItemKind.Separator] = "Separator"
____exports.MenuItemKind.Submenu = 3
____exports.MenuItemKind[____exports.MenuItemKind.Submenu] = "Submenu"
local MODIFIER_CHARS = {
    "#",
    "!",
    ">",
    "<",
    "|"
}
--- Given a name, get the length of the starting modifier characters, if any
local function modifierPrefixLength(self, name)
    do
        local i = 0
        while i < #name do
            local char = __TS__StringCharAt(name, i)
            if not __TS__ArrayIncludes(MODIFIER_CHARS, char) then
                return i
            end
            i = i + 1
        end
    end
    return #name
end
--- Replace all modifier characters with unicode lookalikes
local function replaceModifierCharacters(self, name)
    return __TS__StringReplaceAll(
        __TS__StringReplaceAll(
            __TS__StringReplaceAll(
                __TS__StringReplaceAll(
                    __TS__StringReplaceAll(name, "#", "＃"),
                    "!",
                    "ǃ"
                ),
                ">",
                "＞"
            ),
            "<",
            "＜"
        ),
        "|",
        "ǀ"
    )
end
--- Given a name, replace any prefix chars with unicode lookalikes
local function sanitizeItemName(self, name)
    local prefixLength = modifierPrefixLength(nil, name)
    if prefixLength == 0 then
        return name
    end
    local prefix = __TS__StringSlice(name, 0, prefixLength)
    local suffix = __TS__StringSlice(name, prefixLength, #name)
    return replaceModifierCharacters(nil, prefix) .. suffix
end
--- Given a list of MenuItems, construct a string to be used in `gfx.showmenu`, and
-- a list of MenuItems that can be indexed with `gfx.showmenu`'s return value.
local function buildMenu(self, items)
    local flatItems = {}
    local flatNames = {}
    for ____, item in ipairs(items) do
        repeat
            local ____switch10 = item.kind
            local ____cond10 = ____switch10 == ____exports.MenuItemKind.Normal
            if ____cond10 then
                do
                    flatItems[#flatItems + 1] = item
                    if item.checked then
                        flatNames[#flatNames + 1] = "!" .. sanitizeItemName(nil, item.name)
                    else
                        flatNames[#flatNames + 1] = sanitizeItemName(nil, item.name)
                    end
                    break
                end
            end
            ____cond10 = ____cond10 or ____switch10 == ____exports.MenuItemKind.Muted
            if ____cond10 then
                do
                    flatItems[#flatItems + 1] = item
                    if item.checked then
                        flatNames[#flatNames + 1] = "#!" .. sanitizeItemName(nil, item.name)
                    else
                        flatNames[#flatNames + 1] = "#" .. sanitizeItemName(nil, item.name)
                    end
                    break
                end
            end
            ____cond10 = ____cond10 or ____switch10 == ____exports.MenuItemKind.Separator
            if ____cond10 then
                do
                    flatNames[#flatNames + 1] = ""
                    break
                end
            end
            ____cond10 = ____cond10 or ____switch10 == ____exports.MenuItemKind.Submenu
            if ____cond10 then
                do
                    if item.checked then
                        flatNames[#flatNames + 1] = ">!" .. sanitizeItemName(nil, item.name)
                    else
                        flatNames[#flatNames + 1] = ">" .. sanitizeItemName(nil, item.name)
                    end
                    local rv = buildMenu(nil, item.children)
                    do
                        local lastSubname = rv.names[#rv.names]
                        lastSubname = "<" .. lastSubname
                        rv.names[#rv.names] = lastSubname
                    end
                    __TS__ArrayPushArray(flatItems, rv.items)
                    __TS__ArrayPushArray(flatNames, rv.names)
                    break
                end
            end
            do
                assertUnreachable(nil, item)
            end
        until true
    end
    return {items = flatItems, names = flatNames}
end
local function supportsShowMenuWithoutInit(self)
    local ver = getReaperVersion(nil)
    if ver == nil then
        return false
    end
    if ver.major > 6 then
        return true
    end
    if ver.major == 6 then
        return ver.minor >= 82
    end
    return false
end
function ____exports.showMenu(self, items)
    local menu = buildMenu(nil, items)
    local menustring = table.concat(menu.names, "|")
    local needInit = not supportsShowMenuWithoutInit(nil)
    if needInit then
        gfx.init("", 0, 0)
        gfx.x = gfx.mouse_x
        gfx.y = gfx.mouse_y
    end
    local selectedIdx = gfx.showmenu(menustring) - 1
    if needInit then
        gfx.quit()
    end
    if selectedIdx == -1 then
        return nil
    end
    if selectedIdx >= #menu.items then
        error(
            __TS__New(Error, "selected index exceeds item count"),
            0
        )
    end
    return menu.items[selectedIdx + 1]
end
return ____exports
 end,
}
return require("index", ...)

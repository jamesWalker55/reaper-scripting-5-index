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

local __TS__Iterator
do
    local function iteratorGeneratorStep(self)
        local co = self.____coroutine
        local status, value = coroutine.resume(co)
        if not status then
            error(value, 0)
        end
        if coroutine.status(co) == "dead" then
            return
        end
        return true, value
    end
    local function iteratorIteratorStep(self)
        local result = self:next()
        if result.done then
            return
        end
        return true, result.value
    end
    local function iteratorStringStep(self, index)
        index = index + 1
        if index > #self then
            return
        end
        return index, string.sub(self, index, index)
    end
    function __TS__Iterator(iterable)
        if type(iterable) == "string" then
            return iteratorStringStep, iterable, 0
        elseif iterable.____coroutine ~= nil then
            return iteratorGeneratorStep, iterable
        elseif iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            return iteratorIteratorStep, iterator
        else
            return ipairs(iterable)
        end
    end
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

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

local function __TS__ArraySetLength(self, length)
    if length < 0 or length ~= length or length == math.huge or math.floor(length) ~= length then
        error(
            "invalid array length: " .. tostring(length),
            0
        )
    end
    for i = length + 1, #self do
        self[i] = nil
    end
    return length
end

local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local function __TS__ObjectAssign(target, ...)
    local sources = {...}
    for i = 1, #sources do
        local source = sources[i]
        for key in pairs(source) do
            target[key] = source[key]
        end
    end
    return target
end

local function __TS__ArraySort(self, compareFn)
    if compareFn ~= nil then
        table.sort(
            self,
            function(a, b) return compareFn(nil, a, b) < 0 end
        )
    else
        table.sort(self)
    end
    return self
end

local function __TS__CountVarargs(...)
    return select("#", ...)
end

local __TS__Unpack = table.unpack or unpack

local __TS__Generator
do
    local function generatorIterator(self)
        return self
    end
    local function generatorNext(self, ...)
        local co = self.____coroutine
        if coroutine.status(co) == "dead" then
            return {done = true}
        end
        local status, value = coroutine.resume(co, ...)
        if not status then
            error(value, 0)
        end
        return {
            value = value,
            done = coroutine.status(co) == "dead"
        }
    end
    function __TS__Generator(fn)
        return function(...)
            local args = {...}
            local argsLength = __TS__CountVarargs(...)
            return {
                ____coroutine = coroutine.create(function() return fn(__TS__Unpack(args, 1, argsLength)) end),
                [Symbol.iterator] = generatorIterator,
                next = generatorNext
            }
        end
    end
end

local function __TS__StringIncludes(self, searchString, position)
    if not position then
        position = 1
    else
        position = position + 1
    end
    local index = string.find(self, searchString, position, true)
    return index ~= nil
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

local function __TS__ObjectGetOwnPropertyDescriptors(object)
    local metatable = getmetatable(object)
    if not metatable then
        return {}
    end
    return rawget(metatable, "_descriptors") or ({})
end

local function __TS__Delete(target, key)
    local descriptors = __TS__ObjectGetOwnPropertyDescriptors(target)
    local descriptor = descriptors[key]
    if descriptor then
        if not descriptor.configurable then
            error(
                __TS__New(
                    TypeError,
                    ((("Cannot delete property " .. tostring(key)) .. " of ") .. tostring(target)) .. "."
                ),
                0
            )
        end
        descriptors[key] = nil
        return true
    end
    target[key] = nil
    return true
end

local function __TS__StringAccess(self, index)
    if index >= 0 and index < #self then
        return string.sub(self, index + 1, index + 1)
    end
end

local __TS__Match = string.match

local function __TS__ParseFloat(numberString)
    local infinityMatch = __TS__Match(numberString, "^%s*(-?Infinity)")
    if infinityMatch ~= nil then
        return __TS__StringAccess(infinityMatch, 0) == "-" and -math.huge or math.huge
    end
    local number = tonumber((__TS__Match(numberString, "^%s*(-?%d+%.?%d*)")))
    return number or 0 / 0
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

local function __TS__CloneDescriptor(____bindingPattern0)
    local value
    local writable
    local set
    local get
    local configurable
    local enumerable
    enumerable = ____bindingPattern0.enumerable
    configurable = ____bindingPattern0.configurable
    get = ____bindingPattern0.get
    set = ____bindingPattern0.set
    writable = ____bindingPattern0.writable
    value = ____bindingPattern0.value
    local descriptor = {enumerable = enumerable == true, configurable = configurable == true}
    local hasGetterOrSetter = get ~= nil or set ~= nil
    local hasValueOrWritableAttribute = writable ~= nil or value ~= nil
    if hasGetterOrSetter and hasValueOrWritableAttribute then
        error("Invalid property descriptor. Cannot both specify accessors and a value or writable attribute.", 0)
    end
    if get or set then
        descriptor.get = get
        descriptor.set = set
    else
        descriptor.value = value
        descriptor.writable = writable == true
    end
    return descriptor
end

local __TS__DescriptorGet
do
    local getmetatable = _G.getmetatable
    local ____rawget = _G.rawget
    function __TS__DescriptorGet(self, metatable, key)
        while metatable do
            local rawResult = ____rawget(metatable, key)
            if rawResult ~= nil then
                return rawResult
            end
            local descriptors = ____rawget(metatable, "_descriptors")
            if descriptors then
                local descriptor = descriptors[key]
                if descriptor ~= nil then
                    if descriptor.get then
                        return descriptor.get(self)
                    end
                    return descriptor.value
                end
            end
            metatable = getmetatable(metatable)
        end
    end
end

local __TS__DescriptorSet
do
    local getmetatable = _G.getmetatable
    local ____rawget = _G.rawget
    local rawset = _G.rawset
    function __TS__DescriptorSet(self, metatable, key, value)
        while metatable do
            local descriptors = ____rawget(metatable, "_descriptors")
            if descriptors then
                local descriptor = descriptors[key]
                if descriptor ~= nil then
                    if descriptor.set then
                        descriptor.set(self, value)
                    else
                        if descriptor.writable == false then
                            error(
                                ((("Cannot assign to read only property '" .. key) .. "' of object '") .. tostring(self)) .. "'",
                                0
                            )
                        end
                        descriptor.value = value
                    end
                    return
                end
            end
            metatable = getmetatable(metatable)
        end
        rawset(self, key, value)
    end
end

local __TS__SetDescriptor
do
    local getmetatable = _G.getmetatable
    local function descriptorIndex(self, key)
        return __TS__DescriptorGet(
            self,
            getmetatable(self),
            key
        )
    end
    local function descriptorNewIndex(self, key, value)
        return __TS__DescriptorSet(
            self,
            getmetatable(self),
            key,
            value
        )
    end
    function __TS__SetDescriptor(target, key, desc, isPrototype)
        if isPrototype == nil then
            isPrototype = false
        end
        local ____isPrototype_0
        if isPrototype then
            ____isPrototype_0 = target
        else
            ____isPrototype_0 = getmetatable(target)
        end
        local metatable = ____isPrototype_0
        if not metatable then
            metatable = {}
            setmetatable(target, metatable)
        end
        local value = rawget(target, key)
        if value ~= nil then
            rawset(target, key, nil)
        end
        if not rawget(metatable, "_descriptors") then
            metatable._descriptors = {}
        end
        metatable._descriptors[key] = __TS__CloneDescriptor(desc)
        metatable.__index = descriptorIndex
        metatable.__newindex = descriptorNewIndex
    end
end

local function __TS__ArrayFilter(self, callbackfn, thisArg)
    local result = {}
    local len = 0
    for i = 1, #self do
        if callbackfn(thisArg, self[i], i - 1, self) then
            len = len + 1
            result[len] = self[i]
        end
    end
    return result
end

local function __TS__StringStartsWith(self, searchString, position)
    if position == nil or position < 0 then
        position = 0
    end
    return string.sub(self, position + 1, #searchString + position) == searchString
end

local function __TS__ArrayMap(self, callbackfn, thisArg)
    local result = {}
    for i = 1, #self do
        result[i] = callbackfn(thisArg, self[i], i - 1, self)
    end
    return result
end

local function __TS__StringEndsWith(self, searchString, endPosition)
    if endPosition == nil or endPosition > #self then
        endPosition = #self
    end
    return string.sub(self, endPosition - #searchString + 1, endPosition) == searchString
end

local function __TS__ArrayReduce(self, callbackFn, ...)
    local len = #self
    local k = 0
    local accumulator = nil
    if __TS__CountVarargs(...) ~= 0 then
        accumulator = ...
    elseif len > 0 then
        accumulator = self[1]
        k = 1
    else
        error("Reduce of empty array with no initial value", 0)
    end
    for i = k + 1, len do
        accumulator = callbackFn(
            nil,
            accumulator,
            self[i],
            i - 1,
            self
        )
    end
    return accumulator
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

local function __TS__ObjectDefineProperty(target, key, desc)
    local luaKey = type(key) == "number" and key + 1 or key
    local value = rawget(target, luaKey)
    local hasGetterOrSetter = desc.get ~= nil or desc.set ~= nil
    local descriptor
    if hasGetterOrSetter then
        if value ~= nil then
            error(
                "Cannot redefine property: " .. tostring(key),
                0
            )
        end
        descriptor = desc
    else
        local valueExists = value ~= nil
        local ____desc_set_4 = desc.set
        local ____desc_get_5 = desc.get
        local ____desc_configurable_0 = desc.configurable
        if ____desc_configurable_0 == nil then
            ____desc_configurable_0 = valueExists
        end
        local ____desc_enumerable_1 = desc.enumerable
        if ____desc_enumerable_1 == nil then
            ____desc_enumerable_1 = valueExists
        end
        local ____desc_writable_2 = desc.writable
        if ____desc_writable_2 == nil then
            ____desc_writable_2 = valueExists
        end
        local ____temp_3
        if desc.value ~= nil then
            ____temp_3 = desc.value
        else
            ____temp_3 = value
        end
        descriptor = {
            set = ____desc_set_4,
            get = ____desc_get_5,
            configurable = ____desc_configurable_0,
            enumerable = ____desc_enumerable_1,
            writable = ____desc_writable_2,
            value = ____temp_3
        }
    end
    __TS__SetDescriptor(target, luaKey, descriptor)
    return target
end

local function __TS__ObjectEntries(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = {key, obj[key]}
    end
    return result
end

return {
  __TS__Iterator = __TS__Iterator,
  __TS__StringSlice = __TS__StringSlice,
  __TS__New = __TS__New,
  __TS__ArraySetLength = __TS__ArraySetLength,
  __TS__Class = __TS__Class,
  __TS__ObjectAssign = __TS__ObjectAssign,
  __TS__ArraySort = __TS__ArraySort,
  __TS__Generator = __TS__Generator,
  __TS__Delete = __TS__Delete,
  __TS__ParseFloat = __TS__ParseFloat,
  __TS__StringCharAt = __TS__StringCharAt,
  Error = Error,
  RangeError = RangeError,
  ReferenceError = ReferenceError,
  SyntaxError = SyntaxError,
  TypeError = TypeError,
  URIError = URIError,
  __TS__Promise = __TS__Promise,
  __TS__ParseInt = __TS__ParseInt,
  __TS__SetDescriptor = __TS__SetDescriptor,
  __TS__ClassExtends = __TS__ClassExtends,
  __TS__ArrayFilter = __TS__ArrayFilter,
  __TS__StringStartsWith = __TS__StringStartsWith,
  __TS__ArrayMap = __TS__ArrayMap,
  __TS__StringEndsWith = __TS__StringEndsWith,
  __TS__ArrayReduce = __TS__ArrayReduce,
  __TS__StringIncludes = __TS__StringIncludes,
  __TS__StringReplaceAll = __TS__StringReplaceAll,
  __TS__ObjectDefineProperty = __TS__ObjectDefineProperty,
  __TS__ObjectEntries = __TS__ObjectEntries
}
 end,
["index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local ____extstate = require("lua_modules.reaper-api.extstate")
local TypedSection = ____extstate.TypedSection
local path = require("lua_modules.reaper-api.path.path")
local ____track = require("lua_modules.reaper-api.track")
local Track = ____track.Track
local ____utils = require("lua_modules.reaper-api.utils")
local errorHandler = ____utils.errorHandler
local ____reaper_2Dmicroui = require("lua_modules.reaper-microui.build.index")
local createContext = ____reaper_2Dmicroui.createContext
local microUILoop = ____reaper_2Dmicroui.microUILoop
local Option = ____reaper_2Dmicroui.Option
local config = TypedSection(nil, "detect-offset-items", {
    windowX = "number",
    windowY = "number",
    windowW = "number",
    windowH = "number",
    windowDock = "number"
})
local function getWindowInfo(self)
    local dock, x, y, w, h = gfx.dock(
        -1,
        0,
        0,
        0,
        0
    )
    return {
        dock = dock,
        x = x,
        y = y,
        w = w,
        h = h
    }
end
local function getScriptName(self)
    local is_new_value, fullpath, sectionID, cmdID, mode, resolution, val, contextstr = reaper.get_action_context()
    local parent, filename = path.split(fullpath)
    local stem, ext = path.splitext(filename)
    return stem
end
local HIGHLIGHT_COLOR = {r = 254, g = 1, b = 2}
local function colorsEqual(self, a, b)
    return a.r == b.r and a.g == b.g and a.b == b.b
end
local FRAMESKIP = 5
local NUMBER_FORMAT = "%.12f s"
local function main(self)
    gfx.init(
        getScriptName(nil),
        config.windowW or 360,
        config.windowH or 210,
        config.windowDock or 0,
        config.windowX or 100,
        config.windowY or 50
    )
    gfx.setfont(1, "Arial", 14)
    local ctx = createContext(nil)
    ctx.style.font = 1
    local frameskipLeft = FRAMESKIP
    local posDiffs = {}
    local originalItemColors = {}
    local LOW_THRESHOLD_MIN = 0
    local LOW_THRESHOLD_MAX = 1e-9
    local HIGH_THRESHOLD_MIN = LOW_THRESHOLD_MAX
    local HIGH_THRESHOLD_MAX = 0.01
    local thresholdLow = 4.5e-10
    local thresholdHigh = HIGH_THRESHOLD_MAX
    local thresholdInclusive = false
    local checkItemEnds = false
    local checkItemSnapOffset = true
    microUILoop(
        nil,
        ctx,
        function()
            if frameskipLeft > 0 then
                frameskipLeft = frameskipLeft - 1
            else
                frameskipLeft = FRAMESKIP
                do
                    posDiffs = {}
                    local anyItemColorChanged = false
                    for ____, track in __TS__Iterator(Track:iterAll()) do
                        for ____, item in __TS__Iterator(track:iterItems()) do
                            local itemPos = checkItemEnds and item.position + item.length or (checkItemSnapOffset and item.position + item.snapOffset or item.position)
                            local gridPos = reaper.BR_GetClosestGridDivision(itemPos)
                            local posDiff = math.abs(itemPos - gridPos)
                            local color = item.color
                            local ____thresholdInclusive_0
                            if thresholdInclusive then
                                ____thresholdInclusive_0 = thresholdLow <= posDiff and posDiff <= thresholdHigh
                            else
                                ____thresholdInclusive_0 = thresholdLow < posDiff and posDiff < thresholdHigh
                            end
                            local inThreshold = ____thresholdInclusive_0
                            if inThreshold then
                                posDiffs[#posDiffs + 1] = posDiff
                                if color == nil or not colorsEqual(nil, color, HIGHLIGHT_COLOR) then
                                    originalItemColors[item.obj] = color
                                    item.color = HIGHLIGHT_COLOR
                                    anyItemColorChanged = true
                                end
                            else
                                if color and colorsEqual(nil, color, HIGHLIGHT_COLOR) then
                                    local originalColor = originalItemColors[item.obj]
                                    item.color = originalColor
                                    anyItemColorChanged = true
                                end
                            end
                        end
                    end
                    if anyItemColorChanged then
                        reaper.UpdateArrange()
                    end
                end
            end
            if ctx:beginWindow("Demo Window", {x = 0, y = 0, w = 0, h = 0}, Option.NoResize | Option.NoTitle | Option.NoClose) then
                local win = ctx:getCurrentContainer()
                win.rect.w = gfx.w
                win.rect.h = gfx.h
                ctx:layoutRow({-1}, 0)
                ctx:text("Highlight items that are NOT on gridlines. The threshold controls how far the item should be from a gridline.")
                ctx:label("Threshold range:")
                ctx:layoutRow({54, -1}, 0)
                ctx:label("Low:")
                thresholdLow = ctx:slider(
                    "thresholdLow",
                    thresholdLow,
                    LOW_THRESHOLD_MIN,
                    LOW_THRESHOLD_MAX,
                    nil,
                    NUMBER_FORMAT
                )
                ctx:label("High:")
                thresholdHigh = ctx:slider(
                    "thresholdHigh",
                    thresholdHigh,
                    HIGH_THRESHOLD_MIN,
                    HIGH_THRESHOLD_MAX,
                    nil,
                    NUMBER_FORMAT
                )
                ctx:layoutRow({-1}, 0)
                thresholdInclusive = ctx:checkbox("Inclusive range", thresholdInclusive)
                checkItemEnds = ctx:checkbox("Check item ends", checkItemEnds)
                if not checkItemEnds then
                    checkItemSnapOffset = ctx:checkbox("Account for item snap offset", checkItemSnapOffset)
                end
                if ctx:header("Detected offset positions") then
                    for ____, x in ipairs(posDiffs) do
                        ctx:text(string.format(NUMBER_FORMAT, x))
                    end
                end
                ctx:endWindow()
            end
        end,
        function()
            for ____, track in __TS__Iterator(Track:iterAll()) do
                for ____, item in __TS__Iterator(track:iterItems()) do
                    local currentColor = item.color
                    if currentColor and colorsEqual(nil, currentColor, HIGHLIGHT_COLOR) then
                        local oldColor = originalItemColors[item.obj]
                        item.color = oldColor
                    end
                end
            end
            reaper.UpdateArrange()
            do
                local wnd = getWindowInfo(nil)
                config.windowDock = wnd.dock
                config.windowX = wnd.x
                config.windowY = wnd.y
                config.windowW = wnd.w
                config.windowH = wnd.h
            end
        end
    )
end
errorHandler(nil, main)
return ____exports
 end,
["lua_modules.reaper-microui.build.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__StringSlice = ____lualib.__TS__StringSlice
local __TS__New = ____lualib.__TS__New
local __TS__ArraySetLength = ____lualib.__TS__ArraySetLength
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local ____ffi = require("lua_modules.reaper-microui.node_modules.reaper-api.ffi.index")
local DrawStrFlags = ____ffi.DrawStrFlags
local Mode = ____ffi.Mode
local MouseCap = ____ffi.MouseCap
local ____utils = require("lua_modules.reaper-microui.node_modules.reaper-api.utils")
local deferLoop = ____utils.deferLoop
local log = ____utils.log
local ____ui = require("lua_modules.reaper-microui.build.ui")
local ColorId = ____ui.ColorId
local CommandType = ____ui.CommandType
local Context = ____ui.Context
local createDefaultStyle = ____ui.createDefaultStyle
local IconId = ____ui.IconId
local Key = ____ui.Key
local MouseButton = ____ui.MouseButton
local Option = ____ui.Option
local Response = ____ui.Response
do
    local ____export = require("lua_modules.reaper-microui.build.ui")
    for ____exportKey, ____exportValue in pairs(____export) do
        if ____exportKey ~= "default" then
            ____exports[____exportKey] = ____exportValue
        end
    end
end
--- Create a new microUI context.
-- 
-- You must run gfx.init and gfx.setfont before calling this. E.g.:
-- 
--     gfx.init("My window", 260, 450);
--     gfx.setfont(1, "Arial", 12);
-- 
-- Afterwards, use {@link microUILoop} to run the main GUI loop.
function ____exports.createContext(self)
    return __TS__New(
        Context,
        function(____, font, str, len)
            if len ~= nil then
                str = __TS__StringSlice(str, 0, len)
            end
            gfx.setfont(font)
            local width, _ = gfx.measurestr(str)
            return width
        end,
        function(____, font)
            gfx.setfont(font)
            return gfx.texth
        end,
        createDefaultStyle(nil, 0)
    )
end
--- Main loop for a microUI GUI. Use {@link createContext} to create a context first.
-- 
-- Example code:
-- - {@link demoSimple}
-- - {@link demoSingleWindow}
-- - {@link demoMultiWindow}
function ____exports.microUILoop(self, ctx, func, cleanup)
    local downKeys = {
        left = false,
        middle = false,
        right = false,
        shift = false,
        ctrl = false,
        alt = false,
        backspace = false,
        ["return"] = false
    }
    local downChars = {}
    deferLoop(
        nil,
        function(____, stop)
            do
                downKeys.backspace = false
                downKeys["return"] = false
                __TS__ArraySetLength(downChars, 0)
                while true do
                    do
                        local char = gfx.getchar()
                        if char == -1 then
                            return stop(nil)
                        end
                        if char == 0 then
                            break
                        end
                        if char == 8 then
                            downKeys.backspace = true
                            goto __continue9
                        elseif char == 13 then
                            downKeys["return"] = true
                            goto __continue9
                        end
                        local isUnicode = char >> 24 == 117
                        if isUnicode then
                            local unicodeChar = char & 16777215
                            downChars[#downChars + 1] = utf8.char(unicodeChar)
                            goto __continue9
                        end
                        if 32 <= char and char <= 126 then
                            downChars[#downChars + 1] = utf8.char(char)
                            goto __continue9
                        end
                    end
                    ::__continue9::
                end
                if downKeys.shift then
                    ctx:inputScroll(-gfx.mouse_wheel * 0.3, gfx.mouse_hwheel * 0.3)
                else
                    ctx:inputScroll(gfx.mouse_hwheel * 0.3, -gfx.mouse_wheel * 0.3)
                end
                gfx.mouse_wheel = 0
                gfx.mouse_hwheel = 0
                ctx:inputMouseMove(gfx.mouse_x, gfx.mouse_y)
                downKeys.left = gfx.mouse_cap & MouseCap.LeftMouse ~= 0
                downKeys.middle = gfx.mouse_cap & MouseCap.MiddleMouse ~= 0
                downKeys.right = gfx.mouse_cap & MouseCap.RightMouse ~= 0
                downKeys.ctrl = gfx.mouse_cap & MouseCap.CommandKey ~= 0
                downKeys.alt = gfx.mouse_cap & MouseCap.OptionKey ~= 0
                downKeys.shift = gfx.mouse_cap & MouseCap.ShiftKey ~= 0
                ctx:inputMouseContinuous((downKeys.left and MouseButton.Left or 0) | (downKeys.middle and MouseButton.Middle or 0) | (downKeys.right and MouseButton.Right or 0))
                ctx:inputKeyContinuous((downKeys.alt and Key.Alt or 0) | (downKeys.backspace and Key.Backspace or 0) | (downKeys.ctrl and Key.Ctrl or 0) | (downKeys["return"] and Key.Return or 0) | (downKeys.shift and Key.Shift or 0))
                ctx:inputText(table.concat(downChars, ""))
            end
            ctx:begin()
            func(nil, stop)
            ctx["end"](ctx)
            local currentClip = nil
            for ____, cmd in __TS__Iterator(ctx:iterCommands()) do
                repeat
                    local ____switch19 = cmd.type
                    local ____cond19 = ____switch19 == CommandType.Clip
                    if ____cond19 then
                        do
                            currentClip = cmd.rect
                            break
                        end
                    end
                    ____cond19 = ____cond19 or ____switch19 == CommandType.Rect
                    if ____cond19 then
                        do
                            gfx.r = cmd.color.r / 255
                            gfx.g = cmd.color.g / 255
                            gfx.b = cmd.color.b / 255
                            gfx.a = cmd.color.a / 255
                            gfx.rect(cmd.rect.x, cmd.rect.y, cmd.rect.w, cmd.rect.h)
                            break
                        end
                    end
                    ____cond19 = ____cond19 or ____switch19 == CommandType.Text
                    if ____cond19 then
                        do
                            gfx.r = cmd.color.r / 255
                            gfx.g = cmd.color.g / 255
                            gfx.b = cmd.color.b / 255
                            gfx.a = cmd.color.a / 255
                            gfx.x = cmd.pos.x
                            gfx.y = cmd.pos.y
                            gfx.setfont(cmd.font)
                            if currentClip then
                                local width, height = gfx.measurestr(cmd.str)
                                width = width + 1
                                height = height + 1
                                local clipLeft = cmd.pos.x < currentClip.x
                                local clipRight = cmd.pos.x + width >= currentClip.x + currentClip.w
                                local clipTop = cmd.pos.y < currentClip.y
                                local clipBottom = cmd.pos.y + height >= currentClip.y + currentClip.h
                                if not clipLeft and not clipRight and not clipTop and not clipBottom then
                                    gfx.drawstr(cmd.str)
                                elseif not clipLeft and not clipTop then
                                    gfx.drawstr(cmd.str, 0, currentClip.x + currentClip.w, currentClip.y + currentClip.h)
                                else
                                    gfx.setimgdim(0, width, height)
                                    do
                                        gfx.r = cmd.color.r / 255
                                        gfx.g = cmd.color.g / 255
                                        gfx.b = cmd.color.b / 255
                                        gfx.a = 1
                                        gfx.a2 = 1
                                        gfx.mode = Mode.Default
                                        gfx.dest = 0
                                        gfx.rect(
                                            0,
                                            0,
                                            width,
                                            height,
                                            true
                                        )
                                        gfx.r = 0
                                        gfx.g = 0
                                        gfx.b = 0
                                        gfx.a = -1
                                        gfx.a2 = 1
                                        gfx.mode = Mode.AdditiveBlend
                                        gfx.dest = 0
                                        gfx.rect(
                                            0,
                                            0,
                                            width,
                                            height,
                                            true
                                        )
                                    end
                                    do
                                        gfx.r = 0
                                        gfx.g = 0
                                        gfx.b = 0
                                        gfx.a = 1
                                        gfx.a2 = cmd.color.a / 255
                                        gfx.mode = Mode.AdditiveBlend
                                        gfx.x = cmd.pos.x % 1
                                        gfx.y = cmd.pos.y % 1
                                        gfx.dest = 0
                                        gfx.drawstr(cmd.str, 0)
                                    end
                                    do
                                        gfx.x = 0
                                        gfx.y = 0
                                        gfx.a = 1
                                        gfx.dest = -1
                                        gfx.a2 = 1
                                        gfx.mode = Mode.Default
                                        gfx.blit(
                                            0,
                                            1,
                                            0,
                                            currentClip.x - cmd.pos.x + cmd.pos.x % 1,
                                            currentClip.y - cmd.pos.y + cmd.pos.y % 1,
                                            currentClip.w,
                                            currentClip.h,
                                            currentClip.x,
                                            currentClip.y
                                        )
                                    end
                                    do
                                        gfx.dest = -1
                                        gfx.a2 = 1
                                        gfx.mode = Mode.Default
                                    end
                                end
                            else
                                gfx.drawstr(cmd.str)
                            end
                            break
                        end
                    end
                    ____cond19 = ____cond19 or ____switch19 == CommandType.Icon
                    if ____cond19 then
                        do
                            gfx.r = cmd.color.r / 255
                            gfx.g = cmd.color.g / 255
                            gfx.b = cmd.color.b / 255
                            gfx.a = cmd.color.a / 255
                            gfx.x = cmd.rect.x
                            gfx.y = cmd.rect.y
                            repeat
                                local ____switch33 = cmd.id
                                local ____cond33 = ____switch33 == IconId.Close
                                if ____cond33 then
                                    do
                                        gfx.drawstr("✕", DrawStrFlags.CenterHorizontally | DrawStrFlags.CenterVertically, cmd.rect.x + cmd.rect.w, cmd.rect.y + cmd.rect.h)
                                        break
                                    end
                                end
                                ____cond33 = ____cond33 or ____switch33 == IconId.Check
                                if ____cond33 then
                                    do
                                        gfx.drawstr("✓", DrawStrFlags.CenterHorizontally | DrawStrFlags.CenterVertically, cmd.rect.x + cmd.rect.w, cmd.rect.y + cmd.rect.h)
                                        break
                                    end
                                end
                                ____cond33 = ____cond33 or ____switch33 == IconId.Collapsed
                                if ____cond33 then
                                    do
                                        gfx.drawstr("▸", DrawStrFlags.CenterHorizontally | DrawStrFlags.CenterVertically, cmd.rect.x + cmd.rect.w, cmd.rect.y + cmd.rect.h)
                                        break
                                    end
                                end
                                ____cond33 = ____cond33 or ____switch33 == IconId.Expanded
                                if ____cond33 then
                                    do
                                        gfx.drawstr("▾", DrawStrFlags.CenterHorizontally | DrawStrFlags.CenterVertically, cmd.rect.x + cmd.rect.w, cmd.rect.y + cmd.rect.h)
                                        break
                                    end
                                end
                                do
                                    error("unhandled icon type: " .. tostring(cmd))
                                end
                            until true
                            break
                        end
                    end
                    ____cond19 = ____cond19 or ____switch19 == CommandType.Custom
                    if ____cond19 then
                        do
                            cmd:draw(currentClip)
                            break
                        end
                    end
                    do
                        error("unhandled command type: " .. tostring(cmd))
                    end
                until true
            end
            gfx.update()
        end,
        cleanup
    )
end
function ____exports.demoMultiWindow(self)
    gfx.init("Test window", 500, 500)
    gfx.setfont(1, "Arial", 12)
    local ctx = ____exports.createContext(nil)
    ctx.style.font = 1
    local bgColor = {90, 95, 100}
    local checks = {true, false, true}
    local logWindowTextboxInput = ""
    local logWindowLogUpdated = false
    local logWindowLog = ""
    local function writeLog(self, text)
        if #logWindowLog > 0 then
            logWindowLog = logWindowLog .. "\n" .. text
        else
            logWindowLog = text
        end
        logWindowLogUpdated = true
    end
    local function logWindow(self, ctx)
        if ctx:beginWindow("Log Window", {x = 350, y = 40, w = 300, h = 200}) then
            ctx:layoutRow({-1}, -25)
            ctx:beginPanel("Log Output")
            local panel = ctx:getCurrentContainer()
            ctx:layoutRow({-1}, -1)
            ctx:text(logWindowLog)
            ctx:endPanel()
            if logWindowLogUpdated then
                panel.scroll.y = panel.contentSize.y
                logWindowLogUpdated = false
            end
            local submitted = false
            ctx:layoutRow({-70, -1}, 0)
            logWindowTextboxInput = ctx:textbox(
                "textbox",
                logWindowTextboxInput,
                Option.None,
                function(____, res)
                    if res and res & Response.Submit ~= 0 then
                        ctx:setFocus(ctx.lastId)
                        submitted = true
                    end
                end
            )
            if ctx:button("Submit") then
                submitted = true
            end
            if submitted then
                writeLog(nil, logWindowTextboxInput)
                logWindowTextboxInput = ""
            end
            ctx:endWindow()
        end
    end
    local function testWindow(self, ctx)
        if ctx:beginWindow("Demo Window", {x = 40, y = 40, w = 300, h = 450}) then
            local win = ctx:getCurrentContainer()
            win.rect.w = math.max(win.rect.w, 240)
            win.rect.h = math.max(win.rect.h, 240)
            if ctx:header("Window Info") then
                local win = ctx:getCurrentContainer()
                ctx:layoutRow({54, -1}, 0)
                ctx:label("Position:")
                ctx:label((tostring(win.rect.x) .. ", ") .. tostring(win.rect.y))
                ctx:label("Size:")
                ctx:label((tostring(win.rect.w) .. ", ") .. tostring(win.rect.h))
            end
            if ctx:header("Test Buttons", Option.Expanded) then
                ctx:layoutRow({86, -110, -1}, 0)
                ctx:label("Test buttons 1:")
                if ctx:button("Button 1") then
                    writeLog(nil, "Pressed button 1")
                end
                if ctx:button("Button 2") then
                    writeLog(nil, "Pressed button 2")
                end
                ctx:label("Test buttons 2:")
                if ctx:button("Button 3") then
                    writeLog(nil, "Pressed button 3")
                end
                if ctx:button("Popup") then
                    ctx:openPopup("Test Popup")
                end
                if ctx:beginPopup("Test Popup") then
                    ctx:button("Hello")
                    ctx:button("World")
                    ctx:endPopup()
                end
            end
            if ctx:header("Tree and Text", Option.Expanded) then
                ctx:layoutRow({140, -1}, 0)
                ctx:layoutBeginColumn()
                if ctx:beginTreenode("Test 1") then
                    if ctx:beginTreenode("Test 1a") then
                        ctx:label("Hello")
                        ctx:label("world")
                        ctx:endTreenode()
                    end
                    if ctx:beginTreenode("Test 1b") then
                        if ctx:button("Button 1") then
                            writeLog(nil, "Pressed button 1")
                        end
                        if ctx:button("Button 2") then
                            writeLog(nil, "Pressed button 2")
                        end
                        ctx:endTreenode()
                    end
                    ctx:endTreenode()
                end
                if ctx:beginTreenode("Test 2") then
                    ctx:layoutRow({54, 54}, 0)
                    if ctx:button("Button 3") then
                        writeLog(nil, "Pressed button 3")
                    end
                    if ctx:button("Button 4") then
                        writeLog(nil, "Pressed button 4")
                    end
                    if ctx:button("Button 5") then
                        writeLog(nil, "Pressed button 5")
                    end
                    if ctx:button("Button 6") then
                        writeLog(nil, "Pressed button 6")
                    end
                    ctx:endTreenode()
                end
                if ctx:beginTreenode("Test 3") then
                    checks[1] = ctx:checkbox("Checkbox 1", checks[1])
                    checks[2] = ctx:checkbox("Checkbox 2", checks[2])
                    checks[3] = ctx:checkbox("Checkbox 3", checks[3])
                    ctx:endTreenode()
                end
                ctx:layoutEndColumn()
                ctx:layoutBeginColumn()
                ctx:layoutRow({-1}, 0)
                ctx:text(("Lorem ipsum dolor sit amet, consectetur adipiscing " .. "elit. Maecenas lacinia, sem eu lacinia molestie, mi risus faucibus ") .. "ipsum, eu varius magna felis a nulla.")
                ctx:layoutEndColumn()
            end
            if ctx:header("Background Color", Option.Expanded) then
                ctx:layoutRow({-78, -1}, 74)
                ctx:layoutBeginColumn()
                ctx:layoutRow({46, -1}, 0)
                ctx:label("Red:")
                bgColor[1] = math.floor(ctx:slider("bgColor[0]", bgColor[1], 0, 255))
                ctx:label("Green:")
                bgColor[2] = math.floor(ctx:slider("bgColor[1]", bgColor[2], 0, 255))
                ctx:label("Blue:")
                bgColor[3] = math.floor(ctx:slider("bgColor[2]", bgColor[3], 0, 255))
                ctx:layoutEndColumn()
                local r = ctx:layoutNext()
                ctx:drawRect(r, {r = bgColor[1], g = bgColor[2], b = bgColor[3], a = 255})
                ctx:drawControlText(
                    string.format("#%02X%02X%02X", bgColor[1], bgColor[2], bgColor[3]),
                    r,
                    ColorId.Text,
                    Option.AlignCenter
                )
            end
            ctx:endWindow()
        end
    end
    local function uint8Slider(self, ctx, name, value, low, high)
        local res = ctx:slider(
            name,
            value,
            low,
            high,
            0,
            "%.0f",
            Option.AlignCenter
        )
        return math.floor(res)
    end
    local styleWindowFields = {
        {"text:", ColorId.Text},
        {"border:", ColorId.Border},
        {"windowbg:", ColorId.WindowBG},
        {"titlebg:", ColorId.TitleBG},
        {"titletext:", ColorId.TitleText},
        {"panelbg:", ColorId.PanelBG},
        {"button:", ColorId.Button},
        {"buttonhover:", ColorId.ButtonHover},
        {"buttonfocus:", ColorId.ButtonFocus},
        {"base:", ColorId.Base},
        {"basehover:", ColorId.BaseHover},
        {"basefocus:", ColorId.BaseFocus},
        {"scrollbase:", ColorId.ScrollBase},
        {"scrollthumb:", ColorId.ScrollThumb}
    }
    local function styleWindow(self, ctx)
        if ctx:beginWindow("Style Editor", {x = 350, y = 250, w = 300, h = 240}) then
            local sw = ctx:getCurrentContainer().body.w * 0.14
            ctx:layoutRow({
                80,
                sw,
                sw,
                sw,
                sw,
                -1
            }, 0)
            do
                local i = 0
                while i < #styleWindowFields do
                    local label, colorId = table.unpack(styleWindowFields[i + 1])
                    ctx:label(label)
                    ctx.style.colors[colorId].r = uint8Slider(
                        nil,
                        ctx,
                        label .. "!r",
                        ctx.style.colors[colorId].r,
                        0,
                        255
                    )
                    ctx.style.colors[colorId].g = uint8Slider(
                        nil,
                        ctx,
                        label .. "!g",
                        ctx.style.colors[colorId].g,
                        0,
                        255
                    )
                    ctx.style.colors[colorId].b = uint8Slider(
                        nil,
                        ctx,
                        label .. "!b",
                        ctx.style.colors[colorId].b,
                        0,
                        255
                    )
                    ctx.style.colors[colorId].a = uint8Slider(
                        nil,
                        ctx,
                        label .. "!a",
                        ctx.style.colors[colorId].a,
                        0,
                        255
                    )
                    ctx:drawRect(
                        ctx:layoutNext(),
                        ctx.style.colors[colorId]
                    )
                    i = i + 1
                end
            end
            ctx:endWindow()
        end
    end
    ____exports.microUILoop(
        nil,
        ctx,
        function()
            styleWindow(nil, ctx)
            logWindow(nil, ctx)
            testWindow(nil, ctx)
            gfx.clear = bgColor[1] + bgColor[2] * 256 + bgColor[3] * 65536
        end
    )
end
function ____exports.demoSingleWindow(self)
    gfx.init("80gray Theme Adjuster", 260, 450)
    gfx.setfont(1, "Arial", 12)
    local ctx = ____exports.createContext(nil)
    ctx.style.font = 1
    local bgColor = {90, 95, 100}
    local checks = {true, false, true}
    ____exports.microUILoop(
        nil,
        ctx,
        function()
            if ctx:beginWindow("Demo Window", {x = 0, y = 0, w = 0, h = 0}, Option.NoResize | Option.NoTitle | Option.NoClose) then
                local win = ctx:getCurrentContainer()
                win.rect.w = gfx.w
                win.rect.h = gfx.h
                if ctx:header("Window Info") then
                    local win = ctx:getCurrentContainer()
                    ctx:layoutRow({54, -1}, 0)
                    ctx:label("Position:")
                    ctx:label((tostring(win.rect.x) .. ", ") .. tostring(win.rect.y))
                    ctx:label("Size:")
                    ctx:label((tostring(win.rect.w) .. ", ") .. tostring(win.rect.h))
                end
                if ctx:header("Test Buttons", Option.Expanded) then
                    ctx:layoutRow({86, -110, -1}, 0)
                    ctx:label("Test buttons 1:")
                    if ctx:button("Button 1") then
                        log(nil, "Pressed button 1")
                    end
                    if ctx:button("Button 2") then
                        log(nil, "Pressed button 2")
                    end
                    ctx:label("Test buttons 2:")
                    if ctx:button("Button 3") then
                        log(nil, "Pressed button 3")
                    end
                    if ctx:button("Popup") then
                        ctx:openPopup("Test Popup")
                    end
                    if ctx:beginPopup("Test Popup") then
                        ctx:button("Hello")
                        ctx:button("World")
                        ctx:endPopup()
                    end
                end
                if ctx:header("Tree and Text", Option.Expanded) then
                    ctx:layoutRow({140, -1}, 0)
                    ctx:layoutBeginColumn()
                    if ctx:beginTreenode("Test 1") then
                        if ctx:beginTreenode("Test 1a") then
                            ctx:label("Hello")
                            ctx:label("world")
                            ctx:endTreenode()
                        end
                        if ctx:beginTreenode("Test 1b") then
                            if ctx:button("Button 1") then
                                log(nil, "Pressed button 1")
                            end
                            if ctx:button("Button 2") then
                                log(nil, "Pressed button 2")
                            end
                            ctx:endTreenode()
                        end
                        ctx:endTreenode()
                    end
                    if ctx:beginTreenode("Test 2") then
                        ctx:layoutRow({54, 54}, 0)
                        if ctx:button("Button 3") then
                            log(nil, "Pressed button 3")
                        end
                        if ctx:button("Button 4") then
                            log(nil, "Pressed button 4")
                        end
                        if ctx:button("Button 5") then
                            log(nil, "Pressed button 5")
                        end
                        if ctx:button("Button 6") then
                            log(nil, "Pressed button 6")
                        end
                        ctx:endTreenode()
                    end
                    if ctx:beginTreenode("Test 3") then
                        checks[1] = ctx:checkbox("Checkbox 1", checks[1])
                        checks[2] = ctx:checkbox("Checkbox 2", checks[2])
                        checks[3] = ctx:checkbox("Checkbox 3", checks[3])
                        ctx:endTreenode()
                    end
                    ctx:layoutEndColumn()
                    ctx:layoutBeginColumn()
                    ctx:layoutRow({-1}, 0)
                    ctx:text(("Lorem ipsum dolor sit amet, consectetur adipiscing " .. "elit. Maecenas lacinia, sem eu lacinia molestie, mi risus faucibus ") .. "ipsum, eu varius magna felis a nulla.")
                    ctx:layoutEndColumn()
                end
                if ctx:header("Background Color", Option.Expanded) then
                    ctx:layoutRow({-78, -1}, 74)
                    ctx:layoutBeginColumn()
                    ctx:layoutRow({46, -1}, 0)
                    ctx:label("Red:")
                    bgColor[1] = math.floor(ctx:slider("bgColor[0]", bgColor[1], 0, 255))
                    ctx:label("Green:")
                    bgColor[2] = math.floor(ctx:slider("bgColor[1]", bgColor[2], 0, 255))
                    ctx:label("Blue:")
                    bgColor[3] = math.floor(ctx:slider("bgColor[2]", bgColor[3], 0, 255))
                    ctx:layoutEndColumn()
                    local r = ctx:layoutNext()
                    ctx:drawRect(r, {r = bgColor[1], g = bgColor[2], b = bgColor[3], a = 255})
                    ctx:drawControlText(
                        string.format("#%02X%02X%02X", bgColor[1], bgColor[2], bgColor[3]),
                        r,
                        ColorId.Text,
                        Option.AlignCenter
                    )
                end
                ctx:endWindow()
            end
            gfx.clear = bgColor[1] + bgColor[2] * 256 + bgColor[3] * 65536
        end
    )
end
function ____exports.demoSimple(self)
    gfx.init("My Window", 260, 450)
    gfx.setfont(1, "Arial", 12)
    local ctx = ____exports.createContext(nil)
    ctx.style.font = 1
    local checks = {true, false, true}
    ____exports.microUILoop(
        nil,
        ctx,
        function()
            if ctx:beginWindow("Demo Window", {x = 0, y = 0, w = 0, h = 0}, Option.NoResize | Option.NoTitle | Option.NoClose) then
                local win = ctx:getCurrentContainer()
                win.rect.w = gfx.w
                win.rect.h = gfx.h
                if ctx:header("Window Info") then
                    local win = ctx:getCurrentContainer()
                    ctx:layoutRow({54, -1}, 0)
                    ctx:label("Position:")
                    ctx:label((tostring(win.rect.x) .. ", ") .. tostring(win.rect.y))
                    ctx:label("Size:")
                    ctx:label((tostring(win.rect.w) .. ", ") .. tostring(win.rect.h))
                end
                if ctx:header("Test Buttons", Option.Expanded) then
                    ctx:layoutRow({86, -110, -1}, 0)
                    ctx:label("Test buttons 1:")
                    if ctx:button("Button 1") then
                        log(nil, "Pressed button 1")
                    end
                    if ctx:button("Button 2") then
                        log(nil, "Pressed button 2")
                    end
                    ctx:label("Test buttons 2:")
                    if ctx:button("Button 3") then
                        log(nil, "Pressed button 3")
                    end
                    if ctx:button("Popup") then
                        ctx:openPopup("Test Popup")
                    end
                    if ctx:beginPopup("Test Popup") then
                        ctx:button("Hello")
                        ctx:button("World")
                        ctx:endPopup()
                    end
                end
                if ctx:header("Tree and Text", Option.Expanded) then
                    ctx:layoutRow({140, -1}, 0)
                    ctx:layoutBeginColumn()
                    if ctx:beginTreenode("Test 1") then
                        if ctx:beginTreenode("Test 1a") then
                            ctx:label("Hello")
                            ctx:label("world")
                            ctx:endTreenode()
                        end
                        if ctx:beginTreenode("Test 1b") then
                            if ctx:button("Button 1") then
                                log(nil, "Pressed button 1")
                            end
                            if ctx:button("Button 2") then
                                log(nil, "Pressed button 2")
                            end
                            ctx:endTreenode()
                        end
                        ctx:endTreenode()
                    end
                    if ctx:beginTreenode("Test 2") then
                        checks[1] = ctx:checkbox("Checkbox 1", checks[1])
                        checks[2] = ctx:checkbox("Checkbox 2", checks[2])
                        checks[3] = ctx:checkbox("Checkbox 3", checks[3])
                        ctx:endTreenode()
                    end
                    ctx:layoutEndColumn()
                    ctx:layoutBeginColumn()
                    ctx:layoutRow({-1}, 0)
                    ctx:text(("Lorem ipsum dolor sit amet, consectetur adipiscing " .. "elit. Maecenas lacinia, sem eu lacinia molestie, mi risus faucibus ") .. "ipsum, eu varius magna felis a nulla.")
                    ctx:layoutEndColumn()
                end
                ctx:endWindow()
            end
        end
    )
end
return ____exports
 end,
["lua_modules.reaper-microui.build.ui"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__ArraySort = ____lualib.__TS__ArraySort
local __TS__Generator = ____lualib.__TS__Generator
local __TS__Delete = ____lualib.__TS__Delete
local __TS__StringSlice = ____lualib.__TS__StringSlice
local __TS__ParseFloat = ____lualib.__TS__ParseFloat
local __TS__StringCharAt = ____lualib.__TS__StringCharAt
local ____exports = {}
local ____deepcopy = require("lua_modules.reaper-microui.build.deepcopy")
local deepcopy = ____deepcopy.deepcopy
local ____hash = require("lua_modules.reaper-microui.build.hash")
local HASH_INITIAL = ____hash.HASH_INITIAL
local hashString = ____hash.hashString
____exports.MouseButton = MouseButton or ({})
____exports.MouseButton.None = 0
____exports.MouseButton[____exports.MouseButton.None] = "None"
____exports.MouseButton.Left = 1
____exports.MouseButton[____exports.MouseButton.Left] = "Left"
____exports.MouseButton.Right = 2
____exports.MouseButton[____exports.MouseButton.Right] = "Right"
____exports.MouseButton.Middle = 4
____exports.MouseButton[____exports.MouseButton.Middle] = "Middle"
____exports.Key = Key or ({})
____exports.Key.None = 0
____exports.Key[____exports.Key.None] = "None"
____exports.Key.Shift = 1
____exports.Key[____exports.Key.Shift] = "Shift"
____exports.Key.Ctrl = 2
____exports.Key[____exports.Key.Ctrl] = "Ctrl"
____exports.Key.Alt = 4
____exports.Key[____exports.Key.Alt] = "Alt"
____exports.Key.Backspace = 8
____exports.Key[____exports.Key.Backspace] = "Backspace"
____exports.Key.Return = 16
____exports.Key[____exports.Key.Return] = "Return"
____exports.Option = Option or ({})
____exports.Option.None = 0
____exports.Option[____exports.Option.None] = "None"
____exports.Option.AlignCenter = 1
____exports.Option[____exports.Option.AlignCenter] = "AlignCenter"
____exports.Option.AlignRight = 2
____exports.Option[____exports.Option.AlignRight] = "AlignRight"
____exports.Option.NoInteract = 4
____exports.Option[____exports.Option.NoInteract] = "NoInteract"
____exports.Option.NoFrame = 8
____exports.Option[____exports.Option.NoFrame] = "NoFrame"
____exports.Option.NoResize = 16
____exports.Option[____exports.Option.NoResize] = "NoResize"
____exports.Option.NoScroll = 32
____exports.Option[____exports.Option.NoScroll] = "NoScroll"
____exports.Option.NoClose = 64
____exports.Option[____exports.Option.NoClose] = "NoClose"
____exports.Option.NoTitle = 128
____exports.Option[____exports.Option.NoTitle] = "NoTitle"
____exports.Option.HoldFocus = 256
____exports.Option[____exports.Option.HoldFocus] = "HoldFocus"
____exports.Option.AutoSize = 512
____exports.Option[____exports.Option.AutoSize] = "AutoSize"
____exports.Option.Popup = 1024
____exports.Option[____exports.Option.Popup] = "Popup"
____exports.Option.Closed = 2048
____exports.Option[____exports.Option.Closed] = "Closed"
____exports.Option.Expanded = 4096
____exports.Option[____exports.Option.Expanded] = "Expanded"
local Position = Position or ({})
Position.Unset = 0
Position[Position.Unset] = "Unset"
Position.Relative = 1
Position[Position.Relative] = "Relative"
Position.Absolute = 2
Position[Position.Absolute] = "Absolute"
____exports.ColorId = ColorId or ({})
____exports.ColorId.Text = 0
____exports.ColorId[____exports.ColorId.Text] = "Text"
____exports.ColorId.Border = 1
____exports.ColorId[____exports.ColorId.Border] = "Border"
____exports.ColorId.WindowBG = 2
____exports.ColorId[____exports.ColorId.WindowBG] = "WindowBG"
____exports.ColorId.TitleBG = 3
____exports.ColorId[____exports.ColorId.TitleBG] = "TitleBG"
____exports.ColorId.TitleText = 4
____exports.ColorId[____exports.ColorId.TitleText] = "TitleText"
____exports.ColorId.PanelBG = 5
____exports.ColorId[____exports.ColorId.PanelBG] = "PanelBG"
____exports.ColorId.Button = 6
____exports.ColorId[____exports.ColorId.Button] = "Button"
____exports.ColorId.ButtonHover = 7
____exports.ColorId[____exports.ColorId.ButtonHover] = "ButtonHover"
____exports.ColorId.ButtonFocus = 8
____exports.ColorId[____exports.ColorId.ButtonFocus] = "ButtonFocus"
____exports.ColorId.Base = 9
____exports.ColorId[____exports.ColorId.Base] = "Base"
____exports.ColorId.BaseHover = 10
____exports.ColorId[____exports.ColorId.BaseHover] = "BaseHover"
____exports.ColorId.BaseFocus = 11
____exports.ColorId[____exports.ColorId.BaseFocus] = "BaseFocus"
____exports.ColorId.ScrollBase = 12
____exports.ColorId[____exports.ColorId.ScrollBase] = "ScrollBase"
____exports.ColorId.ScrollThumb = 13
____exports.ColorId[____exports.ColorId.ScrollThumb] = "ScrollThumb"
function ____exports.rgba(self, r, g, b, a)
    return {r = r, g = g, b = b, a = a * 255}
end
____exports.Response = Response or ({})
____exports.Response.Active = 1
____exports.Response[____exports.Response.Active] = "Active"
____exports.Response.Submit = 2
____exports.Response[____exports.Response.Submit] = "Submit"
____exports.Response.Change = 4
____exports.Response[____exports.Response.Change] = "Change"
function ____exports.createDefaultStyle(self, font)
    return {
        font = font,
        size = {x = 68, y = 10},
        padding = 5,
        spacing = 4,
        indent = 24,
        titleHeight = 24,
        scrollbarSize = 12,
        thumbSize = 8,
        colors = {
            [____exports.ColorId.Text] = ____exports.rgba(
                nil,
                230,
                230,
                230,
                1
            ),
            [____exports.ColorId.Border] = ____exports.rgba(
                nil,
                25,
                25,
                25,
                1
            ),
            [____exports.ColorId.WindowBG] = ____exports.rgba(
                nil,
                50,
                50,
                50,
                1
            ),
            [____exports.ColorId.TitleBG] = ____exports.rgba(
                nil,
                25,
                25,
                25,
                1
            ),
            [____exports.ColorId.TitleText] = ____exports.rgba(
                nil,
                240,
                240,
                240,
                1
            ),
            [____exports.ColorId.PanelBG] = ____exports.rgba(
                nil,
                0,
                0,
                0,
                0
            ),
            [____exports.ColorId.Button] = ____exports.rgba(
                nil,
                75,
                75,
                75,
                1
            ),
            [____exports.ColorId.ButtonHover] = ____exports.rgba(
                nil,
                95,
                95,
                95,
                1
            ),
            [____exports.ColorId.ButtonFocus] = ____exports.rgba(
                nil,
                115,
                115,
                115,
                1
            ),
            [____exports.ColorId.Base] = ____exports.rgba(
                nil,
                30,
                30,
                30,
                1
            ),
            [____exports.ColorId.BaseHover] = ____exports.rgba(
                nil,
                35,
                35,
                35,
                1
            ),
            [____exports.ColorId.BaseFocus] = ____exports.rgba(
                nil,
                40,
                40,
                40,
                1
            ),
            [____exports.ColorId.ScrollBase] = ____exports.rgba(
                nil,
                43,
                43,
                43,
                1
            ),
            [____exports.ColorId.ScrollThumb] = ____exports.rgba(
                nil,
                30,
                30,
                30,
                1
            )
        }
    }
end
function ____exports.vec2(self, x, y)
    return {x = x, y = y}
end
function ____exports.rect(self, x, y, w, h)
    return {x = x, y = y, w = w, h = h}
end
local function clamp(self, x, min, max)
    return math.min(
        math.max(x, min),
        max
    )
end
local function rectOverlapsVec2(self, r, p)
    return p.x >= r.x and p.x < r.x + r.w and p.y >= r.y and p.y < r.y + r.h
end
local function intersectRects(self, r1, r2)
    local x1 = math.max(r1.x, r2.x)
    local y1 = math.max(r1.y, r2.y)
    local x2 = math.min(r1.x + r1.w, r2.x + r2.w)
    local y2 = math.min(r1.y + r1.h, r2.y + r2.h)
    if x2 < x1 then
        x2 = x1
    end
    if y2 < y1 then
        y2 = y1
    end
    return {x = x1, y = y1, w = x2 - x1, h = y2 - y1}
end
function ____exports.expandRect(self, rect, n)
    return {x = rect.x - n, y = rect.y - n, w = rect.w + n * 2, h = rect.h + n * 2}
end
local UNCLIPPED_RECT = {x = 0, y = 0, w = 16777216, h = 16777216}
____exports.Clip = Clip or ({})
____exports.Clip.None = 0
____exports.Clip[____exports.Clip.None] = "None"
____exports.Clip.Part = 1
____exports.Clip[____exports.Clip.Part] = "Part"
____exports.Clip.All = 2
____exports.Clip[____exports.Clip.All] = "All"
____exports.IconId = IconId or ({})
____exports.IconId.Close = 0
____exports.IconId[____exports.IconId.Close] = "Close"
____exports.IconId.Check = 1
____exports.IconId[____exports.IconId.Check] = "Check"
____exports.IconId.Collapsed = 2
____exports.IconId[____exports.IconId.Collapsed] = "Collapsed"
____exports.IconId.Expanded = 3
____exports.IconId[____exports.IconId.Expanded] = "Expanded"
____exports.CommandType = CommandType or ({})
____exports.CommandType.Jump = 0
____exports.CommandType[____exports.CommandType.Jump] = "Jump"
____exports.CommandType.Clip = 1
____exports.CommandType[____exports.CommandType.Clip] = "Clip"
____exports.CommandType.Rect = 2
____exports.CommandType[____exports.CommandType.Rect] = "Rect"
____exports.CommandType.Text = 3
____exports.CommandType[____exports.CommandType.Text] = "Text"
____exports.CommandType.Icon = 4
____exports.CommandType[____exports.CommandType.Icon] = "Icon"
____exports.CommandType.Custom = 5
____exports.CommandType[____exports.CommandType.Custom] = "Custom"
local MU_REAL_FMT = "%.3g"
local MU_MAX_FMT = 127
local MU_SLIDER_FMT = "%.2f"
____exports.Context = __TS__Class()
local Context = ____exports.Context
Context.name = "Context"
function Context.prototype.____constructor(self, textWidth, textHeight, style)
    self.textWidth = textWidth
    self.textHeight = textHeight
    self.style = style
    self.hover = nil
    self.focus = nil
    self.lastId = nil
    self.lastRect = nil
    self.lastZindex = 0
    self.updatedFocus = false
    self.hoverRoot = nil
    self.nextHoverRoot = nil
    self.scrollTarget = nil
    self.numberEditBuf = ""
    self.numberEdit = nil
    self.treeNodes = {}
    self.commands = {}
    self.roots = {}
    self.containerStack = {}
    self.clipStack = {}
    self.idStack = {}
    self.layoutStack = {}
    self.containers = {}
    self.mousePos = {x = 0, y = 0}
    self.lastMousePos = {x = 0, y = 0}
    self.mouseDelta = {x = 0, y = 0}
    self.scrollDelta = {x = 0, y = 0}
    self.mouseDown = ____exports.MouseButton.None
    self.mousePressed = ____exports.MouseButton.None
    self.keyDown = ____exports.Key.None
    self.keyPressed = ____exports.Key.None
    self._inputText = ""
end
function Context.prototype.inputMouseMove(self, x, y)
    self.mousePos.x = x
    self.mousePos.y = y
end
function Context.prototype.inputScroll(self, x, y)
    local ____self_scrollDelta_0, ____x_1 = self.scrollDelta, "x"
    ____self_scrollDelta_0[____x_1] = ____self_scrollDelta_0[____x_1] + x
    local ____self_scrollDelta_2, ____y_3 = self.scrollDelta, "y"
    ____self_scrollDelta_2[____y_3] = ____self_scrollDelta_2[____y_3] + y
end
function Context.prototype.inputText(self, text)
    self._inputText = text
end
function Context.prototype.inputMouseDown(self, btn)
    self.mouseDown = self.mouseDown | btn
    self.mousePressed = self.mousePressed | btn
end
function Context.prototype.inputMouseUp(self, btn)
    self.mouseDown = self.mouseDown & ~btn
end
function Context.prototype.inputMouseContinuous(self, btn)
    self.mousePressed = self.mousePressed | btn & ~self.mouseDown
    self.mouseDown = btn
end
function Context.prototype.inputKeyDown(self, key)
    self.keyDown = self.keyDown | key
    self.keyPressed = self.keyPressed | key
end
function Context.prototype.inputKeyUp(self, key)
    self.keyDown = self.keyDown & ~key
end
function Context.prototype.inputKeyContinuous(self, key)
    self.keyPressed = self.keyPressed | key & ~self.keyDown
    self.keyDown = key
end
function Context.prototype.begin(self)
    self.commands = {}
    self.roots = {}
    self.scrollTarget = nil
    self.hoverRoot = self.nextHoverRoot
    self.nextHoverRoot = nil
    self.mouseDelta.x = self.mousePos.x - self.lastMousePos.x
    self.mouseDelta.y = self.mousePos.y - self.lastMousePos.y
end
function Context.prototype.getId(self, name)
    local initialId = #self.idStack == 0 and HASH_INITIAL or self.idStack[#self.idStack]
    local newId = hashString(nil, initialId, name)
    self.lastId = newId
    return newId
end
function Context.prototype.pushId(self, name)
    local ____self_idStack_4 = self.idStack
    ____self_idStack_4[#____self_idStack_4 + 1] = self:getId(name)
end
function Context.prototype.popId(self)
    table.remove(self.idStack)
end
function Context.prototype.bringToFront(self, cnt)
    local ____cnt_8 = cnt
    local ____self_5, ____lastZindex_6 = self, "lastZindex"
    local ____self_lastZindex_7 = ____self_5[____lastZindex_6] + 1
    ____self_5[____lastZindex_6] = ____self_lastZindex_7
    ____cnt_8.zindex = ____self_lastZindex_7
end
function Context.prototype.getContainer(self, id, opt)
    if opt == nil then
        opt = ____exports.Option.None
    end
    if self.containers[id] ~= nil then
        return self.containers[id]
    end
    if opt & ____exports.Option.Closed ~= 0 then
        return nil
    end
    local container = {
        headIdx = nil,
        tailIdx = nil,
        rect = {x = 0, y = 0, w = 0, h = 0},
        body = {x = 0, y = 0, w = 0, h = 0},
        contentSize = {x = 0, y = 0},
        scroll = {x = 0, y = 0},
        zindex = 0,
        open = true,
        root = false
    }
    self:bringToFront(container)
    self.containers[id] = container
    return container
end
function Context.prototype.getCurrentContainer(self)
    assert(#self.containerStack > 0, "attempted to get current container when there are no containers")
    return self.containerStack[#self.containerStack]
end
function Context.prototype.inHoverRoot(self)
    do
        local i = #self.containerStack - 1
        while i >= 0 do
            local cnt = self.containerStack[i + 1]
            if cnt == self.hoverRoot then
                return true
            end
            if cnt.root then
                break
            end
            i = i - 1
        end
    end
    return false
end
function Context.prototype.getClipRect(self)
    assert(#self.clipStack > 0)
    return self.clipStack[#self.clipStack]
end
function Context.prototype.mouseOver(self, rect)
    return rectOverlapsVec2(nil, rect, self.mousePos) and rectOverlapsVec2(
        nil,
        self:getClipRect(),
        self.mousePos
    ) and self:inHoverRoot()
end
function Context.prototype.setFocus(self, id)
    self.focus = id
    self.updatedFocus = true
end
function Context.prototype.updateControl(self, id, rect, opt)
    if self.focus == id then
        self.updatedFocus = true
    end
    if opt & ____exports.Option.NoInteract ~= 0 then
        return
    end
    local mouseover = self:mouseOver(rect)
    if mouseover and self.mouseDown == 0 then
        self.hover = id
    end
    if self.focus == id then
        if self.mousePressed ~= 0 and not mouseover then
            self:setFocus(nil)
        end
        if self.mouseDown == 0 and opt & ____exports.Option.HoldFocus == 0 then
            self:setFocus(nil)
        end
    end
    if self.hover == id then
        if self.mousePressed ~= 0 then
            self:setFocus(id)
        elseif not mouseover then
            self.hover = nil
        end
    end
end
function Context.prototype.pushJump(self, dstIdx, oob)
    if oob == nil then
        oob = false
    end
    if not oob then
        assert(dstIdx ~= nil and 0 <= dstIdx and dstIdx < #self.commands, "attempted to push jump command to out-of-bounds")
    end
    local cmd = {type = ____exports.CommandType.Jump, dstIdx = dstIdx}
    local ____self_commands_9 = self.commands
    ____self_commands_9[#____self_commands_9 + 1] = cmd
    return #self.commands - 1
end
function Context.prototype.beginRootContainer(self, cnt)
    local ____self_containerStack_10 = self.containerStack
    ____self_containerStack_10[#____self_containerStack_10 + 1] = cnt
    local ____self_roots_11 = self.roots
    ____self_roots_11[#____self_roots_11 + 1] = cnt
    cnt.headIdx = self:pushJump(nil, true)
    if rectOverlapsVec2(nil, cnt.rect, self.mousePos) and (not self.nextHoverRoot or cnt.zindex > self.nextHoverRoot.zindex) then
        self.nextHoverRoot = cnt
    end
    local ____self_clipStack_12 = self.clipStack
    ____self_clipStack_12[#____self_clipStack_12 + 1] = UNCLIPPED_RECT
end
function Context.prototype.drawRect(self, rect, color)
    rect = intersectRects(
        nil,
        rect,
        self:getClipRect()
    )
    if rect.w > 0 and rect.h > 0 then
        local cmd = {type = ____exports.CommandType.Rect, rect = rect, color = color}
        local ____self_commands_13 = self.commands
        ____self_commands_13[#____self_commands_13 + 1] = cmd
    end
end
function Context.prototype.drawBox(self, r, color)
    self:drawRect({x = r.x + 1, y = r.y, w = r.w - 2, h = 1}, color)
    self:drawRect({x = r.x + 1, y = r.y + r.h - 1, w = r.w - 2, h = 1}, color)
    self:drawRect({x = r.x, y = r.y, w = 1, h = r.h}, color)
    self:drawRect({x = r.x + r.w - 1, y = r.y, w = 1, h = r.h}, color)
end
function Context.prototype.drawFrame(self, rect, colorId)
    local color = self.style.colors[colorId]
    self:drawRect(rect, color)
    if colorId == ____exports.ColorId.ScrollBase or colorId == ____exports.ColorId.ScrollThumb or colorId == ____exports.ColorId.TitleBG then
        return
    end
    if self.style.colors[____exports.ColorId.Border].a > 0 then
        self:drawBox(
            ____exports.expandRect(nil, rect, 1),
            self.style.colors[____exports.ColorId.Border]
        )
    end
end
function Context.prototype.pushClipRect(self, rect)
    local last = self:getClipRect()
    local ____self_clipStack_14 = self.clipStack
    ____self_clipStack_14[#____self_clipStack_14 + 1] = intersectRects(nil, rect, last)
end
function Context.prototype.popClipRect(self)
    table.remove(self.clipStack)
end
function Context.prototype.checkClip(self, r)
    local cr = self:getClipRect()
    if r.x > cr.x + cr.w or r.x + r.w < cr.x or r.y > cr.y + cr.h or r.y + r.h < cr.y then
        return ____exports.Clip.All
    end
    if r.x >= cr.x and r.x + r.w <= cr.x + cr.w and r.y >= cr.y and r.y + r.h <= cr.y + cr.h then
        return ____exports.Clip.None
    end
    return ____exports.Clip.Part
end
function Context.prototype.setClip(self, rect)
    local cmd = {type = ____exports.CommandType.Clip, rect = rect}
    local ____self_commands_15 = self.commands
    ____self_commands_15[#____self_commands_15 + 1] = cmd
end
function Context.prototype.drawText(self, font, str, len, pos, color)
    local ____pos_x_20 = pos.x
    local ____pos_y_21 = pos.y
    local ____self_textWidth_19 = self.textWidth
    local ____font_17 = font
    local ____str_18 = str
    local ____temp_16
    if len == nil then
        ____temp_16 = nil
    else
        ____temp_16 = len
    end
    local rect = {
        x = ____pos_x_20,
        y = ____pos_y_21,
        w = ____self_textWidth_19(self, ____font_17, ____str_18, ____temp_16),
        h = self:textHeight(font)
    }
    local clipped = self:checkClip(rect)
    if clipped == ____exports.Clip.All then
        return
    end
    if clipped == ____exports.Clip.Part then
        self:setClip(self:getClipRect())
    end
    if len == nil then
        len = #str
    end
    local cmd = {
        type = ____exports.CommandType.Text,
        color = color,
        font = font,
        pos = pos,
        str = str
    }
    local ____self_commands_22 = self.commands
    ____self_commands_22[#____self_commands_22 + 1] = cmd
    if clipped ~= ____exports.Clip.None then
        self:setClip(UNCLIPPED_RECT)
    end
end
function Context.prototype.drawControlFrame(self, id, rect, colorid, opt)
    if opt & ____exports.Option.NoFrame ~= 0 then
        return
    end
    colorid = colorid + (self.focus == id and 2 or (self.hover == id and 1 or 0))
    self:drawFrame(rect, colorid)
end
function Context.prototype.drawControlText(self, str, rect, colorid, opt)
    local pos = {x = 0, y = 0}
    local font = self.style.font
    local tw = self:textWidth(font, str)
    self:pushClipRect(rect)
    pos.y = rect.y + (rect.h - self:textHeight(font)) / 2
    if opt & ____exports.Option.AlignCenter ~= 0 then
        pos.x = rect.x + (rect.w - tw) / 2
    elseif opt & ____exports.Option.AlignRight ~= 0 then
        pos.x = rect.x + rect.w - tw - self.style.padding
    else
        pos.x = rect.x + self.style.padding
    end
    self:drawText(
        font,
        str,
        -1,
        pos,
        self.style.colors[colorid]
    )
    self:popClipRect()
end
function Context.prototype.drawIcon(self, id, rect, color)
    local clipped = self:checkClip(rect)
    if clipped == ____exports.Clip.All then
        return
    end
    if clipped == ____exports.Clip.Part then
        self:setClip(self:getClipRect())
    end
    local cmd = {type = ____exports.CommandType.Icon, color = color, rect = rect, id = id}
    local ____self_commands_23 = self.commands
    ____self_commands_23[#____self_commands_23 + 1] = cmd
    if clipped ~= ____exports.Clip.None then
        self:setClip(UNCLIPPED_RECT)
    end
end
function Context.prototype.scrollbar(self, cnt, viewBounds, contentSize, otherDir, scrollDir, otherLength, scrollLength)
    local maxscroll = contentSize[scrollDir] - viewBounds[scrollLength]
    if maxscroll > 0 and viewBounds[scrollLength] > 0 then
        local id = self:getId("!scrollbar" .. scrollDir)
        local base = deepcopy(viewBounds)
        base[otherDir] = viewBounds[otherDir] + viewBounds[otherLength]
        base[otherLength] = self.style.scrollbarSize
        self:updateControl(id, base, 0)
        if self.focus == id and self.mouseDown == ____exports.MouseButton.Left then
            local ____cnt_scroll_24, ____scrollDir_25 = cnt.scroll, scrollDir
            ____cnt_scroll_24[____scrollDir_25] = ____cnt_scroll_24[____scrollDir_25] + self.mouseDelta[scrollDir] * contentSize[scrollDir] / base[scrollLength]
        end
        cnt.scroll[scrollDir] = clamp(nil, cnt.scroll[scrollDir], 0, maxscroll)
        self:drawFrame(base, ____exports.ColorId.ScrollBase)
        local thumb = deepcopy(base)
        thumb[scrollLength] = math.max(self.style.thumbSize, base[scrollLength] * viewBounds[scrollLength] / contentSize[scrollDir])
        thumb[scrollDir] = thumb[scrollDir] + cnt.scroll[scrollDir] * (base[scrollLength] - thumb[scrollLength]) / maxscroll
        self:drawFrame(thumb, ____exports.ColorId.ScrollThumb)
        if self:mouseOver(viewBounds) then
            self.scrollTarget = cnt
        end
    else
        cnt.scroll[scrollDir] = 0
    end
end
function Context.prototype.scrollbars(self, cnt, body)
    local sz = self.style.scrollbarSize
    local cs = deepcopy(cnt.contentSize)
    cs.x = cs.x + self.style.padding * 2
    cs.y = cs.y + self.style.padding * 2
    self:pushClipRect(body)
    if cs.y > cnt.body.h then
        body.w = body.w - sz
    end
    if cs.x > cnt.body.w then
        body.h = body.h - sz
    end
    self:scrollbar(
        cnt,
        body,
        cs,
        "x",
        "y",
        "w",
        "h"
    )
    self:scrollbar(
        cnt,
        body,
        cs,
        "y",
        "x",
        "h",
        "w"
    )
    self:popClipRect()
end
function Context.prototype.getLayout(self)
    local count = #self.layoutStack
    assert(count > 0, "layout stack is empty")
    return self.layoutStack[count]
end
function Context.prototype.layoutRow(self, widths, height)
    local layout = self:getLayout()
    if widths ~= nil then
        assert(#widths > 0, "list of widths must contain at least 1 number")
        layout.widths = {table.unpack(widths)}
    else
    end
    layout.position = {x = layout.indent, y = layout.nextRow}
    layout.size.y = height
    layout.itemIndex = 0
end
function Context.prototype.pushLayout(self, body, scroll)
    local layout = {
        body = {x = body.x - scroll.x, y = body.y - scroll.y, w = body.w, h = body.h},
        next = {x = 0, y = 0, w = 0, h = 0},
        position = {x = 0, y = 0},
        size = {x = 0, y = 0},
        max = {x = -16777216, y = -16777216},
        widths = {},
        itemIndex = 0,
        nextRow = 0,
        nextType = Position.Unset,
        indent = 0
    }
    local ____self_layoutStack_26 = self.layoutStack
    ____self_layoutStack_26[#____self_layoutStack_26 + 1] = layout
    self:layoutRow({0}, 0)
end
function Context.prototype.layoutSetNext(self, r, relative)
    local layout = self:getLayout()
    layout.next = r
    layout.nextType = relative and Position.Relative or Position.Absolute
end
function Context.prototype.layoutNext(self)
    local layout = self:getLayout()
    local res = {x = 0, y = 0, w = 0, h = 0}
    if layout.nextType ~= Position.Unset then
        local ____type = layout.nextType
        layout.nextType = Position.Unset
        res = layout.next
        if ____type == Position.Absolute then
            self.lastRect = __TS__ObjectAssign({}, res)
            return res
        end
    else
        if layout.itemIndex == #layout.widths then
            self:layoutRow(nil, layout.size.y)
        end
        res.x = layout.position.x
        res.y = layout.position.y
        res.w = #layout.widths > 0 and layout.widths[layout.itemIndex + 1] or layout.size.x
        res.h = layout.size.y
        if res.w == 0 then
            res.w = self.style.size.x + self.style.padding * 2
        end
        if res.h == 0 then
            res.h = self.style.size.y + self.style.padding * 2
        end
        if res.w < 0 then
            res.w = res.w + (layout.body.w - res.x + 1)
        end
        if res.h < 0 then
            res.h = res.h + (layout.body.h - res.y + 1)
        end
        layout.itemIndex = layout.itemIndex + 1
    end
    local ____layout_position_27, ____x_28 = layout.position, "x"
    ____layout_position_27[____x_28] = ____layout_position_27[____x_28] + (res.w + self.style.spacing)
    layout.nextRow = math.max(layout.nextRow, res.y + res.h + self.style.spacing)
    res.x = res.x + layout.body.x
    res.y = res.y + layout.body.y
    layout.max.x = math.max(layout.max.x, res.x + res.w)
    layout.max.y = math.max(layout.max.y, res.y + res.h)
    self.lastRect = __TS__ObjectAssign({}, res)
    return res
end
function Context.prototype.pushContainerBody(self, cnt, body, opt)
    if opt & ____exports.Option.NoScroll == 0 then
        self:scrollbars(cnt, body)
    end
    self:pushLayout(
        ____exports.expandRect(nil, body, -self.style.padding),
        cnt.scroll
    )
    cnt.body = body
end
function Context.prototype.beginWindow(self, title, rect, opt)
    if opt == nil then
        opt = ____exports.Option.None
    end
    local id = self:getId(title)
    local cnt = self:getContainer(id, opt)
    if not cnt or not cnt.open then
        return false
    end
    local ____self_idStack_29 = self.idStack
    ____self_idStack_29[#____self_idStack_29 + 1] = id
    if cnt.rect.w == 0 then
        cnt.rect = rect
    else
        rect = cnt.rect
    end
    local body = deepcopy(rect)
    self:beginRootContainer(cnt)
    if opt & ____exports.Option.NoFrame == 0 then
        self:drawFrame(rect, ____exports.ColorId.WindowBG)
    end
    if opt & ____exports.Option.NoTitle == 0 then
        local tr = __TS__ObjectAssign({}, rect, {h = self.style.titleHeight})
        self:drawFrame(tr, ____exports.ColorId.TitleBG)
        local id = self:getId("!title")
        self:updateControl(id, tr, opt)
        self:drawControlText(title, tr, ____exports.ColorId.TitleText, opt)
        if self.focus == id and self.mouseDown == ____exports.MouseButton.Left then
            local ____cnt_rect_30, ____x_31 = cnt.rect, "x"
            ____cnt_rect_30[____x_31] = ____cnt_rect_30[____x_31] + self.mouseDelta.x
            local ____cnt_rect_32, ____y_33 = cnt.rect, "y"
            ____cnt_rect_32[____y_33] = ____cnt_rect_32[____y_33] + self.mouseDelta.y
        end
        body.y = body.y + tr.h
        body.h = body.h - tr.h
        if opt & ____exports.Option.NoClose == 0 then
            local id = self:getId("!close")
            local r = {x = tr.x + tr.w - tr.h, y = tr.y, w = tr.h, h = tr.h}
            tr.w = tr.w - r.w
            self:drawIcon(____exports.IconId.Close, r, self.style.colors[____exports.ColorId.TitleText])
            self:updateControl(id, r, opt)
            if self.focus == id and self.mouseDown == ____exports.MouseButton.Left then
                cnt.open = false
            end
        end
    end
    self:pushContainerBody(cnt, body, opt)
    if opt & ____exports.Option.NoResize == 0 then
        local sz = self.style.titleHeight
        local id = self:getId("!resize")
        local r = {x = rect.x + rect.w - sz, y = rect.y + rect.h - sz, w = sz, h = sz}
        self:updateControl(id, r, opt)
        if self.focus == id and self.mouseDown == ____exports.MouseButton.Left then
            cnt.rect.w = math.max(96, cnt.rect.w + self.mouseDelta.x)
            cnt.rect.h = math.max(64, cnt.rect.h + self.mouseDelta.y)
        end
    end
    if opt & ____exports.Option.AutoSize ~= 0 then
        local r = self:getLayout().body
        cnt.rect.w = cnt.contentSize.x + (cnt.rect.w - r.w)
        cnt.rect.h = cnt.contentSize.y + (cnt.rect.h - r.h)
    end
    if opt & ____exports.Option.Popup ~= 0 and self.mousePressed ~= 0 and self.hoverRoot ~= cnt then
        cnt.open = false
    end
    self:pushClipRect(cnt.body)
    return ____exports.Response.Active
end
function Context.prototype.popContainer(self)
    local cnt = self:getCurrentContainer()
    local layout = self:getLayout()
    cnt.contentSize.x = layout.max.x - layout.body.x
    cnt.contentSize.y = layout.max.y - layout.body.y
    table.remove(self.containerStack)
    table.remove(self.layoutStack)
    table.remove(self.idStack)
end
function Context.prototype.endRootContainer(self)
    local cnt = self:getCurrentContainer()
    cnt.tailIdx = self:pushJump(nil, true)
    if cnt.headIdx == nil then
        error("container headIdx is null when ending root container")
    end
    local head = self.commands[cnt.headIdx + 1]
    if head.type ~= ____exports.CommandType.Jump then
        error("container headIdx doesn't point to Jump command")
    end
    head.dstIdx = #self.commands
    self:popClipRect()
    self:popContainer()
end
function Context.prototype.endWindow(self)
    self:popClipRect()
    self:endRootContainer()
end
Context.prototype["end"] = function(self)
    assert(#self.containerStack == 0)
    assert(#self.clipStack == 0)
    assert(#self.idStack == 0)
    assert(#self.layoutStack == 0)
    if self.scrollTarget ~= nil then
        local ____self_scrollTarget_scroll_34, ____x_35 = self.scrollTarget.scroll, "x"
        ____self_scrollTarget_scroll_34[____x_35] = ____self_scrollTarget_scroll_34[____x_35] + self.scrollDelta.x
        local ____self_scrollTarget_scroll_36, ____y_37 = self.scrollTarget.scroll, "y"
        ____self_scrollTarget_scroll_36[____y_37] = ____self_scrollTarget_scroll_36[____y_37] + self.scrollDelta.y
    end
    if not self.updatedFocus then
        self.focus = nil
    end
    self.updatedFocus = false
    if self.mousePressed ~= 0 and self.nextHoverRoot ~= nil and self.nextHoverRoot.zindex < self.lastZindex and self.nextHoverRoot.zindex >= 0 then
        self:bringToFront(self.nextHoverRoot)
    end
    self.keyPressed = ____exports.Key.None
    self._inputText = ""
    self.mousePressed = ____exports.MouseButton.None
    self.scrollDelta = {x = 0, y = 0}
    self.lastMousePos.x = self.mousePos.x
    self.lastMousePos.y = self.mousePos.y
    __TS__ArraySort(
        self.roots,
        function(____, a, b) return a.zindex - b.zindex end
    )
    do
        local i = 0
        while i < #self.roots do
            local cnt = self.roots[i + 1]
            if i == 0 then
                local cmd = self.commands[1]
                if cmd.type ~= ____exports.CommandType.Jump then
                    error("first command in list should be jump")
                end
                if cnt.headIdx == nil then
                    error("headIdx of container is not set")
                end
                cmd.dstIdx = cnt.headIdx + 1
            else
                local prev = self.roots[i]
                if prev.tailIdx == nil then
                    error("tailIdx of container is not set")
                end
                local cmd = self.commands[prev.tailIdx + 1]
                if cmd.type ~= ____exports.CommandType.Jump then
                    error("first command in list should be jump")
                end
                if cnt.headIdx == nil then
                    error("headIdx of container is not set")
                end
                cmd.dstIdx = cnt.headIdx + 1
            end
            if i == #self.roots - 1 then
                if cnt.tailIdx == nil then
                    error("tailIdx of container is not set")
                end
                local cmd = self.commands[cnt.tailIdx + 1]
                if cmd.type ~= ____exports.CommandType.Jump then
                    error("first command in list should be jump")
                end
                cmd.dstIdx = #self.commands
            end
            i = i + 1
        end
    end
end
Context.prototype.iterCommands = __TS__Generator(function(self)
    local i = 0
    while true do
        do
            if i >= #self.commands then
                break
            end
            local cmd = self.commands[i + 1]
            if cmd.type == ____exports.CommandType.Jump then
                assert(cmd.dstIdx ~= nil, "attempt to perform Jump command with null destination")
                i = cmd.dstIdx
                goto __continue139
            end
            coroutine.yield(cmd)
            i = i + 1
        end
        ::__continue139::
    end
end)
function Context.prototype.header(self, label, opt)
    if opt == nil then
        opt = ____exports.Option.None
    end
    return self:_header(label, opt, false)
end
function Context.prototype._header(self, label, opt, istreenode)
    if opt == nil then
        opt = ____exports.Option.None
    end
    if istreenode == nil then
        istreenode = false
    end
    local id = self:getId(label)
    self:layoutRow({-1}, 0)
    local active = self.treeNodes[id] == true
    local ____temp_38
    if opt & ____exports.Option.Expanded ~= 0 then
        ____temp_38 = not active
    else
        ____temp_38 = active
    end
    local expanded = ____temp_38
    local r = self:layoutNext()
    self:updateControl(id, r, ____exports.Option.None)
    if self.mousePressed == ____exports.MouseButton.Left and self.focus == id then
        active = not active
    end
    if active then
        self.treeNodes[id] = true
    else
        __TS__Delete(self.treeNodes, id)
    end
    if istreenode then
        if self.hover == id then
            self:drawFrame(r, ____exports.ColorId.ButtonHover)
        end
    else
        self:drawControlFrame(id, r, ____exports.ColorId.Button, 0)
    end
    self:drawIcon(
        expanded and ____exports.IconId.Expanded or ____exports.IconId.Collapsed,
        ____exports.rect(
            nil,
            r.x,
            r.y,
            r.h,
            r.h
        ),
        self.style.colors[____exports.ColorId.Text]
    )
    r.x = r.x + (r.h - self.style.padding)
    r.w = r.w - (r.h - self.style.padding)
    self:drawControlText(label, r, ____exports.ColorId.Text, 0)
    return expanded and ____exports.Response.Active or false
end
function Context.prototype.label(self, text)
    self:drawControlText(
        text,
        self:layoutNext(),
        ____exports.ColorId.Text,
        0
    )
end
function Context.prototype.button(self, label, opt)
    if opt == nil then
        opt = ____exports.Option.None
    end
    local res = 0
    local id = type(label) == "string" and self:getId(label) or self:getId("icon" .. tostring(label))
    local r = self:layoutNext()
    self:updateControl(id, r, opt)
    if self.mousePressed == ____exports.MouseButton.Left and self.focus == id then
        res = res | ____exports.Response.Submit
    end
    self:drawControlFrame(id, r, ____exports.ColorId.Button, opt)
    if type(label) == "string" then
        self:drawControlText(label, r, ____exports.ColorId.Text, opt)
    else
        self:drawIcon(label, r, self.style.colors[____exports.ColorId.Text])
    end
    local ____temp_39
    if res == 0 then
        ____temp_39 = false
    else
        ____temp_39 = res
    end
    return ____temp_39
end
function Context.prototype.openPopup(self, name)
    local id = self:getId(name)
    local cnt = self:getContainer(id)
    if cnt == nil then
        error("openPopup: container is null")
    end
    self.nextHoverRoot = cnt
    self.hoverRoot = cnt
    cnt.rect = ____exports.rect(
        nil,
        self.mousePos.x,
        self.mousePos.y,
        1,
        1
    )
    cnt.open = true
    self:bringToFront(cnt)
end
function Context.prototype.beginPopup(self, name, rect, opt)
    if rect == nil then
        rect = {x = 0, y = 0, w = 0, h = 0}
    end
    if opt == nil then
        opt = ____exports.Option.Popup | ____exports.Option.AutoSize | ____exports.Option.NoResize | ____exports.Option.NoScroll | ____exports.Option.NoTitle | ____exports.Option.Closed
    end
    return self:beginWindow(name, rect, opt)
end
function Context.prototype.endPopup(self)
    self:endWindow()
end
function Context.prototype.layoutBeginColumn(self)
    self:pushLayout(
        self:layoutNext(),
        {x = 0, y = 0}
    )
end
function Context.prototype.layoutEndColumn(self)
    local b = self:getLayout()
    table.remove(self.layoutStack)
    local a = self:getLayout()
    a.position.x = math.max(a.position.x, b.position.x + b.body.x - a.body.x)
    a.nextRow = math.max(a.nextRow, b.nextRow + b.body.y - a.body.y)
    a.max.x = math.max(a.max.x, b.max.x)
    a.max.y = math.max(a.max.y, b.max.y)
end
function Context.prototype.textboxRaw(self, buf, maxBufSize, id, r, opt)
    local res = false
    self:updateControl(id, r, opt | ____exports.Option.HoldFocus)
    if self.focus == id then
        if maxBufSize == nil then
            local newCharCount = #self._inputText
            if newCharCount > 0 then
                buf = buf .. self._inputText
                res = ____exports.Response.Change
            end
        else
            local freeSpace = maxBufSize - #buf
            local newCharCount = #self._inputText
            if freeSpace > 0 and newCharCount > 0 then
                buf = buf .. __TS__StringSlice(self._inputText, 0, freeSpace)
                res = ____exports.Response.Change
            end
        end
        if self.keyPressed & ____exports.Key.Backspace ~= 0 and #buf > 0 then
            buf = __TS__StringSlice(buf, 0, #buf - 1)
            res = ____exports.Response.Change
        end
        if self.keyPressed & ____exports.Key.Return ~= 0 then
            self:setFocus(nil)
            res = ____exports.Response.Submit
        end
    end
    self:drawControlFrame(id, r, ____exports.ColorId.Base, opt)
    if self.focus == id then
        local color = self.style.colors[____exports.ColorId.Text]
        local font = self.style.font
        local textw = self:textWidth(font, buf)
        local texth = self:textHeight(font)
        local ofx = r.w - self.style.padding - textw - 1
        local textx = r.x + math.min(ofx, self.style.padding)
        local texty = r.y + (r.h - texth) / 2
        self:pushClipRect(r)
        self:drawText(
            font,
            buf,
            nil,
            {x = textx, y = texty},
            color
        )
        self:drawRect(
            ____exports.rect(
                nil,
                textx + textw,
                texty,
                1,
                texth
            ),
            color
        )
        self:popClipRect()
    else
        self:drawControlText(buf, r, ____exports.ColorId.Text, opt)
    end
    return {res, buf}
end
function Context.prototype.numberTextbox(self, value, r, id)
    if self.mousePressed == ____exports.MouseButton.Left and self.keyDown & ____exports.Key.Shift ~= 0 and self.hover == id then
        self.numberEdit = id
        self.numberEditBuf = string.format(MU_REAL_FMT, value)
    end
    if self.numberEdit == id then
        local res, newVal = table.unpack(self:textboxRaw(
            self.numberEditBuf,
            MU_MAX_FMT,
            id,
            r,
            0
        ))
        if res then
            self.numberEditBuf = newVal
        end
        if res and res & ____exports.Response.Submit ~= 0 or self.focus ~= id then
            value = __TS__ParseFloat(self.numberEditBuf)
            self.numberEdit = nil
            return {res, value}
        else
            return {____exports.Response.Active, value}
        end
    end
    return {false, value}
end
function Context.prototype.slider(self, identifier, value, low, high, step, fmt, opt)
    if fmt == nil then
        fmt = MU_SLIDER_FMT
    end
    if opt == nil then
        opt = ____exports.Option.AlignCenter
    end
    local res = false
    local last = value
    local id = self:getId(identifier)
    local base = self:layoutNext()
    local textboxRes, newVal = table.unpack(self:numberTextbox(value, base, id))
    if textboxRes then
        return newVal
    end
    self:updateControl(id, base, opt)
    if self.focus == id and self.mouseDown | self.mousePressed == ____exports.MouseButton.Left then
        value = low + (self.mousePos.x - base.x) * (high - low) / base.w
        if step ~= nil and step ~= 0 then
            value = math.floor((value - low) / step + 0.5) * step + low
            value = math.max(
                low,
                math.min(value, high)
            )
        end
    end
    value = clamp(nil, value, low, high)
    if last ~= value then
        res = ____exports.Response.Change
    end
    self:drawControlFrame(id, base, ____exports.ColorId.Base, opt)
    local w = self.style.thumbSize
    local x = (value - low) * (base.w - w) / (high - low)
    local thumb = ____exports.rect(
        nil,
        base.x + x,
        base.y,
        w,
        base.h
    )
    self:drawControlFrame(id, thumb, ____exports.ColorId.Button, opt)
    local buf = string.format(fmt, value)
    self:drawControlText(buf, base, ____exports.ColorId.Text, opt)
    return value
end
function Context.prototype.beginTreenode(self, label, opt)
    if opt == nil then
        opt = ____exports.Option.None
    end
    local res = self:_header(label, opt, true)
    if res and res & ____exports.Response.Active ~= 0 then
        local ____temp_40, ____indent_41 = self:getLayout(), "indent"
        ____temp_40[____indent_41] = ____temp_40[____indent_41] + self.style.indent
        assert(self.lastId ~= nil)
        local ____self_idStack_42 = self.idStack
        ____self_idStack_42[#____self_idStack_42 + 1] = self.lastId
    end
    return res
end
function Context.prototype.endTreenode(self)
    local ____temp_43, ____indent_44 = self:getLayout(), "indent"
    ____temp_43[____indent_44] = ____temp_43[____indent_44] - self.style.indent
    table.remove(self.idStack)
end
function Context.prototype.checkbox(self, label, state)
    local res = false
    local id = self:getId(label)
    local r = self:layoutNext()
    local box = ____exports.rect(
        nil,
        r.x,
        r.y,
        r.h,
        r.h
    )
    self:updateControl(id, r, 0)
    if self.mousePressed == ____exports.MouseButton.Left and self.focus == id then
        res = ____exports.Response.Change
        state = not state
    end
    self:drawControlFrame(id, box, ____exports.ColorId.Base, 0)
    if state then
        self:drawIcon(____exports.IconId.Check, box, self.style.colors[____exports.ColorId.Text])
    end
    local r2 = ____exports.rect(
        nil,
        r.x + box.w,
        r.y,
        r.w - box.w,
        r.h
    )
    self:drawControlText(label, r2, ____exports.ColorId.Text, 0)
    return state
end
function Context.prototype.text(self, text)
    local spaceWidth = self:textWidth(self.style.font, " ")
    local font = self.style.font
    local color = self.style.colors[____exports.ColorId.Text]
    self:layoutBeginColumn()
    self:layoutRow(
        {-1},
        self:textHeight(font)
    )
    local start = 0
    local ____end = 0
    local p = 0
    while true do
        local r = self:layoutNext()
        local currentLineWidth = 0
        ____end = p
        start = ____end
        while true do
            local wordStart = p
            local pChar
            while true do
                pChar = __TS__StringCharAt(text, p)
                if #pChar == 0 or pChar == " " or pChar == "\n" then
                    break
                end
                p = p + 1
            end
            currentLineWidth = currentLineWidth + self:textWidth(
                font,
                __TS__StringSlice(text, wordStart, p)
            )
            if currentLineWidth > r.w and ____end ~= start then
                break
            end
            if pChar == " " then
                currentLineWidth = currentLineWidth + spaceWidth
            end
            local ____p_45 = p
            p = ____p_45 + 1
            ____end = ____p_45
            local endChar = __TS__StringCharAt(text, ____end)
            if #endChar == 0 or endChar == "\n" then
                break
            end
        end
        self:drawText(
            font,
            __TS__StringSlice(text, start, ____end),
            nil,
            {x = r.x, y = r.y},
            color
        )
        p = ____end + 1
        if ____end >= #text then
            break
        end
    end
    self:layoutEndColumn()
end
function Context.prototype.textbox(self, identifier, buf, opt, responseHandler)
    if opt == nil then
        opt = ____exports.Option.None
    end
    local id = self:getId(identifier)
    local r = self:layoutNext()
    local res, newBuf = table.unpack(self:textboxRaw(
        buf,
        nil,
        id,
        r,
        opt
    ))
    if responseHandler ~= nil then
        responseHandler(nil, res, newBuf)
    end
    return newBuf
end
function Context.prototype.beginPanel(self, name, opt)
    if opt == nil then
        opt = ____exports.Option.None
    end
    local id = self:getId(name)
    local ____self_idStack_46 = self.idStack
    ____self_idStack_46[#____self_idStack_46 + 1] = id
    if self.lastId == nil then
        error("attempted to begin panel with no parent container")
    end
    local cnt = self:getContainer(self.lastId, opt)
    if cnt == nil then
        error("panel must never be closed!")
    end
    cnt.rect = self:layoutNext()
    if opt & ____exports.Option.NoFrame == 0 then
        self:drawFrame(cnt.rect, ____exports.ColorId.PanelBG)
    end
    local ____self_containerStack_47 = self.containerStack
    ____self_containerStack_47[#____self_containerStack_47 + 1] = cnt
    self:pushContainerBody(cnt, cnt.rect, opt)
    self:pushClipRect(cnt.body)
end
function Context.prototype.endPanel(self)
    self:popClipRect()
    self:popContainer()
end
return ____exports
 end,
["lua_modules.reaper-microui.build.hash"] = function(...) 
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
 end,
["lua_modules.reaper-microui.node_modules.json.index"] = function(...) 
--
-- json.lua
--
-- Copyright (c) 2020 rxi
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of
-- this software and associated documentation files (the "Software"), to deal in
-- the Software without restriction, including without limitation the rights to
-- use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
-- of the Software, and to permit persons to whom the Software is furnished to do
-- so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--

local json = { _version = "0.1.2" }

-------------------------------------------------------------------------------
-- Encode
-------------------------------------------------------------------------------

local encode

local escape_char_map = {
	["\\"] = "\\",
	['"'] = '"',
	["\b"] = "b",
	["\f"] = "f",
	["\n"] = "n",
	["\r"] = "r",
	["\t"] = "t",
}

local escape_char_map_inv = { ["/"] = "/" }
for k, v in pairs(escape_char_map) do
	escape_char_map_inv[v] = k
end

local function escape_char(c)
	return "\\" .. (escape_char_map[c] or string.format("u%04x", c:byte()))
end

local function encode_nil(val)
	return "null"
end

local function encode_table(val, stack)
	local res = {}
	stack = stack or {}

	-- Circular reference?
	if stack[val] then
		error("circular reference")
	end

	stack[val] = true

	if rawget(val, 1) ~= nil or next(val) == nil then
		-- Treat as array -- check keys are valid and it is not sparse
		local n = 0
		for k in pairs(val) do
			if type(k) ~= "number" then
				error("invalid table: mixed or invalid key types")
			end
			n = n + 1
		end
		if n ~= #val then
			error("invalid table: sparse array")
		end
		-- Encode
		for i, v in ipairs(val) do
			table.insert(res, encode(v, stack))
		end
		stack[val] = nil
		return "[" .. table.concat(res, ",") .. "]"
	else
		-- Treat as an object
		for k, v in pairs(val) do
			if type(k) ~= "string" then
				error("invalid table: mixed or invalid key types")
			end
			table.insert(res, encode(k, stack) .. ":" .. encode(v, stack))
		end
		stack[val] = nil
		return "{" .. table.concat(res, ",") .. "}"
	end
end

local function encode_string(val)
	return '"' .. val:gsub('[%z\1-\31\\"]', escape_char) .. '"'
end

local function encode_number(val)
	-- Check for NaN, -inf and inf
	if val ~= val or val <= -math.huge or val >= math.huge then
		error("unexpected number value '" .. tostring(val) .. "'")
	end
	return string.format("%.14g", val)
end

local type_func_map = {
	["nil"] = encode_nil,
	["table"] = encode_table,
	["string"] = encode_string,
	["number"] = encode_number,
	["boolean"] = tostring,
}

encode = function(val, stack)
	local t = type(val)
	local f = type_func_map[t]
	if f then
		return f(val, stack)
	end
	error("unexpected type '" .. t .. "'")
end

function json.encode(val)
	return (encode(val))
end

-------------------------------------------------------------------------------
-- Decode
-------------------------------------------------------------------------------

local parse

local function create_set(...)
	local res = {}
	for i = 1, select("#", ...) do
		res[select(i, ...)] = true
	end
	return res
end

local space_chars = create_set(" ", "\t", "\r", "\n")
local delim_chars = create_set(" ", "\t", "\r", "\n", "]", "}", ",")
local escape_chars = create_set("\\", "/", '"', "b", "f", "n", "r", "t", "u")
local literals = create_set("true", "false", "null")

local literal_map = {
	["true"] = true,
	["false"] = false,
	["null"] = nil,
}

local function next_char(str, idx, set, negate)
	for i = idx, #str do
		if set[str:sub(i, i)] ~= negate then
			return i
		end
	end
	return #str + 1
end

local function decode_error(str, idx, msg)
	local line_count = 1
	local col_count = 1
	for i = 1, idx - 1 do
		col_count = col_count + 1
		if str:sub(i, i) == "\n" then
			line_count = line_count + 1
			col_count = 1
		end
	end
	error(string.format("%s at line %d col %d", msg, line_count, col_count))
end

local function codepoint_to_utf8(n)
	-- http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=iws-appendixa
	local f = math.floor
	if n <= 0x7f then
		return string.char(n)
	elseif n <= 0x7ff then
		return string.char(f(n / 64) + 192, n % 64 + 128)
	elseif n <= 0xffff then
		return string.char(f(n / 4096) + 224, f(n % 4096 / 64) + 128, n % 64 + 128)
	elseif n <= 0x10ffff then
		return string.char(f(n / 262144) + 240, f(n % 262144 / 4096) + 128, f(n % 4096 / 64) + 128, n % 64 + 128)
	end
	error(string.format("invalid unicode codepoint '%x'", n))
end

local function parse_unicode_escape(s)
	local n1 = tonumber(s:sub(1, 4), 16)
	local n2 = tonumber(s:sub(7, 10), 16)
	-- Surrogate pair?
	if n2 then
		return codepoint_to_utf8((n1 - 0xd800) * 0x400 + (n2 - 0xdc00) + 0x10000)
	else
		return codepoint_to_utf8(n1)
	end
end

local function parse_string(str, i)
	local res = ""
	local j = i + 1
	local k = j

	while j <= #str do
		local x = str:byte(j)

		if x < 32 then
			decode_error(str, j, "control character in string")
		elseif x == 92 then -- `\`: Escape
			res = res .. str:sub(k, j - 1)
			j = j + 1
			local c = str:sub(j, j)
			if c == "u" then
				local hex = str:match("^[dD][89aAbB]%x%x\\u%x%x%x%x", j + 1)
					or str:match("^%x%x%x%x", j + 1)
					or decode_error(str, j - 1, "invalid unicode escape in string")
				res = res .. parse_unicode_escape(hex)
				j = j + #hex
			else
				if not escape_chars[c] then
					decode_error(str, j - 1, "invalid escape char '" .. c .. "' in string")
				end
				res = res .. escape_char_map_inv[c]
			end
			k = j + 1
		elseif x == 34 then -- `"`: End of string
			res = res .. str:sub(k, j - 1)
			return res, j + 1
		end

		j = j + 1
	end

	decode_error(str, i, "expected closing quote for string")
end

local function parse_number(str, i)
	local x = next_char(str, i, delim_chars)
	local s = str:sub(i, x - 1)
	local n = tonumber(s)
	if not n then
		decode_error(str, i, "invalid number '" .. s .. "'")
	end
	return n, x
end

local function parse_literal(str, i)
	local x = next_char(str, i, delim_chars)
	local word = str:sub(i, x - 1)
	if not literals[word] then
		decode_error(str, i, "invalid literal '" .. word .. "'")
	end
	return literal_map[word], x
end

local function parse_array(str, i)
	local res = {}
	local n = 1
	i = i + 1
	while 1 do
		local x
		i = next_char(str, i, space_chars, true)
		-- Empty / end of array?
		if str:sub(i, i) == "]" then
			i = i + 1
			break
		end
		-- Read token
		x, i = parse(str, i)
		res[n] = x
		n = n + 1
		-- Next token
		i = next_char(str, i, space_chars, true)
		local chr = str:sub(i, i)
		i = i + 1
		if chr == "]" then
			break
		end
		if chr ~= "," then
			decode_error(str, i, "expected ']' or ','")
		end
	end
	return res, i
end

local function parse_object(str, i)
	local res = {}
	i = i + 1
	while 1 do
		local key, val
		i = next_char(str, i, space_chars, true)
		-- Empty / end of object?
		if str:sub(i, i) == "}" then
			i = i + 1
			break
		end
		-- Read key
		if str:sub(i, i) ~= '"' then
			decode_error(str, i, "expected string for key")
		end
		key, i = parse(str, i)
		-- Read ':' delimiter
		i = next_char(str, i, space_chars, true)
		if str:sub(i, i) ~= ":" then
			decode_error(str, i, "expected ':' after key")
		end
		i = next_char(str, i + 1, space_chars, true)
		-- Read value
		val, i = parse(str, i)
		-- Set
		res[key] = val
		-- Next token
		i = next_char(str, i, space_chars, true)
		local chr = str:sub(i, i)
		i = i + 1
		if chr == "}" then
			break
		end
		if chr ~= "," then
			decode_error(str, i, "expected '}' or ','")
		end
	end
	return res, i
end

local char_func_map = {
	['"'] = parse_string,
	["0"] = parse_number,
	["1"] = parse_number,
	["2"] = parse_number,
	["3"] = parse_number,
	["4"] = parse_number,
	["5"] = parse_number,
	["6"] = parse_number,
	["7"] = parse_number,
	["8"] = parse_number,
	["9"] = parse_number,
	["-"] = parse_number,
	["t"] = parse_literal,
	["f"] = parse_literal,
	["n"] = parse_literal,
	["["] = parse_array,
	["{"] = parse_object,
}

parse = function(str, idx)
	local chr = str:sub(idx, idx)
	local f = char_func_map[chr]
	if f then
		return f(str, idx)
	end
	decode_error(str, idx, "unexpected character '" .. chr .. "'")
end

function json.decode(str)
	if type(str) ~= "string" then
		error("expected argument of type string, got " .. type(str))
	end
	local res, idx = parse(str, next_char(str, 1, space_chars, true))
	idx = next_char(str, idx, space_chars, true)
	if idx <= #str then
		decode_error(str, idx, "trailing garbage")
	end
	return res
end

return json
 end,
["lua_modules.reaper-microui.build.deepcopy"] = function(...) 
local exports = {}

--- http://lua-users.org/wiki/CopyTable
local function deepcopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == "table" then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[deepcopy(orig_key)] = deepcopy(orig_value)
		end
		setmetatable(copy, deepcopy(getmetatable(orig)))
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

exports.deepcopy = deepcopy

return exports
 end,
["lua_modules.reaper-microui.node_modules.reaper-api.utils"] = function(...) 
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
local ____inspect = require("lua_modules.reaper-microui.node_modules.reaper-api.inspect")
local inspect = ____inspect.inspect
local path = require("lua_modules.reaper-microui.node_modules.reaper-api.path.path")
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
 end,
["lua_modules.reaper-microui.node_modules.reaper-api.path.path"] = function(...) 
--- A port of some functions from Python's os.path module

---@type string
local reaper_os = reaper.GetOS()
local is_windows = reaper_os:sub(1, 3) == "Win"

if is_windows then
  return require("lua_modules.reaper-microui.node_modules.reaper-api.path.ntpath")
else
  return require("lua_modules.reaper-microui.node_modules.reaper-api.path.posixpath")
end
 end,
["lua_modules.reaper-microui.node_modules.reaper-api.path.posixpath"] = function(...) 
-- port of os.path for Linux-based systems

local util = require("lua_modules.reaper-microui.node_modules.reaper-api.path.util")
local common = require("lua_modules.reaper-microui.node_modules.reaper-api.path.genericpath")

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
["lua_modules.reaper-microui.node_modules.reaper-api.path.genericpath"] = function(...) 
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
["lua_modules.reaper-microui.node_modules.reaper-api.path.util"] = function(...) 
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
["lua_modules.reaper-microui.node_modules.reaper-api.path.ntpath"] = function(...) 
-- port of os.path for Windows

local util = require("lua_modules.reaper-microui.node_modules.reaper-api.path.util")
local common = require("lua_modules.reaper-microui.node_modules.reaper-api.path.genericpath")

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
["lua_modules.reaper-microui.node_modules.reaper-api.inspect"] = function(...) 
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
["lua_modules.reaper-microui.node_modules.reaper-api.ffi.index"] = function(...) 
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
do
    local ____export = require("lua_modules.reaper-microui.node_modules.reaper-api.ffi.enums")
    for ____exportKey, ____exportValue in pairs(____export) do
        if ____exportKey ~= "default" then
            ____exports[____exportKey] = ____exportValue
        end
    end
end
return ____exports
 end,
["lua_modules.reaper-microui.node_modules.reaper-api.ffi.enums"] = function(...) 
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
____exports.OSType = OSType or ({})
____exports.OSType.Win32 = "Win32"
____exports.OSType.Win64 = "Win64"
____exports.OSType.OSX32 = "OSX32"
____exports.OSType.OSX64 = "OSX64"
____exports.OSType.MacOSArm64 = "macOS-arm64"
____exports.OSType.Other = "Other"
____exports.Mode = Mode or ({})
____exports.Mode.Default = 0
____exports.Mode[____exports.Mode.Default] = "Default"
____exports.Mode.AdditiveBlend = 1
____exports.Mode[____exports.Mode.AdditiveBlend] = "AdditiveBlend"
____exports.Mode.DisableSourceAlpha = 2
____exports.Mode[____exports.Mode.DisableSourceAlpha] = "DisableSourceAlpha"
____exports.Mode.DisableFilterings = 4
____exports.Mode[____exports.Mode.DisableFilterings] = "DisableFilterings"
____exports.MouseCap = MouseCap or ({})
____exports.MouseCap.None = 0
____exports.MouseCap[____exports.MouseCap.None] = "None"
____exports.MouseCap.LeftMouse = 1
____exports.MouseCap[____exports.MouseCap.LeftMouse] = "LeftMouse"
____exports.MouseCap.RightMouse = 2
____exports.MouseCap[____exports.MouseCap.RightMouse] = "RightMouse"
____exports.MouseCap.CommandKey = 4
____exports.MouseCap[____exports.MouseCap.CommandKey] = "CommandKey"
____exports.MouseCap.ShiftKey = 8
____exports.MouseCap[____exports.MouseCap.ShiftKey] = "ShiftKey"
____exports.MouseCap.OptionKey = 16
____exports.MouseCap[____exports.MouseCap.OptionKey] = "OptionKey"
____exports.MouseCap.ControlKey = 32
____exports.MouseCap[____exports.MouseCap.ControlKey] = "ControlKey"
____exports.MouseCap.MiddleMouse = 64
____exports.MouseCap[____exports.MouseCap.MiddleMouse] = "MiddleMouse"
____exports.DrawStrFlags = DrawStrFlags or ({})
____exports.DrawStrFlags.None = 0
____exports.DrawStrFlags[____exports.DrawStrFlags.None] = "None"
____exports.DrawStrFlags.CenterHorizontally = 1
____exports.DrawStrFlags[____exports.DrawStrFlags.CenterHorizontally] = "CenterHorizontally"
____exports.DrawStrFlags.JustifyRight = 2
____exports.DrawStrFlags[____exports.DrawStrFlags.JustifyRight] = "JustifyRight"
____exports.DrawStrFlags.CenterVertically = 4
____exports.DrawStrFlags[____exports.DrawStrFlags.CenterVertically] = "CenterVertically"
____exports.DrawStrFlags.JustifyBottom = 8
____exports.DrawStrFlags[____exports.DrawStrFlags.JustifyBottom] = "JustifyBottom"
____exports.DrawStrFlags.Unbounded = 256
____exports.DrawStrFlags[____exports.DrawStrFlags.Unbounded] = "Unbounded"
return ____exports
 end,
["lua_modules.reaper-api.utils"] = function(...) 
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
["lua_modules.reaper-api.track"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__Generator = ____lualib.__TS__Generator
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__SetDescriptor = ____lualib.__TS__SetDescriptor
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local ____exports = {}
local TrackRouting
local ____fx = require("lua_modules.reaper-api.fx")
local FX = ____fx.FX
local generateTakeContainerFxidx = ____fx.generateTakeContainerFxidx
local generateTrackContainerFxidx = ____fx.generateTrackContainerFxidx
local parseTakeContainerFxidx = ____fx.parseTakeContainerFxidx
local parseTrackContainerFxidx = ____fx.parseTrackContainerFxidx
local stringifyAddFxParams = ____fx.stringifyAddFxParams
local ____inspect = require("lua_modules.reaper-api.inspect")
local inspect = ____inspect.inspect
____exports.Track = __TS__Class()
local Track = ____exports.Track
Track.name = "Track"
function Track.prototype.____constructor(self, track)
    self.obj = track
end
function Track.getLastTouched(self)
    local obj = reaper.GetLastTouchedTrack()
    if obj == nil then
        return nil
    end
    return __TS__New(____exports.Track, obj)
end
function Track.getMaster(self)
    return __TS__New(
        ____exports.Track,
        reaper.GetMasterTrack(0)
    )
end
function Track.count(self)
    return reaper.CountTracks(0)
end
function Track.getByIdx(self, idx)
    local obj = reaper.GetTrack(0, idx)
    if obj == nil then
        error(
            __TS__New(
                Error,
                "failed to get track with index " .. tostring(idx)
            ),
            0
        )
    end
    return __TS__New(____exports.Track, obj)
end
function Track.getSelected(self)
    local tracks = {}
    local i = 0
    while true do
        local t = reaper.GetSelectedTrack2(0, i, true)
        if t == nil then
            return tracks
        end
        tracks[#tracks + 1] = __TS__New(____exports.Track, t)
        i = i + 1
    end
end
Track.iterAll = __TS__Generator(function(self)
    local count = ____exports.Track:count()
    do
        local i = 0
        while i < count do
            coroutine.yield(____exports.Track:getByIdx(i))
            i = i + 1
        end
    end
end)
function Track.getAll(self)
    local count = ____exports.Track:count()
    local result = {}
    do
        local i = 0
        while i < count do
            result[#result + 1] = ____exports.Track:getByIdx(i)
            i = i + 1
        end
    end
    return result
end
function Track.createAtLastPosition(self)
    reaper.InsertTrackInProject(0, -1, 0)
    local totalTracks = reaper.CountTracks(0)
    return ____exports.Track:getByIdx(totalTracks - 1)
end
function Track.createAtIdx(self, idx)
    local totalTracks = reaper.CountTracks(0)
    if not (0 <= idx and idx < totalTracks) then
        error(
            __TS__New(
                Error,
                (("Track index out of bounds (" .. tostring(totalTracks)) .. "): ") .. tostring(idx)
            ),
            0
        )
    end
    reaper.InsertTrackInProject(0, idx, 0)
    return ____exports.Track:getByIdx(idx)
end
function Track.prototype.guid(self)
    return reaper.GetTrackGUID(self.obj)
end
function Track.prototype.isMaster(self)
    return self:getIdx() == -1
end
function Track.prototype.getParent(self)
    local obj = reaper.GetParentTrack(self.obj)
    if obj == nil then
        if self:isMaster() then
            return nil
        end
        return ____exports.Track:getMaster()
    end
    return __TS__New(____exports.Track, obj)
end
function Track.prototype.getChildren(self)
    local idx = self:getIdx()
    local isMaster = idx == -1
    if not isMaster then
        local rootNextTrackDepth = self:getRawFolderDepth()
        if rootNextTrackDepth <= 0 then
            return {}
        end
    end
    local children = {}
    local currentDepth = 0
    while currentDepth >= 0 do
        idx = idx + 1
        local child
        do
            local function ____catch(e)
                child = nil
            end
            local ____try, ____hasReturned = pcall(function()
                child = ____exports.Track:getByIdx(idx)
            end)
            if not ____try then
                ____catch(____hasReturned)
            end
        end
        if child == nil then
            break
        end
        if currentDepth == 0 then
            children[#children + 1] = child
        end
        currentDepth = currentDepth + child:getRawFolderDepth()
    end
    return children
end
function Track.prototype.addFx(self, fx, position)
    local fxname = stringifyAddFxParams(nil, fx)
    local positionNum = nil
    local positionArr = nil
    if position ~= nil then
        if type(position) == "number" then
            positionArr = parseTrackContainerFxidx(nil, self.obj, position)
            positionNum = position
        else
            positionArr = {table.unpack(position)}
            positionNum = generateTrackContainerFxidx(nil, self.obj, position)
        end
    end
    local rv = reaper.TrackFX_AddByName(self.obj, fxname, false, positionNum == nil and -1 or -1000 - positionNum)
    if rv == -1 then
        return nil
    end
    local newSubposition = rv
    if positionArr == nil then
        return newSubposition
    else
        positionArr[#positionArr] = newSubposition
        return generateTrackContainerFxidx(nil, self.obj, positionArr)
    end
end
function Track.prototype.getFxCount(self)
    return reaper.TrackFX_GetCount(self.obj)
end
function Track.prototype.getAllFx(self)
    local count = self:getFxCount()
    local result = {}
    do
        local i = 0
        while i < count do
            result[#result + 1] = __TS__New(FX, {track = self.obj}, i)
            i = i + 1
        end
    end
    return result
end
function Track.prototype.getFx(self, idx)
    return __TS__New(FX, {track = self.obj}, idx)
end
function Track.prototype.getRawFolderDepth(self)
    return reaper.GetMediaTrackInfo_Value(self.obj, "I_FOLDERDEPTH")
end
function Track.prototype.getSends(self, includeParent)
    if includeParent == nil then
        includeParent = false
    end
    local category = ____exports.TrackRoutingCategory.Send
    local count = reaper.GetTrackNumSends(self.obj, category)
    local result = {}
    if includeParent then
        local info = TrackRouting:getParentInfo(self.obj)
        if info.audio ~= nil or info.midi ~= nil then
            local parentTrack = reaper.GetMediaTrackInfo_Value(self.obj, "P_PARTRACK")
            if parentTrack == 0 then
                parentTrack = reaper.GetMasterTrack(0)
            end
            result[#result + 1] = __TS__ObjectAssign(
                {},
                info,
                {
                    src = __TS__New(____exports.Track, self.obj),
                    dst = __TS__New(____exports.Track, parentTrack)
                }
            )
        end
    end
    do
        local i = 0
        while i < count do
            local info = TrackRouting:getInfo(self.obj, category, i)
            local ____temp_0 = TrackRouting:getTargetTracks(self.obj, category, i)
            local src = ____temp_0.src
            local dst = ____temp_0.dst
            result[#result + 1] = __TS__ObjectAssign({src = src, dst = dst}, info)
            i = i + 1
        end
    end
    return result
end
function Track.prototype.getReceives(self)
    local category = ____exports.TrackRoutingCategory.Receive
    local count = reaper.GetTrackNumSends(self.obj, category)
    local result = {}
    do
        local i = 0
        while i < count do
            local info = TrackRouting:getInfo(self.obj, category, i)
            local ____temp_1 = TrackRouting:getTargetTracks(self.obj, category, i)
            local src = ____temp_1.src
            local dst = ____temp_1.dst
            result[#result + 1] = __TS__ObjectAssign({src = src, dst = dst}, info)
            i = i + 1
        end
    end
    return result
end
function Track.prototype.getHWOutputs(self)
    local category = ____exports.TrackRoutingCategory.HWOutput
    local count = reaper.GetTrackNumSends(self.obj, category)
    local result = {}
    do
        local i = 0
        while i < count do
            local info = TrackRouting:getInfo(self.obj, category, i)
            result[#result + 1] = info
            i = i + 1
        end
    end
    return result
end
function Track.prototype.delete(self)
    reaper.DeleteTrack(self.obj)
end
function Track.prototype.getIdx(self)
    local tracknumber = reaper.GetMediaTrackInfo_Value(self.obj, "IP_TRACKNUMBER")
    if tracknumber == 0 then
        error(
            __TS__New(Error, "failed to get track number"),
            0
        )
    end
    if tracknumber == -1 then
        return -1
    end
    return math.floor(tracknumber - 1 + 0.5)
end
Track.prototype.iterItems = __TS__Generator(function(self)
    local count = reaper.CountTrackMediaItems(self.obj)
    do
        local i = 0
        while i < count do
            local item = reaper.GetTrackMediaItem(self.obj, i)
            coroutine.yield(__TS__New(____exports.Item, item))
            i = i + 1
        end
    end
end)
function Track.prototype.allItems(self)
    local result = {}
    for ____, item in __TS__Iterator(self:iterItems()) do
        result[#result + 1] = item
    end
    return result
end
__TS__SetDescriptor(
    Track.prototype,
    "volume",
    {
        get = function(self)
            return reaper.GetMediaTrackInfo_Value(self.obj, "D_VOL")
        end,
        set = function(self, val)
            local ok = reaper.SetMediaTrackInfo_Value(self.obj, "D_VOL", val)
            if not ok then
                error(
                    __TS__New(Error, "failed to set volume"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Track.prototype,
    "pan",
    {
        get = function(self)
            return reaper.GetMediaTrackInfo_Value(self.obj, "D_PAN")
        end,
        set = function(self, val)
            local ok = reaper.SetMediaTrackInfo_Value(self.obj, "D_PAN", val)
            if not ok then
                error(
                    __TS__New(Error, "failed to set pan"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Track.prototype,
    "width",
    {
        get = function(self)
            return reaper.GetMediaTrackInfo_Value(self.obj, "D_WIDTH")
        end,
        set = function(self, val)
            local ok = reaper.SetMediaTrackInfo_Value(self.obj, "D_WIDTH", val)
            if not ok then
                error(
                    __TS__New(Error, "failed to set width"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Track.prototype,
    "panLaw",
    {
        get = function(self)
            return reaper.GetMediaTrackInfo_Value(self.obj, "D_PANLAW")
        end,
        set = function(self, val)
            local ok = reaper.SetMediaTrackInfo_Value(self.obj, "D_PANLAW", val)
            if not ok then
                error(
                    __TS__New(Error, "failed to set pan law"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Track.prototype,
    "muted",
    {
        get = function(self)
            return reaper.GetMediaTrackInfo_Value(self.obj, "B_MUTE") == 1
        end,
        set = function(self, val)
            local ok = reaper.SetMediaTrackInfo_Value(self.obj, "B_MUTE", val and 1 or 0)
            if not ok then
                error(
                    __TS__New(Error, "failed to set muted"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Track.prototype,
    "phaseInverted",
    {
        get = function(self)
            return reaper.GetMediaTrackInfo_Value(self.obj, "B_PHASE") == 1
        end,
        set = function(self, val)
            local ok = reaper.SetMediaTrackInfo_Value(self.obj, "B_PHASE", val and 1 or 0)
            if not ok then
                error(
                    __TS__New(Error, "failed to set phase inverted"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Track.prototype,
    "panmode",
    {
        get = function(self)
            return reaper.GetMediaTrackInfo_Value(self.obj, "I_PANMODE")
        end,
        set = function(self, val)
            local ok = reaper.SetMediaTrackInfo_Value(self.obj, "I_PANMODE", val)
            if not ok then
                error(
                    __TS__New(Error, "failed to set panmode"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Track.prototype,
    "color",
    {
        get = function(self)
            local x = reaper.GetMediaTrackInfo_Value(self.obj, "I_CUSTOMCOLOR")
            if x == 0 then
                return nil
            end
            local r, g, b = reaper.ColorFromNative(x)
            return {r = r, g = g, b = b}
        end,
        set = function(self, x)
            local rv
            if x == nil then
                rv = reaper.SetMediaTrackInfo_Value(self.obj, "I_CUSTOMCOLOR", 0)
            else
                local color = reaper.ColorToNative(x.r, x.g, x.b)
                rv = reaper.SetMediaTrackInfo_Value(self.obj, "I_CUSTOMCOLOR", 16777216 | color)
            end
            if not rv then
                error(
                    __TS__New(
                        Error,
                        "failed to set item color to " .. inspect(x)
                    ),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Track.prototype,
    "name",
    {
        get = function(self)
            local ok, val = reaper.GetSetMediaTrackInfo_String(self.obj, "P_NAME", "", false)
            if not ok then
                if self:getIdx() == -1 then
                    return ""
                end
                error(
                    __TS__New(Error, "failed to get track name"),
                    0
                )
            end
            return val
        end,
        set = function(self, name)
            local ok, val = reaper.GetSetMediaTrackInfo_String(self.obj, "P_NAME", name, true)
            if not ok then
                if self:getIdx() == -1 then
                    return
                end
                error(
                    __TS__New(Error, "failed to set track name"),
                    0
                )
            end
        end
    },
    true
)
____exports.Item = __TS__Class()
local Item = ____exports.Item
Item.name = "Item"
function Item.prototype.____constructor(self, obj)
    self.obj = obj
end
function Item.getSelected(self)
    local count = reaper.CountSelectedMediaItems(0)
    local result = {}
    do
        local i = 0
        while i < count do
            local obj = reaper.GetSelectedMediaItem(0, i)
            result[#result + 1] = __TS__New(____exports.Item, obj)
            i = i + 1
        end
    end
    return result
end
Item.prototype.iterTakes = __TS__Generator(function(self)
    local count = reaper.GetMediaItemNumTakes(self.obj)
    do
        local i = 0
        while i < count do
            local take = reaper.GetMediaItemTake(self.obj, i)
            coroutine.yield(__TS__New(____exports.Take, take))
            i = i + 1
        end
    end
end)
function Item.prototype.activeTake(self)
    local take = reaper.GetActiveTake(self.obj)
    if not take then
        return nil
    end
    return __TS__New(____exports.Take, take)
end
function Item.prototype.isEmpty(self)
    local count = reaper.GetMediaItemNumTakes(self.obj)
    return count == 0
end
function Item.prototype.split(self, pos)
    local rightItem = reaper.SplitMediaItem(self.obj, pos)
    if rightItem == nil then
        error(
            __TS__New(
                Error,
                ("failed to split item at position " .. tostring(pos)) .. "s"
            ),
            0
        )
    end
    return __TS__New(____exports.Item, rightItem)
end
function Item.prototype.delete(self)
    local track = self:getTrack()
    local rv = reaper.DeleteTrackMediaItem(track.obj, self.obj)
    if not rv then
        error(
            __TS__New(Error, "failed to delete item"),
            0
        )
    end
end
function Item.prototype.getTrack(self)
    local obj = reaper.GetMediaItemTrack(self.obj)
    return __TS__New(____exports.Track, obj)
end
__TS__SetDescriptor(
    Item.prototype,
    "color",
    {
        get = function(self)
            local x = reaper.GetMediaItemInfo_Value(self.obj, "I_CUSTOMCOLOR")
            if x == 0 then
                return nil
            end
            local r, g, b = reaper.ColorFromNative(x)
            return {r = r, g = g, b = b}
        end,
        set = function(self, x)
            local rv
            if x == nil then
                rv = reaper.SetMediaItemInfo_Value(self.obj, "I_CUSTOMCOLOR", 0)
            else
                local color = reaper.ColorToNative(x.r, x.g, x.b)
                rv = reaper.SetMediaItemInfo_Value(self.obj, "I_CUSTOMCOLOR", 16777216 | color)
            end
            if not rv then
                error(
                    __TS__New(
                        Error,
                        "failed to set item color to " .. inspect(x)
                    ),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Item.prototype,
    "position",
    {
        get = function(self)
            return reaper.GetMediaItemInfo_Value(self.obj, "D_POSITION")
        end,
        set = function(self, x)
            local rv = reaper.SetMediaItemInfo_Value(self.obj, "D_POSITION", x)
            if not rv then
                error(
                    __TS__New(Error, "failed to set item position"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Item.prototype,
    "snapOffset",
    {
        get = function(self)
            return reaper.GetMediaItemInfo_Value(self.obj, "D_SNAPOFFSET")
        end,
        set = function(self, x)
            local rv = reaper.SetMediaItemInfo_Value(self.obj, "D_SNAPOFFSET", x)
            if not rv then
                error(
                    __TS__New(Error, "failed to set item snap offset"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Item.prototype,
    "length",
    {
        get = function(self)
            return reaper.GetMediaItemInfo_Value(self.obj, "D_LENGTH")
        end,
        set = function(self, x)
            local rv = reaper.SetMediaItemInfo_Value(self.obj, "D_LENGTH", x)
            if not rv then
                error(
                    __TS__New(Error, "failed to set item length"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Item.prototype,
    "volume",
    {
        get = function(self)
            return reaper.GetMediaItemInfo_Value(self.obj, "D_VOL")
        end,
        set = function(self, x)
            local rv = reaper.SetMediaItemInfo_Value(self.obj, "D_VOL", x)
            if not rv then
                error(
                    __TS__New(Error, "failed to set item volume"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Item.prototype,
    "fadeInLength",
    {
        get = function(self)
            return reaper.GetMediaItemInfo_Value(self.obj, "D_FADEINLEN")
        end,
        set = function(self, x)
            local rv = reaper.SetMediaItemInfo_Value(self.obj, "D_FADEINLEN", x)
            if not rv then
                error(
                    __TS__New(Error, "failed to set item fade-in length"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Item.prototype,
    "fadeOutLength",
    {
        get = function(self)
            return reaper.GetMediaItemInfo_Value(self.obj, "D_FADEOUTLEN")
        end,
        set = function(self, x)
            local rv = reaper.SetMediaItemInfo_Value(self.obj, "D_FADEOUTLEN", x)
            if not rv then
                error(
                    __TS__New(Error, "failed to set item fade-out length"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Item.prototype,
    "muted",
    {
        get = function(self)
            return reaper.GetMediaItemInfo_Value(self.obj, "B_MUTE_ACTUAL") ~= 0
        end,
        set = function(self, x)
            local rv = reaper.SetMediaItemInfo_Value(self.obj, "B_MUTE_ACTUAL", x and 1 or 0)
            if not rv then
                error(
                    __TS__New(Error, "failed to set item muted"),
                    0
                )
            end
        end
    },
    true
)
____exports.Take = __TS__Class()
local Take = ____exports.Take
Take.name = "Take"
function Take.prototype.____constructor(self, obj)
    self.obj = obj
end
function Take.prototype.type(self)
    local source = reaper.GetMediaItemTake_Source(self.obj)
    return reaper.GetMediaSourceType(source)
end
function Take.prototype.isMidi(self)
    local ____type = self:type()
    return ____type == "MIDI" or ____type == "MIDIPOOL"
end
function Take.prototype.asTypedTake(self)
    if self:isMidi() then
        return __TS__New(____exports.MidiTake, self.obj)
    else
        return __TS__New(____exports.AudioTake, self.obj)
    end
end
function Take.prototype.getSource(self)
    return __TS__New(
        ____exports.Source,
        reaper.GetMediaItemTake_Source(self.obj)
    )
end
function Take.prototype.getFxCount(self)
    return reaper.TakeFX_GetCount(self.obj)
end
function Take.prototype.addFx(self, fx, position)
    local fxname = stringifyAddFxParams(nil, fx)
    local positionNum = nil
    local positionArr = nil
    if position ~= nil then
        if type(position) == "number" then
            positionArr = parseTakeContainerFxidx(nil, self.obj, position)
            positionNum = position
        else
            positionArr = {table.unpack(position)}
            positionNum = generateTakeContainerFxidx(nil, self.obj, position)
        end
    end
    local rv = reaper.TakeFX_AddByName(self.obj, fxname, positionNum == nil and -1 or -1000 - positionNum)
    if rv == -1 then
        return nil
    end
    local newSubposition = rv
    if positionArr == nil then
        return newSubposition
    else
        positionArr[#positionArr] = newSubposition
        return generateTakeContainerFxidx(nil, self.obj, positionArr)
    end
end
function Take.prototype.getItem(self)
    local obj = reaper.GetMediaItemTake_Item(self.obj)
    return __TS__New(____exports.Item, obj)
end
function Take.prototype.getTrack(self)
    local obj = reaper.GetMediaItemTake_Track(self.obj)
    return __TS__New(____exports.Track, obj)
end
function Take.prototype.getStretchMarkerCount(self)
    return reaper.GetTakeNumStretchMarkers(self.obj)
end
__TS__SetDescriptor(
    Take.prototype,
    "name",
    {
        get = function(self)
            local ok, rv = reaper.GetSetMediaItemTakeInfo_String(self.obj, "P_NAME", "", false)
            if not ok then
                error(
                    __TS__New(Error, "failed to get take name"),
                    0
                )
            end
            return rv
        end,
        set = function(self, x)
            local ok, rv = reaper.GetSetMediaItemTakeInfo_String(self.obj, "P_NAME", x, true)
            if not ok then
                error(
                    __TS__New(Error, "failed to set take name"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Take.prototype,
    "sourceStartOffset",
    {
        get = function(self)
            local x = reaper.GetMediaItemTakeInfo_Value(self.obj, "D_STARTOFFS")
            return x
        end,
        set = function(self, x)
            local ok = reaper.SetMediaItemTakeInfo_Value(self.obj, "D_STARTOFFS", x)
            if not ok then
                error(
                    __TS__New(Error, "failed to set take source start offset"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Take.prototype,
    "volume",
    {
        get = function(self)
            local x = reaper.GetMediaItemTakeInfo_Value(self.obj, "D_VOL")
            return x
        end,
        set = function(self, x)
            local ok = reaper.SetMediaItemTakeInfo_Value(self.obj, "D_VOL", x)
            if not ok then
                error(
                    __TS__New(Error, "failed to set take volume"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Take.prototype,
    "pan",
    {
        get = function(self)
            local x = reaper.GetMediaItemTakeInfo_Value(self.obj, "D_PAN")
            return x
        end,
        set = function(self, x)
            local ok = reaper.SetMediaItemTakeInfo_Value(self.obj, "D_PAN", x)
            if not ok then
                error(
                    __TS__New(Error, "failed to set take pan"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Take.prototype,
    "playrate",
    {
        get = function(self)
            local x = reaper.GetMediaItemTakeInfo_Value(self.obj, "D_PLAYRATE")
            return x
        end,
        set = function(self, x)
            local ok = reaper.SetMediaItemTakeInfo_Value(self.obj, "D_PLAYRATE", x)
            if not ok then
                error(
                    __TS__New(Error, "failed to set take playrate"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Take.prototype,
    "pitch",
    {
        get = function(self)
            local x = reaper.GetMediaItemTakeInfo_Value(self.obj, "D_PITCH")
            return x
        end,
        set = function(self, x)
            local ok = reaper.SetMediaItemTakeInfo_Value(self.obj, "D_PITCH", x)
            if not ok then
                error(
                    __TS__New(Error, "failed to set take pitch"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    Take.prototype,
    "preservePitch",
    {
        get = function(self)
            local x = reaper.GetMediaItemTakeInfo_Value(self.obj, "D_PITCH") ~= 0
            return x
        end,
        set = function(self, x)
            local ok = reaper.SetMediaItemTakeInfo_Value(self.obj, "D_PITCH", x and 1 or 0)
            if not ok then
                error(
                    __TS__New(Error, "failed to set take preserve pitch"),
                    0
                )
            end
        end
    },
    true
)
____exports.MidiTake = __TS__Class()
local MidiTake = ____exports.MidiTake
MidiTake.name = "MidiTake"
__TS__ClassExtends(MidiTake, ____exports.Take)
function MidiTake.prototype.____constructor(self, ...)
    MidiTake.____super.prototype.____constructor(self, ...)
    self.TYPE = "MIDI"
end
function MidiTake.active(self)
    local hwnd = reaper.MIDIEditor_GetActive()
    if hwnd == nil then
        return nil
    end
    local take = reaper.MIDIEditor_GetTake(hwnd)
    return __TS__New(____exports.MidiTake, take)
end
function MidiTake.prototype.grid(self)
    local beats, swing, noteBeats = reaper.MIDI_GetGrid(self.obj)
    local ____beats_3 = beats
    local ____swing_4 = swing
    local ____temp_2
    if noteBeats == 0 then
        ____temp_2 = nil
    else
        ____temp_2 = noteBeats
    end
    return {beats = ____beats_3, swing = ____swing_4, noteLengthOverride = ____temp_2}
end
MidiTake.prototype.iterNotes = __TS__Generator(function(self)
    local i = 0
    while true do
        local rv, selected, muted, startTick, endTick, chan, pitch, vel = reaper.MIDI_GetNote(self.obj, i)
        if not rv then
            break
        end
        coroutine.yield({
            selected = selected,
            muted = muted,
            startTick = startTick,
            endTick = endTick,
            chan = chan,
            pitch = pitch,
            vel = vel
        })
        i = i + 1
    end
end)
function MidiTake.prototype.allNotes(self)
    local result = {}
    for ____, note in __TS__Iterator(self:iterNotes()) do
        result[#result + 1] = note
    end
    return result
end
function MidiTake.prototype.tickToProjectTime(self, tick)
    return reaper.MIDI_GetProjTimeFromPPQPos(self.obj, tick)
end
--- TODO
____exports.AudioTake = __TS__Class()
local AudioTake = ____exports.AudioTake
AudioTake.name = "AudioTake"
__TS__ClassExtends(AudioTake, ____exports.Take)
function AudioTake.prototype.____constructor(self, ...)
    AudioTake.____super.prototype.____constructor(self, ...)
    self.TYPE = "AUDIO"
end
____exports.Source = __TS__Class()
local Source = ____exports.Source
Source.name = "Source"
function Source.prototype.____constructor(self, obj)
    self.obj = obj
end
function Source.prototype.type(self)
    return reaper.GetMediaSourceType(self.obj)
end
function Source.prototype.getFilename(self)
    local name = reaper.GetMediaSourceFileName(self.obj)
    if #name == 0 then
        error(
            __TS__New(Error, "failed to get PCM_source filename"),
            0
        )
    end
    return name
end
function Source.prototype.getLength(self)
    local length, isQuarterNotes = reaper.GetMediaSourceLength(self.obj)
    if isQuarterNotes then
        error(
            __TS__New(Error, "source is beat-based, does not have length in seconds"),
            0
        )
    end
    return length
end
function Source.prototype.getBeatLength(self)
    local length, isQuarterNotes = reaper.GetMediaSourceLength(self.obj)
    if not isQuarterNotes then
        error(
            __TS__New(Error, "source is seconds-based, does not have length in beats"),
            0
        )
    end
    return length
end
function Source.prototype.getParent(self)
    local parent = reaper.GetMediaSourceParent(self.obj)
    if parent == nil then
        return nil
    end
    return __TS__New(____exports.Source, parent)
end
function Source.prototype.getSectionInfo(self)
    local isSection, offset, length, reversed = reaper.PCM_Source_GetSectionInfo(self.obj)
    return {isSection = isSection, offset = offset, length = length, reversed = reversed}
end
--- ================================================================
-- 
-- Track routing functions
-- 
-- ================================================================
____exports.TrackRoutingCategory = TrackRoutingCategory or ({})
____exports.TrackRoutingCategory.Receive = -1
____exports.TrackRoutingCategory[____exports.TrackRoutingCategory.Receive] = "Receive"
____exports.TrackRoutingCategory.Send = 0
____exports.TrackRoutingCategory[____exports.TrackRoutingCategory.Send] = "Send"
____exports.TrackRoutingCategory.HWOutput = 1
____exports.TrackRoutingCategory[____exports.TrackRoutingCategory.HWOutput] = "HWOutput"
____exports.TrackSendMode = TrackSendMode or ({})
____exports.TrackSendMode.PostFader = 0
____exports.TrackSendMode[____exports.TrackSendMode.PostFader] = "PostFader"
____exports.TrackSendMode.PreFx = 1
____exports.TrackSendMode[____exports.TrackSendMode.PreFx] = "PreFx"
____exports.TrackSendMode.PostFxDeprecated = 2
____exports.TrackSendMode[____exports.TrackSendMode.PostFxDeprecated] = "PostFxDeprecated"
____exports.TrackSendMode.PostFx = 3
____exports.TrackSendMode[____exports.TrackSendMode.PostFx] = "PostFx"
____exports.TrackSendAutomationMode = TrackSendAutomationMode or ({})
____exports.TrackSendAutomationMode.TrackDefault = -1
____exports.TrackSendAutomationMode[____exports.TrackSendAutomationMode.TrackDefault] = "TrackDefault"
____exports.TrackSendAutomationMode.Trim = 0
____exports.TrackSendAutomationMode[____exports.TrackSendAutomationMode.Trim] = "Trim"
____exports.TrackSendAutomationMode.Read = 1
____exports.TrackSendAutomationMode[____exports.TrackSendAutomationMode.Read] = "Read"
____exports.TrackSendAutomationMode.Touch = 2
____exports.TrackSendAutomationMode[____exports.TrackSendAutomationMode.Touch] = "Touch"
____exports.TrackSendAutomationMode.Write = 3
____exports.TrackSendAutomationMode[____exports.TrackSendAutomationMode.Write] = "Write"
____exports.TrackSendAutomationMode.Latch = 4
____exports.TrackSendAutomationMode[____exports.TrackSendAutomationMode.Latch] = "Latch"
TrackRouting = {}
do
    function TrackRouting.parseMidiFlags(self, flags)
        local first5bits = flags & 31
        local midiSendDisabled = first5bits == 31
        if midiSendDisabled then
            return nil
        end
        local next5bits = flags & 992
        local srcChannel = first5bits == 0 and "all" or first5bits
        local dstChannel = next5bits == 0 and "all" or next5bits
        local fadersSendMidiVolPan = flags & 1024 ~= 0
        local rawSrcBus = flags >> 14 & 255
        local srcBus = rawSrcBus == 0 and "all" or rawSrcBus
        local rawDstBus = flags >> 22 & 255
        local dstBus = rawDstBus == 0 and "all" or rawDstBus
        return {
            srcChannel = srcChannel,
            dstChannel = dstChannel,
            srcBus = srcBus,
            dstBus = dstBus,
            fadersSendMidiVolPan = fadersSendMidiVolPan
        }
    end
    function TrackRouting.getAudioInfo(self, track, category, idx)
        local function GTSI_V(____, param)
            return reaper.GetTrackSendInfo_Value(track, category, idx, param)
        end
        local I_SRCCHAN = GTSI_V(nil, "I_SRCCHAN")
        if I_SRCCHAN == -1 then
            return nil
        end
        local srcChannelOffset = I_SRCCHAN & 1023
        local channelCount
        repeat
            local ____switch202 = I_SRCCHAN >> 10
            local ____cond202 = ____switch202 == 0
            if ____cond202 then
                channelCount = 2
                break
            end
            ____cond202 = ____cond202 or ____switch202 == 1
            if ____cond202 then
                channelCount = 1
                break
            end
            do
                channelCount = (I_SRCCHAN >> 10) * 2
                break
            end
        until true
        local I_DSTCHAN = GTSI_V(nil, "I_DSTCHAN")
        local dstChannelOffset = I_DSTCHAN & 1023
        local mixToMono = I_DSTCHAN & 1024 ~= 0
        local muted = GTSI_V(nil, "B_MUTE") == 1
        local phaseInverted = GTSI_V(nil, "B_PHASE") == 1
        local mono = GTSI_V(nil, "B_MONO") == 1
        local volume = GTSI_V(nil, "D_VOL")
        local pan = GTSI_V(nil, "D_PAN")
        local D_PANLAW = GTSI_V(nil, "D_PANLAW")
        local ____temp_5
        if D_PANLAW == -1 then
            ____temp_5 = nil
        else
            ____temp_5 = D_PANLAW
        end
        local panLaw = ____temp_5
        local sendMode = GTSI_V(nil, "I_SENDMODE")
        local automationMode = GTSI_V(nil, "I_AUTOMODE")
        return {
            channelCount = channelCount,
            srcChannelOffset = srcChannelOffset,
            dstChannelOffset = dstChannelOffset,
            muted = muted,
            phaseInverted = phaseInverted,
            mono = mono,
            volume = volume,
            pan = pan,
            panLaw = panLaw,
            sendMode = sendMode,
            automationMode = automationMode,
            mixToMono = mixToMono
        }
    end
    function TrackRouting.getInfo(self, track, category, idx)
        local audio = TrackRouting:getAudioInfo(track, category, idx)
        local midiFlags = reaper.GetTrackSendInfo_Value(track, ____exports.TrackRoutingCategory.Send, idx, "I_MIDIFLAGS")
        local midi = TrackRouting:parseMidiFlags(midiFlags)
        return {audio = audio, midi = midi}
    end
    function TrackRouting.getTargetTracks(self, track, category, idx)
        local dst = reaper.GetTrackSendInfo_Value(track, category, idx, "P_DESTTRACK")
        local src = reaper.GetTrackSendInfo_Value(track, category, idx, "P_SRCTRACK")
        return {
            dst = __TS__New(____exports.Track, dst),
            src = __TS__New(____exports.Track, src)
        }
    end
    function TrackRouting.getParentAudioInfo(self, track)
        local sendsAudioToParent = reaper.GetMediaTrackInfo_Value(track, "B_MAINSEND") == 1
        if not sendsAudioToParent then
            return nil
        end
        local trackChannelCount = reaper.GetMediaTrackInfo_Value(track, "I_NCHAN")
        local dstChannelOffset = reaper.GetMediaTrackInfo_Value(track, "C_MAINSEND_OFFS")
        local rawSendChannelCount = reaper.GetMediaTrackInfo_Value(track, "C_MAINSEND_NCH")
        local sendChannelCount = rawSendChannelCount == 0 and trackChannelCount or rawSendChannelCount
        return {
            channelCount = sendChannelCount,
            srcChannelOffset = 0,
            dstChannelOffset = dstChannelOffset,
            muted = false,
            phaseInverted = false,
            mono = false,
            volume = 1,
            pan = 0,
            panLaw = nil,
            sendMode = ____exports.TrackSendMode.PostFader,
            automationMode = ____exports.TrackSendAutomationMode.TrackDefault,
            mixToMono = false
        }
    end
    function TrackRouting.getParentMidiInfo(self, track)
        local sendsAudioToParent = reaper.GetMediaTrackInfo_Value(track, "B_MAINSEND") == 1
        if not sendsAudioToParent then
            return nil
        end
        local I_MIDI_CTL_CHAN = reaper.GetMediaTrackInfo_Value(track, "I_MIDI_CTL_CHAN")
        local faderLinkedChannel
        repeat
            local ____switch209 = I_MIDI_CTL_CHAN
            local ____cond209 = ____switch209 == 16
            if ____cond209 then
                faderLinkedChannel = "all"
                break
            end
            ____cond209 = ____cond209 or ____switch209 == -1
            if ____cond209 then
                faderLinkedChannel = nil
                break
            end
            do
                faderLinkedChannel = I_MIDI_CTL_CHAN + 1
                break
            end
        until true
        return {
            srcChannel = "all",
            dstChannel = "all",
            srcBus = "all",
            dstBus = "all",
            fadersSendMidiVolPan = faderLinkedChannel ~= nil
        }
    end
    function TrackRouting.getParentInfo(self, track)
        local audio = TrackRouting:getParentAudioInfo(track)
        local midi = TrackRouting:getParentMidiInfo(track)
        return {audio = audio, midi = midi}
    end
end
--- Iterates through all tracks in the project, then returns maps for sending and receiving
-- tracks. This includes the default routing to folder parents.
-- 
-- - `sends`: Maps from `trackIdx` to a list of `trackIdx` which this track sends to
-- - `receives`: Maps from `trackIdx` to a list of `trackIdx` sends to this track
-- 
-- Note: The `receives` map contains `-1` which represent the master track.
-- 
-- @param opt Specify what kind of routing to filter for. E.g. If you only care about audio
-- routing, specify `{ audio: true }`
function ____exports.getProjectRoutingInfo(self, opt)
    if opt == nil then
        opt = {audio = true, midi = true}
    end
    local count = ____exports.Track:count()
    local sends = {}
    local receives = {}
    do
        local srcIdx = 0
        while srcIdx < count do
            local track = ____exports.Track:getByIdx(srcIdx)
            for ____, send in ipairs(track:getSends(true)) do
                do
                    if opt.audio and opt.midi then
                        if not (send.audio or send.midi) then
                            goto __continue213
                        end
                    elseif opt.audio then
                        if not send.audio then
                            goto __continue213
                        end
                    elseif opt.midi then
                        if not send.midi then
                            goto __continue213
                        end
                    end
                    local dstIdx = send.dst:getIdx()
                    if not (sends[srcIdx] ~= nil) then
                        sends[srcIdx] = {}
                    end
                    local ____sends_srcIdx_6 = sends[srcIdx]
                    ____sends_srcIdx_6[#____sends_srcIdx_6 + 1] = dstIdx
                    if not (receives[dstIdx] ~= nil) then
                        receives[dstIdx] = {}
                    end
                    local ____receives_dstIdx_7 = receives[dstIdx]
                    ____receives_dstIdx_7[#____receives_dstIdx_7 + 1] = srcIdx
                end
                ::__continue213::
            end
            srcIdx = srcIdx + 1
        end
    end
    return {sends = sends, receives = receives}
end
return ____exports
 end,
["lua_modules.reaper-api.fx"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__ParseInt = ____lualib.__TS__ParseInt
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__Class = ____lualib.__TS__Class
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__StringEndsWith = ____lualib.__TS__StringEndsWith
local __TS__ArrayReduce = ____lualib.__TS__ArrayReduce
local __TS__StringSlice = ____lualib.__TS__StringSlice
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local ____exports = {}
local Base64 = require("lua_modules.reaper-api.base64")
local Chunk = require("lua_modules.reaper-api.chunk")
local ____element = require("lua_modules.reaper-api.element")
local parse = ____element.parse
local ____inspect = require("lua_modules.reaper-api.inspect")
local inspect = ____inspect.inspect
local ____utils = require("lua_modules.reaper-api.utils")
local assertUnreachable = ____utils.assertUnreachable
local msgBox = ____utils.msgBox
local function parseLittleEndianInteger(self, bytes)
    local result = 0
    do
        local i = 0
        while i < #bytes do
            local byte = string.byte(bytes, i + 1)
            result = result + (byte << i * 8)
            i = i + 1
        end
    end
    return result
end
function ____exports.stringifyAddFxParams(self, params)
    if type(params) == "string" then
        return params
    end
    if params.vst3 ~= nil then
        return "VST3: " .. params.vst3
    elseif params.vst2 ~= nil then
        return "VST2: " .. params.vst2
    elseif params.vst ~= nil then
        return "VST: " .. params.vst
    elseif params.au ~= nil then
        return "AU: " .. params.au
    elseif params.js ~= nil then
        return "JS: " .. params.js
    elseif params.dx ~= nil then
        return "DX: " .. params.dx
    elseif params.clap ~= nil then
        return "CLAP: " .. params.clap
    elseif params.fxchain ~= nil then
        return params.fxchain .. ".rfxchain"
    elseif params.browser ~= nil then
        local browser = params.browser
        if browser == true then
            return "FXADD:"
        elseif browser.max ~= nil then
            return "FXADD:" .. tostring(browser.max)
        elseif browser.exactly ~= nil then
            return ("FXADD:" .. tostring(browser.exactly)) .. "e"
        else
            assertUnreachable(nil, browser)
        end
    else
        assertUnreachable(nil, params)
    end
end
function ____exports.parseTrackContainerFxidx(self, track, fxidx)
    local isContainerFxidx = fxidx & 33554432 ~= 0
    if not isContainerFxidx then
        return {fxidx}
    end
    local ret = {}
    local n = reaper.TrackFX_GetCount(track)
    local curidx = (fxidx - 33554432) % (n + 1)
    local remain = math.floor((fxidx - 33554432) / (n + 1))
    if curidx < 1 then
        error("bad container address")
    end
    local addr = curidx + 33554432
    local addr_sc = n + 1
    while true do
        local ccok, cc = reaper.TrackFX_GetNamedConfigParm(track, addr, "container_count")
        if not ccok then
            error("bad container address: not a container")
        end
        ret[#ret + 1] = curidx - 1
        n = __TS__ParseInt(cc)
        if remain <= n then
            if remain > 0 then
                ret[#ret + 1] = remain - 1
            end
            return ret
        end
        curidx = remain % (n + 1)
        remain = math.floor(remain / (n + 1))
        if curidx < 1 then
            error("bad container address")
        end
        addr = addr + addr_sc * curidx
        addr_sc = addr_sc * (n + 1)
    end
end
function ____exports.generateTrackContainerFxidx(self, track, allidx)
    if #allidx <= 0 then
        error(
            __TS__New(Error, "container index must be at least length 1"),
            0
        )
    end
    local sc = reaper.TrackFX_GetCount(track) + 1
    local rv = 33554432 + allidx[1] + 1
    do
        local i = 1
        while i < #allidx do
            local v = allidx[i + 1] + 1
            local ccok, cc = reaper.TrackFX_GetNamedConfigParm(track, rv, "container_count")
            if not ccok then
                error("bad container address: container does not exist")
            end
            rv = rv + sc * v
            sc = sc * (1 + __TS__ParseInt(cc))
            i = i + 1
        end
    end
    return rv
end
function ____exports.parseTakeContainerFxidx(self, take, fxidx)
    local isContainerFxidx = fxidx & 33554432 ~= 0
    if not isContainerFxidx then
        return {fxidx}
    end
    local ret = {}
    local n = reaper.TakeFX_GetCount(take)
    local curidx = (fxidx - 33554432) % (n + 1)
    local remain = math.floor((fxidx - 33554432) / (n + 1))
    if curidx < 1 then
        error("bad container address")
    end
    local addr = curidx + 33554432
    local addr_sc = n + 1
    while true do
        local ccok, cc = reaper.TakeFX_GetNamedConfigParm(take, addr, "container_count")
        if not ccok then
            error("bad container address: not a container")
        end
        ret[#ret + 1] = curidx - 1
        n = __TS__ParseInt(cc)
        if remain <= n then
            if remain > 0 then
                ret[#ret + 1] = remain - 1
            end
            return ret
        end
        curidx = remain % (n + 1)
        remain = math.floor(remain / (n + 1))
        if curidx < 1 then
            error("bad container address")
        end
        addr = addr + addr_sc * curidx
        addr_sc = addr_sc * (n + 1)
    end
end
function ____exports.generateTakeContainerFxidx(self, take, allidx)
    if #allidx <= 0 then
        error(
            __TS__New(Error, "container index must be at least length 1"),
            0
        )
    end
    local sc = reaper.TakeFX_GetCount(take) + 1
    local rv = 33554432 + allidx[1] + 1
    do
        local i = 1
        while i < #allidx do
            local v = allidx[i + 1] + 1
            local ccok, cc = reaper.TakeFX_GetNamedConfigParm(take, rv, "container_count")
            if not ccok then
                error("bad container address: container does not exist")
            end
            rv = rv + sc * v
            sc = sc * (1 + __TS__ParseInt(cc))
            i = i + 1
        end
    end
    return rv
end
local ReaperFXChain = __TS__Class()
ReaperFXChain.name = "ReaperFXChain"
function ReaperFXChain.prototype.____constructor(self, params)
    if params.track ~= nil then
        self.obj = {type = "track", track = params.track}
    else
        self.obj = {type = "take", take = params.take}
    end
end
function ReaperFXChain.prototype.GetNamedConfigParm(self, fxidx, name)
    repeat
        local ____switch48 = self.obj.type
        local ____cond48 = ____switch48 == "track"
        if ____cond48 then
            do
                local ok, value = reaper.TrackFX_GetNamedConfigParm(self.obj.track, fxidx, name)
                return ok and value or nil
            end
        end
        ____cond48 = ____cond48 or ____switch48 == "take"
        if ____cond48 then
            do
                local ok, value = reaper.TakeFX_GetNamedConfigParm(self.obj.take, fxidx, name)
                return ok and value or nil
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function ReaperFXChain.prototype.SetNamedConfigParm(self, fxidx, name, value)
    repeat
        local ____switch52 = self.obj.type
        local ____cond52 = ____switch52 == "track"
        if ____cond52 then
            do
                return reaper.TrackFX_SetNamedConfigParm(self.obj.track, fxidx, name, value)
            end
        end
        ____cond52 = ____cond52 or ____switch52 == "take"
        if ____cond52 then
            do
                return reaper.TakeFX_SetNamedConfigParm(self.obj.take, fxidx, name, value)
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function ReaperFXChain.prototype.GetNumParams(self, fxidx)
    repeat
        local ____switch56 = self.obj.type
        local ____cond56 = ____switch56 == "track"
        if ____cond56 then
            do
                return reaper.TrackFX_GetNumParams(self.obj.track, fxidx)
            end
        end
        ____cond56 = ____cond56 or ____switch56 == "take"
        if ____cond56 then
            do
                return reaper.TakeFX_GetNumParams(self.obj.take, fxidx)
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function ReaperFXChain.prototype.GetParamIdent(self, fxidx, param)
    repeat
        local ____switch60 = self.obj.type
        local ____cond60 = ____switch60 == "track"
        if ____cond60 then
            do
                local ok, value = reaper.TrackFX_GetParamIdent(self.obj.track, fxidx, param)
                return ok and value or nil
            end
        end
        ____cond60 = ____cond60 or ____switch60 == "take"
        if ____cond60 then
            do
                local ok, value = reaper.TakeFX_GetParamIdent(self.obj.take, fxidx, param)
                return ok and value or nil
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function ReaperFXChain.prototype.GetParamName(self, fxidx, param)
    repeat
        local ____switch64 = self.obj.type
        local ____cond64 = ____switch64 == "track"
        if ____cond64 then
            do
                local ok, value = reaper.TrackFX_GetParamName(self.obj.track, fxidx, param)
                return ok and value or nil
            end
        end
        ____cond64 = ____cond64 or ____switch64 == "take"
        if ____cond64 then
            do
                local ok, value = reaper.TakeFX_GetParamName(self.obj.take, fxidx, param)
                return ok and value or nil
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function ReaperFXChain.prototype.GetParamEx(self, fxidx, param)
    repeat
        local ____switch68 = self.obj.type
        local ____cond68 = ____switch68 == "track"
        if ____cond68 then
            do
                local rv, min, max, mid = reaper.TrackFX_GetParamEx(self.obj.track, fxidx, param)
                if min == nil then
                    error("failed to get param value")
                end
                return {rv, min, max, mid}
            end
        end
        ____cond68 = ____cond68 or ____switch68 == "take"
        if ____cond68 then
            do
                local rv, min, max, mid = reaper.TakeFX_GetParamEx(self.obj.take, fxidx, param)
                if min == nil then
                    error("failed to get param value")
                end
                return {rv, min, max, mid}
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function ReaperFXChain.prototype.SetParam(self, fxidx, param, value)
    repeat
        local ____switch74 = self.obj.type
        local ____cond74 = ____switch74 == "track"
        if ____cond74 then
            do
                return reaper.TrackFX_SetParam(self.obj.track, fxidx, param, value)
            end
        end
        ____cond74 = ____cond74 or ____switch74 == "take"
        if ____cond74 then
            do
                return reaper.TakeFX_SetParam(self.obj.take, fxidx, param, value)
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function ReaperFXChain.prototype.GetFXGUID(self, fxidx)
    repeat
        local ____switch78 = self.obj.type
        local ____cond78 = ____switch78 == "track"
        if ____cond78 then
            do
                return reaper.TrackFX_GetFXGUID(self.obj.track, fxidx)
            end
        end
        ____cond78 = ____cond78 or ____switch78 == "take"
        if ____cond78 then
            do
                return reaper.TakeFX_GetFXGUID(self.obj.take, fxidx)
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function ReaperFXChain.prototype.GetOffline(self, fxidx)
    repeat
        local ____switch82 = self.obj.type
        local ____cond82 = ____switch82 == "track"
        if ____cond82 then
            do
                return reaper.TrackFX_GetOffline(self.obj.track, fxidx)
            end
        end
        ____cond82 = ____cond82 or ____switch82 == "take"
        if ____cond82 then
            do
                return reaper.TakeFX_GetOffline(self.obj.take, fxidx)
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
____exports.FX = __TS__Class()
local FX = ____exports.FX
FX.name = "FX"
function FX.prototype.____constructor(self, params, fxidx)
    if params.track ~= nil then
        self.obj = {type = "track", track = params.track}
        self.chain = __TS__New(ReaperFXChain, {track = params.track})
    else
        self.obj = {type = "take", take = params.take}
        self.chain = __TS__New(ReaperFXChain, {take = params.take})
    end
    self.fxidx = fxidx
end
function FX.prototype.guid(self)
    local guid = self.chain:GetFXGUID(self.fxidx)
    if not guid then
        error("failed to get FX GUID")
    end
    return guid
end
function FX.prototype.getParameter(self, param)
    repeat
        local ____switch91 = self.obj.type
        local ____cond91 = ____switch91 == "track"
        if ____cond91 then
            do
                return __TS__New(____exports.FXParam, {track = self.obj.track}, self.fxidx, param)
            end
        end
        ____cond91 = ____cond91 or ____switch91 == "take"
        if ____cond91 then
            do
                return __TS__New(____exports.FXParam, {take = self.obj.take}, self.fxidx, param)
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function FX.prototype.getParameters(self)
    local totalCount = self.chain:GetNumParams(self.fxidx)
    local result = {}
    do
        local i = 0
        while i < totalCount do
            result[#result + 1] = self:getParameter(i)
            i = i + 1
        end
    end
    return result
end
function FX.prototype.getName(self)
    repeat
        local ____switch97 = self.obj.type
        local ____cond97 = ____switch97 == "track"
        if ____cond97 then
            do
                local ok, value = reaper.TrackFX_GetFXName(self.obj.track, self.fxidx)
                if not ok then
                    error("failed to get FX name")
                end
                return value
            end
        end
        ____cond97 = ____cond97 or ____switch97 == "take"
        if ____cond97 then
            do
                local ok, value = reaper.TakeFX_GetFXName(self.obj.take, self.fxidx)
                if not ok then
                    error("failed to get FX name")
                end
                return value
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function FX.prototype.rename(self, name)
    repeat
        local ____switch103 = self.obj.type
        local ____cond103 = ____switch103 == "track"
        if ____cond103 then
            do
                reaper.TrackFX_SetNamedConfigParm(self.obj.track, self.fxidx, "renamed_name", name)
                break
            end
        end
        ____cond103 = ____cond103 or ____switch103 == "take"
        if ____cond103 then
            do
                reaper.TakeFX_SetNamedConfigParm(self.obj.take, self.fxidx, "renamed_name", name)
                break
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function FX.prototype.getOriginalName(self)
    local name = self.chain:GetNamedConfigParm(self.fxidx, "fx_name")
    if not name then
        error("failed to get FX name")
    end
    return name
end
function FX.prototype.getIdent(self)
    local ident = self.chain:GetNamedConfigParm(self.fxidx, "fx_ident")
    if not ident then
        error("failed to get FX ident")
    end
    return ident
end
function FX.prototype.getType(self)
    local ____type = self.chain:GetNamedConfigParm(self.fxidx, "fx_type")
    if not ____type then
        error("failed to get FX type")
    end
    return ____type
end
function FX.prototype.getPDCLatency(self)
    local pdc = self.chain:GetNamedConfigParm(self.fxidx, "pdc")
    if not pdc then
        error("failed to get FX pdc")
    end
    return pdc
end
function FX.prototype.decipherFxidx(self)
    local actualIdx = 16777215 & self.fxidx
    local isRecInputOrHardwareOutput = self.fxidx & 16777216 ~= 0
    local isInContainer = self.fxidx & 33554432 ~= 0
    if isInContainer then
        return {isRecInputOrHardwareOutput = isRecInputOrHardwareOutput, isInContainer = isInContainer}
    else
        return {actualIdx = actualIdx, isRecInputOrHardwareOutput = isRecInputOrHardwareOutput, isInContainer = isInContainer}
    end
end
function FX.prototype.getElement(self)
    repeat
        local ____switch118 = self.obj.type
        local ____cond118 = ____switch118 == "track"
        if ____cond118 then
            do
                local track = self.obj.track
                local decipher = self:decipherFxidx()
                if decipher.isInContainer then
                    error("unable to get chunk data from FX in containers")
                end
                local fxchainTag
                if decipher.isRecInputOrHardwareOutput then
                    local masterTrack = reaper.GetMasterTrack(0)
                    local isMasterTrack = track == masterTrack
                    if isMasterTrack then
                        error("unable to get chunk data from FX in monitor FX")
                    else
                        fxchainTag = "FXCHAIN_REC"
                    end
                else
                    local totalFxCount = reaper.TrackFX_GetCount(track)
                    if decipher.actualIdx >= totalFxCount then
                        error(
                            __TS__New(
                                Error,
                                (("FX index of " .. tostring(decipher.actualIdx)) .. " exceeds track FX count of ") .. tostring(totalFxCount)
                            ),
                            0
                        )
                    end
                    fxchainTag = "FXCHAIN"
                end
                local chunk = Chunk.track(track)
                local element = parse(nil, chunk)
                local fxchainarr = nil
                for ____, child in ipairs(element.children) do
                    do
                        if not (child.tag ~= nil) then
                            goto __continue126
                        end
                        if child.tag == fxchainTag then
                            fxchainarr = child
                            break
                        end
                    end
                    ::__continue126::
                end
                if fxchainarr == nil then
                    error(("failed to find <" .. fxchainTag) .. "> element in track chunk data")
                end
                local fxchunks = __TS__ArrayFilter(
                    fxchainarr.children,
                    function(____, x) return x.tag ~= nil end
                )
                return fxchunks[decipher.actualIdx + 1]
            end
        end
        ____cond118 = ____cond118 or ____switch118 == "take"
        if ____cond118 then
            do
                error(
                    __TS__New(Error, "TODO: Implement parsing chunk data of items"),
                    0
                )
            end
        end
        do
            assertUnreachable(nil, self.obj)
        end
    until true
end
function FX.prototype.parse(self, element)
    if __TS__StringStartsWith(element.tag, "VST") then
        for ____, x in ipairs(element.children) do
            if x.tag ~= nil then
                error(
                    __TS__New(
                        Error,
                        "fx chunk should not contain sub-elements, but found an element: " .. inspect(x)
                    ),
                    0
                )
            end
            if #x ~= 1 then
                error(
                    __TS__New(
                        Error,
                        "fx chunk line should only have 1 element: " .. inspect(x)
                    ),
                    0
                )
            end
        end
        local b64arr = __TS__ArrayMap(
            element.children,
            function(____, x) return x[1] end
        )
        local b64arrBlocks = __TS__ArrayReduce(
            b64arr,
            function(____, acc, line)
                local ____acc_index_0 = acc[#acc]
                ____acc_index_0[#____acc_index_0 + 1] = line
                if __TS__StringEndsWith(line, "=") then
                    acc[#acc + 1] = {}
                end
                return acc
            end,
            {{}}
        )
        if #b64arrBlocks[#b64arrBlocks] == 0 then
            table.remove(b64arrBlocks)
        end
        local b64blocks = __TS__ArrayMap(
            b64arrBlocks,
            function(____, lines) return table.concat(lines, "") end
        )
        local alldata = table.concat(
            __TS__ArrayMap(
                b64blocks,
                function(____, b) return Base64.decode(b) end
            ),
            ""
        )
        local vstid = string.sub(alldata, 1, 4)
        local magic = string.sub(alldata, 5, 8)
        local i = 8
        local inputCount = parseLittleEndianInteger(
            nil,
            __TS__StringSlice(alldata, i, i + 4)
        )
        i = i + 4
        i = i + inputCount * 8
        local outputCount = parseLittleEndianInteger(
            nil,
            __TS__StringSlice(alldata, i, i + 4)
        )
        i = i + 4
        i = i + outputCount * 8
        local fxdataLength = parseLittleEndianInteger(
            nil,
            __TS__StringSlice(alldata, i, i + 4)
        )
        i = i + 4
        local magicEnd = __TS__StringSlice(alldata, i, i + 8)
        i = i + 8
        local fxdataStart = i
        if not (fxdataStart + fxdataLength < #alldata) then
            error(
                __TS__New(Error, "fxdata exceeds actual chunk size"),
                0
            )
        end
        local headerdata = __TS__StringSlice(alldata, 0, fxdataStart)
        local fxdata = __TS__StringSlice(alldata, fxdataStart, fxdataStart + fxdataLength)
        local footerdata = __TS__StringSlice(alldata, fxdataStart + fxdataLength, #alldata)
        return {
            headerdata = headerdata,
            fxdata = fxdata,
            footerdata = footerdata,
            inputCount = inputCount,
            outputCount = outputCount,
            fxdataLength = fxdataLength,
            vstid = vstid,
            magic = magic
        }
    elseif __TS__StringStartsWith(element.tag, "CLAP") then
        local b64arr = (function()
            for ____, x in ipairs(element.children) do
                if x.tag ~= nil and x.tag == "STATE" then
                    for ____, y in ipairs(x.children) do
                        if y.tag ~= nil then
                            error(
                                __TS__New(
                                    Error,
                                    "clap state element should not contain sub-elements, but found an element: " .. inspect(y)
                                ),
                                0
                            )
                        end
                        if #y ~= 1 then
                            error(
                                __TS__New(
                                    Error,
                                    "fx chunk line should only have 1 element: " .. inspect(y)
                                ),
                                0
                            )
                        end
                    end
                    return __TS__ArrayMap(
                        x.children,
                        function(____, x) return x[1] end
                    )
                end
            end
            error("failed to get CLAP plugin state: " .. inspect(element))
        end)(nil)
        local fxdata = Base64.decode(table.concat(b64arr, ""))
        return {fxdata = fxdata}
    else
        error("this kind of fx chunk is not supported: " .. inspect(element))
    end
end
function FX.prototype.getData(self)
    local ____type = string.upper(self:getType())
    local chunk = nil
    if __TS__StringIncludes(____type, "VST") then
        chunk = self.chain:GetNamedConfigParm(self.fxidx, "vst_chunk")
    elseif __TS__StringIncludes(____type, "CLAP") then
        chunk = self.chain:GetNamedConfigParm(self.fxidx, "clap_chunk")
    else
        return nil
    end
    if chunk ~= nil then
        local arrchunk = self:getElement()
        local ____temp_1 = self:parse(arrchunk)
        local fxdata = ____temp_1.fxdata
        local testchunk = Base64.encode(fxdata)
        if chunk ~= testchunk then
            msgBox(nil, "Debug", "Successfully got chunk data the normal way!\nHowever, the alternative FX chunk parser would have given different output, please debug this!")
        end
    end
    if chunk == nil then
        local arrchunk = self:getElement()
        local ____temp_2 = self:parse(arrchunk)
        local fxdata = ____temp_2.fxdata
        chunk = Base64.encode(fxdata)
    end
    return chunk
end
function FX.prototype.isOffline(self)
    return self.chain:GetOffline(self.fxidx)
end
____exports.FXParam = __TS__Class()
local FXParam = ____exports.FXParam
FXParam.name = "FXParam"
function FXParam.prototype.____constructor(self, target, fxidx, param)
    if target.track ~= nil then
        self.chain = __TS__New(ReaperFXChain, {track = target.track})
    else
        self.chain = __TS__New(ReaperFXChain, {take = target.take})
    end
    self.fxidx = fxidx
    self.param = param
end
function FXParam.prototype._parseParamConfig(self, name, fallback)
    local text = self.chain:GetNamedConfigParm(
        self.fxidx,
        (("param." .. tostring(self.param)) .. ".") .. name
    )
    if not text then
        return fallback
    end
    local result = tonumber(text)
    if result == nil then
        error("failed to parse named config parm as number")
    end
    return result
end
function FXParam.prototype._setParamConfig(self, name, value)
    local key = (("param." .. tostring(self.param)) .. ".") .. name
    if type(value) == "number" then
        self.chain:SetNamedConfigParm(
            self.fxidx,
            key,
            tostring(value)
        )
    else
        self.chain:SetNamedConfigParm(self.fxidx, key, value and "1" or "0")
    end
end
function FXParam.prototype.getIdent(self)
    local rv = self.chain:GetParamIdent(self.fxidx, self.param)
    if not rv then
        error("param object is no longer valid")
    end
    return rv
end
function FXParam.prototype.getName(self)
    local rv = self.chain:GetParamName(self.fxidx, self.param)
    if not rv then
        error("param object is no longer valid")
    end
    return rv
end
function FXParam.prototype.getValue(self)
    local cur, min, max, mid = table.unpack(self.chain:GetParamEx(self.fxidx, self.param))
    return {cur = cur, min = min, max = max, mid = mid}
end
function FXParam.prototype.setValue(self, value)
    return self.chain:SetParam(self.fxidx, self.param, value)
end
function FXParam.prototype.modulationActive(self)
    return self:_parseParamConfig("mod.active", 0) == 1
end
function FXParam.prototype.getModulation(self)
    local modActive = self:_parseParamConfig("mod.active", 0) == 1
    if not modActive then
        return nil
    end
    local modInfo = {
        baseline = self:_parseParamConfig("mod.baseline", 0),
        acs = nil,
        lfo = nil,
        plink = nil
    }
    local lfoActive = self:_parseParamConfig("lfo.active", 0) == 1
    if lfoActive then
        modInfo.lfo = {
            dir = self:_parseParamConfig("lfo.dir", 1),
            phase = self:_parseParamConfig("lfo.phase", 0),
            speed = self:_parseParamConfig("lfo.speed", 1),
            strength = self:_parseParamConfig("lfo.strength", 1),
            tempoSync = self:_parseParamConfig("lfo.temposync", 0) == 1,
            free = self:_parseParamConfig("lfo.free", 0) == 1,
            shape = self:_parseParamConfig("lfo.shape", 0)
        }
    end
    local acsActive = self:_parseParamConfig("acs.active", 0) == 1
    if acsActive then
        modInfo.acs = {
            dir = self:_parseParamConfig("acs.dir", 1),
            strength = self:_parseParamConfig("acs.strength", 1),
            attack = self:_parseParamConfig("acs.attack", 300),
            release = self:_parseParamConfig("acs.release", 300),
            minVol = self:_parseParamConfig("acs.dblo", -24),
            maxVol = self:_parseParamConfig("acs.dbhi", 0),
            chan = self:_parseParamConfig("acs.chan", -1),
            stereo = self:_parseParamConfig("acs.stereo", 0) == 1,
            x2 = self:_parseParamConfig("acs.x2", 0.5),
            y2 = self:_parseParamConfig("acs.y2", 0.5)
        }
    end
    local plinkActive = self:_parseParamConfig("plink.active", 0) == 1
    if plinkActive then
        modInfo.plink = {
            scale = self:_parseParamConfig("plink.scale", 1),
            offset = self:_parseParamConfig("plink.offset", 0),
            fxidx = self:_parseParamConfig("plink.effect", -1),
            param = self:_parseParamConfig("plink.param", -1),
            midi_bus = self:_parseParamConfig("plink.midi_bus", 0),
            midi_chan = self:_parseParamConfig("plink.midi_chan", 0),
            midi_msg = self:_parseParamConfig("plink.midi_msg", 0),
            midi_msg2 = self:_parseParamConfig("plink.midi_msg2", 0)
        }
    end
    return modInfo
end
function FXParam.prototype.setModulation(self, modInfo)
    self:_setParamConfig("mod.active", modInfo ~= nil)
    if modInfo == nil then
        return
    end
    self:_setParamConfig("mod.baseline", modInfo.baseline)
    self:_setParamConfig("lfo.active", modInfo.lfo ~= nil)
    if modInfo.lfo ~= nil then
        self:_setParamConfig("lfo.dir", modInfo.lfo.dir)
        self:_setParamConfig("lfo.phase", modInfo.lfo.phase)
        self:_setParamConfig("lfo.speed", modInfo.lfo.speed)
        self:_setParamConfig("lfo.strength", modInfo.lfo.strength)
        self:_setParamConfig("lfo.temposync", modInfo.lfo.tempoSync)
        self:_setParamConfig("lfo.free", modInfo.lfo.free)
        self:_setParamConfig("lfo.shape", modInfo.lfo.shape)
    end
    self:_setParamConfig("acs.active", modInfo.acs ~= nil)
    if modInfo.acs ~= nil then
        self:_setParamConfig("acs.dir", modInfo.acs.dir)
        self:_setParamConfig("acs.strength", modInfo.acs.strength)
        self:_setParamConfig("acs.attack", modInfo.acs.attack)
        self:_setParamConfig("acs.release", modInfo.acs.release)
        self:_setParamConfig("acs.dblo", modInfo.acs.minVol)
        self:_setParamConfig("acs.dbhi", modInfo.acs.maxVol)
        self:_setParamConfig("acs.chan", modInfo.acs.chan)
        self:_setParamConfig("acs.stereo", modInfo.acs.stereo)
        self:_setParamConfig("acs.x2", modInfo.acs.x2)
        self:_setParamConfig("acs.y2", modInfo.acs.y2)
    end
    self:_setParamConfig("plink.active", modInfo.plink ~= nil)
    if modInfo.plink then
        self:_setParamConfig("plink.scale", modInfo.plink.scale)
        self:_setParamConfig("plink.offset", modInfo.plink.offset)
        self:_setParamConfig("plink.effect", modInfo.plink.fxidx)
        self:_setParamConfig("plink.param", modInfo.plink.param)
        self:_setParamConfig("plink.midi_bus", modInfo.plink.midi_bus)
        self:_setParamConfig("plink.midi_chan", modInfo.plink.midi_chan)
        self:_setParamConfig("plink.midi_msg", modInfo.plink.midi_msg)
        self:_setParamConfig("plink.midi_msg2", modInfo.plink.midi_msg2)
    end
    return modInfo
end
function ____exports.getLastTouchedFx(self)
    local retval, trackidx, itemidx, takeidx, fxidx, parm = reaper.GetTouchedOrFocusedFX(1)
    if not retval then
        return nil
    end
    local isMaster = trackidx == -1
    local track = isMaster and reaper.GetMasterTrack(0) or reaper.GetTrack(0, trackidx)
    if track == nil then
        error("failed to get track belonging to last-touched fx: track " .. tostring(trackidx))
    end
    if itemidx == -1 then
        return __TS__New(____exports.FX, {track = track}, fxidx)
    else
        local item = reaper.GetTrackMediaItem(track, itemidx)
        local take = reaper.GetTake(item, takeidx)
        return __TS__New(____exports.FX, {take = take}, fxidx)
    end
end
return ____exports
 end,
["lua_modules.reaper-api.element"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__StringCharAt = ____lualib.__TS__StringCharAt
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local __TS__StringSlice = ____lualib.__TS__StringSlice
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__StringReplaceAll = ____lualib.__TS__StringReplaceAll
local ____exports = {}
local serialiseTerm, serializeToStringSub
function serialiseTerm(self, text)
    if #text == 0 then
        return "\"\""
    end
    text = __TS__StringReplaceAll(text, "`", "'")
    local firstChar = string.sub(text, 1, 1)
    local needsToBeQuoted = firstChar == "'" or firstChar == "\""
    local hasDblQuote = false
    local hasSglQuote = false
    for x in string.gmatch(text, ".") do
        if x == " " then
            needsToBeQuoted = true
        elseif x == "'" then
            hasSglQuote = true
        elseif x == "\"" then
            hasDblQuote = true
        end
    end
    if not needsToBeQuoted then
        return text
    end
    local quoteChar
    if hasDblQuote and hasSglQuote then
        quoteChar = "`"
    elseif hasDblQuote then
        quoteChar = "'"
    else
        quoteChar = "\""
    end
    return (quoteChar .. text) .. quoteChar
end
function serializeToStringSub(self, buf, element, indentLevel)
    do
        local i = 0
        while i < indentLevel do
            buf[#buf + 1] = "  "
            i = i + 1
        end
    end
    buf[#buf + 1] = "<"
    buf[#buf + 1] = element.tag
    for ____, x in ipairs(element.attr) do
        buf[#buf + 1] = " "
        buf[#buf + 1] = serialiseTerm(nil, x)
    end
    buf[#buf + 1] = "\n"
    for ____, child in ipairs(element.children) do
        if child.tag ~= nil then
            serializeToStringSub(nil, buf, child, indentLevel + 1)
            buf[#buf + 1] = "\n"
        else
            do
                local i = 0
                while i < indentLevel + 1 do
                    buf[#buf + 1] = "  "
                    i = i + 1
                end
            end
            local isFirst = true
            for ____, x in ipairs(child) do
                x = serialiseTerm(nil, x)
                if isFirst then
                    isFirst = false
                else
                    buf[#buf + 1] = " "
                end
                buf[#buf + 1] = x
            end
            buf[#buf + 1] = "\n"
        end
    end
    do
        local i = 0
        while i < indentLevel do
            buf[#buf + 1] = "  "
            i = i + 1
        end
    end
    buf[#buf + 1] = ">"
end
local Err = {ok = false}
local function clone(self, i)
    return {source = i.source, start = i.start, ["end"] = i["end"]}
end
local function alt(self, ...)
    local parsers = {...}
    return function(____, span)
        do
            local i = 0
            while i < #parsers do
                local parser = parsers[i + 1]
                local result = parser(nil, span)
                if result.ok then
                    return result
                end
                i = i + 1
            end
        end
        return Err
    end
end
local function preceded(self, a, b)
    return function(____, span)
        local lhs = a(nil, span)
        if not lhs.ok then
            return Err
        end
        span = lhs.rest
        return b(nil, span)
    end
end
local function delimited(self, parserA, parserT, parserB)
    return function(____, rest)
        local lhs = parserA(nil, rest)
        if not lhs.ok then
            return Err
        end
        rest = lhs.rest
        local mid = parserT(nil, rest)
        if not mid.ok then
            return Err
        end
        rest = mid.rest
        local rhs = parserB(nil, rest)
        if not rhs.ok then
            return Err
        end
        rest = rhs.rest
        return {ok = true, out = mid.out, rest = rest}
    end
end
local function many0(self, parser)
    return function(____, span)
        local firstElement = parser(nil, span)
        if not firstElement.ok then
            return {ok = true, out = {}, rest = span}
        end
        local result = {firstElement.out}
        span = firstElement.rest
        while true do
            local nextElement = parser(nil, span)
            if not nextElement.ok then
                return {ok = true, out = result, rest = span}
            end
            result[#result + 1] = nextElement.out
            span = nextElement.rest
        end
    end
end
local function manyTill(self, parserA, parserB)
    return function(____, rest)
        local result = {}
        while true do
            local ending = parserB(nil, rest)
            if ending.ok then
                rest = ending.rest
                return {ok = true, out = {result, ending.out}, rest = rest}
            else
                local element = parserA(nil, rest)
                if not element.ok then
                    return Err
                end
                result[#result + 1] = element.out
                rest = element.rest
            end
        end
    end
end
local function space0(self, rest)
    local originalStart = rest.start
    rest = clone(nil, rest)
    while rest.start < rest["end"] do
        local stringChar = __TS__StringCharAt(rest.source, rest.start)
        if stringChar ~= " " and stringChar ~= "\t" then
            break
        end
        rest.start = rest.start + 1
    end
    return {ok = true, out = {source = rest.source, start = originalStart, ["end"] = rest.start}, rest = rest}
end
local function space1(self, rest)
    local originalStart = rest.start
    rest = clone(nil, rest)
    while rest.start < rest["end"] do
        local stringChar = __TS__StringCharAt(rest.source, rest.start)
        if stringChar ~= " " and stringChar ~= "\t" then
            break
        end
        rest.start = rest.start + 1
    end
    if rest.start == originalStart then
        return Err
    end
    return {ok = true, out = {source = rest.source, start = originalStart, ["end"] = rest.start}, rest = rest}
end
local function multispace0(self, rest)
    local originalStart = rest.start
    rest = clone(nil, rest)
    while rest.start < rest["end"] do
        local stringChar = __TS__StringCharAt(rest.source, rest.start)
        if stringChar ~= " " and stringChar ~= "\t" and stringChar ~= "\r" and stringChar ~= "\n" then
            break
        end
        rest.start = rest.start + 1
    end
    return {ok = true, out = {source = rest.source, start = originalStart, ["end"] = rest.start}, rest = rest}
end
--- Matches '\n' or '\r\n'.
-- 
-- @param rest
local function lineEnding(self, rest)
    local firstChar = __TS__StringCharAt(rest.source, rest.start)
    if firstChar == "\n" then
        return {ok = true, out = {source = rest.source, start = rest.start, ["end"] = rest.start + 1}, rest = {source = rest.source, start = rest.start + 1, ["end"] = rest["end"]}}
    elseif firstChar == "\r" then
        local secondChar = __TS__StringCharAt(rest.source, rest.start + 1)
        if secondChar == "\n" then
            return {ok = true, out = {source = rest.source, start = rest.start, ["end"] = rest.start + 2}, rest = {source = rest.source, start = rest.start + 2, ["end"] = rest["end"]}}
        end
    end
    return {ok = false}
end
local function quotedString(self, rest)
    local quoteChar = __TS__StringCharAt(rest.source, rest.start)
    if not __TS__StringIncludes("\"'`", quoteChar) then
        return Err
    end
    local originalStart = rest.start
    rest = clone(nil, rest)
    rest.start = rest.start + 1
    while rest.start < rest["end"] do
        local stringChar = __TS__StringCharAt(rest.source, rest.start)
        if stringChar == quoteChar or stringChar == "\n" or stringChar == "\r" then
            break
        end
        rest.start = rest.start + 1
    end
    if __TS__StringCharAt(rest.source, rest.start) ~= quoteChar then
        return Err
    end
    rest.start = rest.start + 1
    return {ok = true, out = {source = rest.source, start = originalStart + 1, ["end"] = rest.start - 1}, rest = rest}
end
local function unquotedString(self, rest)
    local quoteChar = __TS__StringCharAt(rest.source, rest.start)
    if __TS__StringIncludes("\"'`", quoteChar) then
        return Err
    end
    local originalStart = rest.start
    rest = clone(nil, rest)
    while rest.start < rest["end"] do
        local stringChar = __TS__StringCharAt(rest.source, rest.start)
        if stringChar == " " or stringChar == "\n" or stringChar == "\r" then
            break
        end
        rest.start = rest.start + 1
    end
    if rest.start == originalStart then
        return Err
    end
    return {ok = true, out = {source = rest.source, start = originalStart, ["end"] = rest.start}, rest = rest}
end
local function parseString(self, rest)
    return alt(nil, unquotedString, quotedString)(nil, rest)
end
local function stringList(self, rest)
    local firstElement = parseString(nil, rest)
    if not firstElement.ok then
        return Err
    end
    local result = {firstElement.out}
    rest = firstElement.rest
    while true do
        local nextElement = preceded(nil, space1, parseString)(nil, rest)
        if not nextElement.ok then
            return {ok = true, out = result, rest = rest}
        end
        result[#result + 1] = nextElement.out
        rest = nextElement.rest
    end
end
local function elementStart(self, rest)
    local firstChar = __TS__StringCharAt(rest.source, rest.start)
    if firstChar ~= "<" then
        return Err
    end
    rest = clone(nil, rest)
    rest.start = rest.start + 1
    return {ok = true, out = nil, rest = rest}
end
local function elementEnd(self, rest)
    local firstChar = __TS__StringCharAt(rest.source, rest.start)
    if firstChar ~= ">" then
        return Err
    end
    rest = clone(nil, rest)
    rest.start = rest.start + 1
    return {ok = true, out = nil, rest = rest}
end
local elementTag = unquotedString
local function element(self, rest)
    local startChar = elementStart(nil, rest)
    if not startChar.ok then
        return Err
    end
    rest = startChar.rest
    local tag = elementTag(nil, rest)
    if not tag.ok then
        return Err
    end
    rest = tag.rest
    local attr = many0(
        nil,
        preceded(nil, space1, parseString)
    )(nil, rest)
    if not attr.ok then
        return Err
    end
    rest = attr.rest
    do
        local space = space0(nil, rest)
        if not space.ok then
            return Err
        end
        rest = space.rest
        local newline = lineEnding(nil, rest)
        if not newline.ok then
            return Err
        end
        rest = newline.rest
    end
    local children = manyTill(
        nil,
        delimited(
            nil,
            space0,
            alt(nil, element, stringList),
            preceded(nil, space0, lineEnding)
        ),
        preceded(nil, space0, elementEnd)
    )(nil, rest)
    if not children.ok then
        return Err
    end
    rest = children.rest
    local out = {tag = tag.out, attr = attr.out, children = children.out[1]}
    return {ok = true, out = out, rest = rest}
end
local function spanToString(self, x)
    return __TS__StringSlice(x.source, x.start, x["end"])
end
local function spanElementToStringElement(self, ele)
    return {
        tag = spanToString(nil, ele.tag),
        attr = __TS__ArrayMap(
            ele.attr,
            function(____, x) return spanToString(nil, x) end
        ),
        children = __TS__ArrayMap(
            ele.children,
            function(____, child)
                if child.tag ~= nil then
                    return spanElementToStringElement(nil, child)
                else
                    return __TS__ArrayMap(
                        child,
                        function(____, x) return spanToString(nil, x) end
                    )
                end
            end
        )
    }
end
function ____exports.parse(self, input)
    local rest = {source = input, start = 0, ["end"] = #input}
    local result = delimited(nil, multispace0, element, multispace0)(nil, rest)
    if not result.ok then
        error(
            __TS__New(Error, "Failed to parse element"),
            0
        )
    end
    if result.rest.start ~= #input then
        error(
            __TS__New(Error, "Trailing data at end of input"),
            0
        )
    end
    return spanElementToStringElement(nil, result.out)
end
function ____exports.serialize(self, element)
    local buf = {}
    serializeToStringSub(nil, buf, element, 0)
    return table.concat(buf, "")
end
return ____exports
 end,
["lua_modules.reaper-api.chunk"] = function(...) 
local module = {}

--[[
  get/set state chunk for a track. argument `chunk` is optional
 ]]
module.track = function(track, chunk)
  if chunk == nil then
    local rv, xml = reaper.GetTrackStateChunk(track, "", false)
    if not rv then return nil, "Failed to get track state chunk" end
    return xml
  else
    local rv = reaper.SetTrackStateChunk(track, chunk, false)
    if not rv then return nil, "Failed to set track state chunk" end
    return true
  end
end

--[[
  get/set state chunk for a item. argument `chunk` is optional
 ]]
module.item = function(item, chunk)
  if chunk == nil then
    local rv, xml = reaper.GetItemStateChunk(item, "", false)
    if not rv then return nil, "Failed to get item state chunk" end
    return xml
  else
    local rv = reaper.SetItemStateChunk(item, chunk, false)
    if not rv then return nil, "Failed to set item state chunk" end
    return true
  end
end

--[[
  get/set state chunk for an envelope. argument `chunk` is optional
 ]]
module.envelope = function(envelope, chunk)
  if chunk == nil then
    local rv, xml = reaper.GetEnvelopeStateChunk(envelope, "", false)
    if not rv then return nil, "Failed to get envelope state chunk" end
    return xml
  else
    local rv = reaper.SetEnvelopeStateChunk(envelope, chunk, false)
    if not rv then return nil, "Failed to set envelope state chunk" end
    return true
  end
end

--[[
  escape a string to be used in a state chunk
 ]]
module.escape_string = function(name)
  if name == "" then
    return '""'
  elseif not name:find(" ") and not name:find("^[\"'`]") then
    -- single word with no quote at start, return as is
    return name
  else
    -- replace existing backquotes with single quotes then surround with backquotes
    name = name:gsub("`","'")
    name = "`" .. name .. "`"
    return name
  end
end

--[[
  find the next element with the given tag, return the character position in the chunk
  `tag` can be an array of tags to match
 ]]
module.findElement = function(chunk, tag, search_pos)
  if search_pos == nil then search_pos = 0 end

  if type(tag) == "table" then
    local found_pos = {}
    local i = 1
    for _, t in ipairs(tag) do
      local pos = chunk:find("<%s*" .. t .. "%s", search_pos)
      if pos then
        found_pos[i] = pos
        i = i + 1
      end
    end
    if i == 1 then
      return nil
    else
      return math.min(table.unpack(found_pos))
    end
  else
    local pattern = "<%s*" .. tag .. "%s"
    return ({chunk:find(pattern, search_pos)})[1]
  end
end

--[[
  this splits a text like:
  ```plain
  VST "VSTi: IL Harmor (Image-Line)" "IL Harmor.dll" 0 `d " s ' b '` 1229483375<56535449486D6F696C206861726D6F72> ""
  ```
  this assumes the first item doesn't start with a quote
 ]]
module.splitLine = function(line)
  local items = {}
  while true do
    local _, first_quote_pos = line:find(" [\"'`]")
    if first_quote_pos == nil then
      -- all remaining words are unquoted, add them
      for word in line:gmatch("%S+") do
        items[#items + 1] = word
      end
      return items
    else
      local first_quote = line:sub(first_quote_pos, first_quote_pos)
      -- add each unquoted word before the found quote
      for word in line:sub(0, first_quote_pos - 1):gmatch("%S+") do
        items[#items + 1] = word
      end
      -- find end quote position, then add entire string
      local end_quote_pos = line:find(first_quote, first_quote_pos + 1, true)
      if end_quote_pos == nil then return nil, "Error matching end quote: " .. first_quote end
      items[#items + 1] = line:sub(first_quote_pos, end_quote_pos)
      -- remove everything before end of string
      line = line:sub(end_quote_pos + 1, -1)
    end
  end
end

--[[
  remove quotes from a string if it exists, return as-is if no quotes found
 ]]
module.removeStringQuotes = function(text)
  if text:match("^[\"'`]") then
    return text:sub(2, -2)
  else
    return text
  end
end

return module
 end,
["lua_modules.reaper-api.base64"] = function(...) 
--[[

 base64 -- v1.5.3 public domain Lua base64 encoder/decoder
 no warranty implied; use at your own risk

 Needs bit32.extract function. If not present it's implemented using BitOp
 or Lua 5.3 native bit operators. For Lua 5.1 fallbacks to pure Lua
 implementation inspired by Rici Lake's post:
   http://ricilake.blogspot.co.uk/2007/10/iterating-bits-in-lua.html

 author: Ilya Kolbin (iskolbin@gmail.com)
 url: github.com/iskolbin/lbase64

 COMPATIBILITY

 Lua 5.1+, LuaJIT

 LICENSE

 See end of file for license information.

--]]


local base64 = {}

local extract = _G.bit32 and _G.bit32.extract -- Lua 5.2/Lua 5.3 in compatibility mode
if not extract then
	if _G.bit then -- LuaJIT
		local shl, shr, band = _G.bit.lshift, _G.bit.rshift, _G.bit.band
		extract = function( v, from, width )
			return band( shr( v, from ), shl( 1, width ) - 1 )
		end
	elseif _G._VERSION == "Lua 5.1" then
		extract = function( v, from, width )
			local w = 0
			local flag = 2^from
			for i = 0, width-1 do
				local flag2 = flag + flag
				if v % flag2 >= flag then
					w = w + 2^i
				end
				flag = flag2
			end
			return w
		end
	else -- Lua 5.3+
		extract = load[[return function( v, from, width )
			return ( v >> from ) & ((1 << width) - 1)
		end]]()
	end
end


function base64.makeencoder( s62, s63, spad )
	local encoder = {}
	for b64code, char in pairs{[0]='A','B','C','D','E','F','G','H','I','J',
		'K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y',
		'Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n',
		'o','p','q','r','s','t','u','v','w','x','y','z','0','1','2',
		'3','4','5','6','7','8','9',s62 or '+',s63 or'/',spad or'='} do
		encoder[b64code] = char:byte()
	end
	return encoder
end

function base64.makedecoder( s62, s63, spad )
	local decoder = {}
	for b64code, charcode in pairs( base64.makeencoder( s62, s63, spad )) do
		decoder[charcode] = b64code
	end
	return decoder
end

local DEFAULT_ENCODER = base64.makeencoder()
local DEFAULT_DECODER = base64.makedecoder()

local char, concat = string.char, table.concat

function base64.encode( str, encoder, usecaching )
	encoder = encoder or DEFAULT_ENCODER
	local t, k, n = {}, 1, #str
	local lastn = n % 3
	local cache = {}
	for i = 1, n-lastn, 3 do
		local a, b, c = str:byte( i, i+2 )
		local v = a*0x10000 + b*0x100 + c
		local s
		if usecaching then
			s = cache[v]
			if not s then
				s = char(encoder[extract(v,18,6)], encoder[extract(v,12,6)], encoder[extract(v,6,6)], encoder[extract(v,0,6)])
				cache[v] = s
			end
		else
			s = char(encoder[extract(v,18,6)], encoder[extract(v,12,6)], encoder[extract(v,6,6)], encoder[extract(v,0,6)])
		end
		t[k] = s
		k = k + 1
	end
	if lastn == 2 then
		local a, b = str:byte( n-1, n )
		local v = a*0x10000 + b*0x100
		t[k] = char(encoder[extract(v,18,6)], encoder[extract(v,12,6)], encoder[extract(v,6,6)], encoder[64])
	elseif lastn == 1 then
		local v = str:byte( n )*0x10000
		t[k] = char(encoder[extract(v,18,6)], encoder[extract(v,12,6)], encoder[64], encoder[64])
	end
	return concat( t )
end

function base64.decode( b64, decoder, usecaching )
	decoder = decoder or DEFAULT_DECODER
	local pattern = '[^%w%+%/%=]'
	if decoder then
		local s62, s63
		for charcode, b64code in pairs( decoder ) do
			if b64code == 62 then s62 = charcode
			elseif b64code == 63 then s63 = charcode
			end
		end
		pattern = ('[^%%w%%%s%%%s%%=]'):format( char(s62), char(s63) )
	end
	b64 = b64:gsub( pattern, '' )
	local cache = usecaching and {}
	local t, k = {}, 1
	local n = #b64
	local padding = b64:sub(-2) == '==' and 2 or b64:sub(-1) == '=' and 1 or 0
	for i = 1, padding > 0 and n-4 or n, 4 do
		local a, b, c, d = b64:byte( i, i+3 )
		local s
		if usecaching then
			local v0 = a*0x1000000 + b*0x10000 + c*0x100 + d
			s = cache[v0]
			if not s then
				local v = decoder[a]*0x40000 + decoder[b]*0x1000 + decoder[c]*0x40 + decoder[d]
				s = char( extract(v,16,8), extract(v,8,8), extract(v,0,8))
				cache[v0] = s
			end
		else
			local v = decoder[a]*0x40000 + decoder[b]*0x1000 + decoder[c]*0x40 + decoder[d]
			s = char( extract(v,16,8), extract(v,8,8), extract(v,0,8))
		end
		t[k] = s
		k = k + 1
	end
	if padding == 1 then
		local a, b, c = b64:byte( n-3, n-1 )
		local v = decoder[a]*0x40000 + decoder[b]*0x1000 + decoder[c]*0x40
		t[k] = char( extract(v,16,8), extract(v,8,8))
	elseif padding == 2 then
		local a, b = b64:byte( n-3, n-2 )
		local v = decoder[a]*0x40000 + decoder[b]*0x1000
		t[k] = char( extract(v,16,8))
	end
	return concat( t )
end

return base64

--[[
------------------------------------------------------------------------------
This software is available under 2 licenses -- choose whichever you prefer.
------------------------------------------------------------------------------
ALTERNATIVE A - MIT License
Copyright (c) 2018 Ilya Kolbin
Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
------------------------------------------------------------------------------
ALTERNATIVE B - Public Domain (www.unlicense.org)
This is free and unencumbered software released into the public domain.
Anyone is free to copy, modify, publish, use, compile, sell, or distribute this
software, either in source code form or as a compiled binary, for any purpose,
commercial or non-commercial, and by any means.
In jurisdictions that recognize copyright laws, the author or authors of this
software dedicate any and all copyright interest in the software to the public
domain. We make this dedication for the benefit of the public at large and to
the detriment of our heirs and successors. We intend this dedication to be an
overt act of relinquishment in perpetuity of all present and future rights to
this software under copyright law.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
------------------------------------------------------------------------------
--]] end,
["lua_modules.reaper-api.extstate"] = function(...) 
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
 end,
["lua_modules.reaper-api.lua_modules.json.index"] = function(...) 
--
-- json.lua
--
-- Copyright (c) 2020 rxi
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of
-- this software and associated documentation files (the "Software"), to deal in
-- the Software without restriction, including without limitation the rights to
-- use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
-- of the Software, and to permit persons to whom the Software is furnished to do
-- so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--

local json = { _version = "0.1.2" }

-------------------------------------------------------------------------------
-- Encode
-------------------------------------------------------------------------------

local encode

local escape_char_map = {
	["\\"] = "\\",
	['"'] = '"',
	["\b"] = "b",
	["\f"] = "f",
	["\n"] = "n",
	["\r"] = "r",
	["\t"] = "t",
}

local escape_char_map_inv = { ["/"] = "/" }
for k, v in pairs(escape_char_map) do
	escape_char_map_inv[v] = k
end

local function escape_char(c)
	return "\\" .. (escape_char_map[c] or string.format("u%04x", c:byte()))
end

local function encode_nil(val)
	return "null"
end

local function encode_table(val, stack)
	local res = {}
	stack = stack or {}

	-- Circular reference?
	if stack[val] then
		error("circular reference")
	end

	stack[val] = true

	if rawget(val, 1) ~= nil or next(val) == nil then
		-- Treat as array -- check keys are valid and it is not sparse
		local n = 0
		for k in pairs(val) do
			if type(k) ~= "number" then
				error("invalid table: mixed or invalid key types")
			end
			n = n + 1
		end
		if n ~= #val then
			error("invalid table: sparse array")
		end
		-- Encode
		for i, v in ipairs(val) do
			table.insert(res, encode(v, stack))
		end
		stack[val] = nil
		return "[" .. table.concat(res, ",") .. "]"
	else
		-- Treat as an object
		for k, v in pairs(val) do
			if type(k) ~= "string" then
				error("invalid table: mixed or invalid key types")
			end
			table.insert(res, encode(k, stack) .. ":" .. encode(v, stack))
		end
		stack[val] = nil
		return "{" .. table.concat(res, ",") .. "}"
	end
end

local function encode_string(val)
	return '"' .. val:gsub('[%z\1-\31\\"]', escape_char) .. '"'
end

local function encode_number(val)
	-- Check for NaN, -inf and inf
	if val ~= val or val <= -math.huge or val >= math.huge then
		error("unexpected number value '" .. tostring(val) .. "'")
	end
	return string.format("%.14g", val)
end

local type_func_map = {
	["nil"] = encode_nil,
	["table"] = encode_table,
	["string"] = encode_string,
	["number"] = encode_number,
	["boolean"] = tostring,
}

encode = function(val, stack)
	local t = type(val)
	local f = type_func_map[t]
	if f then
		return f(val, stack)
	end
	error("unexpected type '" .. t .. "'")
end

function json.encode(val)
	return (encode(val))
end

-------------------------------------------------------------------------------
-- Decode
-------------------------------------------------------------------------------

local parse

local function create_set(...)
	local res = {}
	for i = 1, select("#", ...) do
		res[select(i, ...)] = true
	end
	return res
end

local space_chars = create_set(" ", "\t", "\r", "\n")
local delim_chars = create_set(" ", "\t", "\r", "\n", "]", "}", ",")
local escape_chars = create_set("\\", "/", '"', "b", "f", "n", "r", "t", "u")
local literals = create_set("true", "false", "null")

local literal_map = {
	["true"] = true,
	["false"] = false,
	["null"] = nil,
}

local function next_char(str, idx, set, negate)
	for i = idx, #str do
		if set[str:sub(i, i)] ~= negate then
			return i
		end
	end
	return #str + 1
end

local function decode_error(str, idx, msg)
	local line_count = 1
	local col_count = 1
	for i = 1, idx - 1 do
		col_count = col_count + 1
		if str:sub(i, i) == "\n" then
			line_count = line_count + 1
			col_count = 1
		end
	end
	error(string.format("%s at line %d col %d", msg, line_count, col_count))
end

local function codepoint_to_utf8(n)
	-- http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=iws-appendixa
	local f = math.floor
	if n <= 0x7f then
		return string.char(n)
	elseif n <= 0x7ff then
		return string.char(f(n / 64) + 192, n % 64 + 128)
	elseif n <= 0xffff then
		return string.char(f(n / 4096) + 224, f(n % 4096 / 64) + 128, n % 64 + 128)
	elseif n <= 0x10ffff then
		return string.char(f(n / 262144) + 240, f(n % 262144 / 4096) + 128, f(n % 4096 / 64) + 128, n % 64 + 128)
	end
	error(string.format("invalid unicode codepoint '%x'", n))
end

local function parse_unicode_escape(s)
	local n1 = tonumber(s:sub(1, 4), 16)
	local n2 = tonumber(s:sub(7, 10), 16)
	-- Surrogate pair?
	if n2 then
		return codepoint_to_utf8((n1 - 0xd800) * 0x400 + (n2 - 0xdc00) + 0x10000)
	else
		return codepoint_to_utf8(n1)
	end
end

local function parse_string(str, i)
	local res = ""
	local j = i + 1
	local k = j

	while j <= #str do
		local x = str:byte(j)

		if x < 32 then
			decode_error(str, j, "control character in string")
		elseif x == 92 then -- `\`: Escape
			res = res .. str:sub(k, j - 1)
			j = j + 1
			local c = str:sub(j, j)
			if c == "u" then
				local hex = str:match("^[dD][89aAbB]%x%x\\u%x%x%x%x", j + 1)
					or str:match("^%x%x%x%x", j + 1)
					or decode_error(str, j - 1, "invalid unicode escape in string")
				res = res .. parse_unicode_escape(hex)
				j = j + #hex
			else
				if not escape_chars[c] then
					decode_error(str, j - 1, "invalid escape char '" .. c .. "' in string")
				end
				res = res .. escape_char_map_inv[c]
			end
			k = j + 1
		elseif x == 34 then -- `"`: End of string
			res = res .. str:sub(k, j - 1)
			return res, j + 1
		end

		j = j + 1
	end

	decode_error(str, i, "expected closing quote for string")
end

local function parse_number(str, i)
	local x = next_char(str, i, delim_chars)
	local s = str:sub(i, x - 1)
	local n = tonumber(s)
	if not n then
		decode_error(str, i, "invalid number '" .. s .. "'")
	end
	return n, x
end

local function parse_literal(str, i)
	local x = next_char(str, i, delim_chars)
	local word = str:sub(i, x - 1)
	if not literals[word] then
		decode_error(str, i, "invalid literal '" .. word .. "'")
	end
	return literal_map[word], x
end

local function parse_array(str, i)
	local res = {}
	local n = 1
	i = i + 1
	while 1 do
		local x
		i = next_char(str, i, space_chars, true)
		-- Empty / end of array?
		if str:sub(i, i) == "]" then
			i = i + 1
			break
		end
		-- Read token
		x, i = parse(str, i)
		res[n] = x
		n = n + 1
		-- Next token
		i = next_char(str, i, space_chars, true)
		local chr = str:sub(i, i)
		i = i + 1
		if chr == "]" then
			break
		end
		if chr ~= "," then
			decode_error(str, i, "expected ']' or ','")
		end
	end
	return res, i
end

local function parse_object(str, i)
	local res = {}
	i = i + 1
	while 1 do
		local key, val
		i = next_char(str, i, space_chars, true)
		-- Empty / end of object?
		if str:sub(i, i) == "}" then
			i = i + 1
			break
		end
		-- Read key
		if str:sub(i, i) ~= '"' then
			decode_error(str, i, "expected string for key")
		end
		key, i = parse(str, i)
		-- Read ':' delimiter
		i = next_char(str, i, space_chars, true)
		if str:sub(i, i) ~= ":" then
			decode_error(str, i, "expected ':' after key")
		end
		i = next_char(str, i + 1, space_chars, true)
		-- Read value
		val, i = parse(str, i)
		-- Set
		res[key] = val
		-- Next token
		i = next_char(str, i, space_chars, true)
		local chr = str:sub(i, i)
		i = i + 1
		if chr == "}" then
			break
		end
		if chr ~= "," then
			decode_error(str, i, "expected '}' or ','")
		end
	end
	return res, i
end

local char_func_map = {
	['"'] = parse_string,
	["0"] = parse_number,
	["1"] = parse_number,
	["2"] = parse_number,
	["3"] = parse_number,
	["4"] = parse_number,
	["5"] = parse_number,
	["6"] = parse_number,
	["7"] = parse_number,
	["8"] = parse_number,
	["9"] = parse_number,
	["-"] = parse_number,
	["t"] = parse_literal,
	["f"] = parse_literal,
	["n"] = parse_literal,
	["["] = parse_array,
	["{"] = parse_object,
}

parse = function(str, idx)
	local chr = str:sub(idx, idx)
	local f = char_func_map[chr]
	if f then
		return f(str, idx)
	end
	decode_error(str, idx, "unexpected character '" .. chr .. "'")
end

function json.decode(str)
	if type(str) ~= "string" then
		error("expected argument of type string, got " .. type(str))
	end
	local res, idx = parse(str, next_char(str, 1, space_chars, true))
	idx = next_char(str, idx, space_chars, true)
	if idx <= #str then
		decode_error(str, idx, "trailing garbage")
	end
	return res
end

return json
 end,
}
return require("index", ...)

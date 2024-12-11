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

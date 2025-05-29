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
local ____exports = {}
local ____utils = require("lua_modules.reaper-api.utils")
local errorHandler = ____utils.errorHandler
local ____common = require("common")
local applyNewBpmToSelectedItems = ____common.applyNewBpmToSelectedItems
local config = ____common.config

errorHandler(
    nil,
    function()
        if config.sourceBpm == 0 then
            error(
                __TS__New(Error, "Source BPM is not set, please run the GUI first!"),
                0
            )
        end
        if config.targetBpm == 0 then
            error(
                __TS__New(Error, "Target BPM is not set, please run the GUI first!"),
                0
            )
        end
        applyNewBpmToSelectedItems(nil, config.sourceBpm, config.targetBpm, true)
    end
)
return ____exports

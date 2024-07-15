-- Fix import paths
local __script_directory = ({reaper.get_action_context()})[2]:match('^(.+[\\\\//])') .. "?.lua"
package.path = __script_directory .. ";" .. package.path

local ____lualib = require("lualib_bundle")
local __TS__ObjectEntries = ____lualib.__TS__ObjectEntries
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local ____exports = {}
local ____json = require("lua_modules.json.index")
local encode = ____json.encode
local ____reaper_2Dmicroui = require("lua_modules.reaper-microui.build.index")
local createContext = ____reaper_2Dmicroui.createContext
local microUILoop = ____reaper_2Dmicroui.microUILoop
local Option = ____reaper_2Dmicroui.Option
local ____fx = require("lua_modules.reaper-api.fx")
local getLastTouchedFx = ____fx.getLastTouchedFx

local function main(self)
    gfx.init("My window", 260, 450)
    gfx.setfont(1, "Arial", 16)
    local ctx = createContext(nil)
    microUILoop(
        nil,
        ctx,
        function()
            local fx = getLastTouchedFx(nil)
            ctx:begin()
            if ctx:beginWindow("Demo Window", {x = 0, y = 0, w = 0, h = 0}, Option.NoResize | Option.NoTitle | Option.NoClose) then
                local win = ctx:getCurrentContainer()
                win.rect.w = gfx.w
                win.rect.h = gfx.h
                if fx == nil then
                    ctx:text("null")
                else
                    ctx:text(encode({type = fx.type, fxid = fx.fxidx}))
                    ctx:layoutRow({80, -1}, 0)
                    ctx:label("Parent type")
                    ctx:label(fx.type)
                    ctx:label("FX index")
                    ctx:label(tostring(fx.fxidx))
                    local parms = {"pdc", "fx_type", "fx_name", "fx_ident"}
                    for ____, parm in ipairs(parms) do
                        ctx:label(parm)
                        ctx:label(fx:GetNamedConfigParm(parm) or "<FAILED>")
                    end
                    __TS__ArrayForEach(
                        fx:getParameters(),
                        function(____, param, i)
                            local title = ((((tostring(i) .. ". ") .. param:getName()) .. " (") .. param:getIdent()) .. ")"
                            if ctx:header(title) then
                                local info = param:getModulation()
                                if not info then
                                    ctx:layoutRow({-1}, 0)
                                    ctx:label("null")
                                    return
                                end
                                ctx:layoutRow({60, -1}, 0)
                                __TS__ArrayForEach(
                                    __TS__ObjectEntries(info),
                                    function(____, ____bindingPattern0)
                                        local v
                                        local k
                                        k = ____bindingPattern0[1]
                                        v = ____bindingPattern0[2]
                                        ctx:label(k)
                                        ctx:text(encode(v))
                                    end
                                )
                            end
                        end
                    )
                end
                ctx:endWindow()
            end
            ctx["end"](ctx)
        end
    )
end
main(nil)
return ____exports

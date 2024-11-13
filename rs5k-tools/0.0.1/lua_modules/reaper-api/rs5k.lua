local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local __TS__SetDescriptor = ____lualib.__TS__SetDescriptor
local ____exports = {}
____exports.RS5KMode = RS5KMode or ({})
____exports.RS5KMode.FreelyConfigurableShifted = "0"
____exports.RS5KMode.Sample = "1"
____exports.RS5KMode.NoteSemitoneShifted = "2"
local Param = Param or ({})
Param.Volume = 0
Param[Param.Volume] = "Volume"
Param.Pan = 1
Param[Param.Pan] = "Pan"
Param.MinVolume = 2
Param[Param.MinVolume] = "MinVolume"
Param.NoteRangeStart = 3
Param[Param.NoteRangeStart] = "NoteRangeStart"
Param.NoteRangeEnd = 4
Param[Param.NoteRangeEnd] = "NoteRangeEnd"
Param.PitchForStartNote = 5
Param[Param.PitchForStartNote] = "PitchForStartNote"
Param.PitchForEndNote = 6
Param[Param.PitchForEndNote] = "PitchForEndNote"
Param.MIDIChannel = 7
Param[Param.MIDIChannel] = "MIDIChannel"
Param.MaxVoices = 8
Param[Param.MaxVoices] = "MaxVoices"
Param.Attack = 9
Param[Param.Attack] = "Attack"
Param.Release = 10
Param[Param.Release] = "Release"
Param.ObeyNoteOffs = 11
Param[Param.ObeyNoteOffs] = "ObeyNoteOffs"
Param.Loop = 12
Param[Param.Loop] = "Loop"
Param.SampleStartOffset = 13
Param[Param.SampleStartOffset] = "SampleStartOffset"
Param.SampleEndOffset = 14
Param[Param.SampleEndOffset] = "SampleEndOffset"
Param.PitchAdjust = 15
Param[Param.PitchAdjust] = "PitchAdjust"
Param.PitchbendRange = 16
Param[Param.PitchbendRange] = "PitchbendRange"
Param.MinimumVelocity = 17
Param[Param.MinimumVelocity] = "MinimumVelocity"
Param.MaximumVelocity = 18
Param[Param.MaximumVelocity] = "MaximumVelocity"
Param.ProbabilityOfHitting = 19
Param[Param.ProbabilityOfHitting] = "ProbabilityOfHitting"
Param.RoundRobinMode = 20
Param[Param.RoundRobinMode] = "RoundRobinMode"
Param.FilterPlayedNotes = 21
Param[Param.FilterPlayedNotes] = "FilterPlayedNotes"
Param.CrossfadeLoopLength = 22
Param[Param.CrossfadeLoopLength] = "CrossfadeLoopLength"
Param.LoopStartOffset = 23
Param[Param.LoopStartOffset] = "LoopStartOffset"
Param.Decay = 24
Param[Param.Decay] = "Decay"
Param.Sustain = 25
Param[Param.Sustain] = "Sustain"
Param.ReleaseNoteOff = 26
Param[Param.ReleaseNoteOff] = "ReleaseNoteOff"
Param.UseNoteOffReleaseOverride = 27
Param[Param.UseNoteOffReleaseOverride] = "UseNoteOffReleaseOverride"
Param.LegacyVoiceReUseMode = 28
Param[Param.LegacyVoiceReUseMode] = "LegacyVoiceReUseMode"
Param.Portamento = 29
Param[Param.Portamento] = "Portamento"
Param.Bypass = 30
Param[Param.Bypass] = "Bypass"
Param.Wet = 31
Param[Param.Wet] = "Wet"
Param.Delta = 32
Param[Param.Delta] = "Delta"
local RS5KFileModifier = __TS__Class()
RS5KFileModifier.name = "RS5KFileModifier"
function RS5KFileModifier.prototype.____constructor(self, fx)
    self.fx = fx
    self.edited = false
end
function RS5KFileModifier.prototype.getFile(self, i)
    local filename = self.fx.chain:GetNamedConfigParm(
        self.fx.fxidx,
        "FILE" .. tostring(i)
    )
    if filename == nil then
        error(
            __TS__New(
                Error,
                ("Failed to get file " .. tostring(i)) .. " in RS5K instance"
            ),
            0
        )
    end
    if #filename == 0 then
        return nil
    else
        return filename
    end
end
function RS5KFileModifier.prototype.deleteFile(self, i)
    local rv = self.fx.chain:SetNamedConfigParm(
        self.fx.fxidx,
        "-FILE" .. tostring(i),
        "a"
    )
    if not rv then
        error(
            __TS__New(
                Error,
                ("Failed to delete file " .. tostring(i)) .. " in RS5K instance"
            ),
            0
        )
    end
    self.edited = true
end
function RS5KFileModifier.prototype.addFile(self, i, path)
    local rv = self.fx.chain:SetNamedConfigParm(
        self.fx.fxidx,
        "+FILE" .. tostring(i),
        path
    )
    if not rv then
        error(
            __TS__New(
                Error,
                ("Failed to add file " .. tostring(i)) .. " in RS5K instance"
            ),
            0
        )
    end
    self.edited = true
end
function RS5KFileModifier.prototype.deleteAllFiles(self)
    local rv = self.fx.chain:SetNamedConfigParm(self.fx.fxidx, "-FILE*", "a")
    if not rv then
        error(
            __TS__New(Error, "Failed to delete all files in RS5K instance"),
            0
        )
    end
    self.edited = true
end
function RS5KFileModifier.prototype.isEdited(self)
    return self.edited
end
____exports.RS5K = __TS__Class()
local RS5K = ____exports.RS5K
RS5K.name = "RS5K"
function RS5K.prototype.____constructor(self, fx)
    self.fx = fx
end
function RS5K.prototype.isValid(self)
    local ident
    do
        local function ____catch(____error)
            return true, false
        end
        local ____try, ____hasReturned, ____returnValue = pcall(function()
            ident = self.fx:getIdent()
        end)
        if not ____try then
            ____hasReturned, ____returnValue = ____catch(____hasReturned)
        end
        if ____hasReturned then
            return ____returnValue
        end
    end
    local os = reaper.GetOS()
    if not __TS__StringStartsWith(os, "Win") then
        error(
            __TS__New(Error, ((("RS5K validity check not implemented for this OS: " .. os) .. " (fxident: ") .. ident) .. ")"),
            0
        )
    end
    return __TS__StringIncludes(ident, "reasamplomatic.dll")
end
function RS5K.prototype.getFiles(self)
    local i = 0
    local files = {}
    while true do
        local filename = self.fx.chain:GetNamedConfigParm(
            self.fx.fxidx,
            "FILE" .. tostring(i)
        )
        if filename == nil then
            return files
        end
        if #filename == 0 then
            files[#files + 1] = ""
        else
            files[#files + 1] = filename
        end
        i = i + 1
    end
end
function RS5K.prototype.modifyFiles(self, func)
    local m = __TS__New(RS5KFileModifier, self.fx)
    local ____error = nil
    do
        local function ____catch(e)
            ____error = e
        end
        local ____try, ____hasReturned = pcall(function()
            func(nil, m)
        end)
        if not ____try then
            ____catch(____hasReturned)
        end
    end
    if m:isEdited() then
        local rv = self.fx.chain:SetNamedConfigParm(self.fx.fxidx, "DONE", "a")
        if not rv then
            error(
                __TS__New(Error, "Failed to finish editing files in RS5K instance"),
                0
            )
        end
    end
    if ____error ~= nil then
        error(____error, 0)
    end
end
__TS__SetDescriptor(
    RS5K.prototype,
    "mode",
    {
        get = function(self)
            local mode = self.fx.chain:GetNamedConfigParm(self.fx.fxidx, "MODE")
            if mode == nil then
                error(
                    __TS__New(Error, "Failed to get RS5K mode"),
                    0
                )
            end
            return mode
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetNamedConfigParm(self.fx.fxidx, "MODE", x)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set RS5K mode"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "resampleMode",
    {
        get = function(self)
            local mode = self.fx.chain:GetNamedConfigParm(self.fx.fxidx, "RSMODE")
            if mode == nil then
                error(
                    __TS__New(Error, "Failed to get RS5K resample mode"),
                    0
                )
            end
            return mode
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetNamedConfigParm(self.fx.fxidx, "RSMODE", x)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set RS5K resample mode"),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "volume",
    {
        get = function(self)
            return self.fx.chain:GetParamEx(self.fx.fxidx, Param.Volume)[1]
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.Volume, x)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.Volume]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "pan",
    {
        get = function(self)
            return self.fx.chain:GetParamEx(self.fx.fxidx, Param.Pan)[1]
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.Pan, x)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.Pan]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "minVolume",
    {
        get = function(self)
            return self.fx.chain:GetParamEx(self.fx.fxidx, Param.MinVolume)[1]
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.MinVolume, x)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.MinVolume]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "noteRangeStart",
    {
        get = function(self)
            return math.floor(self.fx.chain:GetParamEx(self.fx.fxidx, Param.NoteRangeStart)[1] * 127 + 0.5)
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.NoteRangeStart, x / 127)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.NoteRangeStart]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "noteRangeEnd",
    {
        get = function(self)
            return math.floor(self.fx.chain:GetParamEx(self.fx.fxidx, Param.NoteRangeEnd)[1] * 127 + 0.5)
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.NoteRangeEnd, x / 127)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.NoteRangeEnd]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "pitchStart",
    {
        get = function(self)
            return math.floor(self.fx.chain:GetParamEx(self.fx.fxidx, Param.PitchForStartNote)[1] * 160 - 80 + 0.5)
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.PitchForStartNote, (x + 80) / 160)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.PitchForStartNote]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "pitchEnd",
    {
        get = function(self)
            return math.floor(self.fx.chain:GetParamEx(self.fx.fxidx, Param.PitchForEndNote)[1] * 160 - 80 + 0.5)
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.PitchForEndNote, (x + 80) / 160)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.PitchForEndNote]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "midiChannel",
    {
        get = function(self)
            return math.floor(self.fx.chain:GetParamEx(self.fx.fxidx, Param.MIDIChannel)[1] * 16 + 0.5)
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.MIDIChannel, x / 16)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.MIDIChannel]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "maxVoices",
    {
        get = function(self)
            return math.floor(self.fx.chain:GetParamEx(self.fx.fxidx, Param.MaxVoices)[1] / 4 * 63 + 1 + 0.5)
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.MaxVoices, (x - 1) / 63 * 4)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.MaxVoices]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "attack",
    {
        get = function(self)
            return math.floor(self.fx.chain:GetParamEx(self.fx.fxidx, Param.Attack)[1] * 2000 + 0.5)
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.Attack, x / 2000)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.Attack]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "release",
    {
        get = function(self)
            return math.floor(self.fx.chain:GetParamEx(self.fx.fxidx, Param.Release)[1] * 2000 + 0.5)
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.Release, x / 2000)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.Release]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "obeyNoteOffs",
    {
        get = function(self)
            return self.fx.chain:GetParamEx(self.fx.fxidx, Param.ObeyNoteOffs)[1] >= 0.5
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.ObeyNoteOffs, x and 1 or 0)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.ObeyNoteOffs]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "loop",
    {
        get = function(self)
            return self.fx.chain:GetParamEx(self.fx.fxidx, Param.Loop)[1] >= 0.5
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.Loop, x and 1 or 0)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.Loop]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "sampleStartOffset",
    {
        get = function(self)
            return self.fx.chain:GetParamEx(self.fx.fxidx, Param.SampleStartOffset)[1]
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.SampleStartOffset, x)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.SampleStartOffset]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "sampleEndOffset",
    {
        get = function(self)
            return self.fx.chain:GetParamEx(self.fx.fxidx, Param.SampleEndOffset)[1]
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.SampleEndOffset, x)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.SampleEndOffset]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "pitchOffset",
    {
        get = function(self)
            return self.fx.chain:GetParamEx(self.fx.fxidx, Param.PitchAdjust)[1] * 160 - 80
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.PitchAdjust, (x + 80) / 160)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.PitchAdjust]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "pitchbendRange",
    {
        get = function(self)
            return self.fx.chain:GetParamEx(self.fx.fxidx, Param.PitchbendRange)[1] * 12
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.PitchbendRange, x / 12)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.PitchbendRange]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "minVelocity",
    {
        get = function(self)
            return math.floor(self.fx.chain:GetParamEx(self.fx.fxidx, Param.MinimumVelocity)[1] * 127 + 0.5)
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.MinimumVelocity, x / 127)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.MinimumVelocity]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "maxVelocity",
    {
        get = function(self)
            return math.floor(self.fx.chain:GetParamEx(self.fx.fxidx, Param.MaximumVelocity)[1] * 127 + 0.5)
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.MaximumVelocity, x / 127)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.MaximumVelocity]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "probability",
    {
        get = function(self)
            return math.floor(self.fx.chain:GetParamEx(self.fx.fxidx, Param.ProbabilityOfHitting)[1] * 100 + 0.5)
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.ProbabilityOfHitting, x / 100)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.ProbabilityOfHitting]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "roundRobin",
    {
        get = function(self)
            return self.fx.chain:GetParamEx(self.fx.fxidx, Param.RoundRobinMode)[1] >= 0.5
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.RoundRobinMode, x and 1 or 0)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.RoundRobinMode]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "removePlayedMIDINotes",
    {
        get = function(self)
            return self.fx.chain:GetParamEx(self.fx.fxidx, Param.FilterPlayedNotes)[1] >= 0.5
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.FilterPlayedNotes, x and 1 or 0)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.FilterPlayedNotes]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "loopCrossfadeDuration",
    {
        get = function(self)
            return math.floor(self.fx.chain:GetParamEx(self.fx.fxidx, Param.CrossfadeLoopLength)[1] * 1000 + 0.5)
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.CrossfadeLoopLength, x / 1000)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.CrossfadeLoopLength]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "loopStartOffset",
    {
        get = function(self)
            return math.floor(self.fx.chain:GetParamEx(self.fx.fxidx, Param.LoopStartOffset)[1] * 30000 + 0.5)
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.LoopStartOffset, x / 30000)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.LoopStartOffset]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "decay",
    {
        get = function(self)
            return math.floor(self.fx.chain:GetParamEx(self.fx.fxidx, Param.Decay)[1] * 14990 + 10 + 0.5)
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.Decay, (x - 10) / 14990)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.Decay]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "sustain",
    {
        get = function(self)
            return self.fx.chain:GetParamEx(self.fx.fxidx, Param.Sustain)[1]
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.Sustain, x)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.Sustain]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "noteOffRelease",
    {
        get = function(self)
            return math.floor(self.fx.chain:GetParamEx(self.fx.fxidx, Param.ReleaseNoteOff)[1] * 4000 + 0.5)
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.ReleaseNoteOff, x / 4000)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.ReleaseNoteOff]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "noteOffReleaseEnabled",
    {
        get = function(self)
            return self.fx.chain:GetParamEx(self.fx.fxidx, Param.UseNoteOffReleaseOverride)[1] >= 0.5
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.UseNoteOffReleaseOverride, x and 1 or 0)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.UseNoteOffReleaseOverride]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "portamento",
    {
        get = function(self)
            return math.floor(self.fx.chain:GetParamEx(self.fx.fxidx, Param.Portamento)[1] * 1000 + 0.5)
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.Portamento, x / 1000)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.Portamento]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "bypass",
    {
        get = function(self)
            return self.fx.chain:GetParamEx(self.fx.fxidx, Param.Bypass)[1] >= 0.5
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.Bypass, x and 1 or 0)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.Bypass]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "wet",
    {
        get = function(self)
            return math.floor(self.fx.chain:GetParamEx(self.fx.fxidx, Param.Wet)[1] + 0.5)
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.Wet, x)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.Wet]),
                    0
                )
            end
        end
    },
    true
)
__TS__SetDescriptor(
    RS5K.prototype,
    "delta",
    {
        get = function(self)
            return self.fx.chain:GetParamEx(self.fx.fxidx, Param.Delta)[1] >= 0.5
        end,
        set = function(self, x)
            local rv = self.fx.chain:SetParam(self.fx.fxidx, Param.Delta, x and 1 or 0)
            if not rv then
                error(
                    __TS__New(Error, "Failed to set " .. Param[Param.Delta]),
                    0
                )
            end
        end
    },
    true
)
return ____exports

--- Debug module for YourAddon.
--- @module "Debug"

local addon_name, _ = ...
local YourAddon = LibStub("AceAddon-3.0"):GetAddon(addon_name)
local Debug = YourAddon:NewModule("Debug")

local Printer = YourAddon:GetModule("Printer")

--- Higher order function to neutralize each public function of the module when debug mode is disabled.
--- @param func any
--- @return function
--- @usage `Debug.Print = createToggledFunction(function(self, ...)`
local function createToggledFunction(func)
    return function(...)
        if not Debug:IsEnabled() then return end
        return func(unpack({ ... }))
    end
end

--- Toggle debug mode on or off.
function Debug:Toggle()
    if Debug:IsEnabled() then
        Debug:Disable()
    else
        Debug:Enable()
    end
    Printer:Print(Debug:IsEnabled() and "Debug mode enabled" or "Debug mode disabled")
end

--- Print arguments.
--- @param arg1 string
--- @param arg2 string
--- @usage `Debug:ExampleFunction("UNIT_NAME_UPDATE", "player")`
Debug.ExampleFunction = createToggledFunction(function(self, arg1, arg2)
    Printer.Print(arg1, arg2)
end)

function Debug:OnInitialize()
    self.db = YourAddon.db.profile.debug
    if self.db then
        self:Enable()
    else
        self:Disable()
    end
end

function Debug:OnEnable()
    YourAddon.db.profile.debug = Debug:IsEnabled()
end

function Debug:OnDisable()
    YourAddon.db.profile.debug = Debug:IsEnabled()
end

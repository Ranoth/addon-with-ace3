--- Registers additional slash commands for the addon and some utility without strings attached.
--- @module "Commands"

local addon_name, _ = ...
local YourAddon = LibStub("AceAddon-3.0"):GetAddon(addon_name)
local Commands = YourAddon:NewModule("Commands")

local Printer = YourAddon:GetModule("Printer")
local Debug = YourAddon:GetModule("Debug")

local addonShortHand = "shorthand"

--- prints the help message for the addon's slash commands
function Commands:PrintHelp()
    Printer:Print("Available commands")
    Printer:Print("|cffffff00" .. addonShortHand .. " help|r - Prints this message")
    Printer:Print("|cffffff00" .. addonShortHand .. " debug|r - Toggles debug mode")
    Printer:Print("|cffffff00" .. addonShortHand .. " interfaceversion|r - Prints the interface version")
end

--- Registers additional slash commands for the addon
YourAddon:RegisterChatCommand(addonShortHand, function(input)
    local command, args = YourAddon:GetArgs(input, 2)
    if not command then
        Commands:PrintHelp()
        return
    end

    --- @type table<string, function>
    local commandList = {
        ["help"] = Commands.PrintHelp,
        ["debug"] = Debug.Toggle,
        ["interfaceversion"] = function()
            Printer:Print("Interface version: " .. select(4, GetBuildInfo()))
        end
    }

    if commandList[command] then
        commandList[command](args)
    else
        Printer:Print("Unknown command: " .. command)
        Commands:PrintHelp()
    end
end)

--- Registers additional slash commands for the addon and some utility without strings attached.
--- @module "Commands"

local addon_name, _ = ...
local YourAddon = LibStub("AceAddon-3.0"):GetAddon(addon_name)
local Commands = YourAddon:NewModule("Commands")

local Printer = YourAddon:GetModule("Printer")
local Debug = YourAddon:GetModule("Debug")

local addonShortHand = string.lower("YourAddon")
local colorizedShorthand = "|cffffff00" .. addonShortHand

--- @type table<string, table>
local commandList = {
    ["help"] = {
        func = function() Commands:PrintHelp() end,
        help = "Prints this message"
    },
    ["debug"] = {
        func = Debug.Toggle,
        help = "Toggles debug mode"
    },
    ["interfaceversion"] = {
        func = function()
            Printer:Print("Interface version: " .. select(4, GetBuildInfo()))
        end,
        help = "Prints the interface version"
    }
}

--- prints the help message for the addon's slash commands
function Commands:PrintHelp()
    Printer:Print("Available commands")
    for command, info in pairs(commandList) do
        Printer:Print(colorizedShorthand .. " " .. command .. "|r - " .. info.help)
    end
end

--- Registers additional slash commands for the addon
YourAddon:RegisterChatCommand(addonShortHand, function(input)
    local command, args = YourAddon:GetArgs(input, 2)
    if not command then
        Commands:PrintHelp()
        return
    end

    if commandList[command] then
        commandList[command].func(args)
    else
        Printer:Print("Unknown command: " .. command)
        Commands:PrintHelp()
    end
end)

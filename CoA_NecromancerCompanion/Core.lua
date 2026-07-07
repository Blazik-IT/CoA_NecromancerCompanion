local addonName = ...

CNC = {}

CNC.Version = "0.3"

CNC.Minions = {}
CNC.PendingSummons = {}

local frame = CreateFrame("Frame")

frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function()

    print("|cff00ff00===============================|r")
    print("|cff00ff00CoA Necromancer Companion|r")
    print("|cff00ff00Version "..CNC.Version.."|r")
    print("|cff00ff00===============================|r")

end)

SLASH_CNC1 = "/cnc"

SlashCmdList["CNC"] = function()

    if CNC.ToggleWindow then
        CNC:ToggleWindow()
    end

end
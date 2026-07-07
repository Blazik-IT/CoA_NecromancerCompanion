local frame = CreateFrame("Frame")

frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

frame:SetScript("OnEvent", function()

    local arg = {}

    for i = 1, 12 do
        arg[i] = tostring(_G["arg"..i])
    end

    if arg[2] == "SPELL_SUMMON" then

        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00====== SPELL_SUMMON ======|r")

        for i = 1, 12 do
            DEFAULT_CHAT_FRAME:AddMessage(i .. " = " .. tostring(arg[i]))
        end

    end

end)
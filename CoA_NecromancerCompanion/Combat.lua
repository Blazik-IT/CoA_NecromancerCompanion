CoANecro = CoANecro or {}
CoANecro.Combat = {}

local combatFrame = CreateFrame("Frame")

local REMOVAL_EVENTS = {
    ["UNIT_DIED"] = true,
    ["UNIT_DESTROYED"] = true,
    ["UNIT_DISSIPATES"] = true,
    ["SPELL_INSTAKILL"] = true,
    ["PARTY_KILL"] = true,
    ["UNIT_FREEZE"] = true
}

function CoANecro.Combat:Init()
    combatFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    combatFrame:SetScript("OnEvent", function(self, event, ...)
        CoANecro.Combat:OnCombatLog(...)
    end)
end

function CoANecro.Combat:OnCombatLog(...)
    local timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = select(1, ...)
    
    if eventType == "SPELL_SUMMON" then
        if CoANecro.Utils:IsPlayer(sourceName, sourceGUID) then
            CoANecro.Minions:AddMinion(destGUID, destName)
        end
    elseif REMOVAL_EVENTS[eventType] then
        if CoANecro.Minions:GetMinion(destGUID) then
            CoANecro.Minions:RemoveMinion(destGUID)
        end
    end
end
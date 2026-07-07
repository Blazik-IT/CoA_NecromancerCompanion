CoANecro = CoANecro or {}
CoANecro.Minions = {}

local activeMinions = {}

function CoANecro.Minions:AddMinion(guid, name)
    if not guid then return end
    
    if not activeMinions[guid] then
        activeMinions[guid] = {
            guid = guid,
            name = name or "Esbirro",
            health = 1,
            maxHealth = 1,
            lastSeen = GetTime()
        }
        CoANecro.UI:UpdateLayout()
    else
        if name and name ~= "" then
            activeMinions[guid].name = name
        end
        activeMinions[guid].lastSeen = GetTime()
    end
end

function CoANecro.Minions:RemoveMinion(guid)
    if not guid then return end
    
    if activeMinions[guid] then
        activeMinions[guid] = nil
        CoANecro.UI:UpdateLayout()
    end
end

function CoANecro.Minions:UpdateMinionData(guid, health, maxHealth, name)
    local minion = activeMinions[guid]
    if minion then
        if health and maxHealth and maxHealth > 0 then
            minion.health = health
            minion.maxHealth = maxHealth
        end
        if name and name ~= "" then
            minion.name = name
        end
        minion.lastSeen = GetTime()
        return true
    end
    return false
end

function CoANecro.Minions:GetMinions()
    return activeMinions
end

function CoANecro.Minions:GetMinion(guid)
    return activeMinions[guid]
end

function CoANecro.Minions:ClearAll()
    table.wipe(activeMinions)
    CoANecro.UI:UpdateLayout()
end
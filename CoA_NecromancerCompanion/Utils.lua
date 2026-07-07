CoANecro = CoANecro or {}
CoANecro.Utils = {}

function CoANecro.Utils:FormatHealth(current, max)
    if not current or not max or max == 0 then
        return "0 / 0"
    end
    return string.format("%d / %d", current, max)
end

function CoANecro.Utils:IsPlayer(sourceName, sourceGUID)
    local playerGUID = UnitGUID("player")
    local playerName = UnitName("player")
    
    if sourceGUID and playerGUID and sourceGUID == playerGUID then
        return true
    end
    
    if sourceName and playerName and sourceName == playerName then
        return true
    end
    
    if CoANecroConfig and CoANecroConfig.playerName and sourceName == CoANecroConfig.playerName then
        return true
    end
    
    return false
end
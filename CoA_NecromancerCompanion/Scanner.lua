local scanner = CreateFrame("Frame")

scanner:RegisterEvent("UNIT_HEALTH")
scanner:RegisterEvent("UNIT_MODEL_CHANGED")

local function UpdateMinion(unit)

    if not unit then
        return
    end

    if string.sub(unit,1,9) ~= "nameplate" then
        return
    end

    local guid = UnitGUID(unit)

    if not guid then
        return
    end

    if not CNC.PendingSummons[guid] then
        return
    end

    CNC.Minions[guid] = {
        guid = guid,
        unit = unit,
        name = UnitName(unit),
        health = UnitHealth(unit),
        maxHealth = UnitHealthMax(unit),
    }

    if CNC.UpdateWindow then
        CNC:UpdateWindow()
    end

end

scanner:SetScript("OnEvent", function(self,event,unit)

    UpdateMinion(unit)

end)
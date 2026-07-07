CoANecro = CoANecro or {}
CoANecro.Scanner = {}

local scannerFrame = CreateFrame("Frame")
local timeSinceLastScan = 0

function CoANecro.Scanner:Init()
    if not scannerFrame then scannerFrame = CreateFrame("Frame") end
    scannerFrame:SetScript("OnUpdate", function(self, elapsed)
        CoANecro.Scanner:OnUpdate(elapsed)
    end)
end

function CoANecro.Scanner:OnUpdate(elapsed)
    timeSinceLastScan = timeSinceLastScan + elapsed
    
    -- Escaneo cada 0.2 segundos para mantener la vida actualizada
    if timeSinceLastScan >= 0.2 then
        timeSinceLastScan = 0
        local minions = CoANecro.Minions:GetMinions()
        
        -- Escaneamos los 40 slots de nameplates
        for i = 1, 40 do
            local unit = "nameplate" .. i
            if UnitExists(unit) then
                local guid = UnitGUID(unit)
                -- Si el esbirro ya está en nuestra lista, actualizamos su vida
                if guid and minions[guid] then
                    CoANecro.Minions:UpdateMinionData(guid, UnitHealth(unit), UnitHealthMax(unit), UnitName(unit))
                end
            end
        end
        
        -- Refrescamos la UI con los datos que tenemos
        CoANecro.UI:RefreshBars()
    end
end
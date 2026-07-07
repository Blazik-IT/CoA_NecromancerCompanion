local frame = CreateFrame("Frame")

frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

frame:SetScript("OnEvent", function()

    if arg2 ~= "SPELL_SUMMON" then
        return
    end

    -- Temporalmente aceptamos todas las invocaciones.
    -- En el siguiente paso volveremos a filtrar por jugador.
    CNC.PendingSummons[arg6] = true

end)
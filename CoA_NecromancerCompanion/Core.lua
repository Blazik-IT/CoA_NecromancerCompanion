CoANecro = CoANecro or {}

local coreFrame = CreateFrame("Frame")
coreFrame:RegisterEvent("ADDON_LOADED")
coreFrame:RegisterEvent("PLAYER_LOGIN")
coreFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

coreFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "CoA_NecromancerCompanion" then
        CoANecro:InitConfig()
    elseif event == "PLAYER_LOGIN" then
        CoANecro.Combat:Init()
        CoANecro.Scanner:Init()
        CoANecro.UI:Init()
    elseif event == "PLAYER_ENTERING_WORLD" then
        CoANecro.Minions:ClearAll()
    end
end)

SLASH_COANECRO1 = "/necro"
SLASH_COANECRO2 = "/coanecro"
SlashCmdList["COANECRO"] = function(msg)
    local cmd = string.lower(string.trim(msg))
    if cmd == "clear" then
        CoANecro.Minions:ClearAll()
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[CoA Necro]|r Lista de esbirros limpiada manualmente.")
    else
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[CoA Necro]|r Comandos disponibles:")
        DEFAULT_CHAT_FRAME:AddMessage("  /necro clear - Limpia la lista actual de esbirros invocados.")
    end
end
-- ==========================================================
-- BLOQUEADOR DE SPAM AMARILLO DE BARRAS DE VIDA / NAMEPLATES
-- ==========================================================
local function EsSpamDeBarras(msg)
    if not msg then return false end
    local texto = string.lower(msg)
    -- Si el mensaje contiene alguna de estas palabras, se bloqueará:
    if string.find(texto, "barra de vida") or 
       string.find(texto, "barras de vida") or 
       string.find(texto, "placas de nombre") or 
       string.find(texto, "nameplate") then
        return true
    end
    return false
end

-- 1. Bloquear el texto amarillo en el centro de la pantalla (UIErrorsFrame)
local old_UIErrors_AddMessage = UIErrorsFrame.AddMessage
UIErrorsFrame.AddMessage = function(self, msg, ...)
    if EsSpamDeBarras(msg) then 
        return -- Ignora y elimina el mensaje
    end
    return old_UIErrors_AddMessage(self, msg, ...)
end

-- 2. Bloquear el mensaje en la ventana de chat del juego
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", function(self, event, msg, ...)
    if EsSpamDeBarras(msg) then
        return true -- true le dice al chat que oculte el mensaje
    end
    return false
end)
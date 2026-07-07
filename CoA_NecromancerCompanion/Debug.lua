CoANecro = CoANecro or {}
CoANecro.Debug = {}

local DEBUG_MODE = false

function CoANecro.Debug:Log(...)
    if DEBUG_MODE and DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[CoA Necro]|r " .. string.join(" ", ...))
    end
end

function CoANecro.Debug:SetEnabled(enabled)
    DEBUG_MODE = enabled
end
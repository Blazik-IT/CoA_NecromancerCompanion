CoANecro = CoANecro or {}

CoANecro.DefaultConfig = {
    updateInterval = 0.10,
    despawnTimeout = 20,
    frameX = 0,
    frameY = 0,
    framePoint = "CENTER",
    barWidth = 220,
    barHeight = 22,
    barSpacing = 4,
    playerName = "Blazik"
}

function CoANecro:InitConfig()
    if not CoANecroConfig then
        CoANecroConfig = {}
    end
    
    for k, v in pairs(self.DefaultConfig) do
        if CoANecroConfig[k] == nil then
            CoANecroConfig[k] = v
        end
    end
    
    local currentName = UnitName("player")
    if currentName and currentName ~= "" then
        CoANecroConfig.playerName = currentName
    end
end
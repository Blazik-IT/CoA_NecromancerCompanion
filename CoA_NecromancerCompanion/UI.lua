CoANecro = CoANecro or {}
CoANecro.UI = {}

local mainFrame = nil
local barPool = {}
local activeBars = {}

function CoANecro.UI:Init()
    if mainFrame then return end
    
    mainFrame = CreateFrame("Frame", "CoANecroMainFrame", UIParent)
    mainFrame:SetSize(220, 30)
    
    local point = (CoANecroConfig and CoANecroConfig.framePoint) or "CENTER"
    local x = (CoANecroConfig and CoANecroConfig.frameX) or 0
    local y = (CoANecroConfig and CoANecroConfig.frameY) or 0
    mainFrame:SetPoint(point, UIParent, point, x, y)
    
    mainFrame:SetMovable(true)
    mainFrame:EnableMouse(true)
    mainFrame:RegisterForDrag("LeftButton")
    mainFrame:SetScript("OnDragStart", mainFrame.StartMoving)
    mainFrame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local pt, _, _, fx, fy = self:GetPoint()
        if CoANecroConfig then
            CoANecroConfig.framePoint = pt
            CoANecroConfig.frameX = fx
            CoANecroConfig.frameY = fy
        end
    end)
    
    -- Título
    local title = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    title:SetPoint("BOTTOMLEFT", mainFrame, "TOPLEFT", 0, 5)
    title:SetText("Esbirros")
    mainFrame.title = title
    
    -- BOTÓN DE CLEAR (X)
    local clearBtn = CreateFrame("Button", nil, mainFrame)
    clearBtn:SetSize(16, 16)
    clearBtn:SetPoint("BOTTOMRIGHT", mainFrame, "TOPRIGHT", 0, 5)
    clearBtn:SetNormalTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
    clearBtn:SetHighlightTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Highlight")
    clearBtn:SetScript("OnClick", function()
        CoANecro.Minions:ClearAll()
        CoANecro.UI:RefreshBars()
    end)
    
    mainFrame:Show()
end

local function GetBar()
    local bar = table.remove(barPool)
    if not bar then
        local index = #activeBars + #barPool + 1
        bar = CreateFrame("StatusBar", "CoANecroBar" .. index, mainFrame)
        bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
        bar:SetStatusBarColor(0.2, 0.8, 0.2, 1.0)
        
        local bg = bar:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetTexture(0.1, 0.1, 0.1, 0.8)
        bar.bg = bg
        
        local nameText = bar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        nameText:SetPoint("LEFT", bar, "LEFT", 6, 0)
        nameText:SetJustifyH("LEFT")
        bar.nameText = nameText
        
        local healthText = bar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        healthText:SetPoint("RIGHT", bar, "RIGHT", -6, 0)
        healthText:SetJustifyH("RIGHT")
        bar.healthText = healthText
    end
    bar:Show()
    return bar
end

function CoANecro.UI:UpdateLayout()
    if not mainFrame then self:Init() end
    
    for _, bar in ipairs(activeBars) do
        bar:Hide()
        table.insert(barPool, bar)
    end
    table.wipe(activeBars)
    
    local minions = CoANecro.Minions:GetMinions()
    local width = (CoANecroConfig and CoANecroConfig.barWidth) or 220
    local height = (CoANecroConfig and CoANecroConfig.barHeight) or 22
    local spacing = (CoANecroConfig and CoANecroConfig.barSpacing) or 4
    local yOffset = 0
    
    for guid, minion in pairs(minions) do
        local bar = GetBar()
        bar:SetSize(width, height)
        bar:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 0, yOffset)
        bar.guid = guid
        
        bar:SetMinMaxValues(0, minion.maxHealth)
        bar:SetValue(minion.health)
        bar.nameText:SetText(minion.name)
        bar.healthText:SetText(CoANecro.Utils:FormatHealth(minion.health, minion.maxHealth))
        
        table.insert(activeBars, bar)
        yOffset = yOffset - height - spacing
    end
    
    mainFrame:SetSize(width, math.max(height, math.abs(yOffset)))
end

function CoANecro.UI:RefreshBars()
    local minions = CoANecro.Minions:GetMinions()
    for _, bar in ipairs(activeBars) do
        if bar.guid and minions[bar.guid] then
            local minion = minions[bar.guid]
            bar:SetMinMaxValues(0, minion.maxHealth)
            bar:SetValue(minion.health)
            bar.healthText:SetText(CoANecro.Utils:FormatHealth(minion.health, minion.maxHealth))
        end
    end
end
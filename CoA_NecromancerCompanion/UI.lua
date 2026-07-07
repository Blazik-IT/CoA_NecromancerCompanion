local frame = CreateFrame("Frame","CNC_MainFrame",UIParent)

frame:SetWidth(320)
frame:SetHeight(400)

frame:SetPoint("CENTER")

frame:SetBackdrop({

    bgFile="Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",

    tile=true,
    tileSize=16,

    edgeSize=16,

    insets={

        left=4,
        right=4,
        top=4,
        bottom=4

    }

})

frame:Hide()

local title = frame:CreateFontString(nil,"OVERLAY","GameFontNormalLarge")

title:SetPoint("TOP",0,-10)

title:SetText("Necromancer Companion")

local text = frame:CreateFontString(nil,"OVERLAY","GameFontNormal")

text:SetPoint("TOPLEFT",15,-40)

text:SetJustifyH("LEFT")

text:SetText("No hay esbirros.")

function CNC:UpdateWindow()

    local output = ""

    for guid,minion in pairs(CNC.Minions) do

        output = output ..

        minion.name ..

        "   " ..

        minion.health ..

        "/" ..

        minion.maxHealth ..

        "\n"

    end

    if output == "" then

        output = "No hay esbirros."

    end

    text:SetText(output)

end

function CNC:ToggleWindow()

    if frame:IsShown() then

        frame:Hide()

    else

        CNC:UpdateWindow()

        frame:Show()

    end

end
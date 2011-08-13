local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

---------------------------------------------------------
---[[ ADDITIONAL PANELS ]]---
---------------------------------------------------------

--TOP BLANK FRAME DOES NOTHING 
if C["extra_panels"].toppanel == true then 
local toppanel = CreateFrame("Frame", "TukuiTopPanel", UIParent)
toppanel:CreatePanel("Transparent", 2000, 20, "TOP", UIParent, "TOP", 0, 0)
toppanel:SetFrameStrata("BACKGROUND")
toppanel:SetFrameLevel(0)
end

--BOTTOM BLANK FRAME DOES NOTHING 
if C["extra_panels"].bottompanel == true then 
local bottompanel = CreateFrame("Frame", "TukuiBottomPanel", UIParent)
bottompanel:CreatePanel("Transparent", 2000, 20, "BOTTOM", UIParent, "BOTTOM", 0, 0)
bottompanel:SetFrameStrata("BACKGROUND")
bottompanel:SetFrameLevel(0)
end

-- Center Panel Dtext x3 and Threatbar
local icmid = CreateFrame("Frame", "ICenterMid", TukuiBar1)
icmid:CreatePanel("Transparent", TukuiBar1:GetWidth(), 17, "TOP", TukuiBar1, "BOTTOM", 0, -3)
icmid:CreateBorder(false, true)
icmid:SetFrameLevel(2)
icmid:SetFrameStrata("BACKGROUND")

-- MINIMAP INFO LEFT(FOR STATS)
local ilmmap = CreateFrame("Frame", "TukuiInfoLeftMinimap", TukuiMinimap)
ilmmap:CreatePanel("Transparent", (TukuiMinimap:GetWidth() / 2) - 1.5, 19, "TOPLEFT", TukuiMinimap, "BOTTOMLEFT", 0, -3)
ilmmap:CreateBorder(false, true)

-- MINIMAP IFNO RIGHT(FOR STATS)
local irmmap = CreateFrame("Frame", "TukuiInfoRightMinimap", TukuiMinimap)
irmmap:CreatePanel("Transparent", (TukuiMinimap:GetWidth() / 2) - 1.5, ilmmap:GetHeight(), "TOPRIGHT", TukuiMinimap, "BOTTOMRIGHT", 0, -3)
irmmap:CreateBorder(false, true)

--- Chat Toggle Button
local toggleFrame = CreateFrame("Frame", "toggleFrame", TukuiBar2)
toggleFrame:CreatePanel("Transparent", TukuiBar2:GetWidth(), 17, "TOP", TukuiBar2, "BOTTOM", 0, -3, true)
toggleFrame:SetFrameLevel(2)
toggleFrame:SetFrameStrata("LOW")
toggleFrame:EnableMouse()
toggleFrame.text:SetText(T.StatColor.."Chat")
toggleFrame:SetAlpha(1)
T.ApplyHover(toggleFrame)

T.fadeIn(TukuiChatBackgroundLeft)
T.fadeIn(TukuiChatBackgroundRight)

toggleFrame:SetScript("OnMouseDown", function(self)
if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end
	if not TukuiChatBackgroundLeft:IsVisible() then
		TukuiChatBackgroundLeft:Show()
		TukuiChatBackgroundRight:Show()
	else
		T.fadeOut(TukuiChatBackgroundLeft)
		T.fadeOut(TukuiChatBackgroundRight)
	end
end)

----------------------------------------------------------------------------------
-- Config Panel For Action Bars Smelly!---------------------------------------------------
----------------------------------------------------------------------------------

-- BG for action bar config
local actionBarBG = CreateFrame("Frame", "actionBarBG", UIParent)
actionBarBG:CreatePanel("Transparent", 150, 61, "CENTER", UIParent, "CENTER", 0, 0)
if T.lowversion then
	actionBarBG:Height(61)
else
	actionBarBG:Height(80)
end
T.fadeIn(actionBarBG)
actionBarBG:SetFrameLevel(15)
actionBarBG:Hide()

local abHeader = CreateFrame("Frame", "abHeader", actionBarBG)
abHeader:CreatePanel("Transparent", actionBarBG:GetWidth(), 20, "BOTTOM", actionBarBG, "TOP", 0, 3, true)
abHeader.text:SetText(T.StatColor.."Actionbar Config")

-- BG for config menu
local extrasBG = CreateFrame("Frame", "extrasBG", UIParent)
extrasBG:CreatePanel("Transparent", 150, 220 , "CENTER", UIParent, "CENTER", 0, 0)
extrasBG:SetFrameLevel(10)
extrasBG:SetFrameStrata("DIALOG")
extrasBG:Hide()
T.fadeIn(extrasBG)

local extraHeader = CreateFrame("Frame", "extraHeader", extrasBG)
extraHeader:CreatePanel("Transparent", extrasBG:GetWidth(), 20, "BOTTOM", extrasBG, "TOP", 0, 3, true)
extraHeader.text:SetText(T.StatColor.."Config Menu")

-- close button inside action bar config
local closeAB = CreateFrame("Frame", "closeAB", actionBarBG)
closeAB:CreatePanel("Default", actionBarBG:GetWidth() - 8, 15, "BOTTOM", actionBarBG, "BOTTOM", 0, 4, true)
closeAB:SetFrameLevel(actionBarBG:GetFrameLevel() + 1)
T.ApplyHover(closeAB)
closeAB.text:SetText(T.StatColor.."Close")
closeAB:SetScript("OnMouseDown", function()
	T.fadeOut(actionBarBG)
	extrasBG:Show()
end)

-- slash command to open up actionbar config
function SlashCmdList.AB()
	if extrasBG:IsShown() then
		actionBarBG:Show()
		T.fadeOut(extrasBG)
	else
		actionBarBG:Show()
	end
end
SLASH_AB1 = "/ab"

-- setup config button slash commands
local buttons = {
	[1] = {"/tc"},
	[2] = {"/rl"},
	[3] = {"/resetui"},
	[4]	= {"/dps"},
	[5] = {"/heal"},
	[6] = {"/moveui"},
	[7] = {"/ab"},
}

-- setup text in each button
local texts = {
	[1] = {T.StatColor.."Config UI"},
	[2] = {T.StatColor.."Reload UI"},
	[3] = {T.StatColor.."Reset UI"},
	[4]	= {T.StatColor.."Dps Layout"},
	[5] = {T.StatColor.."Heal Layout"},
	[6] = {T.StatColor.."Move UI"},
	[7] = {T.StatColor.."Action Bars"},
}

-- create the config buttons
local button = CreateFrame("Button", "button", extrasBG)
for i = 1, getn(buttons) do
	button[i] = CreateFrame("Button", "button"..i, extrasBG, "SecureActionButtonTemplate")
	button[i]:CreatePanel("Default", extrasBG:GetWidth() - 8, 24, "TOP", extrasBG, "TOP", 0, -4, true)
	button[i]:SetFrameLevel(extrasBG:GetFrameLevel() + 1)
	button[i].text:SetText(unpack(texts[i]))
	if i == 1 then
		button[i]:Point("TOP", extrasBG, "TOP", 0, -4)
	else
		button[i]:Point("TOP", button[i-1], "BOTTOM", 0, -3)
	end
	button[i]:SetAttribute("type", "macro")
	button[i]:SetAttribute("macrotext", unpack(buttons[i]))
	button[i]:SetFrameStrata("DIALOG")
	T.ApplyHover(button[i])
end

local close = CreateFrame("Button", "close", extrasBG)
close:CreatePanel("Default", extrasBG:GetWidth() - 8, 24, "TOP", button[7], "BOTTOM", 0, -3, true)
close:SetFrameLevel(extrasBG:GetFrameLevel() + 1)
close:SetFrameStrata("DIALOG")
close.text:SetText(T.StatColor.."Close")
T.ApplyHover(close)
close:SetScript("OnMouseDown", function()
	T.fadeOut(extrasBG)
end)

local extraToggle = CreateFrame("Frame", "extraToggle", TukuiMinimap)
extraToggle:CreatePanel("Transparent", 28, irmmap:GetHeight(), "LEFT", irmmap, "RIGHT", 3, 0, true)
extraToggle:CreateBorder(false, true)
extraToggle:SetFrameLevel(2)
extraToggle:SetFrameStrata("LOW")
extraToggle.text:SetText(T.StatColor.."C")
T.ApplyHover(extraToggle)

extraToggle:SetScript("OnMouseDown", function(self)
if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end
	if not extrasBG:IsShown() then
		extrasBG:Show()
		T.fadeOut(actionBarBG)
	else
		T.fadeOut(extrasBG)
	end
end)

----------------------------------------------------------------------------------
-- Addon Manager Smelly!-----------------------------------------------------------------
----------------------------------------------------------------------------------

-- Create BG
local addonBG = CreateFrame("Frame", "addonBG", UIParent)
addonBG:CreatePanel("Transparent", 280, 400, "CENTER", UIParent, "CENTER", 0, 0)
T.fadeIn(addonBG)
addonBG:Hide()

local addonHeader = CreateFrame("Frame", "addonHeader", addonBG)
addonHeader:CreatePanel("Transparent", addonBG:GetWidth(), 20, "BOTTOM", addonBG, "TOP", 0, 3, true)
addonHeader.text:SetText(T.StatColor.."Addon Control Menu")

-- Create scroll frame
local scrollFrame = CreateFrame("ScrollFrame", "scrollFrame", addonBG, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", addonBG, "TOPLEFT", 10, -10)
scrollFrame:SetPoint("BOTTOMRIGHT", addonBG, "BOTTOMRIGHT", -30, 40)
T.SkinScrollBar(scrollFrameScrollBar)

-- Create inside BG (uses scroll frame)
local buttonsBG = CreateFrame("Frame", "buttonsBG", scrollFrame)
buttonsBG:SetPoint("TOPLEFT")
buttonsBG:SetWidth(scrollFrame:GetWidth())
buttonsBG:SetHeight(scrollFrame:GetHeight())
scrollFrame:SetScrollChild(buttonsBG)


local saveButton = CreateFrame("Button", "saveButton", addonBG)
saveButton:CreatePanel("Default", 70, 24, "BOTTOMLEFT", addonBG, "BOTTOMLEFT", 10, 10, true)
saveButton.text:SetText(T.StatColor.."Save")
saveButton:SetScript("OnClick", function() ReloadUI() end)
T.ApplyHover(saveButton)

local closeButton = CreateFrame("Button", "closeButton", addonBG)
closeButton:CreatePanel("Default", 70, 24, "BOTTOMRIGHT", addonBG, "BOTTOMRIGHT", -10, 10, true)
closeButton.text:SetText(T.StatColor.."Cancel")
closeButton:SetScript("OnClick", function() T.fadeOut(addonBG) end)
T.ApplyHover(closeButton)

local addonToggle = CreateFrame("Frame", "addonToggle", TukuiBar3)
addonToggle:CreatePanel("Transparent", TukuiBar3:GetWidth(), 17, "TOP", TukuiBar3, "BOTTOM", 0, -3, true)
addonToggle.text:SetText(T.StatColor.."Addons")
addonToggle:SetFrameLevel(2)
addonToggle:SetFrameStrata("Low")
T.ApplyHover(addonToggle)
addonToggle:SetScript("OnMouseDown", function()
if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end
	if not addonBG:IsShown() then
		addonBG:Show()
	else
		T.fadeOut(addonBG)
	end
end)  

--
local function UpdateAddons()
	local addons = {}
	for i=1, GetNumAddOns() do
		addons[i] = select(1, GetAddOnInfo(i))
	end
	table.sort(addons)
	local oldb
	for i,v in pairs(addons) do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(v)
		local button = CreateFrame("Button", v.."_Button", buttonsBG, "SecureActionButtonTemplate")
		button:SetFrameLevel(buttonsBG:GetFrameLevel() + 1)
		button:Size(50, 16)
		button:SetTemplate("Default")
		button:CreateOverlay()

		-- to make sure the border is colored the right color on reload 
		if enabled then
			button:SetBackdropBorderColor(0,1,0)
		else
			button:SetBackdropBorderColor(1,0,0)
		end

		if i==1 then
			button:Point("TOPLEFT", buttonsBG, "TOPLEFT", 0, 0)
		else
			button:Point("TOP", oldb, "BOTTOM", 0, -7)
		end
		local text = T.SetFontString(button, C.media.pixelfont, 10, "MONOCHROMEOUTLINE")
		text:Point("LEFT", button, "RIGHT", 8, 0)
		text:SetText(title)
	
		 button:SetScript("OnMouseDown", function()
            if enabled then
                button:SetBackdropBorderColor(1,0,0)
                DisableAddOn(name)
                enabled = false
            else
                button:SetBackdropBorderColor(0,1,0)
                EnableAddOn(name)
                enabled = true
            end
        end)
	
		oldb = button
	end
end

UpdateAddons()
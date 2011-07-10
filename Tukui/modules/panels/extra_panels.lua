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
toppanel:CreateShadow("Default")
end

--BOTTOM BLANK FRAME DOES NOTHING 
if C["extra_panels"].bottompanel == true then 
local bottompanel = CreateFrame("Frame", "TukuiBottomPanel", UIParent)
bottompanel:CreatePanel("Transparent", 2000, 20, "BOTTOM", UIParent, "BOTTOM", 0, 0)
bottompanel:SetFrameStrata("BACKGROUND")
bottompanel:SetFrameLevel(0)
bottompanel:CreateShadow("Default")
end

-- TIME PANEL
local watch = CreateFrame("Frame", "Tukuiwatch", UIParent)
if IsAddOnLoaded("TukUI_ConfigUI") then
watch:CreatePanel("Default", ((Minimap:GetWidth()) / 2)-2, 17, "TOPLEFT", Minimap, "BOTTOMLEFT", 1, 8)
else
watch:CreatePanel("Default", 73, 17, "TOP", Minimap, "BOTTOM", 0, 8)
end
watch:SetFrameStrata("LOW")
watch:SetFrameLevel(2)

-- SWITCH LAYOUT
if C.chat.background and C.chat.layout_switch then
	local switchbut = CreateFrame("Button", "TukuiSwitchLayoutButton", TukuiTabsRightBackground, "SecureActionButtonTemplate")
	switchbut:Size(114, TukuiTabsRightBackground:GetHeight())
	switchbut:Point("CENTER", TukuiTabsRightBackground, "CENTER", -10, 0)
	switchbut:SetFrameStrata(TukuiTabsRightBackground:GetFrameStrata())
	switchbut:SetFrameLevel(TukuiTabsRightBackground:GetFrameLevel())
	switchbut:RegisterForClicks("AnyUp") switchbut:SetScript("OnClick", function()
		if IsAddOnLoaded("Tukui_Raid") then
			DisableAddOn("Tukui_Raid")
			EnableAddOn("Tukui_Raid_Healing")
			ReloadUI()
		elseif IsAddOnLoaded("Tukui_Raid_Healing") then
			DisableAddOn("Tukui_Raid_Healing")
			EnableAddOn("Tukui_Raid")
			ReloadUI()
		elseif not IsAddOnLoaded("Tukui_Raid_Healing") and not IsAddOnLoaded("Tukui_Raid") then
			EnableAddOn("Tukui_Raid")
			ReloadUI()
		end
	end)

	switchbut.Text = T.SetFontString(switchbut, C.media.pixelfont, 10, "THINOUTLINE")
	switchbut.Text:Point("RIGHT", switchbut, "RIGHT", -5, 0.5)
	switchbut.Text:SetText(T.panelcolor..L.datatext_switch_layout)
end

-- ADDONS BUTTON
if C.chat.background then
local adbutton = CreateFrame("Button", "TukuiAddonsButton", TukuiTabsRightBackground, "SecureActionButtonTemplate")
adbutton:SetWidth(20)
adbutton:Height(17)
adbutton:SetAlpha(0)
adbutton:Point("TOPRIGHT", TukuiTabsRightBackground, "TOPRIGHT", -105, -1)
adbutton:SetAttribute("type", "macro")
adbutton:SetAttribute("macrotext", "/al")
adbutton:SetFrameStrata("BACKGROUND")
adbutton:RegisterForClicks("AnyUp")
adbutton:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
adbutton:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
adbutton.Text = T.SetFontString(adbutton, C.media.pixelfont, 10, "THINOUTLINE")
adbutton.Text:Point("CENTER", adbutton, "CENTER", 0, 0.5)
adbutton.Text:SetText(T.StatColor..ADDONS)
end

-- CONFIG BUTTON
if not IsAddOnLoaded("TukUI_ConfigUI") then return end
local configbut = CreateFrame("Button", "TukuiConfigButton", UIParent, "SecureActionButtonTemplate")
configbut:CreatePanel("Default", ((Minimap:GetWidth()) / 2)-2, 17, "TOPLEFT", Tukuiwatch, "TOPRIGHT", 2, 0)
configbut:SetAttribute("type", "macro")
configbut:SetAttribute("macrotext", "/tc")
configbut:SetFrameLevel(2)
configbut:SetFrameStrata("LOW")
configbut.Text = T.SetFontString(configbut, C.media.pixelfont, 10)
configbut.Text:Point("CENTER", configbut, "CENTER", 0, 1)
configbut.Text:SetText(T.StatColor.."Config UI")

-- World Frame 
WorldStateAlwaysUpFrame:ClearAllPoints()
WorldStateAlwaysUpFrame:SetPoint("TOP", UIParent, "TOP", -20, T.Scale(-35))
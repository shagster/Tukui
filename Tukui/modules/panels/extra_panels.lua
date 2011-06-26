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
watch:CreatePanel("Default", 73, 17, "TOP", Minimap, "BOTTOM", T.Scale(0), 8)
watch:CreateShadow("Default")
watch:SetFrameStrata("LOW")
watch:SetFrameLevel(2)

-- SWITCH LAYOUT
if C.chat.background and C.chat.layout_switch then
	local swl = CreateFrame("Button", "TukuiSwitchLayoutButton", TukuiTabsRightBackground, "SecureActionButtonTemplate")
	swl:Size(114, TukuiTabsRightBackground:GetHeight())
	swl:Point("CENTER", TukuiTabsRightBackground, "CENTER", -10, 0)
	swl:SetFrameStrata(TukuiTabsRightBackground:GetFrameStrata())
	swl:SetFrameLevel(TukuiTabsRightBackground:GetFrameLevel())
	swl:RegisterForClicks("AnyUp") swl:SetScript("OnClick", function()
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

	swl.Text = T.SetFontString(swl, C.media.pixelfont, 10, "THINOUTLINE")
	swl.Text:Point("RIGHT", swl, "RIGHT", -5, 0.5)
	swl.Text:SetText(T.panelcolor..L.datatext_switch_layout)
end

--[[Addon Button bar 5
if C.chat.background then
	local adl = CreateFrame("Button", "ALButton", TukuiTabsRightBackground, "SecureActionButtonTemplate")
	adl:Size(114, TukuiTabsRightBackground:GetHeight())
	adl:Point("RIGHT", TukuiTabsRightBackground, "RIGHT", -105, 0)
	adl:SetFrameStrata(TukuiTabsRightBackground:GetFrameStrata())
	adl:SetFrameLevel(TukuiTabsRightBackground:GetFrameLevel())
	--ad1:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
	--ad1:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
	adl:RegisterForClicks("AnyUp") adl:SetScript("OnClick", function()
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

	adl.Text = T.SetFontString(adl, C.media.pixelfont, 10, "THINOUTLINE")
	adl.Text:Point("RIGHT", adl, "RIGHT", -5, 0.5)
	adl.Text:SetText(T.panelcolor..L.datatext_addon_manager)
end
--]]
-- World Frame 
WorldStateAlwaysUpFrame:ClearAllPoints()
WorldStateAlwaysUpFrame:SetPoint("TOP", UIParent, "TOP", -15, T.Scale(-35))
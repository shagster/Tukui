local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

if C.Addon_Skins.background then
	-- Addons Background (same size as right chat background)
	local bg = CreateFrame("Frame", "AddonBGPanel", UIParent)
	bg:CreatePanel("Transparent", TukuiChatBackgroundRight:GetWidth(), TukuiChatBackgroundRight:GetHeight(), "BOTTOMRIGHT", TukuiChatBackgroundRight, "BOTTOMRIGHT", 0, 0)
	
	-- toggle in-/outfight (NOTE: This will only toggle ChatFrameX (chat config))
	bg:RegisterEvent("PLAYER_ENTERING_WORLD")
	bg:RegisterEvent("PLAYER_LOGIN")
	if C.Addon_Skins.combat_toggle then
		bg:RegisterEvent("PLAYER_REGEN_ENABLED")
		bg:RegisterEvent("PLAYER_REGEN_DISABLED")
	end
	bg:SetScript("OnEvent", function(self, event)
		if C.Addon_Skins.combat_toggle then
			if event == "PLAYER_LOGIN" then
				-- Hide
				bg:Hide()
				if IsAddOnLoaded("Recount") then Recount_MainWindow:Hide() end
				if IsAddOnLoaded("Omen") then OmenAnchor:Hide() end
				if IsAddOnLoaded("Skada") then Skada:SetActive(false) end
				if TukuiChatBackgroundRight then TukuiChatBackgroundRight:Show() end
				elseif event == "PLAYER_ENTERING_WORLD" then
				end
		end
		if C.Addon_Skins.combat_toggle then
			if event == "PLAYER_REGEN_ENABLED" then
				self:Hide()
				if TukuiChatBackgroundRight then TukuiChatBackgroundRight:Show() end
				if IsAddOnLoaded("Recount") then Recount_MainWindow:Hide() end
				if IsAddOnLoaded("Omen") then OmenAnchor:Hide() end
				if IsAddOnLoaded("Skada") then Skada:SetActive(false) end
			elseif event == "PLAYER_REGEN_DISABLED" then
				self:Show()
				if TukuiChatBackgroundRight then TukuiChatBackgroundRight:Hide() end
				if IsAddOnLoaded("Recount") then Recount_MainWindow:Show() end
				if IsAddOnLoaded("Omen") then OmenAnchor:Show() end
				if IsAddOnLoaded("Skada") then Skada:SetActive(true) end
			end
		end
	end)
end

-- Tiny CooldownToGo Skin (we dont need an config entry for that..)
if IsAddOnLoaded("CooldownToGo") then
	local iconborder = CreateFrame("Frame", nil, CooldownToGoFrame)
	iconborder:CreatePanel("",1,1,"TOPLEFT", CDTGIcon, "TOPLEFT", -2, 2)
	iconborder:Point("BOTTOMRIGHT", CDTGIcon, "BOTTOMRIGHT", 2, -2)
	CDTGIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	CDTGText:SetPoint("LEFT", CooldownToGoFrame, "CENTER", 3, 0)
end

if IsAddOnLoaded("spellstealer") then
	SSFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background"})
	SSFrame:SetBackdropColor(0,0,0,0)
	SSFrameList:SetBackdropColor(0,0,0,0)

	local sslist = CreateFrame("Frame", nil, SSFrameList)
	sslist:CreatePanel("", 1, 1, "TOPLEFT", SSFrameList, "TOPLEFT", -2, 2)
	sslist:Point("BOTTOMRIGHT", 2, -2)
		
	local ssframeb = CreateFrame("Frame", nil, sslist)
	ssframeb:CreatePanel("", 1, 16, "BOTTOMLEFT", sslist, "TOPLEFT", 0, 3)
	ssframeb:Point("BOTTOMRIGHT", sslist, "TOPRIGHT", 0, 3)
		
	SSFrametitletext:SetFont(C.media.pixelfont, 10)
	SSFrametitletext:SetTextColor(unpack(C.datatext.color))
	SSFrameListText:SetFont(C.media.font, 10)
	
	SSFrameListText:Point("LEFT", 2, 0)
	SSFrametitletext:ClearAllPoints()
	SSFrametitletext:Point("LEFT", ssframeb, "LEFT", 2, 0)
end
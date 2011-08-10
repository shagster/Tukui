local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
	
	if C["Addon_Skins"].embedright == "None" then return end
	-- Addons Background (same size as right chat background)
	local AddonBGPanel = CreateFrame("Frame", "AddonBGPanel", UIParent)
	AddonBGPanel:CreatePanel("Transparent", TukuiChatBackgroundRight:GetWidth(), TukuiChatBackgroundRight:GetHeight(), "BOTTOMRIGHT", TukuiChatBackgroundRight, "BOTTOMRIGHT", 0, 0)
	
	-- toggle in-/outfight (NOTE: This will only toggle ChatFrameX (chat config))
	AddonBGPanel:RegisterEvent("PLAYER_ENTERING_WORLD")
	AddonBGPanel:RegisterEvent("PLAYER_LOGIN")
	if C.Addon_Skins.combat_toggle then
		AddonBGPanel:RegisterEvent("PLAYER_REGEN_ENABLED")
		AddonBGPanel:RegisterEvent("PLAYER_REGEN_DISABLED")
	end
	AddonBGPanel:SetScript("OnEvent", function(self, event)
		if C.Addon_Skins.combat_toggle then
			if event == "PLAYER_LOGIN" then
				-- Hide
				AddonBGPanel:Hide()
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
				if TukuiChatBackgroundLeft:IsVisible() then TukuiChatBackgroundRight:Show() end
				if IsAddOnLoaded("Recount") then Recount_MainWindow:Hide() end
				if IsAddOnLoaded("Omen") then OmenAnchor:Hide() end
				if IsAddOnLoaded("Skada") then Skada:SetActive(false) end
			elseif event == "PLAYER_REGEN_DISABLED" then
				self:Show()
				if TukuiChatBackgroundRight then TukuiChatBackgroundRight:Hide() end
				TukuiBar5:SetPoint("BOTTOM", TukuiChatBackgroundRight, "TOP", 0, 4)
				if IsAddOnLoaded("Recount") then Recount_MainWindow:Show() end
				if IsAddOnLoaded("Omen") then OmenAnchor:Show() end
				if IsAddOnLoaded("Skada") then Skada:SetActive(true) end
			end
		end
	end)

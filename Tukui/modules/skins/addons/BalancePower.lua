local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
if IsAddOnLoaded("BalancePowerTracker") then
if T.myclass == "DRUID" then
	local eclipseBar = CreateFrame("Frame", "EclipseBar", UIParent)
	eclipseBar:CreatePanel(nil, 1, 1, "CENTER", BalancePowerTrackerBackgroundFrame, "CENTER", 0, 0)
	eclipseBar:ClearAllPoints()
	eclipseBar:Point("TOPLEFT", BalancePowerTrackerBackgroundFrame, "TOPLEFT", 0, 0)
	eclipseBar:Point("BOTTOMRIGHT", BalancePowerTrackerBackgroundFrame, "BOTTOMRIGHT", 0, 0)
	--eclipseBar:CreateShadow("Default")
	eclipseBar:SetTemplate("Thin")
	eclipseBar:SetBackdropColor(0,0,0,1)
	
	local eclipseBarfunc = CreateFrame("Frame")
	eclipseBarfunc:RegisterEvent("PLAYER_ENTERING_WORLD")
	eclipseBarfunc:RegisterEvent("UNIT_AURA")
	eclipseBarfunc:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	eclipseBarfunc:RegisterEvent("PLAYER_TALENT_UPDATE")
	eclipseBarfunc:RegisterEvent("UNIT_TARGET")
	eclipseBarfunc:SetScript("OnEvent", function(self)
    local activeTalent = GetPrimaryTalentTree()
    local shift = GetShapeshiftForm()
	local grace = select(7, UnitAura("player", "Nature's Grace", nil, "HELPFUL"))
    	if grace then
			eclipseBar:SetBackdropBorderColor(205, 25, 0, 1)
		else
			eclipseBar:SetBackdropBorderColor(unpack(C["media"].bordercolor))
		end

		if activeTalent == 1 then
		    if shift == 1 or shift == 2 or shift == 3 or shift == 4 or shift == 6 then
		        eclipseBar:Hide()
			else
			    eclipseBar:Show()
			end
		else
		    eclipseBar:Hide()
		end
	end)

	
end
end
if T.myclass == "DRUID" then
	local t11bar1 = CreateFrame("Frame", "T11Bar1", UIParent)
	local t11bar2 = CreateFrame("Frame", "T11Bar2", UIParent)
	local t11bar3 = CreateFrame("Frame", "T11Bar3", UIParent)
	
	t11bar1:CreatePanel(nil, 1, 2, "TOPLEFT", BalancePowerTrackerBackgroundFrame, "BOTTOMLEFT", 3, 2)
	--t11bar1:CreateShadow("Default")
	--t11bar1.shadow:SetBackdropBorderColor(192, 0, 0, 1)
	t11bar1:SetWidth(78)
	t11bar1:SetBackdropBorderColor(192, 0, 0, 1)
	t11bar1:SetFrameStrata("HIGH")
	t11bar1:Hide()
	
	t11bar2:CreatePanel(nil, 1, 2, "TOP", BalancePowerTrackerBackgroundFrame, "BOTTOM", 0, 2)
	--t11bar2:CreateShadow("Default")
	--t11bar2.shadow:SetBackdropBorderColor(192, 0, 0, 1)
	t11bar2:SetWidth(78)
	t11bar2:SetBackdropBorderColor(192, 0, 0, 1)
	t11bar2:SetFrameStrata("HIGH")
	t11bar2:Hide()
	
	t11bar3:CreatePanel(nil, 1, 2, "TOPRIGHT", BalancePowerTrackerBackgroundFrame, "BOTTOMRIGHT", -3, 2)
	--t11bar3:CreateShadow("Default")
	--t11bar3.shadow:SetBackdropBorderColor(192, 0, 0, 1)
	t11bar3:SetWidth(78)
	t11bar3:SetBackdropBorderColor(192, 0, 0, 1)
	t11bar3:SetFrameStrata("HIGH")
	t11bar3:Hide()
	
	local t11barfunc = CreateFrame("Frame")
	t11barfunc:RegisterEvent("PLAYER_ENTERING_WORLD")
	t11barfunc:RegisterEvent("UNIT_AURA")
	t11barfunc:SetScript("OnEvent", function(self)
	local _,_,_,count,_,_,i,_,_ = UnitAura("player", "Astral Alignment", nil, "HELPFUL")
		if i then
			if count > 0 then
				t11bar1:Show()
			else
				t11bar1:Hide()
			end
			if count > 1 then
				t11bar2:Show()
			else
				t11bar2:Hide()
			end
			if count > 2 then
				t11bar3:Show()
			else
				t11bar3:Hide()
			end
		else
			t11bar1:Hide()
			t11bar2:Hide()
			t11bar3:Hide()
		end
	end)
	end
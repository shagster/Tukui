local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
if C["datatext"].specswitcher == 1 then

local talenticon = CreateFrame("Frame", "TukuiTalentIcon", TukuiChatBackgroundLeft)
talenticon:CreatePanel("Default", 14, 14, "BOTTOMLEFT", TukuiChatBackgroundLeft, "BOTTOMLEFT", 10, 4)
talenticon:SetFrameStrata("LOW")
talenticon:SetTemplate("Thin")

talenticon.tex = talenticon:CreateTexture(nil, "ARTWORK")
talenticon.tex:Point("TOPLEFT", 1, -1)
talenticon.tex:Point("BOTTOMRIGHT", -1, 1)
talenticon.tex:SetTexCoord(0.08, 0.92, 0.08, 0.92)

local UpdateTexture = function(self)
	if not GetPrimaryTalentTree() then return end
	local primary = GetPrimaryTalentTree()
	local tex = select(4, GetTalentTabInfo(primary))
	
	self.tex:SetTexture(tex)
end
talenticon:SetScript("OnMouseDown", function(self, btn)
	if btn == 'RightButton'  then
		ToggleTalentFrame()
	else
		SetActiveTalentGroup(active == 1 and 2 or 1)
	end
	end)
	
	talenticon:RegisterEvent("PLAYER_ENTERING_WORLD")
	talenticon:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	talenticon:RegisterEvent("PLAYER_TALENT_UPDATE")
	talenticon:SetScript("OnEvent", UpdateTexture)
	end
	
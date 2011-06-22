local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
if C["datatext"].specswitcher == 1 then

local talenticon = CreateFrame("Frame", "TukuiTalentIcon", TukuiInfoLeft)
talenticon:CreatePanel("Default", 14, 14, "LEFT", TukuiInfoLeft, "LEFT", 10, 0)
--talenticon:SetFrameLevel(2)
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

local ChangeSpec = function()
	local spec = GetActiveTalentGroup()
	
	if spec == 1 then
		SetActiveTalentGroup(2)
	else
		SetActiveTalentGroup(1)
	end
end

	
	talenticon:SetScript("OnMouseDown", ChangeSpec)
	talenticon:RegisterEvent("PLAYER_ENTERING_WORLD")
	talenticon:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	talenticon:RegisterEvent("PLAYER_TALENT_UPDATE")
	talenticon:SetScript("OnEvent", UpdateTexture)
	end
	
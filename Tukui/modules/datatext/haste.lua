local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
--------------------------------------------------------------------
-- player haste
--------------------------------------------------------------------

if not C["datatext"].haste or C["datatext"].haste == 0 then return end
	local Stat = CreateFrame("Frame")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = TukuiChatBackgroundLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(C.media.pixelfont, C["datatext"].fontsize, "MONOCHROMEOUTLINE")
	T.PP(C["datatext"].haste, Text)
	Stat:SetParent(Text:GetParent())
	local int = 1

	local function Update(self, t)
		spellhaste = UnitSpellHaste("player");
		rangedhaste = GetRangedHaste();
		attackhaste = GetMeleeHaste();
		
		if T.Role == "Caster" then
			haste = spellhaste
		else
		if T.myclass == "HUNTER" then
			haste = rangedhaste
		else
			haste = attackhaste
		end
		end
		
		int = int - t
		if int < 0 then
			Text:SetText(format("%.2f", haste).."% "..T.panelcolor..L.datatext_playerhaste)
			int = 1
		end     
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)

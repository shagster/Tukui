local T, C, L = unpack(select(2, ...)) 
if not C.actionbar.enable or not C.actionbar.microbar then return end
-----------------------------------------
-- Microbar by Elv22
-----------------------------------------
local anchor = CreateFrame("Frame", "TukuiMicrobarAnchor", UIParent)
anchor:Size((((CharacterMicroButton:GetWidth() + 4) * 9) + 12), CharacterMicroButton:GetHeight() - 28)
anchor:SetFrameStrata("TOOLTIP")
anchor:SetFrameLevel(20)
anchor:SetClampedToScreen(true)
anchor:SetAlpha(0)
anchor:SetPoint("TOPLEFT", 12, -12)
anchor:SetTemplate("Default")
anchor:SetBackdropBorderColor(1, 0, 0, 1)
anchor:SetMovable(true)
anchor.text = T.SetFontString(anchor, C.media.uffont, 10)
anchor.text:SetPoint("CENTER")
anchor.text:SetText(L.move_microbar)

local microbuttons = {
	"CharacterMicroButton",
	"SpellbookMicroButton",
	"TalentMicroButton",
	"QuestLogMicroButton",
	"PVPMicroButton",
	"GuildMicroButton",
	"LFDMicroButton",
	"EJMicroButton",
	"RaidMicroButton",
	"HelpMicroButton",
	"MainMenuMicroButton",
	"AchievementMicroButton"
}

local f = CreateFrame("Frame", "MicroParent", UIParent)
MicroParent.shown = false
if C.actionbar.mousemicro then f:SetAlpha(0) end

UpdateMicroButtonsParent(f)

local function CheckFade(self, elapsed)
	local mouseactive
	for i, button in pairs(microbuttons) do
		local b = _G[button]
		if b.mouseover == true then
			mouseactive = true
			if GameTooltip:IsShown() then
				GameTooltip:Hide()
			end
		end
	end

	if not C.actionbar.mousemicro then return end

	if MicroParent.mouseover == true then
		mouseactive = true
		if GameTooltip:IsShown() then
			GameTooltip:Hide()
		end
	end

	if mouseactive == true then
		if MicroParent.shown ~= true then
			UIFrameFadeIn(MicroParent, 0.2)
			MicroParent.shown = true
		end
	else
		if MicroParent.shown == true then
			UIFrameFadeOut(MicroParent, 0.2)
			MicroParent.shown = false
		end
	end
end
f:SetScript("OnUpdate", CheckFade)

for i, button in pairs(microbuttons) do
	local m = _G[button]
	local pushed = m:GetPushedTexture()
	local normal = m:GetNormalTexture()
	local disabled = m:GetDisabledTexture()

	m:SetParent(MicroParent)
	m.SetParent = T.dummy
	_G[button.."Flash"]:SetTexture("")
	m:SetHighlightTexture("")
	m.SetHighlightTexture = T.dummy

	local f = CreateFrame("Frame", nil, m)
	f:SetFrameLevel(1)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint("BOTTOMLEFT", m, "BOTTOMLEFT", 2, 0)
	f:SetPoint("TOPRIGHT", m, "TOPRIGHT", -2, -28)
	f:SetTemplate("Default", true)
	m.frame = f

	pushed:SetTexCoord(0.17, 0.87, 0.5, 0.908)
	pushed:ClearAllPoints()
	pushed:SetPoint("TOPLEFT", m.frame, "TOPLEFT", 2, -2)
	pushed:SetPoint("BOTTOMRIGHT", m.frame, "BOTTOMRIGHT", -2, 2)

	normal:SetTexCoord(0.17, 0.87, 0.5, 0.908)
	normal:ClearAllPoints()
	normal:SetPoint("TOPLEFT", m.frame, "TOPLEFT", 2, -2)
	normal:SetPoint("BOTTOMRIGHT", m.frame, "BOTTOMRIGHT", -2, 2)

	if disabled then
		disabled:SetTexCoord(0.17, 0.87, 0.5, 0.908)
		disabled:ClearAllPoints()
		disabled:SetPoint("TOPLEFT", m.frame, "TOPLEFT", 2, -2)
		disabled:SetPoint("BOTTOMRIGHT", m.frame, "BOTTOMRIGHT", -2, 2)
	end

	m.mouseover = false
	m:HookScript("OnEnter", function(self) self.mouseover = true end)
	m:HookScript("OnLeave", function(self) self.mouseover = false end)
end

--Fix/Create textures for buttons
do
	MicroButtonPortrait:ClearAllPoints()
	MicroButtonPortrait:SetPoint("TOPLEFT", CharacterMicroButton.frame, "TOPLEFT", 2, -2)
	MicroButtonPortrait:SetPoint("BOTTOMRIGHT", CharacterMicroButton.frame, "BOTTOMRIGHT", -2, 2)

	GuildMicroButtonTabard:ClearAllPoints()
	GuildMicroButtonTabard:SetPoint("TOP", GuildMicroButton.frame, "TOP", 0, 25)
	GuildMicroButtonTabard.SetPoint = T.dummy
	GuildMicroButtonTabard.ClearAllPoints = T.dummy
end

MicroParent:SetPoint("TOPLEFT", TukuiMicrobarAnchor, "TOPLEFT", 0, 0) --Default microbar position
MicroParent:SetWidth(((CharacterMicroButton:GetWidth() + 4) * 9) + 12)
MicroParent:SetHeight(CharacterMicroButton:GetHeight() - 28)

CharacterMicroButton:ClearAllPoints()
CharacterMicroButton:SetPoint("BOTTOMLEFT", MicroParent, "BOTTOMLEFT", 0,  0)
CharacterMicroButton.SetPoint = T.dummy
CharacterMicroButton.ClearAllPoints = T.dummy

local bg = CreateFrame("Frame", "TukuiMicrobarBG", MicroParent)
bg:CreatePanel("Default", MicroParent:GetWidth() + 9, MicroParent:GetHeight() + 10, "CENTER", MicroParent, "CENTER", 2, 0)
bg:CreateShadow("Default")
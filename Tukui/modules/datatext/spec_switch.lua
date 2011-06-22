local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
-- TALENT SPEC-SWITCHER BUTTON

if C["datatext"].specbutton and C["datatext"].specbutton > 0 then
--if C["datatext"].talentbutton == true then
if UnitLevel("player") <= 10 then return end

local frame = CreateFrame("Frame", "TalentButton", UIParent)
frame:CreatePanel(nil, 16, 16, "LEFT", TukuiInfoLeft, "LEFT", 0, 0)
frame:EnableMouse(true)
frame:SetFrameLevel(2)

frame.tex = frame:CreateTexture(nil, "ARTWORK")
frame.tex:Point("TOPLEFT", 2, -2)
frame.tex:Point("BOTTOMRIGHT", -2, 2)
frame.tex:SetTexCoord(0.08, 0.92, 0.08, 0.92)

frame.highlight = frame:CreateTexture(nil, "ARTWORK")
frame.highlight:Point("TOPLEFT", 2, -2)
frame.highlight:Point("BOTTOMRIGHT", -2, 2)
frame.highlight:SetTexture(1,1,1,.3)
frame.highlight:Hide()

local UpdateTexture = function(self)
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

local StyleTooltip = function(self)
if not InCombatLockdown() then
local p1 = select(5, GetTalentTabInfo(1))
local p2 = select(5, GetTalentTabInfo(2))
local p3 = select(5, GetTalentTabInfo(3))
local name = select(2, GetTalentTabInfo(GetPrimaryTalentTree()))
local spec = GetActiveTalentGroup()

--local anchor, panel, xoff, yoff = T.DataTextTooltipAnchor(Text)
GameTooltip:SetOwner(self, "ANCHOR_NONE", 0, 0)
GameTooltip:ClearLines()

if spec == 1 then
GameTooltip:AddDoubleLine(format("|cffFFFFFF%s: %s/%s/%s - [%s]|r", name, p1, p2, p3, PRIMARY))
else
GameTooltip:AddDoubleLine(format("|cffFFFFFF%s: %s/%s/%s - [%s]|r", name, p1, p2, p3, SECONDARY))
end

self.highlight:Show()
GameTooltip:Show()
end
end

frame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
frame:RegisterEvent("PLAYER_TALENT_UPDATE")
frame:SetScript("OnEvent", UpdateTexture)
frame:SetScript("OnMouseDown", ChangeSpec)
frame:SetScript("OnEnter", StyleTooltip)
frame:SetScript("OnLeave", function(self) GameTooltip:Hide() self.highlight:Hide() end)
end
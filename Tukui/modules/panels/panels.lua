local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

local sbWidth = C.actionbar.sidebarWidth
local mbWidth = C.actionbar.mainbarWidth

local TukuiBar1 = CreateFrame("Frame", "TukuiBar1", UIParent, "SecureHandlerStateTemplate")
TukuiBar1:CreatePanel("Invisible", 1, 1, "BOTTOM", UIParent, "BOTTOM", 0, 10) --35
TukuiBar1:SetWidth((T.buttonsize * mbWidth) + (T.buttonspacing * (mbWidth-1)))
TukuiBar1:SetHeight((T.buttonsize * 2) + (T.buttonspacing))
TukuiBar1:SetFrameStrata("BACKGROUND")
TukuiBar1:SetFrameLevel(1)

local TukuiBar2 = CreateFrame("Frame", "TukuiBar2", UIParent)
TukuiBar2:CreatePanel("Invisible", 1, 1, "BOTTOMRIGHT", TukuiBar1, "BOTTOMLEFT", -5, 0)
TukuiBar2:SetWidth((T.buttonsize * sbWidth) + (T.buttonspacing * (sbWidth-1)))
TukuiBar2:SetHeight((T.buttonsize * 2) + (T.buttonspacing))
TukuiBar2:SetFrameStrata("BACKGROUND")
TukuiBar2:SetFrameLevel(2)
if T.lowversion then
	TukuiBar2:SetAlpha(0)
else
	TukuiBar2:SetAlpha(1)
end

local TukuiBar3 = CreateFrame("Frame", "TukuiBar3", UIParent)
TukuiBar3:CreatePanel("Invisible", 1, 1, "BOTTOMLEFT", TukuiBar1, "BOTTOMRIGHT", 5, 0)
TukuiBar3:SetWidth((T.buttonsize * sbWidth) + (T.buttonspacing * (sbWidth-1)))
TukuiBar3:SetHeight((T.buttonsize * 2) + (T.buttonspacing))
TukuiBar3:SetFrameStrata("BACKGROUND")
TukuiBar3:SetFrameLevel(2)
if T.lowversion then
	TukuiBar3:SetAlpha(0)
else
	TukuiBar3:SetAlpha(1)
end

local TukuiBar4 = CreateFrame("Frame", "TukuiBar4", UIParent)
TukuiBar4:CreatePanel("Invisible", 1, 1, "BOTTOM", UIParent, "BOTTOM", 0, 10)
TukuiBar4:SetWidth((T.buttonsize * mbWidth) + (T.buttonspacing * (mbWidth-1)))
TukuiBar4:SetHeight((T.buttonsize * 2) + (T.buttonspacing))
TukuiBar4:SetFrameStrata("BACKGROUND")
TukuiBar4:SetFrameLevel(2)
TukuiBar4:SetAlpha(0)


local TukuiBar5 = CreateFrame("Frame", "TukuiBar5", UIParent)
TukuiBar5:CreatePanel("Invisible", (T.buttonsize * 12) + (T.buttonspacing * 11), T.buttonsize, "RIGHT", UIParent, "RIGHT", -24, -14)
TukuiBar5:SetFrameStrata("BACKGROUND")
TukuiBar5:SetFrameLevel(2)
TukuiBar5:SetAlpha(0)

local TukuiBar6 = CreateFrame("Frame", "TukuiBar6", UIParent)
TukuiBar6:SetWidth((T.buttonsize) + (T.buttonspacing * 2))
TukuiBar6:SetHeight((T.buttonsize * 12) + (T.buttonspacing * 11))
TukuiBar6:SetPoint("LEFT", TukuiBar5, "LEFT", 0, 0)
TukuiBar6:SetFrameStrata("BACKGROUND")
TukuiBar6:SetFrameLevel(2)
TukuiBar6:SetAlpha(0)

local TukuiBar7 = CreateFrame("Frame", "TukuiBar7", UIParent)
TukuiBar7:SetWidth((T.buttonsize) + (T.buttonspacing * 2))
TukuiBar7:SetHeight((T.buttonsize * 12) + (T.buttonspacing * 11))
TukuiBar7:SetPoint("TOP", TukuiBar5, "TOP", 0 , 0)
TukuiBar7:SetFrameStrata("BACKGROUND")
TukuiBar7:SetFrameLevel(2)
TukuiBar7:SetAlpha(0)

local petbg = CreateFrame("Frame", "TukuiPetBar", UIParent, "SecureHandlerStateTemplate")
petbg:CreatePanel("Invisible", (T.petbuttonsize * 10) + (T.petbuttonspacing * 9), T.petbuttonsize, "BOTTOM", TukuiBar5, "TOP", 0, 5)


local ltpetbg1 = CreateFrame("Frame", "TukuiLineToPetActionBarBackground", petbg)
ltpetbg1:CreatePanel("Invisible", 24, 265, "LEFT", petbg, "RIGHT", 0, 0)
ltpetbg1:SetParent(petbg)
ltpetbg1:SetFrameStrata("BACKGROUND")
ltpetbg1:SetFrameLevel(0)
ltpetbg1:SetAlpha(0)

if C.actionbar.bgPanel then
	for i = 1, 5 do
		_G["TukuiBar"..i]:SetTemplate("Default")
		--_G["TukuiBar"..i]:CreateShadow()
		_G["TukuiBar"..i]:SetBackdropColor(0,0,0,1)
	end
	
	petbg:SetTemplate("Default")
	--petbg:CreateShadow()
	petbg:SetBackdropColor(0,0,0,1)
	petbg:SetWidth((T.petbuttonsize * 10) + (T.petbuttonspacing * 11))
	petbg:SetHeight(T.petbuttonsize + (T.petbuttonspacing * 2))
	
	TukuiBar1:SetWidth((T.buttonsize * mbWidth) + (T.buttonspacing * (mbWidth+1)))
	TukuiBar1:SetHeight((T.buttonsize * 2) + (T.buttonspacing*3))
	
	TukuiBar2:SetWidth((T.buttonsize * sbWidth) + (T.buttonspacing * (sbWidth+1)))
	TukuiBar2:SetHeight((T.buttonsize * 2) + (T.buttonspacing*3))
	
	TukuiBar3:SetWidth((T.buttonsize * sbWidth) + (T.buttonspacing * (sbWidth+1)))
	TukuiBar3:SetHeight((T.buttonsize * 2) + (T.buttonspacing*3))
	
	TukuiBar4:SetWidth((T.buttonsize * mbWidth) + (T.buttonspacing * (mbWidth+1)))
	TukuiBar4:SetHeight((T.buttonsize * 2) + (T.buttonspacing*3))
	--TukuiBar4.shadow:Hide()
	
	TukuiBar5:SetWidth((T.buttonsize * 12) + (T.buttonspacing * 13))
	TukuiBar5:SetHeight((T.buttonsize) + (T.buttonspacing*2))
	
	TukuiBar6:SetWidth((T.buttonsize) + (T.buttonspacing * 2))
	TukuiBar6:SetHeight((T.buttonsize * 12) + (T.buttonspacing * 13))
	
	TukuiBar7:SetWidth((T.buttonsize) + (T.buttonspacing * 2))
	TukuiBar7:SetHeight((T.buttonsize * 12) + (T.buttonspacing * 13))
end

-- Default FRAME COVERING BOTTOM ACTIONBARS JUST TO PARENT UF CORRECTLY
local invbarbg = CreateFrame("Frame", "InvTukuiActionBarBackground", UIParent)
if T.lowversion then
	invbarbg:SetPoint("TOPLEFT", TukuiBar1)
	invbarbg:SetPoint("BOTTOMRIGHT", TukuiBar1)
	TukuiBar2:Hide()
	TukuiBar3:Hide()
else
	invbarbg:SetPoint("TOPLEFT", TukuiBar2)
	invbarbg:SetPoint("BOTTOMRIGHT", TukuiBar3)
end


-- LEFT VERTICAL LINE
local ileftlv = CreateFrame("Frame", "TukuiInfoLeftLineVertical", TukuiBar1)
ileftlv:CreatePanel("Default", 2, 130, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 22, 30)

-- RIGHT VERTICAL LINE
local irightlv = CreateFrame("Frame", "TukuiInfoRightLineVertical", TukuiBar1)
irightlv:CreatePanel("Default", 2, 130, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -22, 30)

if not C.chat.background then
	-- CUBE AT LEFT, ACT AS A BUTTON (CHAT MENU)
	local cubeleft = CreateFrame("Frame", "TukuiCubeLeft", TukuiBar1)
	cubeleft:CreatePanel("Default", 10, 10, "BOTTOM", ileftlv, "TOP", 0, 0)
	cubeleft:EnableMouse(true)
	cubeleft:SetScript("OnMouseDown", function(self, btn)
		if TukuiInfoLeftBattleGround and UnitInBattleground("player") then
			if btn == "RightButton" then
				if TukuiInfoLeftBattleGround:IsShown() then
					TukuiInfoLeftBattleGround:Hide()
				else
					TukuiInfoLeftBattleGround:Show()
				end
			end
		end
		
		if btn == "LeftButton" then	
			ToggleFrame(ChatMenu)
		end
	end)

	-- CUBE AT RIGHT, ACT AS A BUTTON (CONFIGUI or BG'S)
	local cuberight = CreateFrame("Frame", "TukuiCubeRight", TukuiBar1)
	cuberight:CreatePanel("Default", 10, 10, "BOTTOM", irightlv, "TOP", 0, 0)
	if C["bags"].enable then
		cuberight:EnableMouse(true)
		cuberight:SetScript("OnMouseDown", function(self)
			ToggleKeyRing()
		end)
	end
end

-- HORIZONTAL LINE LEFT
local ltoabl = CreateFrame("Frame", "TukuiLineToABLeft", TukuiBar1)
ltoabl:CreatePanel("Default", 5, 2, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0, 0)
ltoabl:ClearAllPoints()
ltoabl:Point("BOTTOMLEFT", ileftlv, "BOTTOMLEFT", 0, 0)
ltoabl:Point("RIGHT", TukuiBar1, "BOTTOMLEFT", -1, 17)
ltoabl:SetFrameStrata("BACKGROUND")
ltoabl:SetFrameLevel(1)

-- HORIZONTAL LINE RIGHT
local ltoabr = CreateFrame("Frame", "TukuiLineToABRight", TukuiBar1)
ltoabr:CreatePanel("Default", 5, 2, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0, 0)
ltoabr:ClearAllPoints()
ltoabr:Point("LEFT", TukuiBar1, "BOTTOMRIGHT", 1, 17)
ltoabr:Point("BOTTOMRIGHT", irightlv, "BOTTOMRIGHT", 0, 0)
ltoabr:SetFrameStrata("BACKGROUND")
ltoabr:SetFrameLevel(1)


-- MOVE/HIDE SOME ELEMENTS IF CHAT BACKGROUND IS ENABLED
local movechat = 0
if C.chat.background then movechat = 10 ileftlv:SetAlpha(0) irightlv:SetAlpha(0) end

-- INFO LEFT (FOR STATS)
local ileft = CreateFrame("Frame", "TukuiInfoLeft", TukuiBar1)
ileft:CreatePanel("Default", T.InfoLeftRightWidth + 12, 17, "LEFT", ltoabl, "LEFT", -2 - movechat, -11)
--ileft:SetFrameLevel(2)
ileft:CreateShadow("Default")
ileft:SetFrameStrata("LOW")

-- INFO RIGHT (FOR STATS)
local iright = CreateFrame("Frame", "TukuiInfoRight", TukuiBar1)
iright:CreatePanel("Default", T.InfoLeftRightWidth + 12, 17, "RIGHT", ltoabr, "RIGHT", 2 + movechat, -11)
--iright:SetFrameLevel(2)
iright:CreateShadow("Default")
iright:SetFrameStrata("LOW")


-- Alpha horizontal lines because all panels is dependent on this frame.
ltoabl:SetAlpha(0)
ltoabr:SetAlpha(0)

-- CHAT BG LEFT
local chatleftbg = CreateFrame("Frame", "TukuiChatBackgroundLeft", TukuiInfoLeft)
chatleftbg:CreatePanel("Transparent", T.InfoLeftRightWidth + 12, 118, "BOTTOM", TukuiInfoLeft, "BOTTOM", 0, 19)
chatleftbg:CreateShadow("Default")
	
-- CHAT BG RIGHT
local chatrightbg = CreateFrame("Frame", "TukuiChatBackgroundRight", TukuiInfoRight)
chatrightbg:CreatePanel("Transparent", T.InfoLeftRightWidth + 12, 118, "BOTTOM", TukuiInfoRight, "BOTTOM", 0, 19)
chatrightbg:CreateShadow("Default")
	
-- LEFT TAB PANEL
local tabsbgleft = CreateFrame("Frame", "TukuiTabsLeftBackground", TukuiChatBackgroundLeft)
tabsbgleft:CreatePanel("Default", T.InfoLeftRightWidth + 12, 17, "BOTTOMLEFT", chatleftbg, "TOPLEFT", 0, T.Scale(2))
--tabsbgleft:SetFrameLevel(1)
tabsbgleft:SetFrameStrata("BACKGROUND")
tabsbgleft:CreateShadow("Default")

-- RIGHT TAB PANEL
local tabsbgright = CreateFrame("Frame", "TukuiTabsRightBackground", TukuiChatBackgroundRight)
tabsbgright:CreatePanel("Default", T.InfoLeftRightWidth + 12, 17, "BOTTOMLEFT", chatrightbg, "TOPLEFT", 0, T.Scale(2))
--tabsbgright:SetFrameLevel(1)
tabsbgright:SetFrameStrata("BACKGROUND")
tabsbgright:CreateShadow("Default")

--[[
if TukuiMinimap then
	local minimapstatsleft = CreateFrame("Frame", "TukuiMinimapStatsLeft", TukuiMinimap)
	minimapstatsleft:CreatePanel("Default", ((TukuiMinimap:GetWidth() + 4) / 2) -3, 19, "TOPLEFT", TukuiMinimap, "BOTTOMLEFT", 0, -2)

	local minimapstatsright = CreateFrame("Frame", "TukuiMinimapStatsRight", TukuiMinimap)
	minimapstatsright:CreatePanel("Default", ((TukuiMinimap:GetWidth() + 4) / 2) -3, 19, "TOPRIGHT", TukuiMinimap, "BOTTOMRIGHT", 0, -2)
end
--]]

--Re-anchor above right chat panel
TukuiBar5:ClearAllPoints()
TukuiBar5:Point("BOTTOM", tabsbgright, "TOP", 0, 4)

petbg:ClearAllPoints()
petbg:Point("BOTTOM", TukuiBar5, "TOP", 0, 3)

TukuiBar5:SetScript("OnHide", function() petbg:ClearAllPoints() petbg:Point("BOTTOM", tabsbgright, "TOP", 0, 4) end)
TukuiBar5:SetScript("OnShow", function() petbg:ClearAllPoints() petbg:Point("BOTTOM", TukuiBar5, "TOP", 0, 3) end)

--BATTLEGROUND STATS FRAME
if C["datatext"].battleground == true then
	local bgframe = CreateFrame("Frame", "TukuiInfoLeftBattleGround", UIParent)
	bgframe:CreatePanel("Default", 1, 1, "TOPLEFT", UIParent, "BOTTOMLEFT", 0, 0)
	bgframe:SetAllPoints(ileft)
	bgframe:SetFrameStrata("MEDIUM")
	bgframe:SetFrameLevel(0)
	bgframe:EnableMouse(true)
end

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

--[[ ADDONS BUTTON
local adbutton = CreateFrame("Button", "TukuiAddonsButton", UIParent, "SecureActionButtonTemplate")
adbutton:CreatePanel("Default", 100, 17, "BOTTOM", UIParent, "BOTTOM", 0, 12)
adbutton:SetAttribute("type", "macro")
adbutton:SetAttribute("macrotext", "/al")

adbutton.Text = T.SetFontString(adbutton, C.media.pixelfont, 10)
adbutton.Text:Point("CENTER", adbutton, "CENTER", 0, 1)
adbutton.Text:SetText(T.StatColor..ADDONS)

local function ModifiedBackdrop(self)
	local color = RAID_CLASS_COLORS[T.myclass]
	self:SetBackdropColor(unpack(C["media"].backdropcolor))
	self:SetBackdropBorderColor(color.r, color.g, color.b)
end

local function OriginalBackdrop(self)
	self:SetBackdropColor(unpack(C["media"].backdropcolor))
	self:SetBackdropBorderColor(unpack(C["media"].bordercolor))
end

local buttons = {"TukuiAddonsButton"}
--]]

--for i = 1, getn(buttons) do
--	local frame = _G[buttons[i]]
--	frame:SetFrameStrata("BACKGROUND")
--	frame:SetFrameLevel(2)
--	frame:SetAlpha(0)
--	frame:CreateShadow("Default")
--	frame:SetScript("OnEnter", function(self) for _, f in pairs(buttons) do _G[f]:SetAlpha(1) end end)
--	frame:SetScript("OnLeave", function(self) for _, f in pairs(buttons) do _G[f]:SetAlpha(0) end end)
--	frame:HookScript("OnEnter", ModifiedBackdrop)
--	frame:HookScript("OnLeave", OriginalBackdrop)
	
--	if i == 6 then
--		frame:SetFrameLevel(0)
--		frame.shadow:Hide()

--		end
	
--end



-- MOUSEOVER FUNCTION FOR BUTTONS
--moveuibutton:SetAlpha(0)
--configbutton:SetAlpha(0)
--adbutton:SetAlpha(0)
--resetuibutton:SetAlpha(0)
--rluibutton:SetAlpha(0)

--local buttonsBG = CreateFrame("frame", nil, UIParent)
--buttonsBG:SetPoint("TOPLEFT", adbutton, "TOPLEFT" ,0, 0)
--buttonsBG:SetPoint("BOTTOMRIGHT", adbutton, "BOTTOMRIGHT" ,0, 0)
--buttonsBG:EnableMouse(true)
--buttonsBG:SetFrameLevel(0)
--buttonsBG:SetFrameStrata("BACKGROUND")

--local function Alpha(alpha)
	--moveuibutton:SetAlpha(alpha)
	--configbutton:SetAlpha(alpha)
--	adbutton:SetAlpha(alpha)
	--resetuibutton:SetAlpha(alpha)
	--rluibutton:SetAlpha(alpha)
--end

--moveuibutton:SetScript("OnEnter", function() Alpha(1) end)
--moveuibutton:SetScript("OnLeave", function() Alpha(0) end)
--configbutton:SetScript("OnEnter",function() Alpha(1) end)
--configbutton:SetScript("OnLeave", function() Alpha(0) end)
--adbutton:SetScript("OnEnter", function() Alpha(1) end)
--adbutton:SetScript("OnLeave", function() Alpha(0) end)
--resetuibutton:SetScript("OnEnter",function() Alpha(1) end)
--resetuibutton:SetScript("OnLeave", function() Alpha(0) end)
--rluibutton:SetScript("OnEnter", function() Alpha(1) end)
--rluibutton:SetScript("OnLeave", function() Alpha(0) end)
--buttonsBG:SetScript("OnEnter", function() Alpha(1) end)
--buttonsBG:SetScript("OnLeave", function() Alpha(0) end)

-- World Frame 
WorldStateAlwaysUpFrame:ClearAllPoints()
WorldStateAlwaysUpFrame:SetPoint("TOP", UIParent, "TOP", -15, T.Scale(-35))


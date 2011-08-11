local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

local sbWidth = C.actionbar.sidebarWidth
local mbWidth = C.actionbar.mainbarWidth

local TukuiBar1 = CreateFrame("Frame", "TukuiBar1", UIParent, "SecureHandlerStateTemplate")
TukuiBar1:CreatePanel("Invisible", 1, 1, "BOTTOM", UIParent, "BOTTOM", 0, 30) --35
TukuiBar1:SetWidth((T.buttonsize * mbWidth) + (T.buttonspacing * (mbWidth-1)))
TukuiBar1:SetHeight((T.buttonsize * 2) + (T.buttonspacing))
TukuiBar1:SetFrameStrata("BACKGROUND")
TukuiBar1:SetFrameLevel(1)
TukuiBar1:SetBackdrop(nil)

local TukuiBar2 = CreateFrame("Frame", "TukuiBar2", UIParent)
TukuiBar2:CreatePanel("Invisible", 1, 1, "BOTTOMRIGHT", TukuiBar1, "BOTTOMLEFT", -5, 0)
TukuiBar2:SetWidth((T.buttonsize * sbWidth) + (T.buttonspacing * (sbWidth-1)))
TukuiBar2:SetHeight((T.buttonsize * 2) + (T.buttonspacing))
TukuiBar2:SetFrameStrata("BACKGROUND")
TukuiBar2:SetFrameLevel(2)
TukuiBar2:SetBackdrop(nil)
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
TukuiBar3:SetBackdrop(nil)
if T.lowversion then
	TukuiBar3:SetAlpha(0)
else
	TukuiBar3:SetAlpha(1)
end

local TukuiBar4 = CreateFrame("Frame", "TukuiBar4", UIParent)
TukuiBar4:CreatePanel("Invisible", 1, 1, "BOTTOM", UIParent, "BOTTOM", 0, 30)
TukuiBar4:SetWidth((T.buttonsize * mbWidth) + (T.buttonspacing * (mbWidth-1)))
TukuiBar4:SetHeight((T.buttonsize * 2) + (T.buttonspacing))
TukuiBar4:SetFrameStrata("BACKGROUND")
TukuiBar4:SetFrameLevel(2)
TukuiBar4:SetAlpha(0)
TukuiBar4:SetBackdrop(nil)


local TukuiBar5 = CreateFrame("Frame", "TukuiBar5", UIParent)
TukuiBar5:CreatePanel("Invisible", (T.buttonsize * 12) + (T.buttonspacing * 11), T.buttonsize, "BOTTOM", TukuiChatBackgroundRight, "TOP", 0, 4)
TukuiBar5:SetFrameStrata("BACKGROUND")
TukuiBar5:SetFrameLevel(2)
TukuiBar5:SetAlpha(0)
TukuiBar5:SetBackdrop(nil)

local TukuiBar6 = CreateFrame("Frame", "TukuiBar6", UIParent)
TukuiBar6:SetWidth((T.buttonsize) + (T.buttonspacing * 2))
TukuiBar6:SetHeight((T.buttonsize * 12) + (T.buttonspacing * 11))
TukuiBar6:SetPoint("LEFT", TukuiBar5, "LEFT", 0, 0)
TukuiBar6:SetFrameStrata("BACKGROUND")
TukuiBar6:SetFrameLevel(2)
TukuiBar6:SetAlpha(0)
TukuiBar6:SetBackdrop(nil)

local TukuiBar7 = CreateFrame("Frame", "TukuiBar7", UIParent)
TukuiBar7:SetWidth((T.buttonsize) + (T.buttonspacing * 2))
TukuiBar7:SetHeight((T.buttonsize * 12) + (T.buttonspacing * 11))
TukuiBar7:SetPoint("TOP", TukuiBar5, "TOP", 0 , 0)
TukuiBar7:SetFrameStrata("BACKGROUND")
TukuiBar7:SetFrameLevel(2)
TukuiBar7:SetAlpha(0)
TukuiBar7:SetBackdrop(nil)

local petbg = CreateFrame("Frame", "TukuiPetBar", UIParent, "SecureHandlerStateTemplate")
petbg:CreatePanel("Invisible", (T.petbuttonsize * 10) + (T.petbuttonspacing * 9), T.petbuttonsize, "BOTTOM", TukuiBar5, "TOP", 0, 5)
petbg:SetBackdrop(nil)

local ltpetbg1 = CreateFrame("Frame", "TukuiLineToPetActionBarBackground", petbg)
ltpetbg1:CreatePanel("Invisible", 24, 265, "LEFT", petbg, "RIGHT", 0, 0)
ltpetbg1:SetParent(petbg)
ltpetbg1:SetFrameStrata("BACKGROUND")
ltpetbg1:SetFrameLevel(0)
ltpetbg1:SetAlpha(0)

if C.actionbar.bgPanel then
	for i = 1, 5 do
		_G["TukuiBar"..i]:SetTemplate("Default")
		_G["TukuiBar"..i]:CreateBorder(false, true)
		_G["TukuiBar"..i]:SetBackdropColor(0,0,0,1)
	end
	petbg:SetTemplate("Default")
	petbg:CreateBorder(false, true)
	petbg:SetBackdropColor(0,0,0,1)
	petbg:SetWidth((T.petbuttonsize * 10) + (T.petbuttonspacing * 11))
	petbg:SetHeight(T.petbuttonsize + (T.petbuttonspacing * 2))
	
	TukuiBar1:SetWidth((T.buttonsize * mbWidth) + (T.buttonspacing * (mbWidth+1)))
	TukuiBar1:SetHeight((T.buttonsize * 2) + (T.buttonspacing*3))
	TukuiBar1:CreateBorder(false, true)
	
	TukuiBar2:SetWidth((T.buttonsize * sbWidth) + (T.buttonspacing * (sbWidth+1)))
	TukuiBar2:SetHeight((T.buttonsize * 2) + (T.buttonspacing*3))
	TukuiBar2:CreateBorder(false, true)
	
	TukuiBar3:SetWidth((T.buttonsize * sbWidth) + (T.buttonspacing * (sbWidth+1)))
	TukuiBar3:SetHeight((T.buttonsize * 2) + (T.buttonspacing*3))
	TukuiBar3:CreateBorder(false, true)
	
	TukuiBar4:SetWidth((T.buttonsize * mbWidth) + (T.buttonspacing * (mbWidth+1)))
	TukuiBar4:SetHeight((T.buttonsize * 2) + (T.buttonspacing*3))
	TukuiBar4:CreateBorder(false, true)
	
	TukuiBar5:SetWidth((T.buttonsize * 12) + (T.buttonspacing * 13))
	TukuiBar5:SetHeight((T.buttonsize) + (T.buttonspacing*2))
	TukuiBar5:CreateBorder(false, true)
	
	TukuiBar6:SetWidth((T.buttonsize) + (T.buttonspacing * 2))
	TukuiBar6:SetHeight((T.buttonsize * 12) + (T.buttonspacing * 13))
	TukuiBar6:CreateBorder(false, true)
	
	TukuiBar7:SetWidth((T.buttonsize) + (T.buttonspacing * 2))
	TukuiBar7:SetHeight((T.buttonsize * 12) + (T.buttonspacing * 13))
	TukuiBar7:CreateBorder(false, true)
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
			ToggleAllBags()
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

-- Alpha horizontal lines because all panels is dependent on this frame.
ltoabl:SetAlpha(0)
ltoabr:SetAlpha(0)

-- CHAT BG LEFT
local chatleftbg = CreateFrame("Frame", "TukuiChatBackgroundLeft", UIParent)
chatleftbg:CreatePanel("Transparent", T.InfoLeftRightWidth + 12, 160, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 10, 10)
chatleftbg:CreateBorder(true, false)

local linfolinebot = CreateFrame("Frame", "TukuiLeftInfoLineBot", TukuiChatBackgroundLeft)
linfolinebot:CreatePanel("Default", chatleftbg:GetWidth() - 16, 2, "BOTTOMLEFT", chatleftbg, "BOTTOMLEFT", 8, 20)

local linfolinetop = CreateFrame("Frame", "TukuiLeftInfoLineTop", TukuiChatBackgroundLeft)
linfolinetop:CreatePanel("Default", chatleftbg:GetWidth() - 16, 2, "TOPLEFT", chatleftbg, "TOPLEFT", 8, -20)	

-- CHAT BG RIGHT
local chatrightbg = CreateFrame("Frame", "TukuiChatBackgroundRight", UIParent)
chatrightbg:CreatePanel("Transparent", T.InfoLeftRightWidth + 12, 160, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -10, 10)
chatrightbg:CreateBorder(true, false)

local rinfolinebot = CreateFrame("Frame", "TukuiRightInfoLineBot", TukuiChatBackgroundRight)
rinfolinebot:CreatePanel("Default", chatrightbg:GetWidth() - 16, 2, "BOTTOMLEFT", chatrightbg, "BOTTOMLEFT", 8, 20)

local rinfolinetop = CreateFrame("Frame", "TukuiRightInfoLineTop", TukuiChatBackgroundRight)
rinfolinetop:CreatePanel("Default", chatrightbg:GetWidth() - 16, 2, "TOPLEFT", chatrightbg, "TOPLEFT", 8, -20)	

local elapsed = 0
TukuiBar5:SetScript("OnUpdate",function(self, u)
if InCombatLockdown() then return end
	elapsed = elapsed + u
	if elapsed > .5 then -- 2 seconds
		TukuiBar5:ClearAllPoints()
		if TukuiChatBackgroundRight:IsVisible() then
		TukuiBar5:SetPoint("BOTTOM", TukuiChatBackgroundRight, "TOP", 0, 4)
		elseif not C["Addon_Skins"].embedright == "None" then
		TukuiBar5:SetPoint("BOTTOM", TukuiChatBackgroundRight, "TOP", 0, 4)
		else
		TukuiBar5:SetPoint("BOTTOMRIGHT", TukuiChatBackgroundRight, "BOTTOMRIGHT", 0, 22)
		elapsed = 0
	end
	end
end)

local elapsed = 0
TukuiPetBar:SetScript("OnUpdate",function(self, u)
if InCombatLockdown() then return end
	elapsed = elapsed + u
	if elapsed > .5 then -- 2 seconds
		TukuiPetBar:ClearAllPoints()
		if TukuiBar5:IsVisible() then
		TukuiPetBar:Point("BOTTOM", TukuiBar5, "TOP", 0, 3)
		elseif not TukuiBar5:IsVisible() and TukuiChatBackgroundRight:IsVisible() then
		TukuiPetBar:SetPoint("BOTTOM", TukuiChatBackgroundRight, "TOP", 0, 4)
		else
		TukuiPetBar:SetPoint("BOTTOMRIGHT", TukuiChatBackgroundRight, "BOTTOMRIGHT", 0, 22)
	end
		elapsed = 0
	end
end)

--BATTLEGROUND STATS FRAME
if C["datatext"].battleground == true then
	local bgframe = CreateFrame("Frame", "TukuiInfoLeftBattleGround", UIParent)
	bgframe:CreatePanel("Default", TukuiChatBackgroundLeft:GetWidth(), 17, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 10, 10)
	bgframe:SetFrameStrata("MEDIUM")
	bgframe:SetFrameLevel(0)
	bgframe:EnableMouse(true)
end


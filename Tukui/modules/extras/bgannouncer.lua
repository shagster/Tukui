local T, C, L = unpack(select(2, ...)) 
-----------------------------------------------
--	Battleground Defence Announcer, By Azmara 
-----------------------------------------------
if not C["datatext"].bgannouncer then return end

local color = RAID_CLASS_COLORS[T.myclass]
local Text = TukuiChatBackgroundLeft:CreateFontString(nil, "OVERLAY")
Text:SetFont(C.media.pixelfont, C["datatext"].fontsize, "MONOCHROMEOUTLINE")

local curmapid = GetCurrentMapAreaID()
	
-- Create Main Button Frame
local buttonframe = CreateFrame("Frame", "BGAnnouncerButtonFrame", UIParent)
buttonframe:Size(TukuiChatBackgroundRight:GetWidth(), 17)
--buttonframe:SetAllPoints()
buttonframe:SetFrameStrata("MEDIUM")
buttonframe:SetFrameLevel(0)
buttonframe:EnableMouse(true)
buttonframe:SetTemplate("Default")
buttonframe:Point("BOTTOMLEFT", TukuiChatBackgroundRight, "BOTTOMLEFT", 0, 0)

-- Button 1
local button1 = CreateFrame("Button", "BGAnnouncerButton1", buttonframe, "SecureActionButtonTemplate")
button1:CreatePanel("pron", (TukuiChatBackgroundRight:GetWidth()-12)/6, 17, "BOTTOMLEFT", buttonframe, "BOTTOMLEFT", 0,0)
button1:SetFrameLevel(buttonframe:GetFrameLevel() + 1)
button1:SetFrameStrata("MEDIUM")
button1:SetAttribute("type", "macro")
button1:SetAttribute("macrotext", "/bg Light attack incoming to "..GetMinimapZoneText())

local button1_text = button1:CreateFontString(nil,"Overlay")
button1_text:SetFont(C.media.pixelfont, C["datatext"].fontsize, "MONOCHROMEOUTLINE")
button1_text:Point("Center",1,1)
button1_text:SetText(T.StatColor.."Low")
T.ApplyHover(button1)
	
--Button 2
local button2 = CreateFrame("Button", "BGAnnouncerButton2", buttonframe, "SecureActionButtonTemplate")
button2:CreatePanel("pron", (TukuiChatBackgroundRight:GetWidth()-12)/6, 17, "LEFT", button1, "RIGHT", 2,0)
button2:SetFrameLevel(buttonframe:GetFrameLevel() + 1)
button2:SetFrameStrata("MEDIUM")
button2:SetAttribute("type", "macro")
button2:SetAttribute("macrotext", "/bg Medium attack Incoming to "..GetMinimapZoneText())
	
local button2_text = button2:CreateFontString(nil,"Overlay")
button2_text:SetFont(C.media.pixelfont, C["datatext"].fontsize, "MONOCHROMEOUTLINE")
button2_text:Point("Center",1,1)
button2_text:SetText(T.StatColor.."Med")
T.ApplyHover(button2)
	
-- Button 3
local button3 = CreateFrame("Button", "BGAnnouncerButton3", buttonframe, "SecureActionButtonTemplate")
button3:CreatePanel("pron", (TukuiChatBackgroundRight:GetWidth()-12)/6, 17,"LEFT", button2, "RIGHT", 2,0)
button3:SetFrameLevel(buttonframe:GetFrameLevel() + 1)
button3:SetFrameStrata("MEDIUM")
button3:SetAttribute("type", "macro")
button3:SetAttribute("macrotext", "/bg Heavy Incoming to "..GetMinimapZoneText())
	
local button3_text = button3:CreateFontString(nil,"Overlay")
button3_text:SetFont(C.media.pixelfont, C["datatext"].fontsize, "MONOCHROMEOUTLINE")
button3_text:Point("Center",1,1)
button3_text:SetText(T.StatColor.."High")
T.ApplyHover(button3)
	
-- Button 4
local button4 = CreateFrame("Button", "BGAnnouncerButton4", buttonframe, "SecureActionButtonTemplate")
button4:CreatePanel("pron", (TukuiChatBackgroundRight:GetWidth()-12)/6, 17, "LEFT", button3, "RIGHT", 2,0)
button4:SetFrameLevel(buttonframe:GetFrameLevel() + 1)
button4:SetFrameStrata("MEDIUM")
button4:SetAttribute("type", "macro")
button4:SetAttribute("macrotext", "/bg All Secure at "..GetMinimapZoneText())
	
local button4_text = button4:CreateFontString(nil,"Overlay")
button4_text:SetFont(C.media.pixelfont, C["datatext"].fontsize, "MONOCHROMEOUTLINE")
button4_text:Point("Center",1,1)
button4_text:SetText(T.StatColor.."Secure")
T.ApplyHover(button4)

-- Button 5
local button5 = CreateFrame("Button", "BGAnnouncerButton5", buttonframe, "SecureActionButtonTemplate")
button5:CreatePanel("pron", (TukuiChatBackgroundRight:GetWidth()-12)/6, 17, "LEFT", button4, "RIGHT", 2,0)
button5:SetFrameLevel(buttonframe:GetFrameLevel() + 1)
button5:SetFrameStrata("MEDIUM")
button5:SetAttribute("type", "macro")
button5:SetAttribute("macrotext", "/say Focus Damage on %t")
	
local button5_text = button5:CreateFontString(nil,"Overlay")
button5_text:SetFont(C.media.pixelfont, C["datatext"].fontsize, "MONOCHROMEOUTLINE")
button5_text:Point("Center",1,1)
button5_text:SetText(T.StatColor.."Focus")
T.ApplyHover(button5)
	
-- Button 6
local button6 = CreateFrame("Button", "BGAnnouncerButton5", buttonframe, "SecureActionButtonTemplate")
button6:CreatePanel("pron", (TukuiChatBackgroundRight:GetWidth()-12)/6, 17, "LEFT", button5, "RIGHT", 2,0)
button6:SetFrameLevel(buttonframe:GetFrameLevel() + 1)
button6:SetFrameStrata("MEDIUM")
button6:SetAttribute("type", "macro")
button6:SetAttribute("macrotext", "/say Stealthed Enemies Nearby")

local button6_text = button6:CreateFontString(nil,"Overlay")
button6_text:SetFont(C.media.pixelfont, C["datatext"].fontsize, "MONOCHROMEOUTLINE")
button6_text:Point("Center",1,1)
button6_text:SetText(T.StatColor.."Hidden")
T.ApplyHover(button6)

local Stat = CreateFrame("Frame")
Stat:EnableMouse(true)

local UpdateZone = CreateFrame("Frame")
UpdateZone:RegisterEvent("ZONE_CHANGED")
UpdateZone:RegisterEvent("ZONE_CHANGED_NEW_AREA")
UpdateZone:RegisterEvent("PLAYER_ENTERING_WORLD")
UpdateZone:SetScript("OnEvent", OnEvent)
UpdateZone:SetScript("OnUpdate", Update)
UpdateZone:SetScript("OnEvent", function()
	button1:SetAttribute("macrotext", "/bg Light attack incoming to "..GetMinimapZoneText())
	button2:SetAttribute("macrotext", "/bg Medium attack Incoming to "..GetMinimapZoneText())
	button3:SetAttribute("macrotext", "/bg Heavy Incoming to "..GetMinimapZoneText())
	button4:SetAttribute("macrotext", "/bg All Secure at "..GetMinimapZoneText())
end)

--hide text when not in an bg
local function OnEvent(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		local inInstance, instanceType = IsInInstance()
		if inInstance and (instanceType == "pvp") then
			buttonframe:Show()
		else
			buttonframe:Hide()
		end
	end
end

Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
Stat:SetScript("OnEvent", OnEvent)
Stat:SetScript("OnUpdate", Update)



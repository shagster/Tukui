local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
--------------------------------------------------------------------
-- Tukui Minimap Script
--------------------------------------------------------------------

local TukuiMinimap = CreateFrame("Frame", "TukuiMinimap", UIParent)
TukuiMinimap:CreatePanel("Default", 1, 1, "CENTER", UIParent, "CENTER", 0, 0)
TukuiMinimap:RegisterEvent("ADDON_LOADED")
TukuiMinimap:RegisterEvent("CALENDAR_UPDATE_PENDING_INVITES")
TukuiMinimap:RegisterEvent("UPDATE_PENDING_MAIL")
TukuiMinimap:RegisterEvent("PLAYER_ENTERING_WORLD")
TukuiMinimap:Point("TOPRIGHT", UIParent, "TOPRIGHT", -10, -10)
TukuiMinimap:Size(154)
TukuiMinimap:SetClampedToScreen(true)
--TukuiMinimap:CreateShadow("Default")
TukuiMinimap:SetMovable(true)
TukuiMinimap.text = T.SetFontString(TukuiMinimap, C.media.pixelfont, 10)
TukuiMinimap.text:SetPoint("CENTER")
TukuiMinimap.text:SetText(L.move_minimap)

-- kill the minimap cluster
MinimapCluster:Kill()

-- Parent Minimap into our Map frame.
Minimap:SetParent(TukuiMinimap)
Minimap:ClearAllPoints()
Minimap:Point("TOPLEFT", 2, -2)
Minimap:Point("BOTTOMRIGHT", -2, 2)
Minimap:Size(154)

-- Hide Border
MinimapBorder:Hide()
MinimapBorderTop:Hide()

-- Hide Zoom Buttons
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()

-- Hide Voice Chat Frame
MiniMapVoiceChatFrame:Hide()

-- Hide North texture at top
MinimapNorthTag:SetTexture(nil)

-- Hide Zone Frame
MinimapZoneTextButton:Hide()

-- Hide Tracking Button
MiniMapTracking:Hide()

-- Hide Calendar Button
GameTimeFrame:Hide()

-- Hide Mail Button
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:Point("TOPRIGHT", Minimap, 3, 3)
MiniMapMailBorder:Hide()
MiniMapMailIcon:SetTexture("Interface\\AddOns\\Tukui\\medias\\textures\\mail")

-- Move battleground icon
MiniMapBattlefieldFrame:ClearAllPoints()
MiniMapBattlefieldFrame:Point("BOTTOMRIGHT", Minimap, 3, 0)
MiniMapBattlefieldBorder:Hide()

-- Hide world map button
MiniMapWorldMapButton:Hide()

-- shitty 3.3 flag to move
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetParent(Minimap)
MiniMapInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)

-- 4.0.6 Guild instance difficulty
GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetParent(Minimap)
GuildInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)

-- Reposition lfg icon at bottom-left
local function UpdateLFG()
	MiniMapLFGFrame:ClearAllPoints()
	MiniMapLFGFrame:Point("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 2, 1)
	MiniMapLFGFrameBorder:Hide()
end
hooksecurefunc("MiniMapLFG_UpdateIsShown", UpdateLFG)

-- reskin LFG dropdown
LFDSearchStatus:SetTemplate("Default")

-- for t13+, if we move map we need to point LFDSearchStatus according to our Minimap position.
local function UpdateLFGTooltip()
	local position = TukuiMinimap:GetPoint()
	LFDSearchStatus:ClearAllPoints()
	if position:match("BOTTOMRIGHT") then
		LFDSearchStatus:SetPoint("BOTTOMRIGHT", MiniMapLFGFrame, "BOTTOMLEFT", 0, 0)
	elseif position:match("BOTTOM") then
		LFDSearchStatus:SetPoint("BOTTOMLEFT", MiniMapLFGFrame, "BOTTOMRIGHT", 4, 0)
	elseif position:match("LEFT") then		
		LFDSearchStatus:SetPoint("TOPLEFT", MiniMapLFGFrame, "TOPRIGHT", 4, 0)
	else
		LFDSearchStatus:SetPoint("TOPRIGHT", MiniMapLFGFrame, "TOPLEFT", 0, 0)	
	end
end

-- Enable mouse scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)

-- Set Square Map Mask
Minimap:SetMaskTexture(C.media.blank)

-- For others mods with a minimap button, set minimap buttons position in square mode.
function GetMinimapShape() return "SQUARE" end

-- do some stuff on addon loaded or player login event
TukuiMinimap:SetScript("OnEvent", function(self, event, addon)
	if event == "PLAYER_LOGIN" then
		UpdateLFGTooltip()
	elseif addon == "Blizzard_TimeManager" then
		-- Hide Game Time
		TimeManagerClockButton:Kill()
	else
		local inv = CalendarGetNumPendingInvites()
		local mail = HasNewMail()
		if inv > 0 and mail then -- New invites and mail
			TukuiMinimap:SetBackdropBorderColor(1, .5, 0)
			if TukuiMinimapStatsLeft then
				TukuiMinimapStatsLeft:SetBackdropBorderColor(1, .5, 0)
			end
			if TukuiMinimapStatsRight then
				TukuiMinimapStatsRight:SetBackdropBorderColor(1, .5, 0)
			end
		elseif inv > 0 and not mail then -- New invites and no mail
			TukuiMinimap:SetBackdropBorderColor(1, 30/255, 60/255)
			if TukuiMinimapStatsLeft then
				TukuiMinimapStatsLeft:SetBackdropBorderColor(1, 30/255, 60/255)
			end
			if TukuiMinimapStatsRight then
				TukuiMinimapStatsRight:SetBackdropBorderColor(1, 30/255, 60/255)
			end
		elseif inv==0 and mail then -- No invites and new mail
			TukuiMinimap:SetBackdropBorderColor(0, 1, 0)
			if TukuiMinimapStatsLeft then
				TukuiMinimapStatsLeft:SetBackdropBorderColor(0, 1, 0)
			end
			if TukuiMinimapStatsRight then
				TukuiMinimapStatsRight:SetBackdropBorderColor(0, 1, 0)
			end
		else -- None of the above
			TukuiMinimap:SetBackdropBorderColor(unpack(C.media.bordercolor))
			if TukuiMinimapStatsLeft then
				TukuiMinimapStatsLeft:SetBackdropBorderColor(unpack(C.media.bordercolor))
			end
			if TukuiMinimapStatsRight then
				TukuiMinimapStatsRight:SetBackdropBorderColor(unpack(C.media.bordercolor))
			end
		end
	end
end)

----------------------------------------------------------------------------------------
-- Right click menu, used to show micro menu
----------------------------------------------------------------------------------------

local menuFrame = CreateFrame("Frame", "TukuiMinimapMiddleClickMenu", TukuiMinimap, "UIDropDownMenuTemplate")
local menuList = {
	{text = CHARACTER_BUTTON,
	func = function() ToggleCharacter("PaperDollFrame") end},
	{text = SPELLBOOK_ABILITIES_BUTTON,
	func = function() ToggleFrame(SpellBookFrame) end},
	{text = TALENTS_BUTTON,
	func = function() 
		if not PlayerTalentFrame then 
			LoadAddOn("Blizzard_TalentUI") 
		end 

		if not GlyphFrame then 
			LoadAddOn("Blizzard_GlyphUI") 
		end 
		PlayerTalentFrame_Toggle() 
	end},
	{text = ACHIEVEMENT_BUTTON,
	func = function() ToggleAchievementFrame() end},
	{text = QUESTLOG_BUTTON,
	func = function() ToggleFrame(QuestLogFrame) end},
	{text = SOCIAL_BUTTON,
	func = function() ToggleFriendsFrame(1) end},
	{text = PLAYER_V_PLAYER,
	func = function() ToggleFrame(PVPFrame) end},
	{text = ACHIEVEMENTS_GUILD_TAB,
	func = function() 
		if IsInGuild() then 
			if not GuildFrame then LoadAddOn("Blizzard_GuildUI") end 
			GuildFrame_Toggle() 
		else 
			if not LookingForGuildFrame then LoadAddOn("Blizzard_LookingForGuildUI") end 
			LookingForGuildFrame_Toggle() 
		end
	end},
	{text = LFG_TITLE,
	func = function() ToggleFrame(LFDParentFrame) end},
	{text = LOOKING_FOR_RAID,
	func = function() ToggleFrame(LFRParentFrame) end},
	{text = HELP_BUTTON,
	func = function() ToggleHelpFrame() end},
	{text = CALENDAR_VIEW_EVENT,
	func = function()
	if(not CalendarFrame) then LoadAddOn("Blizzard_Calendar") end
		Calendar_Toggle()
	end},
}

Minimap:SetScript("OnMouseUp", function(self, btn)
	local position = TukuiMinimap:GetPoint()
	if btn == "RightButton" then
		local xoff = 0
		
		if position:match("RIGHT") then xoff = T.Scale(-16) end
		ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, TukuiMinimap, xoff, T.Scale(-2))
	elseif btn == "MiddleButton" then
		if position:match("LEFT") then
			EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
		else
			EasyMenu(menuList, menuFrame, "cursor", -160, 0, "MENU", 2)
		end
	else
		Minimap_OnClick(self)
	end
end)



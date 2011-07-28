local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
-- World Frame 
local anchor = CreateFrame("Frame", "TukuiWorldStateFrameAnchor", UIParent)
anchor:Size(170, 20)
anchor:SetFrameStrata("TOOLTIP")
anchor:SetFrameLevel(20)
anchor:SetClampedToScreen(true)
anchor:SetAlpha(0)
anchor:SetPoint("TOP", UIParent, "TOP", -15, -35)
anchor:SetTemplate("Default")
anchor:SetBackdropBorderColor(1, 0, 0, 1)
anchor:SetMovable(true)
anchor.text = T.SetFontString(anchor, C.media.pixelfont, 10)
anchor.text:SetPoint("CENTER")
anchor.text:SetText(L.move_worldstateframe)

WorldStateAlwaysUpFrame:SetFrameStrata("BACKGROUND")
WorldStateAlwaysUpFrame:SetFrameLevel(0)
WorldStateAlwaysUpFrame:ClearAllPoints()
WorldStateAlwaysUpFrame:SetScale(1)
WorldStateAlwaysUpFrame:SetPoint("TOP", TukuiWorldStateFrameAnchor, "TOP", 0, 0)

-- reposition capture bar to top/center of the screen
local function CaptureUpdate()
	if NUM_EXTENDED_UI_FRAMES then
		local captureBar
		for i=1, NUM_EXTENDED_UI_FRAMES do
			captureBar = getglobal("WorldStateCaptureBar" .. i)

			if captureBar and captureBar:IsVisible() then
				captureBar:ClearAllPoints()
				
				if( i == 1 ) then
					captureBar:Point("TOP", WorldStateAlwaysUpFrame, "BOTTOM", 0, -40)
				else
					captureBar:Point("TOPLEFT", getglobal("WorldStateCaptureBar" .. i - 1 ), "TOPLEFT", 0, -25)
				end
			end	
		end	
	end
end
hooksecurefunc("UIParent_ManageFramePositions", CaptureUpdate)
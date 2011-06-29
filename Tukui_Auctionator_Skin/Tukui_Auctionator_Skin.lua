-- Damn edits compatbility by Affli
local UI
if ElvUI then UI=ElvUI else UI=Tukui end
local T, C, L = unpack(UI)

-- Functions needed to make this work
local function SetModifiedBackdrop(self)
	local color = RAID_CLASS_COLORS[T.myclass]
	self:SetBackdropColor(color.r, color.g, color.b, 0.15)
	self:SetBackdropBorderColor(color.r, color.g, color.b)
end

local function SetOriginalBackdrop(self)
	local color = RAID_CLASS_COLORS[T.myclass]
	if C["general"].classcolortheme == true then
		self:SetBackdropBorderColor(color.r, color.g, color.b)
	else
		self:SetTemplate("Default")
	end
end

local function SkinButton(f, strip)
	if f:GetName() then
		local l = _G[f:GetName().."Left"]
		local m = _G[f:GetName().."Middle"]
		local r = _G[f:GetName().."Right"]


		if l then l:SetAlpha(0) end
		if m then m:SetAlpha(0) end
		if r then r:SetAlpha(0) end
	end

	if f.SetNormalTexture then f:SetNormalTexture("") end

	if f.SetHighlightTexture then f:SetHighlightTexture("") end

	if f.SetPushedTexture then f:SetPushedTexture("") end

	if f.SetDisabledTexture then f:SetDisabledTexture("") end

	if strip then f:StripTextures() end

	f:SetTemplate("Default", true)
	f:HookScript("OnEnter", SetModifiedBackdrop)
	f:HookScript("OnLeave", SetOriginalBackdrop)
end

local function SkinScrollBar(frame)
	if _G[frame:GetName().."BG"] then _G[frame:GetName().."BG"]:SetTexture(nil) end
	if _G[frame:GetName().."Track"] then _G[frame:GetName().."Track"]:SetTexture(nil) end

	if _G[frame:GetName().."Top"] then
		_G[frame:GetName().."Top"]:SetTexture(nil)
		_G[frame:GetName().."Bottom"]:SetTexture(nil)
		_G[frame:GetName().."Middle"]:SetTexture(nil)
	end
end

--Tab Regions
local tabs = {
	"LeftDisabled",
	"MiddleDisabled",
	"RightDisabled",
	"Left",
	"Middle",
	"Right",
}

local function SkinTab(tab)
	if not tab then return end
	for _, object in pairs(tabs) do
		local tex = _G[tab:GetName()..object]
		if tex then
			tex:SetTexture(nil)
		end
	end

	if tab.GetHighlightTexture and tab:GetHighlightTexture() then
		tab:GetHighlightTexture():SetTexture(nil)
	else
		tab:StripTextures()
	end

	tab.backdrop = CreateFrame("Frame", nil, tab)
	tab.backdrop:SetTemplate("Default")
	tab.backdrop:SetFrameLevel(tab:GetFrameLevel() - 1)
	tab.backdrop:Point("TOPLEFT", 10, -3)
	tab.backdrop:Point("BOTTOMRIGHT", -10, 3)				
end

local function SkinNextPrevButton(btn, horizonal)
	btn:SetTemplate("Default")
	btn:Size(btn:GetWidth() - 7, btn:GetHeight() - 7)	

	if horizonal then
		btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.72, 0.65, 0.29, 0.65, 0.72)
		btn:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.8, 0.65, 0.35, 0.65, 0.8)
		btn:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)	
	else
		btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.81, 0.65, 0.29, 0.65, 0.81)

		if btn:GetPushedTexture() then
			btn:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.81, 0.65, 0.35, 0.65, 0.81)
		end
		if btn:GetDisabledTexture() then
			btn:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)
		end
	end

	btn:GetNormalTexture():ClearAllPoints()
	btn:GetNormalTexture():Point("TOPLEFT", 2, -2)
	btn:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
	if btn:GetDisabledTexture() then
		btn:GetDisabledTexture():SetAllPoints(btn:GetNormalTexture())
	end

	if btn:GetPushedTexture() then
		btn:GetPushedTexture():SetAllPoints(btn:GetNormalTexture())
	end

	btn:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)
	btn:GetHighlightTexture():SetAllPoints(btn:GetNormalTexture())
end

local function SkinRotateButton(btn)
	btn:SetTemplate("Default")
	btn:Size(btn:GetWidth() - 14, btn:GetHeight() - 14)	

	btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.65, 0.69, 0.29, 0.69, 0.65)
	btn:GetPushedTexture():SetTexCoord(0.3, 0.29, 0.3, 0.65, 0.69, 0.29, 0.69, 0.65)	

	btn:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)

	btn:GetNormalTexture():ClearAllPoints()
	btn:GetNormalTexture():Point("TOPLEFT", 2, -2)
	btn:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
	btn:GetPushedTexture():SetAllPoints(btn:GetNormalTexture())	
	btn:GetHighlightTexture():SetAllPoints(btn:GetNormalTexture())
end

local function SkinEditBox(frame)
	if _G[frame:GetName().."Left"] then _G[frame:GetName().."Left"]:Kill() end
	if _G[frame:GetName().."Middle"] then _G[frame:GetName().."Middle"]:Kill() end
	if _G[frame:GetName().."Right"] then _G[frame:GetName().."Right"]:Kill() end
	if _G[frame:GetName().."Mid"] then _G[frame:GetName().."Mid"]:Kill() end
	frame:CreateBackdrop("Default")

	if frame:GetName() and frame:GetName():find("Silver") or frame:GetName():find("Copper") then
		frame.backdrop:Point("BOTTOMRIGHT", -12, -2)
	end
end

local function SkinDropDownBox(frame, width)
	local button = _G[frame:GetName().."Button"]
	if not width then width = 155 end

	frame:StripTextures()
	frame:Width(width)

	_G[frame:GetName().."Text"]:ClearAllPoints()
	_G[frame:GetName().."Text"]:Point("RIGHT", button, "LEFT", -2, 0)


	button:ClearAllPoints()
	button:Point("RIGHT", frame, "RIGHT", -10, 3)
	button.SetPoint = T.dummy

	SkinNextPrevButton(button, true)

	frame:CreateBackdrop("Default")
	frame.backdrop:Point("TOPLEFT", 20, -2)
	frame.backdrop:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
end

local function SkinCheckBox(frame)
	frame:StripTextures()
	frame:CreateBackdrop("Default")
	frame.backdrop:Point("TOPLEFT", 4, -4)
	frame.backdrop:Point("BOTTOMRIGHT", -4, 4)

	if frame.SetCheckedTexture then
		frame:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
	end

	if frame.SetDisabledTexture then
		frame:SetDisabledTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
	end

	frame.SetNormalTexture = T.dummy
	frame.SetPushedTexture = T.dummy
	frame.SetHighlightTexture = T.dummy
end

local function SkinCloseButton(f, point)
	for i=1, f:GetNumRegions() do
		local region = select(i, f:GetRegions())
		if region:GetObjectType() == "Texture" then
			region:SetDesaturated(1)

			if region:GetTexture() == "Interface\\DialogFrame\\UI-DialogBox-Corner" then
				region:Kill()
			end
		end
	end	

	if point then
		f:Point("TOPRIGHT", point, "TOPRIGHT", 2, 2)
	end
end

--Skinning Auctionator

local JasjeAuction = CreateFrame("Frame")
JasjeAuction:RegisterEvent("ADDON_LOADED")
JasjeAuction:SetScript("OnEvent", function(self, event, addon)
if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") then return end
if not IsAddOnLoaded("Auctionator") then return end

	if addon == "Blizzard_AuctionUI" then
		SkinDropDownBox(Atr_Duration)
		SkinDropDownBox(Atr_DropDownSL)

		SkinButton(Atr_Search_Button, true)
		SkinButton(Atr_Back_Button, true)
		SkinButton(Atr_Buy1_Button, true)
		SkinButton(Atr_Adv_Search_Button, true)
		SkinButton(Atr_FullScanButton, true)
		SkinButton(Auctionator1Button, true)
		SkinButton(Atr_ListTabsTab1, true)
		SkinButton(Atr_ListTabsTab2, true)
		SkinButton(Atr_ListTabsTab3, true)
		SkinButton(Atr_CreateAuctionButton, true)
		SkinButton(Atr_RemFromSListButton, true)
		SkinButton(Atr_AddToSListButton, true)
		SkinButton(Atr_SrchSListButton, true)
		SkinButton(Atr_MngSListsButton, true)
		SkinButton(Atr_NewSListButton, true)
		SkinButton(Atr_CheckActiveButton, true)
		SkinButton(AuctionatorCloseButton, true)
		SkinButton(Atr_CancelSelectionButton, true)
		SkinButton(Atr_FullScanStartButton, true)
		SkinButton(Atr_FullScanDone, true)
		SkinButton(Atr_CheckActives_Yes_Button, true)
		SkinButton(Atr_CheckActives_No_Button, true)
		SkinButton(Atr_Adv_Search_ResetBut, true)
		SkinButton(Atr_Adv_Search_OKBut, true)
		SkinButton(Atr_Adv_Search_CancelBut, true)
		SkinButton(Atr_Buy_Confirm_OKBut, true)
		SkinButton(Atr_Buy_Confirm_CancelBut, true)
		SkinButton(Atr_SaveThisList_Button, true)
		SkinButton(Atr_RecommendItem_Tex, true)
		SkinButton(Atr_SellControls_Tex, true)

        SkinEditBox(Atr_StackPriceGold)
        SkinEditBox(Atr_StackPriceSilver)
        SkinEditBox(Atr_StackPriceCopper)
        SkinEditBox(Atr_ItemPriceGold)
        SkinEditBox(Atr_ItemPriceSilver)
        SkinEditBox(Atr_ItemPriceCopper)
        SkinEditBox(Atr_Batch_NumAuctions)
        SkinEditBox(Atr_Batch_Stacksize)
        SkinEditBox(Atr_Search_Box)
		SkinEditBox(Atr_AS_Searchtext)
		SkinEditBox(Atr_AS_Minlevel)
		SkinEditBox(Atr_AS_Maxlevel)
		SkinEditBox(Atr_AS_MinItemlevel)
        SkinEditBox(Atr_AS_MaxItemlevel)		

		Atr_FullScanResults:StripTextures()
		Atr_FullScanResults:SetTemplate("Transparent")
		Atr_Adv_Search_Dialog:StripTextures()
		Atr_Adv_Search_Dialog:SetTemplate("Transparent")
		Atr_FullScanFrame:StripTextures()
		Atr_FullScanFrame:SetTemplate("Transparent")
		Atr_HeadingsBar:StripTextures()
        Atr_HeadingsBar:SetTemplate("Default")
		Atr_HeadingsBar:Height(246)
		Atr_Error_Frame:StripTextures()		
		Atr_Error_Frame:SetTemplate("Transparent")
		Atr_Hlist:StripTextures()
        Atr_Hlist:SetTemplate("Default")
		Atr_Hlist:Width(196)
		Atr_Hlist:ClearAllPoints()
		Atr_Hlist:Point("TOPLEFT", -195, -75)
		Atr_Buy_Confirm_Frame:StripTextures()
		Atr_Buy_Confirm_Frame:SetTemplate("Default")
		Atr_CheckActives_Frame:StripTextures()
        Atr_CheckActives_Frame:SetTemplate("Default")
		
		-- resize some buttons to fit
		Atr_SrchSListButton:Width(196)
		Atr_MngSListsButton:Width(196)
		Atr_NewSListButton:Width(196)
		Atr_CheckActiveButton:Width(196)
		
		Atr_CreateAuctionButton:Width(165)
		Atr_CreateAuctionButton:ClearAllPoints()
		Atr_CreateAuctionButton:Point("CENTER", 14, -20)

		Atr_DropDownSL:Width(224)
		Atr_DropDownSL:ClearAllPoints()
		Atr_DropDownSL:Point("TOP", Atr_Hlist, -6, 25)

		Atr_Col1_Heading:ClearAllPoints()
		Atr_Col1_Heading:Point("TOPLEFT", Atr_HeadingsBar, 40, -32)
		
		Atr_Col3_Heading:ClearAllPoints()
		Atr_Col3_Heading:Point("RIGHT", Atr_Col1_Heading, 105, 1)
		
		Atr_Col4_Heading:ClearAllPoints()
		Atr_Col4_Heading:Point("RIGHT", Atr_Col3_Heading, 310, 0)		
		
		for i = 1, 6 do
			SkinTab(_G["AuctionFrameTab"..i])
		end
		
		-- Button Positions
		AuctionatorCloseButton:ClearAllPoints()
		AuctionatorCloseButton:Point("BOTTOMLEFT", Atr_Main_Panel, "BOTTOMRIGHT", -17, 10)
		Atr_Buy1_Button:Point("RIGHT", AuctionatorCloseButton, "LEFT", -5, 0)
		Atr_CancelSelectionButton:Point("RIGHT", Atr_Buy1_Button, "LEFT", -5, 0)
	end
	
	if addon == "Blizzard_TradeSkillUI" then
		SkinButton(Auctionator_Search, true)
	end
end)

    Atr_BasicOptionsFrame:StripTextures()
    Atr_BasicOptionsFrame:SetTemplate("Default")
    SkinCheckBox(AuctionatorOption_Enable_Alt_CB)
    SkinCheckBox(AuctionatorOption_Open_All_Bags_CB)
    SkinCheckBox(AuctionatorOption_Show_StartingPrice_CB)
    SkinCheckBox(Atr_RB_N)
    SkinCheckBox(Atr_RB_M)
    SkinCheckBox(Atr_RB_S)
    SkinCheckBox(Atr_RB_L)

    Atr_TooltipsOptionsFrame:StripTextures()
    Atr_TooltipsOptionsFrame:SetTemplate("Default")
    SkinCheckBox(ATR_tipsVendorOpt_CB)
    SkinCheckBox(ATR_tipsAuctionOpt_CB)
    SkinCheckBox(ATR_tipsDisenchantOpt_CB)

    Atr_UCConfigFrame:StripTextures()
    Atr_UCConfigFrame:SetTemplate("Default")
	SkinButton(Atr_UCConfigFrame_Reset)
	SkinEditBox(Atr_Starting_Discount)
	
	SkinEditBox(UC_5000000_MoneyInputGold)
	SkinEditBox(UC_5000000_MoneyInputSilver)
	SkinEditBox(UC_5000000_MoneyInputCopper)
	SkinEditBox(UC_1000000_MoneyInputGold)
	SkinEditBox(UC_1000000_MoneyInputSilver)
	SkinEditBox(UC_1000000_MoneyInputCopper)
	SkinEditBox(UC_200000_MoneyInputGold)
	SkinEditBox(UC_200000_MoneyInputSilver)
	SkinEditBox(UC_200000_MoneyInputCopper)
	SkinEditBox(UC_50000_MoneyInputGold)
	SkinEditBox(UC_50000_MoneyInputSilver)
	SkinEditBox(UC_50000_MoneyInputCopper)
	SkinEditBox(UC_10000_MoneyInputGold)
	SkinEditBox(UC_10000_MoneyInputSilver)
	SkinEditBox(UC_10000_MoneyInputCopper)
	SkinEditBox(UC_2000_MoneyInputGold)
	SkinEditBox(UC_2000_MoneyInputSilver)
	SkinEditBox(UC_2000_MoneyInputCopper)
	SkinEditBox(UC_500_MoneyInputGold)
	SkinEditBox(UC_500_MoneyInputSilver)
	SkinEditBox(UC_500_MoneyInputCopper)
	
    Atr_StackingOptionsFrame:StripTextures()
    Atr_StackingOptionsFrame:SetTemplate("Default")  
	Atr_Stacking_List:StripTextures()
    Atr_Stacking_List:SetTemplate("Default")
	
	SkinButton(Atr_StackingOptionsFrame_Edit)
	SkinButton(Atr_StackingOptionsFrame_New)
	
	Atr_ScanningOptionsFrame:StripTextures()
	Atr_ScanningOptionsFrame:SetTemplate("Default")  
	
	SkinCheckBox(Atr_ScanOpts_MaxHistAge)
	
    AuctionatorResetsFrame:StripTextures()
    AuctionatorResetsFrame:SetTemplate("Default") 

	Atr_ShpList_Options_Frame:StripTextures()
    Atr_ShpList_Options_Frame:SetTemplate("Default")	
	Atr_ShpList_Frame:StripTextures()
    Atr_ShpList_Frame:SetTemplate("Default")  
	
	SkinButton(Atr_ShpList_DeleteButton)
	SkinButton(Atr_ShpList_EditButton)
	SkinButton(Atr_ShpList_RenameButton)
	SkinButton(Atr_ShpList_ExportButton)
	SkinButton(Atr_ShpList_ImportButton) -- there are 2 buttons called like this, need to find a fix

	AuctionatorDescriptionFrame:StripTextures()
	AuctionatorDescriptionFrame:SetTemplate("Default")
	
	Atr_ShpList_Edit_Frame:StripTextures()
	Atr_ShpList_Edit_Frame:SetTemplate("Default")
	
	SkinButton(Atr_ShpList_ImportSaveBut)
	SkinButton(Atr_ShpList_SelectAllBut)
	SkinButton(Atr_ShpList_SaveBut)
	Atr_ShpList_Edit_FrameScrollFrameScrollBar:StripTextures()
	SkinScrollBar(Atr_ShpList_Edit_FrameScrollFrameScrollBar)
	
	SkinDropDownBox(AuctionatorOption_Deftab)
	SkinDropDownBox(Atr_tipsShiftDD)
	SkinDropDownBox(Atr_deDetailsDD)
	SkinDropDownBox(Atr_scanLevelDD)
	
	Atr_ConfirmClear_Frame:StripTextures()
	Atr_ConfirmClear_Frame:SetTemplate("Default")
	
	SkinButton(Atr_ClearConfirm_Cancel)
	
	Atr_MemorizeFrame:StripTextures()
	Atr_MemorizeFrame:SetTemplate("Default")
	
	SkinButton(Atr_Mem_Forget)
	SkinButton( Atr_Mem_Cancel)
	SkinDropDownBox(Atr_Mem_DD_numStacks)
	SkinCheckBox(Atr_Mem_EB_stackSize)
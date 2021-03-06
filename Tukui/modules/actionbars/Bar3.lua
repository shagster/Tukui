local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
if not C["actionbar"].enable == true then return end

---------------------------------------------------------------------------
-- setup MultiBarLeft as bar #3 
---------------------------------------------------------------------------

local bar = TukuiBar3
MultiBarBottomRight:SetParent(bar)

local sbWidth = C.actionbar.sidebarWidth

for i= 1, 12 do
	local b = _G["MultiBarBottomRightButton"..i]
	local b2 = _G["MultiBarBottomRightButton"..i-1]
	b:SetSize(T.buttonsize, T.buttonsize)
	b:ClearAllPoints()
	b:SetFrameStrata("BACKGROUND")
	b:SetFrameLevel(15)
	
	if i == 1 then
		b:SetPoint("BOTTOMLEFT", bar, T.buttonoffset,T.buttonoffset)
	elseif i == 7 then
		b:SetPoint("TOPLEFT", bar, T.buttonoffset,-T.buttonoffset)
	elseif (i > sbWidth and i < 7) or (i > (sbWidth+6))  then
		b:SetPoint("TOP", UIParent, "BOTTOM", 0, -20)
	else
		b:SetPoint("LEFT", b2, "RIGHT", T.buttonspacing, 0)
	end
end
local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
if C["tooltip"].enable ~= true then return end

GameTooltip:HookScript("OnTooltipCleared", function(self) self.TukuiItemTooltip=nil end)
GameTooltip:HookScript("OnTooltipSetItem", function(self)
	if (IsShiftKeyDown() or IsAltKeyDown()) and (TukuiItemTooltip and not self.TukuiItemTooltip and (TukuiItemTooltip.id or TukuiItemTooltip.count)) then
		local item, link = self:GetItem()
		local num = GetItemCount(link)
		local left = ""
		local right = ""
		
		if TukuiItemTooltip.id and link ~= nil then
			left = "|cFFCA3C3CID|r "..link:match(":(%w+)")
		end
		
		if TukuiItemTooltip.count and num > 1 then
			right = "|cFFCA3C3C"..L.tooltip_count.."|r "..num
		end

		self:AddLine(" ")
		self:AddDoubleLine(left, right)
		self.TukuiItemTooltip = 1
	end
end)

GameTooltip:HookScript("OnTooltipSetSpell", function(self)
	if (IsShiftKeyDown() or IsAltKeyDown()) and TukuiItemTooltip and not self.TukuiItemTooltip and (TukuiItemTooltip.spell) then
		local id = select(3, self:GetSpell())
				
		if id ~= nil then
			self:AddLine' '
			self:AddLine("|cffCA3C3CSpell ID|r "..id)
		end
							
		self.TukuiItemTooltip = 1
	end
end)

hooksecurefunc(GameTooltip, "SetUnitBuff", function(self, ...)
	if (IsShiftKeyDown() or IsAltKeyDown()) and TukuiItemTooltip and not self.TukuiItemTooltip and (TukuiItemTooltip.buff) then
		local name, _, _, _, _, _, _, _, _, _, id = UnitBuff(...) 
		
		if name ~= nil and id ~= nil then
			self:AddLine' ' 
			self:AddLine("|cff50e468Buff ID|r " .. id)
			self:Show()
		end
		
		print("|cff50e468Buff: |cff71d5ff|Hspell:"..id.."|h["..name.."]|h|r - " .. id)
	end
end)

hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self, ...)
	if (IsShiftKeyDown() or IsAltKeyDown()) and TukuiItemTooltip and not self.TukuiItemTooltip and (TukuiItemTooltip.debuff) then
		local name, _, _, _, _, _, _, _, _, _, id = UnitDebuff(...) 
		
		if name ~= nil and id ~= nil then
			self:AddLine' ' 
			self:AddLine("|cffe45050Debuff ID|r " .. id)
			self:Show()
		end
		
		print("|cffe45050Debuff: |cff71d5ff|Hspell:"..id.."|h["..name.."]|h|r - " .. id)
	end
end)

hooksecurefunc(GameTooltip, "SetUnitAura", function(self, ...)
	if (IsShiftKeyDown() or IsAltKeyDown()) and TukuiItemTooltip and not self.TukuiItemTooltip and (TukuiItemTooltip.aura) then
		local name, _, _, _, _, _, _, _, _, _, id = UnitAura(...) 

		if name ~= nil and id ~= nil then
			self:AddLine' ' 
			self:AddLine("|cff5065e4Aura ID|r " .. id)
			self:Show()
		end
		
		print("|cff5065e4Aura: |cff71d5ff|Hspell:"..id.."|h["..name.."]|h|r - " .. id)
	end
end)

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(_, _, name)
	if name ~= "Tukui" then return end
	f:UnregisterEvent("ADDON_LOADED")
	f:SetScript("OnEvent", nil)
	TukuiItemTooltip = TukuiItemTooltip or {count=true,id=true,spell=true,buff=true,debuff=true,aura=true}
end)
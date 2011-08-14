local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, "Tukui was unable to locate oUF install.")

ns._Objects = {}
ns._Headers = {}

local T, C, L = unpack(select(2, ...)) 
if not C["unitframes"].enable == true then return end
if C["unitframes"].style ~= "Shag" then return end

------------------------------------------------------------------------
--	local variables
------------------------------------------------------------------------

local font = C["media"].uffont
local font2 = C["media"].font
local normTex = C["media"].normTex
local glowTex = C["media"].glowTex
local bubbleTex = C["media"].bubbleTex
local blankTex = C["media"].blank
local empathTex = C["media"].empath2


local backdrop = {
	bgFile = C["media"].blank,
	insets = {top = -T.mult, left = -T.mult, bottom = -T.mult, right = -T.mult},
}

------------------------------------------------------------------------
--	Layout
------------------------------------------------------------------------

local function Shared(self, unit)
	-- set our own colors
	self.colors = T.oUF_colors
	
	-- register click
	self:RegisterForClicks("AnyUp")
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	
	self:SetFrameLevel(5)
	
	-- menu? lol
	self.menu = T.SpawnMenu

	-- this is the glow border
	self:CreateShadow("Default")
	
	self.shadow:Hide()
	
	------------------------------------------------------------------------
	--	Features we want for all units at the same time
	------------------------------------------------------------------------
	
	-- here we create an invisible frame for all element we want to show over health/power.
	local InvFrame = CreateFrame("Frame", nil, self)
	InvFrame:SetFrameStrata("HIGH")
	InvFrame:SetFrameLevel(5)
	InvFrame:SetAllPoints()
	
	-- symbols, now put the symbol on the frame we created above.
	local RaidIcon = InvFrame:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetTexture("Interface\\AddOns\\Tukui\\medias\\textures\\raidicons.blp") -- thx hankthetank for texture
	RaidIcon:SetHeight(20)
	RaidIcon:SetWidth(20)
	RaidIcon:SetPoint("TOP", 0, 11)
	self.RaidIcon = RaidIcon
	
	-- health
	local health = CreateFrame('StatusBar', nil, self)
	health:SetPoint("TOPLEFT")
	health:SetPoint("TOPRIGHT")
	health:SetStatusBarTexture(normTex)
	health:SetFrameStrata("LOW")
	self.Health = health
	
	local healthBG = health:CreateTexture(nil, 'BORDER')
	healthBG:SetAllPoints()
	self.Health.bg = healthBG
	
	health:CreateBorder(false, true)
	
	-- power
	local power = CreateFrame('StatusBar', nil, self)
	power:Point("BOTTOMLEFT", health, "BOTTOMLEFT", 4, 2)
	power:Point("BOTTOMRIGHT", health, "BOTTOMRIGHT", -4, 2)
	power:SetStatusBarTexture(normTex)
	
	self.Power = power

	local powerBG = power:CreateTexture(nil, 'BORDER')
	powerBG:SetAllPoints(power)
	powerBG:SetTexture(blankTex)
	powerBG.multiplier = 0.3
	self.Power.bg = powerBG
	
	power:CreateBorder(false, true)

	-- colors
	health.frequentUpdates = true
	power.frequentUpdates = true
	power.colorDisconnected = true

	if C["unitframes"].showsmooth == true then
		health.Smooth = true
		power.Smooth = true
	end
		
	if C["unitframes"].unicolor == true then
		health.colorTapping = false
		health.colorDisconnected = false
		health.colorClass = false
		health:SetStatusBarColor(.155, .155, .155)
		healthBG:SetTexture(1, 1, 1)
		healthBG:SetVertexColor(.05, .05, .05)	
			
		power.colorTapping = true
		power.colorDisconnected = true
		power.colorClass = true
		power.colorReaction = true
	else
		healthBG:SetTexture(.1, .1, .1)

		health.colorTapping = true
		health.colorDisconnected = true
		health.colorReaction = true
		health.colorClass = true
				
		power.colorPower = true
	end
		
	-- unitframe bg
	local panel = CreateFrame("Frame", nil, self)
	panel:SetFrameLevel(health:GetFrameLevel() - 1)
	panel:SetFrameStrata(health:GetFrameStrata())
	panel:Point("TOPLEFT", health, -2, 2)
	panel:Point("BOTTOMRIGHT", health, 2, -2)
	panel:SetBackdrop({
		bgFile = C["media"].blank,
		insets = { left = -T.mult, right = -T.mult, top = -T.mult, bottom = -T.mult }
	})
	panel:SetBackdropColor(unpack(C["media"].bordercolor))
	panel:CreateBorder(true, true)
	self.panel = panel
	
	------------------------------------------------------------------------
	--	Player and Target units layout (mostly mirror'd)
	------------------------------------------------------------------------
	
	if (unit == "player" or unit == "target") then
		-- health bar
		health:Height(25)
		power:Height(2)
		
		health.value = T.SetFontString(health, font, 10, "THINOUTLINE")
		health.value:Point("RIGHT", self.panel, "RIGHT", -4, 2)
		health.value:SetParent(self)
		health.PostUpdate = T.PostUpdateHealth
		
		power.value = T.SetFontString(health, font, 10, "THINOUTLINE")
		power.value:Point("LEFT", self.panel, "LEFT", 6, 2)
		power.value:SetParent(self)
		power.PreUpdate = T.PreUpdatePower
		power.PostUpdate = T.PostUpdatePower
					
		-- portraits  
		if C["unitframes"].charportrait == true then
			local portrait = CreateFrame("PlayerModel", nil, health)
			portrait.PostUpdate = function(self) self:SetAlpha(0) self:SetAlpha(0.15) end
			portrait:SetAllPoints(health)
			table.insert(self.__elements, T.HidePortrait)
			self.Portrait = portrait
		end
		
					----- Class Icon ------
		if (C["unitframes"].classicon == true) then
			local classicon = CreateFrame("Frame", self:GetName().."_ClassIconBorder", self)
		
		if unit == "player" then
				classicon:CreatePanel("Default", 29, 29, "RIGHT", health, "LEFT", -4, 0)
		elseif unit == "target" then
				classicon:CreatePanel("Default", 29, 29, "LEFT", health, "RIGHT", 4, 0)
		end

		local class = classicon:CreateTexture(self:GetName().."_ClassIcon", "ARTWORK")
		class:Point("TOPLEFT", 2, -2)
		class:Point("BOTTOMRIGHT", -2, 2)
		self.ClassIcon = class
		end	
		
		if T.myclass == "PRIEST" and C["unitframes"].weakenedsoulbar then
			local ws = CreateFrame("StatusBar", self:GetName().."_WeakenedSoul", power)
			ws:Height(2)
			ws:Point("BOTTOMLEFT", power, "TOPLEFT", 0, 1)
			ws:Point("BOTTOMRIGHT", power, "TOPRIGHT", 0, 1)
			ws:SetStatusBarTexture(blankTex)
			ws:GetStatusBarTexture():SetHorizTile(false)
			ws:SetBackdrop(backdrop)
			ws:SetBackdropColor(unpack(C.media.backdropcolor))
			ws:SetStatusBarColor(191/255, 10/255, 10/255)
			
			self.WeakenedSoul = ws
		end
	
		if (unit == "player") then
			-- combat icon
			local Combat = health:CreateTexture(nil, "OVERLAY")
			Combat:Height(19)
			Combat:Width(19)
			Combat:SetPoint("BOTTOM",0,3)
			Combat:SetVertexColor(0.69, 0.31, 0.31)
			self.Combat = Combat

			-- custom info (low mana warning)
			FlashInfo = CreateFrame("Frame", "TukuiFlashInfo", self)
			FlashInfo:SetScript("OnUpdate", T.UpdateManaLevel)
			FlashInfo.parent = self
			FlashInfo:SetAllPoints(health)
			FlashInfo.ManaLevel = T.SetFontString(FlashInfo, font, 10, "THINOUTLINE")
			FlashInfo.ManaLevel:SetPoint("CENTER", health, "CENTER", 0, 1)
			self.FlashInfo = FlashInfo
			
			-- pvp status text
			local status = T.SetFontString(health, font, 10, "THINOUTLINE")
			status:SetPoint("TOP", health, "TOP", 0, 0)
			status:SetTextColor(0.69, 0.31, 0.31)
			status:Hide()
			self.Status = status
			self:Tag(status, "[pvp]")
			
			-- leader icon
			local Leader = InvFrame:CreateTexture(nil, "OVERLAY")
			Leader:Height(14)
			Leader:Width(14)
			Leader:Point("TOPLEFT", 2, 8)
			self.Leader = Leader
			
			-- master looter
			local MasterLooter = InvFrame:CreateTexture(nil, "OVERLAY")
			MasterLooter:Height(14)
			MasterLooter:Width(14)
			self.MasterLooter = MasterLooter
			self:RegisterEvent("PARTY_LEADER_CHANGED", T.MLAnchorUpdate)
			self:RegisterEvent("PARTY_MEMBERS_CHANGED", T.MLAnchorUpdate)
			
			-- show druid mana when shapeshifted in bear, cat or whatever
			if C["unitframes"].classbar then
			if T.myclass == "DRUID" and C["unitframes"].druid then

					local eclipseBar = CreateFrame('Frame', nil, self)
					eclipseBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 5)
					eclipseBar:Size(225, 5)
					eclipseBar:SetFrameStrata("MEDIUM")
					eclipseBar:SetFrameLevel(8)
					eclipseBar:SetBackdropBorderColor(0,0,0,1)
					eclipseBar:SetScript("OnShow", function() T.EclipseDisplay(self, false) end)
					eclipseBar:SetScript("OnUpdate", function() T.EclipseDisplay(self, true) end) -- just forcing 1 update on login for buffs/shadow/etc.
					eclipseBar:SetScript("OnHide", function() T.EclipseDisplay(self, false) end)
					
					local lunarBar = CreateFrame('StatusBar', nil, eclipseBar)
					lunarBar:SetPoint('LEFT', eclipseBar, 'LEFT', 0, 0)
					lunarBar:SetSize(eclipseBar:GetWidth(), eclipseBar:GetHeight())
					lunarBar:SetStatusBarTexture(blankTex)
					lunarBar:SetStatusBarColor(.30, .52, .90)
					eclipseBar.LunarBar = lunarBar

					local solarBar = CreateFrame('StatusBar', nil, eclipseBar)
					solarBar:SetPoint('LEFT', lunarBar:GetStatusBarTexture(), 'RIGHT', 0, 0)
					solarBar:SetSize(eclipseBar:GetWidth(), eclipseBar:GetHeight())
					solarBar:SetStatusBarTexture(blankTex)
					solarBar:SetStatusBarColor(.80, .82,  .60)
					eclipseBar.SolarBar = solarBar

					local eclipseBarText = eclipseBar:CreateFontString(nil, 'OVERLAY')
					eclipseBarText:SetPoint('TOP', eclipseBar, 0, 25)
					eclipseBarText:SetPoint('BOTTOM', eclipseBar)
					eclipseBarText:SetFont(font, 10, "THINOUTLINE")
					eclipseBarText:SetShadowOffset(T.mult, -T.mult)
					eclipseBarText:SetShadowColor(0, 0, 0, 0.4)
					eclipseBar.PostUpdatePower = T.EclipseDirection
					
					-- hide "low mana" text on load if eclipseBar is show
					if eclipseBar and eclipseBar:IsShown() then FlashInfo.ManaLevel:SetAlpha(0) end

					self.EclipseBar = eclipseBar
					self.EclipseBar.Text = eclipseBarText
					
					eclipseBar.FrameBackdrop = CreateFrame("Frame", nil, eclipseBar)
					eclipseBar.FrameBackdrop:SetTemplate("Default")
					eclipseBar.FrameBackdrop:SetPoint("TOPLEFT", T.Scale(-2), T.Scale(2))
					eclipseBar.FrameBackdrop:SetPoint("BOTTOMRIGHT", T.Scale(2), T.Scale(-2))
					eclipseBar.FrameBackdrop:SetFrameLevel(eclipseBar:GetFrameLevel() - 1)
				end

				-- set holy power bar or shard bar
				if (T.myclass == "WARLOCK" or T.myclass == "PALADIN") then
		
					local bars = CreateFrame("Frame", nil, self)
                    			bars:Size(200, 5)
					bars:Point("TOP", health, "TOP", 2, 10)
					bars:SetBackdropBorderColor(0,0,0,1)
					bars:SetFrameLevel(self:GetFrameLevel() + 3)
					bars:SetFrameStrata("MEDIUM")
					
					for i = 1, 3 do					
						bars[i]=CreateFrame("StatusBar", self:GetName().."_Shard"..i, bars)
						bars[i]:Height(2)					
						bars[i]:SetStatusBarTexture(blankTex)
						bars[i]:GetStatusBarTexture():SetHorizTile(false)
						
						if T.myclass == "WARLOCK" then
							bars[i]:SetStatusBarColor(148/255, 130/255, 201/255)
						elseif T.myclass == "PALADIN" then
							bars[i]:SetStatusBarColor(228/255,225/255,16/255)
						end
						
						if i == 1 then
							bars[i]:SetPoint("LEFT", bars)
							bars[i]:SetWidth(T.Scale(180 /3)) 
						else
							bars[i]:Point("LEFT", bars[i-1], "RIGHT", T.Scale(8), 0)
							bars[i]:SetWidth(T.Scale(180/3))
						end
						
						bars[i].border = CreateFrame("Frame", nil, bars)
					    bars[i].border:SetPoint("TOPLEFT", bars[i], "TOPLEFT", T.Scale(-2), T.Scale(2))
					    bars[i].border:SetPoint("BOTTOMRIGHT", bars[i], "BOTTOMRIGHT", T.Scale(2), T.Scale(-2))
					    bars[i].border:SetFrameStrata("BACKGROUND")
						bars[i].border:SetFrameLevel(2)
					    bars[i].border:SetTemplate("Default")
					    --bars[i].border:SetBackdropColor(.1,.1,.1,1)
						bars[i].border:SetBackdropColor(0,0,0,1)
					end
					
					if T.myclass == "WARLOCK" then
						bars.Override = T.UpdateShards				
						self.SoulShards = bars
					elseif T.myclass == "PALADIN" then
						bars.Override = T.UpdateHoly
						self.HolyPower = bars
					end
				end	

				-- deathknight runes
					if T.myclass == "DEATHKNIGHT" and C["unitframes"].deathknight then
					
					local Runes = CreateFrame("Frame", nil, self)
					Runes:Point("BOTTOMLEFT", health, "TOPLEFT", 13, 6)
					Runes:Size(120, 5)
					Runes:SetFrameLevel(self:GetFrameLevel() + 3)
					Runes:SetFrameStrata("MEDIUM")

					for i = 1, 6 do
					Runes[i] = CreateFrame("StatusBar", self:GetName().."_Runes"..i, self)
					Runes[i]:SetHeight(T.Scale(5))

					if i == 1 then
                    Runes[i]:SetPoint("LEFT", Runes, "LEFT", 0, 0)
					Runes[i]:SetWidth(T.Scale(176 /6))
                    else
                    Runes[i]:SetPoint("LEFT", Runes[i-1], "RIGHT", T.Scale(5), 0)
					Runes[i]:SetWidth(T.Scale(176 /6))
                    end
                    Runes[i]:SetStatusBarTexture(blankTex)
                    Runes[i]:GetStatusBarTexture():SetHorizTile(false)
					Runes[i]:SetBackdrop(backdrop)
                    Runes[i]:SetBackdropColor(0,0,0)
                    Runes[i]:SetFrameLevel(4)
                    
                    Runes[i].bg = Runes[i]:CreateTexture(nil, "BORDER")
                    Runes[i].bg:SetAllPoints(Runes[i])
                    Runes[i].bg:SetTexture(blankTex)
                    Runes[i].bg.multiplier = 0.3
					
					Runes[i].border = CreateFrame("Frame", nil, Runes[i])
					Runes[i].border:SetPoint("TOPLEFT", Runes[i], "TOPLEFT", T.Scale(-2), T.Scale(2))
					Runes[i].border:SetPoint("BOTTOMRIGHT", Runes[i], "BOTTOMRIGHT", T.Scale(2), T.Scale(-2))
					Runes[i].border:SetFrameStrata("MEDIUM")
                    Runes[i].border:SetFrameLevel(4)					
					--Runes[i].border:SetBackdropColor(.1,.1,.1,1 )
					Runes[i].border:SetBackdropColor(0,0,0,1)
					Runes[i].border:SetTemplate("Default")
				end

                    self.Runes = Runes
                end
				
				-- shaman totem bar
				if T.myclass == "SHAMAN" and C["unitframes"].shaman then
				local TotemBar = {}
					TotemBar.Destroy = true
					for i = 1, 4 do
					TotemBar[i] = CreateFrame("StatusBar", self:GetName().."_TotemBar"..i, self)
					TotemBar[i]:SetFrameLevel(self:GetFrameLevel() + 3)
					if (i == 1) then
					TotemBar[i]:Point("BOTTOMLEFT", health, "TOPLEFT", 12, 6)					else
					TotemBar[i]:SetPoint("TOPLEFT", TotemBar[i-1], "TOPRIGHT", T.Scale(7), 0)
					end
					TotemBar[i]:SetStatusBarTexture(blankTex)
					TotemBar[i]:SetHeight(T.Scale(5))
					TotemBar[i]:SetWidth(T.Scale(180) / 4)
					TotemBar[i]:SetFrameLevel(4)
				
					TotemBar[i]:SetBackdrop(backdrop)
					TotemBar[i]:SetBackdropColor(0, 0, 0, 1)
					TotemBar[i]:SetMinMaxValues(0, 1)

					TotemBar[i].bg = TotemBar[i]:CreateTexture(nil, "BORDER")
					TotemBar[i].bg:SetAllPoints(TotemBar[i])
					TotemBar[i].bg:SetTexture(blankTex)
					TotemBar[i].bg.multiplier = 0.2
					
					TotemBar[i].border = CreateFrame("Frame", nil, TotemBar[i])
					TotemBar[i].border:SetPoint("TOPLEFT", TotemBar[i], "TOPLEFT", T.Scale(-2), T.Scale(2))
					TotemBar[i].border:SetPoint("BOTTOMRIGHT", TotemBar[i], "BOTTOMRIGHT", T.Scale(2), T.Scale(-2))
					TotemBar[i].border:SetFrameStrata("MEDIUM")
					TotemBar[i].border:SetFrameLevel(4)
					--TotemBar[i].border:SetBackdropColor(.1,.1,.1,1)
					TotemBar[i].border:SetBackdropColor(0,0,0,1)
					TotemBar[i].border:SetTemplate("Default")
				end
				self.TotemBar = TotemBar
			end
		end	
			
			-- script for pvp status and low mana
			self:SetScript("OnEnter", function(self)
				if self.EclipseBar and self.EclipseBar:IsShown() then 
					self.EclipseBar.Text:Hide()
				end
				FlashInfo.ManaLevel:Hide()
				status:Show()
				UnitFrame_OnEnter(self) 
			end)
			self:SetScript("OnLeave", function(self) 
				if self.EclipseBar and self.EclipseBar:IsShown() then 
					self.EclipseBar.Text:Show()
				end
				FlashInfo.ManaLevel:Show()
				status:Hide()
				UnitFrame_OnLeave(self) 
			end)
		end
		
		if (unit == "target") then			
			-- Unit name on target
			local Name = T.SetFontString(health, font, 10, "THINOUTLINE")
			Name:Point("LEFT", panel, "LEFT", 0, 2)
			Name:SetJustifyH("LEFT")
			Name:SetParent(self)

			self:Tag(Name, '[Tukui:getnamecolor][Tukui:namemedium] [Tukui:diffcolor][level][shortclassification]')
			self.Name = Name
			
			--combo points change to support sCombo
			local cp = T.SetFontString(self, font2, 15, "THINOUTLINE")
			cp:SetPoint("RIGHT", health.border, "LEFT", -5, 0)
			self.CPoints = cp
			end
			
			if (unit == "target" and C["unitframes"].targetauras) or (unit == "player" and C["unitframes"].playerauras) then
			local buffs = CreateFrame("Frame", nil, self)
			local debuffs = CreateFrame("Frame", nil, self)
			
			if (T.myclass == "SHAMAN" or T.myclass == "DEATHKNIGHT" or T.myclass == "PALADIN" or T.myclass == "WARLOCK") and (C["unitframes"].playerauras) and (unit == "player") then
				if T.lowversion then
					buffs:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 34)
				else
					buffs:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 38)
				end
			else
				if T.lowversion then
					buffs:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 26)
				else
					buffs:SetPoint("TOPLEFT", self, "TOPLEFT", -2, 30)
				end
			end
			
			if T.lowversion then
				buffs:SetHeight(21.5)
				buffs:SetWidth(186)
				buffs.size = 21.5
				buffs.num = 8
				
				debuffs:SetHeight(21.5)
				debuffs:SetWidth(186)
				debuffs:SetPoint("BOTTOMLEFT", buffs, "TOPLEFT", 0, 2)
				debuffs.size = 21.5	
				debuffs.num = 24
			else				
				buffs:SetHeight(26)
				buffs:SetWidth(252)
				buffs.size = 26
				buffs.num = 9
				
				debuffs:SetHeight(26)
				debuffs:SetWidth(252)
				debuffs:SetPoint("BOTTOMLEFT", buffs, "TOPLEFT", -24, 2)
				debuffs.size = 26
				debuffs.num = 27
			end
						
			buffs.spacing = 2
			buffs.initialAnchor = 'TOPLEFT'
			buffs.PostCreateIcon = T.PostCreateAura
			buffs.PostUpdateIcon = T.PostUpdateAura
			self.Buffs = buffs	
						
			debuffs.spacing = 2
			debuffs.initialAnchor = 'TOPRIGHT'
			debuffs["growth-y"] = "UP"
			debuffs["growth-x"] = "LEFT"
			debuffs.PostCreateIcon = T.PostCreateAura
			debuffs.PostUpdateIcon = T.PostUpdateAura
			
			-- an option to show only our debuffs on target
			if unit == "target" then
				debuffs.onlyShowPlayer = C.unitframes.onlyselfdebuffs
			end
			
			self.Debuffs = debuffs
		end
		
		-- cast bar for player and target
		if (C["unitframes"].unitcastbar == true) then
			-- castbar of player and target
			local castbar = CreateFrame("StatusBar", self:GetName().."CastBar", self)
			castbar:SetStatusBarTexture(blankTex)
			castbar.bg = castbar:CreateTexture(nil, "BORDER")
			castbar.bg:CreateBorder()
			castbar.bg:SetAllPoints(castbar)
			castbar.bg:SetTexture(blankTex)
			castbar.bg:SetVertexColor(.05, .05, .05)
						
			if unit == "player" then
				if C["unitframes"].cbicons == true then
					castbar:SetWidth(300)
				else
					castbar:SetWidth(TukuiBar1:GetWidth() - 4)
				end
				castbar:SetHeight(22)
				castbar:Point("BOTTOM", TukuiBar1, "TOP", 0, 3)
			elseif unit == "target" then
				if C["unitframes"].cbicons == true then
					castbar:SetWidth(225 - 25)
				else
					castbar:SetWidth(225)
				end
				castbar:SetHeight(18)
				castbar:Point("TOPRIGHT", self, "BOTTOMRIGHT", 0, 2)   -- SHAG
			end
			castbar:SetFrameLevel(6)
						
			-- Border
			castbar.border = CreateFrame("Frame", nil, castbar)
			castbar.border:CreatePanel("Default",1,1,"TOPLEFT", castbar, "TOPLEFT", -2, 2)
			castbar.border:SetBackdropColor(0,0,0,1)
			castbar.border:Point("BOTTOMRIGHT", castbar, "BOTTOMRIGHT", 2, -2)
			castbar.CustomTimeText = T.CustomCastTimeText
			castbar.CustomDelayText = T.CustomCastDelayText
			castbar.PostCastStart = T.PostCastStart
			castbar.PostChannelStart = T.PostCastStart

			castbar.time = T.SetFontString(castbar, font, 10, "THINOUTLINE")
			castbar.time:Point("RIGHT", castbar.bg, "RIGHT", -4, 0)
			castbar.time:SetTextColor(1, 1, 1)
			castbar.time:SetJustifyH("RIGHT")

			castbar.Text = T.SetFontString(castbar, font, 10, "THINOUTLINE")
			castbar.Text:Point("LEFT", castbar.bg, "LEFT", 4, 0)
			castbar.Text:SetTextColor(1, 1, 1)
						
			if C["unitframes"].cbicons == true then
				castbar.button = CreateFrame("Frame", nil, castbar)
				if unit == "player" then
				castbar.button:Size(25)
				else
				castbar.button:Size(22)
				end
				castbar.button:SetTemplate("Default")
				castbar.button:SetBackdropColor(0,0,0,1)
				castbar.button:SetPoint("RIGHT",castbar,"LEFT", -5, 0)
				castbar.button:CreateBorder()
				castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
				castbar.icon:Point("TOPLEFT", castbar.button, 2, -2)
				castbar.icon:Point("BOTTOMRIGHT", castbar.button, -2, 2)
				castbar.icon:SetTexCoord(0.08, 0.92, 0.08, .92)
			end
			
			-- cast bar latency on player
			if unit == "player" and C["unitframes"].cblatency == true then
				castbar.safezone = castbar:CreateTexture(nil, "ARTWORK")
				castbar.safezone:SetTexture(blankTex)
				castbar.safezone:SetVertexColor(0.8, 0.2, 0.2, 0.75)
				castbar.SafeZone = castbar.safezone
			end
					
			self.Castbar = castbar
			self.Castbar.Time = castbar.time
			self.Castbar.Icon = castbar.icon
		end
		
		-- add combat feedback support
		if C["unitframes"].combatfeedback == true then
			local CombatFeedbackText 
			if T.lowversion then
				CombatFeedbackText = T.SetFontString(health, font, 12)
			else
				CombatFeedbackText = T.SetFontString(health, font, 14)
			end
			CombatFeedbackText:SetPoint("CENTER", 0, 1)
			CombatFeedbackText:SetShadowColor(0, 0, 0)
			CombatFeedbackText:SetShadowOffset(1.25, -1.25)
			CombatFeedbackText.colors = {
				DAMAGE = {0.69, 0.31, 0.31},
				CRUSHING = {0.69, 0.31, 0.31},
				CRITICAL = {0.69, 0.31, 0.31},
				GLANCING = {0.69, 0.31, 0.31},
				STANDARD = {0.84, 0.75, 0.65},
				IMMUNE = {0.84, 0.75, 0.65},
				ABSORB = {0.84, 0.75, 0.65},
				BLOCK = {0.84, 0.75, 0.65},
				RESIST = {0.84, 0.75, 0.65},
				MISS = {0.84, 0.75, 0.65},
				HEAL = {0.33, 0.59, 0.33},
				CRITHEAL = {0.33, 0.59, 0.33},
				ENERGIZE = {0.31, 0.45, 0.63},
				CRITENERGIZE = {0.31, 0.45, 0.63},
			}
			self.CombatFeedbackText = CombatFeedbackText
		end
		
		if C["unitframes"].healcomm then
			local mhpb = CreateFrame('StatusBar', nil, self.Health)
			mhpb:SetPoint('TOPLEFT', self.Health:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
			mhpb:SetPoint('BOTTOMLEFT', self.Health:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, 0)
			if T.lowversion then
				mhpb:SetWidth(186)
			else
				mhpb:SetWidth(250)
			end
			mhpb:SetStatusBarTexture(blankTex)
			mhpb:SetStatusBarColor(0, 1, 0.5, 0.25)
			mhpb:SetMinMaxValues(0,1)

			local ohpb = CreateFrame('StatusBar', nil, self.Health)
			ohpb:SetPoint('TOPLEFT', mhpb:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
			ohpb:SetPoint('BOTTOMLEFT', mhpb:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, 0)
			ohpb:SetWidth(250)
			ohpb:SetStatusBarTexture(blankTex)
			ohpb:SetStatusBarColor(0, 1, 0, 0.25)

			self.HealPrediction = {
				myBar = mhpb,
				otherBar = ohpb,
				maxOverflow = 1,
			}
		end
		
		-- player aggro
		if C["unitframes"].playeraggro == true then
			table.insert(self.__elements, T.UpdateThreat)
			self:RegisterEvent('PLAYER_TARGET_CHANGED', T.UpdateThreat)
			self:RegisterEvent('UNIT_THREAT_LIST_UPDATE', T.UpdateThreat)
			self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', T.UpdateThreat)
		end
	end
	
	------------------------------------------------------------------------
	--	Target of Target unit layout
	------------------------------------------------------------------------
	
	if (unit == "targettarget") then
		health:Height(20)
		power:Height(2)
		--[[health.value = T.SetFontString(health, font, 10, "THINOUTLINE")
		health.value:Point("RIGHT", health, "RIGHT", -4, 2)
		health.value:SetParent(self)
		health.PostUpdate = T.PostUpdateHealth		
		]]
		-- Unit name
		local Name = T.SetFontString(health, font, 10, "THINOUTLINE")
		Name:SetPoint("CENTER", panel, "CENTER", 0, 4)
		Name:SetJustifyH("CENTER")
		Name:SetParent(self)

		self:Tag(Name, '[Tukui:getnamecolor][Tukui:namemedium]')
		self.Name = Name
		
		health.frequentUpdates = true
		if C["unitframes"].showsmooth == true then
			health.Smooth = true
			power.Smooth = true
		end
				
		if C["unitframes"].totdebuffs == true and T.lowversion ~= true then
			local debuffs = CreateFrame("Frame", nil, health)
			debuffs:SetHeight(20)
			debuffs:SetWidth(127)
			debuffs.size = 20
			debuffs.spacing = 2
			debuffs.num = 6

			debuffs:SetPoint("TOPLEFT", health, "TOPLEFT", -0.5, 24)
			debuffs.initialAnchor = "TOPLEFT"
			debuffs["growth-y"] = "UP"
			debuffs.PostCreateIcon = T.PostCreateAura
			debuffs.PostUpdateIcon = T.PostUpdateAura
			self.Debuffs = debuffs
		end
	end
	
	------------------------------------------------------------------------
	--	Pet unit layout
	------------------------------------------------------------------------
	
		if (unit == "pet") then
		health:Height(16)
		power:Height(2)
						
		-- Unit name
		local Name = T.SetFontString(health, font, 10, "THINOUTLINE")
		Name:SetPoint("CENTER", health, "CENTER", 0, 4)
		Name:SetJustifyH("CENTER")
		Name:SetParent(self)

		self:Tag(Name, '[Tukui:getnamecolor][Tukui:namemedium]')
		self.Name = Name
		

		
		-- update pet name, this should fix "UNKNOWN" pet names on pet unit, health and bar color sometime being "grayish".
		self:RegisterEvent("UNIT_PET", T.updateAllElements)
	end

	------------------------------------------------------------------------
	--	Pet target layout
	------------------------------------------------------------------------
	
		if (unit == "pettarget") then
		health:Height(16)
		power:Height(2)
						
		-- Unit name
		local Name = T.SetFontString(health, font, 10, "THINOUTLINE")
		Name:SetPoint("CENTER", health, "CENTER", 0, 4)
		Name:SetJustifyH("CENTER")
		Name:SetParent(self)

		self:Tag(Name, '[Tukui:getnamecolor][Tukui:namemedium]')
		self.Name = Name
		

		
		-- update pet name, this should fix "UNKNOWN" pet names on pet unit, health and bar color sometime being "grayish".
		self:RegisterEvent("UNIT_PET", T.updateAllElements)
	end
	
	
	------------------------------------------------------------------------
	--	Focus unit layout
	------------------------------------------------------------------------
	
	if (unit == "focus") then
		health:Height(22)
		power:Height(2)
		
		health.value = T.SetFontString(health, font, 10, "THINOUTLINE")
		health.value:Point("RIGHT", self.panel, "RIGHT", -2, 3)
		health.value:SetParent(self)
		health.PostUpdate = T.PostUpdateHealth
		
		health.frequentUpdates = true
		health.colorDisconnected = true
		if C["unitframes"].showsmooth == true then
			health.Smooth = true
			power.Smooth = true
		end
		power.value = T.SetFontString(health, font, 10, "THINOUTLINE")
		power.value:Point("LEFT", self.panel, "LEFT", 6, 3)
		power.value:SetParent(self)
		power.PreUpdate = T.PreUpdatePower
		power.PostUpdate = T.PostUpdatePower
		
		-- Unit name
		local Name = T.SetFontString(health, font, 10, "THINOUTLINE")
		Name:SetPoint("CENTER", self.panel, "CENTER", 0, 3)
		Name:SetJustifyH("CENTER")
		Name:SetParent(self)

		self:Tag(Name, '[Tukui:getnamecolor][Tukui:namemedium]')
		self.Name = Name
		self:RegisterEvent("UNIT_AURA", T.updateAllElements)
		
		if (C["unitframes"].unitcastbar == true) then
		local castbar = CreateFrame("StatusBar", self:GetName().."CastBar", self)
		if C.unitframes.bigfocuscast then
		castbar:SetHeight(34)
		castbar:SetWidth(320)
		castbar:SetPoint("CENTER", UIParent, "CENTER", 0, 380)
		else
		castbar:SetHeight(16)
		castbar:SetPoint("LEFT", 23, 0)
		castbar:SetPoint("RIGHT", 0, 0)
		castbar:SetPoint("BOTTOM", 0, -15)
		end
				
		castbar:SetStatusBarTexture(blankTex)
		castbar:SetFrameLevel(6)
		
		castbar.bg = CreateFrame("Frame", nil, castbar)
		castbar.bg:SetTemplate("Default")
		castbar.bg:SetBackdropColor(0,0,0,1)
		--castbar.bg:SetBackdropBorderColor(unpack(C["media"].altbordercolor))
		castbar.bg:Point("TOPLEFT", -2, 2)
		castbar.bg:Point("BOTTOMRIGHT", 2, -2)
		castbar.bg:SetFrameLevel(5)
		
		castbar.time = T.SetFontString(castbar,font, 10, "THINOUTLINE")
		castbar.time:Point("RIGHT", castbar, "RIGHT", -4, 0)
		castbar.time:SetTextColor(1, 1, 1)
		castbar.time:SetJustifyH("RIGHT")
		castbar.CustomTimeText = T.CustomCastTimeText

		castbar.Text = T.SetFontString(castbar,font, 10, "THINOUTLINE")
		castbar.Text:SetPoint("LEFT", castbar, "LEFT", 4, 0)
		if C.unitframes.bigfocuscast then
		castbar.Text:SetWidth(250)
		else
		castbar.Text:SetWidth(120)
		end
		castbar.Text:SetTextColor(1, 1, 1)
		
		castbar.CustomDelayText = T.CustomCastDelayText
		castbar.PostCastStart = T.PostCastStart
		castbar.PostChannelStart = T.PostCastStart
								
		castbar.button = CreateFrame("Frame", nil, castbar)
		castbar.button:Height(castbar:GetHeight()+4)
		castbar.button:Width(castbar:GetHeight()+4)
		castbar.button:Point("RIGHT", castbar, "LEFT", -5, 0)
		castbar.button:SetTemplate("Default")
		castbar.button:SetBackdropColor(0,0,0,1)
		--castbar.button:SetBackdropBorderColor(unpack(C["media"].altbordercolor))
		castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
		castbar.icon:Point("TOPLEFT", castbar.button, 2, -2)
		castbar.icon:Point("BOTTOMRIGHT", castbar.button, -2, 2)
		castbar.icon:SetTexCoord(0.08, 0.92, 0.08, .92)

		self.Castbar = castbar
		self.Castbar.Time = castbar.time
		self.Castbar.Icon = castbar.icon
		end
	end
	
	------------------------------------------------------------------------
	--	Focus target unit layout
	------------------------------------------------------------------------

	if (unit == "focustarget") then
		health:Height(22)
		power:Height(2)
		
		health.value = T.SetFontString(health, font, 10, "THINOUTLINE")
		health.value:Point("RIGHT", self.panel, "RIGHT", -2, 3)
		health.value:SetParent(self)
		health.PostUpdate = T.PostUpdateHealth
		health.frequentUpdates = true
		if C["unitframes"].showsmooth == true then
			health.Smooth = true
			power.Smooth = true
		end
		power.value = T.SetFontString(health, font, 10, "THINOUTLINE")
		power.value:Point("LEFT", self.panel, "LEFT", 6, 3)
		power.value:SetParent(self)
		power.PreUpdate = T.PreUpdatePower
		power.PostUpdate = T.PostUpdatePower
		
		-- Unit name
		local Name = T.SetFontString(health, font, 10, "THINOUTLINE")
		Name:SetPoint("CENTER", self.panel, "CENTER", 0, 3)
		Name:SetJustifyH("CENTER")
		Name:SetParent(self)

		self:Tag(Name, '[Tukui:getnamecolor][Tukui:namemedium]')
		self.Name = Name
		
		if (C["unitframes"].unitcastbar == true) and C.unitframes.showfocustarcast then
		local castbar = CreateFrame("StatusBar", self:GetName().."CastBar", self)
		castbar:SetPoint("LEFT", 23, 0)
		castbar:SetPoint("RIGHT", 0, 0)
		castbar:SetPoint("BOTTOM", 0, -15)
		
		castbar:SetHeight(16)
		castbar:SetStatusBarTexture(blankTex)
		castbar:SetFrameLevel(6)
		
		castbar.bg = CreateFrame("Frame", nil, castbar)
		castbar.bg:SetTemplate("Default")
		castbar.bg:SetBackdropColor(0,0,0,1)
		--castbar.bg:SetBackdropBorderColor(unpack(C["media"].altbordercolor))
		castbar.bg:Point("TOPLEFT", -2, 2)
		castbar.bg:Point("BOTTOMRIGHT", 2, -2)
		castbar.bg:SetFrameLevel(5)
		
		castbar.time = T.SetFontString(castbar,font, 10, "THINOUTLINE")
		castbar.time:Point("RIGHT", castbar, "RIGHT", -4, 0)
		castbar.time:SetTextColor(1, 1, 1)
		castbar.time:SetJustifyH("RIGHT")
		castbar.CustomTimeText = T.CustomCastTimeText

		castbar.Text = T.SetFontString(castbar, font, 10, "THINOUTLINE")
		castbar.Text:SetPoint("LEFT", castbar, "LEFT", 4, 0)
		castbar.Text:SetWidth(100)
		castbar.Text:SetTextColor(1, 1, 1)
		
		castbar.CustomDelayText = T.CustomCastDelayText
		castbar.PostCastStart = T.PostCastStart
		castbar.PostChannelStart = T.PostCastStart
								
		castbar.button = CreateFrame("Frame", nil, castbar)
		castbar.button:Height(castbar:GetHeight()+4)
		castbar.button:Width(castbar:GetHeight()+4)
		castbar.button:Point("RIGHT", castbar, "LEFT", -5, 0)
		castbar.button:SetTemplate("Default")
		castbar.button:SetBackdropColor(0,0,0,1)
		--castbar.button:SetBackdropBorderColor(unpack(C["media"].altbordercolor))
		castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
		castbar.icon:Point("TOPLEFT", castbar.button, 2, -2)
		castbar.icon:Point("BOTTOMRIGHT", castbar.button, -2, 2)
		castbar.icon:SetTexCoord(0.08, 0.92, 0.08, .92)

		self.Castbar = castbar
		self.Castbar.Time = castbar.time
		self.Castbar.Icon = castbar.icon
		end
	end

	------------------------------------------------------------------------
	--	Arena or boss units layout (both mirror'd)
	------------------------------------------------------------------------
	
	if (unit and unit:find("arena%d") and C["arena"].unitframes == true) or (unit and unit:find("boss%d") and C["unitframes"].showboss == true) then
		-- Right-click focus on arena or boss units
		self:SetAttribute("type2", "focus")
		
		health:Height(22)
		power:Height(2)
		
		health.value = T.SetFontString(health, font, 10, "THINOUTLINE")
		health.value:Point("RIGHT", self.panel, "RIGHT", -2, 4)
		health.value:SetParent(self)
		health.PostUpdate = T.PostUpdateHealth
		health.frequentUpdates = true
		if C["unitframes"].showsmooth == true then
			health.Smooth = true
			power.Smooth = true
		end
		power.value = T.SetFontString(health, font, 10, "THINOUTLINE")
		power.value:Point("LEFT", self.panel, "LEFT", 6, 4)
		power.value:SetParent(self)
		power.PreUpdate = T.PreUpdatePower
		power.PostUpdate = T.PostUpdatePower
		
		-- Unit name
		local Name = T.SetFontString(health, font, 10, "THINOUTLINE")
		Name:SetPoint("CENTER", self.panel, "CENTER", 0, 4)
		Name:SetJustifyH("CENTER")

		self:Tag(Name, '[Tukui:getnamecolor][Tukui:namemedium]')
		self.Name = Name
		
		if (unit and unit:find("boss%d")) then
			-- alt power bar
			local AltPowerBar = CreateFrame("StatusBar", nil, self.Health)
			AltPowerBar:SetFrameLevel(self.Health:GetFrameLevel() + 1)
			AltPowerBar:Height(4)
			AltPowerBar:SetStatusBarTexture(C.media.empath2)
			AltPowerBar:GetStatusBarTexture():SetHorizTile(false)
			AltPowerBar:SetStatusBarColor(1, 0, 0)

			AltPowerBar:SetPoint("LEFT")
			AltPowerBar:SetPoint("RIGHT")
			AltPowerBar:SetPoint("TOP", self.Health, "TOP")
			
			AltPowerBar:SetBackdrop({
			  bgFile = C["media"].blank, 
			  edgeFile = C["media"].blank, 
			  tile = false, tileSize = 0, edgeSize = T.Scale(1), 
			  insets = { left = 0, right = 0, top = 0, bottom = T.Scale(-1)}
			})
			AltPowerBar:SetBackdropColor(0, 0, 0)

			self.AltPowerBar = AltPowerBar
			
			-- create buff at left of unit if they are boss units
			local buffs = CreateFrame("Frame", nil, self)
			buffs:SetHeight(24)
			buffs:SetWidth(252)
			buffs:Point("TOPRIGHT", self, "TOPLEFT", -4, 1)
			buffs.size = 25
			buffs.num = 3
			buffs.spacing = 2
			buffs.initialAnchor = 'RIGHT'
			buffs["growth-x"] = "LEFT"
			buffs.PostCreateIcon = T.PostCreateAura
			buffs.PostUpdateIcon = T.PostUpdateAura
			self.Buffs = buffs
			
			-- because it appear that sometime elements are not correct.
			self:HookScript("OnShow", T.updateAllElements)
		end

		-- create debuff for arena units
		local debuffs = CreateFrame("Frame", nil, self)
		debuffs:SetHeight(24)
		debuffs:SetWidth(200)
		debuffs:Point('TOPLEFT', self, 'TOPRIGHT', 4, 1)
		debuffs.size = 25
		debuffs.num = 5
		debuffs.spacing = 2
		debuffs.initialAnchor = 'LEFT'
		debuffs["growth-x"] = "RIGHT"
		debuffs.PostCreateIcon = T.PostCreateAura
		debuffs.PostUpdateIcon = T.PostUpdateAura
		-- an option to show only our debuffs on target
		if (unit and (unit:find("boss%d") or unit:find("arena%d"))) then
		debuffs.onlyShowPlayer = C.unitframes.onlyselfdebuffs
		end
		self.Debuffs = debuffs
				
		-- trinket feature via trinket plugin
		if (C.arena.unitframes) and (unit and unit:find('arena%d')) then
			local Trinketbg = CreateFrame("Frame", nil, self)
			Trinketbg:SetHeight(26)
			Trinketbg:SetWidth(26)
			Trinketbg:Point("TOPRIGHT", self, "TOPLEFT", -4, 2)				
			Trinketbg:SetTemplate("Default")
			Trinketbg:SetFrameLevel(0)
			self.Trinketbg = Trinketbg
			
			local Trinket = CreateFrame("Frame", nil, Trinketbg)
			Trinket:SetAllPoints(Trinketbg)
			Trinket:Point("TOPLEFT", Trinketbg, 2, -2)
			Trinket:Point("BOTTOMRIGHT", Trinketbg, -2, 2)
			Trinket:SetFrameLevel(1)
			Trinket.trinketUseAnnounce = true
			self.Trinket = Trinket
		end
		
		-- boss & arena frames cast bar!
		if (C["unitframes"].unitcastbar == true) then
		local castbar = CreateFrame("StatusBar", self:GetName().."CastBar", self)
		castbar:SetPoint("LEFT", 23, 0)
		castbar:SetPoint("RIGHT", 0, 0)
		castbar:SetPoint("BOTTOM", 0, -15)
		
		castbar:SetHeight(16)
		castbar:SetStatusBarTexture(blankTex)
		castbar:SetFrameLevel(6)
		
		castbar.bg = CreateFrame("Frame", nil, castbar)
		castbar.bg:SetTemplate("Default")
		castbar.bg:SetBackdropColor(0,0,0,1)
		--castbar.bg:SetBackdropBorderColor(unpack(C["media"].altbordercolor))
		castbar.bg:Point("TOPLEFT", -2, 2)
		castbar.bg:Point("BOTTOMRIGHT", 2, -2)
		castbar.bg:SetFrameLevel(5)
		
		castbar.time = T.SetFontString(castbar,font, 10, "THINOUTLINE")
		castbar.time:Point("RIGHT", castbar, "RIGHT", -4, 0)
		castbar.time:SetTextColor(1, 1, 1)
		castbar.time:SetJustifyH("RIGHT")
		castbar.CustomTimeText = T.CustomCastTimeText

		castbar.Text = T.SetFontString(castbar,font, 10, "THINOUTLINE")
		castbar.Text:SetPoint("LEFT", castbar, "LEFT", 4, 0)
		castbar.Text:SetTextColor(1, 1, 1)
		
		castbar.CustomDelayText = T.CustomCastDelayText
		castbar.PostCastStart = T.PostCastStart
		castbar.PostChannelStart = T.PostCastStart
								
		castbar.button = CreateFrame("Frame", nil, castbar)
		castbar.button:Height(castbar:GetHeight()+4)
		castbar.button:Width(castbar:GetHeight()+4)
		castbar.button:Point("RIGHT", castbar, "LEFT", -5, 0)
		castbar.button:SetTemplate("Default")
		castbar.button:SetBackdropColor(0,0,0,1)
		--castbar.button:SetBackdropBorderColor(unpack(C["media"].altbordercolor))
		castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
		castbar.icon:Point("TOPLEFT", castbar.button, 2, -2)
		castbar.icon:Point("BOTTOMRIGHT", castbar.button, -2, 2)
		castbar.icon:SetTexCoord(0.08, 0.92, 0.08, .92)

		self.Castbar = castbar
		self.Castbar.Time = castbar.time
		self.Castbar.Icon = castbar.icon
		end
	end

	------------------------------------------------------------------------
	--	Main tanks and Main Assists layout (both mirror'd)
	------------------------------------------------------------------------
	
	if(self:GetParent():GetName():match"TukuiMainTank" or self:GetParent():GetName():match"TukuiMainAssist") then
		-- Right-click focus on maintank or mainassist units
		self:SetAttribute("type2", "focus")
		
		-- health 
		local health = CreateFrame('StatusBar', nil, self)
		health:Height(20)
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(blankTex)
		
		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)
				
		self.Health = health
		self.Health.bg = healthBG
		
		health.frequentUpdates = true
		if C["unitframes"].showsmooth == true then
			health.Smooth = true
		end
		
		if C["unitframes"].unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.250, .250, .250, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true	
		end
		
		-- names
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", self.panel, "CENTER", 0, 0)
		Name:SetJustifyH("CENTER")
		Name:SetFont(font, 12, "OUTLINE")
		Name:SetShadowColor(0, 0, 0)
		Name:SetShadowOffset(1.25, -1.25)
		
		self:Tag(Name, '[Tukui:getnamecolor][Tukui:nameshort]')
		self.Name = Name
	end
	
	return self
end

------------------------------------------------------------------------
--	Default position of Tukui unitframes
------------------------------------------------------------------------
oUF:RegisterStyle('Tukui', Shared)
T.Player, T.Target, T.ToT, T.Pet, T.Focus, T.Focustarget, T.Boss, T.Pettarget = 225, 225, 130, 130, 115, 115, 200, 130

-- spawn
local player = oUF:Spawn('player', "TukuiPlayer")
local target = oUF:Spawn('target', "TukuiTarget")
local tot = oUF:Spawn('targettarget', "TukuiTargetTarget")
local pet = oUF:Spawn('pet', "TukuiPet")
local pettarget = oUF:Spawn('pettarget', "TukuiPettarget")
local focus = oUF:Spawn('focus', "TukuiFocus")

-- sizes
player:Size(T.Player, player.Health:GetHeight() + player.Power:GetHeight() + player.panel:GetHeight() + 6)
target:Size(T.Target, target.Health:GetHeight() + target.Power:GetHeight() + target.panel:GetHeight() + 6)
tot:SetSize(T.ToT, tot.Health:GetHeight() + tot.Power:GetHeight() + tot.panel:GetHeight() + 6)
pet:SetSize(T.Pet, pet.Health:GetHeight() + pet.Power:GetHeight() + pet.panel:GetHeight() + 6)	
pettarget:SetSize(T.Pettarget, pettarget.Health:GetHeight() + pettarget.Power:GetHeight() + pettarget.panel:GetHeight() + 6)
focus:SetSize(180, 29)

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, addon)

	if addon == "Tukui_Raid" then
		--[ DPS ]--
		player:Point("BOTTOM", InvTukuiActionBarBackground, "TOP", -201 , 60)
		target:Point("BOTTOM", InvTukuiActionBarBackground, "TOP", 201, 60)
		tot:Point("BOTTOM", InvTukuiActionBarBackground, "TOP", 0, 60)
		pet:Point("BOTTOM", InvTukuiActionBarBackground, "TOP", 0, 92)
		focus:Point("RIGHT", UIParent, "RIGHT", -412, -253)
		if C.unitframes.showpettarget then
		pettarget:SetPoint("TOPLEFT", tot, "BOTTOMLEFT", 0, -3) ---- SHAG pettarg
		end
	elseif addon == "Tukui_Raid_Healing" then
		--[ HEAL ]--
		player:Point("TOP", UIParent, "BOTTOM", -310 , 300)
		target:Point("TOP", UIParent, "BOTTOM", 310, 300)
		tot:Point("TOPRIGHT", TukuiTarget, "BOTTOMRIGHT", 0, -25)
		pet:Point("TOPLEFT", TukuiPlayer, "BOTTOMLEFT", 0, -32)
		focus:Point("TOP", UIParent, "BOTTOM", -400, 450)
		
	end
end)

if C.unitframes.showfocustarget then
	local focustarget = oUF:Spawn("focustarget", "TukuiFocusTarget")
	focustarget:SetPoint("TOP", TukuiFocus, "BOTTOM", 0 , -35)
	focustarget:Size(180, 29)
end


if C.arena.unitframes then
	local arena = {}
	for i = 1, 5 do
		arena[i] = oUF:Spawn("arena"..i, "TukuiArena"..i)
		if i == 1 then
			arena[i]:SetPoint("RIGHT", UIParent, "RIGHT", -280 , -120)
		else
			arena[i]:SetPoint("BOTTOM", arena[i-1], "TOP", 0, 35)
		end
		arena[i]:Size(200, 29)
	end
end

if C["unitframes"].showboss then
	for i = 1,MAX_BOSS_FRAMES do
		local t_boss = _G["Boss"..i.."TargetFrame"]
		t_boss:UnregisterAllEvents()
		t_boss.Show = T.dummy
		t_boss:Hide()
		_G["Boss"..i.."TargetFrame".."HealthBar"]:UnregisterAllEvents()
		_G["Boss"..i.."TargetFrame".."ManaBar"]:UnregisterAllEvents()
	end

	local boss = {}
	for i = 1, MAX_BOSS_FRAMES do
		boss[i] = oUF:Spawn("boss"..i, "TukuiBoss"..i)
		if i == 1 then
			boss[i]:SetPoint("RIGHT", UIParent, "RIGHT", -140, -140)
		else
			boss[i]:SetPoint('BOTTOM', boss[i-1], 'TOP', 0, 35)             
		end
		boss[i]:Size(200, 29)
	end
end

local assisttank_width = 100
local assisttank_height  = 20
if C["unitframes"].maintank == true then
	local tank = oUF:SpawnHeader('TukuiMainTank', nil, 'raid',
		'oUF-initialConfigFunction', ([[
			self:SetWidth(%d)
			self:SetHeight(%d)
		]]):format(assisttank_width, assisttank_height),
		'showRaid', true,
		'groupFilter', 'MAINTANK',
		'yOffset', 7,
		'point' , 'BOTTOM',
		'template', 'oUF_TukuiMtt'
	)
	tank:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
end
 
if C["unitframes"].mainassist == true then
	local assist = oUF:SpawnHeader("TukuiMainAssist", nil, 'raid',
		'oUF-initialConfigFunction', ([[
			self:SetWidth(%d)
			self:SetHeight(%d)
		]]):format(assisttank_width, assisttank_height),
		'showRaid', true,
		'groupFilter', 'MAINASSIST',
		'yOffset', 7,
		'point' , 'BOTTOM',
		'template', 'oUF_TukuiMtt'
	)
	if C["unitframes"].maintank == true then
		assist:SetPoint("TOPLEFT", TukuiMainTank, "BOTTOMLEFT", 2, -50)
	else
		assist:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end
end

-- this is just a fake party to hide Blizzard frame if no Tukui raid layout are loaded.
local party = oUF:SpawnHeader("oUF_noParty", nil, "party", "showParty", true)

------------------------------------------------------------------------
-- Right-Click on unit frames menu. 
-- Doing this to remove SET_FOCUS eveywhere.
-- SET_FOCUS work only on default unitframes.
-- Main Tank and Main Assist, use /maintank and /mainassist commands.
------------------------------------------------------------------------

do
	UnitPopupMenus["SELF"] = { "PVP_FLAG", "LOOT_METHOD", "LOOT_THRESHOLD", "OPT_OUT_LOOT_TITLE", "LOOT_PROMOTE", "DUNGEON_DIFFICULTY", "RAID_DIFFICULTY", "RESET_INSTANCES", "RAID_TARGET_ICON", "SELECT_ROLE", "CONVERT_TO_PARTY", "CONVERT_TO_RAID", "LEAVE", "CANCEL" };
	UnitPopupMenus["PET"] = { "PET_PAPERDOLL", "PET_RENAME", "PET_ABANDON", "PET_DISMISS", "CANCEL" };
	UnitPopupMenus["PARTY"] = { "MUTE", "UNMUTE", "PARTY_SILENCE", "PARTY_UNSILENCE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "PROMOTE", "PROMOTE_GUIDE", "LOOT_PROMOTE", "VOTE_TO_KICK", "UNINVITE", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "SELECT_ROLE", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" }
	UnitPopupMenus["PLAYER"] = { "WHISPER", "INSPECT", "INVITE", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" }
	UnitPopupMenus["RAID_PLAYER"] = { "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "SELECT_ROLE", "RAID_LEADER", "RAID_PROMOTE", "RAID_DEMOTE", "LOOT_PROMOTE", "RAID_REMOVE", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" };
	UnitPopupMenus["RAID"] = { "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "RAID_LEADER", "RAID_PROMOTE", "RAID_MAINTANK", "RAID_MAINASSIST", "RAID_TARGET_ICON", "LOOT_PROMOTE", "RAID_DEMOTE", "RAID_REMOVE", "PVP_REPORT_AFK", "CANCEL" };
	UnitPopupMenus["VEHICLE"] = { "RAID_TARGET_ICON", "VEHICLE_LEAVE", "CANCEL" }
	UnitPopupMenus["TARGET"] = { "RAID_TARGET_ICON", "CANCEL" }
	UnitPopupMenus["ARENAENEMY"] = { "CANCEL" }
	UnitPopupMenus["FOCUS"] = { "RAID_TARGET_ICON", "CANCEL" }
	UnitPopupMenus["BOSS"] = { "RAID_TARGET_ICON", "CANCEL" }
end
--[[
local moveUFs = CreateFrame("Frame")
moveUFs:RegisterEvent("PLAYER_ENTERING_WORLD")
moveUFs:RegisterEvent("UNIT_NAME_UPDATE")
moveUFs:RegisterEvent("RAID_ROSTER_UPDATE")
moveUFs:RegisterEvent("RAID_TARGET_UPDATE")
moveUFs:RegisterEvent("PARTY_MEMBERS_CHANGED")
moveUFs:SetScript("OnEvent", function(self)
	
	if not IsAddOnLoaded("Tukui_Raid_Healing") then return end

	if TukuiGrid:IsVisible() then
		TukuiBar1:SetWidth((T.buttonsize * 12) + (T.buttonspacing * 13) + 2)
		TukuiBar4:SetWidth((T.buttonsize * 12) + (T.buttonspacing * 13) + 2)
		ActionButton1:SetPoint("BOTTOMLEFT", T.buttonspacing+1, T.buttonspacing)
		MultiBarLeftButton1:SetPoint("TOPLEFT", TukuiBar4, T.buttonspacing+1, -T.buttonspacing)
		player:ClearAllPoints()
		target:ClearAllPoints()
		player:SetPoint("BOTTOMLEFT", InvTukuiActionBarBackground, "TOPLEFT", -40, 116)
		target:SetPoint("BOTTOMRIGHT", InvTukuiActionBarBackground, "TOPRIGHT", 40, 116)
		tot:SetAlpha(0)
	else
		TukuiBar1:SetWidth((T.buttonsize * 12) + (T.buttonspacing * 13))
		TukuiBar4:SetWidth((T.buttonsize * 12) + (T.buttonspacing * 13))
		ActionButton1:SetPoint("BOTTOMLEFT", T.buttonspacing, T.buttonspacing)
		MultiBarLeftButton1:SetPoint("TOPLEFT", TukuiBar4, T.buttonspacing, -T.buttonspacing)
		player:ClearAllPoints()
		target:ClearAllPoints()
		player:SetPoint("BOTTOMLEFT", InvTukuiActionBarBackground, "TOPLEFT", 0,8+adjustXY)
		target:SetPoint("BOTTOMRIGHT", InvTukuiActionBarBackground, "TOPRIGHT", 0,8+adjustXY)
		tot:SetAlpha(1)
	end
	end)
--]]
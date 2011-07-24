local ADDON_NAME, ns = ...
local oUF = oUFTukui or oUF
assert(oUF, "Tukui was unable to locate oUF install.")

ns._Objects = {}
ns._Headers = {}

local T, C, L = unpack(Tukui) -- Import: T - functions, constants, variables; C - config; L - locales
if not C["unitframes"].enable == true or C["unitframes"].gridonly == true then return end

local font2 = C["media"].uffont
local font1 = C["media"].font
local font = C["media"].pixelfont
local normTex = C["media"].normTex
local empathTex = C["media"].empath2

local function Shared(self, unit)
	self.colors = T.oUF_colors
	self:RegisterForClicks("AnyUp")
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	
	self.menu = T.SpawnMenu
	
	self:SetBackdrop({bgFile = C["media"].blank, insets = {top = -T.mult, left = -T.mult, bottom = -T.mult, right = -T.mult}})
	self:SetBackdropColor(0.1, 0.1, 0.1)
	
	local health = CreateFrame('StatusBar', nil, self)
	health:SetPoint("TOPLEFT")
	health:SetPoint("TOPRIGHT")
	health:Height(33*T.raidscale)
	if C["unitframes"].style == "Shag" then
	health:SetStatusBarTexture(normTex)
	elseif C["unitframes"].style == "Smelly" then
	health:SetStatusBarTexture(empathTex)
	end
	--health:SetStatusBarTexture(normTex)
	self.Health = health
	self:HighlightUnit(0,.8,0) -- R,G,B
	health.bg = health:CreateTexture(nil, 'BORDER')
	health.bg:SetAllPoints(health)
	health.bg:SetTexture(empathTex)
	health.bg:SetTexture(0.3, 0.3, 0.3)
	health.bg.multiplier = 0.3
	self.Health.bg = health.bg
		
	health.value = health:CreateFontString(nil, "OVERLAY")
	health.value:SetPoint("RIGHT", health, -3, 1)
	health.value:SetFont(font2, 12*T.raidscale, "THINOUTLINE")
	health.value:SetTextColor(1,1,1)
	health.value:SetShadowOffset(1, -1)
	self.Health.value = health.value
	
	health.PostUpdate = T.PostUpdateHealthRaid
	
	health.frequentUpdates = true
	
	if C.unitframes.unicolor == true then
		health.colorDisconnected = false
		health.colorClass = false
		health:SetStatusBarColor(.3, .3, .3, 1)
		health.bg:SetVertexColor(.1, .1, .1, 1)		
	else
		health.colorDisconnected = true
		health.colorClass = true
		health.colorReaction = true			
	end
	
	local power = CreateFrame("StatusBar", nil, self)
	power:Height(1.5*T.raidscale)
	power:Point("TOPLEFT", self.Health, "BOTTOMLEFT", 2, 4)
	power:Point("TOPRIGHT", self.Health, "BOTTOMRIGHT", -2, 4)
	if C["unitframes"].style == "Shag" then
	power:SetStatusBarTexture(normTex)
	elseif C["unitframes"].style == "Smelly" then
	power:SetStatusBarTexture(empathTex)
	end
	--power:SetStatusBarTexture(normTex)
	self.Power = power
	
	power.frequentUpdates = true
	power.colorDisconnected = true

	power.bg = self.Power:CreateTexture(nil, "BORDER")
	power.bg:SetAllPoints(power)
	power.bg:SetTexture(empathTex)
	power.bg:SetAlpha(1)
	power.bg.multiplier = 0.4
	self.Power.bg = power.bg
	
	if C.unitframes.unicolor == true then
		power.colorClass = true
		power.bg.multiplier = 0.1				
	else
		power.colorPower = true
	end
	
	local name = health:CreateFontString(nil, "OVERLAY")
    name:SetPoint("LEFT", health, 3, 0)
	name:SetFont(font, 10, "THINOUTLINE")
	name:SetShadowOffset(.5, -.5)
	self:Tag(name, "[Tukui:namemedium]")
	self.Name = name
	
    local leader = health:CreateTexture(nil, "OVERLAY")
    leader:Height(12*T.raidscale)
    leader:Width(12*T.raidscale)
    leader:SetPoint("TOPLEFT", 0, 6)
	self.Leader = leader
	
   local LFDRole = health:CreateTexture(nil, "OVERLAY")
    LFDRole:Height(14*T.raidscale)
    LFDRole:Width(14*T.raidscale)
	LFDRole:Point("TOP", 0, 10)
	LFDRole:SetTexture("Interface\\AddOns\\Tukui\\medias\\textures\\lfdicons.blp")
	self.LFDRole = LFDRole
	
	
    local MasterLooter = health:CreateTexture(nil, "OVERLAY")
    MasterLooter:Height(12*T.raidscale)
    MasterLooter:Width(12*T.raidscale)
	self.MasterLooter = MasterLooter
    self:RegisterEvent("PARTY_LEADER_CHANGED", T.MLAnchorUpdate)
    self:RegisterEvent("PARTY_MEMBERS_CHANGED", T.MLAnchorUpdate)
	
	if C["unitframes"].aggro == true then
		table.insert(self.__elements, T.UpdateThreat)
		self:RegisterEvent('PLAYER_TARGET_CHANGED', T.UpdateThreat)
		self:RegisterEvent('UNIT_THREAT_LIST_UPDATE', T.UpdateThreat)
		self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', T.UpdateThreat)
    end
		
	if C["unitframes"].showsymbols == true then
		local RaidIcon = health:CreateTexture(nil, 'OVERLAY')
		RaidIcon:Height(14*T.raidscale)
		RaidIcon:Width(14*T.raidscale)
		RaidIcon:SetPoint('CENTER', self, 'TOP')
		RaidIcon:SetTexture("Interface\\AddOns\\Tukui\\medias\\textures\\raidicons.blp") -- thx hankthetank for texture
		self.RaidIcon = RaidIcon
	end
	
	local ReadyCheck = self.Power:CreateTexture(nil, "OVERLAY")
	ReadyCheck:Height(12*T.raidscale)
	ReadyCheck:Width(12*T.raidscale)
	ReadyCheck:SetPoint('CENTER')
	self.ReadyCheck = ReadyCheck
	
    local debuffs = CreateFrame('Frame', nil, self)
    debuffs:SetPoint('LEFT', self, 'RIGHT', 4, 0)
    debuffs:SetHeight(26)
    debuffs:SetWidth(200)
    debuffs.size = 26
    debuffs.spacing = 2
    debuffs.initialAnchor = 'LEFT'
	debuffs.num = 5
	debuffs.PostCreateIcon = T.PostCreateAura
	debuffs.PostUpdateIcon = T.PostUpdateAura
	self.Debuffs = debuffs
	
	self.DebuffHighlightAlpha = 1
	self.DebuffHighlightBackdrop = true
	self.DebuffHighlightFilter = true
	
	--local picon = self.Health:CreateTexture(nil, 'OVERLAY')
	--picon:SetPoint('CENTER', self.Health)
	--picon:SetSize(16, 16)
	--picon:SetTexture[[Interface\AddOns\Tukui\medias\textures\picon]]
	--picon.Override = T.Phasing
	--self.PhaseIcon = picon
	
	--Resurrect Indicator
	local Resurrect = CreateFrame('Frame', nil, self)
	Resurrect:SetFrameLevel(20)

	local ResurrectIcon = Resurrect:CreateTexture(nil, "OVERLAY")
	ResurrectIcon:Point(health.value:GetPoint())
	ResurrectIcon:Size(30, 25)
	ResurrectIcon:SetDrawLayer('OVERLAY', 7)

	self.ResurrectIcon = ResurrectIcon
	
	if C["unitframes"].showrange == true then
		local range = {insideAlpha = 1, outsideAlpha = C["unitframes"].raidalphaoor}
		self.Range = range
	end
	
	if C["unitframes"].showsmooth == true then
		health.Smooth = true
		power.Smooth = true
	end
	
	if C["unitframes"].healcomm then
		local mhpb = CreateFrame('StatusBar', nil, self.Health)
		mhpb:SetPoint('TOPLEFT', self.Health:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
		mhpb:SetPoint('BOTTOMLEFT', self.Health:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, 0)
		mhpb:SetWidth(150*T.raidscale)
		mhpb:SetStatusBarTexture(normTex)
		mhpb:SetStatusBarColor(0, 1, 0.5, 0.25)

		local ohpb = CreateFrame('StatusBar', nil, self.Health)
		ohpb:SetPoint('TOPLEFT', mhpb:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
		ohpb:SetPoint('BOTTOMLEFT', mhpb:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, 0)
		ohpb:SetWidth(150*T.raidscale)
		ohpb:SetStatusBarTexture(normTex)
		ohpb:SetStatusBarColor(0, 1, 0, 0.25)

		self.HealPrediction = {
			myBar = mhpb,
			otherBar = ohpb,
			maxOverflow = 1,
		}
	end

	return self
end

	oUF:RegisterStyle('TukuiHealR01R15', Shared)
	oUF:Factory(function(self)
	oUF:SetActiveStyle("TukuiHealR01R15")

	local raid = self:SpawnHeader("oUF_TukuiHealRaid0115", nil, "custom [@raid16,exists] hide;show", 
	'oUF-initialConfigFunction', [[
		local header = self:GetParent()
		self:SetWidth(header:GetAttribute('initial-width'))
		self:SetHeight(header:GetAttribute('initial-height'))
	]],
	'initial-width', T.Scale(66*T.raidscale),
	'initial-height', T.Scale(33*T.raidscale),	
	"showParty", true, "showPlayer", C["unitframes"].showplayerinparty, "showRaid", true, "groupFilter", "1,2,3,4,5,6,7,8", "groupingOrder", "1,2,3,4,5,6,7,8", "groupBy", "GROUP", "yOffset", T.Scale(-4))
	
	raid:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 150) -- SHAG
	
	local pets = {} 
		pets[1] = oUF:Spawn('partypet1', 'oUF_TukuiPartyPet1') 
		pets[1]:SetPoint('TOPLEFT', raid, 'TOPLEFT', 0, -240*T.raidscale)
		pets[1]:Size(66*T.raidscale, 34*T.raidscale)
	for i =2, 4 do 
		pets[i] = oUF:Spawn('partypet'..i, 'oUF_TukuiPartyPet'..i) 
		pets[i]:SetPoint('TOP', pets[i-1], 'BOTTOM', 0, 8)
		pets[i]:Size(66*T.raidscale, 34*T.raidscale)
	end
		
	local RaidMove = CreateFrame("Frame")
	RaidMove:RegisterEvent("PLAYER_ENTERING_WORLD")
	RaidMove:RegisterEvent("RAID_ROSTER_UPDATE")
	RaidMove:RegisterEvent("PARTY_LEADER_CHANGED")
	RaidMove:RegisterEvent("PARTY_MEMBERS_CHANGED")
	RaidMove:SetScript("OnEvent", function(self)
		if InCombatLockdown() then
			self:RegisterEvent("PLAYER_REGEN_ENABLED")
		else
			self:UnregisterEvent("PLAYER_REGEN_ENABLED")
			local numraid = GetNumRaidMembers()
			local numparty = GetNumPartyMembers()
			if numparty > 0 and numraid == 0 or numraid > 0 and numraid <= 5 then
				raid:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 150)
				for i,v in ipairs(pets) do v:Enable() end
			elseif numraid > 5 and numraid <= 10 then
				raid:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 150)
				for i,v in ipairs(pets) do v:Disable() end
			elseif numraid > 10 and numraid <= 15 then
				raid:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 150)
				for i,v in ipairs(pets) do v:Disable() end
			elseif numraid > 15 then
				for i,v in ipairs(pets) do v:Disable() end
			end
		end
	end)
end)
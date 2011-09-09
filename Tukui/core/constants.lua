local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

T.dummy = function() return end
T.myname = select(1, UnitName("player"))
T.myclass = select(2, UnitClass("player"))
T.myrace = select(2, UnitRace("player"))
T.client = GetLocale() 
T.resolution = GetCVar("gxResolution")
T.getscreenheight = tonumber(string.match(T.resolution, "%d+x(%d+)"))
T.getscreenwidth = tonumber(string.match(T.resolution, "(%d+)x+%d"))
T.version = GetAddOnMetadata("Tukui", "Version")
T.srelease = GetAddOnMetadata("Tukui", "S-Release")
T.versionnumber = tonumber(T.version)
T.incombat = UnitAffectingCombat("player")
T.patch, T.build, T.releasedate, T.toc = GetBuildInfo()
T.level = UnitLevel("player")
T.myrealm = GetRealmName()
T.InfoLeftRightWidth = 370

--Check Player's Role -- Credit to Elv
local RoleUpdater = CreateFrame("Frame")
local function CheckRole(self, event, unit)
	local tree = GetPrimaryTalentTree()
	local resilience
	local resilperc = GetCombatRatingBonus(COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN)
	if resilperc > GetDodgeChance() and resilperc > GetParryChance() and UnitLevel('player') == MAX_PLAYER_LEVEL then
		resilience = true
	else
		resilience = false
	end
	if ((T.myclass == "PALADIN" and tree == 2) or 
	(T.myclass == "WARRIOR" and tree == 3) or 
	(T.myclass == "DEATHKNIGHT" and tree == 1)) and
	resilience == false or
	(T.myclass == "DRUID" and tree == 2 and GetBonusBarOffset() == 3) then
		T.Role = "Tank"
	else
		local playerint = select(2, UnitStat("player", 4))
		local playeragi	= select(2, UnitStat("player", 2))
		local base, posBuff, negBuff = UnitAttackPower("player");
		local playerap = base + posBuff + negBuff;

		if (((playerap > playerint) or (playeragi > playerint)) and not (T.myclass == "SHAMAN" and tree ~= 1 and tree ~= 3) and not (UnitBuff("player", GetSpellInfo(24858)) or UnitBuff("player", GetSpellInfo(65139)))) or T.myclass == "ROGUE" or T.myclass == "HUNTER" or (T.myclass == "SHAMAN" and tree == 2) then
			T.Role = "Melee"
		else
			T.Role = "Caster"
		end
	end
end
RoleUpdater:RegisterEvent("PLAYER_ENTERING_WORLD")
RoleUpdater:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
RoleUpdater:RegisterEvent("PLAYER_TALENT_UPDATE")
RoleUpdater:RegisterEvent("CHARACTER_POINTS_CHANGED")
RoleUpdater:RegisterEvent("UNIT_INVENTORY_CHANGED")
RoleUpdater:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
RoleUpdater:SetScript("OnEvent", CheckRole)
CheckRole()	
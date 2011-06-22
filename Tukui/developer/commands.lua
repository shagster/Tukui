-- a command to show frame you currently have mouseovered
local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
-- Align your shit, like a bawse.
SLASH_ALI1 = "/ali"
SlashCmdList["ALI"] = function(gridsize)

local defsize = 16
local w = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "(%d+)x+%d"))
local h = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)"))
local x = tonumber(gridsize) or defsize

function Grid()
ali = CreateFrame('Frame', nil, UIParent)
ali:SetFrameLevel(0)
ali:SetFrameStrata("BACKGROUND")

for i=-(w/x/2), w/x/2 do
local Aliv = ali:CreateTexture(nil, 'BACKGROUND')
Aliv:SetTexture(.5, 0, 0, 1)
Aliv:Point("CENTER", UIParent, "CENTER", i*x, 0)
Aliv:SetSize(1,h)
end
for i=-(h/x/2), h/x/2 do
local Alih = ali:CreateTexture(nil, 'BACKGROUND')
Alih:SetTexture(.5, 0, 0, 1)
Alih:Point("CENTER", UIParent, "CENTER", 0, i*x)
Alih:SetSize(w,1)
end
end

if Ali then
if ox ~= x then
ox = x
ali:Hide()
Grid()
Ali = true
print("Ali: ON")
else
ali:Hide()
print("Ali: OFF")
Ali = false
end
else
ox = x
Grid()
Ali = true
print("Ali: ON")
end
end

SLASH_FRAME1 = "/frame"
SlashCmdList["FRAME"] = function(arg)
	if arg ~= "" then
		arg = _G[arg]
	else
		arg = GetMouseFocus()
	end
	if arg ~= nil and arg:GetName() ~= nil then
		local point, relativeTo, relativePoint, xOfs, yOfs = arg:GetPoint()
		ChatFrame1:AddMessage("|cffCC0000~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
		ChatFrame1:AddMessage("Name: |cffFFD100"..arg:GetName())
		if arg:GetParent() then
			ChatFrame1:AddMessage("Parent: |cffFFD100"..arg:GetParent():GetName())
		end
 
		ChatFrame1:AddMessage("Width: |cffFFD100"..format("%.2f",arg:GetWidth()))
		ChatFrame1:AddMessage("Height: |cffFFD100"..format("%.2f",arg:GetHeight()))
		ChatFrame1:AddMessage("Strata: |cffFFD100"..arg:GetFrameStrata())
		ChatFrame1:AddMessage("Level: |cffFFD100"..arg:GetFrameLevel())
 
		if xOfs then
			ChatFrame1:AddMessage("X: |cffFFD100"..format("%.2f",xOfs))
		end
		if yOfs then
			ChatFrame1:AddMessage("Y: |cffFFD100"..format("%.2f",yOfs))
		end
		if relativeTo then
			ChatFrame1:AddMessage("Point: |cffFFD100"..point.."|r anchored to "..relativeTo:GetName().."'s |cffFFD100"..relativePoint)
		end
		ChatFrame1:AddMessage("|cffCC0000~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
	elseif arg == nil then
		ChatFrame1:AddMessage("Invalid frame name")
	else
		ChatFrame1:AddMessage("Could not find frame info")
	end
end

-- enable lua error by command
function SlashCmdList.LUAERROR(msg, editbox)
	if (msg == 'on') then
		SetCVar("scriptErrors", 1)
		-- because sometime we need to /rl to show an error on login.
		ReloadUI()
	elseif (msg == 'off') then
		SetCVar("scriptErrors", 0)
	else
		print("/luaerror on - /luaerror off")
	end
end
SLASH_LUAERROR1 = '/luaerror'

SLASH_TEST1 = "/test"
SlashCmdList["TEST"] = function()
	for _, frames in pairs({"TukuiPet", "TukuiFocus", "TukuiBoss1", "TukuiBoss2", "TukuiBoss3", "TukuiBoss4"}) do
        _G[frames].Hide = function() end
        _G[frames]:Show()
        _G[frames].unit = "player"
	end
end

SLASH_TESTARENA1 = "/testarena"
SlashCmdList["TESTARENA"] = function()
	for _, frames in pairs({"TukuiArena1", "TukuiArena2", "TukuiArena3", "TukuiArena4"}) do
        _G[frames].Hide = function() end
        _G[frames]:Show()
        _G[frames].unit = "player"
	end
end

local mes = function(msg)
	print("|cffFF6347-|r", tostring(msg))
end
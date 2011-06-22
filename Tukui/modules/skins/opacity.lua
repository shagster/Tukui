local T, C, L = unpack(select(2, ...))
if C["general"].skinblizz ~= true then return end
local function LoadSkin()
	OpacityFrame:StripTextures()
	OpacityFrame:SetTemplate("Transparent")
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)
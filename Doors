--ver 1
--Doors
local chr = game.Players.LocalPlayer.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
_G.key=false
while wait(1)do
	for _,v in pairs(workspace.CurrentRooms:GetDescendants()) do
		if v.Name=="KeyObtain"and not _G.key then
			_G.key=true
			chr:TranslateBy((v.Hitbox.Position-chr.HumanoidRootPart.Position))
			wait(0.8)
			chr:TranslateBy((v.Position*1.05-chr.HumanoidRootPart.Position))
			_G.key=false
		else
		if v.Name=="Door"and v:IsA"BasePart"and _G.key then
			chr:TranslateBy((v.Position*1.05-chr.HumanoidRootPart.Position))
		end
		end
	end
end

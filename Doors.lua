--ver 2
--Doors
local chr = game.Players.LocalPlayer.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
function goto(obj)
	while (chr.HumanoidRootPart.Position-obj.Position).magnitude > 5 do
		chr:TranslateBy((obj.Position-chr.HumanoidRootPart.Position)*0.01)
	end
end

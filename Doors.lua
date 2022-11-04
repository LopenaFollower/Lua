--ver 2
--Doors
local chr = game.Players.LocalPlayer.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
function goto(obj)
	while (chr.HumanoidRootPart.Position-obj.Position).magnitude > 5 do
		chr:TranslateBy((obj.Position-chr.HumanoidRootPart.Position)*0.5)
	end
end
_G.key=false
while wait(1)do
	for _,v in pairs(workspace.CurrentRooms:GetChildren()) do
		goto(v.Door.Door)
	end
end

local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
local hrp=chr.HumanoidRootPart

game:GetService"RunService".Heartbeat:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
		hrp=chr.HumanoidRootPart
	end)
	if plr.Backpack:FindFirstChildWhichIsA"Tool"then
		plr.Backpack:FindFirstChildWhichIsA"Tool".Parent=workspace[plr.Name]
	end
end)
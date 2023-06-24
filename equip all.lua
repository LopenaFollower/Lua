local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
local hrp=chr.HumanoidRootPart
function nearestPlr()
	local r
	for _,v in pairs(game.Players:GetChildren())do
		if v~=plr then
			if r==nil then
				r=v
			else
				if(hrp.Position-v.Character.HumanoidRootPart.Position).magnitude<(r.Character.HumanoidRootPart.Position-hrp.Position).magnitude then
					r=v
				end
			end
		end
	end
	return r.Character.HumanoidRootPart
end
game:GetService"RunService".Heartbeat:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr.Humanoid
		hrp=chr.HumanoidRootPart
	end)
	if equipAll then
		pcall(function()
			for _,v in pairs(plr.Backpack:GetChildren())do
				v.Parent=workspace[plr.Name]
			end
		end)
	end
	local nearest=nearestPlr()
	hrp.CFrame=CFrame.lookAt(hrp.Position,vector(nearest.Position.x,hrp.Position.y,nearest.Position.z))
end)
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/gui%20lib.lua")()
local UI=GUI:CreateWindow("Window","info")
local Main=UI:addPage("Main",3,true,1)
Main:addToggle("Equip all tools",false,function(v)
	equipAll=v
end)
Main:destroyGui(function()
	equipAll=false
end)
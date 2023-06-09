if game.PlaceId~=6755746130 then return else repeat wait(1)until game:IsLoaded()and game.Players.LocalPlayer end
local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
local hrp=chr and chr.HumanoidRootPart
local my={
	money=0,
	tycoon=nil,
	tpws=1
}
local tog={
	fruit=true,
	obby=true,
	button=true,
	prestige=true,
	walk=true,
	infj=false,
	tpw=false,
}
local cd={
	fruit=true,
	obby=true,
	button=true,
	prestige=true,
	walk=true,
	drops=true
}
for _,v in pairs(workspace.Tycoons:GetChildren())do
	if(v.Owner.value==nil and v.Essentials and tostring(plr.TeamColor)=="White")or(v.Owner.value==plr.Name and tostring(plr.TeamColor)=="White")then
		hrp.CFrame=v.Essentials.Entrance.CFrame
		hum:ChangeState"Jumping"
		my.tycoon=v
	end
end
wait(.1)
function getFruit()
	pcall(function()
		if workspace[plr.Name]:FindFirstChild"Pick Fruit"then
			for _,v in pairs(my.tycoon.Drops:GetChildren())do
				if v.Name~="JuiceBottle"then
					game:GetService"ReplicatedStorage".CollectFruit:FireServer(v)
				end
			end
			workspace[plr.Name]:FindFirstChild"Pick Fruit".Parent=plr.Backpack
		else
			plr.Backpack:FindFirstChild"Pick Fruit".Parent=workspace[plr.Name]
			for _,v in pairs(my.tycoon.Drops:GetChildren())do
				if v.Name~="JuiceBottle"then
					game:GetService"ReplicatedStorage".CollectFruit:FireServer(v)
				end
			end
			workspace[plr.Name]:FindFirstChild"Pick Fruit".Parent=plr.Backpack
		end
		wait()
		if workspace[plr.Name]:FindFirstChild"Pick Fruit"then
			workspace[plr.Name]:FindFirstChild"Pick Fruit".Parent=plr.Backpack
		end
	end)
end
function countFruits()
	local t=0
	if plr and plr:FindFirstChild"HeldFruits"then
		for _,v in pairs(plr.HeldFruits:GetChildren())do
			t=t+v.value
		end
	end
	return t
end
game:GetService"RunService".Heartbeat:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
		hrp=chr.HumanoidRootPart
		my.money=plr.leaderstats.Money.value
		my.tycoon=workspace.Tycoons[tostring(plr.Team)]
		my.tycoon.Essentials.JuiceMaker.Sign.SurfaceGui.TextLabel.Text=plr.PlayerGui.ObbyBillboards.ObbySignBillBoard.BottomText.Text
		if plr.PlayerGui:FindFirstChild"NotificationsGui"then
			plr.PlayerGui.NotificationsGui:Destroy()
		end
	end)
	if tog.fruit and cd.fruit and my.tycoon:FindFirstChild"Drops"and not(my.tycoon:FindFirstChild"Purchased"and my.tycoon:FindFirstChild"Purchased":FindFirstChild"Auto Collector")then
		cd.fruit=false
		pcall(function()
			if#my.tycoon.Drops:GetChildren()>=10 or plr.PlayerGui.FrenzyGui.FrenzyLabel.Visible then
				getFruit()
			end
		end)
		wait(.5)
		cd.fruit=true
	end
	if tog.button and cd.button then
		cd.button=false
		local parent_folder=nil
		pcall(function()
			if#my.tycoon.Buttons.FirstFloorButtons:GetChildren()>0 then
				parent_folder=my.tycoon.Buttons.FirstFloorButtons
			elseif#my.tycoon.Buttons.SecondFloorButtons:GetChildren()>1 then
				parent_folder=my.tycoon.Buttons.SecondFloorButtons
			else
				parent_folder=my.tycoon.Buttons.RoberryButtons
			end
		end)
		if parent_folder then
			for _,v in pairs(parent_folder:GetChildren())do
				if v:IsA"BasePart"then
					v.CanCollide=false
					v.CFrame=hrp.CFrame
					v.Size=hrp.Size
				end
				if v:FindFirstChildWhichIsA"BillboardGui"then
					v:FindFirstChildWhichIsA"BillboardGui":Destroy()
				end
			end
		end
		if my.tycoon:FindFirstChild"Buttons"then
			for _,v in pairs(my.tycoon.Buttons:GetChildren())do
				if v:IsA"BasePart"and v:FindFirstChild"ButtonLabel"then
					local price=v.ButtonLabel.CostLabel.Text:gsub("%$","")
					price=string.gsub(price,"%,","")
					if v.Name:lower():find"autocollect"then
						if my.money>=tonumber(price)then
							v.CanCollide=false
							game.TweenService:Create(v,TweenInfo.new(.1,Enum.EasingStyle.Linear),{CFrame=hrp.CFrame}):Play()
							v.Size=hrp.Size
						end
					end
					if v.Name:lower():find"floor"then
						if my.money>=tonumber(price)then
							v.CanCollide=false
							game.TweenService:Create(v,TweenInfo.new(.2,Enum.EasingStyle.Linear),{CFrame=hrp.CFrame}):Play()
							v.Size=hrp.Size
						end
					end
					if v.Name:lower():find"juicespeed"then
						if my.money>=tonumber(price)then
							v.CanCollide=false
							game.TweenService:Create(v,TweenInfo.new(.3,Enum.EasingStyle.Linear),{CFrame=hrp.CFrame}):Play()
							v.Size=hrp.Size
						end
					end
					if my.money>6e7 and v.Position.y<=12 then
						v.CanCollide=false
						v.CFrame=hrp.CFrame
						v.Size=hrp.Size
					end
				end
			end
		end
		if countFruits()>=5 and my.money<=25 and plr.leaderstats.Prestige.Value>=5 and not(my.tycoon:FindFirstChild"Purchased"and my.tycoon:FindFirstChild"Purchased":FindFirstChild"Auto Collector")then
			hrp.CFrame=my.tycoon.Essentials.JuiceMaker.AddFruitButton.CFrame
			wait()
			fireproximityprompt(my.tycoon.Essentials.JuiceMaker.AddFruitButton.PromptAttachment.AddPrompt)
		end
		wait(.1)
		cd.button=true
	end
	if cd.obby and tog.obby and tostring(workspace.ObbyParts.ObbyStartPart.BrickColor)=="Lime green"then
		cd.obby=false
		hrp.CFrame=workspace.ObbyParts.ObbyStartPart.CFrame
		wait(.3)
		getFruit()
		repeat
			hrp.CFrame=my.tycoon.Essentials.JuiceMaker.AddFruitButton.CFrame
			wait(.1)
			fireproximityprompt(my.tycoon.Essentials.JuiceMaker.AddFruitButton.PromptAttachment.AddPrompt)
		until countFruits()<=1
		cd.obby=true
	end
	if tog.prestige and cd.prestige then
		cd.prestige=false
		pcall(function()
			if(not plr.PlayerGui.FrenzyGui.FrenzyLabel.Visible or my.money>=tonumber(plr.leaderstats.Prestige.Value.."5000000"))and my.tycoon:FindFirstChild"Buttons"and my.tycoon:FindFirstChild"Buttons":FindFirstChild"Prestige"then
				if(hrp.Position-my.tycoon.Essentials.JuiceMaker.AddFruitButton.Position).magnitude>3 then
					hum.WalkToPoint=my.tycoon.Essentials.JuiceMaker.AddFruitButton.Position
					hrp.CFrame=my.tycoon.Essentials.JuiceMaker.AddFruitButton.CFrame
				end
				if my.money>=tonumber(plr.leaderstats.Prestige.Value.."5000000")then
					hum:ChangeState"Jumping"
				end
				fireproximityprompt(my.tycoon.Essentials.JuiceMaker.AddFruitButton.PromptAttachment.AddPrompt)
				my.tycoon:FindFirstChild"Buttons":FindFirstChild"Prestige".CFrame=hrp.CFrame
			end
			if my.tycoon:FindFirstChild"Purchased"and my.tycoon.Purchased:FindFirstChild"Golden Tree Statue"then
				game:GetService"ReplicatedStorage".RequestPrestige:FireServer()
			end
		end)
		wait(.5)
		cd.prestige=true
	end
	if tog.walk and cd.walk and not((not plr.PlayerGui.FrenzyGui.FrenzyLabel.Visible or my.money>=tonumber(plr.leaderstats.Prestige.Value.."5000000"))and my.tycoon:FindFirstChild"Buttons"and my.tycoon:FindFirstChild"Buttons":FindFirstChild"Prestige")then
		cd.walk=false
		local r=35
		if my.tycoon:FindFirstChild"Essentials"and hum then
			hum.WalkToPoint=my.tycoon.Essentials.SpawnLocation.Position+Vector3.new(math.random(-r,r),0,math.random(-r,r))
		end
		wait(math.random(1.5,3))
		cd.walk=true
	end
	if tog.tpw and hum then
		if hum.MoveDirection.Magnitude>0 then
			chr:TranslateBy(hum.MoveDirection*my.tpws)
		else
			chr:TranslateBy(hum.MoveDirection)
		end
	end
	if my.tycoon:FindFirstChild"Drops"and cd.drops then
		cd.drops=false
		for _,v in pairs(my.tycoon.Drops:GetChildren())do
			if v.Name~="JuiceBottle"and v.Position.y>6 then
				v.CFrame=my.tycoon:FindFirstChild"Essentials".FruitHolder.HolderBottom.CFrame-Vector3.new(math.random(-8,8),.1,math.random(-5,5))
			end
		end
		wait(.1)
		cd.drops=true
	end
end)
workspace.ObbyParts.Stages.Hard.VictoryPart.CFrame=workspace.ObbyParts.ObbyStartPart.CFrame
workspace.ObbyParts.Stages.Hard.VictoryPart.Size=workspace.ObbyParts.ObbyStartPart.Size
game.UserInputService.JumpRequest:Connect(function()
	if tog.infj and hum then
		hum:ChangeState"Jumping"
	end
end)
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/gui%20lib.lua")()
local UI=GUI:CreateWindow("FJT","v3")
local Main=UI:addPage("Main",30,true,1)
local Local=UI:addPage("Local",30,false,1)
Main:addToggle("Fruits",function(v)
	tog.fruit=v
end,tog.fruit)
Main:addToggle("Buttons",function(v)
	tog.button=v
end,tog.button)
Main:addToggle("Obby",function(v)
	tog.obby=v
end,tog.obby)
Main:addToggle("Prestige",function(v)
	tog.prestige=v
end,tog.prestige)
Main:addToggle("Randomly Walk",function(v)
	tog.walk=v
end,tog.walk)
Main:addButton("Juice",function()
	if my.tycoon and my.tycoon:FindFirstChild"Essentials"then
		repeat
			hrp.CFrame=my.tycoon.Essentials.JuiceMaker.AddFruitButton.CFrame
			wait()
			fireproximityprompt(my.tycoon.Essentials.JuiceMaker.AddFruitButton.PromptAttachment.AddPrompt)
		until countFruits()<=1
	end
end)
Local:addTextBox("WalkSpeed",hum.WalkSpeed,function(v)
	hum.WalkSpeed=tonumber(v)
end)
Local:addTextBox("JumpPower",hum.JumpPower,function(v)
	hum.JumpPower=tonumber(v)
end)
Local:addTextBox("HipHeight",hum.HipHeight,function(v)
	hum.HipHeight=tonumber(v)
end)
Local:addToggle("Inf Jump",function(v)
	tog.infj=v
end,tog.infj)
Local:addToggle("TpWalk",function(v)
	tog.tpw=v
end,tog.tpw)
Local:addTextBox("TpWalk Speed",my.tpws,function(v)
	my.tpws=tonumber(v)
end)
loadstring(game:HttpGetAsync"https://raw.githubusercontent.com/LopenaFollower/Lua/main/anti%20afk.lua")()
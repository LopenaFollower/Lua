if game.PlaceId~=6755746130 then return else repeat wait(1)until game:IsLoaded()and game.Players.LocalPlayer end
local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr.Humanoid
local hrp=chr.HumanoidRootPart
local my={
	money=0,
	prestiges=0,
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
	tpw=false
}
local cd={
	fruit=true,
	obby=true,
	button=true,
	prestige=true,
	walk=true,
	drops=true
}
local binds={}
local debug={
	min_drops_collect=1,--1
	auto_fruit_cd=.5,--.5
	min_miscbuttom_money=6e7,--6e7
	min_fruit_before_juice=5,--5
	auto_juice_stop_at="lime",
	min_prestige=15,--15
	buttons_cd=.1,--.1
	obby_cd=1,--1
	juicer_magnitude=15,--15
	prestige_cd=.25,--.25
	random_walk_range=35,--35
	min_randomwalk_wait=1.5,--1.5
	max_randomwalk_wait=3,--3
	drops_cd=.1,--.1
	button_size_x=.1,--.1
	button_size_y=.1,--.1
	button_size_z=1,--1
}
for _,v in pairs(workspace.Tycoons:GetChildren())do
	if v.Owner.value==nil and v.Essentials and my.tycoon==nil and tostring(plr.TeamColor)=="White"then
		my.tycoon=v
		hrp.CFrame=v.Essentials.Entrance.CFrame
		hum:ChangeState"Jumping"
	end
end
function findChildWithName(parent,name)
	for _,v in pairs(parent:GetChildren())do
		if v.Name:lower():find(name:lower()) then
			return true
		end
	end
	return false
end
wait()
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
binds.main=game:GetService"RunService".Heartbeat:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr.Humanoid
		hrp=chr.HumanoidRootPart
		my.money=plr.leaderstats.Money.value
		my.prestiges=plr.leaderstats.Prestige.value
		my.tycoon=workspace.Tycoons[tostring(plr.Team)]
		my.tycoon.Essentials.JuiceMaker.Sign.SurfaceGui.TextLabel.Text=plr.PlayerGui.ObbyBillboards.ObbySignBillBoard.BottomText.Text
		if plr.PlayerGui:FindFirstChild"NotificationsGui"then
			plr.PlayerGui.NotificationsGui:Destroy()
		end
	end)
	if tog.fruit and cd.fruit and my.tycoon:FindFirstChild"Drops"and not(my.tycoon:FindFirstChild"Purchased"and my.tycoon:FindFirstChild"Purchased":FindFirstChild"Auto Collector")then
		cd.fruit=false
		pcall(function()
			if#my.tycoon.Drops:GetChildren()>=debug.min_drops_collect or plr.PlayerGui.FrenzyGui.FrenzyLabel.Visible then
				getFruit()
			end
		end)
		wait(debug.auto_fruit_cd)
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
					v.Size=Vector3.new(debug.button_size_x,debug.button_size_y,debug.button_size_z)
				end
				if v:FindFirstChildWhichIsA"BillboardGui"then
					v:FindFirstChildWhichIsA"BillboardGui":Destroy()
				end
			end
		end
		if my.tycoon:FindFirstChild"Buttons"then
			for _,v in pairs(my.tycoon.Buttons:GetChildren())do
				if v:IsA"BasePart"and v:FindFirstChild"ButtonLabel"then
					local price=tonumber(v.ButtonLabel.CostLabel.Text:gsub("%,",""):match("%d+"))
					v.CanCollide=false
					v.Size=Vector3.new(debug.button_size_x,debug.button_size_y,debug.button_size_z)
					if v.Name:lower():find"autocollect"then
						if my.money>=price then
							game.TweenService:Create(v,TweenInfo.new(.01,Enum.EasingStyle.Linear),{CFrame=hrp.CFrame}):Play()
						end
					elseif v.Name:lower():find"floor"then
						if my.money>=price then
							game.TweenService:Create(v,TweenInfo.new(.0125,Enum.EasingStyle.Linear),{CFrame=hrp.CFrame}):Play()
						end
					elseif v.Name:lower():find"juicespeed"and tonumber(string.match(v.Name,"%d"))<6 and my.money>=loadstring("return 5e"..string.match(v.Name,"%d"))()then
						if my.money>=price then
							game.TweenService:Create(v,TweenInfo.new(.015,Enum.EasingStyle.Linear),{CFrame=hrp.CFrame}):Play()
						end
					elseif my.money>debug.min_miscbuttom_money and v.Position.y<=12 then
						v.CFrame=hrp.CFrame
					end
				end
			end
		end
		if countFruits()>=debug.min_fruit_before_juice and not findChildWithName(my.tycoon.Purchased,debug.auto_juice_stop_at)and my.prestiges>=debug.min_prestige then
			hrp.CFrame=my.tycoon.Essentials.JuiceMaker.AddFruitButton.CFrame
			wait()
			fireproximityprompt(my.tycoon.Essentials.JuiceMaker.AddFruitButton.PromptAttachment.AddPrompt)
		end
		wait(debug.buttons_cd)
		cd.button=true
	end
	if cd.obby and tog.obby and tostring(workspace.ObbyParts.ObbyStartPart.BrickColor)=="Lime green"then
		cd.obby=false
		repeat
			if tostring(workspace.ObbyParts.ObbyStartPart.BrickColor)=="Lime green"then
				hrp.CFrame=workspace.ObbyParts.ObbyStartPart.CFrame
				hum.WalkToPoint=workspace.ObbyParts.ObbyStartPart.Position
				hum:ChangeState"Jumping"
				wait(.4)
			end
		until tostring(workspace.ObbyParts.ObbyStartPart.BrickColor)~="Lime green"
		getFruit()
		repeat
			hrp.CFrame=my.tycoon.Essentials.JuiceMaker.AddFruitButton.CFrame
			wait(.1)
			fireproximityprompt(my.tycoon.Essentials.JuiceMaker.AddFruitButton.PromptAttachment.AddPrompt)
		until countFruits()<=1
		wait(debug.obby_cd)
		cd.obby=true
	end
	if tog.prestige and cd.prestige then
		cd.prestige=false
		pcall(function()
			if(not plr.PlayerGui.FrenzyGui.FrenzyLabel.Visible or my.money>=tonumber(my.prestiges.."5000000"))and my.tycoon:FindFirstChild"Buttons"and my.tycoon:FindFirstChild"Buttons":FindFirstChild"Prestige"then
				if(hrp.Position-my.tycoon.Essentials.JuiceMaker.AddFruitButton.Position).magnitude>debug.juicer_magnitude then
					hum.WalkToPoint=my.tycoon.Essentials.JuiceMaker.AddFruitButton.Position
				end
				if my.money>=tonumber(my.prestiges.."5000000")and not hum.Jump and hum:GetState()~=Enum.HumanoidStateType.Freefall then
					hum:ChangeState"Jumping"
				end
				fireproximityprompt(my.tycoon.Essentials.JuiceMaker.AddFruitButton.PromptAttachment.AddPrompt)
				my.tycoon:FindFirstChild"Buttons":FindFirstChild"Prestige".CFrame=hrp.CFrame
			end
			if my.tycoon:FindFirstChild"Purchased"and my.tycoon.Purchased:FindFirstChild"Golden Tree Statue"then
				game:GetService"ReplicatedStorage".RequestPrestige:FireServer()
			end
		end)
		wait(debug.prestige_cd)
		cd.prestige=true
	end
	if tog.walk and cd.walk and not((not plr.PlayerGui.FrenzyGui.FrenzyLabel.Visible or my.money>=tonumber(my.prestiges.."5000000"))and my.tycoon:FindFirstChild"Buttons"and my.tycoon:FindFirstChild"Buttons":FindFirstChild"Prestige")then
		cd.walk=false
		local r=debug.random_walk_range
		if my.tycoon:FindFirstChild"Essentials"and hum then
			hum.WalkToPoint=my.tycoon.Essentials.SpawnLocation.Position+Vector3.new(math.random(-r,r),0,math.random(-r,r))
		end
		wait(math.random(debug.min_randomwalk_wait,debug.max_randomwalk_wait))
		cd.walk=true
	end
	if tog.tpw and chr and hum then
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
		wait(debug.drops_cd)
		cd.drops=true
	end
end)
workspace.ObbyParts.Stages.Hard.VictoryPart.CFrame=workspace.ObbyParts.ObbyStartPart.CFrame-Vector3.new(0,3.3,0)
workspace.ObbyParts.Stages.Hard.VictoryPart.Size=Vector3.new(2,2,2)
workspace.ObbyParts.Stages.Hard.VictoryPart.CanCollide=false
binds.jump=game.UserInputService.JumpRequest:Connect(function()
	if tog.infj and hum then
		hum:ChangeState"Jumping"
	end
end)
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/gui%20lib.lua")()
local UI=GUI:CreateWindow("FJT","v3.4")
local Main=UI:addPage("Main",30,true,1)
local Local=UI:addPage("Local",30,false,1)
local Stats=UI:addPage("Stats",30,false,1)
local Debugging=UI:addPage("Debugging",30,false,1)
Main:addToggle("Fruits",tog.fruit,function(v)
	tog.fruit=v
end)
Main:addToggle("Buttons",tog.button,function(v)
	tog.button=v
end)
Main:addToggle("Obby",tog.obby,function(v)
	tog.obby=v
end)
Main:addToggle("Prestige",tog.prestige,function(v)
	tog.prestige=v
end)
Main:addToggle("Randomly Walk",tog.walk,function(v)
	tog.walk=v
end)
Main:addButton("Juice",function()
	if my.tycoon and my.tycoon:FindFirstChild"Essentials"then
		repeat
			hrp.CFrame=my.tycoon.Essentials.JuiceMaker.AddFruitButton.CFrame
			wait()
			fireproximityprompt(my.tycoon.Essentials.JuiceMaker.AddFruitButton.PromptAttachment.AddPrompt)
		until countFruits()<=1
	end
end)
Local:addTextBox("WalkSpeed",game.StarterPlayer.CharacterWalkSpeed,function(v)
	hum.WalkSpeed=tonumber(v)
end)
Local:addTextBox("JumpPower",game.StarterPlayer.CharacterJumpPower,function(v)
	hum.JumpPower=tonumber(v)
end)
Local:addTextBox("HipHeight",hum.HipHeight,function(v)
	hum.HipHeight=tonumber(v)
end)
Local:addToggle("Inf Jump",tog.infj,function(v)
	tog.infj=v
end)
Local:addToggle("TpWalk",tog.tpw,function(v)
	tog.tpw=v
end)
Local:addTextBox("TpWalk Speed",my.tpws,function(v)
	my.tpws=tonumber(v)
end)
Local:destroyGui(function()
	for _,v in pairs(binds)do
		v:Disconnect()
	end
end)
task.spawn(function()
	local stats={}
	while wait(1)do
		pcall(function()
			for _,v in pairs(stats)do
				v:remove()
			end
			for _,v in pairs(plr.PlayerGui.MenusGui.StatsFrame.ScrollerHolder.ScrollingFrame:GetChildren())do
				if v:IsA"ImageLabel"then
					stats[#stats+1]=Stats:addLabel(v.StatLabel.Text,v.AmountLabel.Text)
				end
			end
		end)
	end
end)
for k,v in pairs(debug)do
	Debugging:addTextBox(k,v,function(i)
		local val=i
		if val and type(tonumber(val))=="number"and tonumber(val)>=0 and tonumber(val)<=1e9 then
			debug[k]=tonumber(val)
		elseif val and type(val)=="string"and val:len()>0 then
			debug[k]=val
		end
	end)
end
loadstring(game:HttpGetAsync"https://raw.githubusercontent.com/LopenaFollower/Lua/main/anti%20afk.lua")()
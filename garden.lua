local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr:FindFirstChildWhichIsA"Humanoid"
local hrp=chr.HumanoidRootPart
local tog={
	sell=false,
	moonlit=false,
	harvest=false,
	tpw=false,
	infj=false,
	wander=false,
	hideplants=false,
	eggs=false,
	feed=false
}
local seeds={
	{"Carrot",false},
	{"Strawberry",false},
	{"Blueberry",false},
	{"Orange Tulip",false},
	{"Tomato",false},
	{"Corn",false},
	{"Daffodil",false},
	{"Watermelon",false},
	{"Pumpkin",false},
	{"Apple",false},
	{"Bamboo",false},
	{"Coconut",false},
	{"Cactus",false},
	{"Dragon Fruit",false},
	{"Mango",false},
	{"Grape",false},
	{"Mushroom",false},
	{"Pepper",false},
	{"Cacao",false},
	{"Beanstalk",false},
}
local gears={
	{"Watering Can",false},
	{"Trowel",false},
	{"Recall Wrench",false},
	{"Basic Sprinkler",false},
	{"Advanced Sprinkler",false},
	{"Godly Sprinkler",false},
	{"Lightning Rod",false},
	{"Master Sprinkler",false},
}
local event={
	{"Mysterious Crate",false},
	{"Night Egg",false},
	{"Night Seed Pack",false},
	{"Blood Banana",false},
	{"Moon Melon",false},
	{"Star Caller",false},
	{"Blood Hedgehod",false},
	{"Blood Kiwi",false},
	{"Blood Owl",false},
}
local cd={
	harvest=true,
	seeds=true,
	gears=true,
	sell=true,
	moonlit=true,
	wander=true,
	hideplants=true,
	eggs=true
}
local vals={
	tpws=5,
	harvestmode="Aura"
}
local binds={}
if not workspace:FindFirstChild"platform"then
	local p=Instance.new("Part",workspace)
	p.Name="platform"
	p.Transparency=1
	p.Size=Vector3.new(3,.1,3)
	p.Anchored=true
	p.CFrame=CFrame.new(0,0,0)
end
local platform=workspace:FindFirstChild"platform"
local vi=game:GetService"VirtualInputManager"
local rs=game:GetService"ReplicatedStorage"
local GE=rs.GameEvents
local UserFarm=nil
for _,v in pairs(workspace.Farm:GetChildren())do
	if v.Important.Data.Owner.Value==plr.Name then
		UserFarm=v
	end
end
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/gui%20lib.lua")()
local UI=GUI:CreateWindow"Garden"
function mouse(x,y,d,l)
	vi:SendMouseButtonEvent(x,y,0,d,l or game,0)
end
binds.main=game:GetService"RunService".RenderStepped:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr.Humanoid
		hrp=chr.HumanoidRootPart
	end)
	if tog.tpw and chr and hum then
		if hum.MoveDirection.Magnitude>0 then
			chr:TranslateBy(hum.MoveDirection*vals.tpws/5)
		end
	end
	if tog.moonlit and cd.moonlit then
		cd.moonlit=false
		GE.NightQuestRemoteEvent:FireServer"SubmitAllPlants"
		task.wait(.2)
		cd.moonlit=true
	end
	if tog.sell and cd.sell then
		if#plr.Backpack:GetChildren()>199 then
			cd.sell=false
			local pos=hrp.CFrame
			repeat
				hrp.CFrame=workspace.Tutorial_Points.Tutorial_Point_2.CFrame
				task.wait()
				GE.Sell_Inventory:FireServer()
			until not tog.sell or#plr.Backpack:GetChildren()<200
			hrp.CFrame=pos
			cd.sell=true
		end
	end
	if tog.harvest and cd.harvest then
		cd.harvest=false
		pcall(function()
			if vals.harvestmode=="Aura"then
				for _,v in pairs(UserFarm.Important.Plants_Physical:GetDescendants())do
					if v:IsA"ProximityPrompt"and(v.Parent.Position-hrp.Position).Magnitude<17 then
						fireproximityprompt(v)
					end
				end
				task.wait(.1)
			else
				local ps=UserFarm.Important.Plants_Physical:GetChildren()
				local fs=ps[math.random(1,#ps)].Fruits:GetChildren()
				local f=fs[math.random(1,#fs)]
				for _,v in pairs(f:GetChildren())do
					local p=v:FindFirstChildWhichIsA"ProximityPrompt"
					if p then
						fireproximityprompt(p)
						break
					end
				end
			end
		end)
		cd.harvest=true
	end
	if cd.seeds then
		cd.seeds=false
		for k,v in pairs(seeds)do
			if v[2]then
				for i=0,5 do
					GE.BuySeedStock:FireServer(v[1])
				end
			end
		end
		task.wait(.5)
		cd.seeds=true
	end
	if cd.gears then
		cd.gears=false
		for k,v in pairs(gears)do
			if v[2]then
				for i=0,5 do
					GE.BuyGearStock:FireServer(v[1])
				end
			end
		end
		task.wait(1)
		cd.gears=true
	end
	if cd.evshop then
		cd.evshop=false
		for k,v in pairs(event)do
			if v[2]then
				for i=0,5 do
					GE.BuyEventShopStock:FireServer(v[1])
				end
			end
		end
		task.wait(1)
		cd.evshop=true
	end
	if tog.wander and cd.wander and#plr.Backpack:GetChildren()<200 then
		cd.wander=false
		local timeout=false
		local p,s=UserFarm.PetArea.Position,UserFarm.PetArea.Size
		local goal=nil
		local ps=UserFarm.Important.Plants_Physical:GetChildren()
		pcall(function()
			local fs=ps[math.random(1,#ps)].Fruits:GetChildren()
			for _,v in pairs(fs[math.random(1,#fs)]:GetChildren())do
				local p=v:FindFirstChildWhichIsA"ProximityPrompt"
				if p then
					goal=p.Parent.Position+Vector3.new(0,4,0)
					break
				end
			end
			game.TweenService:Create(hrp,TweenInfo.new(.5,Enum.EasingStyle.Linear),{CFrame=CFrame.new(goal.X,goal.Y,goal.Z)}):Play()
			task.spawn(function()
				task.wait(5)
				timeout=true
			end)
			repeat
				task.wait()
				platform.CFrame=hrp.CFrame-Vector3.new(0,2.1,0)
			until(goal-hrp.Position).Magnitude<2 or timeout
		end)
		cd.wander=true
	end
	if tog.hideplants and cd.hideplants then
		cd.hideplants=false
		for _,v in pairs(UserFarm.Important.Plants_Physical:GetChildren())do
			for _,i in pairs(v:GetChildren())do
				if"number"==type(tonumber(i.Name))and(i:IsA"BasePart"or i:IsA"MeshPart")then
					i.CanCollide=false
					i.Transparency=1
				end
				if i.Name=="Branches"then
					for _,k in pairs(i:GetDescendants())do
						if k:IsA"BasePart"or k:IsA"MeshPart"then
							k.CanCollide=false
							k.Transparency=1
						end
					end
				end
			end
		end
		task.wait(.25)
		cd.hideplants=true
	end
	if tog.eggs and cd.eggs then
		cd.eggs=false
		for i=1,3 do
			GE.BuyPetEgg:FireServer(i)
		end
		task.wait(1)
		cd.eggs=true
	end
	if tog.feed then
		local p=nil
		for _,v in pairs(workspace:GetChildren())do
			p="Part"==v.Name and v:FindFirstChild"ProximityPrompt"
			if p then break end
		end
		p.HoldDuration=0
		p.MaxActivationDistance=10^100
		if p.Enabled then
			fireproximityprompt(p)
		end
	end
end)
binds.jump=game.UserInputService.JumpRequest:Connect(function()
	if tog.infj and hum then
		hum:ChangeState"Jumping"
	end
end)
local Main=UI:addPage("Main",1,true)
local Seeds=UI:addPage("Seeds",2.6)
local Gears=UI:addPage("Gears",1.05)
local EvShop=UI:addPage("Gears",1.05)
local Pets=UI:addPage("Pets",1)
local Local=UI:addPage("Local Player",1)
Main.addDropdown("Harvest Mode",{"Aura","Random"},nil,function(v)
	vals.harvestmode=v
end)
Main.addToggle("Harvest",tog.harvest,function(v)
	tog.harvest=v
end)
Main.addToggle("Auto Sell",tog.sell,function(v)
	tog.sell=v
end)
Main.addButton("Manual Sell",function()
	local pos=hrp.CFrame
	hrp.CFrame=workspace.Tutorial_Points.Tutorial_Point_2.CFrame
	task.wait(.1)
	repeat 
		GE.Sell_Inventory:FireServer()
		task.wait(.1)
	until not tog.sell or#plr.Backpack:GetChildren()<200
	hrp.CFrame=pos
end)
Main.addToggle("Give Moonlit Fruits",tog.moonlit,function(v)
	tog.moonlit=v
end)
Main.addToggle("Wander",tog.wander,function(v)
	tog.wander=v
end)
Main.addToggle("Render Plants",not tog.hideplants,function(v)
	tog.hideplants=not v
	for _,k in pairs(UserFarm.Important.Plants_Physical:GetChildren())do
		for _,i in pairs(k:GetChildren())do
			if"number"==type(tonumber(i.Name))and(i:IsA"BasePart"or i:IsA"MeshPart")then
				i.CanCollide=false
				i.Transparency=v and 0 or 1
			end
		end
	end
end)
for _,v in pairs({unpack(seeds)})do
	Seeds.addToggle(v[1],false,function(n)
		for k,j in pairs(seeds)do
			if j[1]==v[1]then
				seeds[k][2]=n
			end
		end
	end)
end
for _,v in pairs({unpack(gears)})do
	Gears.addToggle(v[1],false,function(n)
		for k,j in pairs(gears)do
			if j[1]==v[1]then
				gears[k][2]=n
			end
		end
	end)
end
for _,v in pairs({unpack(event)})do
	EvShop.addToggle(v[1],false,function(n)
		for k,j in pairs(event)do
			if j[1]==v[1]then
				event[k][2]=n
			end
		end
	end)
end
Pets.addToggle("Buy Eggs",tog.eggs,function(v)
	tog.eggs=v
	if v then
		for i=1,3 do
			GE.BuyPetEgg:FireServer(i)
		end
	end
end)
Pets.addToggle("Feed",tog.feed,function(v)
	tog.feed=v
end)
Local.addToggle("Inf Jump",tog.infj,function(v)
	tog.infj=v
end)
Local.addToggle("TP Walk",tog.tpw,function(v)
	tog.tpw=v
end)
Local.addSlider("TPWalk Speed",{min=0,max=150,default=vals.tpws},function(v)
	vals.tpws=v
end)
Local.addToggle("Invis Cam",false,function(v)
	plr.CameraMaxZoomDistance=300
	plr.DevCameraOcclusionMode=v and Enum.DevCameraOcclusionMode.Invisicam or Enum.DevCameraOcclusionMode.Zoom
end)
Local.addButton("Inf Yield",loadstring(game:HttpGet"https://infyiff.github.io/resources/IY_FE.txt"))
Local.destroyGui(function()
	for i,v in pairs(binds)do v:Disconnect()end
	for i,v in pairs(tog)do tog[i]=false end
end)
local args = {
	vector.create(20.227279663085938, 0.1355254054069519, 55.632606506347656),
	"Carrot"
}
--game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Plant_RE"):FireServer(unpack(args))
local args = {
	buffer.fromstring("\002")
}
--game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable"):FireServer(unpack(args)) -- daily quest
--[[
make moonlit submit smarter
harvest filters
	- weight
	- mutatuon
	- type
auto place/hatch eggs
auto place one-time plants
pet feeding(if possible)
]]
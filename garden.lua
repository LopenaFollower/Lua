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
	hideplants=false
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
local cd={
	harvest=true,
	seeds=true,
	sell=true,
	moonlit=true,
	wander=true,
	hideplants=true
}
local vals={
	tpws=5,
	harvestmode="Aura"
}
local binds={}
if not workspace:FindFirstChild"platform"then
	local p=Instance.new"Part"
	p.Name="platform"
	p.Parent=workspace
	p.Transparency=1
	p.Size=Vector3.new(1,.1,1)
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
				task.wait(.1)
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
					if v:IsA"ProximityPrompt"and(v.Parent.Position-hrp.Position).Magnitude<15 then
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
		pcall(function()
			for k,v in pairs(seeds)do
				if v[2]then
					for i=0,5 do
						GE.BuySeedStock:FireServer(v[1])
					end
				end
			end
		end)
		task.wait(.5)
		cd.seeds=true
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
					goal=p.Parent.Position
					break
				end
			end
			hum:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
			game.TweenService:Create(hrp,TweenInfo.new(math.random(1,3),Enum.EasingStyle.Linear),{CFrame=CFrame.new(goal.X,goal.Y,goal.Z)}):Play()
			task.spawn(function()
				task.wait(5)
				timeout=true
			end)
			repeat
				task.wait()
				platform.CFrame=hrp.CFrame-Vector3.new(0,2,0)
			until(goal-hrp.Position).Magnitude<2 or timeout
		end)
		cd.wander=true
	end
	if cd.hideplants then
		cd.hideplants=false
		for _,v in pairs(UserFarm.Important.Plants_Physical:GetChildren())do
			for _,i in pairs(v:GetChildren())do
				if"number"==type(tonumber(i.Name))and(i:IsA"BasePart"or i:IsA"MeshPart")then
					i.CanCollide=false
					i.Transparency=tog.hideplants and 1 or 0
				end
			end
		end
		task.wait(1)
		cd.hideplants=true
	end
end)
binds.jump=game.UserInputService.JumpRequest:Connect(function()
	if tog.infj and hum then
		hum:ChangeState"Jumping"
	end
end)
local Main=UI:addPage("Main",1,true,1)
local Seeds=UI:addPage("Seeds",2.6)
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
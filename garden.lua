local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr:FindFirstChildWhichIsA"Humanoid"
local hrp=chr.HumanoidRootPart
local tog={
	sell=false,
	moonlit=false,
	harvest=false,
	tpw=false,
	infj=false
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
}
local cd={
	harvest=true,
	seeds=true,
	sell=true,
	moonlit=true
}
local vals={
	tpws=5
}
local binds={}
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
function vec2d(v3)
	return Vector2.new(v3.x,v3.z)
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
	if tog.sell and cd.sell then
		if#plr.Backpack:GetChildren()>199 then
			cd.sell=false
			local pos=hrp.CFrame
			hrp.CFrame=workspace.Tutorial_Points.Tutorial_Point_2.CFrame
			task.wait(.1)
			repeat 
				GE.Sell_Inventory:FireServer()
				task.wait(.1)
			until not tog.sell or#plr.Backpack:GetChildren()<200
			hrp.CFrame=pos
			cd.sell=true
		end
	end
	if tog.harvest and cd.harvest then
		cd.harvest=false
		local count=0
		pcall(function()
			for _,v in pairs(UserFarm.Important.Plants_Physical:GetDescendants())do
				if count>75 then break end
				if v:IsA"ProximityPrompt"and(v.Parent.Position-hrp.Position).Magnitude<25 then
					fireproximityprompt(v)
					count+=1
				end
			end
		end)
		task.wait(.1)
		cd.harvest=true
	end
	if tog.moonlit and cd.moonlit then
		cd.moonlit=false
		GE.NightQuestRemoteEvent:FireServer"SubmitAllPlants"
		task.wait(.2)
		cd.moonlit=true
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
		task.wait(.2	)
		cd.seeds=true
	end
end)
binds.jump=game.UserInputService.JumpRequest:Connect(function()
	if tog.infj and hum then
		hum:ChangeState"Jumping"
	end
end)
local Main=UI:addPage("Main",1,true,1)
local Seeds=UI:addPage("Seeds",2.475)
local Local=UI:addPage("Local Player",2.475)
Main.addToggle("Harvest Aura",tog.harvest,function(v)
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
Local.destroyGui(function()
	for i,v in pairs(binds)do v:Disconnect()end
	for i,v in pairs(tog)do tog[i]=false end
end)
local args = {
	vector.create(20.227279663085938, 0.1355254054069519, 55.632606506347656),
	"Carrot"
}
--game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Plant_RE"):FireServer(unpack(args))
if game.PlaceId~=537413528 then
	return
end
repeat
	wait(1)
until game:IsLoaded()and game.Players.LocalPlayer
local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
local hrp=chr.HumanoidRootPart

local farm_status=false
local farm_speed=15
local goal_x=8473
local binds={}
local permin_gold=0
local delete={
	["TitaniumBlock"]=true,
	["SwitchBig"]=true,
	["SonicJetTurbine"]=true,
	["BalloonBlock"]=true,
	["MarbleBlock"]=true,
	["ObsidianBlock"]=true,
	["FabricBlock"]=true,
	["NeonBlock"]=true,
	["ConcreteBlock"]=true,
	["CarSeat"]=true,
	["MetalBlock"]=true,
	["WoodBlock"]=true,
	["Piston"]=true,
	["BackWheel"]=true,
	["Trees"]=true,
	["Thruster"]=true,
	["Seat"]=true,
	["Steel I-Beam"]=true,
	["Glue"]=true,
	["Hinge"]=true,
	["RustedBlock"]=true,
	["GlassBlock"]=true,
	["MetalRod"]=true,
	["Truss"]=true,
	["WoodDoor"]=true,
	["TreasureSmall"]=true,
	["WoodRod"]=true,
	["CoalBlock"]=true,
	["Window"]=true,
	["RustedRod"]=true,
	["Lamp"]=true,
	["StoneBlock"]=true,
	["TreasureMedium"]=true,
	["TreasureLarge"]=true,
	["Torch"]=true,
	["GrassBlock"]=true,
	["Mast"]=true,
	["Switch"]=true,
	["Camera"]=true,
	["WoodTrapDoor"]=true,
	["Throne"]=true,
	["PlasticBlock"]=true,
	["CandyBlue"]=true,
	["IceBlock"]=true,
	["Wedge"]=true,
	["JetPack"]=true,
	["BoatMotor"]=true,
	["ConcreteRod"]=true,
	["Motor"]=true,
	["SandBlock"]=true,
	["Cake"]=true,
	["Chair"]=true,
	["TNT"]=true,
	["SpringFlowers"]=true,
	["Egg"]=true,
	["BrickBlock"]=true,
	["Servo"]=true,
	["TitaniumRod"]=true,
	["PilotSeat"]=true,
	["JetPackEaster"]=true,
	["UltraThruster"]=true,
	["Portal"]=true,
	["GoldBlock"]=true,
	["SandUnderWater"]=true,
	["Harpoon"]=true,
	["ShieldGenerator"]=true,
	["FrontWheel"]=true,
	["Step"]=true,
	["Trophy1st"]=true,
	["Helm"]=true,
	["LightBulb"]=true,
	["Trophy2nd"]=true,
	["Sign"]=true,
	["Cannon"]=true,
	["JetTurbine"]=true,
	["Button"]=true,
	["LockedDoor"]=true,
	["Trophy3rd"]=true,
	["MarbleRod"]=true,
	["Delay"]=true,
	["Spring"]=true,
	["SpikeTrap"]=true,
	["MiniGun"]=true,
	["CornerWedge"]=true,
	["StoneRod"]=true,
	["CornerWedge"]=true,
	["CornerWedge"]=true,
	["CornerWedge"]=true,
	["CornerWedge"]=true,
	["CornerWedge"]=true,
	["CornerWedge"]=true,
	["CornerWedge"]=true,
}
function a()
	hrp.CFrame=CFrame.new(-56,30,1140)
	if goal_x<8450 then
		game.TweenService:Create(hrp,TweenInfo.new(farm_speed/15,Enum.EasingStyle.Linear),{CFrame=CFrame.new(-56,30,goal_x)}):Play()
	else
		game.TweenService:Create(hrp,TweenInfo.new(farm_speed,Enum.EasingStyle.Linear),{CFrame=CFrame.new(-56,30,goal_x)}):Play()
	end
	repeat
		hrp.Velocity=Vector3.new(0,1,0)
		wait()
	until(hrp.Position-Vector3.new(-53,hrp.Position.y,goal_x)).magnitude<10 or not hum
	wait(.1)
	hrp.CFrame=CFrame.new(-56,-360,9496)
end
function permin(inp)
	permin_gold=permin_gold+inp
	local sp=60
	for i=1,sp do
		permin_gold=permin_gold-(inp/sp)
		wait(60/sp)
	end
end
binds.died=hum.Died:Connect(function()
	binds.chat:Disconnect()
end)
binds.chat=plr.PlayerGui.GainedGoldGui.SlideDownFrame.ChildAdded:Connect(function(v)
	if v.Name=="GainClone"then
		permin(tonumber(string.match(v:FindFirstChildWhichIsA"TextLabel".Text,"%d+")))
	end
end)
workspace.ChildAdded:Connect(function(v)
	workspace.ClaimRiverResultsGold:FireServer()
	wait(1)
	for _,v2 in pairs(workspace:GetChildren())do
		if delete[v2.Name]and v2:IsA"Model"then
			v2:Destroy()
		end
	end
	binds.chat:Disconnect()
	binds.chat=plr.PlayerGui.GainedGoldGui.SlideDownFrame.ChildAdded:Connect(function(v)
		if v.Name=="GainClone"then
			permin(tonumber(string.match(v:FindFirstChildWhichIsA"TextLabel".Text,"%d+")))
		end
	end)
	if v:IsA"Model"and v.Name==plr.Name and farm_status then
		a()
	end
end)
game.RunService.Heartbeat:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
		hrp=chr.HumanoidRootPart
		workspace[plr.Name].HumanoidRootPart.GroupLabel.TextLabel.Text=math.round(permin_gold*10)/10
	end)
end)
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/not%20my%20gui%20lib.lua")()
local UI=GUI:CreateWindow("BABFB","beta 1")
local Main=UI:addPage("Main",3,true,1)
Main:addToggle("Start",function(v)
	farm_status=v
	if v then
		a()
	end
end)
Main:addToggle("Gold or Gold Blocks",function(v)
	if v then
		goal_x=2240
	else
		goal_x=8473
	end
end)
Main:addSlider("Speed",10,50,function(val)
	farm_speed=tonumber(val)
end)

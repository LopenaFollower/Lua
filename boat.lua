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
local farm_speed=23
local goal=8425
local die=false
local binds={}
local autobuy={
	item=nil,
	s=false
}
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
	["Flag"]=true,
	["ParachuteBlock"]=true,
	["CornerWedge"]=true,
	["CornerWedge"]=true,
	["CornerWedge"]=true,
	["CornerWedge"]=true,
	["CornerWedge"]=true,
}
local items={
	"Common Chest",
	"Uncommon Chest",
	"Rare Chest",
	"Epic Chest",
	"Legendary Chest",
	"Sign",
	"BoatMotor",
	"Car Parts",
	"Balloons",
	"JetPacks",
	"",
	"Parachutes",
	"Shield Generators",
	"Harpoon",
	"Note",
	"HingeBlocks",
	"Delay",
	"Pistons",
	"Locked Doors",
	"Magnets",
	"PVP Pack",
	"LegacyCarPack",
	"Switch",
	"Button",
	"LightBulb",
	"Camera",
	"CameraDome",
	"SpikeTrap",
	"Cannon",
	"MiniGun",
	"CannonTurret",
	"WoodBlock",
	"SmootWoodBlock",
	"GlassBlock",
	"StoneBlock",
	"FabricBlock",
	"PlasticBlock",
	"GrassBlock",
	"SandBlock",
	"RustedBlock",
	"BouncyBlock",
	"MetalBlock",
	"ConcreteBlock",
	"IceBlock",
	"CoalBlock",
	"BrickBlock",
	"MarbleBlock",
	"TitaniumBlock",
	"ObsidianBlock"
}
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
	wait(.2)
	for _,v2 in pairs(workspace:GetChildren())do
		if delete[v2.Name]and v2:IsA"Model"then
			v2:Destroy()
		end
	end
	binds.chat:Disconnect()
	pcall(function()
		binds.chat=plr.PlayerGui.GainedGoldGui.SlideDownFrame.ChildAdded:Connect(function(v)
			if v.Name=="GainClone"then
				permin(tonumber(string.match(v:FindFirstChildWhichIsA"TextLabel".Text,"%d+")))
			end
		end)
	end)
	for _,i in pairs(workspace.BoatStages.NormalStages.TheEnd:GetChildren()) do
		if i.Name~="GoldenChest"then
			i:Destroy()
		end
		if i:FindFirstChild"Cap"then
			i:FindFirstChild"Cap":Destroy()
		end
	end
end)
game:GetService"RunService".Heartbeat:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
		hrp=chr.HumanoidRootPart
		workspace[plr.Name].HumanoidRootPart.GroupLabel.TextLabel.Text=math.round(permin_gold*100)/100
	end)
	if hrp.CFrame.z<(goal-1000) then
		workspace.ClaimRiverResultsGold:FireServer()
	end
	if farm_status then
		if hrp.CFrame.z<760 then
			hrp.CFrame=CFrame.new(-56,30,1000)
			game.TweenService:Create(hrp,TweenInfo.new(farm_speed,Enum.EasingStyle.Linear),{CFrame=CFrame.new(-56,30,goal+10)}):Play()
		end
		hrp.Velocity=Vector3.new(0,1,0)
		wait()
		if hrp.Position.z>goal then
			hrp.CFrame=CFrame.new(-56,-360,9496)
			if die and hum then
				hum:Destroy()
				workspace.CurrentCamera.CameraSubject=chr
			end
			wait(1)
			workspace.ClaimRiverResultsGold:FireServer()
			wait(10)
			if hrp.Position.z>goal then
				hum:Destroy()
				workspace.CurrentCamera.CameraSubject=chr
			end
		end
	end
	if autobuy.s and autobuy.item~=nil then
		workspace:WaitForChild("ItemBoughtFromShop"):InvokeServer(autobuy.item,1)
	end
	if not workspace:FindFirstChild"standing"then
		local p=Instance.new"Part"
		p.Name="standing"
		p.Parent=workspace
		p.Transparency=.9
		p.Size=Vector3.new(10,0,10)
		p.Anchored=true
		p.CFrame=CFrame.new(-268,100,446)
	end
	hrp.AssemblyAngularVelocity=Vector3.new(0,0,0)
	hrp.AssemblyLinearVelocity=Vector3.new(0,0,0)
	workspace:FindFirstChild"standing".CFrame=hrp.CFrame-Vector3.new(0,3.1,0)
end)
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/not%20my%20gui%20lib.lua")()
local UI=GUI:CreateWindow("BABFB","beta 1")
local Main=UI:addPage("Main",3,true,1)
local Shop=UI:addPage("Shop",3,false,1)
Main:addToggle("Start",function(v)
	farm_status=v
end)
Main:addDropdown("Mode",{"normal","die at last stage"},.5,function(v)
	if v=="normal"then
		die=false
	end
	if v=="die at last stage"then
		die=true
	end
end)
Main:addTextBox("Speed",23,function(val)
	farm_speed=tonumber(val)
end)
Shop:addDropdown("Chest",items,#items*.25,function(v)
	autobuy.item=v
end)
Shop:addToggle("Auto Buy",function(v)
	autobuy.s=v
end)
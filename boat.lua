if game.PlaceId~=537413528 then return else repeat wait(1)until game:IsLoaded()and game.Players.LocalPlayer end
local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
local hrp=chr.HumanoidRootPart
local gold=tonumber(plr.PlayerGui.GoldGui.Frame.Amount.Text)
local totaltime=os.time()
local timer=os.time()
local routinegold=0
local binds={}
local farm_speed=450
local toggle={
	farm=true,
	mode=0,
	delete=false,
	infj=false
}
local autobuy={
	item=nil,
	s=false,
	check=false,
	min=100405,
	cd=true
}
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
	["SticksOfTNT"]=true,
	["CameraDome"]=true,
	["CornerWedge"]=true,
	["CornerWedge"]=true,
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
	"Plane Parts",
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
if not workspace:FindFirstChild"conveyor"then
	local p=Instance.new("Part",workspace)
	p.Name="conveyor"
	p.Size=Vector3.new(1,0,5)
	p.Transparency=.95
	p.Anchored=true
	p.CFrame=hrp.CFrame-Vector3.new(0,3,0)
	p.Velocity=p.CFrame:vectorToWorldSpace(Vector3.new(0,0,farm_speed))
end
function noVelocity()
	pcall(function()
		hrp.AssemblyAngularVelocity=Vector3.new(0,0,0)
		hrp.AssemblyLinearVelocity=Vector3.new(0,0,0)
		hrp.Velocity=Vector3.new(0,0,0)
	end)
end
local conveyor=workspace:FindFirstChild"conveyor"
binds.jump=game.UserInputService.JumpRequest:connect(function()
	if toggle.infj and hum then
		hum:ChangeState"Jumping"
	end
end)
binds.added=workspace.ChildAdded:Connect(function()
	wait(.01)
	if toggle.delete then
		for _,v2 in pairs(workspace:GetChildren())do
			if delete[v2.Name]and v2:IsA"Model"then
				v2:Destroy()
			end
		end
		for _,i in pairs(workspace.BoatStages.NormalStages:GetChildren())do
			if i.Name~="TheEnd"then i:Destroy()end
		end
		for _,i in pairs(workspace.BoatStages.OtherStages:GetChildren())do
			i:Destroy()
		end
		for _,i in pairs(workspace.BoatStages.NormalStages.TheEnd:GetChildren())do
			if i.Name~="GoldenChest"then i:Destroy()end
			for _,v in pairs(i:GetChildren())do
				if v.Name:find"DisplayPrizes"or v.Name=="LightPart"then
					v:Destroy()
				end
				if v:FindFirstChild"Gold"then
					v:FindFirstChild"Gold":Destroy()
				end
				if v:FindFirstChild"Lock"then
					v:FindFirstChild"Lock":Destroy()
				end
				if v:FindFirstChild"LockPosition"then
					v:FindFirstChild"LockPosition":Destroy()
				end
			end
			if i:FindFirstChild"Cap"then
				i:FindFirstChild"Cap":Destroy()
			end
		end
	end
end)
local yVal=40
binds.main=game:GetService"RunService".Heartbeat:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr:FindFirstChildWhichIsA"Humanoid"
		hrp=chr.HumanoidRootPart
		local cgold=tonumber(plr.PlayerGui.GoldGui.Frame.Amount.Text)
		workspace[plr.Name].HumanoidRootPart.GroupLabel.TextLabel.Text="Time: "..(os.time()-totaltime).."s/"..(os.time()-timer).."s\nGold: "..(cgold-gold).."/"..(cgold-routinegold).."\nDist: "..math.round((hrp.Position-Vector3.new(-56,-359,9496)).magnitude)
		conveyor=workspace:FindFirstChild"conveyor"
		conveyor.Velocity=conveyor.CFrame:vectorToWorldSpace(Vector3.new(0,0,farm_speed))
		workspace.CurrentCamera.CameraSubject=chr
	end)
	if toggle.farm then
		local goal=8325
		local zm=1050
		if toggle.mode==1 then goal=2165 end
		if hrp.CFrame.z<goal-1100 and toggle.mode~=1 then
			workspace.ClaimRiverResultsGold:FireServer()
		end
		if hrp.CFrame.z<zm then
			hrp.CFrame=CFrame.new(-56,yVal,zm)
			timer=os.time()
			routinegold=tonumber(plr.PlayerGui.GoldGui.Frame.Amount.Text)
		end
		if hrp.CFrame.z>=zm and hrp.Position.z<goal then
			conveyor.CFrame=CFrame.new(-56,yVal-2,hrp.CFrame.z)
			hrp.CFrame=CFrame.new(-56,hrp.CFrame.y,hrp.CFrame.z)
			if hrp.CFrame.y<yVal-2 then
				hrp.CFrame=CFrame.new(-56,yVal,hrp.CFrame.z)
			end
		end
		if hrp.Position.z>goal and hrp.Position.z<9495 then
			if toggle.mode~=2 then
				hrp.CFrame=CFrame.new(-56,-359,9496)
				noVelocity()
			elseif hum then hum.Health=0 end
			wait(.3)
			noVelocity()
			workspace.ClaimRiverResultsGold:FireServer()
			wait(15)
			if hrp.Position.z>goal and hum then hum.Health=0 end
		end
	end
	if autobuy.s and autobuy.item~=nil and autobuy.cd then
		autobuy.cd=false
		pcall(function()
			if plr.PlayerGui:FindFirstChild"ItemGained"then
				plr.PlayerGui:FindFirstChild"ItemGained":Destroy()
			end
			if(type(autobuy.min)=="number"and(autobuy.check and tonumber(plr.PlayerGui.GoldGui.Frame.Amount.Text)>autobuy.min))or not autobuy.check then
				workspace:WaitForChild"ItemBoughtFromShop":InvokeServer(autobuy.item,1)
			end
		end)
		wait(.25)
		autobuy.cd=true
	end
end)
binds.light=game:GetService("Lighting").Changed:Connect(function()
	if hum and toggle.mode<1 and(hrp.Position-Vector3.new(-56,-359,9496)).magnitude<5 then
		hum.Health=0
	end
end)
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/gui%20lib.lua")()
local UI=GUI:CreateWindow("BABFB","...")
local Main=UI:addPage("Main",1,true,1)
local Shop=UI:addPage("Shop",1,false,1)
local Teleport=UI:addPage("Teleport",2,false,1)
local Local=UI:addPage("Local Player",1,false,1)
Main:addToggle("Start",toggle.farm,function(v)
	toggle.farm=v
end)
Main:addDropdown("Mode",{"full routine","gold blocks","gold"},.75,function(v)
	if v=="full routine"then--415
		toggle.mode=0
	elseif v=="gold blocks"then--idk
		toggle.mode=1
	elseif v=="gold"then--450
		toggle.mode=2
	end
end)
Main:addTextBox("Speed",farm_speed,function(v)
	farm_speed=tonumber(v)
	conveyor.Velocity=conveyor.CFrame:vectorToWorldSpace(Vector3.new(0,0,farm_speed))
end)
Main:addToggle("Lag Reduction",toggle.delete,function(v)
	toggle.delete=v
end)
Shop:addDropdown("Shop Items",items,#items*.25,function(v)
	autobuy.item=v
end)
Shop:addLabel("proceed with caution")
Shop:addToggle("Auto Buy",autobuy.s,function(v)
	autobuy.s=v
end)
Shop:addToggle("Check gold",autobuy.check,function(v)
	autobuy.check=v
	autobuy.cd=true
end)
Shop:addTextBox("Min Balance",100405,function(v)
	autobuy.min=tonumber(v)
	autobuy.cd=true
end)
Shop:addButton("Buy once",function()
	if autobuy.item~=nil then
		workspace:WaitForChild"ItemBoughtFromShop":InvokeServer(autobuy.item,1)
	end
end)
Teleport:addButton("Black Team",function()
	hrp.CFrame=workspace:FindFirstChild"BlackTeam".Baseplate.CFrame+Vector3.new(0,10,0)
end)
Teleport:addButton("Red Team",function()
	hrp.CFrame=workspace:FindFirstChild"Really redTeam".Baseplate.CFrame+Vector3.new(0,10,0)
end)
Teleport:addButton("Blue Team",function()
	hrp.CFrame=workspace:FindFirstChild"Really blueTeam".Baseplate.CFrame+Vector3.new(0,10,0)
end)
Teleport:addButton("Green Team",function()
	hrp.CFrame=workspace:FindFirstChild"CamoTeam".Baseplate.CFrame+Vector3.new(0,10,0)
end)
Teleport:addButton("White Team",function()
	hrp.CFrame=workspace:FindFirstChild"WhiteTeam".Baseplate.CFrame+Vector3.new(0,10,0)
end)
Teleport:addButton("Yellow Team",function()
	hrp.CFrame=workspace:FindFirstChild"New YellerTeam".Baseplate.CFrame+Vector3.new(0,10,0)
end)
Teleport:addButton("Magenta Team",function()
	hrp.CFrame=workspace:FindFirstChild"MagentaTeam".Baseplate.CFrame+Vector3.new(0,10,0)
end)
Teleport:addButton("Waterfall",function()
	hrp.CFrame=CFrame.new(181,-12,1161)
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
Local:addToggle("Inf Jump",false,function(v)
	toggle.infj=v
end)
Local:addButton("Rejoin",function()
	plr:Kick" "
	task.wait()
	game:GetService"TeleportService":Teleport(game.placeId,plr)
end)
Local:destroyGui(function()
	for i,v in pairs(binds)do v:Disconnect()end
	for i,v in pairs(toggle)do toggle[i]=false end
	conveyor:Destroy()--3600/sc*ge=income
end)--game.Players.LocalPlayer.PlayerGui.BuildGui.InventoryFrame.ScrollingFrame.Size=UDim2.new(0,430,0,220)
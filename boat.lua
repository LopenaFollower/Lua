if game.PlaceId~=537413528 then return else repeat wait(1)until game:IsLoaded()and game.Players.LocalPlayer end
local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
local hrp=chr.HumanoidRootPart
local gold=tonumber(plr.PlayerGui.GoldGui.Frame.Amount.Text)
local totaltime,cgold,highestgph
local binds={}
local pstats={}
local toggle={
	farm=false,
	delete=false,
	infj=false
}
local autobuy={
	item=nil,
	s=false,
	check=false,
	min=1070000,
	cd=true
}
function secToTime(s)
	local hr=math.floor(s/3600)s=s%3600
	local min=math.floor(s/60)s=s%60
	function pad(n)
		local s="00"..tostring(n)
		local l=s:len()
		return string.sub(s,l-1,l)
	end
	return pad(hr)..":"..pad(min)..":"..pad(s)
end
local delete={["TitaniumBlock"]=true,["SwitchBig"]=true,["SonicJetTurbine"]=true,["BalloonBlock"]=true,["MarbleBlock"]=true,["ObsidianBlock"]=true,["FabricBlock"]=true,["NeonBlock"]=true,["ConcreteBlock"]=true,["CarSeat"]=true,["MetalBlock"]=true,["WoodBlock"]=true,["Piston"]=true,["BackWheel"]=true,["Trees"]=true,["Thruster"]=true,["Seat"]=true,["Steel I-Beam"]=true,["Glue"]=true,["Hinge"]=true,["RustedBlock"]=true,["GlassBlock"]=true,["MetalRod"]=true,["Truss"]=true,["WoodDoor"]=true,["TreasureSmall"]=true,["WoodRod"]=true,["CoalBlock"]=true,["Window"]=true,["RustedRod"]=true,["Lamp"]=true,["StoneBlock"]=true,["TreasureMedium"]=true,["TreasureLarge"]=true,["Torch"]=true,["GrassBlock"]=true,["Mast"]=true,["Switch"]=true,["Camera"]=true,["WoodTrapDoor"]=true,["Throne"]=true,["PlasticBlock"]=true,["CandyBlue"]=true,["IceBlock"]=true,["Wedge"]=true,["JetPack"]=true,["BoatMotor"]=true,["ConcreteRod"]=true,["Motor"]=true,["SandBlock"]=true,["Cake"]=true,["Chair"]=true,["TNT"]=true,["SpringFlowers"]=true,["Egg"]=true,["BrickBlock"]=true,["Servo"]=true,["TitaniumRod"]=true,["PilotSeat"]=true,["JetPackEaster"]=true,["UltraThruster"]=true,["Portal"]=true,["GoldBlock"]=true,["SandUnderWater"]=true,["Harpoon"]=true,["ShieldGenerator"]=true,["FrontWheel"]=true,["Step"]=true,["Trophy1st"]=true,["Helm"]=true,["LightBulb"]=true,["Trophy2nd"]=true,["Sign"]=true,["Cannon"]=true,["JetTurbine"]=true,["Button"]=true,["LockedDoor"]=true,["Trophy3rd"]=true,["MarbleRod"]=true,["Delay"]=true,["Spring"]=true,["SpikeTrap"]=true,["MiniGun"]=true,["CornerWedge"]=true,["StoneRod"]=true,["Flag"]=true,["ParachuteBlock"]=true,["SticksOfTNT"]=true,["CameraDome"]=true,["CornerWedge"]=true,["CornerWedge"]=true,["CornerWedge"]=true,["CornerWedge"]=true,["CornerWedge"]=true,["CornerWedge"]=true,["CornerWedge"]=true}
local items={"Random","Common Chest","Uncommon Chest","Rare Chest","Epic Chest","Legendary Chest","Sign","BoatMotor","Car Parts","Balloons","JetPacks","Plane Parts","Parachutes","Shield Generators","Harpoon","Note","HingeBlocks","Delay","Pistons","Locked Doors","Magnets","PVP Pack","LegacyCarPack","Switch","Button","LightBulb","Camera","CameraDome","SpikeTrap","Cannon","MiniGun","CannonTurret","WoodBlock","SmootWoodBlock","GlassBlock","StoneBlock","FabricBlock","PlasticBlock","GrassBlock","SandBlock","RustedBlock","BouncyBlock","MetalBlock","ConcreteBlock","IceBlock","CoalBlock","BrickBlock","MarbleBlock","TitaniumBlock","ObsidianBlock"}
if not workspace:FindFirstChild"conveyor"then
	local p=Instance.new("Part",workspace)
	p.Name="conveyor"
	p.Size=Vector3.new(100,0,150)
	p.Transparency=1
	p.Anchored=true
	p.CFrame=CFrame.new(-56,50,1390)
	p.Orientation=Vector3.new(20,0,0)
	p.Velocity=p.CFrame:vectorToWorldSpace(Vector3.new(0,0,10))
end
if not workspace:FindFirstChild"pf1"then
	local p=Instance.new("Part",workspace)
	p.Name="pf1"
	p.Size=Vector3.new(1,0,1)
	p.Anchored=true
	p.CFrame=CFrame.new(-56,-363,9488)
end
function noVelocity()
	pcall(function()
		hrp.AssemblyAngularVelocity=Vector3.new(0,0,0)
		hrp.AssemblyLinearVelocity=Vector3.new(0,0,0)
		hrp.Velocity=Vector3.new(0,0,0)
	end)
end
binds.added=workspace.ChildAdded:Connect(function()
	wait(.01)
	if toggle.delete then
		for _,v in pairs(workspace:GetChildren())do
			if delete[v.Name]and v:IsA"Model"then
				v:Destroy()
			end
		end
		for _,v in pairs(workspace.BoatStages.NormalStages:GetChildren())do
			if v.Name~="TheEnd"then
				for _,i in pairs(v:GetChildren())do
					if i.Name~="DarknessPart"then
						i:Destroy()
					else
						i.CastShadow=false
					end
				end
			end
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
binds.main=game:GetService"RunService".Heartbeat:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr:FindFirstChildWhichIsA"Humanoid"
		hrp=chr.HumanoidRootPart
		cgold=tonumber(plr.PlayerGui.GoldGui.Frame.Amount.Text)
		workspace.CurrentCamera.CameraSubject=chr
	end)
	if autobuy.s and autobuy.item~=nil and autobuy.cd then
		autobuy.cd=false
		pcall(function()
			if plr.PlayerGui:FindFirstChild"ItemGained"then
				plr.PlayerGui:FindFirstChild"ItemGained":Destroy()
			end
			if(type(autobuy.min)=="number"and(autobuy.check and tonumber(plr.PlayerGui.GoldGui.Frame.Amount.Text)>autobuy.min))or not autobuy.check then
				local itm=autobuy.item
				if itm=="random"then itm=items[math.random(2,#items)]end
				workspace:WaitForChild"ItemBoughtFromShop":InvokeServer(itm,1)
			end
		end)
		wait(.15)
		autobuy.cd=true
	end
	pcall(function()
		local t=os.time()-totaltime
		local g=cgold-gold
		if math.round(3600/t*g)>highestgph then highestgph=math.round(3600/t*g)end
		pstats.time:updateInfo(secToTime(t))
		pstats.gold:updateInfo(g)
		pstats.perh:updateInfo(math.round(3600/t*g).."/gph")
		pstats.hgph:updateInfo(highestgph.."/gph")
	end)
end)
binds.jump=game.UserInputService.JumpRequest:connect(function()
	if toggle.infj and hum then
		hum:ChangeState"Jumping"
	end
end)
binds.rspwn=plr.CharacterAdded:Connect(function(v)
	repeat task.wait(.25)until v:FindFirstChild"HumanoidRootPart"or not toggle.farm
	workspace.ClaimRiverResultsGold:FireServer()
	if toggle.farm then
		if not totaltime then totaltime=os.time()end
		if not highestgph then highestgph=0 end
		chr=v
		hrp=v:FindFirstChild"HumanoidRootPart"
		hum=v:FindFirstChild"Humanoid"
		hrp.CFrame=CFrame.new(-56,53,1390)
		repeat task.wait()until hrp.CFrame.z>=1453
		hrp.CFrame=CFrame.new(-56,-358,9488)
		noVelocity()
	end
end)
binds.light=game:GetService"Lighting".Changed:Connect(function()
	if toggle.farm and hum and(hrp.Position-Vector3.new(-56,-360,9488)).magnitude<5 then
		hrp.CFrame=CFrame.new(-56,53,1960)
		hum:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
		game.TweenService:Create(hrp,TweenInfo.new(14.25,Enum.EasingStyle.Linear),{CFrame=CFrame.new(-56,53,8385)}):Play()
		wait(.5)
		task.spawn(function()
			while hrp.CFrame.z>1950 do
				task.wait()
				noVelocity()
				workspace.ClaimRiverResultsGold:FireServer()
			end
		end)
	end
end)
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/gui%20lib.lua")()
local UI=GUI:CreateWindow("BABFB","best auto farm")
local Main=UI:addPage("Main",1,true,1)
local Shop=UI:addPage("Shop",1,false,1)
local Teleport=UI:addPage("Teleport",2,false,1)
local Stats=UI:addPage("Statistics",1,false,1)
local Local=UI:addPage("Local Player",1,false,1)
Main:addToggle("Start",toggle.farm,function(v)
	toggle.farm=v
	workspace.ClaimRiverResultsGold:FireServer()
	if toggle.farm and hrp.CFrame.z<1200 then
		if not totaltime then totaltime=os.time()end
		if not highestgph then highestgph=0 end
		hrp.CFrame=CFrame.new(-56,53,1390)
		repeat task.wait()until hrp.CFrame.z>=1453
		hrp.CFrame=CFrame.new(-56,-358,9488)
	end
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
Shop:addTextBox("Min Balance",autobuy.min,function(v)
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
pstats.time=Stats:addLabel("Elapsed","00:00:00")
pstats.gold=Stats:addLabel("Session Gold","0")
pstats.perh=Stats:addLabel("Estimated","0/hr")
pstats.hgph=Stats:addLabel("Highest Rate","0/hr")
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
	workspace:FindFirstChild"conveyor":Destroy()
	workspace:FindFirstChild"pf1":Destroy()
end)
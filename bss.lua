repeat
	wait(1)
until workspace[game.Players.LocalPlayer.Name]:WaitForChild"Porcelain Port-O-Hive"and game:IsLoaded()
wait()
if game.PlaceId~=1537690962 then
	return
end
--VARIABLES & FUNCTIONS
local ver="2.0e"

local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
local hrp=chr.HumanoidRootPart
local gui_run=false
local HoneyMaking=false
local safe_delay=.25
-- 1 for honey, 2 for brown bear quests
local afk_mode=false

local toggles={
	farming=false,
	tpw=false,
	dig=false,
	inf_jump=false,
	only_token=false,
	quest=false,
	vicious=false,
	token_esp=false,
	noclip=nil,
	commando=false,
	commando_loop=nil,
	walk=false,
	bb=false,
	leaves=false
}
local selected={
	field=nil,
	jp=hum.JumpPower,
	ws=hum.WalkSpeed,
	tpws=1
}
local cd=true
local cd2=true
local cd3=true
local in_prog=false
local finished=false
local min_y=-1
local old_field
local sum
local total
local PRs
for _,v in pairs(workspace.Collectibles:GetChildren())do
	v:Destroy()
end
gui_run=true
if not workspace:FindFirstChild"FLOOOASD3"then
	local p=Instance.new"Part"
	p.Name="FLOOOASD3"
	p.Parent=workspace
	p.Size=Vector3.new(150,0,150)
	p.Anchored=true
	p.Transparency=1
	p.CFrame=CFrame.new(workspace.FlowerZones["Stump Field"].Position.x,82,workspace.FlowerZones["Stump Field"].Position.z)
	workspace.Decorations.Stump.Stump:Destroy()
end
function goto(x,y,z,m)
	if math.abs(y-hrp.Position.y)<=10 then
		while (Vector3.new(x,hrp.Position.y,z)-hrp.Position).Magnitude > 2 and x and y and z and m~=nil and wait()and gui_run and hum and chr and selected.field and finished and not in_prog do
			nearest(workspace.Bees)
			if (Vector3.new(x,hrp.Position.y,z)-hrp.Position).Magnitude<=4 then
				hrp.Velocity=Vector3.new(0,0,0)
			end
			if m then
				hum.WalkToPoint=Vector3.new(x+math.random(),hrp.Position.y,z+math.random())
			else
				chr:TranslateBy((Vector3.new(x+math.random(),hrp.Position.y,z+math.random())-hrp.Position))
			end
		end
	end
end
function NoclipLoop()
	if chr ~= nil then
		for _,v in pairs(chr:GetDescendants()) do
			if v:IsA"BasePart" and v.CanCollide==true then
				v.CanCollide=false
			end
		end
	end
end
function set_sprinkler(t)
	if in_prog then 
		wait()
	elseif not finished and not HoneyMaking then
		in_prog=true
		for i=1,t do
			hum:ChangeState"Jumping"
			wait(.15)
			game.ReplicatedStorage.Events.PlayerActivesCommand:FireServer({["Name"]="Sprinkler Builder"})
			wait(.9)
		end
		in_prog=false
		finished=true
	end
end
function auto_quest()
	if toggles.quest and cd2 then
		cd2=false
		loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/bss%20quest.lua")()
		wait(2.5)
		cd2=true
	end	
end
function BAV(AngularVelocity,Parent,Name)
	local s=Instance.new"BodyAngularVelocity"
	s.Name=Name or"Spinning"
	s.Parent=Parent or nil
	s.MaxTorque=Vector3.new(0,math.huge,0)
	s.AngularVelocity=AngularVelocity or Vector3.new(0,10,0)
	return s
end
function getbbq()
	if gui_run and hum and chr and hrp and hum.Health>0 then
		local goals={"White","Red","Blue","Sunflower Field","Mushroom Field","Dandelion Field","Clover Field","Blue Flower Field","Bamboo Field","Spider Field","Strawberry Field","Pineapple Patch","Stump Field","Rose Field","Cactus Field","Pumpkin Patch","Pine Tree Forest","Mountain Top Field","Coconut Field","Pepper Patch"}
		local res
		if plr.PlayerGui.ScreenGui.Menus.Children.Quests.Content:FindFirstChild"Frame"then wait()
			sum=0
			total=0
			for _,quests in pairs(plr.PlayerGui.ScreenGui.Menus.Children.Quests.Content.Frame:GetChildren())do
				if quests:IsA"Frame"then
					if quests.TitleBar.Text:lower():find("brown bear:")then
						quests.Name="TheBBQ"
					end
				end
			end
			local bbq=plr.PlayerGui.ScreenGui.Menus.Children.Quests.Content.Frame:FindFirstChild"TheBBQ"
			for _,tasks in pairs(bbq:GetChildren())do
				if bbq:FindFirstChild"PRs"then
					bbq:FindFirstChild"PRs":Destroy()
				end
				PRs=bbq.TitleBar:Clone()
				PRs.Parent=bbq
				PRs.Name="PRs"
				PRs.Transparency=0
				if tasks:IsA"Frame"then
					sum=sum+tasks.FillBar.AbsoluteSize.x
					total=tasks.AbsoluteSize.x*(#bbq:GetChildren()-2)
					bbq.PRs.Text="Progress: "..tostring(math.round((sum/total)*10000)/100).."%"
				end
				if tasks:IsA"Frame"and tasks.FillBar.AbsoluteSize.x<=287.9975 then
					for n=1,#goals do wait()
						if tasks.Description.Text:find(goals[n])then
							if(tasks.Description.Text:find"Field"or tasks.Description.Text:find"Patch")and(goals[n]:find"Field"or goals[n]:find"Patch")then
								res=goals[n]
							elseif goals[n]=="White"and not(tasks.Description.Text:find"Field"or tasks.Description.Text:find"Patch")then
								if workspace.MonsterSpawners.CoconutCrab.TimerAttachment.TimerGui.TimerLabel.Text:find("Crab")then
									res="Coconut Field"
								else
									res="Spider Field"
								end
							elseif goals[n]=="Red"and not(tasks.Description.Text:find"Field"or tasks.Description.Text:find"Patch")then
								res="Pepper Patch"
							elseif goals[n]=="Blue"and not(tasks.Description.Text:find"Field"or tasks.Description.Text:find"Patch")then
								res="Pine Tree Forest"
							end
							if old_field~=nil and old_field~=false and res~=nil and  old_field~=res then
								hrp.CFrame=workspace.FlowerZones[res].CFrame*CFrame.new(0,2,0)
								finished=false
							end
							if res~=nil then
								old_field=res
								return res
							end
						end
					end
				end
			end
		else
			local mmm = game.UserInputService:GetMouseLocation()
			if math.abs(mmm.x-90)>10 or math.abs(mmm.y-110)>10 then
				mousemoveabs(90,110)
			else
				mouse1down()
				wait()
				mouse1up()
			end
		end
	end
end
function nearest(tbl)
	local r
	for _,v in pairs(tbl:GetChildren())do
		if r==nil then
			r=v
		else
			if(hrp.Position-v.Position).magnitude<(r.Position-hrp.Position).magnitude then
				r=v
			end
		end
	end
	hrp.CFrame=CFrame.lookAt(hrp.Position,Vector3.new(r.Position.x,hrp.Position.y,r.Position.z))
end
function killvicious()
	if toggles.vicious then
		repeat
			wait()
		until not HoneyMaking
       	for _,i in pairs(game.workspace.Particles:GetChildren()) do
			if i.Name:find"Waiti"then
				toggles.farming=false
           		hrp.CFrame=i.CFrame
     		end
		end
		for _,v in pairs(game.workspace.Monsters:GetChildren()) do
			if v.Name:find"Vici" or v.Name:find"Gifted"then
				toggles.farming=false
				hrp.CFrame=v.Head.CFrame*CFrame.new(0,13,0)
			end
		end
	end
end
function tokens()
	local Display=workspace[plr.Name]:WaitForChild"Porcelain Port-O-Hive".Display
	if not HoneyMaking and Display and Display.Gui then
		if hum and chr and Display.Gui.ProgressBar.AbsoluteSize==Display.Gui.RedBar.AbsoluteSize or Display.Gui.ProgressLabel==plr.CoreStats.Pollen.Value.."/"..plr.CoreStats.Pollen.Value then
			HoneyMaking=true
			wait(1)
			local Spin=BAV(Vector3.new(0,10,0),hrp,"Spinning")
			chr:MoveTo(plr.SpawnPos.Value.p)
			wait(.25)
			game.ReplicatedStorage.Events.PlayerHiveCommand:FireServer"ToggleHoneyMaking"
			repeat
				chr:MoveTo(plr.SpawnPos.Value.p)
				hum.WalkToPoint=plr.SpawnPos.Value.p
				Spin.AngularVelocity=Spin.AngularVelocity*-1
				wait(2.5)
				if not workspace.Particles:FindFirstChild"HoneyBeam"or not tostring(workspace.Particles:FindFirstChild"HoneyBeam".Attachment1)==tostring(plr.DisplayName) then
					game.ReplicatedStorage.Events.PlayerHiveCommand:FireServer"ToggleHoneyMaking"
				end
			until plr.CoreStats.Pollen.Value<=1
			wait(7)
			Spin:Destroy()
			if toggles.farming then
				hrp.CFrame=workspace.FlowerZones[selected.field].CFrame*CFrame.new(0,2,0)
			end
			wait(.1)
			HoneyMaking=false
		end
		wait()
	end
	for _,v in pairs(workspace.Collectibles:GetChildren())do
		if toggles.farming and not finished and not in_prog and selected.field and not HoneyMaking then
			hrp.CFrame=workspace.FlowerZones[selected.field].CFrame*CFrame.new(0,2,0)
			wait(.25)
			set_sprinkler(5)
		end
		if toggles.farming and cd and finished and not HoneyMaking and selected.field then
			cd=false
			if (workspace.FlowerZones[selected.field].Position-v.Position).magnitude<=80 and workspace.Collectibles:FindFirstChild"rbxassetid://1629547638"and workspace.Collectibles:FindFirstChild"rbxassetid://1629547638".Orientation.z==0 then
				pcall(function()
					goto(workspace.Collectibles:FindFirstChild"rbxassetid://1629547638".Position.x,hrp.Position.y,workspace.Collectibles:FindFirstChild"rbxassetid://1629547638".Position.z,toggles.walk)
				end)
				wait(safe_delay)
				cd=true
			elseif (workspace.FlowerZones[selected.field].Position-v.Position).magnitude<=80 and not toggles.only_token and v.Orientation.z==0 then
				pcall(function()
					goto(v.Position.x,hrp.Position.y,v.Position.z,toggles.walk)
				end)
				wait(safe_delay)
				cd=true
			else
				if(workspace.FlowerZones[selected.field].Position-hrp.Position).magnitude>=80 or hrp.Position.y-workspace.FlowerZones[selected.field].Position.y<min_y then
					hrp.CFrame=workspace.FlowerZones[selected.field].CFrame*CFrame.new(0,2,0)
				end
				wait()
				cd=true
			end
		end
	end
	if toggles.dig and hrp and not HoneyMaking then
		pcall(function()
			for _,v in pairs(chr:GetChildren()) do
				if v:IsA"Tool"then
					v.ClickEvent:FireServer()
				end
			end
		end)
	end
end
workspace.Flowers.DescendantAdded:Connect(function(v)
	if v.Name:find"LeafBurst"and toggles.leaves then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=v.Parent.CFrame*CFrame.new(0,0,0)
		print(v.Parent.Parent.Name)
		for _,i in pairs(workspace.Collectibles:GetChildren())do
			if(i.Position-hrp.Position).magnitude<10 then
				chr:TranslateBy((Vector3.new(i.Position.x+math.random(),hrp.Position.y,i.Position.z)-hrp.Position))
			end
		end
	end
end)
function esp(part)
	if part:IsA"BasePart" and not part:FindFirstChild"content.com/Lopen"then
		local a=Instance.new"BoxHandleAdornment"
		a.Name="content.com/Lopen"
		a.Parent=part
		a.Adornee=part
		a.AlwaysOnTop=true
		a.ZIndex=0
		a.Size=Vector3.new(.57,3.95,4.09)
		a.Transparency=.4
		a.Color=part.BrickColor
	end
end
if afk_mode==1 then
	toggles.farming=true
	toggles.dig=true
	toggles.inf_jump=true
	toggles.quest=true
	toggles.token_esp=true
	toggles.noclip=game.RunService.Stepped:Connect(NoclipLoop)
	toggles.walk=true
	selected.field="Pepper Patch"
	selected.ws=175
elseif afk_mode==2 then
	toggles.bb=true
end
game.ReplicatedStorage.Events.ClaimHive:FireServer(6)
game.ReplicatedStorage.Events.ClaimHive:FireServer(5)
game.ReplicatedStorage.Events.ClaimHive:FireServer(4)
game.ReplicatedStorage.Events.ClaimHive:FireServer(3)
game.ReplicatedStorage.Events.ClaimHive:FireServer(2)
game.ReplicatedStorage.Events.ClaimHive:FireServer(1)
workspace.ChildAdded:Connect(function(v)
	wait(0.25)
	if v:IsA"Model"and v.Name==plr.Name and workspace[plr.Name].UpperTorso:FindFirstChild"BodyBackAttachment" then
		finished=false
		workspace[plr.Name].UpperTorso.BodyBackAttachment.Name=plr.DisplayName
		workspace[plr.Name]["Porcelain Port-O-Hive"].Handle.BodyBackAttachment.Name=plr.DisplayName
	end
end)
workspace.Collectibles.ChildAdded:Connect(function(v)
	if gui_run then
		pcall(function()
			if tostring(v)==tostring(plr.Name) or tostring(v)=="C"then
				v.Name=v:FindFirstChild"FrontDecal".Texture
				v.Name=v:FindFirstChild"BackDecal".Texture
			end
			plr.DevCameraOcclusionMode=Enum.DevCameraOcclusionMode.Invisicam
		end)
		if toggles.token_esp and v:IsA"BasePart"then
			esp(v)
		end
	end
end)
workspace.Particles.ChildAdded:Connect(function(v)
	if v.Name=="Crosshair"and gui_run then
		for i=0,5 do
			hrp.Velocity=Vector3.new(0,0,0)
			goto(v.Position.x,hrp.Position.y,v.Position.z,false)
		end
	end
end)
local looping=game.RunService.Heartbeat:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
		hrp=chr.HumanoidRootPart
		hum.JumpPower=selected.jp
		hum.WalkSpeed=selected.ws
		plr.CameraMaxZoomDistance=125
	end)
	if gui_run and hum and chr and hrp and hum.Health>0 then
		if toggles.tpw then
			if hum.MoveDirection.Magnitude>0 then
				chr:TranslateBy(hum.MoveDirection*selected.tpws)
			else
				chr:TranslateBy(hum.MoveDirection)
			end
		end	
		auto_quest()
		killvicious()
		tokens()
		if toggles.bb then
			toggles.farming=true
			toggles.dig=true
			toggles.inf_jump=true
			toggles.quest=true
			toggles.token_esp=true
			selected.ws=175
			if toggles.noclip==nil then
				toggles.noclip=game.RunService.Stepped:Connect(NoclipLoop)
			end
			toggles.walk=true
			if cd3 then
				cd3=false
				selected.field=getbbq()
				wait(1)
				cd3=true
			end
		end
	end
end)
game.UserInputService.JumpRequest:connect(function()
	if toggles.inf_jump and hum and chr and hrp then
		hum:ChangeState"Jumping"
	end
end)
--GUI
--[[
	Refs.
	PageElements:addLabel(labelname,labelinfo)
	PageElements:addButton(buttonname,callback)
	PageElements:addToggle(togglename,callback)
	PageElements:addSlider(slidername,minvalue,maxvalue,callback)
	PageElements:addTextBox(textboxname,textboxdefault,callback)
	PageElements:addDropdown(dropdownname,list,scrollsize,callback)
]]
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/not%20my%20gui%20lib.lua")()
local UI=GUI:CreateWindow("BSS","version "..ver)
local Main=UI:addPage("Main",3,true,1)
local Waypoint=UI:addPage("Waypoints",2,false,1)
local Enemy=UI:addPage("Enemy",3,false,1)
local NPC=UI:addPage("NPC quest",1,false,1)
local Sp=UI:addPage("Local",3,false,1)
Main:addToggle("Auto Dig",function(v)
	toggles.dig=v
end)
Main:addDropdown("Select Field",{"Sunflower Field","Mushroom Field","Dandelion Field","Clover Field","Blue Flower Field","Bamboo Field","Spider Field","Strawberry Field","Pineapple Patch","Stump Field","Rose Field","Cactus Field","Pumpkin Patch","Pine Tree Forest","Mountain Top Field","Coconut Field","Pepper Patch","Ant Field"},4.25,function(v)
	selected.field=nil
	wait()	
	selected.field=v
	old_field=v
	finished=false
	if v=="Stump Field"then
		min_y=-30
	else
		min_y=-1
	end
end)
Main:addToggle("Start Farm",function(v)
	toggles.farming=v
	cd=true
end)
Main:addToggle("Walk (Set WalkSpeed ~150)",function(v)
	toggles.walk=v
	if v then
		safe_delay=0
	else
		safe_delay=.25
	end
end)
Main:addToggle("Token Link only",function(v)
	toggles.only_token=v
end)
Main:addToggle("Auto Quest",function(v)
	toggles.quest=v
end)
Main:addToggle("Auto Leaves",function(v)
	toggles.leaves=v
end)
Main:addToggle("ESP Tokens",function(v)
	toggles.token_esp=v
end)
Main:addButton("Destroy Ui",function()
	gui_run=false
	toggles.farming=false
	toggles.tpw=false
	toggles.dig=false
	toggles.inf_jump=false
	toggles.only_token=false
	selected.field=nil
	selected.jp=hum.JumpPower
	selected.ws=hum.WalkSpeed
	selected.tpws=1
	toggles.walk=false
	HoneyMaking=false
	toggles.quest=false
	toggles.vicious=false
	toggles.commando=false
	toggles.leaves=false
	toggles.token_esp=false
	toggles.bb=false
	if toggles.noclip then
		toggles.noclip:Disconnect()
	end
	if toggles.commando_loop then
		toggles.commando_loop:Disconnect()
	end
	looping:Disconnect()
	wait(.1)
	for _,v in pairs(workspace:GetDescendants())do
		if v.Name=="content.com/Lopen"then
			v:Destroy()
		end
	end
	wait(.1)
	for x=1,100 do
		if game.CoreGui:FindFirstChild"fu8rj82n"then
			game.CoreGui:FindFirstChild"fu8rj82n":Destroy()
		end
	end 
end)
Waypoint:addButton("Hive",function()
	chr:MoveTo(plr.SpawnPos.Value.p)
end)
Waypoint:addDropdown("Fields",{"Sunflower Field","Mushroom Field","Dandelion Field","Clover Field","Blue Flower Field","Bamboo Field","Spider Field","Strawberry Field","Pineapple Patch","Stump Field","Rose Field","Cactus Field","Pumpkin Patch","Pine Tree Forest","Mountain Top Field","Coconut Field","Pepper Patch","Ant Field"},4.25,function(v)
	if tostring(v)=="Ant Field"then
		hrp.CFrame=CFrame.new(91.2,34,503)
	else
		hrp.CFrame=workspace.FlowerZones[v].CFrame*CFrame.new(0,3,0)
	end
end)
Waypoint:addDropdown("NPCs",{"Black Bear","Brown Bear","Bubble Bee Man","Dapper Bear","Gifted Bucko Bee","Gifted Riley Bee","Gummy Bear","Honey Bee","Mother Bear","Panda Bear","Polar Bear","Robo Bear","Science Bear","Spirit Bear","Stick Bug","Onett"},3.75,function(v)
	if v=="Black Bear"then
		hrp.CFrame=CFrame.new(-253,6,296)
	elseif v=="Brown Bear"then
		hrp.CFrame=CFrame.new(281,46,237)
	elseif v=="Bubble Bee Man"then
		hrp.CFrame=CFrame.new(90,312,-277)
	elseif v=="Dapper Bear"then
		hrp.CFrame=CFrame.new(553,143,-361)
	elseif v=="Gifted Bucko Bee"then
		hrp.CFrame=CFrame.new(304,62,105)
	elseif v=="Gifted Riley Bee"then
		hrp.CFrame=CFrame.new(-361,74,213)
	elseif v=="Gummy Bear"then
		hrp.CFrame=CFrame.new(272,25293,-849)
	elseif v=="Honey Bee"then
		hrp.CFrame=CFrame.new(-453,104,-221)
	elseif v=="Mother Bear"then
		hrp.CFrame=CFrame.new(-179,6,91)
	elseif v=="Panda Bear"then
		hrp.CFrame=CFrame.new(104,36,50)
	elseif v=="Polar Bear"then
		hrp.CFrame=CFrame.new(-107,120,-77)
	elseif v=="Robo Bear"then
		hrp.CFrame=CFrame.new(-443,42,112)
	elseif v=="Science Bear"then
		hrp.CFrame=CFrame.new(269,103,19)
	elseif v=="Spirit Bear"then
		hrp.CFrame=CFrame.new(-367,98,478)
	elseif v=="Stick Bug"then
		hrp.CFrame=CFrame.new(-128,50,147)
	elseif v=="Onett"then
		hrp.CFrame=CFrame.new(-9,233,-519)
	end
end)
Waypoint:addDropdown("Shops",{"Noob Shop","Pro Shop","Blue HQ","Red HQ","Mountain Top Shop","Ticket Tent","Royal Jelly Shop(Honey)","Royal Jelly Shop(Ticket)","Basic Egg Shop","Ticket Shop","Treat Shop","Gumdrop Shop","Petal Shop","Coconut Cave","Stinger Shop","Sprinkler Shop","Gummy Bear's Lair","Magic Bean Shop","Dapper Bear’s Shop","Robo Bear's Shop","Moon Charm"},5,function(v)
	if v=="Noob Shop"then
		hrp.CFrame=CFrame.new(90,5,292)
	elseif v=="Pro Shop"then
	hrp.CFrame=CFrame.new(159,69,-166)
	elseif v=="Blue HQ"then
		hrp.CFrame=CFrame.new(292,5,94)
	elseif v=="Red HQ"then
		hrp.CFrame=CFrame.new(-325,21,204)
	elseif v=="Mountain Top Shop"then
		hrp.CFrame=CFrame.new(-18,176,-137)
	elseif v=="Ticket Tent"then
		hrp.CFrame=CFrame.new(-234,18,419)
	elseif v=="Royal Jelly Shop(Honey)"then
		hrp.CFrame=CFrame.new(-291,53,69)
	elseif v=="Royal Jelly Shop(Ticket)"then
		hrp.CFrame=CFrame.new(82,20,239)
	elseif v=="Basic Egg Shop"then
		hrp.CFrame=CFrame.new(-136.8,4.6,243.4)
	elseif v=="Ticket Shop"then
		hrp.CFrame=CFrame.new(-12.8,184,-222.2)
	elseif v=="Treat Shop"then
		hrp.CFrame=CFrame.new(-228.2,5,89.4)
	elseif v=="Gumdrop Shop"then
		hrp.CFrame=CFrame.new(67,22,26)
	elseif v=="Petal Shop"then
		hrp.CFrame=CFrame.new(-500,52,458)
	elseif v=="Coconut Cave"then
		hrp.CFrame=CFrame.new(-142,73,500)
	elseif v=="Stinger Shop"then
		hrp.CFrame=CFrame.new(87,34,453)
	elseif v=="Sprinkler Shop"then
		hrp.CFrame=CFrame.new(-393,70,0)
	elseif v=="Gummy Bear's Lair"then
		hrp.CFrame=CFrame.new(272,25268,-773)
	elseif v=="Magic Bean Shop"then
		hrp.CFrame=CFrame.new(351,92,-85)
	elseif v=="Dapper Bear’s Shop"then
		hrp.CFrame=CFrame.new(524,139,-344)
	elseif v=="Robo Bear's Shop the"then
		hrp.CFrame=CFrame.new(-476,61,105)
	elseif v=="Moon Charm"then
		hrp.CFrame=CFrame.new(21,88,-54)
	end
end)
Waypoint:addDropdown("Dispensers",{"Ant Pass","Blueberry","Coconut","Robo Pass","Glue","Honey","Strawberry","Treat","Royal Jelly"},1.75,function(v)
	if v=="Ant Pass"then
		hrp.CFrame=CFrame.new(128,33,450)
	elseif v=="Blueberry"then
		hrp.CFrame=CFrame.new(313,5,135)
	elseif v=="Coconut"then
		hrp.CFrame=CFrame.new(-176,71,534)
	elseif v=="Robo Pass"then
		hrp.CFrame=CFrame.new(-91,183,-298)
	elseif v=="Glue"then
		hrp.CFrame=CFrame.new(270,25260,-718)
	elseif v=="Honey"then
		hrp.CFrame=CFrame.new(45,6,323)
	elseif v=="Strawberry"then
		hrp.CFrame=CFrame.new(-320.5,46,272.5)
	elseif v=="Treat"then
		hrp.CFrame=CFrame.new(194,69,-122)
	elseif v=="Royal Jelly"then
		hrp.CFrame=CFrame.new(111,66,332)
	end
end)
Waypoint:addDropdown("Boosts",{"Redfield","Bluefield","MountainTop"},.75,function(v)
	if v=="Redfield"then
		hrp.CFrame=CFrame.new(-316,20,244)
	elseif v=="Bluefield"then
		hrp.CFrame=CFrame.new(273,59,86)
	elseif v=="MountainTop"then
		hrp.CFrame=CFrame.new(-40,176,-191.7)
	end
end)
Waypoint:addDropdown("Events",{"Special Sprout","Honeystorm","Instant Honey Converter","Mythic Meteor","Wind Shrine","Wealth Clock","Mega Memory","Extreme Memory","Night Memory"},2.25,function(v)
	if v=="Special Sprout"then
		hrp.CFrame=CFrame.new(-269,26.5,267)
	elseif v=="Honeystorm"then
		hrp.CFrame=CFrame.new(238.4,33.3,165.6)
	elseif v=="Instant Honey Converter"then
		hrp.CFrame=CFrame.new(282,68,-62)
	elseif v=="Mythic Meteor"then
		hrp.CFrame=CFrame.new(161,127,-162)
	elseif v=="Wind Shrine"then
		hrp.CFrame=CFrame.new(-486,142,410)
	elseif v=="Wealth Clock"then
		hrp.CFrame=CFrame.new(310.5,47.6,190)
	elseif v=="Mega Memory"then
		hrp.CFrame=CFrame.new(-431,70,-53)
	elseif v=="Extreme Memory"then
		hrp.CFrame=CFrame.new(-405,113,545)
	elseif v=="Night Memory"then
		hrp.CFrame=CFrame.new(-23,318,-270)
	end
end)
Waypoint:addDropdown("Gear",{"Star Amulet","Demon Mask","Gummy Mask","Diamond Mask"},1,function(v)
	if v=="Star Amulet"then
		hrp.CFrame=CFrame.new(136,66,322)
	elseif v=="Demon Mask"then
		hrp.CFrame=CFrame.new(291,28,271)
	elseif v=="Gummy Mask"then
		hrp.CFrame=CFrame.new(272,25268,-773)
	elseif v=="Diamond Mask"then
		hrp.CFrame=CFrame.new(-336,133,-387)
	end
end)
Waypoint:addDropdown("Boss",{"King Beetles Lair","Tunnel Bear","Coconut Crab","Commando Chick"},1,function(v)
	if v=="King Beetles Lair"then
		hrp.CFrame=CFrame.new(218,3,140)
	elseif v=="Tunnel Bear"then
		hrp.CFrame=CFrame.new(507.3,5.7,-45.7)
	elseif v=="Coconut Crab"then
		hrp.CFrame=CFrame.new(-251,72,431)
	elseif v=="Commando Chick"then
		hrp.CFrame=CFrame.new(519,47,166)
	end
end)
Enemy:addButton("Coconut Crab",function()
	if hrp then
		if not workspace:FindFirstChild"FLOOOASD"then
			local p=Instance.new"Part"
			p.Name="FLOOOASD"
			p.Parent=workspace
			p.Size=Vector3.new(2,0,2)
			p.Anchored=true
			p.CFrame=CFrame.new(-266.5,113.25,425.83)
		end
		hrp.CFrame=CFrame.new(-266.5,116,425.83)
	end
end)
Enemy:addToggle("Vicious Bee",function(v)
	toggles.vicious=v
end)
Enemy:addToggle("Commando (bug w/o noclip)",function(v)
	toggles.commando=v
	if v and hrp then
		local adhd=Vector3.new(0,3.1,0)
		if not workspace:FindFirstChild"FLOOOASD2"then
			local p=Instance.new"Part"
			p.Name="FLOOOASD2"
			p.Parent=workspace
			p.Size=Vector3.new(5,0,5)
			p.Anchored=true
			p.CFrame=CFrame.new(513,47,163)
		end
		hrp.CFrame=workspace:FindFirstChild"FLOOOASD2".CFrame+adhd
		while toggles.commando and wait()and hum and chr and hrp and hum.Health>0 do
			if workspace.Collectibles:FindFirstChild"rbxassetid://2319083910"and workspace.Collectibles:FindFirstChild"rbxassetid://2319083910".Orientation.z==0 then
				hrp.CFrame=workspace.Collectibles:FindFirstChild"rbxassetid://2319083910".CFrame+Vector3.new(0,.1,0)
				wait(.5)
				hrp.CFrame=workspace:FindFirstChild"FLOOOASD2".CFrame+adhd
			else
				hrp.CFrame=workspace:FindFirstChild"FLOOOASD2".CFrame+adhd
			end
		end
	end
end)
toggles.commando_loop=game.RunService.Stepped:Connect(function()
	if toggles.commando and workspace:FindFirstChild"FLOOOASD2"then
		for _,v in pairs(game.workspace.Monsters:GetChildren())do
			if v.Name:lower():find"commando chick"then
				workspace:FindFirstChild"FLOOOASD2".CFrame=CFrame.new(v.Torso.CFrame.x,52,v.Torso.CFrame.z)
			end
		end
	end
end)
NPC:addLabel("Open Quest Tab","Script can't read unloaded Instances")
NPC:addToggle("Brown Bear",function(v)
	toggles.bb=v
	if v==false then
		toggles.farming=false
	else
		finished=false
	end
end)
Sp:addSlider("Walk Speed",0,300,function(val)
	selected.ws=val
end)
Sp:addSlider("Jump Height",75,300,function(val)
	selected.jp=val
end)
Sp:addToggle("Infinite Jump",function(v)
	toggles.inf_jump=v
end)
Sp:addToggle("Noclip",function(v)
	if type(toggles.noclip)=="function"then
		toggles.noclip:Disconnect()
	else
		toggles.noclip=game.RunService.Stepped:Connect(NoclipLoop)
	end
end)
Sp:addTextBox("TP walk speed",selected.tpws,function(val)
	selected.tpws=val
end)
Sp:addToggle("TP walk",function(v)
	toggles.tpw=v
end)

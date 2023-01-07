game.Players.LocalPlayer.DevCameraOcclusionMode=Enum.DevCameraOcclusionMode.Invisicam
--VARIABLES & FUNCTIONS
local chr=game.Players.LocalPlayer.Character
local hum=chr and chr:FindFirstChildWhichIsA("Humanoid")
local hrp=chr.HumanoidRootPart
local gui_run=false
local HoneyMaking=false
local safe_delay=0.25
local toggles={
	farming=false,
	tpw=false,
	dig=false,
	inf_jump=false,
	only_token=false,
	quest=false,
	vicious=false,
	token_esp=false,
	noclip=nil
}
local selected={
	field=false,
	jp=hum.JumpPower,
	ws=hum.WalkSpeed,
	tpws=1,
	mode=false,
}
local cd=true
local cd2=true
local cd3=true
gui_run=true
local in_prog=false
local finished=false
for _,v in pairs(workspace.Collectibles:GetChildren())do
	v:Destroy()
end
function goto(x,y,z)
	if math.abs(y-hrp.Position.y) <= 20 then
		while (Vector3.new(x,hrp.Position.y,z)-hrp.Position).Magnitude > 2 and x and y and z and wait()and gui_run and hum and chr and selected.field do
			if selected.mode then
				hum.WalkToPoint=Vector3.new(x,hrp.Position.y,z)
			else
				chr:TranslateBy((Vector3.new(x,hrp.Position.y,z)-hrp.Position)*.5)
			end
		end
	end
end
function NoclipLoop()
	if game.Players.LocalPlayer.Character ~= nil then
		for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
			if v:IsA("BasePart") and v.CanCollide == true then
				v.CanCollide = false
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
			game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
			wait(.15)
			game:GetService("ReplicatedStorage").Events.PlayerActivesCommand:FireServer({["Name"]="Sprinkler Builder"})
			wait(0.75)
		end
		in_prog=false
		finished=true
	end
end
function auto_quest()
	if toggles.quest and cd2 then
		cd2=false
		loadstring(game:HttpGet("https://raw.githubusercontent.com/LopenaFollower/Lua/main/bss%20quest.lua"))()
		wait(10)
		cd2=true
	end	
end
function killvicious()
	if toggles.vicious then
		repeat wait() until not HoneyMaking
       	for _,i in pairs(game.workspace.Particles:GetChildren()) do
			if string.find(i.Name,"Waiti") then
				toggles.farming=false
           		hrp.CFrame = i.CFrame
     		end
		end
		for _,v in pairs(game.workspace.Monsters:GetChildren()) do
			if string.find(v.Name,"Vici") then
				toggles.farming=false
				hrp.CFrame = v.Head.CFrame * CFrame.new(0,13,0)
			end
		end
		for _,r in pairs(game.workspace.Monsters:GetChildren()) do
			if string.find(r.Name,"Gifted") then
				toggles.farming=false
				hrp.CFrame = r.Head.CFrame * CFrame.new(0,13,0)
			end
		end
	end
end
function tokens()
	if cd3 then
		local Display=workspace[game.Players.LocalPlayer.Name]["Porcelain Port-O-Hive"].Display
		if not HoneyMaking then
			if Display.Gui.ProgressBar.AbsoluteSize == Display.Gui.RedBar.AbsoluteSize or Display.Gui.ProgressLabel == game.Players.LocalPlayer.CoreStats.Pollen.Value.."/"..game.Players.LocalPlayer.CoreStats.Pollen.Value then
				cd3=false
				HoneyMaking=true
				wait(1)
				local Spin =Instance.new("BodyAngularVelocity")
				Spin.Name="Spinning"
				Spin.Parent = hrp
				Spin.MaxTorque = Vector3.new(0, math.huge, 0)
				Spin.AngularVelocity = Vector3.new(0,10,0)
				game:GetService("Players").LocalPlayer.Character:MoveTo(game:GetService("Players").LocalPlayer.SpawnPos.Value.p)
				wait(0.25)
				game:GetService("Players").LocalPlayer.Character:MoveTo(game:GetService("Players").LocalPlayer.SpawnPos.Value.p)
				game:GetService("ReplicatedStorage").Events.PlayerHiveCommand:FireServer("ToggleHoneyMaking")
				repeat wait(.1)game:GetService("Players").LocalPlayer.Character:MoveTo(game:GetService("Players").LocalPlayer.SpawnPos.Value.p) until game.Players.LocalPlayer.CoreStats.Pollen.Value <= 1
				wait(7)
				Spin:Destroy()
				hrp.CFrame = workspace.FlowerZones[selected.field].CFrame * CFrame.new(0,2,0)
				wait(1)
				HoneyMaking=false
				cd3=true
			end
			wait()
		end
	end
	for _,v in pairs(workspace.Collectibles:GetChildren())do
		if toggles.farming and not finished and not in_prog and selected.field then
			hrp.CFrame = workspace.FlowerZones[selected.field].CFrame * CFrame.new(0,2,0)
			wait(0.1)
			set_sprinkler(4)
		end
		if toggles.farming and cd and finished and not HoneyMaking and selected.field then
			cd=false
			if (v.Position-hrp.Position).magnitude <= 80 and workspace.Collectibles:FindFirstChild"rbxassetid://1629547638"and workspace.Collectibles:FindFirstChild"rbxassetid://1629547638".Orientation.z==0 then
				pcall(function()goto(workspace.Collectibles:FindFirstChild"rbxassetid://1629547638".Position.x, hrp.Position.y, workspace.Collectibles:FindFirstChild"rbxassetid://1629547638".Position.z)end)
				wait(safe_delay)
				cd=true
			elseif (v.Position-hrp.Position).magnitude <= 80 and not toggles.only_token and v.Orientation.z==0 then
				pcall(function()goto(v.Position.x, hrp.Position.y, v.Position.z)end)
				wait(safe_delay)
				cd=true
			else
				if (workspace.FlowerZones[selected.field].Position-hrp.Position).magnitude >= 80 or math.abs(workspace.FlowerZones[selected.field].Position.y-hrp.Position.y)>12 then
					hrp.CFrame = workspace.FlowerZones[selected.field].CFrame * CFrame.new(0,2,0)
				end
				wait()
				cd=true
			end
		end
	end
	if toggles.dig and hrp and not HoneyMaking then
		pcall(function()
			for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
				if v:IsA("Tool") then
					v.ClickEvent:FireServer()
				end
			end
		end)
	end
end
function esp(part)
	if part:IsA("BasePart") and not part:FindFirstChild"content.com/Lopen" then
		local a = Instance.new("BoxHandleAdornment")
		a.Name = "content.com/Lopen"
		a.Parent = part
		a.Adornee = part
		a.AlwaysOnTop = true
		a.ZIndex = 0
		a.Size = Vector3.new(0.57,3.95,4.09)
		a.Transparency = 0.4
		a.Color = part.BrickColor
	end
end
workspace.Collectibles.ChildAdded:Connect(function(v)
	pcall(function()
		if tostring(v) == tostring(game.Players.LocalPlayer.Name) or tostring(v) == "C" then
			v.Name=v:FindFirstChild"FrontDecal".Texture
			v.Name=v:FindFirstChild"BackDecal".Texture
		end
	end)
	if toggles.token_esp and v:IsA("BasePart") then
		esp(v)
	end
end)
local looping=game:GetService("RunService").Heartbeat:Connect(function()
	pcall(function()
		chr=game.Players.LocalPlayer.Character
		hum=chr and chr:FindFirstChildWhichIsA("Humanoid")
		hrp=chr.HumanoidRootPart
		hum.JumpPower=selected.jp
		hum.WalkSpeed=selected.ws
	end)
	if gui_run and hum and chr and hrp and hum.Health>0 then
		if toggles.tpw then
			if hum.MoveDirection.Magnitude > 0 then
				chr:TranslateBy(hum.MoveDirection * tonumber(selected.tpws))
			else
				chr:TranslateBy(hum.MoveDirection)
			end
		end	
		auto_quest()
		killvicious()
		tokens()
	end
end)
game:GetService("UserInputService").JumpRequest:connect(function()
	if toggles.inf_jump and hum and chr and hrp then
		hum:ChangeState("Jumping")
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
local GUI=loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/aaaa"))()
local UI=GUI:CreateWindow("BSS","version 2.0")
local Main=UI:addPage("Main",3,true,6)
local Waypoint=UI:addPage("Waypoints",2,false,6)
local Boss=UI:addPage("Boss",3,false,6)
local Sp=UI:addPage("Local",3,false,6)
Main:addToggle("Auto Dig",function(v)
	toggles.dig=v
end)
Main:addDropdown("Select Field",{"Sunflower Field","Mushroom Field","Dandelion Field","Clover Field","Blue Flower Field","Bamboo Field","Spider Field","Strawberry Field","Pineapple Patch","Stump Field","Rose Field","Cactus Field","Pumpkin Patch","Pine Tree Forest","Mountain Top Field","Coconut Field","Pepper Patch"},4,function(v)
	selected.field=v
	finished=false
end)
Main:addToggle("Start Farm",function(v)
	toggles.farming=v
	cd=true
end)
Main:addToggle("Walk(Set WalkSpeed to 150-200)",function(v)
	selected.mode=v
	if v then
		safe_delay=0
	else
		safe_delay=0.25
	end
end)
Main:addToggle("Token Link only",function(v)
	toggles.only_token=v
end)
Main:addToggle("Auto Quest",function(v)
	toggles.quest=v
end)
Main:addToggle("ESP Tokens",function(v)
	toggles.token_esp=v
end)
Main:addButton("Destroy Ui",function()
	toggles.farming=false
	toggles.tpw=false
	toggles.dig=false
	toggles.inf_jump=false
	toggles.only_token=false
	selected.field=false
	selected.jp=hum.JumpPower
	selected.ws=hum.WalkSpeed
	selected.tpws=1
	gui_run=false
	HoneyMaking=false
	toggles.quest=false
	toggles.vicious=false
	toggles.token_esp=false
	toggles.noclip:Disconnect()
	looping:Disconnect()
	wait(.1)
	for _,v in pairs(workspace:GetDescendants())do
		if v.Name=="content.com/Lopen" then
			v:Destroy()
		end
	end
	wait(.1)
	for x=1,1000 do
		if game.CoreGui:FindFirstChild("fu8rj82n")then
			game.CoreGui:FindFirstChild("fu8rj82n"):Destroy()
		end
	end 
end)
Waypoint:addButton("Hive",function()
	game:GetService("Players").LocalPlayer.Character:MoveTo(game:GetService("Players").LocalPlayer.SpawnPos.Value.p)
end)
Waypoint:addDropdown("Fields",{"Sunflower Field","Mushroom Field","Dandelion Field","Clover Field","Blue Flower Field","Bamboo Field","Spider Field","Strawberry Field","Pineapple Patch","Stump Field","Rose Field","Cactus Field","Pumpkin Patch","Pine Tree Forest","Mountain Top Field","Coconut Field","Pepper Patch","Ant Field"},4.25,function(v)
	if tostring(v)=="Ant Field" then
		hrp.CFrame=CFrame.new(91.2,34,503)
	else
		hrp.CFrame=workspace.FlowerZones[v].CFrame*CFrame.new(0,0,0)
	end
end)
Waypoint:addDropdown("NPCs",{"Black Bear","Brown Bear","Bubble Bee Man","Dapper Bear","Gifted Bucko Bee","Gifted Riley Bee","Gummy Bear","Honey Bee","Mother Bear","Panda Bear","Polar Bear","Robo Bear","Science Bear","Spirit Bear","Stick Bug","Onett"},3.75,function(v)
	if v=="Black Bear" then	hrp.CFrame=CFrame.new(-253,6,296)
	elseif v=="Brown Bear"then hrp.CFrame=CFrame.new(281,46,237)
	elseif v=="Bubble Bee Man"then hrp.CFrame=CFrame.new(90,312,-277)
	elseif v=="Dapper Bear"then hrp.CFrame=CFrame.new(553,143,-361)
	elseif v=="Gifted Bucko Bee"then hrp.CFrame=CFrame.new(304,62,105)
	elseif v=="Gifted Riley Bee"then hrp.CFrame=CFrame.new(-361,74,213)
	elseif v=="Gummy Bear"then hrp.CFrame=CFrame.new(272,25293,-849)
	elseif v=="Honey Bee"then hrp.CFrame=CFrame.new(-453,104,-221)
	elseif v=="Mother Bear"then hrp.CFrame=CFrame.new(-179,6,91)
	elseif v=="Panda Bear"then hrp.CFrame=CFrame.new(104,36,50)
	elseif v=="Polar Bear"then hrp.CFrame=CFrame.new(-107,120,-77)
	elseif v=="Robo Bear"then hrp.CFrame=CFrame.new(-443,42,112)
	elseif v=="Science Bear"then hrp.CFrame=CFrame.new(269,103,19)
	elseif v=="Spirit Bear"then hrp.CFrame=CFrame.new(-367,98,478)
	elseif v=="Stick Bug"then hrp.CFrame=CFrame.new(-128,50,147)
	elseif v=="Onett"then hrp.CFrame=CFrame.new(-9,233,-519)
	end
end)
Waypoint:addDropdown("Shops",{"Noob Shop","Pro Shop","Blue HQ","Red HQ","Mountain Top Shop","Ticket Tent","Royal Jelly Shop(Honey)","Royal Jelly Shop(Ticket)","Basic Egg Shop","Ticket Shop","Treat Shop","Gumdrop Shop","Petal Shop","Coconut Cave","Stinger Shop","Sprinkler Shop","Gummy Bear's Lair","Magic Bean Shop","Dapper Bear’s Shop","Robo Bear's Shop","Moon Charm"},5,function(v)
	if v=="Noob Shop" then	hrp.CFrame=CFrame.new(90,5,292)
	elseif v=="Pro Shop"then hrp.CFrame=CFrame.new(159,69,-166)
	elseif v=="Blue HQ" then hrp.CFrame=CFrame.new(292,5,94)
	elseif v=="Red HQ" then	hrp.CFrame=CFrame.new(-325,21,204)
	elseif v=="Mountain Top Shop" then hrp.CFrame=CFrame.new(-18,176,-137)
	elseif v=="Ticket Tent" then hrp.CFrame=CFrame.new(-234,18,419)
	elseif v=="Royal Jelly Shop(Honey)" then hrp.CFrame=CFrame.new(-291,53,69)
	elseif v=="Royal Jelly Shop(Ticket)" then hrp.CFrame=CFrame.new(82,20,239)
	elseif v=="Basic Egg Shop" then hrp.CFrame=CFrame.new(-136.8,4.6,243.4)
	elseif v=="Ticket Shop" then hrp.CFrame=CFrame.new(-12.8,184,-222.2)
	elseif v=="Treat Shop" then hrp.CFrame=CFrame.new(-228.2,5,89.4)
	elseif v=="Gumdrop Shop" then hrp.CFrame=CFrame.new(67,22,26)
	elseif v=="Petal Shop" then hrp.CFrame=CFrame.new(-500,52,458)
	elseif v=="Coconut Cave" then hrp.CFrame=CFrame.new(-142,73,500)
	elseif v=="Stinger Shop" then hrp.CFrame=CFrame.new(87,34,453)
	elseif v=="Sprinkler Shop" then hrp.CFrame=CFrame.new(-393,70,0)
	elseif v=="Gummy Bear's Lair" then hrp.CFrame=CFrame.new(272,25268,-773)
	elseif v=="Magic Bean Shop" then hrp.CFrame=CFrame.new(351,92,-85)
	elseif v=="Dapper Bear’s Shop" then hrp.CFrame=CFrame.new(524,139,-344)
	elseif v=="Robo Bear's Shop" then hrp.CFrame=CFrame.new(-476,61,105)
	elseif v=="Moon Charm" then hrp.CFrame=CFrame.new(21,88,-54)
	end
end)
Waypoint:addDropdown("Dispensers",{"Ant Pass","Blueberry","Coconut","Robo Pass","Glue","Honey","Strawberry","Treat","Royal Jelly"},1.75,function(v)
	if v=="Ant Pass" then hrp.CFrame=CFrame.new(128,33,450)
	elseif v=="Blueberry"then hrp.CFrame=CFrame.new(313,5,135)
	elseif v=="Coconut" then hrp.CFrame=CFrame.new(-176,71,534)
	elseif v=="Robo Pass" then hrp.CFrame=CFrame.new(-91,183,-298)
	elseif v=="Glue" then hrp.CFrame=CFrame.new(270,25260,-718)
	elseif v=="Honey" then hrp.CFrame=CFrame.new(45,6,323)
	elseif v=="Strawberry" then	hrp.CFrame=CFrame.new(-320.5,46,272.5)
	elseif v=="Treat" then hrp.CFrame=CFrame.new(194,69,-122)
	elseif v=="Royal Jelly" then hrp.CFrame=CFrame.new(111,66,332)
	end
end)
Waypoint:addDropdown("Boosts",{"Redfield","Bluefield","MountainTop"},0.75,function(v)
	if v=="Redfield" then hrp.CFrame=CFrame.new(-316,20,244)
	elseif v=="Bluefield"then hrp.CFrame=CFrame.new(273,59,86)
	elseif v=="MountainTop" then hrp.CFrame=CFrame.new(-40,176,-191.7)
	end
end)
Waypoint:addDropdown("Events",{"Special Sprout","Honeystorm","Instant Honey Converter","Mythic Meteor","Wind Shrine","Wealth Clock","Mega Memory","Extreme Memory","Night Memory"},2.25,function(v)
	if v=="Special Sprout" then hrp.CFrame=CFrame.new(-269,26.5,267)
	elseif v=="Honeystorm"then hrp.CFrame=CFrame.new(238.4,33.3,165.6)
	elseif v=="Instant Honey Converter" then hrp.CFrame=CFrame.new(282,68,-62)
	elseif v=="Mythic Meteor" then hrp.CFrame=CFrame.new(161,127,-162)
	elseif v=="Wind Shrine" then hrp.CFrame=CFrame.new(-486,142,410)
	elseif v=="Wealth Clock" then hrp.CFrame=CFrame.new(310.5,47.6,190)
	elseif v=="Mega Memory" then hrp.CFrame=CFrame.new(-431,70,-53)
	elseif v=="Extreme Memory" then hrp.CFrame=CFrame.new(-405,113,545)
	elseif v=="Night Memory" then hrp.CFrame=CFrame.new(-23,318,-270)
	end
end)
Waypoint:addDropdown("Gear",{"Star Amulet","Demon Mask","Gummy Mask","Diamond Mask"},1,function(v)
	if v=="Star Amulet" then hrp.CFrame=CFrame.new(136,66,322)
	elseif v=="Demon Mask"then hrp.CFrame=CFrame.new(291,28,271)
	elseif v=="Gummy Mask" then hrp.CFrame=CFrame.new(272,25268,-773)
	elseif v=="Diamond Mask" then hrp.CFrame=CFrame.new(-336,133,-387)
	end
end)
Waypoint:addDropdown("Boss",{"King Beetles Lair","Tunnel Bear","Coconut Crab","Commando Chick"},1,function(v)
	if v=="King Beetles Lair" then hrp.CFrame=CFrame.new(218,3,140)
	elseif v=="Tunnel Bear"then hrp.CFrame=CFrame.new(507.3,5.7,-45.7)
	elseif v=="Coconut Crab" then hrp.CFrame=CFrame.new(-251,72,431)
	elseif v=="Commando Chick" then hrp.CFrame=CFrame.new(519,47,166)
	end
end)
Boss:addButton("Coconut Crab",function()
	if hrp then
		if not workspace:FindFirstChild"FLOOOASD" then
			local p = Instance.new('Part')
			p.Name = "FLOOOASD"
			p.Parent = workspace
			p.Transparency = 0.5
			p.Size = Vector3.new(2,0,2)
			p.Anchored = true
			p.CFrame = CFrame.new(-266.5,113.25,500)
		end
		hrp.CFrame=CFrame.new(-266.5,116,500)
	end
end)
Boss:addToggle("Vicious Bee",function(v)
	toggles.vicious=v
end)
Sp:addSlider("Walk Speed",32,400,function(val)
	selected.ws=val
end)
Sp:addSlider("Jump Height",hum.JumpPower,1000,function(val)
	selected.jp=val
end)
Sp:addToggle("Infinite Jump",function(v)
	toggles.inf_jump=v
end)
Sp:addToggle("Noclip",function(v)
	if toggles.noclip then
		toggles.noclip:Disconnect()
	else
		toggles.noclip = game:GetService("RunService").Stepped:Connect(NoclipLoop)
	end
end)
Sp:addTextBox("TP walk speed",selected.tpws,function(val)
	selected.tpws=val
end)
Sp:addToggle("TP walk",function(v)
	toggles.tpw=v
end)

game.Players.LocalPlayer.DevCameraOcclusionMode=Enum.DevCameraOcclusionMode.Invisicam
--VARIABLES & FUNCTIONS
local chr=game.Players.LocalPlayer.Character
local hum=chr and chr:FindFirstChildWhichIsA("Humanoid")
local hrp=chr.HumanoidRootPart
local gui_run=false
local HoneyMaking=false
local safe_delay=0.3
local toggles={
	farming=false,
	tpw=false,
	dig=false,
	inf_jump=false,
	only_token=false,
	quest=false,
	vicious=false
}
local selected={
	field=false,
	jp=hum.JumpPower,
	ws=hum.WalkSpeed,
	tpws=1
}
local cd=true
local cd2=true
gui_run=true
local in_prog=false
local finished=false
for _,v in pairs(workspace.Collectibles:GetChildren())do
	v:Destroy()
end
function goto(x,y,z)
	if math.abs(y-hrp.Position.y) <= 20 then
		while (Vector3.new(x,hrp.Position.y,z)-hrp.Position).Magnitude > 2 and x and y and z and wait()and gui_run and hum and chr do
			hum.WalkToPoint=Vector3.new(x,hrp.Position.y,z)
			chr:TranslateBy((Vector3.new(x,hrp.Position.y,z)-hrp.Position))
		end
	end
end
function set_sprinkler(t)
	if in_prog then 
		wait()
	elseif not finished then
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
local looping=game:GetService("RunService").RenderStepped:Connect(function()
	if gui_run and hum and chr and hrp and hum.Health>0 then
		chr=game.Players.LocalPlayer.Character
		hum=chr and chr:FindFirstChildWhichIsA("Humanoid")
		hrp=chr.HumanoidRootPart
		hum.JumpPower=selected.jp
		hum.WalkSpeed=selected.ws
		for _,v in pairs(workspace.Collectibles:GetChildren())do
			pcall(function()
				if tostring(v) == tostring(game.Players.LocalPlayer.Name) or tostring(v) == "C" then
					v.Name=v:FindFirstChild"FrontDecal".Texture
					v.Name=v:FindFirstChild"BackDecal".Texture
				end
			end)
			if toggles.farming and not finished and not in_prog then
				hrp.CFrame = workspace.FlowerZones[selected.field].CFrame * CFrame.new(0,0,0)
				wait(0.1)
				set_sprinkler(4)
			end
			if toggles.farming and cd and toggles.vicious==false and finished and not HoneyMaking then
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
					if (workspace.FlowerZones[selected.field].Position-hrp.Position).magnitude >= 80 or math.abs(workspace.FlowerZones[selected.field].Position.y-hrp.Position.y) >= 20 then
						hrp.CFrame = workspace.FlowerZones[selected.field].CFrame * CFrame.new(0,0,0)
					end
					wait()
					cd=true
				end
				if not v.Orientation.z==0 then
					wait(0.15)
					v:Destroy()
				end
				for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v:IsA("Tool") then
						v.ClickEvent:FireServer()
					end
				end
			end
		end
		if toggles.tpw and chr and hum then
			if hum.MoveDirection.Magnitude > 0 then
				chr:TranslateBy(hum.MoveDirection * tonumber(selected.tpws))
			else
				chr:TranslateBy(hum.MoveDirection)
			end
		end
		if toggles.dig and hrp and not HoneyMaking then
			for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
				if v:IsA("Tool") then
					v.ClickEvent:FireServer()
				end
			end
		end
		for _,v in pairs(workspace[game.Players.LocalPlayer.Name]:GetDescendants()) do
			if v:FindFirstChild("Display")then
				if not HoneyMaking and (v.Display.Gui.ProgressBar.Size == v.Display.Gui.RedBar.Size or v.Display.Gui.ProgressLabel == game.Players.LocalPlayer.CoreStats.Pollen.Value.."/"..game.Players.LocalPlayer.CoreStats.Pollen.Value) then
					HoneyMaking=true
					wait(1)
					game:GetService("Players").LocalPlayer.Character:MoveTo(game:GetService("Players").LocalPlayer.SpawnPos.Value.p)
					wait(0.25)
					game:GetService("ReplicatedStorage").Events.PlayerHiveCommand:FireServer("ToggleHoneyMaking")
					repeat wait(.1) until game.Players.LocalPlayer.CoreStats.Pollen.Value <= 1
					wait(7)
					hrp.CFrame = workspace.FlowerZones[selected.field].CFrame * CFrame.new(0,0,0)
					wait(1)
					HoneyMaking=false
				end
			end
			wait()
		end
		if toggles.quest and cd2 then
			cd2=false
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Pepper")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Coconut")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Playtime")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Honey")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Quest")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Battle")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Ability")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Goo")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Sunflower")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Dandelion")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Mushroom")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Blue Flower")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Clover")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Spider")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Bamboo")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Strawberry")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Pineapple")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Pumpkin")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Cactus")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Rose")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Pine Tree")
			game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Stump")
			game.ReplicatedStorage.Events.ToyEvent:FireServer("Wealth Clock")
			game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Brown Bear")
			game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Polar Bear")
			game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Honey Bee")
			game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Black Bear")
			game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Bucko Bee")
			game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Riley Bee")
			game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Brown Bear")
			game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Polar Bear")
			game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Honey Bee")
			game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Black Bear")
			game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Bucko Bee")
			game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Riley Bee")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Treat Tutorial")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Treat Tutorial")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bonding With Bees")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Bonding With Bees")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Search For A Sunflower Seed")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Search For A Sunflower Seed")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("The Gist Of Jellies")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("The Gist Of Jellies")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Search For Strawberries")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Search For Strawberries")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Binging On Blueberries")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Binging On Blueberries")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Royal Jelly Jamboree")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Royal Jelly Jamboree")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Search For Sunflower Seeds")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Search For Sunflower Seeds")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Picking Out Pineapples")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Picking Out Pineapples")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Seven To Seven")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Seven To Seven")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Mother Bears Midterm")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Mother Bears Midterm")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Eight To Eight")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Eight To Eight")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Sights On The Stars")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Sights On The Stars")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("The Family Final")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("The Family Final")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Preliminary Research")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Preliminary Research")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Biology Study")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Biology Study")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Proving The Hypothesis")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Proving The Hypothesis")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bear Botany")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Bear Botany")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Kingdom Collection")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Kingdom Collection")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Defensive Adaptions")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Devensive Adaptions")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Benefits Of Technology")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Benefits Of Technology")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spider Study")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Spider Study")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Roses And Weeds")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Roses And Weeds")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Blue Review")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Blue Review")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ongoing Progress")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Ongoing Progress")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Red / Blue Duality")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Red / Blue Duality")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Costs Of Computation")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Costs Of Computation")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollination Practice")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollination Practice")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Optimizing Abilities")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Optimizing Abilities")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ready For Infrared")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Ready For Infrared")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Breaking Down Badges")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Breaking Down Badges")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Subsidized Agriculture")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Subsidized Agriculture")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Meticulously Crafted")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Meticulously Crafted")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Smart, Not Hard")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Smart, Not Hard")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Limits of Language")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Limits of Language")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Patterns and Probability")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Patterns and Probability")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Chemical Analysis")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Chemical Analysis")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Mark Mechanics")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Mark Mechanics")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Meditating On Phenomenon")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Meditating On Phenomenon")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Beesperanto")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Beesperanto")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Hive Minded Bias")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Hive Minded Bias")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Mushroom Measurement Monotony")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Mushroom Measurement Monotony")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("The Power Of Information")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("The Power Of Information")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Testing Teamwork")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Testing Teamwork")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Epistemological Endeavor")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Epistemological Endeavor")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Egg Hunt: Panda Bear")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Egg Hunt: Panda Bear")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Lesson On Ladybugs")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Lesson On Ladybugs")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rhino Rumble")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Rhino Rumble")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Beetle Battle")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Beetle Battle")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spider Slayer")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Spider Slayer")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ladybug Bonker")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Ladybug Bonker")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spider Slayer 2")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Spider Slayer 2")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rhino Wrecking")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Rhino Wrecking")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Final Showdown")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Final Showdown")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Werewolf Hunter")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Werewolf Hunter")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Skirmish with Scorpions")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Skirmish with Scorpions")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Mantis Massacre")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Mantis Massacre")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("The REAL Final Showdown")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("The REAL Final Showdown")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ant Arrival")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Ant Arrival")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Winged Wack Attack")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Winged Wack Attack")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Fire Fighter")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Fire Fighter")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Army Ant Assault")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Army Ant Assault")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Colossal Combat")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Colossal Combat")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Eager Exterminator")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Eager Exterminator")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Leaper Lickin'")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Leaper Lickin'")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Colossal Combat 2")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Colossal Combat 2")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Outrageous Onslaught")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Outrageous Onslaught")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Royal Rumble")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Royal Rumble")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ultimate Ant Annihilation 1")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Ultimate Ant Annihilation 1")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ultimate Ant Annihilation 2")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Ultimate Ant Annihilation 2")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ultimate Ant Annihilation 3")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Ultimate Ant Annihilation 3")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ultimate Ant Annihilation 4")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Ultimate Ant Annihilation 4")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ultimate Ant Annihilation 5")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Ultimate Ant Annihilation 5")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Star Journey 1")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Star Journey 1")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Star Journey 2")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Star Journey 2")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Star Journey 3")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Star Journey 3")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Star Journey 4")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Star Journey 4")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Star Journey 5")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Star Journey 5")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Egg Hunt: Riley Bee")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Egg Hunt: Riley Bee")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Egg Hunt: Bucko Bee")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Egg Hunt: Bucko Bee")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Sunflower Start")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Sunflower Start")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Dandelion Deed")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Dandelion Deed")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollen Fetcher")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollen Fetcher")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Red Request")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Red Request")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Into The Blue")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Into The Blue")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Variety Fetcher")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Variety Fetcher")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bamboo Boogie")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Bamboo Boogie")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Red Request 2")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Red Request 2")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Cobweb Sweeper")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Cobweb Sweeper")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Leisure Loot")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Leisure Loot")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("White Pollen Wrangler")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("White Pollen Wrangler")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pineapple Picking")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Pineapple Picking")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollen Fetcher 2")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollen Fetcher 2")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Weed Wacker")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Weed Wacker")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Red + Blue = Gold")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Red + Blue = Gold")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Colorless Collection")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Colorless Collection")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spirit of Springtime")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Spirit of Springtime")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Weed Wacker 2")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Weed Wacker 2")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollen Fetcher 3")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollen Fetcher 3")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Lucky Landscaping")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Lucky Landscaping")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Azure Adventure")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Azure Adventure")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pink Pineapples")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Pink Pineapples")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Blue Mushrooms")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Blue Mushrooms")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Cobweb Sweeper 2")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Cobweb Sweeper 2")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rojo-A-Go-Go")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Rojo-A-Go-Go")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pumpkin Plower")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Pumpkin Plower")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollen Fetcher 4")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollen Fetcher 4")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bouncing Around Biomes")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Bouncing Around Biomes")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Blue Pineapples")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Blue Pineapples")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rose Request")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Rose Request")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Search For The White Clover")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Search For The White Clover")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Stomping Grounds")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Stomping Grounds")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Collecting Cliffside")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Collecting Cliffside")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Mountain Meandering")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Mountain Meandering")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Quest Of Legends")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Quest Of Legends")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("High Altitude")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("High Altitude")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Blissfully Blue")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Blissfully Blue")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rouge Round-up")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Rouge Round-up")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("White As Snow")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("White As Snow")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Solo On The Stump")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Solo On The Stump")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Colorful Craving")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Colorful Craving")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pumpkins, Please!")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Pumpkins, Please!")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Smorgasbord")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Smorgasbord")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollen Fetcher 5")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollen Fetcher 5")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("White Clover Redux")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("White Clover Redux")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Strawberry Field Forever")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Strawberry Field Forever")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Tasting The Sky")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Tasting The Sky")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Whispy and Crispy")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Whispy and Crispy")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Walk Through The Woods")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Walk Through The Woods")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Get Red-y")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Get Red-y")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("One Stop On The Tip Top")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("One Stop On The Tip Top")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Blue Mushrooms 2")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Blue Mushrooms 2")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pretty Pumpkins")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Pretty Pumpkins")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Black Bear, Why?")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Black Bear, Why?")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bee A Star")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Bee A Star")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spirit's Starter")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Spirit's Starter")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("The First Offering")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("The First Offering")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rules of The Road")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Rules of The Road")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("QR Quest")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("QR Quest")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pleasant Pastimes")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Pleasant Pastimes")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Nature's Lessons")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Nature's Lessons")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("The Gifts Of Life")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("The Gifts Of Life")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Out-Questing Questions")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Out-Questing Questions")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Forcefully Friendly")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Forcefully Friendly")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Sway Away")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Sway Away")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Memories of Memories")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Memories of Memories")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Beans Becoming")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Beans Becoming")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Do You Bee-lieve In Magic?")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Do You Bee-lieve In Magic?")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("The Ways Of The Winds / The Wind And Its Way")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("The Ways Of The Winds / The Wind And Its Way")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Beauty Duty")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Beauty Duty")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Witness Grandeur")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Witness Grandeur")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Beeternity")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Beeternity")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("A Breath Of Blue")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("A Breath Of Blue")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Glory Of Goo")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Glory Of Goo")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Tickle The Wind")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Tickle The Wind")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rhubarb That Could Have Been")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Rhubarb That Could Have Been")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Dreams Of Being A Bee")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Dreams Of Being A Bee")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("The Sky Over The Stump")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("The Sky Over The Stump")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Space Oblivion")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Space Oblivion")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollenpalooza")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollenpalooza")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Dancing With Stick Bug")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Dancing With Stick Bug")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bean Bug Busser")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Bean Bug Busser")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bombs, Blueberries, and Bean Bugs")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Bombs, Blueberries, and Bean Bugs")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bean Bugs And Boosts")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Bean Bugs And Boosts")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Make It Hasty")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Make It Hasty")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Total Focus")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Total Focus")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("On Your Marks")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("On Your Marks")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Look In The Leaves")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Look In The Leaves")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("What About Sprouts")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("What About Sprouts")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Bean Bug Beatdown")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bean Bug Beatdown")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Bear Without Despair")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bear Without Despair")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Spirit Spree")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spirit Spree")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Echoing Call")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Echoing Call")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Spring Out Of The Mountain")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spring Out Of The Mountain")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Goo")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Goo")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Medley")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Medley")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Mushrooms")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Mushrooms")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Picnic")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Picnic")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Pollen")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Pollen")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Rampage")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Rampage")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Roses")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Roses")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Scavenge")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Scavenge")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Skirmish")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Skirmish")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Strawberries")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Strawberries")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Tango")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Tango")
			game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Tour")
			game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Tour")
			wait(5)
			cd2=true
		end
		if toggles.vicious then
        	for _,i in pairs(game.workspace.Particles:GetChildren()) do
				if string.find(i.Name,"Waiti") then
					if i:IsA"BasePart" then print(i.Name) end
            		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = i.CFrame
     			end
			end
			for _,v in pairs(game.workspace.Monsters:GetChildren()) do
				if string.find(v.Name,"Vici") then
					if v:IsA"BasePart" then print(v.Name) end
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Head.CFrame * CFrame.new(0,13,0)
				end
			end
			for _,r in pairs(game.workspace.Monsters:GetChildren()) do
				if string.find(r.Name,"Gifted") then
					if r:IsA"BasePart" then print(r.Name) end
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = r.Head.CFrame * CFrame.new(0,13,0)
				end
			end
		end
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
local UI=GUI:CreateWindow("BSS","version 1.0a")
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
Main:addToggle("Token Link only",function(v)
	toggles.only_token=v
end)
Main:addToggle("Auto Quest",function(v)
	toggles.quest=v
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
	looping:Disconnect()
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
Sp:addLabel("Better Speed","no inertia")
Sp:addTextBox("TP walk speed",selected.tpws,function(val)
	selected.tpws=val
end)
Sp:addToggle("TP walk",function(v)
	toggles.tpw=v
end)

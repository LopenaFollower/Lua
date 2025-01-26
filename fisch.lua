if game.PlaceId~=16732694052 then return else repeat wait()until game:IsLoaded()and game.Players.LocalPlayer end
local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr:FindFirstChildWhichIsA"Humanoid"
local hrp=chr.HumanoidRootPart
local plrGui=plr.PlayerGui
local binds={}
local togs={
	cast=false,
	shake=true,
	instacatch=true,
	appraise=false,
	luck=false,
	sell=false,
	anglerQ=false,
	evf=false,
	oxyg=false,
	temp=false,
	invcam=true
}
local cd={
	cast=true,
	appraise=true,
	luck=true,
	sell=true,
	anglerQ1=true,
	anglerQ2=true,
	evf=true
}
local vals={
	tpws=5,
	anchor=nil
}
local wps={
	areas={
		"Moosewood",
		"Roslit",
		"Roslit - Volcano",
		"Mushgrove Swamp",
		"Terrapin",
		"Snowcap",
		"Sunstone",
		"Forsaken Shores",
		"Keepers Altar",
		"Vertigo",
		"The Depths",
		"Desolate Pocket",
		"Brine Pool",
		"Ancient Isle",
		"Ancient Isle - Waterfall",
		"Ancient Archives",
		"Northern Summit",
		"Overgrowth Caves",
		"Frigid Cavern",
		"Cryogenic Canal",
		"Glacial Grotto",
		"Grand Reef"
	},
	items={
		"Rod Of The Depths"
	}
}
local coords={
	["Moosewood"]={387,135,256},
	["Roslit"]={-1464,133,724},
	["Roslit - Volcano"]={-1982,155,235},
	["Mushgrove Swamp"]={2522,132,-704},
	["Terrapin"]={-160,143,1928},
	["Snowcap"]={2600,135,2414},
	["Sunstone"]={-927,133,-1120},
	["Forsaken Shores"]={-2486,133,1557},
	["Keepers Altar"]={1310,-802,-89},
	["Vertigo"]={-111,-515,1140},
	["The Depths"]={946,-712,1256},
	["Desolate Pocket"]={-1661,-214,-2839},
	["Brine Pool"]={-1797,-143,-3366},
	["Ancient Isle"]={6069,195,306},
	["Ancient Isle - Waterfall"]={5801,135,405},
	["Ancient Archives"]={-3153,-755,1922},
	["Northern Summit"]={19552,133,5299},
	["Overgrowth Caves"]={19756,415,5412},
	["Frigid Cavern"]={20229,731,5685},
	["Cryogenic Canal"]={20018,508,5415},
	["Glacial Grotto"]={19958,1143,5537},
	["Grand Reef"]={-3593,132,566},
	["Rod Of The Depths"]={1701,-903,1434},
	["Triden Puzzle"]={-1477,-225,-2321}
}
local appraiseSettings={
	slot=nil,
	mutations={
		["Abyssal"]=false,
		["Albino"]=false,
		["Amber"]=false,
		["Darkened"]=false,
		["Electric"]=false,
		["Fossilized"]=false,
		["Frozen"]=false,
		["Glossy"]=false,
		["Greedy"]=false,
		["Hexed"]=false,
		["Lunar"]=false,
		["Midas"]=false,
		["Mosaic"]=false,
		["Mythical"]=false,
		["Negative"]=false,
		["Scorched"]=false,
		["Silver"]=false,
		["Translucent"]=false
	},
	attributes={
		["Big"]=false,["Giant"]=false,["Shiny"]=false,["Sparkling"]=false
	}
}
local events={
	{"Shark Hunt",0},
	{"Megalodon",0},
	{"Depth Serpent",0},
	{"Gold Tide",0},
	{"Algae",0},
	{"Isonade",0}
}
local fzs={
	["Gold Tide"]={"Golden Tide"},
	["Shark Hunt"]={"Whale Shark","Great White Shark","Great Hammerhead Shark"},
	["Megalodon"]={"Megalodon Default"},
	["Depth Serpent"]={"The Depths - Serpent"},
	["Algae"]={"Mushgrove Algae Pool","Forsaken Algae Pool","Ancient Algae Pool","Snowcap Algae Pool"},
	["Isonade"]={"Isonade"},
}
if not workspace:FindFirstChild"platform"then
	local p=Instance.new"Part"
	p.Name="platform"
	p.Parent=workspace
	p.Transparency=.5
	p.Size=Vector3.new(2,0.1,2)
	p.Anchored=true
	p.CFrame=CFrame.new(0,0,0)
end
local fishingZones=workspace.zones.fishing
local vi=game:GetService"VirtualInputManager"
local rs=game:GetService"ReplicatedStorage"
local rsEvs=rs.events
local tempFolder=Instance.new("Folder",workspace)
local platform=workspace:FindFirstChild"platform"
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/gui%20lib.lua")()
local UI=GUI:CreateWindow("0x3b5 Internal Edition","v0.1")
function notify(ti,tx,d)
	game.StarterGui:SetCore("SendNotification",{
		Title=ti or"";
		Text=tx or"";
		Duration=d or 1;
	})
end
function Reverse(t)
	for i=1,math.floor(#t/2),1 do t[i],t[#t-i+1]=t[#t-i+1],t[i]end
	return t
end
function StrSplit(s,d)
	local r={}
	for w in s:gmatch("[^"..d.."]+")do table.insert(r,w)end
	return r
end
function mouse(x,y,d,l)
	vi:SendMouseButtonEvent(x,y,0,d,l or plr,0)
end
function tpTo(name)
	hrp.CFrame=CFrame.new(unpack(coords[name]))
end	
function tpOnPart(pt,t)
	local p=pt.Position
	local top=p.Y+pt.Size.Y/2+5
	platform.CFrame=CFrame.new(p.X,top-3,p.Z)
	hrp.CFrame=CFrame.new(p.X,top,p.Z)
end
function isAuroraActive()
	return plrGui.hud.safezone.worldstatuses["2_weather"].label.Text=="Aurora Borealis"
end
binds.main=game:GetService"RunService".Stepped:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr.Humanoid
		hrp=chr.HumanoidRootPart
		plrGui=plr.PlayerGui
		chr.oxygen.Disabled=togs.oxyg
		chr["oxygen(peaks)"].Disabled=togs.oxyg
		chr.temperature.Disabled=togs.temp
	end)
	if togs.cast then
		local rod=chr:FindFirstChildOfClass"Tool"
		if rod and rod:FindFirstChild"events"then
			if not rod.values.casted.Value then
				rod.events.cast:FireServer(1)
			end
		end
	end
	if togs.shake and plrGui:FindFirstChild"shakeui"and plrGui.shakeui.safezone:FindFirstChild"button"then
		local btn=plrGui.shakeui.safezone.button
		local x,y=btn.AbsolutePosition.X+btn.AbsoluteSize.X/1.5,btn.AbsolutePosition.Y+btn.AbsoluteSize.Y/1.5
		mouse(x,y,1,btn)
		mouse(x,y,0,btn)
	end
	if togs.instacatch and plrGui:FindFirstChild"reel"then
		if plrGui.reel.bar.playerbar.Transparency==0 then
			rsEvs["reelfinished "]:FireServer(100,math.random(0,100)~=0)
		end
	end
	if togs.appraise and cd.appraise then
		cd.appraise=false
		if appraiseSettings.slot then
			local done=false
			local item=plrGui.hud.safezone.backpack.hotbar[appraiseSettings.slot]
			local itemName,itemId=item.itemname.Text,item.item.Value
			if not chr:FindFirstChildOfClass"Tool"then
				for _,v in pairs(plr.Backpack:GetChildren())do
					if v:FindFirstChild"link"then
						if v.link.Value==itemId then
							v.Parent=chr
							break
						end
					end
				end
			end
			for k,v in pairs(appraiseSettings.mutations)do
				if v and itemName:find(k)then
					done=true
					UI.Appraise.Appraise.setStatus(false)
					break
				end
			end
			for k,v in pairs(appraiseSettings.attributes)do
				if v and itemName:find(k)then
					done=true
					UI.Appraise.Appraise.setStatus(false)
					break
				end
			end
			if not done and chr:FindFirstChildOfClass"Tool"then
				pcall(function()
					workspace.world.npcs.Appraiser.appraiser.appraise:InvokeServer()
				end)
			end
		end
		wait(.01)
		cd.appraise=true
	end
	if togs.luck and cd.luck then
		cd.luck=false
		pcall(function()
			workspace.world.npcs.Merlin.Merlin.luck:InvokeServer()
		end)
		wait(.1)
		cd.luck=true
	end
	if togs.anglerQ and cd.anglerQ1 then
		cd.anglerQ1=false
		pcall(function()
			local ag=workspace.world.npcs["The Depths Angler"].angler
			ag.giveQuest:InvokeServer()
			ag.questCompleted:InvokeServer()
		end)
		wait(.25)
		cd.anglerQ1=true
	end
	if togs.anglerQ and cd.anglerQ2 then
		cd.anglerQ2=false
		for _,v in pairs(plrGui.hud.deviceinset.quests:GetChildren())do
			if v:IsA"Frame"then
				if v.title.Text=="Angler Quest"then
					local goal=v.line1.Text
					if v.line1.TextColor3.r==1 then
						if not chr:FindFirstChild(goal)and plr.Backpack:FindFirstChild(goal)then
							rs.packages.Net["RE/Backpack/Equip"]:FireServer(plr.Backpack[goal])
						else
							for _,i in pairs(plr.Backpack:GetChildren())do
								if i.Name:lower():find"rod"then	
									rs.packages.Net["RE/Backpack/Equip"]:FireServer(i)
									break
								end
							end
						end
					end
				end
			end
		end
		wait(1)
		cd.anglerQ2=true
	end
	if togs.sell and cd.sell then
		cd.sell=false
		rsEvs.SellAll:InvokeServer()
		wait(5)
		cd.sell=true
	end
	if togs.evf and cd.evf then
		cd.evf=false
		local he=false
		for i=1,#events do
			local v=events[i]
			if v[2]>0 then
				local efv=nil
				for _,fz in pairs(fzs[v[1]])do
					if fishingZones:FindFirstChild(fz)then
						efv=fz
						break
					end
				end
				if efv then
					local fp=fishingZones:FindFirstChild(efv)
					if fp then
						he=true
						fp.CanCollide=true
						tpOnPart(fp)
						break
					end
				end
			end
		end
		if not he and vals.anchor then
			hrp.CFrame=vals.anchor
		end
		wait(.1)
		cd.evf=true
	end
	if togs.tpw and chr and hum then
		if hum.MoveDirection.Magnitude>0 then
			chr:TranslateBy(hum.MoveDirection*(vals.tpws/5))
		end
	end
end)
binds.jump=game.UserInputService.JumpRequest:Connect(function()
	if togs.infj and hum then
		hum:ChangeState"Jumping"
	end
end)
local Main=UI:addPage("Main",3,true,1)
local EvFarm=UI:addPage("Event Farming",3,false,1)
local Waypoints=UI:addPage("Locations",3,false,1)
local Appraisal=UI:addPage("Appraise",4,false,1)
local Local=UI:addPage("Local Player",3,false,1)
Main.addToggle("Auto Cast",togs.cast,function(v)
	togs.cast=v
	if v then
		cd.cast=true
	end
end)
Main.addToggle("Auto Shake",togs.shake,function(v)
	togs.shake=v
end)
Main.addToggle("Insta Catch",togs.instacatch,function(v)
	togs.instacatch=v
end)
Main.addToggle("Auto Sell",togs.sell,function(v)
	togs.sell=v
end)
Main.addToggle("Merlin Luck",togs.luck,function(v)
	togs.luck=v
end)
Main.addToggle("Angler Quest",togs.anglerQ,function(v)
	togs.anglerQ=v
end)
Waypoints.addDropdown("Areas",wps.areas,#wps.areas*0.235,function(v)
	tpTo(v)
end)
EvFarm.addLabel("Set the farming priority for each event","Set to -1 to excluded, priority ordered from 0 up to "..(#events-1))
EvFarm.addToggle("Start Farm",togs.evf,function(v)
	togs.evf=v
end)
for _,v in pairs(events)do
	EvFarm.addSlider(v[1],-1,#events-1,function(n)
		for k,j in pairs(events)do
			if j[1]==v[1]then
				events[k][2]=n+1
			end
		end
		table.sort(events,function(a,b)return a[2]<b[2]end)
	end)
end
EvFarm.addLabel("Select a location to farm while there are no events.","Just stand and face at the spot you wish to tp.")
EvFarm.addButton("Set Anchor",function()
	vals.anchor=hrp.CFrame
end)
Appraisal.addLabel("Equip the item you wish to appraise.","Ensure that it stays at the same hotbar slot.")
Appraisal.addToggle("Appraise",togs.appraise,function(v)
	local tool=chr:FindFirstChildOfClass"Tool"
	appraiseSettings.slot=nil
	if v then
		if not tool then
			notify("Not found","you are not holding an item.")
			wait(.2)
			UI.Appraise.Appraise.setStatus(false)
			return
		end
		for k,j in pairs(plrGui.hud.safezone.backpack.hotbar:GetChildren())do
			if j:IsA"ImageButton"then
				if j.hover.Visible and j.hover.GuiState==Enum.GuiState.Idle then
					appraiseSettings.slot=j.Name
					break
				end
			end
		end
		cd.appraise=true
	end
	togs.appraise=v
end)
Appraisal.addLabel("Auto-appraise stops when detecting any of the selected","Will run indefinitely when none selected")
Appraisal.addLabel("Attributes")
for k,v in pairs(appraiseSettings.attributes)do
	Appraisal.addToggle(k,v,function(b)
		appraiseSettings.attributes[k]=b
	end)
end
Appraisal.addLabel("Mutations")
for k,v in pairs(appraiseSettings.mutations)do
	Appraisal.addToggle(k,v,function(b)
		appraiseSettings.mutations[k]=b
	end)
end
Local.addToggle("Disable Drown/Suffocate",togs.oxyg,function(v)
	togs.oxyg=v
end)
Local.addToggle("Disable Temperature",togs.temp,function(v)
	togs.temp=v
end)
Local.addToggle("Invis Cam",togs.invcam,function(v)
	togs.invcam=v
	plr.DevCameraOcclusionMode=v and Enum.DevCameraOcclusionMode.Invisicam or Enum.DevCameraOcclusionMode.Zoom
end)
Local.addToggle("Inf Jump",togs.infj,function(v)
	togs.infj=v
end)
Local.addToggle("TP Walk",togs.tpw,function(v)
	togs.tpw=v
end)
Local.addSlider("TPWalk Speed",0,150,function(v)
	vals.tpws=v
end)
UI["Local Player"]["TPWalk Speed"].setValue(vals.tpws)
Local.addButton("Rejoin",function()
	plr:Kick"Rejoining..."
	wait()
	game:GetService"TeleportService":Teleport(game.PlaceId,plr)
end)
Main.destroyGui(function()
	for _,v in pairs(binds)do
		v:Disconnect()
	end
	for i,v in pairs(togs)do
		togs[i]=false
	end
	for i,v in pairs(cd)do
		cd[i]=false
	end
end)
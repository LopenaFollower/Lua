local x=game.PlaceId
if x^2-131579468225600*x-16732694052*x+2201678985343820114131200~=0 then return else repeat task.wait()until game:IsLoaded()and game.Players.LocalPlayer end
local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr:FindFirstChildWhichIsA"Humanoid"
local hrp=chr.HumanoidRootPart
local plrGui=plr.PlayerGui
local running=true
local fishingZones=workspace.zones.fishing
local lt=game:GetService"Lighting"
local vi=game:GetService"VirtualInputManager"
local rs=game:GetService"ReplicatedStorage"
local rsEvs=rs.events
local pstat=rs.playerstats[plr.Name].Stats
local rsWorld=rs.world
local cam=workspace.CurrentCamera
local runtime,auroraActive,sunkenActive
local pauseFishing=false
local binds={}
local togs={
	cast=false,
	lcst=false,
	shake=true,
	instacatch=true,
	appraise=false,
	luck=false,
	sell=false,
	anglerQ=false,
	evf=false,
	temp=true,
	invcam=true,
	click=false,
	sundialmeg=false,
	sundialkraken=false,
	oxyg=true,
	swim=false,
	fb=false,
	sunkenchest=false
}
local cd={
	cast=true,
	appraise=true,
	luck=true,
	sell=true,
	anglerQ1=true,
	anglerQ2=true,
	evf=true,
	click=true,
	spamsundial=true
}
local rates={
	money=0,
	xp=0
}
local vals={
	tpws=5,
	anchor=nil,
	acspeed=.1,
	money=pstat.coins.Value,
	xp=pstat.xp.Value
}
local totems={
	["Sundial Totem"]={
		use=false,
		during="Day",
		buyAmount=1,
		db=false
	},
	["Aurora Totem"]={
		use=false,
		buyAmount=1,
		db=false
	}
}
local wps={
	areas1={
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
		"Ancient Archives"
	},
	north={
		"Northern Summit",
		"Overgrowth Caves1",
		"Overgrowth Caves2",
		"Frigid Cavern1",
		"Frigid Cavern2",
		"Cryogenic Canal",
		"Glacial Grotto1",
		"Glacial Grotto2"
	},
	atlantis={
		"Grand Reef",
		"Atlantean Storm",
		"Atlantis Main",
		"Sunken Depths",
		"Ethereal Abyss",
		"Poseidon Temple",
		"Zeus Trial",
		"Kraken Pool"
	},
	items={
		"Rod Of The Depths"
	}
}
local coords={
	["Moosewood"]={387,135,256},
	["Roslit"]={-1464,133,724},
	["Roslit - Volcano"]={-1958,173,258},
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
	["Overgrowth Caves1"]={19756,415,5412},
	["Overgrowth Caves2"]={20306,272,5471},
	["Frigid Cavern1"]={20229,731,5685},
	["Frigid Cavern2"]={19844,439,5617},
	["Cryogenic Canal"]={20018,508,5415},
	["Glacial Grotto1"]={19958,1143,5537},
	["Glacial Grotto2"]={20034,883,5639},
	["Grand Reef"]={-3593,132,566},
	["Atlantean Storm"]={-3645,131,780},
	["Rod Of The Depths"]={1701,-903,1434},
	["Trident Puzzle"]={-1477,-225,-2321},
	["Atlantis Main"]={-4261,-603,1810},
	["Sunken Depths"]={-4938,-595,1835},
	["Ethereal Abyss"]={-3794,-564,1834},
	["Poseidon Temple"]={-4038,-558,922},
	["Zeus Trial"]={-4296,-627,2682},
	["Kraken Pool"]={-4375,-996,2049},
	["Aurora Totem"]={-1812,-137,-3282},
	["Sundial Totem"]={-1149,137,-1077}
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
	attributes={["Big"]=false,["Giant"]=false,["Shiny"]=false,["Sparkling"]=false}
}
local events={
	{"Shark Hunt",0},
	{"Megalodon",0},
	{"Depth Serpent",0},
	{"Isonade",0},
	{"Kraken",0},
	{"Orcas",0}
}
local fzs={
	["Shark Hunt"]={"Whale Shark","Great White Shark","Great Hammerhead Shark"},
	["Megalodon"]={"Megalodon Default"},
	["Depth Serpent"]={"The Depths - Serpent"},
	["Kraken"]={"The Kraken Pool"},
	["Isonade"]={"Isonade"},
	["Orcas"]={"Orcas Pool","Ancient Orcas Pool"}
}
local sunkenLocs={
	["moosewood"]={{936,130,-159},{693,130,-362},{613,130,498},{285,130,564},{283,130,-159}},
	["roslit"]={{-1179,130,565},{-1217,130,201},{-1967,130,980},{-2444,130,266},{-2444,130,-37}},
	["sunstone"]={{-852,130,-1560},{-1000,130,-751},{-1500,130,-750},{-1547,130,-1080},{-1618,130,-1560}},
	["terrapin"]={{798,130,1667},{562,130,2455},{393,130,2435},{-1,130,1632},{-190,130,2450}},
	["mushgrove"]={{2890,130,-997},{2729,130,-1098},{2410,130,-1110},{2266,130,-721}},
	["forsaken"]={{-2460,130,2047}}
}
lt.FogEnd=1e4
lt.FogStart=0
if not workspace:FindFirstChild"platform"then
	local p=Instance.new"Part"
	p.Name="platform"
	p.Parent=workspace
	p.Transparency=.5
	p.Size=Vector3.new(2,.1,2)
	p.Anchored=true
	p.CFrame=CFrame.new(0,0,0)
end
local platform=workspace:FindFirstChild"platform"
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/gui%20lib.lua")()
local UI=GUI:CreateWindow("0x3b5 Internal Edition","v1.1")
function notify(t,m,d)
	game.StarterGui:SetCore("SendNotification",{
		Title=t or"";
		Text=m or"";
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
function press(key)
	vi:SendKeyEvent(1,key,0,game)
	vi:SendKeyEvent(0,key,0,game)
end
function tpTo(name)
	hrp.CFrame=CFrame.new(unpack(coords[name]))
end	
function tpOnPart(pt)
	local p=pt.Position
	local top=p.Y+pt.Size.Y/2+5
	platform.CFrame=CFrame.new(p.X,top-3,p.Z)
	hrp.CFrame=CFrame.new(p.X,top,p.Z)
end
function equipBP(v)
	rs.packages.Net["RE/Backpack/Equip"]:FireServer(v)
end
function equipRod()
	for _,v in pairs(plr.Backpack:GetChildren())do
		if v.Name:lower():find"rod"then
			equipBP(v)
			break
		end
	end
end
function useTotem(name)
	local totem=plr.Backpack:FindFirstChild(name)
	if totem then
		repeat task.wait()until not plrGui:FindFirstChild"reel"
		print("use")
		equipBP(totem)
		task.wait(.5)
		mouse(0,0,1)
		mouse(0,0,0)
		task.wait(.4)
		equipRod()
	else
		local pos=hrp.CFrame
		hrp.Anchored=true
		pauseFishing=true
		task.wait(.1)
		while task.wait()do
			if not plrGui:FindFirstChild"reel"and not plrGui:FindFirstChild"shakeui"then
				task.wait(.05)
				local rod=chr:FindFirstChildOfClass"Tool"
				if rod and rod:FindFirstChild"events"then
					rod.events.reset:FireServer()
				end
				break
			end
		end
		tpTo(name)
		task.wait(1)
		totems[name].db=true
		while true do
			cam.CFrame=hrp.CFrame*CFrame.Angles(-2,0,0)
			press(101)
			task.wait(1.5)
			if plr.Backpack:FindFirstChild(name)then
				break
			end
		end
		totems[name].db=false
		task.wait(.1)
		useTotem(name)
		hrp.CFrame=pos
		pauseFishing=false
		hrp.Anchored=false
	end
end
binds.main=game:GetService"RunService".Stepped:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr.Humanoid
		hrp=chr.HumanoidRootPart
		plrGui=plr.PlayerGui
		chr.temperature.Disabled=togs.temp
		chr.oxygen.Disabled=togs.oxyg
		chr["oxygen(peaks)"].Disabled=togs.oxyg
		UI.Stats.Money.setInfo(rates.money.."/min")
		UI.Stats.XP.setInfo(rates.xp.."/min")
		plrGui.uiparticles.Enabled=false
		plr.Passdown:Destroy()
	end)
	if togs.tpw and chr and hum then
		if hum.MoveDirection.Magnitude>0 then
			chr:TranslateBy(hum.MoveDirection*vals.tpws/5)
		end
	end
	if togs.cast and cd.cast and not pauseFishing then
		cd.cast=false
		local rod=chr:FindFirstChildOfClass"Tool"
		if rod and rod:FindFirstChild"events"then
			if not rod.values.casted.Value then
				if togs.lcst then
					mouse(0,0,1)
					task.wait(.45)
					mouse(0,0,0)
				else
					rod.events.cast:FireServer(1)
				end
				task.wait(.1)
			end
		end
		cd.cast=true
	end
	if togs.shake and plrGui:FindFirstChild"shakeui"and plrGui.shakeui.safezone:FindFirstChild"button"then
		local btn=plrGui.shakeui.safezone.button
		btn.Position=UDim2.new(.5,0,.5,0)
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
		task.wait(.01)
		cd.appraise=true
	end
	if togs.luck and cd.luck then
		cd.luck=false
		pcall(function()
			workspace.world.npcs.Merlin.Merlin.luck:InvokeServer()
		end)
		task.wait(.05)
		cd.luck=true
	end
	if togs.anglerQ and cd.anglerQ1 then
		cd.anglerQ1=false
		pcall(function()
			local ag=workspace.world.npcs["The Depths Angler"].angler
			ag.giveQuest:InvokeServer()
			ag.questCompleted:InvokeServer()
		end)
		task.wait(.25)
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
							equipBP(plr.Backpack[goal])
						else
							equipRod()
						end
					end
				end
			end
		end
		task.wait(1)
		cd.anglerQ2=true
	end
	if togs.sell and cd.sell then
		cd.sell=false
		rsEvs.SellAll:InvokeServer()
		task.wait(5)
		cd.sell=true
	end
	if togs.evf and cd.evf and not pauseFishing and not sunkenActive then
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
			task.wait(.1)
		end
		cd.evf=true
	end
	if cd.spamsundial then
		cd.spamsundial=false
		local use=false
		if not workspace.zones.fishing:FindFirstChild"Megalodon Default"and togs.sundialmeg then
			use=true
		elseif not workspace.zones.fishing:FindFirstChild"The Kraken Pool"and togs.sundialkraken then
			use=true
		end
		if use then
			useTotem("Sundial Totem")
		end
	end
end)
binds.fps60=game:GetService"RunService".RenderStepped:Connect(function()
	pcall(function()
		if togs.fb then
			lt.brightness.Enabled=true
			lt.cc.Enabled=false
			lt.location.Enabled=false
			lt.uiblur.Enabled=false
			lt.uicc.Enabled=false
			lt.underwaterbl.Enabled=false
			lt.underwatercc.Enabled=false
			lt.atmos.Density=0
		end
		hum:SetStateEnabled(4,not togs.swim)
		if togs.swim then
			chr.Head.ui:Destroy()
		end
	end)
	if togs.click and cd.click then
		cd.click=false
		mouse(0,0,1)
		mouse(0,0,0)
		task.wait(vals.acspeed)
		cd.click=true
	end
end)
binds.jump=game.UserInputService.JumpRequest:Connect(function()
	if togs.infj and hum then
		hum:ChangeState"Jumping"
	end
end)
binds.over=plrGui.over.ChildAdded:Connect(function(p)
	if p.Name=="prompt"and p:FindFirstChild"question"then
		for k,v in pairs(totems)do
			local q=p.question
			if q.Text:find(k)and v.db then
				plrGui.over.prompt.amount.Text=v.buyAmount
				press(92)
				task.wait(.01)
				press(115)
				task.wait(.02)
				press(13)
				task.wait(.01)
				press(92)
			end
		end
	end
end)
binds.anno=rsEvs.anno_top.OnClientEvent:Connect(function(a)
	local l=a:lower()
	if l:find"sunken treasure"and togs.sunkenchest then
		sunkenActive=true
		task.wait(.2)
		for k,v in pairs(sunkenLocs)do
			if l:find(k)then
				for _,p in pairs(v)do
					hrp.CFrame=CFrame.new(unpack(p))
					hrp.Anchored=true
					task.wait(.1)
					local pad=workspace.ActiveChestsFolder:FindFirstChild"Pad"
					if pad and pad:FindFirstChild"Spawns"then
						for _,c in pairs(pad.Spawns:GetChildren())do
							hrp.CFrame=c.CFrame
							cam.CFrame=hrp.CFrame*CFrame.Angles(-2,0,0)
							task.wait(.1)
							press(101)
						end
						break
					end
				end
			end
		end
		sunkenActive=false
		hrp.Anchored=false
	end
end)
binds.cycle=rsWorld.cycle.Changed:Connect(function()
	local v=rsWorld.cycle.Value
	local usingTotem=rsWorld.totemInUse.Value
	task.wait(.1)
	if not usingTotem and totems["Sundial Totem"].use then
		if totems["Sundial Totem"].during==v or totems["Sundial Totem"].during=="Always"then
			useTotem("Sundial Totem")
		end
	end
	if v=="Night"then
		task.wait(.4)
		if not usingTotem and not auroraActive and totems["Aurora Totem"].use then
			useTotem("Aurora Totem")
		end
	end
	task.wait(.1)
	cd.spamsundial=true
end)
binds.weather=rsWorld.weather.Changed:Connect(function()
	local v=rsWorld.weather.Value
	auroraActive=v=="Aurora_Borealis"
end)
binds.money=pstat.coins:GetPropertyChangedSignal("Value"):Connect(function()
	local v=pstat.coins.Value
	local c=v-vals.money
	rates.money=rates.money+c
	vals.money=v
	task.spawn(function()
		task.wait(60)
		rates.money=rates.money-c
	end)
end)
binds.xp=pstat.xp:GetPropertyChangedSignal("Value"):Connect(function()
	local v=pstat.xp.Value
	local c=v-vals.xp
	if c<0 then return end
	rates.xp=rates.xp+c
	vals.xp=v
	task.spawn(function()
		task.wait(60)
		rates.xp=rates.xp-c
	end)
end)
local Main=UI:addPage("Main",3,true,1)
local EvFarm=UI:addPage("Event Farming",3,false,1)
local Waypoints=UI:addPage("Locations",3,false,1)
local Appraisal=UI:addPage("Appraise",4,false,1)
local ATotem=UI:addPage("Totems",4,false,1)
local Stats=UI:addPage("Stats",4,false,1)
local Local=UI:addPage("Local Player",3,false,1)
Main.addToggle("Auto Cast",togs.cast,function(v)
	togs.cast=v
	if not runtime then runtime=os.time()end
	if v then
		cd.cast=true
	end
end)
Main.addToggle("Legit Cast",togs.lcst,function(v)
	togs.lcst=v
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
Waypoints.addDropdown("Main Areas",wps.areas1,nil,function(v)
	tpTo(v)
end)
Waypoints.addDropdown("Northern Expedition",wps.north,nil,function(v)
	tpTo(v)
end)
Waypoints.addDropdown("Atlantis",wps.atlantis,nil,function(v)
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
EvFarm.addToggle("Sunken Treasure",togs.sunkenchest,function(v)
	togs.sunkenchest=v
end)
Appraisal.addLabel("Equip the item you wish to appraise.","Ensure that it stays at the same hotbar slot.")
Appraisal.addToggle("Appraise",togs.appraise,function(v)
	local tool=chr:FindFirstChildOfClass"Tool"
	appraiseSettings.slot=nil
	if v then
		if not tool then
			notify("Not found","you are not holding an item.")
			task.wait(.2)
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
for k,o in pairs(totems)do
	ATotem.addToggle("Auto use "..k,o.use,function(v)
		o.use=v
	end)
	ATotem.addSlider("Buy Amount",1,10,function(v)
		o.buyAmount=tonumber(v)
	end)
	if o.during~=nil then
		ATotem.addDropdown("Use during",{"Day","Night","Always"},nil,function(v)
			o.during=v
		end)
	end
	ATotem.addLabel("")
end
ATotem.addToggle("Megalodon",togs.sundialmeg,function(v)
	togs.sundialmeg=v
	if v then
		cd.spamsundial=true
	end
end)
ATotem.addToggle("Kraken",togs.sundialkraken,function(v)
	togs.sundialkraken=v
	if v then
		cd.spamsundial=true
	end
end)
Stats.addLabel("Money","0/hr","Left")
Stats.addLabel("XP","0/hr","Left")
Local.addToggle("Disable Temperature",togs.temp,function(v)
	togs.temp=v
end)
Local.addToggle("Infinite Oxygen",togs.oxyg,function(v)
	togs.oxyg=v
end)
Local.addToggle("No Swim",togs.swim,function(v)
	togs.swim=v
end)
Local.addToggle("Invis Cam",togs.invcam,function(v)
	togs.invcam=v
	plr.CameraMaxZoomDistance=300
	plr.DevCameraOcclusionMode=v and Enum.DevCameraOcclusionMode.Invisicam or Enum.DevCameraOcclusionMode.Zoom
end)
Local.addToggle("Fullbright/No blur",togs.fb,function(v)
	togs.fb=v
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
Local.addToggle("Auto Click",togs.click,function(v)
	togs.click=v
end)
Local.addTextBox("Click Speed(seconds)",vals.acspeed,function(v)
	vals.acspeed=tonumber(v)
end)
Local.addButton("Rejoin",function()
	plr:Kick"Rejoining..."
	task.wait()
	game:GetService"TeleportService":Teleport(game.PlaceId,plr)
end)
Main.destroyGui(function()
	running=false
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
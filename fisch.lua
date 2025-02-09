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
local auroraActive,sunkenActive
local pauseFishing=false
local startTime=os.time()
local sessionStart=os.time()
local binds={}
local togs={
	cast=false,
	lcst=false,
	shake=true,
	autocatch=true,
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
	sunkenchest=false,
	enchant=false,
	reducelag=false
}
local cd={
	cast=true,
	catch=true,
	appraise=true,
	luck=true,
	sell=true,
	anglerQ1=true,
	anglerQ2=true,
	evf=true,
	click=true,
	spamsundial=true,
	webhook=true
}
local webhookOpt={
	enabled=false,
	test=false,
	url=""
}
local rates={
	money=0,
	xp=0
}
local vals={
	tpws=5,
	anchor=nil,
	acspeed=.1,
	catch=0,
	perfect=100,
	money=pstat.coins.Value,
	xp=pstat.xp.Value,
	enchant="none"
}
local purchase={
	["Bait Crate"]={v=false,a=1},
	["Quality Bait Crate"]={v=false,a=1},
	["Coral Geode"]={v=false,a=1}
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
local events={
	{"Shark Hunt",0,false},
	{"Megalodon",0,false},
	{"Depth Serpent",0,false},
	{"Isonade",0,true},
	{"Kraken",0,false},
	{"Orcas",0,false},
	{"Ancient Orcas",0,false},
	{"Lovestorm",0,false}
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
		Abyssal=false,
		Albino=false,
		Amber=false,
		Darkened=false,
		Electric=false,
		Fossilized=false,
		Frozen=false,
		Glossy=false,
		Greedy=false,
		Hexed=false,
		Lunar=false,
		Midas=false,
		Mosaic=false,
		Mythical=false,
		Negative=false,
		Scorched=false,
		Silver=false,
		Translucent=false
	},
	attributes={Big=false,Giant=false,Shiny=false,Sparkling=false}
}
local fzs={
	["Shark Hunt"]={"Whale Shark","Great White Shark","Great Hammerhead Shark"},
	["Megalodon"]={"Megalodon Default"},
	["Depth Serpent"]={"The Depths - Serpent"},
	["Kraken"]={"The Kraken Pool"},
	["Isonade"]={"Isonade"},
	["Orcas"]={"Orcas Pool"},
	["Ancient Orcas"]={"Ancient Orcas Pool"},
	["Lovestorm"]={"Lovestorm Eel","Lovestorm Eel Supercharged"}
}
local sunkenLocs={
	moosewood={{936,130,-159},{693,130,-362},{613,130,498},{285,130,564},{283,130,-159}},
	roslit={{-1179,130,565},{-1217,130,201},{-1967,130,980},{-2444,130,266},{-2444,130,-37}},
	sunstone={{-852,130,-1560},{-1000,130,-751},{-1500,130,-750},{-1547,130,-1080},{-1618,130,-1560}},
	terrapin={{798,130,1667},{562,130,2455},{393,130,2435},{-1,130,1632},{-190,130,2450}},
	mushgrove={{2890,130,-997},{2729,130,-1098},{2410,130,-1110},{2266,130,-721}},
	forsaken={{-2460,130,2047}}
}
local enchants={"Abyssal","Blessed","Breezed","Clever","Controlled","Divine","Ghastly","Hasty","Herculean","Insight","Long","Lucky","Mutated","Noir","Quality","Resilient","Scrapper","Sea King","Steady","Storming","Swift","Unbreakable","Wormhole"}
if not workspace:FindFirstChild"platform"then
	local p=Instance.new"Part"
	p.Name="platform"
	p.Parent=workspace
	p.Transparency=.75
	p.Size=Vector3.new(2,.1,2)
	p.Anchored=true
	p.CFrame=CFrame.new(0,0,0)
end
local platform=workspace:FindFirstChild"platform"
local WHC=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/webhook.lua")()
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/gui%20lib.lua")()
local UI=GUI:CreateWindow("0x3b5 Internal Edition","v1.2")
function notify(t,m,d)
	game.StarterGui:SetCore("SendNotification",{
		Title=t or"";
		Text=m or"";
		Duration=d or 1;
	})
end
function toHMS(s)
	return string.format("%02i:%02i:%02i",s/3600,s/60%60,s%60)
end
function formatNum(n)
	return tostring(math.floor(n)):reverse():gsub("(%d%d%d)","%1,"):gsub(",(%-?)$","%1"):reverse()
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
function tpOnPart(pt,t)
	local p=pt.Position
	local h=t and pt.Size.Y/2 or 0
	local top=t and pt.Size.Y/2+5 or pt.Size.Y/4
	platform.CFrame=CFrame.new(p.X,p.Y+top-3,p.Z)
	hrp.CFrame=CFrame.new(p.X,p.Y+top,p.Z)
end
function removeVelocity()
	pcall(function()
		hrp.AssemblyAngularVelocity=Vector3.zero
		hrp.AssemblyLinearVelocity=Vector3.zero
		hrp.Velocity=Vector3.zero
	end)
end
function unequip()
	for _,v in pairs(chr:GetChildren())do
		if v:IsA"Tool"then
			v.Parent=plr.Backpack
		end
	end
end
function equipBP(v)
	rs.packages.Net["RE/Backpack/Equip"]:FireServer(v)
end
function getRod()
	for _,v in pairs(chr:GetChildren())do
		if v:IsA"Tool"and v.Name:lower():find"rod"then
			return v
		end
	end
	for _,v in pairs(plr.Backpack:GetChildren())do
		if v.Name:lower():find"rod"then
			return v
		end
	end
end
function equipRod()
	equipBP(getRod())
end
function useTotem(name)
	local totem=plr.Backpack:FindFirstChild(name)
	if totem then
		repeat task.wait()until not plrGui:FindFirstChild"reel"
		equipBP(totem)
		task.wait(.25)
		mouse(0,0,1)
		mouse(0,0,0)
		task.wait(.1)
		mouse(0,0,1)
		mouse(0,0,0)
		task.wait(.4)
		equipRod()
	else
		if totems[name].buyAmount==0 then return end
		local pos=hrp.CFrame
		pauseFishing=true
		task.wait(.1)
		while task.wait()do
			removeVelocity()
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
		removeVelocity()
		totems[name].db=true
		task.wait(.5)
		while totems[name].db do
			tpTo(name)
			removeVelocity()
			totems[name].db=true
			cam.CFrame=hrp.CFrame*CFrame.Angles(-2,0,0)
			press(101)
			task.wait(1)
		end
		task.wait(.1)
		useTotem(name)
		hrp.CFrame=pos
		pauseFishing=false
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
		UI.Stats.Uptime.setInfo(toHMS(os.time()-sessionStart))
		UI.Stats.Money.setInfo(formatNum(rates.money).."/hr")
		UI.Stats.XP.setInfo(formatNum(rates.xp).."/hr")
		if togs.fb then
			lt.brightness.Enabled=true
			lt.cc.Enabled=false
			lt.location.Enabled=false
			lt.uiblur.Enabled=false
			lt.uicc.Enabled=false
			lt.underwaterbl.Enabled=false
			lt.underwatercc.Enabled=false
			lt.atmos.Density=0
			lt.FogEnd=1e4
			lt.FogStart=0
		end
		local ea=workspace.world.interactables:FindFirstChild"Enchant Altar"
		if ea then
			ea.ProximityPrompt.HoldDuration=0
		end
		plr.Passdown:Destroy()
	end)
	if togs.tpw and chr and hum then
		if hum.MoveDirection.Magnitude>0 then
			chr:TranslateBy(hum.MoveDirection*vals.tpws/5)
		end
	end
	if togs.cast and cd.cast and not pauseFishing then
		cd.cast=false
		local rod=getRod()
		if rod and rod:FindFirstChild"values"then
			if not rod.values.casted.Value then
				if togs.lcst then
					mouse(0,0,1)
					task.wait(.4)
					mouse(0,0,0)
				else
					rod.events.cast:FireServer(1)
					task.wait(.25)
				end
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
		task.wait(.5)
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
						elseif not chr:FindFirstChild(getRod().Name)then
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
						removeVelocity()
						hum:SetStateEnabled(4,false)
						tpOnPart(fp,v[3])
						hum:ChangeState"Running"
						break
					end
				end
			end
		end
		if not he then
			hum:SetStateEnabled(4,not togs.swim)
			hrp.Anchored=false
			if vals.anchor then
				hrp.CFrame=vals.anchor
				task.wait(.1)
			end
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
			useTotem"Sundial Totem"
		end
	end
	if togs.click and cd.click then
		cd.click=false
		mouse(0,0,1)
		mouse(0,0,0)
		task.wait(vals.acspeed)
		cd.click=true
	end
	if(webhookOpt.enabled or webhookOpt.test)and cd.webhook and webhookOpt.url~=""then
		cd.webhook=false
		local lt=DateTime.now():ToLocalTime()
		if lt.Minute==0 or webhookOpt.test then
			local w=WHC:connect(webhookOpt.url)
			w:title"Hourly Report"
			w:author("0x3b5","https://discord.gg/Fh5rmgg27X","https://media.discordapp.net/attachments/1320467041752449116/1332649895445790761/101_20250125105259.png")
			w:addField("Money",formatNum(math.ceil(pstat.coins.Value)).."C$ ("..formatNum(rates.money).."/hr)",true)
			w:addField("Level",formatNum(pstat.level.Value).." ("..formatNum(rates.xp).." XP/hr)",true)
			w:footer("Uptime: "..toHMS(os.time()-sessionStart))
			w:timestamp()
			w:send()
			if webhookOpt.test then
				task.wait(1)
			else
				task.wait(70)
			end
			webhookOpt.test=false
		else
			task.wait(5)
		end
		cd.webhook=true
	end
end)
binds.jump=game.UserInputService.JumpRequest:Connect(function()
	if togs.infj and hum then
		hum:ChangeState"Jumping"
	end
end)
binds.over=plrGui.over.ChildAdded:Connect(function(p)
	if p.Name=="prompt"and p:FindFirstChild"question"then
		local q=p.question
		for k,v in pairs(totems)do
			if q.Text:find(k)and v.db then
				p.Position=UDim2.new(0.15,0,0,0)
				p.amount.Text=v.buyAmount
				repeat
					press(92)
					press(97)
					task.wait()
					press(13)
				until not plrGui.over:FindFirstChild"prompt"
				mouse(0,0,1)
				mouse(0,0,0)
				v.db=false
			end
		end
	end
end)
binds.chr=chr.DescendantAdded:Connect(function(v)
	if togs.reducelag then
		if v:IsA"Model"and v.Name~="Stoke"and v.Parent.Name=="bobber"then
			task.wait()
			v:Destroy()
		end
	end
	if v.Name=="ui"and v.Parent==chr.Head then
		v.Enabled=false
	end
end)
binds.active=workspace.active.ChildAdded:Connect(function(v)
	if togs.reducelag then
		if v:IsA"Model"or(v:IsA"Part"and v.Name=="splash")then
			task.wait()
			v:Destroy()
		end
	end
end)
binds.grandReef=workspace.world.map["Grand Reef"].DescendantAdded:Connect(function(v)
	if togs.reducelag then
		if v:IsA"Model"and(v.Name=="Barrel"or v.Name=="Fence"or v.Name=="Curve")or v:IsA"Folder"and(v.Name=="Coral"or v.Name=="Seaweed")or v:IsA"ParticleEmitter"then
			task.wait()
			v:Destroy()
		end
	end
end)
binds.anno=rsEvs.anno_top.OnClientEvent:Connect(function(a)
	local l=a:lower()
	if l:find"sunken treasure"and togs.sunkenchest then
		sunkenActive=true
		task.wait(.1)
		for k,v in pairs(sunkenLocs)do
			if l:find(k)then
				for _,p in pairs(v)do
					hrp.CFrame=CFrame.new(unpack(p))
					task.wait(1.2)
					local pad=workspace.ActiveChestsFolder:FindFirstChild"Pad"
					if pad and pad:FindFirstChild"Spawns"then
						for _,v in pairs(pad:GetDescendants())do
							if v:IsA"ProximityPrompt"then
								v.MaxActivationDistance=1000
								v.RequiresLineOfSight=false
								v.HoldDuration=0
							end
						end
						task.wait(.2)
						for _,c in pairs(pad.Spawns:GetChildren())do
							hrp.CFrame=c.CFrame
							removeVelocity()
							cam.CFrame=hrp.CFrame*CFrame.Angles(-2,0,0)
							for i=0,5 do
								press(101)
								task.wait(.125)
								press(111)
							end
						end
						sunkenActive=false
						break
					end
				end
			end
		end
	end
end)
binds.cycle=rsWorld.cycle.Changed:Connect(function()
	local v=rsWorld.cycle.Value
	local usingTotem=rsWorld.totemInUse.Value
	task.wait(.1)
	if not usingTotem and totems["Sundial Totem"].use then
		if totems["Sundial Totem"].during==v or totems["Sundial Totem"].during=="Always"then
			useTotem"Sundial Totem"
		end
	end
	if v=="Night"then
		task.wait(.4)
		if not usingTotem and not auroraActive and totems["Aurora Totem"].use then
			useTotem"Aurora Totem"
		end
	end
	task.wait(.1)
	cd.spamsundial=true
end)
binds.reel=plrGui.ChildAdded:Connect(function(v)
	if v.Name=="reel"and togs.autocatch then
		local wt=os.time()
		repeat
			v.bar.playerbar.Size=UDim2.new(1,0,1.3,0)
			task.wait()
			if os.time()>=wt+vals.catch then
				rsEvs["reelfinished "]:FireServer(100,math.random(1,100)<=vals.perfect)
			end
		until not plrGui:FindFirstChild"reel"
	end
end)
binds.weather=rsWorld.weather.Changed:Connect(function()
	local v=rsWorld.weather.Value
	auroraActive=v=="Aurora_Borealis"
end)
binds.money=pstat.coins:GetPropertyChangedSignal"Value":Connect(function()
	local c=pstat.coins.Value-vals.money
	local t=os.time()-startTime
	rates.money=math.round(3600/t*c)
end)
binds.xp=pstat.xp:GetPropertyChangedSignal"Value":Connect(function()
	local c=pstat.xp.Value-vals.xp
	if c<0 then return end
	local t=os.time()-startTime
	rates.xp=math.round(3600/t*c)
end)
local blacklist={"Trusted","Content Creator","Tester","Contributor","Tester 2","Tester 2","Analytics","Trial Mod","Moderator","Senior Mod","Admin","Developer","Lead","Creator","Holder"}
binds.plrs=game.Players.PlayerAdded:Connect(function(v)
	local role=v:GetRoleInGroup(7381705)
	for i,v in pairs(blacklist)do
		if v==role then
			plr:Kick"Staff detected"
			break
		end
	end
end)
local Main=UI:addPage("Main",2,true)
local Waypoints=UI:addPage("Locations",1)
local EvFarm=UI:addPage("Event Farming",2)
local Appraisal=UI:addPage("Appraise",4)
local Enchant=UI:addPage("Enchant",1)
local ATotem=UI:addPage("Totems",2)
local Stats=UI:addPage("Stats",1)
local Webhook=UI:addPage("Webhook",1)
local Local=UI:addPage("Local Player",2)
Main.addToggle("Auto Cast",togs.cast,function(v)
	togs.cast=v
end)
Main.addToggle("Legit Cast",togs.lcst,function(v)
	togs.lcst=v
end)
Main.addToggle("Auto Shake",togs.shake,function(v)
	togs.shake=v
end)
Main.addToggle("Auto Catch",togs.autocatch,function(v)
	togs.autocatch=v
end)
Main.addSlider("Catch Delay",{min=0,max=30,default=vals.catch},function(v)
	vals.catch=v
end)
Main.addSlider("Perfect Catch rate",{min=0,max=100,default=vals.perfect},function(v)
	vals.perfect=v
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
EvFarm.addToggle("Sunken Treasure",togs.sunkenchest,function(v)
	togs.sunkenchest=v
end)
EvFarm.addLabel("Set the farming priority for each event","Set to -1 to excluded, priority ordered from 0 up to "..(#events-1))
EvFarm.addToggle("Start Farm",togs.evf,function(v)
	togs.evf=v
	hrp.Anchored=false
end)
for _,v in pairs(events)do
	EvFarm.addSlider(v[1],{min=-1,max=#events-1,default=v[2]-1},function(n)
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
Appraisal.addLabel"Attributes"
for k,v in pairs(appraiseSettings.attributes)do
	Appraisal.addToggle(k,v,function(b)
		appraiseSettings.attributes[k]=b
	end)
end
Appraisal.addLabel"Mutations"
for k,v in pairs(appraiseSettings.mutations)do
	Appraisal.addToggle(k,v,function(b)
		appraiseSettings.mutations[k]=b
	end)
end
Enchant.addToggle("Auto enchant",togs.enchant,function(v)
	togs.enchant=v
	if v and rsWorld.cycle.Value=="Night"then
		repeat
			tpTo"Keepers Altar"
			equipBP(plr.Backpack["Enchant Relic"])
			task.wait(.1)
			repeat
				press(101)
				task.wait()
			until plrGui.over:FindFirstChild"prompt"or not togs.enchant or rsWorld.cycle.Value=="Day"or pstat.Parent.Rods[getRod().Name].Value==vals.enchant	
			press(92)
			press(115)
			press(13)
		until pstat.Parent.Rods[getRod().Name].Value==vals.enchant or not togs.enchant or rsWorld.cycle.Value=="Day"
		mouse(0,0,1)
		mouse(0,0,0)
		UI.Enchant["Auto enchant"].setStatus(false)
	end
end)
Enchant.addDropdown("Enchant",enchants,nil,function(v)
	vals.enchant=v
end)
for k,o in pairs(totems)do
	ATotem.addToggle("Auto use "..k,o.use,function(v)
		o.use=v
	end)
	ATotem.addSlider("Buy Amount",{min=0,max=10,default=o.buyAmount},function(v)
		o.buyAmount=v
	end)
	if o.during~=nil then
		ATotem.addDropdown("Use during",{"Day","Night","Always"},nil,function(v)
			o.during=v
		end)
	end
	ATotem.addLabel""
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
Stats.addLabel("Uptime","0:00:00","Left")
Stats.addButton("Reset",function()
	vals.money=pstat.coins.Value
	vals.xp=pstat.xp.Value
	startTime=os.time()
	rates.money=0
	rates.xp=0
end)
Stats.addLabel("Money","0/hr","Left")
Stats.addLabel("XP","0/hr","Left")
Webhook.addLabel"This webhook serves as an hourly report"
Webhook.addTextBox("Url",webhookOpt.url,function(v)
	webhookOpt.url=v
end)
Webhook.addToggle("Enable Webhook",webhookOpt.enabled,function(v)
	webhookOpt.enabled=v
end)
Webhook.addButton("Test Webhook",function()
	if not webhookOpt.test then
		webhookOpt.test=true
	end
end)
Local.addToggle("Disable Temperature",togs.temp,function(v)
	togs.temp=v
end)
Local.addToggle("Infinite Oxygen",togs.oxyg,function(v)
	togs.oxyg=v
end)
Local.addToggle("No Swim",togs.swim,function(v)
	togs.swim=v
	hum:SetStateEnabled(4,not togs.swim)
	hum:ChangeState"Running"
end)
Local.addToggle("Invis Cam",togs.invcam,function(v)
	togs.invcam=v
	plr.CameraMaxZoomDistance=300
	plr.DevCameraOcclusionMode=v and Enum.DevCameraOcclusionMode.Invisicam or Enum.DevCameraOcclusionMode.Zoom
end)
Local.addToggle("Fullbright/No blur",togs.fb,function(v)
	togs.fb=v
end)
Local.addToggle("Reduce Lag",togs.reducelag,function(v)
	togs.reducelag=v
end)
Local.addToggle("Inf Jump",togs.infj,function(v)
	togs.infj=v
end)
Local.addToggle("TP Walk",togs.tpw,function(v)
	togs.tpw=v
end)
Local.addSlider("TPWalk Speed",{min=0,max=150,default=vals.tpws},function(v)
	vals.tpws=v
end)
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
local x=game.PlaceId
if(x-131579468225600)*(x-16732694052)~=0 then return else repeat task.wait()until game:IsLoaded()and game.Players.LocalPlayer end
local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr:FindFirstChildWhichIsA"Humanoid"
local hrp=chr.HumanoidRootPart
local plrGui=plr.PlayerGui
local running=true
local fishingZones=workspace.zones.fishing
local lt=game:GetService"Lighting"
local us=game:GetService"UserInputService"
local rs=game:GetService"ReplicatedStorage"
local vi=game:GetService"VirtualInputManager"
local pstat=rs.playerstats[plr.Name].Stats
local rsEvs=rs.events
local rsWorld=rs.world
local cam=workspace.CurrentCamera
local auroraActive,sunkenActive,plrListDD,RSanchor
local pauseFishing=false
local usingTtm=false
local firstReel=true
local resetCycle=false
local lastReel=os.clock()
local startTime=os.time()
local sessionStart=os.time()
local plrNames={}
local statGuis={}
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
	rl_parts=false,
	seralaser=false,
	rmvfish=false,
	rodspam=false,
	equiprod=false
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
	webhook=true,
	rodspam=true,
	equiprod=true,
	resCyc=true,
	test=true
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
	enchant="none",
	crateType="",
	crateAmnt=1,
	totemType="",
	totemAmnt=1,
	pRod=""
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
	{"Scylla",0,false},
	{"Whales",0,false}
}
local fzs={
	["Shark Hunt"]={"Whale Shark","Great White Shark","Great Hammerhead Shark"},
	["Megalodon"]={"Megalodon Default"},
	["Depth Serpent"]={"The Depths - Serpent"},
	["Kraken"]={"The Kraken Pool"},
	["Isonade"]={"Isonade"},
	["Orcas"]={"Orcas Pool"},
	["Ancient Orcas"]={"Ancient Orcas Pool"},
	["Scylla"]={"Forsaken Veil - Scylla"},
	["Whales"]={"Whales Pool"}
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
	veil={
		"Volcanic Vents1",
		"Volcanic Vents2",
		"Challenger's Deep1",
		"Challenger's Deep2",
		"Abyssal Zenith",
		"Large Gate",
		"Calm Zone",
		"Veil of the Forsaken"
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
	["Sundial Totem"]={-1149,137,-1077},
	["Volcanic Vents1"]={-3472,-2258,3848},
	["Volcanic Vents2"]={-3196,-2039,4031},
	["Challenger's Deep1"]={-760,-3283,-702},
	["Challenger's Deep2"]={726,-3361,-1580},
	["Abyssal Zenith"]={-13496,-11050,144},
	["Large Gate"]={-4332,-11183,3228},
	["Calm Zone"]={-4317,-11185,3678},
	["Veil of the Forsaken"]={-2342,-11184,7095}
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
for _,v in pairs(game.Players:GetPlayers())do
	table.insert(plrNames,v.Name)
end
local platform=workspace:FindFirstChild"platform"
local WHC=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/webhook.lua")()
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/gui%20lib.lua")()
local UI=GUI:CreateWindow("0x3b5 Internal Edition","v1.3.4")
function notify(t,m,d)
	game.StarterGui:SetCore("SendNotification",{
		Title=t or"";
		Text=m or"";
		Duration=d or 1;
	})
end
function toHMS(s)
	return string.format("%02i:%02i:%02i",s//3600,s//60%60,s%60)
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
function nearest(folder)
	local n,d=nil,math.huge
	for _,v in pairs(folder:GetChildren())do
		local cd=(hrp.Position-v.Position).Magnitude
		if n==nil or cd<d then
			d=cd
			n=v
		end
	end
	return n
end
function updAnchor(g)
	if togs.rodspam then
		RSanchor=g or hrp.CFrame
	else
		RSanchor=nil
	end
end
function tpTo(name)
	hrp.CFrame=CFrame.new(unpack(coords[name]))
end	
function tpOnPart(pt,t)
	local p=pt.Position
	local top=t and pt.Size.Y/2+5 or pt.Size.Y/4
	platform.CFrame=CFrame.new(p.X,p.Y+top-3,p.Z)
	local d=CFrame.new(p.X,p.Y+top,p.Z)
	hrp.CFrame=d
	return d
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
	local rn=pstat.rod.Value
	return chr:FindFirstChild(rn)or plr.Backpack:FindFirstChild(rn)
end
function castRod()
	local rod=getRod()
	if rod then
		if not rod.values.casted.Value then
			rod.events.cast:FireServer(0)
		end
	end
end
function equipRod()
	equipBP(getRod())
end
function useTotem(name)
	local totem=plr.Backpack:FindFirstChild(name)
	if totem then
		usingTtm=true
		repeat task.wait()until not(plrGui:FindFirstChild"shakeui"or getRod().values.casted.Value)
		equipBP(totem)
		repeat task.wait()until chr:FindFirstChild(name)
		chr:FindFirstChild(name):Activate()
		task.wait(.1)
		equipRod()
		usingTtm=false
	elseif totems[name].buyAmount>0 then
		if not(plr.Backpack:FindFirstChild(name)or chr:FindFirstChild(name))then
			rsEvs.purchase:FireServer(name,"item",nil,totems[name].buyAmount)
		end
		repeat task.wait()until chr:FindFirstChild(name)
		task.wait(.25)
		useTotem(name)
	end
end
binds.main=game:GetService"RunService".Stepped:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr.Humanoid
		hrp=chr.HumanoidRootPart
		plrGui=plr.PlayerGui
		if togs.fb then
			lt.brightness.Enabled=true
			lt.cc.Enabled=false
			lt.location.Enabled=false
			lt.uiblur.Enabled=false
			lt.uicc.Enabled=false
			lt.underwaterbl.Enabled=false
			lt.underwatercc.Enabled=false
			lt.atmos.Density=0
			lt.Brightness=2
			lt.ClockTime=14
			lt.FogEnd=1e5
			lt.GlobalShadows=false
			lt.OutdoorAmbient=Color3.fromRGB(128,128,128)
		end
		local folder=chr.Resources
		folder.temperature.Disabled=togs.temp
		folder["temperature(heat)"].Disabled=togs.temp
		folder.oxygen.Disabled=togs.oxyg
		folder["oxygen(peaks)"].Disabled=togs.oxyg
		UI["Session Stats"].Uptime.setInfo(toHMS(os.time()-sessionStart))
		UI["Session Stats"].Money.setInfo(formatNum(rates.money).."/hr")
		UI["Session Stats"].XP.setInfo(formatNum(rates.xp).."/hr")
		rsEvs.afk:FireServer(false)
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
	if resetCycle and cd.resCyc then
		cd.resCyc=false
		for i=0,2 do
			task.wait(1)
			getRod().Parent=plr.Backpack
			pcall(function()
				chr:FindFirstChildWhichIsA"Tool".Parent=plr.Backpack
			end)
		end
		getRod().Parent=chr
		castRod()
		getRod().Parent=plr.Backpack
		local rod=rs.playerstats[plr.Name].Stats.rod.Value
		rs.packages.Net["RE/Rod/Equip"]:FireServer("Flimsy Rod")
		task.wait()
		rs.packages.Net["RE/Rod/Equip"]:FireServer(rod)
		task.wait(.5)
		getRod().Parent=chr
		resetCycle=false
		firstReel=true
		cd.resCyc=true
	end
	if togs.equiprod and cd.equiprod then
		cd.equiprod=false
		local held=chr:FindFirstChild(pstat.rod.Value)
		if not held and not usingTtm then
			equipRod()
		end
		task.wait(.3)
		cd.equiprod=true
	end
	if not pauseFishing and not usingTtm then
		if not resetCycle then
			if togs.rodspam and cd.test then
				cd.test=false
				for _,v in pairs(hum.Animator:GetPlayingAnimationTracks())do
					if v.Animation.AnimationId=="rbxassetid://113972107465696"then
						getRod().Parent=plr.Backpack
						task.wait(.05)
						getRod().Parent=chr
						break
					end
				end
				cd.test=true
			end
			if togs.cast and togs.rodspam and not firstReel and cd.rodspam then
				cd.rodspam=false
				castRod()
				task.wait(.3)
				rsEvs["reelfinished "]:FireServer(100,true)
				cd.rodspam=true
			end
		end
		if not firstReel and togs.rodspam and RSanchor and togs.cast then
			if os.clock()-lastReel>3.4 and not resetCycle then
				resetCycle=true
			end
			hrp.CFrame=RSanchor
			removeVelocity()
		end
		if togs.cast and cd.cast and not(togs.rodspam and not firstReel)then
			cd.cast=false
			local rod=getRod()
			if rod and rod:FindFirstChild"values"then
				if not rod.values.casted.Value then
					if togs.lcst then
						mouse(0,0,1)
						task.wait(.4)
						mouse(0,0,0)
					else
						rod.events.cast:FireServer(0)
						task.wait(.2)
					end
				end
			end
			cd.cast=true
		end
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
		task.wait(.1)
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
						updAnchor(tpOnPart(fp,v[3]))
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
				updAnchor(vals.anchor)
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
	if togs.rmvfish then
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
	if togs.rmvfish then
		if v:IsA"Model"or(v:IsA"Part"and v.Name=="splash")then
			task.wait()
			v:Destroy()
		end
	end
end)
binds.debrisfx=workspace.active.debrisfx.ChildAdded:Connect(function(v)
	if togs.seralaser then
		if v:IsA"Model"and(v.Name=="SeraphicProp")then
			task.wait()
			v:Destroy()
		end
	end
end)
binds.grandReef=workspace.world.map["Grand Reef"].DescendantAdded:Connect(function(v)
	if togs.rl_parts then
		local p=v.Parent
		if v:IsA"Model"and(v.Name=="Barrel"or v.Name=="Fence"or v.Name=="Curve")or p:IsA"Folder"and(p.Name=="Coral"or p.Name=="Seaweed")or v:IsA"ParticleEmitter"then
			task.wait()
			v:Destroy()
		end
	end
end)
binds.pl=workspace.world.map["Roslit Bay"].Cave.Plants.ChildAdded:Connect(function(v)
	if togs.rl_parts and(v:IsA"MeshPart"or v:IsA"Model")then
		task.wait()
		v:Destroy()
	end
end)
binds.abyss=workspace.world.map["Roslit Bay"].Cave.Abyss.ChildAdded:Connect(function(v)
	if togs.rl_parts and(v:IsA"Folder"or v:IsA"Model"or v.Name=="Meshes/Stalagmites_Cylinder"or v.Name=="RoundRock")then
		task.wait()
		v:Destroy()
	end
end)
binds.anno=rsEvs.anno_top.OnClientEvent:Connect(function(a)
	local l=a:lower()
	if l:find"sunken treasure"and togs.sunkenchest then
		sunkenActive=true
		pauseFishing=true
		task.wait(.5)
		for k,v in pairs(sunkenLocs)do
			if l:find(k)then
				for _,p in pairs(v)do
					hrp.CFrame=CFrame.new(unpack(p))
					task.wait(1.25)
					local pad=workspace.ActiveChestsFolder:FindFirstChild"Pad"
					if pad and pad:FindFirstChild"Spawns"then
						for _,v in pairs(pad:GetDescendants())do
							if v:IsA"ProximityPrompt"then
								v.MaxActivationDistance=1000
								v.RequiresLineOfSight=false
								v.HoldDuration=0
							end
						end
						task.wait(.25)
						for _,c in pairs(pad.Spawns:GetChildren())do
							hrp.CFrame=c.CFrame
							removeVelocity()
							cam.CFrame=hrp.CFrame*CFrame.Angles(-2,0,0)
							for i=0,5 do
								press(101)
								task.wait(.1)
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
	if v.Name=="reel"then
		if not togs.rodspam then
			repeat
				v.bar.playerbar.Size=UDim2.new(1,0,1.3,0)
				task.wait()
				rsEvs["reelfinished "]:FireServer(100,true)
			until not plrGui:FindFirstChild"reel"
		else
			v.bar.playerbar.Size=UDim2.new(1,0,1.3,0)
			if firstReel then
				firstReel=false
				lastReel=os.clock()
				getRod().Parent=plr.Backpack
				getRod().Parent=chr
				task.wait()
				v:Destroy()
				task.wait(.6)
				castRod()
			else
				task.wait()
				local t=os.clock()-lastReel
				lastReel=os.clock()
				v:Destroy()
				for _,r in pairs(hrp:GetChildren())do
					if r.Name=="reeling"then
						r:Destroy()
					end
				end
			end
		end
	end
end)
binds.cfr=hrp:GetPropertyChangedSignal"CFrame":Connect(function()
	if not firstReel and togs.rodspam and RSanchor and togs.cast then
		hrp.CFrame=RSanchor
		removeVelocity()
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
local blacklist={"Trusted","Content Creator","Tester","Contributor","Tester 2","Analytics","Trial Mod","Moderator","Senior Mod","Admin","Developer","Lead","Creator","Holder"}
binds.plrs=game.Players.PlayerAdded:Connect(function(v)
	local role=v:GetRoleInGroup(7381705)
	for i,v in pairs(blacklist)do
		if v==role then
			plr:Kick"Staff detected"
			break
		end
	end
	plrNames={}
	for _,p in pairs(game.Players:GetPlayers())do
		table.insert(plrNames,p.Name)
	end
	plrListDD.setList(plrNames)
end)
binds.plrslv=game.Players.PlayerRemoving:Connect(function(v)
	task.wait(.1)
	plrNames={}
	for _,p in pairs(game.Players:GetPlayers())do
		table.insert(plrNames,p.Name)
	end
	plrListDD.setList(plrNames)
end)
local Main=UI:addPage("Main",1.6,true)
local Waypoints=UI:addPage("Locations",1)
local EvFarm=UI:addPage("Event Farming",2)
local Appraisal=UI:addPage("Appraise",4)
local Enchant=UI:addPage("Enchant",1)
local ATotem=UI:addPage("Totems",2)
local Shop=UI:addPage("Shop",2)
local Stats=UI:addPage("Session Stats",1)
local PlayerInfo=UI:addPage("Player Stats",1)
local Webhook=UI:addPage("Webhook",1)
local Perf=UI:addPage("Performance",1)
local Local=UI:addPage("Local Player",2)
local Debug=UI:addPage("Debug",2)
Main.addToggle("Auto Cast",togs.cast,function(v)
	togs.cast=v
	if v and togs.rodspam then
		firstReel=true
		lastReel=os.clock()
		RSanchor=nil
		resetCycle=false
		updAnchor()
	end
end)
Main.addToggle("Legit Cast",togs.lcst,function(v)
	togs.lcst=v
end)
Main.addToggle("Auto Equip Rod",togs.equiprod,function(v)
	togs.equiprod=v
end)
Main.addToggle("Fast Reel",togs.rodspam,function(v)
	togs.rodspam=v
	if v then
		for _,n in pairs(plrGui:GetChildren())do
			if n.Name=="reel"then
				task.wait()
				n:Destroy()
			end
		end
		if togs.cast then
			updAnchor()
		end
	end
end)
Main.addToggle("Auto Shake",togs.shake,function(v)
	togs.shake=v
end)
Main.addToggle("Auto Catch",togs.autocatch,function(v)
	togs.autocatch=v
end)
Main.addSlider("Catch Delay",{min=0,max=60,default=vals.catch,decimals=2},function(v)
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
Waypoints.addDropdown("Mariana's Veil",wps.veil,nil,function(v)
	tpTo(v)
end)
EvFarm.addToggle("Sunken Treasure",togs.sunkenchest,function(v)
	togs.sunkenchest=v
end)
EvFarm.addLabel("Set the farming priority for each event","Set to -1 to excluded,priority ordered from 0 up to "..(#events-1))
EvFarm.addToggle("Start Farm",togs.evf,function(v)
	togs.evf=v
	hrp.Anchored=false
end)
for _,v in pairs({unpack(events)})do
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
			if not chr:FindFirstChild"Enchant Relic"then
				equipBP(plr.Backpack["Enchant Relic"])
			end
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
Shop.addDropdown("Crates",{"Festive Bait Crate","Bait Crate","Carbon Crate","Quality Bait Crate","Common Crate","Coral Geode","Volcanic Geode"},nil,function(v)
	vals.crateType=v
end)
Shop.addTextBox("Crates amount",vals.crateAmnt,function(v)
	vals.crateAmnt=tonumber(v)
end)
Shop.addButton("Buy crates",function()
	rsEvs.purchase:FireServer(vals.crateType,"fish",nil,vals.crateAmnt)
end)
Shop.addDropdown("Totems",{"Aurora Totem","Eclipse Totem","Meteor Totem","Smokescreen Totem","Sundial Totem","Tempest Totem","Windset Totem","Zeus Storm Totem"},nil,function(v)
	vals.totemType=v
end)
Shop.addTextBox("Totem amount",vals.totemAmnt,function(v)
	vals.totemAmnt=tonumber(v)
end)
Shop.addButton("Buy totems",function()
	rsEvs.purchase:FireServer(vals.totemType,"item",nil,vals.totemAmnt)
end)
Shop.addDropdown("Rods",{"Heaven's Rod","Kraken Rod","Rod Of The Depths","Trident Rod","Zeus Rod"},nil,function(v)
	vals.pRod=v
end)
Shop.addButton("Buy rod",function()
	rsEvs.purchase:FireServer(vals.pRod,"rod",nil,1)
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
local statsToDisplay={
	{"Bestiary Pages Completed","tracker_bestiaryCompletions",1},
	{"Catch Streak","tracker_streak",1},
	{"Treasure Chests opened","tracker_treasurechests",1},
	{"Coins","coins",1},
	{"Angler quests completed","tracker_anglerquests",1},
	{"Quests completed","tracker_quests",1},
	{"Crab Cages opened","tracker_crabcagesopened",1},
	{"Deaths","tracker_deaths",1},
	{"Deaths [via Meteors]","tracker_deathsviameteors",1},
	{"Fish Caught [Exotic]","tracker_exoticcaught",1},
	{"Fish Caught [Mutation]","tracker_mutationcaught",1},
	{"Fish Caught [Mythical]","tracker_mythicalcaught",1},
	{"Fish Caught [Secret]","tracker_secretcaught",1},
	{"Fish Caught [Shiny]","tracker_shinycaught",1},
	{"Fish Caught [Sparkling]","tracker_sparklingcaught",1},
	{"Fish Caught [Total]","tracker_fishcaught",1},
	{"Perfect Catches","tracker_perfectcatches",1},
	{"Reels Snapped","tracker_reelsbroken",1},
	{"Largest fish caught [kg]","tracker_largest",1},
	{"Locations Discovered","tracker_locationsdiscovered",1},
	{"Level","level",1},
	{"Player XP","xp",1},
	{"Rods Enchanted","tracker_enchanted",1},
	{"Set Spawn location","spawnlocation",0},
	{"Playtime","tracker_timeplayed",2},
	{"Times Joined","tracker_timesjoined",1},
	{"Totems used [Aurora]","tracker_auroratotemsused",1},
	{"Totems used [Avalanche]","tracker_avalanchetotemsused",1},
	{"Totems used [Blizzard]","tracker_blizzardtotemsused",1},
	{"Totems used [Eclipse]","tracker_eclipsetotemsused",1},
	{"Totems used [Meteor]","tracker_meteortotemsused",1},
	{"Totems used [Poseidon]","tracker_poseidonwrathtotemsused",1},
	{"Totems used [Smokescreen]","tracker_smokescreentotemsused",1},
	{"Totems used [Sundial]","tracker_sundialtotemsused",1},
	{"Totems used [Tempest]","tracker_tempesttotemsused",1},
	{"Totems used [Windset]","tracker_windsettotemsused",1},
	{"Totems used [Zeus]","tracker_zeusstormtotemsused",1}
}
plrListDD=PlayerInfo.addDropdown("Show Player's Stats/Inventory",plrNames,nil,function(v)
	local p=game.Players:FindFirstChild(v)
	if not p then
		notify("Not found","Player not found.")
		return
	end
	local pD=p.DisplayName
	local tracker={}
	local bds={}
	local GuiActive=true
	local Gui=Instance.new"ScreenGui"
	local Frame=Instance.new"Frame"
	local Close=Instance.new"TextButton"
	local CloseCorner=Instance.new"UICorner"
	local XImg=Instance.new"ImageLabel"
	local Title=Instance.new"TextLabel"
	local ScrollFrame=Instance.new"ScrollingFrame"
	local PageFolder=Instance.new"Folder"
	local ListLayout=Instance.new"UIListLayout"
	Gui.Parent=game.CoreGui
	Frame.Parent=Gui
	Frame.Size=UDim2.new(0,400,0,300)
	Frame.Position=UDim2.new(0.5,-150,0.5,-100)
	Frame.BackgroundColor3=Color3.fromRGB(15,15,15)
	Frame.BorderSizePixel=0
	Frame.Active=true
	Frame.Draggable=true
	Close.Parent=Frame
	Close.Size=UDim2.new(0,15,0,15)
	Close.Position=UDim2.new(1,-20,0,5)
	Close.Text=""
	Close.TextSize=10
	Close.TextColor3=Color3.new(1,1,1)
	Close.BackgroundColor3=Color3.new(1,0,0)
	Close.BorderSizePixel=0
	Close.TextXAlignment=Enum.TextXAlignment.Center
	CloseCorner.Parent=Close
	CloseCorner.CornerRadius=UDim.new(0,4)
	XImg.Parent=Close
	XImg.BackgroundTransparency=1
	XImg.Position=UDim2.new(0,2,0,2)
	XImg.Size=UDim2.new(0,11,0,11)
	XImg.ScaleType=Enum.ScaleType.Fit
	XImg.ImageColor3=Color3.fromRGB(0,0,0)
	XImg.Image="rbxassetid://5054663650"
	Close.MouseButton1Click:Connect(function()
		Gui:Destroy()
		for _,v in pairs(tracker)do v:Disconnect()end
		for _,v in pairs(bds)do v:Disconnect()end
	end)
	Title.Parent=Frame
	Title.Size=UDim2.new(0,15,0,15)
	Title.Position=UDim2.new(0,3,0,4)
	Title.TextXAlignment=Enum.TextXAlignment.Left
	Title.Text=pD.."'s Stats/Inventory:"
	Title.TextSize=10
	Title.TextColor3=Color3.new(1,1,1)
	Title.BackgroundColor3=Color3.fromRGB(15,15,15)
	Title.BorderSizePixel=0
	ScrollFrame.Parent=Frame
	ScrollFrame.Size=UDim2.new(1,-10,1,-40)
	ScrollFrame.Position=UDim2.new(0,5,0,25)
	ScrollFrame.BackgroundColor3 =Color3.fromRGB(15,15,15)
	ScrollFrame.BorderSizePixel=1
	ScrollFrame.CanvasSize=UDim2.new(0,0,#statsToDisplay*.1,0)
	ScrollFrame.ScrollBarThickness=8
	ListLayout.Parent=ScrollFrame
	ListLayout.Padding=UDim.new(0,5)
	table.insert(statGuis,function()
		Gui:Destroy()
		for _,v in pairs(tracker)do v:Disconnect()end
	end)
	local statCount=0
	local function addLabel(txt,val,type)
		if type==1 then
			val=formatNum(math.round(val))
		elseif type==2 then
			val=string.format("%d:%02d:%02d",val//3600,(val%3600)//60,val%60)
		end
		local textColor=statCount%2>0 and Color3.fromRGB(173,173,173)or Color3.fromRGB(220,220,220)
		local holder=Instance.new"Frame"
		local label=Instance.new"TextLabel"
		local dash=Instance.new"TextLabel"
		local value=Instance.new"TextLabel"
		holder.Parent=ScrollFrame
		holder.Size=UDim2.new(1,-15,0,25) 
		holder.BackgroundTransparency=1
		label.Parent=holder
		label.Size=UDim2.new(.7,0,1,0)
		label.Position=UDim2.new(0,0,0,0)
		label.Text=txt
		label.TextSize=14
		label.Font=Enum.Font.SourceSans
		label.TextColor3=textColor
		label.BackgroundTransparency=1
		label.TextXAlignment=Enum.TextXAlignment.Left
		label.TextWrapped=true 
		dash.Parent=holder
		dash.Size=UDim2.new(0,10,1,0)
		dash.Position=UDim2.new(0.7,0,0,0)
		dash.Text="-"
		dash.TextSize=14
		dash.Font=Enum.Font.SourceSans
		dash.TextColor3=textColor
		dash.BackgroundTransparency=1
		value.Parent=holder
		value.Size=UDim2.new(0.3,-15,1,0)
		value.Position=UDim2.new(0.7,15,0,0)
		value.Text=val
		value.TextSize=14
		value.Font=Enum.Font.SourceSans
		value.TextColor3=textColor
		value.BackgroundTransparency=1
		value.TextXAlignment=Enum.TextXAlignment.Right
		value.ClipsDescendants=true
		return function(nv)
			if type==1 then
				nv=formatNum(math.round(nv))
			elseif type==2 then
				nv=string.format("%d:%02d:%02d",nv//3600,(nv%3600)//60,nv%60)
			end
			value.Text=nv
		end
	end
	local sF=rs.playerstats:FindFirstChild(p.Name)
	if sF and sF:FindFirstChild("Stats") then
		local sS=sF.Stats
		for _,sI in pairs(statsToDisplay)do
			local sV=sS:FindFirstChild(sI[2])
			if sV then
				local label=addLabel(sI[1],sV.Value,sI[3])
				statCount=statCount+1
				tracker[sI[2]]=sV:GetPropertyChangedSignal"Value":Connect(function()
					label(sS[sI[2]].Value)
				end)
			else
				addLabel(sI[1],"nil")
			end
		end
	else
		addLabel("Error","Could not find player stats")
	end
	local dragging,dragInput,dragStart,startPos
	local function update(e)
		local delta=e.Position-dragStart
		Frame.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
	end
	bds.ib=Frame.InputBegan:Connect(function(e)
		if e.UserInputType==Enum.UserInputType.MouseButton1 or e.UserInputType==Enum.UserInputType.Touch then
			dragging=true
			dragStart=e.Position
			startPos=Frame.Position
			e.Changed:Connect(function()
				if e.UserInputState==Enum.UserInputState.End then
					dragging=false
				end
			end)
		end
	end)
	bds.ic=Frame.InputChanged:Connect(function(e)
		if e.UserInputType==Enum.UserInputType.MouseMovement or e.UserInputType==Enum.UserInputType.Touch then
			dragInput=e
		end
	end)
	bds.uc=us.InputChanged:Connect(function(e)
		if e==dragInput and dragging then
			update(e)
		end
	end)
	pcall(function()
		while task.wait(1)and GuiActive do
			if not game.Players:FindFirstChild(v)then
				Title.Text=pD.."'s Stats/Inventory: (Player Left)"
				for _,v in pairs(tracker)do v:Disconnect()end
				for _,v in pairs(bds)do v:Disconnect()end
				break
			end
		end
	end)
end)
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
Perf.addToggle("Fullbright/No blur",togs.fb,function(v)
	togs.fb=v
end)
Perf.addToggle("Remove unnecessary parts",togs.rl_parts,function(v)
	togs.rl_parts=v
	if v then
		for _,p in pairs(workspace.world.map["Grand Reef"]:GetDescendants())do
			if v:IsA"Model"and(v.Name=="Barrel"or v.Name=="Fence"or v.Name=="Curve")or v:IsA"Folder"and(v.Name=="Coral"or v.Name=="Seaweed")or v:IsA"ParticleEmitter"then
				task.wait()
				v:Destroy()
			end
		end
		for _,p in pairs(workspace.world.map["Roslit Bay"].Cave.Plants:GetChildren())do
			if v:IsA"MeshPart"or v:IsA"Model"then
				task.wait()
				v:Destroy()
			end
		end
		for _,p in pairs(workspace.world.map["Roslit Bay"].Cave.Abyss:GetChildren())do
			if v:IsA"Folder"or v:IsA"Model"or v.Name=="Meshes/Stalagmites_Cylinder"or v.Name=="RoundRock"then
				task.wait()
				v:Destroy()
			end
		end
	end
end)
Perf.addToggle("Hide Seraphic Laser",togs.seralaser,function(v)
	togs.seralaser=v
end)
Perf.addToggle("Remove Fish Model",togs.rmvfish,function(v)
	togs.rmvfish=v
end)
Perf.addButton("Visual Clear Inventory",function()
	local fishList = game:GetService("ReplicatedStorage").resources.items.fish
	for _,v in pairs(plr.Backpack:GetChildren())do
		if fishList:FindFirstChild(v.Name)and not v.Name:lower():find"crate"then
			v:Destroy()
		end
	end
end)
Perf.addButton("Remove Particle Emitters",function()
	for _,v in pairs(game:GetDescendants())do
		if v:IsA"ParticleEmitter"then
			v.Enabled=false
		end
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
Local.addToggle("Walk on Water",false,function(v)
	for _,c in pairs(fishingZones:GetChildren())do
		if c:IsA"BasePart"then
			c.CanCollide=v
		end
	end
end)
Local.addButton("Rejoin",function()
	plr:Kick"Rejoining..."
	task.wait()
	game:GetService"TeleportService":Teleport(game.PlaceId,plr)
end)
Debug.addButton("Finish Reel",function()
	rsEvs["reelfinished "]:FireServer(100,true)
end)
Debug.addButton("Count Fish",function()
	local fishList=rs.resources.items.fish
	local c=0
	for _,v in pairs(plr.Backpack:GetChildren())do
		if fishList:FindFirstChild(v.Name)then
			c+=1
		end
	end
	notify("Fish Count: "..tostring(c))
end)
Debug.addButton("Unequip Rod",function()
	getRod().Parent=plr.Backpack
end)
Main.destroyGui(function()
	running=false
	for _,v in pairs(binds)do v:Disconnect()end
	for _,v in pairs(statGuis)do pcall(function()v()end)end
	for i,v in pairs(togs)do togs[i]=false end
	for i,v in pairs(cd)do cd[i]=false end
end)
if game.PlaceId~=1537690962 then
	return
end
repeat
	wait(1)
until game:IsLoaded()and game.Players.LocalPlayer
repeat
	wait()
until not game.Players.LocalPlayer.PlayerGui.ScreenGui.LoadingMessage.Visible
function parse(a)
	return game.HttpService:JSONDecode(a)
end
function stringify(a)
	return game.HttpService:JSONEncode(a)
end
--VARIABLES & FUNCTIONS
local ver,branch="2.0.",290

local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
local hrp=chr.HumanoidRootPart
local gui_run,HoneyMaking,safe_delay=false,false,.25
--[[
	1 for honey,
	2 for leaves,
	3 for mobs
]]
local afk_mode=false
game.ReplicatedStorage.Events.ClaimHive:FireServer(6)
game.ReplicatedStorage.Events.ClaimHive:FireServer(5)
game.ReplicatedStorage.Events.ClaimHive:FireServer(4)
game.ReplicatedStorage.Events.ClaimHive:FireServer(3)
game.ReplicatedStorage.Events.ClaimHive:FireServer(2)
game.ReplicatedStorage.Events.ClaimHive:FireServer(1)
if not workspace.Monsters:FindFirstChild"e"then
	local a=Instance.new("Weld",workspace.Monsters)
	a.Name="e"
end
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
	bb1=false,
	bb2=false,
	bb3=false,
	leaves=false,
	ccnc=false,
	ccnl=nil,
	achp=false,
	enemies=false,
	vichop=false
}
if isfile"vic hop.txt"then
	toggles.vichop=parse(readfile"vic hop.txt").v10
end
local selected={
	field=nil,
	jp=hum.JumpPower,
	ws=hum.WalkSpeed,
	tpws=1,
	tokenrange=200
}
local cd,cd2,cd3,cd4,in_prog,finished=true,true,true,true,false,false
local min_y=-1
local goals={"White","Red","Blue","Sunflower Field","Mushroom Field","Dandelion Field","Clover Field","Blue Flower Field","Bamboo Field","Spider Field","Strawberry Field","Pineapple Patch","Stump Field","Rose Field","Cactus Field","Pumpkin Patch","Pine Tree Forest","Mountain Top Field","Coconut Field","Pepper Patch"}
local old_field
local sum=0
local total=0
local PRs
local m1=10000--each 0 represents a decimal place.(ex. 100 = 1.00)
local m2=tonumber(tostring(m1).."00")
local mmm
local binds={}
local crossair=false
local offset,fl,n1,n2,h1=25,false,424,469,71
local token_ids={
	["snowflake"]={
		t=nil,
		id="6087969886"
	},
	["haste"]={
		t=nil,
		id="65867881"
	},
	["honey"]={
		t=nil,
		id="1472135114"
	},
	["treat"]={
		t=nil,
		id="2028574353"
	},
	["babylove"]={
		t=nil,
		id="1472256444"
	},
	["melody"]={
		t=nil,
		id="253828517"
	},
	["bombplus"]={
		t=nil,
		id="1442764904"
	},
	["tokenlink"]={
		t=nil,
		id="1629547638"
	},
	["honeymark"]={
		t=nil,
		id="2499514197"
	},
	["inspire"]={
		t=nil,
		id="2000457501"
	},
	["whiteboost"]={
		t=nil,
		id="3877732821"
	},
	["oil"]={
		t=nil,
		id="2545746569"
	},
	["cloudvial"]={
		t=nil,
		id="3030569073"
	},
	["coconut"]={
		t=nil,
		id="3012679515"
	},
	["magicbean"]={
		t=nil,
		id="2529092020"
	},
	["antpass"]={
		t=nil,
		id="2060626811"
	},
	["blueextract"]={
		t=nil,
		id="2495936060"
	},
	["redextract"]={
		t=nil,
		id="2495935291"
	},
	["microconv"]={
		t=nil,
		id="2863122826"
	},
	["gingerbread"]={
		t=nil,
		id="6077173317"
	},
	["enzyme"]={
		t=nil,
		id="2584584968"
	},
	["mooncharm"]={
		t=nil,
		id="2306224708"
	},
	["glitter"]={
		t=nil,
		id="2542899798"
	},
	["fielddice"]={
		t=nil,
		id="2863468407"
	},
	["ticket"]={
		t=nil,
		id="1674871631"
	},
	["rage"]={
		t=nil,
		id="1442700745"
	},
	["impale"]={
		t=nil,
		id="2319083910"
	},
	["royaljelly"]={
		t=nil,
		id="1471882621"
	},
	["glue"]={
		t=nil,
		id="2504978518"
	},
	["gumdrops"]={
		t=nil,
		id="1838129169"
	},
	["bitterberry"]={
		t=nil,
		id="4483236276"
	},
	["sunflower"]={
		t=nil,
		id="1952682401"
	},
	["pneapple"]={
		t=nil,
		id="1952796032"
	},
	["blueberry"]={
		t=nil,
		id="2028453802"
	},
	["beamstorm"]={
		t=nil,
		id="1671281844"
	},
	["strawberry"]={
		t=nil,
		id="1952740625"
	},
	["bluesync"]={
		t=nil,
		id="1874692303"
	},
	["scratch"]={
		t=nil,
		id="1104415222"
	},
	["pulse"]={
		t=nil,
		id="1874564120"
	},
	["blueboost"]={
		t=nil,
		id="1442863423"
	},
	["redboost"]={
		t=nil,
		id="1442859163"
	},
	["prescision"]={
		t=nil,
		id="8173559749"
	},
	["pollenmark"]={
		t=nil,
		id="2499540966"
	},
	["bomb"]={
		t=nil,
		id="1442725244"
	},
	["focus"]={
		t=nil,
		id="1629649299"
	},
	["stinger"]={
		t=nil,
		id="2314214749"
	},
	["inferno"]={
		t=nil,
		id="4519549299"
	},
	["panda_morph"]={
		t=nil,
		id="1472580249"
	},
	["turpentine"]={
		t=nil,
		id="8310376128"
	},
	["polar_morph"]={
		t=nil,
		id="1472532912"
	},
	["brown_morph"]={
		t=nil,
		id="1472425802"
	},
	["black_morph"]={
		t=nil,
		id="1472491940"
	},
	["fuzzbomb"]={
		t=nil,
		id="4889322534"
	},
	["redsync"]={
		t=nil,
		id="1874704640"
	},
	["festivegift"]={
		t=nil,
		id="2652424740"
	},
	["starjelly"]={
		t=nil,
		id="2319943273"
	},
	["neonberry"]={
		t=nil,
		id="4483267595"
	},
	["basicegg"]={
		t=nil,
		id="1471846464",
	},
	["cog"]={
		t=nil,
		id="11804999942",
	},
	["smoothdice"]={
		t=nil,
		id="8054996680",
	},
	["loadeddice"]={
		t=nil,
		id="8055428094",
	},
	["jellybeans"]={
		t=nil,
		id="3080740120",
	},
	["tropicaldrink"]={
		t=nil,
		id="3835877932",
	},
	["purplepotion"]={
		t=nil,
		id="4935580111",
	},
	["supersmoothie"]={
		t=nil,
		id="5144657109",
	},
	["marhmallowbee"]={
		t=nil,
		id="3027672238",
	},
	["festivebean"]={
		t=nil,
		id="2676715441",
	},
	["nightbell"]={
		t=nil,
		id="2676671613",
	},
	["boxofrogs"]={
		t=nil,
		id="4528640710",
	},
	["robopass"]={
		t=nil,
		id="3036899811",
	},
	["startreat"]={
		t=nil,
		id="2028603146",
	},
	["atomictreat"]={
		t=nil,
		id="4520736128",
	},
	["turpentine"]={
		t=nil,
		id="8310376128",
	},
	["silveregg"]={
		t=nil,
		id="1471848094",
	},
	["goldegg"]={
		t=nil,
		id="1471849394",
	},
	["diamondegg"]={
		t=nil,
		id="1471850677",
	},
	["mythicegg"]={
		t=nil,
		id="4520739302",
	},
	["staregg"]={
		t=nil,
		id="2007771339",
	},
	["giftedsilver"]={
		t=nil,
		id="1987253833",
	},
	["giftedgold"]={
		t=nil,
		id="1987255318",
	},
	["gifteddiamond"]={
		t=nil,
		id="1987257040",
	},
	["giftedmythic"]={
		t=nil,
		id="6134473023",
	}
}
gui_run=true
function vector(x,y,z)
	local x1,y1,z1
	if'number'==type(x)then
		x1=x
	else
		x1=x.Position.x
	end
	if'number'==type(y)then
		y1=y
	else
		y1=y.Position.y
	end
	if'number'==type(z)then
		z1=z
	else
		z1=z.Position.z
	end
	if x1 and y1 and z1 then
		return Vector3.new(x1,y1,z1)
	end
end
if not workspace:FindFirstChild"stump_platform"then
	local p=Instance.new"Part"
	p.Name="stump_platform"
	p.Parent=workspace
	p.Size=vector(150,0,150)
	p.Anchored=true
	p.Transparency=1
	p.CFrame=CFrame.new(workspace.FlowerZones["Stump Field"].Position.x,82,workspace.FlowerZones["Stump Field"].Position.z)
end
if not workspace:FindFirstChild"coconut_platform"then
	local p=Instance.new"Part"
	p.Name="coconut_platform"
	p.Parent=workspace
	p.Transparency=0.9
	p.Size=vector(100,0,40)
	p.Anchored=true
	p.CFrame=CFrame.new(-268,106.75,446)
end
if not workspace:FindFirstChild"vic_platform"then
	local p=Instance.new"Part"
	p.Name="vic_platform"
	p.Parent=workspace
	p.Size=Vector3.new(5,0,5)
	p.Anchored=true
	p.CFrame=CFrame.new(-114,1.9,272)
end
function spl(q,b)
	local splt_ct={}
	for wd in q:gmatch('[^'..b..']+') do
		table.insert(splt_ct,wd)
	end
	return splt_ct
end
function new_field(title,text,line)
	return{["name"]=title,["value"]=text,["inline"]=line or false}
end
function webhook(mainTitle,desc,foot,r,g,b,...)
	req=http_request or request or HttpPost or syn.request
	local webhookFields={...}
	local webhookField={}
	for i,v in ipairs(webhookFields) do
		table.insert(webhookField,v)
	end
	req({
		Url="",
		Body=game.HttpService:JSONEncode({
			["embeds"]={{
				["title"]=mainTitle,
				["description"]=desc,
				["type"]="rich",
				["color"]=tonumber("0x"..string.format("%x",r)..string.format("%x",g)..string.format("%x",b)),
				["fields"]=webhookField,
				["footer"]={
					["text"]=foot
				}
			}}
		}),
		Method="POST",
		Headers={["content-type"]="application/json"}
	})
end
--webhook("dsee","yes","foot",0,0,128,new_field("fe","dsde"))
function get_magnitude(instance1,instance2,axis,abs)
	if axis==nil then
		return(vector(instance1.Position.x,instance2.Position.y,instance1.Position.z)-instance2.Position).magnitude
	elseif axis=="x" then
		if abs then
			return math.abs(instance1.Position.x-instance2.Position.x)
		else
			return instance1.Position.x-instance2.Position.x
		end
	elseif axis=="y" then
		if abs then
			return math.abs(instance1.Position.y-instance2.Position.y)
		else
			return instance1.Position.y-instance2.Position.y
		end
	elseif axis=="z" then
		if abs then
			return math.abs(instance1.Position.z-instance2.Position.z)
		else
			return instance1.Position.z-instance2.Position.z
		end
	end
end
function arrange_guis(path)
	local erss=0
	for _,v in pairs(path:GetChildren())do
		if v:IsA"BillboardGui"then
			erss=1+erss
			v.Name=erss
			v.ExtentsOffset=vector(0,0+(erss*6),0)
		end
	end
	return erss
end
function goto(x,y,z,m)
	if math.abs(y-hrp.Position.y)<=10 then
		while(vector(x,hrp,z)-hrp.Position).Magnitude>=3 and x and y and z and m~=nil and wait()and gui_run and hum and chr and selected.field and finished and not in_prog do
			local bee=nearest(workspace.Bees)
			hrp.CFrame=CFrame.lookAt(hrp.Position,vector(bee.Position.x,hrp.Position.y,bee.Position.z))
			if (vector(x,hrp,z)-hrp.Position).Magnitude<=4 then
				hrp.Velocity=vector(0,0,0)
			end
			if toggles.farming and not HoneyMaking then
				pcall(function()
					if(get_magnitude(workspace.FlowerZones[selected.field],hrp,"x",true)>=workspace.FlowerZones[selected.field].Size.x/2 and get_magnitude(workspace.FlowerZones[selected.field],hrp,"z",true)>=workspace.FlowerZones[selected.field].Size.z/2) or hrp.Position.y-workspace.FlowerZones[selected.field].Position.y<min_y then
						hrp.CFrame=workspace.FlowerZones[selected.field].CFrame*CFrame.new(0,2,0)
					end
				end)
			end
			if m then
				hum.WalkToPoint=vector(x+math.random(),hrp.Position.y,z+math.random())
			else
				chr:TranslateBy((vector(x+math.random(),hrp.Position.y,z+math.random())-hrp.Position))
			end
		end
	end
end
function goto_token(name)
	if token_ids[name].t then
		if fetch_token(token_ids[name].id)and get_magnitude(fetch_token(token_ids[name].id),hrp)<=selected.tokenrange and fetch_token(token_ids[name].id).Orientation.z==0 and fetch_token(token_ids[name].id).Transparency<=1 then
			chr:TranslateBy((vector(fetch_token(token_ids[name].id).Position.x,fetch_token(token_ids[name].id).Position.y,fetch_token(token_ids[name].id).Position.z)-hrp.Position))
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
function _ccnc(a)
	if math.random()<.1 and hum.Health>h1 and not workspace.Particles:FindFirstChild"WarningDisk"and fetch_token(a)and fetch_token(a).Orientation.z==0 and fetch_token(a).Position.z<=n2 and fetch_token(a).Position.z>=n1 then
		hrp.CFrame=fetch_token(a).CFrame+vector(0,.1,0)
		wait()
	end
end
function ccnc_func()
	if toggles.ccnc then
		if workspace.MonsterSpawners.CoconutCrab.TimerAttachment.TimerGui.TimerLabel.Text:find"Crab"then return end
		if not workspace:FindFirstChild"CrabModel"then
			hrp.CFrame=CFrame.new(-268,72,429)
			return
		end
		pcall(function()
			if workspace:FindFirstChild"CrabModel"and workspace:FindFirstChild"CrabModel":FindFirstChild"Whisker".Position.y>65 then
				_ccnc("2319083910")
				_ccnc("1629547638")
				_ccnc("1629649299")
				_ccnc("1442700745")
				if hrp.Position.y<=71 then
					hrp.CFrame=CFrame.new(hrp.Position.x,72,hrp.Position.z)
				end
				if math.random()<.01 and hrp.Position.z>=n1+10 then
					hrp.CFrame=CFrame.new(workspace:FindFirstChild"CrabModel":FindFirstChild"Whisker".Position.x-offset,hrp.Position.y,hrp.Position.z-10)
				end
				if hum.Health>h1 then
					if(workspace:FindFirstChild"CrabModel":FindFirstChild"Whisker".Position.x+255)>=0 and not fl then
						if hrp.Position.z<=n2 and hrp.Position.z>=n1 then
							hrp.CFrame=CFrame.new(workspace:FindFirstChild"CrabModel":FindFirstChild"Whisker".Position.x-offset,hrp.Position.y,hrp.Position.z)
						else
							hrp.CFrame=CFrame.new(workspace:FindFirstChild"CrabModel":FindFirstChild"Whisker".Position.x-offset,hrp.Position.y,446)
						end
					end
					if(workspace:FindFirstChild"CrabModel":FindFirstChild"Whisker".Position.x+255)<=0 and not fl then
						if hrp.Position.z<=n2 and hrp.Position.z>=n1 then
							hrp.CFrame=CFrame.new(workspace:FindFirstChild"CrabModel":FindFirstChild"Whisker".Position.x+offset,hrp.Position.y,hrp.Position.z)
						else
							hrp.CFrame=CFrame.new(workspace:FindFirstChild"CrabModel":FindFirstChild"Whisker".Position.x+offset,hrp.Position.y,446)
						end
					end
				end
				if workspace.Particles:FindFirstChild"WarningDisk"and workspace.Particles:FindFirstChild"WarningDisk".Size.x>35 then
					fl=true
				else
					wait(.1)
					fl=false
				end
				if hum.Health<=h1 and fl then
					hrp.CFrame=CFrame.new(-268,110,429)
				end
				if hum.Health<=50 then
					hrp.CFrame=CFrame.new(-268,110,429)
				end
				for _,v in pairs(workspace.Particles:GetChildren())do
					if v:IsA"BasePart"and v.Size.x>=40 then
						if v.Name=="WarningDisk"then
							if(vector(v.Position.x,hrp.Position.y,v.Position.z)-hrp.Position).magnitude<=23 and hum.Health>75 then
								if(v.Position.x+255)<=0 then
									hrp.CFrame=CFrame.new(v.Position.x+22,hrp.Position.y,hrp.Position.z)
								end
								if(v.Position.x+255)>=0 then
									hrp.CFrame=CFrame.new(v.Position.x-22,hrp.Position.y,hrp.Position.z)
								end
								if v.Position.z<=446.5 and v.Position.z>=469 then
									hrp.CFrame=CFrame.new(v.Position.x,hrp.Position.y,v.Position.z-22)
								end
								if v.Position.z>=446.5 and v.Position.z<=424 then
									hrp.CFrame=CFrame.new(v.Position.x,hrp.Position.y,v.Position.z+22)
								end
							end
						end
					end	
				end
			end
		end)
	end
end
function set_sprinkler(t)
	if in_prog then 
		wait()
	elseif not finished and not HoneyMaking and type(selected.field)=="string"then
		in_prog=true
		hrp.CFrame=workspace.FlowerZones[selected.field].CFrame*CFrame.new(0,2,0)
		hrp.Velocity=vector(0,0,0)
		hum.HipHeight=12
		wait(.2)
		for i=1,t do
			hrp.Velocity=vector(0,0,0)
			game.ReplicatedStorage.Events.PlayerActivesCommand:FireServer({["Name"]="Sprinkler Builder"})
			pcall(function()
				hrp.CFrame=workspace.FlowerZones[selected.field].CFrame*CFrame.new(0,10,0)
			end)
			wait(.9)
		end
		in_prog=false
		hum.HipHeight=2.1
		finished=true
	end
end
function auto_quest()
	if toggles.quest and cd2 then
		cd2=false
		loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/bss%20quest%20v2.lua")()
		wait(1)
		cd2=true
	end	
end
function fetch_token(n)
	if workspace.Collectibles:FindFirstChild(n)then
		return workspace.Collectibles:FindFirstChild(n)
	end
end
function BAV(AngularVelocity,Parent,Name)
	local s=Instance.new"BodyAngularVelocity"
	s.Name=Name or"Spinning"
	s.Parent=Parent or nil
	s.MaxTorque=vector(0,math.huge,0)
	s.AngularVelocity=AngularVelocity or vector(0,10,0)
	return s
end
function getquest(from)
	if gui_run and hum and chr and hrp and hum.Health>0 then
		local res
		local chosen_npc,npc222
		if from:lower():match"brown"then
			chosen_npc="brown bear:"
			npc222="BrownBear"
		end
		if from:lower():match"black"then
			chosen_npc="black bear:"
			npc222="BlackBear"
		end
		if from:lower():match"polar"then
			chosen_npc="polar bear:"
			npc222="PolarBear"
		end
		if plr and plr.PlayerGui and plr.PlayerGui.ScreenGui and plr.PlayerGui.ScreenGui.Menus and plr.PlayerGui.ScreenGui.Menus.Children and plr.PlayerGui.ScreenGui.Menus.Children.Quests.Content:FindFirstChild"Frame"then
			for _,quests in pairs(plr.PlayerGui.ScreenGui.Menus.Children.Quests.Content.Frame:GetChildren())do
				if quests:IsA"Frame"then
					if (quests:FindFirstChild"_1" or quests.TitleBar).Text:lower():find(chosen_npc)then
						quests.Name=npc222
					end
				end
			end
			local bbq=plr.PlayerGui.ScreenGui.Menus.Children.Quests.Content.Frame:FindFirstChild(npc222)
			local tsks=bbq and bbq:GetChildren()
			if bbq:FindFirstChild"PRs"then
				bbq:FindFirstChild"PRs":Destroy()
			end
			PRs=(bbq:FindFirstChild"_1" or bbq.TitleBar):Clone()
			PRs.Parent=bbq
			PRs.Name="PRs"
			PRs.Transparency=0
			for i=1,#tsks do
				pcall(function()
					if bbq[tostring(tsks[i])].Name~="PRs"then
						bbq[tostring(tsks[i])].Name="_"..i
					end
					if bbq[tostring(tsks[i])]:IsA"Frame"then
						total=total+tonumber(loadstring("return("..spl(tsks[i].Description.Text,[["%s"]])[2]:gsub(",","")..")")())
						if bbq[tostring(tsks[i])].FillBar.AbsoluteSize.x<288 then
							sum=sum+tonumber(loadstring("return("..spl(tsks[i].Description.Text,[["."]])[2]:gsub(",","").."*"..spl(tsks[i].Description.Text,[["%s"]])[2]:gsub(",","")..")")())
						else
							sum=sum+tonumber(loadstring("return("..spl(tsks[i].Description.Text,[["%s"]])[2]:gsub(",","")..")")())
						end
					end
				end)
			end
			bbq.PRs.Text="Progress: "..tostring(math.round((sum/total)*m2)/m1).."%"
			wait()
			sum=0
			total=0
			for _,tasks in pairs(bbq:GetChildren())do
				if tasks:IsA"Frame"and tasks.FillBar.AbsoluteSize.x<=287.9985 then
					for n=1,#goals do
						if tasks and tasks:FindFirstChild"Description"then
							if tasks.Description.Text:find(goals[n])then
								if(tasks.Description.Text:find"Forest"or tasks.Description.Text:find"Field"or tasks.Description.Text:find"Patch")and(goals[n]:find"Forest"or goals[n]:find"Field"or goals[n]:find"Patch")then
									res=goals[n]
								elseif goals[n]=="White"and not(tasks.Description.Text:find"Forest"or tasks.Description.Text:find"Field"or tasks.Description.Text:find"Patch")then
									if workspace.MonsterSpawners.CoconutCrab.TimerAttachment.TimerGui.TimerLabel.Text:find"Crab"then
										res="Coconut Field"
									else
										res="Spider Field"
									end
								elseif goals[n]=="Red"and not(tasks.Description.Text:find"Forest"or tasks.Description.Text:find"Field"or tasks.Description.Text:find"Patch")then
									res="Pepper Patch"
								elseif goals[n]=="Blue"and not(tasks.Description.Text:find"Forest"or tasks.Description.Text:find"Field"or tasks.Description.Text:find"Patch")then
									res="Pine Tree Forest"
								else
									res="Mountain Top Field"
								end
								if old_field~=nil and old_field~=false and res~=nil and old_field~=res then
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
			end
		else
			mmm=game.UserInputService:GetMouseLocation()
			mousemoveabs(90,110)
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
	return r
end
function acthehp()
	for _,v in pairs(workspace.Monsters:GetChildren())do
		if v and v:FindFirstChild"Head"and v:FindFirstChild"Head":FindFirstChild"GuiAttachment":FindFirstChild"MonsterGui"and workspace[plr.Name]then
			v:FindFirstChild"Head":FindFirstChild"GuiAttachment":FindFirstChild"MonsterGui".Parent=workspace[plr.Name]:FindFirstChild"Head"
		end
	end
end
function jump(n)
	for i=1,n or 1 do
		hum:ChangeState"Jumping"
		wait(.1)
	end
end
function farm_mobs()
	if cd3 then
		cd3=false
		for _,e in pairs(workspace.MonsterSpawners:GetChildren())do
			if toggles.enemies then
				if not e.Name:lower():find"monster"and not e.Name:lower():find"tunnel"and not e.Name:lower():find"snail"and not e.Name:lower():find"commando"and not e.Name:lower():find"crab"and not e.Name:lower():find"king"then
					words={}
					for word in(e:FindFirstChild"Attachment"or e:FindFirstChild"TimerAttachment").TimerGui.TimerLabel.Text:gmatch"%S+"do table.insert(words,word)end
					current_time=words[#words]:len()
					if e:FindFirstChild"Attachment"or e:FindFirstChild"TimerAttachment"then
						if not(e:FindFirstChild"Attachment"or e:FindFirstChild"TimerAttachment").TimerGui.TimerLabel.Text:match"%a+"or(current_time<=3 and tonumber(string.match((e:FindFirstChild"Attachment"or e:FindFirstChild"TimerAttachment").TimerGui.TimerLabel.Text,"%d+"))<=2)then
							hrp.CFrame=e.CFrame
							wait(.1)
							hrp.CFrame=nearest(workspace.FlowerZones).CFrame*CFrame.new(0,2,0)
							wait(1)
							game.ReplicatedStorage.Events.PlayerActivesCommand:FireServer({["Name"]="Sprinkler Builder"})
							repeat
								wait()
								hum.HipHeight=12
							until get_magnitude(nearest(workspace.Bees),hrp)<=10
							hum.HipHeight=2.1
							wait(3)
							repeat
								wait()
							until fetch_token"1629547638"and get_magnitude(fetch_token("1629547638"),hrp)<=40 or hum.Health<1
							wait(.1)
							hrp.CFrame=fetch_token"1629547638".CFrame+vector(0,2,0)
							wait(.5)
							cd3=true
						end
					end
				end
			end
		end
		cd3=true
	end
end
function killvicious()
	if toggles.vicious then
		repeat
			wait()
		until not HoneyMaking
		if workspace.Particles:FindFirstChild"Vicious"then
			workspace:FindFirstChild"vic_platform".Position=workspace.Particles:FindFirstChild"Vicious".Position
			hrp.CFrame=workspace:FindFirstChild"vic_platform".CFrame+vector(0,3.1,0)
		end
		for _,v in pairs(game.workspace.Monsters:GetChildren()) do
			if v.Name:find"Vici" or v.Name:find"Gifted"then
				toggles.farming=false
				workspace:FindFirstChild"vic_platform".Position=v.Head.Position+vector(0,10,0)
				hrp.CFrame=workspace:FindFirstChild"vic_platform".CFrame+vector(0,3.1,0)
				pcall(function()
					if hum.Health>40 then
						if fetch_token"2319083910"and fetch_token"2319083910".Orientation.z==0 then
							hrp.CFrame=fetch_token"2319083910".CFrame+vector(0,.1,0)
							wait(.5)
							hrp.CFrame=workspace:FindFirstChild"vic_platform".CFrame+vector(0,3.1,0)
						else
							hrp.CFrame=workspace:FindFirstChild"vic_platform".CFrame+vector(0,3.1,0)
						end
						if fetch_token"1442700745"and fetch_token"1442700745".Orientation.z==0 then
							hrp.CFrame=fetch_token"1442700745".CFrame+vector(0,.1,0)
							wait(.5)
							hrp.CFrame=workspace:FindFirstChild"vic_platform".CFrame+vector(0,3.1,0)
						else
							hrp.CFrame=workspace:FindFirstChild"vic_platform".CFrame+vector(0,3.1,0)
						end
						if fetch_token"1629649299"and fetch_token"1629649299".Orientation.z==0 then
							hrp.CFrame=fetch_token"1629649299".CFrame+vector(0,.1,0)
							wait(.5)
							hrp.CFrame=workspace:FindFirstChild"vic_platform".CFrame+vector(0,3.1,0)
						else
							hrp.CFrame=workspace:FindFirstChild"vic_platform".CFrame+vector(0,3.1,0)
						end
					end
				end)
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
			starting_time=tick()
			repeat
				hum.WalkSpeed=0
				hrp.Anchored=false
				chr:MoveTo(plr.SpawnPos.Value.p+vector(0,0,10))
				hum.WalkToPoint=vector(plr.SpawnPos.Value.x,hrp.Position.y,plr.SpawnPos.Value.z)+vector(0,0,10)
				wait()
				hrp.CFrame=CFrame.new(hrp.CFrame.p,hrp.CFrame.p+vector(0,0,.001))
				hrp.Anchored=true
				if workspace.Particles:FindFirstChild"MyBeam"then
					wait(.75)
				else
					wait(3.5)
				end
				pcall(function()
					if not workspace.Particles:FindFirstChild"MyBeam"then
						game.ReplicatedStorage.Events.PlayerHiveCommand:FireServer"ToggleHoneyMaking"
					end
				end)
			until plr.CoreStats.Pollen.Value<=1 and not workspace.Particles:FindFirstChild"MyBeam"
			ending_time=tick()
			wait(.1)
			if game.Players.LocalPlayer.UserId==1399908199 then
				webhook("__**Honey Log**__",plr.PlayerGui.ScreenGui.MeterHUD.HoneyMeter.Bar.TextLabel.Text.."\nDuration: "..math.round(ending_time-starting_time).."s",os.date("%b %d %y - %I:%M %p"),_G.rgbresult.result.ac.nested.actualresult.r,_G.rgbresult.result.ac.nested.actualresult.g,_G.rgbresult.result.ac.nested.actualresult.b)
			end
			hrp.Anchored=false
			if toggles.farming then
				hrp.CFrame=workspace.FlowerZones[selected.field].CFrame*CFrame.new(0,2,0)
			end
			wait(.1)
			repeat
				hum.HipHeight=15
				wait()
			until get_magnitude(nearest(workspace.Bees),hrp)<=30
			hum.HipHeight=2.1
			HoneyMaking=false
		end
	end
	for _,v in pairs(workspace.Collectibles:GetChildren())do
		if toggles.farming and not finished and not in_prog and selected.field and not HoneyMaking then
			set_sprinkler(2)
		end
		if toggles.farming and cd and finished and not HoneyMaking and selected.field and not toggles.ccnc then
			if selected.field=="Stump Field"and hum.Health<60 then
				cd4=false
				hrp.Velocity=vector(0,0,0)
				wait()
				hrp.CFrame=workspace.FlowerZones[selected.field].CFrame*CFrame.new(0,2,0)
			else
				cd4=true
			end
			cd=false
			if cd4 and(get_magnitude(workspace.FlowerZones[selected.field],v,"x",true)<=workspace.FlowerZones[selected.field].Size.x/2 and get_magnitude(workspace.FlowerZones[selected.field],v,"z",true)<=workspace.FlowerZones[selected.field].Size.z/2)and fetch_token"1629547638"and fetch_token"1629547638".Orientation.z==0 and not crossair then
				pcall(function()
					goto(fetch_token"1629547638".Position.x,hrp.Position.y,fetch_token"1629547638".Position.z,toggles.walk)
				end)
				wait(safe_delay)
				cd=true
			elseif cd4 and(get_magnitude(workspace.FlowerZones[selected.field],v,"x",true)<=workspace.FlowerZones[selected.field].Size.x/2 and get_magnitude(workspace.FlowerZones[selected.field],v,"z",true)<=workspace.FlowerZones[selected.field].Size.z/2)and not toggles.only_token and v.Orientation.z==0 then
				pcall(function()
					goto(v.Position.x,hrp.Position.y,v.Position.z,toggles.walk)
				end)
				wait(safe_delay)
				cd=true
			else
				if(get_magnitude(workspace.FlowerZones[selected.field],hrp,"x",true)>=workspace.FlowerZones[selected.field].Size.x/2 and get_magnitude(workspace.FlowerZones[selected.field],hrp,"z",true)>=workspace.FlowerZones[selected.field].Size.z/2) or hrp.Position.y-workspace.FlowerZones[selected.field].Position.y<min_y then
					hrp.CFrame=workspace.FlowerZones[selected.field].CFrame*CFrame.new(0,2,0)
					hum.WalkToPoint=workspace.FlowerZones[selected.field].CFrame.p
					hum.WalkToPoint=hrp.Position
				end
				wait()
				cd=true
			end
		end
	end
	if toggles.dig then
		pcall(function()
			for _,v in pairs(chr:GetChildren()) do
				if v:IsA"Tool"then
					v.ClickEvent:FireServer()
				end
			end
		end)
	end
end
function esp(part)
	if part:IsA"BasePart"and not part:FindFirstChild"content.com/Lopen"then
		local a=Instance.new"BoxHandleAdornment"
		a.Name="content.com/Lopen"
		a.Parent=part
		a.Adornee=part
		a.AlwaysOnTop=true
		a.ZIndex=0
		a.Size=vector(.57,3.95,4.09)
		a.Transparency=.4
		a.Color=part.BrickColor
	end
end
if afk_mode==1 then
	toggles.farming=true
	toggles.dig=true
	toggles.quest=true
	toggles.noclip=game.RunService.Stepped:Connect(NoclipLoop)
	toggles.walk=true
	selected.field="Cactus Field"
	selected.ws=90
end
if afk_mode==2 then
	toggles.leaves=true
	toggles.dig=true
	toggles.quest=true
end
if afk_mode==3 then
	toggles.enemies=true
	toggles.dig=true
	toggles.quest=true
	toggles.noclip=game.RunService.Stepped:Connect(NoclipLoop)
end
if isfile"vic hop.txt"then
	if type(afk_mode)~="number" then
		if parse(readfile"vic hop.txt").v10==true then
			local vic_name=""
			if workspace.Particles:FindFirstChild"Vicious"then
				workspace:FindFirstChild"vic_platform".Position=workspace.Particles:FindFirstChild"Vicious".Position
				hrp.CFrame=workspace:FindFirstChild"vic_platform".CFrame+vector(0,3.1,0)
			end
			wait(2)
			for _,v in pairs(workspace.Monsters:GetChildren())do
				if v.Name:find"Vicious"or v.Name:find"Gifted"then
					vic_name=v.Name
					repeat
						wait()
						pcall(function()
							workspace:FindFirstChild"vic_platform".Position=v.Head.Position+vector(0,10,0)
							hrp.CFrame=workspace:FindFirstChild"vic_platform".CFrame+vector(0,3.1,0)
						end)
						pcall(function()
							if hum.Health>40 then
								if fetch_token"2319083910"and fetch_token"2319083910".Orientation.z==0 then
									hrp.CFrame=fetch_token"2319083910".CFrame+vector(0,.1,0)
									wait(.5)
									hrp.CFrame=workspace:FindFirstChild"vic_platform".CFrame+vector(0,3.1,0)
								else
									hrp.CFrame=workspace:FindFirstChild"vic_platform".CFrame+vector(0,3.1,0)
								end
								if fetch_token"1442700745"and fetch_token"1442700745".Orientation.z==0 then
									hrp.CFrame=fetch_token"1442700745".CFrame+vector(0,.1,0)
									wait(.5)
									hrp.CFrame=workspace:FindFirstChild"vic_platform".CFrame+vector(0,3.1,0)
								else
									hrp.CFrame=workspace:FindFirstChild"vic_platform".CFrame+vector(0,3.1,0)
								end
								if fetch_token"1629649299"and fetch_token"1629649299".Orientation.z==0 then
									hrp.CFrame=fetch_token"1629649299".CFrame+vector(0,.1,0)
									wait(.5)
									hrp.CFrame=workspace:FindFirstChild"vic_platform".CFrame+vector(0,3.1,0)
								else
									hrp.CFrame=workspace:FindFirstChild"vic_platform".CFrame+vector(0,3.1,0)
								end
							end
						end)
					until not workspace.Monsters:FindFirstChild(vic_name)
					if http_request or request or HttpPost or syn.request then
						local req=http_request or request or HttpPost or syn.request
						local servers={}
						local body=parse(req({Url=string.format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100",game.PlaceId)}).Body)
						if body and body.data then
							for i,v in next, body.data do
								if type(v)=="table"and tonumber(v.playing)and tonumber(v.maxPlayers)and v.playing<v.maxPlayers and v.id~=game.JobId then
									table.insert(servers,1,v.id)
								end 
							end
						end
						if #servers>0 then
							game:GetService"TeleportService":TeleportToPlaceInstance(game.PlaceId,servers[math.random(1,#servers)],game.Players.LocalPlayer)
						end
					end
				end
				if vic_name==""then
					if http_request or request or HttpPost or syn.request then
						local req=http_request or request or HttpPost or syn.request
						local servers={}
						local body=parse(req({Url=string.format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100",game.PlaceId)}).Body)
						if body and body.data then
							for i,v in next, body.data do
								if type(v)=="table"and tonumber(v.playing)and tonumber(v.maxPlayers)and v.playing<v.maxPlayers and v.id~=game.JobId then
									table.insert(servers,1,v.id)
								end 
							end
						end
						if #servers>0 then
							game:GetService"TeleportService":TeleportToPlaceInstance(game.PlaceId,servers[math.random(1,#servers)],game.Players.LocalPlayer)
						end
					end
				end
			end
		end
	end
else
	writefile("vic hop.txt",'{"v10":false}')
end
for _,v in pairs(workspace[plr.Name]:GetDescendants())do
	if v.Name=="BodyBackAttachment"then
		v.Name=plr.DisplayName
	end
end
binds.died=hum.Died:Connect(function()
	if gui_run then
		toggles.ccnc=false
		if toggles.ccnl then
			toggles.ccnl:Disconnect()
		end
		toggles.commando=false
		if toggles.commando_loop then
			toggles.commando_loop:Disconnect()
		end
	end
end)
binds.wksp=workspace.DescendantAdded:Connect(function(v)
	if gui_run then
		wait(.1)
		if v:IsA"Model"and v.Name==plr.Name and workspace[plr.Name].UpperTorso:FindFirstChild"BodyBackAttachment"then
			finished=false
			cd3=true
			for _,v in pairs(workspace[plr.Name]:GetDescendants())do
				if v.Name=="BodyBackAttachment"then
					v.Name=plr.DisplayName
				end
			end
		end
		if v:IsA"BasePart"then
			v.CastShadow=false
		end
	end
end)
binds.mnst=workspace.Monsters.ChildAdded:Connect(function(v)
	if gui_run then
		wait(.5)
		if toggles.achp then
			acthehp()
		end
	end
end)
binds.flwr=workspace.Flowers.DescendantAdded:Connect(function(v)
	if gui_run then
		if v.Name:find"LeafBurst"and toggles.leaves then
			hrp.CFrame=v.Parent.CFrame*CFrame.new(0,0,0)
		end
	end
end)
binds.ctbl=workspace.Collectibles.ChildAdded:Connect(function(v)
	if gui_run then
		pcall(function()
			if tostring(v)==tostring(plr.Name) or tostring(v)=="C"then
				v.Name=string.match(v:FindFirstChild"FrontDecal".Texture,"%d+")
				v.Name=string.match(v:FindFirstChild"BackDecal".Texture,"%d+")
			end
			plr.DevCameraOcclusionMode=Enum.DevCameraOcclusionMode.Invisicam
		end)
		if toggles.token_esp and v:IsA"BasePart"then
			esp(v)
		end
		for _,v in pairs(workspace.Amulets:GetDescendants())do
			if v.Name=="ColorTimeOffset"then
				pcall(function()v:Destroy()end)
			end
			pcall(function()v.Color=Color3.fromRGB(_G.rgbresult.result.ac.nested.actualresult.r,_G.rgbresult.result.ac.nested.actualresult.g,_G.rgbresult.result.ac.nested.actualresult.b)end)
			pcall(function()v.BrickColor=Color3.fromRGB(_G.rgbresult.result.ac.nested.actualresult.r,_G.rgbresult.result.ac.nested.actualresult.g,_G.rgbresult.result.ac.nested.actualresult.b)end)
			pcall(function()v.Color=ColorSequence.new(Color3.fromRGB(_G.rgbresult.result.ac.nested.actualresult.r,_G.rgbresult.result.ac.nested.actualresult.g,_G.rgbresult.result.ac.nested.actualresult.b),Color3.fromRGB(_G.rgbresult.result.ac.nested.actualresult.r,_G.rgbresult.result.ac.nested.actualresult.g,_G.rgbresult.result.ac.nested.actualresult.b))end)
		end
	end
end)
binds.ptcl=workspace.Particles.ChildAdded:Connect(function(v)
	if gui_run then
		for _,v2 in pairs(workspace.Particles:GetChildren())do
			if v2.Name=="DustBunnyInstance"and toggles.farming and not HoneyMaking then
				pcall(function()
					if(get_magnitude(workspace.FlowerZones[selected.field],v2:FindFirstChild"Root","x",true)<=workspace.FlowerZones[selected.field].Size.x/2 and get_magnitude(workspace.FlowerZones[selected.field],v2:FindFirstChild"Root","z",true)<=workspace.FlowerZones[selected.field].Size.z/2)then
						hrp.CFrame=v2:FindFirstChild"Root".CFrame+vector(0,2,0)
					end
				end)
			end
		end
		if v.Name=="Crosshair"and toggles.farming and not HoneyMaking then
			crossair=true
			repeat
				hrp.Velocity=vector(0,0,0)
				wait()
				goto(v.Position.x,hrp.Position.y,v.Position.z,false)
			until tostring(v.BrickColor)~="Red flip/flop"or not v or not toggles.farming or HoneyMaking
			crossair=false
		end
		if v:IsA"Beam"and tostring(v.Attachment1)==tostring(game.Players.LocalPlayer.DisplayName)then
			v.Name="MyBeam"
		else
			if v:IsA"Beam"then
				wait(.1)
				v:Destroy()
			end
		end
		for i,v in pairs(game.Lighting:GetDescendants()) do
			if v:IsA"Atmosphere"then
				v:Destroy()
			end
		end
		if hum and chr and hrp and hum.Health>0 and toggles.achp then
			arrange_guis(workspace[plr.Name]:FindFirstChild"Head")
		end
	end
end)
local looping=game.RunService.Heartbeat:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=game.Players.LocalPlayer.Character
		hum=game.Players.LocalPlayer.Character.Humanoid
		hrp=game.Players.LocalPlayer.Character.HumanoidRootPart
		hum.JumpPower=selected.jp
		hum.WalkSpeed=selected.ws
		plr.CameraMaxZoomDistance=math.huge
		plr.CameraMinZoomDistance=0
		workspace:FindFirstChildOfClass'Terrain'.WaterWaveSize=0
		workspace:FindFirstChildOfClass'Terrain'.WaterWaveSpeed=0
		workspace:FindFirstChildOfClass'Terrain'.WaterReflectance=0
		workspace:FindFirstChildOfClass'Terrain'.WaterTransparency=0
		settings().Rendering.QualityLevel=1
		game.Lighting.FogEnd=9e9
		game.Lighting.Brightness=2
		game.Lighting.ClockTime=14
		game.Lighting.GlobalShadows=false
		game.Lighting.OutdoorAmbient=Color3.fromRGB(128,128,128)
		for i,v in pairs(game.Lighting:GetDescendants()) do
			if v:IsA"BlurEffect"or v:IsA"SunRaysEffect"or v:IsA"ColorCorrectionEffect"or v:IsA"BloomEffect"or v:IsA"DepthOfFieldEffect"then
				v.Enabled=false
			end
		end
		plr.PlayerGui.ScreenGui.MouseoverBox.BackgroundColor3=Color3.fromRGB(_G.rgbresult.result.ac.nested.actualresult.r,_G.rgbresult.result.ac.nested.actualresult.g,_G.rgbresult.result.ac.nested.actualresult.b)
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
		if toggles.bb1 then
			selected.field=getquest"brown"
			toggles.farming=true
			toggles.dig=true
			toggles.inf_jump=true
			toggles.quest=true
			toggles.token_esp=true
			if toggles.noclip==nil then
				toggles.noclip=game.RunService.Stepped:Connect(NoclipLoop)
			end
		end
		if toggles.bb2 then
			selected.field=getquest"black"
			toggles.farming=true
			toggles.dig=true
			toggles.inf_jump=true
			toggles.quest=true
			toggles.token_esp=true
			if toggles.noclip==nil then
				toggles.noclip=game.RunService.Stepped:Connect(NoclipLoop)
			end
		end
		if toggles.bb3 then
			selected.field=getquest"polar"
			toggles.farming=true
			toggles.dig=true
			toggles.inf_jump=true
			toggles.quest=true
			toggles.token_esp=true
			if toggles.noclip==nil then
				toggles.noclip=game.RunService.Stepped:Connect(NoclipLoop)
			end
		end
		if toggles.enemies then
			farm_mobs()
		end
	end
end)
game.UserInputService.JumpRequest:connect(function()
	if toggles.inf_jump and hum and chr and hrp then
		jump()
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
local UI=GUI:CreateWindow("BSS","version "..ver..string.format("%x",branch))
local Main=UI:addPage("Main",3,true,1)
local Waypoint=UI:addPage("Waypoints",2,false,1)
local AutoTokens=UI:addPage("Tokens",3,false,1)
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
	min_y=-1
end)
Main:addToggle("Start Farm",function(v)
	toggles.farming=v
	cd=true
end)
Main:addToggle("Walk (semi-patched)",function(v)
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
	looping:Disconnect()
	gui_run=false
	toggles.farming=false
	toggles.tpw=false
	toggles.dig=false
	toggles.inf_jump=false
	toggles.only_token=false
	toggles.quest=false
	toggles.vicious=false
	toggles.token_esp=false
	selected.field=nil
	selected.jp=hum.JumpPower
	selected.ws=hum.WalkSpeed
	selected.tpws=0
	toggles.walk=false
	HoneyMaking=false
	toggles.commando=false
	toggles.leaves=false
	toggles.bb1=false
	toggles.bb2=false
	toggles.bb3=false
	toggles.ccnc=false
	toggles.achp=false
	cd=true
	cd2=true
	cd3=true
	in_prog=false
	finished=false
	min_y=-1
	old_field=nil
	sum=0
	total=0
	PRs=nil
	mmm=nil
	apnt=nil
	fl=false
	toggles.enemies=false
	toggles.vichop=false
	for i=1,#token_ids do
		token_ids[i].t=false
	end
	if toggles.noclip then
		toggles.noclip:Disconnect()
	end
	if toggles.ccnl then
		toggles.ccnl:Disconnect()
	end
	if toggles.commando_loop then
		toggles.commando_loop:Disconnect()
	end
	looping:Disconnect()
	binds.wksp:Disconnect()
	binds.mnst:Disconnect()
	binds.flwr:Disconnect()
	binds.ctbl:Disconnect()
	binds.ptcl:Disconnect()
	binds.died:Disconnect()
	wait(.1)
	for _,v in pairs(workspace:GetDescendants())do
		if v.Name=="content.com/Lopen"then
			v:Destroy()
		end
	end
	wait(.1)
	hum.WalkSpeed=16
	for x=1,100 do
		if game.CoreGui:FindFirstChild"fu8rj82n"then
			game.CoreGui:FindFirstChild"fu8rj82n":Destroy()
		end
	end 
end)
Waypoint:addButton("Hive",function()
	hrp.Anchored=false
	chr:MoveTo(plr.SpawnPos.Value.p+vector(0,0,10))
	hum.WalkToPoint=vector(plr.SpawnPos.Value.x,hrp.Position.y,plr.SpawnPos.Value.z)+vector(0,0,10)
	hrp.CFrame=CFrame.new(hrp.CFrame.p,hrp.CFrame.p+vector(0,0,.001))
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
AutoTokens:addSlider("Range",5,2500,function(val)
	selected.tokenrange=tonumber(val)
end)
AutoTokens:addToggle("Ticket",function(v)
	token_ids["ticket"].t=v
	if v then
		repeat
			wait(.3)
			goto_token("ticket")
		until not token_ids["ticket"].t
	end
end)
AutoTokens:addToggle("Snowflake",function(v)
	token_ids["snowflake"].t=v
	if v then
		repeat
			wait(2)
			hrp.CFrame=workspace.Particles.Snowflakes:FindFirstChild"SnowflakePart".CFrame
		until not token_ids["snowflake"].t
	end
end)
Enemy:addToggle("Coconut Crab",function(v)
	toggles.ccnc=v
	if toggles.ccnc then
		if type(toggles.ccnl)=="function"then
			toggles.ccnl:Disconnect()
		else
			toggles.ccnl=game.RunService.Stepped:Connect(ccnc_func)
		end
	else
		toggles.ccnl:Disconnect()
	end
end)
Enemy:addToggle("Vicious Bee",function(v)
	toggles.vicious=v
end)
Enemy:addButton("Toggle Vicious Hop",function()
	toggles.vichop=not toggles.vichop
	if toggles.vichop then
		writefile("vic hop.txt",'{"v10":true}')
	else
		writefile("vic hop.txt",'{"v10":false}')
	end
	if type(afk_mode)~="number" then
		if parse(readfile"vic hop.txt").v10==true then
			local vic_name=""
			if workspace.Particles:FindFirstChild"Vicious"then
				workspace:FindFirstChild"vic_platform".Position=workspace.Particles:FindFirstChild"Vicious".Position
				hrp.CFrame=workspace:FindFirstChild"vic_platform".CFrame+vector(0,3.1,0)
			end
			wait(2)
			for _,v in pairs(workspace.Monsters:GetChildren())do
				if v.Name:find"Vicious"or v.Name:find"Gifted"then
					vic_name=v.Name
					repeat
						wait()
						pcall(function()
							workspace:FindFirstChild"vic_platform".Position=v.Head.Position+vector(0,10,0)
							hrp.CFrame=workspace:FindFirstChild"vic_platform".CFrame+vector(0,3.1,0)
						end)
					until not workspace.Monsters:FindFirstChild(vic_name)
					if http_request or request or HttpPost or syn.request then
						local req=http_request or request or HttpPost or syn.request
						local servers={}
						local body=parse(req({Url=string.format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100",game.PlaceId)}).Body)
						if body and body.data then
							for i,v in next, body.data do
								if type(v)=="table"and tonumber(v.playing)and tonumber(v.maxPlayers)and v.playing<v.maxPlayers and v.id~=game.JobId then
									table.insert(servers,1,v.id)
								end 
							end
						end
						if #servers>0 then
							game:GetService"TeleportService":TeleportToPlaceInstance(game.PlaceId,servers[math.random(1,#servers)],game.Players.LocalPlayer)
						end
					end
				end
				if vic_name==""then
					if http_request or request or HttpPost or syn.request then
						local req=http_request or request or HttpPost or syn.request
						local servers={}
						local body=parse(req({Url=string.format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100",game.PlaceId)}).Body)
						if body and body.data then
							for i,v in next, body.data do
								if type(v)=="table"and tonumber(v.playing)and tonumber(v.maxPlayers)and v.playing<v.maxPlayers and v.id~=game.JobId then
									table.insert(servers,1,v.id)
								end 
							end
						end
						if #servers>0 then
							game:GetService"TeleportService":TeleportToPlaceInstance(game.PlaceId,servers[math.random(1,#servers)],game.Players.LocalPlayer)
						end
					end
				end
			end
		end
	end
end)
Enemy:addToggle("Commando (bug w/o noclip)",function(v)
	toggles.commando=v
	if v and hrp then
		local adhd=vector(0,3.1,0)
		if not workspace:FindFirstChild"commando_platform"then
			local p=Instance.new"Part"
			p.Name="commando_platform"
			p.Parent=workspace
			p.Size=vector(5,0,5)
			p.Anchored=true
			p.CFrame=CFrame.new(513,47,163)
		end
		hrp.CFrame=workspace:FindFirstChild"commando_platform".CFrame+adhd
		while toggles.commando and wait()and hum and chr and hrp and hum.Health>0 do
			if hum.Health>40 then
				if fetch_token"2319083910"and fetch_token"2319083910".Orientation.z==0 then
					hrp.CFrame=fetch_token"2319083910".CFrame+vector(0,.1,0)
					wait(.5)
					hrp.CFrame=workspace:FindFirstChild"commando_platform".CFrame+adhd
				else
					hrp.CFrame=workspace:FindFirstChild"commando_platform".CFrame+vector(0,3.1,0)
				end
				if fetch_token"1442700745"and fetch_token"1442700745".Orientation.z==0 then
					hrp.CFrame=fetch_token"1442700745".CFrame+vector(0,.1,0)
					wait(.5)
					hrp.CFrame=workspace:FindFirstChild"commando_platform".CFrame+adhd
				else
					hrp.CFrame=workspace:FindFirstChild"commando_platform".CFrame+adhd
				end
				if fetch_token"1629649299"and fetch_token"1629649299".Orientation.z==0 then
					hrp.CFrame=fetch_token"1629649299".CFrame+vector(0,.1,0)
					wait(.5)
					hrp.CFrame=workspace:FindFirstChild"commando_platform".CFrame+adhd
				else
					hrp.CFrame=workspace:FindFirstChild"commando_platform".CFrame+adhd
				end
			end
		end
	end
end)
toggles.commando_loop=game.RunService.Stepped:Connect(function()
	if toggles.commando and workspace:FindFirstChild"commando_platform"then
		for _,v in pairs(game.workspace.Monsters:GetChildren())do
			if v.Name:lower():find"commando"then
				workspace:FindFirstChild"commando_platform".CFrame=CFrame.new(v.Torso.CFrame.x,52,v.Torso.CFrame.z)
			end
		end
	end
end)
Enemy:addToggle("Auto Farm enemies",function(v)
	toggles.enemies=v
end)
Enemy:addToggle("Anchor HP bars",function(v)
	toggles.achp=v
end)
NPC:addLabel("Open Quest Tab","Script can't read unloaded Instances")
NPC:addToggle("Brown Bear",function(v)
	toggles.bb1=v
	if v==false then
		toggles.farming=false
	end
end)
NPC:addToggle("Black Bear",function(v)
	toggles.bb2=v
	if v==false then
		toggles.farming=false
	end
end)
NPC:addToggle("Polar Bear",function(v)
	toggles.bb3=v
	if v==false then
		toggles.farming=false
	end
end)
Sp:addSlider("Walk Speed",0,300,function(val)
	selected.ws=val
	hum.WalkSpeed=val
end)
Sp:addSlider("Jump Height",75,300,function(val)
	selected.jp=val
	hum.JumpPower=val
end)
Sp:addToggle("Infinite Jump",function(v)
	toggles.inf_jump=v
end)
Sp:addToggle("Noclip",function(v)
	if type(toggles.noclip)=="function"and not v then
		toggles.noclip:Disconnect()
	elseif v then
		toggles.noclip=game.RunService.Stepped:Connect(NoclipLoop)
	end
end)
Sp:addTextBox("TP walk speed",selected.tpws,function(val)
	if val>=0.01 then
		selected.tpws=val
	end	
end)
Sp:addToggle("TP walk",function(v)
	toggles.tpw=v
end)
for _,v in pairs(workspace.Collectibles:GetChildren())do
	v:Destroy()
end
print("loaded")
loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/rgb.lua")()

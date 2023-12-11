if game.PlaceId~=1417427737 then return else repeat wait(1)until game:IsLoaded()and game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild"leaderstats"and pcall(function() game.Players.LocalPlayer.leaderstats:WaitForChild"Blocks Mined"end)and pcall(function()game.Players.LocalPlayer.PlayerGui.ScreenGui.StatsFrame.Coins:FindFirstChild"Amount"end)and game.Players.LocalPlayer.PlayerGui.ScreenGui.StatsFrame.Tokens.Amount.Text~="Loading..."end
local ver=133
local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr.Humanoid
local hrp=chr.HumanoidRootPart
local oldgrav=workspace.Gravity
local mp,holder,anchorpos,pform,testing
local MAX=7.5e4
local tog={
	mine=true,
	sell=true,
	anchor=true,
	rebirth=true,
	opcrt=false,
	buycrt=false,
	vel=false,
	infj=false,
	tpw=true,
	egg=false,
	float=false,
	ignore=true,
	esp=false,
	clrbls=true
}
local cd={
	mine=true,
	crate1=true,
	crate2=true,
	crwt=1,
	vel=true,
	misc=true,
	collapse=true,
	rb=true,
	ore=true
}
local depth=200
local mineArea="LavaSpawn"
local gotoArea=""
local mineRange={x=5,y=5}
local lowestSavedY=15
local lowestY=15
local collapsed=false
local crateType="Common"
local crateAmount=1
local sellArea=CFrame.new(-38,14,22558)
local ignore={
	["Dirt"]="ye",
	["Stone"]="ye",
	["Space Stone"]="ye",
	["Sugar Stone"]="ye",
	["Sand"]="ye",
	["Flour"]="ye",
	["Prehistoric Stone"]="ye",
	["Grass"]="ye",
	["Sandstone"]="ye",
	["Cave Stone"]="ye",
	["Mystic Stone"]="ye",
	["Lava Block"]="ye",
	["RootModel"]="ye",
	["Rock Bottom"]="ye"
}
local oreMining={
	tog=false,
	status=0,
	selling=false
}
local locs={"Surface","Space","Candy","Toy","Food","Dino","Sea","Beach","Forest","Cavern","Lava"}
local oreIdList={"Airplane Ore","Amber","Amertrine","Amethyst","Anchors","Ancient Artifact","Ancient Gem","Ancient Stone","Aquamarine","Asteroid Rock","Bacon","Bananas","Bedrock","Black Diamond","Black Onyx","Block Ore","Blood Stone","Blue Beryl","Bonzanite","Breadstone","Candy Fish Ore","Candy Floss Ore","Cannibar","Car Ore","Cherry Ruby","Chest Ore","Chicken Nugget","Chlorite","Chromium","Citrine","Coal","Coconuts","Cookies","Copper","Coral","Craxium","Crystal Stone","Crystalite","Diamond","Dinosaur Bones","Dinosaur Eggs","Dravite","Egg Candy","Emerald","Fish Bones","Fluorite","Fossils","French Fries","Garnet","Gem Block","Glowstone","Godly Gem","Gold","Gold Ring Ore","Golden Coins","Grass Ore","Gummy Bear Ore","Gummy Ore","Gun Ore","Halite","Heart Candy","Hematite","Hotdogs","Ice","Ice Cream","Ice Pop","Icing","Illuminite","Iron","Jade","Jellybean Stone","Kelp","Krixanium","Lapis","Lavastone","Legendary Stone","Lily Pad","Log Ore","Lollipop Ore","Macaroni","Magic Wand","Meat Bones","Mithril","Mushroom Ore","Mythic Stone","Nachos","Obsidian","Opals","Oraxanium","Orb Ore","Orcalium","Orpiment","Pearls","Peppermint","Pezzottaite","Pizza","Plastic","Platinum","Praxium","Puzzle Ore","Pyrite","Quartz","Rainbowite","Red Beryl","Red Rock","Royal Ore","Ruby","Sapphire","Seaweed","Shadow Stone","Shells","Shovel Ore","Silver","Skeleton","Skeleton Stone","Skittles Ore","Slate","Spaceship Ore","Starfish","Sunglasses","Sunscreen Ore","Surfboard Ore","Talc","Tank Ore","Tanzanite","Teddybear Ore","Thermium","Titanium","Twig Ore","Twilight Gem","Unicorn Horn Ore","Unobtainium","Uranium","Watermelon","Yellow Beryl","Zircon"}
local binds={}
local oreEsp={}
local saved={}
local screengui=plr.PlayerGui.ScreenGui
local inventory=screengui.StatsFrame2.Inventory.Amount
local Remote=game.ReplicatedStorage.Network:InvokeServer()
local Remote=game.ReplicatedStorage.Network:InvokeServer()
local rs=game:GetService"RunService".Stepped
if not workspace:FindFirstChild"platform"then
	local p=Instance.new"Part"
	p.Name="platform"
	p.Parent=workspace
	p.Size=Vector3.new(2,0,2)
	p.Anchored=true
	p.CFrame=CFrame.new(-114,1.9,272)
end
if not workspace:FindFirstChild"sll"then
	local p=Instance.new"Part"
	p.Name="sll"
	p.Parent=workspace
	p.Size=Vector3.new(2,0,2)
	p.Anchored=true
	p.CFrame=CFrame.new(-38,10.9525,22558)
end
function highlightedOres()
	local n,blocks=0,{}
	for _,m in pairs(workspace.Blocks:GetChildren())do
		local v=m:FindFirstChild"Part"or m:FindFirstChild"ColorPart"or m:FindFirstChild"Root"
		if v and v:FindFirstChild"highlight"then
			n=n+1
			table.insert(blocks,v)
		end
	end
	return n,blocks
end
function notif(ti,tx,d)
	game.StarterGui:SetCore("SendNotification",{
		Title=ti or"";
		Text=tx or"";
		Duration=d or 1;
	})
end
function spl(s,d)
    local r={}
    for v in(s..d):gmatch("(.-)"..d)do
        table.insert(r,v)
    end
    return r
end
function getnum(str,i)
	str=(str:gsub("%s+","")):gsub(",","")
	return tonumber(str:split"/"[i])
end
function gC()
	return tonumber(plr.leaderstats.Coins.value:gsub(",",""):split" "[1])
end
function gI()
	local Amount=(inventory.Text:gsub("%s+","")):gsub(",","")
	local stringTable=Amount:split"/"
	local mx=tonumber(stringTable[2])
	if MAX~=nil then mx=MAX end
	return tonumber(stringTable[1]),mx
end
function recordDepth(pos,f)
	if collapsed then return end
	if pos.y<lowestSavedY or f then
		lowestY=pos.y
		lowestSavedY=pos.y
	end
end
function noVelocity()
	pcall(function()
		hrp.AssemblyAngularVelocity=Vector3.new(0,0,0)
		hrp.AssemblyLinearVelocity=Vector3.new(0,0,0)
		hrp.Velocity=Vector3.new(0,0,0)
	end)
end
function tweenTo(t,d,c)
	game.TweenService:Create(t,TweenInfo.new(d,Enum.EasingStyle.Linear),{CFrame=c}):Play()
end
function esp(v)
	if not v:FindFirstChild"highlight"then
		local a=Instance.new("BoxHandleAdornment",v)
		a.Name="highlight"
		a.Adornee=v
		a.AlwaysOnTop=true
		a.ZIndex=0
		a.Size=v.Size/Vector3.new(2,2,2)
		a.Transparency=.25
		a.Color=BrickColor.new"White"
	end
end
function sellFunction()
	if tog.sell then
		local am,mx=gI()
		if am>=mx then
			if chr and hrp then
				local sL=hrp.Position
				if anchorpos then
					sL=Vector3.new(anchorpos.x,hrp.Position.y,anchorpos.z)
				end
				local sA=getnum(inventory.Text,1)
				recordDepth(sL)
				tog.vel=true
				oreMining.selling=true
				while getnum(inventory.Text,1)>=sA do
					hrp.CFrame=sellArea
					Remote:FireServer("SellItems",{{}})
					rs:Wait()
				end
				hrp.Anchored=true
				local st=os.time()
				while(hrp.Position-sL).magnitude>1 do
					hrp.CFrame=CFrame.new(sL.x,sL.y,sL.z)
					rs:Wait()
					if os.time()-st>3 then break end
				end
				hrp.Anchored=false
				tog.vel=false
				oreMining.selling=false
			end
		end
	end
end
function mineFunction()
	if not anchorpos then
		for _,v in pairs(workspace:FindPartsInRegion3WithWhiteList(Region3.new((hrp.CFrame-Vector3.new(0,3.2,0)).Position,hrp.Position),{workspace.Blocks},1))do
			if v:IsA"BasePart"and v.Parent then
				anchorpos={x=v.Position.x,z=v.Position.z}
			end
		end
	end
	local cdepth=tonumber(spl(screengui.TopInfoFrame.Depth.Text," ")[1])
	if cdepth<depth and not(cdepth==0 and hrp.CFrame.y<7) then
		for _,v in pairs(workspace:FindPartsInRegion3WithWhiteList(Region3.new((hrp.CFrame-Vector3.new(0,20,0)).Position,(hrp.CFrame+Vector3.new(0,2,0)).Position),{workspace.Blocks},1))do
			if v:IsA"BasePart"and v.Parent then
				Remote:FireServer("MineBlock",{{v.Parent}})
				rs:Wait()
				recordDepth(hrp.Position,true)
				workspace.Gravity=500
			end
		end
		workspace.Gravity=oldgrav
	else
		local r=25
		local l1=workspace:FindPartsInRegion3WithWhiteList(Region3.new((hrp.CFrame-Vector3.new(mineRange.x,mineRange.y,mineRange.x)).Position,(hrp.CFrame+Vector3.new(mineRange.x,mineRange.y,mineRange.x)).Position),{workspace.Blocks},100)
		local l2={}
		for _,v in pairs(workspace:FindPartsInRegion3WithWhiteList(Region3.new((hrp.CFrame-Vector3.new(r,1,r)).Position,(hrp.CFrame+Vector3.new(r,r,r)).Position),{workspace.Blocks},150))do
			if v:IsA"BasePart"and v.Parent and(v.Position-hrp.Position).magnitude<=20 then
				if ignore[v.Parent.Name]~="ye"or not tog.ignore then
					table.insert(l2,v)
				end
			end
		end
		local parts=l1
		if tog.clrbls then
			if #l2>0 then
				parts=l2
			else
				for _,v in pairs(workspace:FindPartsInRegion3WithWhiteList(Region3.new((hrp.CFrame-Vector3.new(0,5,0)).Position,hrp.Position),{workspace.Blocks},1))do
					if v:IsA"BasePart"and v.Parent then
						parts={v}
					end
				end
			end
		end
		for _,v in pairs(parts)do
			if v:IsA"BasePart"and v.Parent and not oreMining.selling then
				Remote:FireServer("MineBlock",{{v.Parent}})
				rs:Wait()
			end
			sellFunction()
		end
	end
end
function nearest(list,type)
	if not type then type=1 end
	local r
	for _,v in pairs(list)do
		if r==nil then
			r=v
		else
			if type==1 then
				if(hrp.Position-v.Position).magnitude<(r.Position-hrp.Position).magnitude then
					r=v
				end
			elseif type==2 then
				if(Vector2.new(hrp.Position.x,hrp.Position.z)-Vector2.new(v.Position.x,v.Position.z)).magnitude<(Vector2.new(r.Position.x,r.Position.z)-Vector2.new(hrp.Position.x,hrp.Position.z)).magnitude then
					r=v
				end
			end
		end
	end
	return r
end
function moveTo(n)
	hrp.CFrame=workspace.TeleportPoints[n].CFrame
end
local rubberbands=0
binds.main=game:GetService"RunService".Heartbeat:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr.Humanoid
		hrp=chr.HumanoidRootPart
		screengui=plr.PlayerGui.ScreenGui
		inventory=screengui.StatsFrame2.Inventory.Amount
		mp=screengui.Collapse
		mp.Visible=true
		mp.Amount.Text=tostring(math.round(mp.Progress.AbsoluteSize.x/mp.Decore.AbsoluteSize.x*1e5)/1e3)
		hum.HipHeight=2.2
		pform=workspace:FindFirstChild"platform"
		if not holder or not holder:FindFirstChild"HumanoidRootPart"then
			for _,v in pairs(workspace:FindPartsInRegion3WithWhiteList(Region3.new((hrp.CFrame-Vector3.new(2,2,2)).Position,(hrp.CFrame+Vector3.new(2,2,2)).Position),{workspace.MiningAreas},15))do
				if v.Name=="HumanoidRootPart"then
					if v.Parent.Name==plr.Name then
						holder=v.Parent
					end
				end
			end
		end
		local near
		for _,v in pairs(workspace.TeleportPoints:GetChildren())do
			if v:IsA"Model"then
				if near then
					if(near.Position-hrp.Position).magnitude>(v.SurfaceSpawn.Position-hrp.Position).magnitude then
						near=v.SurfaceSpawn
					end
				else
					near=v.SurfaceSpawn
				end
			end
		end
		local pn=near.Parent.Name:gsub("SurfaceSpawns","")
		if pn~=""then
			gotoArea=pn.."Sell"
			mineArea=pn.."Spawn"
		else
			gotoArea="SellSpawn"
			mineArea="SurfaceSpawn"
		end
		screengui.MainButtons.Surface.Visible=false
	end)
	if tog.anchor and cd.misc and anchorpos then
		cd.misc=false
		tmp=hrp.Position
		if hrp.CFrame.y<lowestY-1000 then
			if not collapsed and cd.rb and not oreMining.tog then
				rubberbands=rubberbands+5
			end
			noVelocity()
			tweenTo(hrp,.45,CFrame.new(hrp.Position.x,lowestY+2.5,hrp.Position.z))
		end
		if not collapsed and not tog.vel and(hrp.Position-Vector3.new(anchorpos.x,hrp.Position.y,anchorpos.z)).magnitude>1 then--prevent wandering off
			tweenTo(hrp,.45,CFrame.new(anchorpos.x,lowestY+2.5,anchorpos.z))
			if cd.rb and not oreMining.tog then
				rubberbands=rubberbands+1
			end
		end
		if rubberbands>10 then
			rubberbands=0
			cd.rb=false
			wait(5)
			moveTo(gotoArea)
			wait(1)
			tweenTo(hrp,5,CFrame.new(anchorpos.x,12,anchorpos.z))
			wait(5)
			tweenTo(hrp,.1,CFrame.new(anchorpos.x,lowestY,anchorpos.z))
			task.spawn(function()
				wait(1)
				cd.rb=true
			end)
		end
		hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
		wait(.05)
		cd.misc=true
	end
	if tog.vel and cd.vel then
		cd.vel=false
		noVelocity()
		rs:Wait()
		cd.vel=true
	end
	if tog.mine and cd.mine then
		cd.mine=false
		if hrp then
			mineFunction()
		end
		rs:Wait()
		cd.mine=true
	end
	if tog.rebirth and gC()-1e6*(plr.leaderstats.Rebirths.value+1)>0 then
		Remote:FireServer("Rebirth",{{}})
		Remote:FireServer("GroupBenefit",{{}})
	end
	if tog.opcrt and cd.crate1 then
		cd.crate1=false
		Remote:FireServer("SpinCrate",{{crateType}})
		wait(cd.crwt)
		cd.crate1=true
	end
	if tog.buycrt and cd.crate2 then
		cd.crate2=false
		Remote:FireServer("OpenCrate",{{crateType,crateAmount}})
		wait(cd.crwt)
		cd.crate2=true
	end
	if tog.tpw and chr and hum then
		if hum.MoveDirection.Magnitude>0 then
			chr:TranslateBy(hum.MoveDirection*1.1)
		else
			chr:TranslateBy(hum.MoveDirection)
		end
	end
	if collapsed and cd.collapse then
		cd.collapse=false
		notif("collapse alert",tostring(mp.Progress.AbsoluteSize.x/mp.Decore.AbsoluteSize.x),15)
		repeat
			noVelocity()
			wait(.01)
		until math.round(mp.Progress.AbsoluteSize.x/mp.Decore.AbsoluteSize.x*1e5)/1e3<90
		moveTo(gotoArea)
		lowestY=17
		lowestSavedY=10
		wait(.3)
		tweenTo(hrp,10,CFrame.new(anchorpos.x,12,anchorpos.z))
		wait(10)
		collapsed=false
		cd.collapse=true
	end
	if tog.float then
		pform.CanCollide=true
		pform.CFrame=hrp.CFrame-Vector3.new(0,3.12451,0)
	else
		if pform.CanCollide then
			pform.CanCollide=false
		end
	end
	if oreMining.tog and tog.esp and oreMining.status and cd.ore and not oreMining.selling then
		cd.ore=false
		local mining=tog.mine
		local anc=tog.anchor
		local flt=tog.float
		local f=false
		local c,bls=highlightedOres()
		while c>0 and oreMining.tog do
			f=true
			if tog.mine and saved["mine"]then
				tog.mine=false
				saved["mine"]:setStatus(false)
			end
			if tog.anchor and saved["anchor"]then
				tog.anchor=false
				saved["anchor"]:setStatus(false)
			end
			wait(.2)
			oreMining.status=false
			local block=nearest(bls,2)
			block.CanCollide=false
			if(hrp.Position-Vector3.new(block.Position.x,hrp.CFrame.y,block.Position.z)).magnitude<2 then
				tweenTo(hrp,.5,CFrame.new(block.CFrame.x,hrp.CFrame.y,block.CFrame.z))
				wait(.5)
			end
			repeat
				Remote:FireServer("MineBlock",{{block.Parent}})
				rs:Wait()
				tweenTo(hrp,.01,block.CFrame)
				tog.float=true
				saved["float"]:setStatus(true)
			until#workspace:FindPartsInRegion3WithWhiteList(Region3.new(hrp.Position,hrp.Position),{workspace.Blocks},5)<1 or not oreMining.tog
			for _,v in pairs(bls)do
				if(v.Position-hrp.Position).magnitude<20 then
					Remote:FireServer("MineBlock",{{v.Parent}})
					wait()
				end
			end
			c,bls=highlightedOres()
		end
		oreMining.status=true
		if anc and f and anchorpos then
			tweenTo(hrp,.45,CFrame.new(anchorpos.x,lowestY,anchorpos.z))
			wait(.45)
		end
		tog.float=flt
		tog.anchor=anc
		tog.mine=mining
		saved["float"]:setStatus(flt)
		saved["anchor"]:setStatus(anc)
		saved["mine"]:setStatus(mining)
		wait(.1)
		cd.ore=true
	end
end)
binds.gui=screengui.ChildAdded:Connect(function(v)
	if v.Name=="HatchedInfo"or v.Name=="BenefitNotif"or v.Name=="CrateSystem"or v.Name=="CollapsedCave"then
		v.Visible=false
		wait()
		v:Destroy()
	end
	if v.Name=="HatchedInfo"and tog.egg then
		wait(.4)
		local did=false
		while not did do
			if holder and holder:FindFirstChild"Pet"and holder.Pet:FindFirstChild"Root"then
				if not holder.Pet.Root:FindFirstChild"ProgressBar"then
					Remote:FireServer("equipPet",{{{"Omega Egg","Omega Egg",0}}})
					wait(.1)
				else
					did=true
				end
			end
		end
	end
	if v.Name=="CollapsedCave"then
		collapsed=true
	end
end)
binds.bls=workspace.Blocks.ChildAdded:Connect(function(m)
	if tog.esp and m:IsA"Model"then
		wait(.05)
		local v=m:FindFirstChild"Part"or m:FindFirstChild"ColorPart"or m:FindFirstChild"Root"
		if v and oreEsp[m.Name]then
			esp(v)
		end
	end
end)
binds.jump=game.UserInputService.JumpRequest:Connect(function()
	if tog.infj and hum then
		hum:ChangeState"Jumping"
	end
end)
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/gui%20lib.lua")()
local UI=GUI:CreateWindow("Miners",ver)
local Main=UI:addPage("Main",3,true,1)
local Anchor=UI:addPage("Anchor",3,false,1)
local Pets=UI:addPage("Pet Farm",3,false,1)
local Ores=UI:addPage("Ore ESP",18.6,false,1)
local Settings=UI:addPage("Settings",3,false,1)
local Local=UI:addPage("Local Player",3,false,1)
local Test=UI:addPage("Testing",2,false,1)
Main:addDropdown("Farm Area",locs,#locs*.25,function(v)
	Remote:FireServer("MoveTo",{{v.."Spawn"}})
	wait(.2)
	Remote:FireServer("MoveTo",{{v.."Spawn"}})
	tweenTo(hrp,.25,hrp.CFrame)
end)
saved["mine"]=Main:addToggle("Auto Mine",tog.mine,function(v)
	tog.mine=v
end)
Main:addToggle("Clear Nearby Blocks",tog.clrbls,function(v)
	tog.clrbls=v
end)
Main:addTextBox("Depth",depth,function(v)
	if type(tonumber(v))=="number"and tonumber(v)>=1 and tonumber(v)<=5e3 then
		depth=tonumber(v)
	else
		notif"invalid"
	end
end)
Main:addToggle("Ignore Common Blocks",tog.ignore,function(v)
	tog.ignore=v
end)
Main:addToggle("Auto Sell",tog.sell,function(v)
	tog.sell=v
end)
Main:addToggle("Auto Rebirth",tog.rebirth,function(v)
	tog.rebirth=v
end)
Main:addToggle("Auto Open Crate",tog.opcrt,function(v)
	tog.opcrt=v
end)
Main:addToggle("Auto Buy Crate",tog.buycrt,function(v)
	tog.buycrt=v
end)
Main:addTextBox("Crate Name(case-sensitive)","Common",function(v)
	crateType=v
end)
saved["anchor"]=Anchor:addToggle("Enable",tog.anchor,function(v)
	tog.anchor=v
end)
Anchor:addButton("Set Anchor",function()
	local f=true
	for _,v in pairs(workspace:FindPartsInRegion3WithWhiteList(Region3.new((hrp.CFrame-Vector3.new(0,5,0)).Position,hrp.Position),{workspace.Blocks},15))do
		if v:IsA"BasePart"and v.Parent then
			anchorpos={x=v.Position.x,z=v.Position.z}
			f=false
		end
	end
	if f then
		notif"no anchor point found"
	end
	lowestY=hrp.CFrame.y
end)
saved["float"]=Anchor:addToggle("Float",tog.float,function(v)
	tog.float=v
end)
Pets:addToggle("Farm Omega Egg",tog.egg,function(v)
	tog.egg=v
end)
Ores:addLabel("Type IDs of the ore","ex: 4,8,5")
Ores:addTextBox("IDs","",function(v)
	oreEsp={}
	for _,v in pairs(workspace.Blocks:GetDescendants())do
		if v:IsA"BoxHandleAdornment"then
			v:Destroy()
		end
	end
	for _,v in pairs(spl(v,","))do
		oreEsp[oreIdList[tonumber(v)]]=true
	end
	for _,m in pairs(workspace.Blocks:GetChildren())do
		local v=m:FindFirstChild"Part"or m:FindFirstChild"ColorPart"or m:FindFirstChild"Root"
		if tog.esp and oreEsp[m.Name]then
			esp(v)
		end
	end
end)
saved["oreEsp"]=Ores:addToggle("Enable",tog.esp,function(v)
	tog.esp=v
	if v then
		for _,m in pairs(workspace.Blocks:GetChildren())do
			local v=m:FindFirstChild"Part"or m:FindFirstChild"ColorPart"or m:FindFirstChild"Root"
			if oreEsp[m.Name]then
				esp(v)
			end
		end
	end
end)
Ores:addToggle("Mine Ore",oreMining.tog,function(v)
	if v and not tog.esp then
		notif("required","turning on esp")
		tog.esp=true
		saved["oreEsp"]:setStatus(tog.esp)
	end
	oreMining.tog=v
end)
Ores:addLabel("~ ~ ~ IDs ~ ~ ~")
for i,v in pairs(oreIdList)do
	Ores:addLabel(v,i)
end
saved["mRadX"]=Settings:addSlider("Mine Radius X",2,10,function(v)
	mineRange.x=tonumber(v)
end)
saved["mRadX"]:setValue(mineRange.x)
saved["mRadY"]=Settings:addSlider("Mine Radius Y",2,10,function(v)
	mineRange.y=tonumber(v)
end)
saved["mRadY"]:setValue(mineRange.y)
Settings:addTextBox("Selling Threshold",math.min(getnum(inventory.Text,2),MAX),function(v)
	if type(tonumber(v))=="number"and tonumber(v)>0 and tonumber(v)<=getnum(inventory.Text,2)then
		MAX=tonumber(v)
	else
		MAX=nil
		notif("using default",getnum(inventory.Text,2))
	end
end)
Settings:addTextBox("Crate(Buy/Open) Cooldown",cd.crwt,function(v)
	if tonumber(v)>=0 and tonumber(v)<=5 then
		cd.crwt=tonumber(v)
	else
		notif"invalid"
	end
end)
Settings:addTextBox("Crate Count",1,function(v)
	if tonumber(v)>0 and tonumber(v)<=1e3 then
		crateAmount=tonumber(v)
	else
		notif"invalid"
	end
end)
Local:addButton("Rejoin",function()
	plr:Kick"\nRejoining..."
	wait()
	game:GetService"TeleportService":Teleport(game.PlaceId,plr)
end)
Local:addToggle("Inf Jump",tog.infj,function(v)
	tog.infj=v
end)
Local:addToggle("TP Walk",tog.tpw,function(v)
	tog.tpw=v
end)
Local:destroyGui(function()
	for _,v in pairs(binds)do
		v:Disconnect()
	end
	for i,v in pairs(tog)do
		tog[i]=false
	end
	for i,v in pairs(cd)do
		cd[i]=false
	end
	for _,v in pairs(workspace.Blocks:GetDescendants())do
		if v:IsA"BoxHandleAdornment"then
			v:Destroy()
		end
	end
	pform:Destroy()
	screengui.MainButtons.Surface.Visible=true
end)
notif("Mining Simulator","By 0x3b5",5)
plr.DevCameraOcclusionMode=Enum.DevCameraOcclusionMode.Invisicam
repeat wait()until pform
local cd=Instance.new("ClickDetector",pform)
cd.MouseClick:Connect(function()
	hrp.CFrame=hrp.CFrame-Vector3.new(0,10,0)
end)
--[[
50,14,9,125,30,92
improve mining radius
]]
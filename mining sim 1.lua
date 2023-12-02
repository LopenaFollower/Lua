if game.PlaceId~=1417427737 then return else repeat wait(1)until game:IsLoaded()and game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild"leaderstats"end
local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr.Humanoid
local hrp=chr.HumanoidRootPart
while true do
    if pcall(function()plr.PlayerGui.ScreenGui.StatsFrame.Coins:FindFirstChild("Amount")end)then
        if plr.PlayerGui.ScreenGui.StatsFrame.Tokens.Amount.Text~="Loading..."then
            break
        end
    end
    wait(1)
end
local mp,holder,anchorpos
local MAX=7.5e4
local tog={
	mine=true,
	sell=true,
	anchor=true,
	rebirth=true,
	crate=false,
	vel=false,
	infj=false,
	tpw=true,
	egg=true,
	ignore=true
}
local cd={
	mine=true,
	crate1=true,
	crate2=true,
	crwt=1,
	vel=true,
	misc=true,
	collapse=true,
	rb=true
}
local depth=200
local mineArea="LavaSpawn"
local mineRange={x=5,y=5}
local lowestSavedY=15
local lowestY=15
local crateType="Common"
local crateAmount=1
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
local screengui=plr.PlayerGui.ScreenGui
local items={"Common","Rare","Epic","Omega","Mythical","Common Hat Crate","Rare Hat Crate","Epic Hat Crate","Omega Hat Crate","Mythical Hat Crate","Spooky Hat Crate","Haunted Hat Crate","Christmas Hat Crate","Common Accessory Crate","Rare Accessory Crate","Epic Accessory Crate","Omega Accessory Crate","Mythical Accessory Crate","Common Trail Crate","Rare Trail Crate","Epic Trail Crate","Omega Trail Crate","Mythical Trail Crate","Spooky Trail Crate"}
local locs={"Surface","Space","Candy","Toy","Food","Dino","Sea","Beach","Forest","Cavern","Lava"}
local oreIdList={"Airplane Ore","Amber","Amertrine","Amethyst","Anchors","Ancient Artifact","Ancient Gem","Ancient Stone","Aquamarine","Asteroid Rock","Bacon","Bananas","Bedrock","Black Diamond","Black Onyx","Block Ore","Blood Stone","Blue Beryl","Bonzanite","Breadstone","Candy Fish Ore","Candy Floss Ore","Cannibar","Car Ore","Cherry Ruby","Chest Ore","Chicken Nugget","Chlorite","Chromium","Citrine","Coal","Coconuts","Cookies","Copper","Coral","Craxium","Crystal Stone","Crystalite","Diamond","Dinosaur Bones","Dinosaur Eggs","Dravite","Egg Candy","Emerald","Fish Bones","Fluorite","Fossils","French Fries","Garnet","Glowstone","Godly Gem","Gold","Gold Ring Ore","Golden Coins","Grass Ore","Gummy Bear Ore","Gummy Ore","Gun Ore","Halite","Heart Candy","Hematite","Hotdogs","Ice","Ice Cream","Ice Pop","Icing","Illuminite","Iron","Jade","Jellybean Stone","Kelp","Krixanium","Lapis","Lavastone","Legendary Stone","Lily Pad","Log Ore","Lollipop Ore","Macaroni","Magic Wand","Meat Bones","Mithril","Mushroom Ore","Mythic Stone","Nachos","Obsidian","Opals","Oraxanium","Orb Ore","Orcalium","Orpiment","Pearls","Peppermint","Pezzottaite","Pizza","Plastic","Platinum","Praxium","Puzzle Ore","Pyrite","Quartz","Rainbowite","Red Beryl","Red Rock","Royal Ore","Ruby","Sapphire","Seaweed","Shadow Stone","Shells","Shovel Ore","Silver","Skeleton","Skeleton Stone","Skittles Ore","Slate","Spaceship Ore","Starfish","Sunglasses","Sunscreen Ore","Surfboard Ore","Talc","Tank Ore","Tanzanite","Teddybear Ore","Thermium","Titanium","Twig Ore","Twilight Gem","Unicorn Horn Ore","Unobtainium","Uranium","Watermelon","Yellow Beryl","Zircon"}
local binds={}
local oreIds={}
local inventory=screengui.StatsFrame2.Inventory.Amount
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
	return tonumber(str:split("/")[i])
end
function gC()
	return tonumber(plr.leaderstats.Coins.value:gsub(",",""):split(" ")[1])
end
function gI()
	local Amount=(inventory.Text:gsub("%s+","")):gsub(",","")
	local stringTable=Amount:split("/")
	return tonumber(stringTable[1]),tonumber(stringTable[2])
end
function recordDepth(pos)
	if pos.y<lowestSavedY then
		lowestY=pos.y
		lowestSavedY=pos.y
	end
end
function regulate_velocity()
	pcall(function()
		hrp.AssemblyAngularVelocity=Vector3.new(0,0,0)
		hrp.AssemblyLinearVelocity=Vector3.new(0,0,0)
		hrp.Velocity=Vector3.new(0,0,0)
	end)
end
function tweenTo(t,d,c)
	game.TweenService:Create(t,TweenInfo.new(d,Enum.EasingStyle.Linear),{CFrame=c}):Play()
end
local Remote=game.ReplicatedStorage.Network:InvokeServer()
local Remote=game.ReplicatedStorage.Network:InvokeServer()
local rs=game:GetService"RunService".Stepped
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
		if not holder or not holder:FindFirstChild"HumanoidRootPart"then
			for _,v in pairs(workspace:FindPartsInRegion3WithWhiteList(Region3.new((hrp.CFrame-Vector3.new(2,2,2)).Position,(hrp.CFrame+Vector3.new(2,2,2)).Position),{workspace.MiningAreas},15))do
				if v.Name=="HumanoidRootPart"then
					if v.Parent.Name==plr.Name then
						holder=v.Parent
					end
				end
			end
		end
		local nearent
		for _,v in pairs(workspace.TeleportPoints:GetChildren())do
			if v:IsA"Model"then
				if nearest then
					if(nearest.Position-hrp.Position).magnitude>(v.SurfaceSpawn.Position-hrp.Position).magnitude then
						nearest=v.SurfaceSpawn
					end
				else
					nearest=v.SurfaceSpawn
				end
			end
		end
		mineArea=nearest.Parent.Name:gsub("SurfaceSpawns","")
		if mineArea==""then
			mineArea="Surface"
		end
	end)
	if tog.anchor and cd.misc and anchorpos then
		cd.misc=false
		tmp=hrp.Position
		if hrp.CFrame.y<lowestY-500 then
			tweenTo(hrp,.45,CFrame.new(hrp.Position.x,lowestY+5,hrp.Position.z))
		end
		if not tog.vel and(hrp.Position-Vector3.new(anchorpos.x,hrp.Position.y,anchorpos.z)).magnitude>5 then--prevent wandering off
			tweenTo(hrp,.45,CFrame.new(anchorpos.x,lowestY,anchorpos.z))
			if cd.rb then
				rubberbands=rubberbands+1
			end
		end
		if rubberbands>25 then
			rubberbands=0
			tog.anchor=false
			cd.rb=false
			wait(1.4)
			Remote:FireServer("MoveTo",{{mineArea}})
			wait(.2)
			Remote:FireServer("MoveTo",{{mineArea}})
			wait(1.4)
			tog.anchor=true
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
		regulate_velocity()
		rs:Wait()
		cd.vel=true
	end
	if tog.mine and cd.mine then
		cd.mine=false
		if hrp then
			if tonumber(spl(screengui.TopInfoFrame.Depth.Text," ")[1])<depth then
				tog.vel=true
				for _,v in pairs(workspace:FindPartsInRegion3WithWhiteList(Region3.new((hrp.CFrame-Vector3.new(1,10,1)).Position,(hrp.CFrame+Vector3.new(1,0,1)).Position),{workspace.Blocks},5))do
					if v:IsA"BasePart"and v.Parent then
						Remote:FireServer("MineBlock",{{v.Parent}})
						rs:Wait()
						recordDepth(hrp.Position)
					end
					if tog.sell then
						local am,mx=gI()
						if MAX~=nil then mx=MAX end
						if am>=mx then
							if chr and hrp then
								local sL=hrp.Position
								local sA=getnum(inventory.Text,1)
								recordDepth(sL)
								tog.vel=true
								while getnum(inventory.Text,1)>=sA do
									hrp.CFrame=CFrame.new(-38,13.8,22558)
									Remote:FireServer("SellItems",{{}})
									rs:Wait()
								end
								hrp.Anchored=true
								local st=os.time()
								while(hrp.Position-sL).magnitude>1 do
									hrp.CFrame=CFrame.new(sL.x,sL.y,sL.z)
									rs:Wait()
									if os.time()-st>3.5 then break end
								end
								hrp.Anchored=false
								tog.vel=false
							end
						end
					end
				end
				tog.vel=false
			else
				local min=hrp.CFrame-Vector3.new(10,5,10)
				local max=hrp.CFrame+Vector3.new(10,3,10)
				local parts1=workspace:FindPartsInRegion3WithWhiteList(Region3.new((hrp.CFrame-Vector3.new(mineRange.x,mineRange.y,mineRange.x)).Position,(hrp.CFrame+Vector3.new(mineRange.x,mineRange.y,mineRange.x)).Position),{workspace.Blocks},100)
				local parts2=workspace:FindPartsInRegion3WithWhiteList(Region3.new(min.Position,max.Position),{workspace.Blocks},100)
				local nlb=false
				for _,v in pairs(parts2)do
					if v:IsA"BasePart"and v.Parent then
						if ignore[v.Parent.Name]~="ye"or not tog.ignore then
							v.CFrame=hrp.CFrame-Vector3.new(0,3.1+v.Size.y/2,0)
							Remote:FireServer("MineBlock",{{v.Parent}})
							rs:Wait()
							nlb=true
						end
					end
				end
				for _,v in pairs(parts1)do
					if v:IsA"BasePart"and v.Parent and not nlb then
						Remote:FireServer("MineBlock",{{v.Parent}})
						rs:Wait()
					end
					if tog.sell then
						local am,mx=gI()
						if MAX~=nil then mx=MAX end
						if am>=mx then
							if chr and hrp then
								local sL=hrp.Position
								local sA=getnum(inventory.Text,1)
								recordDepth(sL)
								tog.vel=true
								while getnum(inventory.Text,1)>=sA do
									hrp.CFrame=CFrame.new(-38,13.8,22558)
									Remote:FireServer("SellItems",{{}})
									rs:Wait()
								end
								hrp.Anchored=true
								local st=os.time()
								while(hrp.Position-sL).magnitude>1 do
									hrp.CFrame=CFrame.new(sL.x,sL.y,sL.z)
									rs:Wait()
									if os.time()-st>3.5 then break end
								end
								hrp.Anchored=false
								tog.vel=false
							end
						end
					end
					if nlb then break end
				end
			end
		end
		rs:Wait()
		cd.mine=true
	end
	if tog.rebirth and gC()-1e6*(plr.leaderstats.Rebirths.value+1)>0 then
		Remote:FireServer("Rebirth",{{}})
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
			chr:TranslateBy(hum.MoveDirection*1.05)
		else
			chr:TranslateBy(hum.MoveDirection)
		end
	end
	if mp.Progress.AbsoluteSize.x/mp.Decore.AbsoluteSize.x>=0.995 and cd.collapse then
		cd.collapse=false
		notif("collapse alert",tostring(mp.Progress.AbsoluteSize.x/mp.Decore.AbsoluteSize.x),15)
		repeat wait()until math.round(mp.Progress.AbsoluteSize.x/mp.Decore.AbsoluteSize.x*1e5)/1e3<75
		tog.vel=true
		Remote:FireServer("MoveTo",{{mineArea}})
		wait(.2)
		if tog.anchor then
			tweenTo(hrp,.1,CFrame.new(anchorpos.x,16,anchorpos.z))
		end
		tog.vel=false
		lowestY=15
		lowestSavedY=10
		cd.collapse=true
	end
end)
binds.hatch=screengui.ChildAdded:Connect(function(v)
	if v.Name=="HatchedInfo"then
		if tog.egg then
			wait()
			v:Destroy()
			wait(.5)
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
	end
end)
binds.jump=game.UserInputService.JumpRequest:Connect(function()
	if tog.infj and hum then
		hum:ChangeState"Jumping"
	end
end)
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/gui%20lib.lua")()
local UI=GUI:CreateWindow("Miners","...")
local Main=UI:addPage("Main",3,true,1)
local Anchor=UI:addPage("Anchor",3,false,1)
local Pets=UI:addPage("Pet Farm",3,false,1)
local Ores=UI:addPage("Ore ESP",10,false,1)
local Settings=UI:addPage("Settings",3,false,1)
local Local=UI:addPage("Local Player",3,false,1)
local Testing=UI:addPage("test",2,false,1)
Main:addDropdown("Farm Area",locs,#locs*.25,function(v)
	Remote:FireServer("MoveTo",{{v.."Spawn"}})
	wait(.2)
	Remote:FireServer("MoveTo",{{v.."Spawn"}})
end)
Main:addToggle("Auto Mine",tog.mine,function(v)
	tog.mine=v
end)
Main:addTextBox("Depth",depth,function(v)
	if type(tonumber(v))=="number"and tonumber(v)>=1 and tonumber(v)<=5e3 then
		depth=tonumber(v)
	else
		notif("invalid")
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
Anchor:addToggle("Enable",tog.anchor,function(v)
	tog.anchor=v
end)
Anchor:addButton("Set Anchor",function()
	local n=true
	for _,v in pairs(workspace:FindPartsInRegion3WithWhiteList(Region3.new((hrp.CFrame-Vector3.new(0,5,0)).Position,hrp.Position),{workspace.Blocks},15))do
		if v:IsA"BasePart"and v.Parent then
			anchorpos={x=v.Position.x,z=v.Position.z}
			f=false
		end
	end
	if f then
		notif("no anchor point found")
	end
	lowestY=hrp.CFrame.y
end)
Pets:addToggle("Farm Omega Egg",tog.egg,function(v)
	tog.egg=v
end)
Ores:addLabel("Type IDs of the ore","ex: 4,8,5")
Ores:addTextBox("IDs","",function(v)
	oreIds=spl(v,",")
end)
Ores:addLabel("~ ~ ~ IDs ~ ~ ~")
for i,v in pairs(oreIdList)do
	Ores:addLabel(v,i)
	wait(.01)
end
Settings:addSlider("Mine Radius X",2,10,function(v)
	mineRange.x=tonumber(v)
end)
Settings:addSlider("Mine Radius Y",2,10,function(v)
	mineRange.y=tonumber(v)
end)
Settings:addTextBox("Selling Threshold",math.min(getnum(inventory.Text,2),MAX),function(v)
	if type(tonumber(v))=="number"and tonumber(v)>0 and tonumber(v)<=getnum(inventory.Text,2)then
		MAX=tonumber(v)
	else
		MAX=nil
		notif("setting to "..getnum(inventory.Text,2))
	end
end)
Settings:addTextBox("Crate(Buy/Open) Cooldown",cd.crwt,function(v)
	if tonumber(v)>=0 and tonumber(v)<=5 then
		cd.crwt=tonumber(v)
	else
		notif("invalid")
	end
end)
Settings:addTextBox("Crate Count",1,function(v)
	if tonumber(v)>0 and tonumber(v)<=1e3 then
		crateAmount=tonumber(v)
	else
		notif("invalid")
	end
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
end)
notif("Mining Simulator By 0x3b5","120",5)
plr.DevCameraOcclusionMode=Enum.DevCameraOcclusionMode.Invisicam
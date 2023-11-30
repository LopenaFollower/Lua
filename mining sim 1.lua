if game.PlaceId~=1417427737 then return else repeat wait(1)until game:IsLoaded()and game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild"leaderstats"end
local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr.Humanoid
local hrp=chr.HumanoidRootPart
local Remote=game.ReplicatedStorage.Network:InvokeServer()
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
local mineArea="LavaSpawn"
local mineRange={x=5,y=5}
local tmp=hrp.Position
local lowestSavedY=15
local lowestY=15
local anchorpos=nil
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
function recordDepth(pos)
	if pos.y<lowestSavedY then
		lowestY=pos.y
		lowestSavedY=pos.y
	end
end
if not workspace:FindFirstChild"platform"then
	local p=Instance.new"Part"
	p.Name="platform"
	p.Parent=workspace
	p.Size=Vector3.new(2,0,2)
	p.Anchored=true
	p.CFrame=CFrame.new(0,0,0)
end
local items={"Common","Rare","Epic","Omega","Mythical","Common Hat Crate","Rare Hat Crate","Epic Hat Crate","Omega Hat Crate","Mythical Hat Crate","Spooky Hat Crate","Haunted Hat Crate","Christmas Hat Crate","Common Accessory Crate","Rare Accessory Crate","Epic Accessory Crate","Omega Accessory Crate","Mythical Accessory Crate","Common Trail Crate","Rare Trail Crate","Epic Trail Crate","Omega Trail Crate","Mythical Trail Crate","Spooky Trail Crate"}
local locs={"Surface","Space","Candy","Toy","Food","Dino","Sea","Beach","Forest","Cavern","Lava"}
local binds={}
local inventory=plr.PlayerGui.ScreenGui.StatsFrame2.Inventory.Amount
function gC()
	return tonumber(plr.leaderstats.Coins.value:gsub(",",""):split(" ")[1])
end
function notif(ti,tx,d)
	game.StarterGui:SetCore("SendNotification",{
		Title=ti or"";
		Text=tx or"";
		Duration=d or 1;
	})
end
function getnum(str,i)
	str=str:gsub("%s+","")
	str=str:gsub(",","")
	return tonumber(str:split("/")[i])
end
function gI()
	local Amount=inventory.Text
	Amount=Amount:gsub("%s+","")
	Amount=Amount:gsub(",","")
	local stringTable=Amount:split("/")
	return tonumber(stringTable[1]),tonumber(stringTable[2])
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
local rs=game:GetService"RunService".Stepped
local mp
local rubberbands=0
binds.main=game:GetService"RunService".Heartbeat:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr.Humanoid
		hrp=chr.HumanoidRootPart
		inventory=plr.PlayerGui.ScreenGui.StatsFrame2.Inventory.Amount
		tmp=hrp.Position
		mp=plr.PlayerGui.ScreenGui.Collapse
		mp.Visible=true
		lowestY=lowestY-.25
		hum.HipHeight=2.2
		tweenTo(workspace:FindFirstChild"platform",.01,CFrame.new(tmp.x,lowestY-3.1,tmp.z))
	end)
	if tog.anchor and cd.misc and anchorpos then
		cd.misc=false
		tmp=hrp.Position
		if hrp.CFrame.y<lowestY-10 then
			hrp.CFrame=CFrame.new(tmp.x,lowestY,tmp.z)
		end
		if not tog.vel and(hrp.Position-Vector3.new(anchorpos.x,hrp.Position.y,anchorpos.z)).magnitude>5 then--prevent wandering off
			tweenTo(hrp,.45,CFrame.new(anchorpos.x,lowestSavedY,anchorpos.z))
			lowestY=lowestSavedY
			if cd.rb then
				rubberbands=rubberbands+1
			end
		end
		if rubberbands>100 then
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
		wait(.1)
		cd.vel=true
	end
	if tog.mine and cd.mine then
		cd.mine=false
		if hrp then
			local min1=hrp.CFrame-Vector3.new(mineRange.x,mineRange.y,mineRange.x)
			local min2=hrp.CFrame-Vector3.new(10,5,10)
			local max1=hrp.CFrame+Vector3.new(mineRange.x,mineRange.y,mineRange.x)
			local max2=hrp.CFrame+Vector3.new(10,3,10)
			local region1=Region3.new(min1.Position,max1.Position)
			local region2=Region3.new(min2.Position,max2.Position)
			local parts1=workspace:FindPartsInRegion3WithWhiteList(region1,{workspace.Blocks},100)
			local parts2=workspace:FindPartsInRegion3WithWhiteList(region2,{workspace.Blocks},100)
			local nlb=false
			for _,v in pairs(parts2)do
				if v:IsA"BasePart"and v.Parent then
					if ignore[v.Parent.Name]~="ye"or not tog.ignore then
						print(v.Parent.Name)
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
	if mp.Progress.AbsoluteSize.x/mp.Decore.AbsoluteSize.x>=0.9995 and cd.collapse then
		cd.collapse=false
		notif("collapsed",tostring(mp.Progress.AbsoluteSize.x/mp.Decore.AbsoluteSize.x),15)
		repeat wait()until math.round(mp.Progress.AbsoluteSize.x/mp.Decore.AbsoluteSize.x*1e5)/1e3<75
		tweenTo(hrp,.45,CFrame.new(anchorpos.x,15,anchorpos.z))
		lowestY=15
		lowestSavedY=10
		cd.collapse=true
	end
	mp.Amount.Text=tostring(math.round(mp.Progress.AbsoluteSize.x/mp.Decore.AbsoluteSize.x*1e5)/1e3)
end)
binds.jump=game.UserInputService.JumpRequest:Connect(function()
	if tog.infj and hum then
		hum:ChangeState"Jumping"
	end
end)
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/gui%20lib.lua")()
local UI=GUI:CreateWindow("Miners","...")
local Main=UI:addPage("Main",3,true,1)
local Platform=UI:addPage("Platform",3,false,1)
local Settings=UI:addPage("Settings",3,false,1)
local Local=UI:addPage("Local Player",3,false,1)
local Testing=UI:addPage("test",2,false,1)
Main:addDropdown("Farm Area",locs,#locs*.25,function(v)
	mineArea=v.."Spawn"
	Remote:FireServer("MoveTo",{{mineArea}})
	wait(.2)
	Remote:FireServer("MoveTo",{{mineArea}})
end)
Main:addToggle("Auto Mine",tog.mine,function(v)
	tog.mine=v
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
Platform:addToggle("Enable",tog.anchor,function(v)
	tog.anchor=v
	lowestY=hrp.CFrame.y
	lowestSavedY=hrp.CFrame.y-5
end)
Platform:addButton("Set Anchor",function()
	anchorpos={x=hrp.Position.x,z=hrp.Position.z}
	lowestY=hrp.CFrame.y
end)
Platform:addButton("Platform:Reset",function()
	lowestY=hrp.CFrame.y
end)
Platform:addButton("Platform:Move Up",function()
	lowestY=lowestY+25
end)
Platform:addButton("Platform:Move Down",function()
	lowestY=lowestY-25
end)
Settings:addSlider("Mine Radius X",2,10,function(v)
	mineRange.x=tonumber(v)
end)
Settings:addSlider("Mine Radius Y",2,10,function(v)
	mineRange.y=tonumber(v)
end)
Settings:addTextBox("Selling Threshold",math.min(getnum(inventory.Text,2),MAX),function(v)
	if v=="nil"or v==""or tonumber(v)>getnum(inventory.Text,2)then
		MAX=nil
	end
	if tonumber(v)>10 and tonumber(v)<=getnum(inventory.Text,2)then
		MAX=tonumber(v)
	end
end)
Settings:addTextBox("Crate(Buy/Open) Cooldown",1,function(v)
	if tonumber(v)>=0.01 and tonumber(v)<=5 then
		cd.crwt=tonumber(v)
	end
end)
Settings:addTextBox("Crate Count",1,function(v)
	if tonumber(v)>=1 and tonumber(v)<=1e3 then
		crateAmount=tonumber(v)
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
notif("Mining Simulator","By 0x3b5",5)
plr.DevCameraOcclusionMode=Enum.DevCameraOcclusionMode.Invisicam
if game.PlaceId~=1417427737 then return else repeat wait(1)until game:IsLoaded()and game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild"leaderstats"end
local MAX=2e5
local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr.Humanoid
local hrp=chr.HumanoidRootPart
local Remote=game.ReplicatedStorage.Network:InvokeServer()
local tog={
	mine=false,
	fmine=false,
	sell=false,
	rebirth=true,
	crate=false,
	vel=false,
	infj=false
}
local cd={
	mine=true,
	sell=true,
	crate1=true,
	crate2=true,
	crwt=1,
	vel=true,
	misc=true,
	rebirth=true
}
local mineRange=10
local tmp=hrp.Position
local lowestSavedY=0
local lowestY=0
function recordDepth(pos)
	if pos.y-5<lowestSavedY then
		lowestY=pos.y
		lowestSavedY=pos.y
	end
end
local anchorpos=nil
if not workspace:FindFirstChild"platform"then
	local p=Instance.new"Part"
	p.Name="platform"
	p.Parent=workspace
	p.Size=Vector3.new(5,0,5)
	p.Anchored=true
	p.CFrame=CFrame.new(0,0,0)
end
local crateType="Common"
local crateAmount=1
local items={
	"Common","Rare","Epic","Omega","Mythical","Common Hat Crate","Rare Hat Crate","Epic Hat Crate","Omega Hat Crate","Mythical Hat Crate","Spooky Hat Crate","Haunted Hat Crate","Christmas Hat Crate","Common Accessory Crate","Rare Accessory Crate","Epic Accessory Crate","Omega Accessory Crate","Mythical Accessory Crate","Common Trail Crate","Rare Trail Crate","Epic Trail Crate","Omega Trail Crate","Mythical Trail Crate","Spooky Trail Crate"
}
local binds={}
local inventory=plr.PlayerGui.ScreenGui.StatsFrame2.Inventory.Amount
function gC()
	return tonumber(plr.leaderstats.Coins.value:gsub(",",""))
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
local Remote=game.ReplicatedStorage.Network:InvokeServer()
binds.main=game:GetService"RunService".Heartbeat:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr.Humanoid
		hrp=chr.HumanoidRootPart
		inventory=plr.PlayerGui.ScreenGui.StatsFrame2.Inventory.Amount
		tmp=hrp.Position
		lowestY=lowestY-.075
	end)
	if cd.misc then
		cd.misc=false
		tmp=hrp.Position
		if hrp.CFrame.y<lowestY-10 then
			workspace:FindFirstChild"platform".CFrame=CFrame.new(tmp.x,lowestY-10,tmp.z)
			hrp.CFrame=CFrame.new(tmp.x,lowestY-6.875,tmp.z)
		else
			workspace:FindFirstChild"platform".CFrame=CFrame.new(tmp.x,lowestY-10,tmp.z)
		end
		if anchorpos and(hrp.Position-Vector3.new(22,15,26292)).magnitude<10 then--collapsed
			hrp.CFrame=CFrame.new(anchorpos.x,15,anchorpos.z)
		end
		if anchorpos and not tog.vel and(hrp.Position-Vector3.new(anchorpos.x,hrp.Position.y,anchorpos.z)).magnitude>5 then--prevent wandering off
			hrp.CFrame=CFrame.new(anchorpos.x,hrp.Position.y,anchorpos.z)
		end
		wait(.1)
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
			local min=hrp.CFrame-Vector3.new(mineRange,mineRange,mineRange)
			local max=hrp.CFrame+Vector3.new(mineRange,mineRange,mineRange)
			local region=Region3.new(min.Position,max.Position)
			local parts=workspace:FindPartsInRegion3WithWhiteList(region,{game.Workspace.Blocks},100)
			for _,v in pairs(parts)do
				if v:IsA"BasePart"then
		            Remote:FireServer("MineBlock",{{v.Parent}})
					wait()
				end
			end
		end
		wait(.1)
		cd.mine=true
	end
	if tog.rebirth and cd.rebirth then
		cd.rebirth=false
		Remote:FireServer("Rebirth",{{}})
		wait(.25)
		cd.rebirth=true
	end
	if tog.sell and cd.sell then
		cd.sell=false
		local am,mx=gI()
		if MAX~=nil then mx=MAXend
		if am>=mx then
			if chr and hrp then
				local sL=hrp.Position+Vector3.new(0,5,0)
				local sA=getnum(inventory.Text,1)
				local mine=tog.mine
				recordDepth(sL)
				tog.mine=false
				tog.vel=true
				repeat
					hrp.CFrame=CFrame.new(56,14.8,26363)
					Remote:FireServer("SellItems",{{}})
					wait()
				until getnum(inventory.Text,1)<sA
				wait(1)
				while(hrp.Position-sL).magnitude>5 do
					hrp.CFrame=CFrame.new(sL.x,sL.y,sL.z)
					wait()
				end
				tog.mine=mine
			end
		end
		wait(1)
		cd.sell=true
		tog.vel=false
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
end)
binds.nbl=game.Workspace.Blocks.ChildAdded:Connect(function(v)
	if tog.fmine then
		local s=v:WaitForChild"Stats"
		if s then
			local m=s:WaitForChild"Multiplier"
			if m then
				local a=s:FindFirstChild"ActualMultiplier"
				if not a then
					local a=m:Clone()
					a.Name="ActualMultiplier"
					a.Parent=s
				end
				m.value=-1337
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
local Locs=UI:addPage("Platform",3,false,1)
local Settings=UI:addPage("Settings",3,false,1)
local Local=UI:addPage("Local Player",3,false,1)
Main:addToggle("Auto Mine",tog.mine,function(v)
	tog.mine=v
end)
Main:addToggle("Fast Mine",tog.fmine,function(v)
	tog.fmine=v
	if tog.fmine then
		for _,i in pairs(game.Workspace.Blocks:GetChildren())do
			local s=i:FindFirstChild"Stats"
			if s then
				local m=s:FindFirstChild"Multiplier"
				if m then
					local a=s:FindFirstChild"ActualMultiplier"
					if not a then
						local a=m:Clone()
						a.Name="ActualMultiplier"
						a.Parent=s
					end
					m.value=-1337
				end
			end
		end
	else
		for _,i in pairs(game.Workspace.Blocks:GetChildren())do
			local s=block:FindFirstChild"Stats"
			if s then
				local m=s:FindFirstChild"Multiplier"
				if m then
					local a=s:FindFirstChild"ActualMultiplier"
					if a then
						m.value=a.value
					end
				end
			end
		end
	end
end)
Main:addToggle("Auto Sell",tog.sell,function(v)
	tog.sell=v
	cd.sell=true
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
Main:addDropdown("Crate Type",items,#items*.25,function(v)
	crateType=v
end)
Locs:addButton("Set Anchor",function()
	anchorpos={x=hrp.Position.x,z=hrp.Position.z}
	lowestY=hrp.CFrame.y
end)
Locs:addButton("Platform:Reset",function()
	lowestY=hrp.CFrame.y
end)
Locs:addButton("Platform:Move Up",function()
	lowestY=lowestY+5
end)
Locs:addButton("Platform:Move Down",function()
	lowestY=lowestY-5
end)
Settings:addSlider("Mine Radius",1,15,function(v)
	mineRange=tonumber(v)
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
Local:destroyGui(function()
	for _,v in pairs(binds)do
		v:Disconnect()
	end
end)
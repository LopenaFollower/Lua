if game.placeId~=2986677229 then return else repeat wait(1)until game:IsLoaded()and game.Players.LocalPlayer end
local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr.Humanoid
local hrp=chr.HumanoidRootPart
local binds={}
local vacant=true
local orbsP
local plrGui=plr.PlayerGui
local tog={
	swing=true,
	orbs=false,
	meteor=false,
	event=false,
	tpwalk=false,
	farmboss=false,
	petcrate=false,
	skillupgrade=false,
	sellchest=true,
	upwpn=false,
	upskn=false,
	rebirth=false,
	dungeon=false
}
local cd={
	swing=true,
	orbs=true,
	meteor=true,
	event=true,
	petcrate=true,
	skillupgrade=true,
	sellchest=true,
	upgd=true,
	rebirth=true,
	dungeon=true
}
local vals={
	tpws=nil,
	boss={
		borock=false,
		robotron=false,
		demonking=false,
		terminator=false,
		templeguard=false,
		gnomes=false,
		penguins=false
	},
	crateid=nil,
	esplist={},
	weapons={
		main=nil,
		offh=nil
	},
	dungeon={
		route={"0,0"},
		backup={"0,0"}
	}
}
local ignore={
	notifs=true,
	arena=false
}
plr.DevCameraOcclusionMode=Enum.DevCameraOcclusionMode.Invisicam
local RunService=game:GetService"RunService"
local aeroServices=game.ReplicatedStorage.Aero.AeroRemoteServices
local wpnInventory=plrGui.Inventory.Main.InventoryBG.InventoryClipFrame.InventoryMainFrame.WpnInventoryFrame.WpnInvDataFrame.WpnSelectionPanel.WpnSelectionFrame
function pop(tb)
	local n=tb[#tb]
	tb[#tb]=nil
	return n
end
function push(tb,v)
	table.insert(tb,v)
end
function noVelocity()
	pcall(function()
		hrp.AssemblyAngularVelocity=Vector3.new(0,0,0)
		hrp.AssemblyLinearVelocity=Vector3.new(0,0,0)
		hrp.Velocity=Vector3.new(0,0,0)
	end)
end
function esp(v)
	if not v:FindFirstChild"highlight"then
		local a=Instance.new("BoxHandleAdornment",v)
		a.Name="highlight"
		a.Adornee=v
		a.AlwaysOnTop=true
		a.ZIndex=0
		a.Size=v.Size/Vector3.new(1.5,1.5,1.5)
		a.Transparency=.25
		a.Color=BrickColor.new"White"
		table.insert(vals.esplist,a)
	end
end
function press(button,enable)
	for _,v in pairs(getconnections(button.Activated))do
		if enable then v:Enable()end
		v:Fire()
	end
	for _,v in pairs(getconnections(button.MouseButton1Down))do
		if enable then v:Enable()end
		v:Fire()
	end
end
function findDescendant(p,n,t)
	for _,v in pairs(p:GetDescendants())do
		if v.Name==n then
			if t then
				if not v:IsA(t)then return end
			end
			return v
		end
	end
end
function nearest(list)
	local r=nil
	for _,v in pairs(list)do
		if r==nil or(hrp.Position-v.Position).magnitude<(r.Position-hrp.Position).magnitude then
			r=v
		end
	end
	return r
end
function swing()
	local service=aeroServices.GameService
	service.WeaponAttackStart:FireServer()
	service.WeaponAnimComplete:FireServer()
end
function getboss()
	local t=workspace
	local npcs=workspace.NPC
	local gnomes=npcs.Gnomes:GetChildren()
	local penguins=npcs.Penguins:GetChildren()
	pcall(function()
		function getst(n)
			return npcs[n]:FindFirstChild(n)and findDescendant(npcs[n],"Health","TextLabel")and tonumber(findDescendant(npcs[n],"Health","TextLabel").Text)>0
		end
		if npcs.Boss:FindFirstChild"Borock"and vals.boss.borock and plrGui.BossBoard.Frame.BossHealthFrame.Health.Text~="0" then
			t=npcs.Boss:FindFirstChild"Borock"
		elseif getst"SlumBoss"and vals.boss.robotron then
			t=npcs.SlumBoss:FindFirstChild"SlumBoss"
		elseif getst"DemonKing"and vals.boss.demonking then
			t=npcs.DemonKing:FindFirstChild"DemonKing"
		elseif getst"SkeleBoss"and vals.boss.terminator then
			t=npcs.SkeleBoss:FindFirstChild"SkeleBoss"
		elseif getst"EgyptBoss"and vals.boss.templeguard then
			t=npcs.EgyptBoss:FindFirstChild"EgyptBoss"
		elseif#gnomes>0 and vals.boss.gnomes then
			t=gnomes[math.random(1,#gnomes)]
		elseif#penguins>0 and vals.boss.penguins then
			t=penguins[math.random(1,#penguins)]
		end
	end)
	return t:FindFirstChild"HumanoidRootPart"
end
wait(.1)
binds.main=RunService.Heartbeat:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr.Humanoid
		hrp=chr.HumanoidRootPart
		plrGui=plr.PlayerGui
		if not orbsP then
			for _,v in pairs(workspace.Scene:GetChildren())do
				if type(tonumber(v.Name))=="number"then
					orbsP=v
				end
			end
		end
		wpnInventory=plrGui.Inventory.Main.InventoryBG.InventoryClipFrame.InventoryMainFrame.WpnInventoryFrame.WpnInvDataFrame.WpnSelectionPanel.WpnSelectionFrame
		hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
	end)
	if tog.swing and cd.swing then
		cd.swing=false
		swing()
		wait()
		cd.swing=true
	end
	if tog.dungeon and cd.dungeon then
		cd.dungeon=false
		while tostring(plr.TeamColor)~="Sea green"and not workspace.DungeonEntrance.Floor.BillboardGui.Closed.Visible do
			if(hrp.Position-workspace.DungeonEntrance.Darkness.Position).magnitude>5 then
				vals.dungeon.route={"0,0"}
				vals.dungeon.backup={"0,0"}
			end
			hrp.CFrame=workspace.DungeonEntrance.Darkness.CFrame*CFrame.new(0,5,0)
			wait(2.5)
		end
		local plrDungeon=workspace.Dungeons:FindFirstChild(tostring(plr.Dungeon.Value))
		function plrPos()
			return plr.DungeonLocation and plr.DungeonLocation.value
		end
		function strPos()
			return tostring(plrPos()):gsub(" ","")
		end
		if plrDungeon and plrPos() then
			function XYZtoXY(c)
				local t=c:split","
				return t[1]..","..t[3]
			end
			function XYtoXYZ(c)
				local t=c:split","
				return t[1]..","..plrPos().y..","..t[2]
			end
			function direction(c)
				local t=c:split","
				local xy=t[1]:gsub("-0","0")..","..t[2]:gsub("-0","0")
				local dirs={
					["1,0"]="East",
					["-1,0"]="West",
					["0,1"]="North",
					["0,-1"]="South"
				}
				return dirs[xy]
			end
			function coordinate(nsew)
				local y=plrPos().y
				local dirs={
					["North"]=string.format("0,%s,1",y),
					["South"]=string.format("0,%s,-1",y),
					["East"]=string.format("1,%s,0",y),
					["West"]=string.format("-1,%s,0",y)
				}
				return dirs[nsew]
			end
			function getRoom()
				return plrDungeon:FindFirstChild("Room:"..strPos())
			end
			function visitedRoom(xyz)
				local a="Room:"..xyz
				return plrDungeon:FindFirstChild(a)and plrDungeon[a]:FindFirstChild"e"
			end
			function gotoRoom(xyz)
				local c=plrDungeon:FindFirstChild("Room:"..xyz).Floor.floor_Plane.CFrame
				hrp.CFrame=CFrame.new(c.x,c.y+10,c.z)
				local w=Instance.new("Weld",plrDungeon:FindFirstChild("Room:"..xyz))
				w.Name="e"
			end
			function roomsLeft()
				local n=0
				for _,v in pairs(plr.PlayerGui.DungeonMinimap.MapFrame:GetChildren())do
					pcall(function()
						if tostring(v.BackgroundColor)=="Silver flip/flop"then
							n=n+1
						end
					end)
				end
				return n
			end
			function inverse(xy)
				local t=xy:split","
				return tonumber(t[1]*-1)..","..tonumber(t[2]*-1)
			end
			function recordPath(xy)
				push(vals.dungeon.route,xy)
				push(vals.dungeon.backup,xy)
			end
			function checkPath(xy)
				return plrGui.DungeonMinimap.MapFrame:FindFirstChild(xy)and plrGui.DungeonMinimap.MapFrame:FindFirstChild(xy).Visible
			end
			function getPaths()
				local ps,p={},plrPos()
				for _,v in pairs(getRoom().Doors:GetChildren())do
					if v:IsA"BasePart"then
						push(ps,XYZtoXY(coordinate(v.Name)))
					end
				end
				local fp={}
				for i=1,#ps do
					local sp=ps[i]:split","
					local hf=(sp[1]/2)..","..(sp[2]/2)
					local ar=(tonumber(sp[1])+p.x)..","..p.y..","..(tonumber(sp[2])+p.z)
					if checkPath(hf)and not visitedRoom(ar)then
						push(fp,ps[i])
					end
				end
				return fp
			end
			function getRoot(i)
				for _,v in pairs(i:GetDescendants())do
					if v.Name==hrp.Name then
						return v
					end
				end
			end
			function canMove()
				local t=false
				for _,v in pairs(getRoom().Doors:GetChildren())do
					if v:IsA"BasePart"and tostring(v.BrickColor)=="Shamrock"then
						t=true
					end
				end
				return t
			end
			if roomsLeft()>0 then
				local retrace=#getPaths()<1
				if not retrace then
					if XYZtoXY(strPos())=="0,0"then
						gotoRoom(strPos())
					end
					local dirs=getPaths()
					local cd=dirs[math.random(1,#dirs)]
					local oldRoom=getRoom().Name
					local chosenDoor=getRoom().Doors[direction(cd)]
					hrp.CFrame=chosenDoor.CFrame
					repeat wait(.1)until getRoom().Name~=oldRoom or tostring(plr.TeamColor)~="Sea green"
					wait(.3)
					recordPath(cd)
					if not getRoom().Doors:FindFirstChild"Down"then
						gotoRoom(strPos())
					end
				end
				local pass=true
				if getRoom().Doors:FindFirstChild"Down"then
					local fl=plrPos().y
					gotoRoom(strPos())
					repeat wait()until plrGui.NotificationsV2.Dialogs:FindFirstChild"Dialog"or tostring(plr.TeamColor)~="Sea green"or plrPos().y>fl
					pcall(function()
						press(plrGui.NotificationsV2.Dialogs.Dialog.Frame.Buttons.Okay)
					end)
					pass=false
					retrace=false
					repeat wait()until plrPos().y>fl or tostring(plr.TeamColor)~="Sea green"
					vals.dungeon.route={"0,0"}
					vals.dungeon.backup={"0,0"}
					wait(.5)
				end
				wait(.5)
				if pass then
					repeat wait()until getRoom()and(getRoom():FindFirstChild"Enemies"or getRoom():FindFirstChild"Chest")or tostring(plr.TeamColor)~="Sea green"or XYZtoXY(strPos())=="0,0"
					wait(.25)
					if getRoom():FindFirstChild"Enemies"and #getRoom().Enemies:GetChildren()>0 then
						while #getRoom().Enemies:GetChildren()>0 do
							pcall(function()
								local enems=getRoom().Enemies:GetChildren()
								if not tog.swing then
									swing()
								end
								hrp.CFrame=getRoot(enems[math.random(1,#enems)]).CFrame
								noVelocity()
								task.wait(.1)
							end)
						end
						repeat wait(.25)until canMove()or tostring(plr.TeamColor)~="Sea green"
					elseif getRoom():FindFirstChild"Chest"and getRoom().Chest:FindFirstChild"Base"and getRoom().Chest.Base:FindFirstChild"ProximityPrompt"then
						local b=getRoom().Chest.Base
						local st=os.time()
						while b:FindFirstChild"ProximityPrompt"do
							hrp.CFrame=b.CFrame*CFrame.new(0,5,0)
							wait()
							pcall(function()
								fireproximityprompt(b.ProximityPrompt)
							end)
							if os.time()-st>2 then
								b:FindFirstChild"ProximityPrompt":Destroy()
								break
							end
						end
						repeat wait(.25)until canMove()or tostring(plr.TeamColor)~="Sea green"
					elseif retrace and#getPaths()<1 then
						if #vals.dungeon.route<1 then
							vals.dungeon.route={table.unpack(vals.dungeon.backup)}
						end
						pcall(function()
							local cd=inverse(vals.dungeon.route[#vals.dungeon.route])
							local chosenDoor=getRoom().Doors[direction(cd)]
							local oldRoom=getRoom().Name
							hrp.CFrame=chosenDoor.CFrame
							repeat wait(.1)until getRoom().Name~=oldRoom or tostring(plr.TeamColor)~="Sea green"
							pop(vals.dungeon.route)
							wait(.3)
							gotoRoom(strPos())
						end)
						wait(.25)
					end
				end
			end
			wait(1)
		end
		cd.dungeon=true
	else
		if tog.orbs and cd.orbs and vacant then
			vacant=false
			cd.orbs=false
			local orbs={}
			for _,v in pairs(orbsP:GetChildren())do
				local pr=v:FindFirstChild"Prefab"
				if pr then
					table.insert(orbs,pr)
				end
			end
			local c=#orbs
			if c<1 then c=1 end
			local orb=orbs[math.random(1,c)]
			if orb then
				hrp.CFrame=orb.Parent.CFrame
			end
			wait(.25)
			vacant=true
			cd.orbs=true
		end
		if tog.meteor and vacant then
			vacant=false
			cd.meteor=false
			local meteor=workspace.Meteors:FindFirstChild"Meteor"
			if meteor and(hrp.Position-meteor.Position).magnitude>20 and meteor.Health.value>0 then
				hrp.CFrame=meteor.CFrame
			end
			wait(.1)
			vacant=true
			cd.meteor=true
		end
		if tog.event and cd.event and vacant then
			vacant=false
			cd.event=false
			local trg={}
			for _,v in pairs(workspace.Ephemeral.AdvCrate:GetChildren())do
				local pr=v.TechBox:FindFirstChild"SnowMan"
				if pr.Transparency==0 then
					table.insert(trg,pr.Parent)
				end
			end
			local snm=nearest(trg)
			if snm then
				if(hrp.Position-snm.Position).magnitude>5 then
					hrp.CFrame=snm.CFrame
				end
			end
			wait(.25)
			vacant=true
			cd.event=true
		end
		if tog.farmboss and vacant then
			vacant=false
			local boss=getboss()
			local bossold=boss
			while boss==bossold and boss~=nil and tog.farmboss do
				hrp.CFrame=boss.CFrame
				vacant=false
				wait(.025)
				noVelocity()
				boss=getboss()
			end
			wait(.1)
			vacant=true
		end
	end
	if tog.tpwalk and chr and hum then
		local d=RunService.Heartbeat:Wait()*10
		if hum.MoveDirection.Magnitude>0 then
			if vals.tpws and vals.tpws>0 then
				chr:TranslateBy(hum.MoveDirection*vals.tpws*d)
			else
				chr:TranslateBy(hum.MoveDirection*d)
			end
		end
	end
	if tog.petcrate and cd.petcrate then
		cd.petcrate=false
		pcall(function()
			fireproximityprompt(workspace.PetCrates[vals.crateid].Mesh.ProximityAttachment.ProximityPrompt)
			wait(.1)
		end)
		pcall(function()
			fireproximityprompt(workspace.ArtifactCrates[vals.crateid].Mesh.ProximityAttachment.ProximityPrompt)
			wait(.1)
		end)
		cd.petcrate=true
	end
	if tog.skillupgrade and cd.skillupgrade then
		cd.skillupgrade=false
		press(plrGui.RebirthGui.RebirthSkillMainPanel.ClipFrame.SlidingFrame.SkillsFrame.upgrade.MaxUpgrade)
		wait(.05)
		pcall(function()
			plrGui.HUD.BottomHUD.Popup:Destroy()
		end)
		cd.skillupgrade=true
	end
	if tog.sellchest and cd.sellchest then
		cd.sellchest=false
		for _,v in pairs(plrGui.Inventory.Main.InventoryBG.InventoryClipFrame.InventoryMainFrame.ChestInventoryFrame.ChestSelectionPanel.ChestSelectionFrame:GetChildren())do
			if v.Name=="ChestInventoryItem"then
				press(v)
				wait(.1)
				press(plrGui.Inventory.Main.InventoryBG.InventoryClipFrame.InventoryMainFrame.ChestInventoryFrame.SellFrame.SellButton)
				plrGui.HUD.Screen.SellPrompt.Visible=false
				wait(.1)
				press(plrGui.HUD.Screen.SellPrompt.ImageLabel.SellBtn)
			end
		end
		wait(1)
		cd.sellchest=true
	end
	if cd.upgd and(tog.upwpn or tog.upskn)then
		cd.upgd=false
		for _,v in pairs(wpnInventory:GetChildren())do
			pcall(function()
			if v.EqpBrdr.Visible then
				if v.EqpBrdr.ImageColor3.g==1 then
					vals.weapons.main=v
				else
					vals.weapons.offh=v
				end
			end
			end)
		end
		if tog.upwpn then
			press(vals.weapons.main.SelectionButton,true)
			press(plrGui.Inventory.Main.InventoryBG.InventoryClipFrame.InventoryMainFrame.WpnInventoryFrame.ButtonFrame.SUFrame.MaxButton)
			plrGui.HUD.Screen.ConfirmPrompt.Visible=false
		end
		press(plrGui.HUD.Screen.ConfirmPrompt.ImageLabel.ConfirmBtn)
		wait(.2)
		if tog.upwpn then
			press(vals.weapons.offh.SelectionButton,true)
			press(plrGui.Inventory.Main.InventoryBG.InventoryClipFrame.InventoryMainFrame.WpnInventoryFrame.ButtonFrame.SUFrame.MaxButton)
			plrGui.HUD.Screen.ConfirmPrompt.Visible=false
		end
		press(plrGui.HUD.Screen.ConfirmPrompt.ImageLabel.ConfirmBtn)
		wait(.2)
		if tog.upskn then
			press(plrGui.Inventory.Main.InventoryBG.InventoryClipFrame.InventoryMainFrame.SkinInventoryFrame.ButtonFrame.SUFrame.MaxButton)
			plrGui.HUD.Screen.ConfirmPrompt.Visible=false
		end
		press(plrGui.HUD.Screen.ConfirmPrompt.ImageLabel.ConfirmBtn)
		wait(.2)
		cd.upgd=true
	end
	if tog.rebirth and cd.rebirth then
		cd.rebirth=false
		press(plrGui.RebirthGui.RebirthPrompt.ImageLabel.ConfirmBtn)
		wait(.25)
		cd.rebirth=true
	end
end)
binds.jump=game.UserInputService.JumpRequest:Connect(function()
	if tog.infj and hum then
		hum:ChangeState"Jumping"
	end
end)
binds.notifs=plrGui.HUD.BottomHUD.ChildAdded:Connect(function(v)
	if v.Name=="XpFrame"or v.Name=="Popup"then
		v.Visible=not ignore.notifs
	end
	plrGui.ArenaGui.Main.ArenaPopup.Visible=not ignore.arena
end)
binds.hatch=plrGui.HUD.Screen.ChildAdded:Connect(function(v)
	if v.Name=="PetReward"then
		v.Visible=false
	end
	v.Parent.PetCrateFrame.CrateImage.Visible=false
end)
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/gui%20lib.lua")()
local UI=GUI:CreateWindow("Giant","v0.28")
local Main=UI:addPage("Main",3,true,1)
local Crates=UI:addPage("Crates",3,false,1)
local Bosses=UI:addPage("Bosses",3,false,1)
local Misc=UI:addPage("Miscellaneous",3,false,1)
local Local=UI:addPage("Local Player",3,false,1)
Main:addToggle("Auto Swing",tog.swing,function(v)
	tog.swing=v
end)
Main:addToggle("Collect Orbs",tog.orbs,function(v)
	tog.orbs=v
end)
Main:addToggle("Mine Meteor",tog.meteor,function(v)
	tog.meteor=v
end)
Main:addToggle("Farm Snowmen",tog.event,function(v)
	tog.event=v
end)
Main:addToggle("Skill Upgrade",tog.skillupgrade,function(v)
	tog.skillupgrade=v
end)
Main:addToggle("Sell Chests",tog.sellchest,function(v)
	tog.sellchest=v
end)
Main:addToggle("Weapon Upgrade",tog.upwpn,function(v)
	tog.upwpn=v
end)
Main:addToggle("Skin Upgrade",tog.upskn,function(v)
	tog.upskn=v
end)
Main:addToggle("Rebirth",tog.rebirth,function(v)
	tog.rebirth=v
end)
Main:addToggle("Dungeon",tog.dungeon,function(v)
	tog.dungeon=v
end)
Crates:addDropdown("Type",{"Pet1","Pet2","Pet3","Pet4","Pet5","Pet6","Pet7","Pet8","Artifact1","Artifact2","Artifact3","Artifact4","Artifact5","Artifact6","Artifact7"},4,function(v)
	vals.crateid=tostring(v)
end)
Crates:addToggle("Start",tog.petcrate,function(v)
	tog.petcrate=v
end)
Bosses:addToggle("Start",tog.farmboss,function(v)
	tog.farmboss=v
end)
Bosses:addToggle("Borock",vals.boss.borock,function(v)
	vals.boss.borock=v
end)
Bosses:addToggle("Demon King",vals.boss.demonking,function(v)
	vals.boss.demonking=v
end)
Bosses:addToggle("Robotron",vals.boss.robotron,function(v)
	vals.boss.robotron=v
end)
Bosses:addToggle("Terminator",vals.boss.terminator,function(v)
	vals.boss.terminator=v
end)
Bosses:addToggle("Temple Guardian",vals.boss.templeguard,function(v)
	vals.boss.templeguard=v
end)
Bosses:addToggle("Gnomes",vals.boss.gnomes,function(v)
	vals.boss.gnomes=v
end)
Bosses:addToggle("Penguins",vals.boss.penguins,function(v)
	vals.boss.penguins=v
end)
Misc:addToggle("Ignore notifications",ignore.notifs,function(v)
	ignore.notifs=v
end)
Misc:addToggle("Ignore Arena Notif",ignore.arena,function(v)
	ignore.arena=v
end)
Local:addButton("Rejoin",function()
	plr:Kick" "
	task.wait()
	game:GetService"TeleportService":Teleport(game.placeId,plr)
end)
Local:addToggle("Inf Jump",tog.infj,function(v)
	tog.infj=v
end)
Local:addToggle("tpwalk",tog.tpwalk,function(v)
	tog.tpwalk=v
end)
Local:addSlider("tpwalk speed",0,10,function(v)
	vals.tpws=tonumber(v)
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
	end--press multi sell twice
end)--tombs, weapon upgrade, waypoints, time attack, level threshold for rebirth, quests
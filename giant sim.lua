if game.placeId~=2986677229 then return else repeat wait(1)until game:IsLoaded()and game.Players.LocalPlayer end
local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr.Humanoid
local hrp=chr.HumanoidRootPart
local binds={}
local vacant=true
local orbsP,plrHealth
local plrGui=plr.PlayerGui
local tog={
	swing=true,
	orbs=false,
	meteor=false,
	event=false,
	tpwalk=false,
	farmboss=false,
	petcrate=false,
	skillupgrade=true,
	sellchest=true,
	upwpn=false,
	upskn=false,
	rebirth=false,
	dungeon=false,
	tomb=false,
	quest=false,
	timeattack=false
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
	dungeon=true,
	tomb=true,
	quest=true
}
local vals={
	tpws=nil,
	minlvl=1e5,
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
		blacklist={},
		visited={}
	},
	qnpc={
		hopsalot=false,
		gingerbreadman=false,
		lordent=false,
		samurai=false
	},
	doablequests={
		["Hopsalot10Orbs"]=true,
		["HopsalotDefeatSkeleBoss"]=true,
		["HopsalotArcticSeasonSnowflakes"]=true,
		["HopsalotGetCrates"]=true,
		["HopsalotDefeatRobotron"]=true,
		["HopsalotDefeatTempleBoss"]=true,
		["HopsalotDefeatGnomes"]=true,
		["HopsalotMeteor"]=true,
		["HopsalotDefeatPenguins"]=true,
		["HopsalotDefeatBorock"]=true,
		["HopsalotDefeatEgyptBoss"]=true
	},
	rarity={
		["74"]=0,
		["5"]=1,
		["66"]=2,
		["87"]=3,
		["100"]=4
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
local sknInventory=plrGui.Inventory.Main.InventoryBG.InventoryClipFrame.InventoryMainFrame.SkinInventoryFrame
function parse(a)
	return game.HttpService:JSONDecode(a)
end
function stringify(a)
	return game.HttpService:JSONEncode(a)
end
function pop(tb)
	local n=tb[#tb]
	tb[#tb]=nil
	return n
end
function push(tb,v)
	table.insert(tb,v)
end
function isnumber(s)
	return tonumber(s)~=nil or s=="inf"
end
function noVelocity()
	pcall(function()
		hrp.AssemblyAngularVelocity=Vector3.new(0,0,0)
		hrp.AssemblyLinearVelocity=Vector3.new(0,0,0)
		hrp.Velocity=Vector3.new(0,0,0)
	end)
end
function notif(ti,tx,d)
	if not isnumber(d)then d=1 end
	game.StarterGui:SetCore("SendNotification",{
		Title=ti or"";
		Text=tx or"";
		Duration=tonumber(d)or 1;
	})
end
function esp(v)
	if not v:FindFirstChild"highlight"then
		local a=Instance.new("BoxHandleAdornment",v)
		a.Name="highlight"
		a.Adornee=v
		a.AlwaysOnTop=true
		a.ZIndex=0
		a.Size=v.Size
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
		if not wpnInventory then
			wpnInventory=plrGui.Inventory.Main.InventoryBG.InventoryClipFrame.InventoryMainFrame.WpnInventoryFrame.WpnInvDataFrame.WpnSelectionPanel.WpnSelectionFrame
		end
		local hpbar=game.Players.LocalPlayer.PlayerGui.HUD.LeftHUD.Frame.PortraitFG.StatusBarBG.HealthBG
		plrHealth=math.round(hpbar.HealthBar.AbsoluteSize.x/hpbar.AbsoluteSize.x*100)
		hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
	end)
	if tog.swing and cd.swing then
		cd.swing=false
		swing()
		wait(.01)
		cd.swing=true
	end
	if tog.dungeon then
		if cd.dungeon then
			cd.dungeon=false
			while tostring(plr.TeamColor)~="Sea green"and not workspace.DungeonEntrance.Floor.BillboardGui.Closed.Visible do
				if(hrp.Position-workspace.DungeonEntrance.Darkness.Position).magnitude>5 then
					vals.dungeon.blacklist={}
					vals.dungeon.visited={}
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
			if plrDungeon and plrPos()then
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
					local r={}
					for _,v in pairs(plrDungeon:GetChildren())do
						pcall(function()
							if v.Floor.floor_Plane then
								push(r,v.Floor.floor_Plane)
							end
						end)
					end
					return nearest(r).Parent.Parent
				end
				function getRoomPos()
					return getRoom().Name:gsub("Room:","")
				end
				function labelRoom(xy,c)
					local t=xy:split","
					local cur=getRoomPos():split","
					local we=t[1]-cur[1]
					local sn=t[2]-cur[3]
					if plrGui.DungeonMinimap.MapFrame:FindFirstChild(we..","..sn)then
						local bl=Instance.new"Frame"
						local bc=Instance.new"UICorner"
						bl.Name="Lbl"
						bl.Parent=plrGui.DungeonMinimap.MapFrame[we..","..sn]
						bl.BackgroundColor=BrickColor.new(c)
						bl.Position=UDim2.new(0,0,0,0)
						bl.Size=UDim2.new(0,12,0,12)
						bc.CornerRadius=UDim.new(0,100)
						bc.Name="rounded"
						bc.Parent=bl
					end
				end
				function refresh()
					for _,v in pairs(plrGui.DungeonMinimap.MapFrame:GetDescendants())do
						if v.Name=="Lbl"then
							v:Destroy()
						end
					end
					for i,v in pairs(vals.dungeon.visited)do
						labelRoom(i,"White")
					end
					for i,v in pairs(vals.dungeon.blacklist)do
						labelRoom(i,"Black")
					end
				end
				function blacklistRoom(r)
					local xy=XYZtoXY(r:gsub("Room:",""))
					vals.dungeon.blacklist[xy]=true
					refresh()
				end
				function isRoomBlacklisted(r)--xy
					return vals.dungeon.blacklist[XYZtoXY(r)]
				end
				function visitedRoom(xyz)
					return plrDungeon:FindFirstChild("Room:"..xyz)and vals.dungeon.visited[XYZtoXY(xyz)]
				end
				function gotoRoom(xyz)
					local c=plrDungeon:FindFirstChild("Room:"..xyz).Floor.floor_Plane.CFrame
					hrp.CFrame=CFrame.new(c.x,c.y+10,c.z)
					wait()
					hrp.CFrame=CFrame.new(c.x,c.y+10,c.z)
					vals.dungeon.visited[XYZtoXY(xyz)]=true
					refresh()
				end
				function roomsLeft()
					local n=0
					for _,v in pairs(plrGui.DungeonMinimap.MapFrame:GetChildren())do
						pcall(function()
							if tostring(v.BackgroundColor)=="Silver flip/flop"then
								n=n+1
							end
						end)
					end
					return n
				end
				function checkPath(xy)
					return plrGui.DungeonMinimap.MapFrame:FindFirstChild(xy)and plrGui.DungeonMinimap.MapFrame:FindFirstChild(xy).Visible
				end
				function getPaths(ignvs)
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
						if checkPath(hf)and not visitedRoom(ar)and not isRoomBlacklisted(ar)then
							push(fp,ps[i])
						end
					end
					if ignvs then
						for i=1,#ps do
							local sp=ps[i]:split","
							local hf=(sp[1]/2)..","..(sp[2]/2)
							local ar=(tonumber(sp[1])+p.x)..","..p.y..","..(tonumber(sp[2])+p.z)
							if not isRoomBlacklisted(ar)then
								push(fp,ps[i])
							end
						end
					end
					return fp
				end
				function choosePath()
					local paths=getPaths()
					local p=plrPos()--fix picking visited room over new room
					for i=1,#paths do
						local sp=paths[i]:split","
						local ar=(tonumber(sp[1])+p.x)..","..p.y..","..(tonumber(sp[2])+p.z)
						if not visitedRoom(ar)and not isRoomBlacklisted(ar)then
							return paths[i]
						end
					end
					for i=1,#paths do
						local sp=paths[i]:split","
						local ar=(tonumber(sp[1])+p.x)..","..p.y..","..(tonumber(sp[2])+p.z)
						if not isRoomBlacklisted(ar)then
							notif"meh path"
							return paths[i]
						end
					end
					notif"hopeless"
					return paths[math.random(1,#paths)]
				end
				function getRoot(i)
					for _,v in pairs(i:GetDescendants())do
						if v.Name==hrp.Name then
							return v
						end
					end
				end
				function getPart(i)
					for _,v in pairs(i:GetDescendants())do
						if v:IsA"BasePart"then
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
				local paths=getPaths()
				local pc=#paths
				local prc=true
				if pc>0 then
					if XYZtoXY(strPos())=="0,0"then
						if pc<2 then
							blacklistRoom(getRoom().Name)
						end
						gotoRoom(strPos())
					end
					local cd=choosePath()
					local oldRoom=getRoom().Name
					local chosenDoor=getRoom().Doors[direction(cd)]
					repeat
						hum.WalkToPoint=chosenDoor.Position
						wait(.1)
					until(chosenDoor.Position-hrp.Position).magnitude<10 or tostring(plr.TeamColor)~="Sea green"or getRoom().Name~=oldRoom
					repeat wait(.1)until getRoom().Name~=oldRoom or tostring(plr.TeamColor)~="Sea green"
					wait(.25)
					gotoRoom(getRoom().Name:gsub("Room:",""))
					if getRoom().Doors:FindFirstChild"Down"then
						prc=false
						local fl=plrPos().y
						wait(.1)
						hrp.CFrame=getPart(getRoom().Doors.Down).CFrame+Vector3.new(0,7,0)
						repeat wait()until plrGui.NotificationsV2.Dialogs:FindFirstChild"Dialog"or tostring(plr.TeamColor)~="Sea green"or plrPos().y>fl
						pcall(function()
							press(plrGui.NotificationsV2.Dialogs.Dialog.Frame.Buttons.Okay)
						end)
						repeat wait()until plrPos().y>fl or tostring(plr.TeamColor)~="Sea green"
						vals.dungeon.blacklist={}
						vals.dungeon.visited={}
						for _,v in pairs(plrGui.DungeonMinimap.MapFrame:GetDescendants())do
							if v.Name=="Lbl"then
								v:Destroy()
							end
						end
					end
					if prc then
						repeat wait()until getRoom()and(getRoom():FindFirstChild"Enemies"or getRoom():FindFirstChild"Chest")or tostring(plr.TeamColor)~="Sea green"or XYZtoXY(strPos())=="0,0"
						wait(.25)
						if getRoom():FindFirstChild"Enemies"and#getRoom().Enemies:GetChildren()>0 then
							while getRoom():FindFirstChild"Enemies"and#getRoom().Enemies:GetChildren()>0 do
								pcall(function()
									local enems=getRoom().Enemies:GetChildren()
									if not tog.swing then
										swing()
									end
									local ec=getRoot(enems[#enems])
									if(hrp.Position-Vector3.new(ec.Position.x,hrp.CFrame.y,ec.Position.z)).magnitude>1 then
										chr:TranslateBy((Vector3.new(ec.Position.x,hrp.CFrame.y,ec.Position.z)-hrp.Position)*.25)
										wait()
										hrp.CFrame=CFrame.lookAt(hrp.Position,Vector3.new(ec.Position.x,hrp.CFrame.y,ec.Position.z))
									end
									hrp.CFrame=
									noVelocity()
								end)
								task.wait()
							end
							wait(.15)
							repeat wait(.25)until canMove()or tostring(plr.TeamColor)~="Sea green"
							gotoRoom(getRoom().Name:gsub("Room:",""))
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
						end
					end
				else
					blacklistRoom(getRoom().Name)
					local pts=getPaths(true)
					local p=#pts
					local cd=pts[math.random(1,p)]
					local oldRoom=getRoom().Name
					local chosenDoor=getRoom().Doors[direction(cd)]
					repeat
						hum.WalkToPoint=chosenDoor.Position
						wait(.1)
					until(chosenDoor.Position-hrp.Position).magnitude<10 or tostring(plr.TeamColor)~="Sea green"or getRoom().Name~=oldRoom
					repeat wait(.1)until getRoom().Name~=oldRoom or tostring(plr.TeamColor)~="Sea green"
					wait(.25)
					gotoRoom(strPos())
				end
			end
			wait(.5)
			cd.dungeon=true
		end
	elseif tog.tomb and plrGui.EgyptTombBoard.Frame.Title.Text=="Open Tombs:"then
		if cd.tomb then
			cd.tomb=false
			local selected=nil
			for _,v in pairs(workspace.Scene.Egypt.Egypt.Tomb.TombEntrances:GetChildren())do
				if v:FindFirstChild"Door"and v.Door.Surface.SurfaceGui.Frame.Timer.Text=="OPEN"then
					selected=v.Name
					break
				end
			end
			if selected then
				repeat
					hrp.CFrame=Workspace.Scene.Egypt.Egypt.Tomb.TombEntrances[selected].DoorEntry.Trigger.CFrame
					wait(1)
				until not((hrp.Position-Vector3.new(14458,-117,-539)).magnitude>250 and plrGui.EgyptTombBoard.Frame.Title.Text=="Open Tombs:")
				local mp={["Easy"]="TombBoss",["Medium"]="TombBoss2",["Hard"]="TombBoss3"}
				local i=0
				while tog.tomb and workspace.Scene.Egypt.Egypt.Tomb.Bosses:FindFirstChild(mp[selected])do
					if not tog.swing then
						swing()
					end
					local off=0
					if plrHealth<60 then
						i=i+1
						off=50*(-1)^math.floor(i/3)
					else
						i=0
						off=0
					end
					hrp.CFrame=workspace.Scene.Egypt.Egypt.Tomb.Bosses[mp[selected]].HumanoidRootPart.CFrame+Vector3.new(0,0,off)
					noVelocity()
					task.wait()
				end
				repeat wait()until(hrp.Position-Vector3.new(14476,-34,-2234)).magnitude<3 or not tog.tomb
			end
			wait(3)
			cd.tomb=true
		end
	elseif tog.quest and cd.quest then
		cd.quest=false
		if vals.qnpc.hopsalot then
			local hq=false
			while not hq do
				for _,v in pairs(vals.doablequests)do
					if plr.Quests.InProgress:FindFirstChild(_)then
						hq=true
						break
					end
				end
				hrp.CFrame=workspace["Sir Hopsalot"].HumanoidRootPart.CFrame
				task.wait(.1)
				fireproximityprompt(workspace["Sir Hopsalot"].HumanoidRootPart.QuestPromptObject.NewQuestPrompt)
				pcall(function()
					press(plrGui.NotificationsV2.Dialogs.Conversation.Frame.Buttons.Okay)
					task.wait(.1)
					press(plrGui.NotificationsV2.Dialogs.Conversation.ClickBackground)
				end)
			end
			wait(.15)
			local cq=nil
			for _,v in pairs(plr.Quests.InProgress:GetChildren())do
				if vals.doablequests[v.Name]then
					cq=v.Name
				end
			end
			function ongoing(qn)
				return plr.Quests.InProgress:FindFirstChild(qn)
			end
			local npcs=workspace.NPC
			function getst(n)
				return npcs[n]:FindFirstChild(n)and findDescendant(npcs[n],"Health","TextLabel")and tonumber(findDescendant(npcs[n],"Health","TextLabel").Text)>0
			end
			function farmboss(n)
				if getst(n)then
					pcall(function()
						local boss=npcs[n][n]:FindFirstChild"HumanoidRootPart"
						local pcf=hrp.CFrame
						local bcf=boss.CFrame
						hrp.CFrame=(bcf-Vector3.new(0,bcf.y-pcf.y,0))*CFrame.new(0,0,1)
						if(hrp.Position-boss.Position).magnitude>30 then
							hrp.CFrame=bcf
							noVelocity()
						end
					end)
				end
			end
			if cq then
				if cq=="HopsalotDefeatRobotron"then
					farmboss"SlumBoss"
					wait(.1)
					for i=0,3 do
						hrp.CFrame=hrp.CFrame*CFrame.new(7,0,0)
						pcall(function()
							press(plrGui.NotificationsV2.Dialogs.Conversation.Frame.Buttons.Okay)
							press(plrGui.NotificationsV2.Dialogs.Conversation.ClickBackground)
						end)
						wait(.1)
					end
				end
				while ongoing(cq)do
					pcall(function()
						press(plrGui.NotificationsV2.Dialogs.Conversation.Frame.Buttons.Okay)
						press(plrGui.NotificationsV2.Dialogs.Conversation.ClickBackground)
					end)
					if cq=="Hopsalot10Orbs"then
						for _,v in pairs(orbsP:GetChildren())do
							local pr=v:FindFirstChild"Prefab"
							if pr and ongoing(cq)then
								hrp.CFrame=v.CFrame
								break
							end
						end
					elseif cq=="HopsalotMeteor"then
						local meteor=workspace.Meteors:FindFirstChild"Meteor"
						if meteor and(hrp.Position-meteor.Position).magnitude>20 and meteor.Health.value>0 then
							hrp.CFrame=meteor.CFrame
							wait(.25)
						end
					elseif cq=="HopsalotGetCrates"then
						for _,v in pairs(plrGui.Inventory.Main.InventoryBG.InventoryClipFrame.InventoryMainFrame.ChestInventoryFrame.ChestSelectionPanel.ChestSelectionFrame:GetChildren())do
							if ongoing(cq)and v.Name=="ChestInventoryItem"and tonumber(v.ChestImage.AmountImg.AmountTxt.Text)>0 then
								press(v)
								wait()
								press(plrGui.Inventory.Main.InventoryBG.InventoryClipFrame.InventoryMainFrame.ChestInventoryFrame.BuyFrame.BuyButton)
								wait()
								press(plrGui.Inventory.Main.InventoryBG.InventoryClipFrame.InventoryMainFrame.ChestInventoryFrame.ChestInspectionFrame.OpenChestButton)
							end
						end
						for _,v in pairs(sknInventory.SkinInvDataFrame.SkinSelectionPanel.SkinSelectionFrame:GetChildren())do
							pcall(function()
								if ongoing(cq)and vals.rarity[tostring(math.floor(v.TierBG.ImageColor3.r*100))]<3 then
									press(v.SelectionButton,true)
									wait(.05)
									press(sknInventory.ButtonFrame.SUFrame.SellButton)
									wait(.1)
									press(plrGui.HUD.Screen.SellPrompt.ImageLabel.SellBtn)
									wait(.05)
								end
							end)
						end
					elseif cq=="HopsalotArcticSeasonSnowflakes"then
						local trg={}
						for _,v in pairs(workspace.Ephemeral.AdvCrate:GetChildren())do
							local pr=v.TechBox
							if pr.SnowMan.Transparency==0 and ongoing(cq)and(hrp.Position-pr.Position).magnitude>4 then
								hrp.CFrame=pr.CFrame*CFrame.new(0,0,2)
								wait(.15)
								break
							end
						end
					elseif cq=="HopsalotDefeatBorock"then
						if npcs.Boss:FindFirstChild"Borock"and plrGui.BossBoard.Frame.BossHealthFrame.Health.Text~="0"then
							local boss=npcs.Boss.Borock:FindFirstChild"HumanoidRootPart"
							local bcf=boss.CFrame
							hrp.CFrame=(bcf-Vector3.new(0,bcf.y-hrp.CFrame.y,0))*CFrame.new(0,0,1)
							if(hrp.Position-boss.Position).magnitude>30 then
								hrp.CFrame=bcf
								noVelocity()
							end
						end
					elseif cq=="HopsalotDefeatRobotron"then
						farmboss"SlumBoss"
					elseif cq=="HopsalotDefeatTempleBoss"then
						farmboss"DemonKing"
					elseif cq=="HopsalotDefeatSkeleBoss"then
						farmboss"SkeleBoss"
					elseif cq=="HopsalotDefeatEgyptBoss"then
						farmboss"EgyptBoss"
					elseif cq=="HopsalotDefeatGnomes"then
						local gnomes=npcs.Gnomes:GetChildren()
						if#gnomes>0 then
							pcall(function()
								local boss=gnomes[#gnomes].HumanoidRootPart
								local bcf=boss.CFrame
								hrp.CFrame=(bcf-Vector3.new(0,bcf.y-hrp.CFrame.y,0))*CFrame.new(0,0,math.random(-15,1))
								if(hrp.Position-boss.Position).magnitude>15 then
									hrp.CFrame=bcf*CFrame.new(0,0,math.random(-15,1))
									noVelocity()
								end
							end)
						end
					elseif cq=="HopsalotDefeatPenguins"then
						local penguins=npcs.Penguins:GetChildren()
						if#penguins>0 then
							pcall(function()
								local boss=penguins[#penguins].HumanoidRootPart
								local pcf=hrp.CFrame
								local bcf=boss.CFrame
								hrp.CFrame=(bcf-Vector3.new(0,bcf.y-pcf.y,0))*CFrame.new(0,0,math.random(-15,1))
								if(hrp.Position-boss.Position).magnitude>15 then
									hrp.CFrame=bcf*CFrame.new(0,0,math.random(-15,1))
									noVelocity()
								end
							end)
						end
					end
					wait(.1)
				end
			end
		end
		wait(1)
		cd.quest=true
	else
		if tog.orbs and cd.orbs and vacant then
			vacant=false
			cd.orbs=false
			for _,v in pairs(orbsP:GetChildren())do
				if v:FindFirstChild"Prefab"then
					hrp.CFrame=v.CFrame
					break
				end
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
			wait(.5)
			vacant=true
			cd.meteor=true
		end
		if tog.event and cd.event and vacant then
			vacant=false
			cd.event=false
			for _,v in pairs(workspace.Ephemeral.AdvCrate:GetChildren())do
				local pr=v.TechBox
				vacant=false
				if pr.SnowMan.Transparency==0 then
					if(hrp.Position-pr.Position).magnitude>3 then
						hrp.CFrame=pr.CFrame*CFrame.new(0,0,1.5)
						break
					end
				end
			end
			wait(.2)
			vacant=true
			cd.event=true
		end
		if tog.farmboss and vacant then
			vacant=false
			local boss=getboss()
			local bossold=boss
			while boss==bossold and boss~=nil and tog.farmboss do
				local inc=2
				local bcf=boss.CFrame
				if boss.Parent.Name=="Gnome"or boss.Parent.Name=="Penguin"then inc=-10 end
				hrp.CFrame=(bcf-Vector3.new(0,bcf.y-hrp.CFrame.y,0))*CFrame.new(0,0,math.random(inc,2))
				if(hrp.Position-boss.Position).magnitude>25 then
					hrp.CFrame=bcf
					noVelocity()
				end
				vacant=false
				wait(.025)
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
		wait()
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
		task.spawn(function()
			for _,v in pairs(plrGui.Inventory.Main.InventoryBG.InventoryClipFrame.InventoryMainFrame.ChestInventoryFrame.ChestSelectionPanel.ChestSelectionFrame:GetChildren())do
				if v.Name=="ChestInventoryItem"and tonumber(v.ChestImage.AmountImg.AmountTxt.Text)>0 then
					press(v)
					wait(.25)
					press(plrGui.Inventory.Main.InventoryBG.InventoryClipFrame.InventoryMainFrame.ChestInventoryFrame.SellFrame.SellButton)
					plrGui.HUD.Screen.SellPrompt.Visible=false
					wait()
					press(plrGui.HUD.Screen.SellPrompt.ImageLabel.SellBtn)
				end
			end
		end)
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
		pcall(function()
			if tog.upwpn then
				press(vals.weapons.main.SelectionButton,true)
				press(plrGui.Inventory.Main.InventoryBG.InventoryClipFrame.InventoryMainFrame.WpnInventoryFrame.ButtonFrame.SUFrame.MaxButton)
				plrGui.HUD.Screen.ConfirmPrompt.Visible=false
				press(plrGui.HUD.Screen.ConfirmPrompt.ImageLabel.ConfirmBtn)
				wait(.2)
				press(vals.weapons.offh.SelectionButton,true)
				press(plrGui.Inventory.Main.InventoryBG.InventoryClipFrame.InventoryMainFrame.WpnInventoryFrame.ButtonFrame.SUFrame.MaxButton)
				plrGui.HUD.Screen.ConfirmPrompt.Visible=false
			end
			press(plrGui.HUD.Screen.ConfirmPrompt.ImageLabel.ConfirmBtn)
			wait(.2)
			if tog.upskn then
				press(sknInventory.ButtonFrame.SUFrame.MaxButton)
				plrGui.HUD.Screen.ConfirmPrompt.Visible=false
			end
			press(plrGui.HUD.Screen.ConfirmPrompt.ImageLabel.ConfirmBtn)
		end)
		wait(.2)
		cd.upgd=true
	end
	if tog.rebirth and cd.rebirth then
		cd.rebirth=false
		if isnumber(vals.minlvl)and(plr.leaderstats["⚡Level"].value>=vals.minlvl or vals.minlvl==100)then
			press(plrGui.RebirthGui.RebirthPrompt.ImageLabel.ConfirmBtn)
		end
		pcall(function()
			press(wpnInventory.demon_ice.SelectionButton,true)
			press(plrGui.Inventory.Main.InventoryBG.InventoryClipFrame.InventoryMainFrame.WpnInventoryFrame.ButtonFrame.EquipButton)
			press(plrGui.Inventory.Main.InventoryBG.InventoryClipFrame.InventoryMainFrame.WpnInventoryFrame.ButtonFrame.SUFrame.MaxButton)
			wait()
			press(plrGui.HUD.Screen.ConfirmPrompt.ImageLabel.ConfirmBtn)
		end)
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
local UI=GUI:CreateWindow("Giant","v0.83")
local Main=UI:addPage("Main",3,true,1)
local Rebirths=UI:addPage("Rebirthing",3,false,1)
local Crates=UI:addPage("Crates",3,false,1)
local Enemies=UI:addPage("Enemies",3,false,1)
local Quests=UI:addPage("Quests",3,false,1)
local Misc=UI:addPage("Miscellaneous",3,false,1)
local Local=UI:addPage("Local Player",3,false,1)
Main:addToggle("Auto Swing",tog.swing,function(v)
	tog.swing=v
end)
Main:addToggle("Weapon Upgrade",tog.upwpn,function(v)
	tog.upwpn=v
end)
Main:addToggle("Skin Upgrade",tog.upskn,function(v)
	tog.upskn=v
end)
Main:addToggle("Collect Orbs",tog.orbs,function(v)
	tog.orbs=v
end)
Main:addToggle("Sell Chests",tog.sellchest,function(v)
	tog.sellchest=v
end)
Main:addToggle("Mine Meteor",tog.meteor,function(v)
	tog.meteor=v
end)
Main:addToggle("Farm Snowmen",tog.event,function(v)
	tog.event=v
end)
Rebirths:addTextBox("Minimum Level",vals.minlvl,function(v)
	if type(tonumber(v))=="number"and tonumber(v)>=100 then
		vals.minlvl=tonumber(v)
	end
end)
Rebirths:addToggle("Rebirth",tog.rebirth,function(v)
	tog.rebirth=v
end)
Rebirths:addToggle("Skill Upgrade",tog.skillupgrade,function(v)
	tog.skillupgrade=v
end)
Crates:addDropdown("Type",{"Pet1","Pet2","Pet3","Pet4","Pet5","Pet6","Pet7","Pet8","Artifact1","Artifact2","Artifact3","Artifact4","Artifact5","Artifact6","Artifact7"},4,function(v)
	vals.crateid=tostring(v)
end)
Crates:addToggle("Start",tog.petcrate,function(v)
	tog.petcrate=v
end)
Enemies:addToggle("Tombs",tog.tomb,function(v)
	tog.tomb=v
end)
Enemies:addToggle("Dungeon",tog.dungeon,function(v)
	tog.dungeon=v
end)
Enemies:addLabel()
Enemies:addToggle("Start NPC Farm",tog.farmboss,function(v)
	tog.farmboss=v
end)
Enemies:addToggle("Borock",vals.boss.borock,function(v)
	vals.boss.borock=v
end)
Enemies:addToggle("Demon King",vals.boss.demonking,function(v)
	vals.boss.demonking=v
end)
Enemies:addToggle("Robotron",vals.boss.robotron,function(v)
	vals.boss.robotron=v
end)
Enemies:addToggle("Terminator",vals.boss.terminator,function(v)
	vals.boss.terminator=v
end)
Enemies:addToggle("Temple Guardian",vals.boss.templeguard,function(v)
	vals.boss.templeguard=v
end)
Enemies:addToggle("Gnomes",vals.boss.gnomes,function(v)
	vals.boss.gnomes=v
end)
Enemies:addToggle("Penguins",vals.boss.penguins,function(v)
	vals.boss.penguins=v
end)
Quests:addToggle("Sir Hopsalot",vals.qnpc.hopsalot,function(v)
	vals.qnpc.hopsalot=v
	tog.quest=vals.qnpc.hopsalot or vals.qnpc.gingerbreadman or vals.qnpc.lordent or vals.qnpc.samurai
end)
Quests:addToggle("Lord Ent",vals.qnpc.lordent,function(v)
	vals.qnpc.lordent=v
	tog.quest=vals.qnpc.hopsalot or vals.qnpc.gingerbreadman or vals.qnpc.lordent or vals.qnpc.samurai
end)
Quests:addToggle("Gingerbread Man",vals.qnpc.gingerbreadman,function(v)
	vals.qnpc.gingerbreadman=v
	tog.quest=vals.qnpc.hopsalot or vals.qnpc.gingerbreadman or vals.qnpc.lordent or vals.qnpc.samurai
end)
Quests:addToggle("Samurai",vals.qnpc.samurai,function(v)
	vals.qnpc.samurai=v
	tog.quest=vals.qnpc.hopsalot or vals.qnpc.gingerbreadman or vals.qnpc.lordent or vals.qnpc.samurai
end)
Misc:addToggle("Ignore notifications",ignore.notifs,function(v)
	ignore.notifs=v
end)
Misc:addToggle("Ignore Arena Notif",ignore.arena,function(v)
	ignore.arena=v
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
Local:addLabel()
Local:addButton("Rejoin",function()
	plr:Kick" "
	task.wait()
	game:GetService"TeleportService":Teleport(game.placeId,plr)
end)
Local:destroyGui(function()
	for _,v in pairs(binds)do v:Disconnect()end
	for i,v in pairs(tog)do tog[i]=false end
	for i,v in pairs(cd)do cd[i]=false end--p=game.Players.LocalPlayer.PlayerGui.HUD.LeftHUD.Frame.PortraitFG.StatusBarBG.HealthBG.HealthBar
end)--quests, waypoints, time attack, arena farming
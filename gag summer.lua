local plr=game.Players.LocalPlayer
local tog={
	harvest=false,
	submit=true,
	trade=false
}
local plants={
	["Tomato"]=true,
	["Green Apple"]=true,
	["Avocado"]=true,
	["Banana"]=true,
	["Pineapple"]=true,
	["Kiwi"]=true,
	["Bell Pepper"]=true,
	["Prickly Pear"]=true,
	["Loquat"]=true,
	["Feijoa"]=true,
	["Sugar Apple"]=true
}
local cd={
	harvest=true,
	submit=true,
	trade=true,
	o1=true
}
local trading={t="",f=""}
local GE=game.ReplicatedStorage.GameEvents
local binds,plrs={},{}
local UserFarm,dd
for _,v in pairs(workspace.Farm:GetChildren())do
	if v.Important.Data.Owner.Value==plr.Name then
		UserFarm=v
	else
		v:Destroy()
	end
end
function cleanG()
	for _,v in pairs(UserFarm.Important.Plants_Physical:GetChildren())do
		for _,c in pairs(v:GetChildren())do
			if c:IsA"Model"or c:IsA"BasePart"or c:IsA"MeshPart"then
				c:Destroy()
			end
		end
	end
end
cleanG()
for _,v in pairs(game.Players:GetPlayers())do
	if v~=plr then
		table.insert(plrs,v.Name)
	end
end
if plr.PlayerGui:FindFirstChild"Top_Notification"then
	plr.PlayerGui.Top_Notification:Destroy()
end
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/gui%20lib.lua")()
local UI=GUI:CreateWindow("Summer Harvest","v1.2")
binds.main=game:GetService"RunService".RenderStepped:Connect(function()
	if tog.submit and cd.submit then
		cd.submit=false
		local t=os.date"*t"
		local m,s=t["min"],t["sec"]
		if m==0 and s>2 or m>0 and m<10 then
			GE.SummerHarvestRemoteEvent:FireServer"SubmitAllPlants"
		end
		task.wait(.1)
		cd.submit=true
	end
	if tog.harvest and cd.harvest then
		cd.harvest=false
		for _,p in pairs(UserFarm.Important.Plants_Physical:GetChildren())do
			if plants[p.Name]and#p.Fruits:GetChildren()>0 then
				for _,v in pairs(p.Fruits:GetDescendants())do
					if v:IsA"ProximityPrompt"and tog.harvest and v.Enabled then
						fireproximityprompt(v)
					end
				end
				task.wait()
			end
		end
		task.wait(.125)
		cd.harvest=true
	end
	if tog.trade and cd.trade then
		cd.trade=false
		pcall(function()
			local h1=workspace[trading.t].HumanoidRootPart
			local c=plr.Character
			local f=nil
			for _,v in pairs(plr.Backpack:GetChildren())do
				local n=v.Name:lower()
				if not n:find"seed"and n:find(trading.f)then
					f=v
					break
				end
			end
			if f then
				local held=c:FindFirstChildOfClass"Tool"
				if held then
					held.Parent=plr.Backpack
				end
				f.Parent=c
				h1:FindFirstChildOfClass"ProximityPrompt".HoldDuration=0
				task.wait(1)
			end
		end)
		cd.trade=true
	end
	if cd.o1 then
		cd.o1=false
		GE.BuyEventShopStock:FireServer"Summer Seed Pack"
		GE.BuyEventShopStock:FireServer"Oasis Egg"
		for i=1,3 do
			GE.BuyPetEgg:FireServer(i)
		end
		task.wait(5)
		cd.o1=true
	end
end)
binds.plrs=game.Players.PlayerAdded:Connect(function(v)
	plrs={}
	for _,p in pairs(game.Players:GetPlayers())do
		if p~=plr then
			table.insert(plrs,p.Name)
		end
	end
	dd.setList(plrs)
end)
binds.plrslv=game.Players.PlayerRemoving:Connect(function(v)
	task.wait(.1)
	plrs={}
	for _,p in pairs(game.Players:GetPlayers())do
		if p~=plr then
			table.insert(plrs,p.Name)
		end
	end
	dd.setList(plrs)
end)
local Main=UI:addPage("Main",1,true)
local Trade=UI:addPage("Trading",1)
Main.addToggle("Harvest",tog.harvest,function(v)
	tog.harvest=v
end)
Main.addToggle("Submit Fruits",tog.submit,function(v)
	tog.submit=v
end)
Main.addButton("Hide Plants",cleanG)
Main.destroyGui(function()
	for i,v in pairs(tog)do tog[i]=false end
	for _,v in pairs(binds)do v:Disconnect()end
end)
Trade.addToggle("Trade Player",tog.trade,function(v)
	tog.trade=v
end)
dd=Trade.addDropdown("Target Player",plrs,nil,function(v)
	trading.t=v
end)
Trade.addTextBox("Fruit","",function(v)
	trading.f=v:lower()
end)
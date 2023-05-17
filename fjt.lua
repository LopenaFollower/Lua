local t=game:GetService"Teams"
local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
local hrp=chr.HumanoidRootPart
local my={
	team=nil,
	money=0,
	tycoon=nil,
}
local tog={
	fruit=false,
	obby=false,
	button=false,
	dollar=false,
	prestige=false,
}
local cd={
	fruit=true,
	obby=true,
	button=true,
	prestige=true,
}
function notif(title,text,delay)
	game.StarterGui:SetCore("SendNotification",{
		Title=title or"",
		Text=text or"",
		Duration=delay or 1
	})
end
for _,i in pairs(workspace.Tycoons:GetChildren())do
	if i.Owner.value==nil and i.Essentials and tostring(plr.TeamColor)=="White"then
		hrp.CFrame=i.Essentials.Entrance.CFrame
		wait(.5)
		hum:ChangeState"Jumping"
	end
end
wait(1)
for _,v in pairs(t:GetChildren())do
	if plr.TeamColor==v.TeamColor then
		my.team=v.Name
		my.tycoon=workspace.Tycoons[v.Name]
	end
end
notif("Team: "..my.team,"")
function getFruit()
	for _,v in pairs(my.tycoon.Drops:GetChildren())do
		if v.Name~="JuiceBottle"then
			game:GetService"ReplicatedStorage".CollectFruit:FireServer(v)
		end
	end
end
game:GetService"RunService".RenderStepped:Connect(function()
	pcall(function()
		t=game:GetService"Teams"
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
		hrp=chr.HumanoidRootPart
		my.money=plr.leaderstats.Money.value
		my.tycoon=workspace.Tycoons[my.team]
	end)
	if tog.fruit and cd.fruit and not my.tycoon.Purchased:FindFirstChild"Auto Collector"then
		cd.fruit=false
		if #my.tycoon.Drops:GetChildren()>=10 then
			if workspace[plr.Name]:FindFirstChild"Pick Fruit"then
				getFruit()
				wait()
				workspace[plr.Name]:FindFirstChild"Pick Fruit".Parent=plr.Backpack
			else
				plr.Backpack:FindFirstChild"Pick Fruit".Parent=workspace[plr.Name]
				getFruit()
				wait()
				workspace[plr.Name]:FindFirstChild"Pick Fruit".Parent=plr.Backpack
			end
		end
		wait(.5)
		cd.fruit=true
	end
	if tog.button and cd.button then
		cd.button=false
		local parent_folder=nil
		pcall(function()
			if #my.tycoon.Buttons.FirstFloorButtons:GetChildren()>0 then
				parent_folder=my.tycoon.Buttons.FirstFloorButtons
			elseif #my.tycoon.Buttons.SecondFloorButtons:GetChildren()>1 then
				parent_folder=my.tycoon.Buttons.SecondFloorButtons
			else
				parent_folder=my.tycoon.Buttons.RoberryButtons
			end
		end)
		for _,v in pairs(parent_folder:GetChildren())do
			pcall(function()
				if v.ButtonLabel.CostLabel.Text:lower():find"free"then
					hrp.CFrame=v.CFrame
					return
				end
				local price=v.ButtonLabel.CostLabel.Text:gsub("%$","")
				price=string.gsub(price,"%,","")
				if my.money>=tonumber(price)then
					hrp.CFrame=v.CFrame
				end
			end)
		end
		for _,v in pairs(my.tycoon.Buttons:GetChildren())do
			pcall(function()
				if v:IsA"BasePart"and(v.Name:lower():find"autocollect"or v.Name:lower():find"floor"or v.Name:lower():find"juicespeed"or v.Name:lower():find"prestige")then
					local price=v.ButtonLabel.CostLabel.Text:gsub("%$","")
					price=string.gsub(price,"%,","")
					if my.money>=tonumber(price)then
						hrp.CFrame=v.CFrame
					end
				end
			end)
		end
		wait(.4)
		cd.button=true
	end
	if tostring(workspace.ObbyParts.ObbyStartPart.BrickColor)=="Lime green"and cd.obby and tog.obby then
		cd.obby=false
		hrp.CFrame=workspace.ObbyParts.ObbyStartPart.CFrame
		wait(.3)
		hrp.CFrame=workspace.ObbyParts.Stages.Hard.VictoryPart.CFrame+Vector3.new(0,7.5,0)
		wait(.9)
		cd.obby=true
		if workspace[plr.Name]:FindFirstChild"Pick Fruit"then
			workspace[plr.Name]:FindFirstChild"Pick Fruit".Parent=plr.Backpack
		else
			plr.Backpack:FindFirstChild"Pick Fruit".Parent=workspace[plr.Name]
			wait()
			workspace[plr.Name]:FindFirstChild"Pick Fruit".Parent=plr.Backpack
		end
		hrp.CFrame=my.tycoon.Essentials.JuiceMaker.AddFruitButton.CFrame
		wait(.5)
		fireproximityprompt(my.tycoon.Essentials.JuiceMaker.AddFruitButton.PromptAttachment.AddPrompt)
	end
	if tog.prestige and cd.prestige then
		cd.prestige=false
		game:GetService"ReplicatedStorage".RequestPrestige:FireServer()
		wait(1)
		cd.prestige=true
	end
	if tog.dollar then
		hrp.CFrame=workspace.ObbyParts.Stages.Hard.VictoryPart.CFrame+Vector3.new(0,3.7,0)
	end
end)
wait(1)
my.tycoon.Drops.ChildAdded:Connect(function(v)
	if v.Name~="JuiceBottle"then
		wait(.1)
		v.CFrame=my.tycoon.Essentials.FruitHolder.HolderBottom.CFrame+Vector3.new(0,2,0)
	end
end)
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/not%20my%20gui%20lib.lua")()
local UI=GUI:CreateWindow("FJT","...")
local Main=UI:addPage("Main",30,true,1)
Main:addToggle("Fruits",function(v)
	tog.fruit=v
end)
Main:addToggle("Buttons",function(v)
	tog.button=v
end)
Main:addToggle("Obby",function(v)
	tog.obby=v
end)
Main:addToggle("Prestige",function(v)
	tog.prestige=v
end)
Main:addToggle("1 Dollar",function(v)
	tog.dollar=v
end)
loadstring(game:HttpGetAsync"https://raw.githubusercontent.com/LopenaFollower/Lua/main/anti%20afk.lua")()
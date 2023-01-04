game.Players.LocalPlayer.DevCameraOcclusionMode=Enum.DevCameraOcclusionMode.Invisicam
--VARIABLES & FUNCTIONS
local chr=game.Players.LocalPlayer.Character
local hum=chr and chr:FindFirstChildWhichIsA("Humanoid")
local hrp=chr.HumanoidRootPart
local toggles={
	farming=false,
	tpw=false
}
local selected={
	field=false,
	jp=hum.JumpPower,
	ws=hum.WalkSpeed,
	tpws=1
}
for _,v in pairs(workspace.Collectibles:GetChildren())do
	v:Destroy()
end
local function goto(part_pos,speed)
	while(part_pos-hrp.Position).magnitude>=2 and wait()and part_pos do
		chr:TranslateBy((part_pos-hrp.Position)*(speed or 0.95))
	end
end
game:GetService("RunService").RenderStepped:Connect(function()
	chr=game.Players.LocalPlayer.Character
	hum=chr and chr:FindFirstChildWhichIsA("Humanoid")
	hrp=chr.HumanoidRootPart
	hum.JumpPower=selected.jp
	hum.WalkSpeed=selected.ws
    for _,v in pairs(workspace.Collectibles:GetChildren())do
		pcall(function()
			if tostring(v) == tostring(game.Players.LocalPlayer.Name) or tostring(v) == "C" then
				v.Name=v:FindFirstChild"FrontDecal".Texture
				v.Name=v:FindFirstChild"BackDecal".Texture
			end
		end)
    	if toggles.farming and cd then
			cd=false
			if (v.Position-hrp.Position).magnitude <= 80 and v.Name:find"1629547638"then
             	game:GetService("TweenService"):Create(hrp, TweenInfo.new(0.0001, Enum.EasingStyle.Linear), {CFrame = CFrame.new(v.Position.x, hrp.Position.y, v.Position.z)}):Play()
 				wait(.1)
			elseif (v.Position-hrp.Position).magnitude <= 80 then
				game:GetService("TweenService"):Create(hrp, TweenInfo.new(0.0001, Enum.EasingStyle.Linear), {CFrame = CFrame.new(v.Position.x, hrp.Position.y, v.Position.z)}):Play()
 				wait(.1)
				print("norm")
			else
				hrp.CFrame = workspace.FlowerZones[selected.field].CFrame * CFrame.new(math.random(10),0,math.random(10))
			end
			for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
      			if v:IsA("Tool") then
            		v.ClickEvent:FireServer()
     			end
            end
			wait()
			cd=true
		end
	end
	if toggles.tpw and chr and hum then
		if hum.MoveDirection.Magnitude > 0 then
			chr:TranslateBy(hum.MoveDirection * tonumber(selected.tpws))
		else
			chr:TranslateBy(hum.MoveDirection)
		end
	end
end)
--GUI
--[[
	Refs.
	https://textbin.net/raw/yuiz2p0mqy
	PageElements:addLabel(labelname,labelinfo)
	PageElements:addButton(buttonname,callback)
	PageElements:addToggle(togglename,callback)
	PageElements:addSlider(slidername,minvalue,maxvalue,callback)
	PageElements:addTextBox(textboxname,textboxdefault,callback)
	PageElements:addDropdown(dropdownname,list,scrollsize,callback)
]]
local GUI=loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/aaaa"))()
local UI=GUI:CreateWindow("BSS","version 1.0a")
local Main=UI:addPage("Main",1,true,6)
local Boss=UI:addPage("Boss",1,false,6)
local Sp=UI:addPage("Local",1,false,6)
Main:addDropdown("Select Field",{"Sunflower Field","Mushroom Field","Dandelion Field","Clover Field","Blue Flower Field","Bamboo Field","Spider Field","Strawberry Field","Pineapple Patch","Stump Field","Rose Field","Cactus Field","Pumpkin Patch","Pine Tree Forest","Mountain Top Field","Coconut Field","Pepper Patch"},4,function(v)
	selected.field=v
	print(selected.field)
end)
Main:addToggle("Start Farm",function(v)
	toggles.farming=v
	cd=true
end)
Main:addButton("Destroy Ui",function()for x=1,69 do if game.CoreGui:FindFirstChild("fu8rj82n")then game.CoreGui:FindFirstChild("fu8rj82n"):Destroy()end	end end)
Boss:addButton("Coconut Crab",function(v)
	if v then
		if not workspace:FindFirstChild"FLOOOASD" then
			local p = Instance.new('Part')
			p.Name = "FLOOOASD"
			p.Parent = workspace
			p.Transparency = 0.5
			p.Size = Vector3.new(2,0,2)
			p.Anchored = true
			p.CFrame = CFrame.new(-266.5,113.25,500)
		end
		hrp.CFrame=CFrame.new(-266.5,116,500)
	end
end)
Sp:addSlider("Walk Speed",hum.WalkSpeed,1000,function(val)
	selected.ws=val
end)
Sp:addSlider("Jump Height",hum.JumpPower,1000,function(val)
	selected.jp=val
end)
Sp:addLabel("Better Speed","no inertia")
Sp:addTextBox("TP walk speed",selected.tpws,function(val)
	selected.tpws=val
end)
Sp:addToggle("TP walk",function(v)
	toggles.tpw=v
end)

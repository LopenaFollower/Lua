local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
local hrp=chr.HumanoidRootPart
local start=false
local cd=true
local ball={}
local ar=false
local r=30
local cdn=.1
local cda=true
function nearest()
	local r
	for _,v in pairs(workspace.Balls:GetChildren())do
		if v~=plr then
			if r==nil then
				r=v
			else
				if(hrp.Position-v.Position).magnitude<(r.Position-hrp.Position).magnitude then
					r=v
				end
			end
		end
	end
	return r
end
function regulate_velocity()
	pcall(function()
		hrp.AssemblyAngularVelocity=Vector3.new(0,0,0)
        hrp.AssemblyLinearVelocity=Vector3.new(0,0,0)
        hrp.Velocity=Vector3.new(0,0,0)
	end)
end
function fling()
	for _,v in pairs(chr:GetDescendants())do
		if v:IsA"BasePart"then
			v.CustomPhysicalProperties=PhysicalProperties.new(math.huge,.3,.5)
		end
	end
	Noc=game:GetService"RunService".Stepped:Connect(function()
		if chr~=nil then
			for _,v in pairs(chr:GetDescendants())do
				if v:IsA"BasePart"and v.CanCollide==true then
					v.CanCollide=false
				end
			end
		end
		if not start then
			Noc:Disconnect()
		end
	end)
	wait(.1)
	local bambam=Instance.new"BodyAngularVelocity"
	bambam.Name='__ñ_____iekgi49e0okj*2ofji'
	bambam.Parent=hrp or hum
	bambam.AngularVelocity=Vector3.new(0,500,0)
	bambam.MaxTorque=Vector3.new(0,math.huge,0)
	bambam.P=math.huge
	for _,v in next,chr:GetChildren()do
		if v:IsA"BasePart"then
			v.CanCollide=false
			v.Massless=true
			v.Velocity=Vector3.new(0,0,0)
		end
	end
	fd=hum.Died:Connect(function()
		if fd then
			fd:Disconnect()
		end
		if Noc then
			Noc:Disconnect()
		end
		wait(.1)
		if not chr or not hum or not hrp then return end
		for i,v in pairs(hrp:GetChildren())do
			if v:IsA"BodyAngularVelocity"then
				v:Destroy()
			end
		end
		for _,v in pairs(chr:GetDescendants()) do
			if v:IsA"Part"or v:IsA"MeshPart"then
				v.CustomPhysicalProperties=PhysicalProperties.new(.7,.3,.5)
			end
		end
		if start then
			wait(10)
			fling()
		end
	end)
	repeat
		bambam.AngularVelocity=Vector3.new(0,5000,0)
		wait(.2)
		regulate_velocity()
		bambam.AngularVelocity=Vector3.new(0,0,0)
		wait(.1)
	until not hum or not hrp or not start
	for i,v in pairs(hrp:GetChildren())do
		if v:IsA"BodyAngularVelocity"then
			v:Destroy()
		end
	end
	for _,v in pairs(chr:GetDescendants()) do
		if v:IsA"Part"or v:IsA"MeshPart"then
			v.CustomPhysicalProperties=PhysicalProperties.new(.7,.3,.5)
		end
	end
end
local heartbeat=game:GetService"RunService".Heartbeat:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
		hrp=chr.HumanoidRootPart
		players=game:GetService"Players"
		game.Players.LocalPlayer.Character.FallDamageScript:Destroy()
	end)
	if start and cd then
		cd=false
		hrp.CFrame=CFrame.new(workspace.SpawnLocation.CFrame.x+math.random(-r,r),3,workspace.SpawnLocation.CFrame.z+math.random(-r,r))
		wait(cdn)
		cd=true
	end
	if ar and cda then
		cda=false
		game.ReplicatedStorage.SaveDataStore:FireServer(plr.UserId)
		wait(5)
		cda=true
	end
	hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
	hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
	for i=1,20 do
		local count=0
		for _,v in pairs(workspace.Balls:GetChildren())do
			if tonumber(v.Name:match("%d+"))==i then
				count=count+1
			end
		end
		pcall(function()
			ball[i]:updateInfo(count)
		end)
	end
	if hum.Sit then
		hum:ChangeState"Jumping"
	end
end)
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/gui%20lib.lua")()
local UI=GUI:CreateWindow("Window","info")
local Main=UI:addPage("Main",3,true,1)
local Balls=UI:addPage("Ball Count",20,false,1)
Main:addToggle("auto save(caution)",false,function(v)
	ar=v
end)
Main:addToggle("blender",false,function(v)
	start=v
	fling()
end)
Main:addSlider("range",0,100,function(v)
	r=tonumber(v)
end)
Main:addSlider("cd",1,1000,function(v)
	cdn=tonumber(v)/1000
end)
Main:addLabel()
Main:destroyGui(function()
	start=false
	ar=false
	heartbeat:Disconnect()
end)
for i=1,20 do
	ball[i]=Balls:addLabel("Ball "..i,0)
	wait()
end
local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
local hrp=chr.HumanoidRootPart
local defjp=hum.JumpPower
local subject={
	name="",
	c=false,
	p=nil
}
local late=false
local cpos=hrp.CFrame
function notif(title,text,delay)
	game.StarterGui:SetCore("SendNotification",{
	    Title=title or"";
	    Text=text or"";
	    Duration=delay or 1;
	})
end
function playerdistance(a,b)
	return(a.Character.HumanoidRootPart.CFrame-b.Character.HumanoidRootPart.CFrame).magnitude
end
game:GetService"RunService".Heartbeat:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr.Humanoid
		hrp=chr.HumanoidRootPart
	end)
	if hum.Sit then
		hum.JumpPower=0
		hum:ChangeState"Jumping"
	else
		hum.JumpPower=defjp
	end
	if hrp.CFrame.y<-30 then
		hrp.CFrame=CFrame.new(3,5,-4)
	end
	if subject.c and subject.plr~=nil then
		subject.c=false
		repeat
			wait()
			hrp.CFrame=workspace[subject.plr.Name].HumanoidRootPart.CFrame*CFrame.new(0,-.3,math.random(.5,3.5))
		until late or subject.plr.Character.Humanoid.Sit
		if subject.plr.Character.Humanoid.Sit then
			hrp.Velocity=Vector3.new(9e5,9e12,9e5)
			wait(.3)
			workspace[plr.Name]:FindFirstChildWhichIsA"Tool".Parent=plr.Backpack
			wait(.5)
			hrp.CFrame=cpos
			hrp.AssemblyAngularVelocity=Vector3.new(0,0,0)
	        hrp.AssemblyLinearVelocity=Vector3.new(0,0,0)
	        hrp.Velocity=Vector3.new(0,0,0)
			late=true
		else
			wait(.5)
			late=true
			hrp.CFrame=cpos
			hrp.AssemblyAngularVelocity=Vector3.new(0,0,0)
	        hrp.AssemblyLinearVelocity=Vector3.new(0,0,0)
	        hrp.Velocity=Vector3.new(0,0,0)
		end
		if subject.plr and playerdistance(subject.plr,plr)>10000 then
			notif("success","sent "..playerdistance(subject.plr,plr).." studs away")
		else
			notif("fail")
		end
	end
end)
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/gui%20lib.lua")()
local UI=GUI:CreateWindow("Window","info")
local Main=UI:addPage("Main",3,true,1)
Main:addTextBox("Name","",function(v)
	subject.name=v:lower()
end)
Main:addButton("Kill",function()
	if subject.name:len()<1 and late then return end
	for _,v in pairs(game.Players:GetChildren())do
		if v~=plr then
			if v.Name:lower():find(subject.name)and(workspace[plr.Name]:FindFirstChildWhichIsA"Tool"or plr.Backpack:FindFirstChildWhichIsA"Tool")and not v.Character.Humanoid.Sit and v.Character.HumanoidRootPart.CFrame.y<5000 then
				late=false
				wait()
				if plr.Backpack:FindFirstChildWhichIsA"Tool"then
					plr.Backpack:FindFirstChildWhichIsA"Tool".Parent=workspace[plr.Name]
				end
				subject.c=true
				cpos=hrp.CFrame
				subject.plr=v
				wait(5)
				late=true
			elseif v.Name:lower():find(subject.name)and(workspace[plr.Name]:FindFirstChildWhichIsA"Tool"or plr.Backpack:FindFirstChildWhichIsA"Tool")and not subject.c then
				notif("target is sitting")
			elseif v.Name:lower():find(subject.name)and not v.Character.Humanoid.Sit and not subject.c then
				notif("no tool found")
			end
		end
	end
end)
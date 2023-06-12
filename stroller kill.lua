local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
local hrp=chr.HumanoidRootPart
local defjp=game.StarterPlayer.CharacterJumpPower
local subject={
	name="",
	c=false,
	p=nil
}
local late=false
local cpos=hrp.CFrame
local ESPenabled=true
function notif(title,text,delay)
	game.StarterGui:SetCore("SendNotification",{
	    Title=title or"";
	    Text=text or"";
	    Duration=delay or 1;
	})
	print("\n"..title.." "..text)
end
function playerdistance(a,b)
	return math.round((a.Character.HumanoidRootPart.Position-b.Character.HumanoidRootPart.Position).magnitude)
end
function ESP(t)
	task.spawn(function()
		wait()
		if t.Character and t.Name~=plr.Name and not game.CoreGui:FindFirstChild(t.Name.."_ESP")then
			local ESPholder=Instance.new("Folder",game.CoreGui)
			ESPholder.Name=t.Name.."_ESP"
			repeat wait(1)until t.Character and t.Character.HumanoidRootPart and t.Character:FindFirstChildOfClass"Humanoid"
			if t.Character and t.Character:FindFirstChild"Head"then
				local BillboardGui=Instance.new("BillboardGui",ESPholder)
				local TextLabel=Instance.new("TextLabel",BillboardGui)
				BillboardGui.Adornee=t.Character.Head
				BillboardGui.Name=t.Name
				BillboardGui.Size=UDim2.new(0,100,0,150)
				BillboardGui.StudsOffset=Vector3.new(0,1,0)
				BillboardGui.AlwaysOnTop=true
				TextLabel.BackgroundTransparency=1
				TextLabel.Position=UDim2.new(0,0,0,-50)
				TextLabel.Size=UDim2.new(0,100,0,100)
				TextLabel.Font=Enum.Font.SourceSansSemibold
				TextLabel.TextSize=20
				TextLabel.TextColor3=Color3.new(1,1,1)
				TextLabel.TextStrokeTransparency=0
				TextLabel.TextYAlignment=Enum.TextYAlignment.Bottom
				TextLabel.Text="Name: "..t.Name
				TextLabel.ZIndex=10
				local espLoopFunc
				local addedFunc
				addedFunc=t.CharacterAdded:Connect(function()
					if ESPenabled then
						espLoopFunc:Disconnect()
						ESPholder:Destroy()
						repeat wait(1)until t.Character.HumanoidRootPart and t.Character:FindFirstChildOfClass"Humanoid"
						ESP(t)
						addedFunc:Disconnect()
					else
						addedFunc:Disconnect()
					end
				end)
				local function espLoop()
					if game.CoreGui:FindFirstChild(t.Name.."_ESP")then
						if t.Character and t.Character.HumanoidRootPart and t.Character:FindFirstChildOfClass"Humanoid"and chr and hrp and hum then
							BillboardGui.Adornee=t.Character.Head
							TextLabel.Text="Name: "..t.Name.." | Sitting: "..tostring(t.Character:FindFirstChildOfClass"Humanoid".Sit).." | Studs: "..playerdistance(t,plr)
						end
					else
						addedFunc:Disconnect()
						espLoopFunc:Disconnect()
					end
				end
				espLoopFunc=game:GetService"RunService".Heartbeat:Connect(espLoop)
			end
		end
	end)
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
	if hrp.CFrame.y<-70 then
		hrp.CFrame=CFrame.new(3,5,-4)
	end
	if chr and hum then
		if hum.MoveDirection.Magnitude>0 then
			chr:TranslateBy(hum.MoveDirection*2)
		else
			chr:TranslateBy(hum.MoveDirection)
		end
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
			notif("success","sent "..playerdistance(subject.plr,plr).." studs away",5)
			subject.plr=nil
		else
			notif("fail","distance: "..playerdistance(subject.plr,plr).." studs",5)
			subject.plr=nil
		end
		if workspace[plr.Name]:FindFirstChildWhichIsA"Tool"then
			workspace[plr.Name]:FindFirstChildWhichIsA"Tool".Parent=plr.Backpack
		end
	end
	for _,v in pairs(game.Players:GetChildren())do
		if v~=plr then
			ESP(v)
		end
	end
end)
game.UserInputService.JumpRequest:Connect(function()
	if hum then
		hum:ChangeState"Jumping"
	end
end)
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/gui%20lib.lua")()
local UI=GUI:CreateWindow("Window","info")
local Main=UI:addPage("Main",3,true,1)
Main:addTextBox("Name","",function(v)
	subject.name=v:lower()
end)
Main:addButton("Kill",function()
	if subject.name:len()<1 and late and subject.plr~=nil then return end
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
			elseif v.Name:lower():find(subject.name)and(workspace[plr.Name]:FindFirstChildWhichIsA"Tool"or plr.Backpack:FindFirstChildWhichIsA"Tool")and v.Character.Humanoid.Sit and playerdistance(v,plr)<5000 and not subject.c then
				notif("target is sitting")
			elseif v.Name:lower():find(subject.name)and not(workspace[plr.Name]:FindFirstChildWhichIsA"Tool"or plr.Backpack:FindFirstChildWhichIsA"Tool")and not v.Character.Humanoid.Sit and playerdistance(v,plr)<5000 and not subject.c then
				notif("no tool found")
			elseif v.Name:lower():find(subject.name)and(workspace[plr.Name]:FindFirstChildWhichIsA"Tool"or plr.Backpack:FindFirstChildWhichIsA"Tool")and not v.Character.Humanoid.Sit and playerdistance(v,plr)>=5000 and not subject.c then
				notif("target is far away","distance: "..playerdistance(subject.plr,plr).." studs away")
			end
		end
	end
	wait(5)
	subject.plr=nil
	late=true
end)
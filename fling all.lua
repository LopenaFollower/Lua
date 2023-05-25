--fling all
local plr=game.Players.LocalPlayer
local chr=plr.Character
local hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
local hrp=chr.HumanoidRootPart
local st=true
local tg=nil
local players=game:GetService"Players"
local immune={}
local safe_tg=nil
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
	end)
	wait(.1)
	local bambam=Instance.new"BodyAngularVelocity"
	bambam.Name='__ñ_____iekgi49e0okj*2ofji'
	bambam.Parent=hrp or hum
	bambam.AngularVelocity=Vector3.new(0,1e5,0)
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
		wait(6.9)
		fling()
		st=true
		wait(.069)
		fling()
	end)
	repeat
		bambam.AngularVelocity=Vector3.new(0,1e5,0)
		wait(.2)
		regulate_velocity()
		bambam.AngularVelocity=Vector3.new(0,0,0)
		wait(.1)
	until not hum or not hrp
end
game:GetService"RunService".Heartbeat:Connect(function()
	pcall(function()
		plr=game.Players.LocalPlayer
		chr=plr.Character
		hum=chr and chr:FindFirstChildWhichIsA"Humanoid"
		hrp=chr.HumanoidRootPart
		players=game:GetService"Players"
		game.Players.LocalPlayer.Character.FallDamageScript:Destroy()
	end)
	pcall(function()
		tg=players:GetChildren()[math.random(#players:GetChildren())]
	end)
	pcall(function()
		if hrp and(hrp.Position-Vector3.new(-34,safe_tg.Character.HumanoidRootPart.Position.y,22)).magnitude>=480 then
			hrp.CFrame=CFrame.new(-34,1e4,22)
			regulate_velocity()
		end
	end)
	pcall(function()
		if tg~=nil and not immune[tg.Name] and tg~=plr and tg.Character.Humanoid.Health>0 then
			safe_tg=tg
		end
		if safe_tg and(safe_tg.Character.HumanoidRootPart.Position-Vector3.new(-34,safe_tg.Character.HumanoidRootPart.Position.y,22)).magnitude<480 then
			hrp.CFrame=workspace[safe_tg.Name].HumanoidRootPart.CFrame*CFrame.new(0,-.5,math.random(-1,.25))
		end
	end)
	if hrp.CFrame.y<45 then
		regulate_velocity()
		hrp.CFrame=CFrame.new(-34,hrp.Position.y+5,22)
	end
	if hum and hum.Sit then
		hum:ChangeState"Jumping"
	end
	hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
	local bg = Instance.new('BodyGyro',hrp)
end)
local words = {
    ['gay'] = 'Bullying',
    ['lesbian'] = 'Bullying',
    ['retard'] = 'Bullying',
    ['noob'] = 'Bullying',
    ['clown'] = 'Bullying',
    ['get a life'] = 'Bullying',
    ['getalife'] = 'Bullying',
    ['no life'] = 'Bullying',
    ['nolife'] = 'Bullying',
    ['wizard'] = 'Bullying',
    ['report'] = 'Bullying',
    ['father'] = 'Bullying',
    ['mother'] = 'Bullying',
    ['dum'] = 'Bullying',
    ['stupid'] = 'Bullying',
    ['cringe'] = 'Bullying',
    ['skill issue'] = 'Bullying',
    ['parent'] = 'Bullying',
    ['kid'] = 'Bullying',
    ['ugly'] = 'Bullying',
    ['child'] = 'Bullying',
    ['trash'] = 'Bullying',
    ['bozo'] = 'Bullying',
    ['kys'] = 'Bullying',
    ['die'] = 'Bullying',
    ['kill'] = 'Bullying',
    ['loser'] = 'Bullying',
    ['black'] = 'Bullying',
    ['white'] = 'Bullying',
    ['ez'] = 'Bullying',
    ['l'] = 'Bullying',
    ['negro'] = 'Bullying',
    ['nivver'] = 'Bullying',
    ['negar'] = 'Bullying',
    ['bad'] = 'Bullying',
    ['worst'] = 'Bullying',
    ['fat'] = 'Bullying',
    ['hack'] = 'Scamming',
    ['exploit'] = 'Scamming',
    ['cheat'] = 'Scamming',
    ['download'] = 'Offsite Links',
    ['youtube'] = 'Offsite Links',
    ['dizzy'] = 'Offsite Links',
    ['autis'] = 'Bullying',
    ['homophob'] = 'Bullying',
    ['pen'] = 'Bullying',
    ['disc'] = 'Bullying',
    ['ahh'] = 'Bullying',
    ['nigger'] = 'Bullying',
    ['beach'] = 'Bullying',
    ['fat'] = 'Bullying',
    ['nagi'] = 'Bullying',
    ['fur'] = 'Bullying',
    ['smoke'] = 'Bullying',
    ['yt'] = 'Offsite Links',
    ['tt'] = 'Scamming',
    ['trust'] = 'Scamming',
    ['robux'] = 'Scamming',
    ['ash'] = 'Bullying',
    ['thic'] = 'Bullying',
    ['milk'] = 'Bullying',
    ['simp'] = 'Bullying',
    ['smp'] = 'Bullying',
    ['lmao'] = 'Bullying',
    ['mtf'] = 'Bullying',
    ['mafaka'] = 'Bullying',
    ['corn'] = 'Bullying',
    ['slat'] = 'Bullying',
    ['btc'] = 'Scamming',
    ['bottom'] = 'Bullying',
    ['alt'] = 'Bullying',
    ['cuddle'] = 'Bullying',
    ['virgin'] = 'Bullying',
    ['feet'] = 'Bullying',
    ['foot'] = 'Bullying',
    ['toe'] = 'Bullying',
    ['crack'] = 'Bullying',
    ['bread'] = 'Bullying',
    ['cook'] = 'Bullying',
    ['fric'] = 'Bullying',
    ['inhale'] = 'Bullying',
    ['kill'] = 'Bullying',
    ['donkey'] = 'Bullying',
    ['sex'] = 'Bullying',
    ['monkey'] = 'Bullying',
    ['obunga'] = 'Bullying',
    ['naz'] = 'Bullying',
    ['uwu'] = 'Bullying',
    ['clock'] = 'Bullying',
    ['ball'] = 'Bullying',
    ['od'] = 'Bullying',
    ['abc'] = 'Scamming',
    ['goof'] = 'Bullying',
    ['wtf'] = 'Bullying',
    ['brown'] = 'Bullying',
    ['cond'] = 'Bullying',
    ['nut'] = 'Bullying',
    ['horn'] = 'Bullying',
    ['die'] = 'Bullying',
    ['ig'] = 'Bullying',
    ['donate'] = 'Bullying',
    ['kiz'] = 'Bullying',
}
for i,plrs in pairs(players:GetChildren())do
	if plrs.Name~=plr.Name then
		plrs.Chatted:Connect(function(msg)
			for word,reason in next,words do
				if msg:lower():match(word)then
					players:ReportAbuse(plrs,reason,'He is breaking roblox TOS')
					wait(1.5)
					players:ReportAbuse(plrs,reason,'He is breaking roblox TOS')
				end
			end
		end)
	end
end
players.ChildAdded:Connect(function(plrs)
	plrs.Chatted:Connect(function(msg)
		for word,reason in next,words do
			if msg:lower():match(word)then
				players:ReportAbuse(plrs,reason,'He is breaking roblox TOS')
				wait(1.5)
				players:ReportAbuse(plrs,reason,'He is breaking roblox TOS')
			end
		end
	end)
end)
fling()
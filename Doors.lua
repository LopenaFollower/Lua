--ver 8q
--Doors Gui
if game.placeId~=6839171747 then return end
local chr=game.Players.LocalPlayer.Character
local hum=chr and chr:FindFirstChildWhichIsA("Humanoid")
local hrp=chr and chr.HumanoidRootPart
local conf={
skipping=false,
no_lag=true,
esp=true
}
local KeyObtain
local speed=.9
local door_y_offset=-2
local ce="o"
function haskey(i)
	for _,v in pairs(i:GetDescendants())do
		if v.Name=="KeyObtain"then
			return true
		end
	end
end
function o()
	workspace.Gravity=10802
	if ce=="o"then
		for _,v in pairs(workspace:GetDescendants())do
			if v.Name:lower()=="box"and v.Parent.Name:lower()=="elevatorbreaker"then
				chr:TranslateBy((v.Position-hrp.Position)*speed)
				ce="¶"
			end
		end
	end
end
function jump(n)
	workspace.Gravity=50
	for i=0,n or 1 do
		hum:ChangeState(Enum.HumanoidStateType.Jumping)
		wait()
	end
	workspace.Gravity=150
end
game:GetService("RunService").RenderStepped:Connect(function()
	if conf.skipping then
		local room=workspace.CurrentRooms:GetChildren()
		local last=room[#room]
		if last.Name=="100"then
			conf.skipping=false
			conf.esp=false
			for _,e in pairs(workspace:GetDescendants())do
				if e.Name=="esp__box"then
					e:Destroy()
				end
			end
			o()
			return
		end
		if last.Name=="50"then
			chr:TranslateBy(((workspace.CurrentRooms:FindFirstChild"49":FindFirstChild"RoomEnd".Position-hrp.Position)-Vector3.new(0,door_y_offset,0))*speed)
			if hrp.Position.y<workspace.CurrentRooms:FindFirstChild"49":FindFirstChild"RoomEnd".Position.y+door_y_offset then
				jump(5)
			end
			
		end
		for _,v in pairs(last:GetDescendants())do
			if v.Name:lower()=="keyobtain"then
				KeyObtain=v
			end
		end
		if haskey(last)and not workspace[game.Players.LocalPlayer.Name]:FindFirstChild"Key"then
			if not haskey(workspace.CurrentRooms:FindFirstChild(tostring(tonumber(last.Name)-1)))then
				chr:TranslateBy(((workspace.CurrentRooms:FindFirstChild(tostring(tonumber(last.Name)-1)):FindFirstChild"RoomEnd".Position-hrp.Position)-Vector3.new(0,door_y_offset,0))*speed)
				jump(5)
			else
				chr:TranslateBy(((KeyObtain.Hitbox.Position-hrp.Position)-Vector3.new(0,1,-2))*speed)
			end
			if hrp.Position.y<KeyObtain.Hitbox.Position.y+door_y_offset then
				jump(5)
			end
		else
			chr:TranslateBy(((last:FindFirstChild"RoomEnd".Position-hrp.Position)-Vector3.new(0,door_y_offset,0))*speed)
			if hrp.Position.y<last:FindFirstChild"RoomEnd".Position.y+door_y_offset then
				jump(5)
			end
		end
		last:FindFirstChild"Door":FindFirstChild"ClientOpen":FireServer()
	end
end)
game:GetService"LogService".MessageOut:Connect(function(message)
	wait(1.64)
	while message=="SENT SIGNAL"and wait()do
		chr:TranslateBy((workspace.CurrentRooms[100].ElevatorCar.ActualCollision.ElevatorPanel.Button.Position-hrp.Position)*speed)
		chr:TranslateBy((workspace.CurrentRooms[100].ElevatorCar.ActualCollision.ElevatorPanel.Button.Position-hrp.Position)*speed)
		if hrp.Position.y<workspace.CurrentRooms[100].ElevatorCar.ActualCollision.ElevatorPanel.Button.Position.y+1 then
			jump(5)
			wait(54)
			game:GetService"TeleportService":Teleport(6516141723)
		end
	end
end)
function box(p)
	local a=Instance.new"BoxHandleAdornment"
	a.Name="esp__box"
	a.Parent=p
	a.Adornee=p
	a.AlwaysOnTop=true
	a.ZIndex=0
	a.Size=p.Size*1.20
	a.Transparency=.35
	a.Color=p.BrickColor
end
local light=game:GetService"Lighting"
light.Brightness=2
light.ClockTime=14
light.FogEnd=10000
light.GlobalShadows=false
light.OutdoorAmbient=Color3.fromRGB(128,128,128)
workspace.DescendantAdded:Connect(function(v)
	local name=v.Name:lower()
	if conf.no_lag then
		if name=="rafter"or name=="glass"or name=="modular_bookshelf"or name=="potted_plant"or name=="wardrobe"or name=="bookcase"or name=="piece"or name=="rug"or name=="carpet"or name=="desk_globe"or name=="pillar"or name=="wall_strip"or name=="painting_small"or name=="painting_tall"or name=="typewriter"or name=="seek_arm"or name=="painting_verybig"or name=="painting_big"or name=="light_fixtures"or name=="fireplace"or name=="wall_clock"or name=="barrelstack"or name=="web"or name=="barrelstack_small"or name=="grandfather_clock"or name=="pipe"or name=="luggagecarts"or name=="blockades"or name=="lamp_tall"or name=="hat_stand"or name=="bookshelfobstruction"or name=="chandelierobstruction"or name=="chandelier"or name=="window"or v:IsA('ForceField')or v:IsA('Sparkles')or v:IsA('Smoke')or v:IsA('Fire')then
			wait(0.1)
			v:Destroy()
		elseif v:IsA("Decal")then
			v.Transparency = 1
		elseif v:IsA("ParticleEmitter")or v:IsA("Trail")then
			v.Lifetime=NumberRange.new(0)
		end
	end
	if v:IsA"BasePart"and conf.esp and not v:FindFirstChild"esp__box"then
		if name=="humanoidrootpart"or name=="hitbox"or name=="door"or name=="rails"or name=="ribcage"or name=="hintbook"or name=="actualroot"or name=="livehintbook"then
			box(v)
		end
	end
end)
local GUI=loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/aaaa"))()
local UI=GUI:CreateWindow("doors","")
local Main=UI:addPage("Main",1,true,6)
Main:addToggle("Auto Skip",function(v)
	conf.skipping=v
end)
Main:addToggle("Fps Boost",function(v)
	conf.no_lag=v
end)
Main:addToggle("NoClip",function(v)
	for _,v in pairs(chr:GetDescendants())do
		if v:IsA("BasePart")then
			v.CanCollide=not v
		end
	end
end)
Main:addToggle("ESP",function(v)
	conf.esp=v
end)

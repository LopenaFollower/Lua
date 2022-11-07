--ver 7
--Doors Gui
local chr = game.Players.LocalPlayer.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
local hrp = chr and chr.HumanoidRootPart
local skipping=false
local no_lag=false
local KeyObtain
function haskey(i)
	for _,v in pairs(i:GetDescendants())do
		if v.Name=="KeyObtain" then
			return true
		end
	end
end
game:GetService("RunService").RenderStepped:Connect(function()
	if skipping==true then
		local room=workspace.CurrentRooms:GetChildren()
		local last=room[#room]
		if last.Name=="100" then
			return
		end
		if last.Name=="50" then
			chr:TranslateBy(((workspace.CurrentRooms:FindFirstChild("49").RoomEnd.Position-chr.HumanoidRootPart.Position)-Vector3.new(0,-3,0))*0.25)
		end
		for _,v in pairs(last:GetDescendants())do
			if v.Name:lower()=="keyobtain"then
				KeyObtain=v
			end
		end
		if haskey(last) and not workspace[game.Players.LocalPlayer.Name]:FindFirstChild"Key" then
			if not haskey(workspace.CurrentRooms:FindFirstChild(tostring(tonumber(last.Name)-1))) and not workspace[game.Players.LocalPlayer.Name]:FindFirstChild"Key" then
				chr:TranslateBy(((workspace.CurrentRooms:FindFirstChild(tostring(tonumber(last.Name)-1)).RoomEnd.Position-chr.HumanoidRootPart.Position)-Vector3.new(0,-3,0))*0.25)
			else
				chr:TranslateBy(((KeyObtain.Hitbox.Position-chr.HumanoidRootPart.Position)-Vector3.new(0,0,0))*0.25)
			end
			if hrp.Position.y<KeyObtain.Hitbox.Position.y-3 then
				hum:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		else
			chr:TranslateBy(((last.RoomEnd.Position-chr.HumanoidRootPart.Position)-Vector3.new(0,-3,0))*0.25)
			if hrp.Position.y<last.RoomEnd.Position.y-3 then
				hum:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end
		last.Door.ClientOpen:FireServer()
	end
	game:GetService("LogService").MessageOut:Connect(function(message)
		wait(2.5)
		while message =="SENT SIGNAL" and wait(.1) do
			chr:TranslateBy((game:GetService("Workspace").CurrentRooms[100].ElevatorCar.IndustrialLight.Top.ElevatorLight.Position-chr.HumanoidRootPart.Position)*0.25)
			if hrp.Position.y<game:GetService("Workspace").CurrentRooms[100].ElevatorCar.IndustrialLight.Top.ElevatorLight.RoomEnd.Position.y then
				hum:ChangeState(Enum.HumanoidStateType.Jumping)
			end 
		end
	end)
end)

--ver 19
--Doors esp
function box(yes)
	local a = Instance.new("BoxHandleAdornment")
	a.Name = "ffie"
	a.Parent = yes
	a.Adornee = yes
	a.AlwaysOnTop = true
	a.ZIndex = 0
	a.Size = yes.Size*1.20
	a.Transparency = 0.35
	a.Color = yes.BrickColor
end
local light=game:GetService("Lighting")
light.Brightness = 2
light.ClockTime = 14
light.FogEnd = 10000
light.GlobalShadows = false
light.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
workspace.DescendantAdded:Connect(function(v)
	if no_lag==true then
		local name=v.Name:lower()
		if v:IsA"BasePart" then
			if name=="hitbox"or
			name=="door"or
			name=="rails"or
			name=="ribcage"or
			name=="hintbook"or
			name=="actualroot"or
			name=="livehintbook"then
				if not v:FindFirstChild"ffie"then
					box(v)
				end
			end
		end
		if name=="rafter"or name=="glass"or name=="modular_bookshelf"or name=="potted_plant"or name=="wardrobe"or name=="bookcase"or name=="piece"or name=="rug"or name=="carpet"or name=="desk_globe"or name=="pillar"or name=="wall_strip"or name=="painting_small"or name=="painting_tall"or name=="typewriter"or name=="seek_arm"or name=="painting_verybig"or name=="painting_big"or name=="light_fixtures"or name=="fireplace"or name=="wall_clock"or name=="barrelstack"or name=="web"or name=="barrelstack_small"or name=="grandfather_clock"or name=="pipe"or name=="luggagecarts"or name=="blockades"or name=="lamp_tall"or name=="hat_stand"or name=="bookshelfobstruction"or name=="chandelierobstruction"or name=="chandelier"or name=="window"then
			wait(0.1)
			v:Destroy()
		end
		if v:IsA("Decal")then
			v.Transparency = 1
		end
		if v:IsA("ParticleEmitter")or v:IsA("Trail")then
			v.Lifetime=NumberRange.new(0)
		end
		if v:IsA('ForceField')or v:IsA('Sparkles')or v:IsA('Smoke')or v:IsA('Fire')then
			v:Destroy()
		end
	end
end)

local GUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/aaaa"))()
local UI = GUI:CreateWindow("doors","")
local Home = UI:addPage("Home",1,true,6)

Home:addToggle("Auto Skip",function(value)
	skipping=value
end)
Home:addToggle("Fps Boost",function(value)
	no_lag=value
end)
Home:addToggle("NoClip",function(value)
	for _, child in pairs(chr:GetDescendants()) do
		if child:IsA("BasePart")then
			child.CanCollide = not value
		end
	end
end)

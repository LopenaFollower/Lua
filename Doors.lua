--ver 4
--Doors
local chr = game.Players.LocalPlayer.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
function goto(obj,y)
	while (chr.HumanoidRootPart.Position-obj.Position).magnitude > 7.5 do
                wait()
		chr:TranslateBy(((obj.Position-chr.HumanoidRootPart.Position)-Vector3.new(0,y or 0,0))*0.01) mbal
	end
end
local room
local CD=true
game:GetService("RunService").RenderStepped:Connect(function()
	for _,v in pairs(workspace.CurrentRooms:GetChildren())do
                CD=false
		if v:FindFirstChild"Assets":FindFirstChild"KeyObtain"and CD then
	  		room=v
			while not workspace[game.Players.LocalPlayer.Name]:FindFirstChildOfClass"Tool" and wait() do
				goto(room:FindFirstChild"Assets":FindFirstChild"KeyObtain".Hitbox)
			end
		else
			goto(v.RoomEnd,-5)
                        CD=true
		end
	end
end)

local plr=game.Players.LocalPlayer
local hrp=plr.Character.HumanoidRootPart
local descs={
	["Allows you to get more coins in the Path Of Fortune"]=true,
	["Upgrade a random piece of gear you own!"]=true
}
function press(button,enable)
	for _,v in pairs(getconnections(button.Activated))do
		if enable then v:Enable()end
		v:Fire()
	end
	for _,v in pairs(getconnections(button.MouseButton1Down))do
		if enable then v:Enable()end
		v:Fire()
	end
end
function pickupgrade()
	local mc=false
	local btns={}
	for _,v in pairs(plr.PlayerGui.POFUpgrade.Window.Content:GetChildren())do
		if v.Name=="ItemTemplate"then
			table.insert(btns,v)
			local desc=v.Content.Description.Text
			if descs[desc]then
				press(v.UnlockButton)
				mc=true
			end
		end
	end
	if not mc and#btns>0 then
		press(btns[math.random(1,3)].UnlockButton)
	end
end
local i=2
local coords={
	CFrame.new(-427.9,15,3.2),
	CFrame.new(-15921.3,2585.2,4013.3),
	CFrame.new(-15918.25,2587.9,3868.8),
	CFrame.new(-15917.9,2589,3803.4),
	CFrame.new(-16016,2604.2,3787.4),
	CFrame.new(-15997.3,2604.3,3826.25),
	CFrame.new(-15996.25,2620.7,3866.4),
	CFrame.new(-15995.9,2633.4,3896.2),
	CFrame.new(-15987,2644,3981.5),
	CFrame.new(-16109.2,2644,3958.4),
	CFrame.new(-16145.2,2644,3970),
	CFrame.new(-16255.8,2643.6,3936.9),
	CFrame.new(-16224,2644,3923.25),
	CFrame.new(-16202,2644,3886.2),
	CFrame.new(-16181.8,2645,3837.3),
	CFrame.new(-16206.75,2644.29,3766.82),
	CFrame.new(-16242.43,2644.24,3779.3),
	CFrame.new(-16330.1,2644,3853.6),
	CFrame.new(-16327.36,2644,3875.1),
	CFrame.new(-16437.65,2598,3950.44)
}
hrp.CFrame=coords[1]
wait(1)
while i<#coords+1 do
	hrp.CFrame=coords[i]
	if i==9 or i==17 or i==20 then
		wait(.1)
		task.spawn(pickupgrade)
	end
	i=i+1
	wait(.4)
end
hrp.CFrame=CFrame.new(-15995.9,2560,3896.2)
local PID=game.PlaceId
if PID~=16732694052 then return else repeat task.wait()until game:IsLoaded()and game.Players.LocalPlayer end
task.wait(1)
local waitTimeThreshold,y=10,125
local qtp=(syn and syn.queue_on_teleport)or queue_on_teleport or(fluxus and fluxus.queue_on_teleport)
qtp("loadstring(game:HttpGet'https://raw.githubusercontent.com/LopenaFollower/Lua/main/sunken%20server%20hop.lua')()")

local plr=game.Players.LocalPlayer
local chr=plr.Character
local hrp=chr.HumanoidRootPart
local cam=workspace.CurrentCamera

local ts=game:GetService"TeleportService"
local hs=game:GetService"HttpService"
local vi=game:GetService"VirtualInputManager"
local rs=game:GetService"ReplicatedStorage"

local req=(syn and syn.request)or(http and http.request)or http_request or(fluxus and fluxus.request)or request
local sunkenLocs={
	moosewood={{936,y,-159},{693,y,-362},{613,y,498},{285,y,564},{283,y,-159}},
	roslit={{-1179,y,565},{-1217,y,201},{-1967,y,980},{-2444,y,266},{-2444,y,-37}},
	sunstone={{-852,y,-1560},{-1000,y,-751},{-1500,y,-750},{-1547,y,-1080},{-1618,y,-1560}},
	terrapin={{798,y,1667},{562,y,2455},{393,y,2435},{-1,y,1632},{-190,y,2450}},
	mushgrove={{2890,y,-997},{2729,y,-1098},{2410,y,-1110},{2266,y,-721}},
	forsaken={{-2460,y,2047}}
}
function getMinutes(t)
	local a=t:gsub("Uptime: ",""):gsub("D ","*1440+"):gsub("H ","*60+"):gsub("M","")
	return loadstring("return "..a)()
end
function close(m)
	local c=math.huge
	for i=0,100 do
		if math.abs(m-70*i-60)<70 then
			c=i
		end
	end
	return c*70+60-m;
end
function hop()
	if req then
		warn"Server hopping..."
		local servers,res={},req({Url=string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true",PID)})
		local body=hs:JSONDecode(res.Body)
		if body and body.data then
			for i,v in next,body.data do
				local p,m=tonumber(v.playing),tonumber(v.maxPlayers)
				if type(v)=="table"and p and m and p<m and v.id~=game.JobId then
					table.insert(servers,1,v.id)
				end
			end
		end
		if #servers>0 then
			ts:TeleportToPlaceInstance(PID,servers[math.random(1,#servers)],plr)
		end
		task.wait(2)
		hop()
	end
end
function removeVelocity()
	pcall(function()
		hrp.AssemblyAngularVelocity=Vector3.new(0,0,0)
		hrp.AssemblyLinearVelocity=Vector3.new(0,0,0)
		hrp.Velocity=Vector3.new(0,0,0)
	end)
end
function press(k)
	vi:SendKeyEvent(1,k,0,game)
	vi:SendKeyEvent(0,k,0,game)
end
function searchChests(l)
	for k,v in pairs(sunkenLocs)do
		if l:find(k)or l=="All"then
			for _,p in pairs(v)do
				hrp.CFrame=CFrame.new(unpack(p))
				task.wait(1)
				local pad=workspace.ActiveChestsFolder:FindFirstChild"Pad"
				if pad and pad:FindFirstChild"Spawns"then
					for _,v in pairs(pad:GetDescendants())do
						if v:IsA"ProximityPrompt"then
							v.RequiresLineOfSight=false
							v.HoldDuration=0
							v.MaxActivationDistance=1000
						end
					end
					task.wait(.25)
					for _,c in pairs(pad.Spawns:GetChildren())do
						hrp.CFrame=c.CFrame
						removeVelocity()
						cam.CFrame=hrp.CFrame*CFrame.Angles(-2,0,0)
						for i=0,5 do
							press(101)
							press(111)
							task.wait(.15)
						end
					end
					task.wait(3)
					hop()
					break
				end
			end
			task.wait(1.67)
		end
	end
end

plr.DevCameraOcclusionMode=Enum.DevCameraOcclusionMode.Invisicam
task.wait(1.5)
press(290)
task.wait(.5)
print"Sunken Chest server hop loaded"
local waitTime=close(getMinutes(plr.PlayerGui.ScreenGui.serverInfo.uptime.Text))
print("Chest Spawns in "..waitTime.." minute(s)")
if waitTime>waitTimeThreshold and waitTime<=60 then
	hop()
end
if waitTime>60 then
	print"Chest may have not yet despawned, checking"
	searchChests"All"
	task.wait(3)
	hop()
else
	searchChests"All"
end
rs.events.anno_top.OnClientEvent:Connect(function(a)
	if a:lower():find"sunken treasure"then
		task.wait(.1)
		searchChests(a:lower())
	end
end)

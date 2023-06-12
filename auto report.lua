local players=game.Players
local plr=players.LocalPlayer
local words={
    ["gay"]="Bullying",
    ["lesbian"]="Bullying",
    ["retard"]="Bullying",
    ["noob"]="Bullying",
    ["clown"]="Bullying",
    ["get a life"]="Bullying",
    ["getalife"]="Bullying",
    ["no life"]="Bullying",
    ["nolife"]="Bullying",
    ["wizard"]="Bullying",
    ["report"]="Bullying",
    ["father"]="Bullying",
    ["mother"]="Bullying",
    ["dum"]="Bullying",
    ["stupid"]="Bullying",
    ["cringe"]="Bullying",
    ["skill issue"]="Bullying",
    ["parent"]="Bullying",
    ["kid"]="Bullying",
    ["ugly"]="Bullying",
    ["child"]="Bullying",
    ["trash"]="Bullying",
    ["bozo"]="Bullying",
    ["kys"]="Bullying",
    ["die"]="Bullying",
    ["kill"]="Bullying",
    ["loser"]="Bullying",
    ["black"]="Bullying",
    ["white"]="Bullying",
    ["ez"]="Bullying",
    ["l"]="Bullying",
    ["negro"]="Bullying",
    ["nivver"]="Bullying",
    ["negar"]="Bullying",
    ["bad"]="Bullying",
    ["worst"]="Bullying",
    ["fat"]="Bullying",
    ["hack"]="Scamming",
    ["exploit"]="Scamming",
    ["cheat"]="Scamming",
    ["download"]="Offsite Links",
    ["youtube"]="Offsite Links",
    ["dizzy"]="Offsite Links",
    ["autis"]="Bullying",
    ["homophob"]="Bullying",
    ["pen"]="Bullying",
    ["disc"]="Bullying",
    ["ahh"]="Bullying",
    ["nigger"]="Bullying",
    ["beach"]="Bullying",
    ["fat"]="Bullying",
    ["nagi"]="Bullying",
    ["fur"]="Bullying",
    ["smoke"]="Bullying",
    ["yt"]="Offsite Links",
    ["tt"]="Scamming",
    ["trust"]="Scamming",
    ["robux"]="Scamming",
    ["ash"]="Bullying",
    ["thic"]="Bullying",
    ["milk"]="Bullying",
    ["simp"]="Bullying",
    ["smp"]="Bullying",
    ["lmao"]="Bullying",
    ["mtf"]="Bullying",
    ["mafaka"]="Bullying",
    ["corn"]="Bullying",
    ["slat"]="Bullying",
    ["btc"]="Scamming",
    ["bottom"]="Bullying",
    ["alt"]="Bullying",
    ["cuddle"]="Bullying",
    ["virgin"]="Bullying",
    ["feet"]="Bullying",
    ["foot"]="Bullying",
    ["toe"]="Bullying",
    ["crack"]="Bullying",
    ["bread"]="Bullying",
    ["cook"]="Bullying",
    ["fric"]="Bullying",
    ["inhale"]="Bullying",
    ["kill"]="Bullying",
    ["donkey"]="Bullying",
    ["sex"]="Bullying",
    ["monkey"]="Bullying",
    ["obunga"]="Bullying",
    ["naz"]="Bullying",
    ["uwu"]="Bullying",
    ["clock"]="Bullying",
    ["ball"]="Bullying",
    ["od"]="Bullying",
    ["abc"]="Scamming",
    ["goof"]="Bullying",
    ["wtf"]="Bullying",
    ["brown"]="Bullying",
    ["cond"]="Bullying",
    ["nut"]="Bullying",
    ["horn"]="Bullying",
    ["die"]="Bullying",
    ["ig"]="Bullying",
    ["donate"]="Bullying",
    ["kiz"]="Bullying",
}
for i,plrs in pairs(players:GetChildren())do
	if plrs.Name~=plr.Name then
		plrs.Chatted:Connect(function(msg)
			for word,reason in next,words do
				if msg:lower():find(word)then
					players:ReportAbuse(plrs,reason,"He is breaking roblox TOS")
					wait(1.5)
					players:ReportAbuse(plrs,reason,"He is breaking roblox TOS")
				end
			end
		end)
	end
end
players.ChildAdded:Connect(function(plrs)
	plrs.Chatted:Connect(function(msg)
		for word,reason in next,words do
			if msg:lower():find(word)then
				players:ReportAbuse(plrs,reason,"He is breaking roblox TOS")
				wait(1.5)
				players:ReportAbuse(plrs,reason,"He is breaking roblox TOS")
			end
		end
	end)
end)
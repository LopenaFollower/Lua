local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/obeseinsect/roblox/main/Ui%20Libraries/Elerium.lua'))()
local window = library:AddWindow("Dex")
local tab = window:AddTab("")
local holder={}
tab:Show()
local g = tab:AddFolder("game")
for _1,v1 in pairs(game:GetChildren())do
	if #v1:GetChildren()>0 then
		holder[_1]=g:AddFolder(v1.Name)
		for _2,v2 in pairs(v1:GetChildren())do
			if #v2:GetChildren()>0 then
				holder[_1][_2]=holder[_1]:AddFolder(v2.Name)
				for _3,v3 in pairs(v2:GetChildren())do
					if #v3:GetChildren()>0 then
						holder[_1][_2][_3]=holder[_1][_2]:AddFolder(v3.Name)
						for _4,v4 in pairs(v3:GetChildren())do
							if #v4:GetChildren()>0 then
								holder[_1][_2][_3][_4]=holder[_1][_2][_3]:AddFolder(v4.Name)
							else
								holder[_1][_2][_3][_4]=holder[_1][_2][_3]:AddLabel(v4.Name)
							end
						end
					else
						holder[_1][_2][_3]=holder[_1][_2]:AddLabel(v3.Name)
					end
				end
			else
				holder[_1][_2]=holder[_1]:AddLabel(v2.Name)
			end
		end
	else
		holder[_1]=g:AddLabel(v1.Name)
	end
end
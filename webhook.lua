local connector={}
function connector:connect(api)
	local webhook={}
	local req=http_request or request or HttpPost or syn.request
	local embeds={
		["color"]=0,
		["author"]={
			["name"]="",
			["url"]="",
			["icon_url"]=""
		},
		["title"]="",
		["url"]="",
		["description"]="",
		["type"]="rich",
		["fields"]={},
		["thumbnail"]={
			["url"]=""
		},
		["image"]={
			["url"]=""
		},
		["footer"]={
			["text"]="",
			["icon_url"]=""
		}
	}
	local payload={
		["username"]="Default",
		["avatar_url"]="",
		["content"]="",
		["embeds"]={embeds},
		["tts"]=false
	}
	function snd()
		req({
			Url=api,
			Body=game.HttpService:JSONEncode(payload),
			Method="POST",
			Headers={["content-type"]="application/json"}
		})
	end
	function webhook:clearFields()
		embeds.fields={}
	end
	function webhook:addField(title,text,inline)
		table.insert(embeds.fields,{
			["name"]=title,
			["value"]=text,
			["inline"]=inline or false
		})
	end
	function webhook:color(n)
		embeds.color=n
	end
	function webhook:colorRGB(r,g,b)
		embeds.color=r*2^16+g*256+b
	end
	function webhook:setFooter(text,url)
		embeds.footer.text=text
		if url then
			embeds.footer.url=url
		end
	end
	function webhook:sendRaw(p)
		payload=p
		snd()
	end
	function webhook:send()
		snd()
	end
	return webhook
end
return connector

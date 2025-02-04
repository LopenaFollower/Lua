local req=http_request or request or HttpPost or syn.request
local connector={}
function trim(s)
	return s:match"^%s*(.*%S)"or""
end
function connector:connect(api)
	local webhook={}
	local embeds,payload
	function default()
		embeds={
			["color"]=0,
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
		payload={
			["username"]="Spidey Bot",
			["avatar_url"]="",
			["content"]="",
			["embeds"]={embeds}
		}
	end
	default()
	function snd()
		req({
			Url=api,
			Body=game.HttpService:JSONEncode(payload),
			Method="POST",
			Headers={["content-type"]="application/json"}
		})
	end
	function webhook:color(n)
		embeds.color=n
	end
	function webhook:colorRGB(r,g,b)
		embeds.color=r*2^16+g*256+b
	end
	function webhook:author(name,url,icon)
		if trim(name)~=""then
			embeds.author={}
			embeds.author.name=name
			if url then
				embeds.author.url=url
			end
			if icon then
				embeds.author.icon_url=icon
			end
		end
	end
	function webhook:title(str)
		embeds.title=str
	end
	function webhook:url(url)
		embeds.url=url
	end
	function webhook:description(str)
		embeds.description=str
	end
	function webhook:desc(str)
		embeds.description=str
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
	function webhook:thumbnail(url)
		embeds.thumbnail.url=url
	end
	function webhook:image(url)
		embeds.image.url=url
	end
	function webhook:setFooter(str,url)
		embeds.footer.text=str
		if trim(url)~=""then
			embeds.footer.url=url
		end
	end
	function webhook:username(str)
		payload.username=str
	end
	function webhook:avatar_url(url)
		payload.avatar_url=url
	end
	function webhook:content(str)
		payload.content=str
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
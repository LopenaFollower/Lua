local req=http_request or request or HttpPost or syn.request
local connector={}
function trim(s)
	return(s or""):match"^%s*(.*%S)"
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
			["embeds"]={}
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
			payload.embeds[1]=embeds
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
		if trim(str)~=""then
			payload.embeds[1]=embeds
			embeds.title=str
		end
	end
	function webhook:url(url)
		embeds.url=url
	end
	function webhook:description(str)
		if trim(str)~=""then
			payload.embeds[1]=embeds
			embeds.description=str
		end
	end
	function webhook:desc(str)
		embeds.description=str
	end
	function webhook:clearFields()
		embeds.fields={}
	end
	function webhook:addField(title,text,inline)
		payload.embeds[1]=embeds
		table.insert(embeds.fields,{
			["name"]=title or"",
			["value"]=text or"",
			["inline"]=inline or false
		})
	end
	function webhook:thumbnail(url)
		if trim(url)~=""then
			payload.embeds[1]=embeds
			embeds.thumbnail.url=url
		end
	end
	function webhook:image(url)
		if trim(url)~=""then
			payload.embeds[1]=embeds
			embeds.image.url=url
		end
	end
	function webhook:footer(str,url)
		if trim(str)~=""then
			payload.embeds[1]=embeds
			embeds.footer.text=str
			if trim(url)~=""then
				embeds.footer.url=url
			end
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
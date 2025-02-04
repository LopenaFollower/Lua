local req=(syn and syn.request)or(http and http.request)or http_request or(fluxus and fluxus.request)or request
local connector={}
function trim(s)
	return(s or""):match"^%s*(.*%S)"
end
function connector:connect(api)
	local webhook,embeds,payload={},{
		color=0,
		title="",
		url="",
		description="",
		type="rich",
		fields={},
		thumbnail={url=""},
		image={url=""},
		footer={text="",icon_url=""}
	},{
		username="Spidey Bot",
		avatar_url="",
		content="",
		embeds={}
	}
	function webhook:send()
		req({
			Url=api,
			Body=game.HttpService:JSONEncode(payload),
			Method="POST",
			Headers={["content-type"]="application/json"}
		})
	end
	function webhook:sendRaw(p)
		payload=p
		webhook:send()
	end
	function webhook:color(n)
		embeds.color=n
	end
	function webhook:colorRGB(r,g,b)
		embeds.color=r*2^16+g*256+b
	end
	function webhook:author(n,u,i)
		if trim(n)~=""then
			payload.embeds[1]=embeds
			embeds.author={}
			embeds.author.name=n
			embeds.author.url=trim(u)
			embeds.author.icon_url=trim(i)
		end
	end
	function webhook:title(s)
		if trim(s)~=""then
			payload.embeds[1]=embeds
			embeds.title=s
		end
	end
	function webhook:url(u)
		embeds.url=u
	end
	function webhook:desc(s)
		if trim(s)~=""then
			payload.embeds[1]=embeds
			embeds.description=s
		end
	end
	function webhook:description(s)
		webhook:desc(s)
	end
	function webhook:clearFields()
		embeds.fields={}
	end
	function webhook:addField(n,v,i)
		payload.embeds[1]=embeds
		table.insert(embeds.fields,{name=n or"",value=v or"",inline=i})
	end
	function webhook:thumbnail(u)
		if trim(u)~=""then
			payload.embeds[1]=embeds
			embeds.thumbnail.url=u
		end
	end
	function webhook:image(u)
		if trim(u)~=""then
			payload.embeds[1]=embeds
			embeds.image.url=u
		end
	end
	function webhook:footer(s,u)
		if trim(s)~=""then
			payload.embeds[1]=embeds
			embeds.footer.text=s
			embeds.footer.url=trim(u)
		end
	end
	function webhook:username(s)
		payload.username=s
	end
	function webhook:avatar_url(u)
		payload.avatar_url=u
	end
	function webhook:content(s)
		payload.content=s
	end
	return webhook
end
return connector
--refer to https://birdie0.github.io/discord-webhooks-guide/discord_webhook.html

--Remote Spy created by Vaeb
local logInfo={
	pa="",
	full="",
}
local scanRemotes=true
local ignoreNames={Event=true,MessagesChanged=true,}
setreadonly(getrawmetatable(game),false)
local pseudoEnv={}
local gameMeta=getrawmetatable(game)
local tabChar="      "
function small(a,b,c)
	local ab=a:byte()or -1
	local bb=b:byte()or -1
	if ab==bb then
		if c and #a==1 and #b==1 then
			return -1
		elseif #b==1 then
			return false
		elseif #a==1 then
			return true
		else
			return small(a:sub(2),b:sub(2),c)
		end
	else
		return ab<bb
	end
end
function parseData(obj,numTabs,isKey,overflow,noTables,forceDict)
	local objType=typeof(obj)
	local objStr=tostring(obj)
	if objType=="table"then
		if noTables then
			return objStr
		end
		local isCyclic=overflow[obj]
		overflow[obj]=true
		local out={}
		local nextIndex=1
		local isDict=false
		local hasTables=false
		local data={}
		for k,v in next,obj do
			if not hasTables and typeof(v)=="table"then
				hasTables=true
			end

			if not isDict and k~=nextIndex then
				isDict=true
			else
				nextIndex=nextIndex+1
			end

			data[#data+1]={k,v}
		end

		if isDict or hasTables or forceDict then
			out[#out+1]=(isCyclic and"Cyclic "or"").."{"
			table.sort(data,function(a,b)
				local at=typeof(a[2])
				local bt=typeof(b[2])
				if bt=="string"and at~="string"then
					return false
				end
				local r=small(at,bt,true)
				if r==-1 then
					return small(tostring(a[1]),tostring(b[1]))
				else
					return r
				end
			end)
			for i=1,#data do
				local arr=data[i]
				local nowKey=arr[1]
				local nowVal=arr[2]
				local parseKey=parseData(nowKey,numTabs+1,true,overflow,isCyclic)
				local parseVal=parseData(nowVal,numTabs+1,false,overflow,isCyclic)
				if isDict then
					local nowValType=typeof(nowVal)
					local preStr=""
					local postStr=""
					if i>1 and(nowValType=="table"or typeof(data[i-1][2])~=nowValType)then
						preStr="\n"
					end
					if i<#data and nowValType=="table"and typeof(data[i+1][2])~="table"and typeof(data[i+1][2])==nowValType then
						postStr="\n"
					end
					out[#out+1]=preStr..string.rep(tabChar,numTabs+1)..parseKey.." = "..parseVal..";"..postStr
				else
					out[#out+1]=string.rep(tabChar,numTabs+1)..parseVal..";"
				end
			end
			out[#out+1]=string.rep(tabChar,numTabs).."}"
		else
			local data2={}
			for i=1,#data do
				local arr=data[i]
				local nowVal=arr[2]
				local parseVal=parseData(nowVal,0,false,overflow,isCyclic)
				data2[#data2+1]=parseVal
			end
			out[#out+1]="{"..table.concat(data2,", ").."}"
		end

		return table.concat(out,"\n")
	else
		local returnVal=nil
		if(objType=="string"or objType=="Content")and(not isKey or tonumber(obj:sub(1,1)))then
			local retVal='"'..objStr..'"'
			if isKey then
				retVal="["..retVal.."]"
			end
			returnVal=retVal
		elseif objType=="EnumItem"then
			returnVal="Enum."..tostring(obj.EnumType).."."..obj.Name
		elseif objType=="Enum"then
			returnVal="Enum."..objStr
		elseif objType=="Instance"then
			returnVal=obj.Parent and obj:GetFullName()or obj.ClassName
		elseif objType=="CFrame"then
			returnVal="CFrame.new("..objStr..")"
		elseif objType=="Vector3"then
			returnVal="Vector3.new("..objStr..")"
		elseif objType=="Vector2"then
			returnVal="Vector2.new("..objStr..")"
		elseif objType=="UDim2"then
			returnVal="UDim2.new("..objStr:gsub("[{}]","")..")"
		elseif objType=="BrickColor"then
			returnVal="BrickColor.new(\""..objStr.."\")"
		elseif objType=="Color3"then
			returnVal="Color3.new("..objStr..")"
		elseif objType=="NumberRange"then
			returnVal="NumberRange.new("..objStr:gsub("^%s*(.-)%s*$","%1"):gsub(" ",", ")..")"
		elseif objType=="PhysicalProperties"then
			returnVal="PhysicalProperties.new("..objStr..")"
		else
			returnVal=objStr
		end
		return returnVal
	end
end

function tableToString(t)
	return parseData(t,0,false,{},nil,false)
end

local detectClasses={
	BindableEvent=true;
	BindableFunction=true;
	RemoteEvent=true;
	RemoteFunction=true;
}

local classMethods={
	BindableEvent="Fire";
	BindableFunction="Invoke";
	RemoteEvent="FireServer";
	RemoteFunction="InvokeServer";
}

local realMethods={}

for n,e in next,detectClasses do if e then realMethods[classMethods[n]]=Instance.new(n)[classMethods[n]]end end

for k,v in next,gameMeta do pseudoEnv[k]=v end

function getValues(s,k,...)return{realMethods[k](s,...)}end

gameMeta.__index,gameMeta.__namecall=function(self,k)
	if not realMethods[k]or ignoreNames[self.Name]or not scanRemotes then return pseudoEnv.__index(self,k)end
	return function(_,...)
		local allPassed={...}
		local returnValues={}
		local ok,data=pcall(getValues,self,k,...)
		if ok then
			returnValues=data
			logInfo.full="game."..tostring(self:GetFullName())..":"..tostring(k).."(unpack("..tostring(tableToString(allPassed)).."))"
			logInfo.pa=tostring(self:GetFullName())
		else
			print(tableToString(allPassed)..s:GetFullName()..k)
		end
		return unpack(returnValues)
	end
end
function clipboard(s)
	local clipBoard=setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
	if clipBoard then
		clipBoard(s)
	end
end
local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/gui%20lib.lua")()
local UI=GUI:CreateWindow("Remote Spy","v2")
local Settings=UI:addPage("RSpy Settings",30,true,1)
local Logs=UI:addPage("Logs",300,false,1)
local holder={}
local code=""
Settings:addButton("Clear",function()
	for _,v in pairs(holder)do
		v:Destroy()
	end
end)
Settings:addTextBox("Input Code","",function(v)
	code=v
end)
Settings:addButton("Run",function()
	pcall(function()
		loadstring(code)()
	end)
end)
function createNewLog()
	pcall(function()
		if logInfo.pa~=""then
			holder[#holder+1]=Logs:addButton(logInfo.pa,function()
				clipboard(logInfo.full)
			end)
		end
		logInfo.pa=""
	end)
end
loadstring(game:HttpGetAsync"https://raw.githubusercontent.com/LopenaFollower/Lua/main/anti%20afk.lua")()
while wait()do
	createNewLog()
end
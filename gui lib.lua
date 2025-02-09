--Example use:
--local GUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/LopenaFollower/Lua/main/gui%20lib.lua")()
--local UI=GUI:CreateWindow("Window","info")
--local Main=UI:addPage("Main",3,true,1)
--local Tab2=UI:addPage("Tab2",3,false,1)
--
--Main:addLabel("Label","Info")
--
--Main:addButton("Button",function()
--	print("button pressed")
--end)
--
--Main:addToggle("Toggle",false,function(v)
--	print("toggle: "..v)
--end)
--
--Main:addSlider("Slider",0,100,function(v)
--	print("slider value: "..v)
--end)
--
--Main:addTextBox("TextBox","default",function(v)
--	print("textbox: "..v)
--end)
--
--local list={1, 2, 3, "4"}
--Main:addDropdown("Dropdown",list,1,function(v)
--	print("dropdown selected: "..v)
--end)
--
--Tab2:destroyGui(function()
--	print("goodbye")
--end)
local Version=326
task.spawn(function()
	print("Gui version: "..Version)
	loadstring(game:HttpGetAsync"https://raw.githubusercontent.com/LopenaFollower/Lua/main/anti%20afk.lua")()
end)
local UIS=game:GetService"UserInputService"
local G=game.CoreGui:FindFirstChild"51e6b58a-772cd11d-27fc1803-22496d1a-43580b73"
if G then
	G.Running.Value=false
end
function toRGB(n)
	return Color3.fromRGB(bit32.band(bit32.rshift(n,16),255),bit32.band(bit32.rshift(n,8),255),bit32.band(n,255))
end
local destroyButton,destroyCallback,guiFont=false,function()end,Enum.Font.GothamSemibold
local Lib={}
function Lib:CreateWindow(windowname,windowinfo)
	local Gui=Instance.new"ScreenGui"
	local Frame=Instance.new"Frame"
	local FrameCorner=Instance.new"UICorner"
	local DashBoard=Instance.new"Frame"
	local DashBoardCorner=Instance.new"UICorner"
	local TabContainer=Instance.new"ScrollingFrame"
	local TabContainerLayout=Instance.new"UIListLayout"
	local PageContainer=Instance.new"Frame"
	local PageContainerCorner=Instance.new"UICorner"
	local PageFolder=Instance.new"Folder"
	local Title=Instance.new"TextLabel"
	local Yep=Instance.new"TextButton"
	local Cre=Instance.new"ImageLabel"
	local YepTitle=Instance.new"TextLabel"
	local YepCorner=Instance.new"UICorner"
	local Status=Instance.new"BoolValue"
	Gui.Name="51e6b58a-772cd11d-27fc1803-22496d1a-43580b73"
	Gui.Parent=game.CoreGui
	Gui.ZIndexBehavior=1
	Gui.ResetOnSpawn=false
	Frame.Parent=Gui
	Frame.BackgroundColor3=toRGB(0x141414)
	Frame.BorderColor3=toRGB(0x141414)
	Frame.BorderSizePixel=0
	Frame.Position=UDim2.new(.289808273,0,.313227266,0)
	Frame.Size=UDim2.new(0,432,0,285)
	Frame.Active=true
	FrameCorner.Name="FrameCorner"
	FrameCorner.Parent=Frame
	DashBoard.Name="DashBoard"
	DashBoard.Parent=Frame
	DashBoard.BackgroundColor3=toRGB(0xF0F0F)
	DashBoard.BorderColor3=toRGB(0xF0F0F)
	DashBoard.Position=UDim2.new(.0185185205,0,.16842106,0)
	DashBoard.Size=UDim2.new(0,107,0,223)
	DashBoardCorner.CornerRadius=UDim.new(0,6)
	DashBoardCorner.Name="DashBoardCorner"
	DashBoardCorner.Parent=DashBoard
	TabContainer.Name="TabContainer"
	TabContainer.Parent=DashBoard
	TabContainer.BackgroundColor3=toRGB(0xF0F0F)
	TabContainer.BackgroundTransparency=1
	TabContainer.BorderColor3=toRGB(0xF0F0F)
	TabContainer.BorderSizePixel=0
	TabContainer.Position=UDim2.new(.0280373823,0,.0391304344,0)
	TabContainer.Size=UDim2.new(0,100,0,214)
	TabContainer.ScrollBarThickness=3
	TabContainer.ScrollBarImageColor3=toRGB(0x50505)
	TabContainer.CanvasSize=UDim2.new(0,0,1,0)
	TabContainer.Visible=true
	TabContainerLayout.Name="TabContainer"
	TabContainerLayout.Parent=TabContainer
	TabContainerLayout.HorizontalAlignment=Enum.HorizontalAlignment.Center
	TabContainerLayout.SortOrder=Enum.SortOrder.LayoutOrder
	TabContainerLayout.Padding=UDim.new(0,4)
	PageContainer.Name="PageContainer"
	PageContainer.Parent=Frame
	PageContainer.BackgroundColor3=toRGB(0xF0F0F)
	PageContainer.BorderColor3=toRGB(0xF0F0F)
	PageContainer.Position=UDim2.new(.282407403,0,.16842106,0)
	PageContainer.Size=UDim2.new(0,299,0,223)
	PageContainerCorner.CornerRadius=UDim.new(0,6)
	PageContainerCorner.Name="PageContainerCorner"
	PageContainerCorner.Parent=PageContainer
	PageFolder.Name="PageFolder"
	PageFolder.Parent=PageContainer
	Title.Name="Title"
	Title.Parent=Frame
	Title.BackgroundColor3=toRGB(0x141414)
	Title.BackgroundTransparency=1
	Title.BorderColor3=toRGB(0x141414)
	Title.BorderSizePixel=0
	Title.Position=UDim2.new(.0428240746,0,.028070176,0)
	Title.Size=UDim2.new(0,355,0,33)
	Title.Font=guiFont
	Title.Text=windowname
	Title.TextColor3=toRGB(0xFFFFFF)
	Title.TextSize=14
	Title.TextXAlignment=Enum.TextXAlignment.Left
	Yep.Name="Yep"
	Yep.Parent=Frame
	Yep.BackgroundColor3=toRGB(0x141414)
	Yep.BackgroundTransparency=1
	Yep.BorderColor3=toRGB(0x141414)
	Yep.BorderSizePixel=0
	Yep.Position=UDim2.new(.885,0,.0495263338,0)
	Yep.Size=UDim2.new(0,38,0,22)
	Yep.AutoButtonColor=false
	Yep.Font=Enum.Font.SourceSans
	Yep.Text=""
	Yep.TextColor3=toRGB(0)
	Yep.TextSize=14
	Cre.Name="Cre"
	Cre.Parent=Yep
	Cre.BackgroundTransparency=1
	Cre.Size=UDim2.new(0,38,0,21)
	Cre.Image="rbxassetid://4384401360"
	Cre.ScaleType=Enum.ScaleType.Fit
	YepTitle.Name="YepTitle"
	YepTitle.Parent=Yep
	YepTitle.BackgroundColor3=toRGB(0x141414)
	YepTitle.BackgroundTransparency=1
	YepTitle.BorderColor3=toRGB(0x141414)
	YepTitle.BorderSizePixel=0
	YepTitle.Position=UDim2.new(1.57894742,0,-.318181813,0)
	YepTitle.Size=UDim2.new(0,128,0,33)
	YepTitle.Font=guiFont
	YepTitle.Text=windowinfo or Version
	YepTitle.TextColor3=toRGB(0xFFFFFF)
	YepTitle.TextSize=9
	YepTitle.TextTransparency=1
	YepCorner.Name="YepCorner"
	YepCorner.Parent=YepTitle
	Status.Name="Running"
	Status.Parent=Gui
	Status.Value=true
	Status.Changed:Connect(function(v)
		if not v then
			destroyCallback()
			Gui:Destroy()
		end
	end)
	Cre.MouseEnter:Connect(function()
		YepTitle.BackgroundTransparency=.8
		YepTitle.TextTransparency=.5
		task.wait(.02)
		YepTitle.BackgroundTransparency=.5
		YepTitle.TextTransparency=.3
		Cre.ImageColor3=toRGB(0x89F6FF)
		task.wait(.02)
		YepTitle.BackgroundTransparency=0
		YepTitle.TextTransparency=0
	end)
	Cre.MouseLeave:Connect(function()
		YepTitle.BackgroundTransparency=.5
		YepTitle.TextTransparency=.3
		task.wait(.02)
		YepTitle.BackgroundTransparency=.8
		YepTitle.TextTransparency=.5
		Cre.ImageColor3=toRGB(0xFFFFFF)
		task.wait(.02)
		YepTitle.BackgroundTransparency=1
		YepTitle.TextTransparency=1
	end)
	local gui=Frame
	local dragging,dragInput,dragStart,startPos
	local function update(input)
		local delta=input.Position-dragStart
		gui.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
	end
	gui.InputBegan:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
			dragging=true
			dragStart=input.Position
			startPos=gui.Position
			input.Changed:Connect(function()
				if input.UserInputState==Enum.UserInputState.End then
					dragging=false
				end
			end)
		end
	end)
	gui.InputChanged:Connect(function(e)
		if e.UserInputType==Enum.UserInputType.MouseMovement or e.UserInputType==Enum.UserInputType.Touch then
			dragInput=e
		end
	end)
	UIS.InputChanged:Connect(function(e)
		if e==dragInput and dragging then
			update(e)
		end
	end)
	local FrameVisible=true
	local Page={}
	function Page:addPage(pagename,scrollsize,visible,elementspacing)
		local Tab=Instance.new"TextButton"
		local TabCorner=Instance.new"UICorner"
		local Home=Instance.new"ScrollingFrame"
		local PageLayout=Instance.new"UIListLayout"
		Tab.Name="Tab"
		Tab.Parent=TabContainer
		Tab.BackgroundColor3=toRGB(0xF0F0F)
		Tab.BorderColor3=toRGB(0xF0F0F)
		Tab.Position=UDim2.new(-.025,0,0,0)
		Tab.Size=UDim2.new(0,106,0,26)
		Tab.AutoButtonColor=false
		Tab.Font=guiFont
		Tab.Text=pagename or"nil"
		Tab.TextColor3=toRGB(0xFFFFFF)
		Tab.TextSize=11
		Tab.TextTransparency=.300
		TabCorner.CornerRadius=UDim.new(0,7)
		TabCorner.Name="TabCorner"
		TabCorner.Parent=Tab
		Home.Name="Page"
		Home.Parent=PageFolder
		Home.BackgroundColor3=toRGB(0xF0F0F)
		Home.BackgroundTransparency=1
		Home.BorderColor3=toRGB(0xF0F0F)
		Home.BorderSizePixel=0
		Home.Position=UDim2.new(0,0,.0391303785,0)
		Home.Size=UDim2.new(0,298,0,205)
		Home.ScrollBarThickness=5
		Home.ScrollBarImageColor3=toRGB(0)
		Home.CanvasSize=UDim2.new(0,0,scrollsize or 4,0)
		Home.Visible=visible or false
		PageLayout.Name="PageLayout"
		PageLayout.Parent=Home
		PageLayout.HorizontalAlignment=Enum.HorizontalAlignment.Center
		PageLayout.SortOrder=Enum.SortOrder.LayoutOrder
		PageLayout.Padding=UDim.new(0,elementspacing or 1)
		TabContainer.CanvasSize=UDim2.new(0,0,#TabContainer:GetChildren()*.13164,0)
		Tab.MouseButton1Down:Connect(function()
			Tab.TextSize=9
			for i,v in pairs(PageFolder:GetChildren())do
				v.Visible=false
			end
			task.wait(.02)
			Home.Visible=true
			Tab.TextTransparency=0
			Tab.TextSize=11
			for i,v in pairs(TabContainer:GetChildren())do
				if v:IsA"GuiButton"and v~=Tab then
					v.TextTransparency=.5
				end
			end
		end)
		if visible then
			Tab.TextTransparency=0
			for i,v in pairs(PageFolder:GetChildren())do
				if v:IsA"Frame"and v~=Home then
					v.Visible=false
				end
			end
		else
			Tab.TextTransparency=.5
		end
		Tab.MouseEnter:Connect(function()
			Tab.BackgroundColor3=toRGB(0xA0A0A)
		end)
		Tab.MouseLeave:Connect(function()
			Tab.BackgroundColor3=toRGB(0xF0F0F)
		end)
		Page[pagename]={}
		Page[pagename].rename=function(n)
			local name=tostring(n)
			if name:len()>0 then
				Tab.Text=name
			end
		end
		Page[pagename].addLabel=function(labelname,labelinfo,align)
			local Holder=Instance.new"Frame"
			local HolderCorner=Instance.new"UICorner"
			local Title=Instance.new"TextLabel"
			local Info=Instance.new"TextLabel"
			local align=align or"Center"
			Holder.Name="LabelHolder"
			Holder.Parent=Home
			Holder.BackgroundColor3=toRGB(0x111111)
			Holder.BorderColor3=toRGB(0x111111)
			Holder.BorderSizePixel=0
			Holder.Position=UDim2.new(.0167785231,0,0,0)
			Holder.Size=UDim2.new(0,288,0,26)
			HolderCorner.CornerRadius=UDim.new(0,5)
			HolderCorner.Name="LabelHolderCorner"
			HolderCorner.Parent=Holder
			Title.Name="LabelTitle"
			Title.Parent=Holder
			Title.BackgroundColor3=toRGB(0x111111)
			Title.BackgroundTransparency=1
			Title.BorderColor3=toRGB(0x111111)
			Title.BorderSizePixel=0
			Title.Size=UDim2.new(0,288,0,15)
			Title.Font=guiFont
			Title.Text=labelname or""
			Title.TextColor3=toRGB(0xFFFFFF)
			Title.TextXAlignment=Enum.TextXAlignment[align]
			Title.TextSize=11
			Info.Name="LabelInfo"
			Info.Parent=Holder
			Info.BackgroundColor3=toRGB(0x111111)
			Info.BackgroundTransparency=1
			Info.BorderColor3=toRGB(0x111111)
			Info.BorderSizePixel=0
			Info.Position=UDim2.new(0,0,.653846145,0)
			Info.Size=UDim2.new(0,288,0,9)
			Info.Font=guiFont
			Info.Text=labelinfo or""
			Info.TextColor3=toRGB(0xFFFFFF)
			Info.TextXAlignment=Enum.TextXAlignment[align]
			Info.TextSize=9
			Info.TextTransparency=.3
			Page[pagename][labelname]={}
			Page[pagename][labelname].remove=function()
				Holder:Destroy()
			end
			Page[pagename][labelname].setTitle=function(t)
				Title.Text=tostring(t)or""
			end
			Page[pagename][labelname].setInfo=function(t)
				Info.Text=tostring(t)or""
			end
			return Page[pagename][labelname]
		end
		Page[pagename].addButton=function(buttonname,callback)
			local Holder=Instance.new"Frame"
			local Title=Instance.new"TextLabel"
			local Button=Instance.new"TextButton"
			local Corner=Instance.new"UICorner"
			local HolderCorner=Instance.new"UICorner"
			local callback=callback or function()end
			Holder.Name="ButtonHolder"
			Holder.Parent=Home
			Holder.BackgroundColor3=toRGB(0x111111)
			Holder.BorderColor3=toRGB(0x111111)
			Holder.BorderSizePixel=0
			Holder.Position=UDim2.new(.0167785231,0,0,0)
			Holder.Size=UDim2.new(0,288,0,26)
			Title.Name="ButtonTitle"
			Title.Parent=Holder
			Title.BackgroundColor3=toRGB(0x111111)
			Title.BackgroundTransparency=1
			Title.BorderColor3=toRGB(0x111111)
			Title.BorderSizePixel=0
			Title.Position=UDim2.new(.024305556,0,0,0)
			Title.Size=UDim2.new(0,195,0,24)
			Title.Font=guiFont
			Title.Text=buttonname or""
			Title.TextColor3=toRGB(0xFFFFFF)
			Title.TextSize=11
			Title.TextXAlignment=Enum.TextXAlignment.Left
			Button.Name="Button"
			Button.Parent=Holder
			Button.BackgroundColor3=toRGB(0x50505)
			Button.BackgroundTransparency=0
			Button.BorderColor3=toRGB(0x111111)
			Button.Position=UDim2.new(.8534,0,1.17375305e-06,0)
			Button.Size=UDim2.new(0,34,0,19)
			Button.AutoButtonColor=false
			Button.Font=Enum.Font.SourceSans
			Button.Text="btn"
			Button.TextColor3=toRGB(0xFFFFFF)
			Button.TextSize=14
			Corner.Name="ButtonCorner"
			Corner.Parent=Button
			HolderCorner.CornerRadius=UDim.new(0,5)
			HolderCorner.Name="ButtonHolderCorner"
			HolderCorner.Parent=Holder
			Button.MouseButton1Down:Connect(function()
				Button.TextSize=11
				task.wait(.1)
				Button.TextSize=14
				pcall(callback)
			end)
			Page[pagename][buttonname]={}
			Page[pagename][buttonname].remove=function()
				Holder:Destroy()
			end
			Page[pagename][buttonname].setText=function(t)
				Button.Text=tostring(t)or""
			end
			Page[pagename][buttonname].call=function()
				pcall(callback)
			end
			return Page[pagename][buttonname]
		end
		Page[pagename].addToggle=function(togglename,toggledefault,callback)
			local Holder=Instance.new"Frame"
			local HolderCorner=Instance.new"UICorner"
			local Title=Instance.new"TextLabel"
			local Button=Instance.new"TextButton"
			local Frame=Instance.new"Frame"
			local FrameCorner=Instance.new"UICorner"
			local Ball=Instance.new"Frame"
			local BallCorner=Instance.new"UICorner"
			local callback=callback or function()end
			local Enabled=toggledefault or false
			Holder.Name="ToggleHolder"
			Holder.Parent=Home
			Holder.BackgroundColor3=toRGB(0x111111)
			Holder.BorderColor3=toRGB(0x111111)
			Holder.BorderSizePixel=0
			Holder.Position=UDim2.new(.0167785231,0,0,0)
			Holder.Size=UDim2.new(0,288,0,26)
			HolderCorner.CornerRadius=UDim.new(0,5)
			HolderCorner.Name="ToggleHolderCorner"
			HolderCorner.Parent=Holder
			Title.Name="ToggleTitle"
			Title.Parent=Holder
			Title.BackgroundColor3=toRGB(0x111111)
			Title.BackgroundTransparency=1
			Title.BorderColor3=toRGB(0x111111)
			Title.BorderSizePixel=0
			Title.Position=UDim2.new(.024305556,0,0,0)
			Title.Size=UDim2.new(0,195,0,24)
			Title.Font=guiFont
			Title.Text=togglename or""
			Title.TextColor3=toRGB(0xFFFFFF)
			Title.TextSize=11
			Title.TextXAlignment=Enum.TextXAlignment.Left
			Button.Name="ToggleButton"
			Button.Parent=Holder
			Button.BackgroundColor3=toRGB(0x111111)
			Button.BackgroundTransparency=1
			Button.BorderColor3=toRGB(0x111111)
			Button.Position=UDim2.new(.802083313,0,1.17375305e-06,0)
			Button.Size=UDim2.new(0,57,0,25)
			Button.AutoButtonColor=false
			Button.Font=Enum.Font.SourceSans
			Button.Text=""
			Button.TextColor3=toRGB(0)
			Button.TextSize=14
			Frame.Name="ToggleFrame"
			Frame.Parent=Button
			Frame.BackgroundColor3=toRGB(0x50505)
			Frame.BorderColor3=toRGB(0x50505)
			Frame.Position=UDim2.new(.27192983,0,.12,0)
			Frame.Size=UDim2.new(0,34,0,19)
			FrameCorner.Name="ToggleFrameCorner"
			FrameCorner.Parent=Frame
			Ball.Name="ToggleBall"
			Ball.Parent=Frame
			Ball.BackgroundColor3=toRGB(0xFFFFFF)
			Ball.Position=UDim2.new(.123,0,.158,0)
			Ball.Size=UDim2.new(0,14,0,12)
			BallCorner.CornerRadius=UDim.new(0,100)
			BallCorner.Name="ToggleBallCorner"
			BallCorner.Parent=Ball
			local function check()
				Ball:TweenPosition(UDim2.new(Enabled and .455 or .123,0,.158,0),"Out","Linear",.075)
				pcall(callback,Enabled)
			end
			Button.MouseButton1Down:Connect(function()
				Enabled=not Enabled
				check()
			end)
			check()
			Page[pagename][togglename]={}
			Page[pagename][togglename].remove=function()
				Holder:Destroy()
			end
			Page[pagename][togglename].setText=function(t)
				Title.Text=tostring(t)or""
			end
			Page[pagename][togglename].setStatus=function(b)
				if type(b)=="boolean"then
					Enabled=b
					check()
				end
			end
			return Page[pagename][togglename]
		end
		Page[pagename].addSlider=function(slidername,options,callback)
			local Holder=Instance.new"Frame"
			local Title=Instance.new"TextLabel"
			local HolderScript=Instance.new"UICorner"
			local Button=Instance.new"TextButton"
			local ButtonCorner=Instance.new"UICorner"
			local Trail=Instance.new"Frame"
			local TrailCorner=Instance.new"UICorner"
			local Number=Instance.new"TextLabel"
			local minvalue=math.min(options.min,options.max)
			local maxvalue=math.max(options.min,options.max)
			local precision=options.decimals or 0
			local callback=callback or function()end
			Holder.Name="SliderHolder"
			Holder.Parent=Home
			Holder.BackgroundColor3=toRGB(0x111111)
			Holder.BorderColor3=toRGB(0x111010)
			Holder.BorderSizePixel=0
			Holder.Position=UDim2.new(.0167785231,0,0,0)
			Holder.Size=UDim2.new(0,288,0,26)
			Title.Name="SliderTitle"
			Title.Parent=Holder
			Title.BackgroundColor3=toRGB(0x111111)
			Title.BackgroundTransparency=1
			Title.BorderColor3=toRGB(0x111111)
			Title.BorderSizePixel=0
			Title.Position=UDim2.new(.024305556,0,.15384616,0)
			Title.Size=UDim2.new(0,239,0,8)
			Title.Font=guiFont
			Title.Text=slidername
			Title.TextColor3=toRGB(0xFFFFFF)
			Title.TextSize=11
			Title.TextXAlignment=Enum.TextXAlignment.Left
			HolderScript.CornerRadius=UDim.new(0,5)
			HolderScript.Name="SliderHolderScript"
			HolderScript.Parent=Holder
			Button.Name="SliderButton"
			Button.Parent=Holder
			Button.BackgroundColor3=toRGB(0x50505)
			Button.BorderColor3=toRGB(0xF0F0F)
			Button.BorderSizePixel=0
			Button.Position=UDim2.new(0,8,0,17)
			Button.Size=UDim2.new(0,273,0,10)
			Button.AutoButtonColor=false
			Button.Font=Enum.Font.SourceSans
			Button.Text=""
			Button.TextColor3=toRGB(0)
			Button.TextSize=14
			ButtonCorner.Name="SliderButtonCorner"
			ButtonCorner.Parent=Button
			Trail.Name="SliderTrail"
			Trail.Parent=Button
			Trail.BackgroundColor3=toRGB(0x282828)
			Trail.BorderColor3=toRGB(0x282828)
			Trail.Size=UDim2.new(0,10,0,10)
			TrailCorner.Name="SliderTrailCorner"
			TrailCorner.Parent=Trail
			Number.Name="SliderNumber"
			Number.Parent=Holder
			Number.BackgroundColor3=toRGB(0x111111)
			Number.BackgroundTransparency=1
			Number.BorderColor3=toRGB(0x111111)
			Number.BorderSizePixel=0
			Number.Position=UDim2.new(.885,0,.192,1)
			Number.Size=UDim2.new(0,33,0,6)
			Number.Font=guiFont
			Number.Text=minvalue or 0
			Number.TextColor3=toRGB(0xFFFFFF)
			Number.TextSize=10
			Number.TextXAlignment=Enum.TextXAlignment.Left
			local mouse=game.Players.LocalPlayer:GetMouse()
			local Value,dragInput,released,held
			local function update()
				Trail.Size=UDim2.new(0,math.clamp(mouse.X-Trail.AbsolutePosition.X,0,273),0,7)
				Value=math.round(10^precision*(((tonumber(maxvalue)-tonumber(minvalue))/273)*Trail.AbsoluteSize.X)+tonumber(minvalue))/10^precision or 0
				pcall(callback,Value)
				Number.Text=Value
			end
			Button.InputBegan:Connect(function(input)
				if not held and input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
					held=true
					update()
					released=input.Changed:Connect(function()
						if input.UserInputState==Enum.UserInputState.End then
							held=false
							update()
							Holder.BackgroundColor3=toRGB(0x111111)
							released:Disconnect()
							released=nil
							dragInput=nil
						end
					end)
				end
			end)
			Button.InputChanged:Connect(function(input)
				if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then
					dragInput=input
				end
			end)
			UIS.InputChanged:Connect(function(input)
				if input==dragInput and held then
					update()
					Holder.BackgroundColor3=toRGB(0xE0E0E)
				end
			end)
			Page[pagename][slidername]={}
			Page[pagename][slidername].remove=function()
				Holder:Destroy()
			end
			Page[pagename][slidername].setText=function(t)
				Title.Text=tostring(t)or""
			end
			Page[pagename][slidername].setMin=function(n)
				minvalue=tonumber(n)
			end
			Page[pagename][slidername].setMax=function(n)
				maxvalue=tonumber(n)
			end
			Page[pagename][slidername].setValue=function(n)
				local i=tonumber(n)
				if type(i)=="number"and i<=maxvalue and i>=minvalue then
					Value=i
					Number.Text=i
					Trail.Size=UDim2.new(0,i/(maxvalue-minvalue)*273,0,7)
					pcall(callback,i)
				end
			end
			if options.default~=nil then
				local i=tonumber(options.default)
				if type(i)=="number"and i<=maxvalue and i>=minvalue then
					Value=i
					Number.Text=i
					Trail.Size=UDim2.new(0,i/(maxvalue-minvalue)*273,0,7)
					pcall(callback,i)
				end
			end
			return Page[pagename][slidername]
		end
		Page[pagename].addTextBox=function(textboxname,textboxdefault,callback)
			local Holder=Instance.new"Frame"
			local Title=Instance.new"TextLabel"
			local TextBox=Instance.new"TextBox"
			local Corner=Instance.new"UICorner"
			local HolderCorner=Instance.new"UICorner"
			local callback=callback or function()end
			Holder.Name="TextBoxHolder"
			Holder.Parent=Home
			Holder.BackgroundColor3=toRGB(0x111111)
			Holder.BorderColor3=toRGB(0x111010)
			Holder.BorderSizePixel=0
			Holder.Position=UDim2.new(.0167785231,0,0,0)
			Holder.Size=UDim2.new(0,288,0,26)
			Title.Name="TextBoxTitle"
			Title.Parent=Holder
			Title.BackgroundColor3=toRGB(0x111111)
			Title.BackgroundTransparency=1
			Title.BorderColor3=toRGB(0x111111)
			Title.BorderSizePixel=0
			Title.Position=UDim2.new(.024305556,0,.07692308,0)
			Title.Size=UDim2.new(0,195,0,21)
			Title.Font=guiFont
			Title.Text=textboxname
			Title.TextColor3=toRGB(0xFFFFFF)
			Title.TextSize=11
			Title.TextXAlignment=Enum.TextXAlignment.Left
			TextBox.Parent=Holder
			TextBox.BackgroundColor3=toRGB(0x50505)
			TextBox.Position=UDim2.new(.725694418,0,.115384623,0)
			TextBox.Size=UDim2.new(0,72,0,20)
			TextBox.Font=guiFont
			TextBox.Text=textboxdefault or""
			TextBox.TextColor3=toRGB(0xFFFFFF)
			TextBox.ClearTextOnFocus=false
			TextBox.TextWrapped=true
			TextBox.TextSize=9
			Corner.CornerRadius=UDim.new(0,5)
			Corner.Name="TextBoxCorner"
			Corner.Parent=TextBox
			HolderCorner.CornerRadius=UDim.new(0,5)
			HolderCorner.Name="TextBoxHolderCorner"
			HolderCorner.Parent=Holder
			TextBox.Focused:Connect(function()
				Holder.BackgroundColor3=toRGB(0xA0A0A)
			end)
			TextBox.FocusLost:Connect(function()
				Holder.BackgroundColor3=toRGB(0x111111)
				pcall(callback,TextBox.Text)
			end)
			Page[pagename][textboxname]={}
			Page[pagename][textboxname].remove=function()
				Holder:Destroy()
			end
			Page[pagename][textboxname].setText=function(t)
				Title.Text=tostring(t)or""
			end
			Page[pagename][textboxname].setValue=function(t)
				TextBox.Text=t
				pcall(callback,t)
			end
			return Page[pagename][textboxname]
		end
		Page[pagename].addDropdown=function(dropdownname,list,scrollsize,callback)
			local Holder=Instance.new"Frame"
			local HolderCorner=Instance.new"UICorner"
			local Title=Instance.new"TextLabel"
			local Button=Instance.new"TextButton"
			local Icon=Instance.new"ImageLabel"
			local Container=Instance.new"Frame"
			local ContainerCorner=Instance.new"UICorner"
			local OptionContainer=Instance.new"ScrollingFrame"
			local OptionContainerLayout=Instance.new"UIListLayout"
			local callback=callback or function()end
			local Enabled=false
			Holder.Name="DropdownHolder"
			Holder.Parent=Home
			Holder.BackgroundColor3=toRGB(0x111111)
			Holder.BorderColor3=toRGB(0x111111)
			Holder.BorderSizePixel=0
			Holder.Position=UDim2.new(.0167785231,0,0,0)
			Holder.Size=UDim2.new(0,288,0,26)
			HolderCorner.CornerRadius=UDim.new(0,5)
			HolderCorner.Name="DropdownHolderCorner"
			HolderCorner.Parent=Holder
			Title.Name="DropdownTitle"
			Title.Parent=Holder
			Title.BackgroundColor3=toRGB(0x111111)
			Title.BackgroundTransparency=1
			Title.BorderColor3=toRGB(0x111111)
			Title.BorderSizePixel=0
			Title.Position=UDim2.new(.024305556,0,0,0)
			Title.Size=UDim2.new(0,195,0,24)
			Title.Font=guiFont
			Title.Text=dropdownname
			Title.TextColor3=toRGB(0xFFFFFF)
			Title.TextSize=11
			Title.TextXAlignment=Enum.TextXAlignment.Left
			Button.Name="DropdownButton"
			Button.Parent=Holder
			Button.BackgroundColor3=toRGB(0xFFFFFF)
			Button.BackgroundTransparency=1
			Button.Size=UDim2.new(0,288,0,26)
			Button.Font=Enum.Font.SourceSans
			Button.Text=""
			Button.TextColor3=toRGB(0)
			Button.TextSize=14
			Icon.Name="DropdownIcon"
			Icon.Parent=Button
			Icon.BackgroundTransparency=1
			Icon.Position=UDim2.new(.885416687,0,.192307711,0)
			Icon.Size=UDim2.new(0,24,0,16)
			Icon.Image="rbxassetid://3944690667"
			Icon.ScaleType=Enum.ScaleType.Fit
			Container.Name="DropdownContainer"
			Container.Parent=Holder
			Container.Active=true
			Container.BackgroundColor3=toRGB(0x111111)
			Container.BorderColor3=toRGB(0x111111)
			Container.BorderSizePixel=0
			Container.ClipsDescendants=true
			Container.Position=UDim2.new(0,0,1.34615386,0)
			Container.Size=UDim2.new(0,288,0,4)
			Container.Visible=false
			ContainerCorner.CornerRadius=UDim.new(0,6)
			ContainerCorner.Name="DropdownContainerCorner"
			ContainerCorner.Parent=Container
			OptionContainer.Name="DropdownOptionContainer"
			OptionContainer.Parent=Container
			OptionContainer.Active=true
			OptionContainer.BackgroundColor3=toRGB(0x111111)
			OptionContainer.BackgroundTransparency=1
			OptionContainer.BorderColor3=toRGB(0x111111)
			OptionContainer.BorderSizePixel=0
			OptionContainer.Position=UDim2.new(0,0,.0782608688,0)
			OptionContainer.Size=UDim2.new(0,288,0,8)
			OptionContainer.Visible=false
			OptionContainer.CanvasSize=UDim2.new(0,0,scrollsize or #list*.2375,0)
			OptionContainer.ScrollBarThickness=5
			OptionContainerLayout.Name="DropdownOptionContainerLayout"
			OptionContainerLayout.Parent=OptionContainer
			OptionContainerLayout.HorizontalAlignment=Enum.HorizontalAlignment.Center
			OptionContainerLayout.SortOrder=Enum.SortOrder.LayoutOrder
			OptionContainerLayout.Padding=UDim.new(0,5)
			local function makeelements(bool)
				for i,v in pairs(Home:GetChildren())do
					if v:IsA"Frame"and v~=Holder then
						v.Visible=bool
					end
				end
			end
			Button.MouseButton1Down:Connect(function()
				if Enabled then
					Enabled=false
					Icon.ImageColor3=toRGB(0xFFFFFF)
					OptionContainer:TweenSize(UDim2.new(0,288,0,8),"Out","Linear",.2)
					task.wait(.2)
					OptionContainer.Visible=false
					Container:TweenSize(UDim2.new(0,288,0,4),"Out","Linear",.3)
					task.wait(.3)
					makeelements(true)
					Container.Visible=false
					task.wait(.09)
					Container:TweenSize(UDim2.new(0,288,0,4),"Out","Linear",.1)
					OptionContainer:TweenSize(UDim2.new(0,288,0,8),"Out","Linear",.1)
				else
					Enabled=true
					makeelements(false)
					Container.Visible=true
					Container:TweenSize(UDim2.new(0,288,0,115),"Out","Linear",.3)
					Icon.ImageColor3=toRGB(0x89F6FF)
					task.wait(.3)
					OptionContainer.Visible=true
					OptionContainer:TweenSize(UDim2.new(0,288,0,106),"Out","Linear",.2)
					task.wait(.09)
					Home.CanvasPosition=Vector2.new(0,0)
					Container:TweenSize(UDim2.new(0,288,0,115),"Out","Linear",.1)
					OptionContainer:TweenSize(UDim2.new(0,288,0,106),"Out","Linear",.1)
				end
			end)
			for i,v in pairs(list)do
				local Option=Instance.new"TextButton"
				local OptionCorner=Instance.new"UICorner"
				Option.Name="Option"
				Option.Parent=OptionContainer
				Option.BackgroundColor3=toRGB(0xF0F0F)
				Option.BorderColor3=toRGB(0xF0F0F)
				Option.Position=UDim2.new(.017361112,0,0,0)
				Option.Size=UDim2.new(0,283,0,22)
				Option.AutoButtonColor=false
				Option.Font=guiFont
				Option.Text=v
				Option.TextColor3=toRGB(0xFFFFFF)
				Option.TextSize=10
				OptionCorner.CornerRadius=UDim.new(0,6)
				OptionCorner.Name="OptionCorner"
				OptionCorner.Parent=Option
				Option.MouseEnter:Connect(function()
					Option.BackgroundColor3=toRGB(0xA0A0A)
				end)
				Option.MouseLeave:Connect(function()
					Option.BackgroundColor3=toRGB(0xF0F0F)
				end)
				Option.MouseButton1Down:Connect(function()
					for i,v in pairs(Option.Parent:GetChildren())do
						if v:IsA"GuiButton"and v~=Option then
							v.TextColor3=toRGB(0xFFFFFF)
						end
					end
					Option.TextColor3=toRGB(0x89F6FF)
				end)
				Option.MouseButton1Down:Connect(function()
					Enabled=false
					Icon.ImageColor3=toRGB(0xFFFFFF)
					OptionContainer:TweenSize(UDim2.new(0,288,0,8),"Out","Linear",.2)
					task.wait(.2)
					OptionContainer.Visible=false
					Container:TweenSize(UDim2.new(0,288,0,4),"Out","Linear",.3)
					pcall(callback,v)
					task.wait(.3)
					makeelements(true)
					Container.Visible=false
					Container:TweenSize(UDim2.new(0,288,0,4),"Out","Linear",.1)
					OptionContainer:TweenSize(UDim2.new(0,288,0,8),"Out","Linear",.1)
				end)
			end
			Page[pagename][dropdownname]={}
			Page[pagename][dropdownname].remove=function()
				Holder:Destroy()
			end
			Page[pagename][dropdownname].setText=function(t)
				Title.Text=tostring(t)or""
			end
			Page[pagename][dropdownname].setList=function(newlist,scrollsize)
				for i,v in pairs(OptionContainer:GetChildren())do
					if v.Name=="Option"and v~=OptionContainerLayout then
						v:Destroy()
					end
				end
				OptionContainer.CanvasSize=UDim2.new(0,0,scrollsize or #list*.2375,0)
				for i,v in pairs(newlist)do
					local Option=Instance.new"TextButton"
					local OptionCorner=Instance.new"UICorner"
					Option.Name="Option"
					Option.Parent=OptionContainer
					Option.BackgroundColor3=toRGB(0xF0F0F)
					Option.BorderColor3=toRGB(0xF0F0F)
					Option.Position=UDim2.new(.017361112,0,0,0)
					Option.Size=UDim2.new(0,283,0,22)
					Option.AutoButtonColor=false
					Option.Font=guiFont
					Option.Text=v
					Option.TextColor3=toRGB(0xFFFFFF)
					Option.TextSize=10
					OptionCorner.CornerRadius=UDim.new(0,6)
					OptionCorner.Name="OptionCorner"
					OptionCorner.Parent=Option
					Option.MouseEnter:Connect(function()
						Option.BackgroundColor3=toRGB(0xA0A0A)
					end)
					Option.MouseLeave:Connect(function()
						Option.BackgroundColor3=toRGB(0xF0F0F)
					end)
					Option.MouseButton1Down:Connect(function()
						for i,v in pairs(Option.Parent:GetChildren())do
							if v:IsA"GuiButton"and v~=Option then
								v.TextColor3=toRGB(0xFFFFFF)
							end
						end
						Option.TextColor3=toRGB(0x89F6FF)
					end)
					Option.MouseButton1Down:Connect(function()
						Enabled=false
						Icon.ImageColor3=toRGB(0xFFFFFF)
						OptionContainer:TweenSize(UDim2.new(0,288,0,8),"Out","Linear",.2)
						task.wait(.2)
						OptionContainer.Visible=false
						Container:TweenSize(UDim2.new(0,288,0,4),"Out","Linear",.3)
						pcall(callback,v)
						task.wait(.3)
						makeelements(true)
						Container.Visible=false
						Container:TweenSize(UDim2.new(0,288,0,4),"Out","Linear",.1)
						OptionContainer:TweenSize(UDim2.new(0,288,0,8),"Out","Linear",.1)
					end)
				end
			end
			return Page[pagename][dropdownname]
		end
		Page[pagename].destroyGui=function(callback)
			if not destroyButton then
				destroyButton=true
				destroyCallback=callback
				Page[pagename].addButton("Destroy Gui",function()
					pcall(callback)
					Gui:Destroy()
				end)
			end
		end
		return Page[pagename]
	end
	return Page
end
return Lib
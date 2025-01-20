--Credits to Bytes#0001
--Modified by github.com/lopenafollower
--Added features by me (github.com/lopenafollower):
-- * Fixed slider on mobile to detect release.
--
-- * Added a "removeGui" button.
--
-- * Converted TabContainer into a ScrollingFrame
--   to accommodate more pages.
--
-- * Added a "toggledefault" parameter for
--   toggles to set it's initial state.
--   Example: page:addToggle("ToggleName", true, callback)
--   -sets the toggle to be checked when the GUI is loaded.
--
-- * Added PageElement methods.
--
-- * Improved callback handling.
--
-- * Revised the default formats.
--
-- * General tidying up and organization.
--
--Documentation:
--Lib:CreateWindow(windowname,windowinfo,scrollsize)
-- * Creates a Window
-- Parameters:
-- * windowname (string)
-- * windowinfo (string)
-- * scrollsize (number)
--  - Total height of the ScrollingFrame
--
--Page:addPage(pagename,scrollsize,visible,elementspacing)
-- * Adds a Page to a window
-- Parameters:
-- * pagename (string)
-- * scrollsize (number)
--  - Total height of the ScrollingFrame
-- * visible (bool)
--  - Decides the initial page that will
--    be shown upon loading.
-- * elementspacing (number)
--  - The padding between elements.
--
-- Methods:
-- Page:rename(string)
--
--PageElements:addLabel(labelname,labelinfo)
-- * Creates a Label
-- Parameters:
-- * labelname (string)
-- * labelinfo (string)
--
-- Methods:
-- Label:remove()
-- Label:setTitle(string)
-- Label:setInfo(string)
--
--PageElements:addButton(buttonname,callback)
-- * Creates a Button
-- Parameters:
-- * buttonname (string)
-- * callback (function)
--
-- Methods:
-- Button:remove()
-- Button:setText(string)
-- Button:call()
--  - calls the function assigned to the button
--
--PageElements:addToggle(togglename,toggledefault,callback)
-- * Creates a Toggle
-- Parameters:
-- * togglename (string)
-- * toggledefault (bool)
--  - The initial state of the toggle.
-- * callback (function)
--
-- Methods:
-- Toggle:remove()
-- Toggle:setText(string)
-- Toggle:setStatus(boolean)
--
--PageElements:addSlider(slidername,minvalue,maxvalue,callback)
-- * Creates a Slider
-- Parameters:
-- * slidername (string)
-- * minvalue (number)
-- * maxvalue (number)
-- * callback (function)
--
-- Methods:
-- Slider:remove()
-- Slider:setText(string)
-- Slider:setMin(number)
--  - Updates the min value of the slider.
-- Slider:setMax(number)
--  - Updates the max value of the slider
-- Slider:setValue(number)
--
--PageElements:addTextBox(textboxname,textboxdefault,callback)
-- * Creates a Textbox
-- Parameters:
-- * textboxname (string)
-- * textboxdefault (string)
--  - The initial value of the textbox.
-- * callback (function)
--
-- Methods:
-- TextBox:remove()
-- TextBox:setText(string)
-- TextBox:setValue(string)
--
--PageElements:addDropdown(dropdownname,list,scrollsize,callback)
-- * Creates a Dropdown
-- Parameters:
-- * dropdownname (string)
-- * list (table)
-- * scrollsize (number)
--  - Total height of the ScrollingFrame
-- * callback (function)
--
-- Methods:
-- Dropdown:remove()
-- Dropdown:setText(string)
-- Dropdown:setList(list,scrollsize)
--
--PageElements:destroyGui(callback)
-- * Creates a Button
-- Parameters:
-- * callback (function)
--  - will fire the callback and destroy the gui
--
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
--
--Window
--	Main
--		:rename()
--		Label
--			methods
--		Button
--			methods
--		Toggle
--			methods
--		Slider
--			methods
--		TextBox
--			methods
--		Dropdown
--			methods
--	Tab2
--		:rename()
--		Button
--			methods
local Version=317
local destroyButton=false
local destroyCallback=function()end
local UIS=game:GetService"UserInputService"
local G=game.CoreGui:FindFirstChild"51e6b58a-772cd11d-27fc1803-22496d1a-43580b73"
if G then
	G.Running.Value=false
end
task.spawn(function()
	print("Gui version: "..Version)
	loadstring(game:HttpGetAsync"https://raw.githubusercontent.com/LopenaFollower/Lua/main/anti%20afk.lua")()
end)
function toRGB(n)
	return Color3.fromRGB(bit32.band(bit32.rshift(n,16),255),bit32.band(bit32.rshift(n,8),255),bit32.band(n,255))
end
local Lib={}
function Lib:CreateWindow(windowname,windowinfo,scrollsize)
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
	Gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
	Gui.ResetOnSpawn=false
	Frame.Parent=Gui
	Frame.BackgroundColor3=toRGB(0x141414)
	Frame.BorderColor3=toRGB(0x141414)
	Frame.BorderSizePixel=0
	Frame.Position=UDim2.new(.289808273,0,.313227266,0)
	Frame.Size=UDim2.new(0,432,0,285)
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
	TabContainer.Active=true
	TabContainer.BackgroundColor3=toRGB(0xF0F0F)
	TabContainer.BackgroundTransparency=1
	TabContainer.BorderColor3=toRGB(0xF0F0F)
	TabContainer.BorderSizePixel=0
	TabContainer.Position=UDim2.new(.0280373823,0,.0391304344,0)
	TabContainer.Size=UDim2.new(0,100,0,214)
	TabContainer.ScrollBarThickness=3
	TabContainer.ScrollBarImageColor3=toRGB(0x50505)
	TabContainer.CanvasSize=UDim2.new(0,0,scrollsize or 1e3,0)
	TabContainer.Visible=true
	TabContainerLayout.Name="TabContainer"
	TabContainerLayout.Parent=TabContainer
	TabContainerLayout.HorizontalAlignment=Enum.HorizontalAlignment.Center
	TabContainerLayout.SortOrder=Enum.SortOrder.LayoutOrder
	TabContainerLayout.Padding=UDim.new(0,8)
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
	Title.Font=Enum.Font.GothamSemibold
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
	YepTitle.Font=Enum.Font.GothamSemibold
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
		wait(.02)
		YepTitle.BackgroundTransparency=.5
		YepTitle.TextTransparency=.3
		Cre.ImageColor3=toRGB(0x89F6FF)
		wait(.02)
		YepTitle.BackgroundTransparency=0
		YepTitle.TextTransparency=0
	end)
	Cre.MouseLeave:Connect(function()
		YepTitle.BackgroundTransparency=.5
		YepTitle.TextTransparency=.3
		wait(.02)
		YepTitle.BackgroundTransparency=.8
		YepTitle.TextTransparency=.5
		Cre.ImageColor3=toRGB(0xFFFFFF)
		wait(.02)
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
		Tab.Font=Enum.Font.GothamSemibold
		Tab.Text=pagename or"nil"
		Tab.TextColor3=toRGB(0xFFFFFF)
		Tab.TextSize=11
		Tab.TextTransparency=.300
		TabCorner.CornerRadius=UDim.new(0,7)
		TabCorner.Name="TabCorner"
		TabCorner.Parent=Tab
		Home.Name="Page"
		Home.Parent=PageFolder
		Home.Active=true
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
		PageLayout.Padding=UDim.new(0,elementspacing or 6)
		Tab.MouseButton1Down:Connect(function()
			Tab.TextSize=9
			for i,v in pairs(PageFolder:GetChildren())do
				v.Visible=false
			end
			wait(.02)
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
		function Page[pagename]:rename(n)
			local name=tostring(n)
			if name:len()>0 then
				Tab.Text=name
			end
		end
		function Page[pagename]:addLabel(labelname,labelinfo)
			local LabelHolder=Instance.new"Frame"
			local LabelHolderCorner=Instance.new"UICorner"
			local LabelTitle=Instance.new"TextLabel"
			local LabelInfo=Instance.new"TextLabel"
			LabelHolder.Name="LabelHolder"
			LabelHolder.Parent=Home
			LabelHolder.BackgroundColor3=toRGB(0x111111)
			LabelHolder.BorderColor3=toRGB(0x111111)
			LabelHolder.BorderSizePixel=0
			LabelHolder.Position=UDim2.new(.0167785231,0,0,0)
			LabelHolder.Size=UDim2.new(0,288,0,26)
			LabelHolderCorner.CornerRadius=UDim.new(0,5)
			LabelHolderCorner.Name="LabelHolderCorner"
			LabelHolderCorner.Parent=LabelHolder
			LabelTitle.Name="LabelTitle"
			LabelTitle.Parent=LabelHolder
			LabelTitle.BackgroundColor3=toRGB(0x111111)
			LabelTitle.BackgroundTransparency=1
			LabelTitle.BorderColor3=toRGB(0x111111)
			LabelTitle.BorderSizePixel=0
			LabelTitle.Size=UDim2.new(0,288,0,15)
			LabelTitle.Font=Enum.Font.GothamSemibold
			LabelTitle.Text=labelname or""
			LabelTitle.TextColor3=toRGB(0xFFFFFF)
			LabelTitle.TextSize=11
			LabelInfo.Name="LabelInfo"
			LabelInfo.Parent=LabelHolder
			LabelInfo.BackgroundColor3=toRGB(0x111111)
			LabelInfo.BackgroundTransparency=1
			LabelInfo.BorderColor3=toRGB(0x111111)
			LabelInfo.BorderSizePixel=0
			LabelInfo.Position=UDim2.new(0,0,.653846145,0)
			LabelInfo.Size=UDim2.new(0,288,0,9)
			LabelInfo.Font=Enum.Font.GothamSemibold
			LabelInfo.Text=labelinfo or""
			LabelInfo.TextColor3=toRGB(0xFFFFFF)
			LabelInfo.TextSize=9
			LabelInfo.TextTransparency=.3
			Page[pagename][labelname]={}
			function Page[pagename][labelname]:remove()
				LabelHolder:Destroy()
			end
			function Page[pagename][labelname]:setTitle(t)
				LabelTitle.Text=tostring(t)or""
			end
			function Page[pagename][labelname]:setInfo(t)
				LabelInfo.Text=tostring(t)or""
			end
			return Page[pagename][labelname]
		end
		function Page[pagename]:addButton(buttonname,callback)
			local ButtonHolder=Instance.new"Frame"
			local ButtonTitle=Instance.new"TextLabel"
			local Button=Instance.new"TextButton"
			local ButtonCorner=Instance.new"UICorner"
			local ButtonHolderCorner=Instance.new"UICorner"
			local callback=callback or function()end
			ButtonHolder.Name="ButtonHolder"
			ButtonHolder.Parent=Home
			ButtonHolder.BackgroundColor3=toRGB(0x111111)
			ButtonHolder.BorderColor3=toRGB(0x111111)
			ButtonHolder.BorderSizePixel=0
			ButtonHolder.Position=UDim2.new(.0167785231,0,0,0)
			ButtonHolder.Size=UDim2.new(0,288,0,26)
			ButtonTitle.Name="ButtonTitle"
			ButtonTitle.Parent=ButtonHolder
			ButtonTitle.BackgroundColor3=toRGB(0x111111)
			ButtonTitle.BackgroundTransparency=1
			ButtonTitle.BorderColor3=toRGB(0x111111)
			ButtonTitle.BorderSizePixel=0
			ButtonTitle.Position=UDim2.new(.024305556,0,0,0)
			ButtonTitle.Size=UDim2.new(0,195,0,24)
			ButtonTitle.Font=Enum.Font.GothamSemibold
			ButtonTitle.Text=buttonname or""
			ButtonTitle.TextColor3=toRGB(0xFFFFFF)
			ButtonTitle.TextSize=11
			ButtonTitle.TextXAlignment=Enum.TextXAlignment.Left
			Button.Name="Button"
			Button.Parent=ButtonHolder
			Button.BackgroundColor3=toRGB(0x50505)
			Button.BackgroundTransparency=0
			Button.BorderColor3=toRGB(0x111111)
			Button.Position=UDim2.new(.8534,0,1.17375305e-06,0)
			Button.Size=UDim2.new(0,34,0,19)
			Button.AutoButtonColor=false
			Button.Font=Enum.Font.SourceSans
			Button.Text="btn"
			Button.TextColor3=toRGB(0xFFFFFF)
			Button.TextSize=11
			ButtonCorner.Name="ButtonCorner"
			ButtonCorner.Parent=Button
			ButtonHolderCorner.CornerRadius=UDim.new(0,5)
			ButtonHolderCorner.Name="ButtonHolderCorner"
			ButtonHolderCorner.Parent=ButtonHolder
			Button.MouseButton1Down:Connect(function()
				Button.TextSize=11
				wait(.1)
				Button.TextSize=14
				pcall(callback)
			end)
			Page[pagename][buttonname]={}
			function Page[pagename][buttonname]:remove()
				ButtonHolder:Destroy()
			end
			function Page[pagename][buttonname]:setText(t)
				Button.Text=tostring(t)or""
			end
			function Page[pagename][buttonname]:call()
				pcall(callback)
			end
			return Page[pagename][buttonname]
		end
		function Page[pagename]:addToggle(togglename,toggledefault,callback)
			local ToggleHolder=Instance.new"Frame"
			local ToggleHolderCorner=Instance.new"UICorner"
			local ToggleTitle=Instance.new"TextLabel"
			local ToggleButton=Instance.new"TextButton"
			local ToggleFrame=Instance.new"Frame"
			local ToggleFrameCorner=Instance.new"UICorner"
			local ToggleBall=Instance.new"Frame"
			local ToggleBallCorner=Instance.new"UICorner"
			local callback=callback or function()end
			local ToggleEnabled=toggledefault or false
			ToggleHolder.Name="ToggleHolder"
			ToggleHolder.Parent=Home
			ToggleHolder.BackgroundColor3=toRGB(0x111111)
			ToggleHolder.BorderColor3=toRGB(0x111111)
			ToggleHolder.BorderSizePixel=0
			ToggleHolder.Position=UDim2.new(.0167785231,0,0,0)
			ToggleHolder.Size=UDim2.new(0,288,0,26)
			ToggleHolderCorner.CornerRadius=UDim.new(0,5)
			ToggleHolderCorner.Name="ToggleHolderCorner"
			ToggleHolderCorner.Parent=ToggleHolder
			ToggleTitle.Name="ToggleTitle"
			ToggleTitle.Parent=ToggleHolder
			ToggleTitle.BackgroundColor3=toRGB(0x111111)
			ToggleTitle.BackgroundTransparency=1
			ToggleTitle.BorderColor3=toRGB(0x111111)
			ToggleTitle.BorderSizePixel=0
			ToggleTitle.Position=UDim2.new(.024305556,0,0,0)
			ToggleTitle.Size=UDim2.new(0,195,0,24)
			ToggleTitle.Font=Enum.Font.GothamSemibold
			ToggleTitle.Text=togglename or""
			ToggleTitle.TextColor3=toRGB(0xFFFFFF)
			ToggleTitle.TextSize=11
			ToggleTitle.TextXAlignment=Enum.TextXAlignment.Left
			ToggleButton.Name="ToggleButton"
			ToggleButton.Parent=ToggleHolder
			ToggleButton.BackgroundColor3=toRGB(0x111111)
			ToggleButton.BackgroundTransparency=1
			ToggleButton.BorderColor3=toRGB(0x111111)
			ToggleButton.Position=UDim2.new(.802083313,0,1.17375305e-06,0)
			ToggleButton.Size=UDim2.new(0,57,0,25)
			ToggleButton.AutoButtonColor=false
			ToggleButton.Font=Enum.Font.SourceSans
			ToggleButton.Text=""
			ToggleButton.TextColor3=toRGB(0)
			ToggleButton.TextSize=14
			ToggleFrame.Name="ToggleFrame"
			ToggleFrame.Parent=ToggleButton
			ToggleFrame.BackgroundColor3=toRGB(0x50505)
			ToggleFrame.BorderColor3=toRGB(0x50505)
			ToggleFrame.Position=UDim2.new(.27192983,0,.12,0)
			ToggleFrame.Size=UDim2.new(0,34,0,19)
			ToggleFrameCorner.Name="ToggleFrameCorner"
			ToggleFrameCorner.Parent=ToggleFrame
			ToggleBall.Name="ToggleBall"
			ToggleBall.Parent=ToggleFrame
			ToggleBall.BackgroundColor3=toRGB(0xFFFFFF)
			ToggleBall.Position=UDim2.new(.123,0,.158,0)
			ToggleBall.Size=UDim2.new(0,14,0,12)
			ToggleBallCorner.CornerRadius=UDim.new(0,100)
			ToggleBallCorner.Name="ToggleBallCorner"
			ToggleBallCorner.Parent=ToggleBall
			local function check()
				if ToggleEnabled then
					ToggleBall:TweenPosition(UDim2.new(.455,0,.158,0),"Out","Linear",.1)
				else
					ToggleBall:TweenPosition(UDim2.new(.123,0,.158,0),"Out","Linear",.1)
				end
				pcall(callback,ToggleEnabled)
			end
			ToggleButton.MouseButton1Down:Connect(function()
				ToggleEnabled=not ToggleEnabled
				check()
			end)
			check()
			Page[pagename][togglename]={}
			function Page[pagename][togglename]:remove()
				ToggleHolder:Destroy()
			end
			function Page[pagename][togglename]:setText(t)
				ToggleTitle.Text=tostring(t)or""
			end
			function Page[pagename][togglename]:setStatus(b)
				if type(b)=="boolean"then
					ToggleEnabled=b
					check()
				end
			end
			return Page[pagename][togglename]
		end
		function Page[pagename]:addSlider(slidername,minvalue,maxvalue,callback)
			local SliderHolder=Instance.new"Frame"
			local SliderTitle=Instance.new"TextLabel"
			local SliderHolderScript=Instance.new"UICorner"
			local SliderButton=Instance.new"TextButton"
			local SliderButtonCorner=Instance.new"UICorner"
			local SliderTrail=Instance.new"Frame"
			local SliderTrailCorner=Instance.new"UICorner"
			local SliderNumber=Instance.new"TextLabel"
			local minvalue=math.min(minvalue,maxvalue)
			local maxvalue=math.max(minvalue,maxvalue)
			local callback=callback or function()end
			SliderHolder.Name="SliderHolder"
			SliderHolder.Parent=Home
			SliderHolder.BackgroundColor3=toRGB(0x111111)
			SliderHolder.BorderColor3=toRGB(0x111010)
			SliderHolder.BorderSizePixel=0
			SliderHolder.Position=UDim2.new(.0167785231,0,0,0)
			SliderHolder.Size=UDim2.new(0,288,0,26)
			SliderTitle.Name="SliderTitle"
			SliderTitle.Parent=SliderHolder
			SliderTitle.BackgroundColor3=toRGB(0x111111)
			SliderTitle.BackgroundTransparency=1
			SliderTitle.BorderColor3=toRGB(0x111111)
			SliderTitle.BorderSizePixel=0
			SliderTitle.Position=UDim2.new(.024305556,0,.15384616,0)
			SliderTitle.Size=UDim2.new(0,239,0,8)
			SliderTitle.Font=Enum.Font.GothamSemibold
			SliderTitle.Text=slidername
			SliderTitle.TextColor3=toRGB(0xFFFFFF)
			SliderTitle.TextSize=11
			SliderTitle.TextXAlignment=Enum.TextXAlignment.Left
			SliderHolderScript.CornerRadius=UDim.new(0,5)
			SliderHolderScript.Name="SliderHolderScript"
			SliderHolderScript.Parent=SliderHolder
			SliderButton.Name="SliderButton"
			SliderButton.Parent=SliderHolder
			SliderButton.BackgroundColor3=toRGB(0x50505)
			SliderButton.BorderColor3=toRGB(0xF0F0F)
			SliderButton.BorderSizePixel=0
			SliderButton.Position=UDim2.new(0,8,0,17)
			SliderButton.Size=UDim2.new(0,273,0,10)
			SliderButton.AutoButtonColor=false
			SliderButton.Font=Enum.Font.SourceSans
			SliderButton.Text=""
			SliderButton.TextColor3=toRGB(0)
			SliderButton.TextSize=14
			SliderButtonCorner.Name="SliderButtonCorner"
			SliderButtonCorner.Parent=SliderButton
			SliderTrail.Name="SliderTrail"
			SliderTrail.Parent=SliderButton
			SliderTrail.BackgroundColor3=toRGB(0x282828)
			SliderTrail.BorderColor3=toRGB(0x282828)
			SliderTrail.Size=UDim2.new(0,10,0,10)
			SliderTrailCorner.Name="SliderTrailCorner"
			SliderTrailCorner.Parent=SliderTrail
			SliderNumber.Name="SliderNumber"
			SliderNumber.Parent=SliderHolder
			SliderNumber.BackgroundColor3=toRGB(0x111111)
			SliderNumber.BackgroundTransparency=1
			SliderNumber.BorderColor3=toRGB(0x111111)
			SliderNumber.BorderSizePixel=0
			SliderNumber.Position=UDim2.new(.885,0,.192,1)
			SliderNumber.Size=UDim2.new(0,33,0,6)
			SliderNumber.Font=Enum.Font.GothamSemibold
			SliderNumber.Text=minvalue or 0
			SliderNumber.TextColor3=toRGB(0xFFFFFF)
			SliderNumber.TextSize=10
			SliderNumber.TextXAlignment=Enum.TextXAlignment.Left
			local mouse=game.Players.LocalPlayer:GetMouse()
			local Value,dragInput,released,held
			--fixed slider for mobile
			local function update()
				Value=math.floor((((tonumber(maxvalue)-tonumber(minvalue))/273)*SliderTrail.AbsoluteSize.X)+tonumber(minvalue))or 0
				pcall(callback,SliderNumber.Text)
				SliderTrail.Size=UDim2.new(0,math.clamp(mouse.X-SliderTrail.AbsolutePosition.X,0,273),0,7)
			end
			SliderButton.InputBegan:Connect(function(input)
				if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
					held=true
					update()
					released=input.Changed:Connect(function()
						if input.UserInputState==Enum.UserInputState.End then
							held=false
							update()
							SliderHolder.BackgroundColor3=toRGB(0x111111)
							released:Disconnect()
						end
					end)
				end
			end)
			SliderButton.InputChanged:Connect(function(input)
				if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then
					dragInput=input
				end
			end)
			UIS.InputChanged:Connect(function(input)
				if input==dragInput and held then
					SliderNumber.Text=Value
					update()
					SliderHolder.BackgroundColor3=toRGB(0xE0E0E)
				end
			end)
			Page[pagename][slidername]={}
			function Page[pagename][slidername]:remove()
				SliderHolder:Destroy()
			end
			function Page[pagename][slidername]:setText(t)
				SliderTitle.Text=tostring(t)or""
			end
			function Page[pagename][slidername]:setMin(t)
				minvalue=tonumber(t)
			end
			function Page[pagename][slidername]:setMax(t)
				maxvalue=tonumber(t)
			end
			function Page[pagename][slidername]:setValue(t)
				local i=tonumber(t)
				if type(i)=="number"and i<=maxvalue and i>=minvalue then
					Value=i
					SliderNumber.Text=Value
					pcall(callback,SliderNumber.Text)
				end
			end
			return Page[pagename][slidername]
		end
		function Page[pagename]:addTextBox(textboxname,textboxdefault,callback)
			local TextBoxHolder=Instance.new"Frame"
			local TextBoxTitle=Instance.new"TextLabel"
			local TextBox=Instance.new"TextBox"
			local TextBoxCorner=Instance.new"UICorner"
			local TextBoxHolderCorner=Instance.new"UICorner"
			local callback=callback or function()end
			TextBoxHolder.Name="TextBoxHolder"
			TextBoxHolder.Parent=Home
			TextBoxHolder.BackgroundColor3=toRGB(0x111111)
			TextBoxHolder.BorderColor3=toRGB(0x111010)
			TextBoxHolder.BorderSizePixel=0
			TextBoxHolder.Position=UDim2.new(.0167785231,0,0,0)
			TextBoxHolder.Size=UDim2.new(0,288,0,26)
			TextBoxTitle.Name="TextBoxTitle"
			TextBoxTitle.Parent=TextBoxHolder
			TextBoxTitle.BackgroundColor3=toRGB(0x111111)
			TextBoxTitle.BackgroundTransparency=1
			TextBoxTitle.BorderColor3=toRGB(0x111111)
			TextBoxTitle.BorderSizePixel=0
			TextBoxTitle.Position=UDim2.new(.024305556,0,.0769230798,0)
			TextBoxTitle.Size=UDim2.new(0,195,0,21)
			TextBoxTitle.Font=Enum.Font.GothamSemibold
			TextBoxTitle.Text=textboxname
			TextBoxTitle.TextColor3=toRGB(0xFFFFFF)
			TextBoxTitle.TextSize=11
			TextBoxTitle.TextXAlignment=Enum.TextXAlignment.Left
			TextBox.Parent=TextBoxHolder
			TextBox.BackgroundColor3=toRGB(0x50505)
			TextBox.Position=UDim2.new(.725694418,0,.115384623,0)
			TextBox.Size=UDim2.new(0,72,0,20)
			TextBox.Font=Enum.Font.GothamSemibold
			TextBox.Text=textboxdefault or"nil"
			TextBox.TextColor3=toRGB(0xFFFFFF)
			TextBox.TextSize=9
			TextBoxCorner.CornerRadius=UDim.new(0,5)
			TextBoxCorner.Name="TextBoxCorner"
			TextBoxCorner.Parent=TextBox
			TextBoxHolderCorner.CornerRadius=UDim.new(0,5)
			TextBoxHolderCorner.Name="TextBoxHolderCorner"
			TextBoxHolderCorner.Parent=TextBoxHolder
			TextBox.Focused:Connect(function()
				TextBoxHolder.BackgroundColor3=toRGB(0xA0A0A)
			end)
			TextBox.FocusLost:Connect(function()
				TextBoxHolder.BackgroundColor3=toRGB(0x111111)
				pcall(callback,TextBox.Text)
			end)
			Page[pagename][textboxname]={}
			function Page[pagename][textboxname]:remove()
				TextBoxHolder:Destroy()
			end
			function Page[pagename][textboxname]:setText(t)
				TextBoxTitle.Text=tostring(t)or""
			end
			function Page[pagename][textboxname]:setValue(t)
				TextBox.Text=t
				pcall(callback,TextBox.Text)
			end
			return Page[pagename][textboxname]
		end
		function Page[pagename]:addDropdown(dropdownname,list,scrollsize,callback)
			local DropdownHolder=Instance.new"Frame"
			local DropdownHolderCorner=Instance.new"UICorner"
			local DropdownTitle=Instance.new"TextLabel"
			local DropdownButton=Instance.new"TextButton"
			local DropdownIcon=Instance.new"ImageLabel"
			local DropdownContainer=Instance.new"Frame"
			local DropdownContainerCorner=Instance.new"UICorner"
			local DropdownOptionContainer=Instance.new"ScrollingFrame"
			local DropdownOptionContainerLayout=Instance.new"UIListLayout"
			local callback=callback or function()end
			local DropDownEnabled=false
			DropdownHolder.Name="DropdownHolder"
			DropdownHolder.Parent=Home
			DropdownHolder.BackgroundColor3=toRGB(0x111111)
			DropdownHolder.BorderColor3=toRGB(0x111111)
			DropdownHolder.BorderSizePixel=0
			DropdownHolder.Position=UDim2.new(.0167785231,0,0,0)
			DropdownHolder.Size=UDim2.new(0,288,0,26)
			DropdownHolderCorner.CornerRadius=UDim.new(0,5)
			DropdownHolderCorner.Name="DropdownHolderCorner"
			DropdownHolderCorner.Parent=DropdownHolder
			DropdownTitle.Name="DropdownTitle"
			DropdownTitle.Parent=DropdownHolder
			DropdownTitle.BackgroundColor3=toRGB(0x111111)
			DropdownTitle.BackgroundTransparency=1
			DropdownTitle.BorderColor3=toRGB(0x111111)
			DropdownTitle.BorderSizePixel=0
			DropdownTitle.Position=UDim2.new(.024305556,0,0,0)
			DropdownTitle.Size=UDim2.new(0,195,0,24)
			DropdownTitle.Font=Enum.Font.GothamSemibold
			DropdownTitle.Text=dropdownname
			DropdownTitle.TextColor3=toRGB(0xFFFFFF)
			DropdownTitle.TextSize=11
			DropdownTitle.TextXAlignment=Enum.TextXAlignment.Left
			DropdownButton.Name="DropdownButton"
			DropdownButton.Parent=DropdownHolder
			DropdownButton.BackgroundColor3=toRGB(0xFFFFFF)
			DropdownButton.BackgroundTransparency=1
			DropdownButton.Size=UDim2.new(0,288,0,26)
			DropdownButton.Font=Enum.Font.SourceSans
			DropdownButton.Text=""
			DropdownButton.TextColor3=toRGB(0)
			DropdownButton.TextSize=14
			DropdownIcon.Name="DropdownIcon"
			DropdownIcon.Parent=DropdownButton
			DropdownIcon.BackgroundTransparency=1
			DropdownIcon.Position=UDim2.new(.885416687,0,.192307711,0)
			DropdownIcon.Size=UDim2.new(0,24,0,16)
			DropdownIcon.Image="rbxassetid://3944690667"
			DropdownIcon.ScaleType=Enum.ScaleType.Fit
			DropdownContainer.Name="DropdownContainer"
			DropdownContainer.Parent=DropdownHolder
			DropdownContainer.Active=true
			DropdownContainer.BackgroundColor3=toRGB(0x111111)
			DropdownContainer.BorderColor3=toRGB(0x111111)
			DropdownContainer.BorderSizePixel=0
			DropdownContainer.ClipsDescendants=true
			DropdownContainer.Position=UDim2.new(0,0,1.34615386,0)
			DropdownContainer.Size=UDim2.new(0,288,0,4)
			DropdownContainer.Visible=false
			DropdownContainerCorner.CornerRadius=UDim.new(0,6)
			DropdownContainerCorner.Name="DropdownContainerCorner"
			DropdownContainerCorner.Parent=DropdownContainer
			DropdownOptionContainer.Name="DropdownOptionContainer"
			DropdownOptionContainer.Parent=DropdownContainer
			DropdownOptionContainer.Active=true
			DropdownOptionContainer.BackgroundColor3=toRGB(0x111111)
			DropdownOptionContainer.BackgroundTransparency=1
			DropdownOptionContainer.BorderColor3=toRGB(0x111111)
			DropdownOptionContainer.BorderSizePixel=0
			DropdownOptionContainer.Position=UDim2.new(0,0,.0782608688,0)
			DropdownOptionContainer.Size=UDim2.new(0,288,0,8)
			DropdownOptionContainer.Visible=false
			DropdownOptionContainer.CanvasSize=UDim2.new(0,0,scrollsize or 5,0)
			DropdownOptionContainer.ScrollBarThickness=5
			DropdownOptionContainerLayout.Name="DropdownOptionContainerLayout"
			DropdownOptionContainerLayout.Parent=DropdownOptionContainer
			DropdownOptionContainerLayout.HorizontalAlignment=Enum.HorizontalAlignment.Center
			DropdownOptionContainerLayout.SortOrder=Enum.SortOrder.LayoutOrder
			DropdownOptionContainerLayout.Padding=UDim.new(0,5)
			local function makeelements(bool)
				for i,v in pairs(Home:GetChildren())do
					if v:IsA"Frame"and v~=DropdownHolder then
						v.Visible=bool
					end
				end
			end
			DropdownButton.MouseButton1Down:Connect(function()
				if DropDownEnabled==false then
					DropDownEnabled=true
					makeelements(false)
					DropdownContainer.Visible=true
					DropdownContainer:TweenSize(UDim2.new(0,288,0,115),"Out","Linear",.3)
					DropdownIcon.ImageColor3=toRGB(0x89F6FF)
					wait(.3)
					DropdownOptionContainer.Visible=true
					DropdownOptionContainer:TweenSize(UDim2.new(0,288,0,106),"Out","Linear",.2)
					wait(.09)
					Home.CanvasPosition=Vector2.new(0,0)
					DropdownContainer:TweenSize(UDim2.new(0,288,0,115),"Out","Linear",.1)
					DropdownOptionContainer:TweenSize(UDim2.new(0,288,0,106),"Out","Linear",.1)
				else
					DropDownEnabled=false
					DropdownIcon.ImageColor3=toRGB(0xFFFFFF)
					DropdownOptionContainer:TweenSize(UDim2.new(0,288,0,8),"Out","Linear",.2)
					wait(.2)
					DropdownOptionContainer.Visible=false
					DropdownContainer:TweenSize(UDim2.new(0,288,0,4),"Out","Linear",.3)
					wait(.3)
					makeelements(true)
					DropdownContainer.Visible=false
					wait(.09)
					DropdownContainer:TweenSize(UDim2.new(0,288,0,4),"Out","Linear",.1)
					DropdownOptionContainer:TweenSize(UDim2.new(0,288,0,8),"Out","Linear",.1)
				end
			end)
			for i,v in pairs(list)do
				local Option=Instance.new"TextButton"
				local OptionCorner=Instance.new"UICorner"
				Option.Name="Option"
				Option.Parent=DropdownOptionContainer
				Option.BackgroundColor3=toRGB(0xF0F0F)
				Option.BorderColor3=toRGB(0xF0F0F)
				Option.Position=UDim2.new(.0173611119,0,0,0)
				Option.Size=UDim2.new(0,283,0,22)
				Option.AutoButtonColor=false
				Option.Font=Enum.Font.GothamSemibold
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
					DropDownEnabled=false
					DropdownIcon.ImageColor3=toRGB(0xFFFFFF)
					DropdownOptionContainer:TweenSize(UDim2.new(0,288,0,8),"Out","Linear",.2)
					wait(.2)
					DropdownOptionContainer.Visible=false
					DropdownContainer:TweenSize(UDim2.new(0,288,0,4),"Out","Linear",.3)
					pcall(callback,v)
					wait(.3)
					makeelements(true)
					DropdownContainer.Visible=false
					DropdownContainer:TweenSize(UDim2.new(0,288,0,4),"Out","Linear",.1)
					DropdownOptionContainer:TweenSize(UDim2.new(0,288,0,8),"Out","Linear",.1)
				end)
			end
			Page[pagename][dropdownname]={}
			function Page[pagename][dropdownname]:remove()
				DropdownHolder:Destroy()
			end
			function Page[pagename][dropdownname]:setText(t)
				DropdownTitle.Text=tostring(t)or""
			end
			function Page[pagename][dropdownname]:setList(newlist,scrollsize)
				for i,v in pairs(DropdownOptionContainer:GetChildren())do
					if v.Name=="Option"and v~=DropdownOptionContainerLayout then
						v:Destroy()
					end
				end
				DropdownOptionContainer.CanvasSize=UDim2.new(0,0,scrollsize or 5,0)
				for i,v in pairs(newlist)do
					local Option=Instance.new"TextButton"
					local OptionCorner=Instance.new"UICorner"
					Option.Name="Option"
					Option.Parent=DropdownOptionContainer
					Option.BackgroundColor3=toRGB(0xF0F0F)
					Option.BorderColor3=toRGB(0xF0F0F)
					Option.Position=UDim2.new(.0173611119,0,0,0)
					Option.Size=UDim2.new(0,283,0,22)
					Option.AutoButtonColor=false
					Option.Font=Enum.Font.GothamSemibold
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
						DropDownEnabled=false
						DropdownIcon.ImageColor3=toRGB(0xFFFFFF)
						DropdownOptionContainer:TweenSize(UDim2.new(0,288,0,8),"Out","Linear",.2)
						wait(.2)
						DropdownOptionContainer.Visible=false
						DropdownContainer:TweenSize(UDim2.new(0,288,0,4),"Out","Linear",.3)
						pcall(callback,v)
						wait(.3)
						makeelements(true)
						DropdownContainer.Visible=false
						DropdownContainer:TweenSize(UDim2.new(0,288,0,4),"Out","Linear",.1)
						DropdownOptionContainer:TweenSize(UDim2.new(0,288,0,8),"Out","Linear",.1)
					end)
				end
			end
			return Page[pagename][dropdownname]
		end
		function Page[pagename]:destroyGui(callback)
			if not destroyButton then
				destroyButton=true
				destroyCallback=callback
				Page[pagename]:addButton("Destroy Gui",function()
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
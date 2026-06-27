-- ==========================================================
-- 【独立UI】：qwq踏空 (等比缩放 / 2:3分块 / 完美防重版)
-- ==========================================================

local CoreGui = (gethui and gethui()) or game:GetService("CoreGui")
local GuiName = "QWQ_AirWalk_Standalone_UI"

-- 1. 防重复机制
local existingGui = CoreGui:FindFirstChild(GuiName)
if existingGui then
    existingGui:Destroy()
end

-- 2. 创建主 GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = GuiName
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

-- 主框架 (基础尺寸 80x50)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 80, 0, 50)
MainFrame.Position = UDim2.new(0.5, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true 
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = MainFrame

-- 【核心】：UIScale 控制全局等比缩放 (包括字体、圆角全部同步)
local UIScale = Instance.new("UIScale")
UIScale.Scale = 1.0
UIScale.Parent = MainFrame

-- ==================== 第一块 (顶部控制条 15px) ====================
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(0, 80, 0, 15)
TopBar.BackgroundTransparency = 1
TopBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 40, 0, 15)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "qwq踏空"
Title.TextColor3 = Color3.fromRGB(138, 174, 114) -- 抹茶绿
Title.Font = Enum.Font.SourceSansBold
Title.TextScaled = true 
Title.Parent = TopBar

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 20, 0, 15)
MinBtn.Position = UDim2.new(0, 40, 0, 0)
MinBtn.BackgroundTransparency = 1
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinBtn.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 20, 0, 15)
CloseBtn.Position = UDim2.new(0, 60, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.Parent = TopBar

local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(0, 80, 0, 1)
Divider.Position = UDim2.new(0, 0, 0, 15)
Divider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame

-- ==================== 第二块 (2:3 分割控制区) ====================
local ToggleVisBtn = Instance.new("TextButton")
ToggleVisBtn.Size = UDim2.new(0, 32, 0, 34)
ToggleVisBtn.Position = UDim2.new(0, 0, 0, 16)
ToggleVisBtn.BackgroundTransparency = 1
ToggleVisBtn.Text = "显块"
ToggleVisBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
ToggleVisBtn.Font = Enum.Font.SourceSansBold
ToggleVisBtn.TextSize = 12
ToggleVisBtn.Parent = MainFrame

local VDivider = Instance.new("Frame")
VDivider.Size = UDim2.new(0, 1, 0, 24)
VDivider.Position = UDim2.new(0, 32, 0, 21)
VDivider.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
VDivider.BorderSizePixel = 0
VDivider.Parent = MainFrame

local ToggleWalkBtn = Instance.new("TextButton")
ToggleWalkBtn.Size = UDim2.new(0, 47, 0, 34) 
ToggleWalkBtn.Position = UDim2.new(0, 33, 0, 16)
ToggleWalkBtn.BackgroundTransparency = 1
ToggleWalkBtn.Text = "开启"
ToggleWalkBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
ToggleWalkBtn.Font = Enum.Font.SourceSansBold
ToggleWalkBtn.TextSize = 14
ToggleWalkBtn.Parent = MainFrame

-- ==================== 右下角缩放手柄 ====================
local ResizeGrip = Instance.new("TextButton")
ResizeGrip.Size = UDim2.new(0, 15, 0, 15)
ResizeGrip.Position = UDim2.new(1, -15, 1, -15) -- 贴紧右下角
ResizeGrip.BackgroundTransparency = 1
ResizeGrip.Text = "↘"
ResizeGrip.TextColor3 = Color3.fromRGB(120, 120, 120)
ResizeGrip.TextSize = 10
ResizeGrip.ZIndex = 10 -- 保证在最上层防遮挡
ResizeGrip.Parent = MainFrame


-- ==================== 踏空底层核心逻辑 ====================
local AirWalk_Enabled = false
local AirWalk_Visible = false
local AirWalk_Part = nil
local AirWalk_Conn = nil
local CurrentY = 0

local function StopAirWalk()
    if AirWalk_Conn then AirWalk_Conn:Disconnect() AirWalk_Conn = nil end
    if AirWalk_Part then AirWalk_Part:Destroy() AirWalk_Part = nil end
end

local function StartAirWalk()
    StopAirWalk()
    local char = game:GetService("Players").LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    CurrentY = hrp and (hrp.Position.Y - 3.5) or 0

    AirWalk_Part = Instance.new("Part")
    AirWalk_Part.Name = "QWQ_AirWalk_Platform"
    AirWalk_Part.Size = Vector3.new(15, 1, 15) 
    AirWalk_Part.Anchored = true
    AirWalk_Part.CanCollide = true
    AirWalk_Part.Material = Enum.Material.Neon
    AirWalk_Part.Color = Color3.fromRGB(135, 206, 235) 
    AirWalk_Part.Transparency = AirWalk_Visible and 0.5 or 1 
    AirWalk_Part.Parent = workspace

    AirWalk_Conn = game:GetService("RunService").Heartbeat:Connect(function()
        if not ScreenGui.Parent then StopAirWalk() return end
        if not AirWalk_Enabled then return end

        local c_hrp = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if c_hrp then
            local velY = c_hrp.Velocity.Y
            if velY > 0.5 then
                AirWalk_Part.CFrame = CFrame.new(c_hrp.Position.X, CurrentY, c_hrp.Position.Z)
            else
                if (c_hrp.Position.Y - 3.5) > CurrentY + 0.5 then
                    CurrentY = c_hrp.Position.Y - 3.5
                end
                AirWalk_Part.CFrame = CFrame.new(c_hrp.Position.X, CurrentY, c_hrp.Position.Z)
            end
        end
    end)
end

-- ==================== 按钮交互逻辑 ====================
ToggleVisBtn.Activated:Connect(function()
    AirWalk_Visible = not AirWalk_Visible
    if AirWalk_Visible then
        ToggleVisBtn.Text = "隐块"
        ToggleVisBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        if AirWalk_Part then AirWalk_Part.Transparency = 0.5 end
    else
        ToggleVisBtn.Text = "显块"
        ToggleVisBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
        if AirWalk_Part then AirWalk_Part.Transparency = 1 end
    end
end)

ToggleWalkBtn.Activated:Connect(function()
    AirWalk_Enabled = not AirWalk_Enabled
    if AirWalk_Enabled then
        ToggleWalkBtn.Text = "关闭"
        ToggleWalkBtn.TextColor3 = Color3.fromRGB(0, 200, 255)
        StartAirWalk()
    else
        ToggleWalkBtn.Text = "开启"
        ToggleWalkBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        StopAirWalk()
    end
end)

local isMinimized = false
MinBtn.Activated:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame.Size = UDim2.new(0, 80, 0, 15)
        MinBtn.Text = "+"
        ResizeGrip.Visible = false -- 最小化时隐藏缩放按钮
    else
        MainFrame.Size = UDim2.new(0, 80, 0, 50)
        MinBtn.Text = "-"
        ResizeGrip.Visible = true
    end
end)

CloseBtn.Activated:Connect(function()
    StopAirWalk()
    ScreenGui:Destroy()
end)

-- ==================== 全局拖拽与缩放引擎 ====================
local UserInputService = game:GetService("UserInputService")
local dragging = false
local resizing = false
local dragStart, startPos, startScale, dragInput

-- 【缩放事件绑定】
ResizeGrip.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = true
        dragStart = input.Position
        startScale = UIScale.Scale
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                resizing = false
            end
        end)
    end
end)

-- 【拖拽事件绑定】
MainFrame.InputBegan:Connect(function(input)
    -- 如果点的是缩放键，就不要触发拖拽
    if resizing then return end 
    
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
        
        if resizing then
            -- X轴的移动量来决定放大倍率 (基础宽80px)
            local deltaX = input.Position.X - dragStart.X
            local newScale = startScale + (deltaX / 80)
            -- 限制最小倍率 1.0 (80x50)，最大倍率 1.375 (110x68.75)
            UIScale.Scale = math.clamp(newScale, 1.0, 1.375)
            
        elseif dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end
end)

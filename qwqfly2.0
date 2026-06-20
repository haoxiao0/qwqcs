-- =================================================================
-- 极简真·双端飞行悬浮窗 (无缝像素级完美对齐 + 强力物理深层清洗 终极全修版)
-- =================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- 销毁旧的，防止多开卡死
if game.CoreGui:FindFirstChild("FlySuspensionMain") then
    game.CoreGui.FlySuspensionMain:Destroy()
end

-- ==========================================
-- 1. UI 实例构建 (全分数级高精度数学对齐)
-- ==========================================
local main = Instance.new("ScreenGui")
main.Name = "FlySuspensionMain"
main.Parent = game.CoreGui
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 主背景框 (初始 180 x 50)
local Frame = Instance.new("Frame")
Frame.Parent = main
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.1, 0, 0.4, 0)
Frame.Size = UDim2.new(0, 180, 0, 50)
Frame.Active = true

-- 区域划分线 
local DivLine = Instance.new("Frame")
DivLine.Parent = Frame
DivLine.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
DivLine.BorderSizePixel = 0
DivLine.Position = UDim2.new(0, 0, 12/50, 0)
DivLine.Size = UDim2.new(1, 0, 0, 1)

-- 【第一区域 (高度固定占比 12/50)】
local Area1 = Instance.new("Frame")
Area1.Name = "TopArea"
Area1.Parent = Frame
Area1.BackgroundTransparency = 1
Area1.Size = UDim2.new(1, 0, 12/50, 0)

-- 区块1：作者水印 (qwqfiy)
local TextLabel = Instance.new("TextLabel")
TextLabel.Parent = Area1
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.Size = UDim2.new(40/180, 0, 1, 0)
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.Text = "qwqfiy"
TextLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
TextLabel.TextScaled = true

-- 区块2：飞行速度显示
local speedText = Instance.new("TextLabel")
speedText.Parent = Area1
speedText.BackgroundTransparency = 1
speedText.Position = UDim2.new(40/180, 0, 0, 0)
speedText.Size = UDim2.new(40/180, 0, 1, 0)
speedText.Font = Enum.Font.SourceSansBold
speedText.Text = "SPD: 50"
speedText.TextColor3 = Color3.fromRGB(85, 255, 127)
speedText.TextScaled = true

-- 区块4：最小化按钮 (-)
local minBtn = Instance.new("TextButton")
minBtn.Parent = Area1
minBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
minBtn.BorderSizePixel = 0
minBtn.Position = UDim2.new(140/180, 0, 0, 0)
minBtn.Size = UDim2.new(20/180, 0, 1, 0)
minBtn.Font = Enum.Font.SourceSansBold
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.TextScaled = true

-- 区块5：关闭按钮 (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = Area1
closeBtn.BackgroundColor3 = Color3.fromRGB(140, 20, 20)
closeBtn.BorderSizePixel = 0
closeBtn.Position = UDim2.new(160/180, 0, 0, 0)
closeBtn.Size = UDim2.new(20/180, 0, 1, 0)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true

-- 【第二区域 (下方功能区)】
local Area2 = Instance.new("Frame")
Area2.Parent = Frame
Area2.BackgroundTransparency = 1
Area2.Position = UDim2.new(0, 0, 12/50, 0)
Area2.Size = UDim2.new(1, 0, 38/50, 0)

local function setBtnStyle(btn, text, bgCol)
    btn.BackgroundColor3 = bgCol
    btn.BorderSizePixel = 0 
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(230, 230, 230)
    btn.TextScaled = true
end

local up = Instance.new("TextButton", Area2)
up.Position = UDim2.new(0, 0, 0, 0)
up.Size = UDim2.new(55/180, 0, 0.5, 0)
setBtnStyle(up, "上升", Color3.fromRGB(52, 52, 52))

local down = Instance.new("TextButton", Area2)
down.Position = UDim2.new(0, 0, 0.5, 0)
down.Size = UDim2.new(55/180, 0, 0.5, 0)
setBtnStyle(down, "下降", Color3.fromRGB(48, 48, 48))

local plus = Instance.new("TextButton", Area2)
plus.Position = UDim2.new(55/180, 0, 0, 0)
plus.Size = UDim2.new(55/180, 0, 0.5, 0)
setBtnStyle(plus, "加速", Color3.fromRGB(58, 58, 58))

local mine = Instance.new("TextButton", Area2)
mine.Position = UDim2.new(55/180, 0, 0.5, 0)
mine.Size = UDim2.new(55/180, 0, 0.5, 0)
setBtnStyle(mine, "减速", Color3.fromRGB(54, 54, 54))

local onof = Instance.new("TextButton", Area2)
onof.Position = UDim2.new(110/180, 0, 0, 0)
onof.Size = UDim2.new(70/180, 0, 1, 0)
setBtnStyle(onof, "开启飞行", Color3.fromRGB(0, 90, 45))


-- ==========================================
-- 2. 交互系统：手势自适应双端精细拖拽引擎
-- ==========================================
local frameDragging = false
local frameDragStart = nil
local frameStartPos = nil

local draggingRight = false
local draggingBottom = false
local resizeDragStart = nil
local frameStartSize = nil

local function onDragBegan(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if draggingRight or draggingBottom then return end
        frameDragging = true
        frameDragStart = input.Position
        frameStartPos = Frame.Position
    end
end

Frame.InputBegan:Connect(onDragBegan)
minBtn.InputBegan:Connect(onDragBegan)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if frameDragging and frameDragStart then
            local delta = input.Position - frameDragStart
            Frame.Position = UDim2.new(
                frameStartPos.X.Scale, 
                frameStartPos.X.Offset + delta.X, 
                frameStartPos.Y.Scale, 
                frameStartPos.Y.Offset + delta.Y
            )
        elseif draggingRight and resizeDragStart then
            local delta = input.Position - resizeDragStart
            local newWidth = math.clamp(frameStartSize + delta.X, 180, 220)
            Frame.Size = UDim2.new(0, newWidth, 0, Frame.Size.Y.Offset)
        elseif draggingBottom and resizeDragStart then
            local delta = input.Position - resizeDragStart
            local newHeight = math.clamp(frameStartSize + delta.Y, 50, 70)
            Frame.Size = UDim2.new(0, Frame.Size.X.Offset, 0, newHeight)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        frameDragging = false
        draggingRight = false
        draggingBottom = false
    end
end)


-- ==========================================
-- 3. 动态边缘：加厚 10px 触控条
-- ==========================================
local ResizeRight = Instance.new("ImageButton")
ResizeRight.Name = "ResizeRight"
ResizeRight.Parent = Frame
ResizeRight.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
ResizeRight.BorderSizePixel = 0
ResizeRight.Position = UDim2.new(1, 0, 0, 0)
ResizeRight.Size = UDim2.new(0, 10, 1, 0)
ResizeRight.AutoButtonColor = false

local ResizeBottom = Instance.new("ImageButton")
ResizeBottom.Name = "ResizeBottom"
ResizeBottom.Parent = Frame
ResizeBottom.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
ResizeBottom.BorderSizePixel = 0
ResizeBottom.Position = UDim2.new(0, 0, 1, 0)
ResizeBottom.Size = UDim2.new(1, 10, 0, 10)
ResizeBottom.AutoButtonColor = false

ResizeRight.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingRight = true
        resizeDragStart = input.Position
        frameStartSize = Frame.Size.X.Offset
    end
end)

ResizeBottom.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingBottom = true
        resizeDragStart = input.Position
        frameStartSize = Frame.Size.Y.Offset
    end
end)


-- ==========================================
-- 4. 核心功能：全防错深层物理清洗飞行引擎
-- ==========================================
local flying = false
local flySpeed = 50
local flyConnection = nil

local function stopFly()
    flying = false
    
    -- 异步安全包裹：防止UI已销毁时更改属性报错
    pcall(function()
        if onof and onof.Parent then
            onof.Text = "开启飞行"
            onof.BackgroundColor3 = Color3.fromRGB(0, 90, 45)
        end
    end)
    
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local bv = hrp:FindFirstChild("FlyVelocity")
            local bg = hrp:FindFirstChild("FlyGyro")
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end
            
            -- 【核心缺失修复 1】：瞬间抹除残留物理惯性冲量！防止关闭后角色由于惯性滑翔、飙飞
            pcall(function()
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.Velocity = Vector3.zero -- 兼容Roblox旧版引擎
            end)
        end
        
        local hum = char:FindFirstChild("Humanoid")
        if hum then 
            hum.PlatformStand = false 
            
            -- 【核心缺失修复 2】：强行让角色进入复苏站立状态，击碎人偶物理睡眠，绝不卡空
            pcall(function()
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            end)
        end
    end
end

local function startFly()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then return end
    
    local hrp = char.HumanoidRootPart
    local hum = char.Humanoid
    
    flying = true
    onof.Text = "关闭飞行"
    onof.BackgroundColor3 = Color3.fromRGB(140, 20, 20)
    hum.PlatformStand = true
    
    local bv = Instance.new("BodyVelocity")
    bv.Name = "FlyVelocity"
    bv.MaxForce = Vector3.new(9e4, 9e4, 9e4)
    bv.Velocity = Vector3.zero
    bv.Parent = hrp
    
    local bg = Instance.new("BodyGyro")
    bg.Name = "FlyGyro"
    bg.MaxTorque = Vector3.new(9e4, 9e4, 9e4)
    bg.P = 9e4
    bg.CFrame = hrp.CFrame
    bg.Parent = hrp

    flyConnection = RunService.RenderStepped:Connect(function()
        if not flying or not hum or hum.Health <= 0 or not hrp or not hrp.Parent then 
            stopFly()
            return 
        end
        
        local cam = workspace.CurrentCamera
        local moveDir = hum.MoveDirection
        
        if moveDir.Magnitude > 0 then
            local look = cam.CFrame.LookVector
            local right = cam.CFrame.RightVector
            
            local lookH = Vector3.new(look.X, 0, look.Z)
            local rightH = Vector3.new(right.X, 0, right.Z)
            
            lookH = lookH.Magnitude > 0 and lookH.Unit or Vector3.zero
            rightH = rightH.Magnitude > 0 and rightH.Unit or Vector3.zero
            
            local forwardAmount = moveDir:Dot(lookH)
            local rightAmount = moveDir:Dot(rightH)
            
            local finalFlyDir = (look * forwardAmount + right * rightAmount)
            if finalFlyDir.Magnitude > 0 then finalFlyDir = finalFlyDir.Unit end
            
            bv.Velocity = finalFlyDir * flySpeed
        else
            bv.Velocity = Vector3.zero
        end
        
        bg.CFrame = CFrame.new(hrp.Position, hrp.Position + cam.CFrame.LookVector)
    end)
end


-- ==========================================
-- 5. 优化整合：智能最小化切换与关闭拦截器
-- ==========================================
local isMinimized = false
local preMinSizeX = 180
local preMinSizeY = 50

local function toggleMinimize()
    isMinimized = not isMinimized
    if isMinimized then
        preMinSizeX = Frame.Size.X.Offset
        preMinSizeY = Frame.Size.Y.Offset
        
        TextLabel.Visible = false
        speedText.Visible = false
        closeBtn.Visible = false
        DivLine.Visible = false
        Area2.Visible = false
        ResizeRight.Visible = false
        ResizeBottom.Visible = false
        
        Area1.Size = UDim2.new(1, 0, 1, 0)
        minBtn.Position = UDim2.new(0, 0, 0, 0)
        minBtn.Size = UDim2.new(1, 0, 1, 0)
        
        minBtn.TextScaled = false 
        minBtn.TextSize = 13
        minBtn.Font = Enum.Font.SourceSansBold
        minBtn.Text = "fly"
        
        Frame.Size = UDim2.new(0, 42, 0, 24)
    else
        Frame.Size = UDim2.new(0, preMinSizeX, 0, preMinSizeY)
        Area1.Size = UDim2.new(1, 0, 12/50, 0)
        
        TextLabel.Visible = true
        speedText.Visible = true
        closeBtn.Visible = true
        DivLine.Visible = true
        Area2.Visible = true
        ResizeRight.Visible = true
        ResizeBottom.Visible = true
        
        minBtn.Position = UDim2.new(140/180, 0, 0, 0)
        minBtn.Size = UDim2.new(20/180, 0, 1, 0)
        minBtn.TextScaled = true
        minBtn.Text = "-"
    end
end

minBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if frameDragStart then
            local moveDistance = (input.Position - frameDragStart).Magnitude
            frameDragging = false
            if moveDistance < 8 then
                toggleMinimize()
            end
        end
    end
end)

-- 【核心缺失修复 3】：拔除 if 限制！关闭按钮被激活时，必须无条件把物理组件扒干净
closeBtn.Activated:Connect(function()
    stopFly() 
    main:Destroy()
end)


-- ==========================================
-- 6. 功能键控制信号绑定
-- ==========================================
onof.Activated:Connect(function()
    if flying then stopFly() else startFly() end
end)

plus.Activated:Connect(function()
    flySpeed = flySpeed + 10
    speedText.Text = "SPD: " .. tostring(flySpeed)
end)

mine.Activated:Connect(function()
    if flySpeed <= 10 then
        speedText.Text = "SPD: MIN"
        task.wait(0.8)
        speedText.Text = "SPD: " .. tostring(flySpeed)
    else
        flySpeed = flySpeed - 10
        speedText.Text = "SPD: " .. tostring(flySpeed)
    end
end)

up.Activated:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 4, 0)
    end
end)

down.Activated:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, -4, 0)
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    stopFly()
end)

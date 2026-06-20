-- Gui to Lua -- Version: 3.2
local main = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local up = Instance.new("TextButton")
local down = Instance.new("TextButton")
local onof = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local plus = Instance.new("TextButton")
local speed = Instance.new("TextLabel")
local mine = Instance.new("TextButton")

--Properties:
main.Name = "main"
main.Parent = game.CoreGui
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = main
Frame.BackgroundColor3 = Color3.fromRGB(163, 255, 137)
Frame.BorderColor3 = Color3.fromRGB(103, 221, 213)
Frame.Position = UDim2.new(0.100320168, 0, 0.379746825, 0)
Frame.Size = UDim2.new(0, 190, 0, 57)
Frame.Active = true
Frame.Draggable = true -- 允许在手机/电脑上自由拖动UI位置

up.Name = "up"
up.Parent = Frame
up.BackgroundColor3 = Color3.fromRGB(79, 255, 152)
up.Size = UDim2.new(0, 44, 0, 28)
up.Font = Enum.Font.SourceSans
up.Text = "上升"
up.TextColor3 = Color3.fromRGB(0, 0, 0)
up.TextSize = 14.000

down.Name = "down"
down.Parent = Frame
down.BackgroundColor3 = Color3.fromRGB(215, 255, 121)
down.Position = UDim2.new(0, 0, 0.491228074, 0)
down.Size = UDim2.new(0, 44, 0, 28)
down.Font = Enum.Font.SourceSans
down.Text = "下降"
down.TextColor3 = Color3.fromRGB(0, 0, 0)
down.TextSize = 14.000

onof.Name = "onof"
onof.Parent = Frame
onof.BackgroundColor3 = Color3.fromRGB(255, 249, 74)
onof.Position = UDim2.new(0.702823281, 0, 0.491228074, 0)
onof.Size = UDim2.new(0, 56, 0, 28)
onof.Font = Enum.Font.SourceSans
onof.Text = "飞行"
onof.TextColor3 = Color3.fromRGB(0, 0, 0)
onof.TextSize = 14.000

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(242, 60, 255)
TextLabel.Position = UDim2.new(0.469327301, 0, 0, 0)
TextLabel.Size = UDim2.new(0, 100, 0, 28)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "qwq.fly"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

plus.Name = "plus"
plus.Parent = Frame
plus.BackgroundColor3 = Color3.fromRGB(133, 145, 255)
plus.Position = UDim2.new(0.231578946, 0, 0, 0)
plus.Size = UDim2.new(0, 45, 0, 28)
plus.Font = Enum.Font.SourceSans
plus.Text = "加速"
plus.TextColor3 = Color3.fromRGB(0, 0, 0)
plus.TextScaled = true
plus.TextSize = 14.000
plus.TextWrapped = true

speed.Name = "speed"
speed.Parent = Frame
speed.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
speed.Position = UDim2.new(0.468421042, 0, 0.491228074, 0)
speed.Size = UDim2.new(0, 44, 0, 28)
speed.Font = Enum.Font.SourceSans
speed.Text = "50"
speed.TextColor3 = Color3.fromRGB(0, 0, 0)
speed.TextScaled = true
speed.TextSize = 14.000
speed.TextWrapped = true

mine.Name = "mine"
mine.Parent = Frame
mine.BackgroundColor3 = Color3.fromRGB(123, 255, 247)
mine.Position = UDim2.new(0.231578946, 0, 0.491228074, 0)
mine.Size = UDim2.new(0, 45, 0, 29)
mine.Font = Enum.Font.SourceSans
mine.Text = "减速"
mine.TextColor3 = Color3.fromRGB(0, 0, 0)
mine.TextScaled = true
mine.TextSize = 14.000
mine.TextWrapped = true

-- ==========================================
-- 核心全平台真飞行引擎 (双端兼容架构)
-- ==========================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local flying = false
local flySpeed = 50 -- 初始速度设置为50较适合物理推力
local flyConnection = nil

local function stopFly()
    flying = false
    onof.Text = "飞行"
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
        end
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            hum.PlatformStand = false
        end
    end
end

local function startFly()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then return end
    
    local hrp = char.HumanoidRootPart
    local hum = char.Humanoid
    
    flying = true
    onof.Text = "关闭"
    hum.PlatformStand = true -- 浮空挂起，阻止地面摩擦力干扰
    
    -- 建立物理驱动
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

    -- 双端核心心跳主循环
    flyConnection = RunService.RenderStepped:Connect(function()
        -- 安全拦截断联
        if not flying or not hum or hum.Health <= 0 or not hrp or not hrp.Parent then 
            stopFly()
            return 
        end
        
        local cam = workspace.CurrentCamera
        local moveDir = hum.MoveDirection -- 自动读取：手机轮盘输入 或 电脑WASD输入
        
        if moveDir.Magnitude > 0 then
            local look = cam.CFrame.LookVector
            local right = cam.CFrame.RightVector
            
            -- 计算相机的水平分量
            local lookH = Vector3.new(look.X, 0, look.Z)
            local rightH = Vector3.new(right.X, 0, right.Z)
            
            lookH = lookH.Magnitude > 0 and lookH.Unit or Vector3.zero
            rightH = rightH.Magnitude > 0 and rightH.Unit or Vector3.zero
            
            -- 【全平台黑科技数学解算】：利用点积反推出玩家按键或摇杆推力往哪个方向
            local forwardAmount = moveDir:Dot(lookH)
            local rightAmount = moveDir:Dot(rightH)
            
            -- 将计算出的控制比重，注入到相机真正的 3D 全空间向量中 (达成看天往上飞)
            local finalFlyDir = (look * forwardAmount + right * rightAmount)
            if finalFlyDir.Magnitude > 0 then
                finalFlyDir = finalFlyDir.Unit
            end
            
            bv.Velocity = finalFlyDir * flySpeed
        else
            -- 没有任何操作时，死死悬停定死在空中，不漂移
            bv.Velocity = Vector3.zero
        end
        
        -- 让身体平滑地锁定面朝镜头的方向
        bg.CFrame = CFrame.new(hrp.Position, hrp.Position + cam.CFrame.LookVector)
    end)
end

-- ==========================================
-- UI 交互区 (升级为全平台无断触兼容的 Activated 事件)
-- ==========================================

onof.Activated:Connect(function()
    if flying then
        stopFly()
    else
        startFly()
    end
end)

plus.Activated:Connect(function()
    flySpeed = flySpeed + 10
    speed.Text = tostring(flySpeed)
end)

mine.Activated:Connect(function()
    if flySpeed <= 10 then
        speed.Text = "已最小"
        task.wait(1)
        speed.Text = tostring(flySpeed)
    else
        flySpeed = flySpeed - 10
        speed.Text = tostring(flySpeed)
    end
end)

up.Activated:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
    end
end)

down.Activated:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, -5, 0)
    end
end)

-- 重生/角色重置安全防御
LocalPlayer.CharacterAdded:Connect(function()
    stopFly()
end)

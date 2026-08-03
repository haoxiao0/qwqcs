local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/haoxiao0/qwqcs/refs/heads/main/qwqui1.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/haoxiao0/qwqcs/refs/heads/main/qwqui2.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/haoxiao0/qwqcs/refs/heads/main/qwqui3.lua"))()

local Window = Fluent:CreateWindow({
    Title = "QWQ你敢把脚本给别人我弄死你",
    SubTitle = "7.3(更新了死亡之后传送回死亡地点)",
    TabWidth = 100,
    Size = UDim2.fromOffset(450, 350),
    Acrylic = true,
    Theme = "Sunset",
    MinimizeKey = Enum.KeyCode.LeftControl
})


local Tabs = {
    Qwqe = Window:AddTab({ Title = "QwQ", Icon = "rbxassetid://104508482519186" }),
    Qwqa = Window:AddTab({ Title = "功能", Icon = "rbxassetid://104508482519186" }),
    Player = Window:AddTab({ Title = "人物", Icon = "rbxassetid://104508482519186" }),
    ESP = Window:AddTab({ Title = "ESP", Icon = "rbxassetid://104508482519186" }),
    NPC_ESP = Window:AddTab({ Title = "NPC.EPS", Icon = "rbxassetid://104508482519186" }),
    clickbot = Window:AddTab({ Title = "自动扳机", Icon = "rbxassetid://104508482519186" }),
    Aimbot = Window:AddTab({ Title = "自瞄", Icon = "rbxassetid://104508482519186" }),
    Teleport = Window:AddTab({ Title = "传送", Icon = "rbxassetid://104508482519186" }),
    FOV = Window:AddTab({ Title = "视角", Icon = "rbxassetid://104508482519186" }),
    HITBOX = Window:AddTab({ Title = "碰撞箱", Icon = "rbxassetid://104508482519186" }),
    World = Window:AddTab({ Title = "世界", Icon = "rbxassetid://104508482519186" }),
    Tool = Window:AddTab({ Title = "实用工具", Icon = "rbxassetid://104508482519186" }),
    Interact = Window:AddTab({ Title = "互动(gj)", Icon = "rbxassetid://87761482164390" }),
    Main = Window:AddTab({ Title = "测试功能", Icon = "rbxassetid://104508482519186" }),
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()
local Options = Fluent.Options
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local Camera = Workspace.CurrentCamera
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalizationService = game:GetService("LocalizationService")
local LocalPlayer = Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local lplr = game.Players.LocalPlayer
local lplr = Players.LocalPlayer



    




--杂项变量
local platform = nil
local savedPositions = {}
local soundMuted = false
local autoCollectEnabled = false
local autoCollectRange = 20
local characterScale = 1
local freeCamEnabled = false
local soundBoost = 1
local zoomEnabled = false
local fullBrightEnabled = false
local superSprintEnabled = false
local hitboxEnabled = false
local hitboxSize = 5
local hitboxTransparency = 0.7
local hitboxColor = Color3.fromRGB(255, 0, 0)
local hitbox_original_properties = {}
local modifyConnection = nil
local flingFrequency = 0.3
local isFlinging = false
local lightBrightness = 1
local lightRange = 150
local lightColor = Color3.fromRGB(255, 255, 255)

--ESP
local ESP = {
    Boxes = {},
    Rays = {},
    Highlights = {},
    HealthBars = {},
    Names = {},
    Distances = {},
    Coords = {}
}

--传送变量
local isTeleporting = false
local targetPlayerName = nil
local targetPlayer = nil
local teleportFrequency = 0.01
local lastTeleportTime = 0
local teleportOnDeath = false
local teleportDistance = 5
local teleportDirection = "中"
local lastPlatform = nil
local isCircling = false
local circleAngle = 0
local circleSpeed = 1
local isSpectating = false
local spectateConnection = nil
local isFlinging = false
local flingPower = 100
local lastFlingTime = 0
local flingFrequency = 0.05
local suctionConnection = nil
local suctionEnabled = false
local suctionOffset = Vector3.new(-3, 0, 0)
local originalStates = {}

--Aimbot变量
local GlobalAimbotEnabled = false
local SingleAimbotEnabled = false
local AimbotTeamCheck = false
local AimbotWallCheck = true
local AimbotFOVRadius = 100
local AimbotSmoothness = 0.4
local AimbotRainbowFOV = false
local AimbotFOVColor = Color3.fromRGB(0, 255, 0)
local AimbotTargetPart = "HumanoidRootPart" -- 默认锁定身体qwq
local targetSinglePlayer = nil
local targetSinglePlayerName = nil
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
-- ==========================================
-- 黑名单系统核心变量
-- ==========================================
local AimbotBlacklistEnabled = false
local AimbotBlacklist = {}
local targetAddName = ""
local targetRemoveName = ""

-- 动态刷新黑名单下拉列表的函数
local function UpdateBlacklistDropdown()
    local list = #AimbotBlacklist > 0 and AimbotBlacklist or {"无玩家"}
    if Options.BlacklistListDropdown then
        Options.BlacklistListDropdown:SetValues(list)
        if #AimbotBlacklist > 0 and not table.find(AimbotBlacklist, Options.BlacklistListDropdown.Value) then
            Options.BlacklistListDropdown:SetValue(AimbotBlacklist[1])
        elseif #AimbotBlacklist == 0 then
            Options.BlacklistListDropdown:SetValue("无玩家")
        end
    end
end




--Hitbox
local hitboxEnabled = false
local hitboxSize = 5
local hitboxTransparency = 0.7
local hitboxColor = Color3.fromRGB(255, 0, 0)
local hitbox_original_properties = {}
local hitboxTeamCheck = false
local hitboxShape = "Box"
local hitboxMaterial = Enum.Material.Neon
local hitboxTargetSpecific = false
local hitboxSpecificPlayerName
local hitboxSpecificPlayer

-- ==========================================
-- QwQ栏目：自定义路径透视高亮功能 (10秒自动刷新版)
-- ==========================================
Tabs.Qwqe:AddParagraph({
    Title = "路径透视高亮 (自动刷新版)",
    Content = "输入物体或文件夹的完整路径。开启后将每隔 10 秒自动扫描一次，自动为新刷出的物体套上透视。\n例如: workspace.Map.Chests"
})

local HighlightInput = Tabs.Qwqe:AddInput("HighlightPathInput", {
    Title = "目标路径",
    Default = "workspace",
    Placeholder = "请输入完整的路径...",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        -- 仅用来接收输入
    end
})

-- 用一个表格来存我们生成的高亮外框，方便随时删除
local activeHighlights = {}
local highlightThread = nil -- 用来控制10秒循环的线程句柄

local function clearCustomHighlights()
    for _, hl in ipairs(activeHighlights) do
        if hl and hl.Parent then
            hl:Destroy()
        end
    end
    table.clear(activeHighlights)
end

Tabs.Qwqe:AddToggle("HighlightPathToggle", {
    Title = "透视高亮开关",
    Default = false,
    Callback = function(state)
        if state then
            -- 开启前先清理掉旧的
            clearCustomHighlights()
            
            -- 【核心升级】利用 task.spawn 创建一个独立的后台循环线程
            highlightThread = task.spawn(function()
                local isFirstRun = true -- 标记是否是第一次运行
                
                while true do
                    local pathStr = Options.HighlightPathInput.Value
                    
                    -- 解析路径
                    local success, targetInst = pcall(function()
                        local func = loadstring("return " .. pathStr)
                        return func and func() or nil
                    end)

                    if success and typeof(targetInst) == "Instance" then
                        local items = targetInst:GetDescendants()
                        table.insert(items, targetInst) 
                        
                        local newAddedCount = 0
                        for _, obj in ipairs(items) do
                            if obj:IsA("BasePart") or obj:IsA("Model") then
                                -- 【关键优化】只对没有CustomHighlight标记的新物体进行高亮，防止重复创建导致掉帧和闪烁
                                if not obj:FindFirstChild("CustomHighlight") then
                                    local hl = Instance.new("Highlight")
                                    hl.Name = "CustomHighlight"
                                    hl.FillColor = Color3.fromRGB(0, 255, 128) -- 薄荷绿
                                    hl.FillTransparency = 0.6
                                    hl.OutlineColor = Color3.fromRGB(255, 255, 255) -- 白色外框
                                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                                    hl.Parent = obj
                                    
                                    table.insert(activeHighlights, hl)
                                    newAddedCount = newAddedCount + 1
                                end
                            end
                        end
                        
                        -- 智能弹窗提示逻辑
                        if isFirstRun then
                            Fluent:Notify({Title = "透视已开启", Content = "已启动10秒自动巡检。初始高亮了 " .. newAddedCount .. " 个物体", Duration = 4})
                            isFirstRun = false
                        elseif newAddedCount > 0 then
                            -- 只有在后续真正检测到新物品刷出来时，才会弹窗提醒你
                            Fluent:Notify({Title = "检测到新物体", Content = "全图巡检自动为 " .. newAddedCount .. " 新物体加上透视+1", Duration = 3})
                        end
                    else
                        -- 首次运行如果路径输错了就直接关闭
                        if isFirstRun then
                            Fluent:Notify({Title = "错误", Content = "路径解析失败！请检查拼写是否正确。", Duration = 4})
                            Options.HighlightPathToggle:SetValue(false)
                            break
                        end
                    end
                    
                    -- 完美的10秒等待延迟
                    task.wait(10)
                end
            end)
        else
            -- 【核心升级】关闭开关时，强制掐断、销毁这个10秒的后台循环线程
            if highlightThread then
                task.cancel(highlightThread)
                highlightThread = nil
            end
            -- 一键删除所有残留的高亮框
            clearCustomHighlights()
        end
    end
})
-- ==========================================


-- ==========================================
-- QwQ栏目新增：自定义路径吸物 / 远程触碰
-- ==========================================
Tabs.Qwqe:AddSection("自定义路径：吸物与触碰")

Tabs.Qwqe:AddInput("ItemPathInput", {
    Title = "目标物品/文件夹路径",
    Default = "workspace",
    Placeholder = "例如: workspace.Map.Drops",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        -- 仅用于接收输入
    end
})

-- 辅助函数：将字符串路径安全解析为游戏内的 Instance 对象
local function getInstanceFromPath(pathStr)
    local success, targetInst = pcall(function()
        local func = loadstring("return " .. pathStr)
        return func and func() or nil
    end)
    if success and typeof(targetInst) == "Instance" then
        return targetInst
    end
    return nil
end

-- 按钮 1：移动单个指定物品到脚下
Tabs.Qwqe:AddButton({
    Title = "移动 [单个指定物品] 到脚下",
    Description = "适用于路径指向的是某个具体的 Part 或 Model",
    Callback = function()
        local pathStr = Options.ItemPathInput.Value
        local targetInst = getInstanceFromPath(pathStr)
        
        if targetInst then
            local char = LocalPlayer.Character
            local rootPart = char and char:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local feetCFrame = rootPart.CFrame * CFrame.new(0, -3, 0)
                pcall(function()
                    if targetInst:IsA("BasePart") then
                        targetInst.CFrame = feetCFrame
                    elseif targetInst:IsA("Model") then
                        targetInst:PivotTo(feetCFrame)
                    end
                end)
                Fluent:Notify({Title = "成功", Content = "已将 " .. targetInst.Name .. " 传送到脚下", Duration = 3})
            end
        else
            Fluent:Notify({Title = "错误", Content = "路径解析失败或该物品不存在！", Duration = 3})
        end
    end
})

-- 按钮 2：批量移动文件夹内所有物品
Tabs.Qwqe:AddButton({
    Title = "批量移动 [文件夹内所有物品] 到脚下",
    Description = "适用于路径指向的是包含大量掉落物的 Folder 或 Model",
    Callback = function()
        local pathStr = Options.ItemPathInput.Value
        local targetInst = getInstanceFromPath(pathStr)
        
        if targetInst then
            local char = LocalPlayer.Character
            local rootPart = char and char:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local feetCFrame = rootPart.CFrame * CFrame.new(0, -3, 0)
                local count = 0
                
                pcall(function()
                    for _, obj in ipairs(targetInst:GetChildren()) do
                        if obj:IsA("BasePart") then
                            obj.CFrame = feetCFrame
                            count = count + 1
                        elseif obj:IsA("Model") then
                            obj:PivotTo(feetCFrame)
                            count = count + 1
                        end
                    end
                end)
                Fluent:Notify({Title = "批量成功", Content = "成功将 " .. count .. " 个物品吸取到脚下", Duration = 3})
            end
        else
            Fluent:Notify({Title = "错误", Content = "路径解析失败或文件夹不存在！", Duration = 3})
        end
    end
})

-- 按钮 3：远程隔空触碰（破解防作弊专用）
Tabs.Qwqe:AddButton({
    Title = "隔空批量触碰 (防拦截推荐)",
    Description = "如果吸过来捡不起来，用这个直接发送物理触碰包捡起",
    Callback = function()
        local pathStr = Options.ItemPathInput.Value
        local targetInst = getInstanceFromPath(pathStr)
        
        if targetInst then
            local char = LocalPlayer.Character
            local myRoot = char and char:FindFirstChild("HumanoidRootPart")
            if myRoot then
                local count = 0
                pcall(function()
                    -- 同时支持传入的是单个物品，还是一个文件夹
                    local items = targetInst:IsA("Folder") and targetInst:GetChildren() or targetInst:GetDescendants()
                    table.insert(items, targetInst) -- 把自身也加进去测一下
                    
                    for _, obj in ipairs(items) do
                        if obj:IsA("BasePart") and obj:FindFirstChildWhichIsA("TouchTransmitter") then
                            firetouchinterest(myRoot, obj, 0)
                            task.wait(0.01)
                            firetouchinterest(myRoot, obj, 1)
                            count = count + 1
                        end
                    end
                end)
                Fluent:Notify({Title = "触碰发送完毕", Content = "共向 " .. count .. " 个物品发送了触碰信号", Duration = 3})
            end
        else
            Fluent:Notify({Title = "错误", Content = "路径解析失败或物体不存在！", Duration = 3})
        end
    end
})
-- ==========================================
-- 下方为功能区
-- ==========================================
-- =============================================================================
-- [UI 实例创建]
-- =============================================================================
local PerformanceGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local FPSLabel = Instance.new("TextLabel")

PerformanceGui.Name = "QWQ_Beautiful_HUD"
PerformanceGui.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
PerformanceGui.ResetOnSpawn = false

-- 面板靠右上角贴边，留出安全间距
MainFrame.Parent = PerformanceGui
MainFrame.BackgroundTransparency = 1
MainFrame.Position = UDim2.new(1, -150, 0, 15)
MainFrame.Size = UDim2.new(0, 135, 0, 30) -- 移除了Ping，高度由60缩减至30

UIListLayout.Parent = MainFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- 统一的高级质感渲染函数
local function configureLabel(label, order)
    label.Size = UDim2.new(1, 0, 0, 24)
    label.BackgroundTransparency = 0.25 -- 适度的半透明玻璃感
    label.BackgroundColor3 = Color3.fromRGB(20, 20, 25) -- 深邃暗蓝底色
    label.Font = Enum.Font.RobotoMono -- 极客感等宽字体
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.Visible = false
    label.LayoutOrder = order
    
    -- 柔和外边框
    local stroke = Instance.new("UIStroke", label)
    stroke.Color = Color3.fromRGB(45, 45, 55)
    stroke.Thickness = 1
    
    -- 圆角剪裁
    local corners = Instance.new("UICorner", label)
    corners.CornerRadius = UDim.new(0, 5)
    
    label.Parent = MainFrame
end

configureLabel(FPSLabel, 1)

-- =============================================================================
-- [动态刷新驱动] 每 0.2 秒高频刷新 FPS
-- =============================================================================
local fpsCount = 0
local lastUpdateTime = os.clock()

RunService.RenderStepped:Connect(function()
    fpsCount = fpsCount + 1
    local now = os.clock()
    
    -- 精确限制为每 0.2 秒刷新一次，保证实时性的同时防止 CPU 异常占用
    if now - lastUpdateTime >= 0.2 then
        
        -- 计算并更新 FPS
        local currentFps = math.floor(fpsCount / (now - lastUpdateTime))
        FPSLabel.Text = "FPS: " .. currentFps
        
        -- 根据帧率健康度动态变色
        if currentFps >= 55 then
            FPSLabel.TextColor3 = Color3.fromRGB(90, 220, 140) -- 极佳：质感绿
        elseif currentFps >= 35 then
            FPSLabel.TextColor3 = Color3.fromRGB(240, 190, 90) -- 警告：温暖黄
        else
            FPSLabel.TextColor3 = Color3.fromRGB(240, 100, 100) -- 极差：警示红
        end
        
        -- 重置计数器和时间
        fpsCount = 0
        lastUpdateTime = now
    end
end)

-- =============================================================================
-- [UI 开关控制对接]
-- =============================================================================
Tabs.Qwqa:AddSection("屏幕贴边数据显示")

Tabs.Qwqa:AddToggle("ShowFPS_Toggle", { 
    Title = "显示帧率 (FPS)", 
    Description = "屏幕右上角显示实时FPS", 
    Default = false, 
    Callback = function(v) FPSLabel.Visible = v end 
})




-- ==========================================================
-- 【功能构建】：踏空行走 (智能阶梯版) + 悬浮快捷控高按钮 (UI兼容修复版)
-- ==========================================================
if Tabs and Tabs.Qwqa then
    Tabs.Qwqa:AddSection("☁️ 踏空行走 (AirWalk)")

    -- 核心状态与缓存
    local QWQ_AirWalk_Enabled = false
    local QWQ_AirWalk_Part = nil
    local QWQ_AirWalk_Connection = nil
    local QWQ_AirWalk_CurrentY = 0
    local QWQ_AirWalk_Size = 8
    local QWQ_AirWalk_Visible = false

    -- 悬浮按钮状态缓存
    local QWQ_MiniBtn_GUI = nil
    local QWQ_MiniBtn = nil
    local QWQ_MiniBtn_State = false -- false=红色(穿透下落) / true=青蓝色(凝冰托底)
    local QWQ_MiniBtn_DragConnections = {}

    -- 【安全核心】：安全获取 UI 容器 (防移动端注入器权限不足导致不弹UI)
    local function GetSafeUIContainer()
        if gethui then
            local s, r = pcall(gethui)
            if s and r then return r end
        end
        local s, r = pcall(function() return game:GetService("CoreGui") end)
        if s and r then return r end
        return LocalPlayer:WaitForChild("PlayerGui")
    end

    -- ==========================================
    -- 1. 悬浮按钮销毁与创建逻辑
    -- ==========================================
    local function DestroyMiniButton()
        if QWQ_MiniBtn_GUI then QWQ_MiniBtn_GUI:Destroy() QWQ_MiniBtn_GUI = nil end
        QWQ_MiniBtn = nil
        QWQ_MiniBtn_State = false
        for _, conn in ipairs(QWQ_MiniBtn_DragConnections) do pcall(function() conn:Disconnect() end) end
        table.clear(QWQ_MiniBtn_DragConnections)
    end

    local function CreateMiniButton()
        DestroyMiniButton()

        QWQ_MiniBtn_GUI = Instance.new("ScreenGui")
        QWQ_MiniBtn_GUI.Name = "QWQ_AirWalk_MiniBtn"
        QWQ_MiniBtn_GUI.Parent = GetSafeUIContainer() -- 使用安全容器
        QWQ_MiniBtn_GUI.ResetOnSpawn = false
        QWQ_MiniBtn_GUI.IgnoreGuiInset = true -- 无视屏幕刘海和顶栏遮挡

        QWQ_MiniBtn = Instance.new("TextButton")
        QWQ_MiniBtn.Parent = QWQ_MiniBtn_GUI
        QWQ_MiniBtn.Size = UDim2.new(0, 25, 0, 25) -- 稍微放大至25px，防手机断触
        -- 往左下方多移动一段距离，避开所有菜单键和排行榜
        QWQ_MiniBtn.Position = UDim2.new(1, -120, 0, 120) 
        QWQ_MiniBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50) -- 初始红色(关闭托底，允许下落)
        QWQ_MiniBtn.BorderSizePixel = 0
        QWQ_MiniBtn.Text = ""
        QWQ_MiniBtn.AutoButtonColor = false

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = QWQ_MiniBtn

        -- 点击切换状态
        QWQ_MiniBtn.Activated:Connect(function()
            QWQ_MiniBtn_State = not QWQ_MiniBtn_State
            if QWQ_MiniBtn_State then
                -- 开启：青蓝色，平台恢复实体
                QWQ_MiniBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
                if QWQ_AirWalk_Part then
                    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then QWQ_AirWalk_CurrentY = hrp.Position.Y - 3.5 end -- 重新锁定当前高度
                    QWQ_AirWalk_Part.CanCollide = true
                    QWQ_AirWalk_Part.Transparency = QWQ_AirWalk_Visible and 0.5 or 1
                end
            else
                -- 关闭：红色，平台隐藏并失去碰撞 (玩家下落)
                QWQ_MiniBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                if QWQ_AirWalk_Part then
                    QWQ_AirWalk_Part.CanCollide = false
                    QWQ_AirWalk_Part.Transparency = 1
                end
            end
        end)

        -- 拖拽逻辑
        local dragging, dragStart, startPos = false, nil, nil
        table.insert(QWQ_MiniBtn_DragConnections, QWQ_MiniBtn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true dragStart = input.Position startPos = QWQ_MiniBtn.Position
            end
        end))
        table.insert(QWQ_MiniBtn_DragConnections, UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                if dragging then
                    local delta = input.Position - dragStart
                    QWQ_MiniBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end
            end
        end))
        table.insert(QWQ_MiniBtn_DragConnections, UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end))
    end

    -- ==========================================
    -- 2. 踏空行走底层逻辑
    -- ==========================================
    local function StopAirWalk()
        if QWQ_AirWalk_Connection then
            QWQ_AirWalk_Connection:Disconnect()
            QWQ_AirWalk_Connection = nil
        end
        if QWQ_AirWalk_Part then
            QWQ_AirWalk_Part:Destroy()
            QWQ_AirWalk_Part = nil
        end
        DestroyMiniButton() -- 停止踏空时，一并销毁小按钮
    end

    local function StartAirWalk()
        StopAirWalk() 
        CreateMiniButton() -- 启动踏空时，生成小按钮
        
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        
        -- 即使是在死亡/加载状态开启功能，也能强行初始化平台
        QWQ_AirWalk_CurrentY = hrp and (hrp.Position.Y - 3.5) or 0

        QWQ_AirWalk_Part = Instance.new("Part")
        QWQ_AirWalk_Part.Name = "QWQ_AirWalk_Platform"
        QWQ_AirWalk_Part.Size = Vector3.new(QWQ_AirWalk_Size, 1, QWQ_AirWalk_Size)
        QWQ_AirWalk_Part.Anchored = true
        QWQ_AirWalk_Part.CanCollide = false -- 初始配合红色按钮，不碰撞
        QWQ_AirWalk_Part.Transparency = 1
        QWQ_AirWalk_Part.Material = Enum.Material.Neon
        QWQ_AirWalk_Part.Color = Color3.fromRGB(135, 206, 235) 
        QWQ_AirWalk_Part.Parent = workspace

        QWQ_AirWalk_Connection = RunService.Heartbeat:Connect(function()
            if not QWQ_AirWalk_Enabled or not QWQ_AirWalk_Part or not QWQ_AirWalk_Part.Parent then
                StopAirWalk() return
            end

            local currentHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if currentHrp then
                -- 只有在小按钮开启(青蓝色)时，才进行阶梯高度运算
                if QWQ_MiniBtn_State then
                    local currentVelocityY = currentHrp.Velocity.Y
                    if currentVelocityY > 0.5 then
                        QWQ_AirWalk_Part.CFrame = CFrame.new(currentHrp.Position.X, QWQ_AirWalk_CurrentY, currentHrp.Position.Z)
                    else
                        if (currentHrp.Position.Y - 3.5) > QWQ_AirWalk_CurrentY + 0.5 then
                            QWQ_AirWalk_CurrentY = currentHrp.Position.Y - 3.5
                        end
                        QWQ_AirWalk_Part.CFrame = CFrame.new(currentHrp.Position.X, QWQ_AirWalk_CurrentY, currentHrp.Position.Z)
                    end
                else
                    -- 红色下落状态，平台只跟随XY，不提供任何高度支撑
                    QWQ_AirWalk_Part.CFrame = CFrame.new(currentHrp.Position.X, currentHrp.Position.Y - 3.5, currentHrp.Position.Z)
                end
            end
        end)
    end

    -- ==========================================
    -- 3. UI 控件绑定 (现在绑定在 Tabs.Qwqa)
    -- ==========================================
    Tabs.Qwqa:AddToggle("QWQ_AirWalk_Toggle", {
        Title = "开启 踏空行走",
        Description = "生成快捷悬浮按钮：红色(下落) / 青蓝色(空中托底)",
        Default = false,
        Callback = function(state)
            QWQ_AirWalk_Enabled = state
            if state then
                StartAirWalk()
            else
                StopAirWalk()
            end
        end
    })

    Tabs.Qwqa:AddToggle("QWQ_AirWalk_Visible", {
        Title = "显示透明脚踏板",
        Description = "开启后，托底状态下能看到脚底的天蓝色判定光环",
        Default = false,
        Callback = function(state)
            QWQ_AirWalk_Visible = state
            if QWQ_AirWalk_Part and QWQ_MiniBtn_State then
                QWQ_AirWalk_Part.Transparency = state and 0.5 or 1
            end
        end
    })

    Tabs.Qwqa:AddSlider("QWQ_AirWalk_Size", {
        Title = "平台安全面积",
        Description = "如果经常漏脚掉下去，可以把面积调大一点",
        Min = 3,
        Max = 100,
        Default = 8,
        Rounding = 0,
        Callback = function(value)
            QWQ_AirWalk_Size = value
            if QWQ_AirWalk_Part then
                QWQ_AirWalk_Part.Size = Vector3.new(value, 1, value)
            end
        end
    })
end

-- ==========================================
-- [功能栏目] 重生后传送至死亡地点 模块 (纯净直连版)
-- ==========================================
local QWQ_DeathTP_Enabled = false
local QWQ_DeathTP_Height = 0.1
local QWQ_DeathTP_Retries = 3
local QWQ_SavedDeathLocation = nil

-- 0. 添加独立的小节标题
Tabs.Qwqa:AddSection("📌 死亡回传机制")

-- 1. 标签
Tabs.Qwqa:AddParagraph({
    Title = "*重生后传送至死亡地点^ω^ *",
    Content = "记录死亡瞬间坐标，重生后自动尝试传送回该位置。"
})

-- 2. 开关
local Toggle_DeathTP = Tabs.Qwqa:AddToggle("Toggle_DeathTP", {
    Title = "开启死亡回传",
    Default = false
})

Toggle_DeathTP:OnChanged(function()
    QWQ_DeathTP_Enabled = Options.Toggle_DeathTP.Value
end)

-- 3. 传送高度输入框 (米/Studs)
local Input_DeathTPHeight = Tabs.Qwqa:AddInput("Input_DeathTPHeight", {
    Title = "抬高高度 (米)",
    Default = "0.1",
    Placeholder = "防止卡进方块，默认0.1",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        local num = tonumber(Value)
        if num then QWQ_DeathTP_Height = num end
    end
})

-- 4. 传送尝试次数滑动条
local Slider_DeathTPRetries = Tabs.Qwqa:AddSlider("Slider_DeathTPRetries", {
    Title = "传送尝试次数",
    Description = "防止单次传送被地图机制打断",
    Default = 3,
    Min = 1,
    Max = 10,
    Rounding = 0,
    Callback = function(Value)
        QWQ_DeathTP_Retries = Value
    end
})

-- 核心逻辑
local function SetupDeathListener(character)
    if not character then return end
    
    task.spawn(function()
        local humanoid = character:WaitForChild("Humanoid", 5)
        local hrp = character:WaitForChild("HumanoidRootPart", 5)

        if humanoid and hrp then
            humanoid.Died:Connect(function()
                if QWQ_DeathTP_Enabled then QWQ_SavedDeathLocation = hrp.Position end
            end)
            humanoid.HealthChanged:Connect(function(health)
                if health <= 0 and QWQ_DeathTP_Enabled then QWQ_SavedDeathLocation = hrp.Position end
            end)
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    SetupDeathListener(newCharacter)
    
    if QWQ_DeathTP_Enabled and QWQ_SavedDeathLocation then
        task.spawn(function()
            local hrp = newCharacter:WaitForChild("HumanoidRootPart", 5)
            if hrp then
                task.wait(0.5)
                for i = 1, QWQ_DeathTP_Retries do
                    if hrp and newCharacter:FindFirstChild("Humanoid") and newCharacter.Humanoid.Health > 0 then
                        hrp.CFrame = CFrame.new(QWQ_SavedDeathLocation + Vector3.new(0, QWQ_DeathTP_Height, 0))
                        task.wait(0.3)
                    else
                        break
                    end
                end
            end
            QWQ_SavedDeathLocation = nil
        end)
    end
end)

if LocalPlayer.Character then
    SetupDeathListener(LocalPlayer.Character)
end
-- ==========================================





-- ==========================================================
-- 【功能构建】：现代亚克力虚拟摇杆 + 独立跳跃键 (完美伪装PC版)
-- ==========================================================
if Tabs and Tabs.Qwqa then
    Tabs.Qwqa:AddSection("🕹️ 虚拟摇杆与按键 (移动端高级移动辅助)")

    -- 【安全核心】：安全获取 UI 容器
    local function GetSafeUIContainer()
        if gethui then
            local s, r = pcall(gethui)
            if s and r then return r end
        end
        local s, r = pcall(function() return game:GetService("CoreGui") end)
        if s and r then return r end
        return LocalPlayer:WaitForChild("PlayerGui")
    end

    -- 1. 创建独立 GUI 容器 (摇杆和跳跃键共用此容器，实现一键同开同关)
    local DPadGui = GetSafeUIContainer():FindFirstChild("QWQ_Joystick_GUI")
    if DPadGui then DPadGui:Destroy() end 
    
    DPadGui = Instance.new("ScreenGui")
    DPadGui.Name = "QWQ_Joystick_GUI"
    DPadGui.Parent = GetSafeUIContainer()
    DPadGui.ResetOnSpawn = false
    DPadGui.Enabled = false -- 初始隐藏

    -- 核心动态尺寸变量
    local BaseSize = 220
    local KnobSize = math.floor(BaseSize * (2/5))
    local LetterLabels = {} 
    
    local JumpBtnSize = 100
    local JumpBtnDraggable = false

    -- ==========================================
    -- 摇杆模块构建
    -- ==========================================
    local JoystickBase = Instance.new("Frame")
    JoystickBase.Name = "JoystickBase"
    JoystickBase.Parent = DPadGui
    JoystickBase.Size = UDim2.new(0, BaseSize, 0, BaseSize)
    JoystickBase.AnchorPoint = Vector2.new(0, 1) 
    JoystickBase.Position = UDim2.new(0, 60, 1, -60) 
    JoystickBase.BackgroundColor3 = Color3.fromRGB(240, 240, 245) 
    JoystickBase.BackgroundTransparency = 0.65 
    JoystickBase.BorderSizePixel = 0
    JoystickBase.Active = true

    local BaseCorner = Instance.new("UICorner")
    BaseCorner.CornerRadius = UDim.new(0, 30) 
    BaseCorner.Parent = JoystickBase

    local BaseStroke = Instance.new("UIStroke")
    BaseStroke.Color = Color3.fromRGB(255, 255, 255)
    BaseStroke.Transparency = 0.5
    BaseStroke.Thickness = 1.5
    BaseStroke.Parent = JoystickBase

    -- 中心圆形分界线 (死区)
    local DeadZoneRadius = BaseSize / 8
    local DeadZoneCircle = Instance.new("Frame")
    DeadZoneCircle.Size = UDim2.new(0, DeadZoneRadius * 2, 0, DeadZoneRadius * 2)
    DeadZoneCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
    DeadZoneCircle.AnchorPoint = Vector2.new(0.5, 0.5)
    DeadZoneCircle.BackgroundTransparency = 1
    DeadZoneCircle.ZIndex = 2
    DeadZoneCircle.Parent = JoystickBase

    local DeadZoneCorner = Instance.new("UICorner")
    DeadZoneCorner.CornerRadius = UDim.new(1, 0)
    DeadZoneCorner.Parent = DeadZoneCircle

    local DeadZoneStroke = Instance.new("UIStroke")
    DeadZoneStroke.Color = Color3.fromRGB(255, 255, 255)
    DeadZoneStroke.Transparency = 0.6
    DeadZoneStroke.Thickness = 1.5
    DeadZoneStroke.Parent = DeadZoneCircle

    -- 绘制方向字母
    local function CreateLetter(text, pos)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1/3, 0, 1/3, 0)
        label.Position = pos
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(220, 220, 220) 
        label.TextTransparency = 0.2 
        label.Font = Enum.Font.SourceSansBold
        label.TextSize = math.floor(BaseSize * 0.16) 
        label.ZIndex = 1 
        label.Parent = JoystickBase
        table.insert(LetterLabels, label)
    end
    CreateLetter("W", UDim2.new(1/3, 0, 0, 0))       
    CreateLetter("S", UDim2.new(1/3, 0, 2/3, 0))     
    CreateLetter("A", UDim2.new(0, 0, 1/3, 0))       
    CreateLetter("D", UDim2.new(2/3, 0, 1/3, 0))     

    -- 中心摇杆球
    local JoystickKnob = Instance.new("Frame")
    JoystickKnob.Name = "JoystickKnob"
    JoystickKnob.Parent = JoystickBase
    JoystickKnob.Size = UDim2.new(0, KnobSize, 0, KnobSize)
    JoystickKnob.AnchorPoint = Vector2.new(0.5, 0.5)
    JoystickKnob.Position = UDim2.new(0.5, 0, 0.5, 0) 
    JoystickKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    JoystickKnob.BackgroundTransparency = 0.2 
    JoystickKnob.BorderSizePixel = 0
    JoystickKnob.ZIndex = 5 

    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0) 
    KnobCorner.Parent = JoystickKnob

    local KnobStroke = Instance.new("UIStroke")
    KnobStroke.Color = Color3.fromRGB(200, 200, 200)
    KnobStroke.Transparency = 0.4
    KnobStroke.Thickness = 2
    KnobStroke.Parent = JoystickKnob

    -- ==========================================
    -- 跳跃键模块构建
    -- ==========================================
    local JumpButton = Instance.new("TextButton")
    JumpButton.Name = "JumpButton"
    JumpButton.Parent = DPadGui
    JumpButton.Size = UDim2.new(0, JumpBtnSize, 0, JumpBtnSize)
    JumpButton.AnchorPoint = Vector2.new(1, 1) -- 锚点设在右下角
    JumpButton.Position = UDim2.new(1, -60, 1, -60) -- 初始靠右下方
    JumpButton.BackgroundColor3 = Color3.fromRGB(240, 240, 245)
    JumpButton.BackgroundTransparency = 0.65 -- 亚克力材质
    JumpButton.BorderSizePixel = 0
    -- 【修改】：添加向上的字符指示
    JumpButton.Text = "▲\nJUMP"
    JumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    JumpButton.TextTransparency = 0.3
    JumpButton.Font = Enum.Font.SourceSansBold
    JumpButton.TextSize = 22
    JumpButton.AutoButtonColor = false
    JumpButton.Active = true

    local JumpCorner = Instance.new("UICorner")
    JumpCorner.CornerRadius = UDim.new(1, 0) 
    JumpCorner.Parent = JumpButton

    local JumpStroke = Instance.new("UIStroke")
    -- 【修改】：灰白色描边，透明度调整为与亚克力板同等 (0.65)
    JumpStroke.Color = Color3.fromRGB(220, 220, 220)
    JumpStroke.Transparency = 0.65
    JumpStroke.Thickness = 1.5
    JumpStroke.Parent = JumpButton

    -- ==========================================
    -- 动态 UI 刷新引擎
    -- ==========================================
    local function UpdateJoystickUI()
        KnobSize = math.floor(BaseSize * (2/5))
        local newDeadZoneRadius = BaseSize / 8

        JoystickBase.Size = UDim2.new(0, BaseSize, 0, BaseSize)
        DeadZoneCircle.Size = UDim2.new(0, newDeadZoneRadius * 2, 0, newDeadZoneRadius * 2)
        JoystickKnob.Size = UDim2.new(0, KnobSize, 0, KnobSize)

        for _, label in ipairs(LetterLabels) do
            label.TextSize = math.floor(BaseSize * 0.16)
        end
    end

    local function UpdateJumpBtnUI()
        JumpButton.Size = UDim2.new(0, JumpBtnSize, 0, JumpBtnSize)
        JumpButton.TextSize = math.floor(JumpBtnSize * 0.22)
    end

    -- ==========================================
    -- 核心：底层物理键盘信号伪装引擎 (VIM)
    -- ==========================================
    local VIM = game:GetService("VirtualInputManager")
    local activeKeys = {}
    
    local draggingJoystick = false
    local dragInputJoystick = nil

    local draggingJump = false
    local dragInputJump = nil
    local dragStartJump = nil
    local startPosJump = nil

    -- 释放所有按键 (摇杆+跳跃)
    local function releaseAllKeys()
        for key, _ in pairs(activeKeys) do
            VIM:SendKeyEvent(false, key, false, game)
        end
        table.clear(activeKeys)
        VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
    end

    local function updateKeys(newKeys)
        for key, _ in pairs(activeKeys) do
            if not table.find(newKeys, key) then
                VIM:SendKeyEvent(false, key, false, game)
                activeKeys[key] = nil
            end
        end
        for _, key in ipairs(newKeys) do
            if not activeKeys[key] then
                VIM:SendKeyEvent(true, key, false, game)
                activeKeys[key] = true
            end
        end
    end

    -- 后台独立频闪掩码，防手机滑动判定
    local function StartPCMaskingThread()
        task.spawn(function()
            while draggingJoystick do
                pcall(function()
                    VIM:SendKeyEvent(true, Enum.KeyCode.F15, false, game)
                    task.wait(0.01)
                    VIM:SendKeyEvent(false, Enum.KeyCode.F15, false, game)
                end)
                task.wait(0.2)
            end
        end)
    end

    -- 【摇杆事件】
    local function handleJoystickInput(inputPosition)
        local baseCenter = JoystickBase.AbsolutePosition + (JoystickBase.AbsoluteSize / 2)
        local delta = Vector2.new(inputPosition.X, inputPosition.Y) - baseCenter

        local maxVisualRadius = (BaseSize - KnobSize) / 2
        local visualDelta = delta
        if visualDelta.Magnitude > maxVisualRadius then
            visualDelta = visualDelta.Unit * maxVisualRadius
        end
        
        JoystickKnob.Position = UDim2.new(0.5, visualDelta.X, 0.5, visualDelta.Y)

        local threshold = BaseSize / 10 
        local targetKeys = {}

        if delta.Y < -threshold then table.insert(targetKeys, Enum.KeyCode.W) end
        if delta.Y > threshold then table.insert(targetKeys, Enum.KeyCode.S) end
        if delta.X < -threshold then table.insert(targetKeys, Enum.KeyCode.A) end
        if delta.X > threshold then table.insert(targetKeys, Enum.KeyCode.D) end

        updateKeys(targetKeys)
    end

    JoystickBase.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingJoystick = true
            dragInputJoystick = input
            StartPCMaskingThread()
            handleJoystickInput(input.Position)
        end
    end)

    -- 【跳跃键事件】
    JumpButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if JumpBtnDraggable then
                -- 拖拽模式
                draggingJump = true
                dragInputJump = input
                dragStartJump = input.Position
                startPosJump = JumpButton.Position
            else
                -- 触发跳跃 (伪装电脑按 Space)
                JumpButton.BackgroundTransparency = 0.4 
                VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            end
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            -- 摇杆滑动
            if draggingJoystick and input == dragInputJoystick then
                handleJoystickInput(input.Position)
            end
            -- 跳跃键拖拽
            if draggingJump and input == dragInputJump and JumpBtnDraggable then
                local delta = input.Position - dragStartJump
                JumpButton.Position = UDim2.new(
                    startPosJump.X.Scale, startPosJump.X.Offset + delta.X, 
                    startPosJump.Y.Scale, startPosJump.Y.Offset + delta.Y
                )
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        -- 摇杆松开
        if input == dragInputJoystick then
            draggingJoystick = false
            dragInputJoystick = nil
            releaseAllKeys()
            game:GetService("TweenService"):Create(JoystickKnob, TweenInfo.new(0.2, Enum.EasingStyle.Bounce), {
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play()
        end
        -- 跳跃键松开
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if draggingJump and input == dragInputJump then
                draggingJump = false
                dragInputJump = nil
            elseif not JumpBtnDraggable then
                JumpButton.BackgroundTransparency = 0.65
                VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
            end
        end
    end)


    -- ==========================================
    -- UI 控件绑定
    -- ==========================================
    
    -- 【核心】：统一的主开关，同开同关
    Tabs.Qwqa:AddToggle("QWQ_Joystick_Toggle", {
        Title = "显示 虚拟摇杆与跳跃键",
        Description = "开启后屏幕显示移动控制组件，向服务器强制发送物理键盘信号防识别",
        Default = false,
        Callback = function(state)
            DPadGui.Enabled = state -- 控制总容器显示/隐藏
            
            -- 关闭时清理所有内存与状态
            if not state then
                draggingJoystick = false
                dragInputJoystick = nil
                draggingJump = false
                dragInputJump = nil
                releaseAllKeys()
                JoystickKnob.Position = UDim2.new(0.5, 0, 0.5, 0)
            end
        end
    })

    Tabs.Qwqa:AddToggle("QWQ_JumpBtn_Draggable", {
        Title = "编辑跳跃键位置 (拖动模式)",
        Description = "开启后拖动跳跃键调整位置；调整完毕后请关闭开关以恢复跳跃功能！",
        Default = false,
        Callback = function(state)
            JumpBtnDraggable = state
            if state then
                JumpButton.Text = "拖动"
                JumpButton.TextColor3 = Color3.fromRGB(255, 100, 100)
            else
                JumpButton.Text = "▲\nJUMP"
                JumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        end
    })

    Tabs.Qwqa:AddSlider("QWQ_Joystick_SizeSlider", {
        Title = "摇杆大小 (左下角锚定)",
        Min = 100,
        Max = 400,
        Default = 220,
        Rounding = 0,
        Callback = function(value)
            BaseSize = value
            UpdateJoystickUI()
        end
    })

    Tabs.Qwqa:AddSlider("QWQ_JumpBtn_SizeSlider", {
        Title = "跳跃键独立大小",
        Min = 50,
        Max = 200,
        Default = 100,
        Rounding = 0,
        Callback = function(value)
            JumpBtnSize = value
            UpdateJumpBtnUI()
        end
    })

    Tabs.Qwqa:AddColorpicker("QWQ_Joystick_ColorPicker", {
        Title = "全局亚克力颜色",
        Description = "统一更改底座与跳跃键的色调，完美保留玻璃高光与透明度",
        Default = Color3.fromRGB(240, 240, 245),
        Callback = function(value)
            JoystickBase.BackgroundColor3 = value
            JumpButton.BackgroundColor3 = value
        end
    })
end








local customFOVEnabled = false
local customFOVValue = 70

Tabs.FOV:AddToggle("CustomFOVToggle", {
    Title = "开启FOV",
    Default = false,
    Callback = function(value)
        customFOVEnabled = value
        if value then
            Camera.FieldOfView = customFOVValue
        else
            Camera.FieldOfView = 70
        end
    end
})

Tabs.FOV:AddSlider("CustomFOVSlider", {
    Title = "FOV值",
    Min = 1,
    Max = 120,
    Default = 70,
    Rounding = 0,
    Callback = function(value)
        customFOVValue = value
        if customFOVEnabled then
            Camera.FieldOfView = value
        end
    end
})
    
local originalMaxZoom = LocalPlayer.CameraMaxZoomDistance
Tabs.FOV:AddToggle("UnlimitedZoom", {
    Title = "无限视距",
    Default = false,
    Callback = function(value)
        if value then
            LocalPlayer.CameraMaxZoomDistance = math.huge
        else
            LocalPlayer.CameraMaxZoomDistance = originalMaxZoom or 400
        end
    end
})






-- ==========================================================
-- 【UI构建】：强制第三人称视角功能
-- ==========================================================
if Tabs and Tabs.FOV then
    Tabs.FOV:AddSection("视角破解")

    -- 独立连接变量，防止内存泄漏
    local QWQ_ThirdPerson_Connection = nil

    Tabs.FOV:AddToggle("QWQ_ForceThirdPerson_Toggle", {
        Title = "强制第三人称 (突破限制)",
        Default = false,
        Callback = function(QWQ_ThirdPerson_State)
            if QWQ_ThirdPerson_State then
                -- 1. 初始解锁：将相机模式改为经典模式，并放宽缩放限制
                LocalPlayer.CameraMode = Enum.CameraMode.Classic
                LocalPlayer.CameraMinZoomDistance = 5   -- 允许的最近距离
                LocalPlayer.CameraMaxZoomDistance = 400 -- 允许的最远距离
                
                -- 2. 实时对抗：使用高频渲染循环，防止游戏本地脚本将视角再次锁死
                QWQ_ThirdPerson_Connection = RunService.RenderStepped:Connect(function()
                    -- 对抗相机模式锁定
                    if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
                        LocalPlayer.CameraMode = Enum.CameraMode.Classic
                    end
                    
                    -- 对抗最大缩放距离锁定 (很多游戏会把MaxZoomDistance设为0.5来变相强制第一人称)
                    if LocalPlayer.CameraMaxZoomDistance < 5 then
                        LocalPlayer.CameraMaxZoomDistance = 400
                    end
                end)
            else
                -- 关闭功能：断开连接，停止强制覆盖
                if QWQ_ThirdPerson_Connection then
                    QWQ_ThirdPerson_Connection:Disconnect()
                    QWQ_ThirdPerson_Connection = nil
                end
                
                -- 可选：恢复默认缩放设置 (这里恢复为Roblox默认的128)
                LocalPlayer.CameraMaxZoomDistance = 128
            end
        end
    })
end







local faceLockConnection
Tabs.FOV:AddToggle("FaceLock", {
    Title = "视角锁",
    Default = false,
    Callback = function(value)
        if faceLockConnection then
            faceLockConnection:Disconnect()
            faceLockConnection = nil
        end
        if value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            faceLockConnection = RunService.RenderStepped:Connect(function()
                local hrp = LocalPlayer.Character.HumanoidRootPart
                local camLook = Camera.CFrame.LookVector
                hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + Vector3.new(camLook.X, 0, camLook.Z))
            end)
        end
    end
})










LocalPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("HumanoidRootPart")
    if Options.FaceLock.Value then
        if faceLockConnection then
            faceLockConnection:Disconnect()
        end
        faceLockConnection = RunService.RenderStepped:Connect(function()
            local hrp = character.HumanoidRootPart
            local camLook = Camera.CFrame.LookVector
            hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + Vector3.new(camLook.X, 0, camLook.Z))
        end)
    end
end)

Tabs.FOV:AddSection("特定朝向")

local faceTargetMode = "名称"
local faceTargetPlayerName
local faceTargetPlayer
local faceTargetEnabled = false
local faceTargetConnection

local function UpdateFaceTargetPlayerList()
    local players = Players:GetPlayers()
    local playerNames = {}
    for _, player in pairs(players) do
        if player ~= LocalPlayer then
            if faceTargetMode == "名称" then
                table.insert(playerNames, player.Name)
            elseif faceTargetMode == "昵称" then
                table.insert(playerNames, player.DisplayName)
            end
        end
    end
    if #playerNames == 0 then playerNames = {"无玩家"} end
    Options.FaceTargetPlayerDropdown:SetValues(playerNames)
    if #playerNames > 0 and playerNames[1] ~= "无玩家" then
        if not table.find(playerNames, Options.FaceTargetPlayerDropdown.Value) then
            Options.FaceTargetPlayerDropdown:SetValue(playerNames[1])
        end
    else
        Options.FaceTargetPlayerDropdown:SetValue("无玩家")
    end
end

local function UpdateFaceTargetPlayer()
    if not faceTargetPlayerName or faceTargetPlayerName == "无玩家" then
        faceTargetPlayer = nil
        return
    end
    for _, player in pairs(Players:GetPlayers()) do
        if (faceTargetMode == "名称" and player.Name == faceTargetPlayerName) or
           (faceTargetMode == "昵称" and player.DisplayName == faceTargetPlayerName) then
            faceTargetPlayer = player
            return
        end
    end
    faceTargetPlayer = nil
end

Tabs.FOV:AddDropdown("FaceTargetModeDropdown", {
    Title = "选择模式",
    Values = {"名称", "昵称"},
    Default = 1,
    Callback = function(value)
        faceTargetMode = value
        UpdateFaceTargetPlayerList()
    end
})

Tabs.FOV:AddDropdown("FaceTargetPlayerDropdown", {
    Title = "选择目标玩家",
    Values = {},
    Default = 1,
    Callback = function(value)
        faceTargetPlayerName = (value ~= "无玩家") and value or nil
        UpdateFaceTargetPlayer()
    end
})

Tabs.FOV:AddButton({
    Title = "刷新玩家列表",
    Callback = function()
        UpdateFaceTargetPlayerList()
    end
})

Tabs.FOV:AddToggle("FaceTargetEnabled", {
    Title = "开启特定朝向",
    Default = false,
    Callback = function(value)
        faceTargetEnabled = value
        if faceTargetConnection then
            faceTargetConnection:Disconnect()
            faceTargetConnection = nil
        end
        if value then
            if not faceTargetPlayerName or faceTargetPlayerName == "无玩家" then
                Fluent:Notify({Title = "错误", Content = "请先选择一个目标玩家", Duration = 5})
                Options.FaceTargetEnabled:SetValue(false)
                return
            end
            UpdateFaceTargetPlayer()
            if not faceTargetPlayer then
                Fluent:Notify({Title = "错误", Content = "未找到目标玩家", Duration = 5})
                Options.FaceTargetEnabled:SetValue(false)
                return
            end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                faceTargetConnection = RunService.RenderStepped:Connect(function()
                    if faceTargetPlayer and faceTargetPlayer.Character and faceTargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = LocalPlayer.Character.HumanoidRootPart
                        local targetPos = faceTargetPlayer.Character.HumanoidRootPart.Position
                        hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(targetPos.X, hrp.Position.Y, targetPos.Z))
                    else
                        Options.FaceTargetEnabled:SetValue(false)
                    end
                end)
            end
        end
    end
})

UpdateFaceTargetPlayerList()
Players.PlayerAdded:Connect(UpdateFaceTargetPlayerList)
Players.PlayerRemoving:Connect(function(player)
    UpdateFaceTargetPlayerList()
    if player == faceTargetPlayer then
        faceTargetPlayer = nil
        if faceTargetEnabled then
            Options.FaceTargetEnabled:SetValue(false)
            if faceTargetConnection then
                faceTargetConnection:Disconnect()
                faceTargetConnection = nil
            end
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("HumanoidRootPart")
    if faceTargetEnabled and faceTargetPlayer then
        if faceTargetConnection then
            faceTargetConnection:Disconnect()
        end
        faceTargetConnection = RunService.RenderStepped:Connect(function()
            if faceTargetPlayer and faceTargetPlayer.Character and faceTargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = character.HumanoidRootPart
                local targetPos = faceTargetPlayer.Character.HumanoidRootPart.Position
                hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(targetPos.X, hrp.Position.Y, targetPos.Z))
            else
                Options.FaceTargetEnabled:SetValue(false)
            end
        end)
    end
end)
    
    local function touchHead(player)
        pcall(function()
            local character = player.Character
            if character and character:FindFirstChild("Head") then
                local head = character.Head
                local localPlayer = Players.LocalPlayer
                local leftHand = localPlayer.Character and localPlayer.Character:FindFirstChild("LeftHand")
                if head and leftHand then
                    firetouchinterest(head, leftHand, 0)
                    wait(0.01)
                    firetouchinterest(head, leftHand, 1)
                end
            end
        end)
    end
    
    local function setupHitbox(player)
    if player == LocalPlayer then return end
    
    if not player.Character then return end
    
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    pcall(function()
        if not hitbox_original_properties[player] then
            hitbox_original_properties[player] = {
                Size = hrp.Size,
                Transparency = hrp.Transparency,
                Color = hrp.Color,
                Material = hrp.Material,
                CanCollide = hrp.CanCollide
            }
        end
        
        hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
        hrp.Transparency = hitboxTransparency
        hrp.Color = hitboxColor
        hrp.Material = Enum.Material.Neon
        hrp.CanCollide = false
    end)
end

local function restoreHitbox(player)
    if player == LocalPlayer then return end
    
    if not player.Character then return end
    
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if not hitbox_original_properties[player] then return end
    
    pcall(function()
        local props = hitbox_original_properties[player]
        hrp.Size = props.Size
        hrp.Transparency = props.Transparency
        hrp.Color = props.Color
        hrp.Material = props.Material
        hrp.CanCollide = props.CanCollide
        
        hitbox_original_properties[player] = nil
    end)
end


local function createESP(player)
    if player == LocalPlayer then return end
    local character = player.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoidRootPart and humanoid then
            if not ESP.Boxes[player] then
                local box = Drawing.new("Square")
                box.Thickness = 2
                box.Filled = false
                ESP.Boxes[player] = box
            end
            if not ESP.Rays[player] then
                local ray = Drawing.new("Line")
                ray.Thickness = 2
                ESP.Rays[player] = ray
            end
            if not ESP.Highlights[player] then
                local highlight = Instance.new("Highlight")
                highlight.Parent = character
                highlight.Adornee = character
                highlight.Enabled = Options.HighlightESP.Value
                ESP.Highlights[player] = highlight
            end
            if not ESP.HealthBars[player] then
                local healthBar = {
                    Bar = Drawing.new("Square"),
                    Background = Drawing.new("Square"),
                    Percentage = Drawing.new("Text")
                }
                healthBar.Bar.Filled = true
                healthBar.Background.Filled = true
                healthBar.Background.Color = Color3.fromRGB(100, 100, 100)
                healthBar.Background.Thickness = 1
                healthBar.Percentage.Size = 14
                healthBar.Percentage.Center = true
                healthBar.Percentage.Outline = true
                ESP.HealthBars[player] = healthBar
            end
            if not ESP.Names[player] then
                local nameText = Drawing.new("Text")
                nameText.Size = 16
                nameText.Center = true
                nameText.Outline = true
                ESP.Names[player] = nameText
            end
            if not ESP.Distances[player] then
                local distanceText = Drawing.new("Text")
                distanceText.Size = 14
                distanceText.Center = true
                distanceText.Outline = true
                ESP.Distances[player] = distanceText
            end
            if not ESP.Coords[player] then
                local coordsText = Drawing.new("Text")
                coordsText.Size = 14
                coordsText.Center = true
                coordsText.Outline = true
                ESP.Coords[player] = coordsText
            end
        end
    end
end

local function updateESP()
    for player, box in pairs(ESP.Boxes) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position)
            if onScreen and Options.BoxESP.Value then
                local size = (Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0)).Y - Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0)).Y) * 0.75
                box.Size = Vector2.new(size * 1.5, size * 2)
                box.Position = Vector2.new(vector.X - box.Size.X / 2, vector.Y - box.Size.Y / 2)
                box.Color = Options.BoxColor.Value
                box.Visible = true
            else
                box.Visible = false
            end
        else
            box.Visible = false
        end
    end
    for player, ray in pairs(ESP.Rays) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position)
            if onScreen and Options.RayESP.Value then
                ray.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                ray.To = Vector2.new(vector.X, vector.Y)
                ray.Color = Options.RayColor.Value
                ray.Visible = true
            else
                ray.Visible = false
            end
        else
            ray.Visible = false
        end
    end
    for player, highlight in pairs(ESP.Highlights) do
        if player.Character and Options.HighlightESP.Value then
            highlight.FillColor = Options.HighlightColor.Value
            highlight.OutlineColor = Options.HighlightColor.Value
            highlight.Enabled = true
        else
            highlight.Enabled = false
        end
    end
    for player, healthBar in pairs(ESP.HealthBars) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
            local hrp = player.Character.HumanoidRootPart
            local humanoid = player.Character.Humanoid
            local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position)
            if onScreen and Options.HealthESP.Value then
                local height = (Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0)).Y - 
                              Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0)).Y) * 0.75
                healthBar.Background.Size = Vector2.new(5, height)
                healthBar.Background.Position = Vector2.new(vector.X + height * 0.75, vector.Y - height)
                healthBar.Background.Visible = true
                local healthPercent = math.floor((humanoid.Health / humanoid.MaxHealth) * 100)
                healthBar.Bar.Size = Vector2.new(5, height * (healthPercent / 100))
                healthBar.Bar.Position = Vector2.new(vector.X + height * 0.75, vector.Y - height + (height * (1 - healthPercent / 100)))
                healthBar.Bar.Color = Options.HealthColor.Value
                healthBar.Bar.Visible = true
                healthBar.Percentage.Text = healthPercent .. "%"
                healthBar.Percentage.Position = Vector2.new(vector.X + height * 0.75 + 2.5, vector.Y - height - 15)
                healthBar.Percentage.Color = Options.HealthColor.Value
                healthBar.Percentage.Visible = true
            else
                healthBar.Background.Visible = false
                healthBar.Bar.Visible = false
                healthBar.Percentage.Visible = false
            end
        else
            healthBar.Background.Visible = false
            healthBar.Bar.Visible = false
            healthBar.Percentage.Visible = false
        end
    end
    for player, nameText in pairs(ESP.Names) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0))
            if onScreen and Options.NameESP.Value then
                nameText.Text = player.Name
                nameText.Position = Vector2.new(vector.X, vector.Y)
                nameText.Color = Options.NameColor.Value
                nameText.Visible = true
            else
                nameText.Visible = false
            end
        else
            nameText.Visible = false
        end
    end
    for player, distanceText in pairs(ESP.Distances) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0))
            local localHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if onScreen and Options.DistanceESP.Value and localHrp then
                local distance = math.floor((hrp.Position - localHrp.Position).Magnitude)
                distanceText.Text = "距离 " .. distance .. " 米"
                distanceText.Position = Vector2.new(vector.X, vector.Y + 20)
                distanceText.Color = Options.NameColor.Value
                distanceText.Visible = true
            else
                distanceText.Visible = false
            end
        else
            distanceText.Visible = false
        end
    end
    for player, coordsText in pairs(ESP.Coords) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0))
            if onScreen and Options.CoordsESP.Value then
                local pos = hrp.Position
                coordsText.Text = string.format("X: %.1f Y: %.1f Z: %.1f", pos.X, pos.Y, pos.Z)
                coordsText.Position = Vector2.new(vector.X, vector.Y + 40)
                coordsText.Color = Options.NameColor.Value
                coordsText.Visible = true
            else
                coordsText.Visible = false
            end
        else
            coordsText.Visible = false
        end
    end
end

local connections = {}

local function cleanupESP(player)
    if ESP.Boxes[player] then
        ESP.Boxes[player]:Remove()
        ESP.Boxes[player] = nil
    end
    if ESP.Rays[player] then
        ESP.Rays[player]:Remove()
        ESP.Rays[player] = nil
    end
    if ESP.Highlights[player] then
        ESP.Highlights[player]:Destroy()
        ESP.Highlights[player] = nil
    end
    if ESP.HealthBars[player] then
        ESP.HealthBars[player].Bar:Remove()
        ESP.HealthBars[player].Background:Remove()
        ESP.HealthBars[player].Percentage:Remove()
        ESP.HealthBars[player] = nil
    end
    if ESP.Names[player] then
        ESP.Names[player]:Remove()
        ESP.Names[player] = nil
    end
    if ESP.Distances[player] then
        ESP.Distances[player]:Remove()
        ESP.Distances[player] = nil
    end
    if ESP.Coords[player] then
        ESP.Coords[player]:Remove()
        ESP.Coords[player] = nil
    end
    if hitbox_original_properties[player] then
        hitbox_original_properties[player] = nil
    end
end

local function cleanupAll()
    for player, conns in pairs(connections) do
        for _, conn in ipairs(conns) do
            conn:Disconnect()
        end
        cleanupESP(player)
    end
    connections = {}
    if suctionConnection then
        suctionConnection:Disconnect()
        suctionConnection = nil
    end
end


local function createPlatform(position)
    if lastPlatform then lastPlatform:Destroy() end
    local platform = Instance.new("Part")
    platform.Size = Vector3.new(10, 0.2, 10)
    platform.Position = Vector3.new(position.X, position.Y - 0.5, position.Z)
    platform.Anchored = true
    platform.Transparency = 1
    platform.CanCollide = true
    platform.Parent = game.Workspace
    lastPlatform = platform
    task.delay(1, function()
        if platform == lastPlatform then
            platform:Destroy()
            lastPlatform = nil
        end
    end)
end

local function updatePlayerList()
    local players = game:GetService("Players"):GetPlayers()
    local playerNames = {}
    local mode = Options.ModeDropdown.Value or "名称"
    
    for _, player in pairs(players) do
        if player ~= LocalPlayer then
            if mode == "名称" then
                table.insert(playerNames, player.Name)
            elseif mode == "昵称" then
                table.insert(playerNames, player.DisplayName)
            end
        end
    end
    
    if #playerNames == 0 then
        playerNames = {"无玩家"}
    end
    Options.PlayerDropdown:SetValues(playerNames)
    if #playerNames > 0 and playerNames[1] ~= "无玩家" then
        if not table.find(playerNames, Options.PlayerDropdown.Value) then
            Options.PlayerDropdown:SetValue(playerNames[1])
        end
    else
        Options.PlayerDropdown:SetValue("无玩家")
    end
end





    Tabs.ESP:AddToggle("BoxESP", { Title = "方框ESP开关", Default = false, Callback = function(value) Options.BoxESP.Value = value end })
    Tabs.ESP:AddColorpicker("BoxColor", { Title = "方框颜色选择", Default = Color3.fromRGB(180, 220, 170), Callback = function(value) Options.BoxColor.Value = value end })
    Tabs.ESP:AddToggle("RayESP", { Title = "射线ESP开关", Default = false, Callback = function(value) Options.RayESP.Value = value end })
    Tabs.ESP:AddColorpicker("RayColor", { Title = "射线颜色选择", Default = Color3.fromRGB(200, 230, 180), Callback = function(value) Options.RayColor.Value = value end })
    Tabs.ESP:AddToggle("HighlightESP", { Title = "人物高亮ESP开关", Default = false, Callback = function(value) Options.HighlightESP.Value = value end })
    Tabs.ESP:AddColorpicker("HighlightColor", { Title = "高亮颜色选择", Default = Color3.fromRGB(100, 30, 200), Callback = function(value) Options.HighlightColor.Value = value end })
    Tabs.ESP:AddToggle("HealthESP", { Title = "血量ESP开关", Default = false, Callback = function(value) Options.HealthESP.Value = value end })
    Tabs.ESP:AddColorpicker("HealthColor", { Title = "血量颜色选择", Default = Color3.fromRGB(200, 230, 180), Callback = function(value) Options.HealthColor.Value = value end })
    Tabs.ESP:AddToggle("NameESP", { Title = "名称ESP开关", Default = false, Callback = function(value) Options.NameESP.Value = value end })
    Tabs.ESP:AddToggle("DistanceESP", { Title = "距离ESP开关", Default = false, Callback = function(value) Options.DistanceESP.Value = value end })
    Tabs.ESP:AddToggle("CoordsESP", { Title = "坐标ESP开关", Default = false, Callback = function(value) Options.CoordsESP.Value = value end })
    Tabs.ESP:AddColorpicker("NameColor", { Title = "名称/距离/坐标颜色", Default = Color3.fromRGB(255, 255, 255), Callback = function(value) Options.NameColor.Value = value end })

    local ModeDropdown = Tabs.Teleport:AddDropdown("ModeDropdown", {
        Title = "模式选择",
       
        Values = {"名称", "昵称"},
        Default = 1,
        Callback = function(value)
            updatePlayerList()
        end
    })

    local PlayerDropdown = Tabs.Teleport:AddDropdown("PlayerDropdown", {
        Title = "选择目标玩家",
        
        Values = {},
        Default = 1,
        Multi = false,
        Callback = function(value)
            if value ~= "无玩家" then 
                targetPlayerName = value 
            else 
                targetPlayerName = nil 
            end
        end
    })

    Tabs.Teleport:AddButton({
        Title = "更新玩家列表",
       
        Callback = function()
            updatePlayerList()
        end
    })


    Tabs.Teleport:AddToggle("TeleportToggle", {
    Title = "持续传送",
  
    Default = false,
    Callback = function(state)
        isTeleporting = state
        if state then
            targetPlayerName = Options.PlayerDropdown.Value
            if targetPlayerName == "无玩家" or not targetPlayerName then
                isTeleporting = false
                return
            end
            
            local mode = Options.ModeDropdown.Value
            targetPlayer = nil
            for _, player in pairs(Players:GetPlayers()) do
                if (mode == "名称" and player.Name == targetPlayerName) or
                   (mode == "昵称" and player.DisplayName == targetPlayerName) then
                    targetPlayer = player
                    break
                end
            end
            
            if not targetPlayer then
                isTeleporting = false
                Fluent:Notify({ Title = "错误", Content = "未找到目标玩家", Duration = 5 })
                return
            end
            
        else
            targetPlayer = nil
        end
    end
})
    Tabs.Teleport:AddInput("TeleportFrequency", { Title = "传送频率", Default = "0.01", Placeholder = "如 0.5", Numeric = true, Callback = function(value) local freq = tonumber(value) if freq and freq > 0 then teleportFrequency = freq else teleportFrequency = 0 end end })
    Tabs.Teleport:AddInput("TeleportDistance", { Title = "传送距离", Description = "与目标的距离（1-500）", Default = "5", Placeholder = "1-50", Numeric = true, Callback = function(value) local dist = tonumber(value) if dist then if dist < 1 then teleportDistance = 1 Options.TeleportDistance:SetValue("1") elseif dist > 50 then teleportDistance = 50 Options.TeleportDistance:SetValue("500") else teleportDistance = dist end else teleportDistance = 5 Options.TeleportDistance:SetValue("5") end end })
    Tabs.Teleport:AddDropdown("TeleportDirection", {
        Title = "传送方向",
        Description = "相对于目标玩家的方向",
        Values = {"上", "下", "前", "后", "左", "右"},
        Default = 3,
        Callback = function(value) teleportDirection = value end
    })
    Tabs.Teleport:AddToggle("CircleToggle", { Title = "环绕传送", Default = false, Callback = function(value) isCircling = value if value then circleAngle = 0 end end })
    Tabs.Teleport:AddInput("CircleSpeed", { Title = "环绕速度", Description = "环绕圈数/秒", Default = "1", Placeholder = "输入任意数字", Numeric = true, Callback = function(value) local speed = tonumber(value) if speed then if speed < 0 then circleSpeed = 0 Options.CircleSpeed:SetValue("0") else circleSpeed = speed end else circleSpeed = 1 Options.CircleSpeed:SetValue("1") end end })
    Tabs.Teleport:AddToggle("SpectateToggle", { Title = "观察模式", Description = "切换到目标玩家的视角", Default = false, Callback = function(value) if value then if targetPlayerName then local targetPlayer local mode = Options.ModeDropdown.Value for _, player in pairs(Players:GetPlayers()) do if (mode == "名称" and player.Name == targetPlayerName) or (mode == "昵称" and player.DisplayName == targetPlayerName) then targetPlayer = player break end end if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then isSpectating = true local humanoid = targetPlayer.Character.Humanoid Camera.CameraSubject = humanoid Camera.CameraType = Enum.CameraType.Custom if spectateConnection then spectateConnection:Disconnect() end spectateConnection = RunService.RenderStepped:Connect(function() if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("Humanoid") then isSpectating = false Options.SpectateToggle:SetValue(false) Camera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character.Humanoid if spectateConnection then spectateConnection:Disconnect() end end end) else Options.SpectateToggle:SetValue(false) end else Options.SpectateToggle:SetValue(false) end else isSpectating = false Camera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character.Humanoid if spectateConnection then spectateConnection:Disconnect() spectateConnection = nil end end end })
    Tabs.Teleport:AddToggle("TeleportOnDeath", { Title = "死亡后继续", Description = "自己死亡后继续传送", Default = false, Callback = function(value) teleportOnDeath = value end })


Tabs.Teleport:AddSection("甩飞")

local function SkidFling(TargetPlayer)
    local Character = game.Players.LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart

    local TCharacter = TargetPlayer.Character
    local THumanoid
    local TRootPart
    local THead
    local Accessory
    local Handle

    if TCharacter:FindFirstChildOfClass("Humanoid") then
        THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
    end
    if THumanoid and THumanoid.RootPart then
        TRootPart = THumanoid.RootPart
    end
    if TCharacter:FindFirstChild("Head") then
        THead = TCharacter.Head
    end
    if TCharacter:FindFirstChildOfClass("Accessory") then
        Accessory = TCharacter:FindFirstChildOfClass("Accessory")
    end
    if Accessory and Accessory:FindFirstChild("Handle") then
        Handle = Accessory.Handle
    end

    if Character and Humanoid and RootPart then
        if RootPart.Velocity.Magnitude < 50 then
            getgenv().OldPos = RootPart.CFrame
        end
        if THumanoid and THumanoid.Sit then
            Fluent:Notify({ Title = "错误", Content = "目标玩家正在坐下", Duration = 5 })
            return
        end
        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif not THead and Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        elseif THumanoid and TRootPart then
            workspace.CurrentCamera.CameraSubject = THumanoid
        end
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then
            return
        end

        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end

        local SFBasePart = function(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0

            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= game.Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
        end

        workspace.FallenPartsDestroyHeight = 0/0

        local BV = Instance.new("BodyVelocity")
        BV.Name = "EpixVel"
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
        BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)

        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

        if TRootPart and THead then
            if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                SFBasePart(THead)
            else
                SFBasePart(TRootPart)
            end
        elseif TRootPart and not THead then
            SFBasePart(TRootPart)
        elseif not TRootPart and THead then
            SFBasePart(THead)
        elseif not TRootPart and not THead and Accessory and Handle then
            SFBasePart(Handle)
        else
            Fluent:Notify({ Title = "错误", Content = "目标玩家缺少身体部件", Duration = 5 })
            return
        end

        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid

        repeat
            RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
            Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
            Humanoid:ChangeState("GettingUp")
            table.foreach(Character:GetChildren(), function(_, x)
                if x:IsA("BasePart") then
                    x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                end
            end)
            task.wait()
        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
        workspace.FallenPartsDestroyHeight = getgenv().FPDH
    else
        Fluent:Notify({ Title = "错误", Content = "未知错误", Duration = 5 })
    end
end

Tabs.Teleport:AddButton({
    Title = "甩飞一次",
    Callback = function()
        if not targetPlayerName then
            Fluent:Notify({ Title = "错误", Content = "请先选择一个玩家", Duration = 5 })
            return
        end
        local mode = Options.ModeDropdown.Value
        local targetPlayer = nil
        for _, player in pairs(Players:GetPlayers()) do
            if (mode == "名称" and player.Name == targetPlayerName) or (mode == "昵称" and player.DisplayName == targetPlayerName) then
                targetPlayer = player
                break
            end
        end
        SkidFling(targetPlayer)
    end
})

Tabs.Teleport:AddButton({
    Title = "甩飞所有人",
    Callback = function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                SkidFling(player)
                task.wait(flingFrequency)
            end
        end
    end
})

Tabs.Teleport:AddToggle("FlingToggle", {
    Title = "循环甩飞",
    Default = false,
    Callback = function(state)
        if not targetPlayerName then
            Fluent:Notify({ Title = "错误", Content = "请先选择一个玩家", Duration = 5 })
            Options.FlingToggle:SetValue(false)
            return
        end
        isFlinging = state
        if state then
            local mode = Options.ModeDropdown.Value
            targetPlayer = nil  
            for _, player in pairs(Players:GetPlayers()) do
                if (mode == "名称" and player.Name == targetPlayerName) or
                   (mode == "昵称" and player.DisplayName == targetPlayerName) then
                    targetPlayer = player
                    break
                end
            end
            
            if not targetPlayer then
                isFlinging = false
                Fluent:Notify({ Title = "错误", Content = "未找到目标玩家", Duration = 5 })
                return
            end
        else
            targetPlayer = nil
        end
    end
})

Tabs.Teleport:AddSection("自定义")

    local positionDropdown = Tabs.Teleport:AddDropdown("SavedPositionsDropdown", {
        Title = "保存的位置",
        Values = {},
        Default = "",
        Callback = function(value)
            if value ~= "" and savedPositions[value] then
                if lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart") then
                    lplr.Character.HumanoidRootPart.CFrame = savedPositions[value]
                end
            end
        end
    })
    local positionNameInput = Tabs.Teleport:AddInput("SavePositionName", {
        Title = "保存位置名称",
        Default = "位置1",
        Callback = function(value) end
    })
    Tabs.Teleport:AddButton({
        Title = "确认保存位置",
        Callback = function()
            if lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart") then
                local positionName = positionNameInput.Value or "位置" .. (#savedPositions + 1)
                savedPositions[positionName] = lplr.Character.HumanoidRootPart.CFrame
                local dropdownValues = {}
                for name, _ in pairs(savedPositions) do
                    table.insert(dropdownValues, name)
                end
                positionDropdown:SetValues(dropdownValues)
            end
        end
    })

-- ==========================================
-- 【仅修复漏人】只替换这一块即可
-- ==========================================
local function setupPlayerListener(player)
    if player == LocalPlayer then return end

    if player.Character then
        task.spawn(function()
            local hrp = player.Character:WaitForChild("HumanoidRootPart", 5)
            local hum = player.Character:WaitForChild("Humanoid", 5)
            if hrp and hum then
                createESP(player)
                if hitboxEnabled then setupHitbox(player) end
            end
        end)
    end

    player.CharacterAdded:Connect(function(character)
        cleanupESP(player)
        local hrp = character:WaitForChild("HumanoidRootPart", 5)
        local hum = character:WaitForChild("Humanoid", 5)
        if hrp and hum then
            createESP(player)
            if hitboxEnabled then setupHitbox(player) end
        end
    end)

    player.CharacterRemoving:Connect(function()
        cleanupESP(player)
    end)
end

for _, player in pairs(Players:GetPlayers()) do
    setupPlayerListener(player)
end

Players.PlayerAdded:Connect(function(player)
    setupPlayerListener(player)
    updatePlayerList()
end)
--😈😈😈😈

Players.PlayerRemoving:Connect(function(player)
    cleanupESP(player)
    updatePlayerList()
end)

Players.PlayerRemoving:Connect(function(player)
    if ESP.Boxes[player] then ESP.Boxes[player]:Remove() ESP.Boxes[player] = nil end
    if ESP.Rays[player] then ESP.Rays[player]:Remove() ESP.Rays[player] = nil end
    if ESP.Highlights[player] then ESP.Highlights[player]:Destroy() ESP.Highlights[player] = nil end
    if ESP.HealthBars[player] then ESP.HealthBars[player].Bar:Remove() ESP.HealthBars[player].Background:Remove() ESP.HealthBars[player].Percentage:Remove() ESP.HealthBars[player] = nil end
    if ESP.Names[player] then ESP.Names[player]:Remove() ESP.Names[player] = nil end
    if ESP.Distances[player] then ESP.Distances[player]:Remove() ESP.Distances[player] = nil end
    if ESP.Coords[player] then ESP.Coords[player]:Remove() ESP.Coords[player] = nil end
    if hitbox_original_properties[player] then hitbox_original_properties[player] = nil end
    updatePlayerList()
    local mode = Options.ModeDropdown.Value
    if (mode == "名称" and player.Name == targetPlayerName) or (mode == "昵称" and player.DisplayName == targetPlayerName) then
        isTeleporting = false
        isSpectating = false
        isFlinging = false
        targetPlayerName = nil
        Options.PlayerDropdown:SetValue("无玩家")
        Options.TeleportToggle:SetValue(false)
        Options.SpectateToggle:SetValue(false)
        Options.FlingToggle:SetValue(false)
        if spectateConnection then spectateConnection:Disconnect() spectateConnection = nil end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0) end
    end
    if player == targetPlayer then
        targetPlayer = nil
        isTeleporting = false
        isFlinging = false
        isSpectating = false
        Options.TeleportToggle:SetValue(false)
        Options.FlingToggle:SetValue(false)
        Options.SpectateToggle:SetValue(false)
        if spectateConnection then spectateConnection:Disconnect() spectateConnection = nil end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        end
    end
end)

RunService:BindToRenderStep("MainLoop", Enum.RenderPriority.Camera.Value + 1, function()
updateESP()
    if isTeleporting and targetPlayer and teleportFrequency > 0 then
        local currentTime = tick()
        if currentTime - lastTeleportTime >= teleportFrequency then
            if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and
               LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local targetPos = targetPlayer.Character.HumanoidRootPart.Position
                local targetCFrame = targetPlayer.Character.HumanoidRootPart.CFrame
                local newPos
                if isCircling then
                    circleAngle = circleAngle + (math.pi * 2 * circleSpeed * teleportFrequency)
                    if circleAngle >= math.pi * 2 then circleAngle = circleAngle - math.pi * 2 end
                    newPos = targetPos + Vector3.new(math.cos(circleAngle) * teleportDistance, 0, math.sin(circleAngle) * teleportDistance)
                else
                    local offset = Vector3.new(0, 0, 0)
                    if teleportDirection == "上" then
                        offset = Vector3.new(0, teleportDistance, 0)
                    elseif teleportDirection == "下" then
                        offset = Vector3.new(0, -teleportDistance, 0)
                    elseif teleportDirection == "前" then
                        offset = targetCFrame.LookVector * teleportDistance
                    elseif teleportDirection == "后" then
                        offset = -targetCFrame.LookVector * teleportDistance
                    elseif teleportDirection == "左" then
                        offset = -targetCFrame.RightVector * teleportDistance
                    elseif teleportDirection == "右" then
                        offset = targetCFrame.RightVector * teleportDistance
                    end
                    newPos = targetPos + offset
                end
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(newPos)
                createPlatform(newPos)
                lastTeleportTime = currentTime
            elseif not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                if not teleportOnDeath then
                    isTeleporting = false
                    Options.TeleportToggle:SetValue(false)
                end
            end  
        end
    end

    if isFlinging and targetPlayer then
        local currentTime = tick()
        if currentTime - lastFlingTime >= flingFrequency then
            if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and
               LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local targetHRP = targetPlayer.Character.HumanoidRootPart
                local selfHRP = LocalPlayer.Character.HumanoidRootPart
                local targetPos = targetHRP.Position
                local flingDirection = (targetPos - selfHRP.Position).Unit
                local startPos = targetPos - (flingDirection * 10)
                selfHRP.CFrame = CFrame.new(startPos)
                selfHRP.Velocity = flingDirection * flingPower
                task.delay(0.1, function()
                    if isFlinging and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    end
                end)
                lastFlingTime = currentTime
            end  
        end
    end
end)

local function isNumber(str)
    return tonumber(str) ~= nil or str == 'inf'
end

local function createPlatform()
    if platform then platform:Destroy() end
    platform = Instance.new("Part")
    platform.Size = Vector3.new(10, 0.2, 10)
    platform.Transparency = 0.7
    platform.Anchored = true
    platform.CanCollide = true
    platform.Material = Enum.Material.Glass
    platform.Parent = Workspace
end



-- ==========================================================
-- 【UI构建】：极简轻量级 NPC 透视 (总开关/防卡顿版)
-- ==========================================================
if Tabs and Tabs.NPC_ESP then
    Tabs.NPC_ESP:AddSection("NPC 透视总控")

    local QWQ_NPCEspEnabled = false
    local QWQ_RenderConnection = nil
    local QWQ_EventConnections = {}
    local NPC_Cache = {} -- 存储每个NPC的渲染实例

    local QWQ_SafeContainer = Instance.new("Folder")
    QWQ_SafeContainer.Name = "QWQ_NPC_ESP_Container"
    QWQ_SafeContainer.Parent = (gethui and gethui()) or game:GetService("CoreGui")

    -- 1. 特征识别
    local function IsValidNPC(model)
        if not model or not model:IsA("Model") then return false end
        if not model:FindFirstChild("HumanoidRootPart") then return false end
        local hum = model:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then return false end
        if Players:GetPlayerFromCharacter(model) then return false end
        return true
    end

    -- 2. 移除单个NPC的透视
    local function RemoveNPC(npcModel)
        if NPC_Cache[npcModel] then
            local data = NPC_Cache[npcModel]
            if data.Highlight then data.Highlight:Destroy() end
            if data.NameText then data.NameText:Remove() end
            if data.DistText then data.DistText:Remove() end
            NPC_Cache[npcModel] = nil
        end
    end

    -- 3. 添加单个NPC的透视实例
    local function AddNPC(npcModel)
        if NPC_Cache[npcModel] then return end

        local data = {}

        -- 高亮
        local highlight = Instance.new("Highlight")
        highlight.Name = npcModel.Name .. "_ESP"
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0.1
        highlight.Adornee = npcModel
        highlight.Parent = QWQ_SafeContainer
        highlight.Enabled = false
        data.Highlight = highlight

        -- 名称绘制
        local nameText = Drawing.new("Text")
        nameText.Size = 16
        nameText.Center = true
        nameText.Outline = true
        nameText.Visible = false
        data.NameText = nameText

        -- 距离绘制
        local distText = Drawing.new("Text")
        distText.Size = 14
        distText.Center = true
        distText.Outline = true
        distText.Visible = false
        data.DistText = distText

        NPC_Cache[npcModel] = data

        -- 绑定销毁事件释放内存
        local deathConn
        deathConn = npcModel.AncestryChanged:Connect(function(_, parent)
            if not parent then
                RemoveNPC(npcModel)
                if deathConn then deathConn:Disconnect() end
            end
        end)
        
        local hum = npcModel:FindFirstChildOfClass("Humanoid")
        if hum then
            local healthConn
            healthConn = hum.Died:Connect(function()
                RemoveNPC(npcModel)
                if healthConn then healthConn:Disconnect() end
            end)
        end
    end

    -- 4. 彻底清理与停止运算
    local function StopAndClearAll()
        -- 停止高频渲染循环
        if QWQ_RenderConnection then
            QWQ_RenderConnection:Disconnect()
            QWQ_RenderConnection = nil
        end
        -- 断开事件监听
        for _, conn in ipairs(QWQ_EventConnections) do
            conn:Disconnect()
        end
        table.clear(QWQ_EventConnections)
        -- 清理所有绘制缓存
        for npcModel, _ in pairs(NPC_Cache) do
            RemoveNPC(npcModel)
        end
        table.clear(NPC_Cache)
    end

    -- 5. 渲染循环函数 (仅在开启时运作)
    local function RenderLoop()
        local localHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        for npcModel, data in pairs(NPC_Cache) do
            local hrp = npcModel:FindFirstChild("HumanoidRootPart")
            local hum = npcModel:FindFirstChildOfClass("Humanoid")
            
            -- 安全校验
            if hrp and hum and hum.Health > 0 then
                local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                
                -- 高亮处理
                if data.Highlight then
                    data.Highlight.Enabled = Options.NPC_HighlightToggle.Value
                    if data.Highlight.Enabled then
                        data.Highlight.FillColor = Options.NPC_HighlightColor.Value
                        data.Highlight.OutlineColor = Options.NPC_HighlightColor.Value
                    end
                end

                if onScreen then
                    local sizeY = (Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0)).Y - Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0)).Y) * 0.75
                    
                    -- 名称处理
                    if data.NameText then
                        if Options.NPC_NameToggle.Value then
                            data.NameText.Text = npcModel.Name
                            data.NameText.Position = Vector2.new(vector.X, vector.Y - sizeY - 20)
                            data.NameText.Color = Options.NPC_TextColor.Value
                            data.NameText.Visible = true
                        else
                            data.NameText.Visible = false
                        end
                    end

                    -- 距离处理
                    if data.DistText then
                        if Options.NPC_DistToggle.Value and localHrp then
                            local distance = math.floor((hrp.Position - localHrp.Position).Magnitude)
                            data.DistText.Text = distance .. " 米"
                            data.DistText.Position = Vector2.new(vector.X, vector.Y + sizeY + 5)
                            data.DistText.Color = Options.NPC_TextColor.Value
                            data.DistText.Visible = true
                        else
                            data.DistText.Visible = false
                        end
                    end
                else
                    if data.NameText then data.NameText.Visible = false end
                    if data.DistText then data.DistText.Visible = false end
                end
            else
                if data.NameText then data.NameText.Visible = false end
                if data.DistText then data.DistText.Visible = false end
            end
        end
    end

    -- 6. UI 控制面板
    Tabs.NPC_ESP:AddToggle("QWQ_NPC_MasterToggle", {
        Title = "总开关 (NPC透视)",
        Description = "关闭后自动停止所有运算并清除画面",
        Default = false,
        Callback = function(state)
            QWQ_NPCEspEnabled = state
            if state then
                -- 开启渲染循环
                QWQ_RenderConnection = RunService.RenderStepped:Connect(RenderLoop)

                -- 监听新生成的NPC
                table.insert(QWQ_EventConnections, workspace.DescendantAdded:Connect(function(descendant)
                    if not QWQ_NPCEspEnabled then return end
                    if descendant:IsA("Humanoid") then
                        task.delay(0.5, function()
                            local parentModel = descendant.Parent
                            if parentModel and IsValidNPC(parentModel) then
                                AddNPC(parentModel)
                            end
                        end)
                    end
                end))

                -- 初始扫描 (采用分步延时，防卡死)
                task.spawn(function()
                    local descendants = workspace:GetDescendants()
                    for i, obj in ipairs(descendants) do
                        if not QWQ_NPCEspEnabled then break end
                        if obj:IsA("Model") and IsValidNPC(obj) then
                            AddNPC(obj)
                        end
                        if i % 300 == 0 then task.wait() end
                    end
                end)
            else
                StopAndClearAll()
            end
        end
    })

    Tabs.NPC_ESP:AddSection("渲染设置")

    -- 统一调色文本 (名称和距离)
    Tabs.NPC_ESP:AddToggle("NPC_NameToggle", { Title = "显示名称", Default = false, Callback = function(v) Options.NPC_NameToggle.Value = v end })
    Tabs.NPC_ESP:AddToggle("NPC_DistToggle", { Title = "显示距离", Default = false, Callback = function(v) Options.NPC_DistToggle.Value = v end })
    Tabs.NPC_ESP:AddColorpicker("NPC_TextColor", { Title = "名称/距离 颜色", Default = Color3.fromRGB(255, 255, 255), Callback = function(v) Options.NPC_TextColor.Value = v end })
    
    -- 单独调色高亮
    Tabs.NPC_ESP:AddToggle("NPC_HighlightToggle", { Title = "显示高亮", Default = false, Callback = function(v) Options.NPC_HighlightToggle.Value = v end })
    Tabs.NPC_ESP:AddColorpicker("NPC_HighlightColor", { Title = "高亮颜色", Default = Color3.fromRGB(255, 85, 0), Callback = function(v) Options.NPC_HighlightColor.Value = v end })
end

-- ==========================================================
-- 【功能构建】：自动扳机 (TriggerBot) - 悬浮快捷开关/纯净版
-- ==========================================================
if Tabs and Tabs.clickbot then
    Tabs.clickbot:AddSection("🔫 自动扳机 (TriggerBot)")

    -- 核心控制变量
    local QWQ_Trigger_MasterEnabled = false -- 注入器面板总开关
    local QWQ_Trigger_BtnEnabled = true     -- 悬浮按钮控制的实际开关 (默认开启)
    local QWQ_Trigger_MouseClick = false
    local QWQ_Trigger_TargetPlayers = false
    local QWQ_Trigger_TeamCheck = false 
    local QWQ_Trigger_TargetNPCs = false
    local QWQ_Trigger_WallCheck = true 
    local QWQ_Trigger_Radius = 100
    local QWQ_Trigger_Delay = 0.1
    local QWQ_Trigger_FOVColor = Color3.fromRGB(255, 0, 0)

    local QWQ_Trigger_NPC_Cache = {}
    
    -- 悬浮按钮状态变量
    local QWQ_Trigger_MiniBtn_GUI = nil
    local QWQ_Trigger_Btn = nil
    local QWQ_Trigger_DragConnections = {}

    -- 【安全获取 UI 容器】
    local function GetSafeUIContainer()
        if gethui then
            local s, r = pcall(gethui)
            if s and r then return r end
        end
        local s, r = pcall(function() return game:GetService("CoreGui") end)
        if s and r then return r end
        return LocalPlayer:WaitForChild("PlayerGui")
    end

    -- 1. 创建 FOV 准星 GUI
    local TriggerGui = GetSafeUIContainer():FindFirstChild("QWQ_Trigger_GUI") or Instance.new("ScreenGui")
    TriggerGui.Name = "QWQ_Trigger_GUI"
    TriggerGui.Parent = GetSafeUIContainer()
    TriggerGui.IgnoreGuiInset = true
    TriggerGui.ResetOnSpawn = false

    local TriggerFOV = Instance.new("Frame")
    TriggerFOV.Name = "TriggerFOV"
    TriggerFOV.Parent = TriggerGui
    TriggerFOV.AnchorPoint = Vector2.new(0.5, 0.5)
    TriggerFOV.Position = UDim2.new(0.5, 0, 0.5, 0)
    TriggerFOV.Size = UDim2.new(0, QWQ_Trigger_Radius * 2, 0, QWQ_Trigger_Radius * 2)
    TriggerFOV.BackgroundTransparency = 1
    TriggerFOV.Visible = false

    local TriggerStroke = Instance.new("UIStroke", TriggerFOV)
    TriggerStroke.Thickness = 1
    TriggerStroke.Color = QWQ_Trigger_FOVColor

    local TriggerCorner = Instance.new("UICorner", TriggerFOV)
    TriggerCorner.CornerRadius = UDim.new(1, 0)

    -- ==========================================
    -- 悬浮独立 UI 构建与销毁逻辑
    -- ==========================================
    local function DestroyTriggerButton()
        if QWQ_Trigger_MiniBtn_GUI then QWQ_Trigger_MiniBtn_GUI:Destroy() QWQ_Trigger_MiniBtn_GUI = nil end
        QWQ_Trigger_Btn = nil
        for _, conn in ipairs(QWQ_Trigger_DragConnections) do pcall(function() conn:Disconnect() end) end
        table.clear(QWQ_Trigger_DragConnections)
    end

    local function CreateTriggerButton()
        DestroyTriggerButton() 
        QWQ_Trigger_BtnEnabled = true -- 每次生成默认恢复为开启状态
        
        QWQ_Trigger_MiniBtn_GUI = Instance.new("ScreenGui")
        QWQ_Trigger_MiniBtn_GUI.Name = "QWQ_Trigger_MiniBtn"
        QWQ_Trigger_MiniBtn_GUI.Parent = GetSafeUIContainer()
        QWQ_Trigger_MiniBtn_GUI.ResetOnSpawn = false
        QWQ_Trigger_MiniBtn_GUI.IgnoreGuiInset = true 
        
        QWQ_Trigger_Btn = Instance.new("TextButton")
        QWQ_Trigger_Btn.Parent = QWQ_Trigger_MiniBtn_GUI
        QWQ_Trigger_Btn.Size = UDim2.new(0, 50, 0, 30) -- 要求：50x30
        QWQ_Trigger_Btn.Position = UDim2.new(1, -120, 0, 160) -- 放右上角偏下一点，防重叠
        QWQ_Trigger_Btn.BackgroundColor3 = Color3.fromRGB(0, 200, 150) -- 初始青绿色
        QWQ_Trigger_Btn.BorderSizePixel = 0
        QWQ_Trigger_Btn.Text = "扳机开启"
        QWQ_Trigger_Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        QWQ_Trigger_Btn.Font = Enum.Font.SourceSansBold
        QWQ_Trigger_Btn.TextScaled = true -- 自适应文字大小
        QWQ_Trigger_Btn.AutoButtonColor = false

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 20) -- 要求：圆角20
        btnCorner.Parent = QWQ_Trigger_Btn
        
        -- 点击切换状态
        QWQ_Trigger_Btn.Activated:Connect(function()
            QWQ_Trigger_BtnEnabled = not QWQ_Trigger_BtnEnabled
            if QWQ_Trigger_BtnEnabled then
                QWQ_Trigger_Btn.BackgroundColor3 = Color3.fromRGB(0, 200, 150) -- 青绿色
                QWQ_Trigger_Btn.Text = "扳机开启"
                TriggerFOV.Visible = true -- 同步显示FOV
            else
                QWQ_Trigger_Btn.BackgroundColor3 = Color3.fromRGB(255, 105, 180) -- 粉红色
                QWQ_Trigger_Btn.Text = "扳机关闭"
                TriggerFOV.Visible = false -- 同步隐藏FOV
            end
        end)

        -- 拖拽逻辑
        local dragging, dragStart, startPos = false, nil, nil
        table.insert(QWQ_Trigger_DragConnections, QWQ_Trigger_Btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true dragStart = input.Position startPos = QWQ_Trigger_Btn.Position
            end
        end))
        table.insert(QWQ_Trigger_DragConnections, UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                if dragging then
                    local delta = input.Position - dragStart
                    QWQ_Trigger_Btn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end
            end
        end))
        table.insert(QWQ_Trigger_DragConnections, UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end))
    end

    -- ==========================================
    -- 精准判定系统
    -- ==========================================
    local function IsValidNPC(model)
        if not model or not model:IsA("Model") then return false end
        if not model:FindFirstChild("HumanoidRootPart") then return false end
        local hum = model:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then return false end
        if Players:GetPlayerFromCharacter(model) then return false end
        return true
    end

    local function GetTargetFromCrosshair()
        local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        local ray = Camera:ViewportPointToRay(center.X, center.Y)
        local params = RaycastParams.new()
        params.FilterDescendantsInstances = {LocalPlayer.Character or {}}
        params.FilterType = Enum.RaycastFilterType.Blacklist
        local result = workspace:Raycast(ray.Origin, ray.Direction * 1000, params)
        if result and result.Instance then
            return result.Instance:FindFirstAncestorOfClass("Model")
        end
        return nil
    end

    local function CheckTargetInFOV(character, center, radius)
        if not character then return false end
        local partsToCheck = {"HumanoidRootPart", "Head", "UpperTorso", "LowerTorso", "Torso"}
        for _, partName in ipairs(partsToCheck) do
            local part = character:FindFirstChild(partName)
            if part then
                local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                if onScreen then
                    if (Vector2.new(pos.X, pos.Y) - center).Magnitude <= radius then
                        if QWQ_Trigger_WallCheck then
                            local origin = Camera.CFrame.Position
                            local dir = part.Position - origin
                            local params = RaycastParams.new()
                            params.FilterDescendantsInstances = {LocalPlayer.Character or {}}
                            params.FilterType = Enum.RaycastFilterType.Blacklist
                            local res = workspace:Raycast(origin, dir, params)
                            if res and res.Instance and res.Instance:IsDescendantOf(character) then
                                return true
                            end
                        else
                            return true
                        end
                    end
                end
            end
        end
        return false
    end

    -- ==========================================
    -- 核心点击循环 
    -- ==========================================
    task.spawn(function()
        local VirtualInputManager = game:GetService("VirtualInputManager")
        while true do
            task.wait(QWQ_Trigger_Delay)
            
            -- 【核心拦截】：必须总开关和悬浮按钮同时开启才生效
            if not (QWQ_Trigger_MasterEnabled and QWQ_Trigger_BtnEnabled) then continue end
            
            local localChar = LocalPlayer.Character
            local localHum = localChar and localChar:FindFirstChildOfClass("Humanoid")
            if not localHum or localHum.Health <= 0 then continue end

            local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            local targetFound = false

            -- 1. 优先进行射线精准判定
            local directModel = GetTargetFromCrosshair()
            if directModel then
                local hum = directModel:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    local targetPlayer = Players:GetPlayerFromCharacter(directModel)
                    local isPlayer = targetPlayer ~= nil
                    
                    if isPlayer and QWQ_Trigger_TargetPlayers and directModel ~= LocalPlayer.Character then
                        if not (QWQ_Trigger_TeamCheck and targetPlayer.Team == LocalPlayer.Team) then
                            targetFound = true
                        end
                    elseif not isPlayer and QWQ_Trigger_TargetNPCs and QWQ_Trigger_NPC_Cache[directModel] then
                        targetFound = true
                    end
                end
            end

            -- 2. 如果没指到，且 FOV 大于 8，则进行容错范围判定
            if not targetFound and QWQ_Trigger_Radius > 8 then
                if QWQ_Trigger_TargetPlayers then
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player == LocalPlayer then continue end
                        if QWQ_Trigger_TeamCheck and player.Team == LocalPlayer.Team then continue end
                        
                        local char = player.Character
                        local hum = char and char:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health > 0 and CheckTargetInFOV(char, center, QWQ_Trigger_Radius) then
                            targetFound = true break
                        end
                    end
                end
                
                if not targetFound and QWQ_Trigger_TargetNPCs then
                    for npcModel, _ in pairs(QWQ_Trigger_NPC_Cache) do
                        local hum = npcModel:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health > 0 then
                            if CheckTargetInFOV(npcModel, center, QWQ_Trigger_Radius) then targetFound = true break end
                        else
                            if hum and hum.Health <= 0 then QWQ_Trigger_NPC_Cache[npcModel] = nil end
                        end
                    end
                end
            end

            -- 3. 触发开火
            if targetFound then
                -- 电脑端 - 强制屏幕正中心左键点击
                if QWQ_Trigger_MouseClick then
                    pcall(function()
                        VirtualInputManager:SendMouseButtonEvent(center.X, center.Y, 0, true, game, 1)
                        task.wait(0.02)
                        VirtualInputManager:SendMouseButtonEvent(center.X, center.Y, 0, false, game, 1)
                    end)
                end
            end
        end
    end)


    -- ==========================================
    -- UI 控件绑定 (已修改为 Tabs.clickbot)
    -- ==========================================
    Tabs.clickbot:AddToggle("QWQ_Trigger_Master", {
        Title = "总开关 (自动扳机)",
        Description = "开启后屏幕生成快捷控制小按钮，支持一键热切换",
        Default = false,
        Callback = function(state)
            QWQ_Trigger_MasterEnabled = state
            TriggerFOV.Visible = state
            
            if state then
                CreateTriggerButton()
                if QWQ_Trigger_TargetNPCs then
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj:IsA("Model") and IsValidNPC(obj) then QWQ_Trigger_NPC_Cache[obj] = true end
                    end
                end
            else
                DestroyTriggerButton()
                TriggerFOV.Visible = false
            end
        end
    })
    
    Tabs.clickbot:AddToggle("QWQ_Trigger_WallCheckToggle", {
        Title = "开启墙壁检测 (防隔墙射击)",
        Description = "目标被墙挡住时不会开火，保证子弹不白白浪费",
        Default = true,
        Callback = function(state) QWQ_Trigger_WallCheck = state end
    })

    Tabs.clickbot:AddToggle("QWQ_Trigger_MouseToggle", {
        Title = "使用鼠标左键模拟",
        Description = "强制在屏幕物理正中心模拟左键点击，向目标开火",
        Default = false,
        Callback = function(state) QWQ_Trigger_MouseClick = state end
    })

    Tabs.clickbot:AddToggle("QWQ_Trigger_Players", {
        Title = "对 玩家 生效",
        Default = false,
        Callback = function(state) QWQ_Trigger_TargetPlayers = state end
    })
    
    Tabs.clickbot:AddToggle("QWQ_Trigger_TeamCheck", {
        Title = "玩家队伍检测 (防误伤队友)",
        Description = "开启后自动过滤同队玩家，防止扳机对队友开火",
        Default = false,
        Callback = function(state) QWQ_Trigger_TeamCheck = state end
    })

    Tabs.clickbot:AddToggle("QWQ_Trigger_NPCs", {
        Title = "对 NPC 生效",
        Default = false,
        Callback = function(state)
            QWQ_Trigger_TargetNPCs = state
            if not state then table.clear(QWQ_Trigger_NPC_Cache) end
        end
    })

    Tabs.clickbot:AddSlider("QWQ_Trigger_Radius", {
        Title = "扳机 FOV 范围",
        Min = 1,
        Max = 400,
        Default = 100,
        Rounding = 0,
        Callback = function(value) 
            QWQ_Trigger_Radius = value
            TriggerFOV.Size = UDim2.new(0, value * 2, 0, value * 2)
        end
    })

    Tabs.clickbot:AddSlider("QWQ_Trigger_CPS", {
        Title = "点击频率 (CPS)",
        Description = "每秒点击次数",
        Min = 1,
        Max = 30,
        Default = 10,
        Rounding = 0,
        Callback = function(value) QWQ_Trigger_Delay = 1 / value end
    })

    Tabs.clickbot:AddColorpicker("QWQ_Trigger_Color", {
        Title = "FOV 圈颜色",
        Default = Color3.fromRGB(255, 0, 0),
        Callback = function(value) 
            QWQ_Trigger_FOVColor = value 
            TriggerStroke.Color = value
        end
    })
end













do
Tabs.World:AddToggle("SelfGlow", {
    Title = "自身发光",
    Default = false,
    Callback = function(value)
        pcall(function()
            if value then
                local light = Instance.new("PointLight", lplr.Character.Head)
                light.Name = "nb"
                light.Range = lightRange
                light.Brightness = lightBrightness
                light.Color = lightColor
            else
                if lplr.Character and lplr.Character.Head:FindFirstChild("nb") then
                    lplr.Character.Head.nb:Destroy()
                end
            end
        end)
    end
})

Tabs.World:AddInput("LightBrightness", {
    Title = "光照亮度",
    Default = "1",
    Numeric = true,
    Callback = function(value)
        pcall(function()
            local newBrightness = tonumber(value) or 1
            lightBrightness = newBrightness
            if lplr.Character and lplr.Character.Head:FindFirstChild("nb") then
                lplr.Character.Head.nb.Brightness = lightBrightness
            end
        end)
    end
})

Tabs.World:AddInput("LightRange", {
    Title = "光照范围",
    Default = "150",
    Numeric = true,
    Callback = function(value)
        pcall(function()
            local newRange = tonumber(value) or 150
            lightRange = newRange
            if lplr.Character and lplr.Character.Head:FindFirstChild("nb") then
                lplr.Character.Head.nb.Range = lightRange
            end
        end)
    end
})

Tabs.World:AddColorpicker("LightColor", {
    Title = "光照颜色",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(value)
        pcall(function()
            lightColor = value
            if lplr.Character and lplr.Character.Head:FindFirstChild("nb") then
                lplr.Character.Head.nb.Color = lightColor
            end
        end)
    end
})

    

    Tabs.World:AddSection("")
    Tabs.World:AddToggle("MuteSounds", {
        Title = "静音模式",
        Default = false,
        Callback = function(value)
            soundMuted = value
            for _, sound in pairs(game:GetDescendants()) do
                if sound:IsA("Sound") then
                    sound.Volume = value and 0 or (sound:GetAttribute("OriginalVolume") or 0.5) * soundBoost
                    if not sound:GetAttribute("OriginalVolume") and not value then
                        sound:SetAttribute("OriginalVolume", sound.Volume)
                    end
                end
            end
        end
    })
    Tabs.World:AddInput("SoundBoost", {
        Title = "环境音效增强",
        Description = "炸麦",
        Default = "1",
        Numeric = true,
        Callback = function(value)
            soundBoost = tonumber(value) or 1
            if not soundMuted then
                for _, sound in pairs(game:GetDescendants()) do
                    if sound:IsA("Sound") then
                        sound.Volume = (sound:GetAttribute("OriginalVolume") or 0.5) * soundBoost
                    end
                end
            end
        end
    })

    Tabs.World:AddSection("")

    Tabs.World:AddToggle("FullBrightToggle", {
        Title = "全图照明",
        Description = "夜视",
        Default = false,
        Callback = function(value)
            fullBrightEnabled = value
            if value then
                Lighting.Brightness = 5
                Lighting.FogEnd = 1000000
                Lighting.GlobalShadows = false
            else
                Lighting.Brightness = 2
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = true
            end
        end
    })
end

local function isNumber(value)
    return tonumber(value) ~= nil
end

Tabs.Player:AddSection("玩家加速")

local speedEnabled = false
local speedValue = 20          
local speedMode = "Vector"     
local originalWalkSpeed = nil  
local speedConnection = nil

local function disableSpeed()
    if speedConnection then
        speedConnection:Disconnect()
        speedConnection = nil
    end
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            if originalWalkSpeed then
                LocalPlayer.Character.Humanoid.WalkSpeed = originalWalkSpeed
            end
        end
    end)
end

local function updateOriginalWalkSpeed()
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            if not originalWalkSpeed then
                originalWalkSpeed = LocalPlayer.Character.Humanoid.WalkSpeed
            end
        end
    end)
end

local function enableSpeed()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or not LocalPlayer.Character:FindFirstChild("Humanoid") then
        return
    end

    local humanoid = LocalPlayer.Character.Humanoid
    local hrp = LocalPlayer.Character.HumanoidRootPart

    updateOriginalWalkSpeed()

    if speedConnection then speedConnection:Disconnect() end

    if speedMode == "WalkSpeed" then
        humanoid.WalkSpeed = speedValue

    elseif speedMode == "Vector" then
        speedConnection = RunService.Heartbeat:Connect(function()
            if humanoid.MoveDirection.Magnitude > 0 then
                local desiredVelocity = humanoid.MoveDirection * speedValue * 3.6
                hrp.Velocity = Vector3.new(desiredVelocity.X, hrp.Velocity.Y, desiredVelocity.Z)
            else
                hrp.Velocity = Vector3.new(0, hrp.Velocity.Y, 0)
            end
        end)

    elseif speedMode == "CFrame" then
        speedConnection = RunService.Heartbeat:Connect(function(dt)
            if humanoid.MoveDirection.Magnitude > 0 then
                local moveOffset = humanoid.MoveDirection * speedValue * dt * 60
                hrp.CFrame = hrp.CFrame + moveOffset
            end
        end)

    elseif speedMode == "TP" then
        speedConnection = RunService.Heartbeat:Connect(function(dt)
            if humanoid.MoveDirection.Magnitude > 0 then
                local distance = speedValue * dt * 55
                hrp.CFrame = hrp.CFrame + (humanoid.MoveDirection * distance)
            end
        end)
    end
end

Tabs.Player:AddToggle("SpeedEnabled", {
    Title = "开启加速",
    Default = false,
    Callback = function(value)
        speedEnabled = value
        if value then
            enableSpeed()
        else
            disableSpeed()
        end
    end
})

Tabs.Player:AddInput("SpeedValue", {
    Title = "加速速度",
    Default = "20",
    Numeric = true,
    Callback = function(value)
        local num = tonumber(value)
        if num then
            speedValue = num
            if speedEnabled and speedMode == "WalkSpeed" then
                pcall(function()
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                        LocalPlayer.Character.Humanoid.WalkSpeed = num
                    end
                end)
            end
        end
    end
})

Tabs.Player:AddDropdown("SpeedMode", {
    Title = "加速模式",
    Values = {"WalkSpeed", "Vector", "CFrame", "TP"},
    Default = "Vector",
    Callback = function(value)
        speedMode = value
        if speedEnabled then
            disableSpeed()  
            enableSpeed()   
        end
    end
})

LocalPlayer.CharacterAdded:Connect(function(character)
    originalWalkSpeed = nil  
    character:WaitForChild("Humanoid", 10)
    character:WaitForChild("HumanoidRootPart", 10)
    
    updateOriginalWalkSpeed()  
    
    if speedEnabled then
        task.wait(0.5)  
        enableSpeed()   
    else
        pcall(function()
            if character:FindFirstChild("Humanoid") and originalWalkSpeed then
                character.Humanoid.WalkSpeed = originalWalkSpeed
            end
        end)
    end
end)

if LocalPlayer.Character then
    updateOriginalWalkSpeed()
end

Tabs.Player:AddSection("玩家跳跃")

local jumpEnabled = false
local jumpValue = 50           
local jumpMode = "JumpPower"   
local originalJumpPower = nil  
local jumpConnection = nil

local function disableJump()
    if jumpConnection then
        jumpConnection:Disconnect()
        jumpConnection = nil
    end
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            if originalJumpPower then
                LocalPlayer.Character.Humanoid.JumpPower = originalJumpPower
            end
        end
    end)
end

local function updateOriginalJumpPower()
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            if not originalJumpPower then
                originalJumpPower = LocalPlayer.Character.Humanoid.JumpPower
            end
        end
    end)
end

local function enableJump()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or not LocalPlayer.Character:FindFirstChild("Humanoid") then
        return
    end

    local humanoid = LocalPlayer.Character.Humanoid
    local hrp = LocalPlayer.Character.HumanoidRootPart

    updateOriginalJumpPower()

    if jumpConnection then jumpConnection:Disconnect() end

    if jumpMode == "JumpPower" then
        humanoid.JumpPower = jumpValue

    elseif jumpMode == "Vector" then
        jumpConnection = UserInputService.JumpRequest:Connect(function()
            if humanoid:GetState() == Enum.HumanoidStateType.Freefall or humanoid:GetState() == Enum.HumanoidStateType.Jumping then
                hrp.Velocity = Vector3.new(hrp.Velocity.X, jumpValue, hrp.Velocity.Z)
            end
        end)

    elseif jumpMode == "CFrame" then
        jumpConnection = UserInputService.JumpRequest:Connect(function()
            if humanoid:GetState() == Enum.HumanoidStateType.Freefall or humanoid:GetState() == Enum.HumanoidStateType.Jumping then
                hrp.CFrame = hrp.CFrame + Vector3.new(0, jumpValue, 0)
            end
        end)

    elseif jumpMode == "Impulse" then
        jumpConnection = UserInputService.JumpRequest:Connect(function()
            if humanoid:GetState() == Enum.HumanoidStateType.Freefall or humanoid:GetState() == Enum.HumanoidStateType.Jumping then
                hrp:ApplyImpulse(Vector3.new(0, humanoid.Mass * jumpValue, 0))
            end
        end)
    end
end

Tabs.Player:AddToggle("JumpEnabled", {
    Title = "开启跳跃增强",
    Default = false,
    Callback = function(value)
        jumpEnabled = value
        if value then
            enableJump()
        else
            disableJump()
        end
    end
})

Tabs.Player:AddInput("JumpValue", {
    Title = "跳跃高度",
    Default = "50",
    Numeric = true,
    Callback = function(value)
        local num = tonumber(value)
        if num then
            jumpValue = num
            if jumpEnabled and jumpMode == "JumpPower" then
                pcall(function()
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                        LocalPlayer.Character.Humanoid.JumpPower = num
                    end
                end)
            end
        end
    end
})

Tabs.Player:AddDropdown("JumpMode", {
    Title = "跳跃模式",
    Values = {"JumpPower", "Vector", "CFrame", "Impulse"},
    Default = "JumpPower",
    Callback = function(value)
        jumpMode = value
        if jumpEnabled then
            disableJump()  
            enableJump()   
        end
    end
})

local infiniteJumpEnabled = false
local infiniteJumpConnection = nil

Tabs.Player:AddToggle("InfiniteJump", {
    Title = "无限跳跃",
    Default = false,
    Callback = function(value)
        infiniteJumpEnabled = value
        if infiniteJumpConnection then
            infiniteJumpConnection:Disconnect()
            infiniteJumpConnection = nil
        end
        if value then
            infiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
                pcall(function()
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end)
            end)
        end
    end
})

local autoJumpEnabled = false
local autoJumpConnection = nil

Tabs.Player:AddToggle("AutoJump", {
    Title = "自动跳跃",
    Default = false,
    Callback = function(value)
        autoJumpEnabled = value
        if autoJumpConnection then
            autoJumpConnection:Disconnect()
            autoJumpConnection = nil
        end
        if value then
            autoJumpConnection = RunService.Heartbeat:Connect(function()
                pcall(function()
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                        LocalPlayer.Character.Humanoid.Jump = true
                    end
                end)
            end)
        end
    end
})
-- ===============================================
-- 自动旋转
-- ===============================================
-- 带有独一无二 QWQ_SpinBot_ 前缀的全局隔离级变量
local QWQ_SpinBot_GlobalState_IsActive = false
local QWQ_SpinBot_GlobalState_RotationSpeed = 20
local QWQ_SpinBot_System_RenderStepConnection = nil
local QWQ_SpinBot_System_CharacterAddedConnection = nil -- 替换为角色重生监听连接

-- 独一无二的终止清理函数（只清理底层的连接，不影响 UI 开关状态）
local function QWQ_SpinBot_CoreFunction_TerminateSpinning()
    -- 强行熔断渲染层连接，确保 0 条垃圾代码驻留 CPU
    if QWQ_SpinBot_System_RenderStepConnection then
        QWQ_SpinBot_System_RenderStepConnection:Disconnect()
        QWQ_SpinBot_System_RenderStepConnection = nil
    end
end

-- 彻底关闭整个系统的函数（当手动关闭 UI 开关时调用）
local function QWQ_SpinBot_CoreFunction_DisableEntirely()
    QWQ_SpinBot_GlobalState_IsActive = false
    QWQ_SpinBot_CoreFunction_TerminateSpinning()
    
    -- 断开重生监听
    if QWQ_SpinBot_System_CharacterAddedConnection then
        QWQ_SpinBot_System_CharacterAddedConnection:Disconnect()
        QWQ_SpinBot_System_CharacterAddedConnection = nil
    end
end

-- 独一无二的启动驱动函数
local function QWQ_SpinBot_CoreFunction_InitializeSpinning()
    QWQ_SpinBot_CoreFunction_TerminateSpinning() -- 前置清洗渲染连接，防止多次叠加物理层
    
    -- 极速自适应物理心跳循环
    QWQ_SpinBot_System_RenderStepConnection = RunService.RenderStepped:Connect(function(QWQ_SpinBot_Runtime_DeltaTime)
        if not QWQ_SpinBot_GlobalState_IsActive then return end
        
        local QWQ_SpinBot_Loop_Char = LocalPlayer.Character
        if not QWQ_SpinBot_Loop_Char then return end
        
        local QWQ_SpinBot_Loop_Hrp = QWQ_SpinBot_Loop_Char:FindFirstChild("HumanoidRootPart")
        local QWQ_SpinBot_Loop_Hum = QWQ_SpinBot_Loop_Char:FindFirstChild("Humanoid")
        
        -- 严格多重边界判定，防止对假死、无碰撞箱或换模组时的人物实体进行非法坐标运算
        if QWQ_SpinBot_Loop_Hrp and QWQ_SpinBot_Loop_Hum and QWQ_SpinBot_Loop_Hum.Health > 0 then
            QWQ_SpinBot_Loop_Hrp.CFrame = QWQ_SpinBot_Loop_Hrp.CFrame * CFrame.Angles(0, math.rad(QWQ_SpinBot_GlobalState_RotationSpeed * QWQ_SpinBot_Runtime_DeltaTime * 60), 0)
        end
    end)
end

-- 开启监听与注册函数
local function QWQ_SpinBot_CoreFunction_StartSystem()
    QWQ_SpinBot_CoreFunction_DisableEntirely() -- 全面初始化清洗
    QWQ_SpinBot_GlobalState_IsActive = true
    
    -- 1. 针对当前已经存在的角色立即初始化一次
    if LocalPlayer.Character then
        QWQ_SpinBot_CoreFunction_InitializeSpinning()
    end
    
    -- 2. 核心：监听重生。只要玩家复活，就会自动重新挂载旋转逻辑，不再关闭 UI 开关
    QWQ_SpinBot_System_CharacterAddedConnection = LocalPlayer.CharacterAdded:Connect(function(newCharacter)
        -- 稍微等待 Humanoid 加载，确保物理层完全就绪
        newCharacter:WaitForChild("Humanoid", 5)
        if QWQ_SpinBot_GlobalState_IsActive then
            QWQ_SpinBot_CoreFunction_InitializeSpinning()
        end
    end)
end

-- ==========================================================
-- 【UI构建】：防冲突独立索引化界面绑定
-- ==========================================================
if Tabs and Tabs.Player then
    Tabs.Player:AddSection("玩家旋转")

    -- 内部索引键（Key）全部更改为独一无二的名称，彻底断绝全局UI库的命名冲突
    Tabs.Player:AddToggle("QWQ_SpinBot_UniqueKey_Toggle", {
        Title = "开启玩家旋转",
        Default = false,
        Callback = function(QWQ_SpinBot_UI_ToggleState)
            if QWQ_SpinBot_UI_ToggleState then
                QWQ_SpinBot_CoreFunction_StartSystem()
            else
                QWQ_SpinBot_CoreFunction_DisableEntirely()
            end
        end
    })

    Tabs.Player:AddSlider("QWQ_SpinBot_UniqueKey_SpeedSlider", {
        Title = "旋转速度",
        Min = 10,
        Max = 4000, -- 极限陀螺转速
        Default = 20,
        Rounding = 0,
        Callback = function(QWQ_SpinBot_UI_SliderState)
            QWQ_SpinBot_GlobalState_RotationSpeed = QWQ_SpinBot_UI_SliderState
        end
    })
end




-- ==========================================
-- ==========================================
Tabs.Player:AddSection("特殊动作机制 (穿墙)")

local noclipState = false
local noclipLoop = nil
local PhysicsService = game:GetService("PhysicsService")
local LocalPlayer = game:GetService("Players").LocalPlayer

-- 初始化高级碰撞组（仅在未注册时创建）
pcall(function()
    PhysicsService:RegisterCollisionGroup("NoclipGroup")
    PhysicsService:CollisionGroupSetCollidable("NoclipGroup", "Default", false)
end)

-- 辅助函数：将角色应用到穿墙碰撞组
local function applyNoclipGroup(state)
    local char = LocalPlayer.Character
    if char then
        for _, child in ipairs(char:GetDescendants()) do
            if child:IsA("BasePart") then
                child.CollisionGroup = state and "NoclipGroup" or "Default"
            end
        end
    end
end

-- 开关 1：基础穿墙 (每帧动态关闭碰撞)
Tabs.Player:AddToggle("Noclip_Toggle", {
    Title = "基础穿墙 (动态每帧)",
    Description = "通过每帧关闭身体碰撞实现穿墙（平滑、最常用）",
    Default = false,
    Callback = function(v)
        noclipState = v
        
        if v then
            -- 如果开启了基础穿墙，建议关闭高级穿墙避免逻辑冲突
            if Options.AdvNoclip_Toggle and Options.AdvNoclip_Toggle.Value then
                Options.AdvNoclip_Toggle:SetValue(false)
            end

            noclipLoop = game:GetService("RunService").Stepped:Connect(function()
                if not noclipState then
                    if noclipLoop then noclipLoop:Disconnect() noclipLoop = nil end
                    return
                end
                
                local char = LocalPlayer.Character
                if char then
                    for _, obj in ipairs(char:GetDescendants()) do
                        if obj:IsA("BasePart") then
                            obj.CanCollide = false
                        end
                    end
                end
            end)
            
            Fluent:Notify({Title = "基础穿墙已开启", Content = "您现在可以自由穿过任何墙壁", Duration = 3})
        else
            if noclipLoop then
                noclipLoop:Disconnect()
                noclipLoop = nil
            end
            Fluent:Notify({Title = "基础穿墙已关闭", Content = "已恢复正常的物理碰撞", Duration = 3})
        end
    end
})

-- 开关 2：高级穿墙 (物理碰撞组拦截)
local advNoclipConnection = nil
Tabs.Player:AddToggle("AdvNoclip_Toggle", {
    Title = "高级穿墙 (碰撞组图层)",
    Description = "改变身体物理图层不与环境碰撞（适合对抗部分反作弊）",
    Default = false,
    Callback = function(v)
        if v then
            -- 如果开启了高级穿墙，关闭基础穿墙避免逻辑冲突
            if Options.Noclip_Toggle and Options.Noclip_Toggle.Value then
                Options.Noclip_Toggle:SetValue(false)
            end

            -- 立即应用到当前身体
            applyNoclipGroup(true)

            -- 监听玩家复活/刷新，自动重新应用碰撞组
            advNoclipConnection = LocalPlayer.CharacterAdded:Connect(function(char)
                task.wait(0.5) -- 等待身体部件加载
                applyNoclipGroup(true)
            end)

            Fluent:Notify({Title = "高级穿墙已开启", Content = "已修改身体物理图层", Duration = 3})
        else
            -- 断开复活监听
            if advNoclipConnection then
                advNoclipConnection:Disconnect()
                advNoclipConnection = nil
            end
            -- 还原默认碰撞组
            applyNoclipGroup(false)

            Fluent:Notify({Title = "高级穿墙已关闭", Content = "已还原默认物理图层", Duration = 3})
        end
    end
})


LocalPlayer.CharacterAdded:Connect(function(character)
    originalJumpPower = nil  
    character:WaitForChild("Humanoid", 10)
    character:WaitForChild("HumanoidRootPart", 10)
    
    updateOriginalJumpPower()  
    
    if jumpEnabled then
        task.wait(0.5)  
        enableJump()    
    else
        pcall(function()
            if character:FindFirstChild("Humanoid") and originalJumpPower then
                character.Humanoid.JumpPower = originalJumpPower
            end
        end)
    end
end)

if LocalPlayer.Character then
    updateOriginalJumpPower()
end 




-- ==========================================================
-- 【功能构建】：被动反制系统 (挨打反锁 / Counter-Aim)
-- ==========================================================
if Tabs and Tabs.Aimbot then
    Tabs.Aimbot:AddSection("🛡️ 被动反制系统 (反自瞄)")

    local QWQ_CounterAim_Enabled = false
    local QWQ_CounterAim_Angle = 15
    local QWQ_CounterAim_Smoothness = 0.6
    local QWQ_CounterAim_WallCheck = true
    
    -- 核心渲染循环：实时监测全图所有玩家的视线
    RunService.RenderStepped:Connect(function()
        if not QWQ_CounterAim_Enabled then return end
        
        local localChar = LocalPlayer.Character
        local localHead = localChar and localChar:FindFirstChild("Head")
        local localHrp = localChar and localChar:FindFirstChild("HumanoidRootPart")
        
        -- 确保自身存活且实体完整
        if not localHead or not localHrp then return end
        
        local threatPart = nil
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                -- 【黑名单容错】如果你开启了黑名单，被黑名单内的玩家看不会触发反锁
                if AimbotBlacklistEnabled and AimbotBlacklist and table.find(AimbotBlacklist, player.Name) then 
                    continue 
                end
                
                -- 【队伍检测容错】
                if AimbotTeamCheck and player.Team == LocalPlayer.Team then 
                    continue 
                end
                
                local char = player.Character
                if char then
                    local head = char:FindFirstChild("Head")
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    
                    if head and hrp and hum and hum.Health > 0 then
                        -- 计算敌人头部到我方头部的方向向量
                        local dirToMe = (localHead.Position - head.Position).Unit
                        
                        -- 敌人的实际面朝方向 (取头部的LookVector最准确)
                        local enemyLookDir = head.CFrame.LookVector
                        
                        -- 点积运算求出视线夹角
                        local dotProduct = math.clamp(dirToMe:Dot(enemyLookDir), -1, 1)
                        local angle = math.deg(math.acos(dotProduct))
                        
                        -- 如果敌人的视线夹角小于你设置的阈值，说明他正盯着你看
                        if angle <= QWQ_CounterAim_Angle then
                            local hasLineOfSight = true
                            
                            -- 墙壁检测：如果别人隔着墙看你，不触发反锁
                            if QWQ_CounterAim_WallCheck then
                                local rayParams = RaycastParams.new()
                                rayParams.FilterDescendantsInstances = {char}
                                rayParams.FilterType = Enum.RaycastFilterType.Blacklist
                                
                                -- 打一条从敌人头部到我方的射线
                                local result = workspace:Raycast(head.Position, dirToMe * 1000, rayParams)
                                
                                -- 如果射线命中了我方的身体部件，说明视线无遮挡
                                if result and result.Instance and result.Instance:IsDescendantOf(localChar) then
                                    hasLineOfSight = true
                                else
                                    hasLineOfSight = false
                                end
                            end
                            
                            if hasLineOfSight then
                                threatPart = head -- 锁定该威胁的头部
                                break -- 找到第一个盯着我的威胁就立即执行反锁
                            end
                        end
                    end
                end
            end
        end
        
        -- 执行镜头反击反锁
        if threatPart then
            -- 如果同时开启了主动自瞄，反锁系统的优先级更高，会短暂抢夺控制权
            local newCFrame = CFrame.new(Camera.CFrame.Position, threatPart.Position)
            Camera.CFrame = Camera.CFrame:Lerp(newCFrame, QWQ_CounterAim_Smoothness)
        end
    end)
    
    -- ==========================================
    -- UI 控件绑定
    -- ==========================================
    Tabs.Aimbot:AddToggle("QWQ_CounterAim_Master", {
        Title = "开启 挨打反锁 (Counter-Aim)",
        Description = "当其他玩家将枪口/视线对准你时，镜头会瞬间自动锁定他的头部",
        Default = false,
        Callback = function(state)
            QWQ_CounterAim_Enabled = state
        end
    })
    
    Tabs.Aimbot:AddToggle("QWQ_CounterAim_Wall", {
        Title = "反锁墙壁检测",
        Description = "开启后，敌人即使看你，如果中间有墙挡着也不会触发",
        Default = true,
        Callback = function(state) QWQ_CounterAim_WallCheck = state end
    })
    
    Tabs.Aimbot:AddSlider("QWQ_CounterAim_Angle", {
        Title = "敌方感知敏感度 (角度)",
        Description = "越小越精准（只有死死盯着你才反锁），越大越容易触发（看你附近也反锁）",
        Min = 1,
        Max = 60,
        Default = 15,
        Rounding = 0,
        Callback = function(value) QWQ_CounterAim_Angle = value end
    })
    
    Tabs.Aimbot:AddSlider("QWQ_CounterAim_Smoothness", {
        Title = "反锁平滑度",
        Description = "发现有人瞄准你时，镜头甩过去的快慢",
        Min = 0.05,
        Max = 1,
        Default = 0.6,
        Rounding = 2,
        Callback = function(value) QWQ_CounterAim_Smoothness = value end
    })
end





--自瞄

local FOVCircle = Instance.new("Frame")
FOVCircle.Name = "AimbotFOV"
FOVCircle.Parent = ScreenGui
FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FOVCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
FOVCircle.Size = UDim2.new(0, AimbotFOVRadius * 2, 0, AimbotFOVRadius * 2)
FOVCircle.BackgroundTransparency = 1
FOVCircle.Visible = false

local UIStroke = Instance.new("UIStroke", FOVCircle)
UIStroke.Thickness = 2
UIStroke.Color = AimbotFOVColor

local UICorner = Instance.new("UICorner", FOVCircle)
UICorner.CornerRadius = UDim.new(1, 0)

Tabs.Aimbot:AddDropdown("AimbotTargetPartDropdown", {
    Title = "自瞄部位",
    Values = {"头部", "身体"},
    Default = 2, -- 默认选第二个(身体)
    Callback = function(value)
        if value == "头部" then
            AimbotTargetPart = "Head"
        else
            AimbotTargetPart = "HumanoidRootPart"
        end
    end
})

local function GetClosestTarget()
    local closest = nil
    local shortestDist = AimbotFOVRadius

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            -- 【核心修改1】：触发黑名单拦截，如果玩家在黑名单内，直接跳过不瞄准
            if AimbotBlacklistEnabled and table.find(AimbotBlacklist, player.Name) then 
                continue 
            end

            local targetPart = player.Character:FindFirstChild(AimbotTargetPart)
            if not targetPart then continue end

            if AimbotTeamCheck and player.Team == LocalPlayer.Team then continue end
            
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if not humanoid or humanoid.Health <= 0 then continue end

            local pos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
            if onScreen then
                local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude

                if dist <= shortestDist then
                    if AimbotWallCheck then
                        local origin = Camera.CFrame.Position
                        local direction = (targetPart.Position - origin).Unit * 500
                        local raycastParams = RaycastParams.new()
                        raycastParams.FilterDescendantsInstances = {LocalPlayer.Character or {}}
                        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                        local result = workspace:Raycast(origin, direction, raycastParams)
                        if result and result.Instance:IsDescendantOf(player.Character) then
                            closest = player
                            shortestDist = dist
                        end
                    else
                        closest = player
                        shortestDist = dist
                    end
                end
            end
        end
    end
    return closest
end

local function UpdateSingleTarget()
    if not targetSinglePlayerName or targetSinglePlayerName == "无玩家" then
        targetSinglePlayer = nil
        return
    end

    local mode = Options.SingleModeDropdown.Value or "名称"
    for _, player in pairs(Players:GetPlayers()) do
        -- 【核心修改2】：单人自瞄同样受黑名单保护
        if AimbotBlacklistEnabled and table.find(AimbotBlacklist, player.Name) then
            continue
        end
        
        if (mode == "名称" and player.Name == targetSinglePlayerName) or
           (mode == "昵称" and player.DisplayName == targetSinglePlayerName) then
            targetSinglePlayer = player
            return
        end
    end
    targetSinglePlayer = nil
end

local function UpdateSinglePlayerList()
    local players = Players:GetPlayers()
    local playerNames = {}
    local mode = Options.SingleModeDropdown.Value or "名称"
    
    for _, player in pairs(players) do
        if player ~= LocalPlayer then
            if mode == "名称" then
                table.insert(playerNames, player.Name)
            elseif mode == "昵称" then
                table.insert(playerNames, player.DisplayName)
            end
        end
    end
    
    if #playerNames == 0 then playerNames = {"无玩家"} end
    Options.SinglePlayerDropdown:SetValues(playerNames)
    if #playerNames > 0 and playerNames[1] ~= "无玩家" then
        if not table.find(playerNames, Options.SinglePlayerDropdown.Value) then
            Options.SinglePlayerDropdown:SetValue(playerNames[1])
        end
    else
        Options.SinglePlayerDropdown:SetValue("无玩家")
    end
end

RunService.RenderStepped:Connect(function()
    if AimbotRainbowFOV then
        local hue = tick() % 5 / 5
        UIStroke.Color = Color3.fromHSV(hue, 1, 1)
    elseif UIStroke.Color ~= AimbotFOVColor then
        UIStroke.Color = AimbotFOVColor
    end

    if GlobalAimbotEnabled then
        local target = GetClosestTarget()
        if target and target.Character then
            -- 【修改核心】：获取你当前选择的部位进行平滑锁定
            local targetPart = target.Character:FindFirstChild(AimbotTargetPart)
            if targetPart then
                local targetPos = targetPart.Position
                local newCFrame = CFrame.new(Camera.CFrame.Position, targetPos)
                Camera.CFrame = Camera.CFrame:Lerp(newCFrame, AimbotSmoothness)
            end
        end
    elseif SingleAimbotEnabled then
        UpdateSingleTarget()
        if targetSinglePlayer and targetSinglePlayer.Character then
            local humanoid = targetSinglePlayer.Character:FindFirstChild("Humanoid")
            local targetPart = targetSinglePlayer.Character:FindFirstChild(AimbotTargetPart)
            
            -- 【修改核心】：结合了死人忽略和动态部位锁定
            if humanoid and humanoid.Health > 0 and targetPart then
                local targetPos = targetPart.Position
                local newCFrame = CFrame.new(Camera.CFrame.Position, targetPos)
                Camera.CFrame = Camera.CFrame:Lerp(newCFrame, AimbotSmoothness)
            end
        end
    end
end)


Tabs.Aimbot:AddToggle("GlobalAimbotEnabled", {
    Title = "FOV自瞄",
    Default = false,
    Callback = function(value)
        GlobalAimbotEnabled = value
        FOVCircle.Visible = value
        
        if value and SingleAimbotEnabled then
            SingleAimbotEnabled = false
            Options.SingleAimbotEnabled:SetValue(false)
            Fluent:Notify({Title = "无法同时开启两个自瞄模式", Content = "已自动关闭单一玩家自瞄", Duration = 4})
        end
    end
})

Tabs.Aimbot:AddToggle("AimbotTeamCheck", {
    Title = "队伍检查",
    Description = "小部分服务器会误判",
    Default = false,
    Callback = function(value) AimbotTeamCheck = value end
})

Tabs.Aimbot:AddToggle("AimbotWallCheck", {
    Title = "墙壁检查",
    Default = true,
    Callback = function(value) AimbotWallCheck = value end
})



Tabs.Aimbot:AddSlider("AimbotFOVRadius", {
    Title = "FOV 范围",
    Min = 50,
    Max = 500,
    Default = 150,
    Rounding = 1,
    Callback = function(value)
        AimbotFOVRadius = value
        FOVCircle.Size = UDim2.new(0, value * 2, 0, value * 2)
    end
})

Tabs.Aimbot:AddSlider("AimbotSmoothness", {
    Title = "自瞄平滑度",
    Min = 0.05,
    Max = 1,
    Default = 0.4,
    Rounding = 2,
    Callback = function(value) AimbotSmoothness = value end
})

Tabs.Aimbot:AddToggle("AimbotRainbowFOV", {
    Title = "FOV 彩虹模式",
    Default = false,
    Callback = function(value) AimbotRainbowFOV = value end
})

Tabs.Aimbot:AddColorpicker("AimbotFOVColor", {
    Title = "FOV 颜色",
    Default = Color3.fromRGB(255, 215, 215),
    Callback = function(value)
        AimbotFOVColor = value
        if not AimbotRainbowFOV then
            UIStroke.Color = value
        end
    end
})

Tabs.Aimbot:AddParagraph({
        Title = "平滑度解释",
        Content = "调高是强锁自瞄\n调低是半锁自瞄"
    })

-- ==========================================
-- 黑名单系统 UI 界面
-- ==========================================
Tabs.Aimbot:AddSection("黑名单设置 (防误锁)")

Tabs.Aimbot:AddToggle("BlacklistToggle", {
    Title = "启用玩家黑名单",
    Description = "开启后，自瞄将完全无视黑名单中的玩家",
    Default = false,
    Callback = function(value) AimbotBlacklistEnabled = value end
})

Tabs.Aimbot:AddInput("BlacklistAddInput", {
    Title = "添加玩家到黑名单",
    Default = "",
    Placeholder = "输入完整的玩家名称...",
    Callback = function(value) targetAddName = value end
})

Tabs.Aimbot:AddButton({
    Title = "确认添加",
    Callback = function()
        if targetAddName ~= "" and not table.find(AimbotBlacklist, targetAddName) then
            table.insert(AimbotBlacklist, targetAddName)
            UpdateBlacklistDropdown()
            Fluent:Notify({Title = "黑名单已更新", Content = "已将 " .. targetAddName .. " 加入免打名单", Duration = 3})
        elseif targetAddName == "" then
            Fluent:Notify({Title = "提示", Content = "玩家名不能为空", Duration = 2})
        else
            Fluent:Notify({Title = "提示", Content = "该玩家已在黑名单中", Duration = 2})
        end
    end
})

Tabs.Aimbot:AddInput("BlacklistRemoveInput", {
    Title = "从黑名单移除",
    Default = "",
    Placeholder = "输入想移除的玩家名称...",
    Callback = function(value) targetRemoveName = value end
})

Tabs.Aimbot:AddButton({
    Title = "确认移除",
    Callback = function()
        local index = table.find(AimbotBlacklist, targetRemoveName)
        if index then
            table.remove(AimbotBlacklist, index)
            UpdateBlacklistDropdown()
            Fluent:Notify({Title = "黑名单已更新", Content = "已将 " .. targetRemoveName .. " 从免打名单移除", Duration = 3})
        else
            Fluent:Notify({Title = "提示", Content = "黑名单中未找到该玩家", Duration = 2})
        end
    end
})

Tabs.Aimbot:AddDropdown("BlacklistListDropdown", {
    Title = "当前黑名单玩家",
    Values = {"无玩家"},
    Default = 1,
    Callback = function(value) 
        -- 仅作为显示用途，点击下拉框可查看所有受保护的玩家
    end
})


Tabs.Aimbot:AddSection("指定玩家自瞄")

Tabs.Aimbot:AddDropdown("SingleModeDropdown", {
    Title = "选择模式",
    Values = {"名称", "昵称"},
    Default = 1,
    Callback = function() UpdateSinglePlayerList() end
})

Tabs.Aimbot:AddDropdown("SinglePlayerDropdown", {
    Title = "选择目标玩家",
    Values = {},
    Default = 1,
    Callback = function(value)
        if value ~= "无玩家" then
            targetSinglePlayerName = value
        else
            targetSinglePlayerName = nil
        end
        UpdateSingleTarget()
    end
})

Tabs.Aimbot:AddButton({
    Title = "刷新玩家列表",
    Callback = function() UpdateSinglePlayerList() end
})

Tabs.Aimbot:AddToggle("SingleAimbotEnabled", {
    Title = "开启指定玩家自瞄",
    Default = false,
    Callback = function(value)
        SingleAimbotEnabled = value
        
        if value then
            if targetSinglePlayerName == nil or targetSinglePlayerName == "无玩家" then
                Fluent:Notify({Title = "错误", Content = "请先选择一个目标玩家", Duration = 5})
                SingleAimbotEnabled = false
                Options.SingleAimbotEnabled:SetValue(false)
                return
            end
            
            if GlobalAimbotEnabled then
                GlobalAimbotEnabled = false
                Options.GlobalAimbotEnabled:SetValue(false)
                FOVCircle.Visible = false
                Fluent:Notify({Title = "提示", Content = "无法同时开启两个自瞄模式\n已自动关闭另一个", Duration = 4})
            end
        end
    end
})


-- ==========================================================
-- 【零掉帧引擎】：NPC 专属自动瞄准 (完全复刻玩家自瞄完美逻辑)
-- ==========================================================
if Tabs and Tabs.Aimbot then
    Tabs.Aimbot:AddSection("🤖 挂机特化：NPC 自瞄引擎")

    local NPC_Aimbot_Enabled = false
    local NPC_Aimbot_TargetPart = "HumanoidRootPart"
    local NPC_Aimbot_Smoothness = 0.4
    local NPC_Aimbot_Radius = 150
    local NPC_Aimbot_WallCheck = true
    local NPC_Aimbot_FOVColor = Color3.fromRGB(255, 170, 0)
    local NPC_Aimbot_RainbowFOV = false
    
    local NPC_Cache = {}
    local NPC_Connections = {}
    local NPC_RenderConnection = nil

    -- 采用与你玩家自瞄完全一致的 UI Frame 绘制 FOV (告别 Drawing 偏差)
    local ScreenGui_NPC = game:GetService("CoreGui"):FindFirstChild("QWQ_NPC_Aimbot_GUI") or Instance.new("ScreenGui")
    ScreenGui_NPC.Name = "QWQ_NPC_Aimbot_GUI"
    ScreenGui_NPC.Parent = game:GetService("CoreGui")
    ScreenGui_NPC.IgnoreGuiInset = true
    ScreenGui_NPC.ResetOnSpawn = false

    local NPC_FOVCircle = Instance.new("Frame")
    NPC_FOVCircle.Name = "NPC_AimbotFOV"
    NPC_FOVCircle.Parent = ScreenGui_NPC
    NPC_FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
    NPC_FOVCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
    NPC_FOVCircle.Size = UDim2.new(0, NPC_Aimbot_Radius * 2, 0, NPC_Aimbot_Radius * 2)
    NPC_FOVCircle.BackgroundTransparency = 1
    NPC_FOVCircle.Visible = false

    local NPC_UIStroke = Instance.new("UIStroke", NPC_FOVCircle)
    NPC_UIStroke.Thickness = 2
    NPC_UIStroke.Color = NPC_Aimbot_FOVColor

    local NPC_UICorner = Instance.new("UICorner", NPC_FOVCircle)
    NPC_UICorner.CornerRadius = UDim.new(1, 0)

    -- 1. 特征识别器
    local function IsValidNPC(model)
        if not model or not model:IsA("Model") then return false end
        if not model:FindFirstChild("HumanoidRootPart") then return false end
        local hum = model:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then return false end
        if Players:GetPlayerFromCharacter(model) then return false end
        return true
    end

    -- 2. 缓存管理
    local function AddNPCToCache(npcModel)
        if NPC_Cache[npcModel] then return end
        NPC_Cache[npcModel] = true

        local deathConn
        deathConn = npcModel.AncestryChanged:Connect(function(_, parent)
            if not parent then
                NPC_Cache[npcModel] = nil
                if deathConn then deathConn:Disconnect() end
            end
        end)
        
        local hum = npcModel:FindFirstChildOfClass("Humanoid")
        if hum then
            local healthConn
            healthConn = hum.Died:Connect(function()
                NPC_Cache[npcModel] = nil
                if healthConn then healthConn:Disconnect() end
            end)
        end
    end

    -- 3. 智能剪枝初次扫描
    local function ScanForNPCs(parent)
        if not NPC_Aimbot_Enabled or not parent then return end
        for _, child in ipairs(parent:GetChildren()) do
            if not NPC_Aimbot_Enabled then break end
            
            if child:IsA("BasePart") or child:IsA("Script") or child:IsA("Terrain") then continue end
            
            if child:IsA("Model") then
                if IsValidNPC(child) then
                    AddNPCToCache(child)
                else
                    task.defer(ScanForNPCs, child)
                end
            elseif child:IsA("Folder") then
                task.defer(ScanForNPCs, child)
            end
        end
    end

    -- 4. 获取最接近屏幕中心的 NPC (完全复刻你原脚本的逻辑与算式)
    local function GetClosestNPC()
        local closestTargetPart = nil
        local shortestDist = NPC_Aimbot_Radius

        for npcModel, _ in pairs(NPC_Cache) do
            local hum = npcModel:FindFirstChildOfClass("Humanoid")
            local hrp = npcModel:FindFirstChild("HumanoidRootPart")
            
            -- 智能回退：如果指定的部位找不到，默认保底锁身体
            local targetPart = npcModel:FindFirstChild(NPC_Aimbot_TargetPart) or hrp

            if targetPart and hum and hum.Health > 0 and hrp then
                local pos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                if onScreen then
                    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                    local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude

                    if dist <= shortestDist then
                        if NPC_Aimbot_WallCheck then
                            local origin = Camera.CFrame.Position
                            -- 采用你脚本里的 Unit * 500 的射线检测方式
                            local direction = (targetPart.Position - origin).Unit * 500
                            local raycastParams = RaycastParams.new()
                            raycastParams.FilterDescendantsInstances = {LocalPlayer.Character or {}}
                            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                            local result = workspace:Raycast(origin, direction, raycastParams)
                            if result and result.Instance:IsDescendantOf(npcModel) then
                                closestTargetPart = targetPart
                                shortestDist = dist
                            end
                        else
                            closestTargetPart = targetPart
                            shortestDist = dist
                        end
                    end
                end
            else
                if not hrp or (hum and hum.Health <= 0) then
                    NPC_Cache[npcModel] = nil
                end
            end
        end
        return closestTargetPart
    end

    -- 5. 清理引擎
    local function StopNPCAimbot()
        if NPC_RenderConnection then
            NPC_RenderConnection:Disconnect()
            NPC_RenderConnection = nil
        end
        for _, conn in ipairs(NPC_Connections) do
            conn:Disconnect()
        end
        table.clear(NPC_Connections)
        table.clear(NPC_Cache)
        NPC_FOVCircle.Visible = false -- 关闭时隐藏 FOV 圈
    end

    -- 6. 高频渲染循环
    local function NPCAimbotLoop()
        -- 你的彩虹圈逻辑完美平移
        if NPC_Aimbot_RainbowFOV then
            local hue = tick() % 5 / 5
            NPC_UIStroke.Color = Color3.fromHSV(hue, 1, 1)
        elseif NPC_UIStroke.Color ~= NPC_Aimbot_FOVColor then
            NPC_UIStroke.Color = NPC_Aimbot_FOVColor
        end

        local targetPart = GetClosestNPC()
        if targetPart then
            local targetPos = targetPart.Position
            local newCFrame = CFrame.new(Camera.CFrame.Position, targetPos)
            Camera.CFrame = Camera.CFrame:Lerp(newCFrame, NPC_Aimbot_Smoothness)
        end
    end

    -- ==========================================
    -- UI 控件绑定
    -- ==========================================
    Tabs.Aimbot:AddToggle("NPC_Aimbot_Toggle", {
        Title = "开启 NPC 自瞄",
        Description = "开启后自动显示 FOV 圈",
        Default = false,
        Callback = function(state)
            NPC_Aimbot_Enabled = state
            NPC_FOVCircle.Visible = state -- FOV 开关直接与此绑定
            
            if state then
                if Options.GlobalAimbotEnabled and Options.GlobalAimbotEnabled.Value then
                    Options.GlobalAimbotEnabled:SetValue(false)
                    Fluent:Notify({Title = "提示", Content = "已自动关闭玩家自瞄，防止冲突", Duration = 3})
                end

                table.insert(NPC_Connections, workspace.DescendantAdded:Connect(function(descendant)
                    if not NPC_Aimbot_Enabled then return end
                    if descendant:IsA("Humanoid") then
                        task.delay(0.5, function()
                            local parentModel = descendant.Parent
                            if parentModel and IsValidNPC(parentModel) then
                                AddNPCToCache(parentModel)
                            end
                        end)
                    end
                end))

                task.spawn(function() ScanForNPCs(workspace) end)
                NPC_RenderConnection = RunService.RenderStepped:Connect(NPCAimbotLoop)
            else
                StopNPCAimbot()
            end
        end
    })

    Tabs.Aimbot:AddToggle("NPC_Aimbot_WallCheck", {
        Title = "NPC 墙壁检查",
        Default = true,
        Callback = function(state) NPC_Aimbot_WallCheck = state end
    })

    Tabs.Aimbot:AddSlider("NPC_Aimbot_Radius", {
        Title = "NPC FOV 范围",
        Min = 50,
        Max = 500,
        Default = 150,
        Rounding = 1,
        Callback = function(value) 
            NPC_Aimbot_Radius = value 
            NPC_FOVCircle.Size = UDim2.new(0, value * 2, 0, value * 2)
        end
    })

    Tabs.Aimbot:AddSlider("NPC_Aimbot_Smoothness", {
        Title = "NPC 自瞄平滑度",
        Min = 0.05,
        Max = 1,
        Default = 0.4,
        Rounding = 2,
        Callback = function(value) NPC_Aimbot_Smoothness = value end
    })

    Tabs.Aimbot:AddToggle("NPC_Aimbot_RainbowFOV", {
        Title = "NPC FOV 彩虹模式",
        Default = false,
        Callback = function(value) NPC_Aimbot_RainbowFOV = value end
    })

    Tabs.Aimbot:AddColorpicker("NPC_Aimbot_FOVColor", {
        Title = "NPC FOV 颜色",
        Default = Color3.fromRGB(255, 170, 0),
        Callback = function(value)
            NPC_Aimbot_FOVColor = value
            if not NPC_Aimbot_RainbowFOV then
                NPC_UIStroke.Color = value
            end
        end
    })

    Tabs.Aimbot:AddDropdown("NPC_Aimbot_TargetPart", {
        Title = "锁定部位 (找不到将默认锁身体)",
        Values = {"HumanoidRootPart", "Head"},
        Default = 1,
        Callback = function(value) NPC_Aimbot_TargetPart = value end
    })
end


-- 碰撞箱函数
local function setupHitbox(player)
    if player == LocalPlayer then return end
    if hitboxTeamCheck and player.Team == LocalPlayer.Team then return end
    if hitboxTargetSpecific and player ~= hitboxSpecificPlayer then return end
    
    if not player.Character then return end
    
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    pcall(function()
        if not hitbox_original_properties[player] then
            hitbox_original_properties[player] = {
                Size = hrp.Size,
                Transparency = hrp.Transparency,
                Color = hrp.Color,
                Material = hrp.Material,
                CanCollide = hrp.CanCollide,
                Shape = hrp.Shape or Enum.PartType.Block
            }
        end
        
        hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
        hrp.Transparency = hitboxTransparency
        hrp.Color = hitboxColor
        hrp.Material = hitboxMaterial
        hrp.CanCollide = false
        hrp.Shape = (hitboxShape == "Capsule") and Enum.PartType.Cylinder or Enum.PartType.Block
    end)
end

local function restoreHitbox(player)
    if player == LocalPlayer then return end
    if not player.Character then return end
    
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if not hitbox_original_properties[player] then return end
    
    pcall(function()
        local props = hitbox_original_properties[player]
        hrp.Size = props.Size
        hrp.Transparency = props.Transparency
        hrp.Color = props.Color
        hrp.Material = props.Material
        hrp.CanCollide = props.CanCollide
        hrp.Shape = props.Shape
        
        hitbox_original_properties[player] = nil
    end)
end

Tabs.HITBOX:AddSection("Hitbox")
Tabs.HITBOX:AddToggle("HitboxToggle", {
    Title = "开启碰撞箱修改",
    Default = false,
    Callback = function(value)
        hitboxEnabled = value
        if value then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    setupHitbox(player)
                end
            end
        else
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    restoreHitbox(player)
                end
            end
        end
    end
})


Tabs.HITBOX:AddToggle("HitboxTeamCheck", {
    Title = "队伍检查(小部分服务器会误判)",
    Default = false,
    Callback = function(value)
        hitboxTeamCheck = value
        if hitboxEnabled then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    restoreHitbox(player)
                    setupHitbox(player)
                end
            end
        end
    end
})

Tabs.HITBOX:AddInput("HitboxSize", {
    Title = "碰撞箱大小",
    Default = "5",
    Numeric = true,
    Callback = function(value)
        local size = tonumber(value)
        if size and size > 0 then
            hitboxSize = size
            if hitboxEnabled then
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                        if hrp and (not hitboxTargetSpecific or player == hitboxSpecificPlayer) then
                            hrp.Size = Vector3.new(size, size, size)
                        end
                    end
                end
            end
        end
    end
})

Tabs.HITBOX:AddSlider("HitboxTransparency", {
    Title = "透明度",
    Min = 0,
    Max = 1,
    Default = 0.7,
    Rounding = 2,
    Callback = function(value)
        hitboxTransparency = value
        if hitboxEnabled then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and (not hitboxTargetSpecific or player == hitboxSpecificPlayer) then
                        hrp.Transparency = value
                    end
                end
            end
        end
    end
})

Tabs.HITBOX:AddColorpicker("HitboxColor", {
    Title = "颜色",
    Default = Color3.fromRGB(190, 225, 200),
    Callback = function(value)
        hitboxColor = value
        if hitboxEnabled then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and (not hitboxTargetSpecific or player == hitboxSpecificPlayer) then
                        hrp.Color = value
                    end
                end
            end
        end
    end
})


Tabs.HITBOX:AddDropdown("HitboxShape", {
    Title = "形状",
    Values = {"Box", "Capsule"},
    Default = "Box",
    Callback = function(value)
        hitboxShape = value
        if hitboxEnabled then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and (not hitboxTargetSpecific or player == hitboxSpecificPlayer) then
                        hrp.Shape = (value == "Capsule") and Enum.PartType.Cylinder or Enum.PartType.Block
                    end
                end
            end
        end
    end
})

Tabs.HITBOX:AddDropdown("HitboxMaterial", {
    Title = "材质",
    Values = {"Neon", "ForceField", "SmoothPlastic", "Glass"},
    Default = "Neon",
    Callback = function(value)
        hitboxMaterial = Enum.Material[value]
        if hitboxEnabled then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and (not hitboxTargetSpecific or player == hitboxSpecificPlayer) then
                        hrp.Material = hitboxMaterial
                    end
                end
            end
        end
    end
})

Tabs.HITBOX:AddSection("特定玩家")
Tabs.HITBOX:AddToggle("HitboxTargetSpecific", {
    Title = "针对特定玩家",
    Default = false,
    Callback = function(value)
        hitboxTargetSpecific = value
        if value and (not hitboxSpecificPlayer or not hitboxSpecificPlayerName) then
            Fluent:Notify({
                Title = "提示",
                Content = "请先选择一位玩家",
                Duration = 5
            })
            Options.HitboxTargetSpecific:SetValue(false)
            return
        end
        
        if hitboxEnabled then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    restoreHitbox(player)
                end
            end
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    setupHitbox(player)
                end
            end
        end
    end
})

local hitboxMode = "名称"

local function UpdateHitboxPlayerList()
    local playerNames = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if hitboxMode == "名称" then
                table.insert(playerNames, player.Name)
            else
                table.insert(playerNames, player.DisplayName)
            end
        end
    end
    if #playerNames == 0 then playerNames = {"无玩家"} end
    Options.HitboxPlayerDropdown:SetValues(playerNames)
end

Tabs.HITBOX:AddDropdown("HitboxModeDropdown", {
    Title = "选择模式",
    Values = {"名称", "昵称"},
    Default = 1,
    Callback = function(value)
        hitboxMode = value
        UpdateHitboxPlayerList()
    end
})

Tabs.HITBOX:AddDropdown("HitboxPlayerDropdown", {
    Title = "选择目标玩家",
    Values = {},
    Default = 1,
    Callback = function(value)
        if value == "无玩家" then
            hitboxSpecificPlayerName = nil
            hitboxSpecificPlayer = nil
            if hitboxTargetSpecific then
                Options.HitboxTargetSpecific:SetValue(false)
            end
            return
        end
        
        hitboxSpecificPlayerName = value
        hitboxSpecificPlayer = nil
        
        for _, player in pairs(Players:GetPlayers()) do
            if (hitboxMode == "名称" and player.Name == value) or
               (hitboxMode == "昵称" and player.DisplayName == value) then
                hitboxSpecificPlayer = player
                break
            end
        end
        
        if hitboxEnabled and hitboxTargetSpecific then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    restoreHitbox(p)
                end
            end
            if hitboxSpecificPlayer then
                setupHitbox(hitboxSpecificPlayer)
            end
        end
    end
})

Tabs.HITBOX:AddButton({
    Title = "刷新玩家列表",
    Callback = UpdateHitboxPlayerList
})

Players.PlayerAdded:Connect(function(player)
    if player == LocalPlayer then return end
    
    player.CharacterAdded:Connect(function()
        task.wait(0.5)
        if hitboxEnabled then
            setupHitbox(player)
        end
    end)
    
    if player.Character then
        task.wait(0.5)
        if hitboxEnabled then
            setupHitbox(player)
        end
    end
    
    player.CharacterRemoving:Connect(function()
        restoreHitbox(player)
    end)
    
    UpdateHitboxPlayerList()
end)

Players.PlayerRemoving:Connect(function(player)
    restoreHitbox(player)
    UpdateHitboxPlayerList()
    
    if hitboxTargetSpecific and player == hitboxSpecificPlayer then
        hitboxSpecificPlayer = nil
        hitboxSpecificPlayerName = nil
        Options.HitboxTargetSpecific:SetValue(false)
        Fluent:Notify({
            Title = "提示",
            Content = "目标玩家已离开，已自动关闭 针对特定玩家 模式",
            Duration = 6
        })
    end
end)



-- ==========================================================
-- 互动、触发、触碰系统 (完美适配 Fluent 版)
-- ==========================================================
if Tabs and Tabs.Interact then
    Tabs.Interact:AddSection("核心机制")

    local QWQ_Interact_ToggleInteract = Tabs.Interact:AddToggle("QWQ_Interact_ToggleInteract", { Title = "可互动 (ProximityPrompt/Click)", Default = false })
    local QWQ_Interact_ToggleTrigger = Tabs.Interact:AddToggle("QWQ_Interact_ToggleTrigger", { Title = "可触发 (模拟触碰触发器)", Default = false })
    local QWQ_Interact_ToggleTouch = Tabs.Interact:AddToggle("QWQ_Interact_ToggleTouch", { Title = "可触碰 (TouchInterest)", Default = false })

    Tabs.Interact:AddSection("范围与可视化")
    local QWQ_Interact_Range = 20
    local QWQ_Interact_Shape = "圆形距离"

    Tabs.Interact:AddInput("QWQ_Interact_RangeInput", {
        Title = "范围半径 (距离)",
        Default = "20",
        Numeric = true,
        Finished = false,
        Placeholder = "输入数字...",
        Callback = function(v) QWQ_Interact_Range = tonumber(v) or 20 end
    })

    Tabs.Interact:AddDropdown("QWQ_Interact_ShapeDropdown", {
        Title = "范围形状",
        Values = {"圆形距离", "正方形距离"},
        Multi = false,
        Default = 1,
        Callback = function(v) QWQ_Interact_Shape = v end
    })

    local QWQ_Interact_VisualizerToggle = Tabs.Interact:AddToggle("QWQ_Interact_VisualizerToggle", { Title = "显示范围可视化", Default = false })
    local QWQ_Interact_VisualizerColor = Tabs.Interact:AddColorpicker("QWQ_Interact_VisualizerColor", {
        Title = "范围颜色",
        Default = Color3.fromRGB(0, 255, 150)
    })

    Tabs.Interact:AddSection("执行控制")
    local QWQ_Interact_ExecPerSec = 5
    Tabs.Interact:AddSlider("QWQ_Interact_ExecPerSec", {
        Title = "自动执行频率 (次/秒)",
        Default = 5,
        Min = 1,
        Max = 60,
        Rounding = 1,
        Callback = function(v) QWQ_Interact_ExecPerSec = v end
    })

    local QWQ_Interact_AutoExecute = Tabs.Interact:AddToggle("QWQ_Interact_AutoExecute", { Title = "开启自动执行", Default = false })

    -- 悬浮按钮设置
    local QWQ_Interact_QuickBtnToggle = Tabs.Interact:AddToggle("QWQ_Interact_QuickBtnToggle", { Title = "显示悬浮快捷执行按钮", Default = false })
    local QWQ_Interact_QuickBtnColor = Tabs.Interact:AddColorpicker("QWQ_Interact_QuickBtnColor", {
        Title = "快捷执行按钮颜色",
        Default = Color3.fromRGB(255, 255, 255)
    })

    -- 核心逻辑函数
    local function IsInRange(partPos, hrpPos)
        if QWQ_Interact_Shape == "圆形距离" then
            return (partPos - hrpPos).Magnitude <= QWQ_Interact_Range
        else
            local diff = partPos - hrpPos
            return math.abs(diff.X) <= QWQ_Interact_Range and math.abs(diff.Y) <= QWQ_Interact_Range and math.abs(diff.Z) <= QWQ_Interact_Range
        end
    end

    local function ExecuteActions()
        local touchCount, promptCount, clickCount = 0, 0, 0
        local character = LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if not hrp then return 0, 0, 0 end

        local interactOn = Options.QWQ_Interact_ToggleInteract.Value
        local triggerOn = Options.QWQ_Interact_ToggleTrigger.Value
        local touchOn = Options.QWQ_Interact_ToggleTouch.Value

        if not (interactOn or triggerOn or touchOn) then return 0, 0, 0 end

        for _, obj in ipairs(Workspace:GetDescendants()) do
            local isPart = obj:IsA("BasePart")
            local isPrompt = obj:IsA("ProximityPrompt")
            local isClick = obj:IsA("ClickDetector")

            if isPart or isPrompt or isClick then
                local targetPos = nil
                if isPart then
                    targetPos = obj.Position
                elseif (isPrompt or isClick) and obj.Parent and obj.Parent:IsA("BasePart") then
                    targetPos = obj.Parent.Position
                end

                if targetPos and IsInRange(targetPos, hrp.Position) then
                    if interactOn then
                        if isPrompt and fireproximityprompt then
                            fireproximityprompt(obj, 1)
                            promptCount = promptCount + 1
                        elseif isClick and fireclickdetector then
                            fireclickdetector(obj, 1)
                            clickCount = clickCount + 1
                        end
                    end

                    if (touchOn or triggerOn) and isPart and obj:FindFirstChildWhichIsA("TouchTransmitter") then
                        if firetouchinterest then
                            task.spawn(function()
                                firetouchinterest(hrp, obj, 0)
                                task.wait()
                                firetouchinterest(hrp, obj, 1)
                            end)
                            touchCount = touchCount + 1
                        end
                    end
                end
            end
        end
        return touchCount, promptCount, clickCount
    end

local function ExecuteAndNotify()
        local touches, prompts, clicks = ExecuteActions()
        
        -- 使用 pcall 保护原生弹窗，防止个别游戏禁用核心UI导致报错
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "已执行一次",
                Text = string.format("触碰: %d | 互动: %d | 点击: %d", touches, prompts, clicks),
                Icon = "rbxassetid://112498001988193",
                Duration = 3
            })
        end)
    end
    Tabs.Interact:AddButton({
        Title = "点击执行一次",
        Description = "立即扫描范围并触发一次",
        Callback = function()
            ExecuteAndNotify()
        end
    })

    -- ==========================================
    -- 独立可拖动悬浮按钮 UI (防报错版)
    -- ==========================================
    local function GetSafeUI()
        if gethui then
            local s, r = pcall(gethui)
            if s and r then return r end
        end
        local s, r = pcall(function() return game:GetService("CoreGui") end)
        if s and r then return r end
        return LocalPlayer:WaitForChild("PlayerGui")
    end

    local quickGui = Instance.new("ScreenGui")
    quickGui.Name = "QWQ_Interact_QuickUI"
    quickGui.ResetOnSpawn = false
    quickGui.Parent = GetSafeUI()

    local quickBtn = Instance.new("TextButton")
    quickBtn.Size = UDim2.new(0, 30, 0, 20)
    quickBtn.Position = UDim2.new(0, 10, 0, 10)
    quickBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    quickBtn.Text = ""
    quickBtn.AutoButtonColor = true
    quickBtn.Visible = false
    quickBtn.Parent = quickGui

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = quickBtn

    local btnIcon = Instance.new("ImageLabel")
    btnIcon.Size = UDim2.new(0.6, 0, 0.9, 0)
    btnIcon.Position = UDim2.new(0.2, 0, 0.05, 0)
    btnIcon.BackgroundTransparency = 1
    btnIcon.Image = "rbxassetid://87761482164390" -- 标签图标
    btnIcon.ScaleType = Enum.ScaleType.Fit
    btnIcon.Parent = quickBtn

    local dragging, dragInput, dragStart, startPos
    quickBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = quickBtn.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    quickBtn.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            quickBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    quickBtn.MouseButton1Click:Connect(function()
        ExecuteAndNotify()
    end)

    QWQ_Interact_QuickBtnToggle:OnChanged(function()
        quickBtn.Visible = Options.QWQ_Interact_QuickBtnToggle.Value
    end)

    QWQ_Interact_QuickBtnColor:OnChanged(function()
        quickBtn.BackgroundColor3 = Options.QWQ_Interact_QuickBtnColor.Value
    end)

    -- ==========================================
    -- 范围可视化系统 (安全退避版)
    -- ==========================================
    local secureFolder = Instance.new("Folder")
    secureFolder.Name = "QWQ_Interact_Visualizer"
    secureFolder.Parent = Camera -- 直接放在当前相机，防屏蔽且最稳妥

    local sphereVisualizer = Instance.new("SphereHandleAdornment")
    sphereVisualizer.ZIndex = 1
    sphereVisualizer.AlwaysOnTop = true
    sphereVisualizer.Transparency = 0.6
    sphereVisualizer.Parent = secureFolder

    local boxVisualizer = Instance.new("BoxHandleAdornment")
    boxVisualizer.ZIndex = 1
    boxVisualizer.AlwaysOnTop = true
    boxVisualizer.Transparency = 0.6
    boxVisualizer.Parent = secureFolder

    RunService.RenderStepped:Connect(function()
        local isEnabled = Options.QWQ_Interact_VisualizerToggle and Options.QWQ_Interact_VisualizerToggle.Value
        local character = LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")

        if isEnabled and hrp then
            local radius = QWQ_Interact_Range
            local color = Options.QWQ_Interact_VisualizerColor and Options.QWQ_Interact_VisualizerColor.Value or Color3.fromRGB(0,255,150)
            
            if QWQ_Interact_Shape == "圆形距离" then
                boxVisualizer.Visible = false
                sphereVisualizer.Visible = true
                sphereVisualizer.Adornee = hrp
                sphereVisualizer.Radius = radius
                sphereVisualizer.Color3 = color
            else
                sphereVisualizer.Visible = false
                boxVisualizer.Visible = true
                boxVisualizer.Adornee = hrp
                boxVisualizer.Size = Vector3.new(radius * 2, radius * 2, radius * 2)
                boxVisualizer.Color3 = color
            end
        else
            sphereVisualizer.Visible = false
            boxVisualizer.Visible = false
            sphereVisualizer.Adornee = nil
            boxVisualizer.Adornee = nil
        end
    end)

    -- 自动执行任务循环
    task.spawn(function()
        while true do
            if Options.QWQ_Interact_AutoExecute and Options.QWQ_Interact_AutoExecute.Value then
                ExecuteActions()
                task.wait(1 / QWQ_Interact_ExecPerSec)
            else
                task.wait(0.1)
            end
        end
    end)
end

Tabs.Interact:AddSection("全图全自动互动")

local autoLoopThread = nil
local autoProxState = false
local autoClickState = false
local autoTouchState = false

-- 【新增】专门用来备份每个 ProximityPrompt 原本互动时间的对照表
local originalPromptDurations = {}

-- 辅助函数：一键还原所有被修改过的 E 键互动时间
local function restorePromptDurations()
    for prompt, originalDuration in pairs(originalPromptDurations) do
        pcall(function()
            if prompt and prompt.Parent then
                prompt.HoldDuration = originalDuration
            end
        end)
    end
    table.clear(originalPromptDurations) -- 还原后清空备份表
end

-- 全图循环扫描核心逻辑
local function startAutoInteractLoop()
    if autoLoopThread then return end
    autoLoopThread = task.spawn(function()
        local lastTouch = 0
        while autoProxState or autoClickState or autoTouchState do
            pcall(function()
                local descendants = workspace:GetDescendants()
                for i, obj in ipairs(descendants) do
                    if i % 200 == 0 then task.wait() end -- 防卡死
                    
                    -- 【已修改】E键互动：改为“秒互动”模式，不再全图自动触发
                    if autoProxState and obj:IsA("ProximityPrompt") then
                        pcall(function()
                            -- 如果这个E键以前没有被备份过时间，就记录它的原本长按时间
                            if originalPromptDurations[obj] == nil then
                                originalPromptDurations[obj] = obj.HoldDuration
                            end
                            -- 强行将长按时间改成 0（实现走过去按E直接秒开）
                            obj.HoldDuration = 0
                        end)
                    end
                    
                    -- 点击互动
                    if autoClickState and obj:IsA("ClickDetector") then
                        task.spawn(fireclickdetector, obj)
                    end
                    
                    -- 触碰互动（过滤致死）
                    if autoTouchState and (tick() - lastTouch > 0.5) then
                        if obj:IsA("TouchTransmitter") and obj.Parent and obj.Parent:IsA("BasePart") then
                            local part = obj.Parent
                            local nLower = string.lower(part.Name)
                            if not string.find(nLower, "kill") and not string.find(nLower, "lava") and not string.find(nLower, "岩浆") then
                                local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                if myRoot then
                                    task.spawn(function()
                                        firetouchinterest(myRoot, part, 0)
                                        task.wait(0.01)
                                        firetouchinterest(myRoot, part, 1)
                                    end)
                                end
                            end
                        end
                    end
                end
                if autoTouchState then lastTouch = tick() end
            end)
            task.wait(1) -- 每秒轮巡一次
        end
        autoLoopThread = nil
    end)
end

-- 添加 UI 控件开关
Tabs.Interact:AddToggle("AutoProx_Toggle", {
    Title = "本地E键秒互动 (无需长按)",
    Description = "开启后靠近任何物品按E直接秒开，关闭后恢复原有交互时间",
    Default = false,
    Callback = function(v)
        autoProxState = v
        if v then 
            startAutoInteractLoop() 
            Fluent:Notify({Title = "秒互动已开启", Content = "现在靠近物品按E无需等待圈圈转完", Duration = 3})
        else
            -- 【核心逻辑】关闭开关时，立刻触发还原函数，并清空临时备份
            restorePromptDurations()
            Fluent:Notify({Title = "秒互动已关闭", Content = "所有交互已安全恢复原本的时间", Duration = 3})
        end
    end
})


Tabs.Tool:AddButton({
    Title = "tp飞行",
    Callback = function()
loadstring(Game:HttpGet("https://raw.githubusercontent.com/haoxiao0/qwqcs/refs/heads/main/tpfly.lua"))()
    end
})

Tabs.Tool:AddButton({
    Title = "飞行",
    Callback = function()
loadstring(Game:HttpGet("https://raw.githubusercontent.com/haoxiao0/qwqcs/refs/heads/main/qwqfly2.0.lua"))()
    end
})

Tabs.Tool:AddButton({
    Title = "Delta键盘",
    Callback = function()
loadstring(Game:HttpGet("https://raw.githubusercontent.com/JsYb666/Item/refs/heads/main/delta%20keyboard.lua"))()
    end
})

Tabs.Tool:AddButton({
    Title = "功能道具",
    Callback = function()
loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/BTools.txt"))()
    end
})

Tabs.Tool:AddButton({
    Title = "死亡笔记",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0%20(1).txt"))()
    end
})

Tabs.Tool:AddButton({
    Title = "IY指令",
    Callback = function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
    end
})

Tabs.Tool:AddButton({
    Title = "踏空",
    Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))()
    end
})

Tabs.Tool:AddButton({
    Title = "删材质",
    Callback = function()
loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-FpsBoost-9260"))()
    end
})

Tabs.Tool:AddButton({
    Title = "点击传送工具",
    Callback = function()
mouse = game.Players.LocalPlayer:GetMouse() tool = Instance.new("Tool") tool.RequiresHandle = false tool.Name = "[FE] TELEPORT TOOL" tool.Activated:connect(function() local pos = mouse.Hit+Vector3.new(0,2.5,0) pos = CFrame.new(pos.X,pos.Y,pos.Z) game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos end) tool.Parent = game.Players.LocalPlayer.Backpack
    end
})

Tabs.Tool:AddButton({
    Title = "飞车",
    Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/equFq67v"))()
    end
})

Tabs.Tool:AddButton({
    Title = "阿尔宙斯子追",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/Item/refs/heads/main/Arceus%E5%AD%90%E8%BF%BD"))()
    end
})

Tabs.Tool:AddButton({
    Title = "撸管R15",
    Callback = function()
loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
    end
})

Tabs.Tool:AddButton({
    Title = "撸管R6",
    Callback = function()
loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
    end
})



Tabs.Main:AddToggle("ProxInstant", {
    Title = "瞬时互动",
    Default = false,
    Callback = function(v) proximityInstantEnabled = v; setupProximityInstant(v) end
})


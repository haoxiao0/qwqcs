local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/haoxiao0/qwqcs/refs/heads/main/qwqui1.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/haoxiao0/qwqcs/refs/heads/main/qwqui2.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/haoxiao0/qwqcs/refs/heads/main/qwqui3.lua"))()

local Window = Fluent:CreateWindow({
    Title = "QWQ",
    SubTitle = "3.3",
    TabWidth = 100,
    Size = UDim2.fromOffset(450, 350),
    Acrylic = true,
    Theme = "Sunset",
    MinimizeKey = Enum.KeyCode.LeftControl
})


local Tabs = {
    Qwqe = Window:AddTab({ Title = "QwQ", Icon = "rbxassetid://6558374856" }),
    Qwqa = Window:AddTab({ Title = "功能", Icon = "rbxassetid://6558374856" }),
    Player = Window:AddTab({ Title = "人物", Icon = "rbxassetid://6558374856" }),
    ESP = Window:AddTab({ Title = "ESP", Icon = "rbxassetid://6558374856" }),
    Aimbot = Window:AddTab({ Title = "自瞄", Icon = "rbxassetid://5205790785" }),
    Teleport = Window:AddTab({ Title = "传送", Icon = "rbxassetid://6558374856" }),
    FOV = Window:AddTab({ Title = "视角", Icon = "rbxassetid://6558374856" }),
    HITBOX = Window:AddTab({ Title = "碰撞箱", Icon = "rbxassetid://6558374856" }),
    World = Window:AddTab({ Title = "世界", Icon = "rbxassetid://6558374856" }),
    Tool = Window:AddTab({ Title = "实用工具", Icon = "rbxassetid://6558374856" }),
    Main = Window:AddTab({ Title = "测试功能", Icon = "rbxassetid://6558374856" })
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()
local Options = Fluent.Options
local RunService = game:GetService("RunService")
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

-- ==========================================
-- 拼接到原有脚本的 Tabs.Player 栏目中
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

UpdateSinglePlayerList()
UpdateHitboxPlayerList()
Players.PlayerAdded:Connect(UpdateSinglePlayerList)
Players.PlayerRemoving:Connect(UpdateSinglePlayerList)



Tabs.Tool:AddButton({
    Title = "飞行1.0",
    Callback = function()
loadstring(Game:HttpGet("https://raw.githubusercontent.com/haoxiao0/qwqcs/refs/heads/main/qwqfly1.0.lua"))()
    end
})

Tabs.Tool:AddButton({
    Title = "飞行2.0",
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










Tabs.Main:AddToggle("silent", {
    Title = "子弹追踪",
    Default = false,
    Callback = function(value)
        silent = value
        if silent then
        local CurrentCamera = workspace.CurrentCamera
local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
function ClosestPlayer()
    local MaxDist, Closest = math.huge
    for I,V in pairs(Players.GetPlayers(Players)) do
        if V == LocalPlayer then continue end
        if V.Team == LocalPlayer then continue end
        if not V.Character then continue end
    local Head = V.Character.FindFirstChild(V.Character, "Head")
        if not Head then continue end
        local Pos, Vis = CurrentCamera.WorldToScreenPoint(CurrentCamera, Head.Position)
        if not Vis then continue end
        local MousePos, TheirPos = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2), Vector2.new(Pos.X, Pos.Y)
        local Dist = (TheirPos - MousePos).Magnitude
        if Dist < MaxDist then
            MaxDist = Dist
            Closest = V
        end
    end
    return Closest
end
local MT = getrawmetatable(game)
local OldNC = MT.__namecall
local OldIDX = MT.__index
setreadonly(MT, false)
MT.__namecall = newcclosure(function(self, ...)
    local Args, Method = {...}, getnamecallmethod()
    if Method == "FindPartOnRayWithIgnoreList" and not checkcaller() then
        local CP = ClosestPlayer()
        if CP and CP.Character and CP.Character.FindFirstChild(CP.Character, "Head") then
            Args[1] = Ray.new(CurrentCamera.CFrame.Position, (CP.Character.Head.Position - CurrentCamera.CFrame.Position).Unit * 1000)
            return OldNC(self, unpack(Args))
        end
    end
    return OldNC(self, ...)
end)
MT.__index = newcclosure(function(self, K)
    if K == "Clips" then
        return workspace.Map
    end
    return OldIDX(self, K)
end)
setreadonly(MT, true)
    else
        local CurrentCamera = workspace.CurrentCamera
local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
function ClosestPlayer()
    local MaxDist, Closest = math.huge
    for I,V in pairs(Players.GetPlayers(Players)) do
        if V == LocalPlayer then continue end
        if V.Team == LocalPlayer then continue end
        if not V.Character then continue end
        local Head = V.Character.FindFirstChild(V.Character, "Head")
        if not Head then continue end
        local Pos, Vis = CurrentCamera.WorldToScreenPoint(CurrentCamera, Head.Position)
        if not Vis then continue end
        local MousePos, TheirPos = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 0, workspace.CurrentCamera.ViewportSize.Y / 0), Vector2.new(Pos.X, Pos.Y)
        local Dist = (TheirPos - MousePos).Magnitude
        if Dist < MaxDist then
            MaxDist = Dist
            Closest = V
        end
    end
    return Closest
end
local MT = getrawmetatable(game)
local OldNC = MT.__namecall
local OldIDX = MT.__index
setreadonly(MT, false)
MT.__namecall = newcclosure(function(self, ...)
    local Args, Method = {...}, getnamecallmethod()
    if Method == "FindPartOnRayWithIgnoreList" and not checkcaller() then
        local CP = ClosestPlayer()
        if CP and CP.Character and CP.Character.FindFirstChild(CP.Character, "Head") then
            Args[1] = Ray.new(CurrentCamera.CFrame.Position, (CP.Character.Head.Position - CurrentCamera.CFrame.Position).Unit * 1000)
            return OldNC(self, unpack(Args))
        end
    end
    return OldNC(self, ...)
end)
MT.__index = newcclosure(function(self, K)
    if K == "Clips" then
        return workspace.Map
    end
    return OldIDX(self, K)
end)
setreadonly(MT, true)
    end
    end
})

local function getAllProximityPrompts() 
    return workspace:GetDescendants() 
end 

local proximityInstantEnabled = false
local proximityAutoEnabled = false
local proximityHighlightEnabled = false
local proximityTextEnabled = false
local proximityOriginal = {}

local clickUnlimitedEnabled = false
local clickAutoEnabled = false
local clickHighlightEnabled = false
local clickTextEnabled = false
local clickOriginal = {}

local function setupProximityInstant(enable)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") then
            if enable then
                if not proximityOriginal[obj] then
                    proximityOriginal[obj] = {HoldDuration = obj.HoldDuration}
                end
                obj.HoldDuration = 0
            else
                if proximityOriginal[obj] then
                    obj.HoldDuration = proximityOriginal[obj].HoldDuration
                end
            end
        end
    end
end

local function triggerAllProximity()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") then
            fireproximityprompt(obj)
        end
    end
    Fluent:Notify({Title = "Proximity", Content = "已触发所有 Proximity Prompts", Duration = 5})
end

local function setupClickUnlimited(enable)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ClickDetector") then
            if enable then
                if not clickOriginal[obj] then
                    clickOriginal[obj] = {MaxActivationDistance = obj.MaxActivationDistance}
                end
                obj.MaxActivationDistance = math.huge
            else
                if clickOriginal[obj] then
                    obj.MaxActivationDistance = clickOriginal[obj].MaxActivationDistance
                end
            end
        end
    end
end

local function triggerAllClick()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ClickDetector") then
            fireclickdetector(obj)
        end
    end
    Fluent:Notify({Title = "Click", Content = "已触发所有 Click Detectors", Duration = 5})
end

local function getAllTouchParts()
    local parts = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.CanTouch then
            table.insert(parts, obj)
        end
    end
    return parts
end

local function triggerAllTouch()
    local char = LocalPlayer.Character
    if char then
        local touchPart = char:FindFirstChildWhichIsA("BasePart")
        if touchPart then
            for _, part in ipairs(getAllTouchParts()) do
                if part ~= touchPart then
                    firetouchinterest(touchPart, part, 0)
                    task.wait(0.01)
                    firetouchinterest(touchPart, part, 1)
                end
            end
        end
    end
    Fluent:Notify({Title = "Touch", Content = "已触发所有 Touch Interests", Duration = 5})
end


Tabs.Main:AddToggle("ProxInstant", {
    Title = "瞬时互动",
    Default = false,
    Callback = function(v) proximityInstantEnabled = v; setupProximityInstant(v) end
})

Tabs.Main:AddButton({
    Title = "Proximity全图互动",
    Description = "触发所有 Proximity Prompts",
    Callback = triggerAllProximity
})

Tabs.Main:AddButton({
    Title = "Click全图互动",
    Description = "触发所有 Click Detectors",
    Callback = triggerAllClick
})

Tabs.Main:AddButton({
    Title = "Touch全图互动",
    Description = "触发所有 Touch Interests",
    Callback = triggerAllTouch
})

-- ==========================================
-- 拼接到原有脚本的 Tabs.Main 栏目中（本地E键秒互动+恢复版）
-- ==========================================
Tabs.Main:AddSection("全图全自动互动")

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
Tabs.Main:AddToggle("AutoProx_Toggle", {
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

Tabs.Main:AddToggle("AutoClick_Toggle", {
    Title = "自动触发全图 Click (点击)",
    Default = false,
    Callback = function(v)
        autoClickState = v
        if v then startAutoInteractLoop() end
    end
})

Tabs.Main:AddToggle("AutoTouch_Toggle", {
    Title = "自动触发全图 Touch (触碰)",
    Description = "自动收取金币、踩传送阵等（已过滤岩浆致死方块）",
    Default = false,
    Callback = function(v)
        autoTouchState = v
        if v then startAutoInteractLoop() end
    end
})

-- ==========================================
-- 寻宝道具【自动0.4秒发包】测试模块
-- ==========================================
-- 根据你 qwq1.0.lua 脚本中的 Tab 命名，这里绑定到 Tabs.Qwqe 下
Tabs.Qwqe:AddSection("道具自动化qwq")

local autoRewardThread = nil -- 用于保存后台循环线程

Tabs.Qwqe:AddToggle("AutoReward04Sec", {
    Title = "嗯，对挑木棍捡垃圾",
    Description = "开启后，只要手持木棍，每0.4秒会自动绕过动画获取一次奖励",
    Default = false,
    Callback = function(state)
        if state then
            -- 开启一个独立的后台线程进行定时循环
            autoRewardThread = task.spawn(function()
                while true do
                    local character = LocalPlayer.Character
                    local equippedTool = character and character:FindFirstChildOfClass("Tool")
                    
                    local eventsFolder = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
                    local toolEvent = eventsFolder and eventsFolder:FindFirstChild("ToolEvent")
                    
                    -- 核心安全检查：只有当你把木棍拿在手上，并且服务器事件存在时才发包
                    if equippedTool and toolEvent then
                        -- 0毫秒延迟瞬间双发，对服务器谎称动画已瞬间播放完毕
                        toolEvent:FireServer("Activated", false)
                        toolEvent:FireServer("Activated", true)
                        print("【自动化测试】已自动向服务器请求 1 次奖励 (当前手持: " .. equippedTool.Name .. ")")
                    end
                    
                    -- 严格限制为 0.4 秒发包一次
                    task.wait(0.4)
                end
            end)
            
            Fluent:Notify({Title = "自动化启动", Content = "已开启每 0.4 秒自动获取奖励", Duration = 3})
        else
            -- 关闭开关时，强行中断并清理循环线程，防止背景继续发包
            if autoRewardThread then
                task.cancel(autoRewardThread)
                autoRewardThread = nil
            end
            Fluent:Notify({Title = "自动化停止", Content = "已停止自动获取", Duration = 3})
        end
    end
})


    


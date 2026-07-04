local AllowedPlaceId = 13955927965

if game.PlaceId ~= AllowedPlaceId then
    local StarterGui = game:GetService("StarterGui")
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "nonono~",
            Text = "这不是血区(⊙o⊙)！",
            Icon = "rbxassetid://115393444625574",
            Duration = 5
        })
    end)
    return 
end

local MyUIConfig = loadstring(game:HttpGet("https://raw.githubusercontent.com/haoxiao0/hx-ui.lua/refs/heads/main/hx-ui-1.lua"))()
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/haoxiao0/hx-ui.lua/refs/heads/main/hx-ui-2.lua"))()

local Window = Library:CreateWindow({
    Config = MyUIConfig,
    Title = "HAOXIAO原创",
    SubTitle = "不想改了✔️✔️最后再打开这个脚本，不然会拦截"
})

local Tabs = {
    Main = Window:AddTab({ Title = "w", Icon = "rbxassetid://104508482519186" }),
    Visuals = Window:AddTab({ Title = "ESP", Icon = "rbxassetid://104508482519186" }),
    GlobalConfig = Window:AddTab({ Title = "w", Icon = "rbxassetid://104508482519186" }), 
    clickbot = Window:AddTab({ Title = "别不演,会被举报", Icon = "rbxassetid://104508482519186" })
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local Global_IgnoreTeam = false       
local Global_BlacklistEnabled = false 
local AimbotBlacklist = {}

-- ==========================================
-- ESP (透视) 模块
-- ==========================================
if Tabs.Visuals then
    Tabs.Visuals:AddTitle("玩家透视设置 (ESP)")

    local ESPConfig = {
        Box = false, BoxColor = Color3.fromRGB(180, 220, 170),
        Highlight = false, HighlightColor = Color3.fromRGB(100, 30, 200),
        Health = false, HealthColor = Color3.fromRGB(100, 255, 100),
        Name = false, Distance = false, Coords = false,
        TextColor = Color3.fromRGB(255, 255, 255)
    }

    local ESP = {}

    local function cleanupESP(player)
        if ESP[player] then
            local pESP = ESP[player]
            if pESP.Box then pESP.Box:Remove() end
            if pESP.Highlight then pESP.Highlight:Destroy() end
            if pESP.HealthBar then
                pESP.HealthBar.Bar:Remove()
                pESP.HealthBar.Background:Remove()
                pESP.HealthBar.Percentage:Remove()
            end
            if pESP.Name then pESP.Name:Remove() end
            if pESP.Distance then pESP.Distance:Remove() end
            if pESP.Coords then pESP.Coords:Remove() end
            ESP[player] = nil
        end
    end

    local function createESP(player)
        if player == LocalPlayer or ESP[player] then return end
        local char = player.Character
        if not char then return end
        
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        if not hrp or not hum then return end

        local pESP = {}
        
        local box = Drawing.new("Square")
        box.Thickness = 2
        box.Filled = false
        box.Visible = false
        pESP.Box = box

        local highlight = Instance.new("Highlight")
        highlight.Parent = char
        highlight.Adornee = char
        highlight.Enabled = false
        pESP.Highlight = highlight

        local healthBar = {
            Bar = Drawing.new("Square"),
            Background = Drawing.new("Square"),
            Percentage = Drawing.new("Text")
        }
        healthBar.Bar.Filled = true
        healthBar.Bar.Visible = false
        healthBar.Background.Filled = true
        healthBar.Background.Color = Color3.fromRGB(30, 30, 30)
        healthBar.Background.Thickness = 1
        healthBar.Background.Visible = false
        healthBar.Percentage.Size = 14
        healthBar.Percentage.Center = true
        healthBar.Percentage.Outline = true
        healthBar.Percentage.Visible = false
        pESP.HealthBar = healthBar

        local nameText = Drawing.new("Text")
        nameText.Size = 16
        nameText.Center = true
        nameText.Outline = true
        nameText.Visible = false
        pESP.Name = nameText

        local distanceText = Drawing.new("Text")
        distanceText.Size = 14
        distanceText.Center = true
        distanceText.Outline = true
        distanceText.Visible = false
        pESP.Distance = distanceText

        local coordsText = Drawing.new("Text")
        coordsText.Size = 14
        coordsText.Center = true
        coordsText.Outline = true
        coordsText.Visible = false
        pESP.Coords = coordsText

        ESP[player] = pESP
    end

    local function setupPlayerListener(player)
        if player == LocalPlayer then return end
        if player.Character then createESP(player) end
        player.CharacterAdded:Connect(function()
            cleanupESP(player)
            task.wait(0.1) 
            createESP(player)
        end)
        player.CharacterRemoving:Connect(function() cleanupESP(player) end)
    end

    for _, player in ipairs(Players:GetPlayers()) do setupPlayerListener(player) end
    Players.PlayerAdded:Connect(setupPlayerListener)
    Players.PlayerRemoving:Connect(cleanupESP)

    RunService.RenderStepped:Connect(function()
        local localHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        for player, pESP in pairs(ESP) do
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChild("Humanoid")

            if hrp and hum and hum.Health > 0 then
                local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                
                if not onScreen then
                    pESP.Box.Visible = false
                    pESP.Highlight.Enabled = false
                    pESP.HealthBar.Background.Visible = false
                    pESP.HealthBar.Bar.Visible = false
                    pESP.HealthBar.Percentage.Visible = false
                    pESP.Name.Visible = false
                    pESP.Distance.Visible = false
                    pESP.Coords.Visible = false
                    continue
                end

                local topPos = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0))
                local bottomPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                local height = (bottomPos.Y - topPos.Y) * 0.75
                local width = height * 1.5

                if ESPConfig.Box then
                    pESP.Box.Size = Vector2.new(width, height)
                    pESP.Box.Position = Vector2.new(vector.X - width / 2, vector.Y - height / 2)
                    pESP.Box.Color = ESPConfig.BoxColor
                    pESP.Box.Visible = true
                else
                    pESP.Box.Visible = false
                end

                if ESPConfig.Highlight then
                    pESP.Highlight.FillColor = ESPConfig.HighlightColor
                    pESP.Highlight.OutlineColor = ESPConfig.HighlightColor
                    pESP.Highlight.Enabled = true
                else
                    pESP.Highlight.Enabled = false
                end

                if ESPConfig.Health then
                    local healthPercent = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                    
                    pESP.HealthBar.Background.Size = Vector2.new(4, height)
                    pESP.HealthBar.Background.Position = Vector2.new(vector.X - (width / 2) - 8, vector.Y - height / 2)
                    pESP.HealthBar.Background.Visible = true
                    
                    pESP.HealthBar.Bar.Size = Vector2.new(2, height * healthPercent)
                    pESP.HealthBar.Bar.Position = Vector2.new(vector.X - (width / 2) - 7, vector.Y - height / 2 + (height * (1 - healthPercent)))
                    pESP.HealthBar.Bar.Color = ESPConfig.HealthColor
                    pESP.HealthBar.Bar.Visible = true
                    
                    pESP.HealthBar.Percentage.Text = math.floor(healthPercent * 100) .. "%"
                    pESP.HealthBar.Percentage.Position = Vector2.new(vector.X - (width / 2) - 8, vector.Y - height / 2 - 15)
                    pESP.HealthBar.Percentage.Color = ESPConfig.HealthColor
                    pESP.HealthBar.Percentage.Visible = true
                else
                    pESP.HealthBar.Background.Visible = false
                    pESP.HealthBar.Bar.Visible = false
                    pESP.HealthBar.Percentage.Visible = false
                end

                if ESPConfig.Name then
                    pESP.Name.Text = player.Name
                    pESP.Name.Position = Vector2.new(vector.X, vector.Y - (height / 2) - 15)
                    pESP.Name.Color = ESPConfig.TextColor
                    pESP.Name.Visible = true
                else
                    pESP.Name.Visible = false
                end

                if ESPConfig.Distance and localHrp then
                    local dist = math.floor((hrp.Position - localHrp.Position).Magnitude)
                    pESP.Distance.Text = dist .. " 米"
                    pESP.Distance.Position = Vector2.new(vector.X, vector.Y + (height / 2) + 5)
                    pESP.Distance.Color = ESPConfig.TextColor
                    pESP.Distance.Visible = true
                else
                    pESP.Distance.Visible = false
                end

                if ESPConfig.Coords then
                    pESP.Coords.Text = string.format("X: %.0f Y: %.0f Z: %.0f", hrp.Position.X, hrp.Position.Y, hrp.Position.Z)
                    pESP.Coords.Position = Vector2.new(vector.X, vector.Y + (height / 2) + 20)
                    pESP.Coords.Color = ESPConfig.TextColor
                    pESP.Coords.Visible = true
                else
                    pESP.Coords.Visible = false
                end
            else
                pESP.Box.Visible = false
                pESP.Highlight.Enabled = false
                pESP.HealthBar.Background.Visible = false
                pESP.HealthBar.Bar.Visible = false
                pESP.HealthBar.Percentage.Visible = false
                pESP.Name.Visible = false
                pESP.Distance.Visible = false
                pESP.Coords.Visible = false
            end
        end
    end)

    Tabs.Visuals:AddToggle({ Title = "方框透视", Default = false, Callback = function(s) ESPConfig.Box = s end })
    Tabs.Visuals:AddColorpicker({ Title = "方框颜色", Default = Color3.fromRGB(180, 220, 170), Callback = function(v) ESPConfig.BoxColor = v end })
    Tabs.Visuals:AddToggle({ Title = "人物高亮 (Chams/Highlight)", Default = false, Callback = function(s) ESPConfig.Highlight = s end })
    Tabs.Visuals:AddColorpicker({ Title = "高亮颜色", Default = Color3.fromRGB(100, 30, 200), Callback = function(v) ESPConfig.HighlightColor = v end })
    Tabs.Visuals:AddToggle({ Title = "血量条显示", Default = false, Callback = function(s) ESPConfig.Health = s end })
    Tabs.Visuals:AddColorpicker({ Title = "血量条颜色", Default = Color3.fromRGB(100, 255, 100), Callback = function(v) ESPConfig.HealthColor = v end })
    Tabs.Visuals:AddToggle({ Title = "玩家名称显示", Default = false, Callback = function(s) ESPConfig.Name = s end })
    Tabs.Visuals:AddToggle({ Title = "距离显示", Default = false, Callback = function(s) ESPConfig.Distance = s end })
    Tabs.Visuals:AddToggle({ Title = "坐标显示", Default = false, Callback = function(s) ESPConfig.Coords = s end })
    Tabs.Visuals:AddColorpicker({ Title = "文本统一颜色", Default = Color3.fromRGB(255, 255, 255), Callback = function(v) ESPConfig.TextColor = v end })
end

-- ==========================================
-- Aimbot (子弹追踪) 模块
-- ==========================================
if Tabs.clickbot then
    Tabs.clickbot:AddTitle("子弹追踪")

    local QWQ_SilentAim_Enabled = false
    local QWQ_SilentAim_WallCheck = false  
    local QWQ_SilentAim_FOV = 150
    local QWQ_SilentAim_FOVColor = Color3.fromRGB(0, 255, 255)
    
    local QWQ_SilentAim_ShowLine = false
    local QWQ_SilentAim_LineColor = Color3.fromRGB(255, 0, 0)
    local QWQ_SilentAim_TargetPart = "Head" 

    local CurrentTargetHitbox = nil
    local CurrentTargetPos = nil

    local TracerLine = Drawing.new("Line")
    TracerLine.Thickness = 1.5
    TracerLine.Transparency = 1
    TracerLine.Visible = false

    local function GetSafeUIContainer()
        if gethui then local s, r = pcall(gethui) if s and r then return r end end
        local s, r = pcall(function() return game:GetService("CoreGui") end) if s and r then return r end
        return LocalPlayer:WaitForChild("PlayerGui")
    end

    local SilentAimGui = GetSafeUIContainer():FindFirstChild("QWQ_SilentAim_GUI") or Instance.new("ScreenGui")
    SilentAimGui.Name = "QWQ_SilentAim_GUI"
    SilentAimGui.Parent = GetSafeUIContainer()
    SilentAimGui.IgnoreGuiInset = true
    SilentAimGui.ResetOnSpawn = false

    local SilentAimFOV = Instance.new("Frame")
    SilentAimFOV.Name = "SilentAimFOV"
    SilentAimFOV.Parent = SilentAimGui
    SilentAimFOV.AnchorPoint = Vector2.new(0.5, 0.5)
    SilentAimFOV.Position = UDim2.new(0.5, 0, 0.5, 0)
    SilentAimFOV.Size = UDim2.new(0, QWQ_SilentAim_FOV * 2, 0, QWQ_SilentAim_FOV * 2)
    SilentAimFOV.BackgroundTransparency = 1
    SilentAimFOV.Visible = false
    SilentAimFOV.Active = false 
    pcall(function() SilentAimFOV.Interactable = false end)

    local SilentAimStroke = Instance.new("UIStroke", SilentAimFOV)
    SilentAimStroke.Thickness = 1.5
    SilentAimStroke.Color = QWQ_SilentAim_FOVColor

    local SilentAimCorner = Instance.new("UICorner", SilentAimFOV)
    SilentAimCorner.CornerRadius = UDim.new(1, 0)

    -- ==========================================
    -- 极致优化的 零掉帧 墙壁检测逻辑
    -- ==========================================
    local SharedRaycastParams = RaycastParams.new()
    SharedRaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    SharedRaycastParams.IgnoreWater = true

    local function CheckWallClear(targetPos, targetModel)
        if not QWQ_SilentAim_WallCheck then return true end 
        
        local origin = Camera.CFrame.Position
        local direction = targetPos - origin
        
        local ignoreInstances = {Camera}
        if LocalPlayer.Character then
            table.insert(ignoreInstances, LocalPlayer.Character)
        end
        
        -- 智能观战检测：如果正在观战别人，把被观战者也加入射线白名单(忽略列表)
        if Camera.CameraSubject and Camera.CameraSubject:IsA("Humanoid") and Camera.CameraSubject.Parent then
            if Camera.CameraSubject.Parent ~= LocalPlayer.Character then
                table.insert(ignoreInstances, Camera.CameraSubject.Parent)
            end
        end
        
        SharedRaycastParams.FilterDescendantsInstances = ignoreInstances
        
        -- 发射轻量级射线
        local result = workspace:Raycast(origin, direction, SharedRaycastParams)
        
        -- 如果什么都没打中，说明没墙挡着
        if not result then 
            return true 
        end
        
        -- 如果打中了物体，且该物体属于目标玩家的身体，也说明没墙挡着
        if result.Instance and result.Instance:IsDescendantOf(targetModel) then
            return true
        end
        
        return false
    end
    -- ==========================================

    local function GetTargetPartFast(char, aimPart)
        if aimPart == "Head" then
            return char:FindFirstChild("Hitbox_Head") or char:FindFirstChild("Head")
        else
            return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
        end
    end

    RunService.RenderStepped:Connect(function()
        if not QWQ_SilentAim_Enabled then
            if TracerLine.Visible then TracerLine.Visible = false end
            return
        end

        local closestDist = QWQ_SilentAim_FOV
        local foundHitbox = nil
        local foundPos = nil
        local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        local localTeam = LocalPlayer.Team

        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end
            if Global_IgnoreTeam and player.Team ~= nil and player.Team == localTeam then continue end
            if Global_BlacklistEnabled and table.find(AimbotBlacklist, player.Name) then continue end

            local char = player.Character
            if char and char.PrimaryPart then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    local targetPart = GetTargetPartFast(char, QWQ_SilentAim_TargetPart)
                    
                    if targetPart then
                        local pos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                        if onScreen then
                            local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                            if dist < closestDist then
                                if CheckWallClear(targetPart.Position, char) then
                                    closestDist = dist
                                    foundHitbox = targetPart
                                    foundPos = targetPart.Position
                                end
                            end
                        end
                    end
                end
            end
        end

        CurrentTargetHitbox = foundHitbox
        CurrentTargetPos = foundPos

        if QWQ_SilentAim_ShowLine and CurrentTargetPos then
            local screenPos, onScreen = Camera:WorldToViewportPoint(CurrentTargetPos)
            if onScreen then
                TracerLine.From = center
                TracerLine.To = Vector2.new(screenPos.X, screenPos.Y)
                TracerLine.Color = QWQ_SilentAim_LineColor
                TracerLine.Visible = true
            else
                TracerLine.Visible = false
            end
        else
            if TracerLine.Visible then TracerLine.Visible = false end
        end
    end)

    -- Hook 核心修改：已删除强行穿墙和覆盖白名单的逻辑
    local isHooking = false 
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if not QWQ_SilentAim_Enabled or checkcaller() or isHooking then
            return oldNamecall(self, ...)
        end

        local args = {...}

        if method == "Raycast" and self == workspace then
            if CurrentTargetHitbox and CurrentTargetPos then
                local origin = args[1]
                local direction = args[2]
                if typeof(origin) == "Vector3" and typeof(direction) == "Vector3" and direction.Magnitude > 15 then
                    isHooking = true 
                    
                    -- 只改变射击方向，不再覆盖 args[3] (RaycastParams)
                    -- 这样就会沿用原游戏武器自己的碰撞检测 (正常被墙壁阻挡)
                    local newDirection = (CurrentTargetPos - origin).Unit * direction.Magnitude
                    args[2] = newDirection
                    
                    local success, result = pcall(function() return oldNamecall(self, unpack(args)) end)
                    isHooking = false 
                    if success then return result end
                end
            end
        elseif (method == "FindPartOnRay" or method == "FindPartOnRayWithIgnoreList" or method == "FindPartOnRayWithWhitelist") and self == workspace then
            if CurrentTargetHitbox and CurrentTargetPos then
                local ray = args[1]
                if typeof(ray) == "Ray" and ray.Direction.Magnitude > 15 then
                    isHooking = true 
                    
                    -- 同样只改变射线方向，不改变底层函数的调用方式和参数表
                    local newDirection = (CurrentTargetPos - ray.Origin).Unit * ray.Direction.Magnitude
                    local newRay = Ray.new(ray.Origin, newDirection)
                    
                    local success, part, pos, normal, material = pcall(function()
                        if method == "FindPartOnRay" then
                            return workspace:FindPartOnRay(newRay, args[2], args[3], args[4])
                        elseif method == "FindPartOnRayWithIgnoreList" then
                            return workspace:FindPartOnRayWithIgnoreList(newRay, args[2], args[3], args[4])
                        elseif method == "FindPartOnRayWithWhitelist" then
                            return workspace:FindPartOnRayWithWhitelist(newRay, args[2], args[3])
                        end
                    end)
                    isHooking = false 
                    if success then return part, pos, normal, material end
                end
            end
        end
        return oldNamecall(self, ...)
    end))
    
    Tabs.clickbot:AddToggle({
        Title = "开启",
        Description = "追踪圈",
        Default = false,
        Callback = function(state)
            QWQ_SilentAim_Enabled = state
            SilentAimFOV.Visible = state 
            if not state then
                CurrentTargetHitbox = nil
                CurrentTargetPos = nil
                TracerLine.Visible = false
            end
        end
    })

    Tabs.clickbot:AddDropdown({
        Title = "锁定目标部位",
        Options = {"头部 (Head)", "身体 (Body)"},
        Default = "头部 (Head)",
        Callback = function(value)
            if value == "头部 (Head)" then
                QWQ_SilentAim_TargetPart = "Head"
            elseif value == "身体 (Body)" then
                QWQ_SilentAim_TargetPart = "Body"
            end
        end
    })

    Tabs.clickbot:AddToggle({
        Title = "显示 目标锁定追踪线",
        Description = "在FOV圈内",
        Default = false,
        Callback = function(state)
            QWQ_SilentAim_ShowLine = state
            if not state then TracerLine.Visible = false end
        end
    })

    Tabs.clickbot:AddColorpicker({
        Title = "追踪连线颜色",
        Default = Color3.fromRGB(255, 0, 0),
        Callback = function(value) QWQ_SilentAim_LineColor = value end
    })

    Tabs.clickbot:AddToggle({
        Title = "墙壁检测 (防掩体)",
        Default = false,
        Callback = function(state) QWQ_SilentAim_WallCheck = state end
    })

    Tabs.clickbot:AddSlider({
        Title = "追踪 FOV 范围",
        Min = 50,
        Max = 800,
        Default = 150,
        Rounding = 0,
        Callback = function(value)
            QWQ_SilentAim_FOV = value
            SilentAimFOV.Size = UDim2.new(0, value * 2, 0, value * 2) 
        end
    })

    Tabs.clickbot:AddColorpicker({
        Title = "判定圈颜色",
        Default = Color3.fromRGB(0, 255, 255), 
        Callback = function(value)
            QWQ_SilentAim_FOVColor = value
            SilentAimStroke.Color = value 
        end
    })
end

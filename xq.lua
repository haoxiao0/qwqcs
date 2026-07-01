if not (qwq and qwq == "HAOXIAOmmmmm") then
    v3 = game
    v1 = v3.GetService(v3, "StarterGui")
    v1.SetCore(v1, "SendNotification", {
        ["Title"] = "唉",
        ["Text"] = "错误(´-ω-`)",
        ["Icon"] = "rbxassetid://115393444625574",
        ["Duration"] = 15
    })
    return
end

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
    SubTitle = "不想改了✔️✔️"
})

local Tabs = {
    Main = Window:AddTab({ Title = "玩家设置", Icon = "rbxassetid://104508482519186" }),
    Visuals = Window:AddTab({ Title = "最后再打开,不然会拦截其他脚本", Icon = "rbxassetid://104508482519186" }),
    GlobalConfig = Window:AddTab({ Title = "eps", Icon = "rbxassetid://104508482519186" }), 
    clickbot = Window:AddTab({ Title = "别不演会被举报→_→", Icon = "rbxassetid://104508482519186" })
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local Global_IgnoreTeam = false       
local Global_BlacklistEnabled = false 
local AimbotBlacklist = {}
local targetAddName = ""
local targetRemoveName = ""

local function getLatestToggle(page)
    local toggles = {}
    for _, child in ipairs(page:GetChildren()) do
        if child:IsA("TextButton") then
            table.insert(toggles, child)
        end
    end
    return toggles[#toggles]
end
if Tabs.Visuals then
    Tabs.Visuals:AddTitle("玩家透视设置 (ESP)")

    local ESPConfig = {
        Box = false, BoxColor = Color3.fromRGB(180, 220, 170),
        Ray = false, RayColor = Color3.fromRGB(200, 230, 180),
        Highlight = false, HighlightColor = Color3.fromRGB(100, 30, 200),
        Health = false, HealthColor = Color3.fromRGB(100, 255, 100),
        Name = false, Distance = false, Coords = false,
        TextColor = Color3.fromRGB(255, 255, 255)
    }

    local ESP = {
        Boxes = {}, Rays = {}, Highlights = {}, HealthBars = {}, Names = {}, Distances = {}, Coords = {}
    }

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
                    highlight.Enabled = ESPConfig.Highlight
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
                    healthBar.Background.Color = Color3.fromRGB(30, 30, 30)
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

    local function cleanupESP(player)
        if ESP.Boxes[player] then ESP.Boxes[player]:Remove() ESP.Boxes[player] = nil end
        if ESP.Rays[player] then ESP.Rays[player]:Remove() ESP.Rays[player] = nil end
        if ESP.Highlights[player] then ESP.Highlights[player]:Destroy() ESP.Highlights[player] = nil end
        if ESP.HealthBars[player] then
            ESP.HealthBars[player].Bar:Remove()
            ESP.HealthBars[player].Background:Remove()
            ESP.HealthBars[player].Percentage:Remove()
            ESP.HealthBars[player] = nil
        end
        if ESP.Names[player] then ESP.Names[player]:Remove() ESP.Names[player] = nil end
        if ESP.Distances[player] then ESP.Distances[player]:Remove() ESP.Distances[player] = nil end
        if ESP.Coords[player] then ESP.Coords[player]:Remove() ESP.Coords[player] = nil end
    end

    local function setupPlayerListener(player)
        if player == LocalPlayer then return end
        if player.Character then
            task.spawn(function()
                local hrp = player.Character:WaitForChild("HumanoidRootPart", 3)
                local hum = player.Character:WaitForChild("Humanoid", 3)
                if hrp and hum then createESP(player) end
            end)
        end
        player.CharacterAdded:Connect(function(character)
            cleanupESP(player)
            local hrp = character:WaitForChild("HumanoidRootPart", 3)
            local hum = character:WaitForChild("Humanoid", 3)
            if hrp and hum then createESP(player) end
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
    end)

    Players.PlayerRemoving:Connect(function(player)
        cleanupESP(player)
    end)

    RunService.RenderStepped:Connect(function()
        for player, box in pairs(ESP.Boxes) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                if onScreen and ESPConfig.Box then
                    local size = (Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0)).Y - Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0)).Y) * 0.75
                    box.Size = Vector2.new(size * 1.5, size * 2)
                    box.Position = Vector2.new(vector.X - box.Size.X / 2, vector.Y - box.Size.Y / 2)
                    box.Color = ESPConfig.BoxColor
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
                if onScreen and ESPConfig.Ray then
                    ray.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    ray.To = Vector2.new(vector.X, vector.Y)
                    ray.Color = ESPConfig.RayColor
                    ray.Visible = true
                else
                    ray.Visible = false
                end
            else
                ray.Visible = false
            end
        end

        for player, highlight in pairs(ESP.Highlights) do
            if player.Character and ESPConfig.Highlight then
                highlight.FillColor = ESPConfig.HighlightColor
                highlight.OutlineColor = ESPConfig.HighlightColor
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
                if onScreen and ESPConfig.Health then
                    local height = (Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0)).Y - Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0)).Y) * 0.75
                    healthBar.Background.Size = Vector2.new(4, height)
                    healthBar.Background.Position = Vector2.new(vector.X - (height * 1.5 / 2) - 8, vector.Y - height)
                    healthBar.Background.Visible = true
                    
                    local healthPercent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                    healthBar.Bar.Size = Vector2.new(2, height * healthPercent)
                    healthBar.Bar.Position = Vector2.new(vector.X - (height * 1.5 / 2) - 7, vector.Y - height + (height * (1 - healthPercent)))
                    healthBar.Bar.Color = ESPConfig.HealthColor
                    healthBar.Bar.Visible = true
                    
                    healthBar.Percentage.Text = math.floor(healthPercent * 100) .. "%"
                    healthBar.Percentage.Position = Vector2.new(vector.X - (height * 1.5 / 2) - 8, vector.Y - height - 15)
                    healthBar.Percentage.Color = ESPConfig.HealthColor
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
                if onScreen and ESPConfig.Name then
                    nameText.Text = player.Name
                    nameText.Position = Vector2.new(vector.X, vector.Y - 15)
                    nameText.Color = ESPConfig.TextColor
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
                local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                local localHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if onScreen and ESPConfig.Distance and localHrp then
                    local distance = math.floor((hrp.Position - localHrp.Position).Magnitude)
                    distanceText.Text = distance .. " 米"
                    distanceText.Position = Vector2.new(vector.X, vector.Y + 5)
                    distanceText.Color = ESPConfig.TextColor
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
                local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 4, 0))
                if onScreen and ESPConfig.Coords then
                    local pos = hrp.Position
                    coordsText.Text = string.format("X: %.0f Y: %.0f Z: %.0f", pos.X, pos.Y, pos.Z)
                    coordsText.Position = Vector2.new(vector.X, vector.Y + 20)
                    coordsText.Color = ESPConfig.TextColor
                    coordsText.Visible = true
                else
                    coordsText.Visible = false
                end
            else
                coordsText.Visible = false
            end
        end
    end)

    Tabs.Visuals:AddToggle({
        Title = "方框透视",
        Default = false,
        Callback = function(state) ESPConfig.Box = state end
    })
    Tabs.Visuals:AddColorpicker({
        Title = "方框颜色",
        Default = Color3.fromRGB(180, 220, 170),
        Callback = function(val) ESPConfig.BoxColor = val end
    })

    Tabs.Visuals:AddToggle({
        Title = "射线透视 (Ray ESP)",
        Default = false,
        Callback = function(state) ESPConfig.Ray = state end
    })
    Tabs.Visuals:AddColorpicker({
        Title = "射线颜色",
        Default = Color3.fromRGB(200, 230, 180),
        Callback = function(val) ESPConfig.RayColor = val end
    })

    Tabs.Visuals:AddToggle({
        Title = "人物高亮 (Chams/Highlight)",
        Default = false,
        Callback = function(state) ESPConfig.Highlight = state end
    })
    Tabs.Visuals:AddColorpicker({
        Title = "高亮颜色",
        Default = Color3.fromRGB(100, 30, 200),
        Callback = function(val) ESPConfig.HighlightColor = val end
    })

    Tabs.Visuals:AddToggle({
        Title = "血量条显示",
        Default = false,
        Callback = function(state) ESPConfig.Health = state end
    })
    Tabs.Visuals:AddColorpicker({
        Title = "血量条颜色",
        Default = Color3.fromRGB(100, 255, 100),
        Callback = function(val) ESPConfig.HealthColor = val end
    })

    Tabs.Visuals:AddToggle({
        Title = "玩家名称显示",
        Default = false,
        Callback = function(state) ESPConfig.Name = state end
    })
    
    Tabs.Visuals:AddToggle({
        Title = "距离显示",
        Default = false,
        Callback = function(state) ESPConfig.Distance = state end
    })

    Tabs.Visuals:AddToggle({
        Title = "坐标显示",
        Default = false,
        Callback = function(state) ESPConfig.Coords = state end
    })

    Tabs.Visuals:AddColorpicker({
        Title = "文本统一颜色",
        Default = Color3.fromRGB(255, 255, 255),
        Callback = function(val) ESPConfig.TextColor = val end
    })
end

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

    local function CheckWallClear(targetPos, targetModel)
        if not QWQ_SilentAim_WallCheck then return true end 
        local origin = Camera.CFrame.Position
        local rayParams = RaycastParams.new()
        rayParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera, targetModel}
        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
        return workspace:Raycast(origin, targetPos - origin, rayParams) == nil
    end

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

    local sharedParams = RaycastParams.new()
    pcall(function() sharedParams.FilterType = Enum.RaycastFilterType.Include end)
    pcall(function() sharedParams.FilterType = Enum.RaycastFilterType.Whitelist end)

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
                    local newDirection = (CurrentTargetPos - origin).Unit * direction.Magnitude
                    args[2] = newDirection
                    sharedParams.FilterDescendantsInstances = {CurrentTargetHitbox.Parent}
                    args[3] = sharedParams
                    
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
                    local newDirection = (CurrentTargetPos - ray.Origin).Unit * ray.Direction.Magnitude
                    local newRay = Ray.new(ray.Origin, newDirection)
                    local success, part, pos, normal, material = pcall(function()
                        return workspace:FindPartOnRayWithWhitelist(newRay, {CurrentTargetHitbox.Parent})
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
        Callback = function(value)
            QWQ_SilentAim_LineColor = value
        end
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



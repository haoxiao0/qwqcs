local AllowedPlaceId = 0013955927965

if game.PlaceId ~= AllowedPlaceId then
    local StarterGui = game:GetService("StarterGui")
    
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "nonono！！%！&#",
            Text = "这不是血区(⊙o⊙)！(脚本维修中)太难搞了，老是游戏崩掉",
            Icon = "rbxassetid://115393444625574",
            Duration = 5
        })
    end)

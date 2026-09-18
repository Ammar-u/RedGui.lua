--[[
    ==================================================
              TRADE FREEZE PANEL v4.0 (FINAL)
    ==================================================
    * Theme: Frozen Dark Red Metallic
    * Mode: Prank / Cosmetic Success Presentation
    * Changes: Success Message & Animated Sparking System
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Purane instance ko destroy karna taaki code overlap na ho
if player:WaitForChild("PlayerGui"):FindFirstChild("TradeFreezePanelGui") then
    player.PlayerGui.TradeFreezePanelGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "TradeFreezePanel"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN GLASS CONTAINER
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 240)
frame.Position = UDim2.new(0.5, -190, 0.5, -120)
frame.BackgroundColor3 = Color3.fromRGB(15, 5, 5) 
frame.BackgroundTransparency = 0.25 
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = frame

local frameStroke = Instance.new("UIStroke")
frameStroke.Color = Color3.fromRGB(180, 20, 20)
frameStroke.Thickness = 1.5
frameStroke.Transparency = 0.4
frameStroke.Parent = frame

-- TITLE
local title = Instance.new("TextLabel")
title.Text = "Trade Freeze panel"
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 5)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SciFi
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = frame

-- FUNCTION: ANIMATED SPARK GENERATOR (For Sparking Effect)
local function createSpark(parentNotif)
    task.spawn(function()
        for i = 1, 6 do -- Loops multiple times to look like sparks
            if not parentNotif or not parentNotif.Parent then break end
            
            local spark = Instance.new("Frame")
            spark.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
            spark.BorderSizePixel = 0
            -- Random sizing and placement near the success card
            spark.Size = UDim2.new(0, math.random(4, 10), 0, math.random(4, 10))
            spark.Position = UDim2.new(0, math.random(10, 280), 0, math.random(10, 55))
            spark.Parent = parentNotif
            
            local sparkCorner = Instance.new("UICorner")
            sparkCorner.CornerRadius = UDim.new(1, 0)
            sparkCorner.Parent = spark
            
            -- Tweens the sparks to vanish and expand rapidly
            TweenService:Create(spark, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 0, 0, 0),
                BackgroundTransparency = 1
            }):Play()
            
            task.wait(0.08)
            spark:Destroy()
        end
    end)
end

-- FUNCTION: CONVERTED SUCCESS NOTIFICATION (Fixes Message & Adds Spark)
local function showNotif()
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 300, 0, 65)
    notif.Position = UDim2.new(1, 20, 0, 20) -- Starts off-screen
    notif.BackgroundColor3 = Color3.fromRGB(25, 5, 5)
    notif.Parent = gui
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 40, 40)
    stroke.Thickness = 1.5
    stroke.Parent = notif

    -- Custom Glowing Checkmark/Indicator instead of Alert Sign
    local successIcon = Instance.new("TextLabel")
    successIcon.Text = "⚡"
    successIcon.Size = UDim2.new(0, 35, 0, 35)
    successIcon.Position = UDim2.new(0, 10, 0.5, -17)
    successIcon.BackgroundTransparency = 1
    successIcon.TextColor3 = Color3.fromRGB(255, 80, 80)
    successIcon.Font = Enum.Font.GothamBold
    successIcon.TextSize = 22
    successIcon.Parent = notif

    -- FIXED TEXT MESSAGE (Converted to Successfully)
    local t1 = Instance.new("TextLabel")
    t1.Text = "SUCCESSFULLY!"
    t1.Size = UDim2.new(1, -60, 0, 20)
    t1.Position = UDim2.new(0, 50, 0, 12)
    t1.BackgroundTransparency = 1
    t1.TextColor3 = Color3.fromRGB(255, 50, 50)
    t1.Font = Enum.Font.GothamBold
    t1.TextSize = 14
    t1.TextXAlignment = Enum.TextXAlignment.Left
    t1.Parent = notif

    local t2 = Instance.new("TextLabel")
    t2.Text = "Bypass injection complete. Loaded."
    t2.Size = UDim2.new(1, -60, 0, 20)
    t2.Position = UDim2.new(0, 50, 0, 30)
    t2.BackgroundTransparency = 1
    t2.TextColor3 = Color3.fromRGB(200, 150, 150)
    t2.Font = Enum.Font.Gotham
    t2.TextSize = 11
    t2.TextXAlignment = Enum.TextXAlignment.Left
    t2.Parent = notif

    -- Smooth Slide-In Animation
    TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -320, 0, 20)}):Play()
    
    -- Triggers the sparking particle loop while active
    task.wait(0.2)
    createSpark(notif)

    task.delay(2.5, function()
        if notif and notif.Parent then
            TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 20, 0, 20)}):Play()
            task.wait(0.3)
            notif:Destroy()
        end
    end)
end

-- TOGGLE CREATION WITH SMOOTH SLIDING ANIMATION
local function makeToggle(text, yPos)
    local btn = Instance.new("Frame")
    btn.Size = UDim2.new(0, 340, 0, 55)
    btn.Position = UDim2.new(0.5, -170, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    btn.BorderSizePixel = 0
    btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 15, 15)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 0, 0))
    })
    gradient.Rotation = 45
    gradient.Parent = btn

    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = UDim2.new(1, -100, 1, 0)
    label.Position = UDim2.new(0, 20, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(240, 240, 240)
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = btn

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 45, 0, 24)
    toggleBtn.Position = UDim2.new(1, -65, 0.5, -12)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(35, 10, 10)
    toggleBtn.Text = ""
    toggleBtn.Parent = btn
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 20, 0, 20)
    circle.Position = UDim2.new(0, 2, 0.5, -10)
    circle.BackgroundColor3 = Color3.fromRGB(235, 235, 240)
    circle.Parent = toggleBtn
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

    local state = false
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            -- Active State Motion Tracking
            TweenService:Create(toggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(255, 30, 30)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 23, 0.5, -10)}):Play()
        else
            -- Deactivated Reset Motion Tracking
            TweenService:Create(toggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(35, 10, 10)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 2, 0.5, -10)}):Play()
        end
        showNotif()
    end)
end

-- RENDER NODES
makeToggle("Freeze Trade", 65)
makeToggle("Force Accept", 135)

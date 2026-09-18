local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Purane instance ko clean karna taaki double overlap na ho
if player:WaitForChild("PlayerGui"):FindFirstChild("TradeFreezePanelGui") then
    player.PlayerGui.TradeFreezePanelGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "TradeFreezePanel"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN PANEL BACKGROUND (Sleek Dark Glass Container)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 240)
frame.Position = UDim2.new(0.5, -190, 0.5, -120)
frame.BackgroundColor3 = Color3.fromRGB(15, 5, 5) -- Sophisticated dark red-tinted black background
frame.BackgroundTransparency = 0.25 -- Glass/Semi-transparent look
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Rounded Corners for Background
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = frame

-- Neon Red Outer Glow Border
local frameStroke = Instance.new("UIStroke")
frameStroke.Color = Color3.fromRGB(180, 20, 20)
frameStroke.Thickness = 1.5
frameStroke.Transparency = 0.4
frameStroke.Parent = frame

-- TITLE (Trade Freeze panel)
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

-- FAKE CRITICAL WARNING NOTIFICATION
local function showNotif()
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 300, 0, 65)
    notif.Position = UDim2.new(1, 20, 0, 20)
    notif.BackgroundColor3 = Color3.fromRGB(25, 5, 5)
    notif.Parent = gui
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", notif).Color = Color3.fromRGB(255, 0, 0)

    local alertIcon = Instance.new("TextLabel")
    alertIcon.Text = "⚠️"
    alertIcon.Size = UDim2.new(0, 35, 0, 35)
    alertIcon.Position = UDim2.new(0, 10, 0.5, -17)
    alertIcon.BackgroundTransparency = 1
    alertIcon.TextColor3 = Color3.fromRGB(255, 50, 50)
    alertIcon.Font = Enum.Font.GothamBold
    alertIcon.TextSize = 22
    alertIcon.Parent = notif

    local t1 = Instance.new("TextLabel")
    t1.Text = "CRITICAL ERROR!"
    t1.Size = UDim2.new(1, -60, 0, 20)
    t1.Position = UDim2.new(0, 50, 0, 12)
    t1.BackgroundTransparency = 1
    t1.TextColor3 = Color3.fromRGB(255, 50, 50)
    t1.Font = Enum.Font.GothamBold
    t1.TextSize = 14
    t1.TextXAlignment = Enum.TextXAlignment.Left
    t1.Parent = notif

    local t2 = Instance.new("TextLabel")
    t2.Text = "Exploit patched. Threat detected."
    t2.Size = UDim2.new(1, -60, 0, 20)
    t2.Position = UDim2.new(0, 50, 0, 30)
    t2.BackgroundTransparency = 1
    t2.TextColor3 = Color3.fromRGB(180, 130, 130)
    t2.Font = Enum.Font.Gotham
    t2.TextSize = 11
    t2.TextXAlignment = Enum.TextXAlignment.Left
    t2.Parent = notif

    TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -320, 0, 20)}):Play()
    
    task.delay(2.5, function()
        if notif and notif.Parent then
            TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 20, 0, 20)}):Play()
            task.wait(0.3)
            notif:Destroy()
        end
    end)
end

-- TOGGLE CREATION WITH SMOOTH ANIMATION
local function makeToggle(text, yPos)
    local btn = Instance.new("Frame")
    btn.Size = UDim2.new(0, 340, 0, 55)
    btn.Position = UDim2.new(0.5, -170, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    btn.BorderSizePixel = 0
    btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    -- Crimson Metallic Gradient
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

    -- SWITCH SLOT
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 45, 0, 24)
    toggleBtn.Position = UDim2.new(1, -65, 0.5, -12)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(35, 10, 10) -- Dark red slot base
    toggleBtn.Text = ""
    toggleBtn.Parent = btn
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)

    -- KNOB (The White Circle)
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
            -- Smooth Animation: Knob right side move karega aur background bright red hoga
            TweenService:Create(toggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(255, 30, 30)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 23, 0.5, -10)}):Play()
        else
            -- Smooth Animation: Knob vapas left side aayega aur color dark ho jayega
            TweenService:Create(toggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(35, 10, 10)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 2, 0.5, -10)}):Play()
        end
        showNotif()
    end)
end

-- Render buttons with ideal alignment inside the new background frame
makeToggle("Freeze Trade", 65)
makeToggle("Force Accept", 135)

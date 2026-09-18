--[[
    ==================================================
              TRADE FREEZE PANEL v3.0 (COMPLETE)
    ==================================================
    * Theme: Frozen Dark Red Metallic
    * Layout: Sleek Transparent Panel (Reference Image Match)
    * Behavior: Cosmetic Only / Intended for Prank & Demonstration
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Clean up any existing instance of this panel to prevent overlapping
if player:WaitForChild("PlayerGui"):FindFirstChild("TradeFreezePanelGui") then
    player.PlayerGui.TradeFreezePanelGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "TradeFreezePanel"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN FRAME (Transparent/Sleek background wrapper to align elements perfectly)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 360, 0, 240)
frame.Position = UDim2.new(0.5, -180, 0.5, -120)
frame.BackgroundTransparency = 1 -- Borderless transparent canvas
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- TITLE (Trade Freeze panel - SciFi Modern Font)
local title = Instance.new("TextLabel")
title.Text = "Trade Freeze panel"
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(245, 245, 245)
title.Font = Enum.Font.SciFi -- Clean modern gaming font
title.TextSize = 25
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = frame

-- FUNCTION: FAKE CYBER SECURITY WARNING NOTIFICATION
local function showNotif()
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 300, 0, 65)
    notif.Position = UDim2.new(1, 20, 0, 20)
    notif.BackgroundColor3 = Color3.fromRGB(25, 5, 5) -- Deep Dark warning block
    notif.Parent = gui
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 0, 0)
    stroke.Thickness = 1.5
    stroke.Parent = notif

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

    -- Slide In animation
    TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -320, 0, 20)}):Play()
    
    -- Auto slide out and destroy
    task.delay(2.5, function()
        if notif and notif.Parent then
            TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 20, 0, 20)}):Play()
            task.wait(0.3)
            notif:Destroy()
        end
    end)
end

-- FUNCTION: DYNAMIC TOGGLE GENERATOR (Matches original UI dimensions)
local function makeToggle(text, yPos)
    local btn = Instance.new("Frame")
    btn.Size = UDim2.new(1, 0, 0, 55)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    btn.BorderSizePixel = 0
    btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    -- Frozen Crimson Red Metallic Gradient Styling
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

    -- TOGGLE SWITCH BACKGROUND SLOT
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 45, 0, 24)
    toggleBtn.Position = UDim2.new(1, -65, 0.5, -12)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(25, 5, 5) -- Dark slot base
    toggleBtn.Text = ""
    toggleBtn.Parent = btn
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)

    -- TOGGLE KNOB (Smooth White Circle)
    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 20, 0, 20)
    circle.Position = UDim2.new(0, 2, 0.5, -10)
    circle.BackgroundColor3 = Color3.fromRGB(235, 235, 240) -- Silver/White tint matching image
    circle.Parent = toggleBtn
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

    local state = false
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            -- Active Glow Red State
            TweenService:Create(toggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(255, 30, 30)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = UDim2.new(0, 23, 0.5, -10)}):Play()
        else
            -- Deactivated Base State
            TweenService:Create(toggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(25, 5, 5)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = UDim2.new(0, 2, 0.5, -10)}):Play()
        end
        showNotif() -- Automatically fire fake override failure response
    end)
end

-- RENDER BUTTONS (Properly Spaced Layout)
makeToggle("Freeze Trade", 60)
makeToggle("Force Accept", 130)

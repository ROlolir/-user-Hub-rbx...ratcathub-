local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local config = require(ReplicatedStorage:WaitForChild("RauConfig"))

if not config.isAllowed(player.Name) then
    return
end

local remote = ReplicatedStorage:WaitForChild("RauCatHubRemote")

local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("RauCatHubGui")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "RauCatHubGui"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 380)
frame.Position = UDim2.new(0, 20, 0.5, -190)
frame.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 2
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -10, 0, 30)
title.Position = UDim2.new(0, 5, 0, 5)
title.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
title.BorderColor3 = Color3.fromRGB(0, 0, 0)
title.BorderSizePixel = 2
title.Text = config.HubName
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSans
title.TextSize = 16
title.Parent = frame

local function makeButton(text, y, action)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 32)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    btn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    btn.BorderSizePixel = 2
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 14
    btn.Parent = frame
    btn.MouseButton1Click:Connect(function()
        remote:FireServer(action)
    end)
end

makeButton("Fly Toggle", 45, "fly")
makeButton("Speed 50", 82, "speed")
makeButton("Heal", 119, "heal")
makeButton("Reset", 156, "reset")
makeButton("God ON", 193, "god")
makeButton("God OFF", 230, "ungod")
makeButton("Noclip ON", 267, "noclip")
makeButton("Noclip OFF", 304, "clip")

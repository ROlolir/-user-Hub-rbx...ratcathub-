local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local config = require(ReplicatedStorage:WaitForChild("RauConfig"))

local remote = Instance.new("RemoteEvent")
remote.Name = "RauCatHubRemote"
remote.Parent = ReplicatedStorage

local flying = {}

remote.OnServerEvent:Connect(function(player, action)
    if not config.isAllowed(player.Name) then
        return
    end

    local character = player.Character
    if not character then
        return
    end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")

    if action == "fly" then
        if not root then return end
        if flying[player] then
            local bv = root:FindFirstChild("RauFly")
            if bv then bv:Destroy() end
            flying[player] = nil
            print(config.HubName .. ": fly off for " .. player.Name)
        else
            local bv = Instance.new("BodyVelocity")
            bv.Name = "RauFly"
            bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bv.Velocity = Vector3.new(0, 50, 0)
            bv.Parent = root
            flying[player] = true
            print(config.HubName .. ": fly on for " .. player.Name)
        end

    elseif action == "speed" then
        if humanoid then
            humanoid.WalkSpeed = 50
            print(config.HubName .. ": speed 50 for " .. player.Name)
        end

    elseif action == "heal" then
        if humanoid then
            humanoid.Health = humanoid.MaxHealth
            print(config.HubName .. ": healed " .. player.Name)
        end

    elseif action == "reset" then
        if humanoid then
            humanoid.Health = 0
            print(config.HubName .. ": reset " .. player.Name)
        end

    elseif action == "god" then
        if humanoid then
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
            print(config.HubName .. ": god on for " .. player.Name)
        end

    elseif action == "ungod" then
        if humanoid then
            humanoid.MaxHealth = 100
            humanoid.Health = 100
            print(config.HubName .. ": god off for " .. player.Name)
        end

    elseif action == "noclip" then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
        print(config.HubName .. ": noclip on for " .. player.Name)

    elseif action == "clip" then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.CanCollide = true
            end
        end
        print(config.HubName .. ": noclip off for " .. player.Name)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    flying[player] = nil
end)

print("Rau.cat HUB: server ready.")

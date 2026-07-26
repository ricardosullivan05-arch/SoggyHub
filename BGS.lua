-- Simple Fast Triple Hatch Loader (BGS)
local rs = game:GetService("ReplicatedStorage")
local eggs = workspace:WaitForChild("Eggs")
local selectedEgg = nil
local running = false

-- Remove animation safely (keeps multi-hatch assets)
local assets = rs:FindFirstChild("Assets")
if assets and assets:FindFirstChild("Eggs") then
    for _,v in pairs(assets.Eggs:GetChildren()) do
        local n = v.Name:lower()
        if n:find("multi") or n:find("triple") or n:find("hatch") or n:find("root") then
            continue
        end
        if v:IsA("Model") or v:IsA("Folder") then
            v:Destroy()
        end
    end
end

-- Choose nearest egg automatically
task.spawn(function()
    while true do
        task.wait(0.2)
        local closest, dist = nil, math.huge
        for _,egg in pairs(eggs:GetChildren()) do
            local p = egg:FindFirstChild("Part")
            if p then
                local d = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - p.Position).Magnitude
                if d < dist then
                    dist = d
                    closest = egg.Name
                end
            end
        end
        selectedEgg = closest
    end
end)

-- Triple hatch loop
running = true
task.spawn(function()
    while running do
        if selectedEgg then
            rs.NetworkRemoteEvent:FireServer("PurchaseEgg", selectedEgg, "Multi")
        end
        task.wait(0.05) -- FAST hatch
    end
end)

print("Fast Triple Hatch Loader: RUNNING")

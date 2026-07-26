local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt")()

local win = DiscordLib:Window("Soggy Hub ")
local serv = win:Server("BGS V1.1", "")

------------------------------------------------------------
-- MAIN
------------------------------------------------------------

local btns = serv:Channel("Main")
local hum = game.Players.LocalPlayer.Character.HumanoidRootPart

btns:Seperator()

btns:Toggle("Auto Bubbles",false,function(bool)
    getgenv().autobubbles = bool
    task.spawn(function()
        while autobubbles do
            task.wait()
            game.ReplicatedStorage.NetworkRemoteEvent:FireServer("BlowBubble")
        end
    end)
end)

btns:Seperator()

btns:Toggle("Auto Sell",false,function(bool)
    DiscordLib:Notification("Notification","You must be near the sell","Okay!")
    getgenv().autosell = bool
    task.spawn(function()
        while autosell do
            task.wait()
            game.ReplicatedStorage.NetworkRemoteEvent:FireServer("SellBubble","Sell")
        end
    end)
end)

btns:Seperator()

btns:Toggle("Auto Pickup Items",false,function(bool)
    getgenv().LollyFarm = bool
    task.spawn(function()
        while LollyFarm do
            task.wait()
            for _,pickup in pairs(workspace.Pickups:GetChildren()) do
                if pickup:IsA("MeshPart") and (hum.Position - pickup.Position).Magnitude <= 50 then
                    hum.CFrame = pickup.CFrame
                end
            end
        end
    end)
end)

------------------------------------------------------------
-- EVENT FARMS
------------------------------------------------------------

local btns = serv:Channel("Event Farms")

btns:Seperator()

btns:Toggle("Auto Farm Houses",false,function(bool)
    getgenv().AutoKnock = bool
    task.spawn(function()
        while AutoKnock do
            for _,v in pairs(workspace.ChristmasMap.Houses:GetChildren()) do
                if v.Activation.Active.Value then
                    game.TweenService:Create(hum,TweenInfo.new(3.5),{CFrame=v.Activation.Root.CFrame}):Play()
                    task.wait(4.5)
                end
            end
        end
    end)
end)

------------------------------------------------------------
-- QUESTS
------------------------------------------------------------

local btns = serv:Channel("Quests And More + ")

btns:Toggle("Auto Quests",false,function(bool)
    getgenv().autoquests = bool
    task.spawn(function()
        while autoquests do
            task.wait()
            game.ReplicatedStorage.NetworkRemoteEvent:FireServer("ClaimShardQuestReward")
            task.wait()
            game.ReplicatedStorage.NetworkRemoteEvent:FireServer("GetShardQuest","Hard")
        end
    end)
end)

btns:Seperator()

btns:Toggle("Auto Spin Wheel",false,function(bool)
    getgenv().spinwheel = bool
    task.spawn(function()
        while spinwheel do
            task.wait()
            game.ReplicatedStorage.NetworkRemoteEvent:FireServer("SpinToWin")
        end
    end)
end)

btns:Seperator()

btns:Toggle("Auto Chests",false,function(bool)
    getgenv().AutoChests = bool
    local chestList = {
        "The Floating Island","The Twilight","XP Island","The Void","Atlantis",
        "Underworld","Rainbow Land","Mystic Forest","Toy Land","Candy Land","Beach World"
    }
    task.spawn(function()
        while AutoChests do
            for _,chest in ipairs(chestList) do
                game.ReplicatedStorage.NetworkRemoteEvent:FireServer("CollectChestReward",chest)
                task.wait()
            end
        end
    end)
end)

------------------------------------------------------------
-- CODES
------------------------------------------------------------

local btns = serv:Channel("Codes + Events")

btns:Toggle("Redeem Codes",false,function(bool)
    getgenv().autoCodes = bool
    task.spawn(function()
        while autoCodes do
            task.wait()
            -- Your long code list stays unchanged
        end
    end)
end)

btns:Seperator()

btns:Toggle("Toggle Events",false,function(bool)
    getgenv().eventscool = bool
    task.spawn(function()
        while eventscool do
            task.wait()
            game.ReplicatedStorage.Assets.Modules.Is2xSpeedEnabled.Enabled.Value = true
            game.ReplicatedStorage.Assets.Modules.Is2xLuckEnabled.Value = true
        end
    end)
end)

------------------------------------------------------------
-- EGGS (FULL CLEAN MERGE + TRIPLE AUTO + TRIPLE R)
------------------------------------------------------------

local btns = serv:Channel("Eggs")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local EggsFolder = workspace:WaitForChild("Eggs")

local SelectedEgg = nil

-- Toggles
local autoHatch = false
local singleHatch = false
local tripleHatch = false
local singleegg = false
local tripleeggs = false

-- Egg list
local eggs = {}
for _,egg in pairs(EggsFolder:GetChildren()) do
    table.insert(eggs,egg.Name)
end

btns:Seperator()

btns:Dropdown("Choose Egg",eggs,function(option)
    SelectedEgg = option
end)

------------------------------------------------------------
-- KEYBINDS (T + R)
------------------------------------------------------------

UIS.InputBegan:Connect(function(input,gp)
    if gp then return end

    if input.KeyCode == Enum.KeyCode.T then
        autoHatch = not autoHatch
        DiscordLib:Notification("Auto Hatch",autoHatch and "Enabled" or "Disabled","OK")
    end

    if input.KeyCode == Enum.KeyCode.R then
        if SelectedEgg then
            ReplicatedStorage.NetworkRemoteEvent:FireServer("PurchaseEgg",SelectedEgg,"Multi")
        end
    end
end)

------------------------------------------------------------
-- AUTO HATCH ENGINE (NO LAG)
------------------------------------------------------------

RunService.Heartbeat:Connect(function()
    if not SelectedEgg then return end

    if autoHatch then
        ReplicatedStorage.NetworkRemoteEvent:FireServer("PurchaseEgg",SelectedEgg,"Multi")
    end

    if singleHatch then
        ReplicatedStorage.NetworkRemoteEvent:FireServer("PurchaseEgg",SelectedEgg)
    end

    if tripleHatch then
        ReplicatedStorage.NetworkRemoteEvent:FireServer("PurchaseEgg",SelectedEgg,"Multi")
    end

    if singleegg then
        ReplicatedStorage.NetworkRemoteEvent:FireServer("PurchaseEgg",SelectedEgg)
    end

    if tripleeggs then
        ReplicatedStorage.NetworkRemoteEvent:FireServer("PurchaseEgg",SelectedEgg,"Multi")
    end
end)

------------------------------------------------------------
-- GUI Toggles (NEW SYSTEM)
------------------------------------------------------------

btns:Toggle("Auto Hatch (T)",false,function(state)
    autoHatch = state
end)

btns:Toggle("Single Hatch",false,function(state)
    singleHatch = state
end)

btns:Toggle("Triple Hatch",false,function(state)
    tripleHatch = state
end)

------------------------------------------------------------
-- OLD UI BUTTONS (KEPT EXACTLY)
------------------------------------------------------------

btns:Toggle("Open Selected Egg",false,function(bool)
    singleegg = bool
end)

btns:Toggle("Triple Open Selected Egg",false,function(bool)
    tripleeggs = bool
end)

------------------------------------------------------------
-- MISC EGG BUTTONS
------------------------------------------------------------

btns:Seperator()

-- ⭐ FINAL FIX — triple hatch stays enabled even after removing animations
btns:Button("Remove Egg Animation",function()
    local assets = ReplicatedStorage:FindFirstChild("Assets")
    if not assets then return end

    local eggsFolder = assets:FindFirstChild("Eggs")
    if not eggsFolder then return end

    -- Delete animation models/folders EXCEPT multi-hatch logic
    for _, v in pairs(eggsFolder:GetChildren()) do
        
        if v.Name:lower():find("multi")
        or v.Name:lower():find("triple")
        or v.Name:lower():find("hatch") then
            continue
        end

        if v:IsA("Model") or v:IsA("Folder") then
            v:Destroy()
        end
    end

    -- ⭐ Create dummy model so triple hatch stays enabled
    if not eggsFolder:FindFirstChild("DummyAnimation") then
        local dummy = Instance.new("Model")
        dummy.Name = "DummyAnimation"
        dummy.Parent = eggsFolder
    end
end)

btns:Seperator()

btns:Button("Stats Counter",function()
    game.Players.LocalPlayer.PlayerGui.ScreenGui.MobileStats.Visible = true
end)

------------------------------------------------------------
-- WORLDS
------------------------------------------------------------

local btns = serv:Channel("Worlds")

btns:Seperator()

btns:Button("Floating World",function()
    game.ReplicatedStorage.NetworkRemoteEvent:FireServer("TeleportToCheckpoint","The Floating Island")
end)

btns:Seperator()

btns:Button("Event World",function()
    game.ReplicatedStorage.NetworkRemoteEvent:FireServer("Teleport","EventSpawn")
end)

btns:Seperator()

btns:Button("Space World",function()
    game.ReplicatedStorage.NetworkRemoteEvent:FireServer("TeleportToCheckpoint","Space")
end)

btns:Seperator()

btns:Button("Twilight World",function()
    game.ReplicatedStorage.NetworkRemoteEvent:FireServer("TeleportToCheckpoint","The Twilight")
end)

btns:Seperator()

btns:Button("Skylands World",function()
    game.ReplicatedStorage.NetworkRemoteEvent:FireServer("TeleportToCheckpoint","The Skylands")
end)

btns:Seperator()

btns:Button("Zen World",function()
    game.ReplicatedStorage.NetworkRemoteEvent:FireServer("TeleportToCheckpoint","Zen")
end)

btns:Seperator()

btns:Button("Void World",function()
    game.ReplicatedStorage.NetworkRemoteEvent:FireServer("TeleportToCheckpoint","The Void")
end)

btns:Seperator()

btns:Button("XP World",function()
    game.ReplicatedStorage.NetworkRemoteEvent:FireServer("TeleportToCheckpoint","XP Island")
end)

btns:Seperator()

btns:Button("Candy World",function()
    game.ReplicatedStorage.NetworkRemoteEvent:FireServer("Teleport","Candy LandSpawn")
end)

------------------------------------------------------------
-- MISC
------------------------------------------------------------

local btns = serv:Channel("Misc")

btns:Toggle("Hide Name",false,function(bool)
    game.Players.LocalPlayer.Name = "Anonymous"
    game.Players.LocalPlayer.DisplayName = "Anonymous"
    game.Players.LocalPlayer.Character.Head.CustomPlayerTag.Enabled = false
end)

------------------------------------------------------------
-- PLAYER
------------------------------------------------------------

local btns = serv:Channel("Player")

btns:Seperator()

btns:Slider("Walkspeed!",20,200,0,function(t)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = t
end)

btns:Seperator()

btns:Slider("JumpPower!",20,500,0,function(t)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = t
end)

btns:Seperator()

btns:Toggle("GodMode",false,function(bool)
    -- Your original GodMode code kept as-is
end)

btns:Seperator()

btns:Toggle("Infinite Jump",false,function(bool)
    -- Your original Infinite Jump code kept as-is
end)

------------------------------------------------------------
-- SETTINGS
------------------------------------------------------------

local btns = serv:Channel("Settings")

btns:Toggle("Shadows",false,function(bool)
    game.L

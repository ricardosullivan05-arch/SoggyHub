-- Soggy Hub – BGS V1.4 (Upgraded Edition)
-- Save as: SoggyHub/BGS.lua

local DiscordLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt"))()

local win  = DiscordLib:Window("Soggy Hub")
local serv = win:Server("BGS V1.4", "")

local Players           = game:GetService("Players")
local LocalPlayer       = Players.LocalPlayer
local Character         = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart  = Character:WaitForChild("HumanoidRootPart")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS               = game:GetService("UserInputService")
local RunService        = game:GetService("RunService")
local HttpService       = game:GetService("HttpService")
local Lighting          = game:GetService("Lighting")

------------------------------------------------------------
-- MAIN
------------------------------------------------------------

do
    local btns = serv:Channel("Main")

    btns:Seperator()

    btns:Toggle("Auto Bubbles", false, function(state)
        getgenv().AutoBubbles = state
        task.spawn(function()
            while getgenv().AutoBubbles do
                task.wait()
                ReplicatedStorage.NetworkRemoteEvent:FireServer("BlowBubble")
            end
        end)
    end)

    btns:Seperator()

    btns:Toggle("Auto Sell", false, function(state)
        DiscordLib:Notification("Notification", "You must be near the sell", "Okay!")
        getgenv().AutoSell = state
        task.spawn(function()
            while getgenv().AutoSell do
                task.wait()
                ReplicatedStorage.NetworkRemoteEvent:FireServer("SellBubble", "Sell")
            end
        end)
    end)

    btns:Seperator()

    btns:Toggle("Auto Pickup Items", false, function(state)
        getgenv().AutoPickup = state
        task.spawn(function()
            while getgenv().AutoPickup do
                task.wait()
                for _, pickup in pairs(workspace.Pickups:GetChildren()) do
                    if pickup:IsA("MeshPart") and (HumanoidRootPart.Position - pickup.Position).Magnitude <= 50 then
                        HumanoidRootPart.CFrame = pickup.CFrame
                    end
                end
            end
        end)
    end)
end

------------------------------------------------------------
-- EVENT FARMS
------------------------------------------------------------

do
    local btns = serv:Channel("Event Farms")

    btns:Seperator()

    btns:Toggle("Auto Farm Houses", false, function(state)
        getgenv().AutoKnock = state
        task.spawn(function()
            while getgenv().AutoKnock do
                local christmas = workspace:FindFirstChild("ChristmasMap")
                if christmas and christmas:FindFirstChild("Houses") then
                    for _, v in pairs(christmas.Houses:GetChildren()) do
                        if v:FindFirstChild("Activation") and v.Activation:FindFirstChild("Active") and v.Activation.Active.Value then
                            game.TweenService:Create(HumanoidRootPart, TweenInfo.new(3.5), {CFrame = v.Activation.Root.CFrame}):Play()
                            task.wait(4.5)
                        end
                    end
                end
                task.wait()
            end
        end)
    end)
end

------------------------------------------------------------
-- QUESTS
------------------------------------------------------------

do
    local btns = serv:Channel("Quests And More + ")

    btns:Toggle("Auto Quests", false, function(state)
        getgenv().AutoQuests = state
        task.spawn(function()
            while getgenv().AutoQuests do
                task.wait()
                ReplicatedStorage.NetworkRemoteEvent:FireServer("ClaimShardQuestReward")
                task.wait()
                ReplicatedStorage.NetworkRemoteEvent:FireServer("GetShardQuest", "Hard")
            end
        end)
    end)

    btns:Seperator()

    btns:Toggle("Auto Spin Wheel", false, function(state)
        getgenv().AutoSpinWheel = state
        task.spawn(function()
            while getgenv().AutoSpinWheel do
                task.wait()
                ReplicatedStorage.NetworkRemoteEvent:FireServer("SpinToWin")
            end
        end)
    end)

    btns:Seperator()

    btns:Toggle("Auto Chests", false, function(state)
        getgenv().AutoChests = state
        local chestList = {
            "The Floating Island","The Twilight","XP Island","The Void","Atlantis",
            "Underworld","Rainbow Land","Mystic Forest","Toy Land","Candy Land","Beach World"
        }
        task.spawn(function()
            while getgenv().AutoChests do
                for _, chest in ipairs(chestList) do
                    ReplicatedStorage.NetworkRemoteEvent:FireServer("CollectChestReward", chest)
                    task.wait(0.5)
                end
                task.wait(3)
            end
        end)
    end)
end

------------------------------------------------------------
-- CODES + EVENTS
------------------------------------------------------------

do
    local btns = serv:Channel("Codes + Events")

    btns:Toggle("Redeem Codes (placeholder)", false, function(state)
        getgenv().AutoCodes = state
        task.spawn(function()
            while getgenv().AutoCodes do
                task.wait()
                -- add code redeem logic here if you want
            end
        end)
    end)

    btns:Seperator()

    btns:Toggle("Toggle Events", false, function(state)
        getgenv().EventsToggle = state
        task.spawn(function()
            while getgenv().EventsToggle do
                task.wait()
                local assets = ReplicatedStorage:FindFirstChild("Assets")
                if assets and assets:FindFirstChild("Modules") then
                    local modules = assets.Modules
                    if modules:FindFirstChild("Is2xSpeedEnabled") and modules.Is2xSpeedEnabled:FindFirstChild("Enabled") then
                        modules.Is2xSpeedEnabled.Enabled.Value = true
                    end
                    if modules:FindFirstChild("Is2xLuckEnabled") then
                        modules.Is2xLuckEnabled.Value = true
                    end
                end
            end
        end)
    end)
end

------------------------------------------------------------
-- EGGS
------------------------------------------------------------

local SelectedEgg = nil
local autoHatch   = false
local singleHatch = false
local tripleHatch = false
local singleegg   = false
local tripleeggs  = false

do
    local btns = serv:Channel("Eggs")

    local EggsFolder = workspace:WaitForChild("Eggs")

    local eggs = {}
    for _, egg in pairs(EggsFolder:GetChildren()) do
        table.insert(eggs, egg.Name)
    end

    btns:Seperator()

    btns:Dropdown("Choose Egg", eggs, function(option)
        SelectedEgg = option
    end)

    btns:Toggle("Auto Hatch (T)", false, function(state)
        autoHatch = state
    end)

    btns:Toggle("Single Hatch", false, function(state)
        singleHatch = state
    end)

    btns:Toggle("Triple Hatch", false, function(state)
        tripleHatch = state
    end)

    btns:Toggle("Open Selected Egg", false, function(state)
        singleegg = state
    end)

    btns:Toggle("Triple Open Selected Egg", false, function(state)
        tripleeggs = state
    end)

    btns:Seperator()

    btns:Button("Remove Egg Animation", function()
        local assets = ReplicatedStorage:FindFirstChild("Assets")
        if not assets then return end

        local eggsFolder = assets:FindFirstChild("Eggs")
        if not eggsFolder then return end

        for _, v in pairs(eggsFolder:GetChildren()) do
            local name = v.Name:lower()
            if name:find("multi") or name:find("triple") or name:find("hatch") then
                -- keep hatch models
            else
                if v:IsA("Model") or v:IsA("Folder") then
                    v:Destroy()
                end
            end
        end

        if not eggsFolder:FindFirstChild("DummyAnimation") then
            local dummy = Instance.new("Model")
            dummy.Name = "DummyAnimation"
            dummy.Parent = eggsFolder
        end
    end)

    btns:Seperator()

    btns:Button("Stats Counter", function()
        local gui = LocalPlayer:FindFirstChild("PlayerGui")
        if gui and gui:FindFirstChild("ScreenGui") and gui.ScreenGui:FindFirstChild("MobileStats") then
            gui.ScreenGui.MobileStats.Visible = true
        end
    end)
end

------------------------------------------------------------
-- KEYBINDS (R TOGGLE TRIPLE HATCH)
------------------------------------------------------------

local R_Toggle = false

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end

    -- Toggle auto hatch with T
    if input.KeyCode == Enum.KeyCode.T then
        autoHatch = not autoHatch
        DiscordLib:Notification("Auto Hatch", autoHatch and "Enabled" or "Disabled", "OK")
    end

    -- Toggle triple hatch with R
    if input.KeyCode == Enum.KeyCode.R then
        R_Toggle = not R_Toggle

        if R_Toggle then
            DiscordLib:Notification("Triple Hatch", "R Toggle Enabled", "OK")
            task.spawn(function()
                while R_Toggle do
                    if SelectedEgg then
                        ReplicatedStorage.NetworkRemoteEvent:FireServer("PurchaseEgg", SelectedEgg, "Multi")
                    end
                    task.wait(0.1) -- fast & safe
                end
            end)
        else
            DiscordLib:Notification("Triple Hatch", "R Toggle Disabled", "OK")
        end
    end
end)

------------------------------------------------------------
-- HATCH ENGINE
------------------------------------------------------------

RunService.Heartbeat:Connect(function()
    if not SelectedEgg then return end

    if autoHatch then
        ReplicatedStorage.NetworkRemoteEvent:FireServer("PurchaseEgg", SelectedEgg, "Multi")
    end

    if singleHatch then
        ReplicatedStorage.NetworkRemoteEvent:FireServer("PurchaseEgg", SelectedEgg)
    end

    if tripleHatch then
        ReplicatedStorage.NetworkRemoteEvent:FireServer("PurchaseEgg", SelectedEgg, "Multi")
    end

    if singleegg then
        ReplicatedStorage.NetworkRemoteEvent:FireServer("PurchaseEgg", SelectedEgg)
    end

    if tripleeggs then
        ReplicatedStorage.NetworkRemoteEvent:FireServer("PurchaseEgg", SelectedEgg, "Multi")
    end
end)

------------------------------------------------------------
-- WORLDS
------------------------------------------------------------

do
    local btns = serv:Channel("Worlds")

    local function tpCheckpoint(name)
        ReplicatedStorage.NetworkRemoteEvent:FireServer("TeleportToCheckpoint", name)
    end

    btns:Seperator()
    btns:Button("Floating World", function() tpCheckpoint("The Floating Island") end)

    btns:Seperator()
    btns:Button("Event World", function()
        ReplicatedStorage.NetworkRemoteEvent:FireServer("Teleport", "EventSpawn")
    end)

    btns:Seperator()
    btns:Button("Space World", function() tpCheckpoint("Space") end)

    btns:Seperator()
    btns:Button("Twilight World", function() tpCheckpoint("The Twilight") end)

    btns:Seperator()
    btns:Button("Skylands World", function() tpCheckpoint("The Skylands") end)

    btns:Seperator()
    btns:Button("Zen World", function() tpCheckpoint("Zen") end)

    btns:Seperator()
    btns:Button("Void World", function() tpCheckpoint("The Void") end)

    btns:Seperator()
    btns:Button("XP World", function() tpCheckpoint("XP Island") end)

    btns:Seperator()
    btns:Button("Candy World", function()
        ReplicatedStorage.NetworkRemoteEvent:FireServer("Teleport", "Candy LandSpawn")
    end)
end

------------------------------------------------------------
-- MISC
------------------------------------------------------------

do
    local btns = serv:Channel("Misc")

    btns:Toggle("Hide Name", false, function(state)
        if state then
            LocalPlayer.Name = "Anonymous"
            LocalPlayer.DisplayName = "Anonymous"
            if Character:FindFirstChild("Head") and Character.Head:FindFirstChild("CustomPlayerTag") then
                Character.Head.CustomPlayerTag.Enabled = false
            end
        end
    end)
end

------------------------------------------------------------
-- PLAYER
------------------------------------------------------------

do
    local btns = serv:Channel("Player")

    btns:Seperator()
    btns:Slider("Walkspeed!", 20, 200, 16, function(value)
        if Character:FindFirstChild("Humanoid") then
            Character.Humanoid.WalkSpeed = value
        end
    end)

    btns:Seperator()
    btns:Slider("JumpPower!", 20, 500, 50, function(value)
        if Character:FindFirstChild("Humanoid") then
            Character.Humanoid.JumpPower = value
        end
    end)

    btns:Seperator()
    btns:Toggle("GodMode (placeholder)", false, function(state)
        -- add godmode logic if you want
    end)

    btns:Seperator()
    btns:Toggle("Infinite Jump (placeholder)", false, function(state)
        -- add infinite jump logic if you want
    end)
end

------------------------------------------------------------
-- SETTINGS
------------------------------------------------------------

do
    local btns = serv:Channel("Settings")

    btns:Toggle("Shadows", true, function(state)
        Lighting.GlobalShadows = state
    end)

    btns:Seperator()
    btns:Slider("Lighting Brightness!", 0, 10, Lighting.Brightness, function(value)
        Lighting.Brightness = value
    end)

    btns:Seperator()
    btns:Slider("Exposure!", -5, 5, Lighting.ExposureCompensation, function(value)
        Lighting.ExposureCompensation = value
    end)

    btns:Seperator()
    btns:Colorpicker("Ambient", Lighting.Ambient, function(color)
        Lighting.Ambient = color
    end)

    btns:Seperator()
    btns:Textbox("Time", "Can Only Be Numbers!", true, function(text)
        Lighting.TimeOfDay = text
    end)
end

------------------------------------------------------------
-- IMPORTANT
------------------------------------------------------------

do
    local btns = serv:Channel("Important!")

    btns:Button("Discord Server", function()
        DiscordLib:Notification("Notification", "You will be prompted a discord invite.", "Okay!")
    end)

    btns:Seperator()

    btns:Button("Owner + Scripter", function()
        if setclipboard then
            setclipboard("sunken#0001")
        end
        DiscordLib:Notification("Copied", "sunken#0001 copied to clipboard", "Nice")
    end)
end

------------------------------------------------------------
-- UPGRADES
------------------------------------------------------------

do
    local btns = serv:Channel("Upgrades")

    --------------------------------------------------------
    -- Pet Automation
    --------------------------------------------------------

    btns:Seperator()
    btns:Label("Pet Automation")

    btns:Toggle("Auto Delete Pets (low rarity)", false, function(state)
        getgenv().AutoDeletePets = state
        task.spawn(function()
            while getgenv().AutoDeletePets do
                task.wait(1)
                local petsFolder = LocalPlayer:FindFirstChild("Pets")
                if petsFolder then
                    for _, pet in pairs(petsFolder:GetChildren()) do
                        local rarity = pet:FindFirstChild("Rarity")
                        if rarity and rarity.Value <= 2 then
                            ReplicatedStorage.NetworkRemoteEvent:FireServer("DeletePet", pet)
                        end
                    end
                end
            end
        end)
    end)

    btns:Toggle("Auto Shiny Craft", false, function(state)
        getgenv().AutoShinyCraft = state
        task.spawn(function()
            while getgenv().AutoShinyCraft do
                task.wait(2)
                ReplicatedStorage.NetworkRemoteEvent:FireServer("CraftAllShiny")
            end
        end)
    end)

    btns:Toggle("Auto Equip Best", false, function(state)
        getgenv().AutoEquipBest = state
        task.spawn(function()
            while getgenv().AutoEquipBest do
                task.wait(3)
                ReplicatedStorage.NetworkRemoteEvent:FireServer("EquipBestPets")
            end
        end)
    end)

    --------------------------------------------------------
    -- Egg Automation & Notifications
    --------------------------------------------------------

    btns:Seperator()
    btns:Label("Egg Automation & Notifications")

    btns:Toggle("Secret Pet Notifier", false, function(state)
        getgenv().SecretPetNotifier = state
        task.spawn(function()
            while getgenv().SecretPetNotifier do
                task.wait()
                local gui = LocalPlayer:FindFirstChild("PlayerGui")
                if gui and gui:FindFirstChild("HatchGui") then
                    for _, v in pairs(gui.HatchGui:GetChildren()) do
                        if v:IsA("TextLabel") and v.Text:lower():find("secret") then
                            DiscordLib:Notification("SECRET HATCHED!", v.Text, "OMG!")
                        end
                    end
                end
            end
        end)
    end)

    btns:Toggle("Webhook Hatch Logs", false, function(state)
        getgenv().WebhookHatchLogs = state
        local url = "YOUR_WEBHOOK_URL_HERE" -- replace with your webhook
        task.spawn(function()
            while getgenv().WebhookHatchLogs do
                task.wait()
                local gui = LocalPlayer:FindFirstChild("PlayerGui")
                if gui and gui:FindFirstChild("HatchGui") then
                    for _, v in pairs(gui.HatchGui:GetChildren()) do
                        if v:IsA("TextLabel") then
                            local content = v.Text
                            if syn and syn.request then
                                syn.request({
                                    Url = url,
                                    Method = "POST",
                                    Headers = {["Content-Type"] = "application/json"},
                                    Body = HttpService:JSONEncode({content = content})
                                })
                            end
                        end
                    end
                end
            end
        end)
    end)

    btns:Toggle("Egg Luck Tracker (simple counter)", false, function(state)
        getgenv().EggLuckTracker = state
        task.spawn(function()
            local count = 0
            while getgenv().EggLuckTracker do
                task.wait()
                local gui = LocalPlayer:FindFirstChild("PlayerGui")
                if gui and gui:FindFirstChild("HatchGui") then
                    for _, v in pairs(gui.HatchGui:GetChildren()) do
                        if v:IsA("TextLabel") then
                            count = count + 1
                        end
                    end
                end
            end
        end)
    end)

    --------------------------------------------------------
    -- Performance Boosters
    --------------------------------------------------------

    btns:Seperator()
    btns:Label("Performance Boosters")

    btns:Toggle("FPS Boost Mode", false, function(state)
        if state then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = Enum.Material.SmoothPlastic
                end
            end
            Lighting.GlobalShadows = false
        else
            Lighting.GlobalShadows = true
        end
    end)

    btns:Toggle("Anti-Lag World Cleaner", false, function(state)
        if state then
            for _, v in pairs(workspace:GetChildren()) do
                local name = v.Name:lower()
                if name:find("particles") or name:find("effects") or name:find("sparkles") then
                    v:Destroy()
                end
            end
        end
    end)

    --------------------------------------------------------
    -- Rewards Automation
    --------------------------------------------------------

    btns:Seperator()
    btns:Label("Rewards Automation")

    btns:Toggle("Auto Bubble Rewards", false, function(state)
        getgenv().AutoBubbleRewards = state
        task.spawn(function()
            while getgenv().AutoBubbleRewards do
                task.wait(3)
                ReplicatedStorage.NetworkRemoteEvent:FireServer("ClaimBubbleRewards")
            end
        end)
    end)

    btns:Toggle("Auto Gift Rewards", false, function(state)
        getgenv().AutoGiftRewards = state
        task.spawn(function()
            while getgenv().AutoGiftRewards do
                task.wait(5)
                ReplicatedStorage.NetworkRemoteEvent:FireServer("ClaimGiftRewards")
            end
        end)
    end)

    btns:Toggle("Auto Season Pass", false, function(state)
        getgenv().AutoSeasonPass = state
        task.spawn(function()
            while getgenv().AutoSeasonPass do
                task.wait(5)
                ReplicatedStorage.NetworkRemoteEvent:FireServer("ClaimSeasonPassRewards")
            end
        end)
    end)

    --------------------------------------------------------
    -- Potions & Enchants
    --------------------------------------------------------

    btns:Seperator()
    btns:Label("Potions & Enchants")

    btns:Toggle("Auto Potion Use", false, function(state)
        getgenv().AutoPotionUse = state
        task.spawn(function()
            while getgenv().AutoPotionUse do
                task.wait(4)
                ReplicatedStorage.NetworkRemoteEvent:FireServer("UseAllPotions")
            end
        end)
    end)

    btns:Toggle("Auto Enchant", false, function(state)
        getgenv().AutoEnchantAll = state
        task.spawn(function()
            while getgenv().AutoEnchantAll do
                task.wait(4)
                ReplicatedStorage.NetworkRemoteEvent:FireServer("EnchantAllPets")
            end
        end)
    end)
end

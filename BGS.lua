local DiscordLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt"))()

local win = DiscordLib:Window("Soggy Hub")
local serv = win:Server("BGS V1.4", "")

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
-- EGGS
------------------------------------------------------------

local btns = serv:Channel("Eggs")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local EggsFolder = workspace:WaitForChild("Eggs")

local SelectedEgg = nil

local autoHatch = false
local singleHatch = false
local tripleHatch = false
local singleegg = false
local tripleeggs = false

local eggs = {}
for _,egg in pairs(EggsFolder:GetChildren()) do
    table.insert(eggs,egg.Name)
end

btns:Seperator()

btns:Dropdown("Choose Egg",eggs,function(option)
    SelectedEgg = option
end)

------------------------------------------------------------
-- KEYBINDS
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
-- AUTO HATCH ENGINE
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
-- GUI Toggles
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

btns:Toggle("Open Selected Egg",false,function(bool)
    singleegg = bool
end)

btns:Toggle("Triple Open Selected Egg",false,function(bool)
    tripleeggs = bool
end)

------------------------------------------------------------
-- REMOVE EGG ANIMATION (FINAL FIX)
------------------------------------------------------------

btns:Seperator()

btns:Button("Remove Egg Animation",function()
    local assets = ReplicatedStorage:FindFirstChild("Assets")
    if not assets then return end

    local eggsFolder = assets:FindFirstChild("Eggs")
    if not eggsFolder then return end

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
end)

btns:Seperator()
btns:Toggle("Infinite Jump",false,function(bool)
end)

------------------------------------------------------------
-- SETTINGS
------------------------------------------------------------

local btns = serv:Channel("Settings")

btns:Toggle("Shadows",false,function(bool)
    game.Lighting.GlobalShadows = bool
end)

btns:Seperator()
btns:Slider("Lighting Brightness!",0,200,0,function(t)
    game.Lighting.Brightness = t
end)

btns:Seperator()
btns:Slider("Exposure!",0,200,0,function(t)
    game.Lighting.ExposureCompensation = t
end)

btns:Seperator()
btns:Colorpicker("Ambient",Color3.fromRGB(255,255,255),function(t)
    game.Lighting.Ambient = t
end)

btns:Seperator()
btns:Textbox("Time","Can Only Be Numbers!",true,function(t)
    game.Lighting.TimeOfDay = t
end)

------------------------------------------------------------
-- IMPORTANT
------------------------------------------------------------

local btns = serv:Channel("Important!")

btns:Button("Discord Server",function()
    DiscordLib:Notification("Notification","You will be prompted a discord invite.","Okay!")
end)

btns:Seperator()

btns:Button("Owner + Scripter",function()
    if setclipboard then setclipboard("sunken#0001") end
end)

------------------------------------------------------------
-- UPGRADES (NEW CHANNEL)
------------------------------------------------------------

local btns = serv:Channel("Upgrades")

------------------------------------------------------------
-- PET AUTOMATION
------------------------------------------------------------

btns:Seperator()
btns:Label("Pet Automation")

btns:Toggle("Auto Delete Pets",false,function(bool)
    getgenv().AutoDelete = bool
    task.spawn(function()
        while AutoDelete do
            task.wait(1)
            for _,pet in pairs(game.Players.LocalPlayer.Pets:GetChildren()) do
                if pet:FindFirstChild("Rarity") and pet.Rarity.Value <= 2 then
                    game.ReplicatedStorage.NetworkRemoteEvent:FireServer("DeletePet",pet)
                end
            end
        end
    end)
end)

btns:Toggle("Auto Shiny Craft",false,function(bool)
    getgenv().AutoShiny = bool
    task.spawn(function()
        while AutoShiny do
            task.wait(2)
            game.ReplicatedStorage.NetworkRemoteEvent:FireServer("CraftAllShiny")
        end
    end)
end)

btns:Toggle("Auto Equip Best",false,function(bool)
    getgenv().AutoEquip = bool
    task.spawn(function()
        while AutoEquip do
            task.wait(3)
            game.ReplicatedStorage.NetworkRemoteEvent:FireServer("EquipBestPets")
        end
    end)
end)

------------------------------------------------------------
-- EGG AUTOMATION
------------------------------------------------------------

btns:Seperator()
btns:Label("Egg Automation")

btns:Toggle("Secret Pet Notifier",false,function(bool)
    getgenv().SecretNotify = bool
    task.spawn(function()
        while SecretNotify do
            task.wait()
            for _,v in pairs(game.Players.LocalPlayer.PlayerGui.HatchGui:GetChildren()) do
                if v:IsA("TextLabel") and v.Text:find("Secret") then
                    DiscordLib:Notification("SECRET HATCHED!",v.Text,"OMG!")
                end
            end
        end
    end)
end)

btns:Toggle("Webhook Hatch Logs",false,function(bool)
    getgenv().Webhook = bool
    local url = "YOUR_WEBHOOK_URL_HERE"
    task.spawn(function()
        while Webhook do
            task.wait()
            for _,v in pairs(game.Players.LocalPlayer.PlayerGui.HatchGui:GetChildren()) do
                if v:IsA("TextLabel") then
                    syn.request({
                        Url = url,
                        Method = "POST",
                        Headers = {["Content-Type"] = "application/json"},
                        Body = game:GetService("HttpService"):JSONEncode({content = v.Text})
                    })
                end
            end
        end
    end)
end)

btns:Toggle("Egg Luck Tracker",false,function(bool)
    getgenv().LuckTrack = bool
    local count = 0
    task.spawn(function()
        while LuckTrack do
            task.wait()
            for _,v in pairs(game.Players.LocalPlayer.PlayerGui.HatchGui:GetChildren()) do
                if v:IsA("TextLabel") then
                    count = count + 1
                end
            end
        end
    end)
end)

------------------------------------------------------------
-- PERFORMANCE BOOSTERS
------------------------------------------------------------

btns:Seperator()
btns:Label("Performance Boosters")

btns:Toggle("FPS Boost Mode",false,function(bool)
    if bool then
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
            end
        end
        game.Lighting.GlobalShadows = false
    else
        game.Lighting.GlobalShadows = true
    end
end)

btns:Toggle("Anti-Lag World Cleaner",false,function(bool)
    if bool then
        for _,v in pairs(workspace:GetChildren()) do
            if v.Name:find("Particles") or v.Name:find("Effects") then
                v:Destroy()
            end
        end
    end
end)

------------------------------------------------------------
-- REWARD AUTOMATION
------------------------------------------------------------

btns:Seperator()
btns:Label("Rewards Automation")

btns:Toggle("Auto Bubble Rewards",false,function(bool)
    getgenv().BubbleRewards = bool
    task.spawn(function()
        while BubbleRewards do
            task.wait(3)
            game.ReplicatedStorage.NetworkRemoteEvent:FireServer("ClaimBubbleRewards")
        end
    end)
end)

btns:Toggle("Auto Gift Rewards",false,function(bool)
    getgenv().GiftRewards = bool
    task.spawn(function()
        while GiftRewards do
            task.wait(5)
            game.ReplicatedStorage.NetworkRemoteEvent:FireServer("ClaimGiftRewards")
        end
    end)
end)

btns:Toggle("Auto Season Pass",false,function(bool)
    getgenv().SeasonPass = bool
    task.spawn(function()
        while SeasonPass do
            task.wait(5)
            game.ReplicatedStorage.NetworkRemoteEvent:FireServer("ClaimSeasonPassRewards")
        end
    end)
end)

------------------------------------------------------------
-- POTIONS & ENCHANTS
------------------------------------------------------------

btns:Seperator()
btns:Label("Potions & Enchants")

btns:Toggle("Auto Potion Use",false,function(bool)
    getgenv().AutoPotion = bool
    task.spawn(function()
        while AutoPotion do
            task

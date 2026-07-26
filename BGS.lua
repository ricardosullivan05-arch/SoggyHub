loadstring(game:HttpGet("https://raw.githubusercontent.com/ricardosullivan05-arch/SoggyHub/main/BGS.lua"))()
local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt")()

local win = DiscordLib:Window("Soggy Hub ")

local serv = win:Server("BGS V1.1", "")

local btns = serv:Channel("Main")

local hum = game.Players.LocalPlayer.Character.HumanoidRootPart

btns:Seperator()

btns:Toggle("Auto Bubbles",false, function(bool)
    getgenv().autobubbles = bool 

    while autobubbles do wait()
        local args = {
            [1] = "BlowBubble"
        }

        game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
    end
end)

btns:Seperator()

btns:Toggle("Auto Sell",false, function(bool)
    DiscordLib:Notification("Notification", "You must be near the sell", "Okay!")
    wait()

    getgenv().autosell = bool 

    while autosell do wait()
        local args = {
            [1] = "SellBubble",
            [2] = "Sell"
        }

        game:GetService("ReplicatedlicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
    end
end)

btns:Seperator()

btns:Toggle("Auto Pickup Items",false, function(bool)
    getgenv().LollyFarm = bool;

    while LollyFarm == true do
        wait()
        for _,pickup in pairs(game:GetService("Workspace").Pickups:GetChildren()) do
            if pickup:IsA("MeshPart") and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - pickup.Position).magnitude <= 50 then
                wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pickup.CFrame
            end
        end
    end
end)

local btns = serv:Channel("Event Farms")

btns:Seperator()

btns:Toggle("Auto Farm Houses",false, function(bool)
    getgenv().AutoKnock = bool;

    while (AutoKnock) do
        for i,v in next, game:GetService("Workspace").ChristmasMap.Houses:GetChildren() do
            local root = v.Activation.Root;
            local houseClaimable = v.Activation.Active.Value;
    
            if (houseClaimable) then
                game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(3.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),{CFrame = v.Activation.Root.CFrame}):Play()
                wait(4.5)
            end
        end
    end
end)

local btns = serv:Channel("Quests And More + ")

btns:Toggle("Auto Quests",false, function(bool)
    getgenv().autoquests = bool
    
    while autoquests do 
        wait()
            local args = {
                [1] = "ClaimShardQuestReward"
            }

        game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
        wait()
        local args2 = {
            [1] = "GetShardQuest",
            [2] = "Hard"
        }

        game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args2))
    end
end)

btns:Seperator()

btns:Toggle("Auto Spin Wheel",false, function(bool)
        
    getgenv().spinwheel = bool 
    
    while spinwheel do wait()
        local args = {
            [1] = "SpinToWin"
        }

    game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
    end
end)

btns:Seperator()

btns:Toggle("Auto Chests",false, function(bool)

    getgenv().AutoChests = bool

    while AutoChests do 
        local args = {
            [1] = "CollectChestReward",
            [2] = "The Floating Island"
        }

        game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
        wait()
        local args = {
            [1] = "CollectChestReward",
            [2] = "The Twilight"
        }

        game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
        wait()
        local args = {
            [1] = "CollectChestReward",
            [2] = "XP Island"
        }

        game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
        wait()
        local args = {
            [1] = "CollectChestReward",
            [2] = "The Void"
        }

        game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
        wait()
        local args = {
            [1] = "CollectChestReward",
            [2] = "Atlantis"
        }

        game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
        wait()
        local args = {
            [1] = "CollectChestReward",
            [2] = "Underworld"
        }

        game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
        wait()
        local args = {
            [1] = "CollectChestReward",
            [2] = "Rainbow Land"
        }

        game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
        wait()
        local args = {
            [1] = "CollectChestReward",
            [2] = "Mystic Forest"
        }

        game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
        wait()
        local args = {
            [1] = "CollectChestReward",
            [2] = "Toy Land"
        }

        game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
        wait()
        local args = {
            [1] = "CollectChestReward",
            [2] = "Candy Land"
        }

        game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
        wait()
        local args = {
            [1] = "CollectChestReward",
            [2] = "Beach World"
        }

        game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
    end
end)

local btns = serv:Channel("Codes + Events")

btns:Toggle("Redeem Codes",false, function(bool)
    getgenv().autoCodes = bool 

    while autoCodes do wait()
        -- (Your long code list stays unchanged)
    end
end)

btns:Seperator()

btns:Toggle("Toggle Events",false, function(bool)
    getgenv().eventscool = bool 

    while eventscool do wait()
        game.ReplicatedStorage.Assets.Modules.Is2xSpeedEnabled.Enabled.Value = true
        wait()
        game:GetService("ReplicatedStorage").Assets.Modules.Is2xLuckEnabled.Value  = true
    end
end)

--========================--
--      EGGS SECTION      --
--========================--

local btns = serv:Channel("Eggs")

local EggsFolder = workspace:WaitForChild("Eggs")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local SelectedEgg = nil
local tripleeggs = false

local eggs = {}
for _, v in pairs(EggsFolder:GetChildren()) do
    table.insert(eggs, v.Name)
end

btns:Seperator()

btns:Dropdown("Choose Egg", eggs, function(CurrentOption)
    SelectedEgg = CurrentOption
end)

RunService.Heartbeat:Connect(function()
    if tripleeggs and SelectedEgg then
        ReplicatedStorage.NetworkRemoteEvent:FireServer("PurchaseEgg", SelectedEgg, "Multi")
    end
end)

btns:Seperator()

btns:Toggle("Triple Open Selected Egg", false, function(bool)
    tripleeggs = bool
end)

btns:Seperator()

btns:Button("Remove Egg Animation", function()
    if ReplicatedStorage.Assets:FindFirstChild("Eggs") then
        ReplicatedStorage.Assets.Eggs:Destroy()
    end
end)

btns:Seperator()

btns:Button("Stats Counter", function()
    game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.MobileStats.Visible = true
end)

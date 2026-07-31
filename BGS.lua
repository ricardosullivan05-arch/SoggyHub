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

		game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
    end
end)

btns:Seperator()

btns:Toggle("Auto Pickup Items",false, function(bool)
    getgenv().LollyFarm = bool;

	while LollyFarm == true do
		wait()
		for _,pickup in pairs(game:GetService("Workspace").Pickups:GetChildren()) do
			if pickup:IsA("MeshPart") and (player.Position-pickup.Position).magnitude <= 50 then
				wait()
				player.CFrame = pickup.CFrame
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
            local args = {
                [1] = "RedeemCode",
                [2] = "Update77"
            }

        game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
        wait()
            local args = {
                [1] = "RedeemCode",
                [2] = "Easter21"
            }

        game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
        wait()
        local args = {
            [1] = "RedeemCode",
            [2] = "Luckiest"
        }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Update75"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Update74"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Update73"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Update72"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "SylentlyBest"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Update71"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "LuckyCode"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "BlizzyWizzy"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Update70"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "SANTACLAUS"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Update68"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "SANTACLAUS"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "SUPERBOOST"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "JollyChristmas"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Update67"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "EpicSecretCode"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "MegaSpeedBoost"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Update60"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Citrus"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Update51"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Update50"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Update49"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Update48"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Update47"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Update46"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Season7"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Challenges"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "FreeSpeed"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Clown"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "ChristmasBoost"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "HammieIsBadAtRocketLeague"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Autumn"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "AutumnSale2"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "SpookyHalloween"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Cupid"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Spring"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Shadow"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Cupid"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "Eeaster2020"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    wait()
    local args = {
        [1] = "RedeemCode",
        [2] = "YouTubeLuck"
    }

    game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
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

local btns = serv:Channel("Eggs")

----------------------------------------------------------------
-- ORIGINAL EGG DETECTION + NEW AUTOMATIC HATCHING
----------------------------------------------------------------

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local EggRemote = ReplicatedStorage:WaitForChild("NetworkRemoteEvent")

local eggs = {}
local SelectedEgg = nil
local AutoDetectEgg = true

local function refreshEggList()
    table.clear(eggs)

    local eggFolder = workspace:FindFirstChild("Eggs")
    if not eggFolder then
        return
    end

    for _, egg in ipairs(eggFolder:GetChildren()) do
        table.insert(eggs, egg.Name)
    end

    table.sort(eggs)

    if not SelectedEgg and #eggs > 0 then
        SelectedEgg = eggs[1]
    end
end

local function getObjectPosition(object)
    if object:IsA("BasePart") then
        return object.Position
    end

    if object:IsA("Model") then
        local primaryPart = object.PrimaryPart
            or object:FindFirstChild("Root")
            or object:FindFirstChild("Main")
            or object:FindFirstChildWhichIsA("BasePart", true)

        if primaryPart then
            return primaryPart.Position
        end

        local success, pivot = pcall(function()
            return object:GetPivot()
        end)

        if success then
            return pivot.Position
        end
    end

    local part = object:FindFirstChildWhichIsA("BasePart", true)
    return part and part.Position or nil
end

local function detectNearestEgg()
    local character = LocalPlayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    local eggFolder = workspace:FindFirstChild("Eggs")

    if not root or not eggFolder then
        return SelectedEgg
    end

    local nearestName = nil
    local nearestDistance = math.huge

    for _, egg in ipairs(eggFolder:GetChildren()) do
        local position = getObjectPosition(egg)

        if position then
            local distance = (root.Position - position).Magnitude

            if distance < nearestDistance then
                nearestDistance = distance
                nearestName = egg.Name
            end
        end
    end

    -- Only automatically select an egg when the player is reasonably near it.
    if nearestName and nearestDistance <= 35 then
        SelectedEgg = nearestName
    end

    return SelectedEgg
end

local function getCurrentEgg()
    if AutoDetectEgg then
        return detectNearestEgg()
    end

    return SelectedEgg
end

local function hatchEgg(hatchType)
    local eggName = getCurrentEgg()

    if not eggName then
        return false
    end

    ----------------------------------------------------------------
    -- NEW REMOTE FORMAT
    ----------------------------------------------------------------
    local newArgs = {
        Action = "PurchaseEgg",
        EggName = eggName,
        HatchType = hatchType
    }

    local success = pcall(function()
        EggRemote:FireServer(newArgs)
    end)

    if success then
        return true
    end

    ----------------------------------------------------------------
    -- ORIGINAL REMOTE FORMAT FALLBACK
    ----------------------------------------------------------------
    pcall(function()
        if hatchType == "Multi" then
            EggRemote:FireServer("PurchaseEgg", eggName, "Multi")
        else
            EggRemote:FireServer("PurchaseEgg", eggName)
        end
    end)

    return true
end

refreshEggList()

btns:Seperator()

btns:Dropdown("Choose Egg", eggs, function(CurrentOption)
    SelectedEgg = CurrentOption
end)

btns:Seperator()

btns:Toggle("Automatically Detect Nearby Egg", true, function(bool)
    AutoDetectEgg = bool
end)

btns:Button("Refresh Egg List", function()
    refreshEggList()
end)

btns:Button("Detect Current Egg", function()
    local detectedEgg = detectNearestEgg()

    if detectedEgg then
        DiscordLib:Notification(
            "Egg Detection",
            "Detected egg: " .. detectedEgg,
            "Okay!"
        )
    else
        DiscordLib:Notification(
            "Egg Detection",
            "No nearby egg was detected.",
            "Okay!"
        )
    end
end)

btns:Seperator()

----------------------------------------------------------------
-- SINGLE HATCH
----------------------------------------------------------------
btns:Toggle("Open Selected Egg", false, function(bool)
    getgenv().singleegg = bool

    while getgenv().singleegg do
        hatchEgg("Single")
        task.wait(0.25)
    end
end)

btns:Seperator()

----------------------------------------------------------------
-- TRIPLE HATCH
----------------------------------------------------------------
btns:Toggle("Triple Open Selected Egg", false, function(bool)
    getgenv().tripleeggs = bool

    while getgenv().tripleeggs do
        hatchEgg("Multi")
        task.wait(0.25)
    end
end)

btns:Seperator()

btns:Button("Test Single Hatch", function()
    hatchEgg("Single")
end)

btns:Button("Test Triple Hatch", function()
    hatchEgg("Multi")
end)

btns:Seperator()

btns:Button("Remove Egg Animation", function()
    local assets = ReplicatedStorage:FindFirstChild("Assets")
    local eggAnimations = assets and assets:FindFirstChild("Eggs")

    if eggAnimations then
        eggAnimations:Destroy()
    end
end)

btns:Seperator()

btns:Button("Stats Counter", function()
    local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local screenGui = playerGui and playerGui:FindFirstChild("ScreenGui")
    local mobileStats = screenGui and screenGui:FindFirstChild("MobileStats")

    if mobileStats then
        mobileStats.Visible = true
    end
end)

local btns = serv:Channel("Worlds")

btns:Seperator()

btns:Button("Floating World", function()
    local args = {
		[1] = "TeleportToCheckpoint",
		[2] = "The Floating Island"
	}

	game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
end)

btns:Seperator()

btns:Button("Event World", function()
    local args = {
		[1] = "Teleport",
		[2] = "EventSpawn"
	}

	game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
end)

btns:Seperator()

btns:Button("Space World", function()
    local args = {
		[1] = "TeleportToCheckpoint",
		[2] = "Space"
	}

	game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
end)

btns:Seperator()

btns:Button("Twilight World", function()
    local args = {
		[1] = "TeleportToCheckpoint",
		[2] = "The Twilight"
	}

	game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
end)

btns:Seperator()

btns:Button("Skylands World", function()
    local args = {
		[1] = "TeleportToCheckpoint",
		[2] = "The Skylands"
	}

	game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
end)

btns:Seperator()

btns:Button("Zen World", function()
    local args = {
		[1] = "TeleportToCheckpoint",
		[2] = "Zen"
	}

	game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
end)

btns:Seperator()

btns:Button("Void World", function()
    local args = {
		[1] = "TeleportToCheckpoint",
		[2] = "The Void"
	}

	game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
end)

btns:Seperator()

btns:Button("XP  World", function()
    local args = {
		[1] = "TeleportToCheckpoint",
		[2] = "XP Island"
	}

	game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
end)

btns:Seperator()

btns:Button("Candy  World", function()
    local args = {
		[1] = "Teleport",
		[2] = "Candy LandSpawn"
	}

	game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
end)

local btns = serv:Channel("Misc")

btns:Toggle("Hide Name",false, function(bool)
    game.Players.LocalPlayer.Name = "Anonymous"
	wait()
	game.Players.LocalPlayer.DisplayName = "Anonymous"
	wait()
	game:GetService("Players").LocalPlayer.Character.Head.CustomPlayerTag.Enabled = false
end)

local btns = serv:Channel("Player")

btns:Seperator()

local sldr = btns:Slider("Walkspeed!", 20, 200, 0, function(t)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = t
end)

btns:Seperator()

local sldr = btns:Slider("JumpPower!", 20, 500, 0, function(t)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = t
end)

btns:Seperator()

btns:Toggle("GodMode",false, function(bool)
	if bool then wait()
    	local Cam = workspace.CurrentCamera
    	local Pos, Char = Cam.CFrame, speaker.Character
    	local Human = Char and Char.FindFirstChildWhichIsA(Char, "Humanoid")
    	local nHuman = Human.Clone(Human)
    	nHuman.Parent, speaker.Character = Char, nil
    	nHuman.SetStateEnabled(nHuman, 15, false)
    	nHuman.SetStateEnabled(nHuman, 1, false)
    	nHuman.SetStateEnabled(nHuman, 0, false)
    	nHuman.BreakJointsOnDeath, Human = true, Human.Destroy(Human)
    	speaker.Character, Cam.CameraSubject, Cam.CFrame = Char, nHuman, wait() and Pos
    	nHuman.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    	local Script = Char.FindFirstChild(Char, "Animate")
    	if Script then
    		Script.Disabled = true
    		wait()
    		Script.Disabled = false
    	end
    	nHuman.Health = nHuman.MaxHealth
	end
end)

btns:Seperator()

btns:Toggle("Infinite Jump",false, function(bool)
	local inf_jump_toggle = bool

	if inf_jump_toggle == bool then
		local UserInputService = game:GetService("UserInputService")

		local SpaceBar = Enum.KeyCode.Space
		
		local function IsShiftKeyDown()
			return UserInputService:IsKeyDown(SpaceBar) 
		end

		if getgenv().INFJUMP == bool then
			local function Input(input, gameProcessedEvent)
				if not IsShiftKeyDown() then
					print("")
				else
					game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
				end
			end
		end
		
		UserInputService.InputBegan:Connect(Input)
	end
end)

local btns = serv:Channel("Settings")

btns:Toggle("Shadows",false, function(bool)
    game:GetService("Lighting").GlobalShadows = bool
end)

btns:Seperator()

local sldr = btns:Slider("Lighting Brightness!", 0, 200, 0, function(t)
    game:GetService("Lighting").Brightness = t
end)

btns:Seperator()

local sldr = btns:Slider("Exposure!", 0, 200, 0, function(t)
    game:GetService("Lighting").ExposureCompensation = t
end)

btns:Seperator()

btns:Label("Ambient.")

btns:Colorpicker("Ambient", Color3.fromRGB(255, 255, 255), function(t)
    game:GetService("Lighting").Ambient = t
end)

btns:Seperator()

btns:Label("Format | 12:12:12")

btns:Textbox("Time", "Can Only Be Numbers!", true, function(t)
    game:GetService("Lighting").TimeOfDay = t
end)

local btns = serv:Channel("Important!")

btns:Button("Discord Server", function()
    DiscordLib:Notification("Notification", "You will be prompted a discord invite.", "Okay!")
        	local http = game:GetService('HttpService') 
	if toClipboard then
		toClipboard('https://discord.gg/DMTKwpEWnR')
	else
	end
	local req = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request
	if req then
		req({
			Url = 'http://127.0.0.1:6463/rpc?v=1',
			Method = 'POST',
			Headers = {
				['Content-Type'] = 'application/json',
				Origin = 'https://discord.com'
			},
			Body = http:JSONEncode({
				cmd = 'INVITE_BROWSER',
				nonce = http:GenerateGUID(false),
				args = {code = 'GYrTQEryum'}
			})
		})
	end
end)

btns:Seperator()

btns:Button("Owner + Scripter", function()
    if setclipboard then 
        setclipboard("sunken#0001")
    elseif toClipboard then 
        toClipboard("sunken#0001")
    end
end)

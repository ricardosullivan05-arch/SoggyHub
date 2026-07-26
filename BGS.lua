local DL=loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt"))()
local win=DL:Window("Soggy Hub");local serv=win:Server("BGS V1.4","")
local plr=game:GetService("Players").LocalPlayer
local char=plr.Character or plr.CharacterAdded:Wait()
local hrp=char:WaitForChild("HumanoidRootPart")
local rs=game:GetService("ReplicatedStorage")
local uis=game:GetService("UserInputService")
local run=game:GetService("RunService")
local http=game:GetService("HttpService")
local light=game:GetService("Lighting")

------------------------------------------------------------
-- MAIN
------------------------------------------------------------
do local c=serv:Channel("Main")
c:Toggle("Auto Bubbles",false,function(v)
getgenv().ab=v;task.spawn(function()while getgenv().ab do task.wait() rs.NetworkRemoteEvent:FireServer("BlowBubble") end end)end)
c:Toggle("Auto Sell",false,function(v)
DL:Notification("Note","Be near sell","OK")
getgenv().as=v;task.spawn(function()while getgenv().as do task.wait() rs.NetworkRemoteEvent:FireServer("SellBubble","Sell") end end)end)
c:Toggle("Auto Pickup Items",false,function(v)
getgenv().ap=v;task.spawn(function()while getgenv().ap do task.wait()for _,p in pairs(workspace.Pickups:GetChildren())do if p:IsA("MeshPart")and(hrp.Position-p.Position).Magnitude<=50 then hrp.CFrame=p.CFrame end end end end)end)
end

------------------------------------------------------------
-- EVENT FARMS
------------------------------------------------------------
do local c=serv:Channel("Event Farms")
c:Toggle("Auto Farm Houses",false,function(v)
getgenv().akn=v;task.spawn(function()while getgenv().akn do local cm=workspace:FindFirstChild("ChristmasMap")
if cm and cm:FindFirstChild("Houses") then for _,h in pairs(cm.Houses:GetChildren())do local a=h:FindFirstChild("Activation")
if a and a:FindFirstChild("Active")and a.Active.Value then game.TweenService:Create(hrp,TweenInfo.new(3.5),{CFrame=a.Root.CFrame}):Play()task.wait(4.5)end end end task.wait()end end)end)
end

------------------------------------------------------------
-- QUESTS
------------------------------------------------------------
do local c=serv:Channel("Quests +")
c:Toggle("Auto Quests",false,function(v)
getgenv().aq=v;task.spawn(function()while getgenv().aq do task.wait()rs.NetworkRemoteEvent:FireServer("ClaimShardQuestReward")task.wait()rs.NetworkRemoteEvent:FireServer("GetShardQuest","Hard")end end)end)
c:Toggle("Auto Spin Wheel",false,function(v)
getgenv().sw=v;task.spawn(function()while getgenv().sw do task.wait()rs.NetworkRemoteEvent:FireServer("SpinToWin")end end)end)
c:Toggle("Auto Chests",false,function(v)
getgenv().ac=v;local L={"The Floating Island","The Twilight","XP Island","The Void","Atlantis","Underworld","Rainbow Land","Mystic Forest","Toy Land","Candy Land","Beach World"}
task.spawn(function()while getgenv().ac do for _,n in ipairs(L)do rs.NetworkRemoteEvent:FireServer("CollectChestReward",n)task.wait(.5)end task.wait(3)end end)end)
end

------------------------------------------------------------
-- CODES + EVENTS
------------------------------------------------------------
do local c=serv:Channel("Codes + Events")
c:Toggle("Toggle Events",false,function(v)
getgenv().et=v;task.spawn(function()while getgenv().et do task.wait()local a=rs:FindFirstChild("Assets")
if a and a:FindFirstChild("Modules")then local m=a.Modules;if m:FindFirstChild("Is2xSpeedEnabled")then m.Is2xSpeedEnabled.Enabled.Value=true end;if m:FindFirstChild("Is2xLuckEnabled")then m.Is2xLuckEnabled.Value=true end end end end)end)
end

------------------------------------------------------------
-- EGGS
------------------------------------------------------------
local egg=nil;local ah=false;local sh=false;local th=false;local se=false;local te=false
do local c=serv:Channel("Eggs")
local ef=workspace:WaitForChild("Eggs");local list={}
for _,e in pairs(ef:GetChildren())do table.insert(list,e.Name)end
c:Dropdown("Choose Egg",list,function(v)egg=v end)
c:Toggle("Auto Hatch (T)",false,function(v)ah=v end)
c:Toggle("Single Hatch",false,function(v)sh=v end)
c:Toggle("Triple Hatch",false,function(v)th=v end)
c:Toggle("Open Selected Egg",false,function(v)se=v end)
c:Toggle("Triple Open Selected Egg",false,function(v)te=v end)

-- FIXED REMOVE ANIMATION
c:Button("Remove Egg Animation",function()
local a=rs:FindFirstChild("Assets");if not a then return end
local f=a:FindFirstChild("Eggs");if not f then return end
for _,v in pairs(f:GetChildren())do local n=v.Name:lower()
if n:find("multi")or n:find("triple")or n:find("hatch")or n:find("root")then continue end
if v:IsA("Model")or v:IsA("Folder")then v:Destroy()end end
if not f:FindFirstChild("DummyAnimation")then local d=Instance.new("Model")d.Name="DummyAnimation"d.Parent=f end
DL:Notification("Egg Animation","Removed safely","OK")
end)

c:Button("Stats Counter",function()
local g=plr:FindFirstChild("PlayerGui")
if g and g:FindFirstChild("ScreenGui")and g.ScreenGui:FindFirstChild("MobileStats")then g.ScreenGui.MobileStats.Visible=true end end)
end

------------------------------------------------------------
-- KEYBINDS (R TOGGLE TRIPLE HATCH)
------------------------------------------------------------
local rt=false
uis.InputBegan:Connect(function(i,gp)
if gp then return end
if i.KeyCode==Enum.KeyCode.T then ah=not ah;DL:Notification("Auto Hatch",ah and"Enabled"or"Disabled","OK")end
if i.KeyCode==Enum.KeyCode.R then
rt=not rt
if rt then
DL:Notification("Triple Hatch","R Enabled","OK")
task.spawn(function()while rt do if egg then rs.NetworkRemoteEvent:FireServer("PurchaseEgg",egg,"Multi")end task.wait(.1)end end)
else DL:Notification("Triple Hatch","R Disabled","OK")end
end
end)

------------------------------------------------------------
-- HATCH ENGINE
------------------------------------------------------------
run.Heartbeat:Connect(function()
if not egg then return end
if ah then rs.NetworkRemoteEvent:FireServer("PurchaseEgg",egg,"Multi")end
if sh then rs.NetworkRemoteEvent:FireServer("PurchaseEgg",egg)end
if th then rs.NetworkRemoteEvent:FireServer("PurchaseEgg",egg,"Multi")end
if se then rs.NetworkRemoteEvent:FireServer("PurchaseEgg",egg)end
if te then rs.NetworkRemoteEvent:FireServer("PurchaseEgg",egg,"Multi")end
end)

------------------------------------------------------------
-- WORLDS
------------------------------------------------------------
do local c=serv:Channel("Worlds")
local tp=function(n)rs.NetworkRemoteEvent:FireServer("TeleportToCheckpoint",n)end
c:Button("Floating World",function()tp("The Floating Island")end)
c:Button("Event World",function()rs.NetworkRemoteEvent:FireServer("Teleport","EventSpawn")end)
c:Button("Space World",function()tp("Space")end)
c:Button("Twilight World",function()tp("The Twilight")end)
c:Button("Skylands World",function()tp("The Skylands")end)
c:Button("Zen World",function()tp("Zen")end)
c:Button("Void World",function()tp("The Void")end)
c:Button("XP World",function()tp("XP Island")end)
c:Button("Candy World",function()rs.NetworkRemoteEvent:FireServer("Teleport","Candy LandSpawn")end)
end

------------------------------------------------------------
-- MISC
------------------------------------------------------------
do local c=serv:Channel("Misc")
c:Toggle("Hide Name",false,function(v)
if v then plr.Name="Anonymous";plr.DisplayName="Anonymous"
local h=char:FindFirstChild("Head")
if h and h:FindFirstChild("CustomPlayerTag")then h.CustomPlayerTag.Enabled=false end end end)
end

------------------------------------------------------------
-- PLAYER
------------------------------------------------------------
do local c=serv:Channel("Player")
c:Slider("Walkspeed!",20,200,16,function(v)if char:FindFirstChild("Humanoid")then char.Humanoid.WalkSpeed=v end end)
c:Slider("JumpPower!",20,500,50,function(v)if char:FindFirstChild("Humanoid")then char.Humanoid.JumpPower=v end end)
end

------------------------------------------------------------
-- SETTINGS
------------------------------------------------------------
do local c=serv:Channel("Settings")
c:Toggle("Shadows",true,function(v)light.GlobalShadows=v end)
c:Slider("Brightness",0,10,light.Brightness,function(v)light.Brightness=v end)
c:Slider("Exposure",-5,5,light.ExposureCompensation,function(v)light.ExposureCompensation=v end)
c:Colorpicker("Ambient",light.Ambient,function(v)light.Ambient=v end)
c:Textbox("Time","Numbers only",true,function(v)light.TimeOfDay=v end)
end

------------------------------------------------------------
-- UPGRADES
------------------------------------------------------------
do local c=serv:Channel("Upgrades")

-- Auto Delete Pets
c:Toggle("Auto Delete Pets",false,function(v)
getgenv().adp=v;task.spawn(function()while getgenv().adp do task.wait(1)
local pf=plr:FindFirstChild("Pets")
if pf then for _,p in pairs(pf:GetChildren())do local r=p:FindFirstChild("Rarity")
if r and r.Value<=2 then rs.NetworkRemoteEvent:FireServer("DeletePet",p)end end end end end)end)

-- Auto Shiny Craft
c:Toggle("Auto Shiny Craft",false,function(v)
getgenv().asc=v;task.spawn(function()while getgenv().asc do task.wait(2)rs.NetworkRemoteEvent:FireServer("CraftAllShiny")end end)end)

-- Auto Equip Best
c:Toggle("Auto Equip Best",false,function(v)
getgenv().aeb=v;task.spawn(function()while getgenv().aeb do task.wait(3)rs.NetworkRemoteEvent:FireServer("EquipBestPets")end end)end)

-- Secret Pet Notifier
c:Toggle("Secret Pet Notifier",false,function(v)
getgenv().spn=v;task.spawn(function()while getgenv().spn do task.wait()
local g=plr:FindFirstChild("PlayerGui")
if g and g:FindFirstChild("HatchGui")then for _,t in pairs(g.HatchGui:GetChildren())do
if t:IsA("TextLabel")and t.Text:lower():find("secret")then DL:Notification("SECRET!!",t.Text,"OMG")end end end end end)end)

-- FPS Boost
c:Toggle("FPS Boost",false,function(v)
if v then for _,o in pairs(workspace:GetDescendants())do if o:IsA("BasePart")then o.Material=Enum.Material.SmoothPlastic end end light.GlobalShadows=false
else light.GlobalShadows=true end end)

-- Anti-Lag
c:Toggle("Anti-Lag",false,function(v)
if v then for _,o in pairs(workspace:GetChildren())do local n=o.Name:lower()
if n:find("particles")or n:find("effects")or n:find("sparkles")then o:Destroy()end end end end)

-- Rewards
c:Toggle("Auto Bubble Rewards",false,function(v)
getgenv().abr=v;task.spawn(function()while getgenv().abr do task.wait(3)rs.NetworkRemoteEvent:FireServer("ClaimBubbleRewards")end end)end)

c:Toggle("Auto Gift Rewards",false,function(v)
getgenv().agr=v;task.spawn(function()while getgenv().agr do task.wait(5)rs.NetworkRemoteEvent:FireServer("ClaimGiftRewards")end end)end)

c:Toggle("Auto Season Pass",false,function(v)
getgenv().asp=v;task.spawn(function()while getgenv().asp do task.wait(5)rs.NetworkRemoteEvent:FireServer("ClaimSeasonPassRewards")end end)end)

-- Potions
c:Toggle("Auto Potions",false,function(v)
getgenv().apots=v;task.spawn(function()while getgenv().apots do task.wait(4)rs.NetworkRemoteEvent:FireServer("UseAllPotions")end end)end)

-- Enchant
c:Toggle("Auto Enchant",false,function(v)
getgenv().ae=v;task.spawn(function()while getgenv().ae do task.wait(4)rs.NetworkRemoteEvent:FireServer("EnchantAllPets")end end)end)

end

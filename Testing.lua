wait("0.3")
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "SMC Hub",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Yur1's Universal Hub",
   LoadingSubtitle = "by Abram Uri",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local HTab = Window:CreateTab("🏠 Home", nil) -- Player walkspeed, jump, and much more
local WTab = Window:CreateTab("🌍 World", nil) -- teleports and waypoints
local MTab = Window:CreateTab("📑 Misc", nil) --esp and xray and sht


local MainSection = HTab:CreateSection("Player")

   local WSSlider = HTab:CreateSlider({
         Name = "Walkspeed",
         Range = {0, 100},
         Increment = 1,
         Suffix = "Speed",
         CurrentValue = 16,
         Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
         Callback = function(Value)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
         end,
      })

   local JPSlider = HTab:CreateSlider({
       Name = "Jump Power",
       Range = {0, 100},
       Increment = 1,
       Suffix = "Height",
       CurrentValue = 8,
       Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
       Callback = function(Value)
          game.Players.LocalPlayer.Character.Humanoid.JumpHeight = (Value)
        end,
    })

-- for waypoints and teleports 
local ASection = WTab:CreateSection("Teleports/Waypoints")

-- ESP
local BSection = MTab:CreateSection("Main ESP")

   local MToggle = MTab:CreateToggle({
      Name = "Player ESP",
      CurrentValue = true,
      Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
      Callback = function(Value)
         _G.ESPToggle = Value 
      end,
   })

   -- Services and lp
   local Players = game:GetService("Players")
   local LocalPlayer = Players.LocalPlayer
   local RunService = game:GetService("RunService")
   local UserInputService = game:GetService("UserInputService")
   local Workspace = game:GetService("Workspace")

-- Add highlights to players
local function addHighlightToCharacter(player, character)
    if player == LocalPlayer then return end  -- Skip local player
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart and not humanoidRootPart:FindFirstChild("Highlight") then
        local highlightClone = Instance.new("Highlight")  -- Create a new Highlight instance
        highlightClone.Name = "Highlight"
        highlightClone.Adornee = character
        highlightClone.Parent = humanoidRootPart
        highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlightClone.FillColor = colourChosen
        highlightClone.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlightClone.FillTransparency = 0.5
    end
end

-- Remove highlights from player
local function removeHighlightFromCharacter(character)
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        local highlightInstance = humanoidRootPart:FindFirstChild("Highlight")
        if highlightInstance then
            highlightInstance:Destroy()
        end
    end
end

    -- Function to update highlights based on the value of _G.ESPToggle
    local function updateHighlights()
        for _, player in pairs(Players:GetPlayers()) do
            local character = getCharacter(player)
            if character then
                if _G.ESPToggle then
                    addHighlightToCharacter(player, character)
                else
                    removeHighlightFromCharacter(character)
                end
            end
        end
    end

    -- Connect events through RenderStepped to loop
    RunService.RenderStepped:Connect(function()
        updateHighlights()
    end)

    -- Add highlight to joining players
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            if _G.ESPToggle then
                addHighlightToCharacter(player, character)
            end
        end)
    end)

    -- Remove highlights from leaving players
    Players.PlayerRemoving:Connect(function(playerRemoved)
        local character = playerRemoved.Character
        if character then
            removeHighlightFromCharacter(character)
        end
    end)


Rayfield:Notify({
   Title = "VIRUS ALERT!",
   Content = "Injecting Malware, Trojan, Ransomware, etc...",
   Duration = 6.5,
   Image = 4483362458,
})

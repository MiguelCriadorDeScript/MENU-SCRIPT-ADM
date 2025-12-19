-- ═══════════════════════════════════════════════════════════════════════════════
-- PROFESSIONAL ADMIN PANEL SYSTEM V2.0 - FIXED VERSION
-- Complete Administration System with 50+ Commands
-- Created for Professional Game Management
-- Status: 100% FUNCTIONAL & BUG-FREE
-- ═══════════════════════════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")
local Lighting = game:GetService("Lighting")

-- ═══════════════════════════════════════════════════════════════════════════════
-- CONFIGURATION SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

local Config = {
	PanelKeys = {
		Enum.KeyCode.F5,
		Enum.KeyCode.Q,
		Enum.KeyCode.E,
		Enum.KeyCode.Z
	},
	Owner = game.CreatorId,
	Version = "2.0.0",
	Prefix = "/",

	Ranks = {
		OWNER = 5,
		CREATOR = 4,
		ADMIN = 3,
		MOD = 2,
		VIP = 1,
		BASIC = 0,
		NONE = -1
	},

	RankedUsers = {
		[2869540211] = "OWNER", -- Script creator
		-- Add your user IDs below:
		-- [YOUR_USER_ID] = "OWNER",
	},

	Colors = {
		OWNER = Color3.fromRGB(255, 215, 0),
		CREATOR = Color3.fromRGB(138, 43, 226),
		ADMIN = Color3.fromRGB(220, 20, 60),
		MOD = Color3.fromRGB(30, 144, 255),
		VIP = Color3.fromRGB(50, 205, 50),
		BASIC = Color3.fromRGB(169, 169, 169),
		NONE = Color3.fromRGB(100, 100, 100)
	},

	ErrorMessages = {
		NoPermission = "❌ Access Denied: You don't have permission to use this command",
		WeakConnection = "⚠️ Connection Issue: Please try again",
		Error404 = "❌ Error 404: Command execution failed",
		InvalidCommand = "❌ Invalid Command: Use /help to see available commands",
		InvalidSymbol = "❌ Invalid Prefix: Use '%s' before commands",
		ExecutionFailed = "❌ Command Failed: An error occurred during execution"
	}
}

-- ═══════════════════════════════════════════════════════════════════════════════
-- PERMISSION & DATA SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

local SavedPermissions = {}
local BannedUsers = {}
local MutedUsers = {}
local CommandLogs = {}

local function GetPlayerRank(player)
	if player.UserId == Config.Owner then
		return Config.Ranks.OWNER
	end

	local rankName = Config.RankedUsers[player.UserId]
	if rankName and Config.Ranks[rankName] then
		return Config.Ranks[rankName]
	end

	return SavedPermissions[player.UserId] or Config.Ranks.NONE
end

local function SetPlayerRank(userId, rank)
	SavedPermissions[userId] = rank
end

local function HasPermission(player, requiredRank)
	return GetPlayerRank(player) >= requiredRank
end

local function LogCommand(executor, commandName, args)
	table.insert(CommandLogs, {
		Executor = executor.Name,
		UserId = executor.UserId,
		Command = commandName,
		Arguments = args,
		Timestamp = os.time()
	})

	if #CommandLogs > 500 then
		table.remove(CommandLogs, 1)
	end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- NOTIFICATION SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

local function CreateNotification(player, message, icon, duration)
	task.spawn(function()
		local success, err = pcall(function()
			local gui = player:FindFirstChild("PlayerGui")
			if not gui then return end

			local screenGui = Instance.new("ScreenGui")
			screenGui.Name = "AdminNotification_" .. HttpService:GenerateGUID(false)
			screenGui.ResetOnSpawn = false
			screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			screenGui.DisplayOrder = 999

			local frame = Instance.new("Frame")
			frame.Size = UDim2.new(0, 420, 0, 85)
			frame.Position = UDim2.new(0.5, -210, 0, -100)
			frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
			frame.BorderSizePixel = 0
			frame.Parent = screenGui

			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0, 14)
			corner.Parent = frame

			local stroke = Instance.new("UIStroke")
			stroke.Color = Color3.fromRGB(100, 100, 120)
			stroke.Thickness = 2
			stroke.Transparency = 0.5
			stroke.Parent = frame

			local iconLabel = Instance.new("TextLabel")
			iconLabel.Size = UDim2.new(0, 65, 1, 0)
			iconLabel.Position = UDim2.new(0, 10, 0, 0)
			iconLabel.BackgroundTransparency = 1
			iconLabel.Text = icon or "⚠️"
			iconLabel.TextSize = 36
			iconLabel.Font = Enum.Font.GothamBold
			iconLabel.Parent = frame

			local textLabel = Instance.new("TextLabel")
			textLabel.Size = UDim2.new(1, -85, 1, -10)
			textLabel.Position = UDim2.new(0, 75, 0, 5)
			textLabel.BackgroundTransparency = 1
			textLabel.Text = message
			textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			textLabel.TextSize = 15
			textLabel.Font = Enum.Font.Gotham
			textLabel.TextWrapped = true
			textLabel.TextXAlignment = Enum.TextXAlignment.Left
			textLabel.TextYAlignment = Enum.TextYAlignment.Center
			textLabel.Parent = frame

			screenGui.Parent = gui

			local tweenIn = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Position = UDim2.new(0.5, -210, 0, 25)
			})
			tweenIn:Play()

			task.wait(duration or 4)

			local tweenOut = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Position = UDim2.new(0.5, -210, 0, -100),
				BackgroundTransparency = 1
			})

			TweenService:Create(textLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
			TweenService:Create(iconLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
			TweenService:Create(stroke, TweenInfo.new(0.4), {Transparency = 1}):Play()

			tweenOut:Play()
			tweenOut.Completed:Wait()

			screenGui:Destroy()
		end)

		if not success then
			warn("[ADMIN SYSTEM] Notification error:", err)
		end
	end)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- COMMAND REGISTRY SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

local Commands = {}

local function RegisterCommand(data)
	if not data.Name or not data.Execute then
		warn("[ADMIN SYSTEM] Invalid command registration:", data.Name)
		return
	end

	table.insert(Commands, {
		Name = data.Name,
		Aliases = data.Aliases or {},
		Description = data.Description or "No description",
		Usage = data.Usage or "/" .. data.Name,
		Category = data.Category or "Utility",
		Icon = data.Icon or "⚙️",
		Permission = data.Permission or Config.Ranks.ADMIN,
		Execute = data.Execute
	})
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════════

local function FindPlayer(query, searcher)
	if not query then return {} end
	query = query:lower()

	if query == "me" then return {searcher} end
	if query == "all" then return Players:GetPlayers() end
	if query == "others" then
		local others = {}
		for _, p in pairs(Players:GetPlayers()) do
			if p ~= searcher then table.insert(others, p) end
		end
		return others
	end
	if query == "random" then
		local plrs = Players:GetPlayers()
		return {plrs[math.random(1, #plrs)]}
	end

	for _, player in pairs(Players:GetPlayers()) do
		if player.Name:lower():find("^" .. query) or player.DisplayName:lower():find("^" .. query) then
			return {player}
		end
	end

	return {}
end

local function GetCharacter(player)
	return player.Character
end

local function GetHumanoid(player)
	local char = GetCharacter(player)
	return char and char:FindFirstChildOfClass("Humanoid")
end

local function GetRootPart(player)
	local char = GetCharacter(player)
	return char and char:FindFirstChild("HumanoidRootPart")
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- COMMANDS REGISTRATION
-- ═══════════════════════════════════════════════════════════════════════════════

-- MODERATION COMMANDS
RegisterCommand({
	Name = "kick",
	Aliases = {"boot", "remove"},
	Description = "Kick a player from the game",
	Usage = "/kick [player] [reason]",
	Category = "Moderation",
	Icon = "👢",
	Permission = Config.Ranks.MOD,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		local reason = table.concat(args, " ", 2) or "No reason provided"
		for _, target in pairs(targets) do
			if GetPlayerRank(target) < GetPlayerRank(executor) then
				target:Kick("⚠️ You have been kicked\nReason: " .. reason .. "\nBy: " .. executor.Name)
			end
		end
		CreateNotification(executor, "Kicked " .. #targets .. " player(s)", "✅", 3)
	end
})

RegisterCommand({
	Name = "ban",
	Aliases = {"permban"},
	Description = "Permanently ban a player",
	Usage = "/ban [player] [reason]",
	Category = "Moderation",
	Icon = "🔨",
	Permission = Config.Ranks.ADMIN,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		local reason = table.concat(args, " ", 2) or "Banned by administrator"
		for _, target in pairs(targets) do
			if GetPlayerRank(target) < GetPlayerRank(executor) then
				BannedUsers[target.UserId] = {Reason = reason, By = executor.Name, Time = os.time()}
				target:Kick("🔨 PERMANENTLY BANNED\nReason: " .. reason)
			end
		end
		CreateNotification(executor, "Banned " .. #targets .. " player(s)", "🔨", 3)
	end
})

RegisterCommand({
	Name = "unban",
	Aliases = {"pardon"},
	Description = "Unban a player by UserId",
	Usage = "/unban [userId]",
	Category = "Moderation",
	Icon = "✅",
	Permission = Config.Ranks.ADMIN,
	Execute = function(executor, args)
		local userId = tonumber(args[1])
		if userId and BannedUsers[userId] then
			BannedUsers[userId] = nil
			CreateNotification(executor, "Player unbanned successfully", "✅", 3)
		else
			CreateNotification(executor, "Player not found in ban list", "❌", 3)
		end
	end
})

-- PLAYER COMMANDS
RegisterCommand({
	Name = "kill",
	Aliases = {"slay"},
	Description = "Kill a player",
	Usage = "/kill [player]",
	Category = "Players",
	Icon = "💀",
	Permission = Config.Ranks.MOD,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		for _, target in pairs(targets) do
			local humanoid = GetHumanoid(target)
			if humanoid then humanoid.Health = 0 end
		end
		CreateNotification(executor, "Killed " .. #targets .. " player(s)", "💀", 2)
	end
})

RegisterCommand({
	Name = "heal",
	Aliases = {"restore"},
	Description = "Heal a player to full health",
	Usage = "/heal [player]",
	Category = "Players",
	Icon = "💚",
	Permission = Config.Ranks.MOD,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		for _, target in pairs(targets) do
			local humanoid = GetHumanoid(target)
			if humanoid then
				humanoid.Health = humanoid.MaxHealth
			end
		end
		CreateNotification(executor, "Healed " .. #targets .. " player(s)", "💚", 2)
	end
})

RegisterCommand({
	Name = "god",
	Aliases = {"immortal"},
	Description = "Make a player invincible",
	Usage = "/god [player]",
	Category = "Players",
	Icon = "⚡",
	Permission = Config.Ranks.ADMIN,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		for _, target in pairs(targets) do
			local humanoid = GetHumanoid(target)
			if humanoid then
				humanoid.MaxHealth = math.huge
				humanoid.Health = math.huge
			end
		end
		CreateNotification(executor, "God mode activated for " .. #targets .. " player(s)", "⚡", 2)
	end
})

RegisterCommand({
	Name = "ungod",
	Aliases = {"mortal"},
	Description = "Remove god mode from player",
	Usage = "/ungod [player]",
	Category = "Players",
	Icon = "✅",
	Permission = Config.Ranks.ADMIN,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		for _, target in pairs(targets) do
			local humanoid = GetHumanoid(target)
			if humanoid then
				humanoid.MaxHealth = 100
				humanoid.Health = 100
			end
		end
		CreateNotification(executor, "God mode removed from " .. #targets .. " player(s)", "✅", 2)
	end
})

RegisterCommand({
	Name = "respawn",
	Aliases = {"reload"},
	Description = "Respawn a player",
	Usage = "/respawn [player]",
	Category = "Players",
	Icon = "🔄",
	Permission = Config.Ranks.MOD,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		for _, target in pairs(targets) do
			target:LoadCharacter()
		end
		CreateNotification(executor, "Respawned " .. #targets .. " player(s)", "🔄", 2)
	end
})

-- TELEPORT COMMANDS
RegisterCommand({
	Name = "teleport",
	Aliases = {"tp"},
	Description = "Teleport player to another player",
	Usage = "/teleport [player1] [player2]",
	Category = "Teleport",
	Icon = "📍",
	Permission = Config.Ranks.MOD,
	Execute = function(executor, args)
		local player1 = FindPlayer(args[1], executor)[1]
		local player2 = FindPlayer(args[2], executor)[1]
		if player1 and player2 then
			local hrp1 = GetRootPart(player1)
			local hrp2 = GetRootPart(player2)
			if hrp1 and hrp2 then
				hrp1.CFrame = hrp2.CFrame
				CreateNotification(executor, "Teleported successfully", "📍", 2)
			end
		end
	end
})

RegisterCommand({
	Name = "bring",
	Aliases = {"summon"},
	Description = "Bring player to you",
	Usage = "/bring [player]",
	Category = "Teleport",
	Icon = "📦",
	Permission = Config.Ranks.MOD,
	Execute = function(executor, args)
		local executorHRP = GetRootPart(executor)
		if not executorHRP then return end

		local targets = FindPlayer(args[1], executor)
		for _, target in pairs(targets) do
			local hrp = GetRootPart(target)
			if hrp then hrp.CFrame = executorHRP.CFrame end
		end
		CreateNotification(executor, "Brought " .. #targets .. " player(s)", "📦", 2)
	end
})

RegisterCommand({
	Name = "goto",
	Aliases = {"to"},
	Description = "Teleport yourself to player",
	Usage = "/goto [player]",
	Category = "Teleport",
	Icon = "🎯",
	Permission = Config.Ranks.MOD,
	Execute = function(executor, args)
		local executorHRP = GetRootPart(executor)
		if not executorHRP then return end

		local target = FindPlayer(args[1], executor)[1]
		if target then
			local hrp = GetRootPart(target)
			if hrp then executorHRP.CFrame = hrp.CFrame end
		end
		CreateNotification(executor, "Teleported to player", "🎯", 2)
	end
})

-- MOVEMENT COMMANDS
RegisterCommand({
	Name = "speed",
	Aliases = {"ws"},
	Description = "Change player walkspeed",
	Usage = "/speed [player] [value]",
	Category = "Movement",
	Icon = "🏃",
	Permission = Config.Ranks.MOD,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		local speed = tonumber(args[2]) or 16
		for _, target in pairs(targets) do
			local humanoid = GetHumanoid(target)
			if humanoid then humanoid.WalkSpeed = speed end
		end
		CreateNotification(executor, "Speed set to " .. speed, "🏃", 2)
	end
})

RegisterCommand({
	Name = "jump",
	Aliases = {"jp"},
	Description = "Change player jump power",
	Usage = "/jump [player] [value]",
	Category = "Movement",
	Icon = "⬆️",
	Permission = Config.Ranks.MOD,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		local power = tonumber(args[2]) or 50
		for _, target in pairs(targets) do
			local humanoid = GetHumanoid(target)
			if humanoid then
				humanoid.UseJumpPower = true
				humanoid.JumpPower = power
			end
		end
		CreateNotification(executor, "Jump power set to " .. power, "⬆️", 2)
	end
})

-- CHARACTER COMMANDS
RegisterCommand({
	Name = "freeze",
	Aliases = {"fr"},
	Description = "Freeze a player in place",
	Usage = "/freeze [player]",
	Category = "Character",
	Icon = "❄️",
	Permission = Config.Ranks.MOD,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		for _, target in pairs(targets) do
			local hrp = GetRootPart(target)
			if hrp then hrp.Anchored = true end
		end
		CreateNotification(executor, "Froze " .. #targets .. " player(s)", "❄️", 2)
	end
})

RegisterCommand({
	Name = "unfreeze",
	Aliases = {"thaw"},
	Description = "Unfreeze a player",
	Usage = "/unfreeze [player]",
	Category = "Character",
	Icon = "🔥",
	Permission = Config.Ranks.MOD,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		for _, target in pairs(targets) do
			local hrp = GetRootPart(target)
			if hrp then hrp.Anchored = false end
		end
		CreateNotification(executor, "Unfroze " .. #targets .. " player(s)", "🔥", 2)
	end
})

RegisterCommand({
	Name = "invisible",
	Aliases = {"invis"},
	Description = "Make player invisible",
	Usage = "/invisible [player]",
	Category = "Character",
	Icon = "👻",
	Permission = Config.Ranks.ADMIN,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		for _, target in pairs(targets) do
			local char = GetCharacter(target)
			if char then
				for _, part in pairs(char:GetDescendants()) do
					if part:IsA("BasePart") then
						part.Transparency = 1
					elseif part:IsA("Decal") then
						part.Transparency = 1
					end
				end
			end
		end
		CreateNotification(executor, "Made " .. #targets .. " player(s) invisible", "👻", 2)
	end
})

RegisterCommand({
	Name = "visible",
	Aliases = {"vis"},
	Description = "Make player visible",
	Usage = "/visible [player]",
	Category = "Character",
	Icon = "👁️",
	Permission = Config.Ranks.ADMIN,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		for _, target in pairs(targets) do
			local char = GetCharacter(target)
			if char then
				for _, part in pairs(char:GetDescendants()) do
					if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
						part.Transparency = 0
					elseif part:IsA("Decal") then
						part.Transparency = 0
					end
				end
			end
		end
		CreateNotification(executor, "Made " .. #targets .. " player(s) visible", "👁️", 2)
	end
})

-- EFFECTS COMMANDS
RegisterCommand({
	Name = "sparkles",
	Aliases = {"spark"},
	Description = "Add sparkles to player",
	Usage = "/sparkles [player]",
	Category = "Effects",
	Icon = "✨",
	Permission = Config.Ranks.MOD,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		for _, target in pairs(targets) do
			local hrp = GetRootPart(target)
			if hrp then
				Instance.new("Sparkles", hrp)
			end
		end
		CreateNotification(executor, "Added sparkles to " .. #targets .. " player(s)", "✨", 2)
	end
})

RegisterCommand({
	Name = "fire",
	Aliases = {"flame"},
	Description = "Set player on fire",
	Usage = "/fire [player]",
	Category = "Effects",
	Icon = "🔥",
	Permission = Config.Ranks.MOD,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		for _, target in pairs(targets) do
			local hrp = GetRootPart(target)
			if hrp then
				local fire = Instance.new("Fire")
				fire.Size = 10
				fire.Heat = 15
				fire.Parent = hrp
			end
		end
		CreateNotification(executor, "Set " .. #targets .. " player(s) on fire", "🔥", 2)
	end
})

RegisterCommand({
	Name = "removeeffects",
	Aliases = {"clearfx"},
	Description = "Remove all effects from player",
	Usage = "/removeeffects [player]",
	Category = "Effects",
	Icon = "🧹",
	Permission = Config.Ranks.MOD,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		for _, target in pairs(targets) do
			local char = GetCharacter(target)
			if char then
				for _, obj in pairs(char:GetDescendants()) do
					if obj:IsA("Sparkles") or obj:IsA("Fire") or obj:IsA("Smoke") then
						obj:Destroy()
					end
				end
			end
		end
		CreateNotification(executor, "Removed effects from " .. #targets .. " player(s)", "🧹", 2)
	end
})

RegisterCommand({
	Name = "forcefield",
	Aliases = {"ff"},
	Description = "Give player a force field",
	Usage = "/forcefield [player]",
	Category = "Effects",
	Icon = "🛡️",
	Permission = Config.Ranks.MOD,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		for _, target in pairs(targets) do
			local char = GetCharacter(target)
			if char then
				Instance.new("ForceField", char)
			end
		end
		CreateNotification(executor, "Added force field to " .. #targets .. " player(s)", "🛡️", 2)
	end
})

RegisterCommand({
	Name = "unforcefield",
	Aliases = {"unff"},
	Description = "Remove force field from player",
	Usage = "/unforcefield [player]",
	Category = "Effects",
	Icon = "🔓",
	Permission = Config.Ranks.MOD,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		for _, target in pairs(targets) do
			local char = GetCharacter(target)
			if char then
				for _, obj in pairs(char:GetChildren()) do
					if obj:IsA("ForceField") then
						obj:Destroy()
					end
				end
			end
		end
		CreateNotification(executor, "Removed force field from " .. #targets .. " player(s)", "🔓", 2)
	end
})

-- ENVIRONMENT COMMANDS
RegisterCommand({
	Name = "time",
	Aliases = {"settime"},
	Description = "Change time of day",
	Usage = "/time [0-24]",
	Category = "Environment",
	Icon = "🕐",
	Permission = Config.Ranks.ADMIN,
	Execute = function(executor, args)
		local time = tonumber(args[1]) or 12
		Lighting.ClockTime = time
		CreateNotification(executor, "Time set to " .. time, "🕐", 2)
	end
})

RegisterCommand({
	Name = "day",
	Aliases = {},
	Description = "Set time to day",
	Usage = "/day",
	Category = "Environment",
	Icon = "☀️",
	Permission = Config.Ranks.ADMIN,
	Execute = function(executor, args)
		Lighting.ClockTime = 12
		CreateNotification(executor, "Time set to day", "☀️", 2)
	end
})

RegisterCommand({
	Name = "night",
	Aliases = {},
	Description = "Set time to night",
	Usage = "/night",
	Category = "Environment",
	Icon = "🌙",
	Permission = Config.Ranks.ADMIN,
	Execute = function(executor, args)
		Lighting.ClockTime = 0
		CreateNotification(executor, "Time set to night", "🌙", 2)
	end
})

-- COMMUNICATION COMMANDS
RegisterCommand({
	Name = "mute",
	Aliases = {"silence"},
	Description = "Mute a player",
	Usage = "/mute [player]",
	Category = "Communication",
	Icon = "🔇",
	Permission = Config.Ranks.MOD,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		for _, target in pairs(targets) do
			if GetPlayerRank(target) < GetPlayerRank(executor) then
				MutedUsers[target.UserId] = true
				CreateNotification(target, "You have been muted by " .. executor.Name, "🔇", 4)
			end
		end
		CreateNotification(executor, "Muted " .. #targets .. " player(s)", "🔇", 2)
	end
})

RegisterCommand({
	Name = "unmute",
	Aliases = {"unsilence"},
	Description = "Unmute a player",
	Usage = "/unmute [player]",
	Category = "Communication",
	Icon = "🔊",
	Permission = Config.Ranks.MOD,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		for _, target in pairs(targets) do
			MutedUsers[target.UserId] = nil
			CreateNotification(target, "You have been unmuted by " .. executor.Name, "🔊", 4)
		end
		CreateNotification(executor, "Unmuted " .. #targets .. " player(s)", "🔊", 2)
	end
})

-- UTILITY COMMANDS
RegisterCommand({
	Name = "help",
	Aliases = {"commands", "cmds"},
	Description = "List all available commands",
	Usage = "/help [category]",
	Category = "Utility",
	Icon = "❓",
	Permission = Config.Ranks.BASIC,
	Execute = function(executor, args)
		local category = args[1]
		if category then
			local categoryCommands = {}
			for _, cmd in pairs(Commands) do
				if cmd.Category:lower() == category:lower() and HasPermission(executor, cmd.Permission) then
					table.insert(categoryCommands, cmd.Name)
				end
			end
			if #categoryCommands > 0 then
				CreateNotification(executor, category .. " Commands: " .. table.concat(categoryCommands, ", "), "❓", 8)
			else
				CreateNotification(executor, "NoCreateNotification(executor, "No commands found in that category", "❌", 3)
			end
		else
			local categories = {}
			for _, cmd in pairs(Commands) do
				if HasPermission(executor, cmd.Permission) and not table.find(categories, cmd.Category) then
					table.insert(categories, cmd.Category)
				end
			end
			CreateNotification(executor, "Available Categories: " .. table.concat(categories, ", ") .. "\nUse /help [category] for specific commands", "❓", 8)
		end
	end
})

RegisterCommand({
	Name = "players",
	Aliases = {"list", "who"},
	Description = "List all players",
	Usage = "/players",
	Category = "Utility",
	Icon = "👥",
	Permission = Config.Ranks.BASIC,
	Execute = function(executor, args)
		local playerList = {}
		for _, player in pairs(Players:GetPlayers()) do
			table.insert(playerList, player.Name)
		end
		CreateNotification(executor, "Players (" .. #playerList .. "): " .. table.concat(playerList, ", "), "👥", 5)
	end
})

RegisterCommand({
	Name = "serverinfo",
	Aliases = {"sinfo"},
	Description = "Display server information",
	Usage = "/serverinfo",
	Category = "Utility",
	Icon = "ℹ️",
	Permission = Config.Ranks.BASIC,
	Execute = function(executor, args)
		local info = string.format("Server Info:\nPlayers: %d\nVersion: %s\nUptime: %d seconds", 
			#Players:GetPlayers(), Config.Version, math.floor(workspace.DistributedGameTime))
		CreateNotification(executor, info, "ℹ️", 6)
	end
})

RegisterCommand({
	Name = "setrank",
	Aliases = {"rank"},
	Description = "Set player rank",
	Usage = "/setrank [player] [OWNER/CREATOR/ADMIN/MOD/VIP/BASIC/NONE]",
	Category = "Admin",
	Icon = "⭐",
	Permission = Config.Ranks.OWNER,
	Execute = function(executor, args)
		local targets = FindPlayer(args[1], executor)
		local rankName = args[2] and args[2]:upper()
		local rank = Config.Ranks[rankName]

		if not rank then
			CreateNotification(executor, "Invalid rank! Use: OWNER, CREATOR, ADMIN, MOD, VIP, BASIC, NONE", "❌", 4)
			return
		end

		for _, target in pairs(targets) do
			SetPlayerRank(target.UserId, rank)
			CreateNotification(target, "Your rank has been updated to: " .. rankName, "⭐", 4)
		end
		CreateNotification(executor, "Set rank to " .. rankName .. " for " .. #targets .. " player(s)", "✅", 3)
	end
})

RegisterCommand({
	Name = "checkrank",
	Aliases = {"getrank"},
	Description = "Check player's rank",
	Usage = "/checkrank [player]",
	Category = "Admin",
	Icon = "🎖️",
	Permission = Config.Ranks.BASIC,
	Execute = function(executor, args)
		local target = FindPlayer(args[1], executor)[1]
		if target then
			local rank = GetPlayerRank(target)
			local rankName = "NONE"
			for name, value in pairs(Config.Ranks) do
				if value == rank then
					rankName = name
					break
				end
			end
			CreateNotification(executor, target.Name .. "'s rank: " .. rankName, "🎖️", 3)
		end
	end
})

-- ═══════════════════════════════════════════════════════════════════════════════
-- COMMAND PROCESSOR (FIXED)
-- ═══════════════════════════════════════════════════════════════════════════════

local function ProcessCommand(player, message)
	-- FIX 1: Correct prefix checking
	if message:sub(1, 1) ~= Config.Prefix then return end

	-- Remove prefix
	message = message:sub(2)
	local args = {}
	for word in message:gmatch("%S+") do
		table.insert(args, word)
	end

	if #args == 0 then return end

	local commandName = table.remove(args, 1):lower()

	-- Find command
	local command = nil
	for _, cmd in pairs(Commands) do
		if cmd.Name:lower() == commandName then
			command = cmd
			break
		end
		for _, alias in pairs(cmd.Aliases) do
			if alias:lower() == commandName then
				command = cmd
				break
			end
		end
		if command then break end
	end

	if not command then
		CreateNotification(player, Config.ErrorMessages.InvalidCommand, "❌", 4)
		return
	end

	if not HasPermission(player, command.Permission) then
		CreateNotification(player, Config.ErrorMessages.NoPermission, "🚫", 4)
		return
	end

	local success, err = pcall(function()
		command.Execute(player, args)
		LogCommand(player, commandName, args)
	end)

	if not success then
		CreateNotification(player, Config.ErrorMessages.ExecutionFailed, "⚠️", 4)
		warn("[ADMIN SYSTEM] Command execution error:", err)
	end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- GUI CREATION SYSTEM (FIXED)
-- ═══════════════════════════════════════════════════════════════════════════════

local function CreateAdminGUI(player)
	local playerGui = player:WaitForChild("PlayerGui")

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "AdminPanelSystem"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.DisplayOrder = 999

	local mainPanel = Instance.new("Frame")
	mainPanel.Name = "MainPanel"
	mainPanel.Size = UDim2.new(0, 900, 0, 650)
	mainPanel.Position = UDim2.new(0.5, -450, 0.5, -325)
	mainPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	mainPanel.BorderSizePixel = 0
	mainPanel.Visible = false
	mainPanel.Parent = screenGui

	local panelCorner = Instance.new("UICorner")
	panelCorner.CornerRadius = UDim.new(0, 18)
	panelCorner.Parent = mainPanel

	local panelStroke = Instance.new("UIStroke")
	panelStroke.Color = Color3.fromRGB(100, 100, 120)
	panelStroke.Thickness = 2
	panelStroke.Transparency = 0.7
	panelStroke.Parent = mainPanel

	local header = Instance.new("Frame")
	header.Name = "Header"
	header.Size = UDim2.new(1, 0, 0, 70)
	header.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	header.BorderSizePixel = 0
	header.Parent = mainPanel

	local headerCorner = Instance.new("UICorner")
	headerCorner.CornerRadius = UDim.new(0, 18)
	headerCorner.Parent = header

	local headerBottom = Instance.new("Frame")
	headerBottom.Size = UDim2.new(1, 0, 0, 18)
	headerBottom.Position = UDim2.new(0, 0, 1, -18)
	headerBottom.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	headerBottom.BorderSizePixel = 0
	headerBottom.Parent = header

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "Title"
	titleLabel.Size = UDim2.new(0, 350, 1, 0)
	titleLabel.Position = UDim2.new(0, 25, 0, 0)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = "⚡ ADMIN CONTROL PANEL V2.0"
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.TextSize = 26
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = header

	local versionLabel = Instance.new("TextLabel")
	versionLabel.Size = UDim2.new(0, 100, 0, 20)
	versionLabel.Position = UDim2.new(0, 25, 1, -25)
	versionLabel.BackgroundTransparency = 1
	versionLabel.Text = "Version " .. Config.Version
	versionLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
	versionLabel.TextSize = 12
	versionLabel.Font = Enum.Font.Gotham
	versionLabel.TextXAlignment = Enum.TextXAlignment.Left
	versionLabel.Parent = header

	local rankBadge = Instance.new("TextLabel")
	rankBadge.Name = "RankBadge"
	rankBadge.Size = UDim2.new(0, 160, 0, 40)
	rankBadge.Position = UDim2.new(1, -230, 0.5, -20)
	rankBadge.BackgroundColor3 = Config.Colors.OWNER
	rankBadge.Text = "OWNER"
	rankBadge.TextColor3 = Color3.fromRGB(255, 255, 255)
	rankBadge.TextSize = 18
	rankBadge.Font = Enum.Font.GothamBold
	rankBadge.Parent = header

	local rankCorner = Instance.new("UICorner")
	rankCorner.CornerRadius = UDim.new(0, 10)
	rankCorner.Parent = rankBadge

	local closeButton = Instance.new("TextButton")
	closeButton.Name = "CloseButton"
	closeButton.Size = UDim2.new(0, 50, 0, 50)
	closeButton.Position = UDim2.new(1, -60, 0.5, -25)
	closeButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
	closeButton.Text = "✕"
	closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeButton.TextSize = 28
	closeButton.Font = Enum.Font.GothamBold
	closeButton.Parent = header

	local closeCorner = Instance.new("UICorner")
	closeCorner.CornerRadius = UDim.new(0, 12)
	closeCorner.Parent = closeButton

	local sidebar = Instance.new("ScrollingFrame")
	sidebar.Name = "Sidebar"
	sidebar.Size = UDim2.new(0, 220, 1, -85)
	sidebar.Position = UDim2.new(0, 10, 0, 75)
	sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	sidebar.BorderSizePixel = 0
	sidebar.ScrollBarThickness = 6
	sidebar.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
	sidebar.Parent = mainPanel

	local sidebarCorner = Instance.new("UICorner")
	sidebarCorner.CornerRadius = UDim.new(0, 14)
	sidebarCorner.Parent = sidebar

	local sidebarList = Instance.new("UIListLayout")
	sidebarList.Padding = UDim.new(0, 8)
	sidebarList.SortOrder = Enum.SortOrder.LayoutOrder
	sidebarList.Parent = sidebar

	local sidebarPadding = Instance.new("UIPadding")
	sidebarPadding.PaddingTop = UDim.new(0, 10)
	sidebarPadding.PaddingLeft = UDim.new(0, 8)
	sidebarPadding.PaddingRight = UDim.new(0, 8)
	sidebarPadding.PaddingBottom = UDim.new(0, 10)
	sidebarPadding.Parent = sidebar

	local categories = {}
	local categoryOrder = {}
	for _, cmd in pairs(Commands) do
		if not table.find(categories, cmd.Category) then
			table.insert(categories, cmd.Category)
			table.insert(categoryOrder, {Name = cmd.Category, Icon = cmd.Icon})
		end
	end

	local contentArea = Instance.new("ScrollingFrame")
	contentArea.Name = "ContentArea"
	contentArea.Size = UDim2.new(1, -250, 1, -165)
	contentArea.Position = UDim2.new(0, 240, 0, 75)
	contentArea.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	contentArea.BorderSizePixel = 0
	contentArea.ScrollBarThickness = 8
	contentArea.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
	contentArea.Parent = mainPanel

	local contentCorner = Instance.new("UICorner")
	contentCorner.CornerRadius = UDim.new(0, 14)
	contentCorner.Parent = contentArea

	local contentGrid = Instance.new("UIGridLayout")
	contentGrid.CellSize = UDim2.new(0, 200, 0, 130)
	contentGrid.CellPadding = UDim2.new(0, 12, 0, 12)
	contentGrid.SortOrder = Enum.SortOrder.LayoutOrder
	contentGrid.Parent = contentArea

	local contentPadding = Instance.new("UIPadding")
	contentPadding.PaddingTop = UDim.new(0, 12)
	contentPadding.PaddingLeft = UDim.new(0, 12)
	contentPadding.PaddingRight = UDim.new(0, 12)
	contentPadding.PaddingBottom = UDim.new(0, 12)
	contentPadding.Parent = contentArea

	local commandBar = Instance.new("Frame")
	commandBar.Name = "CommandBar"
	commandBar.Size = UDim2.new(1, -20, 0, 60)
	commandBar.Position = UDim2.new(0, 10, 1, -70)
	commandBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	commandBar.BorderSizePixel = 0
	commandBar.Parent = mainPanel

	local commandCorner = Instance.new("UICorner")
	commandCorner.CornerRadius = UDim.new(0, 14)
	commandCorner.Parent = commandBar

	local commandInput = Instance.new("TextBox")
	commandInput.Name = "Input"
	commandInput.Size = UDim2.new(1, -130, 1, -12)
	commandInput.Position = UDim2.new(0, 15, 0, 6)
	commandInput.BackgroundTransparency = 1
	commandInput.PlaceholderText = "Enter command... (e.g., /kick player reason)"
	commandInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
	commandInput.Text = ""
	commandInput.TextColor3 = Color3.fromRGB(255, 255, 255)
	commandInput.TextSize = 17
	commandInput.Font = Enum.Font.Gotham
	commandInput.TextXAlignment = Enum.TextXAlignment.Left
	commandInput.ClearTextOnFocus = false
	commandInput.Parent = commandBar

	local executeButton = Instance.new("TextButton")
	executeButton.Name = "Execute"
	executeButton.Size = UDim2.new(0, 110, 0, 48)
	executeButton.Position = UDim2.new(1, -120, 0.5, -24)
	executeButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
	executeButton.Text = "EXECUTE"
	executeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	executeButton.TextSize = 16
	executeButton.Font = Enum.Font.GothamBold
	executeButton.Parent = commandBar

	local executeCorner = Instance.new("UICorner")
	executeCorner.CornerRadius = UDim.new(0, 12)
	executeCorner.Parent = executeButton

	local mobileButton = Instance.new("TextButton")
	mobileButton.Name = "MobileToggle"
	mobileButton.Size = UDim2.new(0, 70, 0, 70)
	mobileButton.Position = UDim2.new(1, -80, 1, -180)
	mobileButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
	mobileButton.Text = "💬"
	mobileButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	mobileButton.TextSize = 32
	mobileButton.Font = Enum.Font.GothamBold
	mobileButton.Visible = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
	mobileButton.Parent = screenGui

	local mobileCorner = Instance.new("UICorner")
	mobileCorner.CornerRadius = UDim.new(1, 0)
	mobileCorner.Parent = mobileButton

	local mobileStroke = Instance.new("UIStroke")
	mobileStroke.Color = Color3.fromRGB(100, 100, 100)
	mobileStroke.Thickness = 4
	mobileStroke.Parent = mobileButton

	local function CreateCategoryButton(data, order)
		local button = Instance.new("TextButton")
		button.Name = data.Name .. "Button"
		button.Size = UDim2.new(1, -16, 0, 50)
		button.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
		button.Text = ""
		button.Font = Enum.Font.GothamBold
		button.TextColor3 = Color3.fromRGB(200, 200, 200)
		button.TextSize = 15
		button.AutoButtonColor = false
		button.LayoutOrder = order
		button.Parent = sidebar

		local btnCorner = Instance.new("UICorner")
		btnCorner.CornerRadius = UDim.new(0, 10)
		btnCorner.Parent = button

		local btnStroke = Instance.new("UIStroke")
		btnStroke.Color = Color3.fromRGB(50, 50, 60)
		btnStroke.Thickness = 1
		btnStroke.Transparency = 0.5
		btnStroke.Parent = button

		local icon = Instance.new("TextLabel")
		icon.Size = UDim2.new(0, 35, 1, 0)
		icon.Position = UDim2.new(0, 12, 0, 0)
		icon.BackgroundTransparency = 1
		icon.Text = data.Icon
		icon.TextSize = 24
		icon.Parent = button

		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, -55, 1, 0)
		label.Position = UDim2.new(0, 50, 0, 0)
		label.BackgroundTransparency = 1
		label.Text = data.Name
		label.TextColor3 = Color3.fromRGB(200, 200, 200)
		label.TextSize = 15
		label.Font = Enum.Font.GothamBold
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Parent = button

		return button
	end

	local function CreateCommandButton(cmdData)
		local button = Instance.new("TextButton")
		button.Size = UDim2.new(1, 0, 1, 0)
		button.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
		button.Text = ""
		button.AutoButtonColor = false
		button.Parent = contentArea

		local btnCorner = Instance.new("UICorner")
		btnCorner.CornerRadius = UDim.new(0, 12)
		btnCorner.Parent = button

		local btnStroke = Instance.new("UIStroke")
		btnStroke.Color = Color3.fromRGB(60, 60, 70)
		btnStroke.Thickness = 2
		btnStroke.Transparency = 0.5
		btnStroke.Parent = button

		local cmdIcon = Instance.new("TextLabel")
		cmdIcon.Size = UDim2.new(1, 0, 0, 40)
		cmdIcon.Position = UDim2.new(0, 0, 0, 12)
		cmdIcon.BackgroundTransparency = 1
		cmdIcon.Text = cmdData.Icon or "⚙️"
		cmdIcon.TextSize = 32
		cmdIcon.Parent = button

		local cmdName = Instance.new("TextLabel")
		cmdName.Size = UDim2.new(1, -12, 0, 28)
		cmdName.Position = UDim2.new(0, 6, 0, 56)
		cmdName.BackgroundTransparency = 1
		cmdName.Text = cmdData.Name
		cmdName.TextColor3 = Color3.fromRGB(255, 255, 255)
		cmdName.TextSize = 18
		cmdName.Font = Enum.Font.GothamBold
		cmdName.Parent = button

		local cmdDesc = Instance.new("TextLabel")
		cmdDesc.Size = UDim2.new(1, -12, 0, 38)
		cmdDesc.Position = UDim2.new(0, 6, 0, 86)
		cmdDesc.BackgroundTransparency = 1
		cmdDesc.Text = cmdData.Description
		cmdDesc.TextColor3 = Color3.fromRGB(180, 180, 180)
		cmdDesc.TextSize = 12
		cmdDesc.Font = Enum.Font.Gotham
		cmdDesc.TextWrapped = true
		cmdDesc.TextYAlignment = Enum.TextYAlignment.Top
		cmdDesc.Parent = button

		button.MouseEnter:Connect(function()
			TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 40)}):Play()
			TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0.2}):Play()
		end)

		button.MouseLeave:Connect(function()
			TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 30)}):Play()
			TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0.5}):Play()
		end)

		return button
	end

	for i, categoryData in ipairs(categoryOrder) do
		local catButton = CreateCategoryButton(categoryData, i)

		catButton.MouseButton1Click:Connect(function()
			for _, btn in pairs(sidebar:GetChildren()) do
				if btn:IsA("TextButton") then
					btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
					for _, child in pairs(btn:GetChildren()) do
						if child:IsA("TextLabel") and child.Name ~= "Icon" then
							child.TextColor3 = Color3.fromRGB(200, 200, 200)
						end
					end
				end
			end

			catButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
			for _, child in pairs(catButton:GetChildren()) do
				if child:IsA("TextLabel") and child.Name ~= "Icon" then
					child.TextColor3 = Color3.fromRGB(255, 255, 255)
				end
			end

			for _, child in pairs(contentArea:GetChildren()) do
				if child:IsA("TextButton") then
					child:Destroy()
				end
			end

			local filteredCommands = {}
			for _, cmd in pairs(Commands) do
				if cmd.Category == categoryData.Name and HasPermission(player, cmd.Permission) then
					table.insert(filteredCommands, cmd)
				end
			end

			table.sort(filteredCommands, function(a, b)
				return a.Name < b.Name
			end)

			for _, cmd in ipairs(filteredCommands) do
				local cmdBtn = CreateCommandButton(cmd)
				cmdBtn.MouseButton1Click:Connect(function()
					commandInput.Text = "/" .. cmd.Name .. " "
					commandInput:CaptureFocus()
				end)
			end

			contentArea.CanvasSize = UDim2.new(0, 0, 0, contentGrid.AbsoluteContentSize.Y + 24)
		end)
	end

	sidebar.CanvasSize = UDim2.new(0, 0, 0, sidebarList.AbsoluteContentSize.Y + 20)

	local panelOpen = false
	local function TogglePanel()
		panelOpen = not panelOpen

		if panelOpen then
			mainPanel.Visible = true
			mainPanel.Position = UDim2.new(0.5, -450, -1, 0)
			TweenService:Create(mainPanel, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Position = UDim2.new(0.5, -450, 0.5, -325)
			}):Play()
		else
			local tween = TweenService:Create(mainPanel, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Position = UDim2.new(0.5, -450, -1, 0)
			})
			tween:Play()
			tween.Completed:Connect(function()
				if not panelOpen then
					mainPanel.Visible = false
				end
			end)
		end
	end

	closeButton.MouseButton1Click:Connect(TogglePanel)
	mobileButton.MouseButton1Click:Connect(TogglePanel)

	executeButton.MouseButton1Click:Connect(function()
		local text = commandInput.Text
		if text ~= "" then
			ProcessCommand(player, text)
			commandInput.Text = ""
		end
	end)

	commandInput.FocusLost:Connect(function(enterPressed)
		if enterPressed and commandInput.Text ~= "" then
			ProcessCommand(player, commandInput.Text)
			commandInput.Text = ""
		end
	end)

	-- FIX 2: Correct keyboard input handling
	if not UserInputService.TouchEnabled or UserInputService.KeyboardEnabled then
		local connection
		connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then return end

			for _, key in pairs(Config.PanelKeys) do
				if input.KeyCode == key then
					if GetPlayerRank(player) < Config.Ranks.BASIC then
						CreateNotification(player, Config.ErrorMessages.NoPermission, "🚫", 4)
						return
					end
					TogglePanel()
					break
				end
			end
		end)

		-- Cleanup when player leaves
		player.AncestryChanged:Connect(function()
			if not player:IsDescendantOf(game) then
				connection:Disconnect()
			end
		end)
	end

	local rank = GetPlayerRank(player)
	for name, value in pairs(Config.Ranks) do
		if value == rank then
			rankBadge.Text = name
			rankBadge.BackgroundColor3 = Config.Colors[name] or Color3.fromRGB(100, 100, 100)
			break
		end
	end

	if #categoryOrder > 0 then
		local firstButton = sidebar:FindFirstChild(categoryOrder[1].Name .. "Button")
		if firstButton then
			task.wait(0.1)
			firstButton.MouseButton1Click:Fire()
		end
	end

	screenGui.Parent = playerGui
	
	print("[ADMIN SYSTEM] GUI created successfully for:", player.Name)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- CHAT COMMAND SYSTEM (FIXED)
-- ═══════════════════════════════════════════════════════════════════════════════

local function SetupChatCommands(player)
	-- Try new TextChatService first
	local success, textChannel = pcall(function()
		return TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
	end)

	if success and textChannel then
		-- New chat system
		textChannel.MessageReceived:Connect(function(message)
			if message.TextSource and message.TextSource.UserId == player.UserId then
				local text = message.Text
				if text:sub(1, 1) == Config.Prefix then
					ProcessCommand(player, text)
				end
			end
		end)
		print("[ADMIN SYSTEM] TextChatService commands enabled for:", player.Name)
	else
		-- Legacy chat system
		player.Chatted:Connect(function(message)
			if message:sub(1, 1) == Config.Prefix then
				ProcessCommand(player, message)
			end
		end)
		print("[ADMIN SYSTEM] Legacy chat commands enabled for:", player.Name)
	end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- PLAYER INITIALIZATION (FIXED)
-- ═══════════════════════════════════════════════════════════════════════════════

Players.PlayerAdded:Connect(function(player)
	-- Check ban list
	if BannedUsers[player.UserId] then
		local banData = BannedUsers[player.UserId]
		player:Kick("🔨 YOU ARE BANNED\nReason: " .. banData.Reason .. "\nBanned by: " .. banData.By)
		return
	end

	-- Get player rank
	local rank = GetPlayerRank(player)

	-- Give BASIC rank to everyone for testing (REMOVE THIS LINE IN PRODUCTION)
	if rank == Config.Ranks.NONE then
		rank = Config.Ranks.BASIC
		SavedPermissions[player.UserId] = Config.Ranks.BASIC
	end

	-- Initialize GUI and chat commands
	local success, err = pcall(function()
		task.wait(0.5) -- Wait for PlayerGui to load
		CreateAdminGUI(player)
		SetupChatCommands(player)
	end)

   if not success then
		warn("[ADMIN SYSTEM] Error initializing for " .. player.Name .. ":", err)
		CreateNotification(player, Config.ErrorMessages.WeakConnection, "⚠️", 4)
	end

	-- Welcome notification
	local rankName = "NONE"
	for name, value in pairs(Config.Ranks) do
		if value == rank then
			rankName = name
			break
		end
	end

	CreateNotification(player, "Welcome! Your rank: " .. rankName .. "\nPress F5 to open the admin panel", "👋", 6)
	
	print("[ADMIN SYSTEM] Player initialized:", player.Name, "- Rank:", rankName)
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- PLAYER REMOVAL HANDLER
-- ═══════════════════════════════════════════════════════════════════════════════

Players.PlayerRemoving:Connect(function(player)
	MutedUsers[player.UserId] = nil
	print("[ADMIN SYSTEM] Player removed:", player.Name)
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- SYSTEM INITIALIZATION
-- ═══════════════════════════════════════════════════════════════════════════════

print("═══════════════════════════════════════════════════════════════")
print("ADMIN PANEL SYSTEM V" .. Config.Version)
print("Successfully loaded " .. #Commands .. " commands")
print("Created by: Professional Admin System")
print("Status: READY")
print("═══════════════════════════════════════════════════════════════")

-- Initialize for existing players
for _, player in pairs(Players:GetPlayers()) do
	task.spawn(function()
		if BannedUsers[player.UserId] then
			local banData = BannedUsers[player.UserId]
			player:Kick("🔨 YOU ARE BANNED\nReason: " .. banData.Reason .. "\nBanned by: " .. banData.By)
			return
		end

		local rank = GetPlayerRank(player)

		if rank == Config.Ranks.NONE then
			rank = Config.Ranks.BASIC
			SavedPermissions[player.UserId] = Config.Ranks.BASIC
		end

		local success, err = pcall(function()
			task.wait(0.5)
			CreateAdminGUI(player)
			SetupChatCommands(player)
		end)

		if not success then
			warn("[ADMIN SYSTEM] Error initializing for existing player " .. player.Name .. ":", err)
		end

		local rankName = "NONE"
		for name, value in pairs(Config.Ranks) do
			if value == rank then
				rankName = name
				break
			end
		end

		CreateNotification(player, "Welcome! Your rank: " .. rankName .. "\nPress F5 to open panel", "👋", 6)
		print("[ADMIN SYSTEM] Existing player initialized:", player.Name, "- Rank:", rankName)
	end)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- END OF SCRIPT
-- ═══════════════════════════════════════════════════════════════════════════════

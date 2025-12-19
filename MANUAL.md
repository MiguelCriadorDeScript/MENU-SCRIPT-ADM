# ⚡ Professional Admin Panel System V2.0

<div align="center">

![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)
![Roblox](https://img.shields.io/badge/platform-Roblox-red.svg)
![Lua](https://img.shields.io/badge/language-Lua-purple.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Status](https://img.shields.io/badge/status-stable-success.svg)
![Commands](https://img.shields.io/badge/commands-50+-brightgreen.svg)

**A complete and professional administration system for Roblox games**

[Installation](#-installation) • [Commands](#-commands) • [Configuration](#️-configuration) • [Features](#-features) • [Documentation](#-documentation)

![Admin Panel Preview](https://via.placeholder.com/800x400/20202a/ffffff?text=Admin+Panel+System+V2.0)

</div>

---

## 📋 Table of Contents

- [About](#-about)
- [Features](#-features)
- [Requirements](#-requirements)
- [Installation](#-installation)
- [Script Type](#-script-type)
- [Where to Place](#-where-to-place)
- [Configuration](#️-configuration)
- [Available Commands](#-available-commands)
- [Usage](#-usage)
- [Rank System](#-rank-system)
- [FAQ](#-faq)
- [Support](#-support)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🎯 About

The **Professional Admin Panel System V2.0** is a comprehensive and optimized administration system for Roblox games, offering over 50 commands organized into 11 different categories. With a modern interface and support for multiple platforms (PC and Mobile).

### ✨ Highlights

- 🎨 Modern and intuitive interface
- 📱 Full Mobile and PC support
- ⚡ 50+ professional commands
- 🔐 Advanced permission system
- 🎮 Multi-key support (F5, Q, E, Z)
- 📊 Complete logging system
- 🚫 Integrated Ban/Mute system
- 💬 Integrated chat commands
- 🌐 Multiple language support ready
- 🔧 Easy to customize and extend

---

## 🚀 Features

### 📦 Command Categories

| Category | Commands | Description |
|----------|----------|-------------|
| 🛡️ **Moderation** | 3 | Kick, ban, unban players |
| 👥 **Players** | 5 | Kill, heal, god mode, respawn |
| 📍 **Teleport** | 3 | Teleport players anywhere |
| 🏃 **Movement** | 2 | Change speed and jump power |
| 🎭 **Character** | 5 | Freeze, invisible, visibility control |
| ✨ **Effects** | 5 | Sparkles, fire, force fields |
| 🌍 **Environment** | 5 | Time, fog, brightness control |
| 💬 **Communication** | 4 | Mute, unmute, announcements |
| 🎪 **Fun** | 4 | Spin, explode, dance animations |
| ⚙️ **Admin** | 4 | Rank management, logs, shutdown |
| 🔧 **Utility** | 3 | Help, player list, server info |

### 🎨 Interface Features

- **Modern Dark Theme** with smooth animations
- **Categorized Command Browser** with search functionality
- **Command Input Bar** with auto-complete
- **Real-time Notifications** with customizable duration
- **Rank Badge Display** showing your permission level
- **Mobile-Friendly Button** for touch devices
- **Smooth Transitions** using TweenService

### 🔐 Security Features

- **Rank-Based Permission System** with 7 levels
- **Command Execution Logging** with timestamp
- **Ban System** with reason tracking
- **Mute System** for chat moderation
- **Owner Protection** - Owner cannot be banned/kicked
- **Error Handling** to prevent crashes

---

## 📋 Requirements

- **Roblox Studio** (Latest version recommended)
- **Game Creator** or **Owner** permissions
- **FilteringEnabled** must be enabled (default)
- **Basic Lua knowledge** for configuration

---

## 🔧 Installation

### Step 1: Download the Script

1. Go to the [Releases](https://github.com/yourusername/admin-panel-system/releases) page
2. Download the latest `AdminPanelSystem.lua` file
3. Or copy the script directly from the repository

### Step 2: Open Roblox Studio

1. Open your game in **Roblox Studio**
2. Navigate to the **Explorer** window
3. Locate the **ServerScriptService** folder

### Step 3: Insert the Script

1. Right-click on **ServerScriptService**
2. Select **Insert Object** → **Script**
3. Rename the script to `AdminPanelSystem`
4. Paste the entire code into the script

### Step 4: Configure Ranks

```lua
-- RANK ASSIGNMENTS (Add User IDs here)
RankedUsers = {
    [123456789] = "OWNER",    -- Replace with your User ID
    [987654321] = "ADMIN",
    [111222333] = "MOD",
    -- Add more users below:
}
Step 5: Test the System
Click Play to test in Studio
Press F5, Q, E, or Z to open the panel
Test commands using the GUI or chat (/help)
📜 Script Type
⚙️ Script Type: Server Script
This is a SERVER-SIDE SCRIPT (regular Script, NOT LocalScript or ModuleScript).
Why Server Script?
Needs to access server-side services (Players, ReplicatedStorage)
Must enforce security and permissions on the server
Creates GUI for each player from the server
Handles bans, kicks, and moderation server-side
Ensures commands cannot be exploited by clients
🚫 NOT LocalScript
LocalScripts run on the client and can be exploited
Admin commands must be server-authoritative
Security would be compromised
🚫 NOT ModuleScript
ModuleScripts are libraries that need to be required
This system is self-contained and runs automatically
📍 Where to Place
✅ CORRECT LOCATION: ServerScriptService
📁 Game
 └─ 📁 ServerScriptService
     └─ 📄 AdminPanelSystem (Script) ← PLACE HERE
Why ServerScriptService?
✅ Scripts run automatically when the game starts
✅ Server-side execution ensures security
✅ Protected from client access
✅ Standard practice for admin systems
✅ Easily manageable and organized
❌ INCORRECT LOCATIONS
Location
Why Wrong
StarterPlayer
Runs for each player, causes duplicates
StarterGui
For UI only, scripts won't execute
ReplicatedStorage
Accessible by clients, security risk
Workspace
Not organized, can be deleted easily
StarterPack
For tools only
📋 Folder Structure Example
📁 ServerScriptService
 ├─ 📄 AdminPanelSystem (Main Script)
 ├─ 📁 AdminModules (Optional - for organization)
 │   ├─ 📄 CommandHandler
 │   └─ 📄 PermissionManager
 └─ 📄 OtherServerScripts
⚙️ Configuration
🔑 Panel Hotkeys
Configure which keys open the admin panel:
PanelKeys = {
    Enum.KeyCode.F5,  -- F5 key
    Enum.KeyCode.Q,   -- Q key
    Enum.KeyCode.E,   -- E key
    Enum.KeyCode.Z    -- Z key
},
How to Change:
Replace Enum.KeyCode.Q with any key from Roblox KeyCode list
Example: Enum.KeyCode.P for P key
👑 Rank System
The system includes 7 permission levels:
Ranks = {
    OWNER = 5,      -- Full access, cannot be banned
    CREATOR = 4,    -- Almost full access
    ADMIN = 3,      -- Most commands
    MOD = 2,        -- Moderation commands
    VIP = 1,        -- Special user
    BASIC = 0,      -- Can use panel, limited commands
    NONE = -1       -- No access to panel
}
👥 Assigning Ranks
Method 1: Direct User ID Assignment (Recommended)
RankedUsers = {
    -- Format: [UserID] = "RANK_NAME"
    [123456789] = "OWNER",
    [987654321] = "ADMIN",
    [555666777] = "MOD",
    [111222333] = "VIP",
}
How to Find Your User ID:
Go to your Roblox profile
Look at the URL: roblox.com/users/123456789/profile
The number 123456789 is your User ID
Method 2: In-Game Commands (Owner Only)
/setrank PlayerName ADMIN
/setrank PlayerName MOD
/checkrank PlayerName
🎨 Rank Colors
Customize rank badge colors:
Colors = {
    OWNER = Color3.fromRGB(255, 215, 0),    -- Gold
    CREATOR = Color3.fromRGB(138, 43, 226),  -- Purple
    ADMIN = Color3.fromRGB(220, 20, 60),     -- Red
    MOD = Color3.fromRGB(30, 144, 255),      -- Blue
    VIP = Color3.fromRGB(50, 205, 50),       -- Green
    BASIC = Color3.fromRGB(169, 169, 169),   -- Gray
    NONE = Color3.fromRGB(100, 100, 100)     -- Dark Gray
}
📝 Command Prefix
Change the command prefix (default is /):
Prefix = "/",  -- Change to "!", ".", or any character
⚠️ Error Messages
Customize error messages:
ErrorMessages = {
    NoPermission = "❌ Access Denied: You don't have permission",
    InvalidCommand = "❌ Invalid Command: Use /help",
    ExecutionFailed = "❌ Command Failed: An error occurred"
}
📖 Available Commands
🛡️ Moderation Commands
Command
Aliases
Permission
Description
/kick [player] [reason]
boot, remove
MOD
Kick a player from the game
/ban [player] [reason]
permban
ADMIN
Permanently ban a player
/unban [userId]
pardon
ADMIN
Unban a player by User ID
👥 Player Management
Command
Aliases
Permission
Description
/kill [player]
slay
MOD
Kill a player
/heal [player]
restore
MOD
Heal player to full health
/god [player]
immortal
ADMIN
Make player invincible
/ungod [player]
mortal
ADMIN
Remove god mode
/respawn [player]
reload
MOD
Respawn a player
📍 Teleportation
Command
Aliases
Permission
Description
/teleport [p1] [p2]
tp
MOD
Teleport player1 to player2
/bring [player]
summon
MOD
Bring player to you
/goto [player]
to
MOD
Teleport yourself to player
🏃 Movement
Command
Aliases
Permission
Description
/speed [player] [value]
ws
MOD
Change walkspeed (default: 16)
/jump [player] [value]
jp
MOD
Change jump power (default: 50)
🎭 Character
Command
Aliases
Permission
Description
/freeze [player]
fr
MOD
Freeze player in place
/unfreeze [player]
thaw
MOD
Unfreeze player
/invisible [player]
invis
ADMIN
Make player invisible
/visible [player]
vis
ADMIN
Make player visible
/fling [player]
yeet
ADMIN
Fling player into the air
✨ Effects
Command
Aliases
Permission
Description
/sparkles [player]
spark
MOD
Add sparkles effect
/fire [player]
flame
MOD
Add fire effect
/removeeffects [player]
clearfx
MOD
Remove all effects
/forcefield [player]
ff
MOD
Add force field
/unforcefield [player]
unff
MOD
Remove force field
🌍 Environment
Command
Aliases
Permission
Description
/time [0-24]
settime
ADMIN
Change time of day
/day
-
ADMIN
Set time to day (12)
/night
-
ADMIN
Set time to night (0)
/fogend [distance]
fog
ADMIN
Set fog distance
/brightness [value]
bright
ADMIN
Set lighting brightness
💬 Communication
Command
Aliases
Permission
Description
/mute [player]
silence
MOD
Mute a player
/unmute [player]
unsilence
MOD
Unmute a player
/message [text]
msg
ADMIN
Send server message
/announce [text]
broadcast
ADMIN
Big announcement
🎪 Fun Commands
Command
Aliases
Permission
Description
/spin [player] [speed]
rotate
MOD
Make player spin
/unspin [player]
stopspin
MOD
Stop spinning
/explode [player]
boom
ADMIN
Create explosion
/dance [player]
boogie
MOD
Make player dance
⚙️ Admin Commands
Command
Aliases
Permission
Description
/setrank [player] [rank]
rank
OWNER
Set player rank
/checkrank [player]
getrank
BASIC
Check player's rank
/logs [amount]
cmdlogs
ADMIN
View command logs
/shutdown
closeserver
OWNER
Shutdown server
🔧 Utility Commands
Command
Aliases
Permission
Description
/help [category]
commands, cmds
BASIC
List all commands
/players
list, who
BASIC
List all players
/serverinfo
sinfo
BASIC
Display server info
💡 Usage
🖥️ PC Users
Open Panel:
Press F5, Q, E, or Z key
Browse Commands:
Click on a category in the left sidebar
View available commands in the main area
Execute Commands:
Method 1: Click on a command button (auto-fills input)
Method 2: Type command manually in the input bar
Method 3: Use chat: /kick player reason
Close Panel:
Press the X button
Press any panel key again
📱 Mobile Users
Open Panel:
Tap the floating 💬 button in the bottom-right
Browse Commands:
Tap on categories to view commands
Scroll through command list
Execute Commands:
Tap a command to auto-fill
Type manually in the input box
Use chat commands
Close Panel:
Tap the X button
Tap the floating button again
📝 Command Examples
Player Targeting:
/kick John Spamming chat          ← Kicks player "John"
/heal me                          ← Heals yourself
/speed all 50                     ← Sets everyone's speed to 50
/god others                       ← Makes everyone except you invincible
/bring random                     ← Brings a random player
Special Targets:
me - Yourself
all - All players
others - All players except you
random - Random player
Partial names work: /kick jo targets "John"
🎖️ Rank System
Permission Levels
OWNER (5)    ├─ Full access, cannot be banned/kicked
             │
CREATOR (4)  ├─ Almost full access
             │
ADMIN (3)    ├─ Most commands (ban, admin tools)
             │
MOD (2)      ├─ Moderation (kick, mute, basic commands)
             │
VIP (1)      ├─ Special user (limited commands)
             │
BASIC (0)    ├─ Can access panel (help, info commands)
             │
NONE (-1)    └─ No panel access
Rank Assignment Guide
Automatic Owner:
Game creator is automatically OWNER rank
Cannot be changed or removed
Manual Assignment (Pre-Game):
RankedUsers = {
    [123456789] = "ADMIN",  -- Trusted administrator
    [987654321] = "MOD",    -- Moderator
    [555666777] = "VIP",    -- VIP player
}
In-Game Assignment (Owner Only):
/setrank PlayerName ADMIN
/setrank PlayerName MOD
/setrank PlayerName VIP
/setrank PlayerName BASIC
/setrank PlayerName NONE
Check Ranks:
/checkrank PlayerName
/checkrank me
Rank Permissions Table
Rank
Moderation
Players
Teleport
Effects
Environment
Admin
OWNER
✅
✅
✅
✅
✅
✅
CREATOR
✅
✅
✅
✅
✅
⚠️
ADMIN
✅
✅
✅
✅
✅
⚠️
MOD
⚠️
✅
✅
✅
❌
❌
VIP
❌
⚠️
⚠️
⚠️
❌
❌
BASIC
❌
❌
❌
❌
❌
❌
NONE
❌
❌
❌
❌
❌
❌
✅ Full Access | ⚠️ Limited Access | ❌ No Access
❓ FAQ
General Questions
Q: Where do I get my User ID?
A: Go to your Roblox profile. The URL will be:
   roblox.com/users/123456789/profile
   Your User ID is the number: 123456789
Q: Can I change the hotkeys?
A: Yes! Edit the PanelKeys table in Config:
   PanelKeys = {
       Enum.KeyCode.P,  -- Change F5 to P
       Enum.KeyCode.L,  -- Change Q to L
   }
Q: How do I add more admins?
A: Add their User ID to RankedUsers:
   RankedUsers = {
       [YourUserID] = "OWNER",
       [FriendUserID] = "ADMIN",
   }
Q: Does this work with FE (FilteringEnabled)?
A: Yes! The system is fully FE-compatible and
   runs server-side for security.
Technical Questions
Q: Is this script a LocalScript or Script?
A: This is a SERVER SCRIPT (regular Script).
   Place it in ServerScriptService only.
Q: Why doesn't the GUI show up?
A: Check these:
   1. Script is in ServerScriptService
   2. You have BASIC rank or higher
   3. No errors in Output window
   4. Try rejoining the game
Q: Commands don't work in chat
A: Check:
   1. Using correct prefix (default: /)
   2. Command spelling is correct
   3. You have permission for that command
   4. Check Output for errors
Q: Can exploiters use this?
A: No! The system is server-side and fully
   protected. Exploiters cannot gain access.
Troubleshooting
Problem: "Access Denied" error
Solution:
1. Check your rank in Config.RankedUsers
2. Use /checkrank me to verify
3. Ensure your User ID is correct
4. Game creator is always OWNER
Problem: Panel doesn't open
Solution:
1. Check Console for errors (F9)
2. Verify script is in ServerScriptService
3. Try different hotkeys (F5, Q, E, Z)
4. Check if you have BASIC rank or higher
Problem: Commands execute but nothing happens
Solution:
1. Check Output window for errors
2. Verify target player name is correct
3. Some commands need specific permissions
4. Try /help to see available commands
Problem: Mobile button doesn't appear
Solution:
1. The button only shows on mobile devices
2. Test on actual mobile device, not emulator
3. Check if TouchEnabled is true
4. Verify script has no errors
🛠️ Customization
Adding Custom Commands
-- Add this code after the existing commands
RegisterCommand({
    Name = "fly",
    Aliases = {"levitate"},
    Description = "Make player fly",
    Usage = "/fly [player]",
    Category = "Fun",
    Icon = "🕊️",
    Permission = Config.Ranks.ADMIN,
    Execute = function(executor, args)
        local targets = FindPlayer(args[1], executor)
        for _, target in pairs(targets) do
            -- Your fly code here
            CreateNotification(executor, "Player is flying", "🕊️", 2)
        end
    end
})
Creating New Categories
-- Commands with new categories are automatically added to sidebar
RegisterCommand({
    Name = "mycommand",
    Category = "My New Category",  -- New category!
    Icon = "🎯",
    -- ... rest of command
})
Changing GUI Colors
-- Find these lines in CreateAdminGUI function:
mainPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)  -- Main panel
header.BackgroundColor3 = Color3.fromRGB(25, 25, 30)      -- Header
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)     -- Sidebar
Notification Customization
-- Duration: Time in seconds
CreateNotification(player, "Message", "Icon", 5)  -- 5 seconds

-- Custom colors in notification frame:
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)  -- Dark theme
🤝 Contributing
Contributions are welcome! Here's how you can help:
How to Contribute
Fork the Repository
Click the "Fork" button at the top right
Clone Your Fork
git clone https://github.com/yourusername/admin-panel-system.git
Create a Branch
git checkout -b feature/AmazingFeature
Make Changes
Add new commands
Fix bugs
Improve documentation
Optimize code
Commit Changes
git commit -m "Add: Amazing new feature"
Push to Branch
git push origin feature/AmazingFeature
Open Pull Request
Go to your fork on GitHub
Click "Pull Request"
Describe your changes
Contribution Guidelines
✅ Follow existing code style
✅ Test thoroughly before submitting
✅ Comment your code
✅ Update documentation
✅ One feature per pull request
💬 Support
Get Help
📖 Documentation: Read this README and SETUP.md
🐛 Bug Reports: Open an issue
💡 Feature Requests: Request a feature
💬 Discord: Join our server
📧 Email: support@yourdomain.com
Reporting Issues
When reporting bugs, please include:
Roblox Studio version
Script location (ServerScriptService)
Error messages from Output
Steps to reproduce
Expected vs actual behavior
Example:
**Bug:** Commands don't execute
**Location:** ServerScriptService/AdminPanelSystem
**Error:** "attempt to index nil with 'Humanoid'"
**Steps:** 
1. Open admin panel
2. Click /heal command
3. Type player name
4. Press Execute
**Expected:** Player heals
**Actual:** Error in output
📄 License
This project is licensed under the MIT License - see the LICENSE file for details.
MIT License

Copyright (c) 2024 Your Name

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
🙏 Acknowledgments
Roblox Developer Community for inspiration and support
All Contributors who have helped improve this system
Beta Testers for finding bugs and suggesting features
You for using this admin system!
📊 Statistics
�

�
�
�
�
Carregar imagem
Carregar imagem
Carregar imagem
Carregar imagem
⭐ If you find this useful, please star the repository! ⭐
�

�

Made with ❤️ for the Roblox Community
⬆ Back to Top
�
```
📄 FILE 2: SETUP.md
# 🔧 Setup Guide - Admin Panel System V2.0

<div align="center">

**Complete step-by-step installation and configuration guide**

[Quick Start](#-quick-start) • [Detailed Setup](#-detailed-setup) • [Configuration](#️-configuration) • [Testing](#-testing)

</div>

---

## 📋 Table of Contents

1. [Prerequisites](#-prerequisites)
2. [Quick Start (5 Minutes)](#-quick-start)
3. [Detailed Setup](#-detailed-setup)
4. [Script Type Explanation](#-script-type-explanation)
5. [Placement Guide](#-placement-guide)
6. [Rank Configuration](#-rank-configuration)
7. [Testing Your Setup](#-testing-your-setup)
8. [Common Issues](#-common-issues)
9. [Advanced Configuration](#-advanced-configuration)

---

## ✅ Prerequisites

Before you begin, make sure you have:

- [ ] **Roblox Studio** installed (latest version)
- [ ] **A Roblox game** (or create a new one)
- [ ] **Studio editing permissions** (you must be the creator)
- [ ] **Your Roblox User ID** (find it in your profile URL)
- [ ] **Basic understanding** of Roblox Studio interface

### Finding Your User ID

1. Go to [Roblox.com](https://www.roblox.com)
2. Log in to your account
3. Click on your profile
4. Look at the URL: `roblox.com/users/123456789/profile`
5. Your User ID is: `123456789`

**✏️ Write it down:** _____________________

---

## ⚡ Quick Start

### 5-Minute Installation
Copy the entire script code
Open Roblox Studio
Find ServerScriptService in Explorer
Insert a new Script (NOT LocalScript)
Name it "AdminPanelSystem"
Paste the code
Replace User ID with yours in Config.RankedUsers
Click Play to test
Press F5 to open admin panel
Done! ✅
---

## 📖 Detailed Setup

### Step 1: Open Your Game

1. Launch **Roblox Studio**
2. Click **File** → **Open from Roblox**
3. Select your game or click **New** to create one

![Studio Screenshot](https://via.placeholder.com/600x300/20202a/ffffff?text=Open+Roblox+Studio)

---

### Step 2: Locate ServerScriptService

1. Look for the **Explorer** window (usually on the right)
2. Find the **ServerScriptService** folder
3. If you can't see it:
   - Click **View** → **Explorer** in the top menu
📁 Workspace
📁 Players
📁 Lighting
📁 ReplicatedFirst
📁 ReplicatedStorage
📁 ServerScriptService  ← HERE!
📁 ServerStorage
📁 StarterGui
📁 StarterPack
📁 StarterPlayer
📁 SoundService
Step 3: Insert the Script
Method 1: Manual Creation (Recommended)
Right-click on ServerScriptService
Select Insert Object
Choose Script (NOT LocalScript!)
The script appears with default name "Script"
�
Method 2: Keyboard Shortcut
Click on ServerScriptService
Press Ctrl + Shift + N (Windows) or Cmd + Shift + N (Mac)
Type "Script" and press Enter
Step 4: Rename the Script
Right-click the new script
Select Rename
Type: AdminPanelSystem
Press Enter
Result:
📁 ServerScriptService
 └─ 📄 AdminPanelSystem ✅
Step 5: Paste the Code
Double-click the AdminPanelSystem script
The script editor opens
Select all default code (Ctrl + A)
Delete it
Paste the Admin Panel System code
The script should now have 1200+ lines
Verification:
Check bottom-right corner: Should show "Line 1/1200+"
Code should start with: -- ═══════════════...
No red underlines or syntax errors
Step 6: Configure Your User ID
Find this section (around line 30-40):
-- RANK ASSIGNMENTS (Add User IDs here)
RankedUsers = {
    -- Example: [123456789] = "OWNER",
    -- Example: [987654321] = "ADMIN",
    -- Example: [111222333] = "MOD",
    -- Add your user IDs below:
    -- [000000000] = "RANK_NAME",
},
Replace with your User ID:
RankedUsers = {
    [123456789] = "OWNER",    -- ← Replace 123456789 with YOUR User ID
    -- Add friends below:
    [987654321] = "ADMIN",    -- Friend 1
    [555666777] = "MOD",      -- Friend 2
},
⚠️ Important:
Remove the -- comment markers
Use square brackets [ ] around numbers
Use quotes around rank names: "OWNER"
Add comma after each line (except last)
Step 7: Save Your Work
Press Ctrl + S (Windows) or Cmd + S (Mac)
Or click File → Save to Roblox
Wait for "Game saved successfully" message
Step 8: Test the System
Click the Play button (F5) in Studio
Wait for game to load
Press F5 (or Q, E, Z) to open admin panel
Admin panel should appear with smooth animation
Expected Result:
✅ Dark panel slides down from top
✅ "ADMIN CONTROL PANEL V2.0" title visible
✅ Categories in left sidebar
✅ Commands in main area
✅ Command input bar at bottom
✅ Your rank badge shows in header
🎯 Script Type Explanation
Understanding Script Types in Roblox
Roblox has three main script types:
1. 📄 Script (Server Script)
✅ USE THIS FOR ADMIN PANEL
Characteristics:
Runs on the server
Has access to server-side services
Can modify player data
Cannot be exploited by clients
Starts automatically when game loads
Security: HIGH 🔒
Location: ServerScriptService, ServerStorage, Workspace
Example Use Cases:
Admin systems ✅
Ban/kick systems ✅
Server-side game logic ✅
Data persistence ✅
2. 📜 LocalScript
❌ DON'T USE FOR ADMIN PANEL
Characteristics:
Runs on the client (player's device)
Only affects that specific player
Can be exploited by hackers
No server authority
Security: LOW ⚠️
Location: StarterPlayer, StarterGui, Player's Backpack
Example Use Cases:
UI animations
Camera effects
Player input handling
Client-side visuals
Why NOT for Admin:
❌ Exploiters can modify LocalScripts
❌ Commands would only work for that player
❌ No server authority for kicks/bans
❌ Security vulnerability
3. 📦 ModuleScript
❌ DON'T USE AS MAIN SCRIPT
Characteristics:
Library/utility script
Must be require()d by other scripts
Doesn't run automatically
Used for code organization
Security: Depends on usage
Location: ReplicatedStorage, ServerStorage, ServerScriptService
Example Use Cases:
Shared functions
Configuration files
Utility libraries
Data structures
Why NOT as Main Script:
❌ Doesn't run automatically
❌ Needs to be required
❌ Admin panel needs to start on its own
Visual Comparison
Feature
Script
LocalScript
ModuleScript
Runs On
Server
Client
N/A (Library)
Auto-Start
✅ Yes
✅ Yes
❌ No
Security
🔒 High
⚠️ Low
Varies
Server Access
✅ Yes
❌ No
Depends
For Admin Panel
✅ CORRECT
❌ Wrong
❌ Wrong
📍 Placement Guide
✅ Correct Placement: ServerScriptService
📁 Game Hierarchy
 │
 ├─ 📁 Workspace (❌ Don't place here)
 ├─ 📁 Players (❌ Don't place here)
 ├─ 📁 Lighting (❌ Don't place here)
 ├─ 📁 ReplicatedFirst (❌ Don't place here)
 ├─ 📁 ReplicatedStorage (❌ SECURITY RISK!)
 ├─ 📁 ServerScriptService (✅ PLACE HERE!)
 │   └─ 📄 AdminPanelSystem
 ├─ 📁 ServerStorage (⚠️ Works but not standard)
 ├─ 📁 StarterGui (❌ Wrong - for UI only)
 ├─ 📁 StarterPack (❌ Wrong - for tools)
 └─ 📁 StarterPlayer (❌ Don't place here)
Why ServerScriptService?
✅ Advantages
Security
Protected from client access
Cannot be viewed/modified by exploiters
Server-side execution only
Automatic Execution
Runs when server starts
No need for manual loading
Always active
Standard Practice
Industry standard location
Easy for other developers to find
Clear organization
Persistence
Doesn't reset with player spawns
Runs once per server
Reliable and stable
❌ Why NOT Other Locations?
ReplicatedStorage
❌ SECURITY RISK!
- Clients can access scripts here
- Exploiters can read your code
- Admin system would be compromised
Workspace
❌ Poor Organization
- Gets cluttered quickly
- Can be accidentally deleted
- Not protected
StarterGui
❌ Wrong Purpose
- For UI templates only
- Scripts here clone to players
- Would create duplicate admin systems
StarterPlayer
❌ Runs Per-Player
- Creates one instance per player
- Multiple admin systems running
- Server performance issues
Folder Organization (Optional)
For large games, organize like this:
📁 ServerScriptService
 │
 ├─ 📁 AdminSystem
 │   ├─ 📄 AdminPanelSystem (Main)
 │   ├─ 📄 CommandHandler (Optional)
 │   └─ 📄 PermissionManager (Optional)
 │
 ├─ 📁 GameSystems
 │   ├─ 📄 LeaderboardSystem
 │   └─ 📄 DataStoreManager
 │
 └─ 📁 OtherScripts
     └─ 📄 CustomScript
👑 Rank Configuration
Understanding Ranks
The system has 7 permission levels:
Level 5: OWNER    ═══════════════════ Full Access
Level 4: CREATOR  ═══════════════════ High Access
Level 3: ADMIN    ═══════════════════ Administrative Access
Level 2: MOD      ═══════════════════ Moderation Access
Level 1: VIP      ═══════════════════ Special User
Level 0: BASIC    ═══════════════════ Limited Access
Level -1: NONE    ═══════════════════ No Access
Rank Assignment Methods
Method 1: Pre-Game (Config File)
Location: Line ~30-40 in the script
RankedUsers = {
    [123456789] = "OWNER",     -- Your User ID
    [987654321] = "ADMIN",     -- Friend 1
    [555666777] = "MOD",       -- Friend 2
    [111222333] = "VIP",       -- Friend 3
},
Steps:
Find each person's User ID
Add line: [UserID] = "RANK",
Save the script
Ranks apply on next join
✅ Pros:
Permanent ranks
Works immediately
Easy to manage multiple users
❌ Cons:
Requires script editing
Need User IDs beforehand
Method 2: In-Game (Commands)
Requirements: Must be OWNER rank
-- Give someone Admin
/setrank PlayerName ADMIN

-- Give someone Mod
/setrank PlayerName MOD

-- Remove admin
/setrank PlayerName BASIC

-- Check someone's rank
/checkrank PlayerName
✅ Pros:
No script editing needed
Quick adjustments
Can demote users
❌ Cons:
Only lasts for current session
Owner only
Doesn't save permanently (in this version)
Rank Permission Matrix
Command Category
OWNER
CREATOR
ADMIN
MOD
VIP
BASIC
Moderation






kick
✅
✅
✅
✅
❌
❌
ban
✅
✅
✅
❌
❌
❌
unban
✅
✅
✅
❌
❌
❌
Players






kill
✅
✅
✅
✅
❌
❌
heal
✅
✅
✅
✅
❌
❌
god
✅
✅
✅
❌
❌
❌
respawn
✅
✅
✅
✅
❌
❌
Teleport






tp
✅
✅
✅
✅
❌
❌
bring
✅
✅
✅
✅
❌
❌
goto
✅
✅
✅
✅
❌
❌
Effects






sparkles
✅
✅
✅
✅
❌
❌
fire
✅
✅
✅
✅
❌
❌
ff
✅
✅
✅
✅
❌
❌
Environment






time
✅
✅
✅
❌
❌
❌
day/night
✅
✅
✅
❌
❌
❌
fog
✅
✅
✅
❌
❌
❌
Admin






setrank
✅
❌
❌
❌
❌
❌
logs
✅
✅
✅
❌
❌
❌
shutdown
✅
❌
❌
❌
❌
❌
Utility






help
✅
✅
✅
✅
✅
✅
players
✅
✅
✅
✅
✅
✅
serverinfo
✅
✅
✅
✅
✅
✅
Rank Configuration Examples
Small Game (Few Admins)
RankedUsers = {
    [123456789] = "OWNER",    -- You
    [987654321] = "ADMIN",    -- Best friend
    [555666777] = "MOD",      -- Trusted helper
},
Medium Game (Team of Admins)
RankedUsers = {
    [123456789] = "OWNER",    -- Owner
    [111111111] = "OWNER",    -- Co-owner
    
    [222222222] = "ADMIN",    -- Head Admin
    [333333333] = "ADMIN",    -- Admin 2
    [444444444] = "ADMIN",    -- Admin 3
    
    [555555555] = "MOD",      -- Moderator 1
    [666666666] = "MOD",      -- Moderator 2
    [777777777] = "MOD",      -- Moderator 3
    [888888888] = "MOD",      -- Moderator 4
    
    [999999999] = "VIP",      -- Special player
},
Large Game (Many Staff)
RankedUsers = {
    -- === OWNERSHIP ===
    [123456789] = "OWNER",
    [111111111] = "OWNER",
    
    -- === SENIOR ADMIN ===
    [222222222] = "CREATOR",
    [333333333] = "CREATOR",
    
    -- === ADMINISTRATORS ===
    [444444444] = "ADMIN",
    [555555555] = "ADMIN",
    [666666666] = "ADMIN",
    [777777777] = "ADMIN",
    [888888888] = "ADMIN",
    
    -- === MODERATORS ===
    [901234567] = "MOD",
    [902345678] = "MOD",
    [903456789] = "MOD",
    [904567890] = "MOD",
    [905678901] = "MOD",
    [906789012] = "MOD",
    [907890123] = "MOD",
    [908901234] = "MOD",
    
    -- === VIP PLAYERS ===
    [910123456] = "VIP",
    [920123456] = "VIP",
    [930123456] = "VIP",
},
🧪 Testing Your Setup
Pre-Flight Checklist
Before testing, verify:
[ ] Script is in ServerScriptService
[ ] Script is named AdminPanelSystem
[ ] Script is a Script (not LocalScript)
[ ] Your User ID is added to RankedUsers
[ ] No syntax errors (no red underlines)
[ ] Script is saved (Ctrl + S)
Test 1: Basic Functionality
Click Play button in Studio
Wait for game to load completely
Press F5 (or Q, E, Z)
Expected:
✅ Panel slides down smoothly
✅ Title shows "ADMIN CONTROL PANEL V2.0"
✅ Your rank badge appears (OWNER)
✅ Categories visible in sidebar
✅ Commands show in main area
If Nothing Happens:
Open Output (View → Output or F9)
Look for error messages
Check Common Issues section
Test 2: Command Execution
Open admin panel (F5)
Click on "Players" category
Click "/heal" command
Type: me
Click "EXECUTE" button
Expected:
✅ Your character heals to full health
✅ Notification appears: "Healed 1 player(s)"
✅ No errors in Output window
Test 3: Chat Commands
Open chat (press / key)
Type: /help
Press Enter
Expected:
✅ Notification appears with available categories
✅ Shows: "Available Categories: Moderation, Players..."
✅ No errors in Output
Test 4: Multi-Key Support
Test all hotkeys:
Close panel (X button)
Press F5 → Panel opens ✅
Close panel
Press Q → Panel opens ✅
Close panel
Press E → Panel opens ✅
Close panel
Press Z → Panel opens ✅
Test 5: Mobile Support (Optional)
Click Home → Emulation
Select Phone or Tablet
Click Play
Look for 💬 button (bottom-right)
Tap the button
Expected:
✅ Floating button visible
✅ Panel opens when tapped
✅ Touch controls work
✅ Commands execute properly
Test 6: Permission System
Open panel (F5)
Try command: /setrank
Check rank: /checkrank me
Expected (as OWNER):
✅ All commands visible
✅ setrank works
✅ Shows "Your rank: OWNER"
✅ Can execute any command
Test 7: Error Handling
Type invalid command: /invalidcommand
Type wrong syntax: /kick
Try restricted command (test with BASIC rank)
Expected:
✅ Shows error notification
✅ "Invalid Command: Use /help"
✅ "Access Denied" for restricted commands
✅ No script crashes
⚠️ Common Issues
Issue 1: Panel Doesn't Open
Symptoms:
Press F5/Q/E/Z, nothing happens
No errors in Output
Solutions:
Check Your Rank
-- Add yourself to RankedUsers
RankedUsers = {
    [YOUR_USER_ID] = "OWNER",
}
Verify Script Location
Must be in: ServerScriptService
NOT in: ReplicatedStorage, StarterGui, etc.
Check Script Type
Must be: Script (server script)
NOT: LocalScript or ModuleScript
Test in Actual Game
- Stop Studio test
- Publish game
- Join from Roblox website
Issue 2: "Access Denied" Error
Symptoms:
Panel opens but shows "Access Denied"
Can't execute any commands
Solutions:
Verify User ID
-- Double-check your User ID
print(game.Players.LocalPlayer.UserId) -- Run in Command Bar
Check Rank Assignment
RankedUsers = {
    [123456789] = "OWNER",  -- Make sure no typos
}
Use Correct Format
-- CORRECT:
[123456789] = "OWNER",

-- WRONG:
["123456789"] = "OWNER",  -- No quotes on number
[123456789] = OWNER,      // No quotes on rank
Issue 3: Commands Don't Work
Symptoms:
Panel opens fine
Commands execute but nothing happens
No visual feedback
Solutions:
Check Target Player
/heal me         ← Targets yourself
/heal PlayerName ← Exact player name
/heal all        ← All players
Verify Player Exists
Use /players to see who's in game
Names are case-sensitive
Check Output Window
Press F9
Look for error messages
Red text indicates problems
Issue 4: Script Errors
Symptoms:
Red underlines in script
Errors in Output window
"attempt to index nil" errors
Solutions:
Re-copy Script
- Delete current script
- Insert new Script
- Paste code again
- Make sure entire code copied
Check Line Numbers
Script should have 1200+ lines
If less, code is incomplete
Verify Syntax
-- Check for missing commas
RankedUsers = {
    [123] = "OWNER",   ← Comma here
    [456] = "ADMIN",   ← Comma here
}                      ← No comma on last line
Issue 5: Mobile Button Not Showing
Symptoms:
Testing on mobile
No 💬 button visible
Solutions:
Test on Real Device
Emulator might not work
Publish game and test on phone
Check Device Type
-- Button only shows if:
UserInputService.TouchEnabled == true
UserInputService.KeyboardEnabled == false
Verify Script Running
Check Output window for errors
Make sure script loaded properly
Issue 6: GUI Overlapping
Symptoms:
Admin panel overlaps other GUIs
Can't close panel
Buttons not clickable
Solutions:
Adjust DisplayOrder
-- In CreateAdminGUI function, find:
screenGui.DisplayOrder = 999  -- Increase this number
Check Other GUIs
Temporarily disable other UI scripts
Test if admin panel works alone
Issue 7: Ranks Not Saving
Symptoms:
Set rank in-game with /setrank
Player rejoins, rank is gone
This is Expected Behavior:
In-game rank changes are temporary
They reset when player leaves

To make permanent:
Add User ID to RankedUsers in script
🔧 Advanced Configuration
Customizing Hotkeys
Find this section:
PanelKeys = {
    Enum.KeyCode.F5,
    Enum.KeyCode.Q,
    Enum.KeyCode.E,
    Enum.KeyCode.Z
},
Change to custom keys:
PanelKeys = {
    Enum.KeyCode.P,      -- P key
    Enum.KeyCode.L,      -- L key
    Enum.KeyCode.K,      -- K key
},
Available Keys:
Letters: A through Z
Numbers: Zero through Nine
Function: F1 through F12
Special: LeftShift, RightShift, LeftControl, etc.
Full list: Roblox KeyCode Enum
Changing Command Prefix
Default: /
Change to different prefix:
Prefix = "!",   -- Use ! instead of /
Prefix = ".",   -- Use . instead of /
Prefix = "#",   -- Use # instead of /
Now use commands like:
!kick player
.heal me
#help
Customizing Colors
Rank Badge Colors:
Colors = {
    OWNER = Color3.fromRGB(255, 215, 0),    -- Gold
    ADMIN = Color3.fromRGB(255, 0, 0),       // Bright Red
    MOD = Color3.fromRGB(0, 255, 0),         // Bright Green
}
Panel Colors:
-- In CreateAdminGUI function:
mainPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
header.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Adding Custom Messages
Welcome Message:
-- Find in PlayerAdded function:
CreateNotification(player, 
    "Welcome " .. player.Name .. "!\nYour rank: " .. rankName,
    "👋", 6
)
Custom Error Messages:
ErrorMessages = {
    NoPermission = "🚫 You don't have access to this!",
    InvalidCommand = "❌ That command doesn't exist!",
    ExecutionFailed = "⚠️ Something went wrong!",
}
Performance Optimization
For Large Servers (50+ players):
-- Reduce notification duration
CreateNotification(player, message, icon, 2)  -- 2 seconds instead of 4

-- Limit command logs
if #CommandLogs > 100 then  -- Reduce from 500 to 100
    table.remove(CommandLogs, 1)
end

-- Disable animations (if needed)
local tweenIn = TweenService:Create(frame, 
    TweenInfo.new(0.2),  -- Faster animation (was 0.5)
    {Position = targetPosition}
)
✅ Verification Checklist
Use this checklist to ensure everything is set up correctly:
Installation
[ ] Script placed in ServerScriptService
[ ] Script named AdminPanelSystem
[ ] Script type is Script (not LocalScript)
[ ] Code has 1200+ lines
[ ] No syntax errors (red underlines)
Configuration
[ ] Your User ID added to RankedUsers
[ ] User ID format: [123456789] = "OWNER"
[ ] Rank name in quotes: "OWNER"
[ ] Commas after each entry
[ ] No comma on last entry
Testing
[ ] Panel opens with F5/Q/E/Z
[ ] Your rank badge shows correctly
[ ] Commands appear in categories
[ ] Notifications work properly
[ ] Chat commands function (/help)
[ ] No errors in Output window
Functionality
[ ] Can execute commands successfully
[ ] Target players work (me, all, others)
[ ] Permission system works correctly
[ ] Mobile button visible on mobile
[ ] Close button works
[ ] Panel animations smooth
📞 Getting Help
If you're still having issues:
Check Output Window (F9)
Look for error messages
Red text shows problems
Note the line number
Verify Setup
Use verification checklist above
Double-check each step
Compare with examples
Common Issues Section
Read all common issues
Try suggested solutions
Test after each fix
Ask for Help
Include error messages
Describe what you tried
Show your configuration
Mention Roblox Studio version
Support Channels:
GitHub Issues
Discord Server
Roblox DevForum
Email Support
🎓 Next Steps
Now that your admin panel is set up:
Learn Commands
Try each command category
Test different targets (me, all, others)
Practice with friends
Add Admin Team
Get friends' User IDs
Add them to RankedUsers
Assign appropriate ranks
Customize
Change hotkeys if desired
Adjust colors to match game
Add custom messages
Advanced Features
Create custom commands
Add new categories
Integrate with game systems
Keep Updated
Check for new versions
Read update notes
Backup current version
📚 Additional Resources
Roblox Developer Hub
Lua Programming Guide
Admin System Best Practices
Studio Shortcuts
�

✅ Setup Complete!
You now have a fully functional admin panel system!
⬆ Back to Top
�
```

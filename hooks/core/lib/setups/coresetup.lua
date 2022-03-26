local modPath = ModPath

local function stringReplace(string, search, replace)
    return string:gsub(search, replace)
end

modPath = stringReplace(modPath, "\\", "/")

if modPath:sub(-1, -1) == "/" then
    modPath = modPath:sub(1, -2)
end

dofile(modPath .. "/libraries/DebugLogClass.lua")

dofile(modPath .. "/classes/UT.lua")
dofile(modPath .. "/classes/Utils.lua")

UT.modPath = modPath
UT:loadSettings()

dofile(modPath .. "/classes/Tables.lua")
dofile(modPath .. "/classes/AntiCheatChecker.lua")
dofile(modPath .. "/classes/Construction.lua")
dofile(modPath .. "/classes/Dexterity.lua")
dofile(modPath .. "/classes/Driving.lua")
dofile(modPath .. "/classes/GroupSpawn.lua")
dofile(modPath .. "/classes/Instant.lua")
dofile(modPath .. "/classes/Keybinds.lua")
dofile(modPath .. "/classes/Mission.lua")
dofile(modPath .. "/classes/Player.lua")
dofile(modPath .. "/classes/Spawn.lua")
dofile(modPath .. "/classes/Time.lua")
dofile(modPath .. "/classes/Unlocker.lua")
dofile(modPath .. "/classes/Updater.lua")

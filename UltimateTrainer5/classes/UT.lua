UT = {}

UT.version = "5.3.0"
UT.threadUrl = "https://www.unknowncheats.me/forum/payday-2-a/491561-payday-2-ultimate-trainer-5-a.html"

UT.supportedLocales = {
    "chs",
    "en",
    "es",
    "fr",
    "ru"
}

UT.modPath = nil

UT.settings = {}

UT.saveFilesNames = {}
UT.saveFilesNames.settings = "ut-settings.json"
UT.saveFilesNames.bltData = "blt_data.txt"

UT.colors = {
    white = Color("ffffff"),
    info = Color("0000ff"),
    success = Color("00ff00"),
    warning = Color("ffff00"),
    danger = Color("ff0000")
}

UT.Extras = {}

UT.keybinds = {
    {id = "UTKeybindOpenMenu", pc = "f1"},
    {id = "UTKeybindConstructionPick", pc = "f2"},
    {id = "UTKeybindConstructionSpawn", pc = "f3"},
    {id = "UTKeybindConstructionDelete", pc = "f4"},
    {id = "UTKeybindSpawnPrevious", pc = "mouse wheel up"},
    {id = "UTKeybindSpawnNext", pc = "mouse wheel down"},
    {id = "UTKeybindSpawnPlace", pc = "mouse 2"},
    {id = "UTKeybindTeleport", pc = "h"},
    {id = "UTKeybindReplenish", pc = "right alt"}
}

UT.fakeMaxInteger = 1000000000000000000000000000000

function UT:init()
    UT:setSetting("initialized_version", UT.version)
    if UT:getSetting("enable_anti_cheat_checker") == nil then
        UT:setSetting("enable_anti_cheat_checker", true)
    end

    local bltData = UT:getBltData()
    bltData.keybinds = {}
    for key, value in pairs(UT.keybinds) do
        table.insert(bltData.keybinds, value)
    end
    UT:setBltData(bltData)

    local title = UT:getLocalizedText("ut_popup_first_launch_title")
    local message = UT:getLocalizedText("ut_popup_first_launch_message")
    local options = {
        {
            text = UT:getLocalizedText("ut_exit"),
            callback = UT.exitGame
        }
    }
    QuickMenu:new("Ultimate Trainer - " .. title, message, options):Show()
end

function UT:loadSettings()
    UT.settings = UT.Utils:getSaveTable(UT.saveFilesNames.settings)
    return true
end

function UT:saveSettings()
    return UT.Utils:setSaveTable(UT.saveFilesNames.settings, UT.settings)
end

function UT:getSetting(name)
    return UT.settings[name]
end

function UT:infiniteEquipmentToggle()
    if not UT:isInGame() then
        return
    end

    _G.CloneClass(PlayerManager)

    local is_infinite = UT:getSetting("infinite_equipment")
    if is_infinite then
        PlayerManager.remove_equipment = PlayerManager.orig.remove_equipment
        UT:setSetting("infinite_equipment", false)
    else
	    function PlayerManager:remove_equipment() end
        UT:setSetting("infinite_equipment", true)
    end

    UT:saveSettings()
end

function UT.interactWithAnythingToggle()
    if not UT:isInGame() then
        return
    end

    _G.CloneClass(BaseInteractionExt)

    local is_interact = UT:getSetting("interact_with_anything")
    if is_interact then
        BaseInteractionExt.can_interact = BaseInteractionExt.orig.can_interact
        UT:setSetting("interact_with_anything", false)
    else
        function BaseInteractionExt:can_interact() return true end
        UT:setSetting("interact_with_anything", true)
    end

    UT:saveSettings()
end

function UT.bypassUpgradesToggle()
    if not UT:isInGame() then
        return
    end

    _G.CloneClass(BaseInteractionExt)

    local is_bypass = UT:getSetting("bypass_upgrades")
    if is_bypass then
        BaseInteractionExt._has_required_upgrade = BaseInteractionExt.orig._has_required_upgrade
        UT:setSetting("bypass_upgrades", false)
    else
        function BaseInteractionExt:_has_required_upgrade() return true end
        UT:setSetting("bypass_upgrades", true)
    end

    UT:saveSettings()
end

function UT:setSetting(name, value, save)
    UT.settings[name] = value
    if save or save == nil then
        UT:saveSettings()
    end
end

function UT:getBltData()
    return UT.Utils:getSaveTable(UT.saveFilesNames.bltData)
end

function UT:setBltData(data)
    return UT.Utils:setSaveTable(UT.saveFilesNames.bltData, data)
end

function UT:log(data)
    log(UT.Utils:toString(data))
end

function UT:getLocalizedText(stringId)
    return managers.localization:text(stringId)
end

function UT:addAlert(message, color, localized, highLightText, highLightColor)
    if localized or localized == nil then
        message = UT:getLocalizedText(message)
    end
    local parameters = {
        message = message,
        color = color or UT.colors.white,
        time = 5
    }
    if not localized then
        if highLightText then
            parameters.highlight_msg = highLightText
            parameters.highlight_color = highLightColor or UT.colors.white
        end
    end
    UT.debugLogClass:addNewLog(parameters)
end

function UT:showSubtitle(message, color)
    managers.mission:_show_debug_subtitle(message, color)
end

function UT:isUnitLoaded(name)
    return PackageManager:has(Idstring("unit"), name)
end

function UT:spawnUnit(name, position, rotation)
    if not UT:isUnitLoaded(name) then
        return false
    end
    return World:spawn_unit(name, position, rotation)
end

-- Interacts with provided types
function UT:InteractType(interactTypes, --[[optional]]cheatEquipmentBoolean)
	local objects = {}
    local cheatEquipment = cheatEquipmentBoolean or false

    if cheatEquipment then
        UT:infiniteEquipmentToggle()
        UT:interactWithAnythingToggle()
    end

	for _,v in pairs(managers.interaction._interactive_units) do
		if table.contains(interactTypes, v:interaction().tweak_data) then
			table.insert(objects, v:interaction())
		end
	end

	for _,v in ipairs(objects) do
		v:interact(managers.player:player_unit())
	end

    if cheatEquipment then
        UT:infiniteEquipmentToggle()
        UT:interactWithAnythingToggle()
    end
end

function UT:removeUnit(unit)
    if not alive(unit) then
        return
    end
    World:delete_unit(unit)
    managers.network:session():send_to_peers_synched("remove_unit", unit)
end

function UT:removeUnits(units)
    for key, unit in pairs(units) do
        UT:removeUnit(unit)
    end
end

function UT:setUnitTeam(unit, team)
    if not alive(unit) then
        return
    end
    local teamId = tweak_data.levels:get_default_team_ID(team)
    local teamData = managers.groupai:state():team_data(teamId)
    unit:movement():set_team(teamData)
end

function UT:enableUnlimitedConversions()
    _G.CloneClass(PlayerManager)
    function PlayerManager:upgrade_value(category, upgrade, default)
        if category == "player" and upgrade == "convert_enemies" then
            return true
        elseif category == "player" and upgrade == "convert_enemies_max_minions" then
            return UT.fakeMaxInteger
        else
            return PlayerManager.orig.upgrade_value(self, category, upgrade, default)
        end
    end
end

function UT:isHost()
    return Network:is_server()
end

function UT:isInGame()
    return Utils:IsInGameState()
end

function UT:isInHeist()
    if not UT:isInGame() then
        return false
    end
    return Utils:IsInHeist()
end

function UT:isDriving()
    return game_state_machine:current_state_name() == "ingame_driving"
end

function UT:isInMenu()
    return managers.menu:is_active()
end

function UT:isInStartMenu()
    return game_state_machine:current_state_name() == "menu_main"
end

function UT:isInMultiPlayer()
    return Network:multiplayer()
end

function UT:getCrosshairRay()
    return Utils:GetCrosshairRay()
end

function UT:getPlayerPosition()
    return managers.player:player_unit():position()
end

function UT:getPlayerCameraPosition()
    return managers.player:player_unit():camera():position()
end

function UT:getPlayerCameraRotation()
    return managers.player:player_unit():camera():rotation()
end

function UT:getPlayerCameraRotationFlat()
    return Rotation(UT:getPlayerCameraRotation():yaw(), 0, 0)
end

function UT:getPlayerCameraForward()
    return managers.player:player_unit():camera():forward()
end

function UT:showHitMarker()
    managers.hud:on_crit_confirmed()
end

function UT:playSound(name)
    managers.menu_component:post_event(name)
end

function UT:teleportPlayer(position, rotation)
    managers.player:warp_to(position, rotation)
end

function UT:openSteamBrowser(url)
    Steam:overlay_activate("url", url)
end

function UT:openThread()
    UT:openSteamBrowser(UT.threadUrl)
end

function UT:exitGame()
    os.exit()
end

function UT:openMenu()
    managers.menu:open_menu("menu_pause")
    managers.menu:open_node("ut_main_menu")
end

function UT:reloadStartMenu()
    if UT:isInMultiPlayer() then
        MenuCallbackHandler:_dialog_leave_lobby_yes()
    end
    setup:load_start_menu()
end

function UT:setHideModsList(value)
    UT:setSetting("enable_hide_mods_list", value)
    if value then
        UT:addAlert("ut_alert_hide_mods_list_enabled", UT.colors.success)
    else
        UT:addAlert("ut_alert_hide_mods_list_disabled", UT.colors.success)
    end
    UT:addAlert("ut_alert_restart_the_game_to_apply_changes", UT.colors.warning)
end

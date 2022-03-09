local modPath = ModPath

dofile(modPath .. "classes/UT.lua")
dofile(modPath .. "classes/Utils.lua")

UT:loadSettings()

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_UltimateTrainer", function(localizationManager)
    local locale = BLT.Localization:get_language().language
    locale = UT.Utils:inTable(locale, UT.supportedLocales) and locale or "en"
    localizationManager:load_localization_file(modPath .. "locales/" .. locale .. ".json")
end)

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_UltimateTrainer", function(menuManager)
    MenuCallbackHandler.ut_open_thread = function(self, item)
        UT:openThread()
    end

    MenuCallbackHandler.ut_set_level = function(self, item)
        local level = item:value()
        item:set_value("")
        if UT.Utils:isEmptyString(level) then
            return
        end
        level = UT.Utils:toNumber(level)
        if not UT.Utils:isInteger(level) then
            return
        end
        if level < 0 or level > 100 then
            return
        end
        UT.Player:setLevel(level)
    end

    MenuCallbackHandler.ut_set_infamy_rank = function(self, item)
        local infamyRank = item:value()
        item:set_value("")
        if UT.Utils:isEmptyString(infamyRank) then
            return
        end
        infamyRank = UT.Utils:toNumber(infamyRank)
        if not UT.Utils:isInteger(infamyRank) then
            return
        end
        if infamyRank < 0 or infamyRank > 500 then
            return
        end
        UT.Player:setInfamyRank(infamyRank)
    end

    MenuCallbackHandler.ut_add_spending_money = function(self, item)
        local amount = item:value()
        item:set_value("")
        if UT.Utils:isEmptyString(amount) then
            return
        end
        amount = UT.Utils:toNumber(amount)
        if not UT.Utils:isInteger(amount) then
            return
        end
        if amount < 0 then
            return
        end
        UT.Player:addSpendingMoney(amount)
    end

    MenuCallbackHandler.ut_add_offshore_money = function(self, item)
        local amount = item:value()
        item:set_value("")
        if UT.Utils:isEmptyString(amount) then
            return
        end
        amount = UT.Utils:toNumber(amount)
        if not UT.Utils:isInteger(amount) then
            return
        end
        if amount < 0 then
            return
        end
        UT.Player:addOffshoreMoney(amount)
    end

    MenuCallbackHandler.ut_reset_money = function(self, item)
        UT.Player:resetMoney()
    end

    MenuCallbackHandler.ut_add_continental_coins = function(self, item)
        local amount = item:value()
        item:set_value("")
        if UT.Utils:isEmptyString(amount) then
            return
        end
        amount = UT.Utils:toNumber(amount)
        if not UT.Utils:isInteger(amount) then
            return
        end
        if amount < 0 then
            return
        end
        UT.Player:addContinentalCoins(amount)
    end

    MenuCallbackHandler.ut_reset_continental_coins = function(self, item)
        UT.Player:resetContinentalCoins()
    end

    MenuCallbackHandler.ut_toggle_skill_points_hack = function(self, item)
        local value = UT.Utils:getToggleValue(item:value())
        UT.Player:setSkillPointsHack(value)
    end

    MenuCallbackHandler.ut_set_skill_points_total_amount = function(self, item)
        local amount = item:value()
        if UT.Utils:isEmptyString(amount) then
            return
        end
        amount = UT.Utils:toNumber(amount)
        if not UT.Utils:isInteger(amount) then
            return
        end
        if amount < 0 or amount > 690 then
            return
        end
        UT.Player:setSkillPointsTotalAmount(amount)
    end

    MenuCallbackHandler.ut_add_perk_experience = function(self, item)
        local amount = item:value()
        item:set_value("")
        if UT.Utils:isEmptyString(amount) then
            return
        end
        amount = UT.Utils:toNumber(amount)
        if not UT.Utils:isInteger(amount) then
            return
        end
        if amount < 0 then
            return
        end
        UT.Player:addPerkPoints(amount)
    end

    MenuCallbackHandler.ut_reset_perk_points = function(self, item)
        UT.Player:resetPerkPoints()
    end

    MenuCallbackHandler.ut_add_one_of_all_weapon_mods = function(self, item)
        UT.Player:addItemsToInventory("weapon_mods")
    end

    MenuCallbackHandler.ut_add_one_of_all_masks = function(self, item)
        UT.Player:addItemsToInventory("masks")
    end

    MenuCallbackHandler.ut_add_one_of_all_materials = function(self, item)
        UT.Player:addItemsToInventory("materials")
    end

    MenuCallbackHandler.ut_add_one_of_all_patterns = function(self, item)
        UT.Player:addItemsToInventory("textures")
    end

    MenuCallbackHandler.ut_add_one_of_all_colors = function(self, item)
        UT.Player:addItemsToInventory("colors")
    end

    MenuCallbackHandler.ut_clear_weapon_mods = function(self, item)
        UT.Player:clearInventoryItems("weapon_mods")
    end

    MenuCallbackHandler.ut_clear_masks = function(self, item)
        UT.Player:clearInventoryItems("masks")
    end

    MenuCallbackHandler.ut_clear_materials = function(self, item)
        UT.Player:clearInventoryItems("materials")
    end

    MenuCallbackHandler.ut_clear_patterns = function(self, item)
        UT.Player:clearInventoryItems("textures")
    end

    MenuCallbackHandler.ut_clear_colors = function(self, item)
        UT.Player:clearInventoryItems("colors")
    end

    MenuCallbackHandler.ut_unlock_all_weapons = function(self, item)
        UT.Player:unlockInventoryCategory("weapon")
    end

    MenuCallbackHandler.ut_unlock_all_melee_weapons = function(self, item)
        UT.Player:unlockInventoryCategory("melee_weapon")
    end

    MenuCallbackHandler.ut_unlock_all_throwables = function(self, item)
        UT.Player:unlockInventoryCategory("grenade")
    end

    MenuCallbackHandler.ut_unlock_all_armors = function(self, item)
        UT.Player:unlockInventoryCategory("armor")
    end

    MenuCallbackHandler.ut_unlock_all_slots = function(self, item)
        UT.Player:setAllSlots(true)
    end

    MenuCallbackHandler.ut_lock_all_slots = function(self, item)
        UT.Player:setAllSlots(false)
    end

    MenuCallbackHandler.ut_remove_exclamation_marks = function(self, item)
        UT.Player:removeExclamationMarks()
    end

    MenuCallbackHandler.ut_unlock_all_trophies = function(self, item)
        UT.Player:unlockAllTrophies()
    end

    MenuCallbackHandler.ut_lock_all_trophies = function(self, item)
        UT.Player:lockAllTrophies()
    end

    MenuCallbackHandler.ut_unlock_all_steam_achievements = function(self, item)
        UT.Player:unlockAllSteamAchievements()
    end

    MenuCallbackHandler.ut_lock_all_steam_achievements = function(self, item)
        UT.Player:lockAllSteamAchievements()
    end

    MenuCallbackHandler.ut_toggle_dlc_unlocker = function(self, item)
        local value = UT.Utils:getToggleValue(item:value())
        UT.Unlocker:setDlcUnlocker(value)
    end

    MenuCallbackHandler.ut_toggle_skin_unlocker = function(self, item)
        local value = UT.Utils:getToggleValue(item:value())
        UT.Unlocker:setSkinUnlocker(value)
    end

    MenuCallbackHandler.ut_access_cameras = function(self, item)
        managers.menu:close_all_menus()
        UT.Mission:accessCameras()
    end

    MenuCallbackHandler.ut_remove_invisible_walls = function(self, item)
        UT.Mission:removeInvisibleWalls()
    end

    MenuCallbackHandler.ut_convert_all_enemies = function(self, item)
        UT.Mission:convertAllEnemies()
    end

    MenuCallbackHandler.ut_trigger_alarm = function(self, item)
        UT.Mission:triggerAlarm()
    end

    MenuCallbackHandler.ut_toggle_god_mode = function(self, item)
        local value = UT.Utils:getToggleValue(item:value())
        UT.Mission:setGodMode(value)
    end

    MenuCallbackHandler.ut_toggle_disable_ai = function(self, item)
        local value = UT.Utils:getToggleValue(item:value())
        UT.Mission:setDisableAi(value)
    end

    MenuCallbackHandler.ut_toggle_instant_drilling = function(self, item)
        local value = UT.Utils:getToggleValue(item:value())
        UT.Mission:setInstantDrilling(value)
    end

    MenuCallbackHandler.ut_toggle_prevent_alarm_triggering = function(self, item)
        local value = UT.Utils:getToggleValue(item:value())
        UT.Mission:setPreventAlarmTriggering(value)
    end

    MenuCallbackHandler.ut_toggle_unlimited_pagers = function(self, item)
        local value = UT.Utils:getToggleValue(item:value())
        UT.Mission:setUnlimitedPagers(value)
    end

    MenuCallbackHandler.ut_clear_construction = function(self, item)
        UT.Construction:clear()
    end

    MenuCallbackHandler.ut_toggle_crosshair_marker = function(self, item)
        local value = UT.Utils:getToggleValue(item:value())
        UT.Construction:setCrosshairMarker(value)
    end

    MenuCallbackHandler.ut_set_spawn_mode_enemies = function(self, item)
        UT.Spawn:setModeEnemies()
    end

    MenuCallbackHandler.ut_set_spawn_mode_allies = function(self, item)
        UT.Spawn:setModeAllies()
    end

    MenuCallbackHandler.ut_set_spawn_mode_civilians = function(self, item)
        UT.Spawn:setModeCivilians()
    end

    MenuCallbackHandler.ut_set_spawn_mode_loots = function(self, item)
        UT.Spawn:setModeLoots()
    end

    MenuCallbackHandler.ut_set_spawn_mode_equipments = function(self, item)
        UT.Spawn:setModeEquipments()
    end

    MenuCallbackHandler.ut_set_spawn_mode_packages = function(self, item)
        UT.Spawn:setModePackages()
    end

    MenuCallbackHandler.ut_set_spawn_mode_bags = function(self, item)
        UT.Spawn:setModeBags()
    end

    MenuCallbackHandler.ut_remove_npcs = function(self, item)
        UT.Spawn:removeNpcs()
    end

    MenuCallbackHandler.ut_remove_loots = function(self, item)
        UT.Spawn:removeLoots()
    end

    MenuCallbackHandler.ut_remove_equipments = function(self, item)
        UT.Spawn:removeEquipments()
    end

    MenuCallbackHandler.ut_remove_packages = function(self, item)
        UT.Spawn:removePackages()
    end

    MenuCallbackHandler.ut_remove_bags = function(self, item)
        UT.Spawn:removeBags()
    end

    MenuCallbackHandler.ut_dispose_corpses = function(self, item)
        UT.Spawn:disposeCorpses()
    end

    MenuCallbackHandler.ut_set_spawn_position = function(self, item)
        local values = {
            "crosshair",
            "self"
        }
        local index = item:value()
        UT.Spawn:setPosition(values[index])
    end

    MenuCallbackHandler.ut_set_environment_early_morning = function(self, item)
        UT.Time:setEnvironment("environments/pd2_env_hox_02/pd2_env_hox_02")
    end

    MenuCallbackHandler.ut_set_environment_morning = function(self, item)
        UT.Time:setEnvironment("environments/pd2_env_morning_02/pd2_env_morning_02")
    end

    MenuCallbackHandler.ut_set_environment_mid_day = function(self, item)
        UT.Time:setEnvironment("environments/pd2_env_mid_day/pd2_env_mid_day")
    end

    MenuCallbackHandler.ut_set_environment_afternoon = function(self, item)
        UT.Time:setEnvironment("environments/pd2_env_afternoon/pd2_env_afternoon")
    end

    MenuCallbackHandler.ut_set_environment_night = function(self, item)
        UT.Time:setEnvironment("environments/pd2_env_n2/pd2_env_n2")
    end

    MenuCallbackHandler.ut_set_environment_misty_night = function(self, item)
        UT.Time:setEnvironment("environments/pd2_env_arm_hcm_02/pd2_env_arm_hcm_02")
    end

    MenuCallbackHandler.ut_set_environment_foggy_night = function(self, item)
        UT.Time:setEnvironment("environments/pd2_env_foggy_bright/pd2_env_foggy_bright")
    end

    MenuCallbackHandler.ut_reset_environment = function(self, item)
        UT.Time:resetEnvironment()
    end

    MenuCallbackHandler.ut_toggle_packages_loading = function(self, item)
        local value = UT.Utils:getToggleValue(item:value())
        UT.Driving:setPackagesLoading(value)
    end

    MenuCallbackHandler.ut_select_vehicle = function(self, item)
        local index = item:value()
        UT.Driving:setSelectedVehicle(UT.Tables.vehicles[index])
    end

    MenuCallbackHandler.ut_remove_vehicles = function(self, item)
        UT.Driving:removeVehicles()
    end

    MenuCallbackHandler.ut_spawn_vehicle = function(self, item)
        UT.Driving:spawnVehicle()
    end

    MenuCallbackHandler.ut_toggle_anti_cheat_checker = function(self, item)
        local value = UT.Utils:getToggleValue(item:value())
        UT.Configuration:setAntiCheatChecker(value)
        if value then
            UT:addAlert("ut_alert_anti_cheat_checker_enabled", UT.colors.success)
        else
            UT:addAlert("ut_alert_anti_cheat_checker_disabled", UT.colors.success)
        end
    end

    MenuCallbackHandler.ut_toggle_infinite_stamina = function(self, item)
        UT.tempSettings.dexterity.infiniteStamina = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setInfiniteStamina()
    end

    MenuCallbackHandler.ut_toggle_run_in_all_directions = function(self, item)
        UT.tempSettings.dexterity.runInAllDirections = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setRunInAllDirections()
    end

    MenuCallbackHandler.ut_toggle_can_run_with_any_bag = function(self, item)
        UT.tempSettings.dexterity.canRunWithAnyBag = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setCanRunWithAnyBag()
    end

    MenuCallbackHandler.ut_toggle_no_carry_cooldown = function(self, item)
        UT.tempSettings.dexterity.noCarryCooldown = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setNoCarryCooldown()
    end

    MenuCallbackHandler.ut_toggle_no_flashbangs = function(self, item)
        UT.tempSettings.dexterity.noFlashbangs = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setNoFlashbangs()
    end

    MenuCallbackHandler.ut_toggle_instant_swap = function(self, item)
        UT.tempSettings.dexterity.instantSwap = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setInstantSwap()
    end

    MenuCallbackHandler.ut_toggle_instant_reload = function(self, item)
        UT.tempSettings.dexterity.instantReload = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setInstantReload()
    end

    MenuCallbackHandler.ut_toggle_no_recoil = function(self, item)
        UT.tempSettings.dexterity.noRecoil = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setNoRecoil()
    end

    MenuCallbackHandler.ut_toggle_no_spread = function(self, item)
        UT.tempSettings.dexterity.noSpread = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setNoSpread()
    end

    MenuCallbackHandler.ut_toggle_unlimited_ammo = function(self, item)
        UT.tempSettings.dexterity.unlimitedAmmo = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setUnlimitedAmmo()
    end

    MenuCallbackHandler.ut_toggle_instant_interaction = function(self, item)
        UT.tempSettings.dexterity.instantInteraction = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setInstantInteraction()
    end

    MenuCallbackHandler.ut_toggle_instant_deployment = function(self, item)
        UT.tempSettings.dexterity.instantDeployment = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setInstantDeployment()
    end

    MenuCallbackHandler.ut_toggle_unlimited_equipment = function(self, item)
        UT.tempSettings.dexterity.unlimitedEquipment = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setUnlimitedEquipment()
    end

    MenuCallbackHandler.ut_toggle_move_speed_multiplier = function(self, item)
        UT.tempSettings.dexterity.moveSpeedMultiplier = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setMoveSpeedMultiplier()
    end

    MenuCallbackHandler.ut_set_move_speed_multiplier = function(self, item)
        UT.tempSettings.dexterity.moveSpeedMultiplierValue = item:value()
        UT.Dexterity:setMoveSpeedMultiplier()
    end

    MenuCallbackHandler.ut_toggle_throw_distance_multiplier = function(self, item)
        UT.tempSettings.dexterity.throwDistanceMultiplier = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setThrowDistanceMultiplier()
    end

    MenuCallbackHandler.ut_set_throw_distance_multiplier = function(self, item)
        UT.tempSettings.dexterity.throwDistanceMultiplierValue = item:value()
        UT.Dexterity:setThrowDistanceMultiplier()
    end

    MenuCallbackHandler.ut_toggle_fire_rate_multiplier = function(self, item)
        UT.tempSettings.dexterity.fireRateMultiplier = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setFireRateMultiplier()
    end

    MenuCallbackHandler.ut_set_fire_rate_multiplier = function(self, item)
        UT.tempSettings.dexterity.fireRateMultiplierValue = item:value()
        UT.Dexterity:setFireRateMultiplier()
    end

    MenuCallbackHandler.ut_toggle_damage_multiplier = function(self, item)
        UT.tempSettings.dexterity.damageMultiplier = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setDamageMultiplier()
    end

    MenuCallbackHandler.ut_set_damage_multiplier = function(self, item)
        UT.tempSettings.dexterity.damageMultiplierValue = item:value()
        UT.Dexterity:setDamageMultiplier()
    end

    MenuHelper:LoadFromJsonFile(modPath .. "menus/main.json")
    MenuHelper:LoadFromJsonFile(modPath .. "menus/player.json")
    MenuHelper:LoadFromJsonFile(modPath .. "menus/unlocker.json", nil, UT.settings)
    MenuHelper:LoadFromJsonFile(modPath .. "menus/mission.json")
    MenuHelper:LoadFromJsonFile(modPath .. "menus/construction.json")
    MenuHelper:LoadFromJsonFile(modPath .. "menus/spawn.json")
    MenuHelper:LoadFromJsonFile(modPath .. "menus/time.json")
    MenuHelper:LoadFromJsonFile(modPath .. "menus/driving.json", nil, UT.settings)
    MenuHelper:LoadFromJsonFile(modPath .. "menus/dexterity.json")
    MenuHelper:LoadFromJsonFile(modPath .. "menus/configuration.json", nil, UT.settings)
    
    MenuHelper:LoadFromJsonFile(modPath .. "menus/level.json")
    MenuHelper:LoadFromJsonFile(modPath .. "menus/infamy-rank.json")
    MenuHelper:LoadFromJsonFile(modPath .. "menus/money.json")
    MenuHelper:LoadFromJsonFile(modPath .. "menus/continental-coins.json")
    MenuHelper:LoadFromJsonFile(modPath .. "menus/skill-points.json", nil, UT.settings)
    MenuHelper:LoadFromJsonFile(modPath .. "menus/perk-points.json")
    MenuHelper:LoadFromJsonFile(modPath .. "menus/inventory.json")
    MenuHelper:LoadFromJsonFile(modPath .. "menus/trophies.json")
    MenuHelper:LoadFromJsonFile(modPath .. "menus/steam-achievements.json")
end)

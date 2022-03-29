Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_UltimateTrainer", function(localizationManager)
    local locale = BLT.Localization:get_language().language
    locale = UT.Utils:inTable(locale, UT.supportedLocales) and locale or "en"
    localizationManager:load_localization_file(UT.modPath .. "/locales/" .. locale .. ".json")
end)

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_UltimateTrainer", function(menuManager)
    MenuCallbackHandler.ut_main_open_thread = function(self, item)
        UT:openThread()
    end

    MenuCallbackHandler.ut_player_set_level = function(self, item)
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

    MenuCallbackHandler.ut_player_set_infamy_rank = function(self, item)
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

    MenuCallbackHandler.ut_player_add_spending_money = function(self, item)
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

    MenuCallbackHandler.ut_player_add_offshore_money = function(self, item)
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

    MenuCallbackHandler.ut_player_reset_money = function(self, item)
        UT.Player:resetMoney()
    end

    MenuCallbackHandler.ut_player_add_continental_coins = function(self, item)
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

    MenuCallbackHandler.ut_player_reset_continental_coins = function(self, item)
        UT.Player:resetContinentalCoins()
    end

    MenuCallbackHandler.ut_player_toggle_skill_points_hack = function(self, item)
        local value = UT.Utils:getToggleValue(item:value())
        UT.Player:setSkillPointsHack(value)
    end

    MenuCallbackHandler.ut_player_set_skill_points_total_amount = function(self, item)
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

    MenuCallbackHandler.ut_player_add_perk_experience = function(self, item)
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

    MenuCallbackHandler.ut_player_reset_perk_points = function(self, item)
        UT.Player:resetPerkPoints()
    end

    MenuCallbackHandler.ut_player_add_one_of_all_weapon_mods = function(self, item)
        UT.Player:addItemsToInventory("weapon_mods")
    end

    MenuCallbackHandler.ut_player_add_one_of_all_masks = function(self, item)
        UT.Player:addItemsToInventory("masks")
    end

    MenuCallbackHandler.ut_player_add_one_of_all_materials = function(self, item)
        UT.Player:addItemsToInventory("materials")
    end

    MenuCallbackHandler.ut_player_add_one_of_all_patterns = function(self, item)
        UT.Player:addItemsToInventory("textures")
    end

    MenuCallbackHandler.ut_player_add_one_of_all_colors = function(self, item)
        UT.Player:addItemsToInventory("colors")
    end

    MenuCallbackHandler.ut_player_clear_weapon_mods = function(self, item)
        UT.Player:clearInventoryItems("weapon_mods")
    end

    MenuCallbackHandler.ut_player_clear_masks = function(self, item)
        UT.Player:clearInventoryItems("masks")
    end

    MenuCallbackHandler.ut_player_clear_materials = function(self, item)
        UT.Player:clearInventoryItems("materials")
    end

    MenuCallbackHandler.ut_player_clear_patterns = function(self, item)
        UT.Player:clearInventoryItems("textures")
    end

    MenuCallbackHandler.ut_player_clear_colors = function(self, item)
        UT.Player:clearInventoryItems("colors")
    end

    MenuCallbackHandler.ut_player_unlock_all_weapons = function(self, item)
        UT.Player:unlockInventoryCategory("weapon")
    end

    MenuCallbackHandler.ut_player_unlock_all_melee_weapons = function(self, item)
        UT.Player:unlockInventoryCategory("melee_weapon")
    end

    MenuCallbackHandler.ut_player_unlock_all_throwables = function(self, item)
        UT.Player:unlockInventoryCategory("grenade")
    end

    MenuCallbackHandler.ut_player_unlock_all_armors = function(self, item)
        UT.Player:unlockInventoryCategory("armor")
    end

    MenuCallbackHandler.ut_player_unlock_all_slots = function(self, item)
        UT.Player:setAllSlots(true)
    end

    MenuCallbackHandler.ut_player_lock_all_slots = function(self, item)
        UT.Player:setAllSlots(false)
    end

    MenuCallbackHandler.ut_player_remove_exclamation_marks = function(self, item)
        UT.Player:removeExclamationMarks()
    end

    MenuCallbackHandler.ut_player_unlock_all_trophies = function(self, item)
        UT.Player:unlockAllTrophies()
    end

    MenuCallbackHandler.ut_player_lock_all_trophies = function(self, item)
        UT.Player:lockAllTrophies()
    end

    MenuCallbackHandler.ut_player_unlock_all_steam_achievements = function(self, item)
        UT.Player:unlockAllSteamAchievements()
    end

    MenuCallbackHandler.ut_player_lock_all_steam_achievements = function(self, item)
        UT.Player:lockAllSteamAchievements()
    end

    MenuCallbackHandler.ut_unlocker_toggle_dlc_unlocker = function(self, item)
        local value = UT.Utils:getToggleValue(item:value())
        UT.Unlocker:setDlcUnlocker(value)
    end

    MenuCallbackHandler.ut_unlocker_toggle_skin_unlocker = function(self, item)
        local value = UT.Utils:getToggleValue(item:value())
        UT.Unlocker:setSkinUnlocker(value)
    end

    MenuCallbackHandler.ut_mission_access_cameras = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        managers.menu:close_all_menus()
        UT.Mission:accessCameras()
    end

    MenuCallbackHandler.ut_mission_remove_invisible_walls = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Mission:removeInvisibleWalls()
    end

    MenuCallbackHandler.ut_mission_convert_all_enemies = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Mission:convertAllEnemies()
    end

    MenuCallbackHandler.ut_mission_trigger_alarm = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Mission:triggerAlarm()
    end

    MenuCallbackHandler.ut_mission_toggle_disable_ai = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        local value = UT.Utils:getToggleValue(item:value())
        UT.Mission:setDisableAi(value)
    end

    MenuCallbackHandler.ut_mission_toggle_instant_drilling = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        local value = UT.Utils:getToggleValue(item:value())
        UT.Mission:setInstantDrilling(value)
    end

    MenuCallbackHandler.ut_mission_toggle_prevent_alarm_triggering = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        local value = UT.Utils:getToggleValue(item:value())
        UT.Mission:setPreventAlarmTriggering(value)
    end

    MenuCallbackHandler.ut_mission_toggle_unlimited_pagers = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        local value = UT.Utils:getToggleValue(item:value())
        UT.Mission:setUnlimitedPagers(value)
    end

    MenuCallbackHandler.ut_construction_clear = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Construction:clear()
    end

    MenuCallbackHandler.ut_construction_toggle_crosshair_marker = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        local value = UT.Utils:getToggleValue(item:value())
        UT.Construction:setCrosshairMarker(value)
    end

    MenuCallbackHandler.ut_spawn_set_mode_enemies = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Spawn:setModeEnemies()
    end

    MenuCallbackHandler.ut_spawn_set_mode_allies = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Spawn:setModeAllies()
    end

    MenuCallbackHandler.ut_spawn_set_mode_civilians = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Spawn:setModeCivilians()
    end

    MenuCallbackHandler.ut_spawn_set_mode_loots = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Spawn:setModeLoots()
    end

    MenuCallbackHandler.ut_spawn_set_mode_equipments = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Spawn:setModeEquipments()
    end

    MenuCallbackHandler.ut_spawn_set_mode_packages = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Spawn:setModePackages()
    end

    MenuCallbackHandler.ut_spawn_set_mode_bags = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Spawn:setModeBags()
    end

    MenuCallbackHandler.ut_spawn_set_mode_explosives = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Spawn:setModeExplosives()
    end

    MenuCallbackHandler.ut_spawn_remove_npcs = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Spawn:removeNpcs()
    end

    MenuCallbackHandler.ut_spawn_remove_loots = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Spawn:removeLoots()
    end

    MenuCallbackHandler.ut_spawn_remove_equipments = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Spawn:removeEquipments()
    end

    MenuCallbackHandler.ut_spawn_remove_packages = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Spawn:removePackages()
    end

    MenuCallbackHandler.ut_spawn_remove_bags = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Spawn:removeBags()
    end

    MenuCallbackHandler.ut_spawn_dispose_corpses = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Spawn:disposeCorpses()
    end

    MenuCallbackHandler.ut_spawn_set_position = function(self, item)
        local values = {
            "crosshair",
            "self"
        }
        local index = item:value()
        UT.Spawn:setPosition(values[index])
    end

    MenuCallbackHandler.ut_time_set_environment_early_morning = function(self, item)
        UT.Time:setEnvironmentSetting("environments/pd2_env_hox_02/pd2_env_hox_02")
    end

    MenuCallbackHandler.ut_time_set_environment_morning = function(self, item)
        UT.Time:setEnvironmentSetting("environments/pd2_env_morning_02/pd2_env_morning_02")
    end

    MenuCallbackHandler.ut_time_set_environment_mid_day = function(self, item)
        UT.Time:setEnvironmentSetting("environments/pd2_env_mid_day/pd2_env_mid_day")
    end

    MenuCallbackHandler.ut_time_set_environment_afternoon = function(self, item)
        UT.Time:setEnvironmentSetting("environments/pd2_env_afternoon/pd2_env_afternoon")
    end

    MenuCallbackHandler.ut_time_set_environment_night = function(self, item)
        UT.Time:setEnvironmentSetting("environments/pd2_env_n2/pd2_env_n2")
    end

    MenuCallbackHandler.ut_time_set_environment_misty_night = function(self, item)
        UT.Time:setEnvironmentSetting("environments/pd2_env_arm_hcm_02/pd2_env_arm_hcm_02")
    end

    MenuCallbackHandler.ut_time_set_environment_foggy_night = function(self, item)
        UT.Time:setEnvironmentSetting("environments/pd2_env_foggy_bright/pd2_env_foggy_bright")
    end

    MenuCallbackHandler.ut_time_reset_environment = function(self, item)
        UT.Time:resetEnvironment()
    end

    MenuCallbackHandler.ut_driving_toggle_packages_loading = function(self, item)
        local value = UT.Utils:getToggleValue(item:value())
        UT.Driving:setPackagesLoading(value)
    end

    MenuCallbackHandler.ut_driving_select_vehicle = function(self, item)
        local index = item:value()
        UT.Driving:setSelectedVehicle(UT.Tables.vehicles[index])
    end

    MenuCallbackHandler.ut_driving_remove_vehicles = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Driving:removeVehicles()
    end

    MenuCallbackHandler.ut_driving_spawn_vehicle = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Driving:spawnVehicle()
    end

    MenuCallbackHandler.ut_dexterity_toggle_god_mode = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        local value = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setGodMode(value)
    end

    MenuCallbackHandler.ut_dexterity_toggle_infinite_stamina = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        local value = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setInfiniteStamina(value)
    end

    MenuCallbackHandler.ut_dexterity_toggle_run_in_all_directions = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        local value = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setRunInAllDirections(value)
    end

    MenuCallbackHandler.ut_dexterity_toggle_can_run_with_any_bag = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        local value = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setCanRunWithAnyBag(value)
    end

    MenuCallbackHandler.ut_dexterity_toggle_no_carry_cooldown = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        local value = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setNoCarryCooldown(value)
    end

    MenuCallbackHandler.ut_dexterity_toggle_no_flashbangs = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        local value = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setNoFlashbangs(value)
    end

    MenuCallbackHandler.ut_dexterity_toggle_instant_swap = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        local value = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setInstantSwap(value)
    end

    MenuCallbackHandler.ut_dexterity_toggle_instant_reload = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        local value = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setInstantReload(value)
    end

    MenuCallbackHandler.ut_dexterity_toggle_no_recoil = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        local value = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setNoRecoil(value)
    end

    MenuCallbackHandler.ut_dexterity_toggle_no_spread = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        local value = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setNoSpread(value)
    end

    MenuCallbackHandler.ut_dexterity_toggle_unlimited_ammo = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        local value = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setUnlimitedAmmo(value)
    end

    MenuCallbackHandler.ut_dexterity_toggle_instant_interaction = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        local value = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setInstantInteraction(value)
    end

    MenuCallbackHandler.ut_dexterity_toggle_instant_deployment = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        local value = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setInstantDeployment(value)
    end

    MenuCallbackHandler.ut_dexterity_toggle_unlimited_equipment = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        local value = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setUnlimitedEquipment(value)
    end

    MenuCallbackHandler.ut_dexterity_toggle_move_speed_multiplier = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        UT.Dexterity.enableMoveSpeedMultiplier = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setMoveSpeedMultiplier(
            UT.Dexterity.enableMoveSpeedMultiplier,
            UT.Dexterity.moveSpeedMultiplier
        )
    end

    MenuCallbackHandler.ut_dexterity_set_move_speed_multiplier = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        UT.Dexterity.moveSpeedMultiplier = item:value()
        UT.Dexterity:setMoveSpeedMultiplier(
            UT.Dexterity.enableMoveSpeedMultiplier,
            UT.Dexterity.moveSpeedMultiplier
        )
    end

    MenuCallbackHandler.ut_dexterity_toggle_throw_distance_multiplier = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        UT.Dexterity.enableThrowDistanceMultiplier = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setThrowDistanceMultiplier(
            UT.Dexterity.enableThrowDistanceMultiplier,
            UT.Dexterity.throwDistanceMultiplier
        )
    end

    MenuCallbackHandler.ut_dexterity_set_throw_distance_multiplier = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        UT.Dexterity.throwDistanceMultiplier = item:value()
        UT.Dexterity:setThrowDistanceMultiplier(
            UT.Dexterity.enableThrowDistanceMultiplier,
            UT.Dexterity.throwDistanceMultiplier
        )
    end

    MenuCallbackHandler.ut_dexterity_toggle_fire_rate_multiplier = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        UT.Dexterity.enableFireRateMultiplier = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setFireRateMultiplier(
            UT.Dexterity.enableFireRateMultiplier,
            UT.Dexterity.fireRateMultiplier
        )
    end

    MenuCallbackHandler.ut_dexterity_set_fire_rate_multiplier = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        UT.Dexterity.fireRateMultiplier = item:value()
        UT.Dexterity:setFireRateMultiplier(
            UT.Dexterity.enableFireRateMultiplier,
            UT.Dexterity.fireRateMultiplier
        )
    end

    MenuCallbackHandler.ut_dexterity_toggle_damage_multiplier = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        UT.Dexterity.enableDamageMultiplier = UT.Utils:getToggleValue(item:value())
        UT.Dexterity:setDamageMultiplier(
            UT.Dexterity.enableDamageMultiplier,
            UT.Dexterity.damageMultiplier
        )
    end

    MenuCallbackHandler.ut_dexterity_set_damage_multiplier = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        UT.Dexterity.damageMultiplier = item:value()
        UT.Dexterity:setDamageMultiplier(
            UT.Dexterity.enableDamageMultiplier,
            UT.Dexterity.damageMultiplier
        )
    end

    MenuCallbackHandler.ut_configuration_toggle_anti_cheat_checker = function(self, item)
        local value = UT.Utils:getToggleValue(item:value())
        UT.AntiCheatChecker:setEnabled(value)
    end

    MenuCallbackHandler.ut_configuration_anti_cheat_checker_show_list = function(self, item)
        UT.AntiCheatChecker:showList()
    end

    MenuCallbackHandler.ut_configuration_toggle_hide_mods_list = function(self, item)
        local value = UT.Utils:getToggleValue(item:value())
        UT:setHideModsList(value)
    end

    MenuCallbackHandler.ut_instant_start_heist = function(self, item)
        if not UT:isInGame() then
            UT:addAlert("ut_alert_in_game_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Instant:startHeist()
    end

    MenuCallbackHandler.ut_instant_restart_heist = function(self, item)
        if not UT:isInGame() then
            UT:addAlert("ut_alert_in_game_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Instant:restartHeist()
    end

    MenuCallbackHandler.ut_instant_finish_heist = function(self, item)
        if not UT:isInGame() then
            UT:addAlert("ut_alert_in_game_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.Instant:finishHeist()
    end

    MenuCallbackHandler.ut_instant_leave_heist = function(self, item)
        if not UT:isInGame() then
            UT:addAlert("ut_alert_in_game_only_feature", UT.colors.warning)
            return
        end
        UT.Instant:leaveHeist()
    end

    MenuCallbackHandler.ut_mission_toggle_xray = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        local value = UT.Utils:getToggleValue(item:value())
        UT.Mission:setXray(value)
    end

    MenuCallbackHandler.ut_group_spawn_select_type = function(self, item)
        local index = item:value()
        UT.GroupSpawn:setAnimations(UT.Tables.groupSpawnAnimations[index])
    end

    MenuCallbackHandler.ut_group_spawn_set_area_size = function(self, item)
        local value = UT.Utils:toInteger(item:value())
        UT.GroupSpawn:setAreaSize(value)
    end

    MenuCallbackHandler.ut_group_spawn_set_people_number = function(self, item)
        local value = UT.Utils:toInteger(item:value())
        UT.GroupSpawn:setPeopleNumber(value)
    end

    MenuCallbackHandler.ut_group_spawn_spawn = function(self, item)
        if not UT:isInHeist() then
            UT:addAlert("ut_alert_in_heist_only_feature", UT.colors.warning)
            return
        end
        if not UT:isHost() then
            UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
            return
        end
        UT.GroupSpawn:spawn()
    end

    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/main.json")
    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/player.json")
    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/mission.json")
    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/dexterity.json")
    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/construction.json")
    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/spawn.json")
    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/group-spawn.json")
    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/time.json")
    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/driving.json", nil, UT.settings)
    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/instant.json")
    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/unlocker.json", nil, UT.settings)
    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/configuration.json", nil, UT.settings)
    
    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/level.json")
    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/infamy-rank.json")
    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/money.json")
    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/continental-coins.json")
    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/skill-points.json", nil, UT.settings)
    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/perk-points.json")
    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/inventory.json")
    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/trophies.json")
    MenuHelper:LoadFromJsonFile(UT.modPath .. "/menus/steam-achievements.json")
end)

local packageManagerMetaTable = getmetatable(PackageManager)
local _script_data = packageManagerMetaTable.script_data

local ids_menu = Idstring("menu")
local ids_menus = {
	[Idstring("gamedata/menus/start_menu")] = true,
	[Idstring("gamedata/menus/pause_menu")] = true,
}
packageManagerMetaTable.script_data = function(self, typeId, pathId, ...)
	local scriptData = _script_data(self, typeId, pathId, ...)
	if typeId ~= ids_menu and not ids_menus[pathId] then
		return scriptData
	end

	for key, value in ipairs(scriptData[1]) do
		for key2, value2 in ipairs(value) do
			if value2.name == "options" then
				table.insert(scriptData[1][key], key2 + 1, {
					name = "ut_open_menu_main",
					text_id = "ut_menu_main_title",
					help_id = "ut_menu_main_description",
					next_node = "ut_main_menu",
					_meta = "item",
				})
				break
			end
		end
	end
	return scriptData
end

if UT:getSetting("enable_hide_mods_list") then
    function MenuCallbackHandler:is_modded_client()
        return false
    end

    function MenuCallbackHandler:is_not_modded_client()
        return true
    end

    function MenuCallbackHandler:build_mods_list()
        return {}
    end
end

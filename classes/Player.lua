UT.Player = {}

function UT.Player:setLevel(level)
    local rank = managers.experience:current_rank()
    managers.experience:reset()
    managers.experience:_set_current_level(level)
    managers.experience:set_current_rank(rank)
    UT.Player:refreshAndSave()
    UT:addAlert("ut_alert_level_set", UT.colors.success)
end

function UT.Player:setInfamyRank(infamyRank)
    managers.experience:set_current_rank(infamyRank)
    UT.Player:refreshAndSave()
    UT:addAlert("ut_alert_infamy_rank_set", UT.colors.success)
end

function UT.Player:addSpendingMoney(amount)
    managers.money:add_to_spending(amount)
    UT.Player:refreshAndSave()
    UT:addAlert("ut_alert_spending_money_added", UT.colors.success)
end

function UT.Player:addOffshoreMoney(amount)
    managers.money:add_to_offshore(amount)
    UT.Player:refreshAndSave()
    UT:addAlert("ut_alert_offshore_money_added", UT.colors.success)
end

function UT.Player:resetMoney()
    managers.money:reset()
    UT.Player:refreshAndSave()
    UT:addAlert("ut_alert_money_reset", UT.colors.success)
end

function UT.Player:addContinentalCoins(amount)
    managers.custom_safehouse:add_coins(amount)
    UT.Player:refreshAndSave()
    UT:addAlert("ut_alert_continental_coins_added", UT.colors.success)
end

function UT.Player:resetContinentalCoins()
    Global.custom_safehouse_manager.total = 0
    Global.custom_safehouse_manager.total_collected = 0
    UT.Player:refreshAndSave()
    UT:addAlert("ut_alert_continental_coins_reset", UT.colors.success)
end

function UT.Player:setSkillPointsHack(value)
    UT.settings.enableSkillPointsHack = value
    UT:saveSettings()
    if UT.settings.enableSkillPointsHack and UT.settings.skillPointsTotalAmount then
        managers.skilltree:_set_points(UT.settings.skillPointsTotalAmount - managers.skilltree:total_points_spent())
        UT.Player:refreshAndSave()
    end
    if value then
        UT:addAlert("ut_alert_skill_points_hack_enabled", UT.colors.success)
    else
        UT:addAlert("ut_alert_skill_points_hack_disabled", UT.colors.success)
    end
    UT:addAlert("ut_alert_restart_the_game_to_apply_changes", UT.colors.warning)
end

function UT.Player:setSkillPointsTotalAmount(amount)
    UT.settings.skillPointsTotalAmount = amount
    UT:saveSettings()
    if UT.settings.enableSkillPointsHack then
        managers.skilltree:_set_points(UT.settings.skillPointsTotalAmount - managers.skilltree:total_points_spent())
        UT.Player:refreshAndSave()
    end
    UT:addAlert("ut_alert_skill_points_total_amount_set", UT.colors.success)
    UT:addAlert("ut_alert_restart_the_game_to_apply_changes", UT.colors.warning)
end

function UT.Player:addPerkPoints(amount)
    managers.skilltree:give_specialization_points(amount)
    UT.Player:refreshAndSave()
    UT:addAlert("ut_alert_perk_experience_added", UT.colors.success)
end

function UT.Player:resetPerkPoints()
    Global.skilltree_manager.specializations.total_points = 0
    managers.skilltree:reset_specializations()
    UT.Player:refreshAndSave()
    UT:addAlert("ut_alert_perk_points_reset", UT.colors.success)
end

function UT.Player:addItemsToInventory(category)
    for id, item in pairs(tweak_data.blackmarket[category]) do
        local globalValue = "normal"
        if item.global_value then
            globalValue = item.global_value
        elseif item.infamous then
            globalValue = "infamous"
        elseif item.dlc then
            globalValue = item.dlc
        end
        managers.blackmarket:add_to_inventory(globalValue, category, id, false)
    end
    UT.Player:refreshAndSave()
    if category == "weapon_mods" then
        UT:addAlert("ut_alert_added_one_of_all_weapon_mods", UT.colors.success)
    elseif category == "masks" then
        UT:addAlert("ut_alert_added_one_of_all_masks", UT.colors.success)
    elseif category == "materials" then
        UT:addAlert("ut_alert_added_one_of_all_materials", UT.colors.success)
    elseif category == "textures" then
        UT:addAlert("ut_alert_added_one_of_all_patterns", UT.colors.success)
    elseif category == "colors" then
        UT:addAlert("ut_alert_added_one_of_all_colors", UT.colors.success)
    end
end

function UT.Player:clearInventoryItems(category)
    for globalValue, data in pairs(Global.blackmarket_manager.inventory) do
        if data[category] then
            for key, item in pairs(data[category]) do
                Global.blackmarket_manager.inventory[globalValue][category][key] = nil
            end
        end
    end
    UT.Player:refreshAndSave()
    if category == "weapon_mods" then
        UT:addAlert("ut_alert_weapon_mods_cleared", UT.colors.success)
    elseif category == "masks" then
        UT:addAlert("ut_alert_masks_cleared", UT.colors.success)
    elseif category == "materials" then
        UT:addAlert("ut_alert_materials_cleared", UT.colors.success)
    elseif category == "textures" then
        UT:addAlert("ut_alert_patterns_cleared", UT.colors.success)
    elseif category == "colors" then
        UT:addAlert("ut_alert_colors_cleared", UT.colors.success)
    end
end

function UT.Player:unlockInventoryCategory(category)
    for id, data in pairs(tweak_data.upgrades.definitions) do
        if data.category == category then
            if category == "weapon" then
                if string.find(id, "_primary") or string.find(id, "_secondary") then
                    goto continue
                end
            end
            if not managers.upgrades:aquired(id) then
                managers.upgrades:aquire(id)
            end
        end
        ::continue::
    end
    UT.Player:refreshAndSave()
    if category == "weapon" then
        UT:addAlert("ut_alert_unlocked_all_weapons", UT.colors.success)
    elseif category == "melee_weapon" then
        UT:addAlert("ut_alert_unlocked_all_melee_weapons", UT.colors.success)
    elseif category == "grenade" then
        UT:addAlert("ut_alert_unlocked_all_throwables", UT.colors.success)
    elseif category == "armor" then
        UT:addAlert("ut_alert_unlocked_all_armors", UT.colors.success)
    end
end

function UT.Player:setAllSlots(value)
    for i = 1, 160 do
        Global.blackmarket_manager.unlocked_weapon_slots.primaries[i] = value
        Global.blackmarket_manager.unlocked_weapon_slots.secondaries[i] = value
        Global.blackmarket_manager.unlocked_mask_slots[i] = value
    end
    UT.Player:refreshAndSave()
    if value then
        UT:addAlert("ut_alert_unlocked_all_slots", UT.colors.success)
    else
        UT:addAlert("ut_alert_locked_all_slots", UT.colors.success)
    end
end

function UT.Player:removeExclamationMarks()
    Global.blackmarket_manager.new_drops = {}
    UT.Player:refreshAndSave()
    UT:addAlert("ut_alert_exclamation_marks_removed", UT.colors.success)
end

function UT.Player:unlockAllTrophies()
    local trophies = Global.custom_safehouse_manager.trophies
    for key, trophy in pairs(trophies) do
        trophy.completed = true
    end
    UT.Player:refreshAndSave()
    UT:addAlert("ut_alert_unlocked_all_trophies", UT.colors.success)
end

function UT.Player:lockAllTrophies()
    managers.custom_safehouse:flush_completed_trophies()
    local trophies = Global.custom_safehouse_manager.trophies
    for key, trophy in pairs(trophies) do
        trophy.completed = false
    end
    UT.Player:refreshAndSave()
    UT:addAlert("ut_alert_locked_all_trophies", UT.colors.success)
end

function UT.Player:unlockAllSteamAchievements()
    local achievements = managers.achievment.achievments
    for id, achievement in pairs(achievements) do
        managers.achievment:award(id)
    end
    UT.Player:refreshAndSave()
    UT:addAlert("ut_alert_unlocked_all_steam_achievements", UT.colors.success)
end

function UT.Player:lockAllSteamAchievements()
    managers.achievment:clear_all_steam()
    UT.Player:refreshAndSave()
    UT:addAlert("ut_alert_locked_all_steam_achievements", UT.colors.success)
end

function UT.Player:refreshAndSave()
    if managers.menu_component then
        managers.menu_component:refresh_player_profile_gui()
    end
    if managers.savefile then
        managers.savefile:save_progress()
    end
end

UTLoadedClassPlayer = true

local modPath = ModPath

dofile(modPath .. "classes/UT.lua")
dofile(modPath .. "classes/Utils.lua")

UT:loadSettings()

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_UltimateTrainer", function(localizationManager)
    localizationManager:load_localization_file(modPath .. "locales/en.json")
end)

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_UltimateTrainer", function(menuManager)
    MenuCallbackHandler.ut_toggle_dlc_unlocker = function(self, item)
        local value = UT.Utils:getToggleValue(item:value())
        UT.Unlocker:toggleDlcUnlocker(value)
    end

    MenuCallbackHandler.ut_toggle_skin_unlocker = function(self, item)
        local value = UT.Utils:getToggleValue(item:value())
        UT.Unlocker:toggleSkinUnlocker(value)
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
        UT.Player:toggleSkillPointsHack(value)
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

    MenuCallbackHandler.ut_remove_exclamation_marks = function(self, item)
        UT.Player:removeExclamationMarks()
    end

    MenuCallbackHandler.ut_unlock_all_slots = function(self, item)
        UT.Player:setAllSlots(true)
    end

    MenuCallbackHandler.ut_lock_all_slots = function(self, item)
        UT.Player:setAllSlots(false)
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

    MenuHelper:LoadFromJsonFile(modPath .. "menus/main.json", nil, UT.settings)
    MenuHelper:LoadFromJsonFile(modPath .. "menus/player.json", nil, UT.settings)
    MenuHelper:LoadFromJsonFile(modPath .. "menus/unlocker.json", nil, UT.settings)
    
    MenuHelper:LoadFromJsonFile(modPath .. "menus/level.json", nil, UT.settings)
    MenuHelper:LoadFromJsonFile(modPath .. "menus/infamy-rank.json", nil, UT.settings)
    MenuHelper:LoadFromJsonFile(modPath .. "menus/money.json", nil, UT.settings)
    MenuHelper:LoadFromJsonFile(modPath .. "menus/continental-coins.json", nil, UT.settings)
    MenuHelper:LoadFromJsonFile(modPath .. "menus/skill-points.json", nil, UT.settings)
    MenuHelper:LoadFromJsonFile(modPath .. "menus/perk-points.json", nil, UT.settings)
    MenuHelper:LoadFromJsonFile(modPath .. "menus/inventory.json", nil, UT.settings)
    MenuHelper:LoadFromJsonFile(modPath .. "menus/trophies.json", nil, UT.settings)
    MenuHelper:LoadFromJsonFile(modPath .. "menus/steam-achievements.json", nil, UT.settings)
end)

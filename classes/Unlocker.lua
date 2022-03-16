UT.Unlocker = {}

function UT.Unlocker:setDlcUnlocker(value)
    UT:setSetting("enable_dlc_unlocker", value)
    if value then
        UT:addAlert("ut_alert_dlc_unlocker_enabled", UT.colors.success)
    else
        UT:addAlert("ut_alert_dlc_unlocker_disabled", UT.colors.success)
    end
    UT:addAlert("ut_alert_restart_the_game_to_apply_changes", UT.colors.warning)
end

function UT.Unlocker:setSkinUnlocker(value)
    UT:setSetting("enable_skin_unlocker", value)
    if value then
        for skinName, skinData in pairs(tweak_data.blackmarket.weapon_skins) do
            local instanceId = #managers.blackmarket._global.inventory_tradable + 1
            if not managers.blackmarket:have_inventory_tradable_item("weapon_skins", skinName) and not skinData.is_a_color_skin then
                managers.blackmarket:tradable_add_item(instanceId, "weapon_skins", skinName, "mint", false, 1)
            end
        end
    else
        managers.blackmarket._global.inventory_tradable = {}
    end
    UT.Player:refreshAndSave()
    if value then
        UT:addAlert("ut_alert_skin_unlocker_enabled", UT.colors.success)
    else
        UT:addAlert("ut_alert_skin_unlocker_disabled", UT.colors.success)
    end
    UT:addAlert("ut_alert_restart_the_game_to_apply_changes", UT.colors.warning)
end

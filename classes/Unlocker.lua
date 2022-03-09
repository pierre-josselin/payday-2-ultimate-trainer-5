UT.Unlocker = {}

function UT.Unlocker:setDlcUnlocker(value)
    UT.settings.enableDlcUnlocker = value
    UT:saveSettings()
    if value then
        UT:addAlert("ut_alert_dlc_unlocker_enabled", UT.colors.success)
    else
        UT:addAlert("ut_alert_dlc_unlocker_disabled", UT.colors.success)
    end
end

function UT.Unlocker:setSkinUnlocker(value)
    UT.settings.enableSkinUnlocker = value
    UT:saveSettings()
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
end

UTLoadedClassUnlocker = true

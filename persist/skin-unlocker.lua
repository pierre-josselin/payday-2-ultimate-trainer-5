if not UT.settings.enableSkinUnlocker then
    UTLoadedPersistSkinUnlocker = true
    do return end
end

for skinName, skinData in pairs(tweak_data.blackmarket.weapon_skins) do
    local instanceId = #managers.blackmarket._global.inventory_tradable + 1
    if not managers.blackmarket:have_inventory_tradable_item("weapon_skins", skinName) and not skinData.is_a_color_skin then
        managers.blackmarket:tradable_add_item(instanceId, "weapon_skins", skinName, "mint", false, 1)
    end
end

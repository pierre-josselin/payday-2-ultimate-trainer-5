UT.Spawn = {}

UT.Spawn.index = nil
UT.Spawn.mode = nil
UT.Spawn.available = {}
UT.Spawn.position = "crosshair"

function UT.Spawn:setMode(mode)
    UT.Spawn.index = 1
    UT.Spawn.mode = mode
end

function UT.Spawn:setModeEnemies()
    UT.Spawn:setMode("enemies")
end

function UT.Spawn:setModeAllies()
    UT:enableUnlimitedConversions()
    UT.Spawn:setMode("allies")
end

function UT.Spawn:setModeCivilians()
    UT.Spawn.available.civilians = {}
    for key, value in pairs(UT.Tables.civilians) do
        if UT:isUnitLoaded(Idstring(value)) then
            table.insert(UT.Spawn.available.civilians, value)
        end
    end
    if UT.Utils:isTableEmpty(UT.Spawn.available.civilians) then
        UT:addAlert("ut_alert_no_civilians_available_here", UT.colors.danger)
        return
    end
    UT.Spawn:setMode("civilians")
end

function UT.Spawn:setModeLoots()
    UT.Spawn.available.loots = {}
    for key, value in pairs(UT.Tables.loots) do
        if UT:isUnitLoaded(Idstring(value)) then
            table.insert(UT.Spawn.available.loots, value)
        end
    end
    if UT.Utils:isTableEmpty(UT.Spawn.available.loots) then
        UT:addAlert("ut_alert_no_loots_available_here", UT.colors.danger)
        return
    end
    UT.Spawn:setMode("loots")
end

function UT.Spawn:setModeEquipments()
    UT.Spawn.available.equipments = {}
    for key, value in pairs(UT.Tables.equipments) do
        table.insert(UT.Spawn.available.equipments, value)
    end
    UT.Spawn:setMode("equipments")
end

function UT.Spawn:setModePackages()
    UT.Spawn.available.packages = {}
    for key, value in pairs(UT.Tables.packages) do
        table.insert(UT.Spawn.available.packages, value)
    end
    function tweak_data.gage_assignment:get_num_assignment_units()
        return UT.fakeMaxInteger
    end
    UT.Spawn:setMode("packages")
end

function UT.Spawn:setModeBags()
    UT.Spawn:setMode("bags")
end

function UT.Spawn:setModeExplosives()
    UT.Spawn:setMode("explosives")
end

function UT.Spawn:spawnEnemy(id)
    local position = UT.Spawn:getPosition()
    if not position then
        return
    end
    local rotation = UT:getPlayerCameraRotationFlat()
    local unit = UT:spawnUnit(Idstring(id), position, rotation)
    if not unit then
        return
    end
    UT:setUnitTeam(unit, "combatant")
end

function UT.Spawn:spawnAlly(id)
    local position = UT.Spawn:getPosition()
    if not position then
        return
    end
    local rotation = UT:getPlayerCameraRotationFlat()
    local unit = UT:spawnUnit(Idstring(id), position, rotation)
    if not unit then
        return
    end
    UT:setUnitTeam(unit, "combatant")
    UT.Spawn:convertEnemy(unit)
end

function UT.Spawn:spawnCivilian(id)
    local position = UT.Spawn:getPosition()
    if not position then
        return
    end
    local rotation = UT:getPlayerCameraRotationFlat()
    local unit = UT:spawnUnit(Idstring(id), position, rotation)
    if not unit then
        return
    end
    UT:setUnitTeam(unit, "non_combatant")
    unit:brain():action_request({
        type = "act",
        variant = "cm_sp_stand_idle"
    })
end

function UT.Spawn:spawnLoot(name)
    local position = UT.Spawn:getPosition()
    if not position then
        return
    end
    local rotation = UT:getPlayerCameraRotationFlat()
    UT:spawnUnit(Idstring(name), position, rotation)
end

function UT.Spawn:spawnEquipment(name)
    local position = UT.Spawn:getPosition()
    if not position then
        return
    end
    local rotation = UT:getPlayerCameraRotationFlat()
    if name == "ammo_bag" then
        AmmoBagBase.spawn(position, rotation, 1)
    elseif name == "doctor_bag" then
        DoctorBagBase.spawn(position, rotation, 4)
    elseif name == "first_aid_kit" then
        FirstAidKitBase.spawn(position, rotation, 1)
    elseif name == "body_bags_bag" then
        BodyBagsBagBase.spawn(position, rotation)
    elseif name == "grenade_crate" then
        GrenadeCrateBase.spawn(position, rotation)
    elseif name == "trip_mine" then
        if UT.Spawn.position == "crosshair" then
            local crosshairRay = UT:getCrosshairRay()
            if not crosshairRay then
                return
            end
            rotation = Rotation(crosshairRay.normal, math.UP)
        elseif UT.Spawn.position == "self" then
            rotation = Rotation(UT:getPlayerCameraRotation():yaw(), 90, 0)
        end
        local unit = TripMineBase.spawn(position, rotation, true)
        if not unit then
            return
        end
        local playerUnit = managers.player:player_unit()
        unit:base():set_active(true, playerUnit)
    elseif name == "sentry_gun" then
        UT.Spawn:setEquipment("sentry_gun")
        local playerUnit = managers.player:player_unit()
        local unit = SentryGunBase.spawn(playerUnit, position, rotation)
        if not unit then
            return
        end
        unit:base():post_setup(1)
        managers.network:session():send_to_peers_synched("from_server_sentry_gun_place_result", 1, 0, unit, 2, 2, true,
            2)
    end
end

function UT.Spawn:spawnPackage(id)
    local position = UT.Spawn:getPosition()
    if not position then
        return
    end
    local rotation = UT:getPlayerCameraRotationFlat()
    UT:spawnUnit(Idstring(id), position, rotation)
end

function UT.Spawn:spawnBag(name)
    local position = UT:getPlayerCameraPosition()
    local rotation = UT:getPlayerCameraRotation()
    local forward = UT:getPlayerCameraForward()
    
    if name == "piggy" then
        UT:spawnUnit(Idstring("units/pd2_dlc_pda9/props/pda9_pickup_feed_bag/pda9_pickup_feed_bag"), position, rotation)
        return
    end

    managers.player:server_drop_carry(name, managers.money:get_bag_value(name), true, true, 1, position, rotation, forward, 100, nil, nil)
end

function UT.Spawn:spawnExplosive(id)
    local position = UT.Spawn:getPosition()
    if not position then
        return
    end
    local rotation = UT:getPlayerCameraRotationFlat()
    UT:spawnUnit(Idstring(id), position, rotation)
end

function UT.Spawn:removeNpcs()
    local units = {}
    for key, value in pairs(managers.enemy:all_civilians()) do
        table.insert(units, value.unit)
    end
    for key, value in pairs(managers.enemy:all_enemies()) do
        if value.unit:brain()._attention_handler._team.id ~= "neutral1" then
            table.insert(units, value.unit)
        end
    end
    UT:removeUnits(units)
    UT:addAlert("ut_alert_removed_npcs", UT.colors.info)
end

function UT.Spawn:removeLoots()
    local units = {}
    for key, unit in pairs(managers.interaction._interactive_units) do
        if not alive(unit) then
            goto continue
        end
        if not UT.Tables.loots[unit:name():key()] then
            goto continue
        end
        table.insert(units, unit)
        ::continue::
    end
    UT:removeUnits(units)
    UT:addAlert("ut_alert_removed_loots", UT.colors.info)
end

function UT.Spawn:removeEquipments()
    local units = {}
    for key, unit in pairs(World:find_units_quick("all")) do
        if not alive(unit) then
            goto continue
        end
        if not UT.Tables.equipments[unit:name():key()] then
            goto continue
        end
        table.insert(units, unit)
        ::continue::
    end
    UT:removeUnits(units)
    UT:addAlert("ut_alert_removed_equipments", UT.colors.info)
end

function UT.Spawn:removePackages()
    local units = {}
    for key, unit in pairs(managers.interaction._interactive_units) do
        if not alive(unit) then
            goto continue
        end
        if not UT.Tables.packages[unit:name():key()] then
            goto continue
        end
        table.insert(units, unit)
        ::continue::
    end
    UT:removeUnits(units)
    UT:addAlert("ut_alert_removed_packages", UT.colors.info)
end

function UT.Spawn:removeBags()
    local units = {}
    for key, unit in pairs(managers.interaction._interactive_units) do
        if not alive(unit) then
            goto continue
        end
        if not UT.Tables.bagsKeys[unit:name():key()] then
            goto continue
        end
        table.insert(units, unit)
        ::continue::
    end
    UT:removeUnits(units)
    UT:addAlert("ut_alert_removed_bags", UT.colors.info)
end

function UT.Spawn:disposeCorpses()
    managers.enemy:dispose_all_corpses()
    UT:addAlert("ut_alert_corpses_disposed", UT.colors.info)
end

function UT.Spawn:getPosition()
    if UT.Spawn.position == "crosshair" then
        local crosshairRay = UT:getCrosshairRay()
        if not crosshairRay then
            UT:addAlert("ut_alert_cannot_spawn", UT.colors.warning)
            return
        end
        return crosshairRay.position
    elseif UT.Spawn.position == "self" then
        return UT:getPlayerPosition()
    end
end

function UT.Spawn:setPosition(position)
    UT.Spawn.position = position
end

function UT.Spawn:convertEnemy(unit)
    if not alive(unit) then
        return
    end
    managers.groupai:state():convert_hostage_to_criminal(unit)
    managers.groupai:state():sync_converted_enemy(unit)
    unit:contour():add("friendly", true)
end

function UT.Spawn:setEquipment(equipment)
    managers.player:clear_equipment()
    managers.player._equipment.selections = {}
    managers.player:add_equipment({
        equipment = equipment
    })
end

function UT.Spawn:previous()
    if UT.Spawn.mode == "enemies" then
        if UT.Spawn.index == 1 then UT.Spawn.index = UT.Utils:countTable(UT.Tables.enemies)
        else UT.Spawn.index = UT.Spawn.index - 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.Tables.enemies[UT.Spawn.index]), UT.colors.white)
    elseif UT.Spawn.mode == "allies" then
        if UT.Spawn.index == 1 then UT.Spawn.index = UT.Utils:countTable(UT.Tables.enemies)
        else UT.Spawn.index = UT.Spawn.index - 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.Tables.enemies[UT.Spawn.index]), UT.colors.white)
    elseif UT.Spawn.mode == "civilians" then
        if UT.Spawn.index == 1 then UT.Spawn.index = UT.Utils:countTable(UT.Spawn.available.civilians)
        else UT.Spawn.index = UT.Spawn.index - 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.Spawn.available.civilians[UT.Spawn.index]), UT.colors.white)
    elseif UT.Spawn.mode == "loots" then
        if UT.Spawn.index == 1 then UT.Spawn.index = UT.Utils:countTable(UT.Spawn.available.loots)
        else UT.Spawn.index = UT.Spawn.index - 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.Spawn.available.loots[UT.Spawn.index]), UT.colors.white)
    elseif UT.Spawn.mode == "equipments" then
        if UT.Spawn.index == 1 then UT.Spawn.index = UT.Utils:countTable(UT.Spawn.available.equipments)
        else UT.Spawn.index = UT.Spawn.index - 1 end
        UT:showSubtitle(UT.Spawn.available.equipments[UT.Spawn.index], UT.colors.white)
    elseif UT.Spawn.mode == "packages" then
        if UT.Spawn.index == 1 then UT.Spawn.index = UT.Utils:countTable(UT.Spawn.available.packages)
        else UT.Spawn.index = UT.Spawn.index - 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.Spawn.available.packages[UT.Spawn.index]), UT.colors.white)
    elseif UT.Spawn.mode == "bags" then
        if UT.Spawn.index == 1 then UT.Spawn.index = UT.Utils:countTable(UT.Tables.bags)
        else UT.Spawn.index = UT.Spawn.index - 1 end
        UT:showSubtitle(UT.Tables.bags[UT.Spawn.index], UT.colors.white)
    elseif UT.Spawn.mode == "explosives" then
        if UT.Spawn.index == 1 then UT.Spawn.index = UT.Utils:countTable(UT.Tables.explosives)
        else UT.Spawn.index = UT.Spawn.index - 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.Tables.explosives[UT.Spawn.index]), UT.colors.white)
    else
        UT:addAlert("ut_alert_no_mode_selected", UT.colors.warning)
    end
end

function UT.Spawn:next()
    if UT.Spawn.mode == "enemies" then
        if UT.Spawn.index == UT.Utils:countTable(UT.Tables.enemies) then UT.Spawn.index = 1
        else UT.Spawn.index = UT.Spawn.index + 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.Tables.enemies[UT.Spawn.index]), UT.colors.white)
    elseif UT.Spawn.mode == "allies" then
        if UT.Spawn.index == UT.Utils:countTable(UT.Tables.enemies) then UT.Spawn.index = 1
        else UT.Spawn.index = UT.Spawn.index + 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.Tables.enemies[UT.Spawn.index]), UT.colors.white)
    elseif UT.Spawn.mode == "civilians" then
        if UT.Spawn.index == UT.Utils:countTable(UT.Spawn.available.civilians) then UT.Spawn.index = 1
        else UT.Spawn.index = UT.Spawn.index + 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.Spawn.available.civilians[UT.Spawn.index]), UT.colors.white)
    elseif UT.Spawn.mode == "loots" then
        if UT.Spawn.index == UT.Utils:countTable(UT.Spawn.available.loots) then UT.Spawn.index = 1
        else UT.Spawn.index = UT.Spawn.index + 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.Spawn.available.loots[UT.Spawn.index]), UT.colors.white)
    elseif UT.Spawn.mode == "equipments" then
        if UT.Spawn.index == UT.Utils:countTable(UT.Spawn.available.equipments) then UT.Spawn.index = 1
        else UT.Spawn.index = UT.Spawn.index + 1 end
        UT:showSubtitle(UT.Spawn.available.equipments[UT.Spawn.index], UT.colors.white)
    elseif UT.Spawn.mode == "packages" then
        if UT.Spawn.index == UT.Utils:countTable(UT.Spawn.available.packages) then UT.Spawn.index = 1
        else UT.Spawn.index = UT.Spawn.index + 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.Spawn.available.packages[UT.Spawn.index]), UT.colors.white)
    elseif UT.Spawn.mode == "bags" then
        if UT.Spawn.index == UT.Utils:countTable(UT.Tables.bags) then UT.Spawn.index = 1
        else UT.Spawn.index = UT.Spawn.index + 1 end
        UT:showSubtitle(UT.Tables.bags[UT.Spawn.index], UT.colors.white)
    elseif UT.Spawn.mode == "explosives" then
        if UT.Spawn.index == UT.Utils:countTable(UT.Tables.explosives) then UT.Spawn.index = 1
        else UT.Spawn.index = UT.Spawn.index + 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.Tables.explosives[UT.Spawn.index]), UT.colors.white)
    else
        UT:addAlert("ut_alert_no_mode_selected", UT.colors.warning)
    end
end

function UT.Spawn:place()
    if UT.Spawn.mode == "enemies" then
        UT.Spawn:spawnEnemy(UT.Tables.enemies[UT.Spawn.index])
    elseif UT.Spawn.mode == "allies" then
        UT.Spawn:spawnAlly(UT.Tables.enemies[UT.Spawn.index])
    elseif UT.Spawn.mode == "civilians" then
        UT.Spawn:spawnCivilian(UT.Spawn.available.civilians[UT.Spawn.index])
    elseif UT.Spawn.mode == "loots" then
        UT.Spawn:spawnLoot(UT.Spawn.available.loots[UT.Spawn.index])
    elseif UT.Spawn.mode == "equipments" then
        UT.Spawn:spawnEquipment(UT.Spawn.available.equipments[UT.Spawn.index])
    elseif UT.Spawn.mode == "packages" then
        UT.Spawn:spawnPackage(UT.Spawn.available.packages[UT.Spawn.index])
    elseif UT.Spawn.mode == "bags" then
        UT.Spawn:spawnBag(UT.Tables.bags[UT.Spawn.index])
    elseif UT.Spawn.mode == "explosives" then
        UT.Spawn:spawnExplosive(UT.Tables.explosives[UT.Spawn.index])
    else
        UT:addAlert("ut_alert_no_mode_selected", UT.colors.warning)
    end
end

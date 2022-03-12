UT.Spawn = {}

function UT.Spawn:setMode(mode)
    UT.tempData.spawn.index = 1
    UT.tempData.spawn.mode = mode
end

function UT.Spawn:setModeEnemies()
    UT.Spawn:setMode("enemies")
end

function UT.Spawn:setModeAllies()
    UT:enableUnlimitedConversions()
    UT.Spawn:setMode("allies")
end

function UT.Spawn:setModeCivilians()
    UT.tempData.spawn.available.civilians = {}
    for key, value in pairs(UT.Tables.civilians) do
        if UT:isUnitLoaded(Idstring(value)) then
            table.insert(UT.tempData.spawn.available.civilians, value)
        end
    end
    if UT.Utils:isTableEmpty(UT.tempData.spawn.available.civilians) then
        UT:addAlert("ut_alert_no_civilians_available_here", UT.colors.danger)
        return
    end
    UT.Spawn:setMode("civilians")
end

function UT.Spawn:setModeLoots()
    UT.tempData.spawn.available.loots = {}
    for key, value in pairs(UT.Tables.loots) do
        if UT:isUnitLoaded(Idstring(value)) then
            table.insert(UT.tempData.spawn.available.loots, value)
        end
    end
    if UT.Utils:isTableEmpty(UT.tempData.spawn.available.loots) then
        UT:addAlert("ut_alert_no_loots_available_here", UT.colors.danger)
        return
    end
    UT.Spawn:setMode("loots")
end

function UT.Spawn:setModeEquipments()
    UT.tempData.spawn.available.equipments = {}
    for key, value in pairs(UT.Tables.equipments) do
        table.insert(UT.tempData.spawn.available.equipments, value)
    end
    UT.Spawn:setMode("equipments")
end

function UT.Spawn:setModePackages()
    UT.tempData.spawn.available.packages = {}
    for key, value in pairs(UT.Tables.packages) do
        table.insert(UT.tempData.spawn.available.packages, value)
    end
    function tweak_data.gage_assignment:get_num_assignment_units()
        return UT.fakeMaxInteger
    end
    UT.Spawn:setMode("packages")
end

function UT.Spawn:setModeBags()
    UT.Spawn:setMode("bags")
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
    UT.Spawn:setTeam(unit, "combatant")
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
    UT.Spawn:setTeam(unit, "combatant")
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
    UT.Spawn:setTeam(unit, "non_combatant")
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
        if UT.tempData.spawn.position == "crosshair" then
            local crosshairRay = UT:getCrosshairRay()
            if not crosshairRay then
                return
            end
            rotation = Rotation(crosshairRay.normal, math.UP)
        elseif UT.tempData.spawn.position == "self" then
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
    managers.player:server_drop_carry(name, managers.money:get_bag_value(name), true, true, 1, position, rotation,
        forward, 100, nil, nil)
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
    if UT.tempData.spawn.position == "crosshair" then
        local crosshairRay = UT:getCrosshairRay()
        if not crosshairRay then
            UT:addAlert("ut_alert_cannot_spawn", UT.colors.warning)
            return
        end
        return crosshairRay.position
    elseif UT.tempData.spawn.position == "self" then
        return UT:getPlayerPosition()
    end
end

function UT.Spawn:setPosition(position)
    UT.tempData.spawn.position = position
end

function UT.Spawn:setTeam(unit, team)
    if not alive(unit) then
        return
    end
    local teamId = tweak_data.levels:get_default_team_ID(team)
    local teamData = managers.groupai:state():team_data(teamId)
    unit:movement():set_team(teamData)
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
    if UT.tempData.spawn.mode == "enemies" then
        if UT.tempData.spawn.index == 1 then UT.tempData.spawn.index = UT.Utils:countTable(UT.Tables.enemies)
        else UT.tempData.spawn.index = UT.tempData.spawn.index - 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.Tables.enemies[UT.tempData.spawn.index]), UT.colors.white)
    elseif UT.tempData.spawn.mode == "allies" then
        if UT.tempData.spawn.index == 1 then UT.tempData.spawn.index = UT.Utils:countTable(UT.Tables.enemies)
        else UT.tempData.spawn.index = UT.tempData.spawn.index - 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.Tables.enemies[UT.tempData.spawn.index]), UT.colors.white)
    elseif UT.tempData.spawn.mode == "civilians" then
        if UT.tempData.spawn.index == 1 then UT.tempData.spawn.index = UT.Utils:countTable(UT.tempData.spawn.available.civilians)
        else UT.tempData.spawn.index = UT.tempData.spawn.index - 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.tempData.spawn.available.civilians[UT.tempData.spawn.index]), UT.colors.white)
    elseif UT.tempData.spawn.mode == "loots" then
        if UT.tempData.spawn.index == 1 then UT.tempData.spawn.index = UT.Utils:countTable(UT.tempData.spawn.available.loots)
        else UT.tempData.spawn.index = UT.tempData.spawn.index - 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.tempData.spawn.available.loots[UT.tempData.spawn.index]), UT.colors.white)
    elseif UT.tempData.spawn.mode == "equipments" then
        if UT.tempData.spawn.index == 1 then UT.tempData.spawn.index = UT.Utils:countTable(UT.tempData.spawn.available.equipments)
        else UT.tempData.spawn.index = UT.tempData.spawn.index - 1 end
        UT:showSubtitle(UT.tempData.spawn.available.equipments[UT.tempData.spawn.index], UT.colors.white)
    elseif UT.tempData.spawn.mode == "packages" then
        if UT.tempData.spawn.index == 1 then UT.tempData.spawn.index = UT.Utils:countTable(UT.tempData.spawn.available.packages)
        else UT.tempData.spawn.index = UT.tempData.spawn.index - 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.tempData.spawn.available.packages[UT.tempData.spawn.index]), UT.colors.white)
    elseif UT.tempData.spawn.mode == "bags" then
        if UT.tempData.spawn.index == 1 then UT.tempData.spawn.index = UT.Utils:countTable(UT.Tables.bags)
        else UT.tempData.spawn.index = UT.tempData.spawn.index - 1 end
        UT:showSubtitle(UT.Tables.bags[UT.tempData.spawn.index], UT.colors.white)
    else
        UT:addAlert("ut_alert_no_mode_selected", UT.colors.warning)
    end
end

function UT.Spawn:next()
    if UT.tempData.spawn.mode == "enemies" then
        if UT.tempData.spawn.index == UT.Utils:countTable(UT.Tables.enemies) then UT.tempData.spawn.index = 1
        else UT.tempData.spawn.index = UT.tempData.spawn.index + 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.Tables.enemies[UT.tempData.spawn.index]), UT.colors.white)
    elseif UT.tempData.spawn.mode == "allies" then
        if UT.tempData.spawn.index == UT.Utils:countTable(UT.Tables.enemies) then UT.tempData.spawn.index = 1
        else UT.tempData.spawn.index = UT.tempData.spawn.index + 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.Tables.enemies[UT.tempData.spawn.index]), UT.colors.white)
    elseif UT.tempData.spawn.mode == "civilians" then
        if UT.tempData.spawn.index == UT.Utils:countTable(UT.tempData.spawn.available.civilians) then UT.tempData.spawn.index = 1
        else UT.tempData.spawn.index = UT.tempData.spawn.index + 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.tempData.spawn.available.civilians[UT.tempData.spawn.index]), UT.colors.white)
    elseif UT.tempData.spawn.mode == "loots" then
        if UT.tempData.spawn.index == UT.Utils:countTable(UT.tempData.spawn.available.loots) then UT.tempData.spawn.index = 1
        else UT.tempData.spawn.index = UT.tempData.spawn.index + 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.tempData.spawn.available.loots[UT.tempData.spawn.index]), UT.colors.white)
    elseif UT.tempData.spawn.mode == "equipments" then
        if UT.tempData.spawn.index == UT.Utils:countTable(UT.tempData.spawn.available.equipments) then UT.tempData.spawn.index = 1
        else UT.tempData.spawn.index = UT.tempData.spawn.index + 1 end
        UT:showSubtitle(UT.tempData.spawn.available.equipments[UT.tempData.spawn.index], UT.colors.white)
    elseif UT.tempData.spawn.mode == "packages" then
        if UT.tempData.spawn.index == UT.Utils:countTable(UT.tempData.spawn.available.packages) then UT.tempData.spawn.index = 1
        else UT.tempData.spawn.index = UT.tempData.spawn.index + 1 end
        UT:showSubtitle(UT.Utils:getPathBaseName(UT.tempData.spawn.available.packages[UT.tempData.spawn.index]), UT.colors.white)
    elseif UT.tempData.spawn.mode == "bags" then
        if UT.tempData.spawn.index == UT.Utils:countTable(UT.Tables.bags) then UT.tempData.spawn.index = 1
        else UT.tempData.spawn.index = UT.tempData.spawn.index + 1 end
        UT:showSubtitle(UT.Tables.bags[UT.tempData.spawn.index], UT.colors.white)
    else
        UT:addAlert("ut_alert_no_mode_selected", UT.colors.warning)
    end
end

function UT.Spawn:place()
    if UT.tempData.spawn.mode == "enemies" then
        UT.Spawn:spawnEnemy(UT.Tables.enemies[UT.tempData.spawn.index])
    elseif UT.tempData.spawn.mode == "allies" then
        UT.Spawn:spawnAlly(UT.Tables.enemies[UT.tempData.spawn.index])
    elseif UT.tempData.spawn.mode == "civilians" then
        UT.Spawn:spawnCivilian(UT.tempData.spawn.available.civilians[UT.tempData.spawn.index])
    elseif UT.tempData.spawn.mode == "loots" then
        UT.Spawn:spawnLoot(UT.tempData.spawn.available.loots[UT.tempData.spawn.index])
    elseif UT.tempData.spawn.mode == "equipments" then
        UT.Spawn:spawnEquipment(UT.tempData.spawn.available.equipments[UT.tempData.spawn.index])
    elseif UT.tempData.spawn.mode == "packages" then
        UT.Spawn:spawnPackage(UT.tempData.spawn.available.packages[UT.tempData.spawn.index])
    elseif UT.tempData.spawn.mode == "bags" then
        UT.Spawn:spawnBag(UT.Tables.bags[UT.tempData.spawn.index])
    else
        UT:addAlert("ut_alert_no_mode_selected", UT.colors.warning)
    end
end

UTLoadedClassSpawn = true

UT.Driving = {}

function UT.Driving:setPackagesLoading(value)
    UT.settings.drivingPackagesLoading = value
    UT:saveSettings()
    if value then
        UT:addAlert("ut_alert_packages_loading_enabled", UT.colors.success)
        if not UT.tempSettings.driving.packagesLoaded then
            UT:addAlert("ut_alert_restart_the_heist_to_apply_changes", UT.colors.warning)
        end
    else
        UT:addAlert("ut_alert_packages_loading_disabled", UT.colors.success)
    end
end

function UT.Driving:setSelectedVehicle(id)
    UT.tempSettings.driving.selectedVehicle = id
end

function UT.Driving:spawnVehicle()
    local id = UT.tempSettings.driving.selectedVehicle
    if not UT.tempSettings.driving.packagesLoaded then
        UT:addAlert("ut_alert_you_must_first_load_packages", UT.colors.danger)
        return
    end
    if LuaNetworking:GetNumberOfPeers() > 0 then
        UT:addAlert("ut_alert_you_must_be_alone_in_the_game", UT.colors.warning)
        return
    end
    local vehiclePosition = UT:getPlayerPosition()
    local vehicleRotation = UT:getPlayerCameraRotationFlat()
    local playerPosition = Vector3(vehiclePosition[1], vehiclePosition[2], vehiclePosition[3] + 350)
    local playerRotation = UT:getPlayerCameraRotation()
    local unit = UT:spawnUnit(Idstring(id), vehiclePosition, vehicleRotation)
    UT:log(unit)
    if not unit then
        return
    end
    UT:teleportPlayer(playerPosition, playerRotation)
    table.insert(UT.tempData.driving.units, unit)
end

function UT.Driving:removeVehicles()
    if UT:isDriving() then
        managers.player:set_player_state("standard")
    end
    for key, unit in pairs(UT.tempData.driving.units) do
        if alive(unit) then
            unit:set_position(Vector3(0, 0, -10000))
            unit:set_rotation(Rotation(0, 0, 0))
        end
    end
    UT.tempData.driving.units = {}
    UT:addAlert("ut_alert_vehicles_removed", UT.colors.success)
end

UTLoadedClassDriving = true

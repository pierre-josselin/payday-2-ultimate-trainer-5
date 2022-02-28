UT.Construction = {}

function UT.Construction:pick()
    local crosshairRay = UT:getCrosshairRay()

    if not crosshairRay or not crosshairRay.unit then
        UT:addAlert("ut_alert_nothing_to_pick", UT.colors.warning)
        return
    end

    UT:playSound("box_tick")
    UT:showHitMarker()

    local unit = crosshairRay.unit

    if unit:base() then
        UT:addAlert("ut_alert_cannot_pick_this_unit", UT.colors.danger)
        return
    end

    UT.tempSettings.construction.pickedUnit = unit
end

function UT.Construction:spawn()
    if not UT.tempSettings.construction.pickedUnit then
        UT:addAlert("ut_alert_no_unit_picked", UT.colors.warning)
        return
    end

    local crosshairRay = UT:getCrosshairRay()

    if not crosshairRay then
        UT:addAlert("ut_alert_cannot_spawn_unit", UT.colors.warning)
        return
    end

    local position = crosshairRay.position
    local rotation = UT:getPlayerCameraRotationFlat()

    local unitName = UT.tempSettings.construction.pickedUnit:name()
    local unit = UT:spawnUnit(unitName, position, rotation)

    if not unit then
        UT:addAlert("ut_alert_spawn_unit_failure", UT.colors.danger)
        return
    end

    UT.tempSettings.construction.spawnedUnits[UT.Utils:toString(unit)] = unit

    UT:playSound("zoom_in")
    UT:showHitMarker()
end

function UT.Construction:delete()
    local crosshairRay = UT:getCrosshairRay()

    if not crosshairRay or not crosshairRay.unit then
        UT:addAlert("ut_alert_nothing_to_delete", UT.colors.warning)
        return
    end

    local unit = crosshairRay.unit
    local unitTableKey = UT.Utils:toString(unit)

    if not UT.tempSettings.construction.spawnedUnits[unitTableKey] then
        UT:addAlert("ut_alert_nothing_to_delete", UT.colors.warning)
        return
    end

    UT.tempSettings.construction.spawnedUnits[unitTableKey] = nil
    UT:removeUnit(unit)

    UT:playSound("zoom_out")
    UT:showHitMarker()
end

function UT.Construction:drawPickedUnit()
    local unit = UT.tempSettings.construction.pickedUnit

    if not alive(unit) then
        return
    end

    if unit:network_sync() == "spawn" then
        Application:draw(unit, 0, 1, 0)
    else
        Application:draw(unit, 1, 0.5, 0)
    end
end

UTLoadedClassConstruction = true

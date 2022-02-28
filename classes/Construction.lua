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

    UT.tempData.construction.pickedUnit = unit
end

function UT.Construction:spawn()
    if not UT.tempData.construction.pickedUnit then
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

    local unitName = UT.tempData.construction.pickedUnit:name()
    local unit = UT:spawnUnit(unitName, position, rotation)

    if not unit then
        UT:addAlert("ut_alert_spawn_unit_failure", UT.colors.danger)
        return
    end

    UT.tempData.construction.spawnedUnits[UT.Utils:toString(unit)] = unit

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

    if not UT.tempData.construction.spawnedUnits[unitTableKey] then
        UT:addAlert("ut_alert_nothing_to_delete", UT.colors.warning)
        return
    end

    UT.tempData.construction.spawnedUnits[unitTableKey] = nil
    UT:removeUnit(unit)

    UT:playSound("zoom_out")
    UT:showHitMarker()
end

function UT.Construction:drawPickedUnit()
    local unit = UT.tempData.construction.pickedUnit

    if not alive(unit) then
        return
    end

    if unit:network_sync() == "spawn" then
        Application:draw(unit, 0, 1, 0)
    else
        Application:draw(unit, 1, 0.5, 0)
    end
end

function UT.Construction:clear()
    for key, unit in pairs(UT.tempData.construction.spawnedUnits) do
        UT:removeUnit(unit)
        UT.tempData.construction.spawnedUnits[key] = nil
    end
end

function UT.Construction:setCrosshairMarker(value)
    if not UT.tempData.construction.crosshairMarker.workspace then
        local options = {visible = true, color = UT.colors.white:with_alpha(0.5), w = 7, h = 7}
        UT.tempData.construction.crosshairMarker.workspace = Overlay:newgui():create_screen_workspace():panel()
        UT.tempData.construction.crosshairMarker.workspace:bitmap(options):set_center(UT.tempData.construction.crosshairMarker.workspace:center())
    end
    if UT.tempData.construction.crosshairMarker.enabled then
        UT.tempData.construction.crosshairMarker.workspace:hide()
        UT.tempData.construction.crosshairMarker.enabled = false
    else
        UT.tempData.construction.crosshairMarker.workspace:show()
        UT.tempData.construction.crosshairMarker.enabled = true
    end
end

UTLoadedClassConstruction = true

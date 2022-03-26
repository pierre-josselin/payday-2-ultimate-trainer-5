UT.Construction = {}

UT.Construction.pickedUnit = nil
UT.Construction.spawnedUnits = {}
UT.Construction.crosshairMarker = {}

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

    UT.Construction.pickedUnit = unit
end

function UT.Construction:spawn()
    if not UT.Construction.pickedUnit then
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

    local unitName = UT.Construction.pickedUnit:name()
    local unit = UT:spawnUnit(unitName, position, rotation)

    if not unit then
        UT:addAlert("ut_alert_spawn_unit_failure", UT.colors.danger)
        return
    end

    UT.Construction.spawnedUnits[UT.Utils:toString(unit)] = unit

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

    if not UT.Construction.spawnedUnits[unitTableKey] then
        UT:addAlert("ut_alert_nothing_to_delete", UT.colors.warning)
        return
    end

    UT.Construction.spawnedUnits[unitTableKey] = nil
    UT:removeUnit(unit)

    UT:playSound("zoom_out")
    UT:showHitMarker()
end

function UT.Construction:drawPickedUnit()
    local unit = UT.Construction.pickedUnit

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
    for key, unit in pairs(UT.Construction.spawnedUnits) do
        UT:removeUnit(unit)
        UT.Construction.spawnedUnits[key] = nil
    end
    UT:addAlert("ut_alert_construction_cleared", UT.colors.success)
end

function UT.Construction:setCrosshairMarker(value)
    if not UT.Construction.crosshairMarker.workspace then
        local options = {visible = true, color = UT.colors.white:with_alpha(0.5), w = 7, h = 7}
        UT.Construction.crosshairMarker.workspace = Overlay:newgui():create_screen_workspace():panel()
        UT.Construction.crosshairMarker.workspace:bitmap(options):set_center(UT.Construction.crosshairMarker.workspace:center())
    end
    if UT.Construction.crosshairMarker.enabled then
        UT.Construction.crosshairMarker.workspace:hide()
        UT.Construction.crosshairMarker.enabled = false
    else
        UT.Construction.crosshairMarker.workspace:show()
        UT.Construction.crosshairMarker.enabled = true
    end
end

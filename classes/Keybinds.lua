UT.Keybinds = {}

function UT.Keybinds:teleport()
    local crosshairRay = UT:getCrosshairRay()

    if not crosshairRay then
        return
    end

    local offset = Vector3()
    mvector3.set(offset, UT:getPlayerCameraForward())
    mvector3.multiply(offset, 100)
    mvector3.add(crosshairRay.hit_position, offset)
    UT:teleportPlayer(crosshairRay.hit_position, UT:getPlayerCameraRotation())
end

function UT.Keybinds:replenish()
    local playerUnit = managers.player:player_unit()

    if not alive(playerUnit) then
        return
    end

    managers.player:add_grenade_amount(99)
    managers.player:add_body_bags_amount(99)
    managers.player:add_special({name = "cable_tie", amount = 99})
    managers.player:set_player_state("standard")
    playerUnit:base():replenish()
end

UTLoadedClassKeybinds = true

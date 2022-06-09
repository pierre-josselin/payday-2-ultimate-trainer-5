UT.GroupSpawn = {}

UT.GroupSpawn.animations = UT.Tables.groupSpawnAnimations[1]
UT.GroupSpawn.areaSize = 200
UT.GroupSpawn.peopleNumber = 50

function UT.GroupSpawn:setAnimations(animations)
    UT.GroupSpawn.animations = animations
end

function UT.GroupSpawn:setAreaSize(areaSize)
    UT.GroupSpawn.areaSize = areaSize
end

function UT.GroupSpawn:setPeopleNumber(peopleNumber)
    UT.GroupSpawn.peopleNumber = peopleNumber
end

function UT.GroupSpawn:spawn()
    local availableCivilians = {}
    for key, value in pairs(UT.Tables.civilians) do
        if UT:isUnitLoaded(Idstring(value)) then
            table.insert(availableCivilians, value)
        end
    end
    if UT.Utils:isTableEmpty(availableCivilians) then
        UT:addAlert("ut_alert_no_civilians_available_here", UT.colors.danger)
        return
    end
    for i = 1, UT.GroupSpawn.peopleNumber do
        local animation = UT.Utils:getRandomElementFromTable(UT.GroupSpawn.animations)
        local unitName = Idstring(UT.Utils:getRandomElementFromTable(availableCivilians))
        local playerPosition = UT:getPlayerPosition()
        local unitPosition = Vector3(
            playerPosition.x + UT.Utils:getRandomNumber(
                -UT.GroupSpawn.areaSize,
                UT.GroupSpawn.areaSize,
                true
            ),
            playerPosition.y + UT.Utils:getRandomNumber(
                -UT.GroupSpawn.areaSize,
                UT.GroupSpawn.areaSize,
                true
            ),
            playerPosition.z
        )
        local unitRotation = Rotation(UT.Utils:getRandomNumber(-180, 180, true))
        local unit = UT:spawnUnit(unitName, unitPosition, unitRotation)
        local spawnAi = {
            init_state = "inactive"
        }
        local actionData = {
            type = "act",
            body_part = 1,
            variant = animation,
            clamp_to_graph = true,
            blocks = {
                light_hurt = -1,
                hurt = -1,
                heavy_hurt = -1,
                walk = -1
            }
        }
        UT:setUnitTeam(unit, "non_combatant")
        unit:brain():set_spawn_ai(spawnAi)
        unit:brain():action_request(actionData)
        unit:set_active(true)
    end
end

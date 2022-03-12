UT.Mission = {}

function UT.Mission:accessCameras()
    game_state_machine:change_state_by_name("ingame_access_camera")
end

function UT.Mission:removeInvisibleWalls()
    local units = World:find_units_quick("all", 1)
    for key, unit in pairs(units) do
        if UT.Utils:inTable(unit:name():key(), UT.Tables.invisibleWalls) then
            UT:removeUnit(unit)
        end
    end
    UT:addAlert("ut_alert_invisible_walls_removed", UT.colors.success)
end

function UT.Mission:convertAllEnemies()
    UT:enableUnlimitedConversions()
    for key, data in pairs(managers.enemy:all_enemies()) do
        if not alive(data.unit) then
            goto continue
        end
        managers.groupai:state():convert_hostage_to_criminal(data.unit)
        managers.groupai:state():sync_converted_enemy(data.unit)
        data.unit:contour():add("friendly", true)
        ::continue::
    end
    UT:addAlert("ut_alert_converted_all_enemies", UT.colors.success)
end

function UT.Mission:triggerAlarm()
    managers.groupai:state():on_police_called("empty")
    UT:addAlert("ut_alert_alarm_triggered", UT.colors.success)
end

function UT.Mission:setDisableAi(value)
    UT.tempSettings.mission.disableAi = value
    if not value then
        for key, value in pairs(managers.enemy:all_civilians()) do
            value.unit:brain():set_active(true)
        end

        for key, value in pairs(managers.enemy:all_enemies()) do
            value.unit:brain():set_active(true)
        end

        for key, unit in pairs(SecurityCamera.cameras) do
            unit:base()._detection_interval = 0.1
        end

        if managers.groupai:state():turrets() then
            for key, unit in pairs(managers.groupai:state():turrets()) do
                unit:brain():set_active(true)
            end
        end
    end
    if value then
        UT:addAlert("ut_alert_disable_ai_enabled", UT.colors.success)
    else
        UT:addAlert("ut_alert_disable_ai_disabled", UT.colors.success)
    end
end

function UT.Mission:disableAi()
    for key, data in pairs(managers.enemy:all_civilians()) do
        if data.unit:brain():is_active() then
            data.unit:brain():set_active(false)
        end
    end

    for key, data in pairs(managers.enemy:all_enemies()) do
        if data.unit:brain():is_active() then
            data.unit:brain():set_active(false)
        end
    end

    for key, unit in pairs(SecurityCamera.cameras) do
        if unit:base()._detection_interval ~= UT.fakeMaxInteger then
            unit:base()._detection_interval = UT.fakeMaxInteger
        end
    end

    if managers.groupai:state():turrets() then
        for key, unit in pairs(managers.groupai:state():turrets()) do
            if unit:brain():is_active() then
                unit:brain():set_active(false)
            end
        end
    end
end

function UT.Mission:setInstantDrilling(value)
    _G.CloneClass(TimerGui)
    if value then
        function TimerGui:_set_jamming_values()
        end
        function TimerGui:start()
            local timer = 0.01
            self:_start(timer)
            managers.network:session():send_to_peers_synched("start_timer_gui", self._unit, timer)
        end
    else
        TimerGui._set_jamming_values = TimerGui.orig._set_jamming_values
        TimerGui.start = TimerGui.orig.start
    end
    if value then
        UT:addAlert("ut_alert_instant_drilling_enabled", UT.colors.success)
    else
        UT:addAlert("ut_alert_instant_drilling_disabled", UT.colors.success)
    end
end

function UT.Mission:setPreventAlarmTriggering(value)
    _G.CloneClass(GroupAIStateBase)
    if value then
        function GroupAIStateBase:on_police_called()
        end
    else
        GroupAIStateBase.on_police_called = GroupAIStateBase.orig.on_police_called
    end
    if value then
        UT:addAlert("ut_alert_prevent_alarm_triggering_enabled", UT.colors.success)
    else
        UT:addAlert("ut_alert_prevent_alarm_triggering_disabled", UT.colors.success)
    end
end

function UT.Mission:setUnlimitedPagers(value)
    if value then
        tweak_data.player.alarm_pager.bluff_success_chance = {1, 1, 1, 1, 1}
    else
        tweak_data.player.alarm_pager.bluff_success_chance = {1, 1, 1, 1, 0}
    end
    if value then
        UT:addAlert("ut_alert_unlimited_pagers_enabled", UT.colors.success)
    else
        UT:addAlert("ut_alert_unlimited_pagers_disabled", UT.colors.success)
    end
end

function UT.Mission:setXray(value)
    if value then
        for key, data in pairs(managers.enemy:all_civilians()) do
            data.unit:contour():add("mark_enemy", false, UT.fakeMaxInteger)
        end
    
        for key, data in pairs(managers.enemy:all_enemies()) do
            data.unit:contour():add("mark_enemy", false, UT.fakeMaxInteger)
        end
    
        for key, unit in pairs(SecurityCamera.cameras) do
            unit:contour():add("mark_unit", false, UT.fakeMaxInteger)
        end
    else
        for key, data in pairs(managers.enemy:all_civilians()) do
            data.unit:contour():remove("mark_enemy", false)
        end
        
        for key, data in pairs(managers.enemy:all_enemies()) do
            data.unit:contour():remove("mark_enemy", false)
        end
        
        for key, unit in pairs(SecurityCamera.cameras) do
            unit:contour():remove("mark_unit", false)
        end
    end
    if value then
        UT:addAlert("ut_alert_xray_enabled", UT.colors.success)
    else
        UT:addAlert("ut_alert_xray_disabled", UT.colors.success)
    end
end

UTLoadedClassMission = true

UT.Time = {}

function UT.Time:setEnvironment(environment)
    UT:setSetting("time_environment", environment)
    UT:addAlert("ut_alert_environment_set", UT.colors.success)
end

function UT.Time:resetEnvironment()
    UT.Time:setEnvironment(nil)
    if UT:isInHeist() then
        UT:addAlert("ut_alert_restart_the_heist_to_apply_changes", UT.colors.warning)
    end
end

function UT.Time:checkEnvironment()
    local environment = managers.environment_controller._vp._env_handler._path
    --local environment = managers.viewport:first_active_viewport():get_environment_path()

    if not environment then
        return
    end

    if environment == UT:getSetting("time_environment") then
        return
    end

    managers.viewport:first_active_viewport():set_environment(UT:getSetting("time_environment"))
end

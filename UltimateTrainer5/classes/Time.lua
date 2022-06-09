UT.Time = {}

UT.Time.defaultEnvironment = nil

function UT.Time:getEnvironment()
    return managers.environment_controller._vp._env_handler._path
    --return managers.viewport:first_active_viewport():get_environment_path()
end

function UT.Time:setEnvironment(environment)
    managers.viewport:first_active_viewport():set_environment(environment)
end

function UT.Time:setEnvironmentSetting(environment)
    UT:setSetting("time_environment", environment)
    UT:addAlert("ut_alert_environment_set", UT.colors.success)
end

function UT.Time:setDefaultEnvironment()
    UT.Time.defaultEnvironment = UT.Time:getEnvironment()
end

function UT.Time:resetEnvironment()
    UT.Time:setEnvironmentSetting(nil)
    if UT.Time.defaultEnvironment then
        UT.Time:setEnvironment(UT.Time.defaultEnvironment)
    end
end

function UT.Time:checkEnvironment()
    local environment = UT.Time:getEnvironment()

    if not environment then
        return
    end

    if environment == UT:getSetting("time_environment") then
        return
    end

    managers.viewport:first_active_viewport():set_environment(UT:getSetting("time_environment"))
end

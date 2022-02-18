UT = {}

UT.settings = {}

UT.saveFilesNames = {}
UT.saveFilesNames.settings = "ut-settings.json"

UT.colors = {
    white = Color("ffffff"),
    success = Color("00ff00"),
    warning = Color("ffff00"),
    danger = Color("ff0000")
}

function UT:loadSettings()
    UT.settings = UT.Utils:getSaveTable(UT.saveFilesNames.settings)
    return true
end

function UT:saveSettings()
    return UT.Utils:setSaveTable(UT.saveFilesNames.settings, UT.settings)
end

function UT:log(data)
    log(UT.Utils:toString(data))
end

function UT:getLocalizedText(stringId)
    return managers.localization:text(stringId)
end

function UT:addAlert(message, color, localized)
    if localized or localized == nil then
        message = UT:getLocalizedText(message)
    end
    managers.mission._fading_debug_output:script().log(message, color or UT.colors.white)
end

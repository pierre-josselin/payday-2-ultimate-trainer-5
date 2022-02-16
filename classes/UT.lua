UT = {}

UT.saveFilesNames = {}
UT.saveFilesNames.settings = "ut-settings.json"

function UT:getSettings()
    return UT.Utils:getSaveTable(UT.saveFilesNames.settings)
end

function UT:setSettings(settings)
    return UT.Utils:setSaveTable(UT.saveFilesNames.settings, settings)
end

function UT:log(data)
    log(UT.Utils:toString(data))
end

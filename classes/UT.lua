UT = {}

UT.settings = {}

UT.saveFilesNames = {}
UT.saveFilesNames.settings = "ut-settings.json"

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

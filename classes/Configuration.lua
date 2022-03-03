UT.Configuration = {}

function UT.Configuration:setAntiCheatChecker(value)
    UT.settings.enableAntiCheatChecker = value
    UT:saveSettings()
end

UTLoadedClassConfiguration = true

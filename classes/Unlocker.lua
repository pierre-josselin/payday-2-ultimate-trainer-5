UT.Unlocker = {}

function UT.Unlocker:toggleDlcUnlocker(value)
    UT.settings.enableDlcUnlocker = value
    UT:saveSettings()
end

function UT.Unlocker:toggleSkinUnlocker(value)
    UT.settings.enableSkinUnlocker = value
    UT:saveSettings()
end

UTLoadedClassUnlocker = true

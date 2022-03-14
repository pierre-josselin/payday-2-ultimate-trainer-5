UT.debugLogClass = DebugLogClass:new()

UT:loadSettings()

UT.tempSettings.driving.packagesLoaded = UT.settings.drivingPackagesLoading
UT.tempSettings.driving.selectedVehicle = UT.Tables.vehicles[1]

UT.tempSettings.dexterity.moveSpeedMultiplier = 1
UT.tempSettings.dexterity.throwDistanceMultiplier = 1
UT.tempSettings.dexterity.fireRateMultiplier = 1
UT.tempSettings.dexterity.damageMultiplier = 1

managers.mission._fading_debug_output:script().configure({
    font_size = 22,
    max_rows = 10
})

UTLoadedPersistInit = true

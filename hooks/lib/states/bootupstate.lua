_G.CloneClass(BootupState)
function BootupState:at_enter()
    BootupState.orig.at_enter(self)

    UT:loadSettings()

    if UT.settings.initializedVersion ~= UT.version then
        UT:init()
    else
        UT.Updater:checkForUpdate()
    end
end

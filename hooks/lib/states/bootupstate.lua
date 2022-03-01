_G.CloneClass(BootupState)
function BootupState:at_enter()
    BootupState.orig.at_enter(self)

    UT.Updater:checkForUpdate()
end

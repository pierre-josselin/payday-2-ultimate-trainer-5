_G.CloneClass(BootupState)
function BootupState:at_enter()
    BootupState.orig.at_enter(self)

    if UT:getSetting("initialized_version") ~= UT.version then
        UT:init()
    else
        UT.Updater:checkForUpdate()
    end
end

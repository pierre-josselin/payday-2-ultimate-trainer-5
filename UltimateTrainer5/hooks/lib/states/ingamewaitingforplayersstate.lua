_G.CloneClass(IngameWaitingForPlayersState)
function IngameWaitingForPlayersState:at_exit(...)
    IngameWaitingForPlayersState.orig.at_exit(self, ...)

    UT.Dexterity:setFastMask(UT:getSetting("enable_fast_mask"))
end


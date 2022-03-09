if UT:isInGame() then
    if UT:isInHeist() then
        if not UT.tempData.dexterity.godModeReset then
            if Global.god_mode then
                UT.Mission:resetGodMode()
            end
            UT.tempData.dexterity.godModeReset = true
        end

        if UT.tempSettings.mission.disableAi then
            UT.Mission:disableAi()
        end

        if UT.settings.timeEnvironment then
            UT.Time:checkEnvironment()
        end

        if UT:isHost() then
            if UT.tempData.construction.pickedUnit then
                UT.Construction:drawPickedUnit()
            end
        end
    end
end

if UT.settings.enableAntiCheatChecker then
    UT.AntiCheatChecker:check()
end

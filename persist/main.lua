UT.debugLogClass:update()

if UT:isInGame() then
    if UT:isInHeist() then
        if not UT.Dexterity.godModeReset then
            if Global.god_mode then
                UT.Dexterity:resetGodMode()
            end
            UT.Dexterity.godModeReset = true
        end

        if UT.Mission.enableDisableAi then
            UT.Mission:disableAi()
        end

        if not UT.Time.defaultEnvironment then
            UT.Time:setDefaultEnvironment()
        end

        if UT:getSetting("time_environment") then
            UT.Time:checkEnvironment()
        end

        if UT:isHost() then
            if UT.Construction.pickedUnit then
                UT.Construction:drawPickedUnit()
            end
        end
    end
end

if UT:getSetting("enable_anti_cheat_checker") then
    UT.AntiCheatChecker:check()
end

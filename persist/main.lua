if UT:isInGame() then
    if UT:isInHeist() then
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

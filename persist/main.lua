if UT:isInGame() then
    if UT:isInHeist() then
        if UT.tempSettings.mission.disableAi then
            UT.Mission:disableAi()
        end
    end
end

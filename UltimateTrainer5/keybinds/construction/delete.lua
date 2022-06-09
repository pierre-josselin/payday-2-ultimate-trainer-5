if UT:isInMenu() then
    do return end
end

if not UT:isInGame() then
    do return end
end

if not UT:isInHeist() then
    do return end
end

if not UT:isHost() then
    UT:addAlert("ut_alert_host_only_feature", UT.colors.warning)
    do return end
end

UT.Construction:delete()

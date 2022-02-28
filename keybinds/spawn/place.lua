if UT:inMenu() then
    do return end
end

if not UT:isInGame() then
    do return end
end

if not UT:isInHeist() then
    do return end
end

if not UT:isHost() then
    do return end
end

if not alive(managers.player:player_unit()) then
    do return end
end

UT.Spawn:place()

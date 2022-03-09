if not UT:isInGame() then
    do return end
end

if not UT:isInHeist() then
    do return end
end

UT.Keybinds:teleport()

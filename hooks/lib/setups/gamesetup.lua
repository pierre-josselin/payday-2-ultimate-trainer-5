local packages = {}

table.insert(packages, "levels/instances/unique/hlm_random_right003/world")
table.insert(packages, "levels/instances/unique/hlm_gate_base/world")
table.insert(packages, "levels/instances/unique/hlm_door_wooden_white_green/world")
table.insert(packages, "levels/instances/unique/hlm_reader/world")
table.insert(packages, "levels/instances/unique/hlm_vault/world")
table.insert(packages, "levels/instances/unique/hlm_box_contraband001/world")
table.insert(packages, "levels/instances/unique/hox_fbi_armory/world")
table.insert(packages, "levels/instances/unique/mus_security_barrier/world")
table.insert(packages, "levels/instances/unique/san_box_tree001/world")
table.insert(packages, "levels/narratives/vlad/ukrainian_job/world_sounds")
table.insert(packages, "levels/narratives/vlad/jewelry_store/world_sounds")

if UT:getSetting("enableDrivingPackagesLoading") then
    table.insert(packages, "levels/narratives/bain/cage/world/world")
    table.insert(packages, "levels/narratives/vlad/shout/world/world")
    table.insert(packages, "levels/narratives/vlad/jolly/world/world")
    table.insert(packages, "levels/narratives/pbr/jerry/world/world")
    table.insert(packages, "levels/narratives/elephant/born/world/world")
end

for key, value in pairs(packages) do
    if not PackageManager:package_exists(value) then
        goto continue
    end
    if PackageManager:loaded(value) then
        goto continue
    end
    PackageManager:load(value)
    ::continue::
end

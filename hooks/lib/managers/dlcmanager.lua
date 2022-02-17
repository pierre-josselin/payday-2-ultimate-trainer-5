local modPath = ModPath

dofile(modPath .. "classes/UT.lua")
dofile(modPath .. "classes/Utils.lua")

UT:loadSettings()

if not UT.settings.enableDlcUnlocker then
    do return end
end

function WINDLCManager:_verify_dlcs()
    for dlcName, dlcData in pairs(Global.dlc_manager.all_dlc_data) do
        dlcData.verified = true
    end
end

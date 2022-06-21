if not UT:getSetting("enable_dlc_unlocker") then
	do return end
end

function WINDLCManager:_verify_dlcs()
	for dlcName, dlcData in pairs(Global.dlc_manager.all_dlc_data) do
		dlcData.verified = true
	end
end

function GenericDLCManager.has_raidww2_clan()
	return true
end

function GenericDLCManager.has_freed_old_hoxton()
	return true
end

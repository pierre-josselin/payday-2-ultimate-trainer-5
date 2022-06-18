if UT:getSetting("enable_dlc_unlocker") then
	function WINDLCManager:_verify_dlcs()
		for dlcName, dlcData in pairs(Global.dlc_manager.all_dlc_data) do
			dlcData.verified = true
		end
	end
end

-- todo: add specific setting or just merge with dlc unlocker.
function GenericDLCManager.has_raidww2_clan()
	return true
end

function GenericDLCManager.has_freed_old_hoxton()
	return true
end

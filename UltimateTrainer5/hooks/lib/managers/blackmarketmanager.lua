if UT:getSetting("enable_skin_unlocker") then
	function BlackMarketManager:tradable_update() end
end

-- if UT:getSetting("enable_dlc_unlocker") then
-- todo: add specific setting or just merge with dlc unlocker.
function BlackMarketManager.has_unlocked_breech()
	return true, "bm_menu_locked_breech"
end

function BlackMarketManager.has_unlocked_ching()
	return true, "bm_menu_locked_ching"
end

function BlackMarketManager.has_unlocked_erma()
	return true, "bm_menu_locked_erma"
end

function BlackMarketManager.is_crew_item_unlocked()
	return true
end
-- end

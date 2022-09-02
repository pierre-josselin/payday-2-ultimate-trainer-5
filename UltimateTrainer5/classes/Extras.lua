UT.Extras = {}

function UT.Extras:collectGagePackages()
    UT:addAlert("Collecting Gage Packages!", UT.colors.white, false)
    UT:InteractType({'gage_assignment'})
end

function UT.Extras:boardWindows()
    UT:addAlert("Boarding All Windows!", UT.colors.white, false)
    UT:InteractType({'need_boards', 'stash_planks'}, true)
end

function UT.Extras:openDepositBoxes()
    UT:addAlert("Opening Deposit Boxes!", UT.colors.white, false)
    local player = managers.player:player_unit()
    local depositboxes = {}
	for _,v in pairs(managers.interaction._interactive_units) do
		if v.interaction then
			local id = string.sub(v:interaction()._unit:name():t(), 1, 10)
			if id == "@ID7999172" -- Harvest Bank
			or id == "@IDe4bc870" or id == "@ID51da6d6" or id == "@ID8d8c766" or id == "@ID50aac55" or id == "@ID5dcd177" --Armoured Transport
			or id == "@IDa95e021" -- The Big Bank
			or id == "@IDe93c9b2" then -- GO Bank
				table.insert(depositboxes, v:interaction())
			end	
		end 
	end 	
	for _,v in pairs(depositboxes) do
		v:interact(player)
	end
end

function UT.Extras:tieCivilians()
    UT:addAlert("Civilians Tied Up!", UT.colors.white, false)
	UT:InteractType({"requires_cable_ties", 'intimidate'}, true)
end

function UT.Extras:displayInvisibleWalls(value)
    for _, unit in pairs(World:find_units("all", 1)) do
        if UT.Tables.collisionData[unit:name():key()] then
            unit:set_visible(value and true or false)
        end
    end
end

function UT.Extras:lockupAI()
    UT:addAlert("Locking Up All AI!", UT.colors.white, false)
    for id, data in pairs(managers.criminals._characters) do
		bot = data.data.ai
		name = data.name
		unit = data.unit
		if bot and alive(unit) then
            local crim_data = managers.criminals:character_data_by_name(name)
                if crim_data then
                    managers.hud:set_mugshot_custody(crim_data.mugshot_id)
                end
            unit:set_slot(name, 0)
        end
    end
end

function UT.Extras:releaseAI()
    UT:addAlert("Releasing AI from cusody!", UT.colors.white, false)
    local spawn_on_unit = managers.player:player_unit()
	for id, data in pairs(managers.criminals._characters) do
        bot = data.data.ai
        name = data.name
        unit = data.unit
		if bot and not alive(unit) then
			managers.trade:remove_from_trade(name)
			managers.groupai:state():spawn_one_teamAI(false, name, spawn_on_unit)
		end
	end
end

function UT.Extras:toggleCashPenalty(value)
    UT:addAlert("Toggled Cash Penalty", UT.colors.white, false)

    _G.CloneClass(MoneyManager)
    _G.CloneClass(UnitNetworkHandler)
    _G.CloneClass(StatisticsManager)

    if value then
	    function MoneyManager.civilian_killed() return false end
        function MoneyManager.get_civilian_deduction() return 0 end
	    function UnitNetworkHandler:sync_hostage_killed_warning(warning) return 0 end

        local old_killed = StatisticsManager.killed
        function StatisticsManager:killed(data) return (data.name == "civilian" or old_killed(self, data)) end
    else
        MoneyManager.get_civilian_deduction = MoneyManager.orig.get_civilian_deduction
        MoneyManager.civilian_killed = MoneyManager.orig.civilian_killed
        UnitNetworkHandler.sync_hostage_killed_warning = UnitNetworkHandler.orig.sync_hostage_killed_warning
        StatisticsManager.killed = StatisticsManager.orig.killed
    end
end

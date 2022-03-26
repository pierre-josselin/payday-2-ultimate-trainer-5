if UT:getSetting("enable_skill_points_hack") and UT:getSetting("skill_points_total_amount") then
    UT.Player:skillPointsHackHook()
end

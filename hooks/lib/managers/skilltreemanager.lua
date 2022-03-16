if not UT:getSetting("enable_skill_points_hack") or not UT:getSetting("skill_points_total_amount") then
    do return end
end

_G.CloneClass(SkillTreeManager)
function SkillTreeManager:_verify_loaded_data(...)
    SkillTreeManager.orig._verify_loaded_data(self, UT:getSetting("skill_points_total_amount") - managers.experience:current_level())
end

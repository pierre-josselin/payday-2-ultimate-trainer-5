if not UT:getSetting("enableSkillPointsHack") or not UT:getSetting("skillPointsTotalAmount") then
    do return end
end

_G.CloneClass(SkillTreeManager)
function SkillTreeManager:_verify_loaded_data(...)
    SkillTreeManager.orig._verify_loaded_data(self, UT:getSetting("skillPointsTotalAmount") - managers.experience:current_level())
end

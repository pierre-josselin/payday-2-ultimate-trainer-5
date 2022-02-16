local settings = UT:getSettings()

if not settings.enableSkillPointsHack or not settings.skillPointsTotalAmount then
    do return end
end

_G.CloneClass(SkillTreeManager)
function SkillTreeManager:_verify_loaded_data(...)
    log(tostring(managers.experience:current_level()))
    SkillTreeManager.orig._verify_loaded_data(self, settings.skillPointsTotalAmount - managers.experience:current_level())
end

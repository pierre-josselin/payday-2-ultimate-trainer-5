UT.AntiCheatChecker = {}

UT.AntiCheatChecker.detectedText = nil

function UT.AntiCheatChecker:setEnabled(value)
    UT.settings.enableAntiCheatChecker = value
    UT:saveSettings()
    if not value then
        if UT.AntiCheatChecker.detectedText then
            UT.AntiCheatChecker.detectedText:set_visible(false)
        end
    end
    if value then
        UT:addAlert("ut_alert_anti_cheat_checker_enabled", UT.colors.success)
    else
        UT:addAlert("ut_alert_anti_cheat_checker_disabled", UT.colors.success)
    end
end

function UT.AntiCheatChecker:useAntiCheatDetectedFeatures()
    return UT.settings.enableDlcUnlocker
        or UT.settings.enableSkillPointsHack
        or UT.Dexterity.enableUnlimitedEquipment
        or UT.Spawn.mode == "equipments"
        or UT.Spawn.mode == "bags"
end

function UT.AntiCheatChecker:check()
    if not UT.AntiCheatChecker.detectedText then
        local workspace = managers.gui_data:create_saferect_workspace()
        local config = {
            align = "center",
            font_size = 15,
            font = tweak_data.menu.pd2_medium_font,
            text = UT:getLocalizedText("ut_anti_cheat_detected"),
            color = UT.colors.warning,
            alpha = 0.8
        }
        UT.AntiCheatChecker.detectedText = workspace:panel():text(config)
    end

    local useAntiCheatDetectedFeatures = UT.AntiCheatChecker:useAntiCheatDetectedFeatures()
    UT.AntiCheatChecker.detectedText:set_visible(useAntiCheatDetectedFeatures)
end

function UT.AntiCheatChecker:showList()
    local title = UT:getLocalizedText("ut_popup_configuration_anti_cheat_checker_show_list_title")
    local message = ""
    if UT.AntiCheatChecker:useAntiCheatDetectedFeatures() then
        if UT.settings.enableDlcUnlocker then
            message = message .. "- DLC Unlocker\n"
        end
        if UT.settings.enableSkillPointsHack then
            message = message .. "- Skill point hack\n"
        end
        if UT.Dexterity.enableUnlimitedEquipment then
            message = message .. "- Unlimited equipment\n"
        end
        if UT.Spawn.mode == "equipments" then
            message = message .. "- Spawn mode equipments\n"
        end
        if UT.Spawn.mode == "bags" then
            message = message .. "- Spawn mode bags\n"
        end
    else
        message = UT:getLocalizedText("ut_popup_configuration_anti_cheat_checker_show_list_no_detected_feature_message")
    end
    QuickMenu:new("Ultimate Trainer - " .. title, message, {}):Show()
end

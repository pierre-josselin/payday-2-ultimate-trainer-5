local modPath = ModPath

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_UltimateTrainer", function(localizationManager)
    localizationManager:load_localization_file(modPath .. "locales\\en.json")
end)

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_UltimateTrainer", function(menuManager)
    MenuHelper:LoadFromJsonFile(modPath .. "menus\\main.json")
end)

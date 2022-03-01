UT.Updater = {}

UT.Updater.steamId = "76561199248108754"

function UT.Updater:updateAvailable(version)
    if UT.settings.lastUpdateAvailableVersion and UT.settings.lastUpdateAvailableVersion == version then
        return
    end

    UT.settings.lastUpdateAvailableVersion = version
    UT:saveSettings()

    UT:showPopup("ut_popup_update_available_title", "ut_popup_update_available_message")
end

function UT.Updater:checkForUpdate()
    local url = "https://steamcommunity.com/profiles/" .. UT.Updater.steamId
    dohttpreq(url, UT.Updater.checkForUpdateRequestCallback)
end

function UT.Updater.checkForUpdateRequestCallback(data)
    if not data then
        return
    end

    if not UT.Utils:isString(data) then
        return
    end

    local version = data:match("#UT#(.-)#UT#")

    if not version then
        return
    end

    if version ~= UT.version then
        UT.Updater:updateAvailable(version)
    end
end

UTLoadedClassUpdater = true

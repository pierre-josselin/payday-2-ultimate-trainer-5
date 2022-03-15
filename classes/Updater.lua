UT.Updater = {}

UT.Updater.steamId = "76561199248108754"

function UT.Updater:updateAvailable(version)
    local title = UT:getLocalizedText("ut_popup_update_available_title")
    local message = UT:getLocalizedText("ut_popup_update_available_message")
    QuickMenu:new("Ultimate Trainer - " .. title, message, {}):Show()
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

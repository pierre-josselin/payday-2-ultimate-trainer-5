if not UT:getSetting("enable_dlc_unlocker") then
	do return end
end

function MusicManager:jukebox_music_tracks()
	local tracks = {}

	for _, data in ipairs(tweak_data.music.track_list) do
		table.insert(tracks, data.track)

		if data.lock and not self:track_unlocked(data.track) then
			self:unlock_track(data.track)
			self:playlist_add(data.track)
		end
	end

	return tracks, {}
end

function MusicManager:jukebox_menu_tracks()
	local tracks = {}

	for _, data in ipairs(tweak_data.music.track_menu_list) do
		table.insert(tracks, data.track)
	end

	return tracks, {}
end

function MusicManager:jukebox_ghost_tracks()
	local tracks = {}

	if managers.dlc then
		for _, data in ipairs(tweak_data.music.track_ghost_list) do
			table.insert(tracks, data.track)
		end
	end

	return tracks, {}
end

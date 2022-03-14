_G.CloneClass(NetworkManager)
function NetworkManager:on_peer_added(peer, peer_id)
    NetworkManager.orig.on_peer_added(self, peer, peer_id)
    if UT:isInGame() and UT:isInHeist() and UT:isHost() then
        if not UT.Utils:isTableEmpty(UT.Driving.units) then
            UT.Driving:removeVehicles()
        end
    end
end

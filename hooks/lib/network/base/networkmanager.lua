_G.CloneClass(NetworkManager)
function NetworkManager:on_peer_added(peer, peer_id)
    NetworkManager.orig.on_peer_added(self, peer, peer_id)
    if UT:isServer() then
        if not UT.Utils:isTableEmpty(UT.tempData.driving.units) then
            UT.Driving:removeVehicles()
        end
    end
end

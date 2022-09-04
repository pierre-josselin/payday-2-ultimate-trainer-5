UT.Dexterity = {}

UT.Dexterity.enableUnlimitedEquipment = false

UT.Dexterity.enableMoveSpeedMultiplier = false
UT.Dexterity.enableThrowDistanceMultiplier = false
UT.Dexterity.enableFireRateMultiplier = false
UT.Dexterity.enableDamageMultiplier = false

UT.Dexterity.moveSpeedMultiplier = 1
UT.Dexterity.throwDistanceMultiplier = 1
UT.Dexterity.fireRateMultiplier = 1
UT.Dexterity.damageMultiplier = 1

UT.Dexterity.tweakDataCarryTypes = nil
UT.Dexterity.godModeReset = false

UT.Dexterity.enableNoclip = false
UT.Dexterity.noclipSpeedMultiplier = 2
UT.Dexterity.noclipAxisMove = { x = 0, y = 0 }

function UT.Dexterity:setGodMode(value)
    managers.player:player_unit():character_damage():set_god_mode(value)
    if value then
        UT:addAlert("ut_alert_god_mode_enabled", UT.colors.success)
    else
        UT:addAlert("ut_alert_god_mode_disabled", UT.colors.success)
    end
end

function UT.Dexterity:resetGodMode()
    managers.player:player_unit():character_damage():set_god_mode(false)
end

function UT.Dexterity:setInfiniteStamina(value)
    _G.CloneClass(PlayerMovement)
    if value then
        function PlayerMovement:_change_stamina() end

        function PlayerMovement:is_stamina_drained() return false end
    else
        PlayerMovement._change_stamina = PlayerMovement.orig._change_stamina
        PlayerMovement.is_stamina_drained = PlayerMovement.orig.is_stamina_drained
    end
end

function UT.Dexterity:setNoclip(value, isUpdate)
    UT.Dexterity.enableNoclip = value

    local keyboard = Input:keyboard()
    local keyboardDown = keyboard.down
    local player = managers.player:player_unit()
    local camera = player:camera()
    local cameraRotation = camera:rotation()
    local speed = UT.Dexterity.noclipSpeedMultiplier or 2
    if value then
        UT.Dexterity.noclipAxisMove.x = keyboardDown(keyboard, Idstring("w")) and speed or keyboardDown(keyboard, Idstring("s")) and -speed or 0
        UT.Dexterity.noclipAxisMove.y = keyboardDown(keyboard, Idstring("d")) and speed or keyboardDown(keyboard, Idstring("a")) and -speed or 0
        UT.Dexterity.noclipAxisMove.z = keyboardDown(keyboard, Idstring("space")) and speed or keyboardDown(keyboard, Idstring("left ctrl")) and -speed or 0
        local moveDir = cameraRotation:x() * UT.Dexterity.noclipAxisMove.y + cameraRotation:y() * UT.Dexterity.noclipAxisMove.x + cameraRotation:z() * UT.Dexterity.noclipAxisMove.z
        local moveDelta = moveDir * 10
        local newPos = player:position() + moveDelta
        managers.player:warp_to(newPos, cameraRotation, 1, Rotation(0, 0, 0))
    else
        UT.Dexterity.noclipAxisMove = { x = 0, y = 0, z = 0 }
    end

    local isNotUpdate = isUpdate == nil or isUpdate == false
    if value and isNotUpdate then
        UT:addAlert("ut_alert_noclip_enabled", UT.colors.success)
    elseif isNotUpdate then
        UT:addAlert("ut_alert_noclip_disabled", UT.colors.success)
    end
end

function UT.Dexterity:setRunInAllDirections(value)
    _G.CloneClass(PlayerStandard)
    if value then
        function PlayerStandard:_can_run_directional() return true end
    else
        PlayerStandard._can_run_directional = PlayerStandard.orig._can_run_directional
    end
end

function UT.Dexterity:setCanRunWithAnyBag(value)
    UT.Dexterity.tweakDataCarryTypes = UT.Dexterity.tweakDataCarryTypes or deep_clone(tweak_data.carry.types)
    if value then
        for type, data in pairs(tweak_data.carry.types) do
            tweak_data.carry.types[type].can_run = true
        end
    else
        for type, data in pairs(UT.Dexterity.tweakDataCarryTypes) do
            tweak_data.carry.types[type].can_run = data.can_run
        end
    end
end

function UT.Dexterity:setFastMask(value)
    UT.Dexterity.tweakDataPlayerPutOnMaskTime = UT.Dexterity.tweakDataPlayerPutOnMaskTime or tweak_data.player.put_on_mask_time
    if value then
        tweak_data.player.put_on_mask_time = 0.25
    else
        tweak_data.player.put_on_mask_time = UT.Dexterity.tweakDataPlayerPutOnMaskTime
    end
end

function UT.Dexterity:setNoCarryCooldown(value)
    _G.CloneClass(PlayerManager)
    if value then
        function PlayerManager:carry_blocked_by_cooldown() return false end
    else
        PlayerManager.carry_blocked_by_cooldown = PlayerManager.orig.carry_blocked_by_cooldown
    end
end

function UT.Dexterity:setNoFlashbangs(value)
    _G.CloneClass(CoreEnvironmentControllerManager)
    if value then
        function CoreEnvironmentControllerManager:set_flashbang() end
    else
        CoreEnvironmentControllerManager.set_flashbang = CoreEnvironmentControllerManager.orig.set_flashbang
    end
end

function UT.Dexterity:setInstantSwap(value)
    _G.CloneClass(PlayerStandard)
    if value then
        function PlayerStandard:_get_swap_speed_multiplier() return UT.fakeMaxInteger end
    else
        PlayerStandard._get_swap_speed_multiplier = PlayerStandard.orig._get_swap_speed_multiplier
    end
end

function UT.Dexterity:setInstantReload(value)
    _G.CloneClass(RaycastWeaponBase)
    if value then
        function RaycastWeaponBase:can_reload()
            self:on_reload()
            managers.hud:set_ammo_amount(self:selection_index(), self:ammo_info())
        
            return false
        end
    else
        RaycastWeaponBase.can_reload = RaycastWeaponBase.orig.can_reload
    end
end

function UT.Dexterity:setShootThroughWalls(value)
    _G.CloneClass(RaycastWeaponBase)
    _G.CloneClass(NewRaycastWeaponBase)

    local player = managers.player:player_unit()

    if value then
        if not player or not alive(player) then
            return
        end

        RaycastWeaponBase._can_shoot_through_shield = true
        RaycastWeaponBase._can_shoot_through_wall = true
        NewRaycastWeaponBase._can_shoot_through_shield = true
        NewRaycastWeaponBase._can_shoot_through_wall = true
    else
        RaycastWeaponBase._can_shoot_through_shield = RaycastWeaponBase.orig._can_shoot_through_shield
        RaycastWeaponBase._can_shoot_through_wall = RaycastWeaponBase.orig._can_shoot_through_wall
        NewRaycastWeaponBase._can_shoot_through_shield = NewRaycastWeaponBase.orig._can_shoot_through_shield
        NewRaycastWeaponBase._can_shoot_through_wall = NewRaycastWeaponBase.orig._can_shoot_through_wall
    end

    for _, selection in pairs(player:inventory()._available_selections) do
        local unitBase = selection.unit:base()
        if value then
            unitBase._bullet_slotmask_old = unitBase._bullet_slotmask
            unitBase._bullet_slotmask = World:make_slot_mask(7, 11, 12, 14, 16, 17, 18, 21, 22, 25, 26, 33, 34, 35)
        else
            if unitBase._bullet_slotmask_old then
                unitBase._bullet_slotmask = unitBase._bullet_slotmask_old
                unitBase._bullet_slotmask_old = nil
            end
        end
    end

    if value then
        UT:addAlert("ut_alert_shoot_through_walls_enabled", UT.colors.success)
    else
        UT:addAlert("ut_alert_shoot_through_walls_disabled", UT.colors.success)
    end
end

function UT.Dexterity:setNoRecoil(value)
    _G.CloneClass(NewRaycastWeaponBase)
    if value then
        function NewRaycastWeaponBase:recoil_multiplier() return 0 end
    else
        NewRaycastWeaponBase.recoil_multiplier = NewRaycastWeaponBase.orig.recoil_multiplier
    end
end

function UT.Dexterity:setNoSpread(value)
    _G.CloneClass(NewRaycastWeaponBase)
    if value then
        function NewRaycastWeaponBase:spread_multiplier() return 0 end
    else
        NewRaycastWeaponBase.spread_multiplier = NewRaycastWeaponBase.orig.spread_multiplier
    end
end

function UT.Dexterity:setUnlimitedAmmo(value)
    _G.CloneClass(RaycastWeaponBase)
    _G.CloneClass(SawWeaponBase)
    if value then
        function RaycastWeaponBase:clip_empty()
            self:set_ammo_total(self:get_ammo_max())
            return self:get_ammo_remaining_in_clip() == 0
        end

        function SawWeaponBase:clip_empty()
            self:set_ammo_total(self:get_ammo_max())
            return self:get_ammo_remaining_in_clip() == 0
        end
    else
        RaycastWeaponBase.clip_empty = RaycastWeaponBase.orig.clip_empty
        SawWeaponBase.clip_empty = SawWeaponBase.orig.clip_empty
    end
end

function UT.Dexterity:setInstantInteraction(value)
    _G.CloneClass(BaseInteractionExt)
    if value then
        function BaseInteractionExt:_get_timer() return 0.001 end
    else
        BaseInteractionExt._get_timer = BaseInteractionExt.orig._get_timer
    end
end

function UT.Dexterity:setInstantDeployment(value)
    _G.CloneClass(PlayerManager)
    if value then
        function PlayerManager:selected_equipment_deploy_timer() return 0.001 end
    else
        PlayerManager.selected_equipment_deploy_timer = PlayerManager.orig.selected_equipment_deploy_timer
    end
end

function UT.Dexterity:setUnlimitedEquipment(value)
    UT.Dexterity.enableUnlimitedEquipment = value
    _G.CloneClass(BaseInteractionExt)
    _G.CloneClass(PlayerManager)
    if value then
        function BaseInteractionExt:_has_required_upgrade() return true end

        function BaseInteractionExt:_has_required_deployable() return true end

        function BaseInteractionExt:can_interact() return true end

        function PlayerManager:on_used_body_bag() end

        function PlayerManager:remove_equipment() end

        function PlayerManager:remove_special() end
    else
        BaseInteractionExt._has_required_upgrade = BaseInteractionExt.orig._has_required_upgrade
        BaseInteractionExt._has_required_deployable = BaseInteractionExt.orig._has_required_deployable
        BaseInteractionExt.can_interact = BaseInteractionExt.orig.can_interact
        PlayerManager.on_used_body_bag = PlayerManager.orig.on_used_body_bag
        PlayerManager.remove_equipment = PlayerManager.orig.remove_equipment
        PlayerManager.remove_special = PlayerManager.orig.remove_special
    end
end

function UT.Dexterity:setMoveSpeedMultiplier(value, multiplier)
    _G.CloneClass(PlayerManager)
    if value then
        function PlayerManager:movement_speed_multiplier() return multiplier end
    else
        PlayerManager.movement_speed_multiplier = PlayerManager.orig.movement_speed_multiplier
    end
end

function UT.Dexterity:setThrowDistanceMultiplier(value, multiplier)
    UT.Dexterity.tweakDataCarryTypes = UT.Dexterity.tweakDataCarryTypes or deep_clone(tweak_data.carry.types)
    if value then
        for type, data in pairs(tweak_data.carry.types) do
            tweak_data.carry.types[type].throw_distance_multiplier = multiplier
        end
    else
        for type, data in pairs(UT.Dexterity.tweakDataCarryTypes) do
            tweak_data.carry.types[type].throw_distance_multiplier = data.throw_distance_multiplier
        end
    end
end

function UT.Dexterity:setFireRateMultiplier(value, multiplier)
    _G.CloneClass(NewRaycastWeaponBase)
    if value then
        function NewRaycastWeaponBase:fire_rate_multiplier() return multiplier end
    else
        NewRaycastWeaponBase.fire_rate_multiplier = NewRaycastWeaponBase.orig.fire_rate_multiplier
    end
end

function UT.Dexterity:setDamageMultiplier(value, multiplier)
    _G.CloneClass(CopDamage)
    if value then
        function CopDamage:damage_bullet(attack_data)
            if attack_data.attacker_unit == managers.player:player_unit() then
                attack_data.damage = multiplier * 10
            end
            return self.orig.damage_bullet(self, attack_data)
        end

        function CopDamage:damage_melee(attack_data)
            if attack_data.attacker_unit == managers.player:player_unit() then
                attack_data.damage = multiplier * 10
            end
            return self.orig.damage_melee(self, attack_data)
        end
    else
        CopDamage.damage_bullet = CopDamage.orig.damage_bullet
        CopDamage.damage_melee = CopDamage.orig.damage_melee
    end
end

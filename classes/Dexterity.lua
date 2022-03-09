UT.Dexterity = {}

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

function UT.Dexterity:setInfiniteStamina()
    _G.CloneClass(PlayerMovement)
    if UT.tempSettings.dexterity.infiniteStamina then
        function PlayerMovement:_change_stamina() end
        function PlayerMovement:is_stamina_drained() return false end
    else
        PlayerMovement._change_stamina = PlayerMovement.orig._change_stamina
        PlayerMovement.is_stamina_drained = PlayerMovement.orig.is_stamina_drained
    end
end

function UT.Dexterity:setRunInAllDirections()
    _G.CloneClass(PlayerStandard)
    if UT.tempSettings.dexterity.runInAllDirections then
        function PlayerStandard:_can_run_directional() return true end
    else
        PlayerStandard._can_run_directional = PlayerStandard.orig._can_run_directional
    end
end

function UT.Dexterity:setCanRunWithAnyBag()
    UT.tempData.tweakDataCarryTypes = UT.tempData.tweakDataCarryTypes or deep_clone(tweak_data.carry.types)
    if UT.tempSettings.dexterity.canRunWithAnyBag then
        for type, data in pairs(tweak_data.carry.types) do
            tweak_data.carry.types[type].can_run = true
        end
    else
        for type, data in pairs(UT.tempData.tweakDataCarryTypes) do
            tweak_data.carry.types[type].can_run = data.can_run
        end
    end
end

function UT.Dexterity:setNoCarryCooldown()
    _G.CloneClass(PlayerManager)
    if UT.tempSettings.dexterity.noCarryCooldown then
        function PlayerManager:carry_blocked_by_cooldown() return false end
    else
        PlayerManager.carry_blocked_by_cooldown = PlayerManager.orig.carry_blocked_by_cooldown
    end
end

function UT.Dexterity:setNoFlashbangs()
    _G.CloneClass(CoreEnvironmentControllerManager)
    if UT.tempSettings.dexterity.noFlashbangs then
        function CoreEnvironmentControllerManager:set_flashbang() end
    else
        CoreEnvironmentControllerManager.set_flashbang = CoreEnvironmentControllerManager.orig.set_flashbang
    end
end

function UT.Dexterity:setInstantSwap()
    _G.CloneClass(PlayerStandard)
    if UT.tempSettings.dexterity.instantSwap then
        function PlayerStandard:_get_swap_speed_multiplier() return 1000 end
    else
        PlayerStandard._get_swap_speed_multiplier = PlayerStandard.orig._get_swap_speed_multiplier
    end
end

function UT.Dexterity:setInstantReload()
    _G.CloneClass(NewRaycastWeaponBase)
    if UT.tempSettings.dexterity.instantReload then
        function NewRaycastWeaponBase.reload_speed_multiplier() return 1000 end
    else
        NewRaycastWeaponBase.reload_speed_multiplier = NewRaycastWeaponBase.orig.reload_speed_multiplier
    end
end

function UT.Dexterity:setNoRecoil()
    _G.CloneClass(NewRaycastWeaponBase)
    if UT.tempSettings.dexterity.noRecoil then
        function NewRaycastWeaponBase:recoil_multiplier() return 0 end
    else
        NewRaycastWeaponBase.recoil_multiplier = NewRaycastWeaponBase.orig.recoil_multiplier
    end
end

function UT.Dexterity:setNoSpread()
    _G.CloneClass(NewRaycastWeaponBase)
    if UT.tempSettings.dexterity.noSpread then
        function NewRaycastWeaponBase:spread_multiplier() return 0 end
    else
        NewRaycastWeaponBase.spread_multiplier = NewRaycastWeaponBase.orig.spread_multiplier
    end
end

function UT.Dexterity:setUnlimitedAmmo()
    _G.CloneClass(RaycastWeaponBase)
    _G.CloneClass(SawWeaponBase)
    if UT.tempSettings.dexterity.unlimitedAmmo then
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

function UT.Dexterity:setInstantInteraction()
    _G.CloneClass(BaseInteractionExt)
    if UT.tempSettings.dexterity.instantInteraction then
        function BaseInteractionExt:_get_timer() return 0.001 end
    else
        BaseInteractionExt._get_timer = BaseInteractionExt.orig._get_timer
    end
end

function UT.Dexterity:setInstantDeployment()
    _G.CloneClass(PlayerManager)
    if UT.tempSettings.dexterity.instantDeployment then
        function PlayerManager:selected_equipment_deploy_timer() return 0.001 end
    else
        PlayerManager.selected_equipment_deploy_timer = PlayerManager.orig.selected_equipment_deploy_timer
    end
end

function UT.Dexterity:setUnlimitedEquipment()
    _G.CloneClass(BaseInteractionExt)
    _G.CloneClass(PlayerManager)
    if UT.tempSettings.dexterity.unlimitedEquipment then
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

function UT.Dexterity:setMoveSpeedMultiplier()
    _G.CloneClass(PlayerManager)
    if UT.tempSettings.dexterity.moveSpeedMultiplier then
        function PlayerManager:movement_speed_multiplier() return UT.tempSettings.dexterity.moveSpeedMultiplierValue end
    else
        PlayerManager.movement_speed_multiplier = PlayerManager.orig.movement_speed_multiplier
    end
end

function UT.Dexterity:setThrowDistanceMultiplier()
    UT.tempData.tweakDataCarryTypes = UT.tempData.tweakDataCarryTypes or deep_clone(tweak_data.carry.types)
    if UT.tempSettings.dexterity.throwDistanceMultiplier then
        for type, data in pairs(tweak_data.carry.types) do
            tweak_data.carry.types[type].throw_distance_multiplier = UT.tempSettings.dexterity.throwDistanceMultiplierValue
        end
    else
        for type, data in pairs(UT.tempData.tweakDataCarryTypes) do
            tweak_data.carry.types[type].throw_distance_multiplier = data.throw_distance_multiplier
        end
    end
end

function UT.Dexterity:setFireRateMultiplier()
    _G.CloneClass(NewRaycastWeaponBase)
    if UT.tempSettings.dexterity.fireRateMultiplier then
        function NewRaycastWeaponBase:fire_rate_multiplier() return UT.tempSettings.dexterity.fireRateMultiplierValue end
    else
        NewRaycastWeaponBase.fire_rate_multiplier = NewRaycastWeaponBase.orig.fire_rate_multiplier
    end
end

function UT.Dexterity:setDamageMultiplier()
    _G.CloneClass(CopDamage)
    if UT.tempSettings.dexterity.damageMultiplier then
        function CopDamage:damage_bullet(attack_data)
            if attack_data.attacker_unit == managers.player:player_unit() then
                attack_data.damage = UT.tempSettings.dexterity.damageMultiplierValue * 10
            end
            return self.orig.damage_bullet(self, attack_data)
        end
        function CopDamage:damage_melee(attack_data)
            if attack_data.attacker_unit == managers.player:player_unit() then
                attack_data.damage = UT.tempSettings.dexterity.damageMultiplierValue * 10
            end
            return self.orig.damage_melee(self, attack_data)
        end
    else
        CopDamage.damage_bullet = CopDamage.orig.damage_bullet
        CopDamage.damage_melee = CopDamage.orig.damage_melee
    end
end

UTLoadedClassDexterity = true

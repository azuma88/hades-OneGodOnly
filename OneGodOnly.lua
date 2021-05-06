--[[
    AnyWeaponStart v0.1
    Author:
        cgull (Discord: cgull#4469)

    Causes only one god to be seen, any time a boon is offered. Set which god in the config below.

    Flags for Hermes appearing and Hammers appearing can be set to false if those should also not appear
]]

ModUtil.RegisterMod("OneGodOnly")

local config = {
    -- Hermes cannot be specified as DesiredOlympian
    DesiredOlympian = "Aphrodite",
    HermesAppears = false,
    HammersAppear = false,

}

OneGodOnly.Config = config

ModUtil.WrapBaseFunction( "GetEligibleLootNames", 
    function ( baseFunc, excludeLootNames )
        local output = baseFunc(currentRun, excludeLootNames)
        
        for k, lootName in pairs( output ) do
            local lootData = LootData[lootName]
            if lootData.GodLoot and lootName ~= OneGodOnly.Config.DesiredOlympian .. "Upgrade" then
                RemoveValue( output, lootName )
            end
            if lootName == "HermesUpgrade" and not OneGodOnly.Config.HermesAppears then
                RemoveValue( output, lootName )
            elseif lootName == "WeaponUpgrade" and not OneGodOnly.Config.HammersAppear then
                RemoveValue( output, lootName )
            end
        end
            
        return output
    end, OneGodOnly
)
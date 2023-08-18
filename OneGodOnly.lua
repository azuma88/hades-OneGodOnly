--[[
    OneGodOnly v1.0
        Author:
        cgull (Discord: c_gull)

    Causes only one god to be seen, any time a boon is offered. Set which god in the config below.

    Flags for Hermes appearing and Hammers appearing can be set to false if those should also not appear
]]

ModUtil.RegisterMod("OneGodOnly")

local config = {
    -- Hermes cannot be specified as DesiredOlympian
    DesiredOlympian = "Aphrodite",
    HermesAppears = true,
    HammersAppear = true,

}

OneGodOnly.Config = config

ModUtil.Path.Wrap( "GetEligibleLootNames", function( baseFunc, exclueLootNames)
    local baseTable = baseFunc(currentRun, excludeLootNames)
    local returnTable = {OneGodOnly.Config.DesiredOlympian .. "Upgrade"}
    if OneGodOnly.Config.HermesAppears  and Contains(baseTable, "HermesUpgrade") then
        table.insert(returnTable, "HermesUpgrade")
    end
    if OneGodOnly.Config.HammersAppear and Contains(baseTable, "WeaponUpgrade") then
        table.insert(returnTable, "WeaponUpgrade")
    end

    for k, lootName in pairs(returnTable) do
        DebugPrint({Text=lootName})
    end
    return returnTable

end, OneGodOnly)

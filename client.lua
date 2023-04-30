local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    RequestModel(`g_m_m_armboss_01`)
      while not HasModelLoaded(`g_m_m_armboss_01`) do
      Wait(1)
    end
      PillsLabsKeyPed = CreatePed(2, `g_m_m_armboss_01`, Config.PedLoc, false, false)
      SetPedFleeAttributes(PillsLabsKeyPed, 0, 0)
      SetPedDiesWhenInjured(PillsLabsKeyPed, false)
      TaskStartScenarioInPlace(PillsLabsKeyPed, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
      SetPedKeepTask(PillsLabsKeyPed, true)
      SetBlockingOfNonTemporaryEvents(PillsLabsKeyPed, true)
      SetEntityInvincible(PillsLabsKeyPed, true)
      FreezeEntityPosition(PillsLabsKeyPed, true)

    exports['qb-target']:AddBoxZone("PillsLabsKeyPed", Config.PedTargetLoc, 1, 1, {
        name="PillsLabsKeyPed",
        heading=0,
        debugpoly = false,
    }, {
        options = {
            {
                event = "mp-happypills:client:AskForMisson",
                icon = "fas fa-box",
                label = "Talk to this guy",
            },
        },
        distance = 1.5
    })
        
    --exports['qb-target']:AddBoxZone("PillsLabsKeyBox", Config.PackageLoc, 1.5, 1.5, {
        --name="PillsLabsKeyBox",
       --heading=0,
        --debugpoly = true,
    --}, {
        --options = {
            --{
                --event = "mp-happypills:client:OpenBox",
                --icon = "fas fa-box",
                --label = "Search Boxes",
                --item = "pills_jobrecive",
            --},
        --},
        distance = 1.5
    --})
end)

RegisterNetEvent('mp-happypills:client:AskForMisson', function()
    QBCore.Functions.Progressbar('name_here', 'TALKING TO BOSS...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'misscarsteal4@actor',
        anim = 'actor_berating_loop',
        flags = 16,
    }, {}, {}, function()
        ClearPedTasks(PlayerPedId())

        Wait(5000)

        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = 'Important Thins',
            subject = nil,
            message = 'Hey, you got the key but you have to save your life <br> all the best.',
        })

        --SetNewWaypoint(Config.PackageLoc)

        Wait(50)

        SpawnGuards()
        TriggerServerEvent('mp-happypills:server:FirstItem')
    end)
end)

-- Guardas

yatchGuards = {
    ['npcguards'] = {}
}

function loadModel(model)
    if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
end

function SpawnGuards()
    local ped = PlayerPedId()

    SetPedRelationshipGroupHash(ped, `PLAYER`)
    AddRelationshipGroup('npcguards')

    for k, v in pairs(Config['yatchGuards']['npcguards']) do
        loadModel(v['model'])
        yatchGuards['npcguards'][k] = CreatePed(26, GetHashKey(v['model']), v['coords'], v['heading'], true, true)
        NetworkRegisterEntityAsNetworked(yatchGuards['npcguards'][k])
        networkID = NetworkGetNetworkIdFromEntity(yatchGuards['npcguards'][k])
        SetNetworkIdCanMigrate(networkID, true)
        SetNetworkIdExistsOnAllMachines(networkID, true)
        SetPedRandomComponentVariation(yatchGuards['npcguards'][k], 0)
        SetPedRandomProps(yatchGuards['npcguards'][k])
        SetEntityAsMissionEntity(yatchGuards['npcguards'][k])
        SetEntityVisible(yatchGuards['npcguards'][k], true)
        SetPedRelationshipGroupHash(yatchGuards['npcguards'][k], `npcguards`)
        SetPedAccuracy(yatchGuards['npcguards'][k], 75)
        SetPedArmour(yatchGuards['npcguards'][k], 100)
        SetPedCanSwitchWeapon(yatchGuards['npcguards'][k], true)
        SetPedDropsWeaponsWhenDead(yatchGuards['npcguards'][k], false)
        SetPedFleeAttributes(yatchGuards['npcguards'][k], 0, false)
        GiveWeaponToPed(yatchGuards['npcguards'][k], `WEAPON_PISTOL`, 255, false, false)
        TaskGoToEntity(yatchGuards['npcguards'][k], PlayerPedId(), -1, 1.0, 10.0, 1073741824.0, 0)
        local random = math.random(1, 2)
        if random == 2 then
            TaskGuardCurrentPosition(yatchGuards['npcguards'][k], 10.0, 10.0, 1)
        end
    end

    SetRelationshipBetweenGroups(0, `npcguards`, `npcguards`)
    SetRelationshipBetweenGroups(5, `npcguards`, `PLAYER`)
    SetRelationshipBetweenGroups(5, `PLAYER`, `npcguards`)
end

RegisterNetEvent('mp-happypills:client:OpenBox', function()
    QBCore.Functions.Progressbar('name_here', 'SEARCHING BOXES...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'mini@repair',
        anim = 'fixing_a_ped',
        flags = 16,
    }, {}, {}, function()
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('mp-happypills:server:GetCon')
    end)
end)

CreateThread(function()
    RequestModel(`a_m_m_indian_01`)
      while not HasModelLoaded(`a_m_m_indian_01`) do
      Wait(1)
    end
      PillsLabsShopPed = CreatePed(2, `a_m_m_indian_01`, Config.ShopPedLoc, false, false)
      SetPedFleeAttributes(PillsLabsShopPed, 0, 0)
      SetPedDiesWhenInjured(PillsLabsShopPed, false)
      TaskStartScenarioInPlace(PillsLabsShopPed, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
      SetPedKeepTask(PillsLabsShopPed, true)
      SetBlockingOfNonTemporaryEvents(PillsLabsShopPed, true)
      SetEntityInvincible(PillsLabsShopPed, true)
      FreezeEntityPosition(PillsLabsShopPed, true)

    exports['qb-target']:AddBoxZone("PillsLabsShopPed", Config.ShopPedTargetLoc, 1, 1, {
        name="PillsLabsShopPed",
        heading=0,
        debugpoly = false,
    }, {
        options = {
            {
                event = "mp-happypills:client:Store",
                icon = "fas fa-mask",
                label = "Talk to this guy",
            },
        },
        distance = 1.5
    })
end)

RegisterNetEvent('mp-happypills:client:Store', function()
    exports['qb-menu']:openMenu({
        {
            header = "Pills Market",
            isMenuHeader = true,
        },
        {
            header = "< Close Menu",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
        {
            header = "Buy Hydrochloric Acid",
            txt = "Price: 100$ per 1",
            params = {
                event = "mp-happypills:client:BuyAcid1",
            }
        },
        {
            header = "Buy Sodium Hydroxide",
            txt = "Price: 100$ per 1",
            params = {
                event = "mp-happypills:client:BuyAcid2",
            }
        },
        {
            header = "Buy Sulfuric Acid",
            txt = "Price: 100$ per 1",
            params = {
                event = "mp-happypills:client:BuyAcid3",
            }
        },
        {
            header = "Buy empty Bags",
            txt = "Price: 5$ per 1",
            params = {
                event = "mp-happypills:client:BuyemptyBags",
            }
        },
    })
end)

RegisterNetEvent('mp-happypills:client:BuyAcid1', function()
    TriggerServerEvent('mp-happypills:server:BuyAcid1')
    TriggerEvent('mp-happypills:client:Store')
end)

RegisterNetEvent('mp-happypills:client:BuyAcid2', function()
    TriggerServerEvent('mp-happypills:server:BuyAcid2')
    TriggerEvent('mp-happypills:client:Store')
end)

RegisterNetEvent('mp-happypills:client:BuyAcid3', function()
    TriggerServerEvent('mp-happypills:server:BuyAcid3')
    TriggerEvent('mp-happypills:client:Store')
end)

RegisterNetEvent('mp-happypills:client:BuyemptyBags', function()
    TriggerServerEvent('mp-happypills:server:BuyemptyBags')
    TriggerEvent('mp-happypills:client:Store')
end)

RegisterNetEvent('mp-happypills:client:EntrarLab', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    SetEntityCoords(ped, Config.LabsExitLoc)
end)

RegisterNetEvent('mp-happypills:client:SairLab', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    SetEntityCoords(ped, Config.LabsEntranceLoc)
end)

CreateThread(function ()
    exports['qb-target']:AddBoxZone("EntradaLab", Config.LabsEntranceLoc, 1, 1, {
        name = "EntradaLab",
        heading = 0,
        debugPoly = false,
    }, {
        options = {
            {
                type = "Client",
                event = "mp-happypills:client:EntrarLab",
                icon = "fas fa-door-open",
                label = "Get In",
                item = "happy_pills_key",
            },
        },
        distance = 2.5
    })

    exports['qb-target']:AddBoxZone("SaidaLab", Config.LabsExitLoc, 1, 1, {
        name = "SaidaLab",
        heading = 0,
        debugPoly = false,
    }, {
        options = {
            {
                type = "Client",
                event = "mp-happypills:client:SairLab",
                icon = "fas fa-door-open",
                label = "Get Out",
            },
        },
        distance = 2.5
    })

    exports['qb-target']:AddBoxZone("MesaProcessoMeta", vector3(986.79, -140.47, -49.0), 3, 1, { -- Labs process table
        name = "MesaProcessoMeta",
        heading = 270,
        debugPoly = false,
    }, {
        options = {
            {
                type = "Client",
                event = "mp-happypills:client:MenuProcesso",
                icon = "fas fa-box",
                label = "Use Table",
            },
        },
        distance = 2.5
    })
end)

RegisterNetEvent('mp-happypills:client:MenuProcesso', function()
    exports['qb-menu']:openMenu({
        {
            header = "Pills",
            isMenuHeader = true,
        },
        {
            header = "< Close Menu",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
        {
            header = "Make Pills",
            txt = "Requerided: <br> 1x Hydrochloric Acid <br> 1x Sodium Hydroxide <br> 1x Sulfuric Acid",
            params = {
                event = "mp-happypills:client:MakeGoal",
            }
        },
        {
            header = "Pack Pills",
            txt = "Requerided: <br> 10x empty Baggies <br> 5x Pills",
            params = {
                event = "mp-happypills:client:PackGoal",
            }
        },
    })
end)

RegisterNetEvent('mp-happypills:client:MakeGoal', function()
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 5000, false)
    QBCore.Functions.Progressbar('name_here', 'MAKIMG SOME PILLS...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('mp-happypills:server:MakeGoal')
    end)
end)

RegisterNetEvent('mp-happypills:client:PackGoal', function()
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 5000, false)
    QBCore.Functions.Progressbar('name_here', 'PACKING SOME PILLS...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('mp-happypills:server:PackGoal')
    end)
end)

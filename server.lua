local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('mp-happypills:server:GetCon', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = 'happy_pills_key'
    --local item2 = 'happy_pills_key'
    local quantity = 1

    --Player.Functions.RemoveItem(item, quantity)
    --TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")

    --Player.Functions.AddItem(item2, quantity)
    --TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item2], "add")
end)

RegisterNetEvent('mp-happypills:server:BuyAcid1', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = 'hydrochloric_acid'
    local quantity = 1
    local price = 100

    Player.Functions.RemoveMoney('bank', price)

    Player.Functions.AddItem(item, quantity)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
end)

RegisterNetEvent('mp-happypills:server:BuyAcid2', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = 'sodium_hydroxide'
    local quantity = 1
    local price = 100

    Player.Functions.RemoveMoney('bank', price)
    
    Player.Functions.AddItem(item, quantity)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
end)

RegisterNetEvent('mp-happypills:server:BuyAcid3', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = 'sulfuric_acid'
    local quantity = 1
    local price = 100

    Player.Functions.RemoveMoney('bank', price)
    
    Player.Functions.AddItem(item, quantity)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
end)

RegisterNetEvent('mp-happypills:server:BuyemptyBags', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = 'empty_baggies'
    local quantity = 1
    local price = 10

    Player.Functions.RemoveMoney('bank', price)
    
    Player.Functions.AddItem(item, quantity)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
end)

RegisterNetEvent('mp-happypills:server:MakeGoal', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local hydrochloric_acid = Player.Functions.GetItemByName('hydrochloric_acid')
    local sodium_hydroxide = Player.Functions.GetItemByName('sodium_hydroxide')
    local sulfuric_acid = Player.Functions.GetItemByName('sulfuric_acid')

    if hydrochloric_acid ~= nil and sodium_hydroxide ~= nil and sulfuric_acid ~= nil then

        if hydrochloric_acid.amount >= 1 and sodium_hydroxide.amount >= 1 and sulfuric_acid.amount >= 1 then

            Player.Functions.RemoveItem('hydrochloric_acid', 1)
            Player.Functions.RemoveItem('sodium_hydroxide', 1)
            Player.Functions.RemoveItem('sulfuric_acid', 1)

            Player.Functions.AddItem('happy_pills', 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['happy_pills'], "add")
        end
    end
end)

RegisterNetEvent('mp-happypills:server:PackGoal', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local happy_pills = Player.Functions.GetItemByName('happy_pills')
    local empty_baggies = Player.Functions.GetItemByName('empty_baggies')

    if happy_pills ~= nil and empty_baggies ~= nil then
        if happy_pills.amount >= 5 and empty_baggies.amount >= 10 then

            Player.Functions.RemoveItem('happy_pills', 5)
            Player.Functions.RemoveItem('empty_baggies', 10)

            Player.Functions.AddItem('happy_pills_baggies', 10)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['happy_pills_baggies'], "add")
        end
    else
        QBCore.Functions.Notify('TextHere', 'error', 7500)
    end
end)

RegisterNetEvent('mp-happypills:server:FirstItem', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem('happy_pills_key', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['happy_pills_key'], "add")
end)
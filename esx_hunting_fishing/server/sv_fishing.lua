ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterUsableItem('fishingrod', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    TriggerClientEvent('esx_fishing:useGrod', playerId)
end)

function randomItem(items)
    local totalChance = {}
    for k,v in pairs(items) do
        for i = 1, v.chance do
            table.insert(totalChance, v.name)
        end
    end
    return totalChance[math.random(1, #totalChance)]
end

RegisterNetEvent("esx_fishing:success")

AddEventHandler("esx_fishing:success", function(zoneIndex, mdp)

    local xPlayer = ESX.GetPlayerFromId(source)
    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    local position = Config.Zones[zoneIndex].position
    print(position)
    print(playerCoords)
    local distance = #(position - playerCoords)
    if distance > Config.Zones[zoneIndex].radius then return DropPlayer(source, "Les cheateurs ne sont pas les bienvenues sur FrenchfriesV") end
    if mdp ~= "roosevelt" then return DropPlayer(source, "Les cheateurs ne sont pas les bienvenues sur FrenchfriesV") end
    local item = randomItem(Config.Zones[zoneIndex].items)
    if xPlayer.canCarryItem(item, 1) then
        xPlayer.addInventoryItem(item, 1)
    else
        TriggerClientEvent('esx:showNotification', source, 'Vous ne pouvez pas recuperer ceci car votre inventaire est plein!')
    end

end)

ESX.RegisterServerCallback('esx_fishing:sellFish', function(source, cb, itemName)
    print(source)
    print(itemName)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem(itemName).count < 1 then
        TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas ce produit sur vous!")
        return
    end
    xPlayer.removeInventoryItem(itemName, 1)
    print('A retire inventaire')
    xPlayer.addMoney(Config.Shop.items[itemName].price)
    print("a donne l'argent")
    cb(true)
 end)

 ESX.RegisterServerCallback('esx_fishing:getElements', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
    local elements = Config.Shop.items
    for k,v in pairs(Config.Shop.items) do
        v.quant = xPlayer.getInventoryItem(k).count
        --table.insert(elements[k], quant = xPlayer.getInventoryItem(k).count)
    end
     
    print(json.encode(elements))

    cb(elements)

 end)
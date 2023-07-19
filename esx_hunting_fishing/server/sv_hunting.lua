local animals = {}

RegisterNetEvent("esx_hunting:insertAnimalInTable")

AddEventHandler("esx_hunting:insertAnimalInTable", function(entityNet, meat)
local xPlayer = ESX.GetPlayerFromId(source)
print(meat) 
    print(entityNet)
    for k,v in pairs(animals) do
        if entityNet == v then 
            --Wait(15000)
            TriggerClientEvent('esx:showNotification', source, 'Cet animal a deja ete depece!') 
            return 
        end
    end
    if not xPlayer.canCarryItem(meat, 1) then  
        --Wait(15000) 
        TriggerClientEvent('esx:showNotification', source, "Tu n'as plus de place dans ton inventaire pour prelever la viande!") 
        return 
    end
    table.insert(animals, entityNet)
    xPlayer.addInventoryItem(meat, 1)
end)

ESX.RegisterServerCallback('esx_hunting:sellMeat', function(source, cb, itemName)
    print(source)
    print(itemName)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem(itemName).count < 1 then
        TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas ce produit sur vous!")
        return
    end
    xPlayer.removeInventoryItem(itemName, 1)
    print('A retire inventaire')
    xPlayer.addMoney(Config.Hunting.Shop.items[itemName].price)
    print("a donne l'argent")
    cb(true)
 end)

 ESX.RegisterServerCallback('esx_hunting:getElements', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
    local elements = Config.Hunting.Shop.items
    for k,v in pairs(Config.Hunting.Shop.items) do
        v.quant = xPlayer.getInventoryItem(k).count
        --table.insert(elements[k], quant = xPlayer.getInventoryItem(k).count)
    end
     
    print(json.encode(elements))

    cb(elements)

 end)
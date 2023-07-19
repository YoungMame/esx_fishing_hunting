CreateThread(function()
    Wait(1000)
    local pped = PlayerPedId()
    print(pped)
    AddTextEntry('depecer', '~INPUT_PICKUP~ Dépecer')
    local displayBlip = 2
    if Config.Hunting.hideZoneOnMiniMap == true then
        displayBlip = 3
    end
local blip3 = AddBlipForRadius(Config.Hunting.coords, Config.Hunting.radius)
        SetBlipSprite(blip3, 9)
        SetBlipColour(blip3, 14)
        SetBlipAlpha(blip3, 128)
        SetBlipDisplay(blip3, displayBlip)

local blip2 = AddBlipForCoord(Config.Hunting.coords.x, Config.Hunting.coords.y, Config.Hunting.coords.z)
        SetBlipSprite(blip2, Config.Hunting.blip.sprite)
        SetBlipColour(blip2, Config.Hunting.blip.color)
        SetBlipDisplay(blip2, 3)
        SetBlipAsShortRange(blip2, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(Config.Hunting.blip.string)
        EndTextCommandSetBlipName(blip2)
    
        
    local ms = 10000
    while true do
        local trouve = false
        local coords = GetEntityCoords(PlayerPedId())
        while coords == vector3(0, 0, 1) do
            Wait(10)
            print("en attente de pos")
            coords = GetEntityCoords(pped)
        end
        print(coords)
        local closestAnimal, closestDistance = ESX.Game.GetClosestPed(coords) 
        print(closestAnimal)
        local animalPed = GetEntityModel(closestAnimal)
        local animalCoords = GetEntityCoords(closestAnimal)
        print(json.encode(Config.Hunting.Animals))
        for k,v in pairs(Config.Hunting.Animals)  do
            if animalPed == GetHashKey(k) and closestDistance < 30 then
                ms = 2000
                print("animal trouve")
                trouve = true
            else
                print("animal pas trouve")
            end
        end
        --and IsEntityDead(closestAnimal) and not IsPedInAnyVehicle(pped) and HasPedGotWeapon(pped, 'weapon_knife')
        if closestDistance < 10 and trouve then
            print("tourne")
            ms = 200
            if closestDistance < 3 and IsEntityDead(closestAnimal) and HasPedGotWeapon(PlayerPedId(), 'weapon_knife') and not IsPedInAnyVehicle(PlayerPedId()) then
                ms = 0
                BeginTextCommandDisplayHelp('depecer')
                EndTextCommandDisplayHelp(1, 0, 0, 0)
                SetFloatingHelpTextWorldPosition(0, animalCoords)
                 if IsControlJustReleased(0, 51) then
                    slaughtAnimal(closestAnimal, animalCoords)
                end
            end
        end
        Wait(ms)
        ms = 10000
    end
end)

function slaughtAnimal(animal, animalCoords)
    local pped = PlayerPedId()
    CreateThread(function()
        if IsEntityDead(animal) and not IsPedInAnyVehicle(pped) then
            local animalMod = GetEntityModel(animal)
            for k,v in pairs(Config.Hunting.Animals)  do
                if animalMod == GetHashKey(k) then
                    RequestAnimDict('amb@world_human_gardener_plant@male@base')
                    SetCurrentPedWeapon(pped, "WEAPON_UNARMED", true)
                    while not HasAnimDictLoaded('amb@world_human_gardener_plant@male@base') do
                        Wait(10)
                    end                    if DoesEntityExist(animal) then
                        local playerCoords = GetEntityCoords(pped)
                        TriggerServerEvent('esx_hunting:insertAnimalInTable', NetworkGetNetworkIdFromEntity(animal), v)
                        local modelHash = "w_me_knife_01"
                        if not HasModelLoaded(modelHash) then
                         
                            RequestModel(modelHash)
                  
                            while not HasModelLoaded(modelHash) do
                                Citizen.Wait(1)
                            end
                        end

                        local object = CreateObject(modelHash, 0.0, 0.0, 0.0, true, true, false)

                        local boneIndex = GetPedBoneIndex(pped, 57005) -- 57005  main droite  18905  main gauche.
                    AttachEntityToEntity(object, pped, boneIndex, 0.07, 0.0, -0.030, 100.0, 100.0, 100.0, false, false, false, false, 2, true)
                    TaskPlayAnim(pped,"amb@world_human_gardener_plant@male@base","base",1.0,-1.0, 7000, 9, 1, true, true, true)
                    Wait(7000)
                    ESX.Game.DeleteObject(object)
                    end
                end
            end
        end
    end)
end
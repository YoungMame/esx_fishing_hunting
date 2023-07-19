ESX = exports["es_extended"]:getSharedObject()

local inZone = false

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

function setupScaleform(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    -- draw it once to set up layout
    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 0, 0)

    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(0, 177, true))
    ButtonMessage("Arrêter")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

function setupScaleform2(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    -- draw it once to set up layout
    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 0, 0)

    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(0, 191, true))
    ButtonMessage("Tirer")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

CreateThread(function()
    local displayBlip = 2
    if Config.hideZoneOnMiniMap then
        displayBlip = 3
    end
    if Config.showZones then
        for k,v in pairs(Config.Zones) do
            local blip = AddBlipForRadius(v.position, v.radius)
            SetBlipSprite(blip, 9)
            SetBlipColour(blip, 42)
            SetBlipAlpha(blip, 128)
            SetBlipDisplay(blip, displayBlip)

            local blip2 = AddBlipForCoord(v.position.x, v.position.y, v.position.z)
            SetBlipSprite(blip2, Config.blip.sprite)
            SetBlipColour(blip2, Config.blip.color)
            SetBlipDisplay(blip2, 3)
            SetBlipAsShortRange(blip2, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(Config.blip.string)
            EndTextCommandSetBlipName(blip2)
        end
    end
end)

function startFishing(zoneIndex)
    RequestAnimDict('amb@prop_human_parking_meter@male@base')
    RequestAnimDict('amb@world_human_const_drill@male@drill@idle_a')

    local inWork = true
    local pped = PlayerPedId()
    CreateThread(function()
        local form = setupScaleform("instructional_buttons")
        local im = 0
        while inWork do
            DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
            Wait(1)
            im = im +2 
            if IsControlJustPressed(0, 177) then
                inWork = false
                ClearPedTasks(pped)
                local object = GetClosestObjectOfType(GetEntityCoords(pped), 1.0, GetHashKey('prop_fishing_rod_01'), false, false, false)
                ESX.Game.DeleteObject(object)
            end
            if im > Config.timeToWait then
                local playerCoords = GetEntityCoords(pped)
                local position = Config.Zones[zoneIndex].position
                local distance = #(position - playerCoords)
                local valeurAleatoire = math.random(0,1)
                if valeurAleatoire == 1 and distance <= Config.Zones[zoneIndex].radius then
                    inWork = false 
                    local timeToGrab = 0
                    local form2 = setupScaleform2("instructional_buttons")
                    ESX.ShowNotification("~g~Un poisson a mordu!")
                    while timeToGrab < Config.timeToGrab do
                        DrawScaleformMovieFullscreen(form2, 255, 255, 255, 255, 0)
                        if IsControlJustPressed(0 ,18) then --INPUT_SKIP_CUTSCENE
                            if math.random(1, 120) == 60 then
                                TaskPlayAnim(pped, 'amb@world_human_const_drill@male@drill@idle_a', 'idle_a', 1.0, -1.0, 5000, 1, 1, true, true, true)
                                local modelHash = 'prop_wheel_tyre'
                                if not HasModelLoaded(modelHash) then
       
                                    RequestModel(modelHash)
                          
                                    while not HasModelLoaded(modelHash) do
                                        Citizen.Wait(1)
                                    end
                                end
                                local tireProp = CreateObject(modelHash, 0.0, 0.0, 0.0, true, true, false)
                            local coordso = GetEntityCoords(pped)
                            local object = GetClosestObjectOfType(coordso, 1.0, GetHashKey('prop_fishing_rod_01'), false, false, false)
                            local boneIndex = GetPedBoneIndex(playerPed, 57005) -- 57005  main droite  18905  main gauche.
                            AttachEntityToEntity(tireProp, pped, boneIndex, 0.0, 0.4, -0.35, 0.0, 0.0, 0.0, false, false, false, false, 2, true) 
                            ESX.Game.DeleteObject(object)
                            Wait(5000)
                            DetachEntity(tireProp, true, true)
                            TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_STAND_FISHING', 0, true)
                            break 
                            end
                            if math.random(1, 1000) == 567 then
                                RequestModel("a_c_sharktiger")
                                while not HasModelLoaded("a_c_sharktiger") do
                                    Wait(10)
                                    RequestModel("a_c_sharktiger")
                                    print("wait")
                                end 
                                local shark = CreatePed(28, "a_c_sharktiger", playerCoords.x, playerCoords.y, playerCoords.z + 2, 110.0, true, false) 
                                SetPedToRagdoll(shark, 1000, 1000, 0, 0, 0, 0)
                                Wait(200)
                                ClearPedTasks(shark)
                                ClearPedTasks(pped)
                                local object = GetClosestObjectOfType(GetEntityCoords(pped), 1.0, GetHashKey('prop_fishing_rod_01'), false, false, false)
                                ESX.Game.DeleteObject(object)
                                return
                            end
                            TriggerServerEvent('esx_fishing:success', zoneIndex, 'roosevelt')
                            TaskPlayAnim(pped, 'amb@prop_human_parking_meter@male@base', 'base', 1.0, -1.0, 2500, 1, 1, true, true, true)
                            local object = GetClosestObjectOfType(GetEntityCoords(pped), 1.0, GetHashKey('prop_fishing_rod_01'), false, false, false)
                            ESX.Game.DeleteObject(object)
                            Wait(2500)
                            TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_STAND_FISHING', 0, true)
                            break
                        end
                        if IsControlJustPressed(0, 177) then --	INPUT_CELLPHONE_OPTION
                            ClearPedTasks(pped)
                            local object = GetClosestObjectOfType(GetEntityCoords(pped), 1.0, GetHashKey('prop_fishing_rod_01'), false, false, false)
                            ESX.Game.DeleteObject(object)
                            return
                        end
                        timeToGrab = timeToGrab + 2
                        Wait(1)           
                    end
                    do return startFishing(zoneIndex) end 
                    im = 0 
                else
                    print(distance.." "..valeurAleatoire)
                    im = 0
                end
            end
        end
        ClearPedTasks(pped)
    end)
end

RegisterNetEvent('esx_fishing:useGrod')

AddEventHandler('esx_fishing:useGrod', function()
    for k,v in pairs(Config.Zones) do
        local pped = PlayerPedId()
        local playerCoords = GetEntityCoords(pped)
        local position = v.position
        local distance = #(position - playerCoords)
        if distance <= v.radius and not IsPedInAnyVehicle(pped) and not IsPedSwimming(pped) and not IsPedFalling(pped) then 
            TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_STAND_FISHING', 0, true)
            startFishing(k)
        end          
    end
end)
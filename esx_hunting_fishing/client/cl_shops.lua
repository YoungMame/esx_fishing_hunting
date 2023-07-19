local function creaped(pnj, x, y, z, h)
    local h = GetHashKey(pnj)
    RequestModel(h)
    while not HasModelLoaded(h) do Wait(0) end
    local ped = CreatePed(6, h, x, y, z, h, true, false)
    return ped
end

local function addblipcoords(pos, sprite, scale, color, string)
    local blip = AddBlipForCoord(pos)
    SetBlipSprite(blip, sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, scale)
    SetBlipColour(blip, color)
    SetBlipAsShortRange(blip, true)
    
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(string)
    EndTextCommandSetBlipName(blip)
    return blip
end

CreateThread(function()
    ped = creaped(Config.Shop.ped, Config.Shop.pos.x, Config.Shop.pos.y, Config.Shop.pos.z-1 , Config.Shop.heading)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    local blip = addblipcoords(Config.Shop.pos, Config.Shop.blip.sprite, Config.Shop.blip.scale, Config.Shop.blip.color, Config.Shop.blip.string)

    ped2 = creaped(Config.Hunting.Shop.ped, Config.Hunting.Shop.pos.x, Config.Hunting.Shop.pos.y, Config.Hunting.Shop.pos.z-1, Config.Hunting.Shop.heading)
    FreezeEntityPosition(ped2, true)
    SetEntityInvincible(ped2, true)
    local blip2 = addblipcoords(Config.Hunting.Shop.pos, Config.Hunting.Shop.blip.sprite, Config.Hunting.Shop.blip.scale, Config.Hunting.Shop.blip.color, Config.Hunting.Shop.blip.string)

    while true do
            if not menuState and #(GetEntityCoords(PlayerPedId()) - Config.Shop.pos) <= 2 then
                ms = 0
                ESX.ShowHelpNotification('Appuyer sur ~INPUT_CONTEXT~ vendre à ~o~'..Config.Shop.pedName)
                if IsControlJustPressed(0, 51) then
                    openMenu() menuState = true
                end
            else ms = 1000 end
        Wait(ms)
    end    
end)

CreateThread(function()
    while true do 
        if not menuState2 and  #(GetEntityCoords(PlayerPedId()) - Config.Hunting.Shop.pos) <= 2  then
                wait = 0
                ESX.ShowHelpNotification('Appuyer sur ~INPUT_CONTEXT~ vendre à ~o~'..Config.Hunting.Shop.pedName)
                if IsControlJustPressed(0, 51) then
                    openMenu2() menuState = true
                end
        else wait = 1000 end
        Wait(wait)
    end
end)

menuState = false 

local main_menu = RageUI.CreateMenu("", "RACHATS", 10, 80, "root_cause2", 'fridgit')

main_menu.Closed = function()
    menuState = false
end
    
function openMenu()

    ESX.TriggerServerCallback('esx_fishing:getElements', function(elements) 
        

        if menuState then
            menuState = false
            RageUI.Visible(main_menu, false)
        else
            menuState = true 
            RageUI.Visible(main_menu, true)
        end
        CreateThread(function()
            while menuState do 
                Wait(2)
                RageUI.IsVisible(main_menu, function()
                    for k,v in pairs(elements) do
                        --local RBADGE = v.badge
                        --local RLABEL = v.label
                        if v.quant > 0 then
                            RageUI.Button(v.string, v.rlabel, {RightLabel = v.quant}, true, {
                                onSelected = function()
                                    ESX.TriggerServerCallback('esx_fishing:sellFish', function(data)
                                        if data == true then
                                            RequestAmbientAudioBank("HUD_AMMO_SHOP", 0, 0) --This is the good audio bank
                                            PlaySoundFrontend( -1, "WEAPON_AMMO_PURCHASE", "HUD_AMMO_SHOP_SOUNDSET", 1)
                                            menuState = false 
                                            openMenu()
                                        end
                                    end, k)
                                end
                            })
                        else
                            RageUI.Button(v.string, v.rlabel, {}, false, {})
                        end
                    end

                end)
            end
        end)
    end)
end

menuState2 = false 

local main_menu2 = RageUI.CreateMenu("", "RACHATS", 10, 80, "root_cause2", 'raven_slaughterhouse')

main_menu2.Closed = function()
    menuState2 = false
end
    
function openMenu2()

    ESX.TriggerServerCallback('esx_hunting:getElements', function(elements) 
        

        if menuState2 then
            menuState2 = false
            RageUI.Visible(main_menu2, false)
        else
            menuState2 = true 
            RageUI.Visible(main_menu2, true)
        end
        CreateThread(function()
            while menuState2 do 
                Wait(2)
                RageUI.IsVisible(main_menu2, function()
                    for k,v in pairs(elements) do
                        --local RBADGE = v.badge
                        --local RLABEL = v.label
                        if v.quant > 0 then
                            RageUI.Button(v.string, v.rlabel, {RightLabel = v.quant}, true, {
                                onSelected = function()
                                    ESX.TriggerServerCallback('esx_hunting:sellMeat', function(data)
                                        if data == true then
                                            RequestAmbientAudioBank("HUD_AMMO_SHOP", 0, 0) --This is the good audio bank
                                            PlaySoundFrontend( -1, "WEAPON_AMMO_PURCHASE", "HUD_AMMO_SHOP_SOUNDSET", 1)
                                            menuState = false 
                                            openMenu2()
                                        end
                                    end, k)
                                end
                            })
                        else
                            RageUI.Button(v.string, v.rlabel, {}, false, {})
                        end
                    end

                end)
            end
        end)
    end)
end

-- Young mame il suce des dinosaures 
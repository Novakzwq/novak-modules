Modules.skinshop = {}

Modules.skinshop.initialized = false

Modules.skinshop.init = function()
    print("[SKINSHOP] Initialized")
    local parts = {
        mascara = 1,
        mao = 3,
        calca = 4,
        mochila = 5,
        sapato = 6,
        acessorio = 7,
        camisa = 8,
        colete = 9,
        adesivo = 10,
        jaqueta = 11,
        chapeu = "p0",
        oculos = "p1",
        brinco = "p2",
        relogio = "p6",
        bracelete = "p7"
    }

    local carroCompras = {
        mascara = false,
        mao = false,
        calca = false,
        mochila = false,
        sapato = false,
        acessorio = false,
        colete = false,
        camisa = false,
        adesivo = false,
        jaqueta = false,
        chapeu = false,
        oculos = false,
        brinco = false,
        relogio = false,
        bracelete = false,
    }

    local old_custom = {}
    local nCustom = {}

    local valor = 0
    local precoTotal = 0

    local ultLoja = 0
    local in_loja = false
    local atLoja = false

    -- Provado
    
    local chegou = false
    local noProvador = false

    -- Cam controll
    local dataPart = nil
    local texturaSelected = 0
    local handsup = false
    local cooldown = 0

    RegisterNUICallback("skinshopchangePart", function(data, cb)
        dataPart = parts[data.part]
        local ped = PlayerPedId()
        if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
            SendNUIMessage({ 
                listener = "skinshop",
                action = "changecategory",
                data = {
                    sexo = "Male",
                    drawa = vRP.getDrawables(dataPart),
                    category = dataPart,
                }
               
            })
        elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then 
            SendNUIMessage({ 
                listener = "skinshop",
                action = "changecategory",
                data = {
                    sexo = "Female",
                    drawa = vRP.getDrawables(dataPart),
                    category = dataPart,
                }
                
            })
        end
    end)

    RegisterNUICallback("skishopgetinfo", function(data, cb)
        local dataPart = parts[data.part]
        local ped = PlayerPedId()
        if type(dados) == "number" then
            max = GetNumberOfPedTextureVariations(PlayerPedId(), dados, tipo)
        elseif type(dados) == "string" then
            max = GetNumberOfPedPropTextureVariations(PlayerPedId(), parse_part(dados), tipo)
        end

        if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
            SendNUIMessage({ 
                listener = "skinshop",
                action = "changecategorycolor",
                sexo = "Male",
                prefix = "M", 
                max = max,
                category = dataPart,
            })
        elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then 
            SendNUIMessage({ 
                listener = "skinshop",
                action = "changecategorycolor",
                sexo = "Female",
                prefix = "F", 
                max = max,
                category = dataPart,
            })
        end
    end)


    CreateThread(function()
        createBlipSkinshop()
    end)

    CreateThread(function()
        while true do
            local sleep = 1000
            local ped = PlayerPedId()
            local playerCoords = GetEntityCoords(ped, true)
            
            for k, v in pairs(Config.skinshop) do
                for k2,v2 in pairs(v.locs) do 
                    local provador = v2.provador
                    if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, v2.x, v2.y, v2.z, true ) <= 8 and not in_loja and (cooldown == 0) then
                        sleep = 4
                        DrawMarker(27,v2.x,v2.y,v2.z-1,0,0,0,0,180.0,130.0,1.0,1.0,1.0,255,0,0,75,0,0,0,1)
                    end
                    
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), v2.x, v2.y, v2.z, true ) < 1 then
                        local abrirLojaDeRoupa = false
                        if IsControlJustPressed(0, 38) then

                            abrirLojaDeRoupa = true 

                            if abrirLojaDeRoupa then 
                                ultLoja = k
                                valor = 0
                                precoTotal = 0
                                noProvador = true
                                old_custom = vRP.getCustomization()
                                Citizen.Wait(40)
                                nCustom = old_custom
                                old = {}
            
                                lojaProvador()
            
                                cor = 0
                                dados, tipo = nil
            
                                TaskGoToCoordAnyMeans(ped, provador.x, provador.y, provador.z, 1.0, 0, 0, 786603, 0xbf800000)
                            end
                        end
                    end
        
                    if noProvador then
                        if GetDistanceBetweenCoords(GetEntityCoords(ped), provador.x, provador.y, provador.z, true ) < 0.5 and not chegou then
                            chegou = true
        
                            valor = 0
                            precoTotal = 0
                            SetEntityHeading(PlayerPedId(), provador.heading)
                            FreezeEntityPosition(ped, true)
                            SetEntityInvincible(ped, false) --MQCU
                            openGuiSkinshop()
                        end
                    end

                end
            end
            Citizen.Wait(sleep)
        end
    end)

    CreateThread(function()
        while true do 
            if cooldown > 0 then
                cooldown = cooldown - 1
            end
            Citizen.Wait(1000)
        end
    end)

    RegisterCommand("skinshop",function()
        openGuiSkinshop()
    end)

    function openGuiSkinshop()
        local ped = PlayerPedId()
        SetNuiFocus(true, true)
        -- SetCameraCoords()
        TriggerEvent("mapreedev:cl_set_shops_cam","all")
        if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
            SendNUIMessage({ 
                listener = "skinshop",
                action = "show",
                data = {
                    sexo = "Male",
                    oldCustom = nCustom,
                    ultLoja = ultLoja,
                    dadosLoja = Config.skinshop
                }
                
            })
        elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then 
SendNUIMessage({ 
    listener = "skinshop",
    action = "show",
    sexo = "Female",
    oldCustom = nCustom,
    ultLoja = ultLoja,
    dadosLoja = Config.skinshop
})
        end
        in_loja = true
    end

    RegisterNUICallback("leftHeading", function(data, cb)
        local currentHeading = GetEntityHeading(PlayerPedId())
        heading = currentHeading-tonumber(data.value)
        SetEntityHeading(PlayerPedId(), heading)
    end)

    RegisterNUICallback("handsUp", function(data, cb)
        local dict = "missminuteman_1ig_2"
        
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(100)
        end
        
        if not handsup then
            TaskPlayAnim(PlayerPedId(), dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
            handsup = true
        else
            handsup = false
            ClearPedTasks(PlayerPedId())
        end
    end)

    RegisterNUICallback("rightHeading", function(data, cb)
        local currentHeading = GetEntityHeading(PlayerPedId())
        heading = currentHeading+tonumber(data.value)
        SetEntityHeading(PlayerPedId(), heading)
    end)

    function updateCartSkinshop()
        valor = 0
        for k, v in pairs(carroCompras) do
            if carroCompras[k] == true then
                local somaValor = Config.skinshop[ultLoja]['clouth'][k]['price']
                valor = valor + somaValor
            end
        end
        precoTotal = valor
        return valor
    end

    RegisterNUICallback("skinshopchangecolor", function(data, cb)
        if type(dados) == "number" then
            max = GetNumberOfPedTextureVariations(PlayerPedId(), dados, tipo)
        elseif type(dados) == "string" then
            max = GetNumberOfPedPropTextureVariations(PlayerPedId(), parse_part(dados), tipo)
        end

        if data.action == "remove" then
            if cor > 0 then cor = cor - 1 else cor = max end
        elseif data.action == "add" then
            if cor < max then cor = cor + 1 else cor = 0 end
        end
        if dados and tipo then 
            setRoupa(dados, tipo, cor) 
        end
        cb({
            color = cor,
            part = tipo
        })
    end)

    function changeClothSkinshop(type, id, color)
        dados = type
        tipo = tonumber(parseInt(id))
        cor = color
    
        setRoupa(dados, tipo, cor)
    end

    function setRoupa(dados, tipo, cor)
        local ped = PlayerPedId()

        if type(dados) == "number" then
            SetPedComponentVariation(ped, dados, tipo, cor, 1)
        elseif type(dados) == "string" then
            if(tipo == -1) then 
                ClearPedProp(ped, parse_part(dados))
            else      
                SetPedPropIndex(ped, parse_part(dados), tipo, cor, 1)
            end        
            dados = "p" .. (parse_part(dados))
        end
        
        custom = vRP.getCustomization()
        custom.modelhash = nil

        aux = old_custom[dados]
        v = custom[dados]

        if v[1] ~= aux[1] and old[dados] ~= "custom" then
            carroCompras[dados] = true
            price = updateCartSkinshop()
            old[dados] = "custom"
        end
        if v[1] == aux[1] and old[dados] == "custom" then
            carroCompras[dados] = false
            price = updateCartSkinshop()
            old[dados] = "0"
        end

        SendNUIMessage({
            listener = "skinshop",
            action = "updatePrice",
            data = {
                value = price
            }
        })
    end

    RegisterNUICallback("skinshopchangecustomization", function(data, cb)
        changeClothSkinshop(data.type, data.id, data.color)
    end)

    RegisterNUICallback("skinshoppayament", function(data, cb)
        carroCompras = {
            mascara = false,
            mao = false,
            calca = false,
            mochila = false,
            sapato = false,
            gravata = false,
            camisa = false,
            jaqueta = false,
            bone = false,
            oculos = false,
            brinco = false,
            relogio = false,
            bracelete = false
        }
        print(tonumber(data.price))
        TriggerServerEvent("mapreedev:skinshop:buy", tonumber(data.price)) 
    end)

    RegisterNUICallback("reset", function(data, cb)
        if not in_loja then return print("N TA NA SKINSHOP") end
        vRP.setCustomization(old_custom)
        closeGuiLojaRoupa()
        ClearPedTasks(PlayerPedId())
    end)

    function closeGuiLojaRoupa()
        local ped = PlayerPedId()
        DeleteCam()
        SetNuiFocus(false, false)
        SendNUIMessage({
            listener = "skinshop",
            action = "hide"
        })
        FreezeEntityPosition(ped, false)
        SetEntityInvincible(ped, false)
        PlayerReturnInstancia()
        SendNUIMessage({
            listener = "skinshop",
            action = "setPrice",
            price = 0,
            typeaction = "remove"
        })
        
        in_loja = false
        noProvador = false
        chegou = false
        old_custom = {}
        old = nil
        carroCompras = {
            mascara = false,
            mao = false,
            calca = false,
            mochila = false,
            sapato = false,
            gravata = false,
            camisa = false,
            jaqueta = false,
            bone = false,
            oculos = false,
            brinco = false,
            relogio = false,
            bracelete = false
        }
    end


    function mapree.finishBuySkinshop(comprar) 
        if comprar then
            in_loja = false
            cooldown = 5
            closeGuiLojaRoupa()
        else
            in_loja = false
            vRP.setCustomization(old_custom)
            cooldown = 5
            closeGuiLojaRoupa()
        end
    end

    function PlayerInstancia()
        for _, player in ipairs(GetActivePlayers()) do
            local ped = PlayerPedId()
            local otherPlayer = GetPlayerPed(player)
            if ped ~= otherPlayer then
                SetEntityVisible(otherPlayer, false)
                SetEntityNoCollisionEntity(ped, otherPlayer, true)
            end
        end
    end

    function PlayerReturnInstancia()
        for _, player in ipairs(GetActivePlayers()) do
            local ped = PlayerPedId()
            local otherPlayer = GetPlayerPed(player)
            if ped ~= otherPlayer then
                SetEntityVisible(otherPlayer, true)
                SetEntityCollision(ped, true)
            end
        end
    end

    function createBlipSkinshop()
        for _, item2 in pairs(Config.skinshop) do
            for k,item in pairs(item2.locs) do 
                if item.id then 
                    item.blip = AddBlipForCoord(item.x, item.y, item.z)
                    SetBlipSprite(item.blip, item.id)
                    SetBlipColour(item.blip, item.color)
                    SetBlipScale(item.blip, 0.5)
                    SetBlipAsShortRange(item.blip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Loja de Roupas")
                    EndTextCommandSetBlipName(item.blip)
                end    
            end          
        end
    end

    function lojaProvador() 
        Citizen.CreateThread(function()
            while true do
                if noProvador then
                    PlayerInstancia()
                    DisableControlAction(1, 1, true)
                    DisableControlAction(1, 2, true)
                    DisableControlAction(1, 24, true)
                    DisablePlayerFiring(PlayerPedId(), true)
                    DisableControlAction(1, 142, true)
                    DisableControlAction(1, 106, true)
                    DisableControlAction(1, 37, true)
                else 
                    break
                end
                Citizen.Wait(4)
            end
        end)
    end

    AddEventHandler('onResourceStop', function(resource)
        if resource == GetCurrentResourceName() then
            closeGuiLojaRoupa()
        end
    end)

end
Modules.tattooshop = {}

Modules.tattooshop.initialized = false

Modules.tattooshop.init = function()
    print("[TATTTOOSHOP] Initialized")

    ----------------------------------------------------------------------------------------------------------------------------------------- -- VARIAVEIS -----------------------------------------------------------------------------------------------------------------------------------------
    local tattooShops = {}
    local oldTattoo = nil
    local atualTattoo = {}
    local atualShop = {}
    local oldCustom = {}
    local totalPrice = 0
    
    ----------------------------------------------------------------------------------------------------------------------------------------- -- FUNCTIONS -----------------------------------------------------------------------------------------------------------------------------------------
    function mapree.setTattoos(data)
        atualTattoo = data
    end
    
    function mapree.payment(r)
        SetNuiFocus(false, false)
        if r then
        else
            resetTattoo()
        end
        oldTattoo = nil
        closeGUITattooshop()
    end

    RegisterCommand("tattooshop",function()

        openTattooShop(1)
    end)
    
    function openTattooShop(id)
        local ped = PlayerPedId()
        oldTattoo = atualTattoo
        oldCustom = vRP.getCustomization()
        setNewCustom()

        SetNuiFocus(true, true)
        TriggerEvent("mapreedev:cl_set_shops_cam","all")
        local sex = "male"
        if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
            atualShop = tattooShops[id]["male"]
        elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
            atualShop = tattooShops[id]["female"]
            sex = "female"
        end

        SendNUIMessage({
            listener = "tattooshop",
            action = "show",
            data = {
                shop = atualShop,
                tattoo = oldTattoo,
                sex = sex,
                id = id
            }
        })

        in_loja = true
    end
    
    function closeGUITattooshop()
        local ped = PlayerPedId()
        vRP.setCustomization(oldCustom)
        mapree.applyTatto()
        SetNuiFocus(false, false)
        FreezeEntityPosition(ped, false)
        SetEntityInvincible(ped, false)
        in_loja = false
        oldTattoo = nil
        totalPrice = 0
        TriggerEvent("mapreedev:cl_clear_cam")

        SendNUIMessage({
            listener = "tattooshop",
            action = "hide"
        })
        DeleteCam()
    end
    
    function resetTattoo()
        atualTattoo = oldTattoo
        if oldTattoo then
            ClearPedDecorations(PlayerPedId())
            for k, v in pairs(oldTattoo) do
                AddPedDecorationFromHashes(PlayerPedId(), GetHashKey(v[1]), GetHashKey(k))
            end
        else
            ClearPedDecorations(PlayerPedId())
        end
    end
    
    function atualizarTattoo()
        ClearPedDecorations(PlayerPedId())
        for k, v in pairs(atualTattoo) do
            AddPedDecorationFromHashes(PlayerPedId(), GetHashKey(v[1]), GetHashKey(k))
        end
        SendNUIMessage({
            listener = "tattooshop",
            action = "updatePrice",
            data = {
                value = totalPrice
            }
        })
    end
    
    function mapree.applyTatto()
        ClearPedDecorations(PlayerPedId())
        for k, v in pairs(atualTattoo) do
            AddPedDecorationFromHashes(PlayerPedId(), GetHashKey(v[1]), GetHashKey(k))
        end
    end
    
    function setNewCustom()
        local roupaPelado = {
            [1885233650] = {
                [1] = {-1, 0},
                [3] = {15, 0},
                [4] = {21, 0},
                [5] = {-1, 0},
                [6] = {34, 0},
                [7] = {-1, 0},
                [8] = {15, 0},
                [10] = {-1, 0},
                [11] = {15, 0}
            },
            [-1667301416] = {
                [1] = {-1, 0},
                [3] = {15, 0},
                [4] = {15, 0},
                [5] = {-1, 0},
                [6] = {35, 0},
                [7] = {-1, 0},
                [8] = {6, 0},
                [9] = {-1, 0},
                [10] = {-1, 0},
                [11] = {15, 0}
            }
        }
        local modelHash = oldCustom.modelhash
        local idleCopy = {}
        for l, w in pairs(roupaPelado[modelHash]) do
            idleCopy[l] = w
        end
        vRP.setCustomization(idleCopy)
    end
    
    function createBlipTattooshop()
        for k, v in pairs(tattooShops) do
            for k2, v2 in pairs(v.coord) do
                if v2.exibeBlip then
                    v2.blip = AddBlipForCoord(v2[1], v2[2], v2[3])
                    SetBlipSprite(v2.blip, 75)
                    SetBlipColour(v2.blip, 39)
                    SetBlipScale(v2.blip, 0.5)
                    SetBlipAsShortRange(v2.blip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Loja de Tatuagens")
                    EndTextCommandSetBlipName(v2.blip)
                end
            end
        end
    end
    
    ----------------------------------------------------------------------------------------------------------------------------------------- -- THREADS -----------------------------------------------------------------------------------------------------------------------------------------
    CreateThread(function()
        SetNuiFocus(false, false)
        tattooShops = vSERVER.getTattooShops()
        vSERVER.getTattoo()
        createBlipTattooshop()
    end)
    
    CreateThread(function()
        while true do
            local sleep = 500
            local ped = PlayerPedId()
            local x, y, z = table.unpack(GetEntityCoords(ped))
            if not in_loja then
                for k, v in pairs(tattooShops) do
                    for k2, v2 in pairs(v["coord"]) do
                        local distance = GetDistanceBetweenCoords(x, y, z, v2[1], v2[2], v2[3], true)
                        if distance < 10 then
                            sleep = 4
                            DrawMarker(
                                27,
                                v2[1],
                                v2[2],
                                v2[3] - 0.95,
                                0,
                                0,
                                0,
                                0,
                                180.0,
                                130.0,
                                1.0,
                                1.0,
                                1.0,
                                255,
                                0,
                                0,
                                75,
                                0,
                                0,
                                0,
                                1
                            )
                            if distance <= 1 then
                                if IsControlJustPressed(0, 38) then
                                    
                                    if v2.heading then
                                        SetEntityHeading(PlayerPedId(),v2.heading)
                                    end
                                    -- oldCustom = vRP.getCustomization()
                                    -- setNewCustom()
                                    openTattooShop(k)
                                end
                            end
                        end
                    end
                end
            end
            Wait(sleep)
        end
    end) 
    ----------------------------------------------------------------------------------------------------------------------------------------- -- CALLBACK -----------------------------------------------------------------------------------------------------------------------------------------
    RegisterNUICallback("reset", function(data, cb)
        if not in_loja then return end
        resetTattoo()
        ClearPedTasks(PlayerPedId())
        closeGUITattooshop()
    end)
    
    RegisterNUICallback("changeTattoo", function(data, cb)
        local pId = data.id + 1
        local pType = data.type
        local tattooData = atualShop[pType]["tattoo"][pId]
        if atualTattoo[tattooData["name"]] ~= nil then
            local newAtualTattoo = {}
            for k, v in pairs(atualTattoo) do
                if k ~= tattooData["name"] then
                    newAtualTattoo[k] = v
                end
            end
            atualTattoo = newAtualTattoo
            if oldTattoo[tattooData["name"]] == nil then
                totalPrice = totalPrice - tattooData["price"]
            end
            atualizarTattoo()
        else
            local newAtualTattoo = {}
            for k, v in pairs(atualTattoo) do
                if k ~= tattooData["name"] then
                    newAtualTattoo[k] = v
                end
            end
            newAtualTattoo[tattooData["name"]] = {tattooData["part"]}
            atualTattoo = newAtualTattoo
            if oldTattoo[tattooData["name"]] == nil then
                totalPrice = totalPrice + tattooData["price"]
            end
            atualizarTattoo()
        end
    end)
    
    RegisterNUICallback("limpaTattoo", function(data, cb)
        atualTattoo = {}
        atualizarTattoo()
    end)

    RegisterNUICallback("tattooshopchangePart", function(data,cb)
        print(data,json.encode(data))
        SendNUIMessage({
            listener = "tattooshop",
            action = "changecategory",
            data =  tattooShops[data.store_id][data.sex][data.part]
        })
    end)
    
    RegisterNUICallback("tattooshoppayament", function(data, cb)
        vSERVER.payment(data.price, totalPrice, atualTattoo)
    end)
    
    RegisterNetEvent("reloadtattos")
    AddEventHandler("reloadtattos",function()
        if atualTattoo then
            ClearPedDecorations(PlayerPedId())
            for k, v in pairs(atualTattoo) do
                AddPedDecorationFromHashes(PlayerPedId(), GetHashKey(v[1]), GetHashKey(k))
            end
        end
    end)
    
    AddEventHandler("onResourceStop", function(resource)
        if resource == GetCurrentResourceName() then
            closeGUITattooshop()
        end
    end)

end
Modules.barbershop = {}

Modules.barbershop.initialized = false

Modules.barbershop.canStartThread = true

Modules.barbershop.init = function()

    print("[BARBERSHOP] Initialized")

    local old_custom = {}
    local old_clothes = {}
    local nCustom = {}
    local noProvador = false;
    local precoTotal = 0;
    local valor = 0;
    local cooldown = 0;
    local in_loja = false
    local dataPart = 12

    local oldC = nil 
    local old = {
        ["0"] = 0,
        ["9"] = 0,
        ["8"] = 0,
        ["10"] = 0,
        ["12"] = 0,
        ["13"] = 0,
        ["6"] = 0,
        ["5"] = 0,
        ["4"] = 0,
        ["3"] = 0,
        ["2"] = 0,
        ["1"] = 0,
    }

    local carroCompras = {
        ["0"] = false,
        ["9"] = false,
        ["8"] = false,
        ["10"] = false,
        ["12"] = false,
        ["13"] = false,
        ["6"] = false,
        ["5"] = false,
        ["4"] = false,
        ["3"] = false,
        ["2"] = false,
        ["1"] = false,
    }


 


    local canStartTread = false
    local currentCharacterMode = { fathersID = 0, mothersID = 0, skinColor = 0, shapeMix = 0.0,
                eyesColor = 0, eyebrowsHeight = 0, eyebrowsWidth = 0, noseWidth = 0,
                noseHeight = 0, noseLength = 0, noseBridge = 0, noseTip = 0, noseShift = 0,
                cheekboneHeight = 0, cheekboneWidth = 0, cheeksWidth = 0, lips = 0, jawWidth = 0,
                jawHeight = 0, chinLength = 0, chinPosition = 0,
                chinWidth = 0, chinShape = 0, neckWidth = 0,
                hairModel = 4, firstHairColor = 0, secondHairColor = 0, eyebrowsModel = 0, eyebrowsColor = 0,
                beardModel = -1, beardColor = 0, chestModel = -1, chestColor = 0, blushModel = -1, blushColor = 0, lipstickModel = -1, lipstickColor = 0,
                blemishesModel = -1, ageingModel = -1, complexionModel = -1, sundamageModel = -1, frecklesModel = -1, makeupModel = -1 }

    local custom = currentCharacterMode

    local parts = {
        ["defeitos"] = 0,
        ["barba"] = 1,
        ["sobranchelhas"] = 2,
        ["envelhecimento"] = 3,
        ["maquiagem"] = 4,
        ["blush"] = 5,
        ["rugas"] = 6,
        ["batom"] = 8,
        ["sardas"] = 9,
        ["cabelopeito"] = 10,
        ["cabelo"] = 12,
        ["2corcabelo"] = 13
    }

    CreateThread(function()
        createBarbershopBlip()
    end)

    CreateThread(function()
        while true do
            local sleep = 1000
            local ped = PlayerPedId()
            local playerCoords = GetEntityCoords(ped, true)
            
            for k, v in pairs(Config.barbershop.locs) do
                local provador = Config.barbershop.locs[k].provador
                if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, Config.barbershop.locs[k].x, Config.barbershop.locs[k].y, Config.barbershop.locs[k].z, true ) <= 8 and not in_loja and (cooldown == 0) then
                    sleep = 4
                    DrawMarker(27,Config.barbershop.locs[k].x,Config.barbershop.locs[k].y,Config.barbershop.locs[k].z-1,0,0,0,0,180.0,130.0,1.0,1.0,1.0,255,0,0,75,0,0,0,1)
                end

                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.barbershop.locs[k].x, Config.barbershop.locs[k].y, Config.barbershop.locs[k].z, true ) < 1 then
                    if IsControlJustPressed(0, 38) then

                        valor = 0
                        precoTotal = 0
                        noProvador = true
                        -- old_custom = vRP.getCustomization()
                        -- Citizen.Wait(40)
                        -- nCustom = old_custom

                        barbershopProvador()


                        TaskGoToCoordAnyMeans(ped, provador.x, provador.y, provador.z, 1.0, 0, 0, 786603, 0xbf800000)
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
                        openGuiBarberShop()
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end)

    function setPeladoClothes()
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
                [11] = {15, 0},
                ["p1"] = {-1,0 },
                ["p0"] = {-1,0 },
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
                [11] = {15, 0},
                ["p1"] = {-1,0 },
                ["p0"] = {-1,0 },
            }
        }
        local modelHash = old_clothes.modelhash
        local idleCopy = {}
        for l, w in pairs(roupaPelado[modelHash]) do
            idleCopy[l] = w
        end
        vRP.setCustomization(idleCopy)
    end

    RegisterCommand("barbershop",function(s,a,r)
        openGuiBarberShop()
    end)
    
    function openGuiBarberShop()
        local ped = PlayerPedId()
        TriggerEvent("mapreedev:cl_set_shops_cam","all")
        SetNuiFocus(true, true)
        old_clothes = vRP.getCustomization()
        
        for k,v in pairs(custom) do
            old_custom[k] = v
        end
        oldC = mapree.getOverlayBarbershop()
        setPeladoClothes()
        if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
            SendNUIMessage({ 
                listener = "barbershop",
                action = "show",
                data = {
                    sexo = "M",
                }
            })
        elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then 
            SendNUIMessage({ 
                listener = "barbershop",
                action = "show",
                data = {
                    sexo = "F",
                }
            })
        end
        in_loja = true
    end

    function mapree.successBuyBarbershop()
        closeGuiBarberShop();
    end

    function barbershopProvador() 
        Citizen.CreateThread(function()
            while true do
                if noProvador then
                --  PlayerInstancia()
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


    function closeGuiBarberShop()
        local ped = PlayerPedId()
        DeleteCam()
        SetNuiFocus(false, false)
        SendNUIMessage({ openBarberShop = false })
        FreezeEntityPosition(ped, false)
        SetEntityInvincible(ped, false)
        SendNUIMessage({
            listener = "barbershop",
            action = "hide"
        })

        vRP.setCustomization(old_clothes)
        --PlayerReturnInstancia()
        --SendNUIMessage({ action = "setPrice", price = 0, typeaction = "remove" })
        
        in_loja = false
        noProvador = false
        chegou = false
        
        old = {
            ["0"] = 0,
            ["9"] = 0,
            ["8"] = 0,
            ["10"] = 0,
            ["12"] = 0,
            ["13"] = 0,
            ["6"] = 0,
            ["5"] = 0,
            ["4"] = 0,
            ["3"] = 0,
            ["2"] = 0,
            ["1"] = 0,
        }
        
        carroCompras = {
            ["0"] = false,
            ["9"] = false,
            ["8"] = false,
            ["10"] = false,
            ["12"] = false,
            ["13"] = false,
            ["6"] = false,
            ["5"] = false,
            ["4"] = false,
            ["3"] = false,
            ["2"] = false,
            ["1"] = false,
        }
    end 



    RegisterNUICallback("reset", function(data, cb)
        if not in_loja then return end
        custom = old_custom
        old_custom = {}
        closeGuiBarberShop()
        ClearPedTasks(PlayerPedId())
    end)

    RegisterNUICallback("barbershopchangePart", function(data, cb)
        local ped = PlayerPedId()
        dataPart = parts[data.part]
        local gDrawables = mapree.getDrawablesBarbershop(dataPart)
        local gTextures = mapree.getTexturesBarbershop(dataPart)
        SendNUIMessage({
            listener = "barbershop",
            action = "changecategory",
            data = {
                drawa = gDrawables,
                colors = gTextures,
                category = dataPart
            }
        })
    end)

    RegisterNUICallback("barbershopchangecustomization", function(data, cb)
        print(data.type,data.id)
        print("DATATYPE",data.type)
        local type = parseInt(data.type)
        print(oldC[tostring(type)][1])
        print(old[tostring(type)])
        print(parseInt(data.id))

        if parseInt(data.id) ~= oldC[tostring(type)][1] and old[tostring(type)] ~= "custom" then 
            carroCompras[tostring(type)] = true
            price = barbershopUpdateCarroCompras()
          
            old[tostring(type)] = "custom"
        end

        if parseInt(data.id) == oldC[tostring(type)][1] and old[tostring(type)] == "custom" then 
            carroCompras[tostring(type)] = false
            price = barbershopUpdateCarroCompras()
            old[tostring(type)] = "0"
        end


        SendNUIMessage({
            listener = "barbershop",
            action = "updatePrice",
            data = {
                value = price,
            }
        })


        if type == 1 then -- Barba
            custom.beardModel = parseInt(data.id)
        elseif type == 2 then --Sobrancelhas
            custom.eyebrowsModel = parseInt(data.id)
        elseif type == 3 then -- Envelhecimento
            custom.ageingModel = parseInt(data.id)
        elseif type == 4 then --Maquiagem
            custom.makeupModel = parseInt(data.id)	
        elseif type == 5 then -- Blush 
            custom.blushModel = parseInt(data.id)
        elseif type == 6 then -- Rugas 
            custom.complexionModel = parseInt(data.id)
        elseif(type == 8) then --Batom
            custom.lipstickModel = parseInt(data.id)
        elseif(type == 9) then -- Sardas 
            custom.frecklesModel = parseInt(data.id)
        elseif(type == 10) then -- Cabelo do Peito 
            custom.chestModel = parseInt(data.id)
        elseif type == 12 then -- Cabelo
            custom.hairModel = parseInt(data.id)
        end
        TaskUpdateSkinOptionsBarbershop()
        TaskUpdateFaceOptionsBarbershop()
        TaskUpdateHeadOptionsBarbershop()
        --changeClothe(data.type, data.id, data.color)
    end)

    RegisterNUICallback("barbershopchangecolor", function(data, cb)
        local dataType = parseInt(data.dataType)
        local type = parseInt(data.type)
        if dataType == 1 or dataType == 2 or dataType == 5 or dataType == 8 or dataType == 10 then 
            if type == 1 then 
                if dataType == 1 then 				
                    custom.beardColor = parseInt(data.color)
                elseif dataType == 2 then 
                    custom.eyebrowsColor = parseInt(data.color)
                elseif dataType == 5 then 
                    custom.blushColor = parseInt(data.color)
                elseif dataType == 8 then 
                    custom.lipstickColor = parseInt(data.color)
                elseif dataType == 10 then 
                    custom.chestColor = parseInt(data.color) 
                end
            end
        elseif dataType == 12 then 
            if type == 1 then 			
                custom.firstHairColor = parseInt(data.color)
            else			
                custom.secondHairColor = parseInt(data.color)
            end
        end
        TaskUpdateSkinOptionsBarbershop()
        TaskUpdateFaceOptionsBarbershop()
        TaskUpdateHeadOptionsBarbershop()
    end)

    RegisterNUICallback("barbershoppayament", function(data, cb)
        local ped = PlayerPedId()
        SetNuiFocus(false, false)
        old = {
            ["0"] = 0,
            ["9"] = 0,
            ["8"] = 0,
            ["10"] = 0,
            ["12"] = 0,
            ["13"] = 0,
            ["6"] = 0,
            ["5"] = 0,
            ["4"] = 0,
            ["3"] = 0,
            ["2"] = 0,
            ["1"] = 0,
        }
        
        carroCompras = {
            ["0"] = false,
            ["9"] = false,
            ["8"] = false,
            ["10"] = false,
            ["12"] = false,
            ["13"] = false,
            ["6"] = false,
            ["5"] = false,
            ["4"] = false,
            ["3"] = false,
            ["2"] = false,
            ["1"] = false,
        }
        vSERVER.checkoutBarbershop(tonumber(data.price), json.encode(custom))
        ClearPedTasks(PlayerPedId())
        FreezeEntityPosition(ped, false)
        SetEntityInvincible(ped, false)
        in_loja = false
        noProvador = false
        chegou = false
    end)

    function mapree.resetBuyBarbershop()
        local ped = PlayerPedId()
        custom = old_custom
        old_custom = {}
        ClearPedTasks(PlayerPedId())
        TaskUpdateSkinOptionsBarbershop()
        TaskUpdateFaceOptionsBarbershop()
        TaskUpdateHeadOptionsBarbershop()
        FreezeEntityPosition(ped, false)
        SetEntityInvincible(ped, false)    
        in_loja = false
        noProvador = false
        chegou = false
    end

    function barbershopUpdateCarroCompras()
        valor = 0
        for k, v in pairs(carroCompras) do
            if carroCompras[k] == true then
                valor = valor + 500
            end
        end
        precoTotal = valor
        return valor
    end
    -------------------
    -- | SETS [1]
    ------------------

    function mapree.setCharacterBarbershop(data)
        print("SA PORRA STARTOU")
        if data then
            custom = data
            canStartTread = true
        end
    end

    function mapree.getCharacterBarbershop()
        return custom
    end

    function mapree.setOverlayBarbershop(data)
        if data then
            custom.blemishesModel = data["0"][1]
            custom.frecklesModel = data["9"][1]
            custom.lipstickModel = data["8"][1]
            custom.lipstickColor = data["8"][2]
            custom.chestModel = data["10"][1]
            custom.chestColor = data["10"][2]
            custom.hairModel = data["12"][1]
            custom.firstHairColor = data["12"][2]
            custom.secondHairColor = data["13"][2]
            custom.complexionModel = data["6"][1]
            custom.blushModel = data["5"][1]
            custom.blushColor = data["5"][2]
            custom.makeupModel = data["4"][1]
            custom.ageingModel = data["3"][1]
            custom.eyebrowsModel = data["2"][1]
            custom.eyebrowsColor = data["2"][2]
            custom.beardModel = data["1"][1]
            custom.beardColor = data["1"][2]
        end
    end

    function mapree.resetOverlayBarbershopBarbershop()
        custom.blemishesModel = currentCharacterMode.blemishesModel
        custom.frecklesModel = currentCharacterMode.frecklesModel
        custom.lipstickModel = currentCharacterMode.lipstickModel
        custom.lipstickColor = currentCharacterMode.lipstickColor
        custom.chestModel = currentCharacterMode.chestModel
        custom.chestColor = currentCharacterMode.chestColor
        custom.hairModel = currentCharacterMode.hairModel
        custom.firstHairColor = currentCharacterMode.firstHairColor
        custom.secondHairColor = currentCharacterMode.secondHairColor
        custom.complexionModel = currentCharacterMode.complexionModel
        custom.blushModel = currentCharacterMode.blushModel
        custom.blushColor = currentCharacterMode.blushColor
        custom.makeupModel = currentCharacterMode.makeupModel
        custom.ageingModel = currentCharacterMode.ageingModel
        custom.eyebrowsModel = currentCharacterMode.eyebrowsModel
        custom.eyebrowsColor = currentCharacterMode.eyebrowsColor
        custom.beardModel = currentCharacterMode.beardModel
        custom.beardColor = currentCharacterMode.beardColor
    end

    function mapree.getOverlayBarbershop()
        local overlay = {
            ["0"] = { custom.blemishesModel,0 },
            ["9"] = { custom.frecklesModel,0 },
            ["8"] = { custom.lipstickModel,custom.lipstickColor },
            ["10"] = { custom.chestModel,custom.chestColor },
            ["12"] = { custom.hairModel,custom.firstHairColor },
            ["13"] = { custom.hairModel,custom.secondHairColor },
            ["6"] = { custom.complexionModel,0 },
            ["5"] = { custom.blushModel,custom.blushColor },
            ["4"] = { custom.makeupModel,0 },
            ["3"] = { custom.ageingModel,0 },
            ["2"] = { custom.eyebrowsModel,custom.eyebrowsColor },
            ["1"] = { custom.beardModel,custom.beardColor }
        }
        return overlay
    end

    function mapree.getDrawablesBarbershop(part)
        if part == 12 then
            return tonumber(GetNumberOfPedDrawableVariations(PlayerPedId(),2))
        elseif part == -1 then
            return tonumber(GetNumberOfPedDrawableVariations(PlayerPedId(),0))
        elseif part == -2 then
            return 64
        else
            return tonumber(GetNumHeadOverlayValues(part))
        end
    end

    function mapree.getTexturesBarbershop(part)
        if part == -1 then
            return tonumber(GetNumHairColors())
        else
            return 64
        end
    end


    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            if canStartTread and not in_loja and Modules.barbershop.canStartThread then
                while not IsPedModel(PlayerPedId(),"mp_m_freemode_01") and not IsPedModel(PlayerPedId(),"mp_f_freemode_01") do
                    Citizen.Wait(10)
                end
                if custom then
                    TaskUpdateSkinOptionsBarbershop()
                    TaskUpdateFaceOptionsBarbershop()
                    TaskUpdateHeadOptionsBarbershop()
                end
            end
        end
    end)

    function TaskUpdateSkinOptionsBarbershop()
        local data = custom
        SetPedHeadBlendData(PlayerPedId(),data.fathersID,data.mothersID,0,data.skinColor,0,0,f(data.shapeMix),0,0,false)
    end

    function TaskUpdateFaceOptionsBarbershop()
        local ped = PlayerPedId()
        local data = custom	
        -- Olhos
        SetPedEyeColor(ped,data.eyesColor)
        -- Sobrancelha
        SetPedFaceFeature(ped,6,data.eyebrowsHeight)
        SetPedFaceFeature(ped,7,data.eyebrowsWidth)
        -- Nariz
        SetPedFaceFeature(ped,0,data.noseWidth)
        SetPedFaceFeature(ped,1,data.noseHeight)
        SetPedFaceFeature(ped,2,data.noseLength)
        SetPedFaceFeature(ped,3,data.noseBridge)
        SetPedFaceFeature(ped,4,data.noseTip)
        SetPedFaceFeature(ped,5,data.noseShift)
        -- Bochechas
        SetPedFaceFeature(ped,8,data.cheekboneHeight)
        SetPedFaceFeature(ped,9,data.cheekboneWidth)
        SetPedFaceFeature(ped,10,data.cheeksWidth)
        -- Boca/Mandibula
        SetPedFaceFeature(ped,12,data.lips)
        SetPedFaceFeature(ped,13,data.jawWidth)
        SetPedFaceFeature(ped,14,data.jawHeight)
        -- Queixo
        SetPedFaceFeature(ped,15,data.chinLength)
        SetPedFaceFeature(ped,16,data.chinPosition)
        SetPedFaceFeature(ped,17,data.chinWidth)
        SetPedFaceFeature(ped,18,data.chinShape)
        -- Pescoço
        SetPedFaceFeature(ped,19,data.neckWidth)
    end

    function TaskUpdateHeadOptionsBarbershop()
        local ped = PlayerPedId()
        local data = custom

        -- Cabelo
        SetPedComponentVariation(ped,2,data.hairModel,0,0)
        SetPedHairColor(ped,data.firstHairColor,data.secondHairColor)

        -- Sobrancelha 
        SetPedHeadOverlay(ped,2,data.eyebrowsModel, 0.99)
        SetPedHeadOverlayColor(ped,2,1,data.eyebrowsColor,data.eyebrowsColor)

        -- Barba
        SetPedHeadOverlay(ped,1,data.beardModel,0.99)
        SetPedHeadOverlayColor(ped,1,1,data.beardColor,data.beardColor)

        -- Pelo Corporal
        SetPedHeadOverlay(ped,10,data.chestModel,0.99)
        SetPedHeadOverlayColor(ped,10,1,data.chestColor,data.chestColor)

        -- Blush
        SetPedHeadOverlay(ped,5,data.blushModel,0.4)
        SetPedHeadOverlayColor(ped,5,1,data.blushColor,data.blushColor)

        -- Battom
        SetPedHeadOverlay(ped,8,data.lipstickModel,0.99)
        SetPedHeadOverlayColor(ped,8,1,data.lipstickColor,data.lipstickColor)

        -- Manchas
        SetPedHeadOverlay(ped,0,data.blemishesModel,0.99)
        SetPedHeadOverlayColor(ped,0,0,0,0)

        -- Envelhecimento
        SetPedHeadOverlay(ped,3,data.ageingModel,0.99)
        SetPedHeadOverlayColor(ped,3,0,0,0)

        -- Aspecto
        SetPedHeadOverlay(ped,6,data.complexionModel,0.99)
        SetPedHeadOverlayColor(ped,6,0,0,0)

        -- Pele
        SetPedHeadOverlay(ped,7,data.sundamageModel,0.99)
        SetPedHeadOverlayColor(ped,7,0,0,0)

        -- Sardas
        SetPedHeadOverlay(ped,9,data.frecklesModel,0.99)
        SetPedHeadOverlayColor(ped,9,0,0,0)

        -- Maquiagem
        SetPedHeadOverlay(ped,4,data.makeupModel,0.99)
        SetPedHeadOverlayColor(ped,4,0,0,0)
    end



    ---------------------
    -- | Outros [1]
    ---------------------
    function createBarbershopBlip()
        for _, item in pairs(Config.barbershop.locs) do
            if item.id then 
                item.blip = AddBlipForCoord(item.x, item.y, item.z)
                SetBlipSprite(item.blip, item.id)
                SetBlipColour(item.blip, item.color)
                SetBlipScale(item.blip, 0.5)
                SetBlipAsShortRange(item.blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(item.name)
                EndTextCommandSetBlipName(item.blip)
            end       
        end
    end

    AddEventHandler('onResourceStop', function(resource)
        if resource == GetCurrentResourceName() then
            closeGuiBarberShop()
        end
    end)




    
end
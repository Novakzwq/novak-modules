Modules.photo = {}

Modules.photo.initialized = false

Modules.photo.init = function()
    print("[NOVAKDEV] Initialized")

    Citizen.CreateThread(function()
        SetNuiFocus(false,false)
    end)

    local cam = nil
    local newcam = nil

    function selectCameraPHOTO(ped,param,focus,zdif,xdif,ydif,ispositive)
        print("CAM",ped,param,focus,zdif,xdif,ydif)
        local pos = GetEntityCoords(ped)
        local camPos = GetOffsetFromEntityInWorldCoords(ped, 0.0, param, 0.0)
        if newcam then return end
        if not zdif then zdif = 0.00 end
        if not xdif then xdif = 0.00 end
        if not ydif then ydif = 0.00 end
        if not ispositive then
            newcam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", (camPos.x-xdif), (camPos.y-ydif), ((camPos.z+0.65)-zdif), 0.00,0.00,0.00, focus, false, 0)
        else
            newcam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", (camPos.x+xdif), (camPos.y-ydif), ((camPos.z+0.65)-zdif), 0.00,0.00,0.00, focus, false, 0)
        end
        PointCamAtCoord(newcam, pos.x, pos.y,((pos.z+0.65)-zdif))
        SetCamActiveWithInterp(newcam, cam, 1500, true, true)
        RenderScriptCams(true, false, 1, true, true)
        Citizen.Wait(1000)
        cam = newcam
        newcam = nil
    end

    function DeleteCamPHOTO()
        SetCamActive(cam, false)
        RenderScriptCams(false, true, 0, true, true)
        cam = nil
    end


    local camOptions = {
        ["face"] = function(clonePed) -- up cam
            local x,y,z,h = table.unpack(Config.photo.clothes.coords.front)
            print(clonePed,x,y,z,h)
            SetEntityCoords(clonePed,x,y,z)
            SetEntityHeading(clonePed,h)
            selectCameraPHOTO(clonePed,0.9,50.0)
        end,
        ["body"] = function(clonePed)
            local x,y,z,h = table.unpack(Config.photo.clothes.coords.front)
            SetEntityCoords(clonePed,x,y,z)
            SetEntityHeading(clonePed,h)
            selectCameraPHOTO(clonePed,0.9,50.0,0.35)
        end,
        ["pants"] = function(clonePed) -- lower cam
            local x,y,z,h = table.unpack(Config.photo.clothes.coords.front)
            SetEntityCoords(clonePed,x,y,z)
            SetEntityHeading(clonePed,h)
            selectCameraPHOTO(clonePed,1.15,52.5,1.0)
        end,
        ["shoes"] = function(clonePed)
            local x,y,z,h = table.unpack(Config.photo.clothes.coords.front)
            SetEntityCoords(clonePed,x,y,z)
            SetEntityHeading(clonePed,h)
            selectCameraPHOTO(clonePed,0.9,50.0,1.5)
        end,
        ["all"] = function(clonePed) -- shoes cam
            local x,y,z,h = table.unpack(Config.photo.clothes.coords.front)
            SetEntityCoords(clonePed,x,y,z)
            SetEntityHeading(clonePed,h)
            selectCameraPHOTO(clonePed,2.15,62.5,0.5)
        end,
        ["back"] = function(clonePed)
            local x,y,z,h = table.unpack(Config.photo.clothes.coords.back)
            SetEntityCoords(clonePed,x,y,z)
            selectCameraPHOTO(clonePed,0.9,50.0,0.35)
            Wait(150)
            SetEntityHeading(clonePed,h)
        end,
        ["ear"] = function(clonePed)
            local x,y,z,h = table.unpack(Config.photo.clothes.coords.front)
            print(x,y,z,h)
            SetEntityCoords(clonePed,x,y,z)
            SetEntityHeading(clonePed,h)
            selectCameraPHOTO(clonePed,0.9,50.0,0.00,0.1,1.0)
        end,
        ["leftarm"] = function(clonePed)
            local x,y,z,h = table.unpack(Config.photo.clothes.coords.front)
            SetEntityCoords(clonePed,x,y,z)
            SetEntityHeading(clonePed,h)
            selectCameraPHOTO(clonePed,0.9,50.0,0.75,0.1,1.0)
        end,
        ["rightarm"] = function(clonePed)
            local x,y,z,h = table.unpack(Config.photo.clothes.coords.front)
            SetEntityCoords(clonePed,x,y,z)
            SetEntityHeading(clonePed,h)
            selectCameraPHOTO(clonePed,0.9,50.0,0.75,1.30,0.0)
        end,
    }
    
    RegisterCommand(Config.photo.clothes.command,function(source,args)
        local selectedSexo
        local selectedPrefix
        if not args[1] then return TriggerEvent("Notify","negado","Especifique um sexo") end
        if args[1]:lower() == 'm'  then
            selectedSexo = `mp_m_freemode_01`
            selectedPrefix = "Male"
        elseif args[1]:lower() == 'f' then
            selectedSexo = `mp_f_freemode_01`
            selectedPrefix = "Female"
        end
        local currentPart = 1;
        local ped = PlayerPedId()
        while not HasModelLoaded(selectedSexo) do
            RequestModel(selectedSexo)
            Citizen.Wait(10)
        end
        SetNuiFocus(true,true)
        local x,y,z,h = table.unpack(Config.photo.clothes.coords.front)
        SetEntityCoords(ped,x,y,z)
        SetEntityVisible(ped,false)
        local clonePed = CreatePed(4,selectedSexo,x,y,z, h, false, false)
        if Config.photo.clothes.defaultCustom[selectedSexo] then
            for k,v in pairs(Config.photo.clothes.defaultCustom[selectedSexo]) do
                print(k,v[1])
                SetPedComponentVariation(clonePed,k,v[1],0,0)
            end
        end
        FreezeEntityPosition(clonePed,true)

        Citizen.Wait(100)

        while currentPart <= #Config.photo.clothes.parts do
            if camOptions[Config.photo.clothes.parts[currentPart].cammode] then camOptions[Config.photo.clothes.parts[currentPart].cammode](clonePed) end
            local maxCounter = vRP.getDrawables(Config.photo.clothes.parts[currentPart].componentID)
            local partCounter = 1
            while partCounter <= maxCounter do
                local isprop, index = parse_part(Config.photo.clothes.parts[currentPart].componentID)
                print("PROP PART",isprop,index)
                local colorIndex = 0
                local maxColors = 0
                if isprop then
                    maxColors = GetNumberOfPedPropTextureVariations(clonePed,index,partCounter)
                else
                    maxColors = GetNumberOfPedTextureVariations(clonePed,index,partCounter)
                end
                while colorIndex <= maxColors do
                    if isprop then
                        print(isprop,maxColors,partCounter)
                        SetPedPropIndex(clonePed,isprop,partCounter,colorIndex,1)
                    else
                        SetPedComponentVariation(clonePed,index,partCounter,colorIndex,1)
                    end
                    Citizen.Wait(1000)
                    TriggerServerEvent('TakePhoto','cache/photo/clothes/'..Config.photo.clothes.parts[currentPart].componentID.."/"..selectedPrefix..'/',partCounter..'_'..colorIndex..'.jpg')
                    Citizen.Wait(500)   
                    colorIndex = colorIndex + 1
                end
                partCounter = partCounter + 1
            end
            currentPart = currentPart + 1
        end
        DeleteEntity(clonePed)
        DeleteCamPHOTO()
        SetEntityVisible(ped,true)
        SetNuiFocus(false,false)
    end)

    local function getDrawablesBarbershop(part)
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

    RegisterCommand(Config.photo.barbershop.command,function(s,args,r)
        local selectedSexo
        local selectedPrefix
        if not args[1] then return TriggerEvent("Notify","negado","Especifique um sexo") end
        if args[1]:lower() == 'm'  then
            selectedSexo = `mp_m_freemode_01`
            selectedPrefix = "Male"
        elseif args[1]:lower() == 'f' then
            selectedSexo = `mp_f_freemode_01`
            selectedPrefix = "Female"
        end
        local ped = PlayerPedId()
        while not HasModelLoaded(selectedSexo) do
            RequestModel(selectedSexo)
            Citizen.Wait(10)
        end
        SetNuiFocus(true,true)
        local x,y,z,h = table.unpack(Config.photo.barbershop.coords.front)
        SetEntityCoords(ped,x,y,z)
        SetEntityVisible(ped,false)
        local clonePed = CreatePed(4,selectedSexo,x,y,z, h, false, false)
        SetPedDefaultComponentVariation(clonePed)
        FreezeEntityPosition(clonePed,true)

        SetPedHeadBlendData(clonePed, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1, 1, 1, true)


        Citizen.Wait(1000)

        if Config.photo.barbershop.clothes[selectedSexo] then
            for k,v in pairs(Config.photo.barbershop.clothes[selectedSexo]) do
                SetPedComponentVariation(clonePed,k,v[1],v[2],0)
            end
        end

        camOptions["face"](clonePed)

        local hairColor = 0
        camOptions["face"](clonePed)
        while hairColor <= GetNumHairColors() do
            SetPedComponentVariation(clonePed,2,Config.photo.barbershop.colorsHair,0,0)
            SetPedHairColor(clonePed,hairColor,0)
            Citizen.Wait(1000)
            TriggerServerEvent('TakePhoto','cache/photo/barbershop/'..selectedPrefix..'/haircolor/',hairColor..'.jpg')
            Citizen.Wait(100)
            hairColor = hairColor + 1
        end

        local secondHairColor = 0
        
        while secondHairColor <= GetNumHairColors() do
            SetPedComponentVariation(clonePed,2,Config.photo.barbershop.colorsHair,0,0)
            SetPedHairColor(clonePed,0,secondHairColor)
            Citizen.Wait(1000)
            TriggerServerEvent('TakePhoto','cache/photo/barbershop/'..selectedPrefix..'/secondhaircolor/',secondHairColor..'.jpg')
            Citizen.Wait(100)
            secondHairColor = secondHairColor + 1
        end

        local primaryMakeUpColor = 0

        while primaryMakeUpColor <= GetNumMakeupColors() do
            SetPedHeadOverlay(clonePed,4,1, 0.99)
            SetPedHeadOverlayColor(clonePed,4,2,primaryMakeUpColor,primaryMakeUpColor)
            Wait(500)
            TriggerServerEvent('TakePhoto','cache/photo/barbershop/'..selectedPrefix..'/primarymakeup/',primaryMakeUpColor..'.jpg')
            Wait(1000)
            primaryMakeUpColor = primaryMakeUpColor + 1
        end



        local currentPart = 1;

        while currentPart <= #Config.photo.barbershop.parts do
            if camOptions[Config.photo.barbershop.parts[currentPart].cammode] then camOptions[Config.photo.barbershop.parts[currentPart].cammode](clonePed) end
            local maxCounter = getDrawablesBarbershop(Config.photo.barbershop.parts[currentPart].componentID)
           
            local partCounter = 1
            while partCounter <= maxCounter do
                if Config.photo.barbershop.parts[currentPart].componentID == 12 then
                    SetPedComponentVariation(clonePed,2,partCounter,0,0)
                    SetPedHairColor(clonePed,0,0)
                else
                    SetPedHeadOverlay(clonePed,Config.photo.barbershop.parts[currentPart].componentID,partCounter, 0.99)
                    SetPedHeadOverlayColor(clonePed,Config.photo.barbershop.parts[currentPart].componentID,1,1,1)                    
                end
                Citizen.Wait(1000)
                TriggerServerEvent('TakePhoto','cache/photo/barbershop/'..selectedPrefix..'/'..Config.photo.barbershop.parts[currentPart].componentID..'/',partCounter..'.jpg')
                Citizen.Wait(500)   
                partCounter = partCounter + 1
            end
            currentPart = currentPart + 1
        end
        DeleteEntity(clonePed)
        DeleteCamPHOTO()
        SetEntityVisible(ped,true)
        SetNuiFocus(false,false)
    end)

    RegisterCommand(Config.photo.tattooshop.command,function(s,args,r)
        local selectedSexo
        local selectedPrefix
        if not args[1] then return TriggerEvent("Notify","negado","Especifique um sexo") end
        if args[1]:lower() == 'm'  then
            selectedSexo = `mp_m_freemode_01`
            selectedPrefix = "partsM"
        elseif args[1]:lower() == 'f' then
            selectedSexo = `mp_f_freemode_01`
            selectedPrefix = "partsF"
        end
        local ped = PlayerPedId()
        while not HasModelLoaded(selectedSexo) do
            RequestModel(selectedSexo)
            Citizen.Wait(10)
        end
        SetNuiFocus(true,true)
        local x,y,z,h = table.unpack(Config.photo.tattooshop.coords.front)
        SetEntityCoords(ped,x,y,z)
        SetEntityVisible(ped,false)
        local clonePed = CreatePed(4,selectedSexo,x,y,z, h, false, false)
        SetPedDefaultComponentVariation(clonePed)
        FreezeEntityPosition(clonePed,true)

        SetPedHeadBlendData(clonePed, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1, 1, 1, true)

        if Config.photo.tattooshop.clothes[selectedSexo] then
            for k,v in pairs(Config.photo.tattooshop.clothes[selectedSexo]) do
                SetPedComponentVariation(clonePed,k,v[1],v[2],0)
            end
        end


        Citizen.Wait(1000)

        local currentPart = 1;

        while currentPart <= #Config.photo.tattooshop.parts do
            local partInfos = Config.photo.tattooshop.parts[currentPart]
            if camOptions[partInfos.cammode] then camOptions[partInfos.cammode](clonePed) end
            for k,v in pairs(partInfos.tattoos) do
                if camOptions[v.cammode] then camOptions[v.cammode](clonePed) end
                ClearPedDecorations(clonePed)
                AddPedDecorationFromHashes(clonePed,v.part,v.name)
                Wait(1000)
                TriggerServerEvent('TakePhoto','cache/photo/tattooshop/'..selectedPrefix.."/"..partInfos.partName..'/'..v.part.."/", v.name..'.jpg')
                Wait(1000)
            end
            currentPart = currentPart + 1
        end
        SetNuiFocus(false,false)
    end)
end
Modules.mdt = {}

Modules.mdt.init = function()
    local is_open = false
    local preso = false

    RegisterCommand("mdt",function(s,a,r)
        is_open = true
        if not vSERVER.CanOpenMDT() then return TriggerEvent("Notify","negado","Você não tem permissao para abrir o MDT") end
        local profile = vSERVER.GetMeProfile()
    
        SetNuiFocus(true,true)
        SendNUIMessage({
            listener = "mdt",
            action = "show",
            data = {
                profile = profile,
                config = Config.mdt
            }
        })
    end)

    RegisterNUICallback("home",function(data,cb)
        local Infos = vSERVER.GetInfos()
        while not Infos do
            Wait(100)
        end
        cb(Infos)
    end)

    RegisterNUICallback("sendannoucements",function(data,cb)
        if not data.message then return print("Can't find message") end 
        local ActualMessages = vSERVER.SendAnnounce(data.message)
        while not ActualMessages do
            Wait(100)
        end 
        cb(ActualMessages)
    end)

    RegisterNUICallback("punish",function(data,cb)
        cb(Config.mdt.crimes)
    end)

    RegisterNUICallback("changephoto",function(data,cb)
        local result = vSERVER.ChangePhoto(data.url)
        while not result do
            Wait(100)
        end

        cb(result)
    end)

    RegisterNUICallback("reset",function(data,cb)
        if not is_open then return end
        is_open = false
        SendNUIMessage({
            listener = "mdt",
            action = "hide",
        })
        SetNuiFocus(false,false)
        cb("ok")
    end)

    RegisterNUICallback("upgrade", function(data,cb)
        vSERVER.Upgrade(data.user_id)
        cb("ok")
    end)

    RegisterNUICallback("downgrade", function(data,cb)
        vSERVER.Downgrade(data.user_id)
        cb("ok")
    end)

    RegisterNUICallback("dimiss", function(data,cb)
        vSERVER.Dimiss(data.user_id)
        cb("ok")
    end)

    RegisterNUICallback("contract", function(data,cb)
        vSERVER.Contract(data.user_id)
        cb("ok")
    end)

    RegisterNUICallback("searchficha", function(data,cb)
        local fichaResult = vSERVER.SearchFicha(data.id)
        while not fichaResult do
            Wait(100)
        end
        cb(fichaResult)
    end)

    RegisterNUICallback("deter",function(data,cb)
        local detidoinfo = vSERVER.DeterVehicle(data.vehicle,data.user_id,data.status)
        while not detidoinfo do
            Wait(100)
        end
        cb(detidoinfo)
    end)

    RegisterNUICallback("searchemp",function(data,cb)
        local empInfo = vSERVER.SearchEmp(data.id)
        while not empInfo do
            Wait(100)
        end
        cb(empInfo)
    end)

    RegisterNUICallback("prender",function(data,cb)
        local success = vSERVER.Prender(data.id,data.months,data.crimes)
        while not success do
            Wait(100)
        end
        cb(success)
    end)

    RegisterNUICallback("multar",function(data,cb)
        local success = vSERVER.Multar(data.id,data.price)
        while not success do
            Wait(100)
        end
        cb(success)
    end)

    local preso = false

    RegisterNetEvent("big_mdt:prender")
    AddEventHandler("big_mdt:prender",function(status)
        preso = status
        key = false
        currentKeyloc = false
        _runThreadPrisionDist()
        _runThreadPrisionFuga()
        _runThreadRevive()
        if not preso then return end
        local ped = PlayerPedId()
        SetEntityInvincible(ped,true)
        FreezeEntityPosition(ped,true)
        SetEntityVisible(ped,false,false)
        while not HasCollisionLoadedAroundEntity(ped) do
            Wait(100)
        end
        SetEntityInvincible(ped,false)
        FreezeEntityPosition(ped,false)
        SetEntityVisible(ped,true,false)
    end)

    local isThrdDistRunning = false

    function _runThreadPrisionDist()
        if isThrdDistRunning then return end
        isThrdDistRunning = true
        Wait(5000)
        Citizen.CreateThread(function()
            while true do
                if not preso then
                    isThrdDistRunning = false
                    break
                end
                local x,y,z = table.unpack(Config.mdt.prisionPosition)
                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
                if distance >= 150 then
                    SetEntityCoords(PlayerPedId(),x,y,z)
                    TriggerEvent("Notify","aviso","O agente penitenciário encontrou você tentando escapar.")
                end
                Citizen.Wait(5000)
            end
        end)
    end

    local isThrdFugaRunning = false
    local key = false
    local currentLocation = nil
    local blip = nil
    local isSearching = false
    local currentKeyloc = false

    function _runThreadPrisionFuga()
        if isThrdFugaRunning then return end
        isThrdFugaRunning = true
        Citizen.CreateThread(function()
            while true do
                local ped = PlayerPedId()
                local sleep = 1000
                if not preso then
                    isThrdFugaRunning = false
                    break
                end
                if not key then
                    if not currentLocation then
                        if blip ~= nil then
                            RemoveBlip(blip)
                        end
                        currentLocation = math.random(1,#Config.mdt.search.locs)
                        blip = CreateBlip(Config.mdt.search.locs[currentLocation],"Buscar Chaves")
                    end
                    local currentCDS = Config.mdt.search.locs[currentLocation]
                    local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), currentCDS[1], currentCDS[2], currentCDS[3], false)
                    if dist <= 20 and not isSearching then
                        sleep = 1
                        DrawMarker(21,currentCDS[1],currentCDS[2],currentCDS[3],0,0,0,0,180.0,130.0,1.0,1.0,0.5,255,0,0,100,1,0,0,1)
                        if dist <= 1.5 then
                            drawTxt("PRESSIONE  ~r~E~w~  PARA BUSCAR A CHAVE",4,0.5,0.93,0.50,255,255,255,180)
                        end
                    end
                else
                    if not currentKeyloc then
                        currentKeyloc = true
                        
                        if blip ~= nil then
                            RemoveBlip(blip)
                        end
                        blip = CreateBlip(Config.mdt.keyLocation,"Usar Chaves")
                    end
        
                    local currentCDS = Config.mdt.keyLocation
                    local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), currentCDS[1], currentCDS[2], currentCDS[3], false)
                    if dist <= 20 then
                        sleep = 1
                        DrawMarker(21,currentCDS[1],currentCDS[2],currentCDS[3],0,0,0,0,180.0,130.0,1.0,1.0,0.5,255,0,0,100,1,0,0,1)
                        if dist <= 1.5 then
                            drawTxt("PRESSIONE  ~r~E~w~  PARA USAR A CHAVE",4,0.5,0.93,0.50,255,255,255,180)
                        end
                    end
                end
                Citizen.Wait(sleep)
            end
        end)
    end

    local isThrdReviveRunning = false

    function _runThreadRevive()
        if isThrdReviveRunning then return end
        isThrdReviveRunning = true
        Citizen.CreateThread(function()
            while true do
                if not preso then
                    isThrdReviveRunning = false
                    break
                end
                if GetEntityHealth(PlayerPedId()) <= 150 then
                    vRP.killGod()
                    vRP.setHealth(200)
                end
                Wait(5000)
            end
        end)
    end

    RegisterKeyMapping("big_mdt:search:key","Buscar Chaves","keyboard","E")

    RegisterCommand("big_mdt:search:key",function(s,a,r)
        if not preso then return end
        if key then return end
        if isSearching then return end
        local ped = PlayerPedId()
        local currentCDS = Config.mdt.search.locs[currentLocation]
        local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), currentCDS[1], currentCDS[2], currentCDS[3], false)
        if dist <= 1.5 then
            vRP._playAnim(false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
            TriggerEvent('cancelando',true)
            TriggerEvent("progress",5000,"Buscando Chaves")
            isSearching = true
            Wait(5000)
            TriggerEvent('cancelando',false)
            isSearching = false
            currentLocation = nil
            vRP._stopAnim(source,false)
        
            if math.random(0,100) <= Config.mdt.search.chances["rat"] then
                SetPedToRagdollWithFall(ped, 1500, 2000, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
                SetEntityHealth(ped, GetEntityHealth(ped)-20)
                TriggerEvent("Notify","aviso","Você encontrou um rato")
            elseif math.random(0,100) <= Config.mdt.search.chances["key"] then
                key = true
                TriggerEvent("Notify","aviso","Você encontrou a chave")
            else
                TriggerEvent("Notify","aviso","Você encontrou lixo")
                vSERVER.TrashInv()
            end
        
        end
    end)

    RegisterKeyMapping("big_mdt:use_key","Usar Chaves","keyboard","E")

    RegisterCommand("big_mdt:use_key",function()
        if not preso then return end
        if not key then return end
        local ped = PlayerPedId()
        local currentCDS = Config.mdt.keyLocation
        local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), currentCDS[1], currentCDS[2], currentCDS[3], false)
        if dist <= 1.5 then
            if blip ~= nil then
                RemoveBlip(blip)
            end
            vSERVER.LibertPlayer()
        end
    end)

    function drawTxt(text,font,x,y,scale,r,g,b,a)
        SetTextFont(font)
        SetTextScale(scale,scale)
        SetTextColour(r,g,b,a)
        SetTextOutline()
        SetTextCentre(1)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(x,y)
    end

    function CreateBlip(location,text)
        local Blip = AddBlipForCoord(location[1],location[2],location[3])
        SetBlipSprite(Blip,1)
        SetBlipColour(Blip,5)
        SetBlipScale(Blip,0.4)
        SetBlipAsShortRange(Blip,false)
        SetBlipRoute(Blip,true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(text)
        EndTextCommandSetBlipName(Blip)
        return Blip
    end

    local newsScaleFormCounter = 0

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            if newsScaleFormCounter > 0 then
                newsScaleFormCounter = newsScaleFormCounter - 1
            end
        end
    end)

    RegisterNetEvent("News")
    AddEventHandler("News", function(counter)
        newsScaleFormCounter = counter
        PlaySound(-1, "RANK_UP", "HUD_AWARDS", 0, 0, 1)
    end)
            
    Citizen.CreateThread(function()
        local scaleform2 = RequestScaleformMovie("BREAKING_NEWS")
        while not HasScaleformMovieLoaded(scaleform2) do
            Citizen.Wait(100)
        end
        if HasScaleformMovieLoaded(scaleform2) then

            PushScaleformMovieFunction(scaleform2, "SET_DISPLAY_CONFIG")
            PushScaleformMovieFunctionParameterInt(1920)
            PushScaleformMovieFunctionParameterInt(1080)
            PushScaleformMovieFunctionParameterFloat(0.5)
            PushScaleformMovieFunctionParameterFloat(0.5)
            PushScaleformMovieFunctionParameterFloat(0.5)
            PushScaleformMovieFunctionParameterFloat(0.5)
            PushScaleformMovieFunctionParameterInt(0)
            PushScaleformMovieFunctionParameterInt(0)
            PushScaleformMovieFunctionParameterInt(0)
            PopScaleformMovieFunctionVoid()
            
            PushScaleformMovieFunction(scaleform2, "SET_TEXT")
            PushScaleformMovieFunctionParameterString("Fuga do presidio!")
            PushScaleformMovieFunctionParameterString("Os bandidos conseguiram arrombar a porta e fugir!")
            PopScaleformMovieFunctionVoid()
            
            PushScaleformMovieFunction(scaleform2, "SET_SCROLL_TEXT")
            PushScaleformMovieFunctionParameterInt(0)
            PushScaleformMovieFunctionParameterInt(0)
            PushScaleformMovieFunctionParameterString("~r~Noticia de Última Hora")
            PopScaleformMovieFunctionVoid()
        
            PushScaleformMovieFunction(scaleform2, "DISPLAY_SCROLL_TEXT")
            PushScaleformMovieFunctionParameterInt(0)
            PushScaleformMovieFunctionParameterInt(0)
            PushScaleformMovieFunctionParameterInt(100)
            PopScaleformMovieFunctionVoid()	
            while true do
                Citizen.Wait(1)
                if newsScaleFormCounter > 0 then
                    DrawScaleformMovieFullscreen(scaleform2, 255, 255, 255, 255)
                end
            end
        end
    end)

end
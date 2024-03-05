Modules.mdt = {}

Modules.mdt.init = function()
    
    MDTFunctions.prepares()

    local announcements = {}

    function mapreedev.CanOpenMDT()
        local source = source
        local user_id = vRP.getUserId(source)
        return vRP.hasPermission(user_id, Config.mdt.openPermission)
    end

    function mapreedev.GetInfos()
        local source = source
        local user_id = vRP.getUserId(source)

        local officesInService = {}

        local offices = vRP.getUsersByPermission(Config.mdt.openPermission)

        for nsource,nuser_id in pairs(offices) do
            local nidentity = vRP.getUserIdentity(nuser_id)
            local photo = vRP.query("mapreedev/GetMDTPhoto",{ user_id = nuser_id })
            print("PHOTO_tEST",photo,json.encode(photo))
            if not photo[1] then 
                photo = nil
            else
                photo = photo[1].image_url
            end
            local gradeInfos = GetUserGrade(nuser_id)
            officesInService[#officesInService+1] = {
                name = ""..nidentity.name.." "..nidentity.firstname.."",
                groups = vRP.getUserGroups(nuser_id),
                user_id = nuser_id,
                source = nsource,
                photo = photo,
                grade = gradeInfos.currentGrade.group
            }
            print("T",nsource,nuser_id)
        end

        return {
            announcements = announcements,
            offices = officesInService
        }
    end

    function mapreedev.SendAnnounce(message)
        local source = source
        local user_id = vRP.getUserId(source)

        local identity = vRP.getUserIdentity(user_id)

        local photo = vRP.query("mapreedev/GetMDTPhoto",{ user_id = user_id })
        if not photo[1] then 
            photo = nil
        else
            photo = photo[1].image_url
        end

        announcements[#announcements+1] = {
            name = ""..identity.name.." "..identity.firstname.."",
            message = message,
            date = os.time(),
            photo = photo
        }

        table.sort(announcements,function(announce1,announce2)
            return announce1.date < announce2.date
        end)

        return announcements
    end

    function mapreedev.GetMeProfile()
        local source = source
        local user_id = vRP.getUserId(source)

        local photo = vRP.query("mapreedev/GetMDTPhoto",{ user_id = user_id })
        if not photo[1] then 
            photo = nil
        else
            photo = photo[1].image_url
        end

        print("returned",photo)

        return photo
    end

    function mapreedev.ChangePhoto(photoURL)
        local source = source
        local user_id = vRP.getUserId(source)

        vRP.query("mapreedev/ChangeMDTPhoto",{ user_id = user_id, url = photoURL })

        return {
            success = true,
        }
    end

    function GetUserGrade(user_id)
        local Groups = vRP.getUserGroups(user_id)

        local currentGrade = nil
        local nextGrade = nil
        local prevGrade = nil

        for k,v in pairs(Config.mdt.patentes) do
            print("groups",k,v)
            for l,w in pairs(v) do
                if vRP.hasGroup(user_id,w.group) then
                    currentGrade = {
                        org = k,
                        group = w.group,
                        config = Config.mdt.patentes[k][l] 
                    }
                elseif currentGrade and not nextGrade then
                    nextGrade = {
                        org = k,
                        group = w.group,
                        config = Config.mdt.patentes[k][l]
                    }
                elseif not currentGrade then
                    prevGrade = {
                        org = k,
                        group = w.group,
                        config = Config.mdt.patentes[k][l]
                    }
                end
            end
            
        end

        print("q porra",json.encode({
            currentGrade = currentGrade,
            nextGrade = nextGrade,
            prevGrade = prevGrade
        }))

        return {
            currentGrade = currentGrade,
            nextGrade = nextGrade,
            prevGrade = prevGrade
        }

    end

    function mapreedev.Contract(nuser_id)
        local source = source
        local user_id = vRP.getUserId(source)

        -- if user_id == parseInt(nuser_id) then return TriggerClientEvent("Notify",source,"negado","Você não pode se promover") end

        local gradeInfos = GetUserGrade(user_id)

        if not vRP.hasPermission(user_id, Config.mdt.patentes[gradeInfos.currentGrade.org][1].canChange) then return TriggerClientEvent("Notify",source,"negado","Você não tem permissão para promover esse usuario") end

        vRP.addUserGroup(parseInt(nuser_id),Config.mdt.patentes[gradeInfos.currentGrade.org][1].group)
    end

    function mapreedev.Upgrade(nuser_id)
        local source = source
        local user_id = vRP.getUserId(source)

        -- if user_id == parseInt(nuser_id) then return TriggerClientEvent("Notify",source,"negado","Você não pode se promover") end

        local gradeInfo = GetUserGrade(parseInt(nuser_id))

        if not vRP.hasPermission(user_id, gradeInfo.currentGrade.config.canChange) then return TriggerClientEvent("Notify",source,"negado","Você não tem permissão para promover esse usuario") end
        if not gradeInfo.nextGrade then return TriggerClientEvent("Notify",source,"negado","O Usuario já esta no cargo maximo") end

        vRP.removeUserGroup(parseInt(nuser_id),gradeInfo.currentGrade.group)

        vRP.addUserGroup(parseInt(nuser_id),gradeInfo.nextGrade.group)

    end

    function mapreedev.Downgrade(nuser_id)
        local source = source
        local user_id = vRP.getUserId(source)

        -- if user_id == parseInt(nuser_id) then return TriggerClientEvent("Notify",source,"negado","Você não pode se rebaixar") end

        local gradeInfo = GetUserGrade(parseInt(nuser_id))

        if not vRP.hasPermission(user_id, gradeInfo.currentGrade.config.canChange) then return TriggerClientEvent("Notify",source,"negado","Você não tem permissão para rebaixar esse usuario") end

        if not gradeInfo.prevGrade then return TriggerClientEvent("Notify",source,"negado","O Usuario já esta no cargo minimo") end

        vRP.removeUserGroup(parseInt(nuser_id),gradeInfo.currentGrade.group)

        vRP.addUserGroup(parseInt(nuser_id),gradeInfo.prevGrade.group)

    end

    function mapreedev.Dimiss(nuser_id)
        local source = source
        local user_id = vRP.getUserId(source)

        -- if user_id == parseInt(nuser_id) then return TriggerClientEvent("Notify",source,"negado","Você não pode se demitir") end

        local gradeInfo = GetUserGrade(parseInt(nuser_id))

        if not vRP.hasPermission(user_id, gradeInfo.currentGrade.config.canChange) then return TriggerClientEvent("Notify",source,"negado","Você não tem permissão para demitir esse usuario") end

        vRP.removeUserGroup(parseInt(nuser_id),gradeInfo.currentGrade.group) 
    end

    function mapreedev.SearchFicha(nuser_id)
        local source = source
        local user_id = vRP.getUserId(source)
        local nsource = vRP.getUserSource(parseInt(nuser_id))
        if not nsource then return TriggerClientEvent("Notify",source,"negado","Nenhum player com esse id encontrado") end
        
        local identity = vRP.getUserIdentity(parseInt(nuser_id))

        local vehicles = MDTFunctions.GetVehicles(parseInt(nuser_id))
        local vehiclesList = {}

        for k,v in pairs(vehicles) do
            vehiclesList[#vehiclesList+1] = {
                detido = v.detido,
                name = vRP.vehicleName(v.vehicle),
                index = v.vehicle,
            }
            print(k,json.encode(v))
        end

        local query = vRP.query("mapreedev/GetFicha",{ user_id = parseInt(nuser_id) })
        if #query >= 1 then
            return {
                name = ""..identity.name.." "..identity.firstname.."",
                vehicles = vehiclesList,
                user_id = nuser_id,
                ficha = query[1].data
            }
        else
            return {
                name = ""..identity.name.." "..identity.firstname.."",
                vehicles = vehiclesList,
                user_id = nuser_id,
                ficha = nil
            }
        end
    
    end

    function mapreedev.DeterVehicle(vehicleName,nuser_id,status)
        local source = source
        local user_id = vRP.getUserId(source)
        local nsource = vRP.getUserSource(parseInt(nuser_id))
        if not nsource then
            TriggerClientEvent("Notify",source,"Usuario Invalido ou inexistente")
            return {
                detido = false
            }
        end
        local detido = 0
        if status == true then
            detido = 1
        end
        local query = MDTFunctions.SetDetido(parseInt(nuser_id),vehicleName,detido)
        return {
            detido = status
        }
    end

    local prisoes = {}

    function CreateFicha(user_id,crimes)
        local ActualFicha = vRP.query("mapreedev/GetFicha",{ user_id = user_id })
        if #ActualFicha >= 1 then
            local NewFicha = {}
            local index = 1
            local ExistingCrimes = json.decode(ActualFicha[1].data)
            for i=1,#ExistingCrimes do
                if ExistingCrimes[i] then
                    NewFicha[index] = ExistingCrimes[i]
                    index = index + 1
                end
            end
            for i=1,#crimes do
                if crimes[i] then
                    NewFicha[index] = crimes[i]
                    index = index + 1
                end
            end
            vRP.execute("mapreedev/InsertFicha",{ user_id = user_id, data = json.encode(NewFicha) })
        else
            vRP.execute("mapreedev/InsertFicha",{ user_id = user_id, data = json.encode(crimes) })
        end
    end 


    function mapreedev.Prender(nuser_id,months,crimes)
        local source = source
        local user_id = vRP.getUserId(source)

        local nsource = vRP.getUserSource(parseInt(nuser_id))
        if not nsource then
            TriggerClientEvent("Notify",source,"negado","Usuario inexistente ou offline")
            return {
                status = false
            }
        end
        local ped = GetPlayerPed(nsource)

        local old_custom = vRPclient.getCustomization(nsource)
        local idle_copy = {}
        for k,v in pairs(Config.mdt.prisionCloth[old_custom.modelhash]) do
            idle_copy[k] = v
        end

        vRPclient._setCustomization(nsource,idle_copy)
        prisoes[parseInt(nuser_id)] = parseInt(months)
        CreateFicha(parseInt(nuser_id),crimes)
        vRP.setUData(parseInt(nuser_id),"vRP:prisao",json.encode(parseInt(months)))
        TriggerClientEvent("novak_mdt:prender",nsource,true)
        TriggerClientEvent("resetHandcuff",nsource)
        local x,y,z = table.unpack(Config.mdt.prisionPosition)
        SetEntityCoords(ped,x,y,z)
        TriggerClientEvent("Notify",source,"sucesso","Prisão aplicada com sucesso.",5000)
        TriggerClientEvent("Notify",nsource,"importante","Você foi preso por <b>"..vRP.format(parseInt(months)).." meses</b>.",5000)
        return {
            status = true
        }
    end

    function task_save_prisoes()
        SetTimeout(1000 * 60,task_save_prisoes) --1 minuto

        for k,v in pairs(prisoes) do
            prisoes[k] = prisoes[k] - 1
            local source = vRP.getUserSource(parseInt(k))
            if v <= 0 then
                print("RETIRAR DA PRISÃO")
            else
                vRP.setUData(parseInt(k),"vRP:prisao",json.encode(parseInt(prisoes[k])))
                if not source then
                    prisoes[k] = nil
                else
                    TriggerClientEvent("Notify",source,"importante","Sua pena diminui em 1 mês faltam "..prisoes[k].." meses")
                end
            end
        end

    end

    Citizen.CreateThread(function()
        task_save_prisoes()
    end)

    function mapreedev.Multar(nuser_id,price)
        print("MULTAR",nuser_id,price)
        local source = source
        local user_id = vRP.getUserId(source)
        local nsource = vRP.getUserSource(parseInt(nuser_id))
        if not nsource then
            TriggerClientEvent("Notify",source,"negado","Usuario inexistente ou offline")
            return {
                status = false
            }
        end

        MDTFunctions.AddInvoice(parseInt(nuser_id),parseInt(price))
        
        TriggerClientEvent("Notify",source,"sucesso","Player multado com sucesso")
        TriggerClientEvent("Notify",nsource,"sucesso","Você foi multado em $ "..price)

        return {
            status = true
        }
    end

    function mapreedev.LibertPlayer()
        local source = source
        local user_id = vRP.getUserId(source)
        local ped = GetPlayerPed(source)
        if prisoes[user_id] then
            prisoes[user_id] = nil
            TriggerClientEvent("novak_mdt:prender",source,false)
            TriggerClientEvent("News",-1,Config.mdt.newsTimer)
            local ExitCoords = Config.mdt.exitLocation
            SetEntityCoords(ped,ExitCoords[1],ExitCoords[2],ExitCoords[3])
        end
    end

    function mapreedev.TrashInv()
        local source = source
        local user_id = vRP.getUserId(source)
        local RandomItem = math.random(1,#Config.mdt.search.trashItens)
        MDTFunctions.GiveItem(user_id,Config.mdt.search.trashItens[RandomItem],1)
    end

    function mapreedev.SearchEmp(nuser_id)
        print("USER_ID",nuser_id)
        local user_id = vRP.getUserId(source)
        local nsource = vRP.getUserSource(parseInt(nuser_id))
        if not nsource then return TriggerClientEvent("Notify",source,"negado","Nenhum player com esse id encontrado") end

        local identity = vRP.getUserIdentity(parseInt(nuser_id))
        local gradeInfo = GetUserGrade(parseInt(nuser_id))

        local photo = vRP.query("mapreedev/GetMDTPhoto",{ user_id = parseInt(nuser_id) })
        if not photo[1] then 
            photo = nil
        else
            photo = photo[1].image_url
        end

        return {
            name = ""..identity.name.." "..identity.firstname.."",
            job = gradeInfo,
            photo = photo,
            user_id = parseInt(nuser_id)
        }
    end
    
end
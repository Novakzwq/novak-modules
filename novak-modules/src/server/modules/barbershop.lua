Modules.barbershop = {}

Modules.barbershop.initialized = false

Modules.barbershop.init = function()
    print("[BARBERSHOP] Initialized")

    function mapreedev.checkoutBarbershop(preco, custom)
        local source = source 
        local user_id = vRP.getUserId(source)
        if preco then 
            if vRP.tryPayment(user_id,parseInt(preco)) then
                vRP.setUData(user_id,"currentCharacterMode", custom)
                vCLIENT.successBuyBarbershop(source)
                TriggerClientEvent("Notify",source,"sucesso","Você pagou <b>R$"..preco.." reais</b>.",10000)
            else 
                vCLIENT.resetBuyBarbershop(source)	
                TriggerClientEvent("Notify",source,"negado","Você não possui dinheiro.",10000)			
            end		
        else 
            TriggerClientEvent("Notify",source,"negado","Ocorreu um Erro! Tente novamente.",10000)		
            vCLIENT.resetBuyBarbershop(source)
        end
    end

    Citizen.CreateThread(function()
        Wait(5000)
        for k,v in pairs(vRP.getUsers()) do
            TriggerEvent(Config.barbershop.event,k)
        end
    end)

    AddEventHandler(Config.barbershop.event, function(user_id)
        local player = vRP.getUserSource(user_id)
        if player then
            local value = vRP.getUData(user_id,"currentCharacterMode")
            if value ~= nil then
                local custom = json.decode(value) or {}
                vCLIENT.setCharacterBarbershop(player,custom)
            end
        end
    end)

end
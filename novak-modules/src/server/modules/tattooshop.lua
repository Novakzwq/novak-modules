Modules.tattooshop = {}

Modules.tattooshop.initialized = false

Modules.tattooshop.init = function()
    print("[TATTTOOSHOP] Initialized")

    function mapreedev.getTattooShops()
        return Config.tattooshop
    end
    
    function mapreedev.getTattoo()
        local source = source
    
        local user_id = vRP.getUserId(source)
    
        local custom = {}
    
        local data = vRP.getUData(user_id, "vRP:tattoos")
    
        if data ~= "" then
            custom = json.decode(data)
    
            vCLIENT.setTattoos(source, custom)
    
            Wait(100)
    
            vCLIENT.applyTatto(source)
        else
            vCLIENT.setTattoos(source, custom)
    
            Wait(100)
    
            vCLIENT.applyTatto(source)
        end
    end
    
    function mapreedev.payment(price, totalPrice, newTatto)
        local source = source
    
        local user_id = vRP.getUserId(source)
    
        if parseInt(price) == parseInt(totalPrice) then
            if vRP.tryPayment(user_id, parseInt(totalPrice)) then
            --if vRP.paymentBank(user_id,parseInt(totalPrice)) then
                TriggerClientEvent("Notify",source,"sucesso","Você pagou <b>$" .. totalPrice .. " dólares</b> em suas tatuagens.",5000)
    
                vRP.setUData(user_id, "vRP:tattoos", json.encode(newTatto))
    
                vCLIENT.payment(source, true)
            else
                TriggerClientEvent("Notify", source, "negado", "Você não tem dinheiro suficiente", 5000)
    
                vCLIENT.payment(source, false)
            end
        else
            TriggerClientEvent("Notify", source, "negado", "Ocorreu um erro na sua compra! Tente novamente!", 5000)
    
            vCLIENT.payment(source, false)
        end
    end
    
    AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
        local source = source

        if first_spawn then
            local custom = {}

            local data = vRP.getUData(user_id, "vRP:tattoos")

            if data ~= "" then
                custom = json.decode(data)

                vCLIENT.setTattoos(source, custom)

                Wait(100)

                vCLIENT.applyTatto(source)
            else
                vCLIENT.setTattoos(source, custom)

                Wait(100)

                vCLIENT.applyTatto(source)
            end
        end
    end)



end
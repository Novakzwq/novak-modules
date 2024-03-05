Modules.skinshop = {}

Modules.skinshop.initialized = false

Modules.skinshop.init = function()
    print("[SKINSHOP] Initialized")

    RegisterNetEvent("mapreedev:skinshop:buy")
    AddEventHandler("mapreedev:skinshop:buy",function(price)
        local source = source
        local user_id = vRP.getUserId(source)
        if vRP.tryFullPayment(user_id,parseInt(price)) then
            vCLIENT.finishBuySkinshop(source,true)
        else
            vCLIENT.finishBuySkinshop(source,false)
        end
    end)

end
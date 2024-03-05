MDTFunctions = {}

MDTFunctions.prepares = function()
    vRP._prepare("mapreedev/ChangeMDTPhoto","INSERT INTO `novak_mdt_profiles` (`user_id`,`image_url`) VALUE (@user_id, @url) ON DUPLICATE KEY UPDATE `image_url` = @url;")
    vRP._prepare("mapreedev/GetMDTPhoto","SELECT image_url FROM `novak_mdt_profiles` WHERE user_id = @user_id")
    vRP._prepare("mapreedev/InsertFicha","INSERT INTO `novak_mdt_ficha` (`user_id`,`data`) VALUE (@user_id, @data) ON DUPLICATE KEY UPDATE `data` = @data;")
    vRP._prepare("mapreedev/GetFicha","SELECT data FROM `novak_mdt_ficha` WHERE user_id = @user_id")
end

MDTFunctions.GetVehicles = function(user_id)
    return vRP.query("vRP/getVehicles",{ user_id = user_id })
end

MDTFunctions.SetDetido = function(user_id,vehicle,detido)
    return vRP.query("vRP/setDetido",{ detido = detido, user_id = user_id, vehicle = vehicle, ipva = os.time(), time = os.time() })
end

MDTFunctions.AddInvoice = function(user_id,value)
    local actualInvoices = vRP.getUData(parseInt(user_id),"vRP:multas")
    local invoicesA = json.decode(actualInvoices) or 0
    vRP.setUData(parseInt(user_id),"vRP:multas",json.encode(parseInt(invoicesA)+parseInt(value)))
end

MDTFunctions.GiveItem = function(user_id,itemName,itemAmount)
    return vRP.giveInventoryItem(user_id,itemName,itemAmount)
end
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
mapreedev = {}
Tunnel.bindInterface(GetCurrentResourceName(),mapreedev)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName());
Modules = {}

Citizen.CreateThread(function()
    for k,v in pairs(Config.scripts) do
        if v and Modules[k] then
            Modules[k].init();
        end
    end
end)


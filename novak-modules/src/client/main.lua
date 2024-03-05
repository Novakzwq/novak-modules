local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vSERVER = Tunnel.getInterface(GetCurrentResourceName())
mapree = {}
Tunnel.bindInterface(GetCurrentResourceName(),mapree)

Modules = {}

Citizen.CreateThread(function()
    for k,v in pairs(Config.scripts) do
        if v and Modules[k] then
            Modules[k].init();
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        InvalidateIdleCam()
        Citizen.Wait(1000)
    end
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end


local cam = nil
local newcam = nil

local camParts = {
    ["head"] = function()
        selectCamera(0.9,50.0)
    end,
    ["body"] = function()
        selectCamera(0.9,50.0,0.35)
    end,
    ["legs"] = function()
        selectCamera(1.15,52.5,1.00)
    end,
    ["shoes"] = function()
        selectCamera(0.9,50.0,1.5)
    end,
    ["all"] = function()
        selectCamera(2.15,62.5,0.5)
    end
}

RegisterNetEvent("mapreedev:cl_set_shops_cam")
AddEventHandler("mapreedev:cl_set_shops_cam", function(type)
    if not camParts[type] then return end
    camParts[type]()
end)    

RegisterNetEvent("mapreedev:cl_clear_cam")
AddEventHandler("mapreedev:cl_clear_cam", function()
    DeleteCam()
end)

function DeleteCam()
	SetCamActive(cam, false)
	RenderScriptCams(false, true, 0, true, true)
	cam = nil
end

RegisterCommand("cam", function(s,args,r)
    if args[1] == "close" then
        DeleteCam()
    elseif args[1] == "1" then -- MAIS PERTO (CABEÇA)
        selectCamera(0.9,50.0)
    elseif args[1] == '2' then -- torso
        -- print(math.abs(2.5+0.65-0.5))
        selectCamera(0.9,50.0,0.35)
    elseif args[1] == "3" then -- calca
        selectCamera(1.15,52.5,1.00)
    elseif args[1] == "4" then -- sapatos
        selectCamera(0.9,50.0,1.5)
    elseif args[1] == '0' then -- padrão vulgo mais longe
        selectCamera(2.15,62.5,0.5)
    end
end)

RegisterCommand("testcam",function(s,args,r)
    -- print(args[1],args[2])
    selectCamera(tonumber(args[1]), tonumber(args[2]))
end)

function selectCamera(param,focus,zdif,zdifmin)
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local camPos = GetOffsetFromEntityInWorldCoords(ped, 0.0, param, 0.0)
    if newcam then return end
    if not zdif then zdif = 0.00 end
    if not zdifmin then zdifmin = 0.00 end
	newcam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", camPos.x, camPos.y, ((camPos.z+0.65)-zdif), 0.00,0.00,0.00, focus, false, 0)
	PointCamAtCoord(newcam, pos.x, pos.y,((pos.z+0.65)-zdif))
	SetCamActiveWithInterp(newcam, cam, 1500, true, true)
	RenderScriptCams(true, false, 1, true, true)
	Citizen.Wait(1000)
	cam = newcam
    newcam = nil
end

RegisterNUICallback("selectCam", function(data,cb)
    if data.cam == "1" then -- MAIS PERTO (CABEÇA)
        selectCamera(0.9,50.0)
    elseif data.cam == '2' then -- torso
        selectCamera(0.9,50.0,0.35)
    elseif data.cam == "3" then -- calca
        selectCamera(1.15,52.5,1.00)
    elseif data.cam == "4" then -- sapatos
        selectCamera(0.9,50.0,1.5)
    elseif data.cam == '0' then -- padrão vulgo mais longe
        selectCamera(2.15,62.5,0.5)
    end
    -- TriggerEvent("mapreedev:cl_set_shops_cam",data.cam)
end)

RegisterNUICallback("rotateCharacter", function(data,cb)
    SetEntityHeading(PlayerPedId(),parseInt(data.heading)+0.00001)
    cb("ok")
end)

function f(n)
    n = n + 0.00000
    return n
end

function parse_part(key)
    if type(key) == "string" and string.sub(key, 1, 1) == "p" then
        return tonumber(string.sub(key, 2))
    else
        return false, tonumber(key)
    end
end
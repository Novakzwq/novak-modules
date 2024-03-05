Modules.photo = {}

Modules.photo.initialized = false

Modules.photo.init = function()
    print("[PHOTO] Initialized")

    RegisterServerEvent('TakePhoto')
    AddEventHandler('TakePhoto',function(path,fileName)
       
        exports[GetCurrentResourceName()]:recursiveMKDIR(path)
        if color then
            exports['screenshot-basic']:requestClientScreenshot(source, {
                fileName = path..""..fileName
            }, function(err, data)
            end)
        else
            exports['screenshot-basic']:requestClientScreenshot(source, {
                fileName = path..""..fileName
            }, function(err, data)
            end)
        end
     
    end)

end
----- FALLEN TREE EVENT -----
RegisterNetEvent("RandomEvents:FallenTree")
AddEventHandler("RandomEvents:FallenTree", function(coord)
    -- Log which event is happening
    print("Random Events - Fallen Tree")

    -- Get the tree string
    local objectName = "hei_prop_hei_tree_fallen_02"

    -- Radius of the event
    local radius = 1000.0
    
    -- Get random coordinate within radius
    local randomCoordinate = getRandomCoordinateNearPlayer(radius)

    -- Spawn the object
    EventObject = spawnObject(objectName, randomCoordinate)

    -- Draw a blip if enabled
    if Config.DrawBlips then
        EventBlip = AddBlipForCoord(randomCoordinate)
		SetBlipSprite(EventBlip, 836)
		SetBlipColour(EventBlip, 81)
		SetBlipScale(EventBlip, 1.0)
		SetBlipDisplay(EventBlip, 4)
		SetBlipAsShortRange(EventBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Fallen Tree")
		EndTextCommandSetBlipName(EventBlip)
        DrawRoute(randomCoordinate)
    end
    
    -- Check if the object was spawned successfully
    if EventObject ~= 0 then
        if Config.ShowNotification then
            InfoMessage("A tree has fallen in the roadway. Please respond and provide assistance")
        end
        if Config.EnableChatMessage then
            sendChatMessage("A tree has fallen in the roadway. Please respond and provide assistance")
        end
        FreezeEntityPosition(EventObject, true)
    else
        print("There was an error starting the event")
    end
end)

----- ROCKS IN ROAD EVENT -----
RegisterNetEvent("RandomEvent:DebrisInRoad")
AddEventHandler("RandomEvent:DebrisInRoad", function()
    -- Log which event is happening
    print("Random Events - Debris In Road")

    -- Get the tree string
    local objectName = "marina_xr_rocks_05"

    -- Radius of the event
    local radius = 1000.0
    
    -- Get random coordinate within radius
    local randomCoordinate = getRandomCoordinateNearPlayer(radius)

    -- Spawn the object
    EventObject = spawnObject(objectName, randomCoordinate)

    -- Draw a blip if enabled
    if Config.DrawBlips then
        EventBlip = AddBlipForCoord(randomCoordinate)
		SetBlipSprite(EventBlip, 801)
		SetBlipColour(EventBlip, 81)
		SetBlipScale(EventBlip, 1.0)
		SetBlipDisplay(EventBlip, 4)
		SetBlipAsShortRange(EventBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Debris")
		EndTextCommandSetBlipName(EventBlip)
        DrawRoute(randomCoordinate)
    end
    
    -- Check if the object was spawned successfully
    if EventObject ~= 0 then
        if Config.ShowNotification then
            InfoMessage("Some debris is in the roadway. Please respond and provide assistance")
        end
        if Config.EnableChatMessage then
            sendChatMessage("Some debris is in the roadway. Please respond and provide assistance")
        end
        FreezeEntityPosition(EventObject, true)
    else
        print("There was an error starting the event")
    end
end)

----- PALLETS IN ROAD EVENT -----
RegisterNetEvent("RandomEvent:PalletsInRoad")
AddEventHandler("RandomEvent:PalletsInRoad", function()
    -- Log which event is happening
    print("Random Events - Pallets In Road")

    -- Get the tree string
    local objectName = "prop_pallet_pile_01"

    -- Radius of the event
    local radius = 1000.0
    
    -- Get random coordinate within radius
    local randomCoordinate = getRandomCoordinateNearPlayer(radius)

    -- Spawn the object
    EventObject = spawnObject(objectName, randomCoordinate)

    -- Draw a blip if enabled
    if Config.DrawBlips then
        EventBlip = AddBlipForCoord(randomCoordinate)
		SetBlipSprite(EventBlip, 801)
		SetBlipColour(EventBlip, 81)
		SetBlipScale(EventBlip, 1.0)
		SetBlipDisplay(EventBlip, 4)
		SetBlipAsShortRange(EventBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Debris")
		EndTextCommandSetBlipName(EventBlip)
        DrawRoute(randomCoordinate)
    end
    
    -- Check if the object was spawned successfully
    if EventObject ~= 0 then
        if Config.ShowNotification then
            InfoMessage("Some pallets have been dropped in the roadway. Please respond and provide assistance")
        end
        if Config.EnableChatMessage then
            sendChatMessage("Some pallets have been dropped in the roadway. Please respond and provide assistance")
        end
        FreezeEntityPosition(EventObject, true)
    else
        print("There was an error starting the event")
    end
end)

----- STRANDED MOTORIST EVENT -----
RegisterNetEvent("RandomEvent:FlatTire")
AddEventHandler("RandomEvent:FlatTire", function()
    -- Log which event is happening
    print("Random Events - Vehicle with Flat Tire")

    -- Specify the vehicle model and spawn location
    local vehicleModel = "bison"
    
    -- Radius of the event
    local radius = 1000.0
    
    -- Get random coordinate within radius
    local spawnCoords = getRandomCoordinateNearPlayer(radius)
    
    -- Spawn the vehicle with a flat tire
    EventVehicle = spawnVehicleWithFlatTire(vehicleModel, spawnCoords)
    
    -- Spawn a driver near the vehicle
    EventPed = spawnDriverNearVehicle(EventVehicle, spawnCoords)

    -- Draw a blip if enabled
    if Config.DrawBlips then
        EventBlip = AddBlipForCoord(spawnCoords)
		SetBlipSprite(EventBlip, 883)
		SetBlipColour(EventBlip, 81)
		SetBlipScale(EventBlip, 1.0)
		SetBlipDisplay(EventBlip, 4)
		SetBlipAsShortRange(EventBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Stranded Motorist")
		EndTextCommandSetBlipName(EventBlip)
        DrawRoute()
    end
    
    -- Check if the object was spawned successfully
    if EventObject ~= 0 then
        if Config.ShowNotification then
            InfoMessage("A vehicle is stranded with a flat tire. Please respond and assist the motorist!")
        end
        if Config.EnableChatMessage then
            sendChatMessage("A vehicle is stranded with a flat tire. Please respond and assist the motorist!")
        end
        FreezeEntityPosition(EventObject, true)
    else
        print("There was an error starting the event")
    end
end)
function generateRandomEvent()
    local randomNumber = math.random(1, 4)

    if randomNumber == 1 then
        TriggerEvent("RandomEvents:FallenTree")
    elseif randomNumber == 2 then
        TriggerEvent("RandomEvent:DebrisInRoad")
    elseif randomNumber == 3 then
        TriggerEvent("RandomEvent:PalletsInRoad")
    elseif randomNumber == 4 then
        TriggerEvent("RandomEvent:FlatTire")
    end
end

function endRandomEvent()
    if DoesBlipExist(EventBlip) then
        RemoveBlip(EventBlip)
    end

    if DoesEntityExist(EventObject) then
        DeleteEntity(EventObject)
    end

    if DoesEntityExist(EventPed) then
        DeleteEntity(EventPed)
    end

    if DoesEntityExist(EventVehicle) then
        DeleteEntity(EventVehicle)
    end

    SetBlipRoute(EventBlip, false)

    IsEventActive = false
end

function spawnVehicleWithFlatTire(model, coords)
    -- Load the vehicle model
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(500)
    end

    -- Get heading
    local heading = GetEntityHeading(PlayerPedId())
    
    -- Create the vehicle
    local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, false)
    
    -- Apply a flat tire to a random wheel
    local tireIndex = math.random(0, 3) -- Randomly choose a tire index (0-3)
    SetVehicleTyreBurst(vehicle, 1, true, 1000.0) -- Burst the chosen tire
    
    return vehicle
end

function spawnDriverNearVehicle(vehicle, coords)
    local pedModelHash = GetHashKey("a_m_m_farmer_01")
    local ped = CreatePed(26, modelHash, coords.x, coords.y, coords.z, 0.0, true, false)
    TaskWarpPedIntoVehicle(ped, vehicle, -1)
    return ped
end

function getRandomCoordinateNearPlayer(radius)
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    
    -- Set a new random seed
    math.randomseed(GetGameTimer())
    
    -- Generate random offsets within the specified radius
    local offsetX = math.random(-radius, radius)
    local offsetY = math.random(-radius, radius)
    
    -- Calculate the new coordinates
    local newX = playerPos.x + offsetX
    local newY = playerPos.y + offsetY
    
    -- Ensure the new coordinates stay within the world bounds
    newX = math.min(math.max(newX, -3000.0), 3000.0)
    newY = math.min(math.max(newY, -3000.0), 3000.0)
    
    -- Get the closest road to the new coordinates
    local closestRoadCoords = getClosestRoad(vector3(newX, newY, playerPos.z))
    
    return closestRoadCoords
end

function getClosestRoad(coords)
    local _, closestRoad, _, _ = GetClosestRoad(coords.x, coords.y, coords.z, 1, 1)
    return closestRoad
end

function spawnObject(objectName, coords)
    local modelHash = GetHashKey(objectName)
    
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Citizen.Wait(0)
    end
    
    local object = CreateObject(modelHash, coords.x, coords.y, coords.z, true, true, true)
    SetModelAsNoLongerNeeded(modelHash)
    
    return object
end

function drawBlipForObject(object, blipname)
    local blip = AddBlipForEntity(object)
    
    SetBlipSprite(blip, 1) -- Set the blip sprite (1 = standard blip)
    SetBlipDisplay(blip, 4) -- Set the blip display (4 = show on both the minimap and the world map)
    SetBlipColour(blip, 1) -- Set the blip color (1 = white)
    SetBlipAsShortRange(blip, true) -- Set the blip as a short-range blip
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(blipname) -- Set the blip name
    EndTextCommandSetBlipName(blip)
    
    return blip
end

function DrawRoute()
    SetBlipRoute(EventBlip, true)
    SetBlipRouteColour(EventBlip, 47)
end

function ErrorMessage(errorMessage)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName('~r~[ERROR]~w~ ' .. errorMessage)
	DrawNotification(false, true)
end

function InfoMessage(message)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName('~y~[INFO]~w~ ' .. message)
	DrawNotification(false, true)
end

function SuccessMessage(successMessage)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName('~g~[SUCCESS]~w~ ' .. successMessage)
	DrawNotification(false, true)
end

function sendChatMessage(message)
	TriggerEvent("chatMessage", "", {0, 0, 0}, "^3[REPORT] ^2" .. message)
end

function sendChatMessageNormal(message)
	TriggerEvent("chatMessage", "", {0, 0, 0}, "^7" .. message)
end
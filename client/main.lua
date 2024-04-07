local AreRandomEventsEnabled = false
local IsEventActive = false
local EventObjects = {}
local EventObject = nil
local EventBlip = nil
local EventVehicle = nil
local EventPed = nil
local EventMinDelay = Config.DelayMinimum * 1000
local EventMaxDelay = Config.DelayMaximum * 1000

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if AreRandomEventsEnabled then
            local delay = math.random(EventMinDelay * 1000, EventMaxDelay * 1000)
            Citizen.Wait(delay)
            if not IsEventActive then
                generateRandomEvent()
                IsEventActive = true
            else
                print('Tried to start a random event but one is already active')
            end
        end
    end
end)

----- COMMANDS -----
RegisterCommand("++forcerandomevent", function(source, args)
    InfoMessage("Random event will start in ~b~5 seconds!")
    Citizen.Wait(5000)
    if not IsEventActive then
        generateRandomEvent()
        IsEventActive = true
    else
        print('Tried to start a random event but one is already active')
    end
end)

RegisterCommand("++endrandomevent", function(source, args)
	endRandomEvent()
    IsEventActive = false
    SuccessMessage("Random event has been ended!")
end)

RegisterCommand(Config.EnableEventsCommand, function()
    if AreRandomEventsEnabled then
        AreRandomEventsEnabled = false
        InfoMessage("Random events are now ~r~disabled")
    else
        AreRandomEventsEnabled = true
        InfoMessage("Random events are now ~g~enabled")
    end
end)
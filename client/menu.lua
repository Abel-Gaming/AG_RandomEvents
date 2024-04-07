local wasInitialized = false
local delayMin = { '300', '360', '420', '480', '540', '600' }
local delayMax = { '600', '900', '1200', '1500', '1800' }

local function uiThread()
	while true do
		if WarMenu.Begin('eventMenu') then
            
            -- Create toggle button in the main menu
            if WarMenu.CheckBox('Enable Random Events', state.isChecked) then
				state.isChecked = not state.isChecked

                if state.isChecked then
                    AreRandomEventsEnabled = true
                    InfoMessage("Random events are now ~g~enabled")
                else
                    AreRandomEventsEnabled = false
                    InfoMessage("Random events are now ~r~disabled")
                end
			end

            -- Create force event button
            if WarMenu.MenuButton('Force Random Event', 'eventMenu_admin') then
                InfoMessage("Random event will start in ~b~5 seconds!")
                Citizen.Wait(5000)
                if not IsEventActive then
                    generateRandomEvent()
                    IsEventActive = true
                    WarMenu.CloseMenu()
                else
                    print('Tried to start a random event but one is already active')
                end
            end

            -- Create button for event interaction
			WarMenu.MenuButton('Event Interaction', 'eventMenu_interaction')

            -- Create button for settings
            WarMenu.MenuButton('Settings', 'eventMenu_settings')

            --Create end event button
			WarMenu.MenuButton('~r~End Event', 'eventMenu_exit')
			
            -- Call END
            WarMenu.End()
		
        elseif WarMenu.Begin('eventMenu_interaction') then

            -- Clear scene button
            if WarMenu.MenuButton('Clear Scene', 'eventMenu_interaction') then
                if DoesEntityExist(EventObject) then
                    DeleteEntity(EventObject)
                    InfoMessage("The scene has been cleared. Be sure to end the current event when ready!")
                end
            end

            -- Remove ped button
            if WarMenu.MenuButton('Remove Ped', 'eventMenu_interaction') then
                if DoesEntityExist(EventPed) then
                    DeleteEntity(EventPed)
                    InfoMessage("The ped has been removed. Be sure to end the current event when ready!")
                end
            end

            -- Remove vehicle button
            if WarMenu.MenuButton('Remove Vehicle', 'eventMenu_interaction') then
                if DoesEntityExist(EventVehicle) then
                    DeleteEntity(EventVehicle)
                    InfoMessage("The vehicle has been removed. Be sure to end the current event when ready!")
                end
            end

			WarMenu.End()
		
        elseif WarMenu.Begin('eventMenu_exit') then
			
            if WarMenu.MenuButton('No', 'eventMenu') then
                InfoMessage("Random event was not ended!")
            end

            if WarMenu.MenuButton('~r~Yes', 'eventMenu') then
                if IsEventActive then
                    endRandomEvent()
                    IsEventActive = false
                    SuccessMessage("Random event has been ended!")
				    WarMenu.CloseMenu()
                else
                    ErrorMessage("There is no active event")
                end
			end

			WarMenu.End()

        elseif WarMenu.Begin('eventMenu_settings') then

            local ReadMeButton = WarMenu.Button('~r~Read Me', '')
			if WarMenu.IsItemHovered(ReadMeButton) then
				WarMenu.ToolTip('Random events must be disabled before changing these values!')
			end

            if state.currentMinIndex == nil then
                state.currentMinIndex = 1
            end
            
            if state.currentMaxIndex == nil then
                state.currentMaxIndex = 1
            end

            local delayMinButton, currentMinIndex = WarMenu.ComboBox('Minimum Delay (Seconds)', delayMin, state.currentMinIndex)
            state.currentMinIndex = currentMinIndex
            if delayMinButton then
                EventMinDelay = delayMin[currentMinIndex]
                print('New minimum delay: ' .. delayMin[currentMinIndex])
            end

            local delayMaxButton, currentMaxIndex = WarMenu.ComboBox('Maximum Delay (Seconds)', delayMax, state.currentMaxIndex)
            state.currentMaxIndex = currentMaxIndex
            if delayMaxButton then
                EventMaxDelay = delayMax[currentMaxIndex]
                print('New maximum delay: ' .. delayMax[currentMaxIndex])
            end

            WarMenu.MenuButton('~y~Force Specific Events', 'eventMenu_forceevents')

			WarMenu.End()

        elseif WarMenu.Begin('eventMenu_forceevents') then

            -- Fallen Tree
            if WarMenu.MenuButton('Fallen Tree', 'eventMenu_forceevents') then
                if not IsEventActive then
                    TriggerEvent("RandomEvents:FallenTree")
                    IsEventActive = true
                    WarMenu.CloseMenu()
                end
            end

            -- Debris In Road
            if WarMenu.MenuButton('Debris In Road', 'eventMenu_forceevents') then
                if not IsEventActive then
                    TriggerEvent("RandomEvent:DebrisInRoad")
                    IsEventActive = true
                    WarMenu.CloseMenu()
                end
            end

            -- Pallets In Road
            if WarMenu.MenuButton('Pallets In Road', 'eventMenu_forceevents') then
                if not IsEventActive then
                    TriggerEvent("RandomEvent:PalletsInRoad")
                    IsEventActive = true
                    WarMenu.CloseMenu()
                end
            end

            -- Vehicle with Flat Tire
            if WarMenu.MenuButton('Vehicle with Flat Tire', 'eventMenu_forceevents') then
                if not IsEventActive then
                    TriggerEvent("RandomEvent:FlatTire")
                    IsEventActive = true
                    WarMenu.CloseMenu()
                end
            end

			WarMenu.End()
		end

		Wait(0)
	end
end

RegisterCommand('RandomEventMenu', function()
	if WarMenu.IsAnyMenuOpened() then
		return
	end

	if not wasInitialized then
		WarMenu.CreateMenu('eventMenu', 'Random Events', 'Created by Abel Gaming')

		WarMenu.CreateSubMenu('eventMenu_interaction', 'eventMenu', 'Event Interaction') --CODE, MENU WHERE ITS DOCKED, SUBTITLE
		WarMenu.CreateSubMenu('eventMenu_exit', 'eventMenu', 'Are you sure?')
        WarMenu.CreateSubMenu('eventMenu_admin', 'eventMenu', 'Random Event Admin')
        WarMenu.CreateSubMenu('eventMenu_settings', 'eventMenu', 'Random Event Settings')
        WarMenu.CreateSubMenu('eventMenu_forceevents', 'eventMenu_settings', 'Force Random Events')

		Citizen.CreateThread(uiThread)
		wasInitialized = true
	end

	state = {
		useAltSprite = false,
		isChecked = false,
		currentIndex = 1
	}

	WarMenu.OpenMenu('eventMenu')
end)
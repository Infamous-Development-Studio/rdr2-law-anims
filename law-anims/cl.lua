local huk = false
RegisterCommand("huk", function(s, a)
    local ped = PlayerPedId()
    if huk == false then
        huk = true
        loadAnimDict("mech_busted@unapproved")
        TaskPlayAnim(PlayerPedId(), "mech_busted@unapproved", "idle_2_hands_up", 3.0, -1, -1, 0, 0, false, false, false)
        Wait(100)
        while IsEntityPlayingAnim(ped, "mech_busted@unapproved", "idle_2_hands_up", 3) do
            Wait(0)
        end
        StopAnimTask(ped, "mech_busted@unapproved", "idle_2_hands_up", 1.0)
        TaskPlayAnim(ped, "mech_busted@unapproved", "idle_b", 3.0, -1, -1, 1, 0, false, false, false)
    else
        huk = false
        loadAnimDict("mech_busted@unapproved")
        StopAnimTask(ped, "mech_busted@unapproved", "idle_b", 1.0)
        Wait(100)
        TaskPlayAnim(ped, "mech_busted@unapproved", "hands_up_2_idle", 3.0, 3.0, -1, 0, 0, false, false, false)
    end
end)

local hu = false
RegisterCommand("hu", function(s, a)
    local ped = PlayerPedId()
    if hu == false then
        hu = true
        loadAnimDict("mech_busted@arrest")
        TaskPlayAnim(ped, "mech_busted@arrest", "hands_up_transition", 3.0, -1, -1, 0, 0, false, false, false)
        Wait(100)
        while IsEntityPlayingAnim(ped, "mech_busted@arrest", "hands_up_transition", 3) do
            Wait(0)
        end
        StopAnimTask(ped, "mech_busted@arrest", "hands_up_transition", 1.0)
        TaskPlayAnim(ped, "mech_busted@arrest", "hands_up_loop", 3.0, -1, -1, 1, 0, false, false, false)
    else
        hu = false
        StopAnimTask(ped, "mech_busted@arrest", "hands_up_loop", 1.0)
        ClearPedTasksImmediately(ped)
        Wait(150)
        StopAnimTask(PlayerPedId(), 1.0)
        ClearPedTasksImmediately(PlayerPedId())
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustPressed(0, 0x43CDA5B0) then
            loadAnimDict("mech_busted@unapproved")
            TaskPlayAnim(PlayerPedId(), "mech_busted@unapproved", "reach_weapon", 3.0, -1, -1, 0, 0, false, false, false)
        elseif IsControlJustReleased(0, 0x43CDA5B0) then
            StopAnimTask(PlayerPedId(), "mech_busted@unapproved", "reach_weapon", 1.0)
        end
    end
end)

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
end
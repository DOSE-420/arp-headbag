ARPCore = nil
local HaveBagOnHead = false

Citizen.CreateThread(function()
	while ARPCore == nil do
		TriggerEvent('ARPCore:GetObject', function(obj) ARPCore = obj end)
		Citizen.Wait(0)
	end
end)

function NajblizszyGracz() --This function send to server closestplayer

local closestPlayer, closestDistance = ARPCore.Functions.GetClosestPlayer()
local player = GetPlayerPed(-1)

if closestPlayer == -1 or closestDistance > 2.0 then 
  ARPCore.Functions.Notify("No one nearby.", "primary")
else
  if not HaveBagOnHead then
    TriggerServerEvent('arp-headbag:sendclosest', GetPlayerServerId(closestPlayer))
    ARPCore.Functions.Notify("You used a headbag.", "primary")
    TriggerServerEvent('arp-headbag:closest')
  else
    ARPCore.Functions.Notify("This person already have a bag on their head.", "primary")
  end
end

end

RegisterNetEvent('arp-headbag:naloz') --This event open menu
AddEventHandler('arp-headbag:naloz', function()
  NajblizszyGracz()
end)

RegisterNetEvent('arp-headbag:nalozNa') --This event put head bag on nearest player
AddEventHandler('arp-headbag:nalozNa', function(gracz)
    local playerPed = GetPlayerPed(-1)
    Worek = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true) -- Create head bag object!
    AttachEntityToEntity(Worek, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- Attach object to head
    SetNuiFocus(false,false)
    SendNUIMessage({type = 'openGeneral'})
    HaveBagOnHead = true
end)    

AddEventHandler('playerSpawned', function() --This event delete head bag when player is spawn again
DeleteEntity(Worek)
SetEntityAsNoLongerNeeded(Worek)
SendNUIMessage({type = 'closeAll'})
HaveBagOnHead = false
end)

RegisterNetEvent('arp-headbag:zdejmijc') --This event delete head bag from player head
AddEventHandler('arp-headbag:zdejmijc', function(gracz)
  DeleteEntity(Worek)
    SetEntityAsNoLongerNeeded(Worek)
    SendNUIMessage({type = 'closeAll'})
    HaveBagOnHead = false
    print("dose")
end)

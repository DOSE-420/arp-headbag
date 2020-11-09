ARPCore = nil

TriggerEvent('ARPCore:GetObject', function(obj) ARPCore = obj end)

RegisterServerEvent('arp-headbag:closest')
AddEventHandler('arp-headbag:closest', function()
    TriggerClientEvent('arp-headbag:puton', najblizszy)
end)

RegisterServerEvent('arp-headbag:sendclosest')
AddEventHandler('arp-headbag:sendclosest', function(closestPlayer)
    najblizszy = closestPlayer
end)

RegisterServerEvent('arp-headbag:shit')
AddEventHandler('arp-headbag:shit', function()
    TriggerClientEvent('arp-headbag:takeoff', najblizszy)
end)

ARPCore.Commands.Add("bagoff", "Remove the headbag.", {}, true, function(source, args)
	local Player = ARPCore.Functions.GetPlayer(source)
    TriggerClientEvent("arp-headbag:takeoff", source)
end)

ARPCore.Functions.CreateCallback('arp-headbag:itemCheck', function(source, cb )
    local Player = ARPCore.Functions.GetPlayerFromId(src)
    local item   = Player.GetInventoryItem('headbag').count
    if item > 0 then
      cb(true)
      Player.RemoveInventoryItem('headbag', 1)
    else
      cb(false)
    end
  end)

local ESX 				= nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local YachtHeist 		= Config.Yacht

AddEventHandler('esx:playerLoaded', function(source)
    TriggerClientEvent('esx_YachtHeist:load', source, YachtHeist)
end)

RegisterServerEvent('esx_YachtHeist:refreshHeist')
AddEventHandler('esx_YachtHeist:refreshHeist', function()
    TriggerClientEvent('esx_YachtHeist:load', -1, YachtHeist)
end)

RegisterServerEvent('esx_YachtHeist:goonsSpawned')
AddEventHandler('esx_YachtHeist:goonsSpawned', function(id, status)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].GoonsSpawned=status
        TriggerClientEvent('esx_YachtHeist:statusGoonsSpawnedSend', -1, YachtHeist[id].pairs, status)
    end
    YachtHeist[id].GoonsSpawned=status
    TriggerClientEvent('esx_YachtHeist:statusGoonsSpawnedSend', -1, id, status)
end)

RegisterServerEvent('esx_YachtHeist:JobPlayer')
AddEventHandler('esx_YachtHeist:JobPlayer', function(id, status)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].JobPlayer=status
        TriggerClientEvent('esx_YachtHeist:statusJobPlayerSend', -1, YachtHeist[id].pairs, status)
    end
    YachtHeist[id].JobPlayer=status
    TriggerClientEvent('esx_YachtHeist:statusJobPlayerSend', -1, id, status)
end)

RegisterServerEvent('esx_YachtHeist:status')
AddEventHandler('esx_YachtHeist:status', function(id, status)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].started=status
        TriggerClientEvent('esx_YachtHeist:statusSend', -1, YachtHeist[id].pairs, status)
    end
    YachtHeist[id].started=status
    TriggerClientEvent('esx_YachtHeist:statusSend', -1, id, status)
end)

local policeOnline

ESX.RegisterServerCallback("esx_YachtHeist:GetPoliceOnline",function(source,cb)
	local Players = ESX.GetPlayers()
	policeOnline = 0
	for i = 1, #Players do
		local xPlayer = ESX.GetPlayerFromId(Players[i])
		if xPlayer["job"]["name"] == "police" then
			policeOnline = policeOnline + 1
		end
	end
	if policeOnline >= Config.RequiredPolice then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('esx_YachtHeist:statusHack')
AddEventHandler('esx_YachtHeist:statusHack', function(id, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].keypadHacked=state
        TriggerClientEvent('esx_YachtHeist:statusHackSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].keypadHacked=state
    TriggerClientEvent('esx_YachtHeist:statusHackSend', -1, id, state)
end)

RegisterServerEvent('esx_YachtHeist:currentlyHacking')
AddEventHandler('esx_YachtHeist:currentlyHacking', function(id, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].currentlyHacking=state
        TriggerClientEvent('esx_YachtHeist:statusCurrentlyHackingSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].currentlyHacking=state
    TriggerClientEvent('esx_YachtHeist:statusCurrentlyHackingSend', -1, id, state)
end)

RegisterServerEvent('esx_YachtHeist:statusVault')
AddEventHandler('esx_YachtHeist:statusVault', function(id, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].vaultLocked=state
        TriggerClientEvent('esx_YachtHeist:statusVaultSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].vaultLocked=state
    TriggerClientEvent('esx_YachtHeist:statusVaultSend', -1, id, state)
end)

RegisterServerEvent('esx_YachtHeist:HeistIsBeingReset')
AddEventHandler('esx_YachtHeist:HeistIsBeingReset', function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
	-- started:
	YachtHeist[id].started=false
    TriggerClientEvent('esx_YachtHeist:statusSend', -1, id, false)
	Citizen.Wait(1000)
	-- hacked:
    YachtHeist[id].keypadHacked=false
    TriggerClientEvent('esx_YachtHeist:statusHackSend', -1, id, false)
	-- currently hacking:
    YachtHeist[id].currentlyHacking=false
    TriggerClientEvent('esx_YachtHeist:statusCurrentlyHackingSend', -1, id, false)
	-- vault:
    YachtHeist[id].vaultLocked=true
    TriggerClientEvent('esx_YachtHeist:statusVaultSend', -1, id, true)
	-- safe:
    YachtHeist[id].safeRobbed=false
    TriggerClientEvent('esx_YachtHeist:statusSafeRobbedSend', -1, id, false)
	-- drilling:
    YachtHeist[id].drilling=false
    TriggerClientEvent('esx_YachtHeist:statusDrillingSend', -1, id, false)
	-- cashTaken:
    YachtHeist[id].cashTaken=false
    TriggerClientEvent('esx_YachtHeist:statusCashTakenSend', -1, id, false)
	-- stealing:
    YachtHeist[id].stealing=false
    TriggerClientEvent('esx_YachtHeist:statusStealingSend', -1, id, false)
	-- GoonsSpawned:
    YachtHeist[id].GoonsSpawned=false
    TriggerClientEvent('esx_YachtHeist:statusGoonsSpawnedSend', -1, id, false)
	-- JobPlayer:
    YachtHeist[id].JobPlayer=status
    TriggerClientEvent('esx_YachtHeist:statusJobPlayerSend', -1, id, status)
end)

RegisterServerEvent('esx_YachtHeist:drilling')
AddEventHandler('esx_YachtHeist:drilling', function(id, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].drilling=state
        TriggerClientEvent('esx_YachtHeist:statusDrillingSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].drilling=state
    TriggerClientEvent('esx_YachtHeist:statusDrillingSend', -1, id, state)
end)

RegisterServerEvent('esx_YachtHeist:stealing')
AddEventHandler('esx_YachtHeist:stealing', function(id, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].stealing=state
        TriggerClientEvent('esx_YachtHeist:statusStealingSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].stealing=state
    TriggerClientEvent('esx_YachtHeist:statusStealingSend', -1, id, state)
end)

RegisterServerEvent('esx_YachtHeist:cashTaken')
AddEventHandler('esx_YachtHeist:cashTaken', function(id, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].cashTaken=state
        TriggerClientEvent('esx_YachtHeist:statusCashTakenSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].cashTaken=state
    TriggerClientEvent('esx_YachtHeist:statusCashTakenSend', -1, id, state)
end)

RegisterServerEvent('esx_YachtHeist:safeRobbed')
AddEventHandler('esx_YachtHeist:safeRobbed', function(id, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].safeRobbed=state
        TriggerClientEvent('esx_YachtHeist:statusSafeRobbedSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].safeRobbed=state
    TriggerClientEvent('esx_YachtHeist:statusSafeRobbedSend', -1, id, state)
	if policeOnline > 5 then
		policeReward = 5
	else
		policeReward = policeOnline
	end
	-- cash reward:
	local cashReward = ((math.random(10,15) * 1500) * policeReward)
	xPlayer.addMoney(cashReward)
	-- item reward:
	local itemReward = ((math.random(10,15) * 10) * policeReward)
	local item = "goldwatch"
	local itemName = ESX.GetItemLabel(item)
	xPlayer.addInventoryItem(item,itemReward)
end)

ESX.RegisterServerCallback("esx_YachtHeist:updateCashTaken",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if policeOnline > 5 then
		policeReward = 5
	else
		policeReward = policeOnline
	end
	if xPlayer then
		local randomMoney = ((math.random(3, 6) * 100) * policeReward)
		xPlayer.addMoney(randomMoney)
		cb(randomMoney)
	end
end)


--------------------------------
------- Created by Hamza -------
-------------------------------- 

ESX = nil

local PlayerHackTimer = {}
local PlayerDrugsTimer = {}
local PlayerConvertTimer = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("esx_newDrugs:startHackTimer")
AddEventHandler("esx_newDrugs:startHackTimer",function(source)
	table.insert(PlayerHackTimer,{started = GetPlayerIdentifier(source), time = 1800000}) -- cooldown timer for using USB stick
end)

RegisterServerEvent("esx_newDrugs:startDrugsTimer") 
AddEventHandler("esx_newDrugs:startDrugsTimer",function(source)
	table.insert(PlayerDrugsTimer,{startedDrugs = GetPlayerIdentifier(source), timeDrugs = 30000}) -- do not touch this
end)

RegisterServerEvent("esx_newDrugs:startConvertTimer")
AddEventHandler("esx_newDrugs:startConvertTimer",function(source)
	table.insert(PlayerConvertTimer,{startedConvert = GetPlayerIdentifier(source), timeConvert = 15000}) -- do not touch this
end)

Citizen.CreateThread(function() -- do not touch this thread function!
	while true do
	Citizen.Wait(1000)
		for k,v in pairs(PlayerHackTimer) do
			if v.time <= 0 then
				RemoveStarted(v.started)
			else
				v.time = v.time - 1000
			end
		end
		for k,v in pairs(PlayerDrugsTimer) do
			if v.timeDrugs <= 0 then
				RemoveStartedDrugs(v.startedDrugs)
			else
				v.timeDrugs = v.timeDrugs - 1000
			end
		end
		for k,v in pairs(PlayerConvertTimer) do
			if v.timeConvert <= 0 then
				RemoveStartedConvert(v.startedConvert)
			else
				v.timeConvert = v.timeConvert - 1000
			end
		end
	end
end)

-- // ## DRUGS MISSIONS ## // --

RegisterServerEvent("esx_newDrugs:reward")
AddEventHandler("esx_newDrugs:reward",function(amount,typed)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(typed.."brick",math.ceil(amount))
end)

RegisterServerEvent("esx_newDrugs:syncMissionData")
AddEventHandler("esx_newDrugs:syncMissionData",function(data)
	TriggerClientEvent("esx_newDrugs:syncMissionData",-1,data)
end)

ESX.RegisterUsableItem('methburn', function(source)
	if not CheckedStarted(GetPlayerIdentifier(source)) then
		TriggerEvent("esx_newDrugs:startHackTimer",source)
		TriggerClientEvent("esx_newDrugs:UsableItem",source)
		Citizen.Wait(8000)
		TriggerClientEvent("esx_newDrugs:HackingMiniGame",source)
			
		ESX.RegisterServerCallback("esx_newDrugs:StartMissionNow",function(source,cb)
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			cb()
			TriggerClientEvent("esx_newDrugs:startMission",source,0,"meth")
		end)
		
 	else
	 	TriggerClientEvent("esx:showNotification",source,string.format("You can ~y~hack~s~ the network again in: ~b~%s minutes~s~",GetTimeForMission(GetPlayerIdentifier(source))))
  	end
end)

ESX.RegisterUsableItem('cokeburn', function(source)
	if not CheckedStarted(GetPlayerIdentifier(source)) then
		TriggerEvent("esx_newDrugs:startHackTimer",source)
		TriggerClientEvent("esx_newDrugs:UsableItem",source)
		Citizen.Wait(8000)
		TriggerClientEvent("esx_newDrugs:HackingMiniGame",source)
		
		ESX.RegisterServerCallback("esx_newDrugs:StartMissionNow",function(source,cb)
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			cb()
			TriggerClientEvent("esx_newDrugs:startMission",source,0,"coke")
		end)
		
 	else
	 	TriggerClientEvent("esx:showNotification",source,string.format("You can ~y~hack~s~ the network again in: ~b~%s minutes~s~",GetTimeForMission(GetPlayerIdentifier(source))))
  	end
end)

ESX.RegisterUsableItem('weedburn', function(source)
	if not CheckedStarted(GetPlayerIdentifier(source)) then
		TriggerEvent("esx_newDrugs:startHackTimer",source)
		TriggerClientEvent("esx_newDrugs:UsableItem",source)
		Citizen.Wait(8000)
		TriggerClientEvent("esx_newDrugs:HackingMiniGame",source)
		
		ESX.RegisterServerCallback("esx_newDrugs:StartMissionNow",function(source,cb)
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			cb()
			TriggerClientEvent("esx_newDrugs:startMission",source,0,"weed")
		end)
	
	else
	 	TriggerClientEvent("esx:showNotification",source,string.format("You can ~y~hack~s~ the network again in: ~b~%s minutes~s~",GetTimeForMission(GetPlayerIdentifier(source))))
	end
end)

-- // ## DRUGS EFFECT ## // --

ESX.RegisterUsableItem('meth1g', function(source)
	if not CheckedStartedDrugs(GetPlayerIdentifier(source)) then
	TriggerEvent("esx_newDrugs:startDrugsTimer",source)
	TriggerClientEvent("esx_drugs:activate_meth",source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem("meth1g",1)
	else
	 	TriggerClientEvent("esx:showNotification",source,string.format("You can ~r~consume~s~ another ~y~drug~s~ in: ~b~%s seconds~s~",GetTimeForDrugs(GetPlayerIdentifier(source))))
	end
end)

ESX.RegisterUsableItem('coke1g', function(source)
	if not CheckedStartedDrugs(GetPlayerIdentifier(source)) then
	TriggerEvent("esx_newDrugs:startDrugsTimer",source)
	TriggerClientEvent("esx_drugs:activate_coke",source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem("coke1g",1)
	else
	 	TriggerClientEvent("esx:showNotification",source,string.format("You can ~r~consume~s~ another ~y~drug~s~ in: ~b~%s seconds~s~",GetTimeForDrugs(GetPlayerIdentifier(source))))
	end
end)

ESX.RegisterUsableItem('joint2g', function(source)
	if not CheckedStartedDrugs(GetPlayerIdentifier(source)) then
	TriggerEvent("esx_newDrugs:startDrugsTimer",source)
	TriggerClientEvent("esx_drugs:activate_weed",source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem("joint2g",1)
	else
	 	TriggerClientEvent("esx:showNotification",source,string.format("You can ~r~consume~s~ another ~y~drug~s~ in: ~b~%s seconds~s~",GetTimeForDrugs(GetPlayerIdentifier(source))))
	end
end)

-- // ## DRUGS CONVERSION ## // --

-- COKE BRICK >> COKE (10G)
ESX.RegisterUsableItem('cokebrick', function(source)
		
	local xPlayer = ESX.GetPlayerFromId(source)
	local brick = xPlayer.getInventoryItem("cokebrick").count >= 1
	local scale = xPlayer.getInventoryItem("hqscale").count >= 1
	local bags = xPlayer.getInventoryItem("drugbags").count >= 10
	
	if not bags or not brick then
		if not bags then
			TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~y~bags~s~")
		else
			TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~y~Cocaine Bricks~s~")
		end
		return
	end
	
	local maxCokeOutput = 10
		
	if not scale then
		maxCokeOutput = 6
	end

	if xPlayer.getInventoryItem("coke10g").count <= 40 or (not scale and xPlayer.getInventoryItem("coke10g").count <= 44) then
		if not CheckedStartedConvert(GetPlayerIdentifier(source)) then
			TriggerEvent("esx_newDrugs:startConvertTimer",source)
					
			xPlayer.removeInventoryItem("cokebrick",1)
			xPlayer.removeInventoryItem("drugbags",10)
		
			TriggerClientEvent("BrickToCoke10g",source)
			Citizen.Wait(15000)
		
			xPlayer.addInventoryItem("coke10g",maxCokeOutput)
		else
			TriggerClientEvent("esx:showNotification",source,string.format("You are ~b~already engaged~s~ in a ~y~process~s~!",GetTimeForConvert(GetPlayerIdentifier(source))))
		end
	else
		TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~b~empty space~s~ for more ~y~Cocaine (10G)~s~")
	end
end)

-- METH BRICK >> METH (10G)
ESX.RegisterUsableItem('methbrick', function(source)
		
	local xPlayer = ESX.GetPlayerFromId(source)
	local brick = xPlayer.getInventoryItem("methbrick").count >= 1
	local scale = xPlayer.getInventoryItem("hqscale").count >= 1
	local bags = xPlayer.getInventoryItem("drugbags").count >= 10
	
	if not bags or not brick then
		if not bags then
			TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~y~bags~s~")
		else
			TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~y~Meth Bricks~s~")
		end
		return
	end
	
	local maxMethOutput = 10
		
	if not scale then
		maxMethOutput = 6
	end
	
	if xPlayer.getInventoryItem("meth10g").count <= 40 or (not scale and xPlayer.getInventoryItem("meth10g").count <= 44) then
		if not CheckedStartedConvert(GetPlayerIdentifier(source)) then
			TriggerEvent("esx_newDrugs:startConvertTimer",source)
		
			xPlayer.removeInventoryItem("methbrick",1)
			xPlayer.removeInventoryItem("drugbags",10)
		
			TriggerClientEvent("BrickToMeth10g",source)
			Citizen.Wait(15000)
		
			xPlayer.addInventoryItem("meth10g",maxMethOutput)
		else
			TriggerClientEvent("esx:showNotification",source,string.format("You are ~b~already engaged~s~ in a ~y~process~s~!",GetTimeForConvert(GetPlayerIdentifier(source))))
		end
	else
		TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~b~empty space~s~ for more ~y~Meth (10G)~s~")
	end
end)

-- WEED BRICK >> WEED (20G)
ESX.RegisterUsableItem('weedbrick', function(source)
		
	local xPlayer = ESX.GetPlayerFromId(source)
	local brick = xPlayer.getInventoryItem("weedbrick").count >= 1
	local scale = xPlayer.getInventoryItem("hqscale").count >= 1
	local bags = xPlayer.getInventoryItem("drugbags").count >= 10
	
	if not bags or not brick then
		if not bags then
			TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~y~bags~s~")
		else
			TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~y~Weed Bricks~s~")
		end
		return
	end
	
	local maxWeedOutput = 10
		
	if not scale then
		maxWeedOutput = 8
	end
	
	if xPlayer.getInventoryItem("weed20g").count <= 90 or (not scale and xPlayer.getInventoryItem("weed20g").count <= 92) then
		if not CheckedStartedConvert(GetPlayerIdentifier(source)) then
			TriggerEvent("esx_newDrugs:startConvertTimer",source)
		
			xPlayer.removeInventoryItem("weedbrick",1)
			xPlayer.removeInventoryItem("drugbags",10)
		
			TriggerClientEvent("BrickToWeed20g",source)
			Citizen.Wait(15000)
		
			xPlayer.addInventoryItem("weed20g",maxWeedOutput)
		else
			TriggerClientEvent("esx:showNotification",source,string.format("You are ~b~already engaged~s~ in a ~y~process~s~!",GetTimeForConvert(GetPlayerIdentifier(source))))
		end
	else
		TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~b~empty space~s~ for more ~y~Weed (20G)~s~")
	end
end)

-- COKE (10G) >> COKE (1G)
ESX.RegisterUsableItem('coke10g', function(source)
		
	local xPlayer = ESX.GetPlayerFromId(source)
	local coke = xPlayer.getInventoryItem("coke10g").count >= 1
	local scale = xPlayer.getInventoryItem("hqscale").count >= 1
	local bags = xPlayer.getInventoryItem("drugbags").count >= 10
	
	if not bags or not coke then
		if not bags then
			TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~y~bags~s~")
		else
			TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~y~Cocaine (10G)~s~")
		end
		return
	end
	
	local maxCoke1gOutput = 10
		
	if not scale then
		maxCoke1gOutput = 6
	end
	
	if xPlayer.getInventoryItem("coke1g").count <= 40 or (not scale and xPlayer.getInventoryItem("coke1g").count <= 44) then
		if not CheckedStartedConvert(GetPlayerIdentifier(source)) then
			TriggerEvent("esx_newDrugs:startConvertTimer",source)
		
			xPlayer.removeInventoryItem("coke10g",1)
			xPlayer.removeInventoryItem("drugbags",10)
		
			TriggerClientEvent("Coke10gToCoke1g",source)
			Citizen.Wait(15000)
		
			xPlayer.addInventoryItem("coke1g",maxCoke1gOutput)
		else
			TriggerClientEvent("esx:showNotification",source,string.format("You are ~b~already engaged~s~ in a ~y~process~s~!",GetTimeForConvert(GetPlayerIdentifier(source))))
		end
	else
		TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~b~empty space~s~ for more ~y~Cocaine (1G)~s~")
	end
end)

-- METH (10G) >> METH (1G)
ESX.RegisterUsableItem('meth10g', function(source)
		
	local xPlayer = ESX.GetPlayerFromId(source)
	local meth = xPlayer.getInventoryItem("meth10g").count >= 1
	local scale = xPlayer.getInventoryItem("hqscale").count >= 1
	local bags = xPlayer.getInventoryItem("drugbags").count >= 10
	
	if not bags or not meth then
		if not bags then
			TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~y~bags~s~")
		else
			TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~y~Meth (10G)~s~")
		end
		return
	end
	
	local maxMeth1gOutput = 10
		
	if not scale then
		maxMeth1gOutput = 6
	end
	
	if xPlayer.getInventoryItem("meth1g").count <= 40 or (not scale and xPlayer.getInventoryItem("meth1g").count <= 44) then
		if not CheckedStartedConvert(GetPlayerIdentifier(source)) then
			TriggerEvent("esx_newDrugs:startConvertTimer",source)
		
			xPlayer.removeInventoryItem("meth10g",1)
			xPlayer.removeInventoryItem("drugbags",10)
		
			TriggerClientEvent("Meth10gToMeth1g",source)
			Citizen.Wait(15000)
		
			xPlayer.addInventoryItem("meth1g",maxMeth1gOutput)
		else
			TriggerClientEvent("esx:showNotification",source,string.format("You are ~b~already engaged~s~ in a ~y~process~s~!",GetTimeForConvert(GetPlayerIdentifier(source))))
		end
	else
		TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~b~empty space~s~ for more ~y~Meth (1G)~s~")
	end
end)

-- WEED (20G) >> WEED (4G)
ESX.RegisterUsableItem('weed20g', function(source)
		
	local xPlayer = ESX.GetPlayerFromId(source)
	local weedBag = xPlayer.getInventoryItem("weed20g").count >= 1
	local scale = xPlayer.getInventoryItem("hqscale").count >= 1
	local bags = xPlayer.getInventoryItem("drugbags").count >= 5
	
	if not bags or not weedBag then
		if not bags then
			TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~y~bags~s~")
		else
			TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~y~Weed (20G)~s~")
		end
		return
	end
	
	local maxWeedBagOutput = 5
		
	if not scale then
		maxWeedBagOutput = 4
	end
	
	if xPlayer.getInventoryItem("weed4g").count <= 195 or (not scale and xPlayer.getInventoryItem("weed4g").count <= 196) then
		if not CheckedStartedConvert(GetPlayerIdentifier(source)) then
			TriggerEvent("esx_newDrugs:startConvertTimer",source)
		
			xPlayer.removeInventoryItem("weed20g",1)
			xPlayer.removeInventoryItem("drugbags",5)
		
			TriggerClientEvent("Weed20gToWeed4g",source)
			Citizen.Wait(15000)
		
			xPlayer.addInventoryItem("weed4g",maxWeedBagOutput)
		else
			TriggerClientEvent("esx:showNotification",source,string.format("You are ~b~already engaged~s~ in a ~y~process~s~!",GetTimeForConvert(GetPlayerIdentifier(source))))
		end
	else
		TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~b~empty space~s~ for more ~y~Weed (4G)~s~")
	end
end)

-- WEED (4G) >> JOINT (2G)
ESX.RegisterUsableItem('weed4g', function(source)
		
	local xPlayer = ESX.GetPlayerFromId(source)
	local weed = xPlayer.getInventoryItem("weed4g").count >= 1
	local paper = xPlayer.getInventoryItem("rolpaper").count >= 2
	
	if not paper or not weed then
		if not paper then
			TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~y~rolling paper~s~")
		else
			TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~y~Weed (4G)~s~")
		end
		return
	end
	
	if xPlayer.getInventoryItem("joint2g").count <= 48 then
		if not CheckedStartedConvert(GetPlayerIdentifier(source)) then
			TriggerEvent("esx_newDrugs:startConvertTimer",source)
		
			xPlayer.removeInventoryItem("weed4g",1)
			xPlayer.removeInventoryItem("rolpaper",2)
		
			TriggerClientEvent("Weed4gToJoint2g",source)
			Citizen.Wait(15000)
		
			xPlayer.addInventoryItem("joint2g",2)
		else
			TriggerClientEvent("esx:showNotification",source,string.format("You are ~b~already engaged~s~ in a ~y~process~s~!",GetTimeForConvert(GetPlayerIdentifier(source))))
		end
	else
		TriggerClientEvent("esx:showNotification",source,"You ~r~do not have~s~ enough ~b~empty space~s~ for more ~y~Joint (2G)~s~")
	end
end)

-- // ## TIMERS ## // --

-- DO NOT TOUCH!!
function RemoveStarted(source)
	for k,v in pairs(PlayerHackTimer) do
		if v.started == source then
			table.remove(PlayerHackTimer,k)
		end
	end
end
-- DO NOT TOUCH!!
function GetTimeForMission(source)
	for k,v in pairs(PlayerHackTimer) do
		if v.started == source then
			return math.ceil(v.time/60000)
		end
	end
end
-- DO NOT TOUCH!!
function CheckedStarted(source)
	for k,v in pairs(PlayerHackTimer) do
		if v.started == source then
			return true
		end
	end
	return false
end

-- USABLE DRUGS EFFECTS TIMER
-- DO NOT TOUCH!!
function RemoveStartedDrugs(source)
	for k,v in pairs(PlayerDrugsTimer) do
		if v.startedDrugs == source then
			table.remove(PlayerDrugsTimer,k)
		end
	end
end
-- DO NOT TOUCH!!
function GetTimeForDrugs(source)
	for k,v in pairs(PlayerDrugsTimer) do
		if v.startedDrugs == source then
			return math.ceil(v.timeDrugs/1000)
		end
	end
end
-- DO NOT TOUCH!!
function CheckedStartedDrugs(source)
	for k,v in pairs(PlayerDrugsTimer) do
		if v.startedDrugs == source then
			return true
		end
	end
	return false
end
-- DO NOT TOUCH!!
function RemoveStartedConvert(source)
	for k,v in pairs(PlayerConvertTimer) do
		if v.startedConvert == source then
			table.remove(PlayerConvertTimer,k)
		end
	end
end
-- DO NOT TOUCH!!
function GetTimeForConvert(source)
	for k,v in pairs(PlayerConvertTimer) do
		if v.startedConvert == source then
			return math.ceil(v.timeConvert/1000)
		end
	end
end
-- DO NOT TOUCH!!
function CheckedStartedConvert(source)
	for k,v in pairs(PlayerConvertTimer) do
		if v.startedConvert == source then
			return true
		end
	end
	return false
end

-- // ## DRUG SALE ## // --

local soldAmount = {}

RegisterServerEvent("esx_newDrugs:sellDrugs")
AddEventHandler("esx_newDrugs:sellDrugs", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local weed = xPlayer.getInventoryItem('weed4g').count
	local meth = xPlayer.getInventoryItem('meth1g').count
	local coke = xPlayer.getInventoryItem('coke1g').count
	local methbag = xPlayer.getInventoryItem('methbag').count
	local bagofdope = xPlayer.getInventoryItem('bagofdope').count
	local lsd = xPlayer.getInventoryItem('lsd').count
	local lsd_pooch = xPlayer.getInventoryItem('lsd_pooch').count
	local spice = xPlayer.getInventoryItem('spice').count
	local marijuana = xPlayer.getInventoryItem('marijuana').count
	local coke2 = xPlayer.getInventoryItem('coke').count


	local drugamount = 0
	local price = 0
	local drugType = nil
	
	if weed > 0 then
		drugType = 'weed4g'
		if weed == 1 then
			drugamount = 1
		elseif weed == 2 then
			drugamount = math.random(1,2)
		elseif weed == 3 then	
			drugamount = math.random(1,3)
		elseif weed >= 4 then	
			drugamount = math.random(1,4)
		end
		
	elseif meth > 0 then
		drugType = 'meth1g'
		if meth == 1 then
			drugamount = 1
		elseif meth == 2 then
			drugamount = math.random(1,2)
		elseif meth >= 3 then	
			drugamount = math.random(1,3)
		end
		
	elseif coke > 0 then
		drugType = 'coke1g'
		if coke == 1 then
			drugamount = 1
		elseif coke == 2 then
			drugamount = math.random(1,2)
		elseif coke >= 3 then	
			drugamount = math.random(1,3)
		end
	
	elseif methbag > 0 then
		drugType = 'methbag'
		if methbag == 1 then
			drugamount = 1
		elseif methbag == 2 then
			drugamount = math.random(1,2)
		elseif methbag >= 3 then	
			drugamount = math.random(1,3)
		end

	elseif bagofdope > 0 then
		drugType = 'bagofdope'
		if bagofdope == 1 then
			drugamount = 1
		elseif bagofdope == 2 then
			drugamount = math.random(1,2)
		elseif bagofdope >= 3 then	
			drugamount = math.random(1,3)
		end

	elseif lsd > 0 then
		drugType = 'lsd'
		if lsd == 1 then
			drugamount = 1
		elseif lsd == 2 then
			drugamount = math.random(1,2)
		elseif lsd >= 3 then	
			drugamount = math.random(1,3)
		end

	elseif lsd_pooch > 0 then
		drugType = 'lsd_pooch'
		if lsd_pooch == 1 then
			drugamount = 1
		elseif lsd_pooch == 2 then
			drugamount = math.random(1,2)
		elseif lsd_pooch >= 3 then	
			drugamount = math.random(1,3)
		end

	elseif spice > 0 then
		drugType = 'spice'
		if spice == 1 then
			drugamount = 1
		elseif spice == 2 then
			drugamount = math.random(1,2)
		elseif spice >= 3 then	
			drugamount = math.random(1,3)
		end

	elseif marijuana > 0 then
		drugType = 'marijuana'
		if marijuana == 1 then
			drugamount = 1
		elseif marijuana == 2 then
			drugamount = math.random(1,2)
		elseif marijuana >= 3 then	
			drugamount = math.random(1,3)
		end

	elseif coke2 > 0 then
		drugType = 'coke'
		if coke2 == 1 then
			drugamount = 1
		elseif coke2 == 2 then
			drugamount = math.random(1,2)
		elseif coke2 >= 3 then	
			drugamount = math.random(1,3)
		end
	else
		TriggerClientEvent('esx:showNotification', _source, "You have ~r~no more~r~ ~y~drugs~s~ on you")
		return
	end
	
	if drugType=='weed4g' then
		price = math.random(5,8) * 35 * drugamount
	elseif drugType=='meth1g' then
		price = math.random(6,9) * 45 * drugamount
	elseif drugType=='coke1g' then
		price = math.random(6,10) * 40 * drugamount
	elseif drugType=='methbag' then
		price = math.random(5,8) * 25 * drugamount
	elseif drugType=='lsd' then
		price = math.random(7,10) * 25 * drugamount
	elseif drugType=='lsd_pooch' then
		price = math.random(7,10) * 25 * drugamount
	elseif drugType=='spice' then
		price = math.random(7,8) * 25 * drugamount
	elseif drugType=='marijuana' then
		price = math.random(5,8) * 25 * drugamount
	elseif drugType=='coke' then
		price = math.random(6,8) * 25 * drugamount
	elseif drugType=='bagofdope' then
		price = math.random(6,7) * 115 * drugamount
	end
	
	if drugType ~= nil then
		xPlayer.removeInventoryItem(drugType, drugamount)
	end
	
	AddToSoldAmount(xPlayer.getIdentifier(),drugamount)
	xPlayer.addAccountMoney('black_money', price)
	if drugType=='weed4g' then
	TriggerClientEvent('esx:showNotification', _source, "You sold ~b~"..drugamount.."x~s~ ~y~Weed (4G)~s~ for ~r~$" .. price)
	elseif drugType=='meth1g' then
	TriggerClientEvent('esx:showNotification', _source, "You sold ~b~"..drugamount.."x~s~ ~y~Meth (1G)~s~ for ~r~$" .. price)
	elseif drugType=='coke1g' then
	TriggerClientEvent('esx:showNotification', _source, "You sold ~b~"..drugamount.."x~s~ ~y~Cocaine (1G)~s~ for ~r~$" .. price)
	elseif drugType=='methbag' then
	TriggerClientEvent('esx:showNotification', _source, "You sold ~b~"..drugamount.."x~s~ ~y~Bag of Meth (1G)~s~ for ~r~$" .. price)
	elseif drugType=='lsd' then
	TriggerClientEvent('esx:showNotification', _source, "You sold ~b~"..drugamount.."x~s~ ~y~lsd (1G)~s~ for ~r~$" .. price)
	elseif drugType=='lsd_pooch' then
	TriggerClientEvent('esx:showNotification', _source, "You sold ~b~"..drugamount.."x~s~ ~y~Bottle of lsd (1G)~s~ for ~r~$" .. price)
	elseif drugType=='spice' then
	TriggerClientEvent('esx:showNotification', _source, "You sold ~b~"..drugamount.."x~s~ ~y~spice (1G)~s~ for ~r~$" .. price)
	elseif drugType=='marijuana' then
	TriggerClientEvent('esx:showNotification', _source, "You sold ~b~"..drugamount.."x~s~ ~y~marijuana (1G)~s~ for ~r~$" .. price)
	elseif drugType=='coke' then
	TriggerClientEvent('esx:showNotification', _source, "You sold ~b~"..drugamount.."x~s~ ~y~Cocaine (1G)~s~ for ~r~$" .. price)
	elseif drugType=='bagofdope' then
	TriggerClientEvent('esx:showNotification', _source, "You sold ~b~"..drugamount.."x~s~ ~y~bag of weed (1G)~s~ for ~r~$" .. price)
	
	end
	
end)

RegisterServerEvent("esx_newDrugs:canSellDrugs")
AddEventHandler("esx_newDrugs:canSellDrugs", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local soldAmount = (xPlayer.getInventoryItem("coke1g").count > 0 or xPlayer.getInventoryItem("meth1g").count > 0 or xPlayer.getInventoryItem("methbag").count > 0 or xPlayer.getInventoryItem("lsd").count > 0 or xPlayer.getInventoryItem("lsd_pooch").count > 0 or xPlayer.getInventoryItem("spice").count > 0 or xPlayer.getInventoryItem("marijuana").count > 0 or xPlayer.getInventoryItem("coke").count > 0 or xPlayer.getInventoryItem("bagofdope").count > 0  or xPlayer.getInventoryItem("weed4g").count > 0) and CheckSoldAmount(xPlayer.getIdentifier()) < Config.maxCap
		TriggerClientEvent("esx_newDrugs:canSellDrugs",source,soldAmount)
	end
end)

RegisterServerEvent("esx_drugSale:canSellDrugs")
AddEventHandler("esx_drugSale:canSellDrugs", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local sell = (xPlayer.getInventoryItem("coke1g").count > 0 or xPlayer.getInventoryItem("meth1g").count > 0 or xPlayer.getInventoryItem("methbag").count > 0 or xPlayer.getInventoryItem("lsd").count > 0 or xPlayer.getInventoryItem("lsd_pooch").count > 0 or xPlayer.getInventoryItem("spice").count > 0 or xPlayer.getInventoryItem("marijuana").count > 0 or xPlayer.getInventoryItem("coke").count > 0 or xPlayer.getInventoryItem("bagofdope").count > 0 or xPlayer.getInventoryItem("weed4g").count > 0) and CheckSellAmount(xPlayer.getIdentifier()) < 150
		TriggerClientEvent("esx_drugSale:canSellDrugs",source,sell)
	end
end)

function AddToSoldAmount(source,amount)
	for k,v in pairs(soldAmount) do
		if v.id == source then
			v.amount = v.amount + amount
			return
		end
	end
end

function CheckSoldAmount(source)
	for k,v in pairs(soldAmount) do
		if v.id == source then
			return v.amount
			
		end
	end
	table.insert(soldAmount,{id = source, amount = 0})
	return CheckSoldAmount(source)
end
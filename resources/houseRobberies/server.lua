local ESX = nil
local robbableItems = {
 [1] = {chance = 1, id = 0, name = 'Cash', quantity = math.random(100, 500)}, -- really common
 [2] = {chance = 50, id = 'WEAPON_PISTOL', name = 'Pistol', isWeapon = true}, -- rare
 [3] = {chance = 21, id = 'highgradefert', name = 'High-Grade Fertilizer', quantity = 1},
 [4] = {chance = 25, id = 'armor', name = 'Armour', quantity =  math.random(1, 2)}, -- common
 [5] = {chance = 4, id = 'bandage', name = 'Bandage', quantity = math.random(1, 25)}, -- common
 [6] = {chance = 5, id = 'beer', name = 'beer', quantity = math.random(1, 2)}, -- common
 [7] = {chance = 5, id = 'binoculars', name = 'Binoculars', quantity = 1}, -- common
 [8] = {chance = 5, id = 'blowpipe', name = 'Mech Lockpick', quantity = math.random(1, 2)}, -- rare
 [9] = {chance = 3, id = 'lockpick', name = 'lockpick', quantity = math.random(1, 2)}, -- rare
 [10] = {chance = 8, id = 'advancedlockpick', name = 'Multi-pick', quantity = math.random(1, 2)}, -- rare
 [11] = {chance = 6, id = 'cannabinoid', name = 'chemicals', quantity = math.random(1, 5)}, -- rare
 [12] = {chance = 8, id = 'cannabis', name = 'Cannabis Plant', quantity = 2}, -- rare
 [13] = {chance = 15, id = 'clip', name = 'Weapon Clip', quantity = 1}, -- rare
 [14] = {chance = 6, id = 'coke', name = 'Cocaine', quantity = 2}, -- common
 [15] = {chance = 5, id = 'goldNecklace', name = 'Gold Necklace', quantity = 1}, -- rare
 [16] = {chance = 25, id = 'handcuffs', name = 'handcuffs', quantity = 1}, -- rare
 [17] = {chance = 4, id = 'highradio', name = 'Aftermarket Radio', quantity = 1}, -- rare
 [18] = {chance = 25, id = 'jewels', name = 'Jewels', quantity = math.random(1, 5)}, -- rare
 [19] = {chance = 4, id = 'laptop', name = 'Laptop', quantity = 1}, -- rare
 [20] = {chance = 1, id = 'lotteryticket', name = 'Lottery Ticket', quantity = math.random(1, 5)}, -- common
 [21] = {chance = 3, id = 'lowradio', name = 'Stock Radio', quantity = 2},
 [22] = {chance = 10, id = 'lsd', name = 'Lsd', quantity = 10}, 
 [23] = {chance = 5, id = 'marijuana', name = 'Bag of Weed', quantity = math.random(1, 5)}, 
 [24] = {chance = 5, id = 'medikit', name = 'Medikit', quantity = 1}, 
 [25] = {chance = 2, id = 'oxygen_mask', name = 'Oxygen Mask', quantity = 1}, 
 [26] = {chance = 1, id = 'ring', name = 'Ring', quantity = 2}, 
 [27] = {chance = 2, id = 'rolex', name = 'Rolex', quantity = math.random(1, 5)}, 
 [28] = {chance = 5, id = 'rope', name = 'X', quantity = 1},
 [29] = {chance = 4, id = 'samsungS10', name = 'Samsung Phone', quantity = 2}, 
 [30] = {chance = 3, id = 'spice', name = 'Bag of spice', quantity = 2}, 
 [31] = {chance = 1, id = 'vodka', name = 'Vodka', quantity = 1},
 [32] = {chance = 5, id = 'WEAPON_KNIFE', name = 'Combat knife', quantity = 1},
 [33] = {chance = 15, id = 'WEAPON_PIPEBOMB', name = 'Homemade bomb', quantity = math.random(1, 5)},
 [34] = {chance = 13, id = 'highgradefemaleseed', name = 'Female Dope Seed+', quantity = 1},
 [35] = {chance = 8, id = 'lowgradefemaleseed', name = 'Female Dope Seed', quantity = 1},
 [36] = {chance = 25, id = 'highgrademaleseed', name = 'Male Dope Seed+', quantity = 1},
 [37] = {chance = 20, id = 'lowgrademaleseed', name = 'Male Dope Seed', quantity = 1},
 [38] = {chance = 35, id = 'drugItem', name = 'Black USB-C', quantity = 1},
 [39] = {chance = 50, id = 'tuning_laptop', name = 'tunning laptop', quantity = 1},
 [40] = {chance = 20, id = 'goldbar', name = 'gold bar ', quantity = 1}
 
 
}

--[[chance = 1 is very common, the higher the value the less the chance]]--

TriggerEvent('esx:getSharedObject', function(obj)
 ESX = obj
end)

ESX.RegisterUsableItem('advancedlockpick', function(source) --Hammer high time to unlock but 100% call cops
 local source = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(source)
 TriggerClientEvent('houseRobberies:attempt', source, xPlayer.getInventoryItem('advancedlockpick').count)
end)

RegisterServerEvent('houseRobberies:removeLockpick')
AddEventHandler('houseRobberies:removeLockpick', function()
 local source = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(source)
 xPlayer.removeInventoryItem('advancedlockpick', 1)
 --TriggerClientEvent('chatMessage', source, '^1Your lockpick has bent out of shape')
 TriggerClientEvent('notification', source, 'The lockpick bent out of shape.', 2)
end)

RegisterServerEvent('houseRobberies:giveMoney')
AddEventHandler('houseRobberies:giveMoney', function()
 local source = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(source)
 local cash = math.random(1000, 1500)
 xPlayer.addMoney(cash)
 --TriggerClientEvent('chatMessage', source, '^4You have found $'..cash)
 TriggerClientEvent('notification', source, 'You found $'..cash)
end)


RegisterServerEvent('houseRobberies:searchItem')
AddEventHandler('houseRobberies:searchItem', function()
 local source = tonumber(source)
 local item = {}
 local xPlayer = ESX.GetPlayerFromId(source)
 local gotID = {}


 for i=1, math.random(1, 2) do
  item = robbableItems[math.random(1, #robbableItems)]
  if math.random(1, 10) >= item.chance then
   if tonumber(item.id) == 0 and not gotID[item.id] then
    gotID[item.id] = true
    xPlayer.addMoney(item.quantity)
    --TriggerClientEvent('chatMessage', source, 'You found $'..item.quantity)
    TriggerClientEvent('notification', source, 'You found $'..item.quantity)
   elseif item.isWeapon and not gotID[item.id] then
    gotID[item.id] = true
    xPlayer.addWeapon(item.id, 50)
    --TriggerClientEvent('chatMessage', source, 'You found a '..item.name)
    TriggerClientEvent('notification', source, 'Item Added!', 2)
   elseif not gotID[item.id] then
    gotID[item.id] = true
    xPlayer.addInventoryItem(item.id, item.quantity)
    --TriggerClientEvent('chatMessage', source, 'You have found '..item.quantity..'x '..item.name)
    TriggerClientEvent('notification', source, 'Item Added!', 2)
   end
  end
 end
end)

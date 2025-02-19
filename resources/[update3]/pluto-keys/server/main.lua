local ESX

cachedData = {
	["cbData"] = {},
}

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

RegisterServerEvent("pluto-keys:giveKey")
AddEventHandler("pluto-keys:giveKey", function(key, player)
	TriggerClientEvent("pluto-keys:insertKey", player, key)
end)

if Config.CreateDBTable then
	local sqlQuery = {}
	MySQL.ready(function()
		table.insert(sqlQuery, function(callback)
            MySQL.Async.execute([[
				CREATE TABLE IF NOT EXISTS `user_keys` (
					`identifier` varchar(50) NOT NULL,
					`keyTable` longtext NOT NULL,
					PRIMARY KEY (`identifier`)
				) ENGINE=InnoDB DEFAULT CHARSET=latin1;
			]], {}, function(rowsChanged)
                callback(rowsChanged > 0)
            end)
        end)

		Async.parallel(sqlQuery, function(responses)
			if #responses >= #sqlQuery then
				print("Created table [pluto_keys] in db.")
			end
		end)
    end)
end

ESX.RegisterServerCallback("pluto-keys:fetchKeys", function(source, cb)
	
	local player = ESX.GetPlayerFromId(source)["identifier"]

	if not player then cb(false) end

	FetchKeys(player, function(fetchedKeys)

		if fetchedKeys then

			local menuElements = {}

			for _, keyData in ipairs(fetchedKeys) do

				table.insert(menuElements, {
					["label"] = keyData["label"],
					["keyId"] = keyData["keyId"],
				})
			end

			cb(menuElements)

		else

			cb(false)

		end

	end)

end)

ESX.RegisterServerCallback("pluto-keys:removeKey", function(source, cb, removeKeyData)
	local player = ESX.GetPlayerFromId(source)["identifier"]

	if player then
		RemoveKey(player, removeKeyData, function(removedKey)
			if removedKey then
				cb(true)
			else
				cb(false)
			end
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback("pluto-keys:transferKey", function(source, cb, keyData, newOwner)
	
	local player = ESX.GetPlayerFromId(source)["identifier"]
	local newPlayer = ESX.GetPlayerFromId(newOwner)["identifier"]
	local newKeys = {}
	
	if player and newOwner then

		RemoveKey(player, keyData, function(removedKey)
			if removedKey then
				AddKey(newPlayer, keyData, function(addedKey)
					if addedKey then
						cb(true)
					else
						cb(false)
					end
				end)
			else
				cb(false)
			end
		end)

	else

		cb(false)

	end

end)

ESX.RegisterServerCallback("pluto-keys:addKey", function(source, cb, newKey)

	local player = ESX.GetPlayerFromId(source)["identifier"]

	if player then

		AddKey(player, newKey, function(addedKey)

			if addedKey then
				cb(true)
			else
				cb(false)
			end

		end)

	else

		cb(false)

	end

end)

FetchKeys = function(player, cb)

	local fetchSqlQuery = [[
		SELECT
			keyTable
		FROM
			user_keys
		WHERE
			identifier = @identifier
	]]

	MySQL.Async.fetchAll(fetchSqlQuery, {
		["@identifier"] = player
	}, function(retrievedKeys)
		if not retrievedKeys[1] then return cb(false) end

		if cb then
			for _, keyData in pairs(retrievedKeys) do
				decodedKeys = json.decode(keyData["keyTable"])

				cb(decodedKeys)
			end
		end
	end)
end

RemoveKey = function(player, removeKeyData, cb)
	FetchKeys(player, function(fetchedKeys)
			
		if fetchedKeys then

			local updatedKeys = {}

			for _, keyData in ipairs(fetchedKeys) do

				if keyData["keyName"] ~= removeKeyData["label"] and keyData["keyId"] ~= removeKeyData["keyId"] then

					table.insert(updatedKeys, {
						["label"] = keyData["label"],
						["keyId"] = keyData["keyId"],
					})
				end
			end

			local sqlQuery = [[
				UPDATE
					user_keys
				SET
					keyTable = @keyTable
				WHERE
					identifier = @identifier
			]]

			MySQL.Async.execute(sqlQuery, {
				["@keyTable"] = json.encode(updatedKeys),
				["@identifier"] = player
			}, function(rowsChanged)
				if rowsChanged > 0 then
					cb(true)
				else
					cb(false)
				end
			end)

		else
			cb(false)
		end
	end)
end

AddKey = function(player, newKey, cb)
	FetchKeys(player, function(fetchedKeys)
		
		local newKeys = {}

		table.insert(newKeys, newKey)

		if fetchedKeys then

			for _, keyData in ipairs(fetchedKeys) do

				table.insert(newKeys, {
					["label"] = keyData["label"],
					["keyId"] = keyData["keyId"],
				})
			end
	
			local sqlQuery = [[
				UPDATE
					user_keys
				SET
					keyTable = @keyTable
				WHERE
					identifier = @identifier
			]]

			MySQL.Async.execute(sqlQuery, {
				["@keyTable"] = json.encode(newKeys),
				["@identifier"] = player
			}, function(rowsChanged)
				if rowsChanged > 0 then
					cb(true)
				else
					cb(false)
				end
			end)
			
		else
			local sqlQuery = [[
				INSERT
					INTO
				user_keys
					(identifier, keyTable)
				VALUES
					(@identifier, @keyTable)
			]]

			MySQL.Async.execute(sqlQuery, {
				["@keyTable"] = json.encode(newKeys),
				["@identifier"] = player
			}, function(rowsChanged)
				if rowsChanged > 0 then
					cb(true)
				else
					cb(false)
				end
			end)
		end
	end)
end
PHUMWIWAT = GetCurrentResourceName()
local NumberCharset = {}
local Charset = {}
for love,you in pairs(DAXTON.SetBox) do
    ESX.RegisterUsableItem(love, function(source)
        xPlayer = ESX.GetPlayerFromId(source);
		for fuck,with in pairs(DAXTON.SetBox[love].Add) do
			if DAXTON.SetBox[love].Add[fuck].Type == "item" then
				if math.random(1, 100) <= DAXTON.SetBox[love].Add[fuck].Percent then
					local random = math.random(DAXTON.SetBox[love].Add[fuck].Count[1], DAXTON.SetBox[love].Add[fuck].Count[2])
					xPlayer.addInventoryItem(DAXTON.SetBox[love].Add[fuck].Name, random)
				end
			elseif DAXTON.SetBox[love].Add[fuck].Type == "money" then
				if math.random(1, 100) <= DAXTON.SetBox[love].Add[fuck].Percent then
					local random = math.random(DAXTON.SetBox[love].Add[fuck].Count[1], DAXTON.SetBox[love].Add[fuck].Count[2]);
					xPlayer.addAccountMoney(DAXTON.SetBox[love].Add[fuck].Name, random);
				end
			elseif DAXTON.SetBox[love].Add[fuck].Type == "weapon" then
				if math.random(1, 100) <= DAXTON.SetBox[love].Add[fuck].Percent then
					local random = math.random(DAXTON.SetBox[love].Add[fuck].Count[1], DAXTON.SetBox[love].Add[fuck].Count[2]);
					xPlayer.addWeapon(DAXTON.SetBox[love].Add[fuck].Name, random);
				end
			elseif DAXTON.SetBox[love].Add[fuck].Type == "vehicle" then
				if DAXTON.SetBox[love].Add[fuck].Plate == nil then
					AddCars(source,GetPlayerIdentifiers(source)[1], GeneratePlate(), GetHashKey(DAXTON.SetBox[love].Add[fuck].Name))
				elseif DAXTON.SetBox[love].Add[fuck].Plate then
					AddCars(source,GetPlayerIdentifiers(source)[1], DAXTON.SetBox[love].Add[fuck].Plate, GetHashKey(DAXTON.SetBox[love].Add[fuck].Name))
				end
			end
		end
        if DAXTON.SetBox[love].RemoveItem == true then xPlayer.removeInventoryItem(love, 1) end;
    end);
	Citizen.CreateThread(function()
		print(('*[^2LOAD-DATA^7] REGISTER ITEM USE : (\27[42m%s\27[0m)'):format(love))
	end);
end;
for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end
function GeneratePlate()
	local generatedPlate
	local doBreak = false
	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		generatedPlate = string.upper(GetRandomLetter(3) .. ' ' .. GetRandomNumber(3))
		isPlateTaken(function(isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)
		if doBreak then
			break
		end
	end
	return generatedPlate
end
isPlateTaken = function(cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end
GetRandomNumber = function(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end
GetRandomLetter = function(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end
AddCars = function(source, identifier, plate, model)
	local vehicle = { plate = plate, model = model }
	MySQL.Async.execute("INSERT INTO owned_vehicles (owner, plate, vehicle, stored) VALUES (@owner, @plate, @vehicle, @stored)", {
		['@owner'] = identifier,
		['@plate'] = plate,
		['@vehicle'] = json.encode(vehicle),
		['@stored'] = true;
	})
	DAXTON.UPDATE_VEHICLE({ player = source, plate = plate, vehicle =  json.encode(vehicle) })
end

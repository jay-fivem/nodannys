local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("nodannys:server:getSkin", function(source, cb, cid)
    local result = MySQL.Sync.fetchAll('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?', {cid, 1})
    if result[1] ~= nil then
        cb(result[1].skin)
    else
        cb(nil)
    end
end)

RegisterNetEvent("qb-clothing:saveSkin", function(model, clothing)
    TriggerClientEvent("nodannys:client:Update", source, clothing)
end)
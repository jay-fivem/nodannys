--[[

QBCore.Functions.CreateCallback("bankrobbery:getclothes", function(source, cb)
    local src = source
    local result = exports.oxmysql:fetchSync('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?', { QBCore.Functions.GetPlayer(src).PlayerData.citizenid, 1 })
    if result[1] ~= nil then
        cb(result[1].skin)
    else
        cb(false)
    end
end)

Client:
QBCore.Functions.TriggerCallback("bankrobbery:getclothes", function(result)
        if json.decode(result).bag.item == 44 or json.decode(result).bag.item == 45 then
            BankRobbery()
        else
            QBCore.Functions.Notify("You don't have a bag", 'error')
        end
end)
]]

fx_version 'cerulean'
game 'gta5'

client_script 'client.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}
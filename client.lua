local QBCore = exports['qb-core']:GetCoreObject()
local running = true
local clothing = nil
local skin = nil

local function FetchClothing()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if p then return end
    p = promise.new()
    QBCore.Functions.TriggerCallback("nodannys:server:getSkin", function(result)
        p:resolve(result)
    end, PlayerData.citizenid)
    return Citizen.Await(p)
end

local function Danny(skin)
    if skin['t-shirt'].item == 1 and skin['t-shirt'].texture == 0 and skin["torso2"].item == 0 and skin["torso2"].texture == 0 and skin["pants"].item == 0 and skin["pants"].texture == 0 then
        return true
    end
    return false
end

local function DannyDetect()
    SetTextColour(0, 0, 0, 255)
    SetTextFont(4)
    SetTextScale(0.8, 0.8)
    SetTextWrap(0.0, 1.0)
    SetTextCentre(false)
    SetTextDropshadow(2, 2, 0, 0, 0)
    SetTextEdge(1, 0, 0, 0, 205)
    SetTextEntry("STRING")
    AddTextComponentString("~r~Hello Default Danny\nPress Enter to Go back into the clothing menu")
    DrawText(0.105, 0.100)
end

CreateThread(function()
    -- if skin == nil then
    --     clothing = FetchClothing()
    --     skin = json.decode(clothing)
    -- end
    while true do
        Wait(0)
        if running then
            if Danny(skin) then
                if (IsControlJustReleased(1, 201)) then 
                    TriggerEvent('qb-clothes:client:CreateFirstCharacter')
                end
                DisableAllControlActions(0)
                EnableControlAction(0, 201, true)
                DannyDetect()
            else
                running = false
            end
        else
            running = false
        end
    end
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    clothing = FetchClothing()
    skin = json.decode(clothing)
    running = true
end)

RegisterNetEvent("nodannys:client:Update", function(clothing)
    skin = json.decode(clothing)
    print(skin['t-shirt'].item)
    running = true
end)
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('mt-remover_itens_agua:server:RemoverTelemovel', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local phone = Player.Functions.GetItemByName("phone")
    if phone ~= nil then

        if phone.amount >= 1 then
            Player.Functions.RemoveItem("phone", 1)
            Player.Functions.AddItem("phone_estragado", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["phone_estragado"], "add")
            QBCore.Functions.Notify('Infelizmente os teus pertences ficaram molhados...')
        end
    end
end)

RegisterServerEvent('mt-remover_itens_agua:server:RemoverRadio', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local radio = Player.Functions.GetItemByName("radio")
    if radio ~= nil then

        if radio.amount >= 1 then
            Player.Functions.RemoveItem("radio", 1)
            Player.Functions.AddItem("radio_estragado", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["radio_estragado"], "add")
            QBCore.Functions.Notify('Infelizmente os teus pertences ficaram molhados...', 'error')
        end
    end
end)

RegisterServerEvent('mt-remover_itens_agua:server:RepararRadio', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local radio_estragado = Player.Functions.GetItemByName("radio_estragado")
    if radio_estragado ~= nil then

        if radio_estragado.amount >= 1 then
            Player.Functions.RemoveMoney('bank', 10)
            Player.Functions.RemoveItem("radio_estragado", 1)
            Player.Functions.AddItem("radio", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["radio"], "add")
        else
            QBCore.Functions.Notify('Não tens nada disso contigo!', 'error')
        end
    end
end)

RegisterServerEvent('mt-remover_itens_agua:server:RepararTelemovel', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local phone_estragado = Player.Functions.GetItemByName("phone_estragado")
    if phone_estragado ~= nil then

        if phone_estragado.amount >= 1 then
            Player.Functions.RemoveMoney('bank', 40)
            Player.Functions.RemoveItem("phone_estragado", 1)
            Player.Functions.AddItem("phone", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["phone"], "add")
        else
            QBCore.Functions.Notify('Não tens nada disso contigo!', 'error')
        end
    end
end)
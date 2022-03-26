local QBCore = exports['qb-core']:GetCoreObject()

-- Criar blip para a "Horta"
Citizen.CreateThread(function()
  local blip = AddBlipForCoord(392.44, -832.34, 29.29) -- Mudar coordenadas do blip aqui!
SetBlipSprite(blip, 521) -- Mudar estilo do blip aqui!
SetBlipDisplay(blip, 4)
SetBlipScale(blip, 0.7)
SetBlipAsShortRange(blip, true)
SetBlipColour(blip, 3)
BeginTextCommandSetBlipName("STRING")
AddTextComponentSubstringPlayerName("DigitalDen") -- Mudar nome do Blip aqui!
  EndTextCommandSetBlipName(blip)
end)

CreateThread(function()
  Wait(1000)
  while true do
    Wait(5)
    if IsEntityInWater(PlayerPedId()) then
        TriggerServerEvent('mt-remover_itens_agua:server:RemoverRadio')
        TriggerServerEvent('mt-remover_itens_agua:server:RemoverTelemovel')
    end
    if not IsEntityInWater(PlayerPedId()) then
      Wait(1000)
  end
end
end)

RegisterNetEvent('mt-remover_itens_agua:client:ReparoTelemovel', function()
    QBCore.Functions.Progressbar("troncos", "A ENTREGAR TELÉMOVEL...", 2000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() 
        TriggerServerEvent('mt-remover_itens_agua:server:RepararTelemovel')
        QBCore.Functions.Notify('Entregas-te o telémovel ao Técnico')
    end)
end)

RegisterNetEvent('mt-remover_itens_agua:client:ReparoRadio', function()
    QBCore.Functions.Progressbar("troncos", "A ENTREGAR RÁDIO AO TECNICO...", 2000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() 
        TriggerServerEvent('mt-remover_itens_agua:server:RepararRadio')
        QBCore.Functions.Notify('Entregas-te o rádio ao tecnico')
    end)
end)

RegisterNetEvent('mt-remover_itens_agua:client:ReparoMenu', function()
    exports['qb-menu']:openMenu({
      {
        header = "Ténico DigitalDen",
        isMenuHeader = true,
      },
      {
        header = "Reparar télemovel",
        txt = "Preço: 40$",
        params = {
          event = 'mt-remover_itens_agua:client:ReparoTelemovel',
          args = {}
        }
      },
      {
        header = "Reparar rádio",
        txt = "Preço: 10$",
        params = {
          event = 'mt-remover_itens_agua:client:ReparoRadio'
        }
      },
      {
        header = "< Fechar menu",
        txt = "",
        params = {
          event = 'qb-menu:closeMenu'
        }
      }
    })
end)

-- spawn ped de reparo
local reparosPed = {
	{392.56, -831.75, 28.29,"Sr Manel",218.94,0x7E4F763F,"g_m_m_chigoon_01"}, -- trocar aqui o ped e a sua loc
  
  }
  Citizen.CreateThread(function()
	  for _,v in pairs(reparosPed) do
		  RequestModel(GetHashKey(v[7]))
		  while not HasModelLoaded(GetHashKey(v[7])) do
			  Wait(1)
		  end
		  CokeProcPed =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
		  SetEntityHeading(CokeProcPed, v[5])
		  FreezeEntityPosition(CokeProcPed, true)
		  SetEntityInvincible(CokeProcPed, true)
		  SetBlockingOfNonTemporaryEvents(CokeProcPed, true)
		  TaskStartScenarioInPlace(CokeProcPed, "WORLD_HUMAN_AA_SMOKE", 0, true) 
	  end
  end)

-- Target Venda
Citizen.CreateThread(function ()
    exports['qb-target']:AddBoxZone("reparos", vector3(392.56, -831.75, 29.29), 1, 1, {
        name = "reparos",
        heading = 0,
        debugPoly = false,
    }, {
        options = {
            {
                type = "Client",
                event = "mt-remover_itens_agua:client:ReparoMenu",
                icon = "fas fa-phone",
                label = 'Falar com o tecnico'
            },
        },
        distance = 2.5
    })
end)
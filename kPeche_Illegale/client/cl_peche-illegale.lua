
ESX = nil
local PlayerData                = {}
SpamPecheIllegal = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setjob2')
AddEventHandler('esx:setjob2', function(job2)
  ESX.PlayerData.job2 = job2
end)

local MenuShopIllegaleOuvert = false
local MenuPrincipal = RageUI.CreateMenu("", "Magasin de Pêcheur Illégal")
MenuPrincipal.Closed = function() MenuShopIllegaleOuvert = false FreezeEntityPosition(PlayerPedId(), false) end

function ShopMenuIllegale()
    if MenuShopIllegaleOuvert then 
        MenuShopIllegaleOuvert = false 
        return 
    else
        MenuShopIllegaleOuvert = true 
        FreezeEntityPosition(PlayerPedId(), true)
        RageUI.Visible(MenuPrincipal, true)
        Citizen.CreateThread(function()
            while MenuShopIllegaleOuvert do 
                RageUI.IsVisible(MenuPrincipal, function()
                    RageUI.Separator("~b~ ↓ Catalogue Pêcheur Illégal ↓")
                    for k, v in pairs(Config.Shop_Illegale) do 
                        RageUI.Button(v.name, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true, {
                            onSelected = function()
                                TriggerServerEvent("kPeche:AchatsItems", v.item, v.name, v.price, false)
                            end,
                        })    
                    end
                end)
                Wait(1.0)
            end
        end)
    end
end


--------------------------------------------------------------------------------------------------------------------------
                                    -- [ Ped - Shop ] --
--------------------------------------------------------------------------------------------------------------------------


Citizen.CreateThread(function()
    for k, v in pairs(Config.Ped_Vendeur) do 
        while not HasModelLoaded(v.pedModel) do
            RequestModel(v.pedModel)
            Wait(1)
        end
        Ped3 = CreatePed(2, GetHashKey(v.pedModel), v.position, v.heading, 0, 0)
        FreezeEntityPosition(Ped3, 1)
        TaskStartScenarioInPlace(Ped3, v.pedModel, 0, false)
        SetEntityInvincible(Ped3, true)
        SetBlockingOfNonTemporaryEvents(Ped3, 1)
    end
    while true do  
        local wait = 750
        for k, v in pairs(Config.Ped_Vendeur) do 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.position.x, v.position.y, v.position.z)
            if dist <= 3.0 then 
                wait = 0
                Draw3DText(v.position.x, v.position.y, v.position.z-0.600, v.TalkPed, 4, 0.1, 0.05)
                if IsControlJustPressed(1,51) then
                    ShopMenuIllegale()
                    MenuShopIllegaleOuvert = true
                end
            end
        end
    Citizen.Wait(wait)
    end
end)


--------------------------------------------------------------------------------------------------------------------------
                                    -- [ Ped - Acheteur ] --
--------------------------------------------------------------------------------------------------------------------------
 
local MenuVenteOuvert = false
local MenuPrincipal = RageUI.CreateMenu("", "Acheteur Illégal")
MenuPrincipal.Closed = function() MenuVenteOuvert = false FreezeEntityPosition(PlayerPedId(), false) end
local VerifSpamVente = 0
local Appel_LSPD_Verif = Config.Appel_LSPD

function VenteIllegalMenu()
    if MenuVenteOuvert then 
        MenuVenteOuvert = false 
        return 
    else
        MenuVenteOuvert = true 
        FreezeEntityPosition(PlayerPedId(), true)
        RageUI.Visible(MenuPrincipal, true)
        Citizen.CreateThread(function()
            while MenuVenteOuvert do 
                RageUI.IsVisible(MenuPrincipal, function()
                    RageUI.Separator("~b~ ↓ Vendre vos Tortues ↓")
                    if Config.Vente_Mission then
                        RageUI.Button("Prendre un rendez-vous à l'acheteur", nil, {RightBadge = RageUI.BadgeStyle.Tick}, true, {
                            onSelected = function()
                                ESX.TriggerServerCallback('kPeche:AssezTortues', function(hasEnoughTortues)
                                    if hasEnoughTortues then 
                                        if VerifSpamVente == 0 then   
                                            VerifSpamVente = 1
                                            AcheteurMSG("Une position vous sera dévoilée prochainement soyez prudent !")
                                            RageUI.CloseAll()
                                            MenuVenteOuvert = false
                                            FreezeEntityPosition(PlayerPedId(), false) 
                                            Wait(3000)
                                            VenteMission()
                                        else 
                                            ESX.ShowNotification("~r~Vous avez déjà un point de rendez-vous !")  
                                            RageUI.CloseAll()
                                            MenuVenteOuvert = false
                                            FreezeEntityPosition(PlayerPedId(), false) 
                                        end                  
                                    else 
                                        ESX.ShowNotification("~r~Vous n'avez pas de tortues à vendre !")
                                        RageUI.CloseAll()
                                        MenuVenteOuvert = false
                                        FreezeEntityPosition(PlayerPedId(), false)
                                    end 
                                end)
                        end,
                        })  
                    
                    else 
                        RageUI.Button("Vendre l'intégralité de vos Tortues", nil, {RightBadge = RageUI.BadgeStyle.Tick}, true, {
                            onSelected = function()
                            for k, v in pairs(Config.Vente_Illegale) do 
                                TriggerServerEvent("kPeche:VentePoissons", v.item, v.name, v.price)
                            end
                        end,
                        })  
                    end  
                end)
                Wait(1.0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    for k, v in pairs(Config.Ped_Acheteur) do 
        while not HasModelLoaded(v.pedModel) do
            RequestModel(v.pedModel)
            Wait(1)
        end
        Ped4 = CreatePed(2, GetHashKey(v.pedModel), v.position, v.heading, 0, 0)
        FreezeEntityPosition(Ped4, 1)
        TaskStartScenarioInPlace(Ped4, v.pedModel, 0, false)
        SetEntityInvincible(Ped4, true)
        SetBlockingOfNonTemporaryEvents(Ped4, 1)

    end
    while true do  
        local wait = 750
        for k, v in pairs(Config.Ped_Acheteur) do 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.position.x, v.position.y, v.position.z)
            if dist <= 3.0 then 
                wait = 0
                Draw3DText(v.position.x, v.position.y, v.position.z-0.600, v.TalkPed, 4, 0.1, 0.05)
                if IsControlJustPressed(1,51) then
                    VenteIllegalMenu()
                    MenuVenteOuvert = true
                end
            end
        end
    Citizen.Wait(wait)
    end
end)

--------------------------------------------------------------------------------------------------------------------------
                                    -- [ Fonction DrawText ] --
--------------------------------------------------------------------------------------------------------------------------
 
function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov   
    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(250, 250, 250, 255)      
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

--------------------------------------------------------------------------------------------------------------------------
                                    -- [ Config Blips ] --
--------------------------------------------------------------------------------------------------------------------------
 

local blips = {
    {title = Config.Blips_Illegale.Blips_Illegale_Maps.Title, colour = Config.Blips_Illegale.Blips_Illegale_Maps.Color, id = Config.Blips_Illegale.Blips_Illegale_Maps.Type, x = Config.Blips_Illegale.Blips_Illegale_Maps.Position.x, y = Config.Blips_Illegale.Blips_Illegale_Maps.Position.y, z = Config.Blips_Illegale.Blips_Illegale_Maps.Position.z, radius = 100.01}
}
local VerifActive = Config.Blips_Illegale.Blips_Illegale_Maps.For_All

Citizen.CreateThread(function()
    if VerifActive then 
        for _, info in pairs(blips) do
            info.blip = AddBlipForCoord(info.x, info.y, info.z)
            SetBlipSprite(info.blip, info.id)
            SetBlipDisplay(info.blip, 4)
            SetBlipScale(info.blip, 0.9)
            SetBlipColour(info.blip, info.colour)
            SetBlipAsShortRange(info.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(info.title)
            EndTextCommandSetBlipName(info.blip)

            info.blip = AddBlipForRadius(info.x, info.y, info.z, info.radius)
            SetBlipColour(info.blip, info.colour)
            SetBlipAlpha(info.blip, 44)
        end
    else 
        for k, v in pairs(Config.Blips_Illegale_Maps_Groupe) do 
            user_job2 = v.name         
            if ESX.PlayerData.job2.name == user_job2 then   
                for _, info in pairs(blips) do
                    info.blip = AddBlipForCoord(info.x, info.y, info.z)
                    SetBlipSprite(info.blip, info.id)
                    SetBlipDisplay(info.blip, 4)
                    SetBlipScale(info.blip, 0.9)
                    SetBlipColour(info.blip, info.colour)
                    SetBlipAsShortRange(info.blip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(info.title)
                    EndTextCommandSetBlipName(info.blip)
        
                    info.blip = AddBlipForRadius(info.x, info.y, info.z, info.radius)
                    SetBlipColour(info.blip, info.colour)
                    SetBlipAlpha(info.blip, 44)   
                end
            end 
        end 
    end 
end)


--------------------------------------------------------------------------------------------------------------------------
                                    -- [ Config de la Pêche ] --
--------------------------------------------------------------------------------------------------------------------------

function PecheIllegale()
    local xPlayer = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    ESX.TriggerServerCallback('kPeche:AssezCAP', function(hasEnoughCAP) 
        if hasEnoughCAP then  
            ESX.TriggerServerCallback('kPeche:AssezAppatsTortue', function(hasEnoughAppatsTortue)
                if hasEnoughAppatsTortue then
                    FreezeEntityPosition(PlayerPedId(), true)
                    RequestAnimDict('amb@world_human_stand_fishing@idle_a')
                    while not HasAnimDictLoaded('amb@world_human_stand_fishing@idle_a') do
                        Wait(100)
                    end

                    TaskPlayAnim(PlayerPedId(), 'amb@world_human_stand_fishing@idle_a', 'idle_a', 8.0, -8, -1, 49, 0, 0, 0, 0)
                    prop = CreateObject(GetHashKey("prop_fishing_rod_01"), plyCoords.x, plyCoords.y, plyCoords.z+0.2,  true,  true, true)
                    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.0,0.0,0.0,0.0,0.0,0.0, true, true, false, true, 1, true)
   
                    Wait(2000)
                    DeleteEntity(prop) 
                    RandomFishIllegal()

                else 
                    ESX.ShowNotification("Vous n'avez plus d'appâts pour pêcher !")
                end 
            end)
        else 
            ESX.ShowNotification("Vous n'avez pas de canne à pêche !")
        end
    end)
end


function RandomFishIllegal()
	Active = true

    for k, v in pairs(Config.Shop_Illegale) do
        if v.item == 'appats_tortue' then 
            xappats = v.item
            number = v.count
        end 
    end 

	while Active do

		for k,v in pairs(Config.Random_Poisson_Illegale) do
			random = math.random(1, #Config.Random_Poisson_Illegale)
			id = v.id
			item = v.item
            name = v.name
            count = v.number

			if random == id then
				Active = false
                TriggerServerEvent('kPeche:UtilisationAppatTortue', xappats, number)
                TriggerServerEvent('kPeche:RandomPoisson', item, count, name)
                FreezeEntityPosition(PlayerPedId(), false)
                ClearPedTasks(PlayerPedId())   
                SpamPecheIllegal = false                  
                break
		    end
        end
		Citizen.Wait(1000)
	end
end

Citizen.CreateThread(function()
    while true do 
        local wait = 750
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.Blips_Illegale.Blips_Illegale_Maps.Position.x, Config.Blips_Illegale.Blips_Illegale_Maps.Position.y, Config.Blips_Illegale.Blips_Illegale_Maps.Position.z)
        local VerifActive = Config.Blips_Illegale.Blips_Illegale_Maps.For_All
        
        if VerifActive then 
            if dist <= 100 and SpamPecheIllegal == false then 
                wait = 0
                vehicle_perso = GetVehiclePedIsIn(GetPlayerPed(-1), true)

                if not IsPedSittingInVehicle(GetPlayerPed(-1), vehicle_perso) then

                    ESX.ShowHelpNotification(Config.Blips.BlipsMaps.Texte_Zone)

                    if IsControlJustPressed(1,51) then
                        PecheIllegale()
                        SpamPecheIllegal = true
                    end

                elseif IsPedSittingInVehicle(GetPlayerPed(-1), vehicle_perso) then
                    ESX.ShowHelpNotification(Config.Blips.BlipsMaps.Texte_Zone)

                    if IsControlJustPressed(1,51) then
                        ESX.ShowNotification('Vous ne pouvez pas pêcher assis !')    
                    end
                end
            end
            
        else 
            for k, v in pairs(Config.Blips_Illegale_Maps_Groupe) do 
                user_job2 = v.name
                if dist <= 100 and ESX.PlayerData.job2.name == user_job2 and SpamPecheIllegal == false then 
                    wait = 0
                    vehicle_perso = GetVehiclePedIsIn(GetPlayerPed(-1), true)

                    if not IsPedSittingInVehicle(GetPlayerPed(-1), vehicle_perso) then

                        ESX.ShowHelpNotification(Config.Blips.BlipsMaps.Texte_Zone)

                        if IsControlJustPressed(1,51) then
                            PecheIllegale()
                            SpamPecheIllegal = true
                        end

                    elseif IsPedSittingInVehicle(GetPlayerPed(-1), vehicle_perso) then
                        ESX.ShowHelpNotification(Config.Blips.BlipsMaps.Texte_Zone)

                        if IsControlJustPressed(1,51) then
                            ESX.ShowNotification('Vous ne pouvez pas pêcher assis !')    
                        end
                    end
                end
            end 
        end 
    Citizen.Wait(wait)
    end
end)

--------------------------------------------------------------------------------------------------------------------------
                                -- [ Config de la Mission Vente ] --
--------------------------------------------------------------------------------------------------------------------------

function VenteMission()
    Active = true
	while Active do
		for k, v in pairs(Config.Pos_Vente) do

			random = math.random(1, #Config.Pos_Vente)
			id = v.id

			if random == id then
				Active = false
                AcheteurMSG(v.pos.x.." "..v.pos.y.." "..v.pos.z)       

                Blip_Pos_Vente = AddBlipForCoord(v.pos.x, v.pos.y, v.pos.z)                                                       	
                SetBlipFlashes(Blip_Pos_Vente, true)  
                SetBlipColour(Blip_Pos_Vente, 5)  
                SetNewWaypoint(v.pos.x, v.pos.y, v.pos.z) 
                
                npc_arriver = v.ped_arriver
                spawn_vehicle_pos = v.spawn_vehicle
                spawn_vehicle_heading = v.heading
                retour_npc = v.despawn_npc
                spawn_blips = v.spawn_blips
                
                VerificationVente = 1
                break
		    end
        end
		Citizen.Wait(1000)
	end
end

function AppelleLSPD()
    ActiveLSPD = true
    random_lspd = math.random(1, #Config.Random_Appelle_LSPD)
	while ActiveLSPD do
		for k, v in pairs(Config.Random_Appelle_LSPD) do
			id_lspd = v.id
            value_lspd = v.valeur

			if random_lspd == id_lspd then
                if value_lspd then
				    ActiveLSPD = false    
                    TriggerServerEvent("kPeche:DebutVenteTortue")
                    break
                end
            else 
                print("La police n'a pas été alerté")
                ActiveLSPD = false 
                break
            end 
        end
		Citizen.Wait(1000)
	end
end


Citizen.CreateThread(function()
    while true do 
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local blipCoords = GetBlipCoords(Blip_Pos_Vente)
        local dist0 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, blipCoords.x, blipCoords.y, blipCoords.z)

        if dist0 <= 30 and VerificationVente == 1 then 

            RemoveBlip(Blip_Pos_Vente)

            for k, v in pairs(Config.Mission_Achats) do 
               pedModel = v.pedModel 
               typevehicle = v.hashVehicle
            end 

            RequestModel(typevehicle)
            while not HasModelLoaded(typevehicle) do
                Wait(1)
            end
            RequestModel(pedModel)
            while not HasModelLoaded(pedModel) do
                Wait(1)
            end      

            local spawnVehiculePos = vector3(spawn_vehicle_pos.x, spawn_vehicle_pos.y, spawn_vehicle_pos.z)   
        
            NPCVehicle = CreateVehicle(typevehicle, spawnVehiculePos, spawn_vehicle_heading, true, false)      
            SetVehicleDoorsLockedForAllPlayers(NPCVehicle, true)                  
            ClearAreaOfVehicles(GetEntityCoords(NPCVehicle), 5000, false, false, false, false, false);  
            SetVehicleOnGroundProperly(NPCVehicle)
            SetVehicleNumberPlateText(NPCVehicle, "Inconnu")
            SetEntityAsMissionEntity(NPCVehicle, true, true)
            SetVehicleEngineOn(NPCVehicle, true, true, false)

            --APVehiculeBlip = AddBlipForEntity(NPCVehicle)  -- Enlever les "--" si vous souhaitez que les joueurs voient le Blips et l'avancer du NPC                                                	
            --SetBlipFlashes(APVehiculeBlip, true)  
            --SetBlipColour(APVehiculeBlip, 5)
                
            Ped_In_Vehicle = CreatePedInsideVehicle(NPCVehicle, 26, GetHashKey(pedModel), -1, true, false)    
            SetEntityInvincible(Ped_In_Vehicle, true)  
            SetBlockingOfNonTemporaryEvents(Ped_In_Vehicle, 1)   
            
            TaskVehicleDriveToCoord(Ped_In_Vehicle, NPCVehicle, npc_arriver.x, npc_arriver.y, npc_arriver.z, 20.0, 0, GetEntityModel(NPCVehicle), 524863, 2.0)
            VerificationVente = 2

            AcheteurMSG("Une personne est sur le point d'arriver pour récupérer les tortues.")
            AppelleLSPD()
        end
        Citizen.Wait(500)
    end
end) 


Citizen.CreateThread(function()
    while true do 

        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local pedCoords = GetEntityCoords(Ped_In_Vehicle, false)

        local dist1 = Vdist(pedCoords.x, pedCoords.y, pedCoords.z, plyCoords.x, plyCoords.y, plyCoords.z)
        local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pedCoords.x, pedCoords.y, pedCoords.z)

        if dist1 <= 25 and VerificationVente == 2 then 
            VerificationVente = 3
            Wait(2000)
            TaskLeaveVehicle(Ped_In_Vehicle, NPCVehicle, 1)
            Wait(500)

            RequestAnimDict('anim@heists@box_carry@')
            while not HasAnimDictLoaded('anim@heists@box_carry@') do
                Wait(100)
            end

            TaskPlayAnim(Ped_In_Vehicle, 'missheistdocksprep1hold_cellphone', 'static', 8.0, -8, -1, 49, 0, 0, 0, 0)
            prop = CreateObject(GetHashKey("prop_security_case_01"), pedCoords.x, pedCoords.y, pedCoords.z,  true,  true, true)
            AttachEntityToEntity(prop, Ped_In_Vehicle, GetPedBoneIndex(Ped_In_Vehicle, 57005), 0.10, 0.0, 0.0, 0.0, 280.0, 53.0, true, true, false, true, 1, true)

            TaskGoToCoordAnyMeans(Ped_In_Vehicle, plyCoords.x, plyCoords.y, plyCoords.z, 1.0, 0, 0, 786603, 0xbf800000)
        end 

        if dist2 <= 3 and VerificationVente == 3 then 
            FreezeEntityPosition(GetPlayerPed(-1), true)
            Wait(2000)
            for k, v in pairs(Config.Vente_Illegale) do 
                TriggerServerEvent("kPeche:VentePoissons", v.item, v.name, v.price)
            end
            ClearPedTasks(Ped_In_Vehicle)
            DeleteEntity(prop)
            
            FreezeEntityPosition(GetPlayerPed(-1), false)
            VerificationVente = 4
        end 

        if VerificationVente == 4 then 
            Wait(4000)
            TaskVehicleDriveToCoord(Ped_In_Vehicle, NPCVehicle, retour_npc.x, retour_npc.y, retour_npc.z, 30.0, 0, GetEntityModel(NPCVehicle), 524863, 2.0)
            VerificationVente = 5
        end 

        if dist1 >= 200 and VerificationVente == 5 then 
            RemovePedElegantly(Ped_In_Vehicle)
            DeleteEntity(NPCVehicle)
            VerifSpamVente = 0
            VerificationVente = 0 
        end  
        Citizen.Wait(500)
    end
end) 

function Notify(msg)
    ESX.ShowNotification(msg)
end

function AcheteurMSG(msg)
	local phoneNr = "Acheteur"
    PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", true)
	Notify("Vous avez un nouveau message de ~r~Acheteur")
	TriggerServerEvent('gcPhone:sendMessage', phoneNr, msg) --> Si vous utilisez GCPhone ne changer rien. Si vous avez un autre téléphone utiliser le bon TriggerServentEvent liée à votre téléphone
end

RegisterNetEvent('kPeche:setBlip')
AddEventHandler('kPeche:setBlip', function()

	blipVente = AddBlipForCoord(spawn_blips.x, spawn_blips.y, spawn_blips.z)

	SetBlipSprite(blipVente, 161)
	SetBlipScale(blipVente, 3.5)
	SetBlipColour(blipVente, 3)

	PulseBlip(blipVente)
end)

RegisterNetEvent('kPeche:deleteBlip')
AddEventHandler('kPeche:deleteBlip', function()
	RemoveBlip(blipVente)
end)
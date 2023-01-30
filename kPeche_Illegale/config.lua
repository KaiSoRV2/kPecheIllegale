Config = {

----------------------------------------------------------------------------------------
                            -- [ Pêche Légale ] --
----------------------------------------------------------------------------------------

    Blips = {

        BlipsMaps = {
                Title = "Zone de Pêche",
                Type = 68, 
                Color = 3,
                Position = vector3(-1823.486, 5310.901, 5.57),
                Texte_Zone = "~INPUT_TALK~ pour commencer à ~g~Pêche",
        },
    },

    Shop = {

        {item = 'appats', name = "Appâts à poisson", price = 25, count = 1},
        {item = 'canne_a_peche', name = "Canne à pêche", price = 250},

    },

    Vente = {

        {name = "Thon", item = 'thon', price = 250},
        {name = "Truite", item = 'truite', price = 350},     
        {name = "Morue", item = 'morue', price = 450},
        {name = "Saumon", item = 'saumon', price = 2500},
 
    },

    Random_Poisson = {

        {item = "saumon", name = "Saumon", number = 1, id = 1},
        {item = "morue", name = "Morue", number = 1, id = 2},
        {item = "morue", name = "Morue", number = 1, id = 3},
        {item = "truite", name = "Truite", number = 1, id = 4},
        {item = "truite", name = "Truite", number = 1, id = 5},
        {item = "truite", name = "Truite", number = 1, id = 6},
        {item = "thon", name = "Thon", number = 1, id = 7},
        {item = "thon", name = "Thon", number = 1, id = 8},
        {item = "thon", name = "Thon", number = 1, id = 9},
        {item = "thon", name = "Thon", number = 1, id = 10},
    },

    Garage = {

        Zodiac_de_Peche = {name = 'dinghy4', label = 'Zodiac de Pêche', price = 5000, caution = 2500, spawnpos = vector3(-1602.393, 5260.64, 1.05), Heading_Bateau = 20.98},
        Bateau_de_Peche = {name = 'tug', label = 'Bateau de Pêche', price = 1000, caution = 500, spawnpos = vector3(-1601.771, 5264.98, 1.53), Heading_Bateau = 24.77,},

    },

    SpawnVehicle = {

        Bateau_Detruit = 2500,
        Retour_location = vector3(-1602.112, 5259.649, 0.75),
        TP_NPC = vector3(-1605.394, 5258.9, 2.10),
        TextMenuGarage = "Appuyez sur ~b~ [E] ~s~ pour ranger le bateau",

    },

    Ped = {
        {pedModel = 'u_m_y_baygor', heading = 302.91, position = vector3(-1592.671, 5203.073, 4.31 - 0.95), TalkPed = "Appuyez sur ~b~ [E] ~s~ pour parler au vendeur"},
    },

    Ped2 = {
        {pedModel = 'ig_djblamryans', heading = 27.47, position = vector3(-1600.76, 5204.46, 4.31 - 0.95), TalkPed = "Appuyez sur ~b~ [E] ~s~ pour parler à l'acheteur"},
    },


----------------------------------------------------------------------------------------
                            -- [ Pêche Illégale ] --
----------------------------------------------------------------------------------------

    Appelle_LSPD = true,

    Random_Appelle_LSPD = {
        {id = 1, valeur = true},
        {id = 2, valeur = false},
        {id = 2, valeur = false},      
    },

    Blips_Illegale = {

        Blips_Illegale_Maps = {
                For_All = false, 
                Title = "Zone de Pêche Illégale",
                Type = 68, 
                Color = 1,
                Position = vector3(4287.057, 4926.164, 9.8251),
                Texte_Zone = "~INPUT_TALK~ pour commencer à ~g~Pêche",
        },
    },

    Blips_Illegale_Maps_Groupe = {

        {name = 'ballas'},
        {name = 'families'},
        {name = 'vagos'},
        {name = 'crips'},
        {name = 'bloods'},
        {name = 'mafia'},
        {name = 'cartel'},

    },

    Shop_Illegale = {

        {item = 'appats_tortue', name = "Appâts à Tortue", price = 250, count = 1},
        {item = 'canne_a_peche', name = "Canne à Pêche", price = 250},

    },

    Vente_Illegale = {

        {name = "Tortue", item = 'tortue', price = 5000},

    },

    Vente_Mission  = true,

    Pos_Vente = {

        -- Grapeseed 
        {pos = vector3(1964.83, 5172.07, 47.74), id = 1, ped_arriver = vector3(1965.02, 5166.63, 47.49), spawn_vehicle = vector3(1663.55, 4949.52, 42.14), heading = 229.58, despawn_npc = vector3(1959.09, 3084.59, 46.75), spawn_blips = vector3(2182.5, 4923, 40.79)},
        {pos = vector3(2488.20, 4961.54, 44.79), id = 2, ped_arriver = vector3(2469.03, 4954.50, 45.10), spawn_vehicle = vector3(2063.70, 5000.53, 40.60), heading = 254.47, despawn_npc = vector3(1959.09, 3084.59, 46.75), spawn_blips = vector3(2182.5, 4923, 40.79)},
        
        -- Entre Sandy Droite et Grapeseed Sud 
        {pos = vector3(2713.57, 4140.98, 43.89), id = 3, ped_arriver = vector3(2709.23, 4149.34, 43.67), spawn_vehicle = vector3(2899.50, 4455.42, 48.34), heading = 147.56, despawn_npc = vector3(1959.09, 3084.59, 46.75), spawn_blips = vector3(2689.39, 3949.25, 44.08)},
        {pos = vector3(2680.28, 3941.84, 43.42), id = 4, ped_arriver = vector3(2689.39, 3949.25, 44.08), spawn_vehicle = vector3(2023.45, 3824.01, 32.98), heading = 120.67, despawn_npc = vector3(1959.09, 3084.59, 46.75), spawn_blips = vector3(2689.39, 3949.25, 44.08)}, 
        {pos = vector3(2415.62, 3744.76, 41.85), id = 5, ped_arriver = vector3(2415.90, 3763.44, 40.31), spawn_vehicle = vector3(2679.64, 4342.47, 45.79), heading = 72.83, despawn_npc = vector3(1959.09, 3084.59, 46.75), spawn_blips = vector3(2689.39, 3949.25, 44.08)},
       
        -- Nord Est Maps 
        {pos = vector3(1853.66, 6399.87, 46.26), id = 6, ped_arriver = vector3(1846.68, 6401.86, 45.71), spawn_vehicle = vector3(426.94, 6551.82, 27.43), heading = 336.95, despawn_npc = vector3(1959.09, 3084.59, 46.75), spawn_blips = vector3(1623.30, 6402.18, 38.72)},
        {pos = vector3(1394.97, 6589.07, 13.01), id = 7, ped_arriver = vector3(1386.09, 6579.31, 13.65), spawn_vehicle = vector3(426.94, 6551.82, 27.43), heading = 336.95, despawn_npc = vector3(1959.09, 3084.59, 46.75), spawn_blips = vector3(1623.30, 6402.18, 38.72)},
        
        -- Paleto 
        {pos = vector3(-200.18, 6544.65, 11.09), id = 8, ped_arriver = vector3(-207.18, 6535.50, 11.09), spawn_vehicle = vector3(-683.20, 5852.02, 16.83), heading = 1.78, despawn_npc = vector3(218.82, 7009.57, 4.32), spawn_blips = vector3(-101.52, 6393.93, 36.56)},    
        {pos = vector3(422.28, 6508.31, 27.77), id = 9, ped_arriver = vector3(422.57, 6520.51, 27.72), spawn_vehicle = vector3(1368.65, 6501.68, 19.84), heading = 94.78, despawn_npc = vector3(218.82, 7009.57, 4.32), spawn_blips = vector3(-101.52, 6393.93, 36.56)},
        {pos = vector3(15.11, 6277.47, 31.24), id = 10, ped_arriver = vector3(-0.30, 6267.82, 31.35), spawn_vehicle = vector3(-247.01, 6052.73, 31.97), heading = 80.44, despawn_npc = vector3(218.82, 7009.57, 4.32), spawn_blips = vector3(-101.52, 6393.93, 36.56)},
             
    },

    Mission_Achats = {
        {pedModel = 'a_m_m_mexlabor_01', hashVehicle = 'rebel2'},
    },

    Random_Poisson_Illegale = {

        {item = "tortue", name = "Tortue", number = 1, id = 1},
        {item = "saumon", name = "Saumon", number = 1, id = 2},
        {item = "morue", name = "Morue", number = 1, id = 3},
        {item = "morue", name = "Morue", number = 1, id = 4},
        {item = "truite", name = "Truite", number = 1, id = 5},
        {item = "truite", name = "Truite", number = 1, id = 6},
        {item = "truite", name = "Truite", number = 1, id = 7},
        {item = "thon", name = "Thon", number = 1, id = 8},
        {item = "thon", name = "Thon", number = 1, id = 9},
        {item = "thon", name = "Thon", number = 1, id = 10},
    },

    Ped_Vendeur = {
        {pedModel = 'csb_grove_str_dlr', heading = 293.39, position = vector3(3809.562, 4489.589, 6.38 - 0.95), TalkPed = "Appuyez sur ~b~ [E] ~s~ pour parler à la personne"},
    },

    Ped_Acheteur = {
        {pedModel = 'u_m_y_hippie_01', heading = 175.33, position = vector3(3725.21, 4525.213, 22.47 - 0.95), TalkPed = "Appuyez sur ~b~ [E] ~s~ pour parler à la personne"},
    },


}


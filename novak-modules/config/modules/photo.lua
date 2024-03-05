Config.photo = {}

Config.photo.clothes = {
    command = "clothesphoto",
    defaultCustom = {
        [`mp_m_freemode_01`] = {
            [8] = {15},
            [3] = {1},
            [4] = {12},
            [11] = {1},
            [6] = {1}
        },
        [`mp_f_freemode_01`] = {
            [8] = {15},
            [3] = {1},
            [4] = {0},
            [11] = {1},
            [6] = {1}
        },
    },
    coords = {
        front = vector4(-1843.85,-1250.8,8.62,320.00),
        back = vector4(-1843.85,-1250.8,8.62,130.00)
    },
    parts = {
        [1] = { componentID = 1, cammode = "face" }, -- mascara
        [2] = { componentID = 3, cammode = "body" }, -- mao
        [3] = { componentID = 4, cammode = "legs" }, -- calca
        [4] = { componentID = 5, cammode = "back" }, -- mochila
        [5] = { componentID = 6, cammode = "shoes" }, -- sapato
        [6] = { componentID = 7, cammode = "body" }, -- acessorio
        [7] = { componentID = 8, cammode = "body" }, -- camisa
        [8] = { componentID = 9, cammode = "body" }, -- colete
        [9] = { componentID = 10, cammode = "body" }, -- adesivo
        [10] = { componentID = 11, cammode = "body" }, -- jaqueta
        [11] = { componentID = "p0", cammode = "face" }, -- chapeu
        [12] = { componentID = "p1", cammode = "face" }, -- oculos
        [13] = { componentID = "p2", cammode = "ear" }, -- brinco
        [14] = { componentID = "p6", cammode = "rightarm" }, -- relogio
        [15] = { componentID = "p7", cammode = "leftarm" } -- bracelete
    },
}

Config.photo.barbershop = {
    command = "barberphoto",
    colorsHair = 48,
    colorsBear = 10,
    coords = {
        front = vector4(-1843.85,-1250.8,8.62,320.00)
    },
    clothes = {
        [1885233650] = {
            [1] = {-1, 0},
            [3] = {15, 0},
            [4] = {21, 0},
            [5] = {-1, 0},
            [6] = {34, 0},
            [7] = {-1, 0},
            [8] = {15, 0},
            [10] = {-1, 0},
            [11] = {15, 0}
        },
        [-1667301416] = {
            [1] = {-1, 0},
            [3] = {15, 0},
            [4] = {15, 0},
            [5] = {-1, 0},
            [6] = {35, 0},
            [7] = {-1, 0},
            [8] = {6, 0},
            [9] = {-1, 0},
            [10] = {-1, 0},
            [11] = {15, 0}
        }
    },
    parts = {
        [1] = { componentID = 0, cammode = "face" }, -- defeitos
        [2] = { componentID = 1, cammode = "face" }, -- barba
        [3] = { componentID = 2, cammode = "face" }, -- sobranchelhas
        [4] = { componentID = 3, cammode = "face" }, -- envelhecimento
        [5] = { componentID = 4, cammode = "face" }, -- maquiagem
        [6] = { componentID = 5, cammode = "face" }, -- blush
        [7] = { componentID = 6, cammode = "face" }, -- rugas
        [8] = { componentID = 8, cammode = "face" }, -- batom
        [9] = { componentID = 9, cammode = "face" }, -- sardas
        [10] = { componentID = 10, cammode = "body" }, -- cabelopeito
        [11] = { componentID = 12, cammode = "face" }, -- cabelo
    },
}

-- ./assets/tattoo/partsM/head/mpbeach_overlays/MP_Bea_M_Neck_000.jpg

Config.photo.tattooshop = {
    command = "tattoophoto",
    coords = {
        front = vector4(-1843.85,-1250.8,8.62,320.00),
        back = vector4(-1843.85,-1250.8,8.62,130.00)
    },
    clothes = {
        [1885233650] = {
            [1] = {-1, 0},
            [3] = {15, 0},
            [4] = {21, 0},
            [5] = {-1, 0},
            [6] = {34, 0},
            [7] = {-1, 0},
            [8] = {15, 0},
            [10] = {-1, 0},
            [11] = {15, 0}
        },
        [-1667301416] = {
            [1] = {-1, 0},
            [3] = {15, 0},
            [4] = {15, 0},
            [5] = {-1, 0},
            [6] = {35, 0},
            [7] = {-1, 0},
            [8] = {6, 0},
            [9] = {-1, 0},
            [10] = {-1, 0},
            [11] = {15, 0}
        }
    },
    parts = {
        [1] = {
            partName = "torso",
            cammode = "body",
            tattoos = {
                {name = 'MP_Airraces_Tattoo_000_M', cname = 'Turbulence', part = 'mpairraces_overlays', price = 500},                
                {name = 'MP_Airraces_Tattoo_001_M', cammode = "back", cname = 'Pilot Skull', part = 'mpairraces_overlays', price = 500},
                {name = 'MP_Airraces_Tattoo_002_M', cammode = "back", cname = 'Winged Bombshell', part = 'mpairraces_overlays', price = 500},
                {name = 'MP_Airraces_Tattoo_004_M', cammode = "back", cname = 'Balloon Pioneer', part = 'mpairraces_overlays', price = 500},
                {name = 'MP_Airraces_Tattoo_005_M', cammode = "back", cname = 'Parachute Belle', part = 'mpairraces_overlays', price = 500},
                {name = 'MP_Airraces_Tattoo_006_M', cammode = "body", cname = 'Bombs Away', part = 'mpairraces_overlays', price = 500},
                {name = 'MP_Airraces_Tattoo_007_M', cname = 'Eagle Eyes', part = 'mpairraces_overlays', price = 500},

                {name = 'MP_Bea_M_Back_000', cname = 'Ship Arms', part = 'mpbeach_overlays', price = 500},
                {name = 'MP_Bea_M_Chest_000', cname = 'Tribal Hammerhead', part = 'mpbeach_overlays', price = 500},
                {name = 'MP_Bea_M_Chest_001', cname = 'Tribal Shark', part = 'mpbeach_overlays', price = 500},
                {name = 'MP_Bea_M_Stom_000', cname = 'Swordfish', part = 'mpbeach_overlays', price = 500},
                {name = 'MP_Bea_M_Stom_001', cname = 'Wheel', part = 'mpbeach_overlays', price = 500},

                {name = 'MP_MP_Biker_Tat_000_M', cname = 'Demon Rider', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_001_M', cname = 'Both Barrels', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_003_M', cname = 'Web Rider', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_005_M', cname = 'Made In America', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_006_M', cname = 'Chopper Freedom', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_008_M', cname = 'Freedom Wheels', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_010_M', cname = 'Skull Of Taurus', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_011_M', cname = 'R.I.P. My Brothers', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_013_M', cname = 'Demon Crossbones', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_017_M', cname = 'Clawed Beast', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_018_M', cname = 'Skeletal Chopper', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_019_M', cname = 'Gruesome Talons', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_021_M', cname = 'Flaming Reaper', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_023_M', cname = 'Western MC', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_026_M', cname = 'American Dream', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_029_M', cname = 'Bone Wrench', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_030_M', cname = 'Brothers For Life', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_031_M', cname = 'Gear Head', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_032_M', cname = 'Western Eagle', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_034_M', cname = 'Brotherhood of Bikes', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_039_M', cname = 'Gas Guzzler', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_041_M', cname = 'No Regrets', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_043_M', cname = 'Ride Forever', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_050_M', cname = 'Unforgiven', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_052_M', cname = 'Biker Mount', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_058_M', cname = 'Reaper Vulture', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_059_M', cname = 'Faggio', part = 'mpbiker_overlays', price = 500},
                {name = 'MP_MP_Biker_Tat_060_M', cname = 'We Are The Mods!', part = 'mpbiker_overlays', price = 500},

                {name = 'MP_Buis_M_Stomach_000', cname = 'Refined Hustler', part = 'mpbusiness_overlays', price = 500},
                {name = 'MP_Buis_M_Chest_000', cname = 'Rich', part = 'mpbusiness_overlays', price = 500},
                {name = 'MP_Buis_M_Chest_001', cname = '$$$', part = 'mpbusiness_overlays', price = 500},
                {name = 'MP_Buis_M_Back_000', cname = 'Makin Paper', part = 'mpbusiness_overlays', price = 500},
                
                {name = 'MP_Christmas2017_Tattoo_000_M', cname = 'Thor & Goblin', part = 'mpchristmas2017_overlays', price = 500},
                {name = 'MP_Christmas2017_Tattoo_002_M', cname = 'Kabuto', part = 'mpchristmas2017_overlays', price = 500},
                {name = 'MP_Christmas2017_Tattoo_003_M', cname = 'Native Warrior', part = 'mpchristmas2017_overlays', price = 500},
                {name = 'MP_Christmas2017_Tattoo_005_M', cname = 'Ghost Dragon', part = 'mpchristmas2017_overlays', price = 500},
                {name = 'MP_Christmas2017_Tattoo_008_M', cname = 'Spartan Warrior', part = 'mpchristmas2017_overlays', price = 500},
                {name = 'MP_Christmas2017_Tattoo_009_M', cname = 'Norse Rune', part = 'mpchristmas2017_overlays', price = 500},
                {name = 'MP_Christmas2017_Tattoo_010_M', cname = 'Spartan Shield', part = 'mpchristmas2017_overlays', price = 500},
                {name = 'MP_Christmas2017_Tattoo_011_M', cname = 'Weathered Skull', part = 'mpchristmas2017_overlays', price = 500},
                {name = 'MP_Christmas2017_Tattoo_015_M', cname = 'Samurai Combat', part = 'mpchristmas2017_overlays', price = 500},
                {name = 'MP_Christmas2017_Tattoo_016_M', cname = 'Odin & Raven', part = 'mpchristmas2017_overlays', price = 500},
                {name = 'MP_Christmas2017_Tattoo_019_M', cname = 'Strike Force', part = 'mpchristmas2017_overlays', price = 500},
                {name = 'MP_Christmas2017_Tattoo_020_M', cname = 'Medusa Gaze', part = 'mpchristmas2017_overlays', price = 500},
                {name = 'MP_Christmas2017_Tattoo_021_M', cname = 'Spartan & Lion', part = 'mpchristmas2017_overlays', price = 500},
                {name = 'MP_Christmas2017_Tattoo_022_M', cname = 'Spartan & Horse', part = 'mpchristmas2017_overlays', price = 500},
                {name = 'MP_Christmas2017_Tattoo_024_M', cname = 'Dragon Slayer', part = 'mpchristmas2017_overlays', price = 500},
                {name = 'MP_Christmas2017_Tattoo_026_M', cname = 'Spartan Skull', part = 'mpchristmas2017_overlays', price = 500},
                {name = 'MP_Christmas2017_Tattoo_027_M', cname = 'Molon Labe', part = 'mpchristmas2017_overlays', price = 500},

                {name = 'MP_Christmas2018_Tat_000_M', cname = '????', part = 'mpchristmas2018_overlays', price = 500},
                
                {name = 'MP_Xmas2_M_Tat_005', cname = 'Carp Outline', part = 'mpchristmas2_overlays', price = 500},
                {name = 'MP_Xmas2_M_Tat_006', cname = 'Carp Shaded', part = 'mpchristmas2_overlays', price = 500},
                {name = 'MP_Xmas2_M_Tat_009', cname = 'Time To Die', part = 'mpchristmas2_overlays', price = 500},
                {name = 'MP_Xmas2_M_Tat_011', cname = 'Roaring Tiger', part = 'mpchristmas2_overlays', price = 500},
                {name = 'MP_Xmas2_M_Tat_013', cname = 'Lizard', part = 'mpchristmas2_overlays', price = 500},
                {name = 'MP_Xmas2_M_Tat_015', cname = 'Japanese Warrior', part = 'mpchristmas2_overlays', price = 500},
                {name = 'MP_Xmas2_M_Tat_016', cname = 'Loose Lips Outline', part = 'mpchristmas2_overlays', price = 500},
                {name = 'MP_Xmas2_M_Tat_017', cname = 'Loose Lips Color', part = 'mpchristmas2_overlays', price = 500},
                {name = 'MP_Xmas2_M_Tat_018', cname = 'Royal Dagger Outline', part = 'mpchristmas2_overlays', price = 500},
                {name = 'MP_Xmas2_M_Tat_019', cname = 'Royal Dagger Color', part = 'mpchristmas2_overlays', price = 500},
                {name = 'MP_Xmas2_M_Tat_028', cname = 'Executioner', part = 'mpchristmas2_overlays', price = 500},

                {name = 'MP_Gunrunning_Tattoo_000_M', cname = 'Bullet Proof', part = 'mpgunrunning_overlays', price = 500},
                {name = 'MP_Gunrunning_Tattoo_001_M', cname = 'Crossed Weapons', part = 'mpgunrunning_overlays', price = 500},
                {name = 'MP_Gunrunning_Tattoo_009_M', cname = 'Butterfly Knife', part = 'mpgunrunning_overlays', price = 500},
                {name = 'MP_Gunrunning_Tattoo_010_M', cname = 'Cash Money', part = 'mpgunrunning_overlays', price = 500},
                {name = 'MP_Gunrunning_Tattoo_012_M', cname = 'Dollar Daggers', part = 'mpgunrunning_overlays', price = 500},
                {name = 'MP_Gunrunning_Tattoo_013_M', cname = 'Wolf Insignia', part = 'mpgunrunning_overlays', price = 500},
                {name = 'MP_Gunrunning_Tattoo_014_M', cname = 'Backstabber', part = 'mpgunrunning_overlays', price = 500},
                {name = 'MP_Gunrunning_Tattoo_017_M', cname = 'Dog Tags', part = 'mpgunrunning_overlays', price = 500},
                {name = 'MP_Gunrunning_Tattoo_018_M', cname = 'Dual Wield Skull', part = 'mpgunrunning_overlays', price = 500},
                {name = 'MP_Gunrunning_Tattoo_019_M', cname = 'Pistol Wings', part = 'mpgunrunning_overlays', price = 500},
                {name = 'MP_Gunrunning_Tattoo_020_M', cname = 'Crowned Weapons', part = 'mpgunrunning_overlays', price = 500},
                {name = 'MP_Gunrunning_Tattoo_022_M', cname = 'Explosive Heart', part = 'mpgunrunning_overlays', price = 500},
                {name = 'MP_Gunrunning_Tattoo_028_M', cname = 'Micro SMG Chain', part = 'mpgunrunning_overlays', price = 500},
                {name = 'MP_Gunrunning_Tattoo_029_M', cname = 'Win Some Lose Some', part = 'mpgunrunning_overlays', price = 500},

                {name = 'FM_Hip_M_Tat_000', cname = 'Crossed Arrows', part = 'mphipster_overlays', price = 500},
                {name = 'FM_Hip_M_Tat_002', cname = 'Chemistry', part = 'mphipster_overlays', price = 500},
                {name = 'FM_Hip_M_Tat_006', cname = 'Feather Birds', part = 'mphipster_overlays', price = 500},
                {name = 'FM_Hip_M_Tat_011', cname = 'Infinity', part = 'mphipster_overlays', price = 500},
                {name = 'FM_Hip_M_Tat_012', cname = 'Antlers', part = 'mphipster_overlays', price = 500},
                {name = 'FM_Hip_M_Tat_013', cname = 'Boombox', part = 'mphipster_overlays', price = 500},
                {name = 'FM_Hip_M_Tat_024', cname = 'Pyramid', part = 'mphipster_overlays', price = 500},
                {name = 'FM_Hip_M_Tat_025', cname = 'Watch Your Step', part = 'mphipster_overlays', price = 500},
                {name = 'FM_Hip_M_Tat_029', cname = 'Sad', part = 'mphipster_overlays', price = 500},
                {name = 'FM_Hip_M_Tat_030', cname = 'Shark Fin', part = 'mphipster_overlays', price = 500},
                {name = 'FM_Hip_M_Tat_031', cname = 'Skateboard', part = 'mphipster_overlays', price = 500},
                {name = 'FM_Hip_M_Tat_032', cname = 'Paper Plane', part = 'mphipster_overlays', price = 500},
                {name = 'FM_Hip_M_Tat_033', cname = 'Stag', part = 'mphipster_overlays', price = 500},
                {name = 'FM_Hip_M_Tat_035', cname = 'Sewn Heart', part = 'mphipster_overlays', price = 500},
                {name = 'FM_Hip_M_Tat_041', cname = 'Tooth', part = 'mphipster_overlays', price = 500},
                {name = 'FM_Hip_M_Tat_046', cname = 'Triangles', part = 'mphipster_overlays', price = 500},
                {name = 'FM_Hip_M_Tat_047', cname = 'Cassette', part = 'mphipster_overlays', price = 500},

                {name = 'MP_MP_ImportExport_Tat_000_M', cname = 'Block Back', part = 'mpimportexport_overlays', price = 500},
                {name = 'MP_MP_ImportExport_Tat_001_M', cname = 'Power Plant', part = 'mpimportexport_overlays', price = 500},
                {name = 'MP_MP_ImportExport_Tat_002_M', cname = 'Tuned to Death', part = 'mpimportexport_overlays', price = 500},
                {name = 'MP_MP_ImportExport_Tat_009_M', cname = 'Serpents of Destruction', part = 'mpimportexport_overlays', price = 500},
                {name = 'MP_MP_ImportExport_Tat_010_M', cname = 'Take the Wheel', part = 'mpimportexport_overlays', price = 500},
                {name = 'MP_MP_ImportExport_Tat_011_M', cname = 'Talk Shit Get Hit', part = 'mpimportexport_overlays', price = 500},

                {name = 'MP_LR_Tat_000_M', cname = 'SA Assault', part = 'mplowrider2_overlays', price = 500},
                {name = 'MP_LR_Tat_008_M', cname = 'Love the Game', part = 'mplowrider2_overlays', price = 500},
                {name = 'MP_LR_Tat_011_M', cname = 'Lady Liberty', part = 'mplowrider2_overlays', price = 500},
                {name = 'MP_LR_Tat_012_M', cname = 'Royal Kiss', part = 'mplowrider2_overlays', price = 500},
                {name = 'MP_LR_Tat_016_M', cname = 'Two Face', part = 'mplowrider2_overlays', price = 500},
                {name = 'MP_LR_Tat_019_M', cname = 'Death Behind', part = 'mplowrider2_overlays', price = 500},
                {name = 'MP_LR_Tat_031_M', cname = 'Dead Pretty', part = 'mplowrider2_overlays', price = 500},
                {name = 'MP_LR_Tat_032_M', cname = 'Reign Over', part = 'mplowrider2_overlays', price = 500},

                {name = 'MP_LR_Tat_001_M', cname = 'King Fight', part = 'mplowrider_overlays', price = 500},
                {name = 'MP_LR_Tat_002_M', cname = 'Holy Mary', part = 'mplowrider_overlays', price = 500},
                {name = 'MP_LR_Tat_004_M', cname = 'Gun Mic', part = 'mplowrider_overlays', price = 500},
                {name = 'MP_LR_Tat_009_M', cname = 'Amazon', part = 'mplowrider_overlays', price = 500},
                {name = 'MP_LR_Tat_010_M', cname = 'Bad Angel', part = 'mplowrider_overlays', price = 500},
                {name = 'MP_LR_Tat_013_M', cname = 'Love Gamble', part = 'mplowrider_overlays', price = 500},
                {name = 'MP_LR_Tat_014_M', cname = 'Love is Blind', part = 'mplowrider_overlays', price = 500},
                {name = 'MP_LR_Tat_021_M', cname = 'Sad Angel', part = 'mplowrider_overlays', price = 500},
                {name = 'MP_LR_Tat_026_M', cname = 'Royal Takeover', part = 'mplowrider_overlays', price = 500},

                {name = 'MP_LUXE_TAT_002_M', cname = 'The Howler', part = 'mpluxe2_overlays', price = 500},
                {name = 'MP_LUXE_TAT_012_M', cname = 'Geometric Galaxy', part = 'mpluxe2_overlays', price = 500},
                {name = 'MP_LUXE_TAT_022_M', cname = 'Cloaked Angel', part = 'mpluxe2_overlays', price = 500},
                {name = 'MP_LUXE_TAT_025_M', cname = 'Reaper Sway', part = 'mpluxe2_overlays', price = 500},
                {name = 'MP_LUXE_TAT_027_M', cname = 'Cobra Dawn', part = 'mpluxe2_overlays', price = 500},
                {name = 'MP_LUXE_TAT_029_M', cname = 'Geometric Design', part = 'mpluxe2_overlays', price = 500},

                {name = 'MP_LUXE_TAT_003_M', cname = 'Abstract Skull', part = 'mpluxe_overlays', price = 500},
                {name = 'MP_LUXE_TAT_006_M', cname = 'Adorned Wolf', part = 'mpluxe_overlays', price = 500},
                {name = 'MP_LUXE_TAT_007_M', cname = 'Eye of the Griffin', part = 'mpluxe_overlays', price = 500},
                {name = 'MP_LUXE_TAT_008_M', cname = 'Flying Eye', part = 'mpluxe_overlays', price = 500},
                {name = 'MP_LUXE_TAT_014_M', cname = 'Ancient Queen', part = 'mpluxe_overlays', price = 500},
                {name = 'MP_LUXE_TAT_015_M', cname = 'Smoking Sisters', part = 'mpluxe_overlays', price = 500},
                {name = 'MP_LUXE_TAT_024_M', cname = 'Feather Mural', part = 'mpluxe_overlays', price = 500},


                {name = 'MP_Smuggler_Tattoo_000_M', cname = 'Bless The Dead', part = 'mpsmuggler_overlays', price = 500},
                {name = 'MP_Smuggler_Tattoo_002_M', cname = 'Dead Lies', part = 'mpsmuggler_overlays', price = 500},
                {name = 'MP_Smuggler_Tattoo_003_M', cname = 'Give Nothing Back', part = 'mpsmuggler_overlays', price = 500},
                {name = 'MP_Smuggler_Tattoo_006_M', cname = 'Never Surrender', part = 'mpsmuggler_overlays', price = 500},
                {name = 'MP_Smuggler_Tattoo_007_M', cname = 'No Honor', part = 'mpsmuggler_overlays', price = 500},
                {name = 'MP_Smuggler_Tattoo_009_M', cname = 'Tall Ship Conflict', part = 'mpsmuggler_overlays', price = 500},
                {name = 'MP_Smuggler_Tattoo_010_M', cname = 'See You In Hell', part = 'mpsmuggler_overlays', price = 500},
                {name = 'MP_Smuggler_Tattoo_013_M', cname = 'Torn Wings', part = 'mpsmuggler_overlays', price = 500},
                {name = 'MP_Smuggler_Tattoo_015_M', cname = 'Jolly Roger', part = 'mpsmuggler_overlays', price = 500},
                {name = 'MP_Smuggler_Tattoo_016_M', cname = 'Skull Compass', part = 'mpsmuggler_overlays', price = 500},
                {name = 'MP_Smuggler_Tattoo_017_M', cname = 'Framed Tall Ship', part = 'mpsmuggler_overlays', price = 500},
                {name = 'MP_Smuggler_Tattoo_018_M', cname = 'Finders Keepers', part = 'mpsmuggler_overlays', price = 500},
                {name = 'MP_Smuggler_Tattoo_019_M', cname = 'Lost At Sea', part = 'mpsmuggler_overlays', price = 500},
                {name = 'MP_Smuggler_Tattoo_021_M', cname = 'Dead Tales', part = 'mpsmuggler_overlays', price = 500},
                {name = 'MP_Smuggler_Tattoo_022_M', cname = 'X Marks The Spot', part = 'mpsmuggler_overlays', price = 500},
                {name = 'MP_Smuggler_Tattoo_024_M', cname = 'Pirate Captain', part = 'mpsmuggler_overlays', price = 500},
                {name = 'MP_Smuggler_Tattoo_025_M', cname = 'Claimed By The Beast', part = 'mpsmuggler_overlays', price = 500},


                {name = 'MP_MP_Stunt_tat_011_M', cname = 'Wheels of Death', part = 'mpstunt_overlays', price = 500},
                {name = 'MP_MP_Stunt_tat_012_M', cname = 'Punk Biker', part = 'mpstunt_overlays', price = 500},
                {name = 'MP_MP_Stunt_tat_014_M', cname = 'Bat Cat of Spades', part = 'mpstunt_overlays', price = 500},
                {name = 'MP_MP_Stunt_tat_018_M', cname = 'Vintage Bully', part = 'mpstunt_overlays', price = 500},
                {name = 'MP_MP_Stunt_tat_019_M', cname = 'Engine Heart', part = 'mpstunt_overlays', price = 500},
                {name = 'MP_MP_Stunt_tat_024_M', cname = 'Road Kill', part = 'mpstunt_overlays', price = 500},
                {name = 'MP_MP_Stunt_tat_026_M', cname = 'Winged Wheel', part = 'mpstunt_overlays', price = 500},
                {name = 'MP_MP_Stunt_tat_027_M', cname = 'Punk Road Hog', part = 'mpstunt_overlays', price = 500},
                {name = 'MP_MP_Stunt_tat_029_M', cname = 'Majestic Finish', part = 'mpstunt_overlays', price = 500},
                {name = 'MP_MP_Stunt_tat_030_M', cname = "Man's Ruin", part = 'mpstunt_overlays', price = 500},
                {name = 'MP_MP_Stunt_tat_033_M', cname = 'Sugar Skull Trucker', part = 'mpstunt_overlays', price = 500},
                {name = 'MP_MP_Stunt_tat_034_M', cname = 'Feather Road Kill', part = 'mpstunt_overlays', price = 500},
                {name = 'MP_MP_Stunt_tat_037_M', cname = 'Novak Grills', part = 'mpstunt_overlays', price = 500},
                {name = 'MP_MP_Stunt_tat_040_M', cname = 'Monkey Chopper', part = 'mpstunt_overlays', price = 500},
                {name = 'MP_MP_Stunt_tat_041_M', cname = 'Brapp', part = 'mpstunt_overlays', price = 500},
                {name = 'MP_MP_Stunt_tat_044_M', cname = 'Ram Skull', part = 'mpstunt_overlays', price = 500},
                {name = 'MP_MP_Stunt_tat_046_M', cname = 'Full Throttle', part = 'mpstunt_overlays', price = 500},
                {name = 'MP_MP_Stunt_tat_048_M', cname = 'Racing Doll', part = 'mpstunt_overlays', price = 500},

                {name = 'FM_Tat_Award_M_003', cname = 'Blackjack', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_Award_M_004', cname = 'Hustler', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_Award_M_005', cname = 'Angel', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_Award_M_008', cname = 'Los Santos Customs', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_Award_M_011', cname = 'Blank Scroll', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_Award_M_012', cname = 'Embellished Scroll', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_Award_M_013', cname = 'Seven Deadly Sins', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_Award_M_014', cname = 'Trust No One', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_Award_M_016', cname = 'Clown', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_Award_M_017', cname = 'Clown and Gun', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_Award_M_018', cname = 'Clown Dual Wield', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_Award_M_019', cname = 'Clown Dual Wield Dollars', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_M_004', cname = 'Faith', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_M_009', cname = 'kull on the Cross', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_M_010', cname = 'LS Flames', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_M_011', cname = 'LS Script', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_M_012', cname = 'Los Santos Bills', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_M_013', cname = 'Eagle and Serpent', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_M_016', cname = 'Evil Clown', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_M_019', cname = 'The Wages of Sin', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_M_020', cname = 'Dragon', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_M_024', cname = 'Flaming Cross', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_M_025', cname = 'LS Bold', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_M_029', cname = 'Trinity Knot', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_M_030', cname = 'Lucky Celtic Dogs', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_M_034', cname = 'Flaming Shamrock', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_M_036', cname = 'Way of the Gun', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_M_044', cname = 'Stone Cross', part = 'multiplayer_overlays', price = 500},
                {name = 'FM_Tat_M_045', cname = 'Skulls and Rose', part = 'multiplayer_overlays', price = 500},
            }
        }
    }
}

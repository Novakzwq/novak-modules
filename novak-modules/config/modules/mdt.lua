
Config.mdt = {
    openPermission = "staff.permissao", -- PERM PRA ABRIR
    patentes = {
        ["PM"] = {
            [3] = {
                group = "Fundador",
                canChange = "staff.permissao" -- PERMISSAO DE QUEM PODE ALTERAR ESTE CARGO
            },
            [2] = {
                group = "Tenente",
                canChange = "staff.permissao"
            },
            [1] = {
                group = "Soldado",
                canChange = "staff.permissao"
            }
        },
        ["PRF"] = {
            [3] = {
                group = "Fundador2",
                canChange = "staff.permissao" -- PERMISSAO DE QUEM PODE ALTERAR ESTE CARGO
            },
            [2] = {
                group = "TenentePRF",
                canChange = "staff.permissao"
            },
            [1] = {
                group = "SoldadoPRF",
                canChange = "staff.permissao"
            }
        }
    },
    newsTimer = 60, -- 1 minuto
    crimes = {
        { name = "GTA", pena = 20, multa = 2000 },
        { name = "GTA", pena = 20, multa = 2000 },
    },
    exitLocation = { 1850.84,2601.84,45.63 },
    keyLocation = { 1598.17,2554.01,45.62 },
    search = {
        locs = {
            { 1685.89,2553.72,45.57 },
            { 1652.81,2564.38,45.57 },
            { 1634.72,2554.9,45.57 },
            { 1629.9,2564.31,45.57 },
            { 1609.09,2567.06,45.57 },
            { 1609.85,2539.67,45.57 },
            { 1622.45,2507.7,45.57 },
            { 1643.93,2490.75,45.57 },
            { 1667.56,2487.82,45.57 },
            { 1717.93,2526.6,45.57 },
            { 1689.25,2551.14,45.57 },
            { 1695.8,2535.56,45.57 },
            { 1694.72,2507.9,45.57 },
            { 1718.3,2487.82,45.57 },
            { 1630.52,2527.08,45.57 },
            { 1627.07,2539.55,45.57 },
            { 1625.11,2576.0,45.57 }
        },
        chances = {
            key = 100,
            rat = 0,
        },
        trashItens = {
            "mochila",
            "agua"
        }
    },
    prisionPosition = vector3(1680.1,2513.0,45.5),
    prisionCloth = {
        [1885233650] = { --- masculina
            [1] = { 121,0,2 },
            [3] = { 0,0,2 },
            [4] = { 97,19,2 },
            [5] = { -1,0,2 },
            [6] = { 25,0,2 },
            [7] = { 1,0,2 },			
            [8] = { 57,0,2 },
            [9] = { 2,1,2 },
            [10] = { -1,0,2 },
            [11] = { 93,0,2 },		
            ["p0"] = { 10,0 },
            ["p1"] = { 5,0 },
            ["p2"] = { -1,0 },
            ["p6"] = { -1,0 },
            ["p7"] = { -1,0 }
        },
        [-1667301416] = { --- feminina
            [1] = { 121,0 },
            [3] = { 14,0 },
            [4] = { 100,19,2 },
            [5] = { -1,0 },
            [6] = { 25,0 },
            [7] = { 1,0 },			
            [8] = { 34,0 },
            [9] = { -1,0 },
            [10] = { -1,0 },
            [11] = { 84,0 },
            ["p0"] = { 10,0 },
            ["p1"] = { 11,0 },
            ["p2"] = { -1,0 },
            ["p6"] = { -1,0 },
            ["p7"] = { -1,0 }
        }  
    }
}
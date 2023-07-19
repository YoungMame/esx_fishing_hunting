--Fishing Part

Config = {}

Config.showZones = true
Config.timeToWait = 1*1000 -- time waiting beetwen math.random, if success then fish is found
Config.timeToGrab = 5*1000 -- time available to get the fish
Config.hideZoneOnMiniMap = false
Config.Shop = {
    pos = vector3(868.8, -1639.7, 30.3),
    heading = 100.0,
    ped = 's_m_m_migrant_01',
    pedName = 'Fridgit',
    items = {
        ['salmon'] = {string = "Saumon", price = 90, badge = nil, rlabel = "90$"}, -- ne pas toucher badge
        ['trout'] = {string = "Truite", price = 67, badge = nil, rlabel = "67$"},
        ['mackerel'] = {string = "Maquereau", price = 55, badge = nil, rlabel = '55$'},
        ['anchovy'] = {string = "Anchois", price = 60, badge = nil, rlabel = "60$"},
        ['lray'] = {string = "Raie petite", price = 150, badge = nil, rlabel = "150$"},
    },
    blip = {
        sprite = 792,
        color = 0,
        scale = 0.6,
        string = "Fridgit"
    }
}
Config.blip = {
    sprite = 68,
    color = 0,
    string = 'Zone de pêche'
}

Config.Zones = { 
    ['gordo'] = {position = vector3(3926.0, 4890.0, 1.0), items = {{name = "mackerel", chance = 10}, {name = "lray", chance = 2}, {name = "anchovy", chance = 10}, {name = "salmon", chance = 4}}, radius = 250.0},
    ['sandy'] = {position = vector3(524.5, 3820.9, 30.5), items = {{name = "salmon", chance = 3}, {name = "trout", chance = 10}}, radius = 200.0}
}

-----Hunting part

Config.Hunting = {
    Shop = {
        pos = vector3(961.4, -2108.6, 31.95),
        heading = 70.0,
        ped = 's_m_m_migrant_01',
        pedName = 'Abbatoir Raven',
        items = {
            ['mtlionfur'] = {string = "Fourrure de lion de montagne", price = 250,  rlabel = "250$"},
            ['gamemeat'] = {string = "Viande de cerf", price = 85,  rlabel = "85$"},
            ['boarmeat'] = {string = "Viande de sanglier", price = 110,  rlabel = '110$'},
            ['rabbitmeat'] = {string = "Viande de lapin", price = 30,  rlabel = "30$"},
            ['porkmeat'] = {string = "Viande de porc", price = 70,  rlabel = "70$"},
            ['chickenmeat'] = {string = "Viande de poulet", price = 35,  rlabel = "35$"},
            ['cormorantmeat'] = {string = "Viande de corman", price = 40,  rlabel = "40$"},
            ['cowmeat'] = {string = "Viande de boeuf", price = 150,  rlabel = "150$"}
        },
        blip = {
            sprite = 792,
            color = 0,
            scale = 0.6,
            string = "Abbatoir Raven"
        }
    },
    hideZoneOnMiniMap = false,
    blip = {
        sprite = 442,
        color = 62,
        string = 'Zone de chasse'
    },
    coords = vector3(-937.9, 4928.5, 224.85),
    radius = 400.0,
    Animals = {
        ['a_c_mtlion'] = 'mtlionfur',
        ['a_c_deer'] = 'gamemeat',
        ['a_c_boar'] = 'boarmeat',
        ['a_c_rabbit_01'] = 'rabbitmeat',
        ['a_c_pig'] = 'porkmeat',
        ['a_c_hen'] = 'chickenmeat',
        ['a_c_cormorant'] = 'cormorantmeat',
        ['a_c_cow'] =  'cowmeat'
    }
} 

-- Comment tu vas mon quoicoupote, ta les crampters ? Apagnan.
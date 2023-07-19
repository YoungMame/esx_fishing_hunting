fx_version 'adamant'

game 'gta5'

author 'Young F*cking Mame'

version '1.0.0'

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

shared_script {
    'config.lua'
}
fx_version 'cerulean'
game 'gta5'
description 'Random Events'
author 'Abel Gaming'
version '1.0'

server_scripts {
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/main.lua',
	'client/functions.lua',
	'client/events.lua',
	'client/menu.lua'
}

client_script '@warmenu/warmenu.lua' -- https://github.com/warxander/warmenu
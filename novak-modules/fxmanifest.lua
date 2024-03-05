fx_version "adamant"
game "gta5" 

author "Novak (https://novakdev.com.br) <novakdev@novakdev.com.br>"

shared_scripts{
   "config/main.lua",
   "config/modules/*.lua"
}

server_scripts {
   "@vrp/lib/utils.lua",
   "src/server/main.lua",
   "src/server/modules/**",
   "src/server/functions/**"
}

client_scripts {
   "@vrp/lib/utils.lua",
   "src/client/main.lua",
   "src/client/modules/**"
}

files {
   "src/public/**",
}

ui_page "src/public/index.html"

client_script "@rebla_anticheat/src/shared/modules/lib.lua"
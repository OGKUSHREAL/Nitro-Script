local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPclient = Tunnel.getInterface("vRP", "nitro") 
vRP = Proxy.getInterface("vRP")

local activeCars = {}

vRP.defInventoryItem({Config.NitroItem.Spawn,Config.NitroItem.label,Config.NitroItem.Desc, function(args)

    local choices = {}
    choices[Config.NitroItem.Choice] = {function(player,choice,mod)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
            vRP.tryGetInventoryItem({user_id,Config.NitroItem.Spawn,1})
            TriggerClientEvent('nitro:activated', source)
            vRP.closeMenu({player})
        end
    end}

    return choices
end, 0.5})

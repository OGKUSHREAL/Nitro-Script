local nitro = 0
local nitroUsed = false
local nitroveh = nil
local soundofnitro
local sound = false
local exhausts = {}
local engineon

function notify(type, msg)
  if Config.Notify then
  exports['mythic_notify']:SendAlert(type, msg)
  else
    TriggerEvent("pNotify:SendNotification",{text = msg,type = type,timeout = (1500),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}}) 
   end
end

function progres(time, msg)
  exports['progressBars']:startUI(time, msg)
end

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
    N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - 0.1+w, y - 0.02+h)
end

function flame (veh, count)
  if exhausts then
    if not HasNamedPtfxAssetLoaded("core") then
      RequestNamedPtfxAsset("core")
      while not HasNamedPtfxAssetLoaded("core") do
        Wait(1)
      end
    end
    if count == 1 then
      UseParticleFxAssetNextCall("core")
      fire = StartParticleFxLoopedOnEntityBone_2("veh_backfire", veh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, exhausts[1], 1.0, 0, 0, 0)
      Wait(0)
      StopParticleFxLooped(fire, false)
    elseif count == 2 then
      UseParticleFxAssetNextCall("core")
      fire = StartParticleFxLoopedOnEntityBone_2("veh_backfire", veh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, exhausts[1], 1.0, 0, 0, 0)
      UseParticleFxAssetNextCall("core")
      fire2 = StartParticleFxLoopedOnEntityBone_2("veh_backfire", veh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, exhausts[2], 1.0, 0, 0, 0)
      Wait(0)
      StopParticleFxLooped(fire, false)
      StopParticleFxLooped(fire2, false)
    elseif count == 3 then
      UseParticleFxAssetNextCall("core")
      fire = StartParticleFxLoopedOnEntityBone_2("veh_backfire", veh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, exhausts[1], 1.0, 0, 0, 0)
      UseParticleFxAssetNextCall("core")
      fire2 = StartParticleFxLoopedOnEntityBone_2("veh_backfire", veh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, exhausts[2], 1.0, 0, 0, 0)
      UseParticleFxAssetNextCall("core")
      fire3 = StartParticleFxLoopedOnEntityBone_2("veh_backfire", veh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, exhausts[3], 1.0, 0, 0, 0)
      Wait(0)
      StopParticleFxLooped(fire, false)
      StopParticleFxLooped(fire2, false)
      StopParticleFxLooped(fire3, false)
    elseif count == 4 then
      UseParticleFxAssetNextCall("core")
      fire = StartParticleFxLoopedOnEntityBone_2("veh_backfire", veh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, exhausts[1], 1.0, 0, 0, 0)
      UseParticleFxAssetNextCall("core")
      fire2 = StartParticleFxLoopedOnEntityBone_2("veh_backfire", veh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, exhausts[2], 1.0, 0, 0, 0)
      UseParticleFxAssetNextCall("core")
      fire3 = StartParticleFxLoopedOnEntityBone_2("veh_backfire", veh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, exhausts[3], 1.0, 0, 0, 0)
      UseParticleFxAssetNextCall("core")
      fire4 = StartParticleFxLoopedOnEntityBone_2("veh_backfire", veh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, exhausts[4], 1.0, 0, 0, 0)
      Wait(0)
      StopParticleFxLooped(fire, false)
      StopParticleFxLooped(fire2, false)
      StopParticleFxLooped(fire3, false)
      StopParticleFxLooped(fire4, false)
    end
  end
end

Citizen.CreateThread(function()
  while true do
    Wait(0)

    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)

    if engineon == false then
      SetVehicleEngineOn(veh, false, false, false)
      SetVehicleUndriveable(veh, false, false, false)
    end

    if GetPedInVehicleSeat(veh, -1) == ped then
     DrawAdvancedText(0.08, 0.7845, 0.150, 0.0028, 0.4, "~b~Nitro  ~s~" .. nitro, 255, 255, 255, 255, 6, 1)
    end

    if IsControlPressed(0, Config.Hotkey) and GetPedInVehicleSeat(veh, -1) == ped and nitro > 0 then
      Citizen.InvokeNative(0xB59E4BD37AE292DB, veh, 5.0)
      Citizen.InvokeNative(0x93A3996368C94158, veh, 25.0)
      nitroUsed = true

      if sound == false then
        soundofnitro = PlaySoundFromEntity(GetSoundId(), "Flare", veh, "DLC_HEISTS_BIOLAB_FINALE_SOUNDS", 0, 0)
        sound = true
      end
    else
      nitroUsed = false
      Citizen.InvokeNative(0xB59E4BD37AE292DB, veh, 1.0)
      Citizen.InvokeNative(0x93A3996368C94158, veh, 1.0)

      if sound == true then
        StopSound(soundofnitro)
        ReleaseSoundId(soundofnitro)
        sound = false
      end
    end
  end
end)


-- nitro status
Citizen.CreateThread(function()
  while true do
    Wait(0)

    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)
    local hash = GetEntityModel(veh)

    if nitroUsed then
      Wait(Config.consumption)
      nitro = nitro - 1
    end

    if IsThisModelACar(hash) and veh ~= nitroveh then
        exhausts = {}

        for i=1,12 do

          local exhaust = GetEntityBoneIndexByName(veh, "exhaust_" .. i)

          if i == 1 and GetEntityBoneIndexByName(veh, "exhaust") ~= -1 then
            table.insert(exhausts, GetEntityBoneIndexByName(veh, "exhaust"))
          end
          if exhaust ~= -1 then
            table.insert(exhausts, exhaust)
          end
        end
    end

  end
end)

-- exhaust flames
Citizen.CreateThread(function()
  while true do
    Wait(10)
    if nitroUsed then

      local ped = GetPlayerPed(-1)
      local veh = GetVehiclePedIsIn(ped, false)

      if exhausts ~= {} then
        flame(veh, #exhausts)
      end

    end
  end
end)

RegisterNetEvent('nitro:check')
AddEventHandler('nitro:check', function()
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsIn(ped, false)
  local hash = GetEntityModel(veh)
  if GetEntitySpeed(veh)>0.1 then notify('error', 'Bilen skal holde stille'); return end
  if veh and IsThisModelACar(hash) then
  else
    notify('inform', 'Du skal være i et køretøj for at installere nitro!')
  end
end)

RegisterNetEvent('nitro:activated')
AddEventHandler('nitro:activated', function()
  local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)

  FreezeEntityPosition(veh, true)
  SetVehicleDoorOpen(veh, 4, 0, 0)
  progres(10100, 'Installere Nitro')
  engineon = false
  Wait(3000)
  PlaySoundFromEntity(-1, "Bar_Unlock_And_Raise", veh, "DLC_IND_ROLLERCOASTER_SOUNDS", 0, 0)
  Wait(4000)
  SetAudioFlag("LoadMPData", true)
  PlaySoundFrontend(-1, "Lowrider_Upgrade", "Lowrider_Super_Mod_Garage_Sounds", 1)
  Wait(3000)
  SetVehicleDoorShut(veh, 4, 0)
  FreezeEntityPosition(veh, false)
  notify('success', 'Installeret Nitro! [LEFT SHIFT] For at bruge det')
  engineon = true
  nitro = 100
end)

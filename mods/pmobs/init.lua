
-- Animals

dofile(minetest.get_modpath("pmobs").."/wolf.lua") -- KrupnoPavel
dofile(minetest.get_modpath("pmobs").."/dog.lua") -- CProgrammerRU

-- Monsters

dofile(minetest.get_modpath("pmobs").."/ninja.lua") -- CProgrammerRU
dofile(minetest.get_modpath("pmobs").."/yeti.lua") -- TenPlus1

-- NPC
dofile(minetest.get_modpath("pmobs").."/npc.lua") -- TenPlus1
dofile(minetest.get_modpath("pmobs").."/npc_women.lua") -- CProgrammerRU (texture by TenPlus1)
dofile(minetest.get_modpath("pmobs").."/npc_nurse.lua") -- CProgrammerRU
dofile(minetest.get_modpath("pmobs").."/guard.lua") -- CProgrammerRU
dofile(minetest.get_modpath("pmobs").."/archer.lua") -- CProgrammerRU

dofile(minetest.get_modpath("pmobs").."/throwing.lua")
dofile(minetest.get_modpath("pmobs").."/arrow.lua")
dofile(minetest.get_modpath("pmobs").."/fire_arrow.lua")


if minetest.setting_get("log_mods") then
	minetest.log("action", "pmobs loaded")
end


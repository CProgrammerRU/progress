minetest.register_node("hell:rack", {
	description = "Hell Rack",
	tiles = {"hell_rack.png"},
	is_ground_content = true,
	groups = {cracky=3,level=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("hell:glowstone", {
	description = "Glowstone",
	tiles = {"hell_glowstone.png"},
	is_ground_content = true,
	light_source = 13,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("hell:portal", {
	description = "Hell Portal",
	tiles = {"hell_portal.png", "default_obsidian.png"},
	is_ground_content = true,
	groups = {cracky=3,level=2},
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		hell.switch_creature_hell(player)
		player:setpos({x=pointed_thing.under.x, y=player:getpos().y, z=pointed_thing.under.z})
		player:set_physics_override({speed=0, gravity=0})
		local playerpos = player:getpos()
		minetest.after(2, function()
			if hell.is_hell_pos(playerpos) then
				minetest.set_node({x=playerpos.x+1, y=playerpos.y, z=playerpos.z}, {name = "default:obsidian"})
				minetest.set_node({x=playerpos.x-1, y=playerpos.y, z=playerpos.z}, {name = "default:obsidian"})
				minetest.set_node({x=playerpos.x+1, y=playerpos.y, z=playerpos.z+1}, {name = "default:obsidian"})
				minetest.set_node({x=playerpos.x-1, y=playerpos.y, z=playerpos.z-1}, {name = "default:obsidian"})
				minetest.set_node({x=playerpos.x+1, y=playerpos.y, z=playerpos.z-1}, {name = "default:obsidian"})
				minetest.set_node({x=playerpos.x-1, y=playerpos.y, z=playerpos.z+1}, {name = "default:obsidian"})
				minetest.set_node({x=playerpos.x, y=playerpos.y, z=playerpos.z+1}, {name = "default:obsidian"})
				minetest.set_node({x=playerpos.x, y=playerpos.y, z=playerpos.z-1}, {name = "default:obsidian"})
				minetest.remove_node({x=playerpos.x, y=playerpos.y+1, z=playerpos.z})
				minetest.remove_node({x=playerpos.x, y=playerpos.y+2, z=playerpos.z})
				minetest.remove_node({x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z})
				minetest.remove_node({x=playerpos.x+1, y=playerpos.y+2, z=playerpos.z})
				minetest.remove_node({x=playerpos.x+1, y=playerpos.y+2, z=playerpos.z+1})
				minetest.remove_node({x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z})
				minetest.remove_node({x=playerpos.x-1, y=playerpos.y+2, z=playerpos.z})
				minetest.remove_node({x=playerpos.x, y=playerpos.y+1, z=playerpos.z+1})
				minetest.remove_node({x=playerpos.x, y=playerpos.y+2, z=playerpos.z+1})
				minetest.remove_node({x=playerpos.x, y=playerpos.y+1, z=playerpos.z-1})
				minetest.remove_node({x=playerpos.x, y=playerpos.y+2, z=playerpos.z-1})
				minetest.remove_node({x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1})
				minetest.remove_node({x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z-1})
				minetest.remove_node({x=playerpos.x+1, y=playerpos.y+2, z=playerpos.z+1})
				minetest.remove_node({x=playerpos.x+1, y=playerpos.y+2, z=playerpos.z-1})
				minetest.remove_node({x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z+1})
				minetest.remove_node({x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1})
				minetest.remove_node({x=playerpos.x-1, y=playerpos.y+2, z=playerpos.z+1})
				minetest.remove_node({x=playerpos.x-1, y=playerpos.y+2, z=playerpos.z-1})
				minetest.set_node({x=playerpos.x, y=playerpos.y, z=playerpos.z}, {name = "hell:portal"})
			else
				minetest.set_node({x=playerpos.x+1, y=playerpos.y-1, z=playerpos.z}, {name = "default:obsidian"})
				minetest.set_node({x=playerpos.x-1, y=playerpos.y-1, z=playerpos.z}, {name = "default:obsidian"})
				minetest.set_node({x=playerpos.x+1, y=playerpos.y-1, z=playerpos.z+1}, {name = "default:obsidian"})
				minetest.set_node({x=playerpos.x-1, y=playerpos.y-1, z=playerpos.z-1}, {name = "default:obsidian"})
				minetest.set_node({x=playerpos.x+1, y=playerpos.y-1, z=playerpos.z-1}, {name = "default:obsidian"})
				minetest.set_node({x=playerpos.x-1, y=playerpos.y-1, z=playerpos.z+1}, {name = "default:obsidian"})
				minetest.set_node({x=playerpos.x, y=playerpos.y-1, z=playerpos.z+1}, {name = "default:obsidian"})
				minetest.set_node({x=playerpos.x, y=playerpos.y-1, z=playerpos.z-1}, {name = "default:obsidian"})
				minetest.remove_node({x=playerpos.x, y=playerpos.y, z=playerpos.z})
				minetest.remove_node({x=playerpos.x, y=playerpos.y+1, z=playerpos.z})
				minetest.remove_node({x=playerpos.x+1, y=playerpos.y, z=playerpos.z})
				minetest.remove_node({x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z})
				minetest.remove_node({x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1})
				minetest.remove_node({x=playerpos.x-1, y=playerpos.y, z=playerpos.z})
				minetest.remove_node({x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z})
				minetest.remove_node({x=playerpos.x, y=playerpos.y, z=playerpos.z+1})
				minetest.remove_node({x=playerpos.x, y=playerpos.y+1, z=playerpos.z+1})
				minetest.remove_node({x=playerpos.x, y=playerpos.y, z=playerpos.z-1})
				minetest.remove_node({x=playerpos.x, y=playerpos.y+1, z=playerpos.z-1})
				minetest.remove_node({x=playerpos.x+1, y=playerpos.y, z=playerpos.z+1})
				minetest.remove_node({x=playerpos.x+1, y=playerpos.y, z=playerpos.z-1})
				minetest.remove_node({x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1})
				minetest.remove_node({x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z-1})
				minetest.remove_node({x=playerpos.x-1, y=playerpos.y, z=playerpos.z+1})
				minetest.remove_node({x=playerpos.x-1, y=playerpos.y, z=playerpos.z-1})
				minetest.remove_node({x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z+1})
				minetest.remove_node({x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1})
				minetest.set_node({x=playerpos.x, y=playerpos.y-1, z=playerpos.z}, {name = "hell:portal"})
			end
			if player:getpos() ~= playerpos then
				player:setpos(playerpos)
			end
			player:set_physics_override({speed=1, gravity=1})
		end)
	end,
})


minetest.register_craft({
	output = 'hell:portal',
	recipe = {
		{'stairs:slab_wood'},
		{'default:obsidian'},
	}
})

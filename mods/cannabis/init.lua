minetest.register_node("cannabis:cannabis", {
	description = "Cannabis",
	drawtype = "mesh",
	mesh = "cannabis.obj",
	visual_scale = 0.4,
	tiles = {"cannabis.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "cannabis:cannabis_leave 5",
	is_ground_content = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
	on_dig = function(pos, node, digger)
		digger:get_inventory():add_item("main", "cannabis:cannabis_leave 5")
		minetest.remove_node(pos)
	end,
		
}) 

minetest.register_node("cannabis:cannabis_planted", {
	description = "Cannabis",
	drawtype = "mesh",
	mesh = "cannabis_planted.obj",
	visual_scale = 0.1,
	tiles = {"cannabis.png"},
	paramtype = "light",
	sunlight_propagates = true,
	drop = "cannabis:cannabis_leave",
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
	on_dig = function(pos, node, digger)
		digger:get_inventory():add_item("main", "cannabis:cannabis_leave")
		minetest.remove_node(pos)
	end,
}) 

minetest.register_craftitem("cannabis:cannabis_leave", {
	description = "Cannabis Leave",
	inventory_image = "wielded.png",
	on_place = function(itemstack, placer, pointed_thing)
		local pos = minetest.get_pointed_thing_position(pointed_thing, true)
		local under = minetest.get_node(pointed_thing.under)
		if under.name == "farming:soil_wet" or under.name == "farming:soil" then
			minetest.set_node(pos, {name = "cannabis:cannabis_planted"})
			itemstack:take_item()
			return itemstack
		end
	end,
})


minetest.register_craftitem("cannabis:joint", {
	description = "Joint",
	inventory_image = "joint.png",
	on_use = function(itemstack, user)
		hud.hunger[user:get_player_name()] = 2
		hud.set_hunger(user)
		user:set_physics_override({speed=0.5, gravity = 0.1})
		user:set_hp(20)
		user:set_sky(nil,"skybox",{"rainbow.jpg","rainbow.jpg","rainbow.jpg","rainbow.jpg","rainbow.jpg","rainbow.jpg"})
		itemstack:take_item()
		minetest.after(300, function()
			user:set_sky(nil,"regular",nil)
			user:set_physics_override({speed=1, gravity = 1})		
		end)
		return itemstack
	end,
})

minetest.register_craft({
	output = "cannabis:joint",
	recipe = {
		{"default:paper", "default:paper", "default:paper"},
		{"cannabis:cannabis_leave", "cannabis:cannabis_leave", "cannabis:cannabis_leave"},
		{"default:paper", "default:paper", "default:paper"}
	}
})

	
minetest.register_abm({
	nodenames = {"cannabis:cannabis_planted"},
	interval = 10,
	chance = 7,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local nodeunder = minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z})
		if nodeunder.name == "farming:soil_wet" then
			minetest.set_node(pos, {name = "cannabis:cannabis"})
		end
		
	end,
})

minetest.register_abm({
	nodenames = {"cannabis:cannabis_planted", "cannabis:cannabis"},
	interval = 0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local nodeunder = minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z})
		if nodeunder.name ~= "farming:soil_wet" and nodeunder.name ~= "farming:soil" and node.name == "cannabis:cannabis_planted" then
			minetest.remove_node(pos)
			minetest.add_item(pos, "cannabis:cannabis_leave")
		elseif nodeunder.name ~= "farming:soil_wet" and nodeunder.name ~= "farming:soil"
			and nodeunder.name ~= "default:dirt_with_grass" and nodeunder.name ~= "default:dirt"
			and node.name == "cannabis:cannabis" then
				minetest.remove_node(pos)
				minetest.add_item(pos, "cannabis:cannabis_leave 5")
		end
		
	end,
})

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.01,
			scale = 0.03,
			spread = {x=50, y=50, z=50},
			seed = seed,
			octaves = 3,
			persist = 0.6
		},
		biomes = {
			"stone_grassland",
			"sandstone_grassland",
			"deciduous_forest",
			"coniferous_forest",
		},
		y_min = 6,
		y_max = 31000,
		decoration = "cannabis:cannabis",
})

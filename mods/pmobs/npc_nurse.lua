
-- Npc by TenPlus1

mobs.npc_drops = { "default:pick_steel", "mobs:meat", "default:sword_steel", "default:shovel_steel", "farming:bread", "bucket:bucket_water" }

mobs:register_mob("pmobs:npc_nurse", {
	-- animal, monster, npc
	type = "npc",
	-- aggressive, deals 2 damage to player/monster when hit
	passive = false,
	damage = 2,
	attack_type = "dogfight",
	attacks_monsters = false,
	-- health & armor
	hp_min = 10, hp_max = 20, armor = 100,
	-- textures and model
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	mesh = "character.b3d",
	floats = {x=0,y=0,z=0},
	drawtype = "front",
	owner = "",
	order = "follow",
	textures = {
		{"mobs_npc_nurse.png"},
	},
	visual_size = {x=1, y=1},
	-- sounds
	makes_footstep_sound = true,
	sounds = {},
	-- speed and jump
	walk_velocity = 4,
	run_velocity = 4,
	jump = true,
	stepheight = 1.1,
	-- drops wood and chance of apples when dead
	drops = {
		{name = "default:wood",
		chance = 1, min = 1, max = 3},
		{name = "default:apple",
		chance = 2, min = 1, max = 2},
		{name = "default:axe_stone",
		chance = 3, min = 1, max = 1},
	},
	-- damaged by
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,

	view_range = 15,
	-- model animation
	animation = {
		speed_normal = 30,		speed_run = 30,
		stand_start = 0,		stand_end = 79,
		walk_start = 168,		walk_end = 187,
		run_start = 168,		run_end = 187,
		punch_start = 200,		punch_end = 219,
	},
	-- right clicking with cooked meat will give npc more health
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "mobs:meat" or item:get_name() == "farming:bread" then
			local hp = self.object:get_hp()
			if hp + 4 > self.hp_max then return end
			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			self.object:set_hp(hp+4)
		
			
		-- right clicking with gold lump drops random item from mobs.npc_drops
		elseif item:get_name() == "default:gold_lump" then
			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			local pos = self.object:getpos()
			pos.y = pos.y + 0.5
			minetest.add_item(pos, {name = mobs.npc_drops[math.random(1,#mobs.npc_drops)]})
		else
			if self.owner == "" then
				self.owner = clicker:get_player_name()
			else
				local formspec = "size[8,4]"
				formspec = formspec .. "textlist[2.85,0;2.1,0.5;dialog;What can I do for you?]"
				formspec = formspec .. "button_exit[1,1;2,2;nfollow;follow]"
				formspec = formspec .. "button_exit[5,1;2,2;nstand;stand]"
				formspec = formspec .. "button_exit[3,1;2,2;nheal;heal]"
				formspec = formspec .. "button_exit[1,2;2,2;ngohome; go home]"
				formspec = formspec .. "button_exit[5,2;2,2;nsethome; sethome]"
				minetest.show_formspec(clicker:get_player_name(), "order", formspec)
				minetest.register_on_player_receive_fields(function(clicker, formname, fields)
					if fields.nfollow then
						self.order = "follow"
						self.attacks_monsters = false
					end
					if fields.nstand then
						self.order = "stand"
						self.attacks_monsters = false
					end
					if fields.nheal then
						clicker:set_hp(20)
					end
					if fields.nsethome then
						self.floats = self.object:getpos()
					end
					if fields.ngohome then
						if self.floats then
							self.order = "stand"
							self.object:setpos(self.floats)
						end
					end
				end)
						
			end
			
		end
	end,
})

-- register spawn egg
mobs:register_egg("pmobs:npc_nurse", "Npc", "default_brick.png", 1)

 


-- Dog

mobs:register_mob("pmobs:dog", {
	type = "npc",
	passive = true,
	hp_max = 5,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "mobs_wolf.x",
	textures = {
		{"mobs_dog.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		war_cry = "mobs_wolf_attack",
	},
	view_range = 15,
	stepheight = 1.1,
	owner = "",
	order = "follow",
	floats = {x=0,y=0,z=0},
	walk_velocity = 4,
	run_velocity = 4,
	stepheight = 1.1,
	damage = 2,
	armor = 200,
	attacks_monsters = true,
	attack_type = "dogfight",
	drops = {
		{name = "mobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "mobs:meat_raw" then
			local hp = self.object:get_hp()
			if hp + 4 > self.hp_max then return end
			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			self.object:set_hp(hp+4)
		else
			if self.owner == "" then
				self.owner = clicker:get_player_name()
			else
				local formspec = "size[8,4]"
				formspec = formspec .. "textlist[2.85,0;2.1,0.5;dialog;What can I do for you?]"
				formspec = formspec .. "button_exit[1,1;2,2;dfollow;follow]"
				formspec = formspec .. "button_exit[5,1;2,2;dstand;stand]"
				formspec = formspec .. "button_exit[0,2;4,4;dfandp;follow and protect]"
				formspec = formspec .. "button_exit[4,2;4,4;dsandp;stand and protect]"
				formspec = formspec .. "button_exit[1,2;2,2;dgohome; go home]"
				formspec = formspec .. "button_exit[5,2;2,2;dsethome; sethome]"
				minetest.show_formspec(clicker:get_player_name(), "order", formspec)
				minetest.register_on_player_receive_fields(function(clicker, formname, fields)
					if fields.dfollow then
						self.order = "follow"
						self.attacks_monsters = false
					end
					if fields.dstand then
						self.order = "stand"
						self.attacks_monsters = false
					end
					if fields.dfandp then
						self.order = "follow"
						self.attacks_monsters = true
					end
					if fields.dsandp then
						self.order = "stand"
						self.attacks_monsters = true
					end
					if fields.dsethome then
						self.floats = self.object:getpos()
					end
					if fields.dgohome then
						if self.floats then
							self.order = "stand"
							self.object:setpos(self.floats)
						end
					end
				end)
			end
		end
	end,
	animation = {
		speed_normal = 20,
		speed_run = 30,
		stand_start = 10,
		stand_end = 20,
		walk_start = 75,
		walk_end = 100,
		run_start = 100,
		run_end = 130,
		punch_start = 135,
		punch_end = 155,
	},
	jump = true,
	step = 1,
	blood_texture = "mobs_blood.png",
})
mobs:register_egg("pmobs:dog", "Dog", "wool_brown.png", 1)

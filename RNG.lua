-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

hastetype=1
hastesambatype=0
autora = false
--default_ws = "Jishnu's Radiance"
--default_ws = "Trueflight"
default_ws = "Last Stand"

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
	
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff.Barrage = buffactive.Barrage or false
	state.Buff.Camouflage = buffactive.Camouflage or false
	state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Meva')
	state.RangedMode:options('Normal', 'Acc75', 'Acc150', 'Acc250', 'Crit')
	state.WeaponskillMode:options('Normal', 'Acc75', 'Acc150', 'Acc250', 'Crit')
	
	state.autows = M(false, 'AutoWS')
	state.flurrymode = M(false, 'Flurry')

	select_default_macro_book()

	send_command('bind ^d gs c shoot')
	send_command('bind !d gs c shootstop')
	send_command('bind ![ gs c toggle autows')
	send_command('bind @` gs c toggle flurrymode')
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^d')
	send_command('unbind !d')
	send_command('unbind ^[')
	send_command('unbind @`')
end


-- Set up all gear sets.
function init_gear_sets()

	include('Flannelman_aug-gear.lua')
	
	
	belenus={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	belenuswsd={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}}
    belenusSnap={ name="Belenus's Cape", augments={'"Snapshot"+10',}}
	
	DefaultAmmo = {}
	U_Shot_Ammo = {} 
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Bounty Shot'] = {hands="Sylvan Glovelettes +2"}
	sets.precast.JA['Camouflage'] = {body="Orion Jerkin +2"}
	sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +2"}
	sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +2"}


	-- Fast cast sets for spells

	sets.precast.FC = {
		head="Carmine Mask", 
		body="Samnuha Coat",
		hands="Leyline Gloves",
		legs="Gyve Trousers",
		feet="Carmine Greaves", 
		neck="Orunmila's Torque",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Lebeche Ring",
		right_ring="Weather. Ring",}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


	-- Ranged sets (snapshot)
	
	sets.precast.RA = {--ammo="Chrono Bullet",
		head="Taeon Chapeau",					--9
		body="Taeon Tabard",					--9
		hands="Carmine Finger Gauntlets +1",	--8		11
		legs="Adhemar Kecks",					--9		10
		feet="Meghanada Jambeaux +2", 			--10
		waist="Impulse Belt",					--3
		left_ring="Defending Ring",
		back=belenusSnap						--10
		}										--58(10)21(5)
	sets.Flurry = set_combine(sets.precast.RA,{head="Orion Beret +3",waist="Yemaya Belt",})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Chrono Bullet",
		head="Orion Beret +3",
		body="Orion Jerkin +2",
		hands="Meghanada Gloves +2",
		legs=HercLegsWSD,
		feet=HercBootsWSD,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Telos Earring",
		left_ring="Dingir Ring",
		right_ring="Regal Ring",
		back=belenuswsd}

	sets.precast.WS.Acc75 = set_combine(sets.precast.WS, {legs="Orion Braccae +2",feet="Meghanada Jambeaux +2"})
	sets.precast.WS.Acc150 = set_combine(sets.precast.WS.Acc75, {})
	sets.precast.WS.Acc250 = set_combine(sets.precast.WS.Acc150, {neck="Iskur Gorget"})
	sets.precast.WS.Crit = set_combine(sets.precast.WS, {})
	
    sets.precast.WS['Wildfire'] = {--ammo=gear.MAbullet,
		head=HercHelmMAB,
		body="Samnuha Coat",
		hands="Carmine Finger Gauntlets +1",
		legs=HercLegsMAB,
		feet=HercBootsMAB,
		neck="Sanctity Necklace",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear="Friomisi Earring",
		left_ring="Dingir Ring",
		right_ring="Regal Ring",
		back=belenuswsd}	
		
	sets.precast.WS['Wildfire'].Acc75 = sets.precast.WS['Wildfire']
	sets.precast.WS['Wildfire'].Acc150 = sets.precast.WS['Wildfire']
	sets.precast.WS['Wildfire'].Acc250 = sets.precast.WS['Wildfire']
	sets.precast.WS['Wildfire'].Crit = sets.precast.WS['Wildfire']
		
	sets.precast.WS['Trueflight'] = set_combine(sets.precast.WS['Wildfire'],{--ammo=gear.MAbullet,
		left_ear="Moonshade Earring",
		left_ring="Weatherspoon Ring",})	
		
	sets.precast.WS['Trueflight'].Acc75 = sets.precast.WS['Trueflight']	
	sets.precast.WS['Trueflight'].Acc150 = sets.precast.WS['Trueflight']	
	sets.precast.WS['Trueflight'].Acc250 = sets.precast.WS['Trueflight']	
	sets.precast.WS['Trueflight'].Crit = sets.precast.WS['Trueflight']	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
	sets.midcast.FastRecast = {}

	sets.midcast.Utsusemi = {}

	sets.midcast.Cure = set_combine(sets.midcast.FastRecast,{
		head="carmine mask",neck="Phalaina locket",ear1="Mendicant's earring",ear2="Loquacious earring",
        ring1="Kunaji ring",ring2="sirona's ring",
		hands="Buremte Gloves",		
        back="Solemnity cape",waist="Gishdubar sash",legs="Gyve Trousers"})
		
	-- Ranged sets

	sets.midcast.RA = {ammo="Chrono Bullet",
		head={ name="Arcadian Beret +1", augments={'Enhances "Recycle" effect',}},
		body="Orion Jerkin +2",
		hands="Adhemar Wristbands",
		legs={ name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}},
		feet={ name="Adhemar Gamashes", augments={'HP+50','"Store TP"+6','"Snapshot"+8',}},
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Enervating Earring",
		right_ear="Telos Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back=belenus}
	sets.midcast.RA.Acc75 = set_combine(sets.midcast.RA,{--ammo="Eradicating Bullet",
		body="Orion Jerkin +2",neck="Iskur Gorget",})
	sets.midcast.RA.Acc150 = set_combine(sets.midcast.RA.Acc75,{hands="Orion Bracers +2",feet="Mummu Gamash. +1"})
	sets.midcast.RA.Acc250 = set_combine(sets.midcast.RA.Acc150,{head="Orion Beret +3",legs="Orion Braccae +2",})
		
	sets.midcast.RA.Crit = set_combine(sets.midcast.RA,{--ammo="Eradicating Bullet",
		head="Meghanada Visor +1",
		body="Mummu Jacket +1",
		hands="Mummu Wrists +1",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1", 
		ring1="Begrudging Ring"})

	
	--sets.midcast.RA.Annihilator = set_combine(sets.midcast.RA)
--	sets.midcast.RA.Annihilator.Acc = set_combine(sets.midcast.RA.Acc)
--	sets.midcast.RA.Yoichinoyumi = set_combine(sets.midcast.RA, {})
--	sets.midcast.RA.Yoichinoyumi.Acc = set_combine(sets.midcast.RA.Acc, {})
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle = {
		head=HercHelmDT,
		body="Meg. Cuirie +1",
		hands=HercGlovesDT,
		legs="Carmine Cuisses +1",
		feet=HercBootsDT,
		neck="Sanctity Necklace",
		waist="Flume Belt +1",
		left_ear="Hearty Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Dark Ring",
		back="Moonbeam Cape",}
	
	-- Defense sets
	sets.defense.PDT = {
		--ammo="Staunch Tathlum",			--2 2
        head=HercHelmDT,				--5 3   meva 	59
        body="Meg. Cuirie +1",		
		hands=HercGlovesDT,				--5 3			43
		legs="Mummu Kecks +1",			--4 4			107
		feet=HercBootsDT,				--6 4			75
		neck="Loricate torque +1",		--6 6
		ear1="Hearty Earring",				--				
		ear2="Eabani earring",
		ring1="Defending Ring",			--10 10
		back="Moonbeam Cape",			--5 5
		waist="Flume Belt +1",			--4			
		}								

	sets.defense.Meva = {
		head="Orion Beret +3",
		body="Mummu Jacket +1",
		hands="Leyline Gloves",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Hearty Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Purity Ring",
		back="Moonbeam Cape",}

	sets.Kiting = {feet="Carmine Cuisses +1"}


	--------------------------------------
	-- Engaged sets
	--------------------------------------

	sets.engaged = {
		head=HercHelmTA,
		body="Adhemar Jacket +1",
		hands="Adhemar Wristbands +1",
		legs="Samnuha Tights",
		feet=HercBootsTA,
		neck="Iskur Gorget",
		waist="Shetal Stone",
		left_ear="Sherida Earring",
		right_ear="Suppanomimi",
		left_ring="Epona's Ring",
		right_ring="Ilabrat Ring",
		back=belenus}

	sets.engaged.Acc = {head="Dampening Tam",neck="Combatant's Torque",waist="Kentarch Belt +1"}
	sets.engaged.PDT = sets.defense.PDT	
	sets.engaged.PDT.Acc = sets.defense.PDT	
	sets.engaged.Meva = sets.defense.Meva
	sets.engaged.Meva.Acc = sets.defense.Meva
	
	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Barrage = set_combine(sets.midcast.RA.Crit, {hands="Orion Bracers +2",neck="Combatant's Torque"})
	sets.buff.Camouflage = {body="Orion Jerkin +2"}
	sets.buff.Bounty = {Head="White Rarab Cap +1",body=HercVestTH,HercGlovesTH,waist="Chaac Belt"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if buffactive['Terror'] or buffactive['Stun'] or buffactive['Petrification'] then
            eventArgs.cancel = true
			equip(sets.defense.PDT)
			add_to_chat(122, "Unable to act, action cancelled")
            return	
	end
	
	if spell.type == 'WeaponSkill' then
		if spell.target.distance >21 then
			add_to_chat(122, "Out of range, action cancelled")
			cancel_spell()
			return
		elseif state.DefenseMode.value ~= 'None' then
			-- Don't gearswap for weaponskills when Defense is on.
			eventArgs.handled = true
		end
	end
	
	if spell.action_type == 'Ranged Attack' then
		state.CombatWeapon:set(player.equipment.range)
	end

	if spell.action_type == 'Ranged Attack' or
	  (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
		check_ammo(spell, action, spellMap, eventArgs)
	end
		
	if 	spell.en == 'Bounty Shot' then
		equip(sets.buff.Bounty)
		eventArgs.handled = true
	end	
end

function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.action_type=="Ranged Attack" then
		if (buffactive['Flurry'] or buffactive["Courser's Roll"]) and state.flurrymode.value then
			equip(sets.Flurry)
		else
			equip(sets.precast.RA)
		end
	end
	if spell.en == 'Last Stand' or spell.en == 'Trueflight' then
		if player.tp > 2999 then
			equipSet = set_combine(equipSet,{left_ear="Ishvara Earring"})
			equip(equipSet)
		end
		if spell.en ~= 'Last Stand' and (spell.element == world.day_element or spell.element == world.weather_element) then
			equipSet = set_combine(equipSet, {waist="Hachirin-No-Obi"})
			add_to_chat(122, "Weather WS")
			equip(equipSet)
		end
	end	
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' and state.Buff.Barrage then
		equip(sets.buff.Barrage)
		eventArgs.handled = true
	end
end

function job_aftercast(spell, action, spellMap, eventArgs)
	if spell.type == 'WeaponSkill' and autora then 
		send_command('wait 3.4;gs c checkandshoot')
	end
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buffactive['Stun'] or buffactive['Petrification'] or buffactive['Terror'] then
		equip(sets.engaged.PDT)
		add_to_chat(122, "TP set to PDT")
	end
	if buff == "Camouflage" then
		if gain then
			equip(sets.buff.Camouflage)
			disable('body')
		else
			enable('body')
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
	-- Filter ammo checks depending on Unlimited Shot
	if state.Buff['Unlimited Shot'] then
		if player.equipment.ammo ~= U_Shot_Ammo[player.equipment.range] then
			if player.inventory[U_Shot_Ammo[player.equipment.range]] or player.wardrobe[U_Shot_Ammo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active. Using custom ammo.")
				equip({ammo=U_Shot_Ammo[player.equipment.range]})
			elseif player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active but no custom ammo available. Using default ammo.")
				equip({ammo=DefaultAmmo[player.equipment.range]})
			else
				add_to_chat(122,"Unlimited Shot active but unable to find any custom or default ammo.")
			end
		end
	else
		if player.equipment.ammo == U_Shot_Ammo[player.equipment.range] and player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Unlimited Shot not active. Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Removing Unlimited Shot ammo.")
					equip({ammo=empty})
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Removing Unlimited Shot ammo.")
				equip({ammo=empty})
			end
		elseif player.equipment.ammo == 'empty' then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Leaving empty.")
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Leaving empty.")
			end
		elseif player.inventory[player.equipment.ammo].count < 15 then
			add_to_chat(122,"Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low ("..player.inventory[player.equipment.ammo].count..")")
		end
	end
end



-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 7)
end


accmode = 0;
runaway = 0;
rangeswap = 0;
use_dualbox=false
function job_self_command(cmdParams, eventArgs)
	command = cmdParams[1]:lower()
	--if player.tp < 1000 then
	if command=='shoot' then
		send_command('input /shoot <t>')
		if player.status == 'Engaged' then
			autora = true
		end
	elseif command=='checkandshoot' then
		if player.status == 'Engaged' and autora == true and not midshot_real then
			send_command('input /shoot <t>')
			midshot = true
		end
	elseif command=='shootstop' then
		--print('stopping ')
		--print(autora)
		autora = false
		midshot = false
		midshot_real = false	
	end
	--end
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
	local msg = 'Melee'

	if state.CombatForm.has_value then
		msg = msg .. ' (' .. state.CombatForm.value .. ')'
	end

	msg = msg .. ': '

	msg = msg .. state.OffenseMode.value
	if state.HybridMode.value ~= 'Normal' then
		msg = msg .. '/' .. state.HybridMode.value
	end
	msg = msg .. ', WS: ' .. state.WeaponskillMode.value

	if state.DefenseMode.value ~= 'None' then
		msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
	end

	if state.Kiting.value == true then
		msg = msg .. ', Kiting'
	end

	if state.PCTargetMode.value ~= 'default' then
		msg = msg .. ', Target PC: '..state.PCTargetMode.value
	end

	if state.SelectNPCTargets.value == true then
		msg = msg .. ', Target NPCs'
	end

	--msg = msg .. ', TH: ' .. state.TreasureMode.value

	add_to_chat(122, msg)

	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
	if state.Buff[buff_name] then
		equip(sets.buff[buff_name] or {})
		eventArgs.handled = true
	end

	--    if buffactive['Haste'] and player.tp < 200 and usehasteknife == 1 then
	--	    sets.engaged = set_combine(sets.engaged,sets.Mainhand)
	--	    sets.idle = set_combine(sets.idle,sets.Mainhand)
	--    elseif player.tp < 200 and usehasteknife == 1 then 
	--		    sets.engaged = set_combine(sets.engaged,sets.Haste)
	--		    sets.idle = set_combine(sets.idle,sets.Haste)
	--    end
end


require 'actions-custom'


midshot = false
function event_action(raw_actionpacket)
	local actionpacket = ActionPacket.new(raw_actionpacket)
	if not autora then 
		return 
	end
	
	actionstr = actionpacket:get_category_string() 

	if actionstr == 'ranged_begin' then
		--print('ranged begin')
		midshot_real=true
	end
	if actionstr == 'ranged_finish' and player.status == 'Engaged' then
		--print('ranged end')
		--send_command('wait .5;input /shoot <t>')
		--send_command('wait .6;input /shoot <t>')
		midshot=false
		midshot_real=false
		--print('autora')
		if autora and player.tp >= 1000 and state.autows.current == 'on' then
			send_command('wait 1.5;input /ws "'..default_ws..'" <t>;wait 3.4;gs c checkandshoot')
			--send_command('wait 1.3;input /ws "'..default_ws..'" <t>;')
		elseif autora and player.tp < 1000 then 
			send_command('wait 1.3;gs c checkandshoot')
		end
	end
	
end
function ActionPacket.open_raw_listener(funct)
    if not funct or type(funct) ~= 'function' then return end
    local id = windower.raw_register_event('incoming chunk',function(id, org, modi, is_injected, is_blocked)
        if id == 0x28 then
            local act_org = windower.packets.parse_action(org)
            act_org.size = org:byte(5)
            local act_mod = windower.packets.parse_action(modi)
            act_mod.size = modi:byte(5)
            return act_to_string(org,funct(act_org,act_mod))
        end
    end)
    return id
end


ActionPacket.open_raw_listener(event_action)

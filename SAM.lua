-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')

    update_combat_form()
    
    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
	include('Flannelman_aug-gear.lua')

	
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head="Wakido Kabuto +1",hands="Sakonji Kote",back="Smertrios's Mantle"}
    sets.precast.JA['Warding Circle'] = {head="Myochin Kabuto +1"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote"}

	sets.LugraLugra     = { ear1="Lugra Earring", ear2="Lugra Earring +1" }
	sets.Lugra     		= { ear2="Lugra Earring +1" }
	sets.Ishvara	 	= { ear2="Ishvara Earring" }
	
	
	sets.precast.FC = {ammo="Sapience Orb",
		hands="Leyline Gloves",
		neck="Orunmila's Torque",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Lebeche Ring",
		right_ring="Weather. Ring",}
		
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Knobkierrie",
		head=ValorousMaskWSD,
		body=ValorousMailWSD,
		hands=ValorousMittsWSD,
		legs="Hiza. Hizayoroi +1",
		feet=ValorousFeetWSD,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Ishvara Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back="Smertrios's Mantle"}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		hands="Wakido Kote +2",})

    -- Specific weaponskill sets. 
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Flam. Zucchetto +2",
		body="Found. Breastplate", 
		hands="Wakido Kote +2",
		legs="Flamma Dirs +1",
		feet="Flam. Gambieras +1",
		right_ear="Digni. Earring",
		left_ring="Weather. Ring",
		right_ring="Regal Ring",})

    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {
		body="Found. Breastplate", 
		hands="Founder's Gauntlets", 
		legs=ValorousHoseWSD,
		feet="Founder's Greaves", 
		right_ear="Friomisi Earring",})


    -- Midcast Sets
    sets.midcast.FastRecast = {}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    
    sets.idle.Town = {
		ammo="Staunch Tathlum",
		head="Valorous Mask",
		body="Hiza. Haramaki +1",
		hands="Founder's Gauntlets",
		legs="Ryuo Hakama",
		feet="Danzo Sune-Ate",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Hearty Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Regal Ring",
		back="Moonbeam Cape",}
    
	sets.idle.Field = set_combine(sets.idle.Town, {})
	
    sets.idle.Weak = set_combine(sets.idle.Town, {
		head="Genmei Kabuto",
		feet="Amm Greaves",
		back="Moonbeam Cape",})

    -- Defense sets
    sets.defense.PDT = set_combine(sets.idle.Town, {
		head="Genmei Kabuto",
		feet="Amm Greaves",})		
		
    sets.defense.Reraise = set_combine(sets.idle.Town, {
        head="Twilight Helm",
        body="Twilight Mail",})

    sets.defense.MDT = sets.defense.PDT

    sets.Kiting = {feet="Danzo Sune-ate"}

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- Engaged sets
   
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {ammo="Ginsen",
		head="Flamma Zucchetto +2",
		body=ValorousMailQA,
		hands="Wakido Kote +2",
		legs="Ryuo Hakama",
		--feet=ValorousFeetSTP,
		feet=ValorousFeetQA,
		neck="Ganesha's Mala",
		waist="Ioskeha Belt",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Niqmaddu Ring",
		--right_ring="Ilabrat Ring",
		right_ring="Hetairoi Ring",
		back="Takaha Mantle",}
    sets.engaged.Acc = set_combine(sets.engaged, {
		legs="Flamma Dirs +1",
		feet="Flam. Gambieras +1",
		neck="Moonbeam Nodowa",
		right_ring="Regal Ring",})
	
    sets.engaged.PDT = sets.defense.PDT
    sets.engaged.Acc.PDT = sets.defense.PDT
    sets.engaged.Reraise = sets.defense.PDT
    sets.engaged.Acc.Reraise = sets.defense.PDT
        


    --sets.buff.Sekkanoki = {hands="Unkai Kote +2"}
    --sets.buff.Sengikori = {feet="Unkai Sune-ate +2"}
    --sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if buffactive['Terror'] or buffactive['Stun'] or buffactive['Petrification'] then
		eventArgs.cancel = true
		equip(sets.engaged.PDT)
		add_to_chat(122, "Unable to act, action cancelled")
		return	
	end
	
    -- if spell.type:lower() == 'weaponskill' then
        -- if state.Buff.Sekkanoki then
            -- equip(sets.buff.Sekkanoki)
        -- end
        -- if state.Buff.Sengikori then
            -- equip(sets.buff.Sengikori)
        -- end
        -- if state.Buff['Meikyo Shisui'] then
            -- equip(sets.buff['Meikyo Shisui'])
        -- end
    -- end
end


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type:lower() == 'weaponskill' and spell.en ~= 'Tachi: Jinpu' then	
		if player.tp > 2999 then
			equip(sets.LugraLugra)
		else
			if world.time >= (17*60) or world.time <= (7*60) then
				equip(sets.Lugra)
			else 
				equip(sets.Ishvara)
			end				
		end
	end
    -- Effectively lock these items in place.
    if state.HybridMode.value == 'Reraise' or (state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
        equip(sets.Reraise)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff, gain)
	if buffactive['Stun'] or buffactive['Petrification'] or buffactive['Terror'] then
		equip(sets.defense.PDT)
		add_to_chat(122, "TP set to PDT")
	end
end

function update_combat_form()
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(2, 11)
    elseif player.sub_job == 'DNC' then
        set_macro_page(2, 11)
    elseif player.sub_job == 'THF' then
        set_macro_page(3, 11)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 11)
    else
        set_macro_page(2, 11)
    end
end


include('organizer-lib')
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
    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Doom = buffactive.doom or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false

end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Meva')
     state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')

    gear.MovementFeet = {name="Danzo Sune-ate"}
    gear.DayFeet = "Danzo Sune-ate"
    gear.NightFeet = "Danzo Sune-ate"
 --   gear.NightFeet = "Hachiya kyahan"
    
	state.RuneMode = M('None','Lux -- Darkness resist','Tenebrae -- Light resist','Ignis - Ice resist','Gelus -- Wind resist',		-- Winkey + `
			'Flabra -- Earth resist','Tellus -- Lightning resist','Sulpor -- Water resist','Unda -- Fire resist')							
	state.MagicBurst = M(false, 'Magic Burst')		
    state.DualWield = M(false, 'Dual Wield')																				-- Alt + `

    -- Additional local binds
    send_command('bind ^` gs c toggle DualWield')
    send_command('bind ^z input /targetbnpc')
    send_command('bind !` gs c toggle MagicBurst')
	send_command('bind @` gs c cycle RuneMode')
	
    select_movement_feet()
    select_default_macro_book()
end

function user_unload()
    send_command('unbind ^z')
    send_command('unbind ^`')
    send_command('unbind !`')
	send_command('unbind @`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
   -- Katanas

   
	--sets.TP.GK = {main="Kiikanemitsu"}
	--sets.TP.Scythe = {Main="Ark scythe"}
	--sets.TP.Sword = {Main="Ryl.arc. sword"}
	--sets.TP.Pole = {Main="Pitchfork +1"}
	--sets.TP.Staff = {Main="earth staff"}
	--sets.TP.Dagger = {Main="Atoyac"}
   
		
	include('Flannelman_aug-gear.lua')
	
	
	sets.LugraLugra  		 = { ear1="Lugra Earring", ear2="Lugra Earring +1" }
	sets.Mache           = { ear1="Mache Earring" }
   --------------------------------------
    -- Precast sets
    --------------------------------------
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama"}
    sets.precast.JA['Futae'] = {legs="Hattori Tekko"}
    sets.precast.JA['Sange'] = {legs="Mochizuki Chainmail"}
	
	sets.enmity = {
    ammo="Sapience Orb",
    body="Emet Harness +1",
    hands="Kurys Gloves",
    feet="Mochizuki Kyahan",
    neck="Unmoving Collar +1",
    waist="Goading Belt",
    left_ear="Cryptic Earring",
    right_ear="Friomisi Earring",
    left_ring="Petrov Ring",
    right_ring="Supershear Ring",
    back="Agema Cape",
	}
	sets.precast.JA['Provoke'] = sets.enmity
	
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = set_combine(sets.precast.Waltz)

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {}

    sets.precast.Flourish1 = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = { ammo="Sapience Orb",	--2
		head=HercHelmFC,						--12
		body="Adhemar Jacket", 					--7
		hands="Leyline Gloves",					--7
		legs="Gyve Trousers",					--4
		feet=HercBootsFC,						--5
		neck="Orunmila's Torque",				--5
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",			--1
		right_ear="Loquac. Earring",			--2
		left_ring="Weatherspoon Ring",			--5
		right_ring="Kishar Ring",				--5
	}											--55 FC
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    -- Snapshot for ranged
    sets.precast.RA = {legs="Adhemar Kecks", feet="Adhemar Gamashes", waist="Yemaya Belt"}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = { ammo="Seeth. Bomblet +1",
		head=HercHelmWSD,
		body="Adhemar Jacket +1", 
		hands="Adhemar Wristbands +1", 
		legs=HercLegsWSD,
		feet=HercBootsWSD,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Ishvara Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back="Andartia's Mantle", }
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {	
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    
	-- Blade: Jin 	Str & Dex  --
	sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, {
		head="Adhemar Bonnet +1",
		body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",ring2="Epona's Ring",ring1="Hetairoi Ring",
		waist="Fotia belt",legs="Samnuha tights",feet=HercBootsTA})

    -- Blade: Hi	Agi --
	sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS,	{
		ammo="Yetshila",
		head="Adhemar Bonnet +1",
		body="Abnoba Kaftan",
		hands="Ryuo Tekko", 
		legs=HercLegsAcc,
		feet=HercBootsDmg,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear="Ishvara Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back="Andartia's Mantle", 
	})
	sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS['Blade: Hi'], {	
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",})
	
    -- Blade: Shun	Dex --
	sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {
		ammo="Seeth. Bomblet +1",
		head="Adhemar Bonnet +1",
		body="Adhemar Jacket +1",
		hands="Adhemar Wristbands +1",
		legs="Samnuha Tights",
		feet=HercBootsTA,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring", 
		right_ear="Mache Earring",
		left_ring="Epona's Ring",
		right_ring="Regal Ring",
		back="Andartia's Mantle", 
		})
	sets.precast.WS['Blade: Shun'].Acc = set_combine(sets.precast.WS['Blade: Shun'], {})

-- Blade: Ten 	Str & Dex  --
	sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",
		head=HercHelmWSD,
		body=HercVestWSD, 
		hands=HercGlovesWSD, 
		legs="Samnuha Tights",
		--legs="Hizamaru Hizayoroi +1",
		feet=HercBootsWSD,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Ishvara Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back="Andartia's Mantle",
	})
	sets.precast.WS['Blade: Ten'].Acc = set_combine(sets.precast.WS['Blade: Ten'], {	
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",})
	
    sets.precast.WS['Aeolian Edge'] = {ammo="Pemphredo Tathlum",
		head=HercHelmMAB,
		body="Samnuha Coat",
		hands="Leyline Gloves", 
		legs="Gyve Trousers",
		feet=HercBootsMAB,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Dingir Ring",
		back="Toro Cape"}

	
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		head="Adhemar Bonnet +1", 
		body="Abnoba Kaftan",
		hands="Ryuo Tekko",
		legs="Jokushu Haidate", 
		feet=HercBootsDmg,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring", 
		right_ear="Mache Earring",
		left_ring="Epona's Ring",
		right_ring="Regal Ring",})		
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})	
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {ear2="Loquacious Earring"}
        
    sets.midcast.Utsusemi = {feet="Hattori Kyahan",neck="Magoraga Beads",back="Andartia's Mantle",}
	sets.midcast['Utsusemi: San'] = sets.midcast.Utsusemi

    sets.midcast.ElementalNinjutsu = {ammo="Pemphredo Tathlum",
		head=HercHelmMAB,
		body="Samnuha Coat",
		hands="Leyline Gloves", 
		legs="Gyve Trousers",
		feet=HercBootsMAB,
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Hecate's Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Dingir Ring",
		back="Toro Cape"}

    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.Ninjutsu, {})
		
	sets.magic_burst = set_combine(sets.midcast.ElementalNinjutsu, {ring1="Locus ring", ring2="Mujin band"})

    sets.midcast.NinjutsuDebuff = {ammo="Yamarang",
		head="Dampening Tam", 
		body="Samnuha Coat", 
		hands="Leyline Gloves",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Digni. Earring",
		right_ear="Gwati Earring",
		left_ring="Weatherspoon Ring",
		right_ring="Kishar Ring",
		back="Toro Cape",}

    sets.midcast.NinjutsuBuff = {	}

    sets.midcast.RA = {
		head=="Dampening Tam",
		body="Mummu Jacket +1",
		hands="Mummu Wrists +1",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Ilabrat Ring",
		right_ring="Dingir Ring",}
	sets.midcast.RA.Acc = sets.midcast.RA
		
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {ring1="Defending Ring"}
    
    -- Idle sets
    sets.idle = {
		ammo="Staunch Tathlum",
		head=HercHelmDT,
		body="Hizamaru Haramaki +1",
		hands=HercGlovesDT,
		legs="Mummu Kecks +1",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear="Hearty Earring",
		left_ring="Defending Ring",
		right_ring="Regal Ring",
		back="Moonbeam Cape",
		feet=gear.MovementFeet,
	}

    
    sets.idle.Weak = {}
    
    -- Defense sets

    sets.defense.PDT = {		
		ammo="Staunch Tathlum",			--2   2
		head=HercHelmDT,				--4   4
		body="Ken. Samue",			
		hands=HercGlovesDT,				--5   3
		legs="Mummu Kecks +1",			--4   4
		feet="Amm Greaves",				--5   5
		neck="Loricate Torque +1",		--6   6
		waist="Flume Belt +1",			--4
		left_ear="Odnowa Earring +1",	--	  2
		right_ear="Hearty Earring",
		left_ring="Defending Ring",		--10  10
		right_ring="Dark Ring",			--6   3
		back="Moonbeam Cape",			--5   5
	}									--51  50

    sets.defense.Meva = {		--shigi	--5   5		meva
		ammo="Staunch Tathlum",			--2   2
		head="Ken. Jinpachi",						--91
		body="Ken. Samue",							--107
		hands=HercGlovesDT,				--6   3		--43
		legs="Ken. Hakama",							--129
		feet="Mummu Gamash. +1",					--107
		neck="Loricate Torque +1",		--6   6
		waist="Flume Belt +1",			--4
		left_ear="Eabani Earring",					--8
		right_ear="Hearty Earring",
		left_ring="Defending Ring",		--10  10
		right_ring="Dark Ring",			--6   4
		back="Moonbeam Cape",			--5   5
   }									--44  37	--503


    sets.Kiting = {feet=gear.MovementFeet}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group		-- 35% DW --
    sets.engaged = {ammo="Togakushi Shuriken",
		head="Kendatsuba Jinpachi",
		body="Kendatsuba Samue",
		hands="Adhemar Wristbands +1",
		legs="Kendatsuba Hakama",
		--legs="Samnuha Tights",
		feet=HercBootsTA,
		neck="Moonbeam Nodowa",
		waist="Kentarch Belt +1",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Epona's Ring",
		right_ring="Hetairoi Ring",
		back="Andartia's Mantle", 		
	}
	sets.DualWield = set_combine(sets.engaged, {
		head="Ryuo Somen", 
		body="Adhemar Jacket +1", 
		feet=HercBootsDW,
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Suppanomimi",
	})
	
    sets.engaged.Acc = set_combine(sets.engaged, {ammo="Yamarang",
		right_ear="Telos Earring",
		right_ring="Ilabrat Ring",	})
	sets.DualWield.Acc = set_combine(sets.engaged.Acc, {
		head="Ryuo Somen", 
		body="Adhemar Jacket +1",
		waist="Reiki Yotai",
		left_ear="Suppanomimi", })
	
    sets.engaged.PDT = set_combine(sets.defense.PDT, {ear2="Telos Earring"})
    sets.engaged.Acc.PDT = sets.engaged.PDT
	sets.engaged.Meva = sets.defense.Meva
    sets.engaged.Acc.Meva = sets.defense.Meva

    

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {}--body="Hattori ningi"}
    sets.buff.Doom = {waist="Gishdubar sash"}
    sets.buff.Yonin = {legs="Hattori hakamaka +1"}
    sets.buff.Innin = {head="Hattori Zukin +1"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell, action, spellMap, eventArgs)
    if (spell.type:endswith('Magic') or spell.type == "Ninjutsu") and buffactive.silence then
        eventArgs.cancel = true
        send_command('input /item "Echo Drops" <st>')
		add_to_chat(122, "Silenced, Auto-Echos")
    end
end

function job_precast(spell, action, spellMap, eventArgs)
	if buffactive['Terror'] or buffactive['Stun'] or buffactive['Petrification'] then
            eventArgs.cancel = true
			equip(sets.engaged.PDT)
			add_to_chat(122, "Unable to act, action cancelled")
            return	
	end
	if spell.english == 'Lunge' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Swipe" <t>')
            add_to_chat(122, '***Lunge Aborted: Timer on Cooldown -- Downgrading to Swipe.***')
            eventArgs.cancel = true
            return
        end
    end

	if spell.english == 'Unda' then
		if state.RuneMode.value == 'Lux -- Darkness resist' then
            send_command('input /jobability "Lux" <me>')
            add_to_chat(122, 'Lux -- Light')
            eventArgs.cancel = true
            return	
		elseif state.RuneMode.value == 'Tenebrae -- Light resist' then
            send_command('input /jobability "Tenebrae" <me>')
            add_to_chat(122, 'Tenebrae -- Dark')
            eventArgs.cancel = true
            return		
        elseif state.RuneMode.value == 'Ignis - Ice resist' then
            send_command('input /jobability "Ignis" <me>')
            add_to_chat(122, 'Ignis -- Fire (Ice)')
            eventArgs.cancel = true
            return	
		elseif state.RuneMode.value == 'Gelus -- Wind resist' then
            send_command('input /jobability "Gelus" <me>')
            add_to_chat(122, 'Gelus -- Ice (Wind)')
            eventArgs.cancel = true
            return
		elseif state.RuneMode.value == 'Flabra -- Earth resist' then
            send_command('input /jobability "Flabra" <me>')
            add_to_chat(122, 'Flabra -- Wind (Earth)')
            eventArgs.cancel = true
            return	
		elseif state.RuneMode.value == 'Tellus -- Lightning resist' then
            send_command('input /jobability "Tellus" <me>')
            add_to_chat(122, 'Tellus -- Earth (Thunder)')
            eventArgs.cancel = true
            return	
		elseif state.RuneMode.value == 'Sulpor -- Water resist' then
            send_command('input /jobability "Sulpor" <me>')
            add_to_chat(122, 'Sulpor -- Thunder (Water)')
            eventArgs.cancel = true
            return	
		elseif state.RuneMode.value == 'Unda -- Fire resist' then
            add_to_chat(122, 'Unda -- Water (Fire)')
            return
        end
    end
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.en == 'Blade: Ten' then
		if player.tp > 2999 then
			equip(sets.Mache)
		else
			if world.time >= (17*60) or world.time <= (7*60) then
				equip(sets.LugraLugra)
			else 
				equip(sets.Mache)
			end				
		end
	elseif spell.en == 'Blade: Hi' or spell.en == 'Blade: Shun' or spell.en == 'Evisceration' then	
		if player.tp > 2999 then
			equip(sets.LugraLugra)
		else	
			if world.time >= (17*60) or world.time <= (7*60) then
				equip(sets.LugraLugra)
			else 
				equip(sets.Mache)
			end	
		end
	end
	if spellMap == 'Ninjutsu' then
        if spell.element == world.day_element or spell.element == world.weather_element then
			if state.MagicBurst.value then
				--equip(sets.magic_burst.CastingMode)
				equipSet = set_combine(sets.midcast.ElementalNinjutsu, sets.magic_burst)
				equipSet = set_combine(equipSet, {waist="Hachirin-No-Obi"})
				equip(equipSet)
				add_to_chat(122, "Weather Magic Burst")
            else 
				equip({waist="Hachirin-No-Obi"})
				add_to_chat(122, "Weather Nuke")
			end
		elseif state.MagicBurst.value then
			equip(sets.magic_burst) 
			add_to_chat(122, "Magic Burst")
        end
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff, gain)
	if buffactive['Stun'] or buffactive['Petrification'] or buffactive['Terror'] then
		equip(sets.engaged.PDT)
		add_to_chat(122, "TP set to PDT")
	end
	if state.HybridMode.value == "Normal" then
		if string.lower(buff) == "slow" and gain and not state.DualWield.value then
			send_command('gs c toggle DualWield')
		elseif string.lower(buff) == "slow" and state.DualWield.value and not gain then
			send_command('gs c toggle DualWield')
		end
	end
end

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Buff.Migawari then
        --idleSet = set_combine(idleSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.DualWield.value and state.HybridMode.value == 'Normal' then	
		if state.OffenseMode.current == 'Acc' then
			meleeSet = set_combine(meleeSet, sets.DualWield.Acc)
		else	
			meleeSet = set_combine(meleeSet, sets.DualWield)
		end	
	end
    if state.Buff.Migawari then
        --meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    return meleeSet
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------



function select_movement_feet()
    if world.time >= 17*60 or world.time < 7*60 then
        gear.MovementFeet.name = gear.NightFeet
    else
        gear.MovementFeet.name = gear.DayFeet
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 3)
    else
        set_macro_page(1, 3)
    end
end


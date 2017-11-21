
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
 --   include('organizer-lib')
end
 
 
-- Setup vars that are user-independent.
function job_setup()
    state.CapacityMode = M(false, 'Capacity Point Mantle')

    state.Buff.Doom = buffactive.Doom or false
	
    --state.Buff.Souleater = buffactive.souleater or false
    state.Buff.Berserk = buffactive.berserk or false
    state.Buff.Retaliation = buffactive.retaliation or false
    
    wsList = S{}
    gsList = S{'Macbain', 'Kaquljaan'}
    war_sub_weapons = S{"Sangarius", "Usonmunku"}

    get_combat_form()
    get_combat_weapon()
end
 
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc50', 'Acc100')
    state.HybridMode:options('Normal', 'PDT', 'Meva')
    state.WeaponskillMode:options('Normal', 'Acc50', 'Acc100')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'Knockback', 'Meva','Terror', 'Charm'}
	
    
    -- Additional local binds
    
    select_default_macro_book()
end
 
-- Called when this job file is unloaded (eg: job change)
function file_unload()

end
 
       
-- Define sets and vars used by this job file.
function init_gear_sets()
	sets.precast.Item = {}
	sets.precast.Item['Holy Water'] = {ring1="Purity Ring"} 
     --------------------------------------
     -- Start defining the sets
     --------------------------------------
     -- Augmented gear
	include('Flannelman_aug-gear.lua')
	

	-- Precast Sets
	sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers"}
	sets.precast.JA['Blood Rage'] = { body="Ravager's Lorica +2" }
	sets.precast.JA['Aggressor'] = {body="Agoge Lorica"}
	sets.precast.JA['Warcry'] = {head="Agoge Mask"}
	sets.precast.JA['Berserk'] = {feet="Agoge Calligae"}
	sets.precast.JA['Tomahawk'] = {feet="Agoge Calligae"}

	sets.CapacityMantle  = { back="Mecistopins Mantle" }
	sets.BrutalLugra     = { ear1="Lugra Earring", ear2="Lugra Earring +1" }
	sets.Lugra           = { ear1="Lugra Earring +1" }
	sets.Brutal          = { ear1="Brutal Earring" }

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
	}
		
	-- Fast cast sets for spells
	sets.precast.FC = {ammo="Sapience Orb",--2
		body=OdysseanChestFC,			--9
		hands="Leyline gloves",			--8
		feet=OdysseanGreavesFC,			--9
		neck="Orunmila's torque",		--5
		ear2="Loquacious Earring",		--2
		ring1="Lebeche ring",
		ring2="weatherspoon ring",		--5
		legs="Eschite cuisses",			--5
	}
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck="Magoraga Beads" })

	-- Midcast Sets
	sets.midcast.FastRecast = {
	}


	-- Ranged for xbow
	sets.precast.RA = {
	}
	sets.midcast.RA = {
	}

	-- WEAPONSKILL SETS
	-- General sets
	sets.precast.WS = {
		ammo="Seething Bomblet +1",
		head=ValorousMaskWSD,
		body="Argosy Hauberk +1",
		hands=OdysseanGauntletsWSD,
		legs=OdysseanCuissesWSD,
		feet="Sulevia's Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear="Moonshade Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
	}
	sets.precast.WS.Acc50 = set_combine(sets.precast.WS, {
		body="Sulevia's Plate. +1",
		hands="Emicho Gauntlets",
		legs=OdysseanCuissesAcc,
		feet=OdysseanGreavesAcc,
	})
	sets.precast.WS.Acc100 = set_combine(sets.precast.WS.Acc50, {
		ear1="Dignitary's Earring",
		ear2="Telos Earring",
	})
		
	-- RESOLUTION
	-- 86-100% STR
	sets.precast.WS.Resolution = set_combine(sets.precast.WS, {
		head="Argosy Celata +1", 
		body="Argosy Hauberk +1",
		hands="Argosy Mufflers +1",
		legs="Argosy Breeches +1",
		feet="Argosy Sollerets +1",})
	sets.precast.WS.Resolution.Acc50 = set_combine(sets.precast.WS.Resolution, {}) 
	sets.precast.WS.Resolution.Acc100 = set_combine(sets.precast.WS.Resolution, {}) 
	sets.precast.WS.Resolution.Acc150 = set_combine(sets.precast.WS.Acc150, {hands="Argosy Mufflers +1"}) 
	
	-- Scourge
	-- 40$ STR/VIT
	sets.precast.WS['Scourge'] = set_combine(sets.precast.WS, {
		body=OdysseanChestSTP,
		legs=OdysseanCuissesWSD,
		feet=ValorousFeetWSD,
	})
	sets.precast.WS['Scourge'].Acc50 = set_combine(sets.precast.WS.Acc50, {})
	sets.precast.WS['Scourge'].Acc100 = set_combine(sets.precast.WS.Acc100, {})
	
	sets.precast.WS['Stardriver'] = set_combine(sets.precast.WS.Resolution, {})
	sets.precast.WS['Stardriver'].Acc50 = set_combine(sets.precast.WS.Resolution.Acc50, {})
	sets.precast.WS['Stardriver'].Acc100 = set_combine(sets.precast.WS.Resolution.Acc100,{}) 
	
	-- Upheaval
	-- 73-85% VIT
	sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS.Resolution, {	})
	-- Ukko's Fury
	-- 80% STR Crit
	sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS.Resolution, {})
	
	-- Savage Blade
	-- 50% STR/MND
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
	-- SANGUINE BLADE
	-- 50% MND / 50% STR Darkness Elemental
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {ammo="Seething Bomblet +1",
        head=ValorousMaskWSD,ear2="Friomisi Earring",
		body="Founder's Breastplate",hands="Founder's Gauntlets",ring1="acumen ring",ring2="archon ring",
		back="toro cape",legs="Eschite cuisses",feet=OdysseanGreavesMagic
	})
	sets.precast.WS['Sanguine Blade'].Acc50 = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Acc50)
	sets.precast.WS['Sanguine Blade'].Acc100 = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Acc100)

	-- REQUISCAT
	-- 73% MND 
	sets.precast.WS.Requiescat = set_combine(sets.precast.WS, {})
	sets.precast.WS.Requiescat.Acc50 = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Acc50)
	sets.precast.WS.Requiescat.Acc100 = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Acc100)
	
	-- Judgment
	-- 50% STR/MND
	sets.precast.WS['Judgment'] = set_combine(sets.precast.WS, {
        head=ValorousMaskWSD, 
		body=ValorousMailWSD,
		hands=OdysseanGauntletsWSD,
		legs=OdysseanCuissesWSD,
		feet="Sulevia's Leggings +2",
		ear1="Ishvara Earring",
		ear2="Moonshade earring",
	})
	sets.precast.WS['Judgment'].Acc50 = set_combine(sets.precast.WS['Judgment'], {})
	sets.precast.WS['Judgment'].Acc100 = set_combine(sets.precast.WS['Judgment'], sets.precast.WS.Acc100, {ear2="Moonshade earring"})
	
	-- Evisceration
	-- 50% DEX
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS['Resolution'], {
		hands="Emicho Gauntlets",
		legs="Jokushu Haidate",
		feet="Thereoid Greaves"
	})
	
	-- Cloudsplitter
	-- 40% STR/MND Lightning
	sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS, {ammo="Seething Bomblet +1",
        head="Jumalik Helm",ear1="Friomisi Earring",ear2="Moonshade Earring",
		body="Founder's Breastplate",hands="Founder's Gauntlets",
		back="toro cape",legs="Eschite cuisses",feet=OdysseanGreavesMagic
	})
	sets.precast.WS['Cloudsplitter'].Acc50 = set_combine(sets.precast.WS['Cloudsplitter'], {})
	sets.precast.WS['Cloudsplitter'].Acc100 = set_combine(sets.precast.WS['Cloudsplitter'], {})
	-- Calamity
	-- 50% STR/VIT 
	sets.precast.WS['Calamity'] = set_combine(sets.precast.WS, {
        head=ValorousMaskWSD,
		hands=OdysseanGauntletsWSD,
		legs=OdysseanCuissesWSD,
		feet="Sulevia's Leggings +2",
		ear2="Moonshade earring",
	})
	-- Ruinator
	-- 73-85% STR 
	sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS['Resolution'], {})
	
	--Midcast sets
	
	sets.midcast.Cure = {ammo="Sapience Orb",
		neck="Phalaina locket",			--cure4 curer4
		ear1="Mendicant's earring",		--cure 5
		ear2="Nourishing earring +1",	--cure 6-7
        body="Jumalik mail",			--cure 15
		hands="Macabre gauntlets +1",	--cure 11
		ring1="Kunaji Ring",			--curer 5
		ring2="Sirona's Ring",
		back="Solemnity cape",			--cure 7
		waist="Latria sash",
		legs="Souveran Diechlings",		--curer17
		feet="Souveran Schuhs"}		    --curer10 cure50		curer31
	sets.midcast['Phalanx'] = {neck="Incanter's torque",hands="Souveran handschuhs",waist="Olympus Sash",legs=OdysseanCuissesPhalanx,feet="Souveran Schuhs"}	
	-- Resting sets
	sets.resting = {
	}

	-- Idle sets
	

	sets.idle = set_combine(sets.idle.Town, {ammo="Staunch Tathlum",
		head=ValorousMaskWSD, 
		body="Souveran Cuirass", 
		hands="Souv. Handschuhs",
		legs="Souveran Diechlings", 
		feet="Hermes' Sandals",
		neck="Sanctity Necklace",
		waist="Flume Belt +1",
		left_ear="Hearty Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Regal Ring",
		back="Moonbeam Cape",
	})
	
	sets.idle.Regen = set_combine(sets.idle.Field, {})

	sets.idle.Weak = {
	 head="Twilight Helm",
	 body="Twilight Mail",
	}

	-- Defense sets
	sets.defense.PDT = {ammo="Staunch Tathlum",
		head=ValorousMaskWSD, 
		body="Souveran Cuirass", 
		hands="Souv. Handschuhs",
		legs="Souveran Diechlings", 
		feet="Amm Greaves",
		neck="Sanctity Necklace",
		waist="Flume Belt +1",
		left_ear="Hearty Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Regal Ring",
		back="Moonbeam Cape",
	}
	sets.defense.Reraise = sets.idle.Weak

	sets.defense.MDT = set_combine(sets.defense.PDT, {
	})

	sets.Kiting = {feet="Hermes' Sandals"}

	sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

	-- Defensive sets to combine with various weapon-specific sets below
	-- These allow hybrid acc/pdt sets for difficult content
	sets.Defensive = {ammo="Staunch Tathlum",
		head=ValorousMaskWSD, 
		body="Souveran Cuirass", 
		hands="Souv. Handschuhs",
		legs="Souveran Diechlings", 
		feet="Amm Greaves",
		neck="Sanctity Necklace",
		waist="Flume Belt +1",
		left_ear="Hearty Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Regal Ring",
		back="Moonbeam Cape",
	}

	-- Engaged sets
	sets.engaged = {ammo="Ginsen",		
		head="Flamma Zucchetto +1",
		body=OdysseanChestSTP, 
		hands="Argosy Mufflers +1",
		legs=OdysseanCuissesSTP,
		feet="Flam. Gambieras +1",
		neck="Ainia Collar",
		waist="Ioskeha Belt",
		left_ear="Brutal Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Hetairoi Ring",
	}
	sets.engaged.Acc50 = set_combine(sets.engaged, {
		neck="Combatant's Torque",
		right_ear="Digni. Earring",
	})
	sets.engaged.Acc100 = set_combine(sets.engaged.Acc50, {
	})

	sets.engaged.PDT = set_combine(sets.engaged, sets.Defensive)
	sets.engaged.Acc50.PDT = set_combine(sets.engaged.Acc50, sets.Defensive)
	sets.engaged.Acc100.PDT = set_combine(sets.engaged.Acc100, sets.Defensive)

	sets.engaged.DW = set_combine(sets.engaged, {
		ear1="Suppanomimi",
		ear2="Eabani Earring",
		waist="Reiki Yotai"
	})
	
	sets.engaged.Reraise = set_combine(sets.engaged, {
	head="Twilight Helm",
	body="Twilight Mail"
	})
    
end

function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type:endswith('Magic') and buffactive.silence then
        eventArgs.cancel = true
        send_command('input /item "Echo Drops" <me>')
		add_to_chat(122, "Silenced, Auto-Echos")
    --elseif spell.target.distance > 8 and player.status == 'Engaged' then
    --    eventArgs.cancel = true
    --    add_to_chat(122,"Outside WS Range! /Canceling")
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if buffactive['Terror'] or buffactive['Stun'] or buffactive['Petrification'] then
		eventArgs.cancel = true
		equip(sets.engaged.PDT)
		add_to_chat(122, "Unable to act, action cancelled")
		return	
	end
end
 
function job_post_precast(spell, action, spellMap, eventArgs)


end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
end
 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if (state.HybridMode.current == 'PDT' and state.PhysicalDefenseMode.current == 'Reraise') then
        equip(sets.Reraise)
    end

end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
    end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
end
-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
end
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    if state.HybridMode.current == 'PDT' then
        idleSet = set_combine(idleSet, sets.defense.PDT)
    end
    return idleSet
end
 
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    return meleeSet
end
 
-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == "Engaged" then
        get_combat_weapon()
    --elseif newStatus == 'Idle' then
    --    determine_idle_group()
    end
end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    
	if buffactive['Stun'] or buffactive['Petrification'] or buffactive['Terror'] then
		equip(sets.Defensive)
		add_to_chat(122, "TP set to PDT")
	end
	
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
    
    -- Warp ring rule, for any buff being lost
    if S{'Warp', 'Vocation', 'Capacity'}:contains(player.equipment.ring2) then
        if not buffactive['Dedication'] then
            disable('ring2')
        end
    else
        enable('ring2')
    end
    
    
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    
    get_combat_form()
    get_combat_weapon()

end

function get_custom_wsmode(spell, spellMap, default_wsmode)
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()
    if S{'NIN', 'DNC'}:contains(player.sub_job) and war_sub_weapons:contains(player.equipment.sub) then
        state.CombatForm:set("DW")
    else
        state.CombatForm:reset()
    end

end

function get_combat_weapon()
    if gsList:contains(player.equipment.main) then
        state.CombatWeapon:set("GreatSword")
    else -- use regular set
        state.CombatWeapon:reset()
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
end

function select_default_macro_book()
    -- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(2, 10)
	elseif player.sub_job == 'SAM' then
		set_macro_page(1, 10)
	else
		set_macro_page(1, 10)
	end
end


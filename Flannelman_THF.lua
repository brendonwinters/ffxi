-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:

    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
    
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime

--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    
    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT')

    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !- gs c cycle targetmode')

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
    -- Special sets (required by rules)
    --------------------------------------
	
	include('Flannelman_aug-gear.lua')

    ToutSTP={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
    ToutWSD={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}
	
	
    sets.TreasureHunter = {
		head="White Rarab Cap +1",--
		body=HercVestTH,
		hands="Plunderer's armlets", waist="Chaac Belt", feet="Skulker's poulaines"}
    sets.ExtraRegen = {}
    sets.Kiting = {}

    sets.buff['Sneak Attack'] = {ear1="Sherida Earring",ear2="Mache Earring",ring1="Regal Ring",ring2="Ilabrat Ring",}

    sets.buff['Trick Attack'] = {ring1="Regal Ring",ring2="Ilabrat Ring"}

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head="Raider's Bonnet +2"}
    sets.precast.JA['Accomplice'] = {head="Raider's Bonnet +2"}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines"}
    sets.precast.JA['Hide'] = {body="Pillager's Vest"}
    sets.precast.JA['Conspirator'] = {} -- {body="Raider's Vest +2"}
    sets.precast.JA['Steal'] = {head="Plunderer's Bonnet",hands="Pillager's Armlets +1",legs="Pillager's Culottes +1",feet="Pillager's Poulaines +1"}
    sets.precast.JA['Despoil'] = {legs="Raider's Culottes +2",feet="Skulker's poulaines"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets"}
    sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}
	sets.precast.JA["Assassin's Charge"] = {feet="plunderer's poulaines"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Whirlpool Mask",
        body="Pillager's Vest",hands="Pillager's Armlets",ring1="Asklepian Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Desultor tassets",feet="Plunderer's Poulaines"}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {ammo="Sapience Orb",
		head=HercHelmFC,neck="Orunmila's torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Weatherspoon Ring",
		feet=HercBootsFC}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


    -- Ranged snapshot gear
    sets.precast.RA = {legs="Adhemar Kecks",feet="Meghanada Jambeaux +2",waist="Yamaya Belt"}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		head="Pillager's Bonnet +3",
		body="Meg. Cuirie +2",
		hands="Adhemar Wristbands +1", 
		legs="Samnuha Tights",
		feet=HercBootsTA,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring", 
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back=ToutWSD,}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
		head="Pillager's Bonnet +3",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Lustratio Subligar +1",
		feet="Lustratio Leggings +1",
		left_ear="Ishvara Earring",})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Yetshila",head="Pillager's Bonnet +3",})
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Yetshila",head="Pillager's Bonnet +3",})
    sets.precast.WS["Rudra's Storm"].SATA = sets.precast.WS["Rudra's Storm"].SA
	
	--Exenterator AGI ~85% ftp carry
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		head="Pillager's Bonnet +3",
		body="Adhemar Jacket +1",
		hands="Adhemar Wristbands +1", 
		legs="Samnuha Tights",
		feet=HercBootsTA,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Cessance Earring",
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {})
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'], {ammo="Yetshila",head="Pillager's Bonnet +3",})
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'], {ammo="Yetshila",head="Pillager's Bonnet +3",})
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'], {ammo="Yetshila",head="Pillager's Bonnet +3",})

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Yetshila",
		head="Pillager's Bonnet +3",
		body="Abnoba Kaftan",
		hands="Adhemar Wristbands +1", 
		legs="Samnuha Tights",
		feet=HercBootsDmg,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Cessance Earring",
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'], {ammo="Yetshila",head="Pillager's Bonnet +3",})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'], {ammo="Yetshila",head="Pillager's Bonnet +3",})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'], {ammo="Yetshila",head="Pillager's Bonnet +3"})

    sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Mandalic Stab'].Acc = set_combine(sets.precast.WS['Mandalic Stab'], {ammo="Yetshila",head="Pillager's Bonnet +3",})
    sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'], {ammo="Yetshila",head="Pillager's Bonnet +3",})
    sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'], {ammo="Yetshila",head="Pillager's Bonnet +3",})

    sets.precast.WS['Aeolian Edge'] = {
		head=HercHelmMAB,
		body="Samnuha Coat",
		hands="Leyline Gloves",
		legs=HercLegsWSD,
		feet=HercBootsMAB,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Friomisi Earring",
		right_ear="Moonshade Earring", 
		left_ring="Regal Ring",
		right_ring="Dingir Ring",
		back=ToutWSD,}
    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {ear2="Loquacious Earring",back="Repulse Cape"}

    -- Specific spells
    sets.midcast.Utsusemi = {ear2="Loquacious Earring",back="Repulse Cape"}

    -- Ranged gear
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
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {ammo="Staunch Tathlum +1",
		head=HercHelmDT,
		body="Meg. Cuirie +2",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Jute Boots +1",
		neck="Sanctity Necklace",
		waist="Flume Belt +1",
		left_ear="Hearty Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Regal Ring",
		back="Moonlight Cape",}

    sets.idle.Weak = set_combine(sets.idle, {})


    -- Defense sets

    sets.defense.PDT = {
		head=HercHelmDT,					--4   4
		body="Meg. Cuirie +2",				--7
		hands=HercGlovesDT,					--5   3
		legs="Mummu Kecks +1",				--4   4
		feet="Jute Boots +1",
		neck="Sanctity Necklace",
		waist="Flume Belt +1",				--4
		left_ear="Hearty Earring",
		right_ear="Odnowa Earring +1",		--    2
		left_ring="Defending Ring",			--10  10
		right_ring="Regal Ring",
		back="Moonlight Cape",}				--5   5			-->39 27

    sets.defense.MDT = set_combine(sets.defense.PDT ,{})


    --------------------------------------
    -- Melee sets
    --------------------------------------

    -- Normal melee group
    sets.engaged = {ammo="Yamarang",
		head="Adhemar Bonnet +1",
		body="Adhemar Jacket +1", 
		hands="Adhemar Wristbands +1", 
		legs="Samnuha Tights", 
		feet=HercBootsTA,
		neck="Iskur Gorget",
		waist="Kentarch Belt +1",
		left_ear="Sherida Earring",
		right_ear="Cessance Earring",
		left_ring="Epona's Ring",
		right_ring="Hetairoi Ring",
		back=ToutSTP}
	
    sets.engaged.Acc = set_combine(sets.engaged, {head="Pillager's Bonnet +3",neck="Combatant's Torque",ear2="Telos Earring",ring2="Regal Ring"})
        
    sets.engaged.PDT = set_combine(sets.defense.PDT, {feet=HercBootsDT})
    sets.engaged.Acc.PDT = sets.engaged.PDT

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
	if buffactive['Terror'] or buffactive['Stun'] or buffactive['Petrification'] then
            eventArgs.cancel = true
			equip(sets.engaged.PDT)
			add_to_chat(122, "Unable to act, action cancelled")
            return	
	end
end
-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
	if spell.type == 'WeaponSkill' and player.tp > 2499 then
		equip({ear1="Sherida Earring",ear2="Ishvara Earring"})	
	end	
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
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
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end

    return idleSet
end


function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
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
    
    msg = msg .. ', TH: ' .. state.TreasureMode.value

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
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end


-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 5)
    elseif player.sub_job == 'WAR' then
        set_macro_page(2, 5)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 5)
    else
        set_macro_page(2, 5)
    end
end



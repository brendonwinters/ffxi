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
    state.OffenseMode:options('Normal', 'Acc', 'Mod')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')


    gear.default.weaponskill_neck = "Asperity Necklace"
    gear.default.weaponskill_waist = "Caudata Belt"
    gear.AugQuiahuiz = {name="Quiahuiz Trousers", augments={'Haste+2','"Snapshot"+2','STR+8'}}

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
	HercHelmMAB={ name="Herculean Helm",  augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Crit.hit rate+2','"Mag.Atk.Bns."+14',}}
    HercHelmDT={ name="Herculean Helm", augments={'Weapon skill damage +3%','Phys. dmg. taken -2%','Damage taken-3%','Accuracy+2 Attack+2',}}	
    HercHelmWSD={ name="Herculean Helm",  augments={'Attack+22','Weapon skill damage +4%','DEX+8',}}
    HercHelmTA={ name="Herculean Helm", augments={'"Triple Atk."+4','STR+10','Attack+12',}}
	
    HercVestTH={ name="Herculean Vest", augments={'CHR+6','Weapon Skill Acc.+12','"Treasure Hunter"+1','Mag. Acc.+4 "Mag.Atk.Bns."+4',}}
	
    HercGlovesDT={ name="Herculean Gloves", augments={'Damage taken-3%','"Mag.Atk.Bns."+24','Accuracy+13 Attack+13',}}
    HercGlovesTH={ name="Herculean Gloves", augments={'STR+10','"Mag.Atk.Bns."+4','"Treasure Hunter"+1','Accuracy+2 Attack+2',}}
	
    HercLegsAcc={ name="Herculean Trousers", augments={'Accuracy+20 Attack+20','Crit. hit damage +3%','DEX+5','Accuracy+12','Attack+15',}}
	
	HercBootsDT={ name="Herculean boots", augments={'Damage taken-4%','AGI+1','Accuracy+12',}}
	HercBootsDmg={ name="Herculean Boots", augments={'Accuracy+25 Attack+25','Crit.hit rate+2','DEX+11','Accuracy+14','Attack+11',}}
	HercBootsRefresh={ name="Herculean Boots", augments={'Phys. dmg. taken -2%','AGI+7','"Refresh"+1','Accuracy+18 Attack+18',}}
    HercBootsDW={ name="Herculean Boots", augments={'Attack+17','"Dual Wield"+6','Accuracy+15',}}

	
    sets.TreasureHunter = {
		--"White Rarab Cap +1",--body=HercVestTH,
		hands="Plunderer's armlets", waist="Chaac Belt", feet="Raider's Poulaines +2"}
    sets.ExtraRegen = {}
    sets.Kiting = {}

    sets.buff['Sneak Attack'] = {ear1="Sherida Earring",ring1="Apate Ring",ring2="Ilabrat Ring",back="kayapa cape"}

    sets.buff['Trick Attack'] = {ring1="Apate Ring",ring2="Dingir Ring"}

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
    sets.precast.JA['Despoil'] = {legs="Raider's Culottes +2",feet="Raider's Poulaines +2"}
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
    sets.precast.FC = {head="Haruspex Hat",neck="Orunmila's torque",ear2="Loquacious Earring",hands="Thaumas Gloves",ring1="Prolix Ring",legs="Enif Cosciales",back="Repulse Mantle"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


    -- Ranged snapshot gear
    sets.precast.RA = {head="Aurore Beret",hands="Iuitl Wristbands",legs="Nahtirah Trousers",feet="Wurrukatte Boots"}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="seething bomblet +1",
        head="adhemar bonnet",neck="Fotia gorget",ear1="Brutal Earring",ear2="moonshade earring",
        body="abnoba kaftan",hands="adhemar wristbands",ring1="Rajas Ring",ring2="Epona's ring",
        back="grounded mantle",waist="Fotia Belt",legs="Meghanada chausses +1",feet=HercBootsDmg}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Honed Tathlum", back="Letalis Mantle"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {back="Kayapa cape"})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {ammo="Honed Tathlum", back="Letalis Mantle"})
    sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {head="Felistris Mask"})
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Qirmiz Tathlum"})
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Qirmiz Tathlum"})
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Qirmiz Tathlum"})

    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {ammo="Honed Tathlum", back="Letalis Mantle"})
    sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Qirmiz Tathlum"})
    sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Qirmiz Tathlum"})
    sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Qirmiz Tathlum"})

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ring1="Begrudging Ring", legs="Herculean Trousers"})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {ammo="Honed Tathlum",head="adhemar bonnet", back="Letalis Mantle"})
    sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {back="Kayapa Cape",head="adhemar bonnet"})
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mod, {head="adhemar bonnet"})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mod, {head="adhemar bonnet"})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mod, {head="adhemar bonnet"})

    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {hands="Meghanada Gloves +1",legs="samnuha tights",neck="caro necklace",ear1="dominance earring +1",ring2="Apate ring",waist="chaac belt"})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Honed Tathlum", back="Letalis Mantle"})
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"], {hands="Meghanada Gloves +1",ear1="dominance earring +1",ring2="Apate ring"})
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"], {hands="Meghanada Gloves +1",ear1="dominance earring +1",ring2="Apate ring"})
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"], {hands="Meghanada Gloves +1",ear1="dominance earring +1",ring2="Apate ring"})

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {ammo="Honed Tathlum", back="Letalis Mantle"})
    sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
    sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
    sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +1",legs="Pillager's Culottes +1"})

    sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {head="Pillager's Bonnet +1"})
    sets.precast.WS['Mandalic Stab'].Acc = set_combine(sets.precast.WS['Mandalic Stab'], {ammo="Honed Tathlum", back="Letalis Mantle"})
    sets.precast.WS['Mandalic Stab'].Mod = set_combine(sets.precast.WS['Mandalic Stab'], {back="Kayapa Cape",waist=gear.ElementalBelt})
    sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
    sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
    sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +1",legs="Pillager's Culottes +1"})

    sets.precast.WS['Aeolian Edge'] = {
		ammo="Seeth. Bomblet +1",
		head={ name="Herculean Helm", augments={'"Counter"+2','"Mag.Atk.Bns."+17','INT+4 MND+4 CHR+4','Accuracy+10 Attack+10','Mag. Acc.+7 "Mag.Atk.Bns."+7',}},
		body={ name="Samnuha Coat", augments={'Mag. Acc.+14','"Mag.Atk.Bns."+13','"Fast Cast"+4','"Dual Wield"+3',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs={ name="Herculean Trousers", augments={'Attack+13','Phys. dmg. taken -4%','STR+6',}},
		feet={ name="Herculean Boots", augments={'Crit.hit rate+1','Pet: Attack+9 Pet: Rng.Atk.+9','"Refresh"+1','Accuracy+4 Attack+4','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +25',}},
		left_ring="Acumen Ring",
		right_ring="Epona's Ring",
		back="Toro Cape",
	}

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {ear2="Loquacious Earring",back="Repulse Cape"}

    -- Specific spells
    sets.midcast.Utsusemi = {ear2="Loquacious Earring",back="Repulse Cape"}

    -- Ranged gear
    sets.midcast.RA = {
        head="Whirlpool Mask",neck="Ej Necklace",ear1="Clearview Earring",ear2="Volley Earring",
        body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Hajduk Ring",
        back="Libeccio Mantle",waist="Aquiline Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}

    sets.midcast.RA.Acc = {
        head="Pillager's Bonnet +1",neck="Ej Necklace",ear1="Clearview Earring",ear2="Volley Earring",
        body="Iuitl Vest",hands="Buremte Gloves",ring1="Beeline Ring",ring2="Hajduk Ring",
        back="Libeccio Mantle",waist="Aquiline Belt",legs="Thurandaut Tights +1",feet="Pillager's Poulaines"}


    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {head="Ocelomeh Headpiece +1",neck="Sanctity Necklace",
        ear1="Brachyura earring",ring2="Paguroidea Ring"}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
        head="adhemar bonnet",neck="Sanctity Necklace",ear1="Hearty Earring",ear2="Odnowa Earring +1",
        body="Emet harness",hands="Umuthi gloves",ring1="Defending Ring",ring2="Shneddick ring",
        back="shadow mantle",waist="Flume Belt +1",legs="herculean trousers",feet="Jute Boots +1"}

    sets.idle.Town = {
        head="adhemar bonnet",neck="Sanctity Necklace",ear1="Hearty Earring",ear2="Odnowa Earring +1",
        body="Emet harness",hands="Umuthi gloves",ring1="Defending Ring",ring2="Shneddick ring",
        back="shadow mantle",waist="Flume Belt +1",legs="herculean trousers",feet="Jute Boots +1"}

    sets.idle.Weak = {
        head="adhemar bonnet",neck="Sanctity Necklace",ear1="Hearty Earring",ear2="Odnowa Earring +1",
        body="Emet harness",hands="Umuthi gloves",ring1="Defending Ring",ring2="Shneddick ring",
        back="shadow mantle",waist="Flume Belt +1",legs="herculean trousers",feet="herculean boots"}


    -- Defense sets

    sets.defense.Evasion = {
        head="Pillager's Bonnet +1",neck="Ej Necklace",
        body="Qaaxo Harness",hands="Pillager's Armlets +1",ring1="Defending Ring",ring2="Beeline Ring",
        back="Canny Cape",waist="Flume Belt",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}

    sets.defense.PDT = {ammo="Iron Gobbet",
        head="adhemar bonnet",neck="Twilight Torque",ear1="Hearty Earring",ear2="Odnowa Earring +1",
        body="Emet harness",hands="Umuthi gloves",ring1="Defending Ring",ring2="Shneddick ring",
        back="shadow mantle",waist="Flume Belt",legs="herculean trousers",feet="herculean boots"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="dampening tam",neck="Twilight Torque",ear1="Hearty Earring",ear2="Odnowa Earring +1",
        body="Pillager's Vest +1",hands="Pillager's Armlets +1",ring1="Defending Ring",ring2="Shneddick ring",
        back="Engulfer Cape",waist="Flume Belt",legs="herculean trousers",feet="herculean boots"}


    --------------------------------------
    -- Melee sets
    --------------------------------------

    -- Normal melee group
    sets.engaged = {
		head={ name="Herculean Helm", augments={'"Triple Atk."+4','STR+10','Attack+12',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Attack+17','"Dual Wield"+6','Accuracy+15',}},
		neck="Ainia Collar",
		waist="Kentarch Belt +1",
		left_ear="Eabani Earring",
		right_ear="Suppanomimi",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Canny Cape", augments={'DEX+4','AGI+2','"Dual Wield"+2','Crit. hit damage +1%',}},
	}
	
    sets.engaged.Acc = {
        head="dampening tam",neck="Subtlety Spectacles",ear1="Brutal Earring",ear2="suppanomimi",
        body="Rawhide vest",hands="floral gauntlets",ring1="Petrov Ring",ring2="epona's ring",
        back="Canny cape",waist="Kentarch Belt +1",legs="samnuha tights",feet="herculean boots"}
        
    -- Mod set for trivial mobs (Skadi+1)
    sets.engaged.Mod = {ammo="Thew Bomblet",
        head="Felistris Mask",neck="Asperity Necklace",ear1="Brutal Earring",ear2="suppanomimi",
        body="Skadi's Cuirie +1",hands="Pillager's Armlets +1",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist="shetal stone",legs=gear.AugQuiahuiz,feet="herculean socks"}

    -- Mod set for trivial mobs (Thaumas)
    sets.engaged.Mod2 = {ammo="Thew Bomblet",
        head="Felistris Mask",neck="Defiant Collar",ear1="Brutal Earring",ear2="suppanomimi",
        body="Thaumas Coat",hands="Pillager's Armlets +1",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist="shetal stone",legs="Pillager's Culottes +1",feet="Plunderer's Poulaines +1"}

    sets.engaged.Evasion = {ammo="Thew Bomblet",
        head="Felistris Mask",neck="Ej Necklace",ear1="Brutal Earring",ear2="suppanomimi",
        body="Qaaxo Harness",hands="Pillager's Armlets +1",ring1="Beeline Ring",ring2="Epona's Ring",
        back="Canny Cape",waist="shetal stone",legs="Kaabnax Trousers",feet="Qaaxo Leggings"}
    sets.engaged.Acc.Evasion = {ammo="Honed Tathlum",
        head="Whirlpool Mask",neck="Ej Necklace",ear1="Dominance Earring +1",ear2="Brutal Earring",
        body="Pillager's Vest +1",hands="Pillager's Armlets +1",ring1="Beeline Ring",ring2="Epona's Ring",
        back="Canny Cape",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Qaaxo Leggings"}

    sets.engaged.PDT = {ammo="Thew Bomblet",
        head="adhemar bonnet",neck="Twilight Torque",ear1="Brutal Earring",ear2="suppanomimi",
        body="Emet harness",hands="herculean gloves",ring1="Defending Ring",ring2="Epona's Ring",
        back="Solemnity Cape",waist="shetal stone",legs="herculean trousers",feet="herculean boots"}
    sets.engaged.Acc.PDT = {ammo="Honed Tathlum",
        head="adhemar bonnet",neck="Twilight Torque",ear1="Dominance Earring +1",ear2="Brutal Earring",
        body="Emet harness",hands="herculean gloves",ring1="Defending Ring",ring2="Epona's Ring",
        back="Canny Cape",waist="Hurch'lan Sash",legs="herculean trousers",feet="herculean boots"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
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



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
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
	state.Buff.DivineEmblem = buffactive['Divine Emblem'] or false
	
    -- Offhand weapons used to activate DW mode
    pld_sub_weapons = S{"Claidheamh Soluis"}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'HP', 'Meva', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('Meva', 'Reraise')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'Meva', 'Terror', 'Charm', 'Stun'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')
	state.RefreshMode = M(false, 'Refresh Mode')
	state.SIRDMode = M(false, 'SIRD Mode')
    
	update_defense_mode()
    
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind @` gs c cycle ExtraDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')
    send_command('bind !` gs c toggle RefreshMode')
    send_command('bind ^` gs c toggle SIRDMode')

    select_default_macro_book()
end

function user_unload()
    send_command('unbind ^f11')
    send_command('unbind @`')
    send_command('unbind @f10')
    send_command('unbind @f11')
    send_command('unbind !`')
    send_command('unbind ^`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
         -- Augmented gear  

	include('Flannelman_aug-gear.lua')
	
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = {legs="Caballarius Breeches"}
    sets.precast.JA['Holy Circle'] = {feet="Reverence Leggings +1"}
    sets.precast.JA['Shield Bash'] = {hands="Caballarius Gauntlets"}
    sets.precast.JA['Sentinel'] = {feet="Caballarius Leggings +1"}
    sets.precast.JA['Rampart'] = {head="Caballarius Coronet"}
    sets.precast.JA['Fealty'] = {body="Caballarius Surcoat +1"}
    sets.precast.JA['Divine Emblem'] = {feet="Chevalier's Sabatons"}

    -- add MND for Chivalry
    sets.precast.JA['Chivalry'] = {    
		head="Carmine Mask",
		body="Emet Harness +1",
		hands="Emicho gauntlets",
		legs="Founder's Hose",
		feet="Carmine Greaves",
		neck="Phalaina Locket",
		waist="Latria Sash",
		ear2="Lifestorm Earring",
		ring2="Sirona's Ring",}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {neck="Unmoving collar +1"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {waist="Chaac Belt"}
    sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Sapience orb",--2
		head="Carmine Mask",			--12
		body="Reverence Surcoat +2",	--5
		neck="Orunmila's torque",		--5
		ear1="Etiolation Earring",		--1
		ear2="Odnowa Earring +1",		
		hands="Leyline gloves",			--8
		ring1="Kishar ring",			--4
		ring2="weatherspoon ring",		--5
		legs="Eschite cuisses",			--5
		feet=OdysseanGreavesFC,			--8
		waist="Creed Baudrier",
		back="Moonbeam Cape",
		--back="Rudianos's Mantle"
		}								--65
	sets.precast.FC.HP = set_combine(sets.precast.FC, {
		legs="Arke Cosciales",
		back="Moonbeam Cape",})	

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {	ammo="Hasty Pinion +1",
        head="Valorous mask",neck="Fotia gorget",ear1="Lugra Earring +1",ear2="Brutal Earring",
        body="Sulevia's Platemail +1",hands="Sulevia's gauntlets +1",ring1="Rajas Ring",ring2="Regal Ring",
        back="Lupine Cape",waist="Fotia Belt",legs="Sulevia's cuisses +1",feet="Sulevia's Leggings +2"}


    sets.precast.WS.Acc = set_combine(sets.precast.WS,{ring2="Cacoethic Ring +1",feet=OdysseanGreavesAcc})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ring1="Sangoma ring"})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {ring1="Sangoma ring"})

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
		head="Flamma Zucchetto +1",
		body={ name="Valorous Mail", augments={'Accuracy+18','"Dbl.Atk."+4','DEX+7',}},
		hands="Sulev. Gauntlets +1",
		legs={ name="Odyssean Cuisses", augments={'Accuracy+14 Attack+14','Mag. Acc.+24','"Store TP"+10','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		feet={ name="Odyssean Greaves", augments={'Crit. hit damage +3%','Accuracy+28','Accuracy+18 Attack+18',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +25',}},
		right_ear="Telos Earring",
		left_ring="Hetairoi Ring",
		right_ring="Regal Ring",
		back="Lupine Cape",})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {ear2="moonshade earring",ring1="Apate ring"})
	sets.precast.WS['Judgment'] = set_combine(sets.precast.WS['Chant du Cygne'], {hands="Odyssean Gauntlets"})

    sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",ear2="Friomisi Earring",
		body="Jumalik mail",hands="Leyline gloves",ring1="acumen ring",ring2="Sangoma ring",
		back="toro cape",legs="Eschite cuisses",feet=OdysseanGreavesMagic}
   sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Sanguine Blade'], {})
   sets.precast.WS['Atonement'] = {
		head="Valorous mask",neck="Fotia gorget",
		hands=OdysseanGauntletsWSD,ring2="weatherspoon ring",
		waist="Fotia Belt",legs=ValorousHoseWSD,feet="Sulevia's Leggings +2"} 
    --------------------------------------
    -- Midcast sets
    --------------------------------------
	--not fast recast but spell interruption down set
    sets.midcast.FastRecast = {
		head="Souveran schaller",					--15
		--body="Eschite breastplate",					--15
		hands="Eschite gauntlets",					--15
		ring1="Defending ring",
		ring2="Moonbeam ring",
		legs="Founder's hose",						--30
		back="Moonbeam Cape",
		feet=OdysseanGreavesFC}						--20 -> 110
        
	sets.midcast.SIRD = {ammo="Staunch Tathlum",	--10
		head="Souveran schaller",					--15
		ear2="Knightly Earring",					--9
		hands="Eschite gauntlets",					--15
		ring2="Evanescence ring",					--5
		legs="Founder's hose",						--30
		feet=OdysseanGreavesFC}						--20 -> 104
		
		
    sets.midcast.Enmity = {
        head="Souveran Schaller",					--7
		neck="Unmoving collar +1",					--10
        body="Souveran cuirass",					--17
		hands="Macabre gauntlets +1",				--7
		ring1="Apeile Ring",						--9
		ring2="Apeile Ring +1",						--9
        --back="Weard Mantle",						--4 (up to 7)
		waist="Creed Baudrier",						--5
		legs="Souveran Diechlings",					--7
		feet="Eschite Greaves"}						--15
		
		
    sets.midcast.Flash = set_combine(sets.midcast.Enmity, {})    
    sets.midcast.Stun = sets.midcast.Flash
    
    sets.midcast.Cure = {
		head="Souveran Schaller",		--curer10
		neck="Phalaina locket",			--cure4 curer4
		--ear1="Mendicant's earring",	
		ear1="Nourishing earring +1",	--cure 6-7
		ear2="Odnowa Earring +1",
        body="Souveran Cuirass",		--cure10 curer10
		hands="Macabre gauntlets +1",	--cure 11
		ring1="Defending Ring",			
		ring2="Moonbeam Ring",
		--back="Solemnity cape",			
		back="Moonbeam cape",	
		legs="Souveran Diechlings",		--curer17
		feet=OdysseanGreavesFC}		    --cure7				 cure38		curer31
		

    sets.midcast['Phalanx'] = {head=ValorousMaskPhalanx,neck="Incanter's torque",back="Weard Mantle",hands="Souveran handschuhs",waist="Olympus Sash",legs=OdysseanCuissesPhalanx,feet="Souveran Schuhs"}
    sets.midcast.Holy = {ammo="Pemphredo Tathlum",
		head="jumalik helm",neck="Incanter's torque",ear1="Friomisi earring",ear2="Gwati earring",
		body="Jumalik mail",hands="Leyline gloves",ring1="acumen ring",ring2="weatherspoon ring",
		back="toro cape",waist="Eschan stone",legs="Eschite cuisses",feet=OdysseanGreavesMagic}
    sets.midcast.Protect = {ear1="Brachyura earring"}
    sets.midcast.Shell = {ear1="Brachyura earring"}
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
    
    sets.resting = {}
    

    -- Idle sets
    sets.idle = {ammo="Staunch Tathlum",
        head="Souveran Schaller",neck="Coatl Gorget +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        body="Reverence Surcoat +2",hands="Souveran Handschuhs",ring1="Defending Ring",ring2="Moonbeam Ring",
        back="Moonbeam Cape",waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="Souveran Schuhs"}
   	
    sets.idle.Weak = sets.idle    
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
    
    sets.Kiting = {legs="Carmine Cuisses +1",}
	--feet="Hippomenes Socks +1"}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Defense sets
    --------------------------------------
    

    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {sub="Ochain"} -- Ochain
    sets.MagicalShield = {sub="Aegis"} -- Aegis

    -- Basic defense sets.
        
    sets.defense.PDT = {sub="Ochain",ammo="Staunch Tathlum",
        head="Jumalik helm",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Odnowa Earring +1",
        body="Souveran cuirass",hands="Souveran handschuhs",ring1="Defending Ring",ring2="Regal Ring",
        back="Moonbeam Cape",waist="Flume Belt +1",legs="Souveran Diechlings",feet="Amm greaves"}
    sets.defense.Reraise = {ammo="homiliary",
        head="Twilight Helm",neck="Loricate torque +1",ear2="Odnowa Earring +1",
        body="Twilight Mail",hands="Souveran handschuhs",ring1="Defending Ring",ring2="Regal Ring",
        back="Weard Mantle",waist="Flume Belt +1",legs="Souveran Diechlings",feet="Amm greaves"}
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.Meva = {sub="Aegis",ammo="homiliary",
        head="Souveran schaller",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Ethereal Earring",
        body="Souveran cuirass",hands="souveran handschuhs",ring1="Defending Ring",ring2="Regal Ring",
        back="Engulfer cape +1",waist="Flume Belt +1",legs="Souveran Diechlings",feet="Amm greaves"}

    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    sets.engaged = {
		ammo="Ginsen",
		head="Flamma Zucchetto +1",
		body={ name="Valorous Mail", augments={'Accuracy+18','"Dbl.Atk."+4','DEX+7',}},
		hands="Sulev. Gauntlets +1",
		legs={ name="Odyssean Cuisses", augments={'Accuracy+14 Attack+14','Mag. Acc.+24','"Store TP"+10','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		feet="Flamma Gambieras +1",
		neck="Ainia Collar",
		waist="Sailfi Belt +1",
		left_ear="Brutal Earring",
		right_ear="Telos Earring",
		left_ring="Hetairoi Ring",
		right_ring="Petrov Ring",
		back="Lupine Cape",}

    sets.engaged.Acc = set_combine(sets.engaged, {
        neck="Combatant's Torque",ear1="dominance earring +1",ear2="Zennaroi earring",
		hands="Emicho gauntlets",
		legs={ name="Odyssean Cuisses", augments={'Accuracy+24 Attack+24','"Fast Cast"+1','STR+1','Accuracy+12',}},
		back="grounded mantle",waist="Kentarch Belt +1"})
    
	-- Extra defense sets.  Apply these on top of melee or defense sets.
    --sets.Knockback = {back="Philidor Mantle"}
	sets.Meva = 	{ear1="Hearty earring",ear2="Flashward earring",waist="Asklepian Belt",ring2="Purity ring",back="Rudianos's Mantle"}
	sets.Terror = 	set_combine(sets.Meva,{feet="Founder's greaves"})
	sets.Charm =	set_combine(sets.Meva,{neck="Unmoving collar +1",legs="Souveran diechlings",back="Solemnity cape"})
	sets.Stun =		set_combine(sets.Meva,{ear2="Dominance earring +1"})
	
	sets.Defensive = {ammo="Staunch Tathlum",
		head="Souveran Schaller",
		body="Reverence Surcoat +2",
		hands={ name="Souv. Handschuhs", augments={'HP+50','Shield skill +10','Phys. dmg. taken -3',}},
		legs={ name="Souveran Diechlings", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear="Telos Earring",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back="Moonbeam Cape",
	}
	--ammo="homiliary",																--brilliance 3				 3
--		head="Jumalik helm",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Ethereal Earring",		--pdt  5 6 			 mdt   6
--        body="Souveran cuirass",hands="Souveran handschuhs",ring1="Defending Ring",ring2="Regal Ring",		--pdt  9 3 10 6 	 mdt 9 4 10 3 
--        back="Moonbeam Cape",waist="Flume Belt +1",legs="Souveran Diechlings",feet="Souveran Schuhs"}		--pdt    4 3 4 -> 53 mdt     3    -> 38
		
    sets.Defensive_Acc = {  
		ammo="Ginsen",
		head="Sulevia's Mask +1",			--pdt 	5		mdt 5
		body="Sulevia's Plate. +1",			--		8			8
		hands="Sulev. Gauntlets +1",		--		4			4
		legs="Sulevi. Cuisses +1",			--		6			6
		feet="Loyalist Sabatons",			--		2
		neck="Loricate Torque +1",			--		6			6
		waist="Sailfi Belt +1",
		left_ear="Dominance Earring +1",
		right_ear="Brutal Earring",
		left_ring="Defending Ring",			--		10			10	
		right_ring="Moonbeam Ring",				--		6			3
		back="Moonbeam Cape",}				--		3			3	-->50 45
		
	sets.Defensive_HP = {
		ammo="Staunch Tathlum",
		head="Arke Zuchetto",
		body="Souveran Cuirass",
		hands="Souv. Handschuhs", 
		legs="Arke Cosciales",
		feet="Souveran Schuhs", 
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back="Moonbeam Cape",}
				
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)
	
     sets.engaged.PDT = set_combine(sets.engaged, sets.Defensive)
     sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.Defensive_Acc)

	sets.engaged.Meva = set_combine(sets.Defensive, {head="Souveran Schaller",ring2="Archon Ring",back="Engulfer cape +1",feet="Amm greaves"})	
	sets.engaged.Acc.Meva = set_combine(sets.Defensive_Acc, {back="Engulfer cape +1",feet="Amm greaves"})
			 
     sets.engaged.HP = set_combine(sets.engaged, sets.Defensive_HP)
	
	 sets.engaged.DW = set_combine(sets.engaged, {ear1="Brutal earring",ear2="suppanomimi",waist="Reiki Yotai"})
     sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {neck="Combatant's Torque",ring2="Cacoethic Ring +1"})
	 sets.engaged.DW.PDT = set_combine(sets.Defensive, sets.engaged.DW)
	 sets.engaged.DW.Acc.PDT = set_combine(sets.Defensive_Acc, sets.engaged.DW)
 	 sets.engaged.DW.Meva = set_combine(sets.engaged.Meva, sets.engaged.DW)
	 sets.engaged.DW.Acc.Meva = set_combine(sets.engaged.Acc.Meva, sets.engaged.DW)

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {ring2="Purity Ring",waist="Gishdubar sash"}
    sets.buff.Cover = {body="Caballarius surcoat +1"}
	
	sets.Refresh = {ammo="Homiliary",head="Jumalik helm",body="Jumalik mail",hands=OdysseanGauntletsRefresh,ear1="Ethereal earring",waist="Flume belt +1",back="Rudianos's Mantle"}
    sets.Berserker = { neck="Berserker's Torque" }
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

function job_post_precast(spell, action, spellMap, eventArgs)
	if state.HybridMode.value == 'HP' then
		equip(sets.precast.FC.HP)
	end
end
	
 function job_midcast(spell, action, spellMap, eventArgs)
    -- -- If DefenseMode is active, apply that gear over midcast
    -- -- choices.  Precast is allowed through for fast cast on
    -- -- spells, but we want to return to def gear before there's
    -- -- time for anything to hit us.
    -- -- Exclude Job Abilities from this restriction, as we probably want
    -- -- the enhanced effect of whatever item of gear applies to them,
    -- -- and only one item should be swapped out.
     if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
         handle_equipping_gear(player.status)
         eventArgs.handled = true
     end
 end
--function job_midcast(spell, action, spellMap, eventArgs)
--end	
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.english == 'Holy II' then	
		if spell.element == world.day_element or spell.element == world.weather_element then
			equipSet=set_combine(sets.midcast.Holy,{waist="Hachirin-No-Obi"})
			add_to_chat(122, "Weather nuke")
			equip(equipSet)
        end
		if state.Buff.DivineEmblem then
			equipSet=set_combine(sets.midcast.Holy,sets.precast.JA['Divine Emblem'])
			equip(equipSet)
		end
	elseif spell.skill == 'Healing Magic' then	
		if spell.element == world.day_element or spell.element == world.weather_element then		
				equipSet=set_combine(equipSet,{waist="Hachirin-No-Obi"})
				add_to_chat(122, "Weather Cure")		
		end
	elseif spell.english == 'Stun' then
		equipSet=sets.midcast.Enmity
		equip(equipSet)
	end
	
	if state.SIRDMode.value then
		add_to_chat(122, "SIRD")
		send_command('gs c toggle SIRDMode')
		equip(sets.midcast.SIRD)
	end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)	
	if spell.interrupted and not state.SIRDMode.value then
		send_command('gs c toggle SIRDMode')
	end	
	
	if state.RefreshMode.value then
		equip(sets.Refresh) 
	end 
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if state.RefreshMode.value then 
		idleSet = sets.Refresh
	end	
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    if state.ExtraDefenseMode then
		idleSet = set_combine(idleSet, sets[state.ExtraDefenseMode.value])
	end
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    
    if state.ExtraDefenseMode.value ~= 'None' then
        meleeSet = set_combine(meleeSet, sets[state.ExtraDefenseMode.value])
    end
    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
    
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
    
    return defenseSet
end


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
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
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

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
--auto use echo drops
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type:endswith('Magic') and buffactive.silence then
        eventArgs.cancel = true
        send_command('input /item "Echo Drops" <st>')
		add_to_chat(122, "Silenced, Auto-Echos")
    end
end

function update_defense_mode()
    if S{'NIN', 'DNC'}:contains(player.sub_job) and pld_sub_weapons:contains(player.equipment.sub) then
        state.CombatForm:set("DW")
	else
        state.CombatForm:reset()
    end
    -- if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        -- if player.equipment.sub and not player.equipment.sub:contains('Shield') and not
           -- player.equipment.sub ~= 'Aegis' and not player.equipment.sub ~= 'Ochain' then
            -- state.CombatForm:set('DW')
        -- else
            -- state.CombatForm:reset()
        -- end
	-- end
end


function job_buff_change(buff, gain)
    -- Automatically wake me when I'm slept
    if string.lower(buff) == "sleep" and gain and player.hp > 200 then
        equip(sets.Berserker)
    end
	
	if buffactive['Stun'] or buffactive['Petrification'] or buffactive['Terror'] then
		equip(sets.engaged.PDT)
		add_to_chat(122, "TP set to PDT")
	end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'RDM' then
        set_macro_page(1, 2)
    else
        set_macro_page(1, 2)
    end
end


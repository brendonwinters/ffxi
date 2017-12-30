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
    state.Buff.Saboteur = buffactive.saboteur or false
	state.Buff.Chainspell = buffactive.chainspell or false
	state.Buff.Spontaneity = buffactive.spontaneity or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'MDT', 'Rdark')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

    state.MagicBurst = M(false, 'Magic Burst')
	
 --   gear.default.obi_waist = "Sekhmet Corset"
    
    send_command('bind ^` input /ma Stun <t>')
    send_command('bind !` gs c toggle MagicBurst')
	
    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

	MerlinicHood={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic Damage +5','Mag. Acc.+4','"Mag.Atk.Bns."+13',}}
    MerlinicHoodMBD={ name="Merlinic Hood", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Magic burst mdg.+9%','CHR+10','Mag. Acc.+2','"Mag.Atk.Bns."+14',}}
	 
    MerlinicHandsFC={ name="Merlinic Dastanas", augments={'Mag. Acc.+16','"Fast Cast"+6','"Mag.Atk.Bns."+4',}}
	
    MerlinicShalwar={ name="Merlinic Shalwar", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Mag. crit. hit dmg. +3%','Mag. Acc.+11','"Mag.Atk.Bns."+13',}}
    MerlinicShalwarMBD={ name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+28','Magic burst mdg.+10%','CHR+9','Mag. Acc.+7',}}
    MerlinicShalwarAspir={ name="Merlinic Shalwar", augments={'Mag. Acc.+26','"Drain" and "Aspir" potency +8','MND+3',}}
	
    MerlinicCrackows={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic Damage +7','INT+7','"Mag.Atk.Bns."+14',}}
    MerlinicCrackowsMBD={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst mdg.+5%','"Mag.Atk.Bns."+2',}}
    MerlinicCrackowsFC={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+30','"Fast Cast"+6','MND+3','Mag. Acc.+4',}}
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitivation Tabard"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Atrophy Chapeau",
        body="Atrophy Tabard +1",hands="Yaoyotl Gloves",
        back="Refraction Cape",legs="hagondes pants +1",feet="Hagondes Sabots"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
    sets.precast.FC = {ammo="Impatiens",
        head="Carmine Mask",								--12
		ear2="Loquacious Earring", 							--2
        neck="Orunmila's torque",							--5
		body="Vitivation Tabard",							--12
		hands="Leyline gloves",								--7
		ring1="Lebeche ring",
		ring2="weatherspoon ring",							--5
 --       back="Ogapepo Cape",
		waist="Witful Belt",			--3
		legs="lengo pants", 								--5
		feet=MerlinicCrackowsFC}							--11
	
	
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear1="Mendicant's earring"})
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Ginsen",
		head="Jhakri Coronal +1",body="Jhakri Robe +1",hands="Jhakri Cuffs +1",legs="Jhakri Slops +1",feet="Thereoid Greaves",
        neck="Fotia gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        ring1="Rajas Ring",ring2="Shukuyu ring",
        back="Grounded mantle",waist="Fotia belt"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Merlinic Jubbah",hands="Jhakri Cuffs +1",ring1="Acumen Ring",ring2="Archon Ring",
        back="Toro Cape",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1",}

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {ammo="Ginsen",
		head="Jhakri Coronal +1",body="Jhakri Robe +1",hands="Jhakri Cuffs +1",legs="Jhakri Slops +1",feet="Thereoid Greaves",
		ring1="Shukuyu Ring",ring2="Begrudging Ring"})
	
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
		ammo="Ginsen",body="Jhakri Robe +1",hands="Jhakri Cuffs +1",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1",ring1="Shukuyu Ring"})
		
    -- Midcast Sets
    

    sets.midcast.FastRecast = {head="Hike Hat"}

	sets.midcast.Cure = set_combine(sets.midcast.FastRecast,{
		neck="Phalaina locket",ear1="Mendicant's earring",ear2="Lifestorm earring",--4 5
        body="Vrikodara Jupon",hands="Telchine Gloves",ring1="ephedra ring",ring2="sirona's ring",--13					
        back="Solemnity cape",waist="Latria sash",feet="medium's sabots"})--6+10+12 = 50
        
    sets.midcast.Curaga = sets.midcast.Cure
	sets.midcast.Cursna = {ring1="Ephedra ring",ring2="ephedra ring",feet="gendewitha galoshes +1"}
    sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {head="Telchine Cap",neck="Phalaina locket",ring1="Kunaji Ring",waist="Gishdubar Sash"})
	--508 enh skill
	
    sets.midcast['Enhancing Magic'] = {
		head="telchine cap",		--			dur8
		neck="Incanter's torque",	--skill10
        body="Telchine chasuble",	--12
--		hands="Atrophy Gloves",		--			dur15
		hands="telchine gloves",	--			dur8
--		hands="vitivation gloves",	--18
        back="Ghostfyre Cape",		--5			dur17
		waist="olympus sash",		--5
		legs="telchine braconi",	--				9
		feet="lethargy houseaux"}	--skill20	dur25		=skill 89	dur65

    sets.midcast.EnhancingDuration = {
		head="telchine cap",body="Telchine chasuble",hands="Atrophy Gloves",
		back="Ghostfyre Cape",legs="telchine braconi",feet="Lethargy Houseaux"}
									  
    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {head="Amalric Coif +1",legs="Lethargy Fuseau"})
    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration,{head="Amalric Coif +1"})

 --   sets.midcast.Stoneskin = {waist="Siegel Sash"}
    
    sets.midcast['Enfeebling Magic'] = {main="Malevolence",ammo="Pemphredo Tathlum",
        head="Vitivation chapeau +1",neck="Incanter's torque",ear1="Gwati Earring",ear2="Loquacious Earring",       
		body="Merlinic Jubbah",hands="Jhakri Cuffs +1",ring1="Sangoma ring",ring2="Metamorph Ring +1",
        back="Ghostfyre Cape",waist="Eschan stone",legs=MerlinicShalwar,feet="Jhakri Pigaches +1",}

    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation chapeau +1"})

    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation chapeau +1"})
    
    sets.midcast['Elemental Magic'] = {ammo="Pemphredo Tathlum",
        head=MerlinicHood,neck="Sanctity necklace",ear1="Hecate's earring",ear2="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric Gages +1",ring1="Metamorph Ring +1",ring2="Acumen Ring",
		back="Toro Cape",waist="Eschan stone",legs=MerlinicShalwar,feet=MerlinicCrackows}
		
    sets.magic_burst = {
		head=MerlinicHoodMBD,			--9
		legs=MerlinicShalwarMBD,		--10
		feet=MerlinicCrackowsMBD,		--5
		neck="Mizukage-no-Kubikazari",	--10
		ring1="Mujin band", 
		ring2="Locus ring", 			--5		-->39
		}
        
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.midcast['Dark Magic'] = {main="Rubicundity", sub="Rubicundity",
        head="Pixie Hairpin +1",neck="Incanter's torque",ear1="Gwati Earring",ear2="Loquacious Earring",
        body="Merlinic Jubbah",hands="Amalric Gages +1",ring1="Sangoma ring",ring2="Archon Ring",
        back="Toro Cape",waist="Eschan stone",legs=MerlinicShalwarAspir,feet="Jhakri Pigaches +1"}

    --sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		legs=MerlinicShalwarAspir,feet=MerlinicCrackows,ring1="evanescence Ring",waist="Fucho-no-obi"})

    sets.midcast.Aspir = sets.midcast.Drain


    -- Sets for special buff conditions on spells.

    sets.midcast.Protect = {ear1="Brachyura earring"}
    sets.midcast.Shell = {ear1="Brachyura earring"}
        
    sets.buff.ComposureOther = {head="Lethargy Chappel",
        body="Lethargy Sayon",hands="Lethargy Gantherots",
        legs="Lethargy Fuseau",feet="Lethargy Houseaux"}

    sets.buff.Saboteur = {hands="Lethargy Gantherots"}
    

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
      

    -- Idle sets genbu's shield excalibur atoyac mandau claidheamh soluis
    sets.idle = {ammo="Homiliary",
        head="Vitivation chapeau +1",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Eabani Earring",
        body="Vrikodara Jupon",hands="Umuthi gloves",ring1="Defending Ring",ring2="Dark ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="carmine greaves"}

    sets.idle.Town = {ammo="Homiliary",
        head="Vitivation chapeau +1",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Eabani Earring",
        body="Vrikodara Jupon",hands="serpentes cuffs",ring1="Defending Ring",ring2="Shneddick ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="serpentes Sabots"}
    
    sets.idle.Weak = {ammo="Homiliary",
        head="Vitivation chapeau +1",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Eabani Earring",
        body="Vrikodara Jupon",hands="Umuthi gloves",ring1="Defending Ring",ring2="Shneddick ring",
        back="Engulfer cape +1",waist="Flume Belt +1",legs="hagondes pants +1",feet="medium's sabots"}

    sets.idle.PDT = {ammo="Homiliary",
        head="Vitivation chapeau +1",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Eabani Earring",
        body="Vrikodara Jupon",hands="Umuthi gloves",ring1="Defending Ring",ring2="Shneddick ring",
        back="Solemnity Cape",waist="Flume Belt +1",legs="hagondes pants +1",feet="carmine greaves"}
	
    sets.idle.MDT = set_combine(sets.idle.PDT,{
		sub="Beatific shield +1",
        back="Engulfer cape +1",
		waist="carrier's sash",
	})
    
    
    -- Defense sets
    sets.defense.PDT = {ammo="Homiliary",
        head="Hike Khat +1",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Eabani Earring",
        body="emet harness +1",hands="Umuthi gloves",ring1="Defending Ring",ring2="Shneddick Ring",
        back="Solemnity Cape",waist="Flume Belt +1",legs="hagondes pants +1",feet="Carmine greaves"}

    sets.defense.MDT = set_combine(sets.defense.PDT,{sub="Beatific shield",
		ear2="Eabani Earring"})

    sets.Kiting = {legs="Carmine Cuisses +1"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
     sets.Defensive = {ammo="Homiliary",
		head="Hike Khat +1", 	--4 pdt
        neck="Loricate torque +1",			--5 dt
		ear1="Hearty Earring",
        body="emet harness +1",			--5 pdt 
		hands="Umuthi gloves",	--4 pdt
		ring1="Defending Ring",			--10 pdt 10 mdt
		ring2="Dark ring",				--6 pdt	 3	
        back="Solemnity Cape",			--5 pdt (10 night)
		waist="Flume Belt +1",			--4 pdt
		legs="hagondes pants +1",		--4 pdt
		feet="gendewitha galoshes +1"	--3 pdt
     }									--50	 18	
	 sets.Defensive_Acc = {
		head="Vitivation chapeau +1",
		neck="Subtlety Spectacles",
		ear1="Heartseeker Earring",
		ear2="Dominance Earring +1",
        body="emet harness +1",
		hands="Umuthi gloves",
		ring1="Defending ring",
		ring2="Cacoethic Ring +1",
		back="Grounded mantle",
		waist="Kentarch Belt +1",
		legs="hagondes pants +1",
		feet="gendewitha galoshes +1"
     }
	 sets.Resistive = {
		ranged="Killer Shortbow",
		head="Vitivation chapeau +1",
        neck="Loricate torque +1",
		ear1="Hearty Earring",
		ear2="Eabani Earring",
        body="Vrikodara Jupon",
		hands="Umuthi gloves",
		ring2="Shneddick ring",
        back="Engulfer cape +1",
		waist="carrier's sash",
		legs="hagondes pants +1",
		feet="gendewitha galoshes +1"
     }
	 sets.Resistive_Acc = {
		neck="Loricate torque +1",
        back="Engulfer cape +1",
	 }
	 sets.Resistive_Dark = {
		ammo="Shadow Sachet",
		neck="Aesir torque",
		ear1="Hearty Earring",
		ear2="Darkness Earring",
		ring2="Fenrir ring",
		back="Solemnity Cape",
		waist="Carrier's sash",
	 }
    -- Normal melee group
    sets.engaged = {ammo="hasty pinion +1",
        head="taeon chapeau",neck="Defiant Collar",ear1="Dominance Earring +1",ear2="Brutal Earring",
        body="taeon tabard",hands="taeon gloves",ring1="Rajas Ring",ring2="petrov ring",
        back="Bleating mantle",waist="shetal stone",legs="taeon tights",feet="taeon boots"}
    sets.engaged.Acc = set_combine(sets.engaged,{ammo="hasty pinion +1",
        head="taeon chapeau",neck="Subtlety Spectacles",ear1="Dominance Earring +1",ear2="Brutal Earring",
        body="taeon tabard",hands="taeon gloves",ring1="Rajas Ring",ring2="Cacoethic Ring +1",
        back="Grounded mantle",waist="Kentarch Belt +1",legs="taeon tights",feet="taeon boots"})
	--NOT FINISHED - need to code DW capability still
	sets.engaged.DW = {ammo="hasty pinion +1",
        head="taeon chapeau",neck="Defiant Collar",ear1="Brutal Earring",ear2="suppanomimi",
        body="taeon tabard",hands="taeon gloves",ring1="Rajas Ring",ring2="petrov ring",
        back="Bleating mantle",waist="shetal stone",legs="taeon tights",feet="taeon boots"}
		
	sets.engaged.PDT = set_combine(sets.engaged, sets.Defensive)
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.Defensive_Acc)
	sets.engaged.MDT = set_combine(sets.engaged, sets.Resistive)
	sets.engaged.Acc.MDT = set_combine(sets.engaged.Acc, sets.Resistive_Acc)
	sets.engaged.Rdark = set_combine(sets.engaged, sets.Resistive_Dark)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Elemental Magic' and (state.Buff.Chainspell or state.Buff.Spontaneity) then
		equip(sets.midcast['Elemental Magic'].CastingMode)	
	elseif spell.skill == 'Enfeebling Magic' and (state.Buff.Chainspell or state.Buff.Spontaneity) then
		equip(sets.midcast['Enfeebling Magic'].CastingMode)
	elseif spell.skill == 'Enhancing Magic' and (state.Buff.Chainspell or state.Buff.Spontaneity) then
		equip(sets.midcast['Enhancing Magic'].CastingMode)
	elseif spell.english == 'Cure' and (state.Buff.Chainspell or state.Buff.Spontaneity) then
		equip(sets.midcast.Cure)
	end	
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)	
	equipSet={}
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
		if spell.en == 'Refresh III' or spell.en == 'Refresh II' or spell.en == 'Refresh' then
			equip(sets.midcast.Refresh)
		elseif spell.en == 'Aquaveil' then
			equip(sets.midcast.Aquaveil)
        else equip(sets.midcast.EnhancingDuration)
		end
        --if buffactive.composure and spell.target.type == 'PLAYER' then
        --    equip(sets.buff.ComposureOther)
        --end
	elseif spell.skill == 'Elemental Magic' then	
		if spell.element == world.day_element or spell.element == world.weather_element then
			if state.MagicBurst.value then
				equipSet = set_combine(equipSet, sets.magic_burst)
				equipSet = set_combine(equipSet, {waist="Hachirin-No-Obi"})
				equip(equipSet)
				add_to_chat(122, "Weather Magic Burst")
            else 
				equipSet = set_combine(equipSet, {waist="Hachirin-No-Obi"})
				equip(equipSet)
				add_to_chat(122, "Weather Nuke")
			end
		elseif state.MagicBurst.value then
				equipSet = set_combine(equipSet, sets.magic_burst)
				equip(equipSet)
				add_to_chat(122, "Magic Burst")	
        end
	elseif spell.skill == 'Healing Magic' then	
		if spell.target.type == 'SELF' then	
			if spell.element == world.day_element or spell.element == world.weather_element then
				equip(sets.midcast.CureSelf, {waist="Hachirin-No-Obi"})
				add_to_chat(122, "Weather Cure Self")
			else 
				equip(sets.midcast.CureSelf)
			end		
		elseif spell.element == world.day_element or spell.element == world.weather_element then
				equip(sets.midcast.Cure, {waist="Hachirin-No-Obi"})
				add_to_chat(122, "Weather Cure")
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
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
    end
end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 6)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 6)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 6)
    else
        set_macro_page(1, 6)
    end
end


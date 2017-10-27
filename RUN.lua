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
    state.Buff.Doom = buffactive.Doom or false
	
	
	gsList = S{'Humility'}
	sub_weapons = S{"Vampirism","Fettering Blade"}
	
	get_combat_form()    
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc50', 'Acc100', 'Acc150', 'Refresh')
    state.HybridMode:options('Normal', 'PDT', 'HP', 'Meva')
    state.WeaponskillMode:options('Normal', 'Acc50', 'Acc100', 'Acc150')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
		
	state.RuneMode = M('None','Lux','Tenebrae','Ignis','Gelus','Flabra','Tellus','Sulpor','Unda')
    state.MagicBurst = M(false, 'Magic Burst')
	
    -- Additional local binds
    send_command('bind !` gs c toggle MagicBurst')
	send_command('bind @` gs c cycle RuneMode')
	
    --update_combat_form()
    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind !`')
	send_command('unbind @`')
end


-- Set up gear sets.
function init_gear_sets()

    --------------------------------------
    -- aug gear
    --------------------------------------
	
	include('Flannelman_aug-gear.lua')
	
				
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	
	sets.precast.JA['Vallation'] = {body="Runeist coat +1",legs="Futhark trousers +1",back="Ogma's Cape"}	--relic for inspiration
	sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
	sets.precast.JA['Battuta'] = {head="Futhark bandeau"}
	sets.precast.JA['Gambit'] = {hands="Runeist mitons +1"}
	sets.precast.JA['Pflug'] = {head="Runeist bottes +1"}
	sets.precast.JA['Liement'] = {body="Futhark Coat +1"}

	sets.precast.Item = {}
	sets.precast.Item['Holy Water'] = {ring1="Purity Ring"} 

	sets.precast.JA['Lunge'] = {ammo="Seeth. Bomblet +1",
		head=HercHelmMAB, 
		body="Samnuha Coat", 
		hands="Carmine Fin. Ga. +1",
		legs=HercLegsMAB,
		feet="Adhemar Gamashes",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Hecate's Earring",
		right_ear="Friomisi Earring",
		left_ring="Weatherspoon Ring",
		right_ring="Acumen Ring",
		back="Evasionist's Cape",
	}
	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
	
	
    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Sapience Orb",--2
        head="Carmine Mask",			--12
		ear1="Etiolation Earring",		--1
		ear2="Loquacious Earring",		--2
		neck="Orunmila's torque",		--5
        body="Vrikodara Jupon",			--5
		hands="Leyline Gloves",			--8
		ring1="Kishar ring",			--4
		ring2="Weatherspoon Ring",		--5
		legs="Ayanmo Cosciales +1",		--5
		feet="Carmine Greaves"			--7 -->56
		}
        
	sets.precast['Enhancing Magic'] = {legs="Futhark Trousers +1"}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Knobkierrie",
        head=HercHelmTA,neck="Fotia gorget",ear1="Sherida earring",ear2="moonshade earring",
        body="Adhemar jacket",hands="Meghanada Gloves +2",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back="Ogma's cape",waist="Fotia belt",legs="Samnuha tights",feet=HercBootsDmg}
    	
	sets.precast.WS.Acc50 = set_combine(sets.precast.WS,{})
	sets.precast.WS.Acc100 = set_combine(sets.precast.WS,{})		
	sets.precast.WS.Acc150 = set_combine(sets.precast.WS,{})
		
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {ammo="Knobkierrie",
		head=HercHelmTA,
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Samnuha Tights", 
		feet=HercBootsTA,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back="Ogma's cape",
		})
	sets.precast.WS['Resolution'].Acc50 = set_combine(sets.precast.WS['Resolution'], {feet=HercBootsDmg})
	sets.precast.WS['Resolution'].Acc100 = set_combine(sets.precast.WS['Resolution'].Acc50, {head="Meghanada Visor +1"})
	sets.precast.WS['Resolution'].Acc150 = set_combine(sets.precast.WS['Resolution'].Acc100, {ammo="Seething Bomblet +1",legs=HercLegsAcc,ear2="Telos Earring"})
	
	sets.precast.WS['Dimidation'] = set_combine(sets.precast.WS['Resolution'], {})
	sets.precast.WS['Dimidation'].Acc50 = set_combine(sets.precast.WS['Resolution'].Acc50, {})
	sets.precast.WS['Dimidation'].Acc100 = set_combine(sets.precast.WS['Resolution'].Acc100, {})
	sets.precast.WS['Dimidation'].Acc150 = set_combine(sets.precast.WS['Resolution'].Acc150, {})
	
	
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {legs="Carmine Cuisses +1"})
	sets.precast.WS['Requiescat'].Acc50 = sets.precast.WS.Acc50 
	sets.precast.WS['Requiescat'].Acc100 = sets.precast.WS.Acc100 
	sets.precast.WS['Requiescat'].Acc150 = sets.precast.WS.Acc150 

    sets.precast.WS['Sanguine Blade'] = { ammo="Seeth. Bomblet +1",
		head="Pixie Hairpin +1",
		body="Carm. Scale Mail",
		hands="Carmine Fin. Ga. +1",
		legs=HercLegsMAB,
		feet=HercBootsRefresh,
        neck="Fotia gorget",
		ear1="Friomisi Earring",ear2="moonshade Earring",
        ring1="Acumen Ring",ring2="Archon Ring",
		back="Toro Cape",waist="Fotia belt"}
	sets.precast.WS['Red Lotus Blade'] = set_combine(sets.precast.WS['Sanguine Blade'], {head=HercHelmMAB})	
    sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS['Sanguine Blade'], {head=HercHelmMAB,ring2="Weatherspoon ring"})
	sets.precast.WS['Seraph Blade'] = sets.precast.WS['Flash Nova']
	
	sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS, {head="Adhemar Bonnet",body="Abnoba kaftan",feet="Thereoid Greaves",ring1="Apate ring"})
	sets.precast.WS['Vorpal Blade'].Acc50 = set_combine(sets.precast.WS, {head="Adhemar Bonnet",body="Abnoba kaftan",feet="Thereoid Greaves",ring1="Apate ring"})
	sets.precast.WS['Vorpal Blade'].Acc100 = set_combine(sets.precast.WS, {head="Adhemar Bonnet",body="Abnoba kaftan",feet=HercBootsDmg,ring1="Apate ring"})
	sets.precast.WS['Vorpal Blade'].Acc150 = set_combine(sets.precast.WS.Acc100, {ring1="Apate Ring",ring2="Epona's Ring"})
	
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS['Resolution'], {head=HercHelmWSD,feet=HercBootsWSD})
	sets.precast.WS['Savage Blade'].Acc50 = set_combine(sets.precast.WS['Resolution'].Acc50, {})
	sets.precast.WS['Savage Blade'].Acc100 = set_combine(sets.precast.WS['Resolution'].Acc100, {})
	sets.precast.WS['Savage Blade'].Acc150 = set_combine(sets.precast.WS['Resolution'].Acc150, {})
    
    -- Midcast Sets
    sets.midcast.FastRecast = {}
        
    
	sets.midcast.Cure = set_combine(sets.midcast.FastRecast,{
		head="carmine mask",neck="Phalaina locket",ear1="Mendicant's earring",ear2="Loquacious earring",--4 5
        body="Vrikodara Jupon",ring1="ephedra ring",ring2="sirona's ring",--13					
        back="Solemnity cape",})--6 = 38
		
    sets.midcast.self_healing = set_combine(sets.midcast.Cure,{
		neck="Phalaina locket",		--4
		hands="Buremte Gloves",		--13
		ring1="Kunaji Ring",		--5
		waist="Gishdubar sash"})	--10		
	
	sets.midcast['Diaga']={head="White rarab cap +1",body=HercVestTH,hands=HercGlovesTH,waist="Chaac belt"}
	
	
	sets.midcast['Flash']={
		ammo="Sapience Orb",			--2
		head="Rabid Visor",				--6
		body="Emet Harness +1",			--10
		hands="Kurys Gloves",			--9
		legs="Erilaz Leg Guards +1",	--11
		feet="Erilaz Greaves +1",		--6
		neck="Unmoving Collar +1",		--10
		waist="Goading Belt",			--3
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Petrov Ring",		--4
		right_ring="Supershear Ring",	--5
		back="Evasionist's Cape",}		--5	-->69
	sets.midcast['Foil']=	sets.midcast['Flash']
	
	sets.midcast['Elemental Magic']= sets.precast.JA['Lunge'] 
	
	sets.midcast['Enhancing Magic'] = {head="Erilaz Galea",legs="Futhark Trousers +1"}

	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {head="Futhark Bandeau"})	
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],{waist="Gishdubar sash"})
	
    sets.midcast.Protect = {ear1="Brachyura earring"}
    sets.midcast.Protectra = {ear1="Brachyura earring"}
    sets.midcast.Shell = {ear1="Brachyura earring"}
    sets.midcast.Shellra = {ear1="Brachyura earring"}
    

    -- Resting sets
    sets.resting = {}
    
    -- Idle sets
    sets.idle = {ammo="Staunch Tathlum",
        head=HercHelmDT,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        body="Erilaz Surcoat +1",hands=HercGlovesDT,ring1="Defending Ring",ring2="Regal ring",
        back="Moonbeam Cape",waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="Erilaz Greaves +1"}--25DT 35PDT 30MDT

    sets.idle.PDT = {ammo="Staunch Tathlum",
        head=HercHelmDT,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        body="Erilaz Surcoat +1",hands=HercGlovesDT,ring1="Defending Ring",ring2="Regal ring",
        back="Moonbeam Cape",waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="Erilaz Greaves +1"}--37DT 53PDT 45MDT
	
	sets.idle.Refresh = set_combine(sets.idle, {
        head="rawhide mask",
        body="Runeist Coat +1",
		feet=HercBootsRefresh,
		neck="Sanctity Necklace",
		waist="fucho-no-obi",})

--    sets.idle.Town = {main="Buramenk'ah",ammo="Sapience Orb",
--        head="Mavi Kavuk +2",neck="Sanctity Necklace",ear1="Bloodgem Earring",ear2="Loquacious Earring",
--        body="Luhlaza Jubbah",hands="Assimilator's Bazubands +1",ring1="Defending Ring",ring2="Shneddick ring",
--        back="Lupine cape",waist="Flume Belt +1",feet="Luhlaza Charuqs"}


    
    -- Defense sets
    sets.defense.PDT = {
		ammo="Staunch Tathlum",			--2 2
        head=HercHelmDT,				--4 4   meva 	59
        body="Erilaz Surcoat +1",		--				80
		hands=HercGlovesDT,				--5 3			43
		legs="Erilaz Leg Guards +1",	--7				107
		feet="Erilaz Greaves +1",		--5				107
		neck="Loricate torque +1",		--6 6
		ear1="Etiolation Earring",		--	3
		ear2="Odnowa Earring +1",		--	2
		ring1="Defending Ring",			--10 10
		ring2="Regal ring",	
        back="Evasionist's Cape",		--7 4	
		waist="Flume Belt +1",			--4
		}								--50pdt 34mdt	389meva

    sets.defense.HP = set_combine(sets.defense.PDT, {back="Moonbeam Cape",})		

	sets.defense.Meva = set_combine(sets.defense.PDT,{
		hands="Leyline Gloves",			--					62
		left_ear="Eabani Earring",		--					8
		right_ear="Flashward Earring",--					8
		right_ring="Purity Ring",		--					10
		back="Fugacity Mantle +1",	--						12
	})									--					434
	
    sets.Kiting = {legs="Carmine Cuisses +1"}

    -- Engaged sets

    
    -- Normal melee group
    sets.engaged = {ammo="Ginsen",
		head=HercHelmTA,
		body="Adhemar Jacket",
		hands="Adhemar Wristbands", 
		legs="Samnuha Tights", 
		feet=HercBootsTA,
		neck="Anu Torque",
		waist="Ioskeha Belt",
		left_ear="Sherida Earring",
		right_ear="Cessance Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epona's Ring",
		back="Ogma's cape"}

    sets.engaged.Acc50 = set_combine(sets.engaged,{feet=HercBootsDmg})
    sets.engaged.Acc100 = set_combine(sets.engaged.Acc100,{head="Dampening Tam"})
    sets.engaged.Acc150 = set_combine(sets.engaged.Acc150,{ammo="Falcon Eye",neck="Combatant's Torque",ear2="Telos Earring",ring2="Ilabrat Ring"})
    sets.engaged.Refresh = set_combine(sets.engaged,{head="rawhide mask",body="Runeist Coat +1",feet=HercBootsRefresh})

    sets.engaged.DW = set_combine(sets.engaged,{ear1="Eabani Earring",ear2="Suppanomimi",waist="Shetal Stone",feet=HercBootsDW})
    sets.engaged.DW.Acc50 = set_combine(sets.engaged,{ear1="Eabani Earring",ear2="Suppanomimi",waist="Shetal Stone",feet=HercBootsDW})
    sets.engaged.DW.Acc100 = set_combine(sets.engaged.Acc100,{ear1="Eabani Earring",ear2="Suppanomimi",waist="Shetal Stone",feet=HercBootsDW})
    sets.engaged.DW.Acc150 = set_combine(sets.engaged.Acc150,{feet=HercBootsDW})
    sets.engaged.DW.Refresh = set_combine(sets.engaged,{head="rawhide mask",body="Runeist Coat +1",feet=HercBootsRefresh})


		
	sets.engaged.PDT = set_combine(sets.defense.PDT, {body="Ayanmo Corazza +1",legs="Ayanmo Cosciales +1",waist="Ioskeha Belt",ring2="Niqmaddu Ring"})		--51pdt 41mdt	
	sets.engaged.Acc50.PDT = set_combine(sets.engaged.PDT, {ear1="Dignitary's Earring",ear2="Telos Earring"})
	sets.engaged.Acc100.PDT = set_combine(sets.engaged.Acc50.PDT, {})
	sets.engaged.Acc150.PDT = set_combine(sets.engaged.Acc100.PDT, {})
	sets.engaged.Refresh.PDT = set_combine(sets.engaged.PDT, {body="Vrikodara Jupon",waist="Fucho-no-obi"})
	sets.engaged.DW.PDT = sets.defense.PDT
	sets.engaged.DW.Acc50.PDT = set_combine(sets.engaged.DW.PDT, {})
	sets.engaged.DW.Acc100.PDT = set_combine(sets.engaged.DW.PDT, {})
	sets.engaged.DW.Acc150.PDT = set_combine(sets.engaged.DW.PDT, {})
	sets.engaged.DW.Refresh.PDT = set_combine(sets.engaged.PDT, {body="Vrikodara Jupon",waist="Fucho-no-obi"})
	
	sets.engaged.HP = set_combine(sets.defense.HP, sets.engaged.PDT, {back="Moonbeam Cape",})
	sets.engaged.Acc50.HP = set_combine(sets.defense.HP, sets.engaged.PDT, {back="Moonbeam Cape",})
	sets.engaged.Refresh.HP = set_combine(sets.engaged.Refresh.PDT, {back="Moonbeam Cape",})
	sets.engaged.DW.HP = set_combine(sets.defense.HP, {back="Moonbeam Cape",})
	sets.engaged.DW.Refresh.HP = set_combine(sets.engaged.DW.Refresh.PDT, {back="Moonbeam Cape",})
	
	sets.engaged.Meva = sets.defense.Meva
--	sets.engaged.Acc50.Meva = set_combine(sets.defense.Meva, {body="Adhemar Jacket",back="Lupine cape"})
	sets.engaged.Refresh.Meva = sets.defense.Meva
	sets.engaged.DW.Meva = sets.defense.Meva
	sets.engaged.DW.Acc50.Meva = set_combine(sets.defense.Meva, {body="Adhemar Jacket",})
	sets.engaged.DW.Acc100.Meva = set_combine(sets.defense.Meva, {body="Adhemar Jacket",})
	sets.engaged.DW.Acc150.Meva = set_combine(sets.defense.Meva, {body="Adhemar Jacket",})
	sets.engaged.DW.Refresh.Meva = sets.defense.Meva
	
	sets.latent_refresh = {waist="Fucho-no-obi"}	
    sets.buff.Doom = {ring2="Purity Ring",waist="Gishdubar sash"}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type:endswith('Magic') and buffactive.silence then
        eventArgs.cancel = true
        send_command('input /item "Echo Drops" <st>')
		add_to_chat(122, "Silenced, Auto-Echos")
    end
end

	
function job_precast(spell, action, spellMap, eventArgs)

	if buffactive['Terror'] or buffactive['Stun'] or buffactive['Petrification'] or buffactive['Sleep']then
            eventArgs.cancel = true
			equip(sets.engaged.HP)
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
		if state.RuneMode.value == 'Lux' then
            send_command('input /jobability "Lux" <me>')
            add_to_chat(122, 'Lux -- Light')
            eventArgs.cancel = true
            return	
		elseif state.RuneMode.value == 'Tenebrae' then
            send_command('input /jobability "Tenebrae" <me>')
            add_to_chat(122, 'Tenebrae -- Dark')
            eventArgs.cancel = true
            return		
        elseif state.RuneMode.value == 'Ignis' then
            send_command('input /jobability "Ignis" <me>')
            add_to_chat(122, 'Ignis -- Fire (Ice)')
            eventArgs.cancel = true
            return	
		elseif state.RuneMode.value == 'Gelus' then
            send_command('input /jobability "Gelus" <me>')
            add_to_chat(122, 'Gelus -- Ice (Wind)')
            eventArgs.cancel = true
            return
		elseif state.RuneMode.value == 'Flabra' then
            send_command('input /jobability "Flabra" <me>')
            add_to_chat(122, 'Flabra -- Wind (Earth)')
            eventArgs.cancel = true
            return	
		elseif state.RuneMode.value == 'Tellus' then
            send_command('input /jobability "Tellus" <me>')
            add_to_chat(122, 'Tellus -- Earth (Thunder)')
            eventArgs.cancel = true
            return	
		elseif state.RuneMode.value == 'Sulpor' then
            send_command('input /jobability "Sulpor" <me>')
            add_to_chat(122, 'Sulpor -- Thunder (Water)')
            eventArgs.cancel = true
            return	
		elseif state.RuneMode.value == 'Unda' then
            add_to_chat(122, 'Unda -- Water (Fire)')
            return
        end
    end
end

	

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
	if spellMap == 'Healing' or spellMap == 'Cure' then	
		if spell.target.type == 'SELF' then	
			if 'Light' == world.day_element or 'Light' == world.weather_element then
				equip(sets.midcast.self_healing)
				add_to_chat(122, "Weather Cure Self")
			else 
				equip(sets.midcast.self_healing)
				add_to_chat(122, "Cure Self")
			end		
		elseif 'Light' == world.day_element or 'Light' == world.weather_element then
				equip(sets.midcast.Cure, {waist="Hachirin-No-Obi"})
				add_to_chat(122, "Weather Cure")
		else
			equip(sets.midcast.Cure)
			add_to_chat(122, "Cure")
		end	
    
	elseif spell.skill == 'Enhancing Magic' then	
		if spell.en == 'Refresh' then
			equip(sets.midcast.Refresh)
		elseif spell.en == 'Phalanx' then
			equip(sets.midcast.Phalanx)
		else equip(sets.midcast['Enhancing Magic'])
		end
    elseif spell.skill == 'Elemental Magic' then
		equip(sets.midcast['Elemental Magic'])
	end
	
end


function job_buff_change(buff, gain)

	if buffactive['Stun'] or buffactive['Petrification'] or buffactive['Terror'] or buffactive['Sleep'] then
		equip(sets.engaged.PDT)
		add_to_chat(122, "TP set to PDT")
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
-- function job_buff_change(buff, gain)
    -- if state.Buff[buff] ~= nil then
        -- state.Buff[buff] = gain
    -- end
-- end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.


-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)	
    if player.mpp < 51 then
		state.IdleMode:set("Refresh")
	else 
		state.IdleMode:reset()
    end
    return idleSet
end



-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.

function job_status_change(newStatus, oldStatus, eventArgs)
	if newStatus == "Engaged" then
		get_combat_form()
	end
end

function get_combat_form()

	if S{'NIN', 'DNC'}:contains(player.sub_job) and sub_weapons:contains(player.equipment.sub) then
		state.CombatForm:set("DW")
	else
		state.CombatForm:reset()
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------




-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
	if player.sub_job == 'NIN' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 4)
    else
        set_macro_page(1, 4)
    end
end



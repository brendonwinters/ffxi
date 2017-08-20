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
		
	state.Buff['Mana Wall'] = buffactive['Mana Wall'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'ManaWall')
    state.CastingMode:options('Normal', 'Macc', 'ConvertNuke')
    state.IdleMode:options('Normal', 'PDT')
    
    state.MagicBurst = M(false, 'Magic Burst')
    state.DeathMode = M(false, 'Death Mode')
--	state.MagicElement = M('None', 'Lightning', 'Ice', 'Fire', 'Wind', 'Water', 'Earth', 'Light', 'Dark')
    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

    
    -- Additional local binds
    send_command('bind ^` input /ma Stun <t>')
    send_command('bind !` gs c toggle MagicBurst')
--    send_command('bind @` gs c cycle MagicElement')
    send_command('bind @` gs c toggle DeathMode')
    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
	send_command('unbind @`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	
	include('Flannelman_aug-gear.lua')
	
    TaranusFCDeath={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}
    TaranusElemental={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {feet="Wicce Sabots +1"}

    sets.precast.JA.Manafont = {body="Sorcerer's Coat +2"}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {ammo="Sapience Orb",
        head=MerlinicHoodFC,			--14
		neck="Orunmila's torque",		--5	
		ear1="Etiolation Earring",		--1
		ear2="Loquacious Earring",		--2
        body="Merlinic Jubbah",			--6
		hands=MerlinicDastanasFC,			--6
		ring1="Lebeche ring",
		ring2="Weatherspoon Ring",		--5
		back=TaranusFCDeath,			--10
		waist="Witful Belt",			--3
		legs="Lengo Pants",				--5
		feet=MerlinicCrackowsFC}		--11			
		
	sets.precast.FC.Death = {ammo="Pemphredo Tathlum",
		head="Amalric Coif",
		body="Amalric Doublet",
		hands="Telchine Gloves",
		legs="Amalric Slops",
		feet=MerlinicCrackowsFC, 
		neck="Orunmila's Torque",
		waist="Shinjutsu-no-obi +1",
		left_ear="Mendi. Earring",
		right_ear="Loquac. Earring",
		left_ring="Mephitas's Ring +1",
		right_ring="Weather. Ring",
		back=TaranusFCDeath
	}
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {legs="Amalric Slops",ear1="Barkarole earring"})
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear1="Mendicant's earring"})
    sets.precast.FC.Curaga = sets.precast.FC.Cure

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Ginsen",
		head="Jhakri Coronal +1",body="Jhakri Robe +1",hands="Jhakri Cuffs +2",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1",
		neck="Fotia gorget",ear1="Zennaroi earring",ear2="Dominance Earring +1",
        ring1="Cacoethic Ring +1",ring2="Cacoethic ring",back="Kayapa Cape",waist="Fotia belt",}
    sets.precast.WS['Myrkr'] = {ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",body="Amalric Doublet",hands="Telchine Gloves",legs="Amalric Slops",feet="Amalric Nails",
		left_ear="Loquacious Earring",right_ear="moonshade Earring",left_ring="Metamor. Ring +1",right_ring="Sangoma Ring",
        neck="Fotia gorget",back=TaranusFCDeath,waist="Shinjutsu-no-obi +1",}
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Fotia gorget",ear1="Friomisi Earring",ear2="Moonshade Earring",
		body="Merlinic Jubbah",hands="Jhakri Cuffs +2",ring1="Acumen Ring",ring2="Archon Ring",
		back=TaranusElemental,waist="Fotia belt",legs=MerlinicShalwar,feet=MerlinicCrackows}
    sets.precast.WS['Cataclysm'] = sets.precast.WS['Vidohunir']
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {head="Hike Khat +1"}

	sets.midcast.Cure = set_combine(sets.midcast.FastRecast,{
		neck="Phalaina locket",ear1="Mendicant's earring",ear2="Lifestorm earring",--4 5
        body="Vrikodara Jupon",ring1="ephedra ring",ring2="sirona's ring",--13					
        back="Solemnity cape",legs="Gyve Trousers",feet="Medium's sabots"})--6+10+12 = 50

    sets.midcast.Curaga = sets.midcast.Cure	
    sets.midcast.CureSelf = set_combine(sets.midcast.cure, {head="Telchine Cap",neck="Phalaina locket",ring1="Kunaji Ring"})
	
	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast,{
        head="Telchine cap",neck="Incanter's torque",
        body="Telchine Chasuble",hands="Telchine Gloves",
		waist="Olympus Sash",legs="Telchine Braconi",feet="Telchine Pigaches"})
	

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],{head="Amalric Coif"})
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],{head="Amalric Coif"})	
    --sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast['Enfeebling Magic'] = {ammo="Pemphredo Tathlum",
		head="Amalric Coif", 
		body="Merlinic Jubbah",
		hands="Jhakri Cuffs +2",
		legs=MerlinicShalwar,
		feet="Jhakri Pigaches +1",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Barkarole Earring",
		right_ear="Gwati Earring",
		left_ring="Metamorph Ring +1",
		right_ring="Sangoma Ring",
        back=TaranusElemental,}
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Barkarole earring",ear2="Gwati Earring",
        body="Merlinic Jubbah",hands="Amalric gages",ring1="Sangoma ring",ring2="Archon Ring",
        back=TaranusElemental,waist="Eschan stone",legs=MerlinicShalwar,feet="Jhakri Pigaches +1"}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'],{--main="Rubicundity", 
		ear1="hirudinea earring",ear2="gwati earring",ring1="evanescence Ring",ring2="Archon Ring",
		waist="Fucho-no-obi",feet=MerlinicCrackows})
    
    sets.midcast.Aspir = sets.midcast.Drain
    sets.midcast.Stun = sets.midcast['Enfeebling Magic']
    sets.midcast.BardSong = sets.midcast['Enfeebling Magic']
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak",ring2="Archon Ring"})

    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {main="Lathi",sub="Niobid strap",ammo="Pemphredo Tathlum",
        head=MerlinicHood,neck="Sanctity necklace",ear1="Barkarole earring",ear2="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric gages",ring1="Metamorph Ring +1",ring2="Acumen Ring",
        back=TaranusElemental,waist="Eschan stone",legs=MerlinicShalwar,feet=MerlinicCrackows}

    sets.midcast['Elemental Magic'].Macc = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].ConvertNuke = set_combine(sets.midcast['Elemental Magic'], {body="Spaekona's coat +1"})
	sets.midcast['Comet'] = set_combine(sets.midcast['Elemental Magic'], {head="Pixie Hairpin +1",ring2="Archon Ring"})
	sets.midcast['Comet'].ConvertNuke = set_combine(sets.midcast['Elemental Magic'], {head="Pixie Hairpin +1",body="Spaekona's coat +1",ring2="Archon Ring"})
	sets.midcast['Elemental Magic'].ConvertNuke = set_combine(sets.midcast['Elemental Magic'], {body="Spaekona's coat +1"})
    sets.magic_burst = {
		head=MerlinicHoodMBD,			--9
		legs=MerlinicShalwarMBD,		--10
		feet=MerlinicCrackowsMBD,		--5
		neck="Mizukage-no-Kubikazari",	--10
		ring1="Mujin band", 	
		back=TaranusElemental,}			--5		--39
    
	sets.midcast['Death'] = {ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body="Amalric Doublet", 
		hands="Amalric Gages", 
		legs="Amalric Slops",
		feet="Amalric Nails",
		neck="Mizu. Kubikazari",
		waist="Hachirin-No-Obi",
		left_ear="Barkaro. Earring",
		right_ear="Loquac. Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Archon Ring",
		back=TaranusFCDeath,
	}
	sets.midcast.DeathAspir = set_combine(sets.midcast['Death'],{--main="Rubicundity",
		head="Pixie Hairpin +1", 
		feet=MerlinicCrackowsAspir,
		ring1="evanescence Ring",ring2="Archon Ring",
		waist="Fucho-no-obi"})


	-- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {main="Lathi",sub="Niobid strap",
		head="Hike Khat +1",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Eabani Earring",
        body="Vrikodara Jupon",hands="Hagondes cuffs +1",ring1="Defending Ring",ring2="Dark ring",
        back="Shadow Mantle",waist="Fucho-no-obi",legs="Lengo Pants",feet="herald's gaiters"}


    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {
		head="Hike Khat +1",				--3
        body="Vrikodara Jupon",			--4 3
		hands="Hagondes cuffs +1",			--3 3
		legs="Hagondes Pants +1",			--4
		feet="herald's gaiters",
		neck="Loricate torque +1",			--6 6
		ear1="Genmei Earring",				--2
		ear2="Eabani Earring",			
		ring1="Defending Ring",				--10 10
		ring2="Dark ring",					--6  3
        back="Solemnity Cape",				--4  4
		waist="Fucho-no-obi"}

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",ammo="Sapience Orb",
		head="Hike Khat +1",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Eabani Earring",
        body="Vrikodara Jupon",hands="Hagondes cuffs +1",ring1="Defending Ring",ring2="Dark ring",
        back="Shadow Mantle",waist="Fucho-no-obi",legs="Lengo Pants",feet="herald's gaiters"}
    
    -- Town gear.
    sets.idle.Town = {
		head="Hike Khat +1",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Eabani Earring",
        body="Vrikodara Jupon",hands="Hagondes cuffs +1",ring1="Defending Ring",ring2="Dark ring",
        back="Shadow Mantle",waist="Fucho-no-obi",legs="Lengo Pants",feet="herald's gaiters"}
    
	sets.idle.Death = {ammo="Pemphredo Tathlum",
		head="Amalric Coif",
		body="Amalric Doublet",
		hands="Telchine Gloves",
		legs="Amalric Slops",
		feet="Medium's Sabots", 
		neck="Orunmila's Torque",
		waist="Fucho-no-obi",
		left_ear="Mendi. Earring",
		right_ear="Loquac. Earring",
		left_ring="Mephitas's Ring +1",
		right_ring="Defending Ring",
		back=TaranusFCDeath
	}    
    -- Defense sets

    sets.defense.PDT = {main="Bolelabunga",
		sub="Genmei Shield",				--10
		head="Hike Khat +1",				--3
        body="Vrikodara Jupon",			--4 3
		hands="Hagondes cuffs +1",			--3 3
		legs="Hagondes Pants +1",			--4
		feet="herald's gaiters",
		neck="Loricate torque +1",			--6 6
		ear1="Genmei Earring",				--2
		ear2="Eabani Earring",			
		ring1="Defending Ring",				--10 10
		ring2="Dark ring",					--6  3
        back="Solemnity Cape",				--4  4
		waist="Fucho-no-obi",	
		}									--53 19

    sets.defense.MDT = {
		head="Hike Khat +1",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Eabani Earring",
        body="Vrikodara Jupon",hands="Hagondes cuffs +1",ring1="Defending Ring",ring2="Dark ring",
        back="Shadow Mantle",waist="Fucho-no-obi",legs="Lengo Pants",feet="herald's gaiters"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = set_combine(sets.defense.PDT,{ear2="Ethereal Earring",back=TaranusFCDeath,feet="Wicce Sabots +1"})


    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Hasty pinion +1",
		head="Hike Khat +1",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Dominance Earring +1",
        body="Onca suit",hands=empty,ring1="Rajas Ring",ring2="Petrov ring",
        back="Kayapa Cape",waist="eschan stone",legs=empty,feet=empty}
	sets.engaged.ManaWall = {main="Bolelabunga",sub="Genmei Shield",ammo="Hasty pinion +1",
		head="Hike Khat +1",neck="Loricate torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
        body="Vrikodara Jupon",hands="Hagondes cuffs +1",ring1="Defending Ring",ring2="Dark ring",
        back=TaranusFCDeath,waist="Fucho-no-obi",legs="Hagondes Pants +1",feet="Wicce Sabots +1"}	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)	
	if spell.english == 'Aspir III' then		
        local spell_recasts = windower.ffxi.get_spell_recasts()
        if spell_recasts[spell.id] ~= 0 then
            send_command('input /ma "Aspir II" <t>')
            add_to_chat(122, '***Aspir III Aborted: Timer on Cooldown -- Downgrading to Aspir II.***')
            eventArgs.cancel = true
            return
		end
	end	
	
	if spell.english == 'Aspir II' then
        local spell_recasts = windower.ffxi.get_spell_recasts()
        if spell_recasts[spell.id] ~= 0 then
            send_command('input /ma "Aspir" <t>')
            add_to_chat(122, '***Aspir II Aborted: Timer on Cooldown -- Downgrading to Aspir.***')
            eventArgs.cancel = true
            return
        end
    end
	if spell.skill == 'Elemental Magic' then
		if spell.levels[4] == 100 then
			local spell_recasts = windower.ffxi.get_spell_recasts()
			 if spell_recasts[spell.id] ~= 0 then
				local lessnuke = spell.element
				if spell.element == "Lightning" then
					lessnuke = "Thunder"
				elseif spell.element == "Ice" then
					lessnuke = "Blizzard"
				elseif spell.element == "Wind" then
					lessnuke = "Aero"
				elseif spell.element == "Earth" then
					lessnuke = "Stone"
				end 
				send_command('input /ma "'..lessnuke..' V" <t>')
				add_to_chat(122, '***'..spell.en..' Aborted: Timer on Cooldown -- Downgrading to '..lessnuke..' V.***')
				eventArgs.cancel = true
				return
			 end
		end 
    end
	
--[[	if spell.skill == 'Enhancing Magic' then
		if spell.en == 'Thunderstorm' and state.MagicElement.value ~= 'None' then
			local stormchange = state.MagicElement.value
			if stormchange == "Lightning" then
				return
			elseif stormchange == "Ice" then
				stormchange = "Hail"
			elseif stormchange == "Water" then
				stormchange = "Rain"
			elseif stormchange == "Earth" then
				stormchange = "Sand"
			elseif stormchange == "Light" then
				stormchange = "Aurora"
			elseif stormchange == "Dark" then
				stormchange = "Void"
			end 
			send_command('input /ma "'..stormchange..'storm" <me>')
			eventArgs.cancel = true
			return
		end
		return
	end ]]
end

function job_post_precast(spell, action, spellMap, eventArgs)	
	equipSet={}
	if spell.en:startswith('Aspir') and state.DeathMode.value then
		equipSet = set_combine(equipSet,sets.precast.FC.Death)
		equip(equipSet)
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

function job_post_midcast(spell, action, spellMap, eventArgs)
	equipSet={}
	if spell.skill == 'Elemental Magic' then	
--		if spell.element == "Earth" then
--			equipSet = set_combine(equipSet, {neck="Quanpur necklace"})
--			equip(equipSet)	
--		else		
--			equipSet = set_combine(equipSet, {neck="Sanctity necklace"})
--			equip(equipSet)
--		end
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
	end
	if spell.skill == 'Healing Magic' then	
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
	if spell.en:startswith('Aspir') and state.DeathMode.value then
		equipSet = set_combine(equipSet,sets.midcast.DeathAspir)
		equip(equipSet)
	end	
end


function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
	if state.Buff['Mana Wall'] then
		equip(sets.buff['Mana Wall'])
	end
    -- if not spell.interrupted then
        -- if spell.english == 'Mana Wall' then
            -- enable('feet')
            -- equip(sets.buff['Mana Wall'])
            -- disable('feet')
        -- elseif spell.skill == 'Elemental Magic' then
            -- state.MagicBurst:reset()
        -- end
    -- end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
--    if buff == "Mana Wall" and not gain then
--        enable('feet')
--        handle_equipping_gear(player.status)
--    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
--    if stateField == 'Offense Mode' then
--        if newValue == 'Normal' then
--            disable('main','sub','range')
--        else
--            enable('main','sub','range')
--        end
--    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        --[[ No real need to differentiate with current gear.
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
        --]]
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if state.DeathMode.value then
		idleSet = set_combine(idleSet, sets.idle.Death)
	end
	if buffactive['Mana Wall'] then
		idleSet = set_combine(idleSet, sets.buff['Mana Wall'])
	end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end
function customize_melee_set(meleeSet)
	if buffactive['Mana Wall'] then
		meleeSet = set_combine(meleeSet, sets.engaged.ManaWall)
	end
	return meleeSet
end
-- Function to display the current relevant user state when doing an update.
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
    set_macro_page(1, 15)
end


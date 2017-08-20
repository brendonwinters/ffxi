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
    indi_timer = ''
    indi_duration = 275
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    state.MagicBurst = M(false, 'Magic Burst')
 --   gear.default.weaponskill_waist = "Windbuffet Belt"

    select_default_macro_book()
	
	
	send_command('bind ^z input /targetbnpc') 
    send_command('bind !` gs c toggle MagicBurst')
end


function file_unload()	
	send_command('unbind ^z')
    send_command('unbind !`')
end
-- Define sets and vars used by this job file.
function init_gear_sets()

	include('Flannelman_aug-gear.lua')
    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic"}
    sets.precast.JA['Life cycle'] = {body="Geomancy Tunic"}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua sandals +1"}

    -- Fast cast sets for spells

    sets.precast.FC = {ammo="Impatiens",
        head=MerlinicHoodFC,		--14
        body="Merlinic Jubbah",		--6
		hands=MerlinicHandsFC,		--6
		legs="geomancy pants +1",	--11
		feet="Merlinic Crackows",	--5
		neck="Orunmila's torque",	--5
		ear2="Loquacious Earring",	--2
		ring1="Lebeche ring",		--2
		ring2="Weatherspoon Ring",	--5
		waist="Witful Belt",		--3	
		back="lifestream cape",}	--7		

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear1="Barkarole earring",hands="bagua mitaines"})
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear1="Mendicant's earring"})
	sets.precast.FC['Geomancy'] = set_combine(sets.precast.FC, {range="Dunna",ammo=empty})
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Ginsen",
		head="Jhakri Coronal +1",body="Jhakri Robe +1",hands="Jhakri Cuffs +1",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1",
		neck="Fotia gorget",ear1="Zennaroi earring",ear2="Dominance Earring +1",
        ring1="Cacoethic Ring +1",ring2="Cacoethic ring",back="Kayapa Cape",waist="Fotia belt",}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Flash Nova'] = {
        head=MerlinicHood,neck="Fotia gorget",ear1="Friomisi Earring",ear2="Moonshade Earring",
        body="Merlinic Jubbah",hands="Jhakri Cuffs +1",ring1="Acumen Ring",ring2="Weatherspoon Ring",
        back="Toro Cape",waist="Fotia belt",legs=MerlinicShalwar,feet=MerlinicCrackows}
	
	sets.precast.WS['Vidohunir'] = {ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Fotia gorget",ear1="Friomisi Earring",ear2="Moonshade Earring",
		body="Amalric Doublet",hands="Jhakri Cuffs +1",ring1="Acumen Ring",ring2="Archon Ring",
		back="Toro Cape",waist="Fotia belt",legs=MerlinicShalwar,feet=MerlinicCrackows}
		
    sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}

    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast = {
        head="merlinic hood",neck="Incanter's torque",ear2="Loquacious Earring",
        body="Vrikodara jupon",ring1="Prolix Ring",ring2="Weatherspoon ring",
        back="lifestream cape",waist="Witful Belt",legs="geomancy pants +1"}

    sets.midcast.Geomancy = set_combine(sets.midcast.FastRecast, {range="Dunna",
		head="Azimuth hood",neck="Incanter's torque",ear1="mendicant's earring",ear2="gwati earring",
		body="Azimuth coat",hands="Azimuth gloves",
		back="lifestream cape",waist="hachirin-no-obi",legs="Azimuth tights",feet="Azimuth gaiters"})
    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy,{main="solstice",legs="Bagua Pants",back="lifestream cape"})

	sets.midcast.Cure = set_combine(sets.midcast.FastRecast,{
		neck="Phalaina locket",ear1="Mendicant's earring",ear2="Lifestorm earring",--4 5
        body="Vrikodara Jupon",ring1="ephedra ring",ring2="sirona's ring",--13					
        back="Solemnity cape",waist="Latria sash",legs="Gyve Trousers",feet="medium's sabots"})--6+10+12 = 50
    
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {head="Telchine Cap",neck="Phalaina locket",ring1="Kunaji Ring",waist="Gishdubar Sash"})
	sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {ring1="ephedra ring",ring2="sirona's ring"})
    sets.midcast.Protect = {ear1="Brachyura earring"}
    sets.midcast.Shell = {ear1="Brachyura earring"}
	sets.midcast.Shellra = sets.midcast.Shell
	
	sets.midcast['Enhancing Magic'] = {
        head="Telchine cap",neck="Incanter's torque",
        body="Telchine Chasuble",hands="Telchine Gloves",
		waist="Olympus Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
	
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],{head="Amalric Coif"})
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],{head="Amalric Coif"})
	
	sets.midcast['Elemental Magic'] = {main="rubicundity",sub="culminus",ammo="Pemphredo Tathlum",
        head=MerlinicHood,neck="Sanctity necklace",ear1="Barkarole earring",ear2="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric gages",ring1="Metamorph Ring +1",ring2="Acumen Ring",
		back="Toro Cape",waist="Eschan stone",legs=MerlinicShalwar,feet=MerlinicCrackows}
		
		
    sets.magic_burst = {
		head=MerlinicHoodMBD,			--9
		legs=MerlinicShalwarMBD,		--10
		feet=MerlinicCrackowsMBD,		--8
		neck="Mizukage-no-Kubikazari",	--10
		ring1="Mujin band", 
		ring2="Locus ring", 			--5		-->42
		}
--	sets.midcast['Geomancy'] = set_combine(sets.midcast.FastRecast, {range="Dunna", ammo=empty,
--		head="Azimuth hood",body="bagua tunic",hands="geomancy mitaines +1",
--		back="lifestream cape",legs="bagua pants",feet="Azimuth gaiters"})
		
    sets.midcast['Dark Magic'] = {main="rubicundity",sub="culminus",
        head="Pixie Hairpin +1",neck="Incanter's torque",ear1="Gwati Earring",ear2="Loquacious Earring",
        body="Merlinic Jubbah",hands="Amalric gages",ring1="Sangoma ring",ring2="Archon Ring",
        back="Toro Cape",waist="Eschan stone",legs=MerlinicShalwarAspir,feet=MerlinicCrackowsAspir}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'],{
		legs=MerlinicShalwarAspir,feet=MerlinicCrackowsAspir,ring1="evanescence Ring",waist="Fucho-no-obi"})
	sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak",})
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {head="Nefer Khat +1",neck="Sanctity Necklace",
        body="Heka's Kalasiris",hands="Serpentes Cuffs",ear1="Brachyura earring",ring2="Paguroidea Ring",
        waist="Austerity Belt",legs="Nares Trews",feet="merlinic crackows"}


    -- Idle sets

    sets.idle = {main="bolelabunga",sub="genbu's shield",range="Dunna",
        head="Hike Khat +1",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Eabani Earring",
        body="hagondes coat +1",hands="bagua mitaines",ring1="Defending Ring",ring2="Dark ring",
        back="shadow mantle",waist="fucho-no-obi",legs="Lengo Pants",feet="herald's gaiters"}--geomancy sandals

    sets.idle.PDT = {main="bolelabunga",sub="genbu's shield",range="Dunna",
        head="Hike Khat +1",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Eabani Earring",
        body="hagondes coat +1",hands="hagondes cuffs +1",ring1="Defending Ring",ring2="Dark ring",
        back="Solemnity Cape",waist="fucho-no-obi",legs="Lengo Pants",feet="herald's gaiters"}

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {main="solstice",sub="genbu's shield",range="Dunna",
        head="Azimuth hood",neck="Loricate torque +1",ear1="Handler's Earring +1",ear2="Handler's Earring",
        body="Gyve doublet",hands="geomancy mitaines +1",
		ring1="Defending Ring",ring2="Dark ring",
        back="lifestream cape",waist="isa belt",
		feet="Bagua sandals +1"
		--body="Onca suit",hands=empty,legs=empty,feet=empty
		}

    sets.idle.PDT.Pet = {main="solstice",sub="genbu's shield",range="Dunna",
        head="Azimuth hood",neck="Loricate torque +1",ear1="Handler's Earring +1",ear2="Handler's Earring",
        body="hagondes coat +1",hands="geomancy mitaines +1",ring1="Defending Ring",ring2="Dark ring",
        back="lifestream cape",waist="fucho-no-obi",legs="telchine braconi",feet="Bagua sandals +1"}


    sets.idle.Town = {range="Dunna",
        head="Hike Khat +1",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Eabani Earring",
        body="Amalric Doublet",hands="bagua mitaines",ring1="Defending Ring",ring2="Dark ring",
        back="shadow mantle",waist="fucho-no-obi",legs="Lengo Pants",feet="herald's gaiters"}

--    sets.idle.Weak = {range="Dunna",
--        head="Hike Khat +1",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Eabani Earring",
 --       body="Amalric Doublet",hands="hagondes cuffs +1",ring1="Defending Ring",ring2="Shneddick ring",
 --       back="shadow mantle",waist="fucho-no-obi",legs="Assiduity pants +1",feet="geomancy sandals"}

    -- Defense sets

    sets.defense.PDT = {range="Dunna",
        head="Hike Khat +1",neck="Loricate torque +1",ear1="Hearty Earring",ear2="colossus's Earring",
        body="hagondes coat +1",hands="hagondes cuffs +1",ring1="Defending Ring",ring2="Dark ring",
        back="shadow mantle",waist="fucho-no-obi",legs="hagondes pants +1",feet="medium's sabots"}

    sets.defense.MDT = {range="Dunna",
        head="Hike Khat +1",neck="Loricate torque +1",ear1="Hearty Earring",ear2="colossus's Earring",
        body="hagondes coat +1",hands="hagondes cuffs +1",ring1="Defending Ring",ring2="Dark ring",
        back="shadow mantle",waist="fucho-no-obi",legs="gyve trousers",feet="medium's sabots"}

    sets.Kiting = {feet="herald's gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {range="Dunna",
        head="Hike Khat +1",neck="Lissome necklage",ear1="Brutal Earring",ear2="Hearty Earring",
        body="Amalric Doublet",hands="Amalric gages",ring1="Defending Ring",ring2="Cacoethic Ring +1",
        back="Solemnity Cape",waist="windbuffet belt",legs="Lengo Pants",feet="medium's sabots"}

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

end

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
			send_command('input /ma "'..lessnuke..' VI" <t>')
			add_to_chat(122, '***'..spell.en..' Aborted: Timer on Cooldown -- Downgrading to '..lessnuke..' VI.***')
			eventArgs.cancel = true
			return
         end
    end
end
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	equipSet={}
    if spell.skill == 'Elemental Magic' then
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
	if spell.skill == 'Enhancing Magic' then
		equip(sets.midcast['Enhancing Magic'])
	end
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
-- function job_buff_change(buff, gain)
    -- if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        -- classes.CustomIdleGroups:append('Indi')
        -- handle_equipping_gear(player.status)
    -- elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        -- classes.CustomIdleGroups:clear()
        -- handle_equipping_gear(player.status)
    -- end
-- end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
-- function job_update(cmdParams, eventArgs)
    -- classes.CustomIdleGroups:clear()
    -- if player.indi then
        -- classes.CustomIdleGroups:append('Indi')
    -- end
-- end

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
    set_macro_page(1, 18)
end


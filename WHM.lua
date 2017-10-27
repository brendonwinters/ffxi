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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
		head="Vanya Hood",			--10
		body="Inyanga Jubbah +1",	--13
		hands="Gende. Gages +1",	--7
		legs="Ayanmo Cosciales +1",	--5
		feet="Chelona Boots",		--4
		waist="Witful Belt",		--3
		back="Alaunus's Cape",		--10
		ear2="Etiolation Earring",	--1
		ring2="Kishar Ring",		--4
	}								--57
        
--    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
--    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {head="Umuthi Hat"})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pantaloons",feet="Vanya Clogs"})--12+14=26+57-8=75
    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {ear1="Mendicant's Earring",ear2="Nourishing Earring"})--7+75=82

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    gear.default.weaponskill_neck = "ziel charm"
    gear.default.weaponskill_waist = ""
    sets.precast.WS = {}
    
    sets.precast.WS['Flash Nova'] = {}
    

    -- Midcast Sets
    
    sets.midcast.FastRecast = {}
    
    -- Cure sets

    sets.midcast.Cure = {ammo="Plumose Sachet",
		head="Vanya Hood",
		body="Theophany Briault +2",
		hands="Theophany Mitts +2",
		legs="Ebers Pantaloons",
		feet="Vanya Clogs", 
		neck="Nodens Gorget",
		waist="Witful Belt",
		left_ear="Mendi. Earring",
		right_ear="Nourish. Earring",
		left_ring="Mephitas's Ring +1",
		right_ring="Kishar Ring",
		back="Alaunus's Cape",}

    sets.midcast.CureSolace = set_combine(sets.midcast.Cure,{})
    sets.midcast.Curaga = set_combine(sets.midcast.Cure,{})
    sets.midcast.CureMelee = set_combine(sets.midcast.Cure,{})

    sets.midcast.Cursna = {hands="Inyanga Dastanas +2",back="Alaunus's Cape",legs="Ebers Pantaloons",feet="Vanya Clogs"}

    sets.midcast.StatusRemoval = {legs="Ebers Pantaloons"}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {hands="Inyanga Dastanas +2"}

    sets.midcast.Stoneskin = {}

    sets.midcast.Auspice = {}

    sets.midcast.BarElement = {legs="Piety Pantaloons"}

    sets.midcast.Regen = {
		head="Inyanga Tiara +2",
        body="Telchine Chasuble",--hands="Orison Mitts +2",
        legs="Theophany Pantaloons +1"}

    sets.midcast.Protectra = {}--ring1="Sheltered Ring",feet="Piety Duckbills +1"}

    sets.midcast.Shellra = {}--ring1="Sheltered Ring",legs="Piety Pantaloons"}


    sets.midcast['Divine Magic'] = {
		ammo="Hydrocera",
		head="Inyanga Tiara +2",
		body="Inyanga Jubbah +1",
		hands="Inyanga Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Inyanga Crackows +2",
		neck="Sanctity Necklace",
		waist="Salire Belt",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Acumen Ring",
		right_ring="Kishar Ring",}

    sets.midcast['Dark Magic'] = {
		ammo="Hydrocera",
		head="Inyanga Tiara +2",
		body="Inyanga Jubbah +1",
		hands="Inyanga Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Inyanga Crackows +2",
		neck="Sanctity Necklace",
		waist="Salire Belt",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Acumen Ring",
		right_ring="Kishar Ring",}
		
	sets.midcast['Elemental Magic'] = {
		ammo="Hydrocera",
		head="Inyanga Tiara +2",
		body="Inyanga Jubbah +1",
		hands="Inyanga Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Inyanga Crackows +2",
		neck="Sanctity Necklace",
		waist="Salire Belt",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Acumen Ring",
		right_ring="Kishar Ring",}

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
		ammo="Hydrocera",
		head="Inyanga Tiara +2",
		body="Inyanga Jubbah +1",
		hands="Inyanga Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Inyanga Crackows +2",
		neck="Sanctity Necklace",
		waist="Salire Belt",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Acumen Ring",
		right_ring="Kishar Ring",}

    sets.midcast.IntEnfeebles = sets.midcast.MndEnfeebles 

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
		head="Inyanga Tiara +2",
		body="Vanya Robe",
		hands="Inyanga Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Inyanga Crackows +2",
		neck="Twilight Torque",
		left_ear="Mendi. Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Shneddick Ring",
		waist="Gishdubar Sash",
		back="Moonbeam Cape",
	}

    sets.idle.PDT = {
		head="Inyanga Tiara +2",
		body="Vanya Robe",
		hands="Inyanga Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Inyanga Crackows +2",
		neck="Twilight Torque",
		left_ear="Mendi. Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Shneddick Ring",
		back="Moonbeam Cape",
	}

    sets.idle.Town = sets.idle
    
    sets.idle.Weak = sets.idle
    
    -- Defense sets

    sets.defense.PDT = {
		head="Inyanga Tiara +2",
		body="Vanya Robe",
		hands="Inyanga Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Inyanga Crackows +2",
		neck="Twilight Torque",
		left_ear="Mendi. Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Shneddick Ring",
		back="Moonbeam Cape",
	}

    sets.defense.MDT = {
		head="Inyanga Tiara +2",
		body="Vanya Robe",
		hands="Inyanga Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Inyanga Crackows +2",
		neck="Twilight Torque",
		left_ear="Mendi. Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Shneddick Ring",
		back="Moonbeam Cape",}

    sets.Kiting = {ring2="Shneddick ring"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
		head="Aya. Zucchetto +1",
		body="Ayanmo Corazza +1",
		hands="Aya. Manopolas +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
		neck="Clotharius Torque",
		waist="Windbuffet Belt",
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back="Moonbeam Cape",}


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {}--hands="Orison Mitts +2",back="Mending Cape"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
    
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
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

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
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
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 13)
end


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
        Custom commands:

        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.

                                        Light Arts              Dark Arts

        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
--]]



-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
    update_active_strategems()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')--^f11
    state.IdleMode:options('Normal', 'PDT')

    state.MagicBurst = M(false, 'Magic Burst')
    state.KlimaToggle = M(false, 'Klimaform')

	state.MagicElement = M('None', 'Dark', 'Lightning', 'Ice', 'Fire', 'Wind', 'Water', 'Earth', 'Light')
    info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder",
						"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II"}
    info.high_nukes = S{"Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
						"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
					   "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}
	helix_map = S{"Ionohelix","Cryohelix","Pyrohelix","Anemohelix","Hydrohelix","Geohelix","Noctohelix","Luminohelix",
	"Ionohelix II","Cryohelix II","Pyrohelix II","Anemohelix II","Hydrohelix II","Geohelix II","Noctohelix II","Luminohelix II"}

    --send_command('bind ^` input /ma Stun <t>')
	send_command('bind ^` gs c toggle KlimaToggle')
    send_command('bind !` gs c toggle MagicBurst')
    send_command('bind @` gs c cycle MagicElement')

    select_default_macro_book()
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
	send_command('unbind @`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	
	MerlinicHood={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic Damage +5','Mag. Acc.+4','"Mag.Atk.Bns."+13',}}
    MerlinicHoodMBD={ name="Merlinic Hood", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Magic burst dmg.+9%','CHR+10','Mag. Acc.+2','"Mag.Atk.Bns."+14',}}
    MerlinicHoodFC={ name="Merlinic Hood", augments={'"Fast Cast"+6','MND+2','Mag. Acc.+2',}}
	 
    MerlinicHandsFC={ name="Merlinic Dastanas", augments={'Mag. Acc.+16','"Fast Cast"+6','"Mag.Atk.Bns."+4',}}
    ChironicGlovesMAB={ name="Chironic Gloves", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','MND+9','"Mag.Atk.Bns."+15',}}
	
    MerlinicShalwar={ name="Merlinic Shalwar", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Mag. crit. hit dmg. +3%','Mag. Acc.+11','"Mag.Atk.Bns."+13',}}
    MerlinicShalwarMBD={ name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+28','Magic burst dmg.+10%','CHR+9','Mag. Acc.+7',}}
    MerlinicShalwarTH={ name="Merlinic Shalwar", augments={'INT+9','Phys. dmg. taken -3%','"Treasure Hunter"+1','Mag. Acc.+7 "Mag.Atk.Bns."+7',}}
    ChironicHose={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','MND+10','Mag. Acc.+9',}}
	
    MerlinicCrackows={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic Damage +7','INT+7','"Mag.Atk.Bns."+14',}}
    MerlinicCrackowsMBD={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+5%','"Mag.Atk.Bns."+2',}}
    MerlinicCrackowsFC={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+30','"Fast Cast"+6','MND+3','Mag. Acc.+4',}}
    ChironicSlippers={ name="Chironic Slippers", augments={'Mag. Acc.+21','Phys. dmg. taken -3%','MND+11','Attack+1',}}
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
--    sets.buff['Ebullience'] = {head="Arbatel bonnet"}
    sets.buff['Rapture'] = {head="Arbatel bonnet"}
    sets.buff['Perpetuance'] = {hands="Arbatel bracers +1"}
    sets.buff['Immanence'] = {hands="Arbatel bracers +1"}
    sets.buff['Penury'] = {legs="Savant's Pants +2"}
    sets.buff['Parsimony'] = {legs="Savant's Pants +2"}--forces conserve mp
    sets.buff['Celerity'] = {feet="Pedagogy Loafers"}
    sets.buff['Alacrity'] = {feet="Pedagogy Loafers"}
    sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}

    -- Precast Sets

    sets.precast.JA['Tabula Rasa'] = {legs="Argute Pants +2"}

	sets.precast.Item = {}
	sets.precast.Item['Holy Water'] = {ring1="Purity Ring"} 
	
    -- Fast cast sets for spells

    sets.precast.FC = {ammo="Sapience Orb",--2
        head=MerlinicHoodFC,			--14
        body="Shango Robe",				--8
		hands=MerlinicHandsFC,			--6
		legs="Lengo Pants",				--5
		feet="Academic's Loafers +2",
		neck="Orunmila's torque",		--5	
		ear1="Etiolation Earring",		--1
		ear2="Loquacious Earring",		--2
		ring1="Kishar ring",			--4
		ring2="Weatherspoon Ring",		--5
		back="Swith Cape",				--3
 --       back="Lugh's Cape",				
		waist="Witful Belt",			--3
		}								--58

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {legs="Amalric Slops",ear1="Barkarole earring"})
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear1="Mendicant's earring"})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})	
	
		-- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Ginsen",
		head="Jhakri Coronal +1",body="Jhakri Robe +1",hands="Jhakri Cuffs +2",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1",
		neck="Fotia gorget",ear1="Zennaroi earring",ear2="Dominance Earring +1",
        ring1="Cacoethic Ring +1",ring2="Cacoethic ring",back="Kayapa Cape",waist="Fotia belt",}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
        body="Amalric Doublet",
		hands="Telchine Gloves", 
		legs="Amalric Slops",
		feet="medium's sabots",
		left_ear="Loquacious Earring",right_ear="moonshade Earring",
		left_ring="Metamorph Ring +1",right_ring="Sangoma Ring",
        neck="Fotia gorget",
        waist="Shinjutsu-no-obi +1",}
	
	sets.precast.WS['Omnicience'] = {ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Fotia gorget",ear1="Friomisi Earring",ear2="Moonshade Earring",
		body="Amalric Doublet",hands="Jhakri Cuffs +2",ring1="Acumen Ring",ring2="Archon Ring",
		back="Lugh's Cape",waist="Fotia belt",legs=MerlinicShalwar,feet=MerlinicCrackows}
	sets.precast.WS['Cataclysm'] = 	sets.precast.WS['Omnicience']
		
    -- Midcast Sets

    sets.midcast.FastRecast = {head="Hike Khat +1"}

	sets.midcast.Cure = set_combine(sets.midcast.FastRecast,{
		neck="Phalaina locket",ear1="Mendicant's earring",--4 5
        body="Vrikodara Jupon",ring1="ephedra ring",ring2="sirona's ring",--13					
        back="Solemnity cape",legs="Gyve Trousers",feet="medium's sabots"})--6+10+12 = 50

    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {head="Telchine Cap",neck="Phalaina locket",ring1="Kunaji Ring",waist="Gishdubar Sash"})
    sets.midcast.Cursna = {neck="Incanter's torque",back="Solemnity cape",ring1="Ephedra Ring",ring2="sirona's ring",waist="Gishdubar Sash"}

    sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast,{ammo="Savant's Treatise",
        head="Telchine cap",neck="Incanter's torque",
        body="Telchine Chasuble",hands="Telchine Gloves",
		waist="Olympus Sash",legs="Telchine Braconi",feet="Telchine Pigaches"})

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],{main="Bolelabunga",head="Arbatel bonnet",back="Bookworm's Cape"})
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],{head="Amalric Coif",waist="Gishdubar Sash"})
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],{head="Amalric Coif"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Haste = sets.midcast['Enhancing Magic']
    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {feet="Pedagogy Loafers"})

    sets.midcast.Protect = {ear1="Brachyura earring"}
    sets.midcast.Shell = {ear1="Brachyura earring"}


    -- Custom spell classes
    sets.midcast['Enfeebling Magic'] = {ammo="Pemphredo Tathlum",
		head="Academic's Mortarboard +2", 
		body="Merlinic Jubbah",
		hands=ChironicGlovesMAB,
		legs=ChironicHose,
		feet="Academic's Loafers +2",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Barkarole Earring",
		right_ear="Dignitary's Earring",
		left_ring="Metamorph Ring +1",
		right_ring="Sangoma Ring",
        back="Lugh's Cape"}


    sets.midcast['Dark Magic'] = {main="Rubicundity", sub="Rubicundity",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Barkarole Earring",ear2="Dignitary's Earring",
        body="Merlinic Jubbah",hands=ChironicGlovesMAB,ring1="Evanescence ring",ring2="Archon Ring",
        back="Lugh's Cape",waist="Eschan stone",legs=MerlinicShalwar,feet="Academic's Loafers +2"}

    sets.midcast.Kaustra = set_combine(sets.midcast['Dark Magic'],{ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Mizukage-no-Kubikazari",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Mujin Band",ring2="Archon Ring",
		back="Lugh's Cape",legs=MerlinicShalwarMBD,feet=MerlinicCrackows})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'],{
		--ear1="hirudinea earring",
		waist="Fucho-no-obi"})

    sets.midcast.Aspir = sets.midcast.Drain
    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'],{ammo="Pemphredo Tathlum",
		head="Academic's Mortarboard +2",
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Drain" and "Aspir" potency +5','MND+10','"Mag.Atk.Bns."+12',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','MND+9','"Mag.Atk.Bns."+15',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','MND+10','Mag. Acc.+9',}},
		feet="Acad. Loafers +2",
		neck="Erra Pendant",
		waist="Eschan Stone",
		left_ear="Digni. Earring",
		right_ear="Barkaro. Earring",
		left_ring="Evanescence Ring",
		right_ring="Weather. Ring",
		back="Lugh's Cape"})


    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {ammo="Pemphredo Tathlum",
        head=MerlinicHood,neck="Sanctity necklace",ear1="Barkarole earring",ear2="Friomisi Earring",
        body="Merlinic Jubbah",hands=ChironicGlovesMAB,ring1="Metamorph Ring +1",ring2="Acumen Ring",
        back="Lugh's Cape",waist="Eschan stone",legs=MerlinicShalwar,feet=MerlinicCrackows}

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],{})		
	sets.midcast.Helix = set_combine(sets.midcast['Elemental Magic'], {back="Lugh's Cape"})
	sets.midcast.Noctohelix = set_combine(sets.midcast['Elemental Magic'], {head="Pixie Hairpin +1",ring2="Archon Ring",back="Lugh's Cape"})
	sets.midcast['Noctohelix II']=sets.midcast.Noctohelix
	sets.midcast.Luminohelix = set_combine(sets.midcast['Elemental Magic'], {ring2="Weatherspoon Ring",back="Lugh's Cape"})
	sets.midcast['Luminohelix II']=sets.midcast.Luminohelix
	
    -- Custom refinements for certain nuke tiers
--    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
--    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
    sets.magic_burst = {head=MerlinicHoodMBD,hands="Amalric Gages",neck="Mizukage-no-Kubikazari",ring1="Mujin band",legs=MerlinicShalwarMBD} -- 10 9 10 10
--	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})
	
	
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak",ring2="Archon Ring"})


    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle.Town = {ammo="homiliary",
		head="Merlinic Hood",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Eabani Earring",
        body="Vrikodara Jupon",hands="Hagondes cuffs +1",ring1="defending Ring",ring2="Dark ring",
        back="Moonbeam Cape",waist="Fucho-no-obi",legs="Lengo Pants",feet="herald's gaiters"}

    sets.idle.Field = {ammo="staunch tathlum",
		head="Merlinic Hood",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Eabani Earring",
        body="Vrikodara Jupon",hands="Hagondes cuffs +1",ring1="defending Ring",ring2="Dark ring",
        back="Moonbeam Cape",waist="Fucho-no-obi",legs="Lengo Pants",feet="herald's gaiters"}

    sets.idle.Field.PDT = {ammo="homiliary",
		head="Merlinic Hood",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Eabani Earring",
        body="Vrikodara Jupon",hands="Hagondes cuffs +1",ring1="defending Ring",ring2="Dark ring",
        back="Moonbeam Cape",waist="Fucho-no-obi",legs="Lengo Pants",feet=ChironicSlippers}


    sets.idle.Weak = {ammo="homiliary",
		head="Merlinic Hood",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Eabani Earring",
        body="Vrikodara Jupon",hands="Hagondes cuffs +1",ring1="Defending Ring",ring2="Meridian ring",
        back="Moonbeam Cape",waist="Fucho-no-obi",legs="Lengo Pants",feet=ChironicSlippers}

    -- Defense sets

    sets.defense.PDT = {ammo="homiliary",
		head="Merlinic Hood",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Eabani Earring",
        body="Vrikodara Jupon",hands="Hagondes cuffs +1",ring1="defending Ring",ring2="Dark ring",
        back="Moonbeam Cape",waist="Fucho-no-obi",legs="Lengo Pants",feet=ChironicSlippers}

    sets.defense.MDT = {ammo="homiliary",
		head="Merlinic Hood",neck="Loricate torque +1",ear1="Hearty Earring",ear2="Eabani Earring",
        body="Vrikodara Jupon",hands="Hagondes cuffs +1",ring1="defending Ring",ring2="Dark ring",
        back="Moonbeam Cape",waist="Fucho-no-obi",legs="Lengo Pants",feet=ChironicSlippers}

    sets.Kiting = {feet="herald's gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

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


    --sets.buff['Sandstorm'] = {feet="Desert Boots"}
	sets.buff.FullSublimation = {head="Academic's Mortarboard +2",neck="Sanctity Necklace",ear1="Savant's Earring",back="Moonbeam Cape",}--body="Pedagogy Gown +1"}
	sets.buff.PDTSublimation = {ear1="Savant's Earring",head="Academic's Mortarboard +2",back="Moonbeam Cape",}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type:endswith('Magic') and buffactive.silence then
        eventArgs.cancel = true
        send_command('input /item "Echo Drops" <st>')
		add_to_chat(122, "Silenced, Auto-Echos")
    end
end

function job_precast(spell, action, spellMap, eventArgs)	
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
	if spell.skill == 'Enhancing Magic' then
		if spell.en == 'Thunderstorm II' and state.MagicElement.value ~= 'None' then
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
			send_command('input /ma "'..stormchange..'storm II" <st>')
			eventArgs.cancel = true
			return
		end
		return
	end
end
-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
	equipSet={}
	if spell.skill == 'Elemental Magic' then
		equipSet = sets.midcast['Elemental Magic'].CastingMode
		if helix_map:contains(spell.english) then	
			if state.MagicBurst.value then
				equipSet = set_combine(equipSet, sets.magic_burst)
				equip(equipSet)
				add_to_chat(122, "Helix MB")
			end	
			if spell.element == world.weather_element and state.KlimaToggle and state.Buff['Klimaform'] then
				equipSet = set_combine(equipSet, sets.buff['Klimaform'])
				equip(equipSet)
			end
			return	
		elseif spell.element == world.day_element or spell.element == world.weather_element then
			if state.MagicBurst.value then
				equipSet = set_combine(sets.midcast['Elemental Magic'].CastingMode, sets.magic_burst)
				equipSet = set_combine(equipSet, {waist="Hachirin-No-Obi"})
				equip(equipSet)
				add_to_chat(122, "Weather Magic Burst")
            else 
				equipSet = set_combine(sets.midcast['Elemental Magic'].CastingMode, {waist="Hachirin-No-Obi"})
				equip(equipSet)
				add_to_chat(122, "Weather Nuke")
			end
		elseif state.MagicBurst.value then
				equipSet = set_combine(sets.midcast['Elemental Magic'].CastingMode, sets.magic_burst)
				equip(equipSet)
				add_to_chat(122, "Magic Burst")	
        end
		if spell.element == world.weather_element and state.KlimaToggle and state.Buff['Klimaform'] then
				equipSet = set_combine(equipSet, sets.buff['Klimaform'])
				equip(equipSet)
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
--	if spell.skill == 'Enhancing Magic' then
--		equip(sets.midcast['Enhancing Magic'])
--	end	
	if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
-- helix timers
	if (not spell.interrupted) then
		if helix_map:contains(spell.english) then	
--			createTimerHelix(spell.english)
		end 
	end
end	
	
	
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
end

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
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if world.weather_element == 'Light' then
                return 'CureWithLightWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Elemental Magic' then
            if info.low_nukes:contains(spell.english) or helix_map:contains(spell.english) then
                return 'LowTierNuke'
 --           elseif info.mid_nukes:contains(spell.english) then
 --               return 'MidTierNuke'
            elseif info.high_nukes:contains(spell.english) then
                return 'HighTierNuke'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
        elseif state.IdleMode.value == 'PDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
        end
    end

    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not (buffactive['light arts'] or buffactive['dark arts'] or
                       buffactive['addendum: white'] or buffactive['addendum: black']) then
        if state.IdleMode.value == 'Stun' then
            send_command('@input /ja "Dark Arts" <me>')
        else
            send_command('@input /ja "Light Arts" <me>')
        end
    end

    update_active_strategems()
    update_sublimation()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element then
            --equip(sets.buff['Klimaform'])
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 4*60

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end



-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 17)
end


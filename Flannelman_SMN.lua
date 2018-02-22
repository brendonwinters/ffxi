-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Also, you'll need the Shortcuts addon to handle the auto-targetting of the custom pact commands.

--[[
    Custom commands:
    
    gs c petweather
        Automatically casts the storm appropriate for the current avatar, if possible.
    
    gs c siphon
        Automatically run the process to: dismiss the current avatar; cast appropriate
        weather; summon the appropriate spirit; Elemental Siphon; release the spirit;
        and re-summon the avatar.
        
        Will not cast weather you do not have access to.
        Will not re-summon the avatar if one was not out in the first place.
        Will not release the spirit if it was out before the command was issued.
        
    gs c pact [PactType]
        Attempts to use the indicated pact type for the current avatar.
        PactType can be one of:
            cure
            curaga
            buffOffense
            buffDefense
            buffSpecial
            debuff1
            debuff2
            sleep
            nuke2
            nuke4
            bp70
            bp75 (merits and lvl 75-80 pacts)
            astralflow

--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff["Avatar's Favor"] = buffactive["Avatar's Favor"] or false
    state.Buff["Astral Conduit"] = buffactive["Astral Conduit"] or false
	state.Buff['Haste'] = buffactive['Haste'] or false
	state.ConduitMode = M(false, 'ConduitMode')

    spirits = S{"LightSpirit", "DarkSpirit", "FireSpirit", "EarthSpirit", "WaterSpirit", "AirSpirit", "IceSpirit", "ThunderSpirit"}
    avatars = S{"Carbuncle", "Fenrir", "Diabolos", "Ifrit", "Titan", "Leviathan", "Garuda", "Shiva", "Ramuh", "Odin", "Alexander", "Cait Sith"}

    magicalRagePacts = S{
        'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Diamond Dust','Judgment Bolt','Searing Light','Howling Moon','Ruinous Omen',
        'Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II',
        'Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV',
        'Thunderspark','Meteorite','Nether Blast',
        'Meteor Strike','Heavenly Strike','Wind Blade','Geocrush','Grand Fall','Thunderstorm',
        'Holy Mist','Lunar Bay','Night Terror','Level ? Holy'}
	
	hybridRagePacts = S{'Burning Strike','Flaming Crush'}

    pacts = {}
    pacts.cure = {['Carbuncle']='Healing Ruby'}
    pacts.curaga = {['Carbuncle']='Healing Ruby II', ['Garuda']='Whispering Wind', ['Leviathan']='Spring Water'}
    pacts.buffoffense = {['Carbuncle']='Glittering Ruby', ['Ifrit']='Crimson Howl', ['Garuda']='Hastega II', ['Ramuh']='Rolling Thunder',
        ['Fenrir']='Ecliptic Growl'}
    pacts.buffdefense = {['Carbuncle']='Shining Ruby', ['Shiva']='Frost Armor', ['Garuda']='Aerial Armor', ['Titan']='Earthen Ward',
        ['Ramuh']='Lightning Armor', ['Fenrir']='Ecliptic Howl', ['Diabolos']='Noctoshield', ['Cait Sith']='Reraise II'}
    pacts.buffspecial = {['Ifrit']='Inferno Howl', ['Garuda']='Fleet Wind', ['Titan']='Earthen Armor', ['Diabolos']='Dream Shroud',
        ['Carbuncle']='Soothing Ruby', ['Fenrir']='Heavenward Howl', ['Cait Sith']='Raise II'}
    pacts.debuff1 = {['Shiva']='Diamond Storm', ['Ramuh']='Shock Squall', ['Leviathan']='Tidal Roar', ['Fenrir']='Lunar Cry',
        ['Diabolos']='Pavor Nocturnus', ['Cait Sith']='Eerie Eye'}
    pacts.debuff2 = {['Shiva']='Sleepga', ['Leviathan']='Slowga', ['Fenrir']='Lunar Roar', ['Diabolos']='Somnolence'}
    pacts.sleep = {['Shiva']='Sleepga', ['Diabolos']='Nightmare', ['Cait Sith']='Mewing Lullaby'}
    pacts.nuke2 = {['Ifrit']='Fire II', ['Shiva']='Blizzard II', ['Garuda']='Aero II', ['Titan']='Stone II',
        ['Ramuh']='Thunder II', ['Leviathan']='Water II'}
    pacts.nuke4 = {['Ifrit']='Fire IV', ['Shiva']='Blizzard IV', ['Garuda']='Aero IV', ['Titan']='Stone IV',
        ['Ramuh']='Thunder IV', ['Leviathan']='Water IV'}
    pacts.bp70 = {['Ifrit']='Flaming Crush', ['Shiva']='Rush', ['Garuda']='Predator Claws', ['Titan']='Mountain Buster',
        ['Ramuh']='Chaotic Strike', ['Leviathan']='Spinning Dive', ['Carbuncle']='Meteorite', ['Fenrir']='Eclipse Bite',
        ['Diabolos']='Nether Blast',['Cait Sith']='Regal Scratch'}
    pacts.bp75 = {['Ifrit']='Meteor Strike', ['Shiva']='Heavenly Strike', ['Garuda']='Wind Blade', ['Titan']='Geocrush',
        ['Ramuh']='Thunderstorm', ['Leviathan']='Grand Fall', ['Carbuncle']='Holy Mist', ['Fenrir']='Lunar Bay',
        ['Diabolos']='Night Terror', ['Cait Sith']='Level ? Holy'}
    pacts.astralflow = {['Ifrit']='Inferno', ['Shiva']='Diamond Dust', ['Garuda']='Aerial Blast', ['Titan']='Earthen Fury',
        ['Ramuh']='Judgment Bolt', ['Leviathan']='Tidal Wave', ['Carbuncle']='Searing Light', ['Fenrir']='Howling Moon',
        ['Diabolos']='Ruinous Omen', ['Cait Sith']="Altana's Favor"}

    -- Wards table for creating custom timers   
    wards = {}
    -- Base duration for ward pacts.
    wards.durations = {
        ['Crimson Howl'] = 60, ['Earthen Armor'] = 60, ['Inferno Howl'] = 60, ['Heavenward Howl'] = 60,
        ['Rolling Thunder'] = 120, ['Fleet Wind'] = 120,
        ['Shining Ruby'] = 180, ['Frost Armor'] = 180, ['Lightning Armor'] = 180, ['Ecliptic Growl'] = 180,
        ['Glittering Ruby'] = 180, ['Hastega II'] = 180, ['Noctoshield'] = 180, ['Ecliptic Howl'] = 180,
        ['Dream Shroud'] = 180,
        ['Reraise II'] = 3600
    }
    -- Icons to use when creating the custom timer.
    wards.icons = {
        ['Earthen Armor']   = 'spells/00299.png', -- 00299 for Titan
        ['Shining Ruby']    = 'spells/00043.png', -- 00043 for Protect
        ['Dream Shroud']    = 'spells/00304.png', -- 00304 for Diabolos
        ['Noctoshield']     = 'spells/00106.png', -- 00106 for Phalanx
        ['Crimson Howl']    = 'spells/00298.png', -- 00298 for Ifrit
        ['Hastega II']      = 'spells/00358.png', -- 00358 for Hastega
        ['Rolling Thunder'] = 'spells/00104.png', -- 00358 for Enthunder
        ['Frost Armor']     = 'spells/00250.png', -- 00250 for Ice Spikes
        ['Lightning Armor'] = 'spells/00251.png', -- 00251 for Shock Spikes
        ['Reraise II']      = 'spells/00135.png', -- 00135 for Reraise
        ['Fleet Wind']      = 'abilities/00074.png', -- 
    }
    -- Flags for code to get around the issue of slow skill updates.
    wards.flag = false
    wards.spell = ''
    
    send_command('bind !` gs c toggle ConduitMode')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
    
    select_default_macro_book()
end


function user_unload()
    send_command('unbind !`')
end	

-- Define sets and vars used by this job file.
function init_gear_sets()
	sets.precast.Item = {}
	sets.precast.Item['Holy Water'] = {ring1="Purity Ring"} 

	include('Flannelman_aug-gear.lua')
	

    CampestresPhysical={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20',}}	
    CampestresMagical={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20',}}
	
    --------------------------------------
    -- Precast Sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Astral Flow'] = {head="Glyphic Horn"}
    
    sets.precast.JA['Elemental Siphon'] = {
		ammo="Sancus Sachet +1",
		head="Beckoner's horn +1",
		body="Baayami Robe +1",
		hands="Baayami Cuffs +1",
		legs="Baayami Slops +1",
		feet="Baayami Sabots +1",
		neck="Incanter's Torque",
		left_ring="Evoker's Ring",
		right_ring="Stikini Ring +1",
		back="Conveyance Cape",
	}

    sets.precast.JA['Mana Cede'] = {hands="Caller's Bracers +2"}

    -- Pact delay reduction gear
    sets.precast.BloodPactWard = { 
		ammo="Sancus Sachet +1",
--		head="Convoker's horn +2",
		head="Beckoner's horn +1",
		body="Baayami Robe +1",
		hands="Baayami Cuffs +1",
		legs="Baayami Slops +1",
		feet="Baayami Sabots +1",
		left_ear="Andoaa Earring",
		neck="Incanter's Torque",
		left_ring="Evoker's Ring",
		right_ring="Stikini Ring +1",
		waist="Kobo Obi",
		back="Conveyance Cape",
	}

    sets.precast.BloodPactRage = sets.precast.BloodPactWard

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Sapience Orb",
        head=MerlinicHoodFC,			--14
        body="Zendik Robe",				--13
		hands=MerlinicDastanasFC,		--6
		legs="Lengo pants",				--5
		feet=MerlinicCrackowsFC,		--11
		ear1="Etiolation Earring",		--1
		ear2="Loquacious Earring",		--2
		neck="Orunmila's torque",		--5
		ring1="Lebeche ring",
		ring2="Weatherspoon Ring",		--5
		waist="Witful Belt",			--3			-->66 (rdm sub = 81)
		}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear1="Mendicant's earring",})

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		head="Tali'ah Turban +1",
		body="Convoker's Doublet +3",
		hands="Tali'ah Gages +1",
		legs="Tali'ah Seraweels +1",
		feet="Convoker's Pigaches +2",	
		neck="Fotia gorget",	
		left_ear="Digni. Earring",right_ear="Telos Earring",ring2="Cacoethic Ring +1",
        back="Kayapa Cape",waist="Fotia belt",}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {  
		head="Pixie Hairpin +1",
		body="Convoker's Doublet +3",
		hands="Apogee Mitts", 
		legs="Amalric Slops +1", 
		feet="Convoker's Pigaches +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Gelos Earring",
		right_ear="Moonshade Earring", 
		left_ring="Mephitas's Ring +1",
		right_ring="Kishar Ring",
		back="Conveyance Cape",
	}
	sets.precast.WS['Garland of Bliss'] = {
		ammo="Pemphredo Tathlum",
		head="Amalric Coif +1",
		body="Amalric Doublet +1",
		hands="Amalric Gages +1",
		legs="Amalric Slops +1", 
		feet="Amalric Nails +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Defending Ring",
		right_ring="Acumen Ring",
		back="Seshaw Cape",
	}
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {ammo="Sapience Orb",
        head="merlinic hood",			--8
		ear2="Loquacious Earring",		--2
		neck="Incanter's torque",		--5
        body="Baayami Robe +1",			--5
		ring1="Evanescence ring",
		ring2="Weatherspoon Ring",		--5
		waist="Witful Belt",			--3
		legs="Lengo pants",				--5
		feet="merlinic crackows"			--4
		}

	sets.midcast.Cure = set_combine(sets.midcast.FastRecast,{
		neck="Phalaina locket",ear1="Mendicant's earring",--4 5
        body="Vrikodara Jupon",hands="Telchine Gloves",ring1="ephedra ring",ring2="sirona's ring",--13 10
        back="Solemnity cape",feet="medium's sabots"})--6+12 = 50
		
    sets.midcast.Curaga = sets.midcast.Cure	
    sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {head="Telchine Cap",neck="Phalaina locket",ring1="Kunaji Ring",waist="Gishdubar Sash"})
	
	sets.midcast['Enhancing Magic'] = {
        head="Telchine cap",neck="Incanter's torque",
        body="Telchine Chasuble",hands="Telchine Gloves",
		waist="Olympus Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],{head="Amalric Coif +1",feet="Inspirited Boots",waist="Gishdubar Sash"})	
	
    sets.midcast['Enfeebling Magic'] = {ammo="Pemphredo Tathlum",
		head="Amalric Coif +1",
		body="Amalric Doublet +1",
		hands="Raetic Bangles",
		legs="Amalric Slops +1", 
		feet="Medium's Sabots", 
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Digni. Earring",
		right_ear="Gwati Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Weather. Ring",
		back="Toro Cape",}

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak",})

    sets.midcast['Dark Magic'] = {
        head="Pixie Hairpin +1",neck="Incanter's torque",ear1="Dignitary's Earring",ear2="Gwati Earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Kishar ring",ring2="Weatherspoon Ring",
        back="Toro Cape",waist="Eschan stone",legs="Merlinic shalwar",feet="Medium's sabots"}
		    
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'],{
		ring1="evanescence Ring",ring2="archon ring",
		waist="Fucho-no-obi",feet="merlinic crackows"})

    sets.midcast.Aspir = sets.midcast.Drain
    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'],{})
	
    sets.midcast['Elemental Magic'] = {ammo="Pemphredo Tathlum",
		head="Amalric Coif +1",
		body="Amalric Doublet +1",
		hands="Amalric Gages +1",
		legs="Amalric Slops +1", 
		feet="Amalric Nails +1",
        neck="Sanctity necklace",ear1="Barkarole earring",ear2="Friomisi Earring",
        ring1="Metamorph Ring +1",ring2="Acumen Ring",
        back="Toro Cape",waist="Eschan stone"}

    sets.midcast['Summon Magic'] = {}
	sets.midcast['Diaga']={head="White Rarab Cap +1",legs=MerlinicShalwarTH,waist="Chaac belt"}
	sets.midcast['Dia II']=sets.midcast['Diaga']


    -- Avatar pact sets.  All pacts are Ability type.
    
    sets.midcast.Pet.BloodPactWard = {    ammo="Sancus Sachet +1",
		head="Convoker's horn +2",
		body="Baayami Robe +1",
		hands="Baayami Cuffs +1",
		legs="Baayami Slops +1",
		feet="Baayami Sabots +1",
		left_ear="Andoaa Earring",
		neck="Incanter's Torque",
		left_ring="Evoker's Ring",
		right_ring="Stikini Ring +1",
		back="Conveyance Cape",
		waist="Kobo Obi",
	}

    sets.midcast.Pet.DebuffBloodPactWard = {ammo="Sancus Sachet +1",
		head="Convoker's horn +2",
		body="Baayami Robe +1",
		hands="Baayami Cuffs +1",
		legs="Baayami Slops +1",
		feet="Baayami Sabots +1",
		neck="Incanter's Torque",
		ring1="Evoker's Ring",
		ring2="Stikini Ring +1",
		back=CampestresMagical
	}
        
    sets.midcast.Pet.DebuffBloodPactWard.Acc = sets.midcast.Pet.DebuffBloodPactWard
    
    sets.midcast.Pet.PhysicalBloodPactRage = { 
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head="Apogee Crown +1",
		body="Convoker's Doublet +3",
		hands=MerlinicDastanasPBP,
		legs="Apogee Slacks +1",
		feet="Apogee Pumps +1",
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Gelos Earring",
		right_ear="Lugalbanda Earring",
		left_ring="Varar Ring",
		right_ring="Varar Ring",
		back=CampestresPhysical
	}

    sets.midcast.Pet.PhysicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {
		head="Apogee Crown +1",
		hands="Tali'ah Gages +1",
		legs="Tali'ah Seraweels +1",
		feet="Convo. Pigaches +2",
		left_ear="Enmerkar Earring",
	})

    sets.midcast.Pet.MagicalBloodPactRage = {
		--main="Espiritus",
		--sub="Niobid Strap",
		ammo="Sancus Sachet +1",
		head="Apogee Crown +1", 
		body="Convoker's Doublet +3",
		hands=MerlinicDastanasMBP,
		legs="Enticer's Pants", 
		feet="Apogee Pumps +1",
		neck="Adad Amulet",
		left_ear="Gelos Earring",
		right_ear="Lugalbanda Earring",
		left_ring="Varar Ring",
		right_ring="Varar Ring",
		back=CampestresMagical
	}
	
    sets.midcast.Pet.MagicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.MagicalBloodPactRage,{	
		head="Apogee Crown +1",
		--hands="Apogee Mitts",
		legs="Tali'ah Seraweels +1",
		left_ear="Enmerkar Earring",
	})
	
	
	sets.midcast.Pet.HybridBloodPactRage = {	
		ammo="Sancus Sachet +1",
		head="Apogee Crown +1", 
		body="Convoker's Doublet +3",
		hands=MerlinicDastanasMBP,
		legs="Apogee Slacks +1", 
		feet="Apogee Pumps +1",
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Gelos Earring",
		right_ear="Lugalbanda Earring",
		left_ring="Varar Ring",
		right_ring="Varar Ring",
		back=CampestresMagical
	}
	sets.midcast.Pet.HybridBloodPactRage.Acc = set_combine(sets.midcast.Pet.HybridBloodPactRage,{
		head="Apogee Crown +1",
		--hands="Apogee Mitts",
		legs="Tali'ah Seraweels +1",	
		feet="Convo. Pigaches +2",
		left_ear="Enmerkar Earring",
	})
	

    -- Spirits cast magic spells, which can be identified in standard ways.
    
    sets.midcast.Pet.WhiteMagic = {}
    
    sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {})

    sets.midcast.Pet['Elemental Magic'].Resistant = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {})
    

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {ammo="Sancus Sachet +1",
        head="Convoker's horn +2",neck="Loricate torque +1",ear1="Gelos Earring",ear2="Loquacious Earring",
        body="Amalric Doublet +1",hands=MerlinicDastanasMBP,ring1="Defending Ring",ring2="Stikini Ring +1",
        back="Moonlight Cape",waist="Fucho-no-Obi",legs="Lengo Pants",feet="Herald's gaiters"}
    
    -- Idle sets
    sets.idle = {ammo="Staunch Tathlum +1",
		head="Convoker's horn +2",
		body="Amalric Doublet +1", 
		hands="Raetic Bangles", 
		legs="Assid. Pants +1",
		feet="Baayami Sabots +1",
		--feet="Herald's Gaiters",
		neck="Sanctity Necklace",
		waist="Fucho-no-Obi",
		left_ear="Hearty Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Stikini Ring +1",
		back="Moonlight Cape",
	}

    sets.idle.PDT = {ammo="Staunch Tathlum +1",
        head="Convoker's horn +2",neck="Loricate torque +1",ear1="Gelos Earring",ear2="Etiolation Earring",        
		body="Amalric Doublet +1", hands="Raetic Bangles",ring1="Defending Ring",
        back="Moonlight Cape",waist="Fucho-no-Obi",legs="Lengo Pants",feet="Herald's Gaiters"}

    -- perp costs:
    -- spirits: 7
    -- carby: 11 (5 with mitts)
    -- fenrir: 13
    -- others: 15
    -- avatar's favor: -4/tick
    
    -- Max useful -perp gear is 1 less than the perp cost (can't be reduced below 1)
    -- Aim for -14 perp, and refresh in other slots.
    
    -- -perp gear:
    -- Gridarvor: -5
    -- Glyphic Horn: -4
    -- Caller's Doublet +2/Glyphic Doublet: -4
    -- Evoker's Ring: -1
    -- Caller's Pigaches +1: -4
    -- total: -18
    
    -- Can make due without either the head or the body, and use +refresh items in those slots.
    
    sets.idle.Avatar = {ammo="Sancus Sachet +1",
		--main="Nirvana",				--8
		--sub="Niobid Strap",
		ammo="Sancus Sachet +1",
		head="Convoker's horn +2",
		body="Amalric Doublet +1", 
		hands="Baayami Cuffs +1", 
		legs="Assid. Pants +1",			--3
		feet="Convoker's Pigaches +2",	--5	
		neck="Empath Necklace",
		waist="Isa Belt",
		left_ear="Enmerkar Earring",
		right_ear="Handler's Earring +1",
		left_ring="Defending Ring",
		right_ring="Stikini Ring +1",
		back=CampestresPhysical,
	}

    sets.idle.Spirit = {ammo="Sancus Sachet +1",
		--main="Gridarvor",
		--sub="Niobid Strap",
		ammo="Sancus Sachet +1",
		head="Convoker's horn +2",
		body="Amalric Doublet +1", 
		hands="Baayami Cuffs +1", 
		legs="Assid. Pants +1",			--3
		feet="Convoker's Pigaches +2",	--5	
		neck="Empath Necklace",
		waist="Isa Belt",
		left_ear="Enmerkar Earring",
		right_ear="Handler's Earring +1",
		left_ring="Defending Ring",
		right_ring="Stikini Ring +1",
		back=CampestresPhysical,
	}


    -- Favor uses Caller's Horn instead of Summoners Horn for refresh
    sets.idle.Avatar.Favor = {head="Beckoner's Horn +1"}
    sets.idle.Avatar.Melee = {waist="Incarnation Sash"}
        
    sets.perp = {}
    -- Caller's Bracer's halve the perp cost after other costs are accounted for.
    -- Using -10 (Gridavor, ring, Conv.feet), standard avatars would then cost 5, halved to 2.
    -- We can then use Hagondes Coat and end up with the same net MP cost, but significantly better defense.
    -- Weather is the same, but we can also use the latent on the pendant to negate the last point lost.
    sets.perp.Day = {}
    sets.perp.Weather = {}
    -- Carby: Mitts+Conv.feet = 1/tick perp.  Everything else should be +refresh
    sets.perp.Carbuncle = {feet="Herald's gaiters"}
    -- Diabolos's Rope doesn't gain us anything at this time
    --sets.perp.Diabolos = {waist="Diabolos's Rope"}
    sets.perp.Alexander = sets.midcast.Pet.BloodPactWard

    
    -- Defense sets
    sets.defense.PDT = {ammo="Sancus Sachet +1",
        neck="Loricate Torque +1",ear1="Hearty Earring",ear2="Odnowa Earring +1",
		ring1="Defending Ring",ring2="Stikini Ring +1",
        back="Moonlight Cape",waist="Fucho-no-Obi"}

    sets.defense.MDT = {
		main="Keraunos", 
		--sub="Niobid Strap",
		ammo="Sancus Sachet +1",
		head="Inyanga Tiara +1",
		body="Inyanga Jubbah +1",
		hands=MerlinicDastanasMBP,
		legs="Inyanga Shalwar +1",
		feet="Convoker's Pigaches +2",		
		neck="Empath Necklace",
		waist="Fucho-no-Obi",
		left_ear="Eabani Earring",
		right_ear="Handler's Earring +1",
		left_ring="Defending Ring",
		right_ring="Stikini Ring +1",
		back="Solemnity Cape",
	}

    sets.Kiting = {feet="Herald's Gaiters"}
    
    sets.latent_refresh = {waist="Fucho-no-obi"}
    

    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    -- Normal melee group
	sets.engaged = {ammo="Sancus Sachet +1",
		head="Tali'ah Turban +1",
		body="Convoker's Doublet +3",
		hands="Tali'ah Gages +1",
		legs="Tali'ah Seraweels +1",
		feet="Convoker's Pigaches +2",	
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
	}
	sets.engaged.Perp = {
		ammo="Sancus Sachet +1",
		head="Beckoner's Horn +1",
		body="Convoker's Doublet +3",
		hands="Tali'ah Gages +1",
		legs="Assid. Pants +1",
		feet="Convoker's Pigaches +2",		
		neck="Empath Necklace",
		waist="Incarnation Sash",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Defending Ring",
		right_ring="Stikini Ring +1",
		back=CampestresPhysical}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
   --if state.Buff['Astral Conduit'] and pet_midaction() then
   --     eventArgs.handled = true
   -- end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Elemental Magic' then	
		if spell.element == world.day_element or spell.element == world.weather_element then
            equip(sets.midcast['Elemental Magic'].CastingMode, {waist="Hachirin-No-Obi"})
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
-- Runs when pet completes an action.
function job_pet_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.type == 'BloodPactWard' then
        wards.flag = true
        wards.spell = spell.english
        send_command('wait 4; gs c reset_ward_flag')
    end
	
    if pet.isvalid then 
		if pet.status == 'Engaged' then
            idleSet = set_combine(idleSet, sets.idle.Avatar.Melee)
		else 
			idleSet = set_combine(idleSet,sets.idle.Avatar)
        end
		equip(idleSet)
		--add_to_chat(122, "pet out")
	end
end

function job_aftercast(spell, action, spellMap, eventArgs)	
    if pet.isvalid then
		if pet.status == 'Engaged' then
            idleSet = set_combine(idleSet, sets.idle.Avatar.Melee)
		else 
			idleSet = set_combine(idleSet,sets.idle.Avatar)
        end
		equip(idleSet)
	--	add_to_chat(122, "pet out")
	end	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	--if state.Buff['Astral Conduit'] then
	if state.ConduitMode.value then
		if state.Buff['Astral Conduit'] then
			equip(sets.midcast.Pet.PhysicalBloodPactRage)
			add_to_chat(122, "Conduit Goes")
			disable('ammo','head','neck','ear1','ear2','body','hands','ring1','ring2','back','waist','legs','feet')
		else enable('ammo','head','neck','ear1','ear2','body','hands','ring1','ring2','back','waist','legs','feet')
		end
	end
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    elseif storms:contains(buff) then
        handle_equipping_gear(player.status)
    end
end


-- Called when the player's pet's status changes.
-- This is also called after pet_change after a pet is released.  Check for pet validity.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if not pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
        handle_equipping_gear(player.status, newStatus)
    end
end


-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
    classes.CustomIdleGroups:clear()
    if gain then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    else
--        select_default_macro_book('reset')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell)
    if spell.type == 'BloodPactRage' then
        if magicalRagePacts:contains(spell.english) then
            return 'MagicalBloodPactRage'
		elseif hybridRagePacts:contains(spell.english) then
			return 'HybridBloodPactRage'
        else
            return 'PhysicalBloodPactRage'
        end
    elseif spell.type == 'BloodPactWard' and spell.target.type == 'MONSTER' then
        return 'DebuffBloodPactWard'
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if pet.isvalid then
        -- if pet.element == world.day_element then
            -- idleSet = set_combine(idleSet, sets.perp.Day)
        -- end
        -- if pet.element == world.weather_element then
            -- idleSet = set_combine(idleSet, sets.perp.Weather)
        -- end
        -- if sets.perp[pet.name] then
            -- idleSet = set_combine(idleSet, sets.perp[pet.name])
        -- end
        -- gear.perp_staff.name = elements.perpetuance_staff_of[pet.element]
        -- if gear.perp_staff.name and (player.inventory[gear.perp_staff.name] or player.wardrobe[gear.perp_staff.name]) then
            -- idleSet = set_combine(idleSet, sets.perp.staff_and_grip)
        -- end
        if state.Buff["Avatar's Favor"] and avatars:contains(pet.name) then
            idleSet = set_combine(idleSet, sets.idle.Avatar.Favor)
        end
        if pet.status == 'Engaged' then
            idleSet = set_combine(idleSet, sets.idle.Avatar.Melee)
        end
    end
    
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'petweather' then
        handle_petweather()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'siphon' then
        handle_siphoning()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'pact' then
        handle_pacts(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1] == 'reset_ward_flag' then
        wards.flag = false
        wards.spell = ''
        eventArgs.handled = true
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Cast the appopriate storm for the currently summoned avatar, if possible.
function handle_petweather()
    if player.sub_job ~= 'SCH' then
        add_to_chat(122, "You can not cast storm spells")
        return
    end
        
    if not pet.isvalid then
        add_to_chat(122, "You do not have an active avatar.")
        return
    end
    
    local element = pet.element
    if element == 'Thunder' then
        element = 'Lightning'
    end
    
    if S{'Light','Dark','Lightning'}:contains(element) then
        add_to_chat(122, 'You do not have access to '..elements.storm_of[element]..'.')
        return
    end 
    
    local storm = elements.storm_of[element]
    
    if storm then
        send_command('@input /ma "'..elements.storm_of[element]..'" <me>')
    else
        add_to_chat(123, 'Error: Unknown element ('..tostring(element)..')')
    end
end


-- Custom uber-handling of Elemental Siphon
function handle_siphoning()
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'Cannot use Elemental Siphon in a city area.')
        return
    end

    local siphonElement
    local stormElementToUse
    local releasedAvatar
    local dontRelease
    
    -- If we already have a spirit out, just use that.
    if pet.isvalid and spirits:contains(pet.name) then
        siphonElement = pet.element
        dontRelease = true
        -- If current weather doesn't match the spirit, but the spirit matches the day, try to cast the storm.
        if player.sub_job == 'SCH' and pet.element == world.day_element and pet.element ~= world.weather_element then
            if not S{'Light','Dark','Lightning'}:contains(pet.element) then
                stormElementToUse = pet.element
            end
        end
    -- If we're subbing /sch, there are some conditions where we want to make sure specific weather is up.
    -- If current (single) weather is opposed by the current day, we want to change the weather to match
    -- the current day, if possible.
    elseif player.sub_job == 'SCH' and world.weather_element ~= 'None' then
        -- We can override single-intensity weather; leave double weather alone, since even if
        -- it's partially countered by the day, it's not worth changing.
        if get_weather_intensity() == 1 then
            -- If current weather is weak to the current day, it cancels the benefits for
            -- siphon.  Change it to the day's weather if possible (+0 to +20%), or any non-weak
            -- weather if not.
            -- If the current weather matches the current avatar's element (being used to reduce
            -- perpetuation), don't change it; just accept the penalty on Siphon.
            if world.weather_element == elements.weak_to[world.day_element] and
                (not pet.isvalid or world.weather_element ~= pet.element) then
                -- We can't cast lightning/Dark/light weather, so use a neutral element
                if S{'Light','Dark','Lightning'}:contains(world.day_element) then
                    stormElementToUse = 'Wind'
                else
                    stormElementToUse = world.day_element
                end
            end
        end
    end
    
    -- If we decided to use a storm, set that as the spirit element to cast.
    if stormElementToUse then
        siphonElement = stormElementToUse
    elseif world.weather_element ~= 'None' and (get_weather_intensity() == 2 or world.weather_element ~= elements.weak_to[world.day_element]) then
        siphonElement = world.weather_element
    else
        siphonElement = world.day_element
    end
    
    local command = ''
    local releaseWait = 0
    
    if pet.isvalid and avatars:contains(pet.name) then
        command = command..'input /pet "Release" <me>;wait 1.1;'
        releasedAvatar = pet.name
        releaseWait = 10
    end
    
    if stormElementToUse then
        command = command..'input /ma "'..elements.storm_of[stormElementToUse]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end
    
    if not (pet.isvalid and spirits:contains(pet.name)) then
        command = command..'input /ma "'..elements.spirit_of[siphonElement]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end
    
    command = command..'input /ja "Elemental Siphon" <me>;'
    releaseWait = releaseWait - 1
    releaseWait = releaseWait + 0.1
    
    if not dontRelease then
        if releaseWait > 0 then
            command = command..'wait '..tostring(releaseWait)..';'
        else
            command = command..'wait 1.1;'
        end
        
        command = command..'input /pet "Release" <me>;'
    end
    
    if releasedAvatar then
        command = command..'wait 1.1;input /ma "'..releasedAvatar..'" <me>'
    end
    
    send_command(command)
end


-- Handles executing blood pacts in a generic, avatar-agnostic way.
-- cmdParams is the split of the self-command.
-- gs c [pact] [pacttype]
function handle_pacts(cmdParams)
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'You cannot use pacts in town.')
        return
    end

    if not pet.isvalid then
        add_to_chat(122,'No avatar currently available. Returning to default macro set.')
        select_default_macro_book('reset')
        return
    end

    if spirits:contains(pet.name) then
        add_to_chat(122,'Cannot use pacts with spirits.')
        return
    end

    if not cmdParams[2] then
        add_to_chat(123,'No pact type given.')
        return
    end
    
    local pact = cmdParams[2]:lower()
    
    if not pacts[pact] then
        add_to_chat(123,'Unknown pact type: '..tostring(pact))
        return
    end
    
    if pacts[pact][pet.name] then
        if pact == 'astralflow' and not buffactive['astral flow'] then
            add_to_chat(122,'Cannot use Astral Flow pacts at this time.')
            return
        end
        
        -- Leave out target; let Shortcuts auto-determine it.
        send_command('@input /pet "'..pacts[pact][pet.name]..'"')
    else
        add_to_chat(122,pet.name..' does not have a pact of type ['..pact..'].')
    end
end


-- Event handler for updates to player skill, since we can't rely on skill being
-- correct at pet_aftercast for the creation of custom timers.
windower.raw_register_event('incoming chunk',
    function (id)
        if id == 0x62 then
            if wards.flag then
                create_pact_timer(wards.spell)
                wards.flag = false
                wards.spell = ''
            end
        end
    end)

-- Function to create custom timers using the Timers addon.  Calculates ward duration
-- based on player skill and base pact duration (defined in job_setup).
function create_pact_timer(spell_name)
    -- Create custom timers for ward pacts.
    if wards.durations[spell_name] then
        local ward_duration = wards.durations[spell_name]
        if ward_duration < 181 then
            local skill = player.skills.summoning_magic
            if skill > 300 then
                skill = skill - 300
                ward_duration = ward_duration + skill
            end
        end
        
        local timer_cmd = 'timers c "'..spell_name..'" '..tostring(ward_duration)..' down'
        
        if wards.icons[spell_name] then
            timer_cmd = timer_cmd..' '..wards.icons[spell_name]
        end

        send_command(timer_cmd)
    end
end
--auto use echo drops
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type:endswith('Magic') and buffactive.silence then
        eventArgs.cancel = true
        send_command('input /item "Echo Drops" <st>')
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book(reset)
    if reset == 'reset' then
        -- lost pet, or tried to use pact when pet is gone
    end
    
    -- Default macro set/book
    set_macro_page(1, 16)
end

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
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
    state.Buff.Doom = buffactive.Doom or false
    
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false
	
	HasteTotal = 0
	
    blue_magic_maps = {}
	
    -- Physical Spells --
    
    blue_magic_maps.Physical = S{'Bilgestorm'}
    blue_magic_maps.PhysicalAcc = S{'Heavy Strike'}
    blue_magic_maps.PhysicalStr = S{
        'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Spinal Cleave','Sweeping Gouge',
        'Uppercut','Vertical Cleave','Sinker Drill','Thrashing Assault'}
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch',
        'Vanity Dive'}     
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'}
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'}
    blue_magic_maps.PhysicalInt = S{'Mandibular Bite','Queasyshroom'}
    blue_magic_maps.PhysicalMnd = S{'Ram Charge','Screwdriver','Tourbillion'}
    blue_magic_maps.PhysicalChr = S{'Bludgeon'}
    blue_magic_maps.PhysicalHP = S{'Final Sting'}

    -- Magical Spells --

    blue_magic_maps.Magical = S{
        'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Dark Orb','Death Ray',
        'Droning Whirlwind','Embalming Earth','Firespit','Foul Waters','Ice Break',
        'Leafstorm','Maelstrom','Regurgitation','Rending Deluge',
        'Subduction','Tem. Upheaval','Water Bomb',
		'Searing Tempest', 'Spectral Floe', 'Scouring Spate', 'Anvil Lightning', 'Entomb',
		'Silent Storm', 'Molting Plumage', 'Nectarous Deluge'}
    blue_magic_maps.MagicalMnd = S{'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast'}
    blue_magic_maps.MagicalChr = S{'Eyes On Me','Mysterious Light'}
    blue_magic_maps.MagicalVit = S{'Thermal Pulse'}
    blue_magic_maps.MagicalDex = S{'Charged Whisker','Gates of Hades'}            
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        '1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'}
    blue_magic_maps.MagicDark = S{'Blood Saber','Palling Salvo','Tenebral Crush','Osmosis','Atra. Libations'}
	blue_magic_maps.MagicLight = S{'Blinding Fulgor','Diffusion Ray','Rail Cannon','Retinal Glare','Magic Hammer'}
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
        'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'}
    blue_magic_maps.Stun = S{
        'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage'}
    blue_magic_maps.Healing = S{'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Wild Carrot'}
    blue_magic_maps.SkillBasedBuff = S{
        'Diamondhide','Magic Barrier','Metallic Body','Plasma Charge','Reactor Cool', 'Occultation'}
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Barrier Tusk','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
        'Memento Mori','Nat. Meditation','Orcish Counterstance','Pyric Bulwark','Refueling',
        'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promy.',
        'Zephyr Mantle'}
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
        'Droning Whirlwind','Gates of Hades','Harden Shell','Pyric Bulwark','Thunderbolt',
        'Tourbillion','Mighty Guard'}
	
	if buffactive['Mighty Guard'] then
		HasteTotal = HasteTotal + 15
	end	
	if buffactive['Haste'] then
		HasteTotal = HasteTotal + 30
	end	
	if buffactive['March'] then
		HasteTotal = HasteTotal + 15
	end		
	--add_to_chat(122, HasteTotal)
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc50', 'Acc100', 'Acc150', 'Refresh')
    state.HybridMode:options('Normal', 'PDT', 'Meva')
    state.WeaponskillMode:options('Normal', 'Defending', 'Acc50', 'Acc100', 'Acc150')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
		
	state.RuneMode = M('None','Sulpor','Lux','Tenebrae','Ignis','Gelus','Flabra','Tellus','Unda')
    state.MagicBurst = M(false, 'Magic Burst')
    state.DualWield = M(false, 'Dual Wield')
	state.RaeticMode = M(False, 'Raetic Mode')

    -- Additional local binds
--    send_command('bind ^` gs c toggle DualWield')
	send_command('bind ^` gs c toggle RaeticMode')
    send_command('bind !` gs c toggle MagicBurst')
	send_command('bind @` gs c cycle RuneMode')
	
    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
	send_command('unbind @`')
end


-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	
	include('Flannelman_aug-gear.lua')
    

    RosmertaSTP={ name="Rosmerta's Cape",  augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}}
    RosmertaCrit={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
    RosmertaWSD={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

    sets.buff['Burst Affinity'] = {}--feet="Hashishin Basmak +1",}--legs="Assimilator's Shalwar"}
    sets.buff['Chain Affinity'] = {}--feet="Assimilator's Charuqs"}
    --sets.buff.Convergence = {head="Mirage Keffiyeh +2"}
    sets.buff.Diffusion = {feet="Luhlaza Charuqs"}
    --sets.buff.Enchainment = {body="Mirage Jubbah +2"}
    sets.buff.Efflux = {legs="Hashishin Tayt +1"}

    
    -- Precast Sets
	sets.precast.Item = {}
	sets.precast.Item['Holy Water'] = {ring1="Purity Ring"} 
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Azure Lore'] = {hands="Mirage Bazubands +2"}


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
	
	
    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Sapience Orb",--2
        head=HercHelmFC,				--13
        body="Pinga Tunic +1",			--15
		hands="Leyline Gloves",			--8
		legs="Pinga Pants +1",			--11
		ear1="Etiolation Earring",		--1
		ear2="Loquacious Earring",		--2
		neck="Orunmila's torque",		--5
		ring1="Kishar ring",			--4
		ring2="Weatherspoon Ring",		--5
		waist="Witful Belt",			--3 
		back="Moonlight Cape",			-->69 + 15 (trait) 80
		}
        
    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {})
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear1="Mendicant's earring"})--5fc

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Falcon eye",
        head="Dampening tam",neck="Fotia gorget",ear1="Moonshade earring",ear2="Brutal earring",
        body="Assimilator's Jubbah +3",hands="Adhemar Wristbands +1",ring1="Hetairoi Ring",ring2="Epona's Ring",
        back=RosmertaCrit,waist="Fotia belt",legs="Samnuha tights",feet=HercBootsDmg}
    	
	sets.precast.WS.Acc50 = {ammo="Falcon eye",
        head="Dampening tam",neck="Fotia gorget",ear1="Moonshade earring",ear2="Brutal earring",
        body="Assimilator's Jubbah +3",hands="Adhemar Wristbands +1",ring1="Ilabrat Ring",ring2="Epona's Ring",
        back=RosmertaCrit,waist="Fotia belt",legs=HercLegsAcc,feet=HercBootsDmg}

	sets.precast.WS.Acc100 = {ammo="Falcon eye",
        head="Dampening tam",neck="Fotia gorget",ear1="Moonshade earring",ear2="Telos earring",
        body="Assimilator's Jubbah +3",hands="Adhemar Wristbands +1",ring1="Ilabrat Ring",ring2="Cacoethic Ring +1",
        back=RosmertaCrit,waist="Fotia belt",legs=HercLegsAcc,feet=HercBootsDmg}	
		
	sets.precast.WS.Acc150 = {ammo="Falcon eye",
        head="Dampening tam",neck="Fotia gorget",ear1="Dignitary's Earring",ear2="Telos earring",
        body="Assimilator's Jubbah +3",hands="Adhemar Wristbands +1",ring1="Ilabrat Ring",ring2="Chirich Ring",
        back=RosmertaCrit,waist="Fotia belt",legs="Carmine Cuisses +1",feet=HercBootsDmg}
		
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {head="Adhemar Bonnet +1",body="Abnoba kaftan",feet="Thereoid Greaves",ear2="Telos earring",ring1="Ilabrat Ring"})
	sets.precast.WS['Chant du Cygne'].Acc50 = set_combine(sets.precast.WS.Acc50, {head="Adhemar Bonnet +1",body="Assimilator's Jubbah +3",ear2="Telos earring",ring1="Ilabrat Ring"})
	sets.precast.WS['Chant du Cygne'].Acc100 = set_combine(sets.precast.WS.Acc100, {head="Adhemar Bonnet +1",body="Assimilator's Jubbah +3",ring2="Ilabrat Ring"})--ring switch, its fine
	sets.precast.WS['Chant du Cygne'].Acc150 = set_combine(sets.precast.WS.Acc150, {body="Assimilator's Jubbah +3",ring2="Ilabrat Ring"})
	sets.precast.WS['Chant du Cygne'].Defending = set_combine(sets.precast.WS['Chant du Cygne'], {ring1="Defending Ring",ring2="Epona's Ring"})
	
	sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS, {ammo="Falcon Eye",
		head="Jhakri Coronal +2",body="Assimilator's Jubbah +3",hands="Jhakri Cuffs +2",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",left_ear="Moonshade Earring",right_ear="Ishvara Earring",left_ring="Apate Ring",right_ring="Ilabrat Ring",back=RosmertaWSD})
	sets.precast.WS['Expiacion'].Acc50 = sets.precast.WS['Expiacion']
	sets.precast.WS['Expiacion'].Acc100 = sets.precast.WS['Expiacion']
	sets.precast.WS['Expiacion'].Acc150 = set_combine(sets.precast.WS.Acc150, {head="Jhakri Coronal +2",hands="Jhakri Cuffs +2",back=RosmertaWSD}) 
	
	sets.precast.WS['Savage Blade'] = sets.precast.WS['Expiacion']
	sets.precast.WS['Savage Blade'].Acc50 = sets.precast.WS['Expiacion'].Acc50 
	sets.precast.WS['Savage Blade'].Acc100 = sets.precast.WS['Expiacion'].Acc100 
	sets.precast.WS['Savage Blade'].Acc150 = sets.precast.WS['Expiacion'].Acc150 
	
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
		ammo="Ginsen",body="Assimilator's Jubbah +3",hands="Jhakri Cuffs +2",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2",ear1="Regal Earring"})
	sets.precast.WS['Requiescat'].Acc50 = set_combine(sets.precast.WS['Requiescat'], {})
	sets.precast.WS['Requiescat'].Acc100 = set_combine(sets.precast.WS['Requiescat'], {})
	sets.precast.WS['Requiescat'].Acc150 = sets.precast.WS.Acc150 

    sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",body="Jhakri Robe +2",hands="Jhakri Cuffs +2",legs="Amalric Slops +1",feet="Jhakri Pigaches +2",
        neck="Fotia gorget",ear1="Friomisi Earring",ear2="Regal Earring",ring1="Acumen Ring",ring2="Archon Ring",
        back="Cornflower Cape",waist="Fotia belt"}
		
	--sets.precast.WS['Red Lotus Blade'] = set_combine(sets.precast.WS['Sanguine Blade'], {head=HercHelmMAB})	
    sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS['Sanguine Blade'], {head=HercHelmMAB,ring2="Weatherspoon ring"})
	--sets.precast.WS['Seraph Blade'] = sets.precast.WS['Flash Nova']
	
	sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Chant du Cygne']
	
    sets.precast.WS['Judgment'] = sets.precast.WS['Expiacion']
	sets.precast.WS['Judgment'].Acc50 = sets.precast.WS['Expiacion'].Acc50 
	sets.precast.WS['Judgment'].Acc100 = sets.precast.WS['Expiacion'].Acc100 
	sets.precast.WS['Judgment'].Acc150 = sets.precast.WS['Expiacion'].Acc150 
	
    sets.precast.WS['Black Helo'] = sets.precast.WS['Expiacion']
	sets.precast.WS['Black Helo'].Acc50 = sets.precast.WS['Expiacion'].Acc50 
	sets.precast.WS['Black Helo'].Acc100 = sets.precast.WS['Expiacion'].Acc100 
	sets.precast.WS['Black Helo'].Acc150 = sets.precast.WS['Expiacion'].Acc150 
	
    -- Midcast Sets
	 --Fastcast with spell interrupt down
    sets.midcast.FastRecast = {amm="Sapience Orb",ear1="Etiolation Earring",ear2="Loquacious Earring",ring1="Kishar Ring",waist="Witful Belt"}
        
    sets.midcast['Blue Magic'] = {}
    
    -- Physical Spells --
    
    sets.midcast['Blue Magic'].Physical = {ammo="Falcon eye",
        head="Carmine Mask",neck="Sanctity necklace",ear1="Dignitary's earring",ear2="Regal earring",
        body="Assimilator's Jubbah +3",hands="Leyline Gloves",ring1="Apate Ring",ring2="Weatherspoon ring",
        back="Cornflower cape",waist="Latria sash",legs="Carmine Cuisses +1",feet="Jhakri Pigaches +2"}

    sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical,{ammo="Falcon eye",
		head="Carmine Mask",body="Assimilator's Jubbah +3",hands="Jhakri Cuffs +2",
		legs="Ayanmo Cosciales +2",feet=HercBootsDmg,
		ear1="Dignitary's earring",ear2="Regal earring",
		ring1="Stikini Ring +1",ring2="Weatherspoon Ring",
		back=RosmertaCrit,waist="Eschan Stone"})
    sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical,{neck="Sanctity Necklace",ring2="Apate ring"})
    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical,{neck="Sanctity Necklace",ring2="Ilabrat ring"})
    sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical,{})
    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical,{ring2="Ilabrat ring"})
    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical,{})		
    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical,{})		
    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical,{})
    sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical)
    sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].PhysicalAcc,{})   

    -- Magical Spells --
    
    sets.midcast['Blue Magic'].Magical = {ammo="Pemphredo Tathlum",
        head=HercHelmMAB,
		body="Amalric Doublet +1",
		hands="Amalric Gages +1",
		legs="Amalric Slops +1",
		feet="Amalric Nails +1",
		neck="Sanctity necklace",
		ear1="Friomisi Earring",ear2="Regal Earring",
		ring1="Acumen Ring",ring2="Locus Ring",
        back="Cornflower Cape",waist="Eschan stone"}
		
    sets.magic_burst = {feet="Jhakri Pigaches +2",ring1="Mujin band",ring2="Locus Ring",back="Seshaw cape"}
	
		
    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,{})    
    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical,{})
    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical,{})
    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical,{})
    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical,{})
	
    sets.midcast['Blue Magic'].MagicAccuracy = set_combine(sets.midcast['Blue Magic'].Magical,{ammo="Pemphredo Tathlum",
		head="Carmine Mask",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		ear1="Dignitary's earring",
		ring1="Stikini Ring +1",ring2="Weatherspoon ring",
		back="Cornflower Cape",waist="Eschan Stone"})
	
	sets.midcast['Blue Magic']['Subduction'] = set_combine(sets.midcast['Blue Magic'].Magical,{head="Jhakri Coronal +2"})
	
	sets.midcast['Blue Magic'].MagicDark = set_combine(sets.midcast['Blue Magic'].Magical,{head="Pixie Hairpin +1",ring2="Archon Ring"})
	sets.midcast['Blue Magic'].MagicLight = set_combine(sets.midcast['Blue Magic'].Magical,{ring2="Weatherspoon ring"})
    sets.midcast['Blue Magic'].Breath = set_combine(sets.midcast.FastRecast,{})
	
	sets.midcast.Cure = set_combine(sets.midcast.FastRecast,{
		head="carmine mask",neck="Incanter's Torque",ear1="Mendicant's earring",ear2="Etiolation earring",--5
        body="Pinga Tunic +1",hands="Telchine Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",--15	10				
        legs="Pinga Pants +1",feet="medium's sabots"})--13+12 = 55
		
    sets.midcast['Blue Magic']['White Wind'] = set_combine(sets.midcast.Cure,{
        head="Telchine Cap",
		neck="Phalaina Locket",
		left_ear="Odnowa Earring +1",right_ear="Odnowa Earring",
		ring1="Kunaji Ring",ring2="Ilabrat Ring",
		back="Moonlight Cape",waist="Gishdubar sash"})

    sets.midcast['Blue Magic'].Healing = sets.midcast.Cure

    sets.midcast['Blue Magic'].SkillBasedBuff = set_combine(sets.midcast.FastRecast,{
        neck="Incanter's torque",
		--body="Hashishin Mintan",legs="Ayanmo Cosciales +2",
		body="Assimilator's Jubbah +3",
		ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Cornflower Cape",legs="Hashishin Tayt +1",feet="Luhlaza Charuqs"
		})

    sets.midcast['Blue Magic'].Buff = set_combine(sets.midcast.FastRecast,{})
    
		
    sets.midcast.self_healing = set_combine(sets.midcast.Cure,{
		ammo="Staunch Tathlum +1",
		head="Telchine Cap", 		--6
		hands="Telchine Gloves",	--5
		neck="Phalaina Locket",		--4
		waist="Gishdubar Sash",		--10
		left_ear="Odnowa Earring +1",
		right_ear="Odnowa Earring",
		left_ring="Defending Ring",
		right_ring="Kunaji Ring",	--5
		back="Moonlight Cape",})		--30	
	
	sets.midcast['Diaga']={head="White Rarab Cap +1",body=HercVestTH,hands=HercGlovesTH,waist="Chaac belt"}
	sets.midcast['Dia II']=sets.midcast['Diaga']
	sets.midcast['Flash']=sets.midcast['Diaga']
	sets.midcast['Bio']=sets.midcast['Diaga']
	sets.midcast['Glutinous Dart']=set_combine(sets.midcast['Blue Magic'].MagicAccuracy, sets.midcast['Diaga'])
	sets.precast['Provoke'] = sets.midcast['Diaga']
	sets.precast['Diaga'] = sets.midcast['Diaga']
	
	sets.midcast['Elemental Magic']= sets.midcast['Blue Magic'].Magical
	
	sets.midcast['Enhancing Magic'] = {
        head="Telchine cap",neck="Incanter's torque",
        body="Telchine Chasuble",hands="Telchine Gloves",legs="Telchine braconi",feet="Telchine pigaches",
		ring1="Stikini Ring +1",ring2="Stikini Ring +1",waist="Olympus Sash"}

	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {head=HercHelmPhalanx,body=HercVestPhalanx})	
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],{head="Amalric Coif +1",waist="Gishdubar sash"})
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],{head="Amalric Coif +1"})
	sets.midcast['Battery Charge'] = sets.midcast.Refresh
	sets.midcast['Carcharian Verve'] = sets.midcast.Aquaveil
	
    sets.midcast.Protect = {ear1="Brachyura earring"}
    sets.midcast.Protectra = {ear1="Brachyura earring"}
    sets.midcast.Shell = {ear1="Brachyura earring"}
    sets.midcast.Shellra = {ear1="Brachyura earring"}
    

    
    
    -- Sets to return to when not performing an action.





    -- Resting sets
    sets.resting = {}
    
    -- Idle sets
    sets.idle = {ammo="Staunch Tathlum +1",
        head="rawhide mask",neck="Sanctity Necklace",ear1="Hearty Earring",ear2="Etiolation Earring",
        body="Assimilator's Jubbah +3",hands=HercGlovesDT,ring1="Defending Ring",ring2="Stikini Ring +1",
        back="Moonlight Cape",waist="Flume Belt +1",legs="Carmine Cuisses +1",feet=HercBootsRefresh}

    sets.idle.PDT = {ammo="Staunch Tathlum +1",
        head=HercHelmDT,neck="Sanctity Necklace",ear1="Hearty Earring",ear2="Odnowa Earring +1",
        body="Ayanmo Corazza +2",hands=HercGlovesDT,ring1="Defending Ring",ring2="Stikini Ring +1",
        back="Moonlight Cape",waist="Flume Belt +1",legs="Ayanmo Cosciales +2",feet=HercBootsDT}
	
	sets.idle.Refresh = {
        head="rawhide mask",neck="Sanctity Necklace",ear1="Hearty Earring",ear2="Odnowa Earring +1",
        body="Assimilator's Jubbah +3",hands=HercGlovesDT,ring1="Defending Ring",ring2="Stikini Ring +1",
        back="Moonlight Cape",waist="fucho-no-obi",legs="Carmine Cuisses +1",feet=HercBootsRefresh}

--    sets.idle.Town = {main="Buramenk'ah",ammo="Sapience Orb",
--        head="Mavi Kavuk +2",neck="Sanctity Necklace",ear1="Bloodgem Earring",ear2="Loquacious Earring",
--        body="Luhlaza Jubbah",hands="Assimilator's Bazubands +1",ring1="Defending Ring",ring2="Shneddick ring",
--        back="Lupine cape",waist="Flume Belt +1",feet="Luhlaza Charuqs"}


    
    -- Defense sets
    sets.defense.PDT = {
		ammo="Staunch Tathlum +1",		--3 3
        head=HercHelmDT,				--4 4   meva 	59
        body="Ayanmo Corazza +2",		--6 6			64
		hands=HercGlovesDT,				--5 3			43
		legs="Samnuha Tights",			--				75
		feet=HercBootsDT,				--6 4			75
		neck="Loricate torque +1",		--6 6
		ear1="Suppanomimi",				--				
		ear2="Eabani earring",			--				8
		ring1="Defending Ring",			--10 10
		ring2="Ilabrat Ring",
		back="Moonlight Cape",			--6 6
		waist="Flume Belt +1",			--4			
		}								--50pdt 44mdt	324meva


	sets.defense.Meva ={ammo="Staunch Tathlum +1",	
		head="Pinga Crown +1",--						109
		body="Pinga Tunic +1",--						128
		hands="Raetic Bangles",--						90
		legs="Pinga Pants +1",--						147
		feet="Pinga Pumps +1",			--				147
		neck="Loricate Torque +1",
		waist="Kentarch Belt +1",
		left_ear="Telos Earring",		
		right_ear="Eabani earring",	--					8
		left_ring="Defending Ring",
		right_ring="Purity Ring",		--				10
		back=RosmertaSTP,
	}									--				639meva
    sets.Kiting = {legs="Carmine Cuisses +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Ginsen",
        head="Adhemar Bonnet +1",body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",legs="Samnuha Tights",feet=HercBootsTA,
		neck="Ainia collar",waist="Kentarch Belt +1",ear1="Brutal Earring",ear2="Telos Earring",
        ring1="Hetairoi Ring",ring2="Epona's Ring",back=RosmertaSTP,}
	sets.DualWield = set_combine(sets.engaged,{
		feet=HercBootsDW,ear1="Suppanomimi",ear2="Eabani earring",waist="Reiki Yotai",})
		
	sets.engaged.Acc50 = {ammo="Falcon Eye",	
		head="Adhemar Bonnet +1",body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",legs="Samnuha Tights", feet=HercBootsTA,
		neck="Combatant's Torque",waist="Kentarch Belt +1",ear1="Brutal Earring",ear2="Telos Earring",
		left_ring="Ilabrat Ring",right_ring="Epona's Ring",back=RosmertaSTP, }
	sets.DualWield.Acc50 = set_combine(sets.engaged.Acc50,{
		feet=HercBootsDW,ear1="Suppanomimi",ear2="Telos earring",waist="Reiki Yotai",})

	sets.engaged.Acc100 = {ammo="Falcon Eye",
		head="Adhemar Bonnet +1",body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",legs="Carmine Cuisses +1", feet=HercBootsDmg,
		neck="Combatant's Torque",waist="Kentarch Belt +1",ear1="Brutal Earring",ear2="Telos Earring",
		left_ring="Ilabrat Ring",right_ring="Epona's Ring",back=RosmertaSTP, }
	sets.DualWield.Acc100 = set_combine(sets.engaged.Acc100,{
		feet=HercBootsDW,ear1="Suppanomimi",ear2="Telos earring",waist="Reiki Yotai",})
		
	sets.engaged.Acc150 = {ammo="Falcon Eye",
		head="Dampening Tam",body="Assimilator's Jubbah +3",hands="Adhemar Wristbands +1",legs="Carmine Cuisses +1", feet=HercBootsDmg,
		neck="Combatant's Torque",waist="Kentarch Belt +1",left_ear="Dignitary's Earring",right_ear="Telos earring",
		left_ring="Ilabrat Ring",right_ring="Cacoethic Ring +1",back=RosmertaSTP,}
	sets.DualWield.Acc150 = set_combine(sets.engaged.Acc150,{})
	
    sets.engaged.Refresh = {ammo="Ginsen",
        head="rawhide mask",neck="Sanctity necklace",ear1="Suppanomimi",ear2="Eabani earring",
        body="Assimilator's Jubbah +3",hands="Adhemar Wristbands +1",ring1="Hetairoi Ring",ring2="Epona's Ring",
        back=RosmertaSTP,waist="fucho-no-obi",legs="Lengo Pants",feet=HercBootsRefresh}

		
	sets.engaged.PDT = sets.defense.PDT		--51pdt 31mdt	
	sets.engaged.Acc50.PDT = set_combine(sets.engaged.PDT, {ear1="Telos earring",right_ring="Ilabrat Ring",back=RosmertaSTP})
	sets.engaged.Acc100.PDT = set_combine(sets.engaged.PDT, {ear1="Telos earring",right_ring="Ilabrat Ring",back=RosmertaSTP})
	sets.engaged.Acc150.PDT = set_combine(sets.engaged.PDT, {ammo="Falcon eye",ear1="Telos earring",right_ring="Ilabrat Ring",back=RosmertaSTP})
	sets.engaged.Refresh.PDT = set_combine(sets.engaged.PDT, {waist="Fucho-no-obi"})
		
	sets.engaged.Meva = sets.defense.Meva
	sets.engaged.Acc50.Meva = set_combine(sets.defense.Meva, {back=RosmertaSTP})
	sets.engaged.Acc100.Meva = set_combine(sets.defense.Meva, {back=RosmertaSTP})
	sets.engaged.Acc150.Meva = set_combine(sets.defense.Meva, {back=RosmertaSTP})
	sets.engaged.Refresh.Meva = sets.defense.Meva
	
	sets.latent_refresh = {waist="Fucho-no-obi"}	
    sets.buff.Doom = {ring1="Eshmun's Ring",ring2="Eshmun's Ring",waist="Gishdubar sash"}
	--ring2="Purity Ring",waist="Gishdubar sash"}
	
	sets.precast.JA['Lunge'] = sets.midcast['Blue Magic'].Magical
	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
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

function change_midcast(spell, action, spellMap, eventArgs)

end
	
function job_precast(spell, action, spellMap, eventArgs)
	if buffactive['Terror'] or buffactive['Stun'] or buffactive['Petrification'] then
            eventArgs.cancel = true
			equip(sets.engaged.PDT)
			add_to_chat(122, "Unable to act, action cancelled")
            return	
	end
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
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

	
function job_post_precast(spell, action, spellMap, eventArgs)
	
	if spell.en == "Subduction" then
		equip(sets.midcast['Blue Magic'].Magical)
	end
	if spell.en == 'Expiacion' or spell.en == 'Savage Blade' then
		if player.tp > 2999 then
			equip({ear1="Telos Earring"})		
		end
	elseif spell.en == 'Chant du Cygne' then
		if player.tp > 2999 then
			equip({ear1="Brutal Earring"})		
		end
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	equipSet={}
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
    elseif spell.skill == 'Blue Magic' and state.Buff.Diffusion then
        equip(sets.buff.Diffusion) 
	elseif spell.skill == 'Blue Magic' and spell.en ~= 'Mighty Guard' then
		if spell.en == 'White Wind' then
			equip(sets.midcast.self_healing)
		elseif spellMap:startswith('Magic') then
			if spell.element == world.day_element or spell.element == world.weather_element then
				if state.MagicBurst.value then
					equipSet=set_combine(equipSet,sets.magic_burst)			
					equipSet = set_combine(equipSet, {waist="Hachirin-No-Obi"})
					equip(equipSet)
					add_to_chat(122, "Weather Magic Burst")
				else 
					equipSet = set_combine(equipSet, {waist="Hachirin-No-Obi"})
					equip(equipSet)
					add_to_chat(122, "Weather Nuke")
				end
			elseif state.MagicBurst.value then
				equipSet=set_combine(equipSet,sets.magic_burst)		
				equip(equipSet)
				add_to_chat(122, "Magic Burst")
			end	
		end
	elseif spell.skill == 'Enhancing Magic' then		
		if spell.en == 'Aquaveil' then
			equip(sets.midcast.Aquaveil)
		elseif spell.en == 'Refresh' then
			equip(sets.midcast.Refresh)
		elseif spell.en == 'Phalanx' then
			equip(sets.midcast.Phalanx)
		else equip(sets.midcast['Enhancing Magic'])
		end
    elseif spell.skill == 'Elemental Magic' then
		equip(sets.midcast['Blue Magic'].Magical)
	end
end

function job_aftercast(spell, action, spellMap, eventArgs)
	customize_melee_set(meleeSet)  
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
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
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)	
    if player.mpp < 51 then
		state.IdleMode:set("Refresh")
	else 
		state.IdleMode:reset()
    end
    return idleSet
end


function customize_melee_set(meleeSet)   
--	if state.CombatForm.current == 'Haste' then
	--if buffactive['Haste'] then
	-- if HasteTotal > 39 then	
        -- --if buffactive['Mighty Guard'] and 
		-- if state.HybridMode.value == 'Normal' then
			-- if state.OffenseMode.current == 'Acc50' then
				-- meleeSet = set_combine(meleeSet, sets.MightyGuard.Acc50)
			-- elseif state.OffenseMode.current == 'Acc100' then
				-- meleeSet = set_combine(meleeSet, sets.MightyGuard.Acc100)
			-- elseif state.OffenseMode.current == 'Acc150' then
				-- meleeSet = set_combine(meleeSet, sets.MightyGuard.Acc150)
			-- else	
				-- meleeSet = set_combine(meleeSet, sets.MightyGuard)
			-- end	
		
		-- else
			-- state.CombatForm:reset()	
		-- end	
    -- end
	if state.DualWield.value and state.HybridMode.value == 'Normal' then	
		if state.OffenseMode.current == 'Acc50' then
			meleeSet = set_combine(meleeSet, sets.DualWield.Acc50)
		elseif state.OffenseMode.current == 'Acc100' then
			meleeSet = set_combine(meleeSet, sets.DualWield.Acc100)
		elseif state.OffenseMode.current == 'Acc150' then
			meleeSet = set_combine(meleeSet, sets.DualWield.Acc150)
		else	
			meleeSet = set_combine(meleeSet, sets.DualWield)
		end	
	end	
	if state.RaeticMode.value then
		meleeSet = set_combine(meleeSet, {hands="Raetic Bangles"})
	end
	return meleeSet
end


function job_buff_change(buff, gain)
	-- if buff == "Haste" and gain then
		-- HasteTotal = HasteTotal + 30
	-- elseif buff == "Haste" and not gain then
		-- HasteTotal = HasteTotal - 30
	-- end
	-- if buff == "March" and gain then
		-- HasteTotal = HasteTotal + 10
	-- elseif buff == "March" and not gain then
		-- HasteTotal = HasteTotal - 10
	-- end	
	-- if buff == "Mighty Guard" and gain then
		-- HasteTotal = HasteTotal + 15
	-- elseif buff == "Mighty Guard" and not gain then
		-- HasteTotal = HasteTotal - 15
	-- end
	-- if buff == "Embrava" and gain then
		-- HasteTotal = HasteTotal + 25
	-- elseif buff == "Embrava" and not gain then
		-- HasteTotal = HasteTotal - 25
	-- end
	-- if buff == "Slow" and gain then
		-- HasteTotal = HasteTotal - 30
	-- elseif buff == "Slow" and not gain then
		-- HasteTotal = HasteTotal + 30
	-- end
	
	-- if HasteTotal > 39 then
		-- if state.HybridMode.value == 'Normal' then
			-- if state.OffenseMode.current == 'Acc50' then
				-- meleeSet = set_combine(meleeSet, sets.MightyGuard.Acc50)
			-- elseif state.OffenseMode.current == 'Acc100' then
				-- meleeSet = set_combine(meleeSet, sets.MightyGuard.Acc100)
			-- elseif state.OffenseMode.current == 'Acc150' then
				-- meleeSet = set_combine(meleeSet, sets.MightyGuard.Acc150)
			-- else	
				-- meleeSet = set_combine(meleeSet, sets.MightyGuard)
			-- end	
			-- engagedcheck = windower.ffxi.get_player()
			-- if engagedcheck.status == 1 then
				-- equip(meleeSet)
			-- end	
		-- else
			-- state.CombatForm:reset()	
		-- end	
	-- elseif HasteTotal < 40 then
	-- --	add_to_chat(122, HasteTotal)
		-- state.CombatForm:reset()	
	-- end	
	if state.HybridMode.value == "Normal" then
		if string.lower(buff) == "slow" and gain and not state.DualWield.value then
			send_command('gs c toggle DualWield')
		elseif string.lower(buff) == "slow" and state.DualWield.value and not gain then
			send_command('gs c toggle DualWield')
		end
	end
	if buffactive['Stun'] or buffactive['Petrification'] or buffactive['Terror'] then
		equip(sets.engaged.PDT)
		add_to_chat(122, "TP set to PDT")
	end
	if string.lower(buff) == "doom" then
		if gain then
			equip(sets.buff.Doom)
			disable('ring1','ring2','waist')		
			add_to_chat(122, "DOOOOOOM")
		else
			enable('ring1','ring2','waist')
		end
	end
--	if buffactive['Haste'] then
--        if buffactive['Mighty Guard'] and state.HybridMode.value == 'Normal' then
--            state.CombatForm:set("Haste")
--		else
--			state.CombatForm:reset()	
--		end
 --   end
--	customize_melee_set()   
end	
--function job_buff_change(buff, loss)
--	if buff == "Haste" then
--		add_to_chat(122, "haste lost")
--	end
--end	
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'RUN' then
        set_macro_page(2, 9)    
    elseif player.sub_job == 'RDM' then
        set_macro_page(3, 9)
    else
        set_macro_page(1, 9)
    end
end



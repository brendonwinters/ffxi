--[[   

--]]
--
-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	--   include('organizer-lib')
end


-- Setup vars that are user-independent.
function job_setup()
	state.Buff.Doom = buffactive.Doom or false
	state.Buff.Souleater = buffactive.souleater or false
	state.Buff['Last Resort'] = buffactive['Last Resort'] or false
	-- Set the default to false if you'd rather SE always stay acitve

	-- Greatswords you use. 
	gsList = S{'Ragnarok','Caladbolg'}
	-- Offhand weapons used to activate DW mode
	drk_sub_weapons = S{"Sangarius", "tramontane axe"}
	
	drain_timer = ''
	drain_duration = 218
    absorb_timer = ''
    absorb_duration = 218
	
	xStepWS = 0

	get_combat_form()
	get_combat_weapon()
	update_melee_groups()
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal','Acc25','Acc100','Acc200')

	state.HybridMode:options('Normal','PDT','Meva')
	state.WeaponskillMode:options('Normal','Acc25','Acc100','Acc200')
	state.CastingMode:options('Normal', 'MAcc')
	state.IdleMode:options('Normal')
	state.RestingMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT', 'Reraise')
	state.MagicalDefenseMode:options('MDT')

	state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'Knockback', 'Meva', 'Terror', 'Charm'}
	state.SkillchainMode = M{['description']='Skillchain', 'None', '2Step', '3Step', '4Step', '5Step'}
	state.RaeticMode = M(false, 'Raetic Mode')

	-- Additional local binds
	send_command('bind ^` gs c toggle RaeticMode')
	send_command('bind !` gs c cycle SkillchainMode')
	send_command('bind @` gs c cycle ExtraDefenseMode')

	select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
	send_command('unbind ^`')
	send_command('unbind @`')
	send_command('unbind !`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
--------------------------------------
-- Start defining the sets
--------------------------------------
-- Augmented gear

	include('Flannelman_aug-gear.lua')

    AnkouWSD={ name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}
    AnkouDA={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
    AnkouDEX={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+6','"Dbl.Atk."+10',}}

	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA['Diabolic Eye'] = {hands="Fallen's Finger Gauntlets"}--increases duration 6s/merit
	sets.precast.JA['Nether Void'] = {legs="Heathen's Flanchard"}--increaes drained by 30% equip on ja
	sets.precast.JA['Dark Seal'] = {}--head="Fallen's Burgonet"}--increases duration of abs 10% per merit only needs equip during midcast
	sets.precast.JA['Souleater'] = {head="Ignominy Burgonet +2"}
	sets.precast.JA['Blood Weapon'] = {body="Fallen's Cuirass"}
	sets.precast.JA['Weapon Bash'] = {hands="Ignominy Gauntlets +2"}
	sets.precast.JA['Last Resort'] = {back="Ankou's Mantle"}
	sets.precast.JA['Arcane Circle'] = {feet="Ignominy Sollerets +2"}
	sets.precast.JA['Lunge'] = set_combine(sets.midcast['Elemental Magic'], {head="Pixie Hairpin +1",ring2="Archon Ring"})

	sets.Berserker       = { neck="Berserker's Torque" }
	--sets.WSDayBonus      = { head="Gavialis Helm" }
	--sets.WSBack          = { back="Trepidity Mantle" }
	-- TP ears for night and day, AM3 up and down. 
	sets.BrutalLugra     = { ear1="Lugra Earring", ear2="Lugra Earring +1" }
	sets.BrutalIshvara	 = { ear1="Brutal Earring", ear2="Ishvara Earring" }
	sets.Lugra           = { ear1="Lugra Earring +1" }
	sets.Brutal          = { ear1="Brutal Earring" }

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Fast cast sets for spells
	sets.precast.FC = {ammo="Sapience Orb",--2
		head="Carmine Mask",				--12
		body=OdysseanChestFC,				--9
		hands="Leyline Gloves",				--8
		legs="Eschite cuisses", 			--5
		feet=OdysseanGreavesFC,				--9
		neck="Orunmila's Torque",			--5
		ear1="Etiolation Earring",			--1
		ear1="Loquacious Earring",			--2
		ring1="Weatherspoon ring",			--5
		ring2="Kishar Ring",				--4
	}										--> 62


	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="jumalik mail",ear1="Mendicant's earring"})
	-- Midcast Sets
	sets.midcast.FastRecast = {ammo="Staunch Tathlum +1",	--10
--		body="Eschite breastplate",					--15
--		hands="Eschite gauntlets",					--15
		ring2="Evanescence ring",					--5
		legs="Founder's hose",						--30
		feet=OdysseanGreavesFC						--20 -> 95
	}



	sets.midcast['Enfeebling Magic'] = {ammo="Pemphredo Tathlum",
		head="Carmine Mask",			--macc38 enf10
		body="Carmine Scale Mail",		--macc28
		hands="Raetic Bangles",
		legs=OdysseanCuissesSTP,			--macc40		
		feet="Ignominy Sollerets +2",			--macc42
		neck="Incanter's torque",		
		ear1="Gwati Earring", 		--macc8
		ear2="Dignitary's Earring",--macc10
		ring1="Regal Ring", 
		ring2="Weatherspoon Ring",
		waist="Eschan Stone",
		back="Toro cape",				
	}
	sets.midcast['Enfeebling Magic'].MAcc = sets.midcast['Enfeebling Magic']

	sets.midcast['Elemental Magic'] = {ammo="Pemphredo Tathlum",
		head="jumalik helm",
		body="founder's breastplate",	
		hands="Leyline gloves",		
		legs="Eschite cuisses", 
		feet="Ignominy Sollerets +2",	
		neck="sanctity necklace",
		ear1="Hecate's Earring",
		ear2="friomisi Earring",
		ring1="Acumen Ring",
		ring2="Metamorph Ring +1",
		back="Toro Cape",
		waist="Eschan stone",
	}

	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak",ring2="Archon Ring"})


	sets.midcast['Dark Magic'] = {ammo="Pemphredo Tathlum",
		head="Ignominy Burgonet +2", 	--22	
		neck="Erra Pendant",			--  10
		body="Carmine Scale Mail",			--15
		hands="Fallen's Finger Gauntlets", -- 14
		legs="Eschite cuisses", 		-- 20
		feet="Ratri Sollerets",
		ear1="Dignitary's Earring",
		ear2="gwati earring",
		ring1="Evanescence Ring",--10
		ring2="Archon Ring",
		waist="Eschan stone",
		back="niht mantle",				--  5
	}
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		ring1="Kishar Ring",})
	sets.midcast.Drain.MAcc = set_combine(sets.midcast.Drain, {
		head="Carmine Mask",
		hands="Raetic Bangles",
		legs="Ratri Cuirass",
		ring2="Stikini Ring +1",})	
	sets.midcast['Drain III'] = set_combine(sets.midcast.Drain, {})
	sets.midcast['Drain III'].Macc = sets.midcast.Drain.MAcc
	sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.MAcc = sets.midcast.Drain.MAcc

	sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {
		--head="carmine mask",
		hands="Raetic Bangles",
		legs="Ratri Cuirass",
		ring1="Kishar Ring",
		ring2="Stikini Ring +1",
		back="Ankou's Mantle",
--		back="Chuparrosa mantle"
	})
	sets.midcast.Absorb.MAcc = sets.midcast.Absorb
	
	sets.midcast['Absorb-TP'] = set_combine(sets.midcast.Absorb, {
		--hands="Heathen's Gauntlets"
	})
	sets.midcast['Absorb-STR'] = sets.midcast.Absorb
	sets.midcast['Absorb-DEX'] = sets.midcast.Absorb
	sets.midcast['Absorb-VIT'] = sets.midcast.Absorb
	sets.midcast['Absorb-AGI'] = sets.midcast.Absorb
	sets.midcast['Absorb-INT'] = sets.midcast.Absorb
	sets.midcast['Absorb-MND'] = sets.midcast.Absorb
	sets.midcast['Absorb-CHR'] = sets.midcast.Absorb
	sets.midcast['Absorb-Attri'] = sets.midcast.Absorb
	sets.midcast['Absorb-ACC'] = sets.midcast.Absorb
	sets.midcast['Absorb-STR'].MAcc = sets.midcast.Absorb.MAcc
	sets.midcast['Absorb-DEX'].MAcc = sets.midcast.Absorb.MAcc
	sets.midcast['Absorb-VIT'].MAcc = sets.midcast.Absorb.MAcc
	sets.midcast['Absorb-AGI'].MAcc = sets.midcast.Absorb.MAcc
	sets.midcast['Absorb-INT'].MAcc = sets.midcast.Absorb.MAcc
	sets.midcast['Absorb-MND'].MAcc = sets.midcast.Absorb.MAcc
	sets.midcast['Absorb-CHR'].MAcc = sets.midcast.Absorb.MAcc
	sets.midcast['Absorb-Attri'].MAcc = sets.midcast.Absorb.MAcc
	sets.midcast['Absorb-ACC'].MAcc = sets.midcast.Absorb.MAcc

	sets.midcast['Dread Spikes'] = {
		head="Odyssean Helm", 
		body="Ratri Breastplate", 
		hands="Raetic Bangles",
		legs="Eschite Cuisses",
		feet="Ratri Sollerets",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back="Moonlight Cape",}


	sets.midcast.Cure = {		
		neck="Incanter's torque",ear1="Mendicant's Earring",
		body="Jumalik mail",hands="Macabre gauntlets +1",ring1="kunaji ring",ring2="Stikini Ring +1",
		back="Solemnity cape",feet=OdysseanGreavesFC}
	
	sets.midcast['Stone'] = {head="White Rarab Cap +1",hands=THhands, feet=THfeet, waist="Chaac Belt"}

	-- WEAPONSKILL SETS
	-- General sets
	sets.precast.WS = {ammo="Seething Bomblet +1",
		head=ValorousMaskWSD,
		body="Ignominy Cuirass +3",
		hands=OdysseanGauntletsWSD,
		legs="Ignominy Flanchard +3",
		feet="Sulevia's Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Telos Earring",
		right_ear="Moonshade Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back=AnkouDA,}
	sets.precast.WS.Acc25 = set_combine(sets.precast.WS, {})
	sets.precast.WS.Acc100 = set_combine(sets.precast.WS, {})
	sets.precast.WS.Acc200 = set_combine(sets.precast.WS.Acc100, {  ammo="Seething Bomblet +1",  
		head="Ignominy Burgonet +2", 
		hands="Flamma Manopolas +2",
		feet="Flamma Gambieras +2",
		left_ear="Telos Earring",
		right_ear="Dignitary's Earring",
		back=AnkouDEX
	})

	-- RESOLUTION
	-- 86-100% STR
	sets.precast.WS.Resolution =  set_combine(sets.precast.WS, {ammo="Seething Bomblet +1",
		head="Flamma Zucchetto +2", 
		body="Argosy Hauberk +1",
		hands="Argosy Mufflers +1",
		legs="Ignominy Flanchard +3",
		feet="Flamma Gambieras +2",})
	sets.precast.WS.Resolution.Acc25 = set_combine(sets.precast.WS.Resolution, {}) 
	sets.precast.WS.Resolution.Acc100 = set_combine(sets.precast.WS.Resolution, {}) 
	sets.precast.WS.Resolution.Acc200 = set_combine(sets.precast.WS.Acc200, {hands="Argosy Mufflers +1",back=AnkouDEX}) 

	-- TORCLEAVER 
	-- VIT 80%
	sets.precast.WS.Torcleaver = set_combine(sets.precast.WS, {ammo="Knobkierrie",
		head=OdysseanHelmWSD,
		body="Ignominy Cuirass +3",
		hands=OdysseanGauntletsWSD,
		legs=ValorousHoseWSD,
		feet="Sulevia's Leggings +2",
		back=AnkouWSD})
	sets.precast.WS.Torcleaver.Acc25 = set_combine(sets.precast.WS.Torcleaver, {})
	sets.precast.WS.Torcleaver.Acc100 = set_combine(sets.precast.WS.Torcleaver, {})
	sets.precast.WS.Torcleaver.Acc200 = set_combine(sets.precast.WS.Acc200, {
		back=AnkouWSD})
	
	-- SCOURGE
	-- STR/VIT 40% 
	sets.precast.WS['Scourge'] = set_combine(sets.precast.WS.Torcleaver, {ear2="Ishvara Earring"})
	sets.precast.WS['Scourge'].Acc25 = set_combine(sets.precast.WS.Torcleaver.Acc25,{ear2="Ishvara Earring"})
	sets.precast.WS['Scourge'].Acc100 = set_combine(sets.precast.WS.Torcleaver.Acc100,{ear2="Ishvara Earring"})
	sets.precast.WS['Scourge'].Acc200 = set_combine(sets.precast.WS.Torcleaver.Acc200,{back=AnkouWSD})

	-- ENTROPY
	-- 86-100% INT 
	sets.precast.WS.Entropy = set_combine(sets.precast.WS, {})
	sets.precast.WS.Entropy.Acc25 = set_combine(sets.precast.WS.Entropy, {})
	sets.precast.WS.Entropy.Acc100 = set_combine(sets.precast.WS.Entropy, {})
	sets.precast.WS.Entropy.Acc200 = set_combine(sets.precast.WS.Acc200, {})
	
	-- INSURGENCY
	-- 20% STR / 20% INT 
	sets.precast.WS.Insurgency = set_combine(sets.precast.WS.Entropy, sets.precast.WS)
	sets.precast.WS.Insurgency.Acc25 = set_combine(sets.precast.WS.Entropy.Acc25, {})
	sets.precast.WS.Insurgency.Acc100 = set_combine(sets.precast.WS.Entropy.Acc100, {})
	sets.precast.WS.Insurgency.Acc200 = set_combine(sets.precast.WS.Acc200, {})

	--CATASTROPHE
	--40% STR 40% INT	 
	sets.precast.WS.Catastrophe = set_combine(sets.precast.WS, {ammo="Knobkierrie",
		head="Ratri Sallet",
		hands="Ratri Gadlings",
		legs="Ratri Cuisses",
		feet="Sulevia's Leggings +2",
		ear2="Ishvara Earring",
		back=AnkouWSD})
	sets.precast.WS.Catastrophe.Acc25 = set_combine(sets.precast.WS.Catastrophe, {})
	sets.precast.WS.Catastrophe.Acc100 = set_combine(sets.precast.WS.Catastrophe, {})
	sets.precast.WS.Catastrophe.Acc200 = set_combine(sets.precast.WS.Acc200, {back=AnkouWSD})


	-- CROSS Reaper
	-- 60% STR / 60% MND
	sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS.Catastrophe,{})
	sets.precast.WS['Cross Reaper'].Acc25 = sets.precast.WS.Catastrophe.Acc25
	sets.precast.WS['Cross Reaper'].Acc100 = sets.precast.WS.Catastrophe.Acc100
	sets.precast.WS['Cross Reaper'].Acc200 =  set_combine(sets.precast.WS.Acc200, {back=AnkouDEX})


	-- Quietus
	-- 60% STR / MND 
	sets.precast.WS.Quietus = sets.precast.WS.Catastrophe
	sets.precast.WS.Quietus.Acc25 = sets.precast.WS.Catastrophe.Acc25
	sets.precast.WS.Quietus.Acc100 = sets.precast.WS.Catastrophe.Acc100
	sets.precast.WS.Quietus.Acc200 = sets.precast.WS.Catastrophe.Acc200

	-- SPIRAL HELL
	-- 50% STR / 50% INT 
	sets.precast.WS['Spiral Hell'] = sets.precast.WS
	sets.precast.WS['Spiral Hell'].Acc25 = sets.precast.WS.Acc25
	sets.precast.WS['Spiral Hell'].Acc100 = sets.precast.WS.Acc100
	sets.precast.WS['Spiral Hell'].Acc200 = sets.precast.WS.Acc200

	-- SHADOW OF DEATH
	-- 40% STR 40% INT - Darkness Elemental
	sets.precast.WS['Shadow of Death'] = set_combine(sets.precast.WS['Entropy'], {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		body="Founder's breastplate",
		hands="leyline gloves",
		legs="eschite cuisses",
		feet="Ignominy Sollerets +2",
		ear1="Friomisi Earring",
		ear2="Moonshade Earring",
		ring1="Acumen ring",
		ring2="Archon Ring",
		back=AnkouWSD
	})
	sets.precast.WS['Shadow of Death'].Acc25 = sets.precast.WS['Shadow of Death']
	sets.precast.WS['Shadow of Death'].Acc100 = sets.precast.WS['Shadow of Death']
	sets.precast.WS['Shadow of Death'].Acc200 = sets.precast.WS['Shadow of Death']

	sets.precast.WS['Infernal Scythe'] = sets.precast.WS['Shadow of Death']
	sets.precast.WS['Infernal Scythe'].Acc25 = sets.precast.WS['Shadow of Death']
	sets.precast.WS['Infernal Scythe'].Acc100 = sets.precast.WS['Shadow of Death']
	sets.precast.WS['Infernal Scythe'].Acc200 = sets.precast.WS['Shadow of Death']
	-- DARK HARVEST 
	-- 40% STR 40% INT - Darkness Elemental
	sets.precast.WS['Dark Harvest'] = sets.precast.WS['Shadow of Death']
	sets.precast.WS['Dark Harvest'].Acc25 = sets.precast.WS['Shadow of Death']
	sets.precast.WS['Dark Harvest'].Acc100 = sets.precast.WS['Shadow of Death']
	sets.precast.WS['Dark Harvest'].Acc200 = sets.precast.WS['Shadow of Death']

	--Herculean Slash
	--80% VIT
	sets.precast.WS['Herculean Slash'] = set_combine(sets.precast.WS['Shadow of Death'], {head="Jumalik helm" })
	sets.precast.WS['Herculean Slash'].Acc25 = sets.precast.WS['Herculean Slash']
	sets.precast.WS['Herculean Slash'].Acc100 = sets.precast.WS['Herculean Slash']
	sets.precast.WS['Herculean Slash'].Acc200 = sets.precast.WS['Herculean Slash']

	-- Sword WS
	-- SANGUINE BLADE
	-- 50% MND / 50% STR Darkness Elemental
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS['Shadow of Death'], { })
	sets.precast.WS['Sanguine Blade'].Acc25 = sets.precast.WS['Sanguine Blade']
	sets.precast.WS['Sanguine Blade'].Acc100 = sets.precast.WS['Sanguine Blade']
	sets.precast.WS['Sanguine Blade'].Acc200 = sets.precast.WS['Sanguine Blade']

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS['Resolution'], { })
	sets.precast.WS['Savage Blade'].Acc25 = sets.precast.WS['Resolution'].Acc25
	sets.precast.WS['Savage Blade'].Acc100 = sets.precast.WS['Resolution'].Acc100
	sets.precast.WS['Savage Blade'].Acc200 = sets.precast.WS['Resolution'].Acc200

	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Shadow of Death'], {head="jumalik helm",})
	sets.precast.WS['Aeolian Edge'].Acc25 = sets.precast.WS['Aeolian Edge']
	sets.precast.WS['Aeolian Edge'].Acc100 = sets.precast.WS['Aeolian Edge']
	sets.precast.WS['Aeolian Edge'].Acc200 = sets.precast.WS['Aeolian Edge']

	--------------------------------------------------------------------------------------------

	-- Idle sets

	--------------------------------------------------------------------------------------------

	sets.idle.Town = {ammo="Staunch Tathlum +1",
		head=ValorousMaskQA,
		neck="coatl gorget +1",
		ear1="Hearty Earring",
		ear2="Odnowa Earring +1",
		body="Ratri Breastplate",
		--body="councilor's garb",
		hands=OdysseanGauntletsRefresh,
		ring1="Defending Ring",
		ring2="Moonbeam Ring",
		back="Moonlight Cape",
		waist="Flume Belt +1",
		legs="Carmine Cuisses +1",
		feet="Amm Greaves"
	}

	sets.idle.Field = set_combine(sets.idle.Town, {
		body="jumalik mail",
--		back="shadow mantle"
	})


	sets.idle.Weak = set_combine(sets.idle.Field,{ammo="Staunch Tathlum +1",
		head="Twilight Helm",
		neck="Coatl Gorget +1",
		ear2="Odnowa Earring +1",
		body="Twilight Mail",
		back="Moonlight Cape",
		waist="Flume Belt +1",
		legs="Carmine Cuisses +1",
		feet="Amm Greaves"
	})

	sets.refresh = { ammo="Staunch Tathlum +1",
		head="Jumalik helm",
		neck="Coatl Gorget +1",
		body="Jumalik mail",
		hands=OdysseanGauntletsRefresh
	}

	-- Defense sets
	sets.defense.PDT = {ammo="Staunch Tathlum +1",--2		2
		head=ValorousMaskQA,
		body="Sulevia's Platemail +2",		--9			9
		hands="Sulevia's Gauntlets +2",		--5			5
		legs="Sulevia's Cuisses +2",		--7			7
		feet="Amm Greaves",					--5			5
		neck="Loricate Torque +1",			--6			6
		left_ear="Hearty Earring",
		right_ear="Odnowa Earring +1",		
		left_ring="Defending Ring",			--10		10
		right_ring="Regal Ring",			
		back="Moonlight Cape",				--5			5		
	}
	sets.defense.Reraise = sets.idle.Weak

	sets.Kiting = {legs="Carmine Cuisses +1"}

	sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}


	
	-- Apocalypse 
	sets.engaged = {ammo="Yetshila",
		head=ValorousMaskQA,
		body=ValorousMailQA, 
		hands="Flamma Manopolas +2",
		legs="Ignominy Flanchard +3",
		feet=ValorousFeetQA,
		neck="Ganesha's Mala",
		waist="Windbuffet Belt",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		back=AnkouDEX,
	}
	sets.engaged.Acc25 = set_combine(sets.engaged, {
		head="Flamma Zucchetto +2",
		legs="Ignominy Flanchard +3",
		left_ear="Telos Earring",
		waist="Ioskeha Belt", 
		left_ring="Petrov Ring",
		back=AnkouDEX,})	
	sets.engaged.Acc100 = set_combine(sets.engaged.Acc25, {
		--body="Flamma Korazin +1",
		hands="Flamma Manopolas +2",
		feet="Flamma Gambieras +2",
		ring1="Regal Ring",
		back=AnkouDEX,
		})
	sets.engaged.Acc200 = set_combine(sets.engaged, {ammo="Seething Bomblet +1",	
		head=ValorousMaskQA,
		body="Ignominy Cuirass +3",
		hands="Ignominy Gauntlets +2", 
		legs="Ignominy Flanchard +3",
		feet=ValorousFeetRefresh,
		neck="Combatant's Torque",
		waist="Ioskeha Belt",
		left_ear="Dignitary's Earring",
		right_ear="Telos Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back=AnkouDEX,
	})	
	
	-- Ragnarok
	-- base acc 1065
	sets.engaged.GreatSword = {ammo="Yetshila",
		head=ValorousMaskQA,
		body=ValorousMailQA, 
		hands="Flamma Manopolas +2",
		legs="Ignominy Flanchard +3",
		feet=ValorousFeetQA,
		neck="Ganesha's Mala",
		waist="Windbuffet Belt",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		back=AnkouDEX,
	}
	sets.engaged.GreatSword.Acc25 =  set_combine(sets.engaged.GreatSword, {
		head="Flamma Zucchetto +2",
		legs="Ignominy Flanchard +3",
		left_ear="Telos Earring",
		neck="Combatant's Torque",
		waist="Ioskeha Belt", 
		left_ring="Petrov Ring",
		back=AnkouDEX,})	
	sets.engaged.GreatSword.Acc100 =  set_combine(sets.engaged.GreatSword.Acc25, {
		--body="Flamma Korazin +1",
		hands="Flamma Manopolas +2",
		feet="Flamma Gambieras +2",
		ring1="Regal Ring",
		back=AnkouDEX,
		})
	sets.engaged.GreatSword.Acc200 =  set_combine(sets.engaged.GreatSword, {ammo="Seething Bomblet +1",	
		head=ValorousMaskQA,
		body="Ignominy Cuirass +3",
		hands="Ignominy Gauntlets +2", 
		legs="Ignominy Flanchard +3",
		feet=ValorousFeetRefresh,
		neck="Combatant's Torque",
		waist="Ioskeha Belt",
		left_ear="Dignitary's Earring",
		right_ear="Telos Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back=AnkouDEX,
	})	
	
	-- Defensive sets to combine with various weapon-specific sets below
	-- These allow hybrid acc/pdt sets for difficult content
	sets.Defensive = {						--pdt		mdt
		ammo="Staunch Tathlum +1",			--3			3
		head="Flamma Zucchetto +2",		
		body="Sulevia's Platemail +2",		--9			9
		hands="Sulevia's Gauntlets +2",		--5			5
		legs="Sulevia's Cuisses +2",		--7			7
		feet="Amm Greaves",					--5			5
		neck="Loricate Torque +1",			--6			6
		left_ear="Hearty Earring",
		right_ear="Telos Earring",
		left_ring="Defending Ring",			--10		10
		right_ring="Niqmaddu Ring",			
		back="Moonlight Cape",				--6			6	
	}										--51DT		

	sets.Defensive_Acc25 = set_combine(sets.Defensive,{left_ear="Dignitary's Earring",feet="Sulevia's Leggings +2"})
	sets.Defensive_Acc100 = set_combine(sets.Defensive_Acc25,{back=AnkouDEX,ring2="Moonbeam Ring"})
		
	sets.Defensive_Meva = set_combine(sets.Defensive,{
		ammo="Staunch Tathlum +1",			--2   2   
		head="Flamma Zucchetto +2",		--        	53
		body="Ratri Breastplate",		--+13  13  	107
		hands="Raetic Bangles",			--			90
		legs=OdysseanCuissesSTP,		--			86
		feet="Founder's Greaves",		--			95
		neck="Loricate Torque +1",		--6   6
		ear1="Hearty earring",
		ear2="Eabani earring",			--			8
		ring1="Defending Ring",			--10  10
		ring2="Purity ring",				--	  4		10
		back="Moonlight Cape",			--5   5
	})									--10  14	
	
	sets.engaged.PDT = sets.Defensive
	sets.engaged.Acc25.PDT = sets.Defensive_Acc25
	sets.engaged.Acc100.PDT = sets.Defensive_Acc100
	sets.engaged.Acc200.PDT = sets.Defensive_Acc100
	sets.engaged.Meva = set_combine(sets.engaged, sets.Defensive_Meva)
	sets.engaged.Acc25.Meva = set_combine(sets.engaged.Acc25, sets.Defensive_Meva)
	sets.engaged.Acc100.Meva = set_combine(sets.engaged.Acc100, sets.Defensive_Meva)
	sets.engaged.Acc200.Meva = set_combine(sets.engaged.Acc200, sets.Defensive_Meva)
	sets.engaged.GreatSword.PDT = sets.Defensive
	sets.engaged.GreatSword.Acc25.PDT = sets.Defensive_Acc25
	sets.engaged.GreatSword.Acc100.PDT = sets.Defensive_Acc100
	sets.engaged.GreatSword.Acc200.PDT = sets.Defensive_Acc100
	sets.engaged.GreatSword.Meva = set_combine(sets.engaged.GreatSword, sets.Defensive_Meva)
	sets.engaged.GreatSword.Acc25.Meva = set_combine(sets.engaged.GreatSword.Acc25, sets.Defensive_Meva)
	sets.engaged.GreatSword.Acc100.Meva = set_combine(sets.engaged.GreatSword.Acc100, sets.Defensive_Meva)
	sets.engaged.GreatSword.Acc200.Meva = set_combine(sets.engaged.GreatSword.Acc200, sets.Defensive_Meva)
	
	-- dual wield
	sets.engaged.DW = set_combine(sets.engaged, {
		legs="Carmine Cuisses +1",
		neck="Combatant's Torque",
		ear1="Eabani earring",
		ear2="suppanomimi",
		waist="Reiki Yotai"
	})
	sets.engaged.DW.Acc25 = set_combine(sets.engaged.Acc25, {
		legs="Carmine Cuisses +1",
		neck="Combatant's Torque",
		ear1="Eabani earring",
		ear2="suppanomimi",
		waist="Reiki Yotai"})

	-- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {back="Impassive Mantle"}
	sets.Meva = 	{ammo="Staunch Tathlum +1",ear1="Hearty earring",ear2="Eabani earring",waist="Asklepian Belt",ring2="Purity ring"}
	sets.Terror = 	set_combine(sets.Meva,{feet="Founder's greaves"})
	sets.Charm =	set_combine(sets.Meva,{neck="Unmoving collar +1",back="Solemnity cape"})
	sets.Stun =		set_combine(sets.Meva,{body="Onca suit",hands=empty,legs=empty,feet=empty})
	sets.buff.Doom = {ring2="Purity Ring"}

	sets.engaged.Reraise = set_combine(sets.engaged, {
		head="Twilight Helm",
		body="Twilight Mail"
	})

	sets.buff.Souleater = { 
		head="Ignominy Burgonet +2"
	}

end

-------------------------------------------------------------------------------------------------------------------
-- 
-------------------------------------------------------------------------------------------------------------------

--auto use echo drops
function job_pretarget(spell, action, spellMap, eventArgs)
	if spell.type:endswith('Magic') and buffactive.silence then
		eventArgs.cancel = true
		send_command('input /item "Echo Drops" <st>')
		add_to_chat(122, "Silenced, Auto-Echos")
	end
end
	
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if buffactive['Terror'] or buffactive['Stun'] or buffactive['Petrification'] then
		eventArgs.cancel = true
		equip(sets.engaged.PDT)
		add_to_chat(122, "Unable to act, action cancelled")
		return	
	end
	if state.SkillchainMode.current == 'None' then
		xStepWS = 0
	end	
	if player.tp > 999 then
		--if player.equipment.main == 'Apocalypse' then
			if spell.english == 'Spiral Hell' then
				if state.SkillchainMode.current == '2Step' and xStepWS == 0 then
					add_to_chat(122, 'Darkness 2step1')
					send_command('input /ws "Catastrophe" <t>')
					eventArgs.cancel = true
					xStepWS = 1
					return				
				elseif state.SkillchainMode.current == '2Step' and xStepWS == 1 then
					add_to_chat(122, '2step2')
					send_command('input /ws "Cross Reaper" <t>')
					eventArgs.cancel = true
					xStepWS = 0	
					return		
				elseif state.SkillchainMode.current == '3Step' and xStepWS == 0 then
					add_to_chat(122, 'Darkness 3step1')
					send_command('input /ws "Insurgency" <t>')
					eventArgs.cancel = true
					xStepWS = 1
					return		
				elseif state.SkillchainMode.current == '3Step' and xStepWS == 1 then
					add_to_chat(122, '3step2')
					send_command('input /ws "Entropy" <t>')
					eventArgs.cancel = true
					xStepWS = 2
					return		
				elseif state.SkillchainMode.current == '3Step' and xStepWS == 2 then
					add_to_chat(122, '3step3')
					send_command('input /ws "Cross Reaper" <t>')
					eventArgs.cancel = true
					xStepWS = 0
					return		
				elseif state.SkillchainMode.current == '4Step' and xStepWS == 0 then
					add_to_chat(122, 'Darkness 4step1')
					send_command('input /ws "Insurgency" <t>')
					eventArgs.cancel = true
					xStepWS = 1
					return		
				elseif state.SkillchainMode.current == '4Step' and xStepWS == 1 then
					add_to_chat(122, '4step2')
					send_command('input /ws "Entropy" <t>')
					eventArgs.cancel = true
					xStepWS = 2
					return		
				elseif state.SkillchainMode.current == '4Step' and xStepWS == 2 then
					add_to_chat(122, '4step3')
					send_command('input /ws "Cross Reaper" <t>')
					eventArgs.cancel = true
					xStepWS = 3
					return			
				elseif state.SkillchainMode.current == '4Step' and xStepWS == 3 then
					add_to_chat(122, '4step4')
					send_command('input /ws "Catastrophe" <t>')
					eventArgs.cancel = true
					xStepWS = 0
					return		
				elseif state.SkillchainMode.current == '5Step' and xStepWS == 0 then
					add_to_chat(122, 'Darkness 5step1')
					send_command('input /ws "Cross Reaper" <t>')
					eventArgs.cancel = true
					xStepWS = 1
					return		
				elseif state.SkillchainMode.current == '5Step' and xStepWS == 1 then
					add_to_chat(122, '5step2')
					send_command('input /ws "Insurgency" <t>')
					eventArgs.cancel = true
					xStepWS = 2
					return		
				elseif state.SkillchainMode.current == '5Step' and xStepWS == 2 then
					add_to_chat(122, '5step3')
					send_command('input /ws "Entropy" <t>')
					eventArgs.cancel = true
					xStepWS = 3
					return		
				elseif state.SkillchainMode.current == '5Step' and xStepWS == 3 then
					add_to_chat(122, '5step4')
					send_command('input /ws "Cross Reaper" <t>')
					eventArgs.cancel = true
					xStepWS = 4
					return		
				elseif state.SkillchainMode.current == '5Step' and xStepWS == 4 then
					add_to_chat(122, '5step5')
					send_command('input /ws "Catastrophe" <t>')
					eventArgs.cancel = true
					xStepWS = 0
					return		
				else
					send_command('input /ws "Catastrophe" <t>')
					eventArgs.cancel = true
					xStepWS = 0
					return	
				end			
			elseif spell.english == 'Dark Harvest' then
				if state.SkillchainMode.current == '2Step' and xStepWS == 0 then
					add_to_chat(122, 'Fusion/Light 2step1')
					send_command('input /ws "Cross Reaper" <t>')
					eventArgs.cancel = true
					xStepWS = 1
					return				
				elseif state.SkillchainMode.current == '2Step' and xStepWS == 1 then
					add_to_chat(122, '2step2')
					send_command('input /ws "Insurgency" <t>')
					eventArgs.cancel = true
					xStepWS = 0	
					return		
				elseif state.SkillchainMode.current == '3Step' and xStepWS == 0 then
					add_to_chat(122, 'Light 3step1')
					send_command('input /ws "Guillotine" <t>')
					eventArgs.cancel = true
					xStepWS = 1
					return		
				elseif state.SkillchainMode.current == '3Step' and xStepWS == 1 then
					add_to_chat(122, '3step2')
					send_command('input /ws "Entropy" <t>')
					eventArgs.cancel = true
					xStepWS = 2
					return		
				elseif state.SkillchainMode.current == '3Step' and xStepWS == 2 then
					add_to_chat(122, '3step3')
					send_command('input /ws "Insurgency" <t>')
					eventArgs.cancel = true
					xStepWS = 0
					return		
				elseif state.SkillchainMode.current == '4Step' and xStepWS == 0 then
					add_to_chat(122, 'Light 4step1')
					send_command('input /ws "Entropy" <t>')
					eventArgs.cancel = true
					xStepWS = 1
					return		
				elseif state.SkillchainMode.current == '4Step' and xStepWS == 1 then
					add_to_chat(122, '4step2')
					send_command('input /ws "Guillotine" <t>')
					eventArgs.cancel = true
					xStepWS = 2
					return		
				elseif state.SkillchainMode.current == '4Step' and xStepWS == 2 then
					add_to_chat(122, '4step3')
					send_command('input /ws "Entropy" <t>')
					eventArgs.cancel = true
					xStepWS = 3
					return			
				elseif state.SkillchainMode.current == '4Step' and xStepWS == 3 then
					add_to_chat(122, '4step4')
					send_command('input /ws "Insurgency" <t>')
					eventArgs.cancel = true
					xStepWS = 0
					return		
				elseif state.SkillchainMode.current == '5Step' and xStepWS == 0 then
					add_to_chat(122, 'Light 6step1')
					send_command('input /ws "Insurgency" <t>')
					eventArgs.cancel = true
					xStepWS = 1
					return		
				elseif state.SkillchainMode.current == '5Step' and xStepWS == 1 then
					add_to_chat(122, '6step2')
					send_command('input /ws "Vorpal Scythe" <t>')
					eventArgs.cancel = true
					xStepWS = 2
					return		
				elseif state.SkillchainMode.current == '5Step' and xStepWS == 2 then
					add_to_chat(122, '6step3')
					send_command('input /ws "Entropy" <t>')
					eventArgs.cancel = true
					xStepWS = 3
					return		
				elseif state.SkillchainMode.current == '5Step' and xStepWS == 3 then
					add_to_chat(122, '6step4')
					send_command('input /ws "Guillotine" <t>')
					eventArgs.cancel = true
					xStepWS = 4
					return		
				elseif state.SkillchainMode.current == '5Step' and xStepWS == 4 then
					add_to_chat(122, '6step5')
					send_command('input /ws "Entropy" <t>')	
					eventArgs.cancel = true
					xStepWS = 5
					return		
				elseif state.SkillchainMode.current == '5Step' and xStepWS == 5 then
					add_to_chat(122, '6step6')
					send_command('input /ws "Insurgency" <t>')	
					eventArgs.cancel = true
					xStepWS = 0
					return		
				else
					send_command('input /ws "Catastrophe" <t>')
					eventArgs.cancel = true
					xStepWS = 0
					return		
				end	
			else
			end
		
		--elseif player.equipment.main == 'Ragnarok' then	
			if spell.english == 'Frostbite' then
				if state.SkillchainMode.current == '2Step' and xStepWS == 0 then
					add_to_chat(122, '2step1')
					send_command('input /ws "Resolution" <t>')
					eventArgs.cancel = true
					xStepWS = 1
					return				
				elseif state.SkillchainMode.current == '2Step' and xStepWS == 1 then
					add_to_chat(122, '2step2')
					send_command('input /ws "Torcleaver" <t>')
					eventArgs.cancel = true
					xStepWS = 0	
					return		
				elseif state.SkillchainMode.current == '3Step' and xStepWS == 0 then
					add_to_chat(122, '3step1')
					send_command('input /ws "Scourge" <t>')
					eventArgs.cancel = true
					xStepWS = 1
					return		
				elseif state.SkillchainMode.current == '3Step' and xStepWS == 1 then
					add_to_chat(122, '3step2')
					send_command('input /ws "Resolution" <t>')
					eventArgs.cancel = true
					xStepWS = 2
					return		
				elseif state.SkillchainMode.current == '3Step' and xStepWS == 2 then
					add_to_chat(122, '3step3')
					send_command('input /ws "Torcleaver" <t>')
					eventArgs.cancel = true
					xStepWS = 0
					return		
				elseif (state.SkillchainMode.current == '4Step' or state.SkillchainMode.current == '5Step') and xStepWS == 0 then
					add_to_chat(122, '5step1')
					send_command('input /ws "Resolution" <t>')
					eventArgs.cancel = true
					xStepWS = 1
					return		
				elseif (state.SkillchainMode.current == '4Step' or state.SkillchainMode.current == '5Step') and xStepWS == 1 then
					add_to_chat(122, '5step2')
					send_command('input /ws "Torcleaver" <t>')
					eventArgs.cancel = true
					xStepWS = 2
					return		
				elseif (state.SkillchainMode.current == '4Step' or state.SkillchainMode.current == '5Step') and xStepWS == 2 then
					add_to_chat(122, '5step3')
					send_command('input /ws "Scourge" <t>')
					eventArgs.cancel = true
					xStepWS = 3
					return			
				elseif (state.SkillchainMode.current == '4Step' or state.SkillchainMode.current == '5Step') and xStepWS == 3 then
					add_to_chat(122, '5step4')
					send_command('input /ws "Resolution" <t>')
					eventArgs.cancel = true
					if state.SkillchainMode.current == '5Step' then
						xStepWS = 4
					else xStepWS = 0
					end
					return		
				elseif (state.SkillchainMode.current == '4Step' or state.SkillchainMode.current == '5Step') and xStepWS == 4 then
					add_to_chat(122, '5step5')
					send_command('input /ws "Torcleaver" <t>')
					eventArgs.cancel = true
					xStepWS = 0
					return		
				else
					send_command('input /ws "Resolution" <t>')
					eventArgs.cancel = true
					xStepWS = 0
					return		
				end	
			else
			end
		--end	
	else
	
	end	
end

function job_post_precast(spell, action, spellMap, eventArgs)

	if spell.en == 'Resolution' or spell.en == 'Torcleaver' or spell.en == 'Insurgency' or spell.en == 'Cross Reaper' then
		if player.tp > 2999 then
			equip(sets.BrutalIshvara)
		end	
		if world.time >= (17*60) or world.time <= (7*60) then
			equip(sets.BrutalLugra)
		end
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if (state.HybridMode.current == 'PDT' and state.PhysicalDefenseMode.current == 'Reraise') then
		equip(sets.Reraise)
	end
	if spell.type == 'BlackMagic' and (spell.element == world.day_element or spell.element == world.weather_element) then
		equip({waist="Hachirin-No-Obi"})
	end
	if buffactive['Dark Seal'] and spell.type == 'BlackMagic' then
		equip(sets.precast.JA['Dark Seal'])
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Absorb') and spell.english ~= 'Absorb-TP' then
            send_command('@timers d "'..absorb_timer..'"')
            absorb_timer = spell.english
            send_command('@timers c "'..absorb_timer..'" '..absorb_duration..' down spells/00220.png')
		elseif spell.english == 'Drain III' then	
			if buffactive['Dark Seal'] then
				drain_duration = 270
			end
            send_command('@timers d "'..drain_timer..'"')
            drain_timer = spell.english
            send_command('@timers c "'..drain_timer..'" '..drain_duration..' down spells/00220.png')
		elseif spell.english == 'Dread Spikes' then
            send_command('@timers d "'..drain_timer..'"')
            drain_timer = spell.english
            send_command('@timers c "'..drain_timer..'" '..drain_duration..' down spells/00220.png')
		end
	end
	
	-- if spell.en == 'Insurgency' and state.SkillchainMode.current == '5Step' and xStepWS == 4 then
		-- equip({main='Ragnarok'})
	-- elseif spell.en == 'Torcleaver' and state.SkillchainMode.current == '5Step' and xStepWS == 0 then
		-- equip({main='Apocalypse'})
	-- end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
end
-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
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
	if state.RaeticMode.value then
		meleeSet = set_combine(meleeSet, {hands="Raetic Bangles"})
	end
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
	if newStatus == "Engaged" then
		get_combat_weapon()
	end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

	-- AM custom groups
	--if S{'aftermath'}:contains(buff:lower()) then
	--	if player.equipment.main == 'Apocalypse' then
	--		classes.CustomMeleeGroups:clear()

	--		if (buff == "Aftermath: Lv.3" and gain) or buffactive['Aftermath: Lv.3'] then
	--			classes.CustomMeleeGroups:append('AM3')
	--		end
	--	else
	--		classes.CustomMeleeGroups:clear()

	--		if buff == "Aftermath" and gain or buffactive.Aftermath then
	--			classes.CustomMeleeGroups:append('AM')
	--		end
	--	end
	--end
	-- Automatically wake me when I'm slept
	if string.lower(buff) == "sleep" and gain and player.hp > 200 then
		equip(sets.Berserker)
	end
	
	if buffactive['Stun'] or buffactive['Petrification'] or buffactive['Terror'] then
		equip(sets.Defensive)
		add_to_chat(122, "TP set to PDT")
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)

	get_combat_form()
	get_combat_weapon()
	update_melee_groups()

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()

	if S{'NIN', 'DNC'}:contains(player.sub_job) and drk_sub_weapons:contains(player.equipment.sub) then
		state.CombatForm:set("DW")
	elseif (buffactive['Last Resort']) then
--		if (buffactive.embrava or buffactive.haste) and buffactive.march  then
--			add_to_chat(8, '-------------Delay Capped-------------')
--			state.CombatForm:set("Haste")
--		else
--			state.CombatForm:reset()
--		end
--		else
--			state.CombatForm:reset()
	end
end

function get_combat_weapon()
	if gsList:contains(player.equipment.main) then
		state.CombatWeapon:set("GreatSword")
	else -- use regular set, 
		state.CombatWeapon:reset()
	end
end


-- Call from job_aftercast() to create the custom aftermath timer.
function aw_custom_aftermath_timers_aftercast(spell)
	if not spell.interrupted and spell.type == 'WeaponSkill' and
		info.aftermath and info.aftermath.weaponskill == spell.english and info.aftermath.duration > 0 then

		local aftermath_name = 'Aftermath: Lv.'..tostring(info.aftermath.level)
		send_command('timers d "Aftermath: Lv.1"')
		send_command('timers d "Aftermath: Lv.2"')
		send_command('timers d "Aftermath: Lv.3"')
		send_command('timers c "'..aftermath_name..'" '..tostring(info.aftermath.duration)..' down abilities/aftermath'..tostring(info.aftermath.level)..'.png')

		info.aftermath = {}
	end
end

function display_current_job_state(eventArgs)
	local msg = ''
	msg = msg .. 'Offense: '..state.OffenseMode.current
	msg = msg .. ', Hybrid: '..state.HybridMode.current

	if state.DefenseMode.value ~= 'None' then
		local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
		msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
	end
	if state.CombatForm.current == 'Haste' then
		msg = msg .. ', High Haste, '
	end
	if state.CapacityMode.value then
		msg = msg .. ', Capacity, '
	end
	if state.LastResortMode.value then
		msg = msg .. ', LR Defense, '
	end
	if state.PCTargetMode.value ~= 'default' then
		msg = msg .. ', Target PC: '..state.PCTargetMode.value
	end
	if state.SelectNPCTargets.value then
		msg = msg .. ', Target NPCs'
	end

	add_to_chat(123, msg)
	eventArgs.handled = true
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
end

function update_melee_groups()

	classes.CustomMeleeGroups:clear()
	-- mythic AM	
	if player.equipment.main == 'Apocalypse' then
		if buffactive['Aftermath: Lv.3'] then
			classes.CustomMeleeGroups:append('AM3')
		end
		else
		-- relic AM
		if buffactive['Aftermath'] then
			classes.CustomMeleeGroups:append('AM')
		end
	end
end

function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'SAM' then
		set_macro_page(2, 1)
	elseif player.sub_job == 'RUN' then
		set_macro_page(10, 1)
	elseif player.sub_job == 'RDM' then
		set_macro_page(1, 1)
	else
		set_macro_page(1, 1)
	end
end
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
    state.HybridMode:options('Normal', 'PDT', 'Meva')
    state.WeaponskillMode:options('Normal', 'Acc50', 'Acc100', 'Acc150')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
		
	state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'Turtle', 'Resist', 'Terror', 'Charm','Death'}
	state.RuneMode = M('None','Lux','Tenebrae','Ignis','Gelus','Flabra','Tellus','Sulpor','Unda')
    state.MagicBurst = M(false, 'Magic Burst')
	
    -- Additional local binds
    send_command('bind !` gs c toggle MagicBurst')
	send_command('bind @` gs c cycle RuneMode')
	send_command('bind ^` gs c cycle ExtraDefenseMode')
	
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
	
				
    OgmaFC={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10',}}
    OgmaDD={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
	OgmaPDT={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10',}}
    OgmaSTP={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}}
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	sets.enmity={--Epeolatry 23
		ammo="Sapience Orb",			--2
		head="Rabid Visor",				--6
		body="Emet Harness +1",			--10
		hands="Kurys Gloves",			--9
		legs="Erilaz Leg Guards +1",	--11
		feet="Erilaz Greaves +1",		--6
		neck="Unmoving Collar +1",		--10
		waist="Chaac Belt",			--
		left_ear="Cryptic Earring",		--4
		right_ear="Odnowa Earring +1",	
		left_ring="Petrov Ring",		--4
		right_ring="Supershear Ring",	--5
		back=OgmaPDT,}		--5	-->69+23+30  112
	sets.precast.JA=sets.enmity	
		
	sets.precast.JA['Vallation'] = set_combine(sets.enmity,{body="Runeist's Coat +2",legs="Futhark trousers +1",back=OgmaPDT})	--relic for inspiration
	sets.precast.JA['Valiance'] = set_combine(sets.enmity,sets.precast.JA['Vallation'])
	sets.precast.JA['Battuta'] = set_combine(sets.enmity,{head="Futhark Bandeau +2"})
	sets.precast.JA['Gambit'] = set_combine(sets.enmity,{hands="Runeist mitons +1"})
	sets.precast.JA['Pflug'] = set_combine(sets.enmity,{feet="Runeist bottes +1"})
	sets.precast.JA['Liement'] = set_combine(sets.enmity,{body="Futhark Coat +1"})
	sets.precast.JA['Vivacious Pulse'] = {head="Erilaz Galea +1",legs="Runeist Trousers +1",neck="Incanter's Torque",ring1="Stikini Ring +1",ring2="Stikini Ring +1"}
	
	sets.precast.HP = {ring1="Moonbeam Ring",ear2="Odnowa Earring +1"}

	sets.precast.Item = {}
	sets.precast.Item['Holy Water'] = {ring1="Purity Ring"} 

	sets.precast.JA['Lunge'] = {ammo="Seeth. Bomblet +1",
		head=HercHelmMAB, 
		body="Samnuha Coat", 
		hands="Carmine Fin. Ga. +1",
		legs=HercLegsWSD,
		feet=HercBootsMAB,
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		right_ring="Shiva Ring +1",
		back="Evasionist's Cape",
	}
	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
	
	
    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Sapience Orb",--2
        head=HercHelmFC,			--13
		ear1="Etiolation Earring",		--1
		ear2="Odnowa Earring +1",		--
		neck="Orunmila's torque",		--5
        body="adhemar jacket",			--7
		hands="Leyline Gloves",			--8
		ring1="Kishar ring",			--4
		ring2="Lebeche Ring",		
		legs="Ayanmo Cosciales +2",		--6
		--feet=HercBootsFC,				--5
		back=OgmaFC}						--10 >60
        
	sets.precast['Enhancing Magic'] = {legs="Futhark Trousers +1"}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Knobkierrie",
        head="Adhemar Bonnet +1",neck="Fotia gorget",ear1="Sherida earring",ear2="moonshade earring",
        body="Adhemar Jacket +1",hands="Meghanada Gloves +2",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back=OgmaDD,waist="Fotia belt",legs="Samnuha tights",feet=HercBootsDmg}
    	
	sets.precast.WS.Acc50 = set_combine(sets.precast.WS,{})
	sets.precast.WS.Acc100 = set_combine(sets.precast.WS,{})		
	sets.precast.WS.Acc150 = set_combine(sets.precast.WS,{})
		
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {ammo="Seething Bomblet +1",
		head="Meghanada Visor +2",
		body="Meghanada Cuirie +2",
		hands="Raetic Bangles",
		legs="Samnuha Tights", 
		feet="Lustratio Leggings +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back=OgmaDD,
		})
	sets.precast.WS['Resolution'].Acc50 = set_combine(sets.precast.WS['Resolution'], {feet=HercBootsDmg})
	sets.precast.WS['Resolution'].Acc100 = set_combine(sets.precast.WS['Resolution'].Acc50, {head="Meghanada Visor +2"})
	sets.precast.WS['Resolution'].Acc150 = set_combine(sets.precast.WS['Resolution'].Acc100, {ammo="Seething Bomblet +1",legs=HercLegsAcc,ear2="Telos Earring"})
	
	--80% DEX dmg scales w/ tp
	sets.precast.WS['Dimidation'] = set_combine(sets.precast.WS, {ammo="Knobkierrie",
		head="Adhemar Bonnet +1",
		body="Adhemar Jacket +1", 
		hands="Meghanada Gloves +2",
		legs="Lustr. Subligar +1",
		feet="Lustra. Leggings +1", 
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Karieyh Ring +1",
		back=OgmaSTP, })
	sets.precast.WS['Dimidation'].Acc50 = set_combine(sets.precast.WS['Dimidation'], {feet=HercBootsDmg})
	sets.precast.WS['Dimidation'].Acc100 = set_combine(sets.precast.WS['Dimidation'].Acc50, {})
	sets.precast.WS['Dimidation'].Acc150 = set_combine(sets.precast.WS['Dimidation'].Acc100, {head="Meghanada Visor +2",ear2="Mache Earring +1",})
	
	
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {legs="Carmine Cuisses +1"})
	sets.precast.WS['Requiescat'].Acc50 = sets.precast.WS.Acc50 
	sets.precast.WS['Requiescat'].Acc100 = sets.precast.WS.Acc100 
	sets.precast.WS['Requiescat'].Acc150 = sets.precast.WS.Acc150 

    sets.precast.WS['Sanguine Blade'] = { ammo="Seeth. Bomblet +1",
		head="Pixie Hairpin +1",
		body="Carm. Scale Mail",
		hands="Carmine Fin. Ga. +1",
		legs=HercLegsWSD,
		feet=HercBootsRefresh,
        neck="Fotia gorget",
		ear1="Friomisi Earring",ear2="moonshade Earring",
        ring1="Shiva Ring +1",ring2="Archon Ring",
		back="Evasionist's Cape",waist="Fotia belt"}
	sets.precast.WS['Red Lotus Blade'] = set_combine(sets.precast.WS['Sanguine Blade'], {head=HercHelmMAB})	
    sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS['Sanguine Blade'], {head=HercHelmMAB,})
	sets.precast.WS['Seraph Blade'] = sets.precast.WS['Flash Nova']
	
	sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS, {head="Adhemar Bonnet +1",body="Abnoba kaftan",feet="Thereoid Greaves",ring1="Apate ring"})
	sets.precast.WS['Vorpal Blade'].Acc50 = set_combine(sets.precast.WS, {head="Adhemar Bonnet +1",body="Abnoba kaftan",feet="Thereoid Greaves",ring1="Apate ring"})
	sets.precast.WS['Vorpal Blade'].Acc100 = set_combine(sets.precast.WS, {head="Adhemar Bonnet +1",body="Abnoba kaftan",feet=HercBootsDmg,ring1="Apate ring"})
	sets.precast.WS['Vorpal Blade'].Acc150 = set_combine(sets.precast.WS.Acc100, {ring1="Apate Ring",ring2="Epona's Ring"})
	
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS['Resolution'], {hands="Meghanada Gloves +2",feet=HercBootsWSD})
	sets.precast.WS['Savage Blade'].Acc50 = set_combine(sets.precast.WS['Resolution'].Acc50, {hands="Meghanada Gloves +2",})
	sets.precast.WS['Savage Blade'].Acc100 = set_combine(sets.precast.WS['Resolution'].Acc100, {hands="Meghanada Gloves +2",})
	sets.precast.WS['Savage Blade'].Acc150 = set_combine(sets.precast.WS['Resolution'].Acc150, {hands="Meghanada Gloves +2",})
    
    -- Midcast Sets
    sets.midcast.FastRecast = {ear2="Odnowa Earring +1", ring1="Moonbeam Ring", back="Moonlight Cape"}
    sets.midcast.HP = {ear2="Odnowa Earring +1", ring1="Moonbeam Ring", back="Moonlight Cape"}
        
    
	sets.midcast.Cure = set_combine(sets.midcast.FastRecast,{
		head="carmine mask",neck="Phalaina locket",ear1="Mendicant's earring",ear2="Loquacious earring",--4 5
        body="Vrikodara Jupon",ring1="Stikini Ring +1",ring2="Lebeche Ring",--16					
        back="Solemnity cape",})--6 = 41
		
    sets.midcast.self_healing = set_combine(sets.midcast.Cure,{
		neck="Phalaina locket",		--4
		ring1="Kunaji Ring",		--5
		waist="Gishdubar sash"})	--10		
	
	sets.TH={head=HercHelmTH,feet=HercBootsTH}
	sets.midcast['Bio']=sets.TH
	
	
	sets.midcast['Flash']={
		ammo="Sapience Orb",			--2
		head="Rabid Visor",				--6
		body="Emet Harness +1",			--10
		hands="Kurys Gloves",			--9
		legs="Erilaz Leg Guards +1",	--11
		feet="Erilaz Greaves +1",		--6
		neck="Unmoving Collar +1",		--10
		waist="Chaac Belt",			--
		left_ear="Cryptic Earring",		--4
		right_ear="Odnowa Earring +1",	
		left_ring="Petrov Ring",		--4
		right_ring="Supershear Ring",	--5
		back=OgmaPDT,}		--10
	sets.midcast['Foil']=	sets.midcast['Flash']
	--sets.precast.JA=sets.midcast['Flash']
	sets.midcast['Jettatura'] = sets.midcast['Flash']
	sets.midcast['Blank Gaze'] = sets.midcast['Flash']
	sets.midcast['Geist Wall'] = sets.midcast['Flash']
	sets.midcast['Sheep Song'] = sets.midcast['Flash']
	sets.midcast['Stun'] = sets.midcast['Flash']
	
	sets.midcast['Elemental Magic']= sets.precast.JA['Lunge'] 
	
	sets.midcast['Enhancing Magic'] = {head="Erilaz Galea +1",hands="Runeist Mitons +1",legs="Futhark Trousers +1",neck="Incanter's Torque",ring1="Stikini Ring +1",ring2="Stikini Ring +1"}

	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'],{head=HercHelmPhalanx,body=HercVestPhalanx,hands=TaeonGlovesPhalanx,legs=TaeonTightsPhalanx,feet=HercBootsPhalanx})	
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],{waist="Gishdubar sash"})
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],{head="Runeist Bandeau +1"})
	
    sets.midcast.Protect = {ear1="Brachyura earring"}
    sets.midcast.Protectra = {ear1="Brachyura earring"}
    sets.midcast.Shell = {ear1="Brachyura earring"}
    sets.midcast.Shellra = {ear1="Brachyura earring"}
    

    -- Resting sets
    sets.resting = {}
    
    -- Idle sets
    sets.idle = {ammo="Staunch Tathlum +1",
        head=HercHelmDT,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        body="Runeist's Coat +2",hands="Turms Mittens +1",ring1="Defending Ring",ring2="Karieyh Ring +1",
        back="Moonlight Cape",waist="Flume Belt +1",legs="Carmine Cuisses +1",feet=HercBootsRefresh}--29DT 38PDT 34MDT

    sets.idle.PDT = {ammo="Staunch Tathlum +1",
        head=HercHelmDT,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        body="Runeist's Coat +2",hands=HercGlovesDT,ring1="Defending Ring",ring2="Moonbeam ring",
        back="Moonlight Cape",waist="Flume Belt +1",legs="Erilaz Leg Guards +1",feet="Erilaz Greaves +1"}--29DT 51PDT 38MDT
	
	sets.idle.Refresh = set_combine(sets.idle, {
        head="rawhide mask",
        body="Runeist's Coat +2",
		feet=HercBootsRefresh,
		neck="Sanctity Necklace",
		waist="fucho-no-obi",})

--    sets.idle.Town = {main="Buramenk'ah",ammo="Sapience Orb",
--        head="Mavi Kavuk +2",neck="Sanctity Necklace",ear1="Bloodgem Earring",ear2="Loquacious Earring",
--        body="Luhlaza Jubbah",hands="Assimilator's Bazubands +1",ring1="Defending Ring",ring2="Shneddick ring",
--        back="Lupine cape",waist="Flume Belt +1",feet="Luhlaza Charuqs"}


    
    -- Defense sets
    sets.defense.PDT = {
		ammo="Staunch Tathlum +1",		--3 3
        head=HercHelmDT,				--4 4   meva 	59
        body="Futhark Coat +1",		--7 7				80
		hands=HercGlovesDT,				--5 3			43
		legs="Erilaz Leg Guards +1",	--7				107
		feet="Turms Leggings +1",			--				137
		neck="Loricate torque +1",		--6 6
		ear1="Etiolation Earring",		--	3
		ear2="Odnowa Earring +1",		--	2
		ring1="Defending Ring",			--10 10
		ring2="Moonbeam ring",			--4 4
		waist="Flume Belt +1",			--4
		back=OgmaSTP					--			
		}								--53pdt 42mdt	456meva


	sets.defense.Meva = set_combine(sets.defense.PDT,{
		body="Turms Harness",		--			118
		hands="Turms Mittens +1",			--					91
		feet="Turms Leggings +1",			--					137
		left_ear="Etiolation Earring",		
		right_ear="Eabani Earring",					--					8
		right_ring="Purity Ring",		--					10
		waist="Engraved Belt",		--20/30
		back=OgmaPDT,					--					30
	})						
	
    sets.Turtle = {body="Runeist's Coat +2",ear2="Odnowa Earring +1",ring2="Moonbeam Ring",back="Moonlight Cape",}
	sets.Resist = set_combine(sets.defense.Meva,{ammo="Staunch Tathlum +1",
		body="Runeist's Coat +2",legs="Erilaz Leg Guards +1",feet="Turms Leggings +1",
		--neck="warder's charm +1",
		ear1="Hearty earring",ear2="Eabani earring",waist="Engraved Belt",ring2="Purity ring",back=OgmaPDT})
	sets.Terror = 	set_combine(sets.Resist,{})
	sets.Charm =	set_combine(sets.Resist,{neck="Unmoving collar +1",back="Solemnity cape"})
	sets.Death =	{body="Samnuha Coat",ring2="Shadow Ring",}
    sets.Kiting = {legs="Carmine Cuisses +1"}

    -- Engaged sets

    
    -- Normal melee group
    sets.engaged = {ammo="Yetshila +1",
		head="Adhemar Bonnet +1",
		body="Adhemar Jacket +1",
		hands="Adhemar Wristbands +1", 
		legs="Samnuha Tights", 
		feet=HercBootsTA,
		neck="Anu Torque",
		waist="Windbuffet Belt +1",
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epona's Ring",
		back=OgmaSTP}

    sets.engaged.Acc50 = set_combine(sets.engaged,{ammo="Yetshila +1",head="Dampening Tam",ear2="Telos Earring"})
    sets.engaged.Acc100 = set_combine(sets.engaged.Acc50,{ammo="Yamarang",
		head="Meghanada Visor +2",feet=HercBootsDmg,neck="Combatant's Torque",
		ear1="Mache Earring +1",ear2="Telos Earring",ring2="Ilabrat Ring",waist="Ioskeha Belt"})
    sets.engaged.Acc150 = set_combine(sets.engaged.Acc100,{})
    sets.engaged.Refresh = set_combine(sets.engaged,{body="Runeist's Coat +2"})

    sets.engaged.DW = set_combine(sets.engaged,{ear1="Suppanomimi",ear2="Eabani Earring",waist="Reiki Yotai"})
    sets.engaged.DW.Acc50 = set_combine(sets.engaged,{ear1="Suppanomimi",ear2="Eabani Earring",waist="Reiki Yotai"})
    sets.engaged.DW.Acc100 = set_combine(sets.engaged.Acc100,{ear1="Suppanomimi",ear2="Eabani Earring",waist="Reiki Yotai"})
    sets.engaged.DW.Acc150 = set_combine(sets.engaged.Acc150,{})
    sets.engaged.DW.Refresh = set_combine(sets.engaged,{body="Runeist's Coat +2",})


		
	sets.engaged.PDT = set_combine(sets.defense.PDT, {body="Turms Harness",hands="Turms Mittens +1"})		--38 32
	sets.engaged.Acc50.PDT = set_combine(sets.engaged.PDT, {body="Ayanmo Corazza +2",legs="Ayanmo Cosciales +2",})
	sets.engaged.Acc100.PDT = set_combine(sets.engaged.Acc50.PDT, {ear1="Mache Earring +1",ear2="Telos Earring"})
	sets.engaged.Acc150.PDT = set_combine(sets.engaged.Acc100.PDT, {})
	sets.engaged.Refresh.PDT = set_combine(sets.engaged.PDT, {body="Runeist's Coat +2"})
	sets.engaged.DW.PDT = sets.engaged.PDT
	sets.engaged.DW.Acc50.PDT = set_combine(sets.engaged.DW.PDT, {})
	sets.engaged.DW.Acc100.PDT = set_combine(sets.engaged.DW.PDT, {})
	sets.engaged.DW.Acc150.PDT = set_combine(sets.engaged.DW.PDT, {})
	sets.engaged.DW.Refresh.PDT = set_combine(sets.engaged.PDT, {body="Runeist's Coat +2"})
	
	
	sets.engaged.Meva = sets.defense.Meva
--	sets.engaged.Acc50.Meva = set_combine(sets.defense.Meva, {body="Adhemar Jacket +1",back="Lupine cape"})
	sets.engaged.Refresh.Meva = sets.defense.Meva
	sets.engaged.DW.Meva = sets.defense.Meva
	sets.engaged.DW.Acc50.Meva = set_combine(sets.defense.Meva, {ear1="Mache Earring +1",ear2="Telos Earring"})
	sets.engaged.DW.Acc100.Meva = set_combine(sets.defense.Meva, {ear1="Mache Earring +1",ear2="Telos Earring"})
	sets.engaged.DW.Acc150.Meva = set_combine(sets.defense.Meva, {ear1="Mache Earring +1",ear2="Telos Earring"})
	sets.engaged.DW.Refresh.Meva = sets.defense.Meva
	
	sets.latent_refresh = {waist="Fucho-no-obi"}	
    sets.buff.Doom = {ring1="Eshmun's Ring",ring2="Eshmun's Ring",waist="Gishdubar sash"}
	
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
			equip(sets.defense.PDT)
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

function job_post_precast(spell, action, spellMap, eventArgs)

	if state.ExtraDefenseMode.value == 'Turtle' then
		equip(sets.precast.HP)		
		add_to_chat(122, "HP Precast")
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
		elseif spell.en:startswith('Regen') then
			equip(sets.midcast.Regen)
		else equip(sets.midcast['Enhancing Magic'])
		end
    elseif spell.skill == 'Elemental Magic' then
		equip(sets.midcast['Elemental Magic'])
	end
	if state.ExtraDefenseMode.value == 'Turtle' then
		equip(sets.midcast.HP)		
	end
	if spell.skill == 'Enhancing Magic' and buffactive['Embolden'] then 
		equip({back="Evasionist's Cape"})
	end
end

function job_buff_change(buff, gain)

	if buffactive['Stun'] or buffactive['Petrification'] or buffactive['Terror'] or buffactive['Sleep'] then
		equip(sets.defense.PDT)
		add_to_chat(122, "TP set to PDT")
	end
	
	if string.lower(buff) == "doom" then
		if gain then
			equip(sets.buff.Doom)
			disable('ring1','ring2','waist')		
			add_to_chat(122, "DOOM")
		else
			enable('ring1','ring2','waist')
		end
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
	if state.ExtraDefenseMode then
		idleSet = set_combine(idleSet, sets[state.ExtraDefenseMode.value])
	end
    return idleSet
end


function customize_melee_set(meleeSet)
	if state.Buff.Doom then
		meleeSet = set_combine(meleeSet, sets.buff.Doom)	
	elseif state.ExtraDefenseMode.value ~= 'None' then
		meleeSet = set_combine(meleeSet, sets[state.ExtraDefenseMode.value])
	end
	return meleeSet
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



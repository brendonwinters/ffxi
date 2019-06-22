-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
autora = false
wildshot = false
--default_ws = "Last Stand"
--default_ws = "Leaden Salute"

--[[
    gs c toggle luzafring -- Toggles use of Luzaf Ring on and off
   
    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.
    Acc on offense mode (which is intended for melee) will currently use .Acc weaponskill
    mode for both melee and ranged weaponskills.  Need to fix that in core.
--]]
 
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
   
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")
        -- Detect Triple Shot
    state.Buff['Triple Shot'] = buffactive['Triple Shot'] or false
    -- Whether a warning has been given for low ammo
    state.warned = M(false)
 
    define_roll_values()
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc100', 'Acc200')
    state.HybridMode:options('Normal', 'PDT30', 'PDT40','Meva')
    state.RangedMode:options('Normal', 'Acc50', 'Acc100', 'Enmity', 'Crit','TH')
    state.WeaponskillMode:options('Normal', 'Acc50', 'Acc100', 'Crit')
    state.CastingMode:options('Normal', 'PreNuke', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh', 'Meva')
 
	state.QuickdrawMode = M('None','Fire','Ice','Wind','Thunder','Water','Light','Dark')
	state.autows = M(false, 'AutoWS')
	state.default_ws = M('Leaden Salute', 'Last Stand', 'Savage Blade','Wildfire')
	
	if player.equipment.range == 'Fomalhaut' then
		send_command('gs c cycle default_ws')
	elseif player.equipment.range == 'Anarchy +2' then
		send_command('gs c cycle default_ws')
		send_command('gs c cycle default_ws')
	end
	
    gear.RAbullet = "Devastating Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Living Bullet"
    gear.QDbullet = "Living Bullet"
	
    
	options.ammo_warning_limit = 15
 
	send_command('bind ^d gs c shoot')
	send_command('bind !d gs c shootstop')
	send_command('bind ![ gs c toggle autows')
	send_command('bind ^[ gs c cycle default_ws')
    send_command('bind !` gs c toggle luzafring')
	send_command('bind @` gs c cycle QuickdrawMode')
    -- Additional local binds
	select_default_macro_book()
	update_combat_form()
end
 
 
-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind !`')
    send_command('unbind @`')
end
 
-- Define sets and vars used by this job file.
function init_gear_sets()
        --------------------------------------
        -- Start defining the sets
        --------------------------------------   
		HercHelmQA={ name="Herculean Helm", augments={'STR+9','"Mag.Atk.Bns."+21','Quadruple Attack +2','Mag. Acc.+6 "Mag.Atk.Bns."+6',}}	
		HercHelmMAB={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+21','INT+10','Accuracy+12 Attack+12','Mag. Acc.+11 "Mag.Atk.Bns."+11',}}
		HercHelmWSD={ name="Herculean Helm", augments={'Accuracy+26','Weapon skill damage +5%','STR+4','Attack+4',}}
				
		HercGlovesCure={ name="Herculean Gloves", augments={'Accuracy+19','"Cure" potency +10%',}}
		HercGlovesMAB={ name="Herculean Gloves", augments={'Mag. Acc.+30','DEX+5','Crit.hit rate+2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}}
		
		HercTrousersMAB={ name="Herculean Trousers", augments={'"Drain" and "Aspir" potency +4','"Mag.Atk.Bns."+23','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}
		HercTrousersTH={ name="Herculean Trousers", augments={'Spell interruption rate down -8%','Weapon Skill Acc.+7','"Treasure Hunter"+2','Mag. Acc.+3 "Mag.Atk.Bns."+3',}}
		HercTrousersWSD={ name="Herculean Trousers", augments={'STR+6','Pet: VIT+5','Weapon skill damage +7%','Accuracy+20 Attack+20',}}
		HercTrousersWSD_A={ name="Herculean Trousers", augments={'AGI+13','"Occult Acumen"+5','Weapon skill damage +8%','Accuracy+13 Attack+13',}}
		HercTrousersRefresh={ name="Herculean Trousers", augments={'Crit.hit rate+2','AGI+1','"Refresh"+2','Mag. Acc.+16 "Mag.Atk.Bns."+16',}}
		HercTrousersQA={ name="Herculean Trousers", augments={'Pet: Accuracy+13 Pet: Rng. Acc.+13','"Mag.Atk.Bns."+17','Quadruple Attack +3','Accuracy+20 Attack+20',}}
	
	
		HercBootsMAB={ name="Herculean Boots", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','Mag. Acc.+14','"Mag.Atk.Bns."+14',}}
		HercBootsTA={ name="Herculean Boots", augments={'Accuracy+11','"Triple Atk."+4','Attack+12',}}
		HercBootsRA={ name="Herculean Boots", augments={'Rng.Acc.+16','Crit. hit damage +5%',}}
		HercBootsRACC={ name="Herculean Boots", augments={'Rng.Acc.+30','Crit.hit rate+3','AGI+10','Rng.Atk.+10',}}
		HercBootsRefresh={ name="Herculean Boots", augments={'AGI+2','Crit. hit damage +2%','"Refresh"+2','Accuracy+2 Attack+2',}}
		HercBootsTH={ name="Herculean Boots", augments={'Accuracy+22','"Treasure Hunter"+2',}}
		HercBootsSTP={ name="Herculean Boots", augments={'Accuracy+9 Attack+9','"Store TP"+4','AGI+6','Accuracy+9',}}
		HercBootsDT={ name="Herculean Boots", augments={'"Store TP"+2','Pet: "Store TP"+2','Damage taken-5%','Accuracy+3 Attack+3',}}
			
		CamuRA={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}}
		CamuWS={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
		CamuSavage={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
		CamuMelee={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}
        -- Precast Sets
 
        -- Precast sets to enhance JAs
       
        sets.precast.JA['Triple Shot'] = {}
        sets.precast.JA['Snake Eye'] = {legs="Lanun Trews"}
        sets.precast.JA['Fold'] = {hands="Lanun Gants +3"}
        sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
        sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}
		        
        sets.precast.CorsairRoll = {head="Lanun Tricorne +1",hands="Chasseur's Gants +1", legs="Desultor Tassets", neck="Regal Necklace", back="Camulus's Mantle"}
       
        sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {})--legs="Chas. Culottes +1"})
        sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {})--feet="Chass. Bottes"})
        sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {})--head="Chass. Tricorne +1"})
        sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {})--body="Chasseur's Frac"})
        sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})
       
        sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
        sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"}
		
		sets.ws_earring = {ear1="Ishvara Earring"}
       
        sets.precast.CorsairShot = {}
       
 
               -- Waltz set (chr and vit)
        sets.precast.Waltz = {}
               
        -- Don't need any special gear for Healing Waltz.
        sets.precast.Waltz['Healing Waltz'] = {}
 
        -- Fast cast sets for spells
       
        sets.precast.FC = {ear2="Eabani Earring",
			head="Carmine Mask",body="Adhemar Jacket",hands="Leyline Gloves",
			ear1="Etiolation Earring",neck="Voltsurge Torque"}
 
        --sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
 
 
        sets.precast.RA = {					--snapshot rapidshot
			ammo=gear.RAbullet,
			head="Taeon Chapeau",			--9s
--			body="Laksamana's Frac +3",		--		20r
			body="Oshosi Vest",				--12s
			hands="Lanun Gants +3",			--13s
			legs="Laksamana's Trews +3",	--15s
			feet="Meg. Jam. +2",			--10s
			waist="Yemaya Belt",			--		5r
			--back="Navarch's mantle",
			}
											--59 + 10
		sets.Flurry = {
			body="Laksamana's Frac +3",		--		20r
			}
		
		
        -- Weaponskill sets
        -- Default set for any weaponskill that isn't any more specifically defined
        sets.precast.WS = {
			head=HercHelmWSD,
			body="Laksamana's Frac +3",
			hands="Meg. Gloves +2",
			legs=HercTrousersWSD,
			feet="Lanun Bottes +3",
			neck="Fotia Gorget",
			waist="Fotia Belt",
			left_ear="Moonshade Earring",
			right_ear="Ishvara Earring",
			left_ring="Rajas Ring",
			right_ring="Apate Ring",
			back=CamuWS,}
        sets.precast.WS.Acc50 = sets.precast.WS
        sets.precast.WS.Acc100 = set_combine(sets.precast.WS, {})
        sets.precast.WS.Acc200 = set_combine(sets.precast.WS, {})
        sets.precast.WS.Crit = sets.precast.WS
        sets.precast.WS.Enmity = sets.precast.WS
 
 
        -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
        sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {back=CamuSavage}) 
        sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})
 
        sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
        sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {back=CamuSavage})
        sets.precast.WS['Savage Blade'].Acc100 = set_combine(sets.precast.WS, {back=CamuSavage})	
        sets.precast.WS['Savage Blade'].Acc200 = set_combine(sets.precast.WS, {ear2="Mache Earring",body="Meghanada Cuirie +2",back=CamuSavage})		
        sets.precast.WS['Swift Blade'] = set_combine(sets.precast.WS, {back=CamuSavage})
        sets.precast.WS['Swift Blade'].Acc100 = set_combine(sets.precast.WS, {back=CamuSavage})
        sets.precast.WS['Swift Blade'].Acc200 = set_combine(sets.precast.WS.Acc200, {back=CamuSavage})
 
        sets.precast.WS['Last Stand'] = {ammo=gear.WSbullet,
			head=HercHelmWSD,
			body="Laksamana's Frac +3",
			hands="Meg. Gloves +2",
			legs=HercTrousersWSD_A,
			feet="Lanun Bottes +3",
			neck="Fotia Gorget",
			waist="Fotia Belt",
			left_ear="Moonshade Earring",
			right_ear="Ishvara Earring",
			left_ring="Dingir Ring",
			right_ring="Ilabrat Ring",
			back=CamuWS}
 
        sets.precast.WS['Last Stand'].Acc50 = sets.precast.WS['Last Stand']
		sets.precast.WS['Last Stand'].Acc100 = {ammo=gear.WSbullet,
			head="Mummu Bonnet +2",
			body="Laksamana's Frac +3",
			hands="Meg. Gloves +2",
			legs="Mummu Kecks +2",
			feet="Meg. Jam. +2",
			neck="Fotia Gorget",
			waist="Fotia Belt",
			left_ear="Moonshade Earring",
			right_ear="Enervating Earring",
			left_ring="Dingir Ring",
			right_ring="Ilabrat Ring",
			back=CamuWS}			
        sets.precast.WS['Last Stand'].Crit = sets.precast.WS['Last Stand'].Acc100
        sets.precast.WS['Last Stand'].Enmity = sets.precast.WS['Last Stand']
		
        sets.precast.WS['Wildfire'] = {ammo=gear.MAbullet,
			head=HercHelmMAB, 
			body="Lanun Frac +3",
			hands="Carmine Finger Gauntlets +1",
			legs=HercTrousersMAB,
			feet="Lanun Bottes +3",
			neck="Commodore Charm +2",
			waist="Fotia Belt",
			left_ear="Ishvara Earring",
			right_ear="Friomisi Earring",
			left_ring="Dingir Ring",
			right_ring="Ilabrat Ring",
			back=CamuWS}
		sets.precast.WS['Wildfire'].Acc50 = sets.precast.WS['Wildfire']
		sets.precast.WS['Wildfire'].Acc100 = sets.precast.WS['Wildfire']
		sets.precast.WS['Wildfire'].Crit = sets.precast.WS['Wildfire']
		sets.precast.WS['Wildfire'].Enmity = sets.precast.WS['Wildfire']
       
        sets.precast.WS['Leaden Salute'] = {ammo=gear.MAbullet,
			head="pixie hairpin +1",
			body="Lanun Frac +3",
			hands="Carmine Finger Gauntlets +1",
			legs=HercTrousersMAB,
			feet="Lanun Bottes +3",
			neck="Commodore Charm +2",
			waist="Fotia Belt",
			left_ear="Moonshade Earring",
			right_ear="Friomisi Earring",
			left_ring="Archon Ring",
			right_ring="Dingir Ring",
			back=CamuWS}
		sets.precast.WS['Leaden Salute'].Acc50 = sets.precast.WS['Leaden Salute']
		sets.precast.WS['Leaden Salute'].Acc100 = sets.precast.WS['Leaden Salute']
		sets.precast.WS['Leaden Salute'].Crit = sets.precast.WS['Leaden Salute']
		sets.precast.WS['Leaden Salute'].Enmity = sets.precast.WS['Leaden Salute']
               
        sets.precast.WS['Aeolian Edge'] = {ammo=gear.MAbullet,
			head=HercHelmMAB, 
			body="Lanun Frac +3",
			hands="Carmine Finger Gauntlets +1",
			legs=HercTrousersMAB,
			feet="Lanun Bottes +3",
			neck="Commodore Charm +2",
			left_ear="Moonshade Earring",
			right_ear="Friomisi Earring",
			left_ring="Acumen Ring",
			right_ring="Dingir Ring",
			back=CamuWS}
        
		sets.precast.WS['Hot Shot'] = {ammo=gear.RAbullet,
			head=HercHelmMAB, 
			body="Laksamana's Frac +3",
			hands="Meghanada Gloves +2",
			legs="Laksamana's Trews +3",
			feet="Lanun Bottes +3",
			neck="Commodore Charm +2",
			waist="Fotia Belt",
			left_ear="Moonshade Earring",
			right_ear="Friomisi Earring",
			left_ring="Dingir Ring",
			right_ring="Ilabrat Ring",
			back=CamuWS}
		sets.precast.WS['Hot Shot'].Acc50 = sets.precast.WS['Hot Shot']
		sets.precast.WS['Hot Shot'].Acc100 = sets.precast.WS['Hot Shot']
		
        -- Midcast Sets
        sets.midcast.FastRecast = {}
               
        -- Specific spells
        sets.midcast.Utsusemi = sets.midcast.FastRecast
		
		sets.midcast.Cure = set_combine(sets.midcast.FastRecast,{
			neck="Phalaina locket",ear1="Mendicant's earring",ear2="Lifestorm earring",--4 5
			ring1="ephedra ring",ring2="sirona's ring",--13					
			back="Solemnity cape",})
 
        sets.midcast.CorsairShot = {ammo=gear.QDbullet,
			head=HercHelmMAB,neck="Commodore Charm +2",ear1="Friomisi Earring",ear2="Dignitary's Earring",
			body="Lanun Frac +3",hands="Carmine Finger Gauntlets +1",ring1="Dingir Ring",ring2="Ilabrat Ring",
			back=CamuWS,waist="Kwahu Kachina Belt",legs=HercTrousersWS,feet="Lanun Bottes +3"}
 
		sets.midcast.CorsairShot.Mod = set_combine(sets.midcast.CorsairShot, {ammo=gear.QDbullet,--STP + Magic weakness
			body="Nisroch Jerkin",
			hands="Adhemar Wristbands", 
			legs="Adhemar Kecks",
			feet="Chasseur's Bottes +1",
			neck="Commodore Charm +2",
			waist="Kentarch Belt",
			left_ear="Neritic Earring",
			right_ear="Enervating Earring",
			left_ring="Rajas Ring",
			right_ring="Dingir Ring",
			back=CamuRA})
		
        sets.midcast.CorsairShot.Acc = set_combine(sets.midcast.CorsairShot,{
			head="Oshosi Mask",
			neck="Commodore Charm +2",
			body="Lanun Frac +3",
			hands="Lanun Gants +3",
			legs="Mummu Kecks +2",
			feet="Oshosi Leggings",
			left_ear="Dignitary's Earring",
			left_ring="Mummu Ring",
			back=CamuWS}) 
        sets.midcast.CorsairShot['Light Shot'] = set_combine(sets.midcast.CorsairShot.Acc,{}) 
        sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']
 
 
        -- Ranged gear
        sets.midcast.RA = {ammo=gear.RAbullet,
			head="Meghanada Visor +2",
			body="Nisroch Jerkin",
			hands="Adhemar Wristbands",
			legs="Adhemar Kecks",
			feet=HercBootsRA,
			neck="Commodore Charm +2",
			waist="Yemaya Belt",
			left_ear="Neritic Earring",
			right_ear="Enervating Earring",
			left_ring="Dingir Ring",
			--left_ring="Rajas Ring",
			right_ring="Ilabrat Ring",
			back=CamuRA}
		
 
        sets.midcast.RA.Acc50 = set_combine(sets.midcast.RA, {
			feet="Meg. Jam. +2",
			left_ring="Cacoethic Ring +1",			
		})
		
        sets.midcast.RA.Acc100 = {ammo=gear.RAbullet,
			head="Meghanada Visor +2",
			body="Laksamana's Frac +3",
			--hands="Mummu Wrists +2",
			hands="Lanun Gants +3",
			legs="Laksamana's Trews +3",
			feet="Meg. Jam. +2",
			neck="Commodore Charm +2",
			waist="Kwahu Kachina Belt",
			left_ear="Neritic Earring",
			right_ear="Enervating Earring",
			left_ring="Cacoethic Ring +1",
			right_ring="Ilabrat Ring",
			back=CamuRA}
        
		sets.midcast.RA.Crit = {ammo=gear.RAbullet,--4
			head="Meghanada Visor +2",
			body="Nisroch Jerkin",			--10
			--hands="Mummu Wrists +2",		--6
			legs="Mummu Kecks +2",			--7
			feet="Oshosi Leggings",			--8
			neck="Commodore Charm +2",
			waist="Kwahu Kachina Belt",		--4
			left_ear="Neritic Earring",
			right_ear="Enervating Earring",
			left_ring="Mummu Ring",			--3
			right_ring="Ilabrat Ring",
			back=CamuRA}					-->42
			
		sets.midcast.RA.Enmity = set_combine(sets.midcast.RA,{ammo=gear.RAbullet,
			body="Adhemar Jacket +1",			--8
			legs="Laksamana's Trews +3",	--8
			feet="Oshosi Leggings",			--10
			neck="Commodore Charm +2",			--3
			ear2="Enervating Earring",		--3
			ring1="Cacoethic Ring +1",		--5
		})									-->37
		sets.midcast.RA.TH = set_combine(sets.midcast.RA,{ammo=gear.RAbullet,
		    legs=HercTrousersTH,
			feet=HercBootsTH
			})

		sets.TripleShot	= {
			head="Oshosi Mask",
			body="Oshosi Vest",
			hands="Lanun Gants +3",
			legs="Oshosi Trousers",
			feet="Oshosi Leggings",}
       
        -- Sets to return to when not performing an action.
       
        -- Resting sets
        sets.resting = {ring1="Defending Ring"}
       
 
        -- Idle sets
        sets.idle = {--ammo=gear.RAbullet,
			head="rawhide mask",neck="Sanctity Necklace",ear1="Hearty Earring",ear2="Odnowa Earring +1",
			--body="Meghanada Cuirie +1",
			body="Mekosuchinae Harness",
			hands="Meghanada Gloves +2",ring1="Defending Ring",ring2="Shneddick ring",
			back="Moonbeam Cape",waist="Flume Belt",legs="Mummu Kecks +2",feet=HercBootsRefresh}
 
        --sets.idle.Town = {ammo=gear.QDbullet,}
               
 
        -- Defense sets
        sets.defense.PDT = {
			head="Meghanada Visor +2",			--4
			body="Meg. Cuirie +2",				--8
			hands="Meg. Gloves +2",				--4
			legs="Mummu Kecks +2",				--5 	5
			feet=HercBootsDT,				--7  5
			neck="Loricate Torque +1",			--6 	6
			left_ear="Hearty Earring",
			right_ear="Odnowa Earring +1",		--		2
			left_ring="Defending Ring", 		--10 	10
			right_ring="Shneddick Ring",
			back="Moonbeam Cape",--5  5
			}				--49 34
 
        sets.defense.Meva = {--pdt mdt meva mdb
			head="Oshosi Mask",--0  0  80  6
			body="Oshosi Vest",--0  0  96  8
			hands="Lanun Gants +3", --0  0  57  4
			legs="Oshosi Trousers",--0  0  121  8
			feet="Oshosi Leggings",--0  0  121  6
			neck="Loricate Torque +1",--6  6
			waist="Flume Belt",--4  0
			left_ear="Odnowa Earring +1",--0  2
			right_ear="Eabani Earring",--0  0  8
			left_ring="Defending Ring",--10 10
			right_ring="Shneddick Ring",
			back="Moonbeam Cape",--5  5
			}--25 22 489 32
       
 
        sets.Kiting = {ring2="Shneddick ring"}
        -- buff sets
        -- Engaged sets
 
        -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
        -- sets if more refined versions aren't defined.
        -- If you create a set with both offense and defense modes, the offense mode should be first.
        -- EG: sets.engaged.Dagger.Accuracy.Evasion
       
        -- Normal melee group
        sets.engaged = {--ammo=gear.RAbullet,
			head="Adhemar Bonnet +1",
			body="Adhemar Jacket +1",
			hands="Adhemar Wristbands +1",
			legs=HercTrousersQA,
			feet=HercBootsTA, 
			neck="Sanctity Necklace",
			waist="Sarissapho. Belt",
			left_ear="Brutal Earring",
			right_ear="Mache Earring",
			left_ring="Epona's Ring",
			right_ring="Petrov Ring",
			back=CamuMelee,}
		
		sets.engaged.Acc100 = set_combine(sets.engaged,{
			legs="Meg. Chausses +2",
			waist="Kentarch Belt",
			left_ear="Digni. Earring",
			right_ear="Mache Earring",
			})
        sets.engaged.Acc200 = set_combine(sets.engaged.Acc100,{
			--head="Mummu Bonnet +2",
			--feet="Mummu Gamash. +2",
			right_ring="Mummu Ring",
			back=CamuMelee,})
 
        sets.engaged.DW = set_combine(sets.engaged,{rear="Eabani Earring",waist="Shetal Stone"}) 
        sets.engaged.DW.Acc100 = set_combine(sets.engaged.Acc100,{}) 
        sets.engaged.DW.Acc200 = set_combine(sets.engaged.Acc200,{})
 
        sets.engaged.Ranged = {--ammo=gear.RAbullet,
			head="Oshosi Mask",
			body="Oshosi Vest",
			hands="Adhemar Wristbands",
			legs="Oshosi Trousers",
			feet="Oshosi Leggings",
			neck="Loricate Torque +1",
			waist="Sarissapho. Belt",
			left_ear="Hearty Earring",
			right_ear="Odnowa Earring +1",
			left_ring="Defending Ring",
			right_ring="Shneddick Ring",
			back=CamuMelee,}
			sets.engaged.DW.Ranged = sets.engaged.Ranged
               
		sets.engaged.PDT30 = set_combine(sets.engaged,{			
			neck="Loricate Torque +1",--6  6
			left_ring="Defending Ring",--10 10
			right_ring="Ilabrat Ring",
			})
		sets.engaged.Acc100.PDT30 = sets.engaged.PDT30
		sets.engaged.Acc200.PDT30 = sets.engaged.PDT30
		
		sets.engaged.DW.PDT30 = set_combine(sets.engaged.PDT30,{rear="Eabani Earring",waist="Shetal Stone"}) 
		sets.engaged.DW.Acc100.PDT30 = set_combine(sets.engaged.DW.PDT30,{lear="Mache Earring",legs="Meghanada Chausses +2",feet="Meghanada Jambeaux +2"})
		sets.engaged.DW.Acc200.PDT30 = set_combine(sets.engaged.DW.Acc100.PDT30,{neck="Sanctity Necklace",rear="Dignitary's Earring"})
			
		sets.engaged.PDT40 = set_combine(sets.engaged,{	
			legs="Mummu Kecks +2",
			feet=HercBootsDT,
			neck="Loricate Torque +1",--6  6
			left_ring="Defending Ring",--10 10
			right_ring="Ilabrat Ring",
			})	   							
		sets.engaged.Acc100.PDT40 = sets.engaged.PDT40
		sets.engaged.Acc200.PDT40 = sets.engaged.PDT40
		
		sets.engaged.DW.PDT40 = set_combine(sets.engaged.PDT40,{rear="Eabani Earring",waist="Shetal Stone"}) 
		sets.engaged.DW.Acc100.PDT40 = sets.engaged.PDT40
		sets.engaged.DW.Acc200.PDT40 = sets.engaged.PDT40
		
		sets.engaged.Meva = set_combine(sets.defense.Meva, {
			right_ring="Shadow Ring",
			})					
		sets.engaged.DW.Meva = sets.engaged.Meva
		sets.engaged.DW.Acc100.Meva = sets.engaged.Meva
		sets.engaged.DW.Acc200.Meva = sets.engaged.Meva
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if buffactive['Terror'] or buffactive['Stun'] or buffactive['Petrification'] then
            eventArgs.cancel = true
			equip(sets.defense.PDT)
			add_to_chat(122, "Unable to act, action cancelled")
            return	
	end

	if spell.type == 'WeaponSkill' then
		if spell.target.distance >23 then
			add_to_chat(122, "Out of range, action cancelled")
			cancel_spell()
			return
		elseif state.DefenseMode.value ~= 'None' then
			-- Don't gearswap for weaponskills when Defense is on.
			eventArgs.handled = true
		end
	end
	if spell.en == 'Wildfire' and wildshot == false then
		--cancel_spell()
		--wildshot = true
		--send_command('input /jobability "Fire Shot" <t>')
		--eventArgs.cancel = true
		--return wildshot
	end
	
	if spell.type == 'Ninjutsu' then 	
		if player.inventory["Shihei"].count < 10 then
					add_to_chat(102, 'Low on Shihei!')
		end
	end
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    -- gear sets
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
        equip(sets.precast.LuzafRing)
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'PreNuke' then
		classes.CustomClass = 'Mod'
	elseif spell.english == "Double-Up" then	
    end
	
    if spell.english == 'Fold' and buffactive['Bust'] == 2 then
		add_to_chat(122, "double bust")
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
	end	
	if spell.english == 'Earth Shot' then
        if state.QuickdrawMode.value == 'Fire' then
            send_command('input /jobability "Fire Shot" <t>')
            eventArgs.cancel = true
            return	
		elseif state.QuickdrawMode.value == 'Ice' then
            send_command('input /jobability "Ice Shot" <t>')
            eventArgs.cancel = true
            return	
		elseif state.QuickdrawMode.value == 'Wind' then
            send_command('input /jobability "Wind Shot" <t>')
            eventArgs.cancel = true
            return	
		elseif state.QuickdrawMode.value == 'Earth' then
            send_command('input /jobability "Earth Shot" <t>')
            eventArgs.cancel = true
            return	
		elseif state.QuickdrawMode.value == 'Thunder' then
            send_command('input /jobability "Thunder Shot" <t>')
            eventArgs.cancel = true
            return	
		elseif state.QuickdrawMode.value == 'Water' then
            send_command('input /jobability "Water Shot" <t>')
            eventArgs.cancel = true
            return	
		elseif state.QuickdrawMode.value == 'Light' then
            send_command('input /jobability "Light Shot" <t>')
            eventArgs.cancel = true
            return	
		elseif state.QuickdrawMode.value == 'Dark' then
            send_command('input /jobability "Dark Shot" <t>')
            eventArgs.cancel = true
            return	
		end
	end
end
 
function job_post_precast(spell, action, spellMap, eventArgs)	
	if spell.action_type=="Ranged Attack" then
		if (buffactive['Flurry'] or buffactive["Courser's Roll"]) then--and state.flurrymode.value then
			equip(sets.Flurry)
			add_to_chat(122, "Flurry")
			
		else
			equip(sets.precast.RA)
		end
	end
	if spell.en == 'Leaden Salute' then
		if player.tp > 2699 then			
			add_to_chat(122, "Full TP")
			equip(sets.ws_earring)
		end
		if spell.element == world.day_element or spell.element == world.weather_element then
			equipSet = set_combine(equipSet, {waist="Hachirin-No-Obi"})
			add_to_chat(122, "Weather WS")
			equip(equipSet)
		end
	end
	if spell.en == 'Savage Blade' and state.OffenseMode.current == 'Acc200' then 
		equip(sets.precast.WS['Savage Blade'].Acc200)
	end
end
 
 
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type=="Ranged Attack" and buffactive['Triple Shot'] then
		--add_to_chat(122, "ranged attack")
		equip(sets.TripleShot)
	end
	
	if spell.type == 'CorsairShot' then	
		if spell.element == world.day_element or spell.element == world.weather_element then
			equipSet = set_combine(equipSet, {waist="Hachirin-No-Obi"})
--			add_to_chat(122, "Weather WS")
			equip(equipSet)
		end
	end
	if spell.en == 'Fire Shot' and wildshot then
		equip({feet="Chasseur's Bottes +1"})
	end
end	
	
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
	if spell.en == 'Dia' then
		add_to_chat(122, "Auto Dia Upgrade")		
        send_command('wait 2.6;input /jobability "Light Shot" <t>;wait .5;input /jobability "Light Shot" <t>;wait .3;input /jobability "Light Shot" <t>')
	elseif spell.en == 'Dia II' then
		add_to_chat(122, "Auto Dia Upgrade")		
        send_command('wait 2.9;input /jobability "Light Shot" <t>;wait .5;input /jobability "Light Shot" <t>;wait .3;input /jobability "Light Shot" <t>')
	end	
	if spell.en == 'Fire Shot' and wildshot then
		send_command('wait .5;input /weaponskill "Wildfire" <t>')
		add_to_chat(122, "wild shot")
	end	
	if spell.en == 'Wildfire' then
		wildshot = false
	end
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff, gain)
	local enfeeb = string.lower(buff)
	if ( enfeeb == "stun" or enfeeb == "petrification" or enfeeb == "terror" or enfeeb == "sleep" ) and not gain then
		if player.status == 'Engaged' and autora then
			send_command('wait .3;gs c shoot')
			add_to_chat(122, "UN-ENFEEBLED")
		end
	elseif ( enfeeb == "stun" or enfeeb == "petrification" or enfeeb == "terror" or enfeeb == "sleep" ) and gain then	
			equip(sets.defense.PDT)
			add_to_chat(122, "Unable to act, PDT gear equipped")
	end	
	if buff == "Triple Shot" then
		if buffactive['Triple Shot'] then
			add_to_chat(122, 'buff triple shot')
		else add_to_chat(122, 'loss triple shot')
		end
	end
	--add_to_chat(122, 'buff gained: ' ..enfeeb.. ' ')
end 

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
    if buffactive['Transcendancy'] then
        return 'Brew'
    end
end
 
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
   
    msg = msg .. 'Off.: '..state.OffenseMode.current
    msg = msg .. ', Rng.: '..state.RangedMode.current
    msg = msg .. ', WS.: '..state.WeaponskillMode.current
    msg = msg .. ', QD.: '..state.CastingMode.current
 
    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
   
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
   
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end
 
    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end
 
    msg = msg .. ', Roll Size: ' .. (state.LuzafRing.value and 'Large') or 'Small'
   
    add_to_chat(122, msg)
 
    eventArgs.handled = true
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=3, unlucky=7, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=4, unlucky=8, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
        ["Runeist's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Evasion"},
        ["Naturalist's Roll"]   = {lucky=3, unlucky=7, bonus="Enhancing Magic Duration"},
    }
end
 
function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'
 
    if rollinfo then
        add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end
 
 
-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1
   
    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- physical weaponskills
                bullet_name = gear.WSbullet
            else
                -- magical weaponskills
                bullet_name = gear.MAbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end
   
    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
   
    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end
       
	if spell.type == 'CorsairShot' and player.inventory["Trump Card"].count < 10 then
					add_to_chat(104, 'Low on trump cards!')
	end
       
   
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    -- if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        -- add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        -- eventArgs.cancel = true
        -- return
    -- end
   
    -- Low ammo warning.
    -- if spell.type ~= 'CorsairShot' and state.warned.value == false
        -- and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        -- local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        -- --local border = string.repeat("*", #msg)
        -- local border = ""
        -- for i = 1, #msg do
            -- border = border .. "*"
        -- end
       
        -- add_to_chat(104, border)
        -- add_to_chat(104, msg)
        -- add_to_chat(104, border)
 
        -- state.warned:set()
    -- elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        -- state.warned:reset()
    -- end

end

function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == "Nusku Shield" or player.equipment.sub == 'empty' then
	--	add_to_chat(122,"1h mode")
        state.CombatForm:reset()
    else
	--	add_to_chat(122,"DW mode")
        state.CombatForm:set('DW')
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 19)
end


accmode = 0;
runaway = 0;
rangeswap = 0;
use_dualbox=false
function job_self_command(cmdParams, eventArgs)
	command = cmdParams[1]:lower()
	--if player.tp < 1000 then
	if command=='shoot' then
		send_command('input /shoot <t>')
		if player.status == 'Engaged' then
			autora = true
		end
	elseif command=='checkandshoot' then
		if player.status == 'Engaged' and autora == true and not midshot_real then
			send_command('input /shoot <t>')
			midshot = true
		end
	elseif command=='shootstop' then
		--print('stopping ')
		--print(autora)
		autora = false
		midshot = false
		midshot_real = false	
	end
	--end
end



-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
	if state.Buff[buff_name] then
		equip(sets.buff[buff_name] or {})
		eventArgs.handled = true
	end

	--    if buffactive['Haste'] and player.tp < 200 and usehasteknife == 1 then
	--	    sets.engaged = set_combine(sets.engaged,sets.Mainhand)
	--	    sets.idle = set_combine(sets.idle,sets.Mainhand)
	--    elseif player.tp < 200 and usehasteknife == 1 then 
	--		    sets.engaged = set_combine(sets.engaged,sets.Haste)
	--		    sets.idle = set_combine(sets.idle,sets.Haste)
	--    end
end


require 'actions-custom'


midshot = false
function event_action(raw_actionpacket)
	local actionpacket = ActionPacket.new(raw_actionpacket)
	
	
	actionstr = actionpacket:get_category_string() 
	
	if not autora and actionstr ~= 'weaponskill_begin' and actionstr ~= 'weaponskill_finish' and player.status == 'Engaged' then 
		if player.tp >= 1000 and state.autows.current == 'on' then
			send_command('input /ws "'..state.default_ws.current..'" <t>')
		else	
		--return 	
		end
	end
	
	if actionstr == 'ranged_begin' then
		--print('ranged begin')
		midshot_real=true
	end
	if actionstr == 'ranged_finish' and player.status == 'Engaged' then
		--print('ranged end')
		--send_command('wait .5;input /shoot <t>')
		--send_command('wait .6;input /shoot <t>')
		midshot=false
		midshot_real=false
		--print('autora')
		if autora and player.tp >= 1000 and state.autows.current == 'on' then
			--send_command('input /ws "'..state.default_ws.current..'" <t>')
			send_command('wait 1.3;input /ws "'..state.default_ws.current..'" <t>;wait 3.1;gs c checkandshoot')
		elseif autora then 
			--send_command('wait .7;input /shoot <t>')
			--send_command('wait .8;input /shoot <t>')
			--send_command('wait .9;input /shoot <t>')
			--send_command('wait .6;gs c checkandshoot')
			--send_command('wait .7;gs c checkandshoot')
			--send_command('wait .8;gs c checkandshoot')
			--send_command('wait .9;gs c checkandshoot')
			--send_command('wait 1;gs c checkandshoot')
			send_command('wait 1.3;gs c checkandshoot')
			--send_command('wait 1;gs c checkandshoot')
			--send_command('wait 1.3;gs c checkandshoot')
		end
	end
	
end
function ActionPacket.open_raw_listener(funct)
    if not funct or type(funct) ~= 'function' then return end
    local id = windower.raw_register_event('incoming chunk',function(id, org, modi, is_injected, is_blocked)
        if id == 0x28 then
            local act_org = windower.packets.parse_action(org)
            act_org.size = org:byte(5)
            local act_mod = windower.packets.parse_action(modi)
            act_mod.size = modi:byte(5)
            return act_to_string(org,funct(act_org,act_mod))
        end
    end)
    return id
end


ActionPacket.open_raw_listener(event_action)

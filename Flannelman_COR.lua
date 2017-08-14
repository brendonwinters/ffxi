-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
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
    state.OffenseMode:options('Ranged', 'Melee', 'Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.CastingMode:options('Normal', 'Resistant', 'PreNuke')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
 
	state.QuickdrawMode = M('None','Fire','Ice','Wind','Earth','Thunder','Water','Light','Dark')
	
    gear.RAbullet = "Bronze Bullet"
    gear.WSbullet = "Oberon's Bullet"
    gear.MAbullet = "Bronze Bullet"
    gear.QDbullet = "Animikii Bullet"
	
    
	options.ammo_warning_limit = 15
 
 
    send_command('bind !` gs c toggle luzafring')
	send_command('bind @` gs c cycle QuickdrawMode')
    -- Additional local binds
	select_default_macro_book()
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
		HercHelmMAB={ name="Herculean Helm",  augments={'Mag. Acc.+13 "Mag.Atk.Bns."+13','INT+12','Mag. Acc.+8','"Mag.Atk.Bns."+13',}}
		HercHelmDT={ name="Herculean Helm", augments={'Weapon skill damage +3%','Phys. dmg. taken -2%','Damage taken-3%','Accuracy+2 Attack+2',}}	
		HercHelmTH={ name="Herculean Helm", augments={'Weapon skill damage +2%','"Store TP"+5','"Treasure Hunter"+1','Accuracy+15 Attack+15',}}	
		HercHelmWSD={ name="Herculean Helm", augments={'Weapon skill damage +3%','STR+6','Accuracy+10','Attack+3',}}
		
		HercVest={ name="Herculean Vest", augments={'Accuracy+23 Attack+23','"Triple Atk."+3','AGI+9','Accuracy+15','Attack+12',}}
		
		HercGlovesDT={ name="Herculean Gloves", augments={'Damage taken-3%','"Mag.Atk.Bns."+24','Accuracy+13 Attack+13',}}
		HercGlovesTH={ name="Herculean Gloves", augments={'STR+10','"Mag.Atk.Bns."+4','"Treasure Hunter"+1','Accuracy+2 Attack+2',}}
		HercGlovesWSD={ name="Herculean Gloves", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +3%',}}
		
		HercLegsPhalanx={ name="Herculean Trousers", augments={'Phys. dmg. taken -2%','Pet: Accuracy+22 Pet: Rng. Acc.+22','Phalanx +2','Accuracy+7 Attack+7','Mag. Acc.+2 "Mag.Atk.Bns."+2',}}
		HercLegsAcc={ name="Herculean Trousers", augments={'Accuracy+20 Attack+20','Crit. hit damage +3%','DEX+5','Accuracy+12','Attack+15',}}
		HercLegsWSD={ name="Herculean Trousers", augments={'Attack+6','Weapon skill damage +3%','STR+15',}}
		HercLegsMAB={ name="Herculean Trousers", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Store TP"+1','"Mag.Atk.Bns."+15',}}		
		
		HercBootsDT={ name="Herculean boots", augments={'Damage taken-4%','AGI+1','Accuracy+12',}}
		HercBootsDmg={ name="Herculean Boots", augments={'Accuracy+25 Attack+25','Crit.hit rate+2','DEX+11','Accuracy+14','Attack+11',}}
		HercBootsRefresh={ name="Herculean Boots", augments={'Crit.hit rate+1','Pet: Attack+9 Pet: Rng.Atk.+9','"Refresh"+1','Accuracy+4 Attack+4','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}
		HercBootsDW={ name="Herculean Boots", augments={'Attack+17','"Dual Wield"+6','Accuracy+15',}}
		HercBootsWSD={ name="Herculean Boots", augments={'Attack+24','Weapon skill damage +2%','STR+12',}}
		
		
		WScape = {name="Gunslinger's Cape", augments={'"Mag.Atk.Bns."+1','Enmity-5','Weapon skill damage +4%'}}
		PRcape = {name="Gunslinger's Cape", augments={'"Mag.Atk.Bns."+1','Enmity-2','"Phantom Roll" ability delay -5'}}
        -- Precast Sets
 
        -- Precast sets to enhance JAs
       
        sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac"}
        sets.precast.JA['Snake Eye'] = {legs="Lanun Culottes"}
        sets.precast.JA['Wild Card'] = {feet="Lanun Bottes"}
        sets.precast.JA['Random Deal'] = {body="Lanun Frac"}
        
       
        sets.precast.CorsairRoll = {head="Lanun Tricorne",hands="Chasseur's Gants", ring1="Barataria Ring", back="Camulus's Mantle"}
       
        sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Navarch's Culottes +2"})
        sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's Bottes"})
        sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chasseur's Tricorne"})
        sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac"})
        sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants"})
       
        sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
        sets.precast.FoldDoubleBust = {hands="Lanun Gants"}
       
        sets.precast.CorsairShot = { gear.QDbullet}
       
 
        -- Waltz set (chr and vit)
        sets.precast.Waltz = {}
               
        -- Don't need any special gear for Healing Waltz.
        sets.precast.Waltz['Healing Waltz'] = {}
 
        -- Fast cast sets for spells
       
        sets.precast.FC = {
			head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
			body="Emet Harness +1",
			hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
			legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
			feet={ name="Carmine Greaves", augments={'HP+60','STR+10','INT+10',}},
			neck="Orunmila's Torque",
			waist="Flume Belt +1",
			left_ear="Etiolation Earring",
			right_ear="Loquac. Earring",
			left_ring="Lebeche Ring",
			right_ring="Weather. Ring",}
 
        sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
 
 
        sets.precast.RA = {
			head="Chasseur's Tricorne",
			hands="Lanun Gants",
			legs="Lanun Culottes",
			feet="Meg. Jam. +1",
			back="Navarch's Mantle",}
 
       
        -- Weaponskill sets
        -- Default set for any weaponskill that isn't any more specifically defined
        sets.precast.WS = {
			head="Meghanada Visor +1",
			body=HercVest,
			hands="Meg. Gloves +1",
			legs="Samnuha Tights",
			feet=HercBootsDmg,
			neck="Fotia Gorget",
			waist="Fotia Belt",
			left_ear="Brutal Earring",
			right_ear="Moonshade Earring",
			left_ring="Apate Ring",
			right_ring="Epona's Ring",
			back="Lupine Cape",}
 
 
        -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
        sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {body="Abnoba Kaftan",ting1="Begrudging Ring"})
 
        sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})
 
        sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
        sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
 
        sets.precast.WS['Last Stand'] = {ammo=gear.WSbullet,    
			head={ name="Herculean Helm", augments={'Weapon skill damage +3%','STR+6','Accuracy+10','Attack+3',}},
			body="Meg. Cuirie +1",
			hands="Meg. Gloves +1",
			legs={ name="Herculean Trousers", augments={'Attack+6','Weapon skill damage +3%','STR+15',}},
			feet={ name="Herculean Boots", augments={'Attack+24','Weapon skill damage +2%','STR+12',}},
			neck="Fotia Gorget",
			waist="Fotia Belt",
			left_ear="Ishvara Earring",
			right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +25',}},
			left_ring="Apate Ring",
			right_ring="Cacoethic Ring +1",
			back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+12 /Mag. Dmg.+12','Weapon skill damage +10%',}},
}
 
        sets.precast.WS['Last Stand'].Acc = {ammo=gear.WSbullet,
			head="Meghanada Visor +1",
			body="Meghanada Cuirie",
			hands="Meg. Gloves +1",
			legs="Meg. Chausses +1",
			feet="Meg. Jam. +1",
			neck="Fotia Gorget",
			waist="Fotia Belt",
			left_ear="Moonshade Earring", 
			right_ear="Ishvara Earring",
			left_ring="Cacoethic Ring +1",
			right_ring="Apate Ring",
			back="Camulus's Mantle",}
 
        sets.precast.WS['Wildfire'] = {ammo=gear.MAbullet,
			head={ name="Herculean Helm", augments={'Mag. Acc.+13 "Mag.Atk.Bns."+13','INT+12','Mag. Acc.+8','"Mag.Atk.Bns."+13',}},
			body={ name="Samnuha Coat", augments={'Mag. Acc.+13','"Mag.Atk.Bns."+14','"Fast Cast"+3','"Dual Wield"+4',}},
			hands={ name="Herculean Gloves", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +3%',}},
			legs={ name="Herculean Trousers", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Store TP"+1','"Mag.Atk.Bns."+15',}},
			feet={ name="Herculean Boots", augments={'Crit.hit rate+1','Pet: Attack+9 Pet: Rng.Atk.+9','"Refresh"+1','Accuracy+4 Attack+4','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
			neck="Sanctity Necklace",
			waist="Eschan Stone",
			left_ear="Friomisi Earring",
			right_ear="Hecate's Earring",
			left_ring="Petrov Ring",
			right_ring="Apate Ring",
			back="Camulus's Mantle",
		}
 
       
        sets.precast.WS['Leaden Salute'] = {ammo=gear.MAbullet,
			head="Pixie Hairpin +1",
			body={ name="Samnuha Coat", augments={'Mag. Acc.+13','"Mag.Atk.Bns."+14','"Fast Cast"+3','"Dual Wield"+4',}},
			hands={ name="Herculean Gloves", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +3%',}},
			legs={ name="Herculean Trousers", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Store TP"+1','"Mag.Atk.Bns."+15',}},
			feet={ name="Herculean Boots", augments={'Crit.hit rate+1','Pet: Attack+9 Pet: Rng.Atk.+9','"Refresh"+1','Accuracy+4 Attack+4','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
			neck="Sanctity Necklace",
			waist="Eschan Stone",
			left_ear="Friomisi Earring",
			right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +25',}},
			left_ring="Archon Ring",
			right_ring="Apate Ring",
			back="Camulus's Mantle",
		}
               
        sets.precast.WS['Aeolian Edge'] = {ammo=gear.QDbullet,
			head={ name="Herculean Helm", augments={'Mag. Acc.+13 "Mag.Atk.Bns."+13','INT+12','Mag. Acc.+8','"Mag.Atk.Bns."+13',}},
			body={ name="Samnuha Coat", augments={'Mag. Acc.+13','"Mag.Atk.Bns."+14','"Fast Cast"+3','"Dual Wield"+4',}},
			hands={ name="Herculean Gloves", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +3%',}},
			legs={ name="Herculean Trousers", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Store TP"+1','"Mag.Atk.Bns."+15',}},
			feet={ name="Herculean Boots", augments={'Crit.hit rate+1','Pet: Attack+9 Pet: Rng.Atk.+9','"Refresh"+1','Accuracy+4 Attack+4','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
			neck="Sanctity Necklace",
			waist="Eschan Stone",
			left_ear="Friomisi Earring",
			right_ear="Hecate's Earring",
			left_ring="Petrov Ring",
			right_ring="Apate Ring",
			back="Camulus's Mantle",
		}
       
       
        -- Midcast Sets
        sets.midcast.FastRecast = {}
               
        -- Specific spells
        sets.midcast.Utsusemi = sets.midcast.FastRecast
 
        sets.midcast.CorsairShot = {ammo=gear.QDbullet,
			head={ name="Herculean Helm", augments={'Mag. Acc.+13 "Mag.Atk.Bns."+13','INT+12','Mag. Acc.+8','"Mag.Atk.Bns."+13',}},
			body={ name="Samnuha Coat", augments={'Mag. Acc.+13','"Mag.Atk.Bns."+14','"Fast Cast"+3','"Dual Wield"+4',}},
			hands={ name="Herculean Gloves", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +3%',}},
			legs={ name="Herculean Trousers", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Store TP"+1','"Mag.Atk.Bns."+15',}},
			feet={ name="Herculean Boots", augments={'Crit.hit rate+1','Pet: Attack+9 Pet: Rng.Atk.+9','"Refresh"+1','Accuracy+4 Attack+4','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
			neck="Sanctity Necklace",
			waist="Eschan Stone",
			left_ear="Friomisi Earring",
			right_ear="Hecate's Earring",
			left_ring="Petrov Ring",
			right_ring="Apate Ring",
			back={ name="Gunslinger's Cape", augments={'Enmity-5','"Mag.Atk.Bns."+1','Weapon skill damage +4%',}},
		}
 
        sets.midcast.CorsairShot.Acc = {ammo=gear.QDbullet,
			head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
			body={ name="Samnuha Coat", augments={'Mag. Acc.+13','"Mag.Atk.Bns."+14','"Fast Cast"+3','"Dual Wield"+4',}},
			hands="Meg. Gloves +1",
			legs="Meg. Chausses +1",
			feet="Meg. Jam. +1",
			neck="Sanctity Necklace",
			waist="Eschan Stone",
			left_ear="Lempo Earring",
			right_ear="Gwati Earring",
			left_ring="Weather. Ring",
			right_ring="Sangoma Ring",
			back="Camulus's Mantle",
		}
		
		sets.midcast.CorsairShot.Mod = set_combine(sets.midcast.CorsairShot, {feet="Chasseur's Bottes"})
		
        sets.midcast.CorsairShot['Light Shot'] = sets.midcast.CorsairShot.Acc
 
        sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']
 
 
        -- Ranged gear
        sets.midcast.RA = {ammo=gear.RAbullet,
			head={ name="Herculean Helm", augments={'Weapon skill damage +2%','"Store TP"+5','"Treasure Hunter"+1','Accuracy+15 Attack+15',}},
			body={ name="Herculean Vest", augments={'Accuracy+23 Attack+23','"Triple Atk."+3','AGI+9','Accuracy+15','Attack+12',}},
			hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
			legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
			feet="Meg. Jam. +1",
			neck="Sanctity Necklace",
			waist="Eschan Stone",
			left_ear="Brutal Earring",
			right_ear="Neritic Earring",
			left_ring="Petrov Ring",
			right_ring="Rajas Ring",
			back={ name="Gunslinger's Cape", augments={'Enmity-5','"Mag.Atk.Bns."+1','Weapon skill damage +4%',}},}
               
        sets.midcast.TS = sets.midcast.RA 
 
        sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
			head="Meghanada Visor +1",
			body="Meghanada Cuirie",
			hands="Meg. Gloves +1",
			legs="Meg. Chausses +1",}) 
       
 
 
       
        -- Sets to return to when not performing an action.
       
        -- Resting sets
        sets.resting = {neck="Wiglen Gorget",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
       
 
        -- Idle sets
        sets.idle = {ammo=gear.RAbullet,
			head=HercHelmDT,
            body="Emet Harness +1",
			hands={ name="Herculean Gloves", augments={'Damage taken-3%','"Mag.Atk.Bns."+24','Accuracy+13 Attack+13',}},
			legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
			feet={ name="Herculean Boots", augments={'Damage taken-4%','AGI+1','Accuracy+12',}},
			neck="Sanctity Necklace",
			waist="Flume Belt ++",
			left_ear="Hearty Earring",
			right_ear="Eabani Earring",
			left_ring="Defending Ring",
			right_ring="Archon Ring",
			back="Shadow Mantle",
		}
 
        sets.idle.Town = sets.idle
               
 
        -- Defense sets
        sets.defense.PDT = {
			head="Fugacity Beret +1",neck="Twilight Torque",
			body="Lanun Frac +1",hands="Taeon Gloves",ring1="Dark Ring",ring2="Shneddick ring",
			back="shadow mantle",waist="Flume Belt +1",legs="Chas. Culottes +1",feet="Lanun Bottes +1"}
 
        sets.defense.MDT = {
			head="Fugacity Beret +1",neck="Twilight Torque",
			body="Lanun Frac +1",hands="Taeon Gloves",ring1="Dark Ring",ring2="Shneddick ring",
			back="Shadow Mantle",waist="Flume Belt +1",legs="Chas. Culottes +1",feet="Chass. Bottes +1"}
       
 
        sets.Kiting = {legs="Carmine Cuisses +1"}
        -- buff sets
        sets.buff['Triple Shot'] = {body="Chasseur's Frac +1"}
        -- Engaged sets
 
        -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
        -- sets if more refined versions aren't defined.
        -- If you create a set with both offense and defense modes, the offense mode should be first.
        -- EG: sets.engaged.Dagger.Accuracy.Evasion
       
        -- Normal melee group
        sets.engaged.Melee = {ammo=gear.RAbullet,
            head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
			body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
			hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
			legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
			feet={ name="Herculean Boots", augments={'Attack+17','"Dual Wield"+6','Accuracy+15',}},
			neck="Lissome Necklace",
			waist="Shetal Stone",
			left_ear="Suppanomimi",
			right_ear="Eabani Earring",
			left_ring="Hetairoi Ring",
			right_ring="Epona's Ring",
			back="Lupine Cape",
		}
       
        sets.engaged.Acc = sets.midcast.RA
 
        sets.engaged.Melee.DW = sets.engaged.Melee
 
        sets.engaged.Acc.DW = sets.midcast.RA
 
        sets.engaged.Ranged = sets.engaged.Melee 
               
        sets.engaged.TS = sets.engaged.Melee
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
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
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
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
 
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
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
    if newStatus == 'Engaged' and player.equipment.main == 'Chatoyant Staff' then
        state.OffenseMode:set('Ranged')
    end
end
function job_self_command(cmdParams, eventArgs)
        if command == 'coffer' then
                cycle = 0
                invCount = windower.ffxi.get_bag_info(0).count
                if invCount == 80 then
                        add_to_chat(140,'Inv. full. Ending cycle')
                elseif player.inventory["Velkk Coffer"] then
                        send_command('input /item "Velkk Coffer"')
                        cycle = 1
                else
                        add_to_chat(140,'No Coffers found in inv.')
                        send_command('findall Velkk Coffer')
                end
                if cycle == 1 then
                        send_command('wait 2;gc c coffer')
                end
        end
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
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
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
       
        if spell.type == 'CorsairShot' and player.inventory["Trump Card"] and player.inventory["Trump Card"].count < 10 then
                        add_to_chat(104, 'Low on trump cards!')
        end
       
   
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end
   
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end
       
        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)
 
        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 19)
end


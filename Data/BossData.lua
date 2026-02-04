-- Dungeon Spam Tracker - Boss Stats and Abilities Data
-- Compiled from WoWHead TBC Classic guides and community sources
local ADDON_NAME, DST = ...

DST.BossData = {}
local B = DST.BossData

-- Boss information for TBC dungeons
-- Format: health, mana, abilities, mechanics
B.Bosses = {
    ["Hellfire Ramparts"] = {
        ["Watchkeeper Gargolmar"] = {
            health = {normal = "33,000", heroic = "91,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Mortal Wound", desc = "Stacks up to 10 times, reducing healing by 5%-50% (10% per stack in Heroic). Cannot be dispelled."},
                {name = "Charge", desc = "Charges the furthest player regardless of threat."},
                {name = "Overpower", desc = "Deals increased damage to the tank."},
                {name = "Retaliation", desc = "Reflects melee attacks."},
            },
            adds = "Summons 2x Hellfire Watchers (healers) - can be crowd controlled",
            notes = "Tank faces boss away from group. DPS focuses on killing Hellfire Watcher adds first."
        },
        ["Omor the Unscarred"] = {
            health = {normal = "59,836", heroic = "160,000"},
            mana = {normal = "12,840", heroic = "25,000"},
            abilities = {
                {name = "Treacherous Aura", desc = "Curse dealing 350-450 damage per tick to nearby players (4000-5000 in Heroic). Spread out!"},
                {name = "Shadow Bolt", desc = "Deals shadow damage to random targets."},
                {name = "Shadow Whip", desc = "Knocks players into the air."},
                {name = "Demonic Shield", desc = "Below 20% HP, reflects spells periodically."},
                {name = "Summon Fiendish Hound", desc = "Summons adds that must be killed."},
            },
            notes = "Spread out to minimize Treacherous Aura damage. Stop DPS below 20% when Demonic Shield is active."
        },
        ["Nazan & Vazruden"] = {
            health = {normal = "33,000 each", heroic = "95,000 each"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Vazruden's Mark", desc = "Marks targets for Nazan to attack with fireballs."},
                {name = "Fireball", desc = "Air phase only - deals 2000-3000 damage plus fire DOT (4500/tick in Heroic)."},
                {name = "Liquid Flame", desc = "Creates fire patches on ground - move out immediately!"},
                {name = "Cone of Fire", desc = "Frontal cone attack when landed."},
                {name = "Bellowing Roar", desc = "(Heroic only) Fears entire party."},
            },
            notes = "Burn down Vazruden to 50% HP to force Nazan to land. Avoid fire patches at all costs. Tank faces Nazan away from group."
        },
    },
    ["Blood Furnace"] = {
        ["The Maker"] = {
            health = {normal = "47,000", heroic = "127,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Domination", desc = "Mind controls a random player for 6 seconds."},
                {name = "Throw Beaker", desc = "Throws exploding beakers dealing AoE damage."},
                {name = "Adrenal Surge", desc = "Increases attack speed and damage."},
            },
            notes = "Stay spread out. Be ready to CC/interrupt mind-controlled players."
        },
        ["Broggok"] = {
            health = {normal = "52,000", heroic = "139,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Poison Bolt", desc = "Deals heavy Nature damage and applies poison DOT."},
                {name = "Poison Cloud", desc = "Large AoE poison cloud - stay out of it!"},
                {name = "Slime Spray", desc = "Frontal cone poison attack."},
            },
            notes = "Tank faces boss away. Ranged and healer stay at max range. Have poison removal ready."
        },
        ["Keli'dan the Breaker"] = {
            health = {normal = "58,000", heroic = "155,000"},
            mana = {normal = "15,000", heroic = "28,000"},
            abilities = {
                {name = "Burning Nova", desc = "5 second cast AoE explosion dealing massive fire damage. RUN AWAY!"},
                {name = "Shadow Bolt Volley", desc = "Hits multiple targets with shadow damage."},
                {name = "Corruption", desc = "Shadow damage DOT on random players."},
                {name = "Evocation", desc = "Channeled spell to restore mana."},
            },
            notes = "CRITICAL: When Burning Nova cast starts, everyone must run to maximum range (40+ yards) or die instantly."
        },
    },
    ["Shattered Halls"] = {
        ["Grand Warlock Nethekurse"] = {
            health = {normal = "77,000", heroic = "207,000"},
            mana = {normal = "18,000", heroic = "32,000"},
            abilities = {
                {name = "Death Coil", desc = "Heals Nethekurse for 50% of target's health and horrifies target for 3 seconds."},
                {name = "Dark Spin", desc = "AoE shadow damage attack - get out of melee range!"},
                {name = "Shadow Cleave", desc = "Frontal cone shadow damage attack."},
                {name = "Mind Flay", desc = "Channeled shadow damage that slows the target."},
            },
            adds = "Summons Lesser Shadow Fissures (portals that spawn adds)",
            notes = "Tank faces boss away from group. Interrupt Dark Spin. Kill Lesser Shadow Fissures quickly to prevent add spawns."
        },
        ["Blood Guard Porung"] = {
            health = {normal = "62,000", heroic = "167,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Intimidating Shout", desc = "AoE fear effect."},
                {name = "Mortal Strike", desc = "Reduces healing effectiveness by 50%."},
                {name = "Enrage", desc = "Increases attack speed and damage at low health."},
            },
            notes = "Tank should face away from group to avoid Intimidating Shout spreading. Healers prepare for high damage during Enrage phase."
        },
        ["Warbringer O'mrogg"] = {
            health = {normal = "94,000", heroic = "253,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Blast Wave", desc = "AoE knockback dealing fire damage."},
                {name = "Burning Maul", desc = "Adds fire damage to melee attacks."},
                {name = "Fear", desc = "Fears random players."},
                {name = "Thunderclap", desc = "Reduces attack speed of nearby enemies."},
            },
            notes = "Two-headed ogre boss. Stay spread out to minimize Blast Wave impact. Be ready to move away when feared."
        },
        ["Warchief Kargath Bladefist"] = {
            health = {normal = "108,000", heroic = "290,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Blade Dance", desc = "Massive AoE whirlwind attack - RUN AWAY when cast!"},
                {name = "Charge", desc = "Charges random player and deals heavy damage."},
            },
            adds = "Adds from side rooms join the fight periodically",
            notes = "CRITICAL: Everyone must kite away during Blade Dance or die. Kill adds from side rooms before pulling boss if possible. Tank should face boss away from group."
        },
    },
    ["Mana-Tombs"] = {
        ["Pandemonius"] = {
            health = {normal = "44,000", heroic = "119,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Void Blast", desc = "Random target shadow damage attack."},
                {name = "Dark Shell", desc = "Reflects all spells back to caster. Stop casting!"},
            },
            notes = "Stop all spellcasting immediately when Dark Shell is active (boss glows purple). Wait for it to fade before resuming."
        },
        ["Tavarok"] = {
            health = {normal = "67,000", heroic = "180,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Earthquake", desc = "AoE nature damage and knockdown."},
                {name = "Arcing Smash", desc = "Frontal arc melee attack."},
                {name = "Crystal Prison", desc = "Encases random player in crystal, making them immune but unable to act."},
            },
            notes = "Tank faces boss away from group. Continue DPS even when players are in Crystal Prison - they cannot be harmed."
        },
        ["Nexus-Prince Shaffar"] = {
            health = {normal = "78,000", heroic = "210,000"},
            mana = {normal = "18,000", heroic = "32,000"},
            abilities = {
                {name = "Frostbolt", desc = "Deals frost damage and slows target."},
                {name = "Frost Nova", desc = "AoE freeze around the boss."},
                {name = "Blink", desc = "Teleports around the room."},
            },
            adds = "Summons Ethereal Beacons (3 adds that must be killed quickly)",
            notes = "CRITICAL: Kill Ethereal Beacons immediately - they explode and heal the boss if not killed fast. Stay spread out for Frost Nova."
        },
        ["Yor"] = {
            health = {normal = "62,000", heroic = "167,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Stomp", desc = "AoE physical damage and interrupt."},
                {name = "Double Breath", desc = "Dual cone breath attack hitting frontal and rear arcs."},
            },
            notes = "Unique mechanic: Has both a front AND back breath attack. Ranged DPS should stay on the sides to avoid both breath cones."
        },
    },
    ["Auchenai Crypts"] = {
        ["Shirrak the Dead Watcher"] = {
            health = {normal = "52,000", heroic = "139,000"},
            mana = {normal = "15,000", heroic = "28,000"},
            abilities = {
                {name = "Carnivorous Bite", desc = "Heavy nature damage on tank."},
                {name = "Inhibit Magic", desc = "AoE that increases cast time and mana cost by 300%."},
                {name = "Attract Magic", desc = "Pulls all players toward the boss."},
            },
            adds = "Focus Fire spawns periodically during the fight (move away from fire)",
            notes = "Move away from Focus Fire zones immediately. During Inhibit Magic, avoid unnecessary casting. Be ready for Attract Magic pull."
        },
        ["Exarch Maladaar"] = {
            health = {normal = "84,000", heroic = "226,000"},
            mana = {normal = "20,000", heroic = "35,000"},
            abilities = {
                {name = "Avatar of the Martyred", desc = "Summons a dark version of a player that must be killed."},
                {name = "Ribbon of Souls", desc = "Steals health from all nearby players."},
                {name = "Soul Scream", desc = "AoE shadow damage fear effect."},
            },
            notes = "Focus DPS on Avatar immediately when spawned - it has player's abilities. Stay spread to minimize Ribbon of Souls damage."
        },
    },
    ["Sethekk Halls"] = {
        ["Darkweaver Syth"] = {
            health = {normal = "56,000", heroic = "151,000"},
            mana = {normal = "16,000", heroic = "29,000"},
            abilities = {
                {name = "Frost Shock", desc = "Frontal cone frost damage and slow."},
                {name = "Flame Shock", desc = "Fire damage DOT on random target."},
                {name = "Arcane Shock", desc = "Arcane damage and mana drain."},
                {name = "Shadow Shock", desc = "Shadow damage DOT."},
            },
            adds = "Summons 4 elementals at 25% HP intervals (Fire, Frost, Arcane, Shadow)",
            notes = "Tank faces boss away. Kill elementals quickly when they spawn. Each elemental type corresponds to one of his shock abilities."
        },
        ["Anzu"] = {
            health = {normal = nil, heroic = "188,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Screech", desc = "AoE silence that prevents casting for 4 seconds."},
                {name = "Spell Bomb", desc = "Summons exploding bombs that detonate after 6 seconds."},
                {name = "Cyclone", desc = "Lifts a player into the air, making them unable to act."},
                {name = "Banish", desc = "Banishes himself briefly, becoming immune."},
            },
            notes = "Heroic-only boss. Requires Druid with Epic Flight Form and quest item to summon. Kill Spell Bombs before they explode."
        },
        ["Talon King Ikiss"] = {
            health = {normal = "88,000", heroic = "237,000"},
            mana = {normal = "20,000", heroic = "36,000"},
            abilities = {
                {name = "Arcane Volley", desc = "AoE arcane damage to all in front of boss."},
                {name = "Mana Shield", desc = "Absorbs damage, must be removed before DPS resumes."},
                {name = "Polymorph", desc = "Sheeps random player."},
                {name = "Arcane Explosion", desc = "Large AoE arcane damage - get away from boss!"},
                {name = "Slow", desc = "Reduces attack and casting speed."},
            },
            notes = "At 20% HP, boss becomes more dangerous with increased Arcane Explosion frequency. Ranged should stay at distance."
        },
    },
    ["Shadow Labyrinth"] = {
        ["Ambassador Hellmaw"] = {
            health = {normal = "66,000", heroic = "178,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Corrosive Acid", desc = "Frontal cone nature damage and armor reduction."},
                {name = "Fear", desc = "AoE fear effect."},
            },
            notes = "Tank faces boss away from group. Save fear breaks for emergencies. Patrol boss - must be fought where encountered."
        },
        ["Blackheart the Inciter"] = {
            health = {normal = "77,000", heroic = "207,000"},
            mana = {normal = "18,000", heroic = "32,000"},
            abilities = {
                {name = "Incite Chaos", desc = "Mind controls the entire party! Everyone attacks random targets."},
                {name = "War Stomp", desc = "AoE stun."},
                {name = "Charge", desc = "Charges random player."},
            },
            notes = "UNIQUE MECHANIC: During Incite Chaos, party loses control and attacks each other. Spread out and prepare to heal through it."
        },
        ["Grandmaster Vorpil"] = {
            health = {normal = "84,000", heroic = "226,000"},
            mana = {normal = "20,000", heroic = "35,000"},
            abilities = {
                {name = "Draw Shadows", desc = "Teleports all players to him and summons void portals."},
                {name = "Rain of Fire", desc = "AoE fire damage zones on the ground."},
                {name = "Shadow Bolt Volley", desc = "Hits multiple players with shadow damage."},
            },
            adds = "Void Traveler adds spawn from portals after Draw Shadows",
            notes = "Kill Void Travelers quickly before they explode. Move out of Rain of Fire immediately. Be ready for teleport."
        },
        ["Murmur"] = {
            health = {normal = "140,000", heroic = "377,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Sonic Boom", desc = "Massive AoE physical damage to entire party. Deals more damage the closer you are!"},
                {name = "Resonance", desc = "Increases magic damage taken by 50% per stack."},
                {name = "Magnetic Pull", desc = "Pulls all players toward the boss."},
                {name = "Murmur's Touch", desc = "Reduces max HP by 50% and deals damage over time."},
            },
            notes = "CRITICAL: Stay at MAX RANGE for Sonic Boom - damage is based on distance. After Magnetic Pull, spread out immediately before next Sonic Boom."
        },
    },
    ["Slave Pens"] = {
        ["Mennu the Betrayer"] = {
            health = {normal = "36,000", heroic = "97,000"},
            mana = {normal = "12,000", heroic = "22,000"},
            abilities = {
                {name = "Lightning Bolt", desc = "Direct nature damage to random target."},
                {name = "Healing Ward", desc = "Summons totem that heals boss - kill immediately!"},
                {name = "Earthgrab Totem", desc = "Summons totem that roots players."},
                {name = "Corrupted Nova Totem", desc = "Deals shadow damage in AoE."},
            },
            notes = "Kill Healing Ward totem immediately. Destroy other totems as needed to prevent crowd control."
        },
        ["Rokmar the Crackler"] = {
            health = {normal = "52,000", heroic = "139,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Grievous Wound", desc = "Stacking bleed that must be healed above 90% HP to remove."},
                {name = "Frenzy", desc = "Increases attack speed at low health."},
                {name = "Water Spit", desc = "Ranged attack that slows target."},
            },
            notes = "Healer must keep tank above 90% HP to prevent Grievous Wound stacking. Tank cooldowns ready for Frenzy phase."
        },
        ["Quagmirran"] = {
            health = {normal = "68,000", heroic = "183,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Acid Geyser", desc = "Summons poison pools on ground - move out immediately!"},
                {name = "Cleave", desc = "Frontal cone melee attack."},
                {name = "Poison Bolt Volley", desc = "AoE poison damage to all players."},
                {name = "Uppercut", desc = "Knocks tank into the air."},
            },
            notes = "Tank faces boss away from group. All players must avoid Acid Geyser poison pools. Spread out for Poison Bolt Volley."
        },
    },
    ["Underbog"] = {
        ["Hungarfen"] = {
            health = {normal = "47,000", heroic = "127,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Foul Spores", desc = "Creates mushroom spores around room that explode when approached."},
                {name = "Despawn Spores", desc = "Detonates all spores at once for massive damage."},
            },
            notes = "Avoid mushroom spores on the ground. When boss casts Despawn Spores, all active spores explode - stay clear!"
        },
        ["Ghaz'an"] = {
            health = {normal = "59,000", heroic = "159,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Tail Sweep", desc = "Knockback attack hitting players behind the boss."},
                {name = "Acid Spit", desc = "Frontal nature damage attack."},
                {name = "Acid Breath", desc = "Frontal cone acid attack."},
            },
            notes = "Tank faces boss away. Melee DPS should stand on sides, not behind boss to avoid Tail Sweep."
        },
        ["Swamplord Musel'ek"] = {
            health = {normal = "54,000", heroic = "145,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Throw", desc = "Throws weapon at random target."},
                {name = "Knock Away", desc = "Knockback that also reduces threat."},
                {name = "Bear Form", desc = "Shapeshifts into bear, increasing armor and damage."},
            },
            adds = "Fights with Claw companion (beast) that must be tanked separately",
            notes = "Off-tank or CC the Claw pet. Main tank be ready for threat wipes from Knock Away."
        },
        ["The Black Stalker"] = {
            health = {normal = "78,000", heroic = "210,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Levitate", desc = "Lifts random player into air and suspends them, then drops for fall damage."},
                {name = "Static Charge", desc = "Stacking nature damage DOT."},
                {name = "Chain Lightning", desc = "Bounces between nearby players."},
                {name = "Summon Spore Strider", desc = "Summons adds during the fight."},
            },
            notes = "Stay spread out to minimize Chain Lightning bounces. Kill Spore Strider adds. Players who are Levitated should be ready to receive healing after drop."
        },
    },
    ["Steamvault"] = {
        ["Hydromancer Thespia"] = {
            health = {normal = "44,000", heroic = "119,000"},
            mana = {normal = "15,000", heroic = "27,000"},
            abilities = {
                {name = "Lightning Cloud", desc = "Summons a cloud that deals nature damage to players underneath."},
                {name = "Lung Burst", desc = "Heavy nature damage and silence on tank."},
                {name = "Enveloping Winds", desc = "Stuns players in melee range."},
            },
            notes = "Move out of Lightning Cloud immediately. Ranged stay at distance to avoid Enveloping Winds."
        },
        ["Mekgineer Steamrigger"] = {
            health = {normal = "56,000", heroic = "151,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Super Shrink Ray", desc = "Shrinks random player, reducing damage and threat significantly."},
                {name = "Saw Blade", desc = "Throws spinning blade at random target."},
                {name = "Repair", desc = "Channels heal on Steamrigger Mechanics - interrupt immediately!"},
            },
            adds = "3x Steamrigger Mechanics that must be killed",
            notes = "CRITICAL: Kill all 3 Steamrigger Mechanics FIRST before engaging boss. Interrupt Repair at all costs."
        },
        ["Warlord Kalithresh"] = {
            health = {normal = "84,000", heroic = "226,000"},
            mana = {normal = "18,000", heroic = "32,000"},
            abilities = {
                {name = "Impale", desc = "Throws spear dealing massive physical damage."},
                {name = "Reflection", desc = "Reflects spells back at caster."},
                {name = "Head Crack", desc = "Interrupts casting and reduces Intelligence."},
                {name = "Warlord's Rage", desc = "Massive damage buff at 25% HP."},
            },
            adds = "4x Naga Distillers that channel buffs to boss",
            notes = "Kill the 4 Naga Distillers on the platforms first to remove boss buffs. Stop casting during Reflection. Save cooldowns for final 25% burn phase."
        },
    },
    ["Old Hillsbrad"] = {
        ["Lieutenant Drake"] = {
            health = {normal = "41,000", heroic = "110,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Exploding Shot", desc = "Places a bomb on target that explodes after 3 seconds."},
                {name = "Whirlwind", desc = "Spinning AoE attack."},
                {name = "Intimidating Shout", desc = "AoE fear effect."},
            },
            notes = "Run away from party when targeted by Exploding Shot. Tank faces boss away for Intimidating Shout."
        },
        ["Captain Skarloc"] = {
            health = {normal = "62,000", heroic = "167,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Holy Light", desc = "Heals for significant amount - interrupt!"},
                {name = "Consecration", desc = "Creates holy damage field on ground."},
                {name = "Hammer of Justice", desc = "Stuns target."},
                {name = "Cleanse", desc = "Removes debuffs from himself."},
            },
            notes = "CRITICAL: Interrupt Holy Light casts. Move out of Consecration. Be ready for stuns."
        },
        ["Epoch Hunter"] = {
            health = {normal = "88,000", heroic = "237,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Curse of Exertion", desc = "Reduces melee and ranged attack speed by 20%."},
                {name = "Magic Disruption", desc = "Massive AoE that silences and damages all players."},
                {name = "Time Stop", desc = "Stuns random player in a time bubble."},
                {name = "Sand Breath", desc = "Frontal cone attack that also reduces attack speed."},
            },
            notes = "Tank faces boss away. All players prepare for Magic Disruption - it cannot be avoided. Dispel Curse of Exertion if possible."
        },
    },
    ["Black Morass"] = {
        ["Chrono Lord Deja"] = {
            health = {normal = "62,000", heroic = "167,000"},
            mana = {normal = "15,000", heroic = "27,000"},
            abilities = {
                {name = "Arcane Blast", desc = "Heavy arcane damage on random target."},
                {name = "Magnetic Pull", desc = "Pulls all players to him."},
                {name = "Time Lapse", desc = "Resets threat and returns to full health - must burn him down fast!"},
            },
            notes = "CRITICAL: Burn boss quickly before he casts Time Lapse or the fight resets! Use all cooldowns. First boss in timed defense event."
        },
        ["Temporus"] = {
            health = {normal = "62,000", heroic = "167,000"},
            mana = {normal = "15,000", heroic = "27,000"},
            abilities = {
                {name = "Hasten", desc = "Increases attack and movement speed by 200%."},
                {name = "Mortal Wound", desc = "Stacking bleed that reduces healing received."},
                {name = "Spell Reflection", desc = "Reflects spells back at caster."},
            },
            notes = "Tank uses cooldowns during Hasten phase. Stop casting during Spell Reflection. Second boss in timed defense event."
        },
        ["Aeonus"] = {
            health = {normal = "88,000", heroic = "237,000"},
            mana = {normal = "18,000", heroic = "32,000"},
            abilities = {
                {name = "Time Stop", desc = "Freezes random player in time bubble."},
                {name = "Sand Breath", desc = "Frontal cone nature damage that slows attack speed."},
                {name = "Frenzy", desc = "Increases attack speed by 50% at low health."},
            },
            adds = "Spawns Infinite Assassin and Infinite Chronomancer adds periodically",
            notes = "Final boss. Kill adds quickly - Chronomancers heal Aeonus. Tank faces boss away. Must complete before time expires or Medivh dies."
        },
    },
    ["Arcatraz"] = {
        ["Zereketh the Unbound"] = {
            health = {normal = "77,000", heroic = "207,000"},
            mana = {normal = "18,000", heroic = "32,000"},
            abilities = {
                {name = "Shadow Nova", desc = "Massive AoE shadow damage - run away during cast!"},
                {name = "Void Zone", desc = "Creates void zones on ground that deal shadow damage."},
                {name = "Seed of Corruption", desc = "Places seed that explodes for AoE damage."},
            },
            notes = "CRITICAL: Run far away when Shadow Nova is casting or die. Avoid void zones. Spread out for Seed of Corruption."
        },
        ["Dalliah the Doomsayer"] = {
            health = {normal = "59,000", heroic = "159,000"},
            mana = {normal = "15,000", heroic = "27,000"},
            abilities = {
                {name = "Whirlwind", desc = "Spinning AoE melee attack."},
                {name = "Heal", desc = "Heals for large amount - interrupt immediately!"},
                {name = "Shadow Wave", desc = "AoE shadow damage pulse."},
                {name = "Gift of the Doomsayer", desc = "Enrages at 20% HP, increasing damage significantly."},
            },
            notes = "Interrupt Heal at all costs. Kite boss during Whirlwind. Save cooldowns for final 20% burn phase. Part of duo encounter."
        },
        ["Wrath-Scryer Soccothrates"] = {
            health = {normal = "59,000", heroic = "159,000"},
            mana = {normal = "18,000", heroic = "32,000"},
            abilities = {
                {name = "Immolation", desc = "AoE fire damage aura."},
                {name = "Felfire", desc = "Summons fire on ground - move out!"},
                {name = "Knock Away", desc = "Knockback that reduces threat."},
                {name = "Charge", desc = "Charges random player."},
            },
            notes = "Tank be ready for threat resets. Move out of Felfire immediately. Can be fought with Dalliah or separately. Part of duo encounter."
        },
        ["Harbinger Skyriss"] = {
            health = {normal = "105,000", heroic = "283,000"},
            mana = {normal = "25,000", heroic = "45,000"},
            abilities = {
                {name = "Mind Rend", desc = "Random target instant death - cannot be prevented!"},
                {name = "Fear", desc = "AoE fear effect."},
                {name = "Domination", desc = "Mind controls random player."},
            },
            adds = "Splits into 2 copies at 66% and 33% HP that must all be killed",
            notes = "CRITICAL: At 66% and 33%, boss splits into copies. Kill all copies or they recombine. Mind Rend randomly kills players - use soulstone/rebirth."
        },
    },
    ["Botanica"] = {
        ["Commander Sarannis"] = {
            health = {normal = "52,000", heroic = "140,000"},
            mana = {normal = "15,000", heroic = "27,000"},
            abilities = {
                {name = "Arcane Resonance", desc = "Stacking arcane damage debuff - switch targets if possible."},
                {name = "Summon Reinforcements", desc = "Calls adds that must be killed."},
            },
            adds = "Summons Bloodfalcon adds periodically",
            notes = "Kill Bloodfalcon adds quickly. Tank swap or use cooldowns when Arcane Resonance stacks high."
        },
        ["High Botanist Freywinn"] = {
            health = {normal = "62,000", heroic = "167,000"},
            mana = {normal = "18,000", heroic = "32,000"},
            abilities = {
                {name = "Tranquility", desc = "Channeled AoE heal - interrupt immediately!"},
                {name = "Plant Spawn", desc = "Summons adds."},
                {name = "Tree Form", desc = "Transforms into tree, increasing armor significantly."},
            },
            adds = "Summons Frayer adds from Plant Spawns",
            notes = "CRITICAL: Interrupt Tranquility at all costs. Kill Plant Spawns before they create Frayers. DPS may need to switch to adds."
        },
        ["Thorngrin the Tender"] = {
            health = {normal = "67,000", heroic = "180,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Hellfire", desc = "AoE fire damage to all nearby."},
                {name = "Sacrifice", desc = "Kills nearby plant adds to heal himself."},
                {name = "Enrage", desc = "Increases attack speed and damage."},
            },
            notes = "Kill plant adds in the room BEFORE pulling boss to prevent Sacrifice heals. Spread out to minimize Hellfire damage."
        },
        ["Laj"] = {
            health = {normal = "78,000", heroic = "210,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Allergic Reaction", desc = "Teleports random player and deals heavy damage."},
                {name = "Summon Thorn Flayer", desc = "Summons adds at 75%, 50%, and 25% HP."},
                {name = "Pollen", desc = "AoE nature damage."},
            },
            adds = "Summons 5 Thorn Flayers at health thresholds",
            notes = "Tank Thorn Flayers with boss. AoE them down while damaging boss. Players teleported by Allergic Reaction need immediate healing."
        },
        ["Warp Splinter"] = {
            health = {normal = "91,000", heroic = "245,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Stomp", desc = "AoE nature damage and stun."},
                {name = "Summon Treants", desc = "Calls 6 Sapling adds that must be killed."},
                {name = "Arcane Volley", desc = "AoE arcane damage."},
            },
            adds = "Summons 6 Saplings at 50% HP",
            notes = "CRITICAL: AoE down all Saplings immediately when spawned. They heal the boss if not killed quickly. Tank faces boss away for Stomp."
        },
    },
    ["Mechanar"] = {
        ["Gatewatcher Gyro-Kill"] = {
            health = {normal = "47,000", heroic = "127,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Shadow Power", desc = "Increases shadow damage significantly."},
                {name = "Saw Blade", desc = "Throws blade at random target."},
                {name = "Steam of Machine Fluid", desc = "Frontal cone attack."},
            },
            notes = "Tank faces boss away from group. Melee stay behind boss to avoid frontal attacks."
        },
        ["Gatewatcher Iron-Hand"] = {
            health = {normal = "47,000", heroic = "127,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Hammer Punch", desc = "Heavy melee attack on tank."},
                {name = "Jack Hammer", desc = "Stuns target and deals massive damage over 3 seconds."},
                {name = "Stream of Machine Fluid", desc = "Frontal cone attack."},
            },
            notes = "Tank uses cooldowns during Jack Hammer. Face boss away from group."
        },
        ["Mechano-Lord Capacitus"] = {
            health = {normal = "62,000", heroic = "167,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Head Crack", desc = "Interrupts casting and reduces Intelligence."},
                {name = "Nether Charge", desc = "Creates nether rifts that explode - run away!"},
                {name = "Reflective Magic Shield", desc = "Reflects spells back at caster."},
            },
            adds = "Periodically summons Nether Charge adds (bombs)",
            notes = "CRITICAL: Run far away from Nether Charge bombs before they explode. Stop casting during Reflective Shield."
        },
        ["Nethermancer Sepethrea"] = {
            health = {normal = "67,000", heroic = "180,000"},
            mana = {normal = "20,000", heroic = "36,000"},
            abilities = {
                {name = "Frost Attack", desc = "Frontal cone frost damage."},
                {name = "Dragons Breath", desc = "Frontal cone fire damage."},
                {name = "Arcane Blast", desc = "Heavy arcane damage on random target."},
            },
            adds = "4x Ragin' Flames adds that must be killed first",
            notes = "CRITICAL: Kill all 4 Ragin' Flames elementals FIRST before engaging boss. Tank faces boss away from group."
        },
        ["Pathaleon the Calculator"] = {
            health = {normal = "88,000", heroic = "237,000"},
            mana = {normal = "25,000", heroic = "45,000"},
            abilities = {
                {name = "Mana Tap", desc = "Drains mana from all players."},
                {name = "Arcane Torrent", desc = "Uses drained mana to deal AoE damage and silence."},
                {name = "Domination", desc = "Mind controls random player."},
                {name = "Summon Nether Wraith", desc = "Summons adds at 50%, 40%, 30%, 20%, and 10% HP."},
            },
            adds = "Summons Nether Wraith adds at multiple health thresholds",
            notes = "Kill or CC Nether Wraiths quickly. Be ready to break mind control. Conserve mana for Arcane Torrent."
        },
    },
    ["Magisters' Terrace"] = {
        ["Selin Fireheart"] = {
            health = {normal = "77,000", heroic = "207,000"},
            mana = {normal = "25,000", heroic = "45,000"},
            abilities = {
                {name = "Fel Explosion", desc = "AoE fire damage around boss."},
                {name = "Drain Mana", desc = "Drains all mana from all players."},
                {name = "Drain Life", desc = "Channels life drain on random target."},
                {name = "Drain Fel Crystal", desc = "Boss drains crystals in room to restore health and mana."},
            },
            notes = "CRITICAL: When boss starts draining a crystal, pull him away from it immediately or he heals to full! Save mana for Fel Explosion."
        },
        ["Vexallus"] = {
            health = {normal = "84,000", heroic = "226,000"},
            mana = {normal = nil, heroic = nil},
            abilities = {
                {name = "Chain Lightning", desc = "Bounces between nearby players - spread out!"},
                {name = "Arcane Shock", desc = "Random target arcane damage."},
                {name = "Overload", desc = "Releases Pure Energy adds when damaged."},
            },
            adds = "Pure Energy adds spawn periodically - they explode when they reach players",
            notes = "Stay spread for Chain Lightning. Kill or kite Pure Energy adds - they explode for massive damage if they reach you."
        },
        ["Priestess Delrissa"] = {
            health = {normal = "62,000", heroic = "167,000"},
            mana = {normal = "20,000", heroic = "36,000"},
            abilities = {
                {name = "Dispel Magic", desc = "Removes buffs from players."},
                {name = "Flash Heal", desc = "Heals allies for large amount."},
                {name = "Shadow Word: Pain", desc = "Shadow damage DOT."},
                {name = "Renew", desc = "Healing over time on allies."},
                {name = "Power Word: Shield", desc = "Absorbs damage on allies."},
            },
            adds = "Fights with 4 random adds from a pool - composition varies each time!",
            notes = "CRITICAL: Kill order depends on random add composition. Interrupt Delrissa's heals. This is a gauntlet fight with 5 enemies total."
        },
        ["Kael'thas Sunstrider"] = {
            health = {normal = "105,000", heroic = "283,000"},
            mana = {normal = "35,000", heroic = "60,000"},
            abilities = {
                {name = "Fireball", desc = "Heavy fire damage on random target."},
                {name = "Flamestrike", desc = "Creates fire on ground - move out immediately!"},
                {name = "Gravity Lapse", desc = "Levitates all players and deals Arcane damage. Then Shock Barrier."},
                {name = "Shock Barrier", desc = "Stuns all players after Gravity Lapse ends."},
                {name = "Phoenix", desc = "Summons Phoenix add at 50% HP that must be killed."},
            },
            adds = "Summons Phoenix at 50% HP - kill it before it resurrects!",
            notes = "CRITICAL: Move out of Flamestrike. During Gravity Lapse, prepare for stun when landing. Kill Phoenix quickly or it resurrects with full HP!"
        },
    },
}

-- Get boss data for a specific dungeon and boss
function B:GetBossData(dungeonName, bossName)
    if self.Bosses[dungeonName] then
        return self.Bosses[dungeonName][bossName]
    end
    return nil
end

-- Get all bosses for a dungeon
function B:GetDungeonBosses(dungeonName)
    return self.Bosses[dungeonName] or {}
end

-- Check if boss data exists
function B:HasBossData(dungeonName, bossName)
    return self.Bosses[dungeonName] and self.Bosses[dungeonName][bossName] ~= nil
end

-- TBC Raid Boss Lists
B.Raids = {
    ["Karazhan"] = {
        "Attumen the Huntsman",
        "Midnight",
        "Moroes",
        "Maiden of Virtue",
        "The Curator",
        "Terestian Illhoof",
        "Shade of Aran",
        "Netherspite",
        "Prince Malchezaar",
        "Nightbane",
        "Tenris Mirkblood",
    },
    ["Zul'Aman"] = {
        "Nalorakk",
        "Jan'alai",
        "Akil'zon",
        "Halazzi",
        "Hexxlord Jin'Zakk",
        "Zul'jin",
    },
    ["Gruul's Lair"] = {
        "High King Maulgar",
        "Gruul the Dragonkiller",
    },
    ["Magtheridon's Lair"] = {
        "Magtheridon",
    },
    ["Serpentshrine Cavern"] = {
        "Hydross the Unstable",
        "The Lurker Below",
        "Leotheras the Blind",
        "Fathom-Lord Karathress",
        "Morogrim Tidewalker",
        "Lady Vashj",
    },
    ["The Eye"] = {
        "Al'ar",
        "Void Reaver",
        "High Astromancer Solarian",
        "Kael'thas Sunstrider",
    },
    ["Battle for Mount Hyjal"] = {
        "Rage Winterchill",
        "Anetheron",
        "Kaz'rogal",
        "Azgalor",
        "Archimonde",
    },
    ["The Black Temple"] = {
        "High Warlord Naj'entus",
        "Supremus",
        "Shade of Akama",
        "Teron Gorefiend",
        "Gurtogg Bloodboil",
        "Reliquary of Souls",
        "Mother Shahraz",
        "Illidari Council",
        "Illidan Stormrage",
    },
    ["Sunwell Plateau"] = {
        "Kalecgos",
        "Sathrovarr the Corruptor",
        "Brutallus",
        "Felmyst",
        "Grand Warlock Alythess",
        "Lady Sacrolash",
        "M'uru",
        "Kil'jaeden",
    },
}

-- Get raid boss list
function B:GetRaidBosses(raidName)
    return self.Raids[raidName] or {}
end

-- Get all raids
function B:GetAllRaids()
    return self.Raids
end

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

-- TBC Raid Boss Data
-- Format: Same as dungeon bosses (health, mana, abilities, mechanics, notes)
-- Note: Raids only have normal mode (no heroic) in TBC
B.RaidBosses = {
    ["Karazhan"] = {
        ["Attumen the Huntsman"] = {
            health = {normal = "820,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Intangible Presence", desc = "Reduces healing on tank by 50% when mounted."},
                {name = "Shadow Cleave", desc = "Frontal cone shadow damage hitting multiple targets."},
                {name = "Charge", desc = "Charges random player and stuns them."},
                {name = "Summon Midnight", desc = "Mounted phase - combines with Midnight at 95% HP."},
            },
            adds = "Midnight (horse) - merges with Attumen at 95%",
            notes = "Tank faces boss away from raid. Two-phase fight: Kill Midnight first, then Attumen mounts and they combine into one entity."
        },
        ["Moroes"] = {
            health = {normal = "535,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Gouge", desc = "Incapacitates main tank and switches to a new target."},
                {name = "Blind", desc = "Blinds a random player."},
                {name = "Garrote", desc = "Applies stacking bleed DOT that must be dispelled."},
                {name = "Vanish", desc = "Disappears briefly then reappears with full energy."},
                {name = "Enrage", desc = "At 30% HP, enrages increasing damage and attack speed."},
            },
            adds = "4 Dinner Guests (random each week) - must be CC'd or killed",
            notes = "CRITICAL: CC 2 adds, off-tank 1-2 others. Dispel Garrote bleeds immediately. Tank swap ready for Gouge. Use bloodlust/heroism at 30% for burn phase."
        },
        ["Maiden of Virtue"] = {
            health = {normal = "840,000"},
            mana = {normal = "180,000"},
            abilities = {
                {name = "Repentance", desc = "AoE stun that incapacitates all players in melee range for 6 seconds."},
                {name = "Holy Fire", desc = "Deals holy damage and applies a DOT to random target."},
                {name = "Holy Ground", desc = "Standing in consecrated areas deals holy damage over time."},
                {name = "Holy Wrath", desc = "Massive AoE holy damage when players use spells/abilities near her."},
            },
            notes = "CRITICAL: Stop all casting/abilities during Repentance or Holy Wrath will wipe the raid! Melee DPS stay behind boss. Dispel Holy Fire DOTs."
        },
        ["Opera Event"] = {
            health = {normal = "Varies"},
            mana = {normal = "Varies"},
            abilities = {
                {name = "Random Event", desc = "One of three: Big Bad Wolf, Romulo & Julianne, or Wizard of Oz"},
            },
            notes = "Random encounter that changes weekly. Wolf: Kite the Little Red Riding Hood. R&J: Kill both within 10 seconds. Oz: CC Roar, kill Tinhead, then Strawman, then Crone."
        },
        ["The Curator"] = {
            health = {normal = "1,680,000"},
            mana = {normal = "150,000"},
            abilities = {
                {name = "Evocation", desc = "Channels to restore mana - raid must burn DPS during this phase."},
                {name = "Arcane Infusion", desc = "Increases spell damage taken by 50% stacking debuff."},
                {name = "Hateful Bolt", desc = "Massive arcane damage on second-highest threat target."},
                {name = "Summon Astral Flare", desc = "Spawns adds every 10 seconds that must be killed."},
                {name = "Berserk", desc = "Enrages after 10 minutes, wiping raid."},
            },
            adds = "Astral Flare adds spawn every 10 seconds",
            notes = "CRITICAL: Kill Astral Flares with ranged DPS while melee stays on boss. Off-tank takes Hateful Bolt. Burn boss hard during Evocation phases. 10 minute enrage timer."
        },
        ["Shade of Aran"] = {
            health = {normal = "882,000"},
            mana = {normal = "250,000"},
            abilities = {
                {name = "Fireball", desc = "Heavy fire damage on highest threat target."},
                {name = "Arcane Missiles", desc = "Channeled spell hitting random targets - can be interrupted."},
                {name = "Chains of Ice", desc = "Roots and damages a random player - must move to break."},
                {name = "Flame Wreath", desc = "Places ring around 3 players - NEVER MOVE or raid wipes!"},
                {name = "Blizzard", desc = "AoE frost damage covering outer ring - move to center."},
                {name = "Dragon's Breath", desc = "Massive frontal cone fire attack during Blizzard phase."},
                {name = "Mass Polymorph", desc = "Sheeps entire raid briefly at 40% HP."},
                {name = "Summon Elementals", desc = "Summons 4 Water Elementals at 40% HP."},
            },
            adds = "4 Water Elementals spawn at 40% HP - must be killed",
            notes = "CRITICAL: During Flame Wreath, affected players MUST NOT MOVE or entire raid dies! Move center during Blizzard but watch for Dragon's Breath. Kill elementals at 40%."
        },
        ["Terestian Illhoof"] = {
            health = {normal = "935,000"},
            mana = {normal = "200,000"},
            abilities = {
                {name = "Sacrifice", desc = "Chains a player in cage, dealing shadow damage over time."},
                {name = "Shadow Bolt", desc = "Heavy shadow damage on random target."},
                {name = "Summon Kilrek", desc = "Permanently summons demon add at pull."},
                {name = "Summon Demonchains", desc = "Spawns adds that channel on sacrificed player."},
            },
            adds = "Kilrek (permanent demon) and Demon Chains (spawn during Sacrifice)",
            notes = "Kill Demon Chains immediately when player is sacrificed. Off-tank holds Kilrek away from boss. Interrupt Shadow Bolts when possible."
        },
        ["Netherspite"] = {
            health = {normal = "1,680,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Netherbreath", desc = "Frontal cone arcane damage."},
                {name = "Void Zone", desc = "Creates void zones that deal shadow damage."},
                {name = "Banish", desc = "Banish phase - all DPS stops, portals appear."},
                {name = "Perseverance Beam", desc = "Red beam - tank stands in it to reduce boss damage."},
                {name = "Serenity Beam", desc = "Blue beam - healer stands in it for mana regeneration."},
                {name = "Dominance Beam", desc = "Green beam - DPS stands in it for increased damage."},
            },
            notes = "Complex mechanic: Alternate between Portal phase (manage beams by rotation) and Banish phase (burn boss, avoid void zones). Rotate beam assignments."
        },
        ["Prince Malchezaar"] = {
            health = {normal = "1,260,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Shadow Nova", desc = "Massive AoE shadow damage - healers be ready."},
                {name = "Enfeeble", desc = "Reduces 5 players' HP to 1 temporarily - don't take any damage!"},
                {name = "Thrash", desc = "Extra attacks on tank."},
                {name = "Summon Infernal", desc = "Phase 2: Summons Infernals that create fire zones."},
                {name = "Summon Axes", desc = "Phase 3: Floating axes deal damage to random players."},
            },
            adds = "Phase 2: Infernals. Phase 3: Floating Axes",
            notes = "Three phases. Phase 1: Basic tank and spank. Phase 2 (60%): Infernals drop creating fire - move away. Phase 3 (30%): Axes attack random players + Enfeeble - affected players take no damage."
        },
        ["Nightbane"] = {
            health = {normal = "1,260,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Cleave", desc = "Frontal cone physical damage."},
                {name = "Tail Sweep", desc = "Rear cone knockback."},
                {name = "Charred Earth", desc = "Creates fire zones on ground - move out!"},
                {name = "Distracting Ash", desc = "Reduces chance to hit by 75%."},
                {name = "Air Phase", desc = "Flies into air shooting Fireball Barrages - hide behind walls."},
                {name = "Smoking Blast", desc = "Frontal cone fire damage during air phase."},
            },
            adds = "Restless Skeletons spawn during Air phase",
            notes = "Optional boss summoned via Blackened Urn. Two phases alternate: Ground (tank and spank with fire avoidance) and Air (hide behind walls, kill skeletons). Move from Charred Earth immediately."
        },
    },
    ["Gruul's Lair"] = {
        ["High King Maulgar"] = {
            health = {normal = "1,680,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Arcing Smash", desc = "Frontal cone attack hitting for massive damage."},
                {name = "Whirlwind", desc = "Spinning AoE attack - everyone kite away."},
                {name = "Intimidating Roar", desc = "Fears nearby players."},
                {name = "Flurry", desc = "Increases attack speed significantly."},
            },
            adds = "4 Council Members: Kiggler (mage), Blindeye (warlock), Olm (priest), Krosh (warrior) - must be killed first",
            notes = "CRITICAL: CC or off-tank each council member. Kill order: Blindeye > Kiggler > Krosh > Olm > Maulgar. Kite during Whirlwind. Face Maulgar away for Arcing Smash."
        },
        ["Gruul the Dragonkiller"] = {
            health = {normal = "3,360,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Hurtful Strike", desc = "Hits second-highest threat target for massive damage."},
                {name = "Cave In", desc = "Random falling rocks deal damage - keep moving."},
                {name = "Ground Slam", desc = "AoE knockback that also applies Stoned debuff."},
                {name = "Stoned", desc = "Stacking debuff reducing movement speed. At 5 stacks = Shatter."},
                {name = "Shatter", desc = "Kills all players with 5 Stoned stacks instantly if within 15 yards of each other."},
                {name = "Grow", desc = "Stacking buff increasing damage and size - soft enrage."},
            },
            notes = "CRITICAL: After each Ground Slam, spread out to prevent Shatter chain kills. Off-tank takes Hurtful Strike. Keep moving during Cave In. 9 minute soft enrage via Grow stacks."
        },
    },
    ["Magtheridon's Lair"] = {
        ["Magtheridon"] = {
            health = {normal = "4,200,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Cleave", desc = "Frontal cone physical damage."},
                {name = "Blast Nova", desc = "5 second cast AoE that wipes raid - click cubes to interrupt!"},
                {name = "Quake", desc = "Raid-wide damage pulse."},
                {name = "Cave In", desc = "Random rocks fall dealing damage."},
                {name = "Warder Debuff", desc = "If Hellfire Warders alive, they channel Shadow Grasp debuff."},
            },
            adds = "5 Hellfire Channelers at start, must be killed within 2 minutes",
            notes = "CRITICAL: Kill all 5 Channelers quickly, interrupt their Dark Mending. When Magtheridon casts Blast Nova, 5 players must click Manticron Cubes to interrupt or raid wipes. Rotate cube clickers."
        },
    },
    ["Serpentshrine Cavern"] = {
        ["Hydross the Unstable"] = {
            health = {normal = "2,940,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Water Tomb", desc = "Encases random player in water bubble."},
                {name = "Vile Sludge", desc = "Poison DOT that spreads to nearby players."},
                {name = "Mark of Hydross/Corruption", desc = "Stacking debuff based on current form."},
                {name = "Phase Transition", desc = "Switches between Frost (blue) and Nature (green) at 75%, 50%, 25%."},
            },
            notes = "Position boss near center. Tank swaps on phase transitions. DPS stops briefly during transition. Dispel Vile Sludge quickly. Spread out to prevent DOT spreading."
        },
        ["The Lurker Below"] = {
            health = {normal = "2,520,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Spout", desc = "Spinning water stream that knocks players off platform - jump in water!"},
                {name = "Whirl", desc = "AoE knockback during Spout."},
                {name = "Geyser", desc = "Random water spouts knocking players up."},
                {name = "Submerge", desc = "Boss goes underwater, spawning adds."},
            },
            adds = "Coilfang Ambusher and Guardian adds during Submerge phase",
            notes = "CRITICAL: During Spout, everyone jump in water immediately or die. Kill adds during Submerge phase. Jump back on platform when boss resurfaces. Don't stand on geyser spawn points."
        },
        ["Leotheras the Blind"] = {
            health = {normal = "2,310,000 combined"},
            mana = {normal = "150,000"},
            abilities = {
                {name = "Whirlwind", desc = "Spinning AoE melee attack."},
                {name = "Insidious Whisper", desc = "Mind controls a player who splits into demon - must be killed!"},
                {name = "Chaos Blast", desc = "Shadow damage on random target."},
                {name = "Demon Form Split", desc = "At 15% HP, splits into Demon and Human forms."},
            },
            adds = "Inner Demons spawn from mind-controlled players",
            notes = "Complex fight. Kill Inner Demons from mind control quickly. At 15%, boss splits - kill both forms within 1 minute or they recombine with full HP. Kite during Whirlwind."
        },
        ["Fathom-Lord Karathress"] = {
            health = {normal = "1,260,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Cataclysmic Bolt", desc = "Massive single-target damage on highest threat."},
                {name = "Sear Nova", desc = "AoE fire damage."},
                {name = "Enrage", desc = "Increases damage when advisors die."},
            },
            adds = "3 Advisors: Caribdis (priest), Tidalvess (hunter), Sharkkis (shaman) - kill first",
            notes = "Kill order: Sharkkis > Tidalvess > Caribdis > Karathress. Each advisor death enrages Karathress. Off-tank each advisor. Interrupt Caribdis heals."
        },
        ["Morogrim Tidewalker"] = {
            health = {normal = "4,200,000"},
            mana = {normal = "115,000"},
            abilities = {
                {name = "Tidal Wave", desc = "Summons massive wave that knocks raid back and deals damage."},
                {name = "Watery Grave", desc = "Encases 4 players in water tombs - raid must free them!"},
                {name = "Earthquake", desc = "Raid-wide damage during Watery Grave phase."},
                {name = "Summon Water Globule", desc = "Spawns adds that must be killed quickly."},
            },
            adds = "Murlocs at start (clear before pull), Water Globules during fight",
            notes = "CRITICAL: Free players from Watery Graves quickly by destroying globes. Kill Water Globule adds immediately. Position raid to handle Tidal Wave knockback."
        },
        ["Lady Vashj"] = {
            health = {normal = "5,040,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Shock Blast", desc = "Heavy nature damage on tank."},
                {name = "Static Charge", desc = "Jumping lightning between nearby players - spread out!"},
                {name = "Entangle", desc = "Roots random player in place."},
                {name = "Phase 2: Shield", desc = "Becomes immune, raid must do Core Mechanic."},
                {name = "Toxic Spore", desc = "Green poison clouds - don't stand in them."},
                {name = "Tainted Core", desc = "P2: Enchanted Elementals drop cores - pass them to Core Looters."},
            },
            adds = "Phase 2: Strider adds and Enchanted Elementals. Phase 3: Naga adds",
            notes = "Complex 3-phase fight. P1: Tank and spank, spread for Static Charge. P2: Kill Enchanted Elementals, carry Cores to generators (4 needed). P3: Burn boss, handle adds. Very coordination intensive."
        },
    },
    ["Tempest Keep"] = {
        ["Al'ar"] = {
            health = {normal = "3,570,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Flame Quills", desc = "Raid-wide fire damage while stationary."},
                {name = "Flame Buffet", desc = "Stacking fire damage on tank."},
                {name = "Dive Bomb", desc = "Charges random platform, dealing massive damage in area."},
                {name = "Rebirth", desc = "At 0% HP Phase 1, resurrects as Al'ar in Phase 2."},
                {name = "Melt Armor", desc = "Phase 2: Reduces tank armor by 80%."},
            },
            adds = "Ember of Al'ar adds in Phase 2 - must be killed",
            notes = "Two phases. P1: Four platforms, boss flies between them. Tanks rotate on platforms. Move away from Dive Bomb. P2: Ember adds spawn - AoE them. Tank swap for Melt Armor."
        },
        ["Void Reaver"] = {
            health = {normal = "4,200,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Arcane Orb", desc = "Massive arcane damage on random player + explosion around them."},
                {name = "Pounding", desc = "Stacking knockback on tank."},
                {name = "Knock Away", desc = "Knocks tank back and resets threat."},
                {name = "Enrage", desc = "10 minute berserk timer."},
            },
            notes = "Simplest TBC raid boss - gear check. Stay spread 20+ yards for Arcane Orbs. Tank with back to wall. Off-tanks ready for Knock Away threat reset. 10 min enrage."
        },
        ["High Astromancer Solarian"] = {
            health = {normal = "2,100,000"},
            mana = {normal = "500,000"},
            abilities = {
                {name = "Arcane Missiles", desc = "Heavy arcane damage on random target."},
                {name = "Wrath of the Astromancer", desc = "Massive arcane bomb on random player - RUN AWAY!"},
                {name = "Blind", desc = "Blinds nearby players."},
                {name = "Void Reaver Teleport", desc = "At 20%, teleports entire raid and spawns agents."},
            },
            adds = "3 Agents (Priests, Solarium Agents), Phase 2 Void Walkers",
            notes = "Three phases. P1: Kill adds, avoid Wrath of Astromancer explosions (run 30+ yards away). P2 (50%): Becomes void form, spawns Void Walkers. P3 (20%): Spawns agents, burn boss."
        },
        ["Kael'thas Sunstrider"] = {
            health = {normal = "8,400,000+"},
            mana = {normal = nil},
            abilities = {
                {name = "Fireball", desc = "Heavy fire damage on tank."},
                {name = "Shock Barrier", desc = "Stuns nearby players."},
                {name = "Flamestrike", desc = "Fire AoE on ground - move out!"},
                {name = "Phoenix", desc = "Summons Phoenix adds that resurrect if not killed quickly."},
                {name = "Mind Control", desc = "Phase 4: Takes control of 3 players."},
                {name = "Gravity Lapse", desc = "Phase 4: Levitates raid and deals damage."},
            },
            adds = "Phase 1: Four advisors + weapons. Phase 3: Phoenix. Phase 5: Multiple bosses",
            notes = "LONGEST FIGHT IN TBC - 5 phases. P1: Kill 4 advisors. P2: Loot legendary weapons from advisors. P3: Fight Kael with weapons. P4: Mind controls and Gravity Lapse. P5: All advisors return - burn Kael."
        },
    },
    ["Battle for Mount Hyjal"] = {
        ["Rage Winterchill"] = {
            health = {normal = "4,200,000"},
            mana = {normal = "400,000"},
            abilities = {
                {name = "Frost Armor", desc = "Slows attackers."},
                {name = "Death and Decay", desc = "AoE shadow DOT zones - move out!"},
                {name = "Frost Nova", desc = "AoE freeze."},
                {name = "Icebolt", desc = "Encases random player in ice block."},
            },
            notes = "Wave-based encounter. Defend Alliance base through waves of Horde attackers. Boss spawns after waves complete. Move from Death and Decay. Healers focus on dispelling."
        },
        ["Anetheron"] = {
            health = {normal = "4,200,000"},
            mana = {normal = "400,000"},
            abilities = {
                {name = "Carrion Swarm", desc = "Frontal cone shadow damage."},
                {name = "Sleep", desc = "Puts nearby players to sleep."},
                {name = "Vampiric Aura", desc = "Heals attackers for 3% of damage dealt."},
                {name = "Inferno", desc = "Summons Infernal adds that must be tanked."},
            },
            adds = "Infernal adds - off-tank these away from raid",
            notes = "Second wave boss. Tank with back to raid for Carrion Swarm. Off-tank Infernals away. Spread out to minimize Sleep."
        },
        ["Kaz'rogal"] = {
            health = {normal = "4,200,000"},
            mana = {normal = nil},
            abilities = {
                {name = "War Stomp", desc = "AoE stun and knockback."},
                {name = "Cleave", desc = "Frontal cone melee attack."},
                {name = "Mark of Kaz'rogal", desc = "Drains mana/rage/energy - if depleted, explodes for AoE damage!"},
            },
            notes = "Third wave boss. CRITICAL: Players marked must stop using abilities or risk explosion. Ranged spread out. Mana users stop casting when marked. Tank faces away."
        },
        ["Azgalor"] = {
            health = {normal = "4,200,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Cleave", desc = "Frontal cone physical damage."},
                {name = "War Stomp", desc = "AoE stun."},
                {name = "Howl of Azgalor", desc = "AoE silence."},
                {name = "Doom", desc = "Applies Doom debuff dealing massive shadow damage after 20 seconds - must be removed!"},
            },
            adds = "Summons Lesser Doomguard adds",
            notes = "Fourth wave boss. Tank faces away. Kill Doomguard adds. CRITICAL: Dispel Doom or affected player dies instantly after 20 seconds!"
        },
        ["Archimonde"] = {
            health = {normal = "8,400,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Air Burst", desc = "Launches random player into air - use Tears of the Goddess to survive fall!"},
                {name = "Grip of the Legion", desc = "Beam that drains health/mana and fears."},
                {name = "Doomfire", desc = "Creates spreading fire on ground - move out!"},
                {name = "Fear", desc = "Random fears throughout fight."},
                {name = "Soul Charge", desc = "Grows stronger when players die - battle res wisely!"},
                {name = "Enrage", desc = "10 minute hard enrage."},
            },
            notes = "Final boss. CRITICAL: Use Tears of the Goddess item before pull (drops from tree) to survive Air Burst. Avoid Doomfire spreading. Don't die or boss gets stronger. 10 min enrage."
        },
    },
    ["Black Temple"] = {
        ["High Warlord Naj'entus"] = {
            health = {normal = "5,040,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Impaling Spine", desc = "Impales random player with spine - raid must free them!"},
                {name = "Tidal Shield", desc = "Absorbs damage, reflects when broken."},
                {name = "Tidal Burst", desc = "Raid-wide frost damage when shield breaks."},
                {name = "Needle Spine", desc = "Ranged attack on random targets."},
            },
            notes = "First boss. When Impaling Spine hits someone, raid must destroy spine to free them. Break Tidal Shield quickly, healers prepare for Tidal Burst. Spread out for Needle Spine."
        },
        ["Supremus"] = {
            health = {normal = "6,720,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Molten Punch", desc = "Massive fire damage on tank with knockback."},
                {name = "Volcanic Geyser", desc = "Random fire eruptions dealing AoE damage."},
                {name = "Kite Phase", desc = "Switches to Kite Phase, chasing random player."},
                {name = "Volcanic Eruption", desc = "During Kite Phase, creates fire patches."},
            },
            notes = "Two alternating phases. Tank Phase: Tank boss, move from Volcanic Geysers. Kite Phase: Targeted player kites boss, raid spreads and avoids volcanoes. Move between zones to reset."
        },
        ["Shade of Akama"] = {
            health = {normal = "2,940,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Shadow of Death", desc = "Channeled attack that must be line-of-sighted."},
                {name = "Adds", desc = "Constant waves of adds that must be managed."},
            },
            adds = "Channelers, Sorcerers, Spawns, and Defenders - endless waves",
            notes = "Defensive encounter. Shade is initially immune. Kill 6 Channelers on sides first while managing add waves. Tank Akama helps. Once Channelers dead, Shade vulnerable - burn boss. Very add-heavy."
        },
        ["Teron Gorefiend"] = {
            health = {normal = "6,300,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Shadow of Death", desc = "Kills a player, turning them into a ghost - must kill Vengeful Spirits!"},
                {name = "Incinerate", desc = "Heavy fire damage on random target."},
                {name = "Crushing Shadows", desc = "Debuff dealing shadow damage when healed."},
                {name = "Doom Blossom", desc = "Creates shadow zones on ground."},
            },
            notes = "Complex mechanic: Random player becomes ghost and must kill constructs in spirit realm. Living raid damages boss while dodging shadow zones. Spread out. Don't heal Crushing Shadows targets."
        },
        ["Gurtogg Bloodboil"] = {
            health = {normal = "7,560,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Bloodboil", desc = "Raid-wide bleed damage that stacks."},
                {name = "Fel Acid Breath", desc = "Frontal cone acid attack."},
                {name = "Arcing Smash", desc = "Frontal cone knockback."},
                {name = "Fel Rage", desc = "Enrages on random raid member - they must be healed!"},
                {name = "Eject", desc = "Knocks tank back and resets threat."},
            },
            notes = "Heal-intensive fight. Raid stacks for Bloodboil healing. Tank faces boss away. During Fel Rage, targeted player takes massive damage - all healers on them. Off-tanks ready for Eject."
        },
        ["Reliquary of Souls"] = {
            health = {normal = "13,860,000 total"},
            mana = {normal = nil},
            abilities = {
                {name = "Essence of Suffering", desc = "Phase 1 - Physical attacks, Fixate, Enrage."},
                {name = "Essence of Desire", desc = "Phase 2 - Mana drains, Spirit Shock, Deaden."},
                {name = "Essence of Anger", desc = "Phase 3 - Raid-wide aura, Soul Scream, Spite."},
            },
            notes = "Three-phase encounter, each with different mechanics. P1: Kite when Fixated, tank swap for Enrage. P2: Manage mana carefully, interrupt heals. P3: High DPS phase, spread for Spite. Very complex."
        },
        ["Mother Shahraz"] = {
            health = {normal = "8,400,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Fatal Attraction", desc = "Teleports 3 players together - they explode for AoE damage!"},
                {name = "Prismatic Aura", desc = "Random school immunity - raid needs all resist types."},
                {name = "Saber Lash", desc = "Splits damage between 3 nearest targets - need 3 tanks!"},
                {name = "Sinful Beam", desc = "Random debuffs on raid members."},
                {name = "Enrage", desc = "10 minute berserk."},
            },
            notes = "Shadow resist fight. CRITICAL: 3 tanks must stack for Saber Lash or tank dies. Players with Fatal Attraction run away from raid. Need all resist types for Prismatic Aura. 10 min enrage."
        },
        ["Illidari Council"] = {
            health = {normal = "2,100,000 each"},
            mana = {normal = "Varies"},
            abilities = {
                {name = "Lady Malande", desc = "Healer - Reflective Shield, Circle of Healing."},
                {name = "High Nethermancer Zerevor", desc = "Mage - Flamestrike, Blizzard, Arcane Bolt."},
                {name = "Gathios the Shatterer", desc = "Paladin - Blessing of Spell Warding, Hammer of Justice."},
                {name = "Veras Darkshadow", desc = "Rogue - Vanish, Envenom, Deadly Poison."},
            },
            notes = "Four-boss council fight. All share health pool. Kill order: Usually focus one at a time. Interrupt Malande heals. Move from Flamestrike/Blizzard. Tank Veras separately. Complex positioning."
        },
        ["Illidan Stormrage"] = {
            health = {normal = "13,860,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Shear", desc = "Removes 60% of tank's threat - tank swap required!"},
                {name = "Flame Burst", desc = "AoE fire damage around boss."},
                {name = "Draw Soul", desc = "Spawns Shadow Demons that chase lowest HP players."},
                {name = "Demon Form", desc = "Phase 2: Transforms into demon, raid-wide AoE damage."},
                {name = "Eye Blast", desc = "Laser beam that must be avoided."},
                {name = "Dark Barrage", desc = "Shadow damage on random players."},
                {name = "Phase 4: Maiev", desc = "Maiev helps in final phase, place Traps."},
            },
            adds = "Shadow Demons, Flame of Azzinoth, Parasites",
            notes = "Epic 5-phase fight. P1: Tank swap on Shear. P2: Demon form, spread out. P3: Tank Flames. P4: Use Maiev's traps, kill demons. P5: Burn boss. Requires Warglaive drops. Final BT boss."
        },
    },
    ["Zul'Aman"] = {
        ["Nalorakk"] = {
            health = {normal = "2,310,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Mangle", desc = "Heavy bleed damage on tank."},
                {name = "Surge", desc = "Charges random player."},
                {name = "Bear Form", desc = "Phase 1: Bear form with Mangle/Surge."},
                {name = "Troll Form", desc = "Phase 2: Troll form with Rend/Deafening Roar."},
            },
            notes = "First timed boss. Two forms alternate. Bear form: High physical damage, bleeds. Troll form: Silences and bleeds. Tank swap between phases. Healers prepare for Mangle."
        },
        ["Akil'zon"] = {
            health = {normal = "2,310,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Static Disruption", desc = "Places storm on random player - stay away from others!"},
                {name = "Call Lightning", desc = "Chain lightning hitting highest HP targets."},
                {name = "Electrical Storm", desc = "Levitates random player, raid takes heavy damage."},
                {name = "Summon Eagles", desc = "Spawns eagles that must be killed."},
            },
            adds = "Soaring Eagles - kill these quickly",
            notes = "Eagle boss. Players with Static Disruption must move away from raid. Kill eagles. One player targeted by Electrical Storm - everyone else hides behind them to avoid damage."
        },
        ["Jan'alai"] = {
            health = {normal = "2,310,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Flame Breath", desc = "Frontal cone fire attack."},
                {name = "Fireball", desc = "Heavy fire damage on random target."},
                {name = "Fire Bomb", desc = "Creates fire patches on ground."},
                {name = "Hatch Eggs", desc = "Periodically hatches egg groups OR all eggs at 25% HP."},
                {name = "Enrage", desc = "5 minute soft enrage."},
            },
            adds = "Dragonhawk Hatchlings from eggs",
            notes = "Dragonhawk boss. Two strategies: Kill egg groups before they hatch OR save all eggs for burn phase. Move from Fire Bombs. Tank faces away for Flame Breath. Very AoE heavy at 25%."
        },
        ["Halazzi"] = {
            health = {normal = "2,310,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Saber Lash", desc = "Splits damage between nearest targets - stack tanks!"},
                {name = "Flame Shock", desc = "Fire damage DOT."},
                {name = "Earth Shock", desc = "Interrupt."},
                {name = "Frenzy", desc = "Lynx adds at 75%, 50%, 25% HP - splits into Lynx."},
                {name = "Transform", desc = "Splits into Halazzi and his Lynx spirit."},
            },
            adds = "Corrupted Lightning Totems - destroy these",
            notes = "Lynx boss. At each 25% threshold, splits into troll and lynx - both must be damaged. Stack melee for Saber Lash. Kill totems immediately. Tank swap ready."
        },
        ["Hex Lord Malacrass"] = {
            health = {normal = "1,890,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Spirit Bolts", desc = "Shadow damage on multiple targets."},
                {name = "Soul Drain", desc = "Massive 8-second drain that must be interrupted!"},
                {name = "Steal Player Ability", desc = "Copies random player's class abilities."},
            },
            adds = "4 Random adds from pool - must be CC'd or killed",
            notes = "CC or kill adds first (various combinations). CRITICAL: Interrupt Soul Drain or raid wipes! Boss gains random player abilities making each pull different. Focus interrupts."
        },
        ["Zul'jin"] = {
            health = {normal = "2,940,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Grievous Throw", desc = "Heavy physical damage reducing healing received."},
                {name = "Phase 1: Troll Form", desc = "Tank and spank with bleeds."},
                {name = "Phase 2: Bear Form", desc = "Paralyzing Roar, Creeping Paralysis."},
                {name = "Phase 3: Eagle Form", desc = "Energy Storm, Column of Fire, Summons Eagles."},
                {name = "Phase 4: Lynx Form", desc = "Claw Rage, Lynx Rush, Summons Lynxes."},
                {name = "Phase 5: Dragonhawk Form", desc = "Flame Whirl, Fire Breath, Flame Column."},
            },
            adds = "Eagles in Phase 3, Lynxes in Phase 4",
            notes = "Final boss - 5 phases, each representing an animal god. Complex phase transitions. P2: Dispel paralysis. P3: Move from pillars, kill eagles. P4: Kill lynxes. P5: Burn boss while avoiding fire."
        },
    },
    ["Sunwell Plateau"] = {
        ["Kalecgos"] = {
            health = {normal = "10,080,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Spectral Blast", desc = "Arcane damage and teleport to demon realm."},
                {name = "Arcane Buffet", desc = "Stacking arcane damage debuff."},
                {name = "Sathrovarr", desc = "Demon form in shadow realm - must be tanked."},
                {name = "Corrupting Strike", desc = "Stacking curse on shadow tank."},
                {name = "Portal", desc = "Players use portals to switch between realms."},
            },
            notes = "Two-realm fight. Half raid fights Kalecgos in normal realm, half fights Sathrovarr demon in shadow realm. Both must die within 1 minute. Use portals to equalize. Dispel curses."
        },
        ["Brutallus"] = {
            health = {normal = "10,080,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Meteor Slash", desc = "Massive physical damage, split between targets - 2 tanks!"},
                {name = "Burn", desc = "Stacking fire DOT debuff on tank - tank swap!"},
                {name = "Stomp", desc = "AoE knockback with physical damage."},
                {name = "Enrage", desc = "6 minute hard enrage - tight DPS check!"},
            },
            notes = "Pure DPS race. CRITICAL: 2 tanks rotate on Burn stacks (swap at 2-3 stacks). Stack melee for Meteor Slash. 6 minute enrage - toughest DPS check in TBC. Requires full buffs and consumables."
        },
        ["Felmyst"] = {
            health = {normal = "10,080,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Gas Nova", desc = "Raid-wide damage, leaves fog that encapsulates players."},
                {name = "Encapsulate", desc = "Traps player in green bubble - raid must free them!"},
                {name = "Demonic Vapor", desc = "Creates fog trails during air phase - hide behind these!"},
                {name = "Fog of Corruption", desc = "Instant death if standing in open during air phase."},
                {name = "Air Phase", desc = "Boss flies up, shoots beams creating fog trails."},
            },
            notes = "Two phases alternate. Ground: Free encapsulated players, spread for Gas Nova. Air: Boss flies creating fog trails with beams - everyone hide behind fog or die instantly. Very positioning heavy."
        },
        ["Eredar Twins"] = {
            health = {normal = "5,880,000 each"},
            mana = {normal = "500,000 each"},
            abilities = {
                {name = "Sacrolash - Fire", desc = "Conflagration, Flame Sear, Shadow Nova."},
                {name = "Alythess - Shadow", desc = "Conflagration, Shadow Nova, Pyrogenics."},
                {name = "Empower", desc = "When far apart, they empower each other."},
                {name = "Conflagration", desc = "Huge AoE fire damage - spread out!"},
                {name = "Shadow Nova", desc = "Shadow explosion around boss."},
            },
            notes = "Twin boss fight with fire/shadow mechanics. Keep bosses together or they empower. Sacrolash tank moves away before Conflagration. Raid gets buffs from same-color abilities, damage from opposite."
        },
        ["M'uru"] = {
            health = {normal = "6,720,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Darkness", desc = "Raid-wide shadow damage increasing over time."},
                {name = "Summon Void Sentinel", desc = "Spawns Sentinel adds."},
                {name = "Summon Void Spawn", desc = "Spawns Spawns from dead Sentinels."},
                {name = "Dark Fiend", desc = "Summons humanoid adds."},
                {name = "Entropius", desc = "Phase 2: M'uru dies, becomes Entropius void god."},
                {name = "Black Hole", desc = "Phase 2: Creates Black Holes that pull players in."},
            },
            adds = "Multiple add types: Sentinels, Spawns, Dark Fiends, Fury Mages",
            notes = "Brutal 2-phase fight. P1: Kill adds while damaging boss. Darkness kills raid slowly. Very add-heavy. P2: M'uru becomes Entropius - kill Black Holes, avoid void zones, burn boss. Insane difficulty."
        },
        ["Kil'jaeden"] = {
            health = {normal = "12,600,000"},
            mana = {normal = nil},
            abilities = {
                {name = "Soul Flay", desc = "Shadow damage beam on random target."},
                {name = "Legion Lightning", desc = "Chain lightning between players."},
                {name = "Fire Bloom", desc = "Massive fire damage and knockback."},
                {name = "Flame Dart", desc = "Fire missile on random targets."},
                {name = "Sinister Reflection", desc = "Spawns evil clones of players."},
                {name = "Shield Orbs", desc = "Blue orbs appear - ranged must shoot them down for shields."},
                {name = "Darkness", desc = "Phase 2: Darkness increases, blue orbs protect raid."},
            },
            adds = "Sinister Reflections, Shield Orbs",
            notes = "Final TBC boss - 5 phases. Extremely complex. P1-3: Manage adds, spread for lightning, use blue orbs for shields. P4: DPS race with Darkness. P5: All abilities active, strict positioning. Legendary bow drops."
        },
    },
}

-- Get raid boss data for a specific raid and boss
function B:GetRaidBossData(raidName, bossName)
    if self.RaidBosses[raidName] then
        return self.RaidBosses[raidName][bossName]
    end
    return nil
end

-- Get all bosses for a raid (returns detailed data)
function B:GetRaidBossesDetailed(raidName)
    return self.RaidBosses[raidName] or {}
end

-- Get simple boss name list for a raid (for UI)
function B:GetRaidBossList(raidName)
    local bosses = {}
    if self.RaidBosses[raidName] then
        for bossName, _ in pairs(self.RaidBosses[raidName]) do
            table.insert(bosses, bossName)
        end
    end
    return bosses
end

-- Legacy compatibility: Keep old GetRaidBosses for simple name lists
function B:GetRaidBosses(raidName)
    return self:GetRaidBossList(raidName)
end

-- Get all raids
function B:GetAllRaids()
    local raids = {}
    for raidName, _ in pairs(self.RaidBosses) do
        table.insert(raids, raidName)
    end
    return raids
end

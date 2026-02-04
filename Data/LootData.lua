-- Dungeon Spam Tracker - Cached Loot Data
-- Extracted from AtlasLoot Classic for when the addon is not available
local ADDON_NAME, DST = ...

DST.LootData = {}
local L = DST.LootData

-- Loot information for TBC dungeons
-- Format: {bossName, normalLootCount, heroicLootCount, items = {normal = {itemIDs}, heroic = {itemIDs}}}
L.Dungeons = {
    ["Hellfire Ramparts"] = {
        atlasLootID = "HellfireRamparts",
        bosses = {
            {
                name = "Watchkeeper Gargolmar",
                normal = 6,
                heroic = 6,
                items = {
                    normal = {24024, 24023, 24022, 24021, 24020, 23881},
                    heroic = {27448, 27451, 27450, 27447, 27449, 23881}
                }
            },
            {
                name = "Omor the Unscarred",
                normal = 7,
                heroic = 13,
                items = {
                    normal = {24090, 24091, 24073, 24096, 24094, 24069, 23886},
                    heroic = {27466, 27462, 27467, 27478, 27539, 27906, 27464, 27895, 27477, 27463, 27476, 23886, 27465}
                }
            },
            {
                name = "Nazan & Vazruden",
                normal = 11,
                heroic = 15,
                items = {
                    normal = {24150, 24083, 24063, 24046, 24064, 24045, 24154, 24151, 24044, 24155, 23891},
                    heroic = {29264, 32077, 29238, 29346, 27452, 27461, 27456, 27454, 27458, 27455, 27459, 27457, 27453, 27460, 23891}
                }
            }
        }
    },
    ["Blood Furnace"] = {
        atlasLootID = "TheBloodFurnace",
        bosses = {
            {
                name = "The Maker",
                normal = 5,
                heroic = 5,
                items = {
                    normal = {24388, 24387, 24385, 24386, 24384},
                    heroic = {27485, 27488, 27483, 27487, 27484}
                }
            },
            {
                name = "Broggok",
                normal = 5,
                heroic = 5,
                items = {
                    normal = {24392, 24393, 24391, 24390, 24389},
                    heroic = {27848, 27492, 27489, 27491, 27490}
                }
            },
            {
                name = "Keli'dan the Breaker",
                normal = 5,
                heroic = 17,
                items = {
                    normal = {24397, 24395, 24398, 24396, 24394},
                    heroic = {32080, 29245, 29239, 29347, 27506, 27514, 27522, 27494, 27505, 27788, 27495, 28121, 28264, 27497, 27512, 27507, 33814}
                }
            }
        }
    },
    ["Shattered Halls"] = {
        atlasLootID = "TheShatteredHalls",
        bosses = {
            {
                name = "Grand Warlock Nethekurse",
                normal = 8,
                heroic = 9,
                items = {
                    normal = {24312, 27519, 27517, 27521, 27520, 27518, 21525, 23735},
                    heroic = {24312, 27519, 27517, 27521, 27520, 27518, 23735, 25462, 21525}
                }
            },
            {
                name = "Blood Guard Porung",
                normal = 0,
                heroic = 5,
                items = {
                    normal = {},
                    heroic = {30709, 30707, 30708, 30705, 30710}
                }
            },
            {
                name = "Warbringer O'mrogg",
                normal = 6,
                heroic = 6,
                items = {
                    normal = {27525, 27868, 27524, 27526, 30829, 27802},
                    heroic = {27525, 27868, 27524, 27526, 30829, 27802}
                }
            },
            {
                name = "Warchief Kargath Bladefist",
                normal = 13,
                heroic = 18,
                items = {
                    normal = {27527, 27529, 27534, 27533, 27538, 27540, 23723, 27536, 27537, 27531, 27474, 27528, 27535},
                    heroic = {29255, 29263, 29254, 29348, 27527, 27529, 27534, 27533, 27538, 27540, 23723, 33815, 27536, 27537, 27531, 27474, 27528, 27535}
                }
            }
        }
    },
    ["Mana-Tombs"] = {
        atlasLootID = "ManaTombs",
        bosses = {
            {
                name = "Pandemonius",
                normal = 6,
                heroic = 6,
                items = {
                    normal = {25941, 25942, 25940, 25943, 28166, 25939},
                    heroic = {27816, 27818, 27813, 27815, 27814, 27817}
                }
            },
            {
                name = "Tavarok",
                normal = 6,
                heroic = 6,
                items = {
                    normal = {25945, 25946, 25947, 25952, 25944, 25950},
                    heroic = {27824, 27821, 27825, 27826, 27823, 27822}
                }
            },
            {
                name = "Nexus-Prince Shaffar",
                normal = 8,
                heroic = 19,
                items = {
                    normal = {25957, 25955, 25956, 25954, 25962, 25953, 22921, 28490},
                    heroic = {29240, 30535, 29352, 32082, 27831, 27843, 27827, 27835, 27844, 27798, 33835, 28490, 27837, 27828, 28400, 27829, 27840, 27842, 22921}
                }
            },
            {
                name = "Yor (Void Hound of Shaffar)",
                normal = 0,
                heroic = 10,
                items = {
                    normal = {},
                    heroic = {31919, 31920, 31921, 31922, 31923, 31924, 31554, 31562, 31570, 31578}
                }
            }
        }
    },
    ["Auchenai Crypts"] = {
        atlasLootID = "AuchenaiCrypts",
        bosses = {
            {
                name = "Shirrak the Dead Watcher",
                normal = 5,
                heroic = 6,
                items = {
                    normal = {27410, 27409, 27408, 26055, 25964},
                    heroic = {27866, 27493, 27865, 27845, 27847, 27846}
                }
            },
            {
                name = "Exarch Maladaar",
                normal = 7,
                heroic = 11,
                items = {
                    normal = {27411, 27415, 27414, 27413, 27416, 27412, 21525},
                    heroic = {29354, 29257, 29244, 27867, 27871, 27869, 27523, 27872, 21525, 33836, 27870}
                }
            },
            {
                name = "Avatar of the Martyred",
                normal = 0,
                heroic = 6,
                items = {
                    normal = {},
                    heroic = {27878, 28268, 27876, 27937, 27877, 27797}
                }
            }
        }
    },
    ["Sethekk Halls"] = {
        atlasLootID = "SethekkHalls",
        bosses = {
            {
                name = "Darkweaver Syth",
                normal = 8,
                heroic = 9,
                items = {
                    normal = {27919, 27914, 27915, 27918, 27917, 27916, 24160, 27633},
                    heroic = {27919, 27914, 27915, 27918, 27917, 27916, 24160, 27633, 25461}
                }
            },
            {
                name = "Talon King Ikiss",
                normal = 13,
                heroic = 18,
                items = {
                    normal = {27946, 27981, 27985, 27925, 27980, 27986, 27632, 27991, 27948, 27838, 27875, 27776, 27936},
                    heroic = {29249, 29259, 32073, 29355, 27946, 27981, 27985, 27925, 27980, 27986, 27991, 27948, 27838, 27875, 27776, 27936, 27632, 33834}
                }
            },
            {
                name = "Anzu",
                normal = 0,
                heroic = 6,
                items = {
                    normal = {},
                    heroic = {32768, 32769, 32778, 32779, 32781, 32780}
                }
            }
        }
    },
    ["Shadow Labyrinth"] = {
        atlasLootID = "ShadowLabyrinth",
        bosses = {
            {
                name = "Ambassador Hellmaw",
                normal = 6,
                heroic = 6,
                items = {
                    normal = {27889, 27888, 27884, 27886, 27887, 27885},
                    heroic = {27889, 27888, 27884, 27886, 27887, 27885}
                }
            },
            {
                name = "Blackheart the Inciter",
                normal = 8,
                heroic = 8,
                items = {
                    normal = {27892, 27893, 28134, 27891, 27890, 25728, 30808, 27468},
                    heroic = {27892, 27893, 28134, 27891, 27890, 25728, 30808, 27468}
                }
            },
            {
                name = "Grandmaster Vorpil",
                normal = 7,
                heroic = 7,
                items = {
                    normal = {27897, 27900, 27901, 27898, 21525, 30827, 27775},
                    heroic = {27897, 27900, 27901, 27898, 21525, 30827, 27775}
                }
            },
            {
                name = "Murmur",
                normal = 13,
                heroic = 19,
                items = {
                    normal = {24309, 27902, 27912, 27913, 27905, 27903, 27910, 27778, 28232, 28230, 27908, 27909, 27803},
                    heroic = {30532, 29357, 29261, 29353, 27902, 27912, 27913, 27905, 27903, 27910, 31722, 24309, 27778, 28232, 28230, 27908, 27909, 27803, 33840}
                }
            }
        }
    },
    ["Slave Pens"] = {
        atlasLootID = "TheSlavePens",
        bosses = {
            {
                name = "Mennu the Betrayer",
                normal = 6,
                heroic = 7,
                items = {
                    normal = {24359, 24357, 24360, 24356, 24361, 29674},
                    heroic = {27542, 27545, 27541, 27546, 27544, 27543, 29674}
                }
            },
            {
                name = "Rokmar the Crackler",
                normal = 5,
                heroic = 6,
                items = {
                    normal = {24379, 24376, 24378, 24380, 24381},
                    heroic = {27550, 27547, 28124, 27549, 27548, 27551}
                }
            },
            {
                name = "Quagmirran",
                normal = 5,
                heroic = 17,
                items = {
                    normal = {24362, 24365, 24366, 24363, 24364},
                    heroic = {29242, 30538, 32078, 29349, 27712, 27800, 28337, 27672, 27742, 33821, 27796, 27713, 27740, 27683, 27714, 27673, 27741}
                }
            }
        }
    },
    ["Underbog"] = {
        atlasLootID = "TheUnderbog",
        bosses = {
            {
                name = "Hungarfen",
                normal = 5,
                heroic = 6,
                items = {
                    normal = {24450, 24452, 24451, 24413, 27631},
                    heroic = {27746, 27745, 27743, 27748, 27744, 27747}
                }
            },
            {
                name = "Ghaz'an",
                normal = 5,
                heroic = 6,
                items = {
                    normal = {24459, 24458, 24460, 24462, 24461},
                    heroic = {27760, 27759, 27755, 27758, 27761, 27757}
                }
            },
            {
                name = "Swamplord Musel'ek",
                normal = 5,
                heroic = 6,
                items = {
                    normal = {24454, 24455, 24457, 24456, 24453},
                    heroic = {27764, 27763, 27765, 27766, 27762, 27767}
                }
            },
            {
                name = "The Black Stalker",
                normal = 6,
                heroic = 18,
                items = {
                    normal = {24481, 24466, 24465, 24463, 24464, 24248},
                    heroic = {29265, 30541, 32081, 29350, 27781, 27768, 27938, 27773, 27779, 27780, 27896, 27770, 27907, 27771, 27769, 27772, 24248, 33826}
                }
            }
        }
    },
    ["Steamvault"] = {
        atlasLootID = "TheSteamvault",
        bosses = {
            {
                name = "Hydromancer Thespia",
                normal = 7,
                heroic = 7,
                items = {
                    normal = {27789, 27787, 27783, 27784, 29673, 30828, 27508},
                    heroic = {27789, 27787, 27783, 27784, 29673, 30828, 27508}
                }
            },
            {
                name = "Mekgineer Steamrigger",
                normal = 6,
                heroic = 6,
                items = {
                    normal = {27793, 27790, 27792, 27791, 27794, 23887},
                    heroic = {27793, 27790, 27792, 27791, 27794, 23887}
                }
            },
            {
                name = "Warlord Kalithresh",
                normal = 13,
                heroic = 19,
                items = {
                    normal = {24313, 27804, 27799, 27795, 27806, 27805, 27738, 27737, 27801, 27510, 27874, 28203, 27475},
                    heroic = {30543, 29243, 29463, 29351, 27804, 27799, 27795, 27806, 27805, 31721, 33827, 24313, 27738, 27737, 27801, 27510, 27874, 28203, 27475}
                }
            }
        }
    },
    ["Old Hillsbrad"] = {
        atlasLootID = "OldHillsbradFoothills",
        bosses = {
            {
                name = "Lieutenant Drake",
                normal = 5,
                heroic = 6,
                items = {
                    normal = {27423, 27418, 27417, 27420, 27436},
                    heroic = {28212, 28214, 28215, 28211, 28213, 28210}
                }
            },
            {
                name = "Captain Skarloc",
                normal = 8,
                heroic = 9,
                items = {
                    normal = {27428, 27430, 27427, 27424, 27426, 21524, 22927},
                    heroic = {28218, 28220, 28219, 28221, 28217, 28216, 21524, 22927}
                }
            },
            {
                name = "Epoch Hunter",
                normal = 6,
                heroic = 19,
                items = {
                    normal = {24173, 27433, 27434, 27440, 27432, 27431},
                    heroic = {29250, 29246, 30534, 30536, 27911, 28344, 28233, 27904, 28227, 28223, 28226, 28222, 24173, 28191, 28224, 28401, 28225, 33847}
                }
            },
            {
                name = "Don Carlos",
                normal = 2,
                heroic = 3,
                items = {
                    normal = {38276, 38329},
                    heroic = {38506, 38276, 38329}
                }
            }
        }
    },
    ["Black Morass"] = {
        atlasLootID = "TheBlackMorass",
        bosses = {
            {
                name = "Chrono Lord Deja",
                normal = 7,
                heroic = 7,
                items = {
                    normal = {27988, 27994, 27995, 27993, 27996, 27987, 29675},
                    heroic = {27988, 27994, 27995, 27993, 27996, 27987, 29675}
                }
            },
            {
                name = "Temporus",
                normal = 6,
                heroic = 6,
                items = {
                    normal = {28185, 28186, 28034, 28187, 28184, 28033},
                    heroic = {28185, 28186, 28034, 28187, 28184, 28033}
                }
            },
            {
                name = "Aeonus",
                normal = 12,
                heroic = 17,
                items = {
                    normal = {28206, 28194, 28207, 28190, 28189, 28188, 28193, 27509, 27873, 28192, 27977, 27839},
                    heroic = {30531, 29247, 29253, 29356, 28206, 28194, 28207, 28190, 28189, 28188, 33858, 28193, 27509, 27873, 28192, 27977, 27839}
                }
            }
        }
    },
    ["Arcatraz"] = {
        atlasLootID = "TheArcatraz",
        bosses = {
            {
                name = "Zereketh the Unbound",
                normal = 5,
                heroic = 5,
                items = {
                    normal = {28373, 28374, 28384, 28375, 28372},
                    heroic = {28373, 28374, 28384, 28375, 28372}
                }
            },
            {
                name = "Dalliah the Doomsayer",
                normal = 6,
                heroic = 6,
                items = {
                    normal = {24308, 28391, 28390, 28387, 28392, 28386},
                    heroic = {28391, 28390, 28387, 28392, 28386, 24308}
                }
            },
            {
                name = "Wrath-Scryer Soccothrates",
                normal = 5,
                heroic = 5,
                items = {
                    normal = {28396, 28398, 28394, 28393, 28397},
                    heroic = {28396, 28398, 28394, 28393, 28397}
                }
            },
            {
                name = "Harbinger Skyriss",
                normal = 12,
                heroic = 17,
                items = {
                    normal = {28406, 28419, 28407, 28418, 28412, 28416, 28415, 28413, 28414, 28231, 28403, 28205},
                    heroic = {29241, 29248, 29252, 29360, 28406, 28419, 28407, 28418, 28412, 28416, 33861, 28415, 28413, 28414, 28231, 28403, 28205}
                }
            }
        }
    },
    ["Botanica"] = {
        atlasLootID = "TheBotanica",
        bosses = {
            {
                name = "Commander Sarannis",
                normal = 6,
                heroic = 5,
                items = {
                    normal = {28301, 28304, 28306, 28296, 28311, 28769},
                    heroic = {28301, 28304, 28306, 28296, 28311}
                }
            },
            {
                name = "High Botanist Freywinn",
                normal = 8,
                heroic = 8,
                items = {
                    normal = {28317, 28318, 28321, 28315, 28316, 23617, 21524, 31744},
                    heroic = {28317, 28318, 28321, 28315, 28316, 21524, 23617, 31744}
                }
            },
            {
                name = "Thorngrin the Tender",
                normal = 6,
                heroic = 7,
                items = {
                    normal = {24310, 28324, 28327, 28323, 28322, 28325},
                    heroic = {24310, 28324, 28327, 28323, 28322, 28325}
                }
            },
            {
                name = "Laj",
                normal = 5,
                heroic = 5,
                items = {
                    normal = {28328, 28338, 28340, 28339, 27739},
                    heroic = {28328, 28338, 28340, 28339, 27739}
                }
            },
            {
                name = "Warp Splinter",
                normal = 15,
                heroic = 20,
                items = {
                    normal = {24311, 28371, 28342, 28347, 28343, 28370, 28345, 28367, 28341, 31085, 28229, 28348, 28349, 28228, 28350},
                    heroic = {29258, 29262, 32072, 29359, 28371, 28342, 28347, 28343, 28370, 28345, 28367, 28341, 24311, 28229, 28348, 28349, 28228, 28350, 31085, 33859}
                }
            }
        }
    },
    ["Mechanar"] = {
        atlasLootID = "TheMechanar",
        bosses = {
            {
                name = "Mechano-Lord Capacitus",
                normal = 6,
                heroic = 6,
                items = {
                    normal = {28256, 28255, 28254, 28257, 28253, 35582},
                    heroic = {28256, 28255, 28254, 28257, 28253, 35582}
                }
            },
            {
                name = "Nethermancer Sepethrea",
                normal = 8,
                heroic = 8,
                items = {
                    normal = {28262, 28259, 28260, 28263, 28258, 21524, 22920},
                    heroic = {28262, 28259, 28260, 28263, 28258, 21524, 22920}
                }
            },
            {
                name = "Pathaleon the Calculator",
                normal = 14,
                heroic = 19,
                items = {
                    normal = {28269, 28266, 28265, 28288, 27899, 28267, 28286, 21907, 31086, 28278, 28202, 28204, 28275, 28285},
                    heroic = {29251, 32076, 30533, 29362, 28269, 28266, 28265, 28288, 27899, 28267, 28286, 21907, 28278, 28202, 28204, 28275, 28285, 33860, 31086}
                }
            },
            {
                name = "Cache of the Legion",
                normal = 0,
                heroic = 5,
                items = {
                    normal = {},
                    heroic = {28249, 28250, 28252, 28251, 28248}
                }
            }
        }
    },
    ["Magisters' Terrace"] = {
        atlasLootID = "MagistersTerrace",
        bosses = {
            {
                name = "Selin Fireheart",
                normal = 6,
                heroic = 5,
                items = {
                    normal = {34702, 34697, 34701, 34698, 34700, 34699},
                    heroic = {34602, 34601, 34604, 34603, 35275}
                }
            },
            {
                name = "Vexallus",
                normal = 6,
                heroic = 5,
                items = {
                    normal = {34708, 34705, 34707, 34704, 34706, 34703},
                    heroic = {34607, 34605, 34606, 34608, 35275}
                }
            },
            {
                name = "Priestess Delrissa",
                normal = 7,
                heroic = 6,
                items = {
                    normal = {34792, 34788, 34791, 34789, 34790, 34783, 35756},
                    heroic = {34473, 34471, 34470, 34472, 35275, 35756}
                }
            },
            {
                name = "Kael'thas Sunstrider",
                normal = 17,
                heroic = 13,
                items = {
                    normal = {34810, 34808, 34809, 34799, 34807, 34625, 34793, 34796, 34795, 34798, 34794, 34797, 35504, 35311, 35304, 35294, 34157},
                    heroic = {34610, 34613, 34614, 34615, 34612, 34611, 34609, 34616, 35513, 35504, 35311, 35304, 35294}
                }
            }
        }
    }
}

-- Get loot data for a dungeon
function L:GetDungeonLoot(dungeonName)
    return self.Dungeons[dungeonName]
end

-- Get boss list for a dungeon
function L:GetBossList(dungeonName)
    local data = self.Dungeons[dungeonName]
    if not data then return {} end
    return data.bosses
end

-- Get total loot count for a dungeon
function L:GetTotalLoot(dungeonName, difficulty)
    local data = self.Dungeons[dungeonName]
    if not data then return 0 end

    local total = 0
    for _, boss in ipairs(data.bosses) do
        if difficulty == "heroic" then
            total = total + (boss.heroic or 0)
        else
            total = total + (boss.normal or 0)
        end
    end
    return total
end

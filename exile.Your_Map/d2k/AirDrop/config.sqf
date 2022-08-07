/*
 * Desa2k's Playhouse
 * https://discord.gg/3RCdgzDCzD
 * Author: Apoc
 * Reworked into Standalone by Desa2k
 */

APOC_AA_coolDownTime = 60; 			// Time before AirDrop can be used again, Expressed in sec
APOC_AA_AdvancedBanking = false;		// false = use locker system, true = use Advanced Banking
APOC_AA_UseExileLockerFunds = true;		// false = use poptabs from wallet, true = use poptabs from locker (only applies if using locker sysytem)
APOC_Heli = "B_Heli_Transport_03_unarmed_F"; 	// Classname of the aircraft to deliver the goods.
APOC_Distance = 3000;				// Distance from player that the aircraft will spawn
APOC_Height = 200;				// Hight of aircraft flight
APOC_Heli_Damage = false;			// false = aircraft can not be damaged, true = aircraft can be damaged
APOC_Captive = true;				// false = visable to other ai (will get shot at), true = invisable to other ai (will not get shot at)
APOC_Delivery_Damage = false;			// false = goods can not be damaged during delivery, true = goods can be damaged during delivery


APOC_AA_VehOptions =
[ // ["Menu Text",		ItemClassname,				Price,		"Drop Type"]
["Quadbike (Civilian)", 	"C_Quadbike_01_F", 			10000, 		"vehicle"],
["Golf Black", 			"Exile_Car_Golf_Black", 		10000, 		"vehicle"],
["Offroad HMG", 		"B_G_Offroad_01_armed_F",		20000, 		"vehicle"],
["Strider HMG", 		"I_MRAP_03_hmg_F", 			70000, 		"vehicle"],
["Strider GMG", 		"I_MRAP_03_gmg_F", 			65000, 		"vehicle"],
["Little Bird", 		"CUP_B_MH6J_USA", 			20000, 		"vehicle"],
["Gorgon", 			"I_APC_Wheeled_03_cannon_F", 		250000, 	"vehicle"],
["Ferret AA", 			"SC_Ferret_AA_AR", 			350000, 	"vehicle"],
["Ferret Autocannon", 		"SC_Ferret_Autocannon_AR", 		350000, 	"vehicle"],
["Saurus Shredder AA", 		"SC_SaurusAPC_AA_SE", 			600000, 	"vehicle"],
["Saurus APC", 			"SC_SaurusAPC_SE", 			600000, 	"vehicle"],
["Pawnee",	 		"B_Heli_Light_01_dynamicLoadout_F", 	150000, 	"vehicle"],
["Ghost Hawk", 			"B_Heli_Transport_01_F", 		200000,		"vehicle"],
["BTR80 Autocannon", 		"CUP_O_BTR80A_CAMO_RU", 		225000, 	"vehicle"],
["Trump Tank", 			"MAGA_B_M1A1_Trump", 			1000000, 	"vehicle"]
];

APOC_AA_SupOptions =
[// ["stringItemName", 		"Crate Type for fn_refillBox		Price," drop type"]
["Launchers", 			"mission_USLaunchers", 			35000, "supply"],
["Assault Rifle", 		"mission_USSpecial", 			35000, "supply"],
["Sniper Rifles", 		"airdrop_Snipers", 			50000, "supply"],
["DLC Rifles", 			"airdrop_DLC_Rifles", 			45000, "supply"],
["DLC LMGs", 			"airdrop_DLC_LMGs", 			45000, "supply"],
["Medical", 			"airdrop_Med", 				35000, "supply"]
];

APOC_AA_FoodOptions =
[//["Menu Text",		"Crate Type",				"Cost", "drop type"]
["EMRE X20",			"aridrop_food",				10000, 	"picnic"],
["Coffee X20",			"airdrop_water",			10000, 	"picnic"],
["EMRE & Coffee X10",		"airdrop_foodandwater",			10000, 	"picnic"],
["Beef Parts X10",		"airdrop_beef",				320000, "picnic"]
];
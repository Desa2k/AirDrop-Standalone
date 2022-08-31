/*
 * Desa2k's Playhouse
 * https://discord.gg/3RCdgzDCzD
 * Author: Apoc
 * Reworked into Standalone by Desa2k
 */

scriptName "d2k_fnc_srv_startAirdrop";
if (!isServer) exitWith {};
private ["_type","_selection","_player"]; //Variables coming from command menu and client side APOC_cli_startAirdrop
_type 				= _this select 0;
_selectionNumber 	= _this select 1;
_player			= _this select 2;

diag_log format ["SERVER - Apoc's Airdrop Assistance - Player: %1, Drop Type: %2, Selection #: %3",name _player,_type,_selectionNumber];
//hint format ["Well we've made it this far! %1, %2, %3,",_player,_type,_selectionNumber];
_selectionArray = [];

switch (_type) do {
	case "vehicle": {_selectionArray = APOC_AA_VehOptions};
	case "supply": 	{_selectionArray = APOC_AA_SupOptions};
	case "picnic":	{_selectionArray = APOC_AA_FoodOptions};
	default 	{_selectionArray = APOC_AA_VehOptions; diag_log "AAA - Default Array Selected - Something broke";};
};

_selectionName 	= (_selectionArray select _selectionNumber) select 0;
_selectionClass = (_selectionArray select _selectionNumber) select 1;
_DropPrice		= (_selectionArray select _selectionNumber) select 2;
// Moved money removal until after the drop point.

//OK, now the real fun

/////// Let's spawn us  an AI helo to carry the cargo /////////////////////////////////////////////////

_heliType = APOC_Heli;
_center = createCenter civilian;
_grp = createGroup civilian;
if(isNil("_grp2"))then{_grp2 = createGroup civilian;}else{_grp2 = _grp2;};
_flyHeight = APOC_Height;  //Distance from ground that heli will fly at
_dropSpot = [(position _player select 0),(position _player select 1),_flyHeight];
_heliDirection = random 360;
_heliStartDistance = APOC_Distance;
_spos=[(_dropSpot select 0) - (sin _heliDirection) * _heliStartDistance, (_dropSpot select 1) - (cos _heliDirection) * _heliStartDistance, (_flyHeight+200)];

diag_log format ["AAA - Heli Spawned at %1", _spos];
_heli = createVehicle [_heliType, _spos, [], 0, "FLY"];
if (APOC_Heli_Damage) then {
	_heli allowDamage true;
} else {
	_heli allowDamage false;
};

//So, apppppparently the heli needs a pilot.  Let's grab one from the BIS ranks
_crew = _grp createUnit ["O_recon_F", _spos, [], 0, "NONE"];
_crew moveInDriver _heli;
if (APOC_Heli_Damage) then {
	_crew allowDamage true;
} else {
	_crew allowDamage false;
};
if (APOC_Captive) then {
	_heli setCaptive true;  //Let's not let everyone else go after this guy, make him invisible to other Ai
} else {
	_heli setCaptive false;
};
_dir = ((_dropSpot select 0) - (_spos select 0)) atan2 ((_dropSpot select 1) - (_spos select 1));
_flySpot = [(_dropSpot select 0) + (sin _dir) * _heliStartDistance, (_dropSpot select 1) + (cos _dir) * _heliStartDistance, _flyHeight];

_grp setCombatMode "BLUE";
_grp setBehaviour "CARELESS";

{_x disableAI "AUTOTARGET"; _x disableAI "TARGET";} forEach units _grp;

//Well ole chap, where are we going?									
_wp0 = _grp addWaypoint [_dropSpot, 0, 1];
[_grp,1] setWaypointBehaviour "CARELESS";
[_grp,1] setWaypointCombatMode "BLUE";
[_grp,1] setWaypointCompletionRadius 20;
_wp1 = _grp addWaypoint [_flySpot, 0, 2];
[_grp,2] setWaypointBehaviour "CARELESS";
[_grp,2] setWaypointCombatMode "BLUE";
[_grp,2] setWaypointCompletionRadius 20;
_heli flyInHeight _flyHeight;

//////// Create Purchased Object //////////////////////////////////////////////
_object = switch (_type) do {
	case "vehicle":
	{
		_objectSpawnPos = [(_spos select 0), (_spos select 1), (_spos select 2) - 5];
		_object = [_selectionClass, _objectSpawnPos, 0, FALSE] call ExileServer_object_vehicle_createNonPersistentVehicle;
		_object attachTo [_heli, [0,0,-5]]; //Attach Object to the heli
		_object
	};
	case "supply":
	{
		_objectSpawnPos = [(_spos select 0), (_spos select 1), (_spos select 2) - 5];
		_object = createVehicle ["Exile_Container_SupplyBox", _objectSpawnPos, [], 0, "None"];
		[_object, _selectionClass] call d2k_fnc_refillbox;
		_object attachTo [_heli, [0,0,-5]]; //Attach Object to the heli
		_object
	};
	case "picnic":  //Beware of Bears!
	{
		_objectSpawnPos = [(_spos select 0), (_spos select 1), (_spos select 2) - 5];
		_object = createVehicle ["Exile_Container_SupplyBox", _objectSpawnPos, [], 0, "None"];
		[_object, _selectionClass] call d2k_fnc_refillbox;
		_object attachTo [_heli, [0,0,-5]]; //Attach Object to the heli
		_object
	};
	default {
		_objectSpawnPos = [(_spos select 0), (_spos select 1), (_spos select 2) - 5];
		_object = createVehicle ["Exile_Container_SupplyBox", _objectSpawnPos, [], 0, "None"];
		[_object, "mission_USSpecial"] call d2k_fnc_refillbox;
		_object attachTo [_heli, [0,0,-5]]; //Attach Object to the heli
		_object
		};
};
if (APOC_Delivery_Damage) then {
	_object allowDamage true;
} else {
	_object allowDamage false; //Let's not let these things get destroyed on the way there, shall we?
};

diag_log format ["Apoc's Airdrop Assistance - Object at %1", position _object];  //A little log love to confirm the location of this new creature

//Wait until the heli completes the drop waypoint, then move on to dropping the cargo and all of that jazz

While {true} do {
	sleep 0.1;
	if (currentWaypoint _grp >= 2) exitWith {};  //Completed Drop Waypoint
};
_playerMoney = 0; //Initialize and all that jazz
if (APOC_AA_AdvancedBanking) then {
    // Let's handle the money after this tricky spot - This way players won't be charged for non-delivered goods!
    _playerMoney = _player getVariable ["ExileBank", 0];
    if (_DropPrice > _playerMoney) exitWith
    {
        { _x setDamage 1; } forEach units _grp;
        _heli setDamage 1; //BOOM
        _object setDamage 1; //BOOM BOOM
        diag_log format ["Apoc's Airdrop Assistance - Player Account Too Low, Drop Aborted. %1. Bank:$%2. Cost: $%3", _player, _playerMoney, _DropPrice];  //A little log love to mark the Scallywag who tried to cheat the valiant pilot
	[_player, "toastRequest", ["ErrorTitleAndText", ["Air Drop Boom!", "Thought you'd be tricky and not pay, eh?"]]] call ExileServer_system_network_send_to;
    };  //Thought you'd be tricky and not pay, eh?

    //Server Side Money handling
    _newBalance = _playerMoney - _DropPrice;
    _player setVariable ["ExileBank", _newBalance];
    format["updateBank:%1:%2", _newBalance, (getPlayerUID _player)] call ExileServer_system_database_query_fireAndForget;
    [_player,"updateBankStats",[str(_newBalance)]] call ExileServer_system_network_send_to;
} else {
    // Let's handle the money after this tricky spot - This way players won't be charged for non-delivered goods!
    if (APOC_AA_UseExileLockerFunds) then {
        _playerMoney = _player getVariable ["ExileLocker",0];
    } else {
        _playerMoney = _player getVariable ["ExileMoney", 0];
    };
    if (_DropPrice > _playerMoney) exitWith
    {
        { _x setDamage 1; } forEach units _grp;
        _heli setDamage 1; //BOOM
        _object setDamage 1; //BOOM BOOM
        diag_log format ["Apoc's Airdrop Assistance - Player Account Too Low, Drop Aborted. %1. Bank:$%2. Cost: $%3", _player, _playerMoney, _DropPrice];  //A little log love to mark the Scallywag who tried to cheat the valiant pilot
	[_player, "toastRequest", ["ErrorTitleAndText", ["Air Drop Boom!", "Thought you'd be tricky and not pay, eh?"]]] call ExileServer_system_network_send_to;
    };  //Thought you'd be tricky and not pay, eh?

    //Server Side Money handling
    _newBalance = _playerMoney - _DropPrice;
    if (APOC_AA_UseExileLockerFunds) then {
        _player setVariable ["ExileLocker", _newBalance, true];
        format["updateLocker:%1:%2", _newBalance, (getPlayerUID _player)] call ExileServer_system_database_query_fireAndForget;
    } else {
        _player setVariable ["ExileMoney", _newBalance, true];
        format["setPlayerMoney:%1:%2", _newBalance, _player getVariable ["ExileDatabaseID", 0]] call ExileServer_system_database_query_fireAndForget;
    };
};
//  Now on to the fun stuff:						  
diag_log format ["Apoc's Airdrop Assistance - Object at %1, Detach Up Next", position _object];  //A little log love to confirm the location of this new creature
detach _object;  //WHEEEEEEEEEEEEE
_objectPosDrop = position _object;
_heli fire "CMFlareLauncher";
_heli fire "CMFlareLauncher";

//Delete heli once it has proceeded to end point
	[_heli,_grp,_flySpot,_dropSpot,_heliStartDistance] spawn {
		private ["_heli","_grp","_flySpot","_dropSpot","_heliStartDistance"];
		_heli = _this select 0;
		_grp = _this select 1;
		_flySpot = _this select 2;
		_dropSpot = _this select 3;
		_heliStartDistance = _this select 4;
		while{([_heli, _flySpot] call BIS_fnc_distance2D)>200}do{
			if(!alive _heli || !canMove _heli)exitWith{};
			sleep 5;
		};
		waitUntil{([_heli, _dropSpot] call BIS_fnc_distance2D)>(_heliStartDistance * .5)};
		{ deleteVehicle _x; } forEach units _grp;
		deleteVehicle _heli;
	};

//Time based deletion of the heli, in case it gets distracted
	[_heli,_grp] spawn {
		private ["_heli","_grp"];
		_heli = _this select 0;
		_grp = _this select 1;
		sleep 30;
		if (alive _heli) then
		{
			{ deleteVehicle _x; } forEach units _grp;
			deleteVehicle _heli;
			diag_log "AIRDROP SYSTEM - Deleted Heli after Drop";
		};
	};

WaitUntil {(((position _object) select 2) < (_flyHeight-20))};
		_heli fire "CMFlareLauncher";
		_objectPosDrop = position _object;
		_para = createVehicle ["B_Parachute_02_F", _objectPosDrop, [], 0, ""];
		_object attachTo [_para,[0,0,-1.5]];

		_smoke1= "SmokeShellGreen" createVehicle getPos _object;
		_smoke1 attachto [_object,[0,0,-0.5]];
		_flare1= "F_40mm_Green" createVehicle getPos _object;
		_flare1 attachto [_object,[0,0,-0.5]];



WaitUntil {((((position _object) select 2) < 1) || (isNil "_para"))};
		detach _object;
		_smoke2= "SmokeShellGreen" createVehicle getPos _object;
		//_smoke2 attachto [_object,[0,0,-0.5]];
		_flare2= "F_40mm_Green" createVehicle getPos _object;
		//_flare2 attachto [_object,[0,0,-0.5]];
		sleep 5;
		if (_type == "vehicle") then {_object allowDamage true;}; //Turn on damage for vehicles once they're on the ground.
		[_player, "toastRequest", ["SuccessTitleAndText", ["Air Drop", "Complete!"]]] call ExileServer_system_network_send_to;

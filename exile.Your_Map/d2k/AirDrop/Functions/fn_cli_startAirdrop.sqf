/*
 * Desa2k's Playhouse
 * https://discord.gg/3RCdgzDCzD
 * Author: Apoc
 * Reworked into Standalone by Desa2k
 */

scriptName "d2k_fnc_cli_startAirdrop";
private ["_type","_selection","_player"]; //Variables coming from command menu
_type 				= _this select 0;
_selectionNumber 	= _this select 1;
_player 			= _this select 2;

diag_log format ["Player %1, Drop Type %2, Selection # %3",_player,_type,_selectionNumber];
//hint format ["Well we've made it this far! %1, %2, %3,",_player,_type,_selectionNumber];
_selectionArray = [];
switch (_type) do {
	case "vehicle": {_selectionArray = APOC_AA_VehOptions};
	case "supply": 	{_selectionArray = APOC_AA_SupOptions};
	case "picnic":	{_selectionArray = APOC_AA_FoodOptions};
	default 	{_selectionArray = APOC_AA_VehOptions; diag_log "AAA - Default Array Selected - Something broke";};
};
_selectionName 	= (_selectionArray select _selectionNumber) select 0;
_price 			= (_selectionArray select _selectionNumber) select 2;

/////////////  Cooldown Timer ////////////////////////
if (!isNil "APOC_AA_lastUsedTime") then
{
diag_log format ["AAA - Last Used Time: %1; CoolDown Set At: %2; Current Time: %3",APOC_AA_lastUsedTime, APOC_AA_coolDownTime, diag_tickTime];
_timeRemainingReuse = APOC_AA_coolDownTime - (diag_tickTime - APOC_AA_lastUsedTime); //time is still in s
if ((_timeRemainingReuse) > 0) then 
	{
		["ErrorTitleAndText",["Air Drop Error", format["You need to wait %1 seconds before using this service again!", ceil _timeRemainingReuse]]] call ExileClient_gui_toaster_addTemplateToast;
		playSound "FD_CP_Not_Clear_F";
		breakOut "dk2_fnc_cli_startAirdrop";
	};
};
////////////////////////////////////////////////////////
diag_log format ["Player %1, Drop Type %2, Selection # %3, Cost is %4 PopTabs.",_player,_type,_selectionNumber,_price];
_playerMoney = 0;
if (APOC_AA_AdvancedBanking) then {
	_playerMoney = _player getVariable ["ExileBank", 0];
	if (_price > _playerMoney) exitWith
		{
			["ErrorTitleAndText",["Air Drop Error", format["You don't have enough money in your bank to request this airdrop!"]]] call ExileClient_gui_toaster_addTemplateToast;
			playSound "FD_CP_Not_Clear_F";
		};
} else {
	if (APOC_AA_UseExileLockerFunds) then {
		_playerMoney = _player getVariable ["ExileLocker", 0];
		if (_price > _playerMoney) exitWith
			{
				["ErrorTitleAndText",["Air Drop Error", format["You don't have enough money in your locker to request this airdrop!"]]] call ExileClient_gui_toaster_addTemplateToast;
				playSound "FD_CP_Not_Clear_F";
			};
	} else {
		_playerMoney = _player getVariable ["ExileMoney", 0];
		if (_price > _playerMoney) exitWith
			{
				["ErrorTitleAndText",["Air Drop Error", format["You don't have enough money in your wallet to request this airdrop!"]]] call ExileClient_gui_toaster_addTemplateToast;
				playSound "FD_CP_Not_Clear_F";
			};
	};
};


		
_confirmMsg = format ["This airdrop will deduct $%1 from your bank account upon delivery<br/>",_price];
_confirmMsg = _confirmMsg + format ["<br/><t font='EtelkaMonospaceProBold'>1</t> x %1",_selectionName];
		
	// Display confirm message
	if ([parseText _confirmMsg, "Confirm", "DROP!", true] call BIS_fnc_guiMessage) then
	{
	[_type,_selectionNumber,_player] remoteExec ["d2k_fnc_srv_startAirdrop",2];
	APOC_AA_lastUsedTime = diag_tickTime;
	diag_log format ["AAA - Just Used Time: %1; CoolDown Set At: %2; Current Time: %3",APOC_AA_lastUsedTime, APOC_AA_coolDownTime, diag_tickTime];
	["SuccessTitleAndText", ["Air Drop", format ["%1 drop is in route!", _selectionName]]] call ExileClient_gui_toaster_addTemplateToast;
	};
	

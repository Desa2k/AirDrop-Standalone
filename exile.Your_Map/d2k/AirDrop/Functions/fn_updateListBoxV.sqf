/*
 * Desa2k's Playhouse
 * https://discord.gg/3RCdgzDCzD
 * Author: Apoc
 * Reworked into Standalone by Desa2k
 */

scriptName "d2k_fnc_updateListBoxV";
private _display = uiNamespace getVariable ["d2kAirDrop", displayNull];
private _listbox = _display displayCtrl 1337;
lbClear _listbox;
//private _cfgVehicles = configFile >> "CfgVehicles";
//private _cfgExileArsenal = missionConfigFile >> "CfgExileArsenal";

{
	_x params ["_dName", "_className", "_price", "_type"];
	private _index = _listbox lbAdd _dName;
	private _strPrice = str _price;
	_listbox lbSetTextRight [_forEachIndex, _strPrice];
	_listbox lbSetData [_index, _type];
	//diag_log format ["Test %1", _x];

} forEach APOC_AA_VehOptions;


true

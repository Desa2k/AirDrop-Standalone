/*
 * Desa2k's Playhouse
 * https://discord.gg/3RCdgzDCzD
 * Author: Apoc
 * Reworked into Standalone by Desa2k
 */

scriptName "d2k_fnc_startAirdrop";
disableSerialization;
private _display = uiNamespace getVariable ["d2kAirdrop", displayNull];
private _ctrl = _display displayCtrl 1337;

try
{
	_curSelection = lbCurSel _ctrl;
	if (_curSelection == -1) throw "Select a Air Drop first!";
	_type = _ctrl lbData _curSelection;
	diag_log format ["Test %1, %2", _type, _curSelection];
	[_type,_curSelection,player] spawn d2k_fnc_cli_startAirdrop;


}
catch
{
	["ErrorTitleAndText", ["Air Drop", _exception]] call ExileClient_gui_toaster_addTemplateToast;
};

private _display = uiNamespace getVariable ["d2kAirDrop", displayNull];
_display closeDisplay 0;

true

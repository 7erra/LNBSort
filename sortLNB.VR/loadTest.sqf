_mode = _this#0;
_this = _this#1;

switch (_mode) do
{
case "onLoad":
{
	_this params ["_display"];
	_lnbEntries = _display displayCtrl 1500;
	_cfgs = "true" configClasses (configFile >> "CfgVehicles");
	_names = _cfgs apply {[_x] call BIS_fnc_displayname};
	_cfgNames = _cfgs apply {configName _x};
	for "_i" from 0 to 30 do {
		_rInd = floor random (count _cfgs);
		_ind = _lnbEntries lnbAddRow [_cfgNames#_rInd, _names#_rInd, str _rInd];
		_lnbEntries lnbSetValue [[_ind,2],_rInd];
	};

	for "_idc" from 2400 to 2402 do {
		_btn = _display displayCtrl _idc;
		_btn setVariable ["reverseSort",false];
		_btn ctrlAddEventHandler ["ButtonClick",{
			["sortCol",[ctrlParent (_this#0)] +_this] execVM "loadTest.sqf";
		}];
	};
};
case "sortCol":{
	params ["_display","_ctrl"];
	_lnbEntries = _display displayCtrl 1500;
	_column = [2400,2401,2402] find ctrlIDC _ctrl;
	_reverse = _ctrl getVariable "reverseSort";
	if (_column == 2) then {
		_lnbEntries lnbSortByValue [_column,_reverse];
	} else {
		_lnbEntries lnbSort [_column,_reverse];
	};
	_ctrl setVariable ["reverseSort",!_reverse];
};
};
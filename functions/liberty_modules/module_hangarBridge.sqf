params ["_parent", "_anchorOffset"];
private _moduleVarName = "JC_Mod_HangarBridge";

// 1. SELF-CLEANING MECHANISM
private _oldObjects = _parent getVariable [format ["%1_All", _moduleVarName], []];
{ deleteVehicle _x } forEach _oldObjects;

private _allObjects = [];
private _roomLights = [];
private _interactData = createHashMap;

// 2. COMPOSITION MATRIX (Rotated 180 Degrees Horizontally)
private _composition = [
    // [Classname, Inverted Offset [X,Y,Z], Reversed Vectors [[Dir], [Up]], Tag, Key]
    ["Land_CampingTable_F", [0, -1.5, 0.31], [[0,-1,0],[0,0,1]], "SCENERY", ""],
    ["Land_Laptop_unfolded_F", [0, -1.5, 0.95], [[0,1,0],[0,0,1]], "INTERACTIVE", "commandTerminal"],
    ["Land_PortableLight_double_F", [6.25, -0.5, 0.75], [[1,0,0],[0,0,1]], "LIGHT", ""]
//    ["Land_PortableHelipadLight_01_F", [0, 0, 0], [[0,-1,0],[0,0,1]], "LIGHT", ""]
];

// 3. DEPLOYMENT LOOP
{
    _x params ["_class", "_offset", "_vectors", "_tag", "_key"];
    private _prop = createVehicle [_class, [0,0,0], [], 0, "NONE"];
    
    private _finalOffset = [
        (_anchorOffset select 0) + (_offset select 0),
        (_anchorOffset select 1) + (_offset select 1),
        (_anchorOffset select 2) + (_offset select 2)
    ];
    
    _prop attachTo [_parent, _finalOffset];
    _prop setVectorDirAndUp _vectors;
    _prop allowDamage false;
    
    _allObjects pushBack _prop;
    
    switch (_tag) do {
        case "LIGHT":       { _roomLights pushBack _prop; };
        case "INTERACTIVE": { 
			_interactData set [_key, _prop]; 
			[_prop] call JC_fnc_setupTeleportTerminal;
		};
//		case "TELEPORTER":  { [_prop] call JC_fnc_setupTeleportTerminal; };
    };
} forEach _composition;

// 4. GLOBAL TRACKING REGISTRATION
_parent setVariable [format ["%1_All", _moduleVarName], _allObjects, true];
_parent setVariable [format ["%1_Lights", _moduleVarName], _roomLights, true];
_parent setVariable [format ["%1_Anchor", _moduleVarName], _anchorOffset, true];
params ["_parent", "_anchorOffset"];
private _moduleVarName = "JC_Mod_EngineRoom";

// 1. SELF-CLEANING MECHANISM
private _oldObjects = _parent getVariable [format ["%1_All", _moduleVarName], []];
{ deleteVehicle _x } forEach _oldObjects;

private _allObjects = [];
private _roomLights = [];
private _interactData = createHashMap;

// 2. COMPOSITION MATRIX
private _composition = [
//	forward walls, floor and roof
	//	 forward walls
    ["Land_Mil_WallBig_4m_F", [1.83, 5.83, 1.25], [[0, 1, 0], [0, 0, 1]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [-1.83, 5.83, 1.25], [[0, 1, 0], [0, 0, 1]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [5.83, 5.83, 1.25], [[0, 1, 0], [0, 0, 1]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [-5.83, 5.83, 1.25], [[0, 1, 0], [0, 0, 1]], "SCENERY", ""],
	//	side walls
	["Land_Mil_WallBig_4m_F", [7.83, 3.83, 1.25], [[1, 0, 0], [0, 0, 1]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [-7.83, 3.83, 1.25], [[-1, 0, 0], [0, 0, 1]], "SCENERY", ""],
	//	front floors
	["Land_Mil_WallBig_4m_F", [1.83, 3.83, -1.16], [[0, 0, -1], [0, 1, 0]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [-1.83, 3.83, -1.16], [[0, 0, -1], [0, 1, 0]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [5.83, 3.83, -1.16], [[0, 0, -1], [0, 1, 0]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [-5.83, 3.83, -1.16], [[0, 0, -1], [0, 1, 0]], "SCENERY", ""],
	// front roofs
	["Land_Mil_WallBig_4m_F", [1.83, 4.16, 3.83], [[0, 0, 1], [0, 1, 0]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [-1.83, 4.16, 3.83], [[0, 0, 1], [0, 1, 0]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [5.83, 4.16, 3.83], [[0, 0, 1], [0, 1, 0]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [-5.83, 4.16, 3.83], [[0, 0, 1], [0, 1, 0]], "SCENERY", ""],
//	center walls, floor and roof
	//	middle walls just to shield players entering the room
	["Land_Mil_WallBig_4m_F", [1.83, 0.75, 1.25], [[0, 1, 0], [0, 0, 1]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [-1.83, 0.75, 1.25], [[0, 1, 0], [0, 0, 1]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [5.83, 0.75, 1.25], [[0, 1, 0], [0, 0, 1]], "SCENERY", ""],
	//	side walls
	["Land_Mil_WallBig_4m_F", [7.83, 0, 1.25], [[1, 0, 0], [0, 0, 1]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [-7.83, 0, 1.25], [[-1, 0, 0], [0, 0, 1]], "SCENERY", ""],
	//	floors
	["Land_Mil_WallBig_4m_F", [1.83, 0, -1.16], [[0, 0, -1], [0, 1, 0]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [-1.83, 0, -1.16], [[0, 0, -1], [0, 1, 0]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [5.83, 0, -1.16], [[0, 0, -1], [0, 1, 0]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [-5.83, 0, -1.16], [[0, 0, -1], [0, 1, 0]], "SCENERY", ""],
	// roofs
	["Land_Mil_WallBig_4m_F", [1.83, 0, 3.83], [[0, 0, 1], [0, 1, 0]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [-1.83, 0, 3.83], [[0, 0, 1], [0, 1, 0]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [5.83, 0, 3.83], [[0, 0, 1], [0, 1, 0]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [-5.83, 0, 3.83], [[0, 0, 1], [0, 1, 0]], "SCENERY", ""],
//	stuff
	//	the machines, engines
	["Land_Device_assembled_F", [0.75, 2.25, 0], [[1,0,0],[0,0,1]], "INTERACTIVE", ""],
	["Land_Device_assembled_F", [0.75, -2.42, 0], [[-1,0,0],[0,0,1]], "INTERACTIVE", ""],
	//	laptop, notebook, teleporter
	["Land_Laptop_unfolded_F", [0.75, 2.31, 0.57], [[0,1,0],[0,0,1]], "TELEPORTER"],
	// corner woking lamps for reference, all are facing the center of the roof
		//	front left
	["Land_PortableLight_single_F", [-7, 5.16, 0.1], [[-0.707,0.707,0],[0,0,1]], "LIGHT", ""],
		// front right
	["Land_PortableLight_single_F", [7, 5.16, 0.1], [[0.707,0.707,0],[0,0,1]], "LIGHT", ""],
		//	rear left
	["Land_PortableLight_single_F", [-7, -5.16, 0.1], [[-0.707,-0.707,0],[0,0,1]], "LIGHT", ""],
		// rear right
	["Land_PortableLight_single_F", [7, -5.16, 0.1], [[0.707,-0.707,0],[0,0,1]], "LIGHT", ""],
//	backwards walls, floor and roof
	//	fence gate for physicall access
	["Land_BackAlley_01_l_gate_F", [-1.95, -5.66, 0.75], [[0, -1, 0], [0, 0, 1]], "SCENERY", ""],
	//	backward walls
	["Land_Mil_WallBig_4m_F", [-5.7, -5.83, 1.25], [[0, -1, 0], [0, 0, 1]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [1.83, -5.83, 1.25], [[0, -1, 0], [0, 0, 1]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [5.83, -5.83, 1.25], [[0, -1, 0], [0, 0, 1]], "SCENERY", ""],
	//	side walls
	["Land_Mil_WallBig_4m_F", [7.83, -3.83, 1.25], [[1, 0, 0], [0, 0, 1]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [-7.83, -3.83, 1.25], [[-1, 0, 0], [0, 0, 1]], "SCENERY", ""],
	//	rear floors
	["Land_Mil_WallBig_4m_F", [1.83, -3.83, -1.16], [[0, 0, -1], [0, -1, 0]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [-1.83, -3.83, -1.16], [[0, 0, -1], [0, -1, 0]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [5.83, -3.83, -1.16], [[0, 0, -1], [0, -1, 0]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [-5.83, -3.83, -1.16], [[0, 0, -1], [0, -1, 0]], "SCENERY", ""],
	// rear roofs
	["Land_Mil_WallBig_4m_F", [1.83, -4.16, 3.83], [[0, 0, 1], [0, 1, 0]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [-1.83, -4.16, 3.83], [[0, 0, 1], [0, 1, 0]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [5.83, -4.16, 3.83], [[0, 0, 1], [0, 1, 0]], "SCENERY", ""],
	["Land_Mil_WallBig_4m_F", [-5.83, -4.16, 3.83], [[0, 0, 1], [0, 1, 0]], "SCENERY", ""]
//	,["Land_PortableHelipadLight_01_F", [0, 0, 0], [[0,0,0],[0,0,1]], "LIGHT", ""]
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
//			[_prop] call JC_fnc_setupTeleportTerminal;
		};
		case "TELEPORTER":  { [_prop] call JC_fnc_setupTeleportTerminal; };
    };
} forEach _composition;

_parent setVariable [format ["%1_All", _moduleVarName], _allObjects, true];
_parent setVariable [format ["%1_Lights", _moduleVarName], _roomLights, true];
_parent setVariable [format ["%1_Anchor", _moduleVarName], _anchorOffset, true];




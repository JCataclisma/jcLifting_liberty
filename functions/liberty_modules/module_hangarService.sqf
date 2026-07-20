params ["_parent", "_anchorOffset"];
private _moduleVarName = "JC_Mod_HangarService";

// 1. SELF-CLEANING MECHANISM
private _oldObjects = _parent getVariable [format ["%1_All", _moduleVarName], []];
{ deleteVehicle _x } forEach _oldObjects;

private _allObjects = [];
private _roomLights = [];
private _interactData = createHashMap;
private _laptopObj = objNull;

// 2. COMPOSITION MATRIX
private _composition = [
    ["Land_CampingTable_F", [1, 3.25, -0.75], [[0,0,0],[0,0,1]], "SCENERY", ""],
    ["Land_Laptop_unfolded_F", [1, 3.25, -0.16], [[0,-1,0],[0,0,1]], "TELEPORTER", ""]
//    ["Land_PortableLight_double_F", [8.95, -3.75, 0.75], [[1,0,0],[0,0,1]], "LIGHT", ""]
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
		case "TELEPORTER":  {
			[_prop] call JC_fnc_setupTeleportTerminal;
			_laptopObj = _prop;
		};
        case "INTERACTIVE": { _interactData set [_key, _prop]; };
    };
} forEach _composition;

/*
// =========================================================================
// MULTIPLAYER COMPATIBLE INTERACTIVE MESSAGE DISPLAY (Priority 16)
// =========================================================================
if (!isNull _laptopObj) then {
    [_laptopObj, [
        "<t color='#00FF66'>Tow in Vehicle for Service</t>",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];
			hintSilent parseText "<t color='#00FF00' size='1.2' shadow='1'>Service Hangar</t><br/>Tow in vehicles by clicking the green lights on the floor.";
			systemChat "[HANGAR]: Click on the green lights on the floor to pull vehicles.";
			sleep 10; hint "";
		}, nil, 6, true, true, "", "true", 2.25
	]] remoteExec ["addAction", 0, _laptopObj];
};


// =========================================================================
// NEW: INDEPENDENT PURPLE FLATBED TRUCK CONSTRUCTOR MENU (Priority 16)
// =========================================================================
if (!isNull _laptopObj) then {
    [_laptopObj, [
        "<t color='#A333FF'>Summon Flatbed Truck</t>",
        {
            params ["_targetPump", "_caller"];
            
            if (!isServer) exitWith {};

            // --- USER CONFIGURABLE ORIENTATION & PLACEMENT ---
            private _spawnDir = (getDir liberty);	// + 180;
            private _attachOffset = [-5, 7, 1.75]; // Edit this offset to adjust spawn position relative to the LAPTOP/PUMP
            private _spawnPos = [0, 0, 0];         // Initialized at world origin for safe un-decked spawning
            // -------------------------------------------------

            // 1. INSTANTIATE SAFELY AT WORLD ORIGIN
            private _flatbed = createVehicle ["B_T_Truck_01_flatbed_F", _spawnPos, [], 0, "NONE"];
            _flatbed allowDamage false;
            sleep 0.25;

            // 2. SNAP DIRECTLY TO THE LAPTOP/PUMP'S CURRENT DECK HEIGHT
            _flatbed attachTo [_targetPump, _attachOffset];

            // 3. ENGINE DESYNC BUFFER (Let the engine map the deck collision)
            sleep 0.25;

            // 4. CUT THE TIE AND FORCE WORLD ORIENTATION
            detach _flatbed;
            _flatbed setDir _spawnDir;
            _flatbed allowDamage true;

            // 5. TARGET INJECTIONS (Executes directly upon the spawned flatbed)
            _flatbed setVariable ["JC_Lifting_FOB_Materials", true, true]; 
            [_flatbed, true] remoteExec ["JC_Lifting_fnc_Action_Update_Material_Visuals", 2];

            // 6. NOTIFICATIONS & AUDIO FEEDBACK
            [_targetPump, "", "vehicleChat", "Engineering Node: Flatbed Truck fabricated and deployed."] remoteExec ["JC_Lifting_fnc_Messages", 0];
            ["Hooked", _targetPump] remoteExec ["JC_Lifting_fnc_Transmission_Sons", 0];
        },
        nil, 16, true, true, "", "true", 5
    ]] remoteExec ["addAction", 0, _laptopObj];
};			*/



_parent setVariable [format ["%1_All", _moduleVarName], _allObjects, true];
_parent setVariable [format ["%1_Lights", _moduleVarName], _roomLights, true];
_parent setVariable [format ["%1_Anchor", _moduleVarName], _anchorOffset, true];













/*

// =========================================================================
// NEW: INDEPENDENT PURPLE TOWING DOZER CONSTRUCTOR MENU (Priority 16)
// =========================================================================
if (!isNull _laptopObj) then {
    [_laptopObj, [
        "<t color='#A333FF'>Summon Towing Dozer</t>",
        {
            params ["_targetPump", "_caller"];
            
            if (!isServer) exitWith {};

			// --- USER CONFIGURABLE ORIENTATION & PLACEMENT ---
			private _spawnDir = (getDir liberty) + 180;
			private _attachOffset = [-5, 21, 1.1]; // Edit this offset to adjust spawn position relative to the PUMP
			private _spawnPos = [0, 0, 0];     // Initialized at world origin for safe un-decked spawning
			// -------------------------------------------------

			// 1. INSTANTIATE SAFELY AT WORLD ORIGIN
			private _dozerTractor = createVehicle ["JC_Lifting_Dozer_Nyx", _spawnPos, [], 0, "NONE"];
sleep 1;
			_dozerTractor allowDamage false;
sleep 1;
			// 2. SNAP DIRECTLY TO THE PUMP'S CURRENT DECK HEIGHT
			_dozerTractor attachTo [_targetPump, _attachOffset];

			// 3. ENGINE DESYNC BUFFER (Let the engine map the deck collision)
			sleep 0.25;

			// 4. CUT THE TIE AND FORCE WORLD ORIENTATION
			detach _dozerTractor;
			_dozerTractor setDir _spawnDir;

			// 5. VARIABLE ASSIGNMENT RESTORATION
			// Updates the position variable with the actual deck coordinates for the rest of the script
			_spawnPos = getPosATL _dozerTractor;
            // ---------------------------------------------------------

            // 1. INSTANTIATE STANDALONE COMBAT TRACTOR ASSET
            private _dozerTractor = createVehicle ["JC_Lifting_Dozer_Nyx", _spawnPos, [], 0, "CAN_COLLIDE"];
            _dozerTractor setDir _spawnDir;
            _dozerTractor setVariable ["JC_Lifting_IsCombatTractor", true, true];

            // --- NATIVE FUEL & GOVERNOR SETTINGS ---
            _dozerTractor setFuelConsumptionCoef 12;
            private _originalMass = getMass _dozerTractor; 
            _dozerTractor setMass (_originalMass * 1.83);

            // 2. APPLY CUSTOM TEXTURES & ARMAMENT MODIFICATIONS
            _dozerTractor setObjectTextureGlobal [0, "a3\soft_f_exp\lsv_01\data\nato_lsv_01_black_co.paa"];
            _dozerTractor setObjectTextureGlobal [1, "a3\soft_f_exp\lsv_01\data\nato_lsv_02_black_co.paa"];

            _dozerTractor removeWeaponTurret ["carHorn", [-1]];
            _dozerTractor addWeaponTurret ["M134_minigun", [-1]];
            _dozerTractor addMagazineTurret ["5000Rnd_762x51_Belt", [-1]];
            _dozerTractor setVariable ["JC_Lifting_IsTerrainCapable", true, true];

            // 3. ASSEMBLE ORNAMENTATION & WRECK COMPONENTS
            private _dozerWreck = createVehicle ["Land_Bulldozer_01_abandoned_F", [0, 0, 100], [], 0, "CAN_COLLIDE"];
            _dozerWreck attachTo [_dozerTractor, [-0.25, 0.66, -0.31]];
            [_dozerWreck, [180, 0, 0]] call BIS_fnc_setObjectRotation;
            _dozerWreck allowDamage false;

            private _dozerTowbar = createVehicle ["Land_TowBar_01_F", [0, 0, 100], [], 0, "CAN_COLLIDE"];	
            _dozerTowbar attachTo [_dozerTractor, [-0.25, -3.1, 0.42]];
            [_dozerTowbar, [180, 30, 0]] call BIS_fnc_setObjectRotation;
            _dozerTowbar allowDamage false;

            // 4. CASCADING GARBAGE CLEANUP LAYER
            _dozerTractor addEventHandler ["Killed", {
                params ["_unit"];
                { deleteVehicle _x; } forEach (attachedObjects _unit);
            }];

            // 5. INJECT USER ACTIONS DIRECTLY ONTO THE SPAWNED ASSET
            [
                _dozerTractor,
                [
                    "<t color='#00FFFF'>Swap Scuba Gear</t>",
                    {
                        params ["_target", "_caller"];
                        [_target, _caller] remoteExec ["JC_Lifting_fnc_Action_Tractor_ScubaSwap", 2];
                    },
                    nil, 1.5, true, true, "", "_this == vehicle _this && { _this distance2D _target < 6 }", 6, false
                ]
            ] remoteExec ["addAction", 0, true];

            [
                _dozerTractor,
                [
                    "<t color='#2076ff'>ENGAGE Bridge</t>",
                    {
                        params ["_targetDozer"];
                        [_targetDozer] remoteExec ["JC_Lifting_fnc_Feature_Bridge_Maker_Dozer", 2];
                    },
                    nil, 1.4, false, true, "", "player == driver _target && {isNull (_target getVariable ['JC_Lifting_CurrentBridge', objNull])}", 5
                ]
            ] remoteExec ["addAction", 0, true];

sleep 2; _dozerTractor allowDamage false;
            // 6. NOTIFICATIONS & AUDIO FEEDBACK
            [_targetPump, "", "vehicleChat", "Engineering Node: Towing Dozer fabricated and deployed."] remoteExec ["JC_Lifting_fnc_Messages", 0];
            ["Hooked", _targetPump] remoteExec ["JC_Lifting_fnc_Transmission_Sons", 0];

            // 7. DYNAMIC GHOST MARKER BOUNDARY SYSTEM (BULLDOZER EQUALIZER)
            [
                _dozerTractor,
                {
                    params ["_veh"];
                    private _arrows = [];
                    private _drawEH = -1;
                    while {alive _veh} do {
                        private _isDriver = (player == driver _veh);
                        private _hasArrows = (count _arrows > 0);
                        
                        if (_isDriver && !_hasArrows) then {
                            private _settings = [_veh, "GET_SETTINGS"] call JC_Lifting_fnc_Feature_Dozer_Equalizer;
                            _settings params ["_digDepth", "_digSizeX", "_digSizeY", "_gridStep", "_digOffset"];
                            
                            private _edgeX = _digSizeX + _gridStep;
                            private _edgeY = _digSizeY + _gridStep;
                            
                            private _corners = [
                                [_edgeY, _digOffset + (_edgeX * 0.95), -0.75],
                                [_edgeY, _digOffset - (_edgeX * 1.15), -0.75],
                                [-_edgeY, _digOffset + (_edgeX * 0.95), -0.75],
                                [-_edgeY, _digOffset - (_edgeX * 1.15), -0.75]
                            ];
                            
                            {
                                private _arrow = "Sign_Arrow_Yellow_F" createVehicleLocal [0,0,0];
                                _arrow attachTo [_veh, _x];
                                _arrows pushBack _arrow;
                            } forEach _corners;
                            
                            _veh setVariable ["JC_Lifting_TrenchCorners", _corners];
                            
                            _drawEH = addMissionEventHandler ["Draw3D", {
                                private _v = vehicle player;
                                private _c = _v getVariable ["JC_Lifting_TrenchCorners", []];
                                
                                if (count _c == 4) then {
                                    {
                                        private _zOffset = _x;
                                        private _c0 = _c select 0;
                                        private _c1 = _c select 1;
                                        private _c2 = _c select 2;
                                        private _c3 = _c select 3;
                                        
                                        private _p0 = _v modelToWorldVisual [_c0 select 0, _c0 select 1, (_c0 select 2) + _zOffset];
                                        private _p1 = _v modelToWorldVisual [_c1 select 0, _c1 select 1, (_c1 select 2) + _zOffset];
                                        private _p2 = _v modelToWorldVisual [_c2 select 0, _c2 select 1, (_c2 select 2) + _zOffset];
                                        private _p3 = _v modelToWorldVisual [_c3 select 0, _c3 select 1, (_c3 select 2) + _zOffset];
                                        
                                        drawLine3D [_p0, _p1, [1, 0, 0, 1], 5];
                                        drawLine3D [_p1, _p3, [1, 0, 0, 1], 5];
                                        drawLine3D [_p3, _p2, [1, 0, 0, 1], 5];
                                        drawLine3D [_p2, _p0, [1, 0, 0, 1], 5];
                                        
                                    } forEach [0, 1, -0.5];
                                };
                            }];
                        };
                        
                        if (!_isDriver && _hasArrows) then {
                            { deleteVehicle _x; } forEach _arrows;
                            _arrows = [];
                            if (_drawEH != -1) then {
                                removeMissionEventHandler ["Draw3D", _drawEH];
                                _drawEH = -1;
                            };
                        };
                        sleep 0.5;
                    };
                    { deleteVehicle _x; } forEach _arrows;
                    if (_drawEH != -1) then {
                        removeMissionEventHandler ["Draw3D", _drawEH];
                    };
                }
            ] remoteExec ["spawn", 0, true];

sleep 2; _dozerTractor allowDamage true;
			
        },
        nil, 16, true, true, "", "true", 5
    ]] remoteExec ["addAction", 0, _laptopObj];
};
/*
	Author JCataclisma

	Automatic modules spawner for USS liberty .
	Can be called by either one of these methods:
	
	[]execVm "liberty_lite.sqf"
	
	OR
	
			[_m, [
				"<t color='#BF00FF'>Engage liberty Permanent Modules</t>", 
				{
					params ["_target", "_caller", "_actionId", "_arguments"];
					[_target] execVM "liberty.sqf"; // Passed the helipad object as a parameter
				}, 
				nil, 16, false, true, "", "alive _target", 5
			]] remoteExec ["addAction", 0, _m];

*/


params ["_helipad"];

private _anchor = missionNamespace getVariable ["libertyFake", objNull];

if (isNull _anchor) exitWith { 
    systemChat "Logistics Error: Liberty Fake Anchor not found.";
};

liberty = _anchor;





		
		private _doubleRedTacticalLampFront = createVehicle ["Land_PortableLight_double_F", [0,0,0], [], 0, "NONE"];
		private _doubleRedTacticalLampRear = createVehicle ["Land_PortableLight_double_F", [0,0,0], [], 0, "NONE"];
		_doubleRedTacticalLampRear attachTo [liberty, [8.75, -12.75, 2.5]];
        _doubleRedTacticalLampRear setDir 45;
		_doubleRedTacticalLampRear switchLight "ON";
		_doubleRedTacticalLampFront attachTo [liberty, [8.75, 0.5, 2.5]];
        _doubleRedTacticalLampFront setDir 150;
		_doubleRedTacticalLampFront switchLight "ON";



		private _medKit = createVehicle ["Land_FirstAidKit_01_closed_F", [0,0,0], [], 0, "NONE"];
		private _medKitFront = createVehicle ["Land_FirstAidKit_01_closed_F", [0,0,0], [], 0, "NONE"];
		private _medKitEntry = createVehicle ["Land_FirstAidKit_01_closed_F", [0,0,0], [], 0, "NONE"];
		_medKit attachTo [liberty,[-10.31, 6.6, 2.83]];
		_medKit setDir 270;
		_medKit allowDamage false;
		_medKitFront attachTo [liberty,[-10.31, 40.31, 2.83]];
		_medKitFront setDir 270;
		_medKitFront allowDamage false;
		_medKitEntry attachTo [liberty,[10.31, -32.65, 2.83]];
		_medKitEntry setDir 90;
		_medKitEntry allowDamage false;

		private _dockPierHelipadLight = createVehicle ["PortableHelipadLight_01_yellow_F", [0,0,0], [], 0, "NONE"];
		_dockPierHelipadLight attachTo [liberty,[0, -90.75, 8.83]];
		[_dockPierHelipadLight, [0,0,0]] call BIS_fnc_setObjectRotation;
		_dockPierHelipadLight allowDamage false;
		private _outerSwitchLower = createVehicle ["PortableHelipadLight_01_green_F", [0,0,0], [], 0, "NONE"];
		_outerSwitchLower attachTo [liberty,[0, -25, 1.6]];
		_outerSwitchLower allowDamage false;
sleep 0.1;
		private _entryDockFloor = createVehicle ["Land_MedicalTent_01_floor_light_F", [0,0,0], [], 0, "NONE"];
		_entryDockFloor attachTo [_outerSwitchLower,[0, 2, 0.16]];
		_entryDockFloor allowDamage false;
		private _innerSwitchLower = createVehicle ["PortableHelipadLight_01_green_F", [0,0,0], [], 0, "NONE"];
		_innerSwitchLower attachTo [liberty,[0, 6.6, 1.6]];
		_innerSwitchLower allowDamage false;
		private _entryLowerMediTaruPod = createVehicle ["Land_Pod_Heli_Transport_04_medevac_F", [0,0,0], [], 0, "NONE"];
		_entryLowerMediTaruPod attachTo [liberty,[-8.25, -47.5, 10.16]];
		_entryLowerMediTaruPod allowDamage false;
		[_entryLowerMediTaruPod, [180,0,0]] call BIS_fnc_setObjectRotation;
			_entryLowerMediTaruPod setObjectTextureGlobal [0, "a3\air_f_heli\heli_transport_04\data\heli_transport_04_pod_ext01_black_co.paa"]; 
			_entryLowerMediTaruPod setObjectTextureGlobal [1, "a3\air_f_heli\heli_transport_04\data\heli_transport_04_pod_ext02_black_co.paa"];
			_entryLowerMediTaruPod animateSource ["Door_4_source", 1];
			_entryLowerMediTaruPod setVariable ["Is_liberty_Medpod", true, true];




// --- DOCKBARGE SPAWN --- FRONT HANGAR
        private _dockAnchorFront = [0, -75.05, 8.7];
//        liberty setVariable ["JC_Barge_dockAnchorFront", _dockAnchorFront, true];
        private _dockCompArrayFront = [
            ["PortableHelipadLight_01_yellow_F", [0, 0, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_red_F", [0, 8, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_red_F", [-8, 0, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_red_F", [8, 0, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_red_F", [0, -8, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_red_F", [0, 5, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_red_F", [-5, 0, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_red_F", [5, 0, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_red_F", [0, -5, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_blue_F", [0, 2.5, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_blue_F", [-2.5, 0, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_blue_F", [2.5, 0, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_blue_F", [0, -2.5, 0.16], [0, 0, 0]],
            ["Land_MedicalTent_01_floor_light_F", [0, 0, 0.07], [0, 0, 0]],
            ["PortableHelipadLight_01_green_F", [0, 3.5, 0.11], [0, 0, 0]],
			["PortableHelipadLight_01_green_F", [0, 33.75, 0.11], [0, 0, 0]]
        ];
        
        private _spawnedDockFront = [];
        {
            _x params ["_class", "_offset", "_rot"];
            private _item = createVehicle [_class, [0,0,0], [], 0, "NONE"];
            _item attachTo [liberty, [(_dockAnchorFront select 0) + (_offset select 0), (_dockAnchorFront select 1) + (_offset select 1), (_dockAnchorFront select 2) + (_offset select 2)]];
            _item setDir (_rot select 0);
            [_item, _rot select 1, _rot select 2] call BIS_fnc_setPitchBank;
            _spawnedDockFront pushBack _item;
        } forEach _dockCompArrayFront;
        
        private _centerLightFront = _spawnedDockFront select 0;
        private _tentFloorFront = _spawnedDockFront select 13;
        private _outerSwitch = _spawnedDockFront select 14;
		private _innerSwitch = _spawnedDockFront select 15;

private _trgInnerSwitchHangar = createTrigger ["EmptyDetector", [0,0,0], false];
_trgInnerSwitchHangar attachTo [_innerSwitch, [0,0,0]];
_trgInnerSwitchHangar setTriggerArea [6.75, 6.75, 0, true, 3];
_trgInnerSwitchHangar setTriggerActivation ["WEST", "PRESENT", true];
_trgInnerSwitchHangar setTriggerStatements ["this", "{_x setDamage 0; _x setFuel 1; _x setVehicleAmmo 1} forEach thisList;", ""];
        

_innerSwitch switchLight OFF; _outerSwitch switchLight OFF;

	// --- DOCKING TRACTOR BEAM FOR UPPER HANGAR DOOR ---
// =========================================================================
// 1. REGISTER THE CORE TRACTOR BEAM LOOP (Locality-Assured & Just Release)
// =========================================================================
JC_fnc_localHangarTractor = {
    _this spawn {
        params ["_veh", "_destPosASL"];
        
        if (_veh getVariable ["JC_HangarTractor_Lock", false]) exitWith {};
        _veh setVariable ["JC_HangarTractor_Lock", true, true];
        
        _veh enableSimulationGlobal true;

        private _startPos = getPosASL _veh;
        _startPos set [2, (_startPos select 2) + 0.25]; // Lift start 0.25m
        
        private _endPos = +_destPosASL;
        _endPos set [2, (_endPos select 2) + 0.25]; // Lift end 0.25m
        
        private _vDir = vectorDir _veh;
        private _vUp = vectorUp _veh;
        private _t1 = diag_tickTime;
        private _t2 = diag_tickTime + 9; 

        private _instName = format ["JC_tractor_%1", netId _veh];
        missionNamespace setVariable [_instName, [_veh, _startPos, _endPos, _vDir, _vUp, _t1, _t2], true];

        addMissionEventHandler ["EachFrame", format [
            "
                private _args = missionNamespace getVariable ['%1', []];
                if (_args isEqualTo []) exitWith { removeMissionEventHandler ['EachFrame', _thisEventHandler]; };
                _args params ['_veh', '_startPos', '_endPos', '_vDir', '_vUp', '_t1', '_t2'];
                
                private _interval = 0 max ((linearConversion [_t1, _t2, diag_tickTime, 0, 1, true]) * (1 - diag_deltaTime)) min 1;
                
                _veh setVelocityTransformation [
                    _startPos, _endPos,
                    [0,0,0], [0,0,0],
                    _vDir, _vDir,
                    _vUp, _vUp,
                    _interval
                ];
                
                if (_interval >= 0.99 || !alive _veh) then {
                    _veh setVelocity [0,0,0];
                    _veh setVariable ['JC_HangarTractor_Lock', false, true];
                    missionNamespace setVariable ['%1', nil, true];
                    removeMissionEventHandler ['EachFrame', _thisEventHandler];
                };
            ", 
            _instName
        ]];
    };
};
publicVariable "JC_fnc_localHangarTractor";

// =========================================================================
// 2. INJECT INTERACTIONS INTO SCROLL MENUS
// =========================================================================

// INNER SWITCH: Pulls vehicle deep into the slot
_innerSwitch addAction [
    "<t color='#00FF66'>[JC_Lift] Engage Tractor: Pull Vehicle IN</t>",
    {
        params ["_target", "_caller", "_id", "_args"];
        _args params ["_outer", "_inner"];
        
        private _foundVehs = nearestObjects [_outer, ["LandVehicle", "Air"], 7];
        
        if (count _foundVehs > 0) then {
            private _veh = _foundVehs select 0;
            "JC_Lifting: Dragging asset to internal slot for resupply." remoteExec ["hintSilent", _caller];
            
            // Target the specific vehicle owner for the physics commands
            [_veh, getPosASL _inner] remoteExec ["JC_fnc_localHangarTractor", _veh];
			_veh engineOn false;
			_veh setVariable ["JC_Lifting_FOB_Materials", true, true];
			[_veh, true] remoteExec ["JC_Lifting_fnc_Action_Update_Van_Capacity", 2];
			[_veh, true] remoteExec ["JC_Lifting_fnc_Action_Update_Material_Visuals", 2];
			sleep 4; _veh setDamage 0; _veh setFuel 1; _veh setVehicleAmmo 1; /*[liberty, _veh] call BIS_fnc_unflipThing; */sleep 3; _veh setDir (getDir liberty);
        } else {
            "System Error: No valid vehicle detected within 7 meters of the exterior ground green light!" remoteExec ["hint", _caller];
        };
    },
    [_outerSwitch, _innerSwitch], 11, true, true, "", "true", 5
];

// OUTER SWITCH: Pushes vehicle out to the pad
_outerSwitch addAction [
    "<t color='#FF3333'>[JC_Lift] Engage Tractor: Push Vehicle OUT</t>",
    {
        params ["_target", "_caller", "_id", "_args"];
        _args params ["_inner", "_outer"];
        
        private _foundVehs = nearestObjects [_inner, ["LandVehicle", "Air"], 8];
        
        if (count _foundVehs > 0) then {
            private _veh = _foundVehs select 0;
            "JC_Lifting: Clearing revamped asset to exterior pad." remoteExec ["hintSilent", _caller];
            _veh setDir (getDir liberty) //	((getDir liberty) + 180)
            // Target the specific vehicle owner for the physics commands
            ;	[_veh, getPosASL _outer] remoteExec ["JC_fnc_localHangarTractor", _veh];
			_veh setDamage 0; _veh setFuel 1; _veh setVehicleAmmo 1; sleep 7;
//			[liberty, _veh] call BIS_fnc_unflipThing;//	 sleep 7; [liberty, _veh] call BIS_fnc_unflipThing;
			_veh setDamage 0; _veh setFuel 1; _veh setVehicleAmmo 1; _veh engineOn true; 
        } else {
            "System Error: No valid vehicle detected within 8 meters of the ground green light!" remoteExec ["hint", _caller];
        };
    },
    [_innerSwitch, _outerSwitch], 11, true, true, "", "true", 5
];

// =========================================================================
// 3. CENTERING ACTION (TO OUTER SWITCH)
// =========================================================================
_outerSwitch addAction [
    "<t color='#FFA500'>Center-Ready vehicle for Storage</t>",
    {
        params ["_target", "_caller", "_id", "_args"];
        
        // Search 5 meters nearby ITSELF (the _outerSwitch target object)
        private _foundVehs = nearestObjects [_target, ["LandVehicle", "Air", "Ship"], 7];
        
        if (count _foundVehs > 0) then {
            private _veh = _foundVehs select 0;
			private _libertyDir = getDir liberty;
            
            private _targetPos = getPosATL _target;
            private _currentZ = (getPosATL _veh) select 2;
            
            // Locality-assured instant snap: Executed directly on the vehicle's owner machine
            [_veh, [_targetPos select 0, _targetPos select 1, (_targetPos select 2) + 0.83]] remoteExec ["setPosATL", _veh];
			[_veh, _libertyDir] remoteExec ["setDir", _veh];
            
            "Vehicle centered over the exterior pad alignment." remoteExec ["hintSilent", _caller];
			[liberty, _veh] call BIS_fnc_unflipThing;
        } else {
            "System Error: No vehicle detected within 7 meters of this switch!" remoteExec ["hint", _caller];
        };
    },
    nil, 12, true, true, "", "true", 7
];

// =========================================================================
// 4. CENTERING ACTION FOR INNER SWITCH HANGAR (up)
// =========================================================================
_innerSwitch addAction [
    "<t color='#FFA500'>Center-Ready vehicle for Storage</t>",
    {
        params ["_target", "_caller", "_id", "_args"];
        
        // Search 5 meters nearby ITSELF (the _innerSwitch target object)
        private _foundVehs = nearestObjects [_target, ["LandVehicle", "Air", "Ship"], 7];
        
        if (count _foundVehs > 0) then {
            private _veh = _foundVehs select 0;
			private _libertyDir = getDir liberty;
            
            private _targetPos = getPosATL _target;
            private _currentZ = (getPosATL _veh) select 2;
            
            // Locality-assured instant snap: Executed directly on the vehicle's owner machine
            [_veh, [_targetPos select 0, _targetPos select 1, (_targetPos select 2) + 0.83]] remoteExec ["setPosATL", _veh];
			[_veh, _libertyDir] remoteExec ["setDir", _veh];
			_veh setDamage 0; _veh setFuel 1; _veh setVehicleAmmo 1; _veh setVariable ["JC_Lifting_FOB_Materials", true, true];
            
            "Vehicle centered over the exterior pad alignment." remoteExec ["hintSilent", _caller];
			[liberty, _veh] call BIS_fnc_unflipThing;
        } else {
            "System Error: No vehicle detected within 7 meters of this switch!" remoteExec ["hint", _caller];
        };
    },
    nil, 12, true, true, "", "true", 7
];




	// --- DOCKING TRACTOR BEAM FOR LOWETR ENTRY ---
// =========================================================================
// 1. REGISTER THE CORE TRACTOR BEAM LOOP (Locality-Assured & Just Release)
// =========================================================================
JC_fnc_localHangarTractor = {
    _this spawn {
        params ["_veh", "_destPosASL"];
        
        if (_veh getVariable ["JC_HangarTractor_Lock", false]) exitWith {};
        _veh setVariable ["JC_HangarTractor_Lock", true, true];
        
        _veh enableSimulationGlobal true;

        private _startPos = getPosASL _veh;
        _startPos set [2, (_startPos select 2) + 0.25]; // Lift start 0.25m
        
        private _endPos = +_destPosASL;
        _endPos set [2, (_endPos select 2) + 0.25]; // Lift end 0.25m
        
        private _vDir = vectorDir _veh;
        private _vUp = vectorUp _veh;
        private _t1 = diag_tickTime;
        private _t2 = diag_tickTime + 9; 

        private _instName = format ["JC_tractor_%1", netId _veh];
        missionNamespace setVariable [_instName, [_veh, _startPos, _endPos, _vDir, _vUp, _t1, _t2], true];

        addMissionEventHandler ["EachFrame", format [
            "
                private _args = missionNamespace getVariable ['%1', []];
                if (_args isEqualTo []) exitWith { removeMissionEventHandler ['EachFrame', _thisEventHandler]; };
                _args params ['_veh', '_startPos', '_endPos', '_vDir', '_vUp', '_t1', '_t2'];
                
                private _interval = 0 max ((linearConversion [_t1, _t2, diag_tickTime, 0, 1, true]) * (1 - diag_deltaTime)) min 1;
                
                _veh setVelocityTransformation [
                    _startPos, _endPos,
                    [0,0,0], [0,0,0],
                    _vDir, _vDir,
                    _vUp, _vUp,
                    _interval
                ];
                
                if (_interval >= 0.99 || !alive _veh) then {
                    _veh setVelocity [0,0,0];
                    _veh setVariable ['JC_HangarTractor_Lock', false, true];
                    missionNamespace setVariable ['%1', nil, true];
                    removeMissionEventHandler ['EachFrame', _thisEventHandler];
                };
            ", 
            _instName
        ]];
    };
};
publicVariable "JC_fnc_localHangarTractor";

// =========================================================================
// 2. INJECT INTERACTIONS INTO SCROLL MENUS
// =========================================================================

// INNER SWITCH: Pulls vehicle deep into the slot
_innerSwitchLower addAction [
    "<t color='#00FF66'>[JC_Lift] Engage Tractor: Pull Vehicle IN</t>",
    {
        params ["_target", "_caller", "_id", "_args"];
        _args params ["_outer", "_inner"];
        
        private _foundVehs = nearestObjects [_outer, ["LandVehicle", "Air"], 7];
        
        if (count _foundVehs > 0) then {
            private _veh = _foundVehs select 0;
            "JC_Lifting: Dragging asset to internal slot for resupply." remoteExec ["hintSilent", _caller];
            
            // Target the specific vehicle owner for the physics commands
            [_veh, getPosASL _inner] remoteExec ["JC_fnc_localHangarTractor", _veh];
			_veh engineOn false;
			_veh setVariable ["JC_Lifting_FOB_Materials", true, true];
			[_veh, true] remoteExec ["JC_Lifting_fnc_Action_Update_Van_Capacity", 2];
			[_veh, true] remoteExec ["JC_Lifting_fnc_Action_Update_Material_Visuals", 2];
			sleep 4; _veh setDamage 0; _veh setFuel 1; _veh setVehicleAmmo 1;/* [liberty, _veh] call BIS_fnc_unflipThing; */sleep 3; _veh setDir (getDir liberty);
        } else {
            "System Error: No valid vehicle detected within 7 meters of the exterior ground green light!" remoteExec ["hint", _caller];
        };
    },
    [_outerSwitchLower, _innerSwitchLower], 11, true, true, "", "true", 5
];

// OUTER SWITCH: Pushes vehicle out to the pad
_outerSwitchLower addAction [
    "<t color='#FF3333'>[JC_Lift] Engage Tractor: Push Vehicle OUT</t>",
    {
        params ["_target", "_caller", "_id", "_args"];
        _args params ["_inner", "_outer"];
        
        private _foundVehs = nearestObjects [_inner, ["LandVehicle", "Air"], 8];
        
        if (count _foundVehs > 0) then {
            private _veh = _foundVehs select 0;
            "JC_Lifting: Clearing revamped asset to exterior pad." remoteExec ["hintSilent", _caller];
            _veh setDir (getDir liberty) //	((getDir liberty) + 180)
            // Target the specific vehicle owner for the physics commands
            ;	[_veh, getPosASL _outer] remoteExec ["JC_fnc_localHangarTractor", _veh];
			_veh setDamage 0; _veh setFuel 1; _veh setVehicleAmmo 1; sleep 7;
//			[liberty, _veh] call BIS_fnc_unflipThing;//	 sleep 7; [liberty, _veh] call BIS_fnc_unflipThing;
			_veh setDamage 0; _veh setFuel 1; _veh setVehicleAmmo 1; _veh engineOn true; 
        } else {
            "System Error: No valid vehicle detected within 8 meters of the ground green light!" remoteExec ["hint", _caller];
        };
    },
    [_innerSwitchLower, _outerSwitchLower], 11, true, true, "", "true", 5
];

// =========================================================================
// 3. CENTERING ACTION (EXCLUSIVE TO OUTER SWITCH lower deck)
// =========================================================================
_outerSwitchLower addAction [
    "<t color='#FFA500'>Center-Ready vehicle for Storage</t>",
    {
        params ["_target", "_caller", "_id", "_args"];
        
        // Search 5 meters nearby ITSELF (the _outerSwitchL target object)
        private _foundVehs = nearestObjects [_target, ["LandVehicle", "Air"], 10];
        
        if (count _foundVehs > 0) then {
            private _veh = _foundVehs select 0;
			private _libertyDir = getDir liberty;
            
            private _targetPos = getPosATL _target;
            private _currentZ = (getPosATL _veh) select 2;
            
            // Locality-assured instant snap: Executed directly on the vehicle's owner machine
            [_veh, [_targetPos select 0, _targetPos select 1, (_targetPos select 2) + 0.83]] remoteExec ["setPosATL", _veh];
			[_veh, _libertyDir] remoteExec ["setDir", _veh];
            
            "Vehicle centered over the green light alignment." remoteExec ["hintSilent", _caller];
			[liberty, _veh] call BIS_fnc_unflipThing;
        } else {
            "System Error: No vehicle detected within 10 meters of this switch!" remoteExec ["hint", _caller];
        };
    },
    nil, 12, true, true, "", "true", 7
];

// =========================================================================
// 4. CENTERING ACTION (EXCLUSIVE TO INNER SWITCH lower deck)
// =========================================================================
_outerSwitchLower addAction [
    "<t color='#FFA500'>Center-Ready vehicle for Storage</t>",
    {
        params ["_target", "_caller", "_id", "_args"];
        
        // Search 5 meters nearby ITSELF (the _innerSwitchLower target object)
        private _foundVehs = nearestObjects [_target, ["LandVehicle", "Air"], 8.5];
        
        if (count _foundVehs > 0) then {
            private _veh = _foundVehs select 0;
			private _libertyDir = getDir liberty;
            
            private _targetPos = getPosATL _target;
            private _currentZ = (getPosATL _veh) select 2;
            
            // Locality-assured instant snap: Executed directly on the vehicle's owner machine
            [_veh, [_targetPos select 0, _targetPos select 1, (_targetPos select 2) + 0.25]] remoteExec ["setPosATL", _veh];
			[_veh, _libertyDir] remoteExec ["setDir", _veh];
			_veh setDamage 0; _veh setFuel 1; _veh setVehicleAmmo 1; _veh setVariable ["JC_Lifting_FOB_Materials", true, true];
            
            "Vehicle centered over the entry green light alignment." remoteExec ["hintSilent", _caller];
			[liberty, _veh] call BIS_fnc_unflipThing;
        } else {
            "System Error: No vehicle detected within 10 meters of this switch!" remoteExec ["hint", _caller];
        };
    },
    nil, 12, true, true, "", "true", 7
];


private _trgInnerSwitchLower = createTrigger ["EmptyDetector", [0,0,0], false];
_trgInnerSwitchLower attachTo [_innerSwitchLower, [0,0,0]];
_trgInnerSwitchLower setTriggerArea [6.75, 6.75, 0, true, 5];
_trgInnerSwitchLower setTriggerActivation ["WEST", "PRESENT", true];
_trgInnerSwitchLower setTriggerStatements ["this", "{_x setDamage 0; _x setFuel 1; _x setVehicleAmmo 1} forEach thisList;", ""];


// --- START OF FRONT LANDING DECK STUFF - FRONT HANGAR
// --- DOCKBARGE SPAWN --- FRONT HANGAR
        private _hangarAnchorFront = [0, 63, 10.42];
//        liberty setVariable ["JC_Barge_hangarAnchorFront", _hangarAnchorFront, true];
        private _frontCompArrayFront = [
            ["PortableHelipadLight_01_yellow_F", [0, 0, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_red_F", [0, 8, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_red_F", [-8, 0, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_red_F", [8, 0, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_red_F", [0, -8, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_red_F", [0, 5, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_red_F", [-5, 0, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_red_F", [5, 0, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_red_F", [0, -5, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_blue_F", [0, 2.5, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_blue_F", [-2.5, 0, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_blue_F", [2.5, 0, 0.16], [0, 0, 0]],
            ["PortableHelipadLight_01_blue_F", [0, -2.5, 0.16], [0, 0, 0]],
            ["Land_MedicalTent_01_floor_light_F", [0, 0, 0.07], [0, 0, 0]]
            ,["PortableHelipadLight_01_green_F", [0, 3.5, 0.16], [0, 0, 0]]
//			,["PortableHelipadLight_01_green_F", [0, 33.75, 0.11], [0, 0, 0]]
        ];
        
        private _spawnedLandingFront = [];
        {
            _x params ["_class", "_offset", "_rot"];
            private _item = createVehicle [_class, [0,0,0], [], 0, "NONE"];
            _item attachTo [liberty, [(_hangarAnchorFront select 0) + (_offset select 0), (_hangarAnchorFront select 1) + (_offset select 1), (_hangarAnchorFront select 2) + (_offset select 2)]];
            _item setDir (_rot select 0);
            [_item, _rot select 1, _rot select 2] call BIS_fnc_setPitchBank;
            _spawnedLandingFront pushBack _item;
        } forEach _frontCompArrayFront;
        
        private _landingLightFront = _spawnedLandingFront select 0;
        private _tentFloorLanding = _spawnedLandingFront select 13;
        private _outerSwitchLanding = _spawnedLandingFront select 14;
		private _innerSwitchLanding = _spawnedLandingFront select 15;



// =========================================================================
// 3. CENTERING ACTION (FRONT LANDING PAD)
// =========================================================================
_outerSwitchLanding addAction [
    "<t color='#FFA500'>Center-Ready vehicle for Storage</t>",
    {
        params ["_target", "_caller", "_id", "_args"];
        
        // Search 5 meters nearby ITSELF (the _outerSwitchLanding target object)
        private _foundVehs = nearestObjects [_target, ["LandVehicle", "Air", "Ship"], 7];
        
        if (count _foundVehs > 0) then {
            private _veh = _foundVehs select 0;
			private _libertyDir = getDir liberty;
            
            private _targetPos = getPosATL _target;
            private _currentZ = (getPosATL _veh) select 2;
            
            // Locality-assured instant snap: Executed directly on the vehicle's owner machine
            [_veh, [_targetPos select 0, _targetPos select 1, (_targetPos select 2) + 0.83]] remoteExec ["setPosATL", _veh];
			[_veh, _libertyDir] remoteExec ["setDir", _veh];
            
            "Vehicle centered over the exterior pad alignment." remoteExec ["hintSilent", _caller];
			[liberty, _veh] call BIS_fnc_unflipThing;
        } else {
            "System Error: No vehicle detected within 7 meters of this switch!" remoteExec ["hint", _caller];
        };
    },
    nil, 12, true, true, "", "true", 7
];

// --- END OF FRONT LANDING DECK STUFF ---




//TELEPORTATION SYSTEM

// ============================================================================
// CENTRALIZED TELEPORT TERMINAL CONFIGURATOR
// Paste this anywhere inside your liberty.sqf file
// ============================================================================
JC_fnc_setupTeleportTerminal = {
    params ["_terminalObj"];
    if (isNull _terminalObj) exitWith {};

    removeAllActions _terminalObj;

    private _destinations = [
        ["Service Lower Dock", "ServiceRoom", "Service Dock"],
        ["Engine Room", "EngineRoom", "Engine Room"],
        ["Control Bridge", "ControlBridge", "Control Bridge"],
        ["Hangar Bridge", "HangarBridge", "Hangar Bridge"],
		["Front Landing Deck", "FrontLandingDeck", "Front Landing Deck"],
		["Hangar Service Gate", "HangarService", "Hangar Service Gate"],
		//	["Lower Deck Control", "LowerDeckControl", "Lower Deck Control"],
		["Bathroom", "Bathroom", "Bathroom"]
    ];

    {
        _x params ["_menuName", "_varSuffix", "_alertName"];
        
        _terminalObj addAction [
            format ["<t color='#FFA500'>[Teleport] %1</t>", _menuName], 
            {
                params ["_target", "_caller", "_actionId", "_arguments"];
                _arguments params ["_varSuffix", "_alertName"];
                
                private _offset = liberty getVariable [format ["JC_Mod_%1_Anchor", _varSuffix], []];
                
                if (count _offset > 0) then {
                    // CRITICAL FIX: Gets absolute world ASL coordinates
                    private _spawnPos = liberty modelToWorldWorld _offset;
                    
                    // CRITICAL FIX: Safe placement relative to Sea Level, not sea floor
                    _caller setPosASL [_spawnPos select 0, _spawnPos select 1, (_spawnPos select 2) + 0.1];
                    _caller setDir (getDir liberty);
                    
                    titleText [format ["Teleporting to %1...", _alertName], "PLAIN DOWN", 0.5];
                } else {
                    systemChat format ["Teleport Failed: %1 anchor matrix has not been initialized.", _alertName];
                };
            },
            [_varSuffix, _alertName],
            1.5,
            false,
            true,
            "",
            "true",
            2
        ];
    } forEach _destinations;
};

//	SPECIFIC OBJECTS FOR CALL TELEPORTS
[_medKit] call JC_fnc_setupTeleportTerminal;
[_medKitEntry] call JC_fnc_setupTeleportTerminal;

/*
[cursorObject] call JC_fnc_setupTeleportTerminal;

EXAMPLES:
[bridge_console] call JC_fnc_setupTeleportTerminal;
[deck_sign] call JC_fnc_setupTeleportTerminal;	*/




// =========================================================================
// MODULAR CHAMBER INITIALIZATION PANELS
// =========================================================================

// Arguments: [Parent Object, Relative Offset [X, Y, Z]]
[liberty, [51, 42, 83]] execVM "functions\liberty_modules\module_bathroom.sqf";
[liberty, [83, 42, 83]] execVM "functions\liberty_modules\module_serviceRoom.sqf";
[liberty, [-51, 42, 83]] execVM "functions\liberty_modules\module_engineRoom.sqf";
[liberty, [0, 38, 19.75]] execVM "functions\liberty_modules\module_controlBridge.sqf";
[liberty, [-9, -50.5, 15.5]] execVM "functions\liberty_modules\module_hangarBridge.sqf";
//	[liberty, [-9, -35.5, 5.75]] execVM "functions\liberty_modules\module_lowerDeckControl.sqf";
[liberty, [0, 78, 10.83]] execVM "functions\liberty_modules\module_frontLandingDeck.sqf";
[liberty, [-5.75, -7.75, 8.25]] execVM "functions\liberty_modules\module_hangarService.sqf";




// --- INSTRUCTORS VENDORS PRESET LOADOUT GEAR ---
if (!isServer) exitWith {};

// --- ADJUST RELATIVE POSITIONS HERE ---
// Format: [X (Left/Right), Y (Forward/Back), Z (Deck Height)] relative to liberty pivot
private _paramedicOffset   = [-10, -47.5, 15.5]; 
private _scubaOffset       = [-8.25, -49.5, 15.5];
private _cbrnOffset        = [-7.5, -50.1, 15.5];

// Create safe control group
private _unitGroup = createGroup [civilian, true];
_unitGroup setBehaviour "CARELESS";
_unitGroup setCombatMode "BLUE";

// ============================================================================
// 1. SPAWN PARAMEDIC UNIT
// ============================================================================
private _paramedicPos = liberty modelToWorldWorld _paramedicOffset;
private _unitParamedic = _unitGroup createUnit ["C_man_1", [0,0,0], [], 0, "NONE"];
_unitParamedic setPosASL _paramedicPos;
//_unitParamedic setDir (getDir liberty);
_unitParamedic setDir ((getDir liberty) + 180);
_unitParamedic disableAI "MOVE";
_unitParamedic allowDamage false;

// Apply Paramedic Preset Loadout
removeVest _unitParamedic;
removeUniform _unitParamedic;
removeBackpack _unitParamedic;
removeHeadgear _unitParamedic;
_unitParamedic addVest "JC_DeckCrewViolet_Cargo";
_unitParamedic forceAddUniform "U_C_Paramedic_01_F";
_unitParamedic addBackpack "B_AssaultPack_rgr";
_unitParamedic addHeadgear "H_HelmetSpecB";

// Add Actions
[_unitParamedic, [
    "<t color='#00FF66'>Swap Paramedic</t>", 
    {
        params ["_target", "_caller"];
        private _uid = getPlayerUID _caller;
        private _varName = format ["JC_Lifting_StoredGear_Paramedic_%1", _uid];
        _target setVariable [_varName, getUnitLoadout _caller, true];
        
        removeVest _caller; removeUniform _caller; removeBackpack _caller; removeHeadgear _caller;
        _caller addVest "JC_DeckCrewViolet_Cargo";
        _caller forceAddUniform "U_C_Paramedic_01_F";
        _caller addBackpack "B_AssaultPack_rgr";
        _caller addHeadgear "H_HelmetSpecB";
        hint "Paramedic Gear Equipped.";
    }, nil, 6, true, true, "", "true", 2.25
]] remoteExec ["addAction", 0, _unitParamedic];

[_unitParamedic, [
    "<t color='#FF3333'>Restore Original Gear (Paramedic)</t>", 
    {
        params ["_target", "_caller"];
        private _uid = getPlayerUID _caller;
        private _varName = format ["JC_Lifting_StoredGear_Paramedic_%1", _uid];
        private _storedLoadout = _target getVariable [_varName, []];
        if (count _storedLoadout == 0) exitWith { hint "No original gear recorded on this unit!"; };
        
        removeVest _caller; removeUniform _caller; removeBackpack _caller; removeHeadgear _caller;
        _caller setUnitLoadout _storedLoadout;
        _target setVariable [_varName, nil, true];
        hint "Original gear restored.";
    }, nil, 5, true, true, "", "true", 2.25
]] remoteExec ["addAction", 0, _unitParamedic];


// ============================================================================
// 2. SPAWN SCUBA UNIT
// ============================================================================
private _scubaPos = liberty modelToWorldWorld _scubaOffset;
private _unitScuba = _unitGroup createUnit ["C_man_1", [0,0,0], [], 0, "NONE"];
_unitScuba setPosASL _scubaPos;
//_unitScuba setDir (getDir liberty);
_unitScuba setDir ((getDir liberty) + 135);
_unitScuba disableAI "MOVE";
_unitScuba allowDamage false;

// Apply Scuba Preset Loadout
removeAllWeapons _unitScuba;
removeHeadgear _unitScuba;
removeVest _unitScuba;
removeUniform _unitScuba;
removeBackpack _unitScuba;
removeAllAssignedItems _unitScuba;
_unitScuba addVest "V_RebreatherB";
_unitScuba forceAddUniform "U_B_Wetsuit";
_unitScuba addBackpack "B_SCBA_01_F";
_unitScuba addWeapon "arifle_SDAR_F";

// Add Actions
[_unitScuba, [
    "<t color='#00FF66'>Swap Scuba</t>", 
    {
        params ["_target", "_caller"];
        private _uid = getPlayerUID _caller;
        private _varName = format ["JC_Lifting_StoredGear_%1", _uid];
        _target setVariable [_varName, getUnitLoadout _caller, true];
        
        removeAllWeapons _caller; removeHeadgear _caller; removeVest _caller; removeUniform _caller; removeBackpack _caller; removeAllAssignedItems _caller;
        _caller addVest "V_RebreatherB";
        _caller forceAddUniform "U_B_Wetsuit";
        _caller addBackpack "B_SCBA_01_F";
        _caller addWeapon "arifle_SDAR_F";
        _caller addWeapon "hgun_P07_snds_F";
        for "_i" from 1 to 4 do { _caller addMagazine "30Rnd_556x45_Stanag_red"; };
        for "_i" from 1 to 2 do { _caller addMagazine "16Rnd_9x21_Mag"; };
        hint "Scuba Gear Equipped.";
    }, nil, 6, true, true, "", "true", 2.25
]] remoteExec ["addAction", 0, _unitScuba];

[_unitScuba, [
    "<t color='#FF3333'>Restore Original Gear (Scuba)</t>", 
    {
        params ["_target", "_caller"];
        private _uid = getPlayerUID _caller;
        private _varName = format ["JC_Lifting_StoredGear_%1", _uid];
        private _storedLoadout = _target getVariable [_varName, []];
        if (count _storedLoadout == 0) exitWith { hint "No original gear recorded on this unit!"; };
        
        removeAllWeapons _caller; removeHeadgear _caller; removeVest _caller; removeUniform _caller; removeBackpack _caller; removeAllAssignedItems _caller;
        _caller setUnitLoadout _storedLoadout;
        _target setVariable [_varName, nil, true];
        hint "Original gear restored.";
    }, nil, 5, true, true, "", "true", 2.25
]] remoteExec ["addAction", 0, _unitScuba];


// ============================================================================
// 3. SPAWN CBRN UNIT
// ============================================================================
private _cbrnPos = liberty modelToWorldWorld _cbrnOffset;
private _unitCBRN = _unitGroup createUnit ["C_man_1", [0,0,0], [], 0, "NONE"];
_unitCBRN setPosASL _cbrnPos;
//_unitCBRN setDir (getDir liberty);
_unitCBRN setDir ((getDir liberty) + 135);
_unitCBRN disableAI "MOVE";
_unitCBRN allowDamage false;

// Apply CBRN Preset Loadout
removeVest _unitCBRN;
removeUniform _unitCBRN;
removeBackpack _unitCBRN;
_unitCBRN addVest "V_RebreatherB";
_unitCBRN forceAddUniform "U_B_CBRN_Suit_01_Wdl_F";
_unitCBRN addBackpack "B_SCBA_01_F";

// Add Actions
[_unitCBRN, [
    "<t color='#00FF66'>Swap CBRN</t>", 
    {
        params ["_target", "_caller"];
        private _uid = getPlayerUID _caller;
        private _varName = format ["JC_Lifting_StoredGear_Toxic_%1", _uid];
        _target setVariable [_varName, getUnitLoadout _caller, true];
        
        removeVest _caller; removeUniform _caller; removeBackpack _caller;
        _caller addVest "V_RebreatherB";
        _caller forceAddUniform "U_B_CBRN_Suit_01_Wdl_F";
        _caller addBackpack "B_SCBA_01_F";
        hint "CBRN Hazard Gear Equipped.";
    }, nil, 6, true, true, "", "true", 2.25
]] remoteExec ["addAction", 0, _unitCBRN];

[_unitCBRN, [
    "<t color='#FF3333'>Restore Original Gear (CBRN)</t>", 
    {
        params ["_target", "_caller"];
        private _uid = getPlayerUID _caller;
        private _varName = format ["JC_Lifting_StoredGear_Toxic_%1", _uid];
        private _storedLoadout = _target getVariable [_varName, []];
        if (count _storedLoadout == 0) exitWith { hint "No original gear recorded on this unit!"; };
        
        removeVest _caller; removeUniform _caller; removeBackpack _caller;
        _caller setUnitLoadout _storedLoadout;
        _target setVariable [_varName, nil, true];
        hint "Original gear restored.";
    }, nil, 5, true, true, "", "true", 2.25
]] remoteExec ["addAction", 0, _unitCBRN];



// --- SUPPLY BOX CRATE AMMUNITION PHYSICAL INVENTORY GEAR LOADOUTS ---
if (isServer) then {
    // 1. SPAWN SUPPLY CARGO NET AND ATTACH TO MASTER HULL
    private _loadoutCrate = createVehicle ["B_CargoNet_01_ammo_F", [0,0,0], [], 0, "NONE"];
    _loadoutCrate attachTo [liberty, [-5, -42, 16.25]];
    _loadoutCrate setDir ((getDir liberty) + 135);
    _loadoutCrate allowDamage false;

    // 2. WIPE DEFAULT CARGO CONTENTS COMPLETELY
    clearWeaponCargoGlobal _loadoutCrate;
    clearMagazineCargoGlobal _loadoutCrate;
    clearItemCargoGlobal _loadoutCrate;
    clearBackpackCargoGlobal _loadoutCrate;

    // 3. POPULATE FILTERED LOADOUT ITEMS

    // --- SPECIFIC SYSTEM ITEMS ---
    _loadoutCrate addItemCargoGlobal ["ToolKit", 10];
    _loadoutCrate addItemCargoGlobal ["Medikit", 7];
    _loadoutCrate addItemCargoGlobal ["FirstAidKit", 30];
    _loadoutCrate addItemCargoGlobal ["MineDetector", 5];

    // --- VESTS (5 of each) ---
    { _loadoutCrate addItemCargoGlobal [_x, 5]; } forEach [
        "JC_DeckCrewViolet_Cargo",
        "V_RebreatherB"                 // Scuba System Vest
    ];

    // --- BACKPACKS (5 of each) ---
    { _loadoutCrate addBackpackCargoGlobal [_x, 5]; } forEach [
        "B_AssaultPack_rgr"
    ];
	
	// --- BACKPACKS PARACHUTE (31 of each) ---
    { _loadoutCrate addBackpackCargoGlobal [_x, 31]; } forEach [
        "B_Parachute"
    ];

    // --- UNIFORMS (5 of each) ---
    { _loadoutCrate addItemCargoGlobal [_x, 5]; } forEach [
        "U_C_Paramedic_01_F",
        "U_C_CBRN_Suit_01_White_F",
        "U_B_Wetsuit"                   // Scuba System Uniform
    ];

    // --- HELMETS AND HATS (5 of each) ---
    { _loadoutCrate addItemCargoGlobal [_x, 5]; } forEach [
        "H_HelmetSpecB",
        "EF_H_Cap_liberty"
    ];

    // --- WEAPONS (3 of each) ---
    { _loadoutCrate addWeaponCargoGlobal [_x, 3]; } forEach [
        "JC_arifle_MX_Custom",
        "JC_hgun_P07_Custom"
    ];

    // --- AMMO MAGAZINES (16 of each matching default weapon compatibility) ---
    {
        private _mags = getArray (configFile >> "CfgWeapons" >> _x >> "magazines");
        if (count _mags > 0) then {
            _loadoutCrate addMagazineCargoGlobal [_mags select 0, 16];
        };
    } forEach ["JC_arifle_MX_Custom", "JC_hgun_P07_Custom"];

    // --- WEAPON ATTACHMENTS (2 of each) ---
    { _loadoutCrate addItemCargoGlobal [_x, 2]; } forEach [
        "JC_suppressor_shotgun",
        "JC_acc_flashlight_red",
        "JC_suppressor_revolver",
        "JC_acc_flashlight_pistol_red"
    ];

    // --- UNSPECIFIED / OTHER MISC ITEMS (3 of each) ---
    { _loadoutCrate addItemCargoGlobal [_x, 3]; } forEach [
        "NVGoggles",
        "G_Diving"                      // Scuba System Goggles/Glasses
    ];
};




 liberty addEventHandler ["HandleDamage", 
 {
    params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitPartIndex", "_instigator", "_hitPoint", "_directHit", "_context"];
    private _oldDamage = damage liberty;
    private _building = liberty;
    private _newDamage = (_damage - _oldDamage) / 10;
    _newDamage
 }];


// --- 4X REAR HANGAR LIFEBOATS DEPLOYMENT ---
//	The legacy huge code block is right after this working one

// =========================================================================
// DEFINITION: Config Array [libertyOffset, direction, boatOffset, smokeOffset]
// =========================================================================
private _deployConfigs = [
    [[-13.83, -61.25, 10.0], 90,  [-1.83, -19, -10.5],  [0, -21, -8]], // Deploy 1
    [[-13.83, -64.75, 10.0], 90,  [1.83, -19, -10.5], [0, -21, -8]], // Deploy 2
    [[13.83, -61.25, 10.0],  270, [1.83, -19, -10.5], [0, -21, -8]], // Deploy 3
    [[13.83, -64.75, 10.0],  270, [-1.83, -19, -10.5], [0, -21, -8]]  // Deploy 4
];

// =========================================================================
// EXECUTION: Spawn and Assign Actions to All Stations
// =========================================================================
{
    _x params ["_libertyOffset", "_dir", "_boatOffset", "_smokeOffset"];
    
    // 1. Spawn and align the station
    private _deployLight = createVehicle ["PortableHelipadLight_01_green_F", [0,0,0], [], 0, "NONE"];
    _deployLight attachTo [liberty, _libertyOffset];
    _deployLight setDir _dir;

    // 2. Store the specific offsets directly on this light object
    _deployLight setVariable ["JC_boatOffset", _boatOffset, true];
    _deployLight setVariable ["JC_smokeOffset", _smokeOffset, true];

    // 3. Register the Deploy Lifeboat Action globally
    [_deployLight, [
        "<t color='#FFA200'>Deploy Lifeboat</t>", 
        {
            params ["_target", "_caller", "_actionId", "_arguments"];
            
            _target spawn {
                params ["_target"];
                private _bOffset = _target getVariable ["JC_boatOffset", [0, -19, -10]];
                private _sOffset = _target getVariable ["JC_smokeOffset", [0, -21, -8]];

                private _boat = createVehicle ["B_Lifeboat", [0,0,0], [], 0, "NONE"];
                _boat attachTo [_target, _bOffset];
                sleep 1; 
                detach _boat;

                private _smoke = createVehicle ["JC_SmokeShellYellow_Extended", [0,0,0], [], 0, "NONE"];
                _smoke attachTo [_target, _sOffset];
                _smoke setDamage 1;
                sleep 0.25; 
                detach _smoke;
            };

            [_target, _actionId] remoteExec ["removeAction", 0, _target];
        }, 
        nil, 16, false, true, "", "alive _target", 3
    ]] remoteExec ["addAction", 0, _deployLight];

    // 4. Register the Swap Scuba Action globally
    // Condition: Only visible if this player has NOT stored gear on this specific light
    [_deployLight, [
        "<t color='#00D8FF'>Swap Scuba</t>", 
        {
            params ["_target", "_caller"];

            
            removeAllWeapons _caller; 
            removeHeadgear _caller; 
            removeVest _caller; 
            removeUniform _caller; 
            removeBackpack _caller; 
            removeAllAssignedItems _caller;

            _caller addVest "V_RebreatherB";
            _caller forceAddUniform "U_B_Wetsuit";
            _caller addBackpack "B_SCBA_01_F";
            _caller addWeapon "arifle_SDAR_F";
            _caller addWeapon "hgun_P07_snds_F";

            for "_i" from 1 to 4 do { _caller addMagazine "30Rnd_556x45_Stanag_red"; };
            for "_i" from 1 to 2 do { _caller addMagazine "16Rnd_9x21_Mag"; };

            hint "Scuba Gear Equipped.";
        }, 
        nil, 16, true, true, "", 
        "alive _target && {isNil {_target getVariable (format ['JC_Lifting_StoredGear_%1', getPlayerUID _this])}}", 
        5
    ]] remoteExec ["addAction", 0, _deployLight];


//	[_deployLight] call JC_fnc_setupTeleportTerminal;
} forEach _deployConfigs;



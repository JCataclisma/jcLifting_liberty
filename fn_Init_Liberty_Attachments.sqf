/*
    Author: JCataclisma
    Description: 
        Creates a localized fake anchor ('libertyFake') at the 'mrk_liberty_dock' marker position.
        Attaches a test Quadbike with an action and yellow smoke to this anchor.
        Runs automatically on postInit (Server-only).
		
		True Coordinates: Since the anchor is spawned exactly at your map marker ("mrk_liberty_dock"), 
		any attachTo offsets you apply to _libertyFake will now calculate perfectly relative to that marker's position.

		Global Access: By using missionNamespace setVariable ["libertyFake", _libertyFake, true], 
		you can now open any other script (including takmyr.sqf or console commands) 
		and reference the anchor simply as libertyFake without needing any spatial searches
*/
if (!isServer) exitWith {};

[] spawn {
    // Give the engine a second to initialize world assets and markers
    sleep 1; 

    // 1. Verify if the marker exists
    if (getMarkerColor "mrk_liberty_dock" == "") exitWith {
        diag_log "TAKMYR SYSTEM ERROR: Marker 'mrk_liberty_dock' does not exist on the map!";
    };

    private _markerPos = getMarkerPos "mrk_liberty_dock";
	private _markerDir = markerDir "mrk_liberty_dock";
	private _anchorASLpos = [_markerPos select 0, _markerPos select 1, (_markerPos select 2) + 2.5];

    // 2. Create the invisible anchor at the marker's position
    // We use "Land_HelipadEmpty_F" because it has no physics collisions to glitch the ship
//	private _libertyFake = createVehicle ["Land_HelipadEmpty_F", _markerPos, [], 0, "NONE"];
	private _libertyFake = createVehicle ["Land_HelipadEmpty_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	_libertyFake setPosASL _anchorASLpos;
    _libertyFake setDir _markerDir;
    _libertyFake allowDamage false;
//	[_libertyFake, false] remoteExec ["enableSimulationGlobal", 2];

    // Publish globally so other scripts (like takmyr.sqf) can instantly reference "libertyFake"
    missionNamespace setVariable ["libertyFake", _libertyFake, true];

    // 3. Spawn and attach to our new fake anchor
    private _m = createVehicle ["PortableHelipadLight_01_yellow_F", [0,0,0], [], 0, "NONE"];
    _m attachTo [_libertyFake, [-9.95, -57, 10.31]];
    _m setDir 90;

    // 4. Attach the Violet Interaction Action to the Quadbike
    [_m, [
        "<t color='#BF00FF'>Engage USS Liberty Permanent Modules</t>", 
        {
            params ["_target", "_caller", "_actionId", "_arguments"];
            [_target] execVM "liberty.sqf"; 
        }, 
        nil, 16, false, true, "", "alive _target", 5
    ]] remoteExec ["addAction", 0, _m];


};
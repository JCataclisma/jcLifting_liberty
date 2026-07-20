Arma 3 - Extra features for the USS liberty destroyer

============================= -DOWNLOAD and INSTALLATION

-copy all these files into your root mission folder (the same place where you find mission.sqm);

-add the object/prop USS liberty into your mission, either in mission editor, Zeus or script;

-give it the variable name "liberty";

-while in gameplay, open debug menu [ESC], paste the line below and hit [EXEC]:

[]execVm "liberty_lite.sqf" ;

--or execute the same file using scripts.

........... Below is the suggested file-tree your mission folder must have to make sure this stuff will work:

[MISSION_NAME.MAP]

|-mission.sqm |-liberty_lite.sqf

|->-[FUNCTIONS]|->-[liberty_MODULES]

==================== -CUSTOM NAME?

If you want to use any other name, just open this SQF file and perform an automatic find & replace for "liberty" into the name of your choice. IMPORTANT: if you happen to find something starting with a underline, like '_liberty', do NOT replace those.

==================== -DIFFERENT MODULES:

Every single module is summoned and spawned at the moment the main "liberty_lite" file is called. If you don't wan any of them, just search for the block below, inside the "lite" file, and block the lines related to what you don't want, just like the "module_bathroom" you can see there. Note that even if a module is blocked from spawning, it WILL still be available for selection in the "teleporters" laptops. Although the script is meant to return a denied message in such cases, it might happen that the player is thrown underwater, in position [0,0,0] of the map, case they insist in selecting an unexistent module.

// ========================================================================= // MODULAR CHAMBER INITIALIZATION PANELS // =========================================================================

// Arguments: [Parent Object, Relative Offset [X, Y, Z]]

//[liberty, [0, 6.6, 1.6]] execVM "module_bathroom.sqf";

[liberty, [4.5, 40.25, 4.5]] execVM "module_serviceRoom.sqf";

[liberty, [-6.5, 46.16, 2.5]] execVM "module_engineRoom.sqf";

[liberty, [0, 58.5, 20.9]] execVM "module_controlBridge.sqf";

[liberty, [-9, -35.5, 17.5]] execVM "module_hangarBridge.sqf";

[liberty, [-9, -35.5, 5.75]] execVM "module_lowerDeckControl.sqf";

[liberty, [0, 78, 10.83]] execVM "module_frontLandingDeck.sqf";

[liberty, [-4.75, -21.31, 10.75]] execVM "module_hangarService.sqf";

==================== -UPDATES and stuff

This script will be update quite often. Several other features, actions and areas will be available. The "lite" version will not have the whole lot of features of the full version that you might see on videos in my channel, as their heavy core relies mostly on dependencies from my JC_Lifting mod. You will most likely find a quite messy content inside, as every time I make this "lite" version ready I just delete my mod-dependencies content and somehow reposition what is left - but it should all work, nonetheless. If throughout the time this script receives more content you thing it might have a negative impact in your game/server performance, just setup some triggers to activate/deactivate it - the next areas of the ship are suposed to be "modular", for better performance and control.

================== -NETWORK and CONTACT

-My Youtube channel: https://www.youtube.com/@jcataclisma

-JC_Lifting mod on Steam Workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=3711634638

-Expeditionary Forces DLC on Steam: https://store.steampowered.com/app/2647830/Arma_3_Creator_DLC_Expeditionary_Forces/

/**********************Mine areas**************************/

/area/mine
	icon_state = "mining"

/area/mine/dangerous/explored
	name = "Mine"
	icon_state = "explored"
	music = null
	always_unpowered = 1
	requires_power = 1
	poweralm = 0
	power_environ = 0
	power_equip = 0
	power_light = 0
	outdoors = 1
	ambientsounds = list('sound/ambience/ambimine.ogg')

/area/mine/dangerous/unexplored
	name = "Mine"
	icon_state = "unexplored"
	music = null
	always_unpowered = 1
	requires_power = 1
	poweralm = 0
	power_environ = 0
	power_equip = 0
	power_light = 0
	outdoors = 1
	ambientsounds = list('sound/ambience/ambimine.ogg','sound/ambience/song_game.ogg')

/area/mine/lobby
	name = "Mining Station"
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/mine/storage
	name = "Mining Station Storage"

/area/mine/production
	name = "Mining Station Starboard Wing"
	icon_state = "mining_production"

/area/mine/abandoned
	name = "Abandoned Mining Station"

/area/mine/living_quarters
	name = "Mining Station Port Wing"
	icon_state = "mining_living"
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/mine/eva
	name = "Mining Station EVA"
	icon_state = "mining_eva"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/mine/maintenance
	name = "Mining Station Communications"

/area/mine/cafeteria
	name = "Mining Station Cafeteria"

/area/mine/hydroponics
	name = "Mining Station Hydroponics"

/area/mine/sleeper
	name = "Mining Station Emergency Sleeper"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/mine/north_outpost
	name = "North Mining Outpost"

/area/mine/west_outpost
	name = "West Mining Outpost"

/area/mine/podbay
	name = "Mining Podbay"
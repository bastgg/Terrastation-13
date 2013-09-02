/**********************Random mine generator************************/

//this item is intended to give the effect of entering the mine, so that light gradually fades
/obj/effect/mine_generator
	name = "Random mine generator"
	anchored = 1
	unacidable = 1
	var/turf/last_loc
	var/turf/target_loc
	var/turf/start_loc
	var/randXParam //the value of these two parameters are generated by the code itself and used to
	var/randYParam //determine the random XY parameters
	var/mineDirection = 3
	/*
		0 = none
		1 = N
		2 = NNW
		3 = NW
		4 = WNW
		5 = W
		6 = WSW
		7 = SW
		8 = SSW
		9 = S
		10 = SSE
		11 = SE
		12 = ESE
		13 = E
	 	14 = ENE
		15 = NE
		16 = NNE
	*/

/obj/effect/mine_generator/New()
	last_loc = src.loc
	var/i
	for(i = 0; i < 50; i++)
		gererateTargetLoc()
		//target_loc = locate(last_loc.x + rand(5), last_loc.y + rand(5), src.z)
		fillWithAsteroids()
	del(src)
	return


/obj/effect/mine_generator/proc/gererateTargetLoc()  //this proc determines where the next square-room will end.
	switch(mineDirection)
		if(1)
			randXParam = 0
			randYParam = 4
		if(2)
			randXParam = 1
			randYParam = 3
		if(3)
			randXParam = 2
			randYParam = 2
		if(4)
			randXParam = 3
			randYParam = 1
		if(5)
			randXParam = 4
			randYParam = 0
		if(6)
			randXParam = 3
			randYParam = -1
		if(7)
			randXParam = 2
			randYParam = -2
		if(8)
			randXParam = 1
			randYParam = -3
		if(9)
			randXParam = 0
			randYParam = -4
		if(10)
			randXParam = -1
			randYParam = -3
		if(11)
			randXParam = -2
			randYParam = -2
		if(12)
			randXParam = -3
			randYParam = -1
		if(13)
			randXParam = -4
			randYParam = 0
		if(14)
			randXParam = -3
			randYParam = 1
		if(15)
			randXParam = -2
			randYParam = 2
		if(16)
			randXParam = -1
			randYParam = 3
	target_loc = last_loc
	if(randXParam > 0)
		target_loc = locate(target_loc.x+rand(randXParam),target_loc.y,src.z)
	if(randYParam > 0)
		target_loc = locate(target_loc.x,target_loc.y+rand(randYParam),src.z)
	if(randXParam < 0)
		target_loc = locate(target_loc.x-rand(-randXParam),target_loc.y,src.z)
	if(randYParam < 0)
		target_loc = locate(target_loc.x,target_loc.y-rand(-randXParam),src.z)
	if(mineDirection == 1 || mineDirection == 5 || mineDirection == 9 || mineDirection == 13) //if N,S,E,W, turn quickly
		if(prob(50))
			mineDirection += 2
		else
			mineDirection -= 2
			if(mineDirection < 1)
				mineDirection += 16
	else
		if(prob(50))
			if(prob(50))
				mineDirection += 1
			else
				mineDirection -= 1
				if(mineDirection < 1)
					mineDirection += 16
	return


/obj/effect/mine_generator/proc/fillWithAsteroids()

	if(last_loc)
		start_loc = last_loc

	if(start_loc && target_loc)
		var/x1
		var/y1

		var/turf/line_start = start_loc
		var/turf/column = line_start

		if(start_loc.x <= target_loc.x)
			if(start_loc.y <= target_loc.y)                                 //GOING NORTH-EAST
				for(y1 = start_loc.y; y1 <= target_loc.y; y1++)
					for(x1 = start_loc.x; x1 <= target_loc.x; x1++)
						new/turf/simulated/floor/plating/airless/asteroid(column)
						column = get_step(column,EAST)
					line_start = get_step(line_start,NORTH)
					column = line_start
				last_loc = target_loc
				return
			else                                                            //GOING NORTH-WEST
				for(y1 = start_loc.y; y1 >= target_loc.y; y1--)
					for(x1 = start_loc.x; x1 <= target_loc.x; x1++)
						new/turf/simulated/floor/plating/airless/asteroid(column)
						column = get_step(column,WEST)
					line_start = get_step(line_start,NORTH)
					column = line_start
				last_loc = target_loc
				return
		else
			if(start_loc.y <= target_loc.y)                                 //GOING SOUTH-EAST
				for(y1 = start_loc.y; y1 <= target_loc.y; y1++)
					for(x1 = start_loc.x; x1 >= target_loc.x; x1--)
						new/turf/simulated/floor/plating/airless/asteroid(column)
						column = get_step(column,EAST)
					line_start = get_step(line_start,SOUTH)
					column = line_start
				last_loc = target_loc
				return
			else                                                            //GOING SOUTH-WEST
				for(y1 = start_loc.y; y1 >= target_loc.y; y1--)
					for(x1 = start_loc.x; x1 >= target_loc.x; x1--)
						new/turf/simulated/floor/plating/airless/asteroid(column)
						column = get_step(column,WEST)
					line_start = get_step(line_start,SOUTH)
					column = line_start
				last_loc = target_loc
				return


	return

/obj/item/projectile/hivebotbullet
		damage = 5
		mobdamage = list(BRUTE = 5, BURN = 0, TOX = 0, OXY = 0, CLONE = 0)

/obj/critter/hivebot
	name = "Hivebot"
	desc = "A small robot"
	icon = 'hivebot.dmi'
	icon_state = "basic"
	health = 10
	max_health = 10
	aggressive = 1
	wanderer = 1
	opensdoors = 1
	atkcarbon = 1
	atksilicon = 0
	atkcritter = 1
	atksame = 0
	atkmech = 1
	firevuln = 0.5
	brutevuln = 1
	seekrange = 8
	armor = 5
	melee_damage_lower = 2
	melee_damage_upper = 3
	angertext = "leaps at"
	attacktext = "claws"
	var
		ranged = 0
		rapid = 0
	proc
		Shoot(var/target, var/start, var/user, var/bullet = 0)
		OpenFire(var/thing)//bluh ill rename this later or somethin


	Die()
		if (!src.alive) return
		src.alive = 0
		walk_to(src,0)
		src.visible_message("<b>[src]</b> blows apart!")
		var/turf/Ts = get_turf(src)
		new /obj/decal/cleanable/robot_debris(Ts)
		var/datum/effects/system/spark_spread/s = new /datum/effects/system/spark_spread
		s.set_up(3, 1, src)
		s.start()
		del(src)

	seek_target()
		src.anchored = 0
		var/T = null
		for(var/mob/living/C in view(src.seekrange,src))//TODO: mess with this
			if (src.target)
				src.task = "chasing"
				break
			if((C.name == src.oldtarget_name) && (world.time < src.last_found + 100)) continue
			if(istype(C, /mob/living/carbon/) && !src.atkcarbon) continue
			if(istype(C, /mob/living/silicon/) && !src.atksilicon) continue
			if(C.health < 0) continue
			if(istype(C, /mob/living/carbon/) && src.atkcarbon)
				if(C:mind)
					if(C:mind:special_role == "H.I.V.E")
						continue
				src.attack = 1
			if(istype(C, /mob/living/silicon/) && src.atksilicon)
				if(C:mind)
					if(C:mind:special_role == "H.I.V.E")
						continue
				src.attack = 1
			if(src.attack)
				T = C
				break

		for(var/obj/mecha/C in view(src.seekrange,src))//TODO: Change this to chase mechas.
			if (src.target)
				src.task = "chasing"
				break
			if((C.name == src.oldtarget_name) && (world.time < src.last_found + 100)) continue
			src.attack = 1
			if(src.attack)
				T = C
				break


		if(!src.attack)
			for(var/obj/critter/C in view(src.seekrange,src))
				if(istype(C, /obj/critter) && !src.atkcritter) continue
				if(istype(C, /obj/mecha) && !src.atkmech) continue
				if(C.health <= 0) continue
				if(istype(C, /obj/critter) && src.atkcritter)
					if((istype(C, /obj/critter/hivebot) && !src.atksame) || (C == src))	continue
					src.attack = 1
				if(istype(C, /obj/mecha) && src.atkmech) src.attack = 1
				if(src.attack)
					T = C
					break

		if(src.attack)
			src.target = T
			src.oldtarget_name = T:name
			if(src.ranged)
				OpenFire(T)
				return
			src.task = "chasing"
		return


	OpenFire(var/thing)
		src.target = thing
		src.oldtarget_name = thing:name
		for(var/mob/O in viewers(src, null))
			O.show_message("\red <b>[src]</b> fires at [src.target]!", 1)

		var/tturf = get_turf(target)
		if(rapid)
			spawn(1)
				Shoot(tturf, src.loc, src)
			spawn(4)
				Shoot(tturf, src.loc, src)
			spawn(6)
				Shoot(tturf, src.loc, src)
		else
			Shoot(tturf, src.loc, src)

		src.attack = 0
		sleep(12)
		seek_target()
		src.task = "thinking"
		return


	Shoot(var/target, var/start, var/user, var/bullet = 0)
		if(target == start)
			return

		var/obj/item/projectile/hivebotbullet/A = new /obj/item/projectile/hivebotbullet(user:loc)
		playsound(user, 'Gunshot.ogg', 100, 1)

		if(!A)	return

		if (!istype(target, /turf))
			del(A)
			return
		A.current = target
		A.yo = target:y - start:y
		A.xo = target:x - start:x
		spawn( 0 )
			A.process()
		return
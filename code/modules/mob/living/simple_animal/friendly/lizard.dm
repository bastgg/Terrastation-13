/mob/living/simple_animal/lizard
	name = "Lizard"
	desc = "A cute tiny lizard."
	icon = 'icons/mob/critter.dmi'
	icon_state = "lizard"
	icon_living = "lizard"
	icon_dead = "lizard-dead"
	small = 1
	speak_emote = list("hisses")
	health = 5
	maxHealth = 5
	attacktext = "bites"
	attacktext = "bites"
	melee_damage_lower = 1
	melee_damage_upper = 2
	response_help  = "pets"
	response_disarm = "shoos"
	response_harm   = "stomps on"
	ventcrawler = 2
	density = 0
	pass_flags = PASSTABLE | PASSMOB
	can_hide = 1
	butcher_results = list(/obj/item/weapon/reagent_containers/food/snacks/meat = 1)
	can_collar = 1

/obj/item/stack/tile/light
	name = "light tile"
	singular_name = "light floor tile"
	desc = "A floor tile, made out off glass. It produces light."
	icon_state = "tile_e"
	w_class = WEIGHT_CLASS_NORMAL
	force = 3
	throwforce = 5
	throw_speed = 5
	throw_range = 20
	max_amount = 60
	attack_verb = list("bashed", "battered", "bludgeoned", "thrashed", "smashed")
	var/on = 1
	var/state //0 = fine, 1 = flickering, 2 = breaking, 3 = broken

/obj/item/stack/tile/light/Initialize(mapload, amount)
	. = ..()
	if(prob(5))
		state = 3 //broken
	else if(prob(5))
		state = 2 //breaking
	else if(prob(10))
		state = 1 //flickering occasionally
	else
		state = 0 //fine

/obj/item/stack/tile/light/attackby(obj/item/I, mob/user, params)
	. = ..()

	if(istype(I, /obj/item/tool/crowbar))
		new /obj/item/stack/sheet/metal(user.loc)
		amount--
		new /obj/item/stack/light_w(user.loc)
		if(amount <= 0)
			user.temporarilyRemoveItemFromInventory(src)
			qdel(src)

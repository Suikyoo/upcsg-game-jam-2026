extends Entity

func on_collide(body: CharacterBody2D):
	if body is Entity:
		var sibling_portal = get_parent().get_children().filter(func(e): return e!=self)[0]
		body.set_global_position(sibling_portal.global_position)	
		
		#body.external_velocity = Vector2(0, 800)

extends Entity


func on_collide(body: CharacterBody2D):
	if body is Entity:
		body.on_death()

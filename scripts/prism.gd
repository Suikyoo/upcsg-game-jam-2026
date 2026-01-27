extends Entity

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	$SpriteStack.rotation_angle += 0.1
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
func on_collide(body: CharacterBody2D):
	$/root/World.on_win()

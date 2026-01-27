extends Entity

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	$SpriteStack.rotation_angle += 0.1
	
func on_collide(body: CharacterBody2D):
	$/root/World.on_win()

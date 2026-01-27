extends Entity

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	var player: Player = get_node_or_null("/root/World/Player")
 	
	
	$SpriteStack.rotation_angle += 0.1
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

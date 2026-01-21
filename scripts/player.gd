extends Entity

class_name Player

func _physics_process(delta: float) -> void:
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	velocity += direction * SPEED
	velocity = velocity.lerp(Vector2.ZERO, 0.7)
	
	super._physics_process(delta)
	
	

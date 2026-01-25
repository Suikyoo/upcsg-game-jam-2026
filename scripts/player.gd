extends Entity

class_name Player

var movement: Vector2 = Vector2.ZERO

func _ready() -> void:
	pass

func _get_draw_pos() -> Vector2:
	var stack: SpriteStack = get_node_or_null("SpriteStack")
	if !stack:
		push_error("no sprite stack in player scene.")
	return stack.global_position
	
func _physics_process(delta: float) -> void:
	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#rotation = lerp_angle(rotation, -world_angle, 0.1)
	super._physics_process(delta)
	
func _move(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	movement = lerp(movement, direction.rotated(-world_angle) * SPEED * delta, 0.2)	
	if movement != velocity:
		var stack: SpriteStack = get_node("SpriteStack")
		if movement != Vector2.ZERO:
			stack.rotation_angle = rotate_toward(stack.rotation_angle, movement.angle(), 0.2)
	velocity += movement
	
func _add_velocity(delta: float) -> void:
	_move(delta)
	super._add_velocity(delta)
	
	

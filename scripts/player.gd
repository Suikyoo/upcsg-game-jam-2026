extends Entity

class_name Player

var movement: Vector2 = Vector2.ZERO

signal body_entered
signal body_exited

func _ready() -> void:
	pass

func _get_draw_pos() -> Vector2:
	var stack: SpriteStack = get_node_or_null("SpriteStack")
	if !stack:
		push_error("no sprite stack in player scene.")
	return stack.global_position
	
func _physics_process(delta: float) -> void:
	#super._physics_process(delta)
	velocity = Vector2.ZERO
	
	add_velocity(delta)
	var collision := move_and_collide(velocity * delta)
	if collision:
		var collider := collision.get_collider()
		if collider is Entity:
			collider.on_collide(self)
	
func _move(delta: float) -> void:
	var direction = Input.get_vector("input_left", "input_right", "input_up", "input_down")
	movement = lerp(movement, direction.rotated(-world_angle) * SPEED * delta, 0.2)	
	if movement != velocity:
		var stack: SpriteStack = get_node("SpriteStack")
		if movement != Vector2.ZERO:
			
			stack.rotation_angle = rotate_toward(stack.rotation_angle, movement.angle() + PI, 0.4)
	velocity += movement
	
func add_velocity(delta: float) -> void:
	_move(delta)
	super.add_velocity(delta)

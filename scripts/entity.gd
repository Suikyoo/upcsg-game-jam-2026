extends CharacterBody2D

class_name Entity

const SPEED = 5000.0
const JUMP_VELOCITY = -400.0

var falling = false
var fall_velocity: Vector2 = Vector2.ZERO

#these are local variables to store global variables fetched in world
var world_angle: float = 0
var world_gravity: Vector2 = Vector2.ZERO

func _on_world_world_flip(angle: float, gravity: Vector2) -> void:
	world_angle = angle
	world_gravity = gravity
	
func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _fall(delta: float) -> void:
	# Add the gravity.
	if falling:
		fall_velocity += world_gravity * delta
	else:
		fall_velocity = Vector2.ZERO
		
	velocity += fall_velocity
	
func _add_velocity(delta: float) -> void:
	_fall(delta)
	
func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	
	_add_velocity(delta)
	
	position += velocity * delta
	#move_and_slide()

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		pass

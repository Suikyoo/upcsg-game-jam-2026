extends CharacterBody2D

class_name Entity

const SPEED = 800.0
const JUMP_VELOCITY = -400.0

var falling = false

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	
func _physics_process(delta: float) -> void:
	print(falling)
	# Add the gravity.
	if falling:
		velocity += get_gravity() * delta

	move_and_slide()

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		pass

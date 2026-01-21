extends Node2D

@export var world_angle: float = 0

const gravity_value = 10
var world_gravity: Vector2 = Vector2(0, 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	const rot_scalar: float = PI/2
	
	if Input.is_action_just_pressed("change_perspective"):
		world_angle += rot_scalar
		world_gravity = Vector2.from_angle(world_angle + PI/2) * gravity_value
		

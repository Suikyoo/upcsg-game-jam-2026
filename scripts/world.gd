extends Node2D


@export var world_angle: float = 0

signal world_flip(angle: float, gravity: Vector2)

const gravity_value = 800
var world_gravity: Vector2 = Vector2(0, 1) * gravity_value
var target_angle: float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	world_flip.emit(target_angle, world_gravity)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	const rot_scalar: float = PI/2
	
	if Input.is_action_just_pressed("change_perspective"):
		target_angle += rot_scalar
		world_gravity = Vector2.from_angle(target_angle - PI/2) * Vector2(1, -1) * gravity_value
		world_flip.emit(target_angle, world_gravity)
		
	world_angle = lerp_angle(world_angle, target_angle, 0.4)

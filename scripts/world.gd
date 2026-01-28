extends Node2D

#The root of the game, can be thought of as an entire level of the game

const gravity_value = 800

#these variable trickle down into the child node for their own specific uses
#these are the global variables that change in the world during the game
var world_gravity: Vector2 = Vector2(0, 1) * gravity_value
@export var world_angle: float = 0

#used for smooth interpolation
var target_angle: float = 0

#emits after whenever the perspective is changed
signal world_flip(angle: float, gravity: Vector2)

func _ready() -> void:
	world_flip.emit(target_angle, world_gravity)
	
func _process(delta: float) -> void:
	const rot_scalar: float = PI/2
	
	if Input.is_action_just_pressed("anti-rotate"):
		target_angle -= rot_scalar
		world_gravity = Vector2.from_angle(target_angle - PI/2) * Vector2(1, -1) * gravity_value
		world_flip.emit(target_angle, world_gravity)		
	
	if Input.is_action_just_pressed("pro-rotate"):
		target_angle += rot_scalar
		world_gravity = Vector2.from_angle(target_angle - PI/2) * Vector2(1, -1) * gravity_value
		world_flip.emit(target_angle, world_gravity)
		
	world_angle = lerp_angle(world_angle, target_angle, 0.4)
	

func on_win():
	get_tree().change_scene_to_file("res://scenes/win.tscn")

func on_lose():
	get_tree().change_scene_to_file("res://scenes/lose.tscn")

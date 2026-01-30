extends Node2D

#The root of the game, can be thought of as an entire level of the game

const gravity_value = 800

#these variable trickle down into the child node for their own specific uses
#these are the global variables that change in the world during the game
var world_gravity: Vector2 = Vector2(0, 1) * gravity_value
@export var world_angle: float = 0

#used for smooth interpolation
var target_angle: float = 0

@export var bg_color: Color = Color("#0a3045")

var folder_path: String
var level_id: int

var game_state: int = -1

var darkness: float = 1
var target_darkness: float = 0

#emits after whenever the perspective is changed
signal world_flip(angle: float, gravity: Vector2)

func _ready() -> void:
	var path := get_tree().current_scene.scene_file_path.rsplit('/', false, 1)
	folder_path = path[0]
	level_id = int(path[1].split(".")[0])
	print(level_id)
	world_flip.emit(target_angle, world_gravity)
	var offset := -world_gravity.normalized() * 2
	#$Canvas.material.set_shader_parameter("outline_offset", offset)
	$"Camera2D/ColorRect".set_color(bg_color)
	$SubViewport.size = $Canvas.size
	
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

	darkness = move_toward(darkness, target_darkness, 0.01)
	
	$"Camera2D/Filter".material.set_shader_parameter("darkness", darkness)
	
	if darkness >= 0.99:
		on_end()
		
func on_end():
	if game_state == 1:
		advance()
	elif game_state == 0:
		restart()
		
func on_win():
	game_state = 1
	target_darkness = 1
	
func on_lose():
	game_state = 0
	target_darkness = 1

func advance():
	var next_level := folder_path + "/" + "%02d" % (level_id + 1) + ".tscn"
	var resource := ResourceLoader.load(next_level)
	if !resource:
		next_level = "res://scenes/win.tscn"
		
	get_tree().change_scene_to_file(next_level)

func restart():
	get_tree().reload_current_scene()

	

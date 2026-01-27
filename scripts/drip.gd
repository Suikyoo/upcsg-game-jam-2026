extends Node2D

var world_gravity: Vector2 = Vector2.ZERO
var prev_cell: Vector2i

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position += world_gravity * delta * 0.05
	
	var map: TileMapLayer = get_parent()
	var ground: Area2D = get_parent().get_parent()
	if !map or !ground:
		push_error("drip object must be a child of tilemaplayer and a grandchild of ground.")
		
	var cell := map.local_to_map(map.to_local(global_position))
		
	if cell != prev_cell:
		map.set_cell(prev_cell, 2, Vector2(1, 1))
		ground.add_collision(prev_cell)

	prev_cell = cell
		
	var alt_flag: int = 0
	
	match (world_gravity.normalized()):
		Vector2.DOWN:
			alt_flag ^= TileSetAtlasSource.TRANSFORM_TRANSPOSE
			alt_flag ^= TileSetAtlasSource.TRANSFORM_FLIP_V
		Vector2.RIGHT: 
			alt_flag ^= TileSetAtlasSource.TRANSFORM_FLIP_H
		Vector2.UP * Vector2(-1., 1):
			alt_flag ^= TileSetAtlasSource.TRANSFORM_TRANSPOSE
		Vector2.LEFT:
			pass
			
	map.set_cell(cell, 1, Vector2i(0, 0), alt_flag)
	#ground.add_collision(cell)

func _on_world_world_flip(angle: float, gravity: Vector2) -> void:
	world_gravity = gravity

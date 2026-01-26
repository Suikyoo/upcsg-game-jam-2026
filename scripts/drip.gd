extends Node2D

var world_gravity: Vector2 = Vector2.ZERO

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
	print(world_gravity)
	ground.add_collision(cell)
	map.set_cell(cell, 1, Vector2i(0, 0))

	
func _on_world_world_flip(angle: float, gravity: Vector2) -> void:
	world_gravity = gravity

extends Node2D

# drip is an invisible object that moves during the game. 
# Wherever it moves, it sets the TileMapLayer's cell to a certain tile
# Specifically, it sets the current tile as a "dripping tile" and its previous paths as "filled tile"

var world_gravity: Vector2 = Vector2.ZERO
var prev_cell: Vector2i

func _process(delta: float) -> void:
	#move the object
	position += world_gravity * delta * 0.012
	
	#fetching external objects
	var map: TileMapLayer = get_parent()
	var ground: Area2D = get_parent().get_parent()
	if !map or !ground:
		push_error("drip object must be a child of tilemaplayer and a grandchild of ground.")
		
	#from the object's position, find where on the TileMapLayer's coordinates it belongs.
	#The TileMapLayer's coordinate is known as a Cell. Note that TileMapLayer is Godot-native
	var cell := map.local_to_map(map.to_local(global_position))
		
	#if the object's position has moved to another cell coordinate, 
	#we set the previous one to a filled tile. The current one stays to become a "dripping tile"
	if cell != prev_cell:
		#iirc, the cell that I used for this is located at source_id = 2, at atlas coords(1, 1)
		#atlas coords is the tileset coordinates. Different from the TileMapLayer's coordinates.
		map.set_cell(prev_cell, 2, Vector2(1, 1))
		#every time a "filled tile" is set and drawn, 
		#we add it's preconfigured collision to the Ground (Area2D) object
		ground.add_collision(prev_cell)
		prev_cell = cell
	
	
	#due to godot's fcked up way of doing rotations for tilesets, 
	#we need to use blitflags to rotate them
	#by using OR (+) operations
	var alt_flag: int = 0
	
	var direction = Vector2(Vector2i(world_gravity.normalized()))
	match (direction):
		Vector2.DOWN:
			alt_flag ^= TileSetAtlasSource.TRANSFORM_TRANSPOSE
			alt_flag ^= TileSetAtlasSource.TRANSFORM_FLIP_V
		Vector2.RIGHT: 
			alt_flag ^= TileSetAtlasSource.TRANSFORM_FLIP_H
		Vector2.UP:
			alt_flag ^= TileSetAtlasSource.TRANSFORM_TRANSPOSE
		Vector2.LEFT:
			pass
	
	#at this point, we are setting this current cell coordinate
	#to render the dripping tile in a certain way(rotated)
	map.set_cell(cell, 1, Vector2i(0, 0), alt_flag)
	#ground.add_collision(cell)

func _on_world_world_flip(angle: float, gravity: Vector2) -> void:
	world_gravity = gravity

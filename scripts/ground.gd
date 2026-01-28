@tool
extends Area2D

#Ground is an Area2D mainly used for managing the TileMapLayer's collision.
#Instead of physically colliding with the TileMap, we take all the collision data 
#and transfer it over to its parent node, Ground (Area2D).
#this way, we don't end up colliding with the tilemap. 
#Rather, we are able to detect when any entity enters or leaves the Area2D's jurisdiction of multiple collision tiles.

const TILE_SIZE: Vector2i = Vector2i(16, 16)
var world_angle: float = 0

@export_tool_button("generate collision") var button_func: Callable = func():
	generate_collisions()
@export_tool_button("remove collision") var button_func_0: Callable = func():
	remove_collisions()

#removes all collisions, is not triggered at runtime and is rather used in creating the tilemap for a level.
func remove_collisions():
	for i in get_children():
		if i is CollisionPolygon2D:
			remove_child(i)

#only triggers once when loading the level. Also used in creating the tilemap for a level.
func generate_collisions():
	
	var tile_map: TileMapLayer = get_node_or_null("TileMapLayer")
	if !tile_map:
		return
	
	var cells := tile_map.get_used_cells()
	for c in cells:
		add_collision(c)

#Adds collision given a cell coordinate. Primarily used by Drip object
func add_collision(c: Vector2) -> void:
	var src_id: int = $TileMapLayer.get_cell_source_id(c)
	if src_id == -1:
		return
			
	var points := Array($TileMapLayer.get_cell_tile_data(c).get_collision_polygon_points(0, 0))
	points = points.map(func(e): return $TileMapLayer.map_to_local(c) + e)
	var polygon := CollisionPolygon2D.new()
	polygon.set_polygon(points)
	polygon.set_visible(true)
	add_child(polygon)
	
func _ready() -> void:
	generate_collisions()

func _physics_process(delta: float) -> void:
	# tiresome fetching
	var world_node: Node2D = get_node_or_null("/root/World")
	if !world_node:
		return
		
	var angle: float = world_node.get("world_angle")
	if !angle:
		return
	
	var map: TileMapLayer = get_node_or_null("TileMapLayer")
	if !map:
		return
	
	#rotates the map but not the collisions. (Visual effect only)
	map.global_position = GlobalFuncts.world_transform(get_parent().global_position, angle)
	map.rotation = angle

#This is a configuration warning but I don't even think this works
func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	
	const required_nodes = ["TileMapLayer"]
	for node in required_nodes:
		if not has_node(node):
			warnings.append("Missing required node: " + node)
	return warnings
	
#if any entity enters Ground, falling state would be deactivated
func _on_body_entered(body: Node2D) -> void:
	if body is Entity:
		body.falling = false

#when exiting, falling state of an entity reactivates
func _on_body_exited(body: Node2D) -> void:
	if body is Entity:
		body.falling = true	

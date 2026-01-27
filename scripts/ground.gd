@tool
extends Area2D

var world_angle: float = 0
@export_tool_button("generate collision") var button_func: Callable = func():
	_generate_collision()
@export_tool_button("remove collision") var button_func_0: Callable = func():
	_remove_collision()
	
func _remove_collision():
	for i in get_children():
		if i is CollisionPolygon2D:
			remove_child(i)
			
func _generate_collision():
	
	var tile_map: TileMapLayer = get_node_or_null("TileMapLayer")
	if !tile_map:
		return
	
	var cells := tile_map.get_used_cells()
	for c in cells:
		add_collision(c)

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
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_generate_collision()
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass #area_entered
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var world_node: Node2D = get_node_or_null("/root/World")
	if !world_node:
		return
		
	var angle: float = world_node.get("world_angle")
	if !angle:
		return
	
	var map: TileMapLayer = get_node_or_null("TileMapLayer")
	if !map:
		return
		
	map.global_position = GlobalFuncts.world_transform(get_parent().global_position, angle)
	map.rotation = angle
	
func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	
	const required_nodes = ["TileMapLayer"]
	for node in required_nodes:
		if not has_node(node):
			warnings.append("Missing required node: " + node)
	return warnings
	
func _on_body_entered(body: Node2D) -> void:
	print(body)
	if body is Entity:
		body.velocity = Vector2.ZERO
		body.falling = false
		
func _on_body_exited(body: Node2D) -> void:
	print(body)
	if body is Entity:
		body.falling = true	

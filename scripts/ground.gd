extends Area2D

var world_angle: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
			warnings.append("Missing required node: {}".format(node))
	return warnings
	
func _on_body_entered(body: Node2D) -> void:
	if body is Entity:
		body.velocity = Vector2.ZERO
		body.falling = false
		print("catched")
	
func _on_body_exited(body: Node2D) -> void:
	if body is Entity:
		body.falling = true
		print("fell")
	

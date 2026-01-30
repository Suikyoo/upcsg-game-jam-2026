extends Entity

# drip is an invisible object that moves during the game. 
# Wherever it moves, it sets the TileMapLayer's cell to a certain tile
# Specifically, it sets the current tile as a "dripping tile" and its previous paths as "filled tile"
signal new_tile_entered
var max_drip: int = -1
func fall(delta: float) -> void:
	fall_velocity = world_gravity * 0.2
	
func _process(delta: float) -> void:
	#move the object
	position += world_gravity * delta * 0.1
	
	#fetching external objects
	var map: TileMapLayer = get_node_or_null("/root/World/Ground/TileMapLayer")
	var ground: Area2D = map.get_parent()

	var cell := map.local_to_map(map.to_local(global_position))
	
	if cell not in map.get_used_cells():
		map.set_cell(cell, 3, Vector2(3, 0))
		ground.add_collision(cell)
		new_tile_entered.emit()
	
	var sprite: Sprite2D = get_node_or_null("../SubViewport/Sprite2D")
	if !sprite:
		return
	
	var canvas: TextureRect = get_node_or_null("../Canvas")
		
	sprite.position = global_position - canvas.global_position
	sprite.scale = Vector2(0.5, 0.5)
	sprite.rotation += cos(Time.get_ticks_msec()) * 5
	
	if max_drip == 0:
		queue_free()
		
func _on_world_world_flip(angle: float, gravity: Vector2) -> void:
	super._on_world_world_flip(angle, gravity)


func _on_new_tile_entered() -> void:
	if max_drip > 0:
		max_drip -= 1
		

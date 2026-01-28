extends Area2D

const offset: int = 300
func _ready() -> void:
	var tilemap: TileMapLayer = get_node_or_null("/root/World/Ground/TileMapLayer")
	if !tilemap:
		return
	
	var rect = tilemap.get_used_rect()
	rect.position *= Vector2i(tilemap.get_parent().TILE_SIZE)
	rect.size *= Vector2i(tilemap.get_parent().TILE_SIZE)
	rect.position += Vector2i(tilemap.get_parent().position)
	
	rect = rect.grow(offset)
	var collision_shape = CollisionShape2D.new()
	set_position(rect.position + rect.size/2)
	collision_shape.shape = RectangleShape2D.new()
	collision_shape.shape.set_size(Vector2i(rect.size))
	add_child(collision_shape)

func _on_body_exited(body: Node2D) -> void:
	if body is Entity:
		body.on_death()

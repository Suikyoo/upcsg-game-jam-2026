extends Entity

var drip_scene: PackedScene = preload("res://scenes/drip.tscn")

var drips_remaining: int = 5
func _ready() -> void:
	get_parent().connect("world_flip", Callable(self, "_on_world_world_flip"))
func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	
	add_velocity(delta)
	
	#this is where the player collides with every other entity
	var collision := move_and_collide(velocity * delta)

	if collision:
		var collider := collision.get_collider()
		if collider is Entity:
			var map: TileMapLayer = get_node_or_null("/root/World/Ground/TileMapLayer")
			if !map:
				return
			var drip: Entity = drip_scene.instantiate()
			
			drip.position = position
			drip.world_gravity = world_gravity
			drip.max_drip = 5
			get_parent().connect("world_flip", Callable(drip, "_on_world_world_flip"))
			drip.connect("new_tile_entered", Callable(self, "_drip_on_new_tile_entered"))
			get_parent().add_child(drip)
			queue_free()
			
func _drip_on_new_tile_entered():
	pass

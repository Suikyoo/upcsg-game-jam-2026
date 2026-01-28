extends Entity


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	input_pickable = true

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	
	add_velocity(delta)
	
	#this is where the player collides with every other entity
	var collision := move_and_collide(velocity * delta)
	if collision:
		var collider := collision.get_collider()
		print(collider)

		if collider is TileMapLayer:
			var map: TileMapLayer = get_node_or_null("/root/World/Ground/TileMapLayer")
			if !map:
				return
			var cell := map.local_to_map(map.to_local($SpriteStack.global_position))
			cell -= Vector2i(1, 1)
			for y in range(3):
				for x in range(3):
					print(cell + Vector2i(x, y))
					map.set_cell(cell + Vector2i(x, y), 2, Vector2(1, 1))
			queue_free()
			

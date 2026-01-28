extends Camera2D

const zoom_factor: float = 0.1
const zoom_vec: Vector2 = Vector2(zoom_factor, zoom_factor)

func _process(delta: float) -> void:
	
	var player: Player = get_node("../Player")
	if !player:
		push_error("Player not detected as parent.")
	
	global_position = player.get_draw_pos()
	
	#rotation = 0
	

func _unhandled_input(event: InputEvent) -> void:
	const lerp_weight: float = 0.1
	
	# Zooming is ugly but it works
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			self.zoom = lerp(self.zoom, self.zoom +self.zoom_vec, lerp_weight)
			
			
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			self.zoom = lerp(self.zoom, self.zoom -self.zoom_vec, lerp_weight)

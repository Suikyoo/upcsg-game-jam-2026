extends Camera2D

const zoom_factor: float = 0.1

func _process(delta: float) -> void:
	
	var player: Player = get_node("../Player")
	if !player:
		push_error("Player not detected as parent.")
	
	global_position = player.get_draw_pos()
	
	#rotation = 0
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			self.zoom += Vector2(zoom_factor, zoom_factor)
			
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			self.zoom -= Vector2(zoom_factor, zoom_factor)

extends Camera2D

const zoom_factor: float = 0.5
const zoom_min: float = 0.35
const zoom_max: float = 2.25

func _process(delta: float) -> void:
	
	var player: Player = get_node("../Player")
	if !player:
		push_error("Player not detected as parent.")
	
	global_position = global_position.lerp(player.get_draw_pos(), 0.2)
	
	#rotation = 0
	

func _unhandled_input(event: InputEvent) -> void:
	const lerp_weight: float = 0.1
	
	# Zooming is ugly but it works
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			var prev: float = self.zoom.x
			var next: float = lerp(prev, min(zoom_max, prev +zoom_factor), lerp_weight)
			print(next)
			self.zoom = Vector2(next, next)
			
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			var prev: float = self.zoom.x
			var next: float = lerp(prev, max(zoom_min, prev -zoom_factor), lerp_weight)
			print(next)
			self.zoom = Vector2(next, next)

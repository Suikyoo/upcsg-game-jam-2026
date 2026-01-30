extends Camera2D

const zoom_factor: float = 0.5
const zoom_min: float = 0.35
const zoom_max: float = 2.25

var chase_position: Vector2;
var quake: float;

func _process(delta: float) -> void:
	var player: Player = get_node("../Player")
	if !player:
		push_error("Player not detected as parent.")
		
	chase_position = chase_position.lerp(player.get_draw_pos(), 0.08)
	quake = lerp(quake, 0., 0.08)
	var offset = Vector2((randf() * 2 - 1) * quake, (randf() * 2 - 1) * quake)
	global_position = chase_position + offset
	
	rotation = -get_parent().world_angle
	

func _unhandled_input(event: InputEvent) -> void:
	const lerp_weight: float = 0.1
	scale = Vector2.ONE / zoom

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

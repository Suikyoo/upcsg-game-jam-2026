extends Camera2D

const zoom_min: float = 1
const zoom_max: float = 2.75
const zoom_stages = [1, 1.75, 2.75]
var zoom_index: int = 1

var chase_position: Vector2;
var quake: float;
var label: Label;

func _ready() -> void:
	label = Label.new()
	label.add_theme_font_size_override("default_font", 200)
	label.z_index = 999
	label.label_settings = LabelSettings.new()
	label.label_settings.font = load("res://assets/alagard.ttf")
	label.label_settings.font_size = 50
	label.position -= Vector2(80, 150)
	add_child(label)
	
	$ColorRect.material = ShaderMaterial.new()
	$ColorRect.material.shader = load("res://shaders/bg.gdshader")
	print(get_parent().bg_color)
	$ColorRect.material.set_shader_parameter("stripe_color", get_parent().bg_color)
	$ColorRect.material.set_shader_parameter("background_color", Color.BLACK)

func _process(delta: float) -> void:
	label.text = "Level %d" % ($"/root/World".level_id)

	label.modulate.a = lerp(label.modulate.a, 0., 0.01)
	
	var player: Player = get_node("../Player")
	if !player:
		push_error("Player not detected as parent.")
		return
		
	chase_position = chase_position.lerp(player.get_draw_pos(), 0.08)
	quake = lerp(quake, 0., 0.08)
	var offset = Vector2((randf() * 2 - 1) * quake, (randf() * 2 - 1) * quake)
	global_position = chase_position + offset
	
	rotation = -get_parent().world_angle
	
	if Input.is_action_just_pressed("zoom_toggle"):
		zoom_index = (zoom_index + 1) % len(zoom_stages)
			
	zoom = zoom.lerp(Vector2(zoom_stages[zoom_index], zoom_stages[zoom_index]), 0.1)
#func _unhandled_input(event: InputEvent) -> void:
	#const lerp_weight: float = 0.1
	#scale = Vector2.ONE / zoom
#
	## Zooming is ugly but it works
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			#var prev: float = self.zoom.x
			#var next: float = lerp(prev, min(zoom_max, prev +zoom_factor), lerp_weight)
			#print(next)
			#self.zoom = Vector2(next, next)
			#
		#if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			#var prev: float = self.zoom.x
			#var next: float = lerp(prev, max(zoom_min, prev -zoom_factor), lerp_weight)
			#print(next)
			#self.zoom = Vector2(next, next)

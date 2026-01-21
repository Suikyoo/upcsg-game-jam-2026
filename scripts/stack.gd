@tool
extends Node2D

@export var texture: Texture2D
@export var hframes: int = 9
@export var vertical_spacing: int = 1
@export_tool_button("Stack Sprite") var _button_func: Callable = func():
	_stack_sprites()

# local
var rot_angle: float = 0
func _stack_sprites() -> void:
	if texture == null:
		push_warning("no texture set")
		return 
		
	for child in get_children():
		child.queue_free()
		
	for i in range(hframes):
		var sprite: Sprite2D = Sprite2D.new()
		sprite.texture = texture
		sprite.hframes = hframes
		sprite.frame = i
		sprite.position.y = -i * vertical_spacing
		add_child(sprite)

# sets the angle
func set_sprite_rotation(angle: float):
	for sprite in get_children():
		sprite.rotation_degrees = angle
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_stack_sprites()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var world_node: Node2D = get_node_or_null("/root/World")	

	if world_node:
		var target_angle: float = world_node.get("world_angle")
		rot_angle = lerp(rot_angle, target_angle, .3)
		
		var player_node: CharacterBody2D = get_node_or_null("/root/World/Player")
		if player_node:
			var player_position: Vector2 = player_node.global_position
			
			global_position = Vector2(get_parent().global_position - player_position).rotated(rot_angle)
			
			for child in get_children():
				if child is Sprite2D:
					child.rotation = rot_angle
			#position = Vector2(origin_position - player_position).rotated(rot_angle)

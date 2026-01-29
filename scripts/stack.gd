@tool
extends Node2D

#The visual aspect of an entity, a sprite stack

class_name SpriteStack

#the spritesheet
@export var texture: Texture2D
#number of stacks
@export var hframes: int = 9
#how much vertical spacing per stack
@export var vertical_gap: int = 1
#rotation for all stacks
@export var rotation_angle: float = 0

#this tool button is quite useful when creating entities and configuring its sprite stack
#this is only run once and is also used when designing entities and their sprite stacks
@export_tool_button("Stack Sprite") var _button_func: Callable = func():
	stack_sprites()

func stack_sprites() -> void:
	if texture == null:
		push_warning("no texture set")
		return 
		
	for child in get_children():
		child.queue_free()
		
	for i in range(hframes):
		var sprite: Sprite2D = Sprite2D.new()
		sprite.texture = texture
		sprite.hframes = hframes
		sprite.rotation = rotation_angle
		sprite.frame = i
		sprite.position.y = -i * vertical_gap
		sprite.set_use_parent_material(true)
		add_child(sprite)

func _ready() -> void:
	stack_sprites()

func _process(delta: float) -> void:
	
	var world_node: Node2D = get_node_or_null("/root/World")
	if !world_node:
		return
		
	var angle: float = world_node.get("world_angle")
	
	var player: Player = get_node_or_null("/root/World/Player")
	
	#if angle != 0:
		#global_position = GlobalFuncts.world_transform(get_parent().global_position, angle)
	global_rotation = -angle
	rotate_stack(angle + rotation_angle)

func rotate_stack(angle: float):
	for child in get_children():
		if child is Sprite2D:
			child.rotation = angle

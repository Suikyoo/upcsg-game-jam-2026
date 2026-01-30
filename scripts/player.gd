extends Entity

class_name Player

var drip_scene: PackedScene = load("res://scenes/drip.tscn")
var current_drip: Entity

const SPEED = 5000.0

var movement: Vector2 = Vector2.ZERO
var hold: bool = false

@export var health = 20
var max_health = health

func _ready() -> void:
	$Health.max_value = health
	$Health.curr_value = health

#this is mainly used by the Camera2d to get the player's coordinates and track it
func get_draw_pos() -> Vector2:
	var stack: SpriteStack = get_node_or_null("SpriteStack")
	if !stack:
		push_error("no sprite stack in player scene.")
	return stack.global_position
	
func _physics_process(delta: float) -> void:
	#super._physics_process(delta)
	velocity = Vector2.ZERO
	
	add_velocity(delta)
	
	#this is where the player collides with every other entity
	var collision := move_and_collide(velocity * delta)
	if collision:
		var collider := collision.get_collider()
		if collider is Entity:
			collider.on_collide(self)
	
	$Health.rotation = rotate_toward($Health.rotation, -world_angle, 0.2)
func _move(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		
		hold = true
		current_drip = drip_scene.instantiate()
		
		current_drip.position = position
		current_drip.world_gravity = world_gravity
		
		get_parent().connect("world_flip", Callable(current_drip, "_on_world_world_flip"))
		current_drip.connect("new_tile_entered", Callable(self, "_drip_on_new_tile_entered"))
		get_parent().add_child(current_drip)
		
		$"/root/World/MusicController".play("Charge")
		
	elif Input.is_action_just_released("ui_accept"):
		hold = false
		if current_drip:
			current_drip.queue_free()
		current_drip = null
		
		$"/root/World/MusicController".stop("Charge")



	if hold:
		$"../Camera2D".quake = 4;
		return
		
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	movement = lerp(movement, direction.rotated(-world_angle) * SPEED * delta, 0.2)	
	var stack: SpriteStack = get_node("SpriteStack")
	if movement != Vector2.ZERO:
		stack.rotation_angle = rotate_toward(stack.rotation_angle, movement.angle() + PI, 0.4)
	velocity += movement
	
func _process(delta: float) -> void:
	super._process(delta)
	
	if health <= 0:
		on_death()
	
	$"../Camera2D/Filter".material.set_shader_parameter("danger", 1 - health/max_health)
		
func add_velocity(delta: float) -> void:
	_move(delta)
	super.add_velocity(delta)

func on_death() -> void:
	$"/root/World".on_lose()
	queue_free()

func _drip_on_new_tile_entered():
	update_health(-5)	
	
func update_health(offset_value: int) -> void:
	health = clamp(health + offset_value, 0, max_health)
	$Health.curr_value = health

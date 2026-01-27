extends CharacterBody2D

#Entity is the base class for all objects that use SpriteStack
#You can consider this a wrapper for the SpriteStack object

#objects like Player, Prism, etc. inherit from this

class_name Entity

#all entities are affected by gravity 
#this is done primarily through the falling state
#if falling state is true, gravity takes effect in the direction it intends
var falling = false
var fall_velocity: Vector2 = Vector2.ZERO

#these are local variables to store global variables fetched in world
var world_angle: float = 0
var world_gravity: Vector2 = Vector2.ZERO

func _on_world_world_flip(angle: float, gravity: Vector2) -> void:
	world_angle = angle
	world_gravity = gravity
	
func fall(delta: float) -> void:
	# Add the gravity.
	if falling:
		fall_velocity += world_gravity * delta
	else:
		fall_velocity = Vector2.ZERO
		
	velocity += fall_velocity
	
func add_velocity(delta: float) -> void:
	fall(delta)
	
func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	
	add_velocity(delta)
	move_and_slide()

#this function is used by inheriting objects. 
#the body in the argument is primarily the Player object.
#this function triggers when the player collides with the entity.
func on_collide(body: CharacterBody2D):
	pass

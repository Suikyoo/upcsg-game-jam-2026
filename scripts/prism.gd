extends Entity

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	$SpriteStack.rotation_angle += 0.1
	
func on_collide(body: CharacterBody2D):
	$/root/World.on_win()
	$/root/World/Camera2D.quake = 5
	$"/root/World/MusicController".play("Win")

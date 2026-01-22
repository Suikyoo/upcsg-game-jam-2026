extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var player: Player = get_node("../Player")
	if !player:
		push_error("Player not detected as parent.")
	
	global_position = player._get_draw_pos()
	#rotation = 0
	

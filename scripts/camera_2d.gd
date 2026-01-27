extends Camera2D

func _process(delta: float) -> void:
	
	var player: Player = get_node("../Player")
	if !player:
		push_error("Player not detected as parent.")
	
	global_position = player.get_draw_pos()
	#rotation = 0
	

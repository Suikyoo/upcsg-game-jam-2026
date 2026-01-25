extends TileMapLayer

@export var tileset_sources: Array[TileSetAtlasSource] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var world = get_node_or_null("/root/World")
	if !world:
		return
	
	var world_angle = world.world_angle
	for i in get_children():
		i.rotation = world_angle
		


func _on_changed() -> void:
	for i in get_children():
		if i is TileMapLayer:
			var cells := get_used_cells()
			for cell in cells:
				var src_id = get_cell_source_id(cell)
				i.set_cell(cell, src_id)
			

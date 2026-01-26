extends Node2D

#drip is essentially a collision shape generator for its parent

var origin := position
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var poly: CollisionPolygon2D = get_node_or_null("CollisionPolygon2D")
	if !poly:
		push_warning("drip: no associated collision polygon")
	
	var group_name := "drip_%d_path" % get_index()
	if get_tree().has_group(group_name):
		var polygon: CollisionPolygon2D = get_tree().get_first_node_in_group(group_name)
		var new_poly_points := Geometry2D.merge_polygons(polygon.polygon, poly.polygon)
		polygon.set_polygon(new_poly_points)
	
	else:
		poly.add_to_group(group_name)
	
func _on_world_world_flip(angle: float, gravity: Vector2) -> void:
	pass

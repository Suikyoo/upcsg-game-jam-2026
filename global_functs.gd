extends Node

#this is where I'm supposed to keep my global functions and variables
#kinda like util functions in a sense?

#position of current entity body to be rotated, rotation angle
func world_transform(pos: Vector2, angle: float) -> Vector2:
	var player_node: CharacterBody2D = get_node_or_null("/root/World/Player")
	if !player_node:
		return pos
		
	var player_position := player_node.global_position
	var new_pos := Vector2(pos - player_position).rotated(angle)
	return new_pos

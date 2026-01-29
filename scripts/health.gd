extends Control

@export var max_value: int = 50
@export var curr_value: int = 50
@export var outline_color: Color
@export var fill_color: Color

func _ready() -> void:
	var container: ColorRect = ColorRect.new()
	container.color = outline_color
	container.size.x = max_value + 2
	container.size.y = 6
	add_child(container)
	var bar: ColorRect = ColorRect.new()
	bar.color = fill_color
	bar.position = Vector2(1, 1)
	bar.size = Vector2(curr_value, 4)
	container.add_child(bar)

func _process(delta: float) -> void:
	var container: ColorRect = get_child(0)
	var bar: ColorRect = container.get_child(0)
	container.size.x = max_value + 2
	bar.size.x = curr_value
	

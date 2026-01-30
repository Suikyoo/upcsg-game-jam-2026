extends Node2D

const data = ["Dialogue", "Landing", "Falling", "Win", "Charge", "Music"]
var prev_time: int = 0
func _ready() -> void:
	get_child(data.find("Music")).autoplay = true
	play("Music")

func _process(delta: float) -> void:
	var current_time := Time.get_ticks_msec() 
	if current_time - prev_time > 5000:
		prev_time = current_time
		
		if randf() > 0.5:
			play("Dialogue")
			
func play(name: String):
	var index := data.find(name)
	if index == -1:
		return
	if !get_child(index).playing:
		get_child(index).play()

func stop(name: String):
	var index := data.find(name)
	if index == -1:
		return
	
	if get_child(index).playing:
		get_child(index).stop()

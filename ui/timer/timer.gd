extends Label

var time: int 

	
func _process(delta: float) -> void:
	time = int(GlobalSignals.timer.time_left)
	text = str(time)

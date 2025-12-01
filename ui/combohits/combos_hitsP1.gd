extends Label

var time_hited: int 
var time_hited_old: int
@onready var x = $"../X"

func _ready() -> void:
	GlobalSignals.timer2.connect("timeout", clear)
	clear()

var last_value = null

func _process(delta):
	var v = GlobalSignals.hit_times_p2

	if v != last_value:
		last_value = v

		if v == 0:
			text = str(time_hited_old)
			visible = true
			x.visible = true
			GlobalSignals.timer2.start(2.5)
		if v > 0:
			text = str(v)
			time_hited_old = v
			visible = true
			x.visible = true
		
func clear():
	visible = false
	x.visible = false
	

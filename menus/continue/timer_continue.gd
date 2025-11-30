extends Label

@onready var timer: Timer = $"../counter"

func _ready() -> void:
	timer.start(10)
	timer.connect("timeout", go_main_menu)

func _process(delta: float) -> void:
	
	var time: int = int(timer.time_left)
	text = str(time)
	
	if Input.is_action_just_pressed("p1_start") or Input.is_action_just_pressed("p2_start"):
		on_start()
	
	if Input.is_action_just_pressed("p1_back") or Input.is_action_just_pressed("p2_back"):
		go_main_menu()

func go_main_menu() -> void:
	pass
	
func on_start() -> void:
	pass
	
	

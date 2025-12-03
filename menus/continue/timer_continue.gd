extends Label

@onready var timer: Timer = $"../counter"
@onready var counter: AudioStreamPlayer = $"../countingdown"

var main_menu_path = "res://menus/main_menu/control.tscn"
var fight_path

func start_tine() -> void:
	timer.start(9)
	
func _ready() -> void:
	start_tine()
	timer.connect("timeout", go_main_menu)

func _process(delta: float) -> void:
	
	var time: int = int(timer.time_left)
	text = str(time)
	
	if Input.is_action_just_pressed("p1_start") or Input.is_action_just_pressed("p2_start"):
		on_start()
	
	if Input.is_action_just_pressed("p1_back") or Input.is_action_just_pressed("p2_back"):
		go_main_menu()

func go_main_menu() -> void:
	get_tree().change_scene_to_file(main_menu_path)
	pass
	
func on_start() -> void:
	GameState.select_map(GameState.map_chice)
	pass
	

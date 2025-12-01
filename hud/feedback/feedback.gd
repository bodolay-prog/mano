class_name Feedback
extends Label

var fight_: bool = false

var _text

func clear() -> void:
	visible = false

func _ready() -> void:
	visible = false
	are_ready()
	GlobalSignals.timer3.connect("timeout", clear)
	
func _process(delta: float) -> void:
	text = _text

func are_ready() -> void:
	
	visible = true
	_text = "READY?"
	
func fight() -> void:
	
	if !fight_:
		fight_ = true
		GlobalSignals.timer3.start(1.5)
		visible = true
		_text = "FIGHT!"
	
func p1_wins() -> void:
	visible = true
	_text = "P1 WINS!"
	
func p2_wins() -> void:
	visible = true
	_text = "P2 WINS!"

func on_draw() -> void:
	visible = true
	_text = "DRAW"

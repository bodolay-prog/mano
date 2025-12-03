class_name Feedback
extends Label

var fight_: bool = false

@onready var ready_: AudioStreamPlayer = $"../sfxs/ready?"
@onready var _fight: AudioStreamPlayer = $"../sfxs/fight"
@onready var youwin: AudioStreamPlayer = $"../sfxs/you win"
@onready var draw_game: AudioStreamPlayer = $"../sfxs/draw"


var _text

func clear() -> void:
	visible = false

func _ready() -> void:
	await GlobalSignals.timer4.timeout
	visible = false
	are_ready()
	
func _process(delta: float) -> void:
	text = _text

func are_ready() -> void:
	
	visible = true
	_text = "READY?"
	ready_.play()
	await ready_.finished
	fight()
	
func fight() -> void:
	
	if !fight_:
		fight_ = true
		visible = true
		_text = "FIGHT!"
		_fight.play()
		await _fight.finished
		clear()
		GlobalSignals.timer3.timeout.emit()
	
func p1_wins() -> void:
	print("feedback p1wins")
	visible = true
	_text = "P1 WINS!"
	youwin.play(0.0)
	await youwin.finished
	GlobalSignals.timer5.timeout.emit()
	
	
func p2_wins() -> void:
	print("feedback p2wins")
	visible = true
	_text = "P2 WINS!"
	youwin.play(0.0)
	await youwin.finished
	GlobalSignals.timer5.timeout.emit()
	

func on_draw() -> void:
	visible = true
	_text = "DRAW"
	draw_game.play(0.0)
	await draw_game.finished
	GlobalSignals.timer5.timeout.emit()
	

extends Node

var timer = Timer.new()
var timer2 = Timer.new()
var hit_times_p1: int = -1 
var hit_times_p2: int = -1

func _ready() -> void:
	
	add_child(timer)
	add_child(timer2)
	timer.start(99)

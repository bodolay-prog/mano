extends Node

var timer = Timer.new()
var timer2 = Timer.new()
var timer3 = Timer.new()
var hit_times_p1: int = -1 
var hit_times_p2: int = -1

func test() -> void:
	print("test")

func _ready() -> void:
	connect("selected", test)
	add_child(timer)
	add_child(timer2)
	add_child(timer3)
	timer3.set_deferred("one_shot", true)
	

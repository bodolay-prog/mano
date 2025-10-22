extends Node2D

@onready
var p1: P1Character = $"../p1_player"
@onready
var p2: P2Character = $"../p2_test_player"

func p1_is_on_right_side() -> void:
	var p1_pos = p1.position
	var p2_pos = p2.position
	
	if p1_pos > p2_pos and !p1.on_right_side:
		p1.on_right_side = true
		p1.flip_char()
		
	if p1_pos < p2_pos and p1.on_right_side:
		p1.on_right_side = false
		p1.flip_char()

func p2_is_on_right_side() -> void:
	var p1_pos = p1.position
	var p2_pos = p2.position
	
	if p2_pos > p1_pos and !p2.on_right_side:
		p2.on_right_side = true
		p2.flip_char()
		
	if p2_pos < p1_pos and p2.on_right_side:
		p2.on_right_side = false
		p2.flip_char()

func _process(delta: float) -> void:
	p1_is_on_right_side()
	p2_is_on_right_side()

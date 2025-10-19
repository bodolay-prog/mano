extends Node2D

@onready
var high_hitbox = $hitbox/high_hit
@onready
var mid_hitbox = $hitbox/mid_hit
@onready
var low_hitbox = $hitbox/low_hit

@onready
var enemy_hitbox = $hitbox

signal hit_reset()

func _process(delta: float) -> void:
	if Input.is_action_pressed('test_high_hit'):
		$hitbox_manager_debuig/high_area/high_hit.disabled = false
	if Input.is_action_just_released('test_high_hit'):
		$hitbox_manager_debuig/high_area/high_hit.disabled = true
		hit_reset.emit()
		
		
	if Input.is_action_pressed('test_mid_hit'):
		$hitbox_manager_debuig/mid_area/mid_hit.disabled = false
	if Input.is_action_just_released('test_mid_hit'):
		$hitbox_manager_debuig/mid_area/mid_hit.disabled = true
		hit_reset.emit()
		
	if Input.is_action_pressed('test_low_hit'):
		$hitbox_manager_debuig/low_area/low_hit.disabled = false
	if Input.is_action_just_released('test_low_hit'):
		$hitbox_manager_debuig/low_area/low_hit.disabled = true
		hit_reset.emit()

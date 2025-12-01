class_name HealthBarConfigP1
extends ProgressBar

@onready var timer = $timer
@onready var damageBar = $damage_bar
@onready var spBar = $sp_bar

var health = 0 
var sp = 0

func _set_health(new_health) -> void:
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	
	if health < prev_health:
		timer.start()
	else:
		damageBar.value = health
		
func _set_sp(new_sp) -> void:
	spBar.value = new_sp

func init_health(_health) -> void:
	health = _health
	max_value = health
	value = health
	damageBar.max_value = health
	damageBar.value = health

func init_sp(_sp) -> void:
	sp = _sp
	spBar.max_value = 1000
	spBar.value = sp
	
	

func _on_timer_timeout() -> void:
	damageBar.value = health

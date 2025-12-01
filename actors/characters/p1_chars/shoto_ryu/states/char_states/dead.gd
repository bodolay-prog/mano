class_name dead_p1
extends P1State

var is_dead_on_floor: bool = false
signal is_on_floor()

@onready var dead: AudioStreamPlayer = $"../../sfx/dead"

func enter() -> void:
	super()
	dead.play()
	animations_player.speed_scale = 0.20
	parent.velocity.y += -350
	parent.knockback = 70
	

func process_physics(delta: float) -> P1State:
	
	parent.velocity.y += gravity * delta 
	parent.velocity.x = parent.knockback * (1 if parent.on_right_side else -1)
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		animations_player.play("air_hit")
		Hitstop.hitstop(0.05, 1)
	
	if parent.is_on_floor() and !is_dead_on_floor:
		is_dead_on_floor = true
		parent.velocity.x = 0
		parent.velocity.y = 0
		parent.knockback = 0
		parent.knockback_y = 0
		is_on_floor.emit()
		animations_player.play("knockdown")
		
		
	await is_on_floor
	await animations_player.animation_finished
	animations_player.active = false
	parent.p1_dead.emit()
	
	return 
	

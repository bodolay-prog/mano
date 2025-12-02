class_name win_p1
extends P1State

var is_on_floor: bool = false

func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.velocity.y = 0
	parent.knockback = 0
	parent.knockback_y = 0

func process_physics(delta: float) -> P1State:
	
	parent.velocity.y += gravity * delta 
	parent.velocity.x = parent.knockback * (1 if parent.on_right_side else -1)
	parent.move_and_slide()
	
	if parent.is_on_floor() and !is_on_floor:
		is_on_floor = true
		animations_player.play("win_round")

	await animations_player.animation_finished
	animations_player.active = false
	parent.p1_win.emit()
	
	return 
	

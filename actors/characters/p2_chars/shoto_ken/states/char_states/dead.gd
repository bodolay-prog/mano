class_name dead_p2
extends P2State

var is_dead_on_floor: bool = false
signal is_on_floor()

func enter() -> void:
	super()
	parent.velocity.y += -350
	parent.knockback = 70
	

func process_physics(delta: float) -> P2State:
	
	parent.velocity.y += gravity * delta 
	parent.velocity.x = parent.knockback * (1 if parent.on_right_side else -1)
	parent.move_and_slide()
	
	if !parent.is_on_floor():
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
	parent.p2_dead.emit()
	
	return 
	

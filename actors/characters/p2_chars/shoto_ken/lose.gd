class_name lose_p2
extends P2State

var is_dead_on_floor: bool = false
signal is_on_floor()

func enter() -> void:
	super()
	

func process_physics(delta: float) -> P2State:
	
	parent.velocity.y += gravity * delta 
	parent.move_and_slide()
	
	if parent.is_on_floor() and !is_dead_on_floor:
		is_dead_on_floor = true
		parent.velocity.x = 0
		parent.velocity.y = 0
		parent.knockback = 0
		parent.knockback_y = 0
		is_on_floor.emit()
		
		
	await is_on_floor
	parent.p2_lose.emit()
	
	return 
	

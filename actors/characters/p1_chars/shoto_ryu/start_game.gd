class_name start_p1
extends P1State

var is_on_floor: bool = false

func enter() -> void:
	super()
	animations_player.speed_scale = 0.30
	parent.velocity.x = 0
	parent.velocity.y = 0

func process_physics(delta: float) -> P1State:
	
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	await animations_player.animation_finished
	animations_player.play("idle")
	parent.is_ready.emit()
	
	return 
	

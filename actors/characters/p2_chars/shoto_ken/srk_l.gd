class_name srk_l
extends P2State

# Char States
@export
var on_hit_state: P2State
		
# Movement P2States
@export
var idle_state: P2State
@export 
var crouch_state: P2State

@onready
var special: special_hit = $"../../hitbox_manager/special_hit_manager"

func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.velocity.y += -250
	parent.motion = " "
	special.hit_stun_frames = 20
	special.block_stun_frames = 10
	special.knockback = 150
	special.knockback_y = -150

func process_input() -> P2State:	

	parent.velocity.x = 10 * (-1 if parent.on_right_side else 1)
	parent.move_and_slide()
	
	if parent.get_hurt_type() == "counter":
		return on_hit_state
		
	await animations_player.animation_finished
	
	if parent.is_on_floor():
		if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:
			return crouch_state
		return idle_state

	return	
	
func process_physics(delta: float) -> P2State:
	
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if parent.is_on_floor():
		return idle_state
	
	return
	

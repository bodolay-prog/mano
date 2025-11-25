class_name tmk_ex
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
	animations_player.set_deferred("Speed Scale", 0.55)
	parent.sp -= 250
	parent.velocity.x = 0
	parent.position.y += -3
	parent.motion = " "
	special.hit_stun_frames = 20
	special.block_stun_frames = 10
	special.knockback = 50
	special.knockback_y = 0
	special.ender_hit_stun_frames = 28
	special.ender_block_stun_frames = 18
	special.ender_knockback = 100
	special.ender_knockback_y = -430

func process_input() -> P2State:	

	parent.velocity.x = 450 * (-1 if parent.on_right_side else 1)
	parent.move_and_slide()
	
	if parent.get_hurt_type() == "counter":
		return on_hit_state
		
	await animations_player.animation_finished
	
	
	if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:
		return crouch_state
	return idle_state
	
	

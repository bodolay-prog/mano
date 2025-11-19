class_name state_machine_p2
extends Node

@export
var starting_state: P2State
var old_state: P2State
var current_state: P2State

# Initialize the state machine by giving each child state a reference to the
# parent object it belongs to and enter the default starting_state.
func init(parent: P2Character, animations_player: AnimationPlayer, node_hitbox_manager: hitbox_manager, node_hurtbox_manager: hurtbox_manager, input_component) -> void:
	for child in get_children():
		child.parent = parent
		child.animations_player = animations_player
		child.node_hitbox_manager = node_hitbox_manager
		child.node_hurtbox_manager = node_hurtbox_manager
		child.input_component = input_component
		
	# Initialize to the default state
	change_state(starting_state)

# Change to the new state by first calling any exit logic on the current state.
func change_state(new_state: P2State) -> void:
	if current_state or current_state == new_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()
	
# Pass through functions for the Player to call,
# handling state changes as needed.
func process_physics(delta: float) -> void:
	var new_state = await current_state.process_physics(delta)
	if new_state:
		old_state = current_state
		change_state(new_state)

func process_input() -> void:
	var new_state = await current_state.process_input()
	if new_state:
		old_state = current_state
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)

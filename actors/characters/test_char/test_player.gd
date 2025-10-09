class_name Player
extends CharacterBody2D

@onready
var j5_l_hitbox = $hitboxes/j5_L/j5_L_hitbox
@onready
var j5_m_hitbox = $hitboxes/j5_M/j5_M_hitbox
@onready
var movement_animations: AnimatedSprite2D = $move_animations
@onready
var animations_player: AnimationPlayer = $animation_player
@onready
var input_state_machine: Node = $input_state_machine
@onready
var player_input_component = $player_input_component


func _ready() -> void:
	input_state_machine.init(self, animations_player, player_input_component)

func _unhandled_input(event: InputEvent) -> void:
	input_state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	input_state_machine.process_physics(delta)

func _process(delta: float) -> void:
	if is_on_floor():
		j5_l_hitbox.disabled = true
		j5_m_hitbox.disabled = true
		
	#input_state_machine.process_frame(delta)
	#print("x:" +str(velocity.x) + " y: " + str(velocity.y) )
	#print("movement input: " + str(player_input_component.movement_inputs()))
	#print("attack input: " + str(player_input_component.attack_inputs()))
	if is_on_floor():
		print("chão")
	#print("State: " +str($input_state_machine.current_state))
	return 

extends Node

func movement_inputs() -> int:
	
	if Input.is_action_pressed('crouch'):
		if Input.is_action_pressed('jump'):
			return 5
		if Input.is_action_pressed('move_back'):
			return 1
		if Input.is_action_pressed('move_foward'):
			return 3
		return 2
		
	if Input.is_action_pressed('move_back'):
		if Input.is_action_just_pressed('dash'):
			return 44
		if Input.is_action_pressed('jump'):
			return 7
		if Input.is_action_pressed('move_foward'):
			return 5
		return 4
		
	if Input.is_action_pressed('move_foward'):
		if Input.is_action_just_pressed('dash'):
			return 66
		if Input.is_action_pressed('move_back'):
			return 5
		if Input.is_action_pressed('jump'):
			return 9
		return 6
		
	if Input.is_action_pressed('jump'):
		return 8
	return 5
	
	
func attack_inputs() -> String:
	
	if Input.is_action_just_pressed("5L"):
		return "L"
	if Input.is_action_just_pressed("5M"):
		return "M"
	if Input.is_action_just_pressed("5H"):
		return "H"

	return "N"
		
